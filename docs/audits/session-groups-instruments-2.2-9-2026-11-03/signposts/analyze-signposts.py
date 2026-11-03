#!/usr/bin/env python3
"""Analyze already exported native SessionGroups signposts. Never access a device.

Only fixed probe names/numeric payloads are emitted. Cross-table duplicate event
rows are merged, but duplicate rows within one table are retained and flagged.
"""
import argparse
import hashlib
import json
import math
import re
import statistics
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path

SUBSYSTEM = 'com.wechatimprove.performance'
CATEGORY = 'SessionGroups'
OPERATIONS = ('ModelFull', 'ModelDelta', 'ModelSelection', 'CoordinatorApply',
              'AdapterRefreshAttempt', 'AdapterPublication', 'MainTableReloadData',
              'MainTableReloadRows', 'TabRecordsUpdateAttempt', 'TabLayout')
EVENTS = ('MainTableTargetVerified', 'MainTableTargetUnavailable',
          'ReloadDispatchUnverified', 'PublicationCompleted', 'ReloadDataCompleted',
          'ReloadRowsCompleted', 'TabRecordsRebuilt', 'KnownChangeHint', 'UnknownChangeHint')
OUTCOMES = {0:'exception', 1:'completed', 2:'valid', 3:'rejected', 4:'fallback',
            5:'reused', 6:'ready', 7:'boundary', 8:'unchanged'}
MODEL_NAMES = {'ModelFull', 'ModelDelta', 'ModelSelection'}


def tag(e):
    return e.tag.rsplit('}', 1)[-1] if e is not None else ''


def child(e, name):
    return next((x for x in e if tag(x) == name), None) if e is not None else None


def integer(value):
    return int(value) if re.fullmatch(r'[0-9]+', value or '') else None


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


class Export:
    def __init__(self, path, expected_schema):
        self.path = Path(path)
        self.root = ET.parse(self.path).getroot()
        self.ids = {x.get('id'):x for x in self.root.iter() if x.get('id')}
        self.expected_schema = expected_schema
        self.issues = Counter()
        self.tables = []

    def resolve(self, e):
        seen = set()
        while e is not None and e.get('ref'):
            ref = e.get('ref')
            if ref in seen:
                self.issues['cyclic_xml_reference'] += 1
                return None
            seen.add(ref)
            e = self.ids.get(ref)
            if e is None:
                self.issues['missing_xml_reference'] += 1
        return e

    def text(self, e, formatted=False):
        e = self.resolve(e)
        if e is None or tag(e) == 'sentinel':
            return ''
        return (e.get('fmt') or (e.text or '').strip()) if formatted else (e.text or '').strip()

    def number(self, e):
        return integer(self.text(e))

    def pid(self, e):
        e = self.resolve(e)
        if e is None:
            return None
        process = e if tag(e) == 'process' else self.resolve(child(e, 'process'))
        return self.number(child(process, 'pid'))

    def tid(self, e):
        return self.number(child(self.resolve(e), 'tid'))

    def rows(self):
        # xctrace emits one schema followed by later nodes with the same schema
        # omitted. The xpath was restricted to one schema; retain that schema.
        inherited = None
        nodes = [e for e in self.root if tag(e) == 'node']
        if not nodes:
            nodes = [self.root]
        for index, node in enumerate(nodes):
            schema = self.resolve(child(node, 'schema'))
            if schema is not None:
                if schema.get('name') != self.expected_schema:
                    self.issues['unexpected_schema'] += 1
                    continue
                inherited = schema
            schema = inherited
            if schema is None:
                self.issues['table_without_resolved_schema'] += 1
                continue
            columns = [self.text(child(c, 'mnemonic')) or c.get('mnemonic')
                       for c in schema if tag(c) in ('col', 'column')]
            types = [self.text(child(c, 'engineering-type')) or c.get('engineeringType')
                     for c in schema if tag(c) in ('col', 'column')]
            table_id = node.get('xpath', str(index))
            rows = [e for e in node if tag(e) == 'row']
            self.tables.append({'xpath':table_id, 'raw_row_count':len(rows)})
            for sequence, row in enumerate(rows):
                if len(row) != len(columns):
                    self.issues['row_column_count_mismatch'] += 1
                    continue
                yield table_id, sequence, dict(zip(columns, row)), dict(zip(columns, types))

    def identity(self, cells, types, pid, name_key):
        if self.text(cells.get('subsystem')) != SUBSYSTEM or self.text(cells.get('category')) != CATEGORY:
            return None
        if self.pid(cells.get('process')) != pid:
            self.issues['own_subsystem_other_or_unknown_pid'] += 1
            return None
        time = self.number(cells.get('time'))
        time_cell = self.resolve(cells.get('time'))
        if time is None or types.get('time') != 'event-time' or tag(time_cell) != 'event-time':
            self.issues['unverified_event_nanoseconds'] += 1
            return None
        name = self.text(cells.get(name_key))
        if name not in OPERATIONS and name not in EVENTS:
            self.issues['unknown_own_probe_name'] += 1
            return None
        tid, identifier = self.tid(cells.get('thread')), self.number(cells.get('identifier'))
        if tid is None or identifier is None:
            self.issues['missing_thread_or_signpost_identifier'] += 1
            return None
        return time, tid, identifier, name


