#!/usr/bin/env python3
"""Read-only, independent CPU/frame/thermal audit of xctrace XML.

No xctrace/device calls. Time and counter arithmetic uses integer nanoseconds;
CPU percentages use Decimal. A readable export never proves capture integrity.
"""
import argparse
from collections import Counter
from decimal import Decimal, InvalidOperation
import hashlib
import json
from pathlib import Path
import re
import xml.etree.ElementTree as ET

NS = Decimal(10**9)


def local(node):
    return node.tag.rsplit('}', 1)[-1]


def child(node, name):
    return next((e for e in node if local(e) == name), None) if node is not None else None


def text(node):
    return (node.text or '').strip() if node is not None else ''


class Table:
    def __init__(self, path):
        self.path = str(path)
        self.root = ET.parse(path).getroot()
        self.ids = {e.get('id'): e for e in self.root.iter() if e.get('id')}
        self.errors = Counter()

    def resolve(self, node):
        seen = set()
        while node is not None and node.get('ref'):
            ref = node.get('ref')
            if ref in seen:
                raise ValueError('Cyclic XML reference ' + ref)
            seen.add(ref)
            if ref not in self.ids:
                raise ValueError('Unresolved XML reference ' + ref)
            node = self.ids[ref]
        return node

    def number(self, node):
        node = self.resolve(node)
        if node is None or local(node) == 'sentinel':
            return None
        try:
            n = Decimal(text(node).replace(',', ''))
            return n if n.is_finite() else None
        except InvalidOperation:
            return None

    def integer(self, node):
        n = self.number(node)
        return int(n) if n is not None and n == int(n) else None

    def ns(self, node):
        node = self.resolve(node)
        if node is None or local(node) not in {'start-time', 'event-time', 'sample-time', 'duration', 'duration-on-core'}:
            return None
        return self.integer(node)

    def pid(self, row):
        node = self.resolve(row.get('pid'))
        if node is not None:
            value = self.integer(node)
            if value is not None:
                return value
        node = self.resolve(row.get('process'))
        if node is not None:
            value = self.integer(child(node, 'pid'))
            if value is not None:
                return value
        node = self.resolve(row.get('thread'))
        if node is not None:
            process = self.resolve(child(node, 'process'))
            return self.integer(child(process, 'pid'))
        return None

    def percent(self, node):
        node = self.resolve(node)
        if node is None:
            return None
        match = re.fullmatch(r'\s*([\d.,]+)\s*%\s*', node.get('fmt', ''))
        raw = self.number(node)
        if not match or raw is None or raw < 0:
            return None
        shown = Decimal(match.group(1).replace(',', ''))
        tolerance = Decimal(5).scaleb(shown.as_tuple().exponent - 1)
        scales = [s for s in (Decimal(1), Decimal(100)) if abs(raw * s - shown) <= tolerance]
        if len(scales) == 1:
            return raw * scales[0]
        # A displayed 0.0% does not prove fractional raw precision.
        return shown if scales else None

    def rows(self, schema_name):
        for parent in self.root.iter():
            schema = child(parent, 'schema')
            if schema is None or schema.get('name') != schema_name:
                continue
            columns = [text(child(c, 'mnemonic')) for c in schema if local(c) in ('col', 'column')]
            for row in parent:
                if local(row) != 'row':
                    continue
                if len(row) != len(columns):
                    self.errors['row_column_count_mismatch'] += 1
                    continue
                yield dict(zip(columns, row))

    def narrative(self, node, seen=None):
        node = self.resolve(node)
        seen = set() if seen is None else seen
        if node is None or id(node) in seen:
            return ''
        seen.add(id(node))
        return ' '.join([text(node), node.get('fmt', ''), *(self.narrative(c, seen) for c in node)])


def seconds(ns):
    return float(Decimal(ns) / NS)


def overlap(left, right, begin, end):
    return max(0, min(right, end) - max(left, begin))


def coverage(ranges, begin, end):
    merged = []
    for left, right in sorted(ranges):
        left, right = max(begin, left), min(end, right)
        if right <= left:
            continue
        if merged and left <= merged[-1][1]:
            merged[-1][1] = max(right, merged[-1][1])
        else:
            merged.append([left, right])
    total = sum(r - l for l, r in merged)
    gaps, cursor = [], begin
    for left, right in merged:
        if cursor < left:
            gaps.append([seconds(cursor), seconds(left)])
        cursor = right
    if cursor < end:
        gaps.append([seconds(cursor), seconds(end)])
    return {'nanoseconds': total, 'seconds': seconds(total), 'fraction': total / (end - begin), 'gaps_seconds': gaps}