def arg_index(path, pid):
    if path is None:
        return {}, None
    source = Export(path, 'os-signpost-arg')
    result = defaultdict(dict)
    duplicates = 0
    for table, sequence, cells, types in source.rows():
        identity = source.identity(cells, types, pid, 'signpost-name')
        if identity is None:
            continue
        key = (*identity, source.text(cells.get('format-string')))
        name = source.text(cells.get('name'))
        value = source.number(cells.get('value'))
        if name not in ('arg0','arg1') or value is None:
            source.issues['unexpected_own_argument_name_or_value'] += 1
            continue
        if name in result[key]:
            if result[key][name] != value:
                source.issues['conflicting_argument_value'] += 1
            else:
                duplicates += 1
        result[key][name] = value
    return dict(result), {'path':str(path), 'sha256':digest(path), 'tables':source.tables,
                          'issues':dict(source.issues), 'duplicate_argument_rows':duplicates}


def parse_raw(path, args_path, pid):
    arguments, args_info = arg_index(args_path, pid)
    source = Export(path, 'os-signpost')
    events, signatures, duplicate_count = [], {}, 0
    for table, sequence, cells, types in source.rows():
        identity = source.identity(cells, types, pid, 'name')
        if identity is None:
            continue
        time, tid, identifier, name = identity
        kind = source.text(cells.get('event-type'))
        if kind not in ('Begin', 'End', 'Event'):
            source.issues['unknown_event_type'] += 1
            continue
        if (name in OPERATIONS) != (kind in ('Begin','End')):
            source.issues['probe_name_event_kind_mismatch'] += 1
            continue
        if source.text(cells.get('scope')) != 'Process':
            source.issues['unexpected_nonprocess_scope'] += 1
            continue
        fmt = source.text(cells.get('format-string'))
        message = source.text(cells.get('message'), formatted=True)
        payload = {}
        if kind != 'Begin':
            pattern = r'outcome=([0-9]+) units=([0-9]+)' if kind == 'End' else r'units=([0-9]+)'
            match = re.fullmatch(pattern, message)
            if match:
                payload = dict(zip(('outcome','units') if kind == 'End' else ('units',), map(int,match.groups())))
            arg_values = arguments.get((*identity,fmt), {})
            fallback = ({'outcome':arg_values.get('arg0'),'units':arg_values.get('arg1')} if kind == 'End'
                        else {'units':arg_values.get('arg0')})
            if fallback and all(value is not None for value in fallback.values()):
                if payload and payload != fallback:
                    source.issues['message_argument_payload_conflict'] += 1
                    payload = {}
                elif not payload:
                    payload = fallback
            if 'units' not in payload or (kind == 'End' and payload.get('outcome') not in OUTCOMES):
                source.issues['missing_or_invalid_numeric_payload'] += 1
        signature = (*identity,kind,fmt,message)
        old_index = signatures.get(signature)
        if old_index is not None:
            old = events[old_index]
            if table not in old['source_tables']:
                old['source_tables'].append(table)
                duplicate_count += 1
                continue
            source.issues['identical_event_within_same_table'] += 1
        signatures[signature] = len(events)
        events.append({'time_ns':time, 'thread_id':tid, 'identifier':identifier, 'name':name,
                       'kind':kind, **payload, 'source_tables':[table], 'source_sequence':sequence})
    events.sort(key=lambda e:(e['time_ns'], e['source_sequence']))
    return events, {'path':str(path), 'sha256':digest(path), 'tables':source.tables,
                    'issues':dict(source.issues), 'cross_table_duplicate_events_merged':duplicate_count,
                    'arguments':args_info}


def pair(events):
    intervals, active, incomplete, pending_targets = [], {}, [], {}
    issues = Counter()
    for event in events:
        name, kind, tid = event['name'],event['kind'],event['thread_id']
        key = (event['identifier'],name)
        if name in ('MainTableTargetVerified','MainTableTargetUnavailable'):
            pending_targets[tid] = event
        if kind == 'Begin':
            if key in active:
                incomplete.append({'reason':'begin_before_previous_end', 'event':active.pop(key)})
                issues['begin_before_previous_end'] += 1
            active[key] = event
            if name == 'AdapterPublication':
                event['target_event'] = pending_targets.pop(tid,None)
        elif kind == 'End':
            begin = active.pop(key,None)
            if begin is None:
                incomplete.append({'reason':'end_without_begin', 'event':event})
                continue
            if begin['thread_id'] != tid or event['time_ns'] < begin['time_ns']:
                issues['invalid_paired_thread_or_time'] += 1
                incomplete.extend([{'reason':'invalid_paired_thread_or_time','event':begin},
                                   {'reason':'invalid_paired_thread_or_time','event':event}])
                continue
            interval = {'name':name,'identifier':event['identifier'],'thread_id':tid,
                        'start_ns':begin['time_ns'],'end_ns':event['time_ns'],
                        'duration_ns':event['time_ns']-begin['time_ns'],
                        'outcome':event.get('outcome'),'units':event.get('units')}
            if name == 'AdapterPublication':
                target = begin.get('target_event')
                interval['target'] = ({'verified':target['name']=='MainTableTargetVerified',
                                      'mask':target.get('units'),'time_ns':target['time_ns']}
                                     if target else None)
            intervals.append(interval)
    incomplete.extend({'reason':'begin_without_end','event':e} for e in active.values())
    # Assign parents using per-thread stacks, without summing nested durations.
    intervals.sort(key=lambda x:(x['start_ns'],-x['end_ns']))
    stacks = defaultdict(list)
    for index, interval in enumerate(intervals):
        interval['index'] = index
        stack = stacks[interval['thread_id']]
        while stack and intervals[stack[-1]]['end_ns'] <= interval['start_ns']:
            stack.pop()
        if stack and intervals[stack[-1]]['end_ns'] < interval['end_ns']:
            issues['crossing_synchronous_intervals'] += 1
            while stack and intervals[stack[-1]]['end_ns'] < interval['end_ns']:
                stack.pop()
        interval['parent_index'] = stack[-1] if stack else None
        parent = interval['parent_index']
        coordinator = None
        while parent is not None:
            candidate = intervals[parent]
            if candidate['name'] == 'CoordinatorApply':
                coordinator = parent
                break
            parent = candidate['parent_index']
        interval['coordinator_index'] = coordinator
        stack.append(index)
    # Completion events must occur inside the operation that owns their scope.
    owners = {'PublicationCompleted':'AdapterPublication','ReloadDataCompleted':'MainTableReloadData',
              'ReloadRowsCompleted':'MainTableReloadRows','TabRecordsRebuilt':'TabRecordsUpdateAttempt'}
    by_thread = defaultdict(list)
    for interval in intervals:
        by_thread[interval['thread_id']].append(interval)
    for event in events:
        if event['kind'] != 'Event' or event['name'] not in owners:
            continue
        candidates = [x for x in by_thread[event['thread_id']] if x['name']==owners[event['name']]
                      and x['start_ns'] <= event['time_ns'] <= x['end_ns']]
        if candidates:
            event['owner_interval_index'] = min(candidates,key=lambda x:x['duration_ns'])['index']
        else:
            event['owner_interval_index'] = None
            issues['completion_event_without_complete_owner'] += 1
    return intervals,incomplete,dict(issues)


def duration_summary(intervals):
    values = sorted(x['duration_ns']/1e6 for x in intervals)
    outcomes = Counter(OUTCOMES.get(x['outcome'],'unknown') for x in intervals)
    return {'status':'observed' if values else 'not_observed_in_export', 'complete_interval_count':len(values),
            'outcomes':dict(outcomes), 'duration_ms':{'p50':statistics.median(values) if values else None,
            'p95_nearest_rank':values[max(0,math.ceil(len(values)*.95)-1)] if values else None,
            'max':max(values) if values else None},
            'units_sum':sum(x['units'] for x in intervals) if values and all(x['units'] is not None for x in intervals) else None}