def percentile(values, q):
    values = sorted(values)
    if not values:
        return None
    return values[max(0, (len(values) * q + 99) // 100 - 1)]


def cpu_report(table, raw, pid, begin, end):
    entries, rejected, other = [], Counter(), Counter()
    for row in table.rows('activity-monitor-process-live'):
        rp = table.pid(row)
        if rp != pid:
            other[str(rp)] += 1
            continue
        t, d = table.ns(row.get('start')), table.ns(row.get('duration'))
        pct = table.percent(row.get('cpu-percent'))
        if t is None or d is None or d <= 0 or pct is None:
            rejected['missing_time_or_verified_percent'] += 1
            continue
        w = overlap(t, t + d, begin, end)
        if w:
            entries.append((t, d, pct, w))
    if not entries:
        return {'status': 'unavailable', 'rejected': rejected, 'other_pid_rows': other}
    weighted_ns = sum(x[3] for x in entries)
    cov = coverage([(t, t + d) for t, d, _, _ in entries], begin, end)
    weighted_sum = sum(p * w for _, _, p, w in entries)
    p95, cumulative = None, 0
    for _, _, p, w in sorted(entries, key=lambda x: x[2]):
        cumulative += w
        if cumulative * 100 >= weighted_ns * 95:
            p95 = p
            break
    counters, resets = [], 0
    if raw is not None:
        for row in raw.rows('sysmon-process'):
            if raw.pid(row) != pid:
                continue
            t = raw.ns(row.get('time'))
            u, s = raw.ns(row.get('cpu-total-user')), raw.ns(row.get('cpu-total-system'))
            if None not in (t, u, s) and begin <= t <= end:
                counters.append((t, u + s))
        counters = sorted(set(counters))
        resets = sum(b[1] < a[1] for a, b in zip(counters, counters[1:]))
    result = {'status': 'available', 'rows': len(entries), 'mean_percent': float(weighted_sum / weighted_ns),
              'p95_percent': float(p95), 'peak_percent': float(max(x[2] for x in entries)),
              'coverage': cov, 'overlap_ns': weighted_ns - cov['nanoseconds'],
              'rejected_rows': rejected, 'other_pid_rows': other,
              'percent_unit': '100 percent = one fully occupied core; whole process'}
    if len(counters) >= 2 and not resets:
        dt = counters[-1][0] - counters[0][0]
        dc = counters[-1][1] - counters[0][1]
        same_span_ns = sum(overlap(t, t + d, counters[0][0], counters[-1][0]) for t, d, _, _ in entries)
        same_span_cpu = sum(p * overlap(t, t + d, counters[0][0], counters[-1][0]) for t, d, p, _ in entries)
        same_span_mean = same_span_cpu / same_span_ns if same_span_ns else None
        result['raw_counter_crosscheck'] = {'first_sample_seconds': seconds(counters[0][0]),
            'last_sample_seconds': seconds(counters[-1][0]), 'wall_seconds': seconds(dt),
            'cpu_seconds_delta': seconds(dc), 'mean_percent': float(Decimal(dc) / dt * 100),
            'live_mean_same_counter_span_percent': float(same_span_mean) if same_span_mean is not None else None,
            'live_minus_counter_percentage_points': float(same_span_mean - Decimal(dc) / dt * 100) if same_span_mean is not None else None,
            'sample_count': len(counters), 'reset_count': resets}
    else:
        result['raw_counter_crosscheck'] = {'status': 'unavailable', 'sample_count': len(counters), 'reset_count': resets}
    return result


def frame_report(table, pid, begin, end, target_scoped):
    entries, rejected = {}, Counter()
    sentinel_ontime, checks, mismatches = 0, 0, []
    for row in table.rows('coreanimation-lifetime-interval'):
        rp = table.pid(row)
        if rp is not None and rp != pid:
            continue
        t, d = table.ns(row.get('start')), table.ns(row.get('duration'))
        if t is None or d is None or d < 0:
            rejected['invalid_lifetime_time'] += 1
            continue
        if t + d <= begin or t >= end:
            continue
        h = table.ns(row.get('hitch-duration'))
        if h is None:
            node = table.resolve(row.get('hitch-duration'))
            if node is not None and local(node) == 'sentinel' and ': on-time' in table.narrative(row.get('narrative')).lower():
                h = 0
                sentinel_ontime += 1
            else:
                rejected['unknown_hitch_duration'] += 1
                continue
        if h < 0 or h > d:
            rejected['invalid_hitch_duration'] += 1
            continue
        latency = table.ns(row.get('acceptable-latency'))
        if h and latency is not None:
            checks += 1
            if abs((d - latency) - h) > 1:
                mismatches.append({'start_seconds': seconds(t), 'hitch_ns': h, 'duration_minus_latency_ns': d - latency})
        identity = tuple(table.integer(row.get(k)) for k in ('display-id', 'lifetime-id', 'swap-id', 'frame-seed'))
        key = (t, identity)
        clipped = overlap(t + d - h, t + d, begin, end) if h else 0
        if key in entries and entries[key] != clipped:
            rejected['conflicting_duplicate_identity'] += 1
        entries[key] = max(entries.get(key, 0), clipped)
    positive = [h for h in entries.values() if h > 0]
    return {'status': 'available' if entries else 'unavailable',
            'scope': 'target attached PID and SINGLE table independently verified' if target_scoped else 'device/display; target process unverified',
            'classified_lifetimes': len(entries), 'positive_hitch_count': len(positive),
            'hitch_record_fraction': len(positive) / len(entries) if entries else None,
            'summed_hitch_ms': sum(positive) / 10**6,
            'positive_p95_ms': percentile(positive, 95) / 10**6 if positive else None,
            'max_hitch_ms': max(positive) / 10**6 if positive else 0,
            'explicit_ontime_sentinels': sentinel_ontime,
            'hitch_latency_equation_checks': checks, 'hitch_latency_equation_mismatches': mismatches,
            'rejected_rows': rejected, 'interpretation': 'Classified lifetimes are not FPS; positive hitch records are not exact dropped display refreshes.'}


def thermal_report(table, begin, end):
    states, ranges, intervals, rejected = Counter(), [], [], Counter()
    for row in table.rows('device-thermal-state-intervals'):
        t, d = table.ns(row.get('start')), table.ns(row.get('duration'))
        declared_end = table.ns(row.get('end'))
        state = text(table.resolve(row.get('thermal-state')))
        if None in (t, d) or d < 0 or not state or (declared_end is not None and declared_end != t + d):
            rejected['unknown_or_inconsistent_thermal_interval'] += 1
            continue
        w = overlap(t, t + d, begin, end)
        if not w:
            continue
        states[state] += w
        ranges.append((t, t + d))
        intervals.append({'start_seconds': seconds(t), 'end_seconds': seconds(t + d), 'state': state,
                          'induced': table.integer(row.get('is-induced')), 'overlap_seconds': seconds(w)})
    cov = coverage(ranges, begin, end)
    return {'status': 'available' if intervals else 'unavailable', 'coverage': cov,
            'overlap_nanoseconds': sum(states.values()) - cov['nanoseconds'],
            'state_seconds': {k: seconds(v) for k, v in states.items()},
            'state_fraction_of_window': {k: v / (end - begin) for k, v in states.items()},
            'intervals': intervals, 'rejected_rows': rejected,
            'interpretation': 'Device thermal state does not prove CPU throttling or identify a causal process.'}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    for name in ('toc', 'cpu', 'sysmon', 'lifetime', 'commits', 'thermal'):
        p.add_argument('--' + name, type=Path, required=name in ('toc', 'cpu'))
    p.add_argument('--pid', type=int, required=True)
    p.add_argument('--begin', type=Decimal, required=True)
    p.add_argument('--end', type=Decimal, required=True)
    p.add_argument('--output', type=Path)
    a = p.parse_args()
    begin, end = int(a.begin * NS), int(a.end * NS)
    if not 0 <= begin < end or a.pid <= 0:
        p.error('Require positive PID and valid finite window')
    toc = ET.parse(a.toc).getroot()
    processes = [dict(e.attrib) for e in toc.iter() if local(e) == 'process']
    attached = any(e.get('type') == 'attached' and e.get('pid') == str(a.pid) for e in toc.iter() if local(e) == 'process')
    scopes = [e.get('target-pid') for e in toc.iter() if local(e) == 'table' and e.get('schema') == 'coreanimation-lifetime-interval']
    target_scoped = attached and scopes == ['SINGLE']
    tables = {n: Table(getattr(a, n)) if getattr(a, n) else None for n in ('cpu', 'sysmon', 'lifetime', 'commits', 'thermal')}
    result = {'pid': a.pid, 'window_seconds': [float(a.begin), float(a.end)],
              'capture_integrity': 'Not inferred. Verify recorder exit, action labels, PID/bundle mapping, and loss separately.',
              'toc_processes': processes, 'attached_target_pid_matches': attached, 'frame_table_scopes': scopes,
              'cpu': cpu_report(tables['cpu'], tables['sysmon'], a.pid, begin, end),
              'frames': frame_report(tables['lifetime'], a.pid, begin, end, target_scoped) if tables['lifetime'] else {'status': 'unavailable'},
              'thermal': thermal_report(tables['thermal'], begin, end) if tables['thermal'] else {'status': 'unavailable'}}
    if tables['commits']:
        commits, unknown = set(), 0
        table = tables['commits']
        for row in table.rows('coreanimation-commit-interval'):
            if table.pid(row) is None:
                unknown += 1
            if table.pid(row) != a.pid:
                continue
            t = table.ns(row.get('start'))
            if t is not None and begin <= t < end:
                commits.add((t, table.ns(row.get('duration')), table.integer(row.get('transaction'))))
        result['commits'] = {'attributed_count': len(commits), 'per_second': len(commits) * 10**9 / (end - begin),
                             'unknown_pid_rows': unknown, 'interpretation': 'CA commits are not group refresh calls.'}
    sources = [a.toc, *(getattr(a, n) for n in tables if getattr(a, n))]
    result['sources'] = [{'path': str(f), 'sha256': hashlib.sha256(f.read_bytes()).hexdigest()} for f in sources]
    result['table_errors'] = {n: t.errors for n, t in tables.items() if t and t.errors}
    encoded = json.dumps(result, ensure_ascii=False, indent=2) + '\n'
    if a.output:
        if a.output.exists():
            p.error('Refusing to overwrite existing result')
        a.output.write_text(encoded)
    else:
        print(encoded, end='')


if __name__ == '__main__':
    main()