def summarize(events, intervals, incomplete, begin_ns, end_ns):
    selected_events = [e for e in events if begin_ns <= e['time_ns'] < end_ns]
    selected = [x for x in intervals if x['start_ns'] >= begin_ns and x['end_ns'] <= end_ns]
    crossing = [x for x in intervals if x['start_ns'] < end_ns and x['end_ns'] > begin_ns and x not in selected]
    model = {}
    for name in MODEL_NAMES:
        rows = [x for x in selected if x['name']==name]
        model[name] = {'all_api_calls':duration_summary(rows),
                       'inside_coordinator':duration_summary([x for x in rows if x['coordinator_index'] is not None]),
                       'outside_coordinator':duration_summary([x for x in rows if x['coordinator_index'] is None])}
    counts = {}
    for name in EVENTS:
        values = [e for e in selected_events if e['kind']=='Event' and e['name']==name]
        counts[name] = {'status':'observed' if values else 'not_observed_in_export','count':len(values),
                        'units_distribution':dict(Counter(str(e.get('units')) for e in values)),
                        'units_sum':sum(e['units'] for e in values) if name == 'ReloadRowsCompleted' and values and all('units' in e for e in values) else None,
                        'unowned_completion_count':sum(e.get('owner_interval_index') is None for e in values)
                        if name in ('PublicationCompleted','ReloadDataCompleted','ReloadRowsCompleted','TabRecordsRebuilt') else None}
    publications = [x for x in selected if x['name']=='AdapterPublication']
    masks = Counter(str((x.get('target') or {}).get('mask')) for x in publications)
    target_unknown = sum(not x.get('target') or not x['target'].get('verified') or x['target'].get('mask') not in (0,1,2,3) for x in publications)
    reloads = {}
    for name,bit,event_name in [('MainTableReloadData',1,'ReloadDataCompleted'),('MainTableReloadRows',2,'ReloadRowsCompleted')]:
        covered = [x for x in publications if x.get('target') and x['target']['verified'] and x['target'].get('mask') in (1,2,3) and x['target']['mask']&bit]
        uncovered = len(publications)-len(covered)
        reloads[name] = {'status':('verified_publication_scope_only' if publications and not uncovered else 'partial_coverage' if covered else 'unavailable'),
                         'covered_publication_count':len(covered),'uncovered_publication_count':uncovered,
                         'reason':None if publications and not uncovered else 'No complete verified publication scope or method dispatch coverage is incomplete; absent calls are not validated zero.',
                         'observed_intervals':duration_summary([x for x in selected if x['name']==name]),
                         'normal_completion_events':counts[event_name]}
    return {'selected_unique_raw_events':len(selected_events),'selected_event_kind_counts':dict(Counter(e['kind'] for e in selected_events)),
            'operations':{name:duration_summary([x for x in selected if x['name']==name]) for name in OPERATIONS},
            'models_by_coordinator_scope':model,'events':counts,
            'publication_target_validation':{'status':'observed' if publications else 'unavailable', 'complete_publication_count':len(publications),'mask_distribution':dict(masks),
                                             'unknown_or_unavailable_target_count':target_unknown},
            'main_table_reload_coverage':reloads,'complete_intervals_crossing_analysis_boundary':len(crossing),
            'unpaired_events_in_window':dict(Counter(x['reason'] for x in incomplete if begin_ns <= x['event']['time_ns'] < end_ns))}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--xml',type=Path,required=True)
    parser.add_argument('--args-xml',type=Path)
    parser.add_argument('--pid',type=int,required=True)
    parser.add_argument('--begin',type=float,default=0)
    parser.add_argument('--end',type=float,required=True)
    parser.add_argument('--recording-status',choices=('complete','failed','unknown'),default='unknown')
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--details-output',type=Path)
    args = parser.parse_args()
    if args.pid <= 0 or not math.isfinite(args.begin) or not math.isfinite(args.end) or args.begin < 0 or args.end <= args.begin:
        parser.error('Require a positive PID and finite 0 <= begin < end seconds.')
    details_path = args.details_output or args.output.with_suffix('.details.json')
    if args.output.exists() or details_path.exists():
        parser.error('Refusing to overwrite analysis evidence.')
    events,info = parse_raw(args.xml,args.args_xml,args.pid)
    intervals,incomplete,pairing_issues = pair(events)
    summary = {'target_pid':args.pid,'subsystem':SUBSYSTEM,'category':CATEGORY,
               'recording_status_verified_externally':args.recording_status,
               'window_seconds':{'begin':args.begin,'end':args.end,'duration':args.end-args.begin},
               'input':info,'pairing_issues':pairing_issues,
               'whole_export_unique_probe_events':len(events),
               'whole_export_probe_time_seconds':{'first':events[0]['time_ns']/1e9 if events else None,
                                                  'last':events[-1]['time_ns']/1e9 if events else None},
               'whole_export_unpaired_events':dict(Counter(x['reason'] for x in incomplete)),
               'timing_semantics':'Synchronous wall time in observation build; includes probe overhead. Nested durations must not be added. Missing probes or unverified targets are not zero computation or zero refresh.',
               'summary':summarize(events,intervals,incomplete,round(args.begin*1e9),round(args.end*1e9)),
               'details_path':str(details_path)}
    details = {'input_sha256':info['sha256'],'target_pid':args.pid,'intervals':intervals,
               'events':events,'incomplete_intervals':incomplete}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    details_path.parent.mkdir(parents=True,exist_ok=True)
    details_path.write_text(json.dumps(details,ensure_ascii=False,indent=2)+'\n')
    args.output.write_text(json.dumps(summary,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'output':str(args.output),'unique_events':len(events),
                      'complete_intervals':len(intervals),'pairing_issues':pairing_issues},ensure_ascii=False))


if __name__ == '__main__':
    main()
