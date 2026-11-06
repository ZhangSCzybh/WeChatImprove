#!/usr/bin/env python3
"""Read-only measurement of the supplied 2.2-18 tab-bar leak recording.

Frame indexes are one-based decode order, using fps_mode passthrough. This
measures rendered pixels only: it cannot recover UIKit view properties.
"""
import csv
import hashlib
import json
from pathlib import Path
import subprocess
import sys

import numpy as np
from PIL import Image, ImageDraw, ImageFont

OUT = Path(__file__).resolve().parent
ROOT = OUT.parents[3]
SOURCE = ROOT / "docs/feedbacks/2026-11-06-settings-subpage-tabbar-leak.mp4"
REFS = ROOT / "docs/feedbacks/2026-11-06-settings-subpage-tabbar-leak-frames"
EXPECTED_SHA = "cb320e249770f6691940ce4ae316c368a0e3d1b3b95a0847d2a703189358c5bc"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(command):
    return subprocess.check_output(command)


def components(mask):
    """Eight-connected row-run components, no external CV library required."""
    parents, records, previous = [], [], []

    def find(index):
        while parents[index] != index:
            parents[index] = parents[parents[index]]
            index = parents[index]
        return index

    for y, line in enumerate(mask):
        changes = np.diff(np.r_[False, line, False].astype(np.int8))
        starts, stops = np.where(changes == 1)[0], np.where(changes == -1)[0] - 1
        current = []
        for start, stop in zip(starts, stops):
            index = len(parents)
            parents.append(index)
            records.append((int(start), int(stop), y))
            for pstart, pstop, pindex in previous:
                if pstop >= start - 1 and pstart <= stop + 1:
                    parents[find(index)] = find(pindex)
            current.append((start, stop, index))
        previous = current
    grouped = {}
    for index, (start, stop, y) in enumerate(records):
        key = find(index)
        if key not in grouped:
            grouped[key] = [start, y, stop, y, stop - start + 1]
        else:
            group = grouped[key]
            group[0] = min(group[0], start)
            group[1] = min(group[1], y)
            group[2] = max(group[2], stop)
            group[3] = max(group[3], y)
            group[4] += stop - start + 1
    return list(grouped.values())


before = sha(SOURCE)
assert before == EXPECTED_SHA
probe_command = ["ffprobe", "-v", "error", "-select_streams", "v:0", "-show_streams", "-show_format", "-of", "json", str(SOURCE)]
timestamp_command = ["ffprobe", "-v", "error", "-select_streams", "v:0", "-show_frames", "-show_entries", "frame=best_effort_timestamp_time,pkt_dts_time,key_frame", "-of", "json", str(SOURCE)]
decode_command = ["ffmpeg", "-v", "error", "-i", str(SOURCE), "-map", "0:v:0", "-fps_mode", "passthrough", "-f", "rawvideo", "-pix_fmt", "rgb24", "pipe:1"]
probe = json.loads(run(probe_command))
timestamps = json.loads(run(timestamp_command))
(OUT / "ffprobe-stream.json").write_text(json.dumps(probe, indent=2) + "\n")
(OUT / "ffprobe-frames.json").write_text(json.dumps(timestamps, indent=2) + "\n")
width, height = (probe["streams"][0][key] for key in ("width", "height"))
raw = run(decode_command)
assert len(raw) % (width * height * 3) == 0
frames = np.frombuffer(raw, dtype=np.uint8).reshape(-1, height, width, 3)
assert len(frames) == len(timestamps["frames"]) == 182
assert width == 592 and height == 1280
rows = []
component_rows = []
for index, frame in enumerate(frames, 1):
    roi = frame[1160:1271].astype(np.int16)
    red, green, blue = roi[:, :, 0], roi[:, :, 1], roi[:, :, 2]
    mask = (green > 120) & (green - red > 50) & (green - blue > 30)
    ys, xs = np.where(mask)
    bbox = [int(xs.min()), int(ys.min() + 1160), int(xs.max()), int(ys.max() + 1160)] if len(xs) else [None] * 4
    upper = frame[1040:1131].astype(np.int16)
    ur, ug, ub = upper[:, :, 0], upper[:, :, 1], upper[:, :, 2]
    upper_mask = (ug > 120) & (ug - ur > 50) & (ug - ub > 30)
    uys, uxs = np.where(upper_mask)
    upper_bbox = [int(uxs.min()), int(uys.min() + 1040), int(uxs.max()), int(uys.max() + 1040)] if len(uxs) else [None] * 4
    expanded = frame[600:1271].astype(np.int16)
    er, eg, eb = expanded[:, :, 0], expanded[:, :, 1], expanded[:, :, 2]
    expanded_mask = (eg > 120) & (eg - er > 50) & (eg - eb > 30)
    wide_components = [part for part in components(expanded_mask) if part[2] - part[0] >= 120 and part[3] - part[1] >= 15 and part[4] >= 100]
    for part in wide_components:
        component_rows.append({"frame_1based": index, "pts_seconds": timestamps["frames"][index - 1]["best_effort_timestamp_time"], "xmin": part[0], "ymin": part[1] + 600, "xmax": part[2], "ymax": part[3] + 600, "pixel_count": part[4]})
    widest = max(wide_components, key=lambda part: part[2] - part[0], default=None)
    if index <= 37:
        phase = "native_plugin_list"
    elif index <= 72:
        phase = "enter_plugin_root"
    elif index <= 84:
        phase = "first_subpage_push"
    elif index <= 95:
        phase = "first_subpage_stable"
    elif index <= 99:
        phase = "first_pop"
    elif index <= 119:
        phase = "plugin_root_between_pushes"
    elif index <= 129:
        phase = "second_subpage_push"
    elif index <= 143:
        phase = "second_subpage_stable"
    elif index <= 147:
        phase = "second_pop"
    else:
        phase = "plugin_root_after_pop"
    rows.append({
        "frame_1based": index,
        "pts_seconds": timestamps["frames"][index - 1]["best_effort_timestamp_time"],
        "phase_visual_classification": phase,
        "green_pixels_y1160_through1270": int(mask.sum()),
        "green_xmin": bbox[0], "green_ymin": bbox[1],
        "green_xmax": bbox[2], "green_ymax": bbox[3],
        "green_bbox_width_inclusive": bbox[2] - bbox[0] + 1 if len(xs) else None,
        "green_bbox_height_inclusive": bbox[3] - bbox[1] + 1 if len(xs) else None,
        "green_pixels_y1040_through1130": int(upper_mask.sum()),
        "upper_roi_green_xmin": upper_bbox[0], "upper_roi_green_ymin": upper_bbox[1],
        "upper_roi_green_xmax": upper_bbox[2], "upper_roi_green_ymax": upper_bbox[3],
        "wide_green_component_count_y600_through1270": len(wide_components),
        "widest_green_component_xmin": widest[0] if widest else None,
        "widest_green_component_ymin": widest[1] + 600 if widest else None,
        "widest_green_component_xmax": widest[2] if widest else None,
        "widest_green_component_ymax": widest[3] + 600 if widest else None,
        "decoded_rgb_sha256": hashlib.sha256(frame.tobytes()).hexdigest(),
    })
with (OUT / "all-frames.csv").open("w", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)
with (OUT / "wide-green-components.csv").open("w", newline="") as handle:
    writer = csv.DictWriter(handle, fieldnames=list(component_rows[0]))
    writer.writeheader()
    writer.writerows(component_rows)

windows = []
for row in rows:
    if row["green_pixels_y1160_through1270"]:
        if not windows or row["frame_1based"] != windows[-1][-1] + 1:
            windows.append([row["frame_1based"], row["frame_1based"]])
        else:
            windows[-1][-1] = row["frame_1based"]

selected = [1, 37, 60, 72, 73, 75, 79, 80, 85, 95, 96, 97, 98, 99, 100, 110, 119, 120, 122, 130, 140, 143, 144, 145, 146, 147, 148, 150, 155, 182]
matches = []
for index in selected:
    target = OUT / f"f{index:03d}.png"
    Image.fromarray(frames[index - 1]).save(target)
    reference = REFS / target.name
    if reference.exists():
        array = np.asarray(Image.open(reference).convert("RGB"))
        matches.append({"frame_1based": index, "reference": str(reference.relative_to(ROOT)), "reference_sha256": sha(reference), "rgb_exact_match": bool(np.array_equal(array, frames[index - 1]))})

font_path = Path("/System/Library/Fonts/Monaco.ttf")
font = ImageFont.truetype(str(font_path), 15) if font_path.exists() else ImageFont.load_default()
small = ImageFont.truetype(str(font_path), 12) if font_path.exists() else ImageFont.load_default()
sheet_frames = [37, 60, 72, 73, 75, 79, 85, 95, 96, 110, 119, 120, 122, 130, 143, 144, 155, 182]
sheet = Image.new("RGB", (296 * 6, 660 * 3), "white")
draw = ImageDraw.Draw(sheet)
for slot, index in enumerate(sheet_frames):
    x, y = slot % 6 * 296, slot // 6 * 660
    sheet.paste(Image.fromarray(frames[index - 1]).resize((296, 640)), (x, y + 20))
    draw.text((x + 6, y + 2), f"f{index:03d} PTS={rows[index - 1]['pts_seconds']}", fill="black", font=small)
sheet.save(OUT / "contact-sheet.png")

strip_frames = [72, 73, 75, 79, 85, 95, 96, 119, 120, 122, 130, 143, 144, 155]
strip = Image.new("RGB", (592 * 2, 150 * 7), "white")
draw = ImageDraw.Draw(strip)
for slot, index in enumerate(strip_frames):
    x, y = slot % 2 * 592, slot // 2 * 150
    strip.paste(Image.fromarray(frames[index - 1]).crop((0, 1150, 592, 1280)), (x, y + 20))
    row = rows[index - 1]
    draw.text((x + 8, y + 2), f"f{index:03d} pixels={row['green_pixels_y1160_through1270']} x={row['green_xmin']}..{row['green_xmax']}", fill="black", font=font)
strip.save(OUT / "bottom-strip.png")

trace = Image.new("RGB", (1280, 550), "white")
draw = ImageDraw.Draw(trace)
left, right, top, bottom = 75, 1245, 50, 480
maximum = max(row["green_pixels_y1160_through1270"] for row in rows)
for tick in range(0, 201, 20):
    x = left + tick / len(rows) * (right - left)
    if x <= right:
        draw.line((x, top, x, bottom), fill="#eeeeee")
        draw.text((x - 8, bottom + 10), str(tick), fill="black", font=small)
draw.line((left, top, left, bottom, right, bottom), fill="black", width=1)
points = [(left + (row["frame_1based"] - 1) / (len(rows) - 1) * (right - left), bottom - row["green_pixels_y1160_through1270"] / maximum * (bottom - top)) for row in rows]
draw.line(points, fill="#069447", width=3)
draw.text((left, 15), "Green pixel count in y=1160..1270, 1-based decoded frames", fill="black", font=font)
draw.text((8, top), str(maximum), fill="black", font=small)
for start, end in windows:
    x = left + (start - 1) / (len(rows) - 1) * (right - left)
    draw.text((x, 515), f"visible f{start:03d}..f{end:03d}", fill="#087738", font=font)
trace.save(OUT / "visibility-trace.png")

pop_frames = [95, 96, 99, 100, 143, 144, 147, 148]
pop = Image.new("RGB", (592 * 4, 450 * 2), "white")
draw = ImageDraw.Draw(pop)
for slot, index in enumerate(pop_frames):
    x, y = slot % 4 * 592, slot // 4 * 450
    pop.paste(Image.fromarray(frames[index - 1]).crop((0, 870, 592, 1280)), (x, y + 40))
    row = rows[index - 1]
    draw.text((x + 8, y + 3), f"f{index:03d} PTS={row['pts_seconds']}", fill="black", font=font)
    draw.text((x + 8, y + 21), f"fixed-bottom-ROI pixels={row['green_pixels_y1160_through1270']}", fill="black", font=small)
    draw.rectangle((x, y + 40 + 1160 - 870, x + 591, y + 40 + 1270 - 870), outline="#d03636", width=2)
pop.save(OUT / "pop-roi-counterexample.png")

summary = {
    "source_sha256": before,
    "decoded_frame_count": len(frames),
    "size": [width, height],
    "duration_seconds": probe["format"]["duration"],
    "visible_green_windows_inclusive": windows,
    "visually_observed_capsule_windows_inclusive": [[73, 99], [120, 147]],
    "visual_window_limit": "Manual inspection of decoded frames and exact matching supplied keyframes. Capsule survives f096/f144 above the fixed bottom ROI, follows outgoing child rightward, and is no longer visible at f100/f148. Not a UIKit hidden/alpha measurement.",
    "all_supplied_numbered_keyframes_match": all(item["rgb_exact_match"] for item in matches),
    "keyframe_matches": matches,
    "selected_samples": [rows[index - 1] for index in selected],
    "limitation": "Rendered pixel evidence from existing recording only; no MMTabBar hidden/alpha/superview/frame/window or VC state can be recovered. No fixed-build device verification.",
}
(OUT / "summary.json").write_text(json.dumps(summary, indent=2, ensure_ascii=False) + "\n")
(OUT / "README.md").write_text("""# 2.2-18 supplied recording: tab-bar leak pixel analysis

This is read-only analysis of the existing supplied 2.2-18 recording. It is not a recording of the fixed build, not a device runtime log, and not proof of any UIKit object property.

## Source and indexing

- SHA256: `cb320e249770f6691940ce4ae316c368a0e3d1b3b95a0847d2a703189358c5bc` (matches supplied value; unchanged during analysis).
- HEVC, 592×1280, 182 decoded frames, duration 6.133333 s. Nominal `r_frame_rate=30/1`; actual `avg_frame_rate=1365/46`.
- `f001` is the first decoded frame. Decode uses `-fps_mode passthrough`, no frame synthesis/duplication. PTS is recorded separately in `all-frames.csv` and `ffprobe-frames.json`; no `frame_number/30` substitution.
- All 11 supplied numbered keyframes match the RGB arrays of the corresponding independently decoded frames exactly. PNG byte hashes may differ because encoders differ. The 960×240 zoom is a derived crop, not a full-frame reference, and is not counted among those 11.

## Reproducing the supplied detector

For every decoded RGB24 frame, retain pixels at inclusive `y=1160..1270` satisfying `g>120 && g-r>50 && g-b>30`. Differences use signed int16 to avoid uint8 wraparound. Record count and inclusive bbox. `all-frames.csv` preserves every sample, including zeroes and noise.

The main nonzero windows reproduce **f073–f095** and **f120–f143**. There is also a **two-pixel** match at f150 (`x=132,y=1254..1255`), which is not a rendered capsule. This raw noise has not been removed from the samples.

| Frame | PTS (s) | Fixed-ROI green pixels | Fixed-ROI bbox (inclusive) | Observation |
|---|---:|---:|---|---|
| f072 | 2.366667 | 0 | — | Main plugin settings root |
| f073 | 2.400000 | 293 | x546..591,y1176..1251 | Capsule first enters at right edge |
| f075 | 2.466667 | 1684 | x272..591,y1175..1251 | Slides left with pushed child |
| f079 | 2.600000 | 3198 | x108..525,y1174..1251 | Near final horizontal position |
| f080 | 2.633333 | 3210 | x100..515,y1174..1251 | Still moving slightly |
| f085 | 2.800000 | 3712 | x88..507,y1174..1251 | Stable first child; obscures content |
| f095 | 3.133333 | 2338 | x90..505,y1182..1257 | Capsule before first pop |
| f096 | 3.166667 | 0 | — | Capsule remains visible **above** fixed ROI |
| f110 | 3.633333 | 0 | — | Root; capsule absent |
| f120 | 3.966667 | 364 | x518..591,y1175..1251 | Second push begins |
| f122 | 4.033333 | 2024 | x258..591,y1175..1251 | Capsule slides with second child |
| f130 | 4.300000 | 3927 | x90..507,y1174..1251 | Second child stable |
| f143 | 4.733333 | 2452 | x88..505,y1182..1257 | Capsule before second pop |
| f144 | 4.766667 | 0 | — | Capsule remains visible **above** fixed ROI |
| f155 | 5.133333 | 0 | — | Root; capsule absent |

`x88..507` is an inclusive 420-pixel extent (coordinate difference 419); `y1174..1251` is an inclusive 78-pixel extent. At the supplied illustrative 393/592 scale these are about 278.8pt×51.8pt; this does not establish the device's UIKit point scale. First detected onset f073 to stable f085 spans 12 frame intervals/0.4s.

## Important limit of the fixed ROI: pop does not prove immediate hiding

The supplied text interprets `f095→f096` and `f143→f144` as a single-frame disappearance. Independent visual inspection of those **exact matching keyframes** shows the capsule is still visible. At f096/f144 it has moved upward to approximately **y1048..1123**, outside `1160..1270`; it then follows the outgoing child toward the right edge. It remains visible through f099/f147; it is no longer visible at f100/f148. These are rendered-pixel observations, not hidden/alpha logs.

`pop-roi-counterexample.png` places those frames side by side and outlines the original detector ROI in red. `wide-green-components.csv` adds an independent expanded `y=600..1270` component analysis; `all-frames.csv` also retains an explicit `y=1040..1130` green bbox/count. Expanded connected components are a geometric aid, can fragment on antialiasing, and are not an object-identity classifier (notably they miss f096 despite the capsule being plainly visible).

Therefore the original ROI is useful for detecting the leak during push, but **ROI zero is not evidence that UIKit changed `hidden` or `alpha`**. Do not use it to infer the visibility writer or pop timing. The rendered four-tab capsule, unread `3`, selected green “Me”, and matching plugin border are visible; class identity `MMTabBar`, parentage, view-frame/window coordinates, and whether a snapshot participates cannot be proven from pixels alone.

## Scope and unverified device evidence

Observed old-recording paths: native plugin list → plugin root → Avatar Settings → root → Navigation Avatar Settings → root → system Control Center. Root and native plugin-list frames have no capsule; both pushed children show it. The recording does **not** include exiting back to the WeChat main screen, all four tabs, style-disabled behavior, other requested children, or any fixed-build run.

No available real device or simulator runtime was used. MMTabBar `hidden`, `alpha`, `superview`, object `frame`, `window`, current VC `hidesBottomBarWhenPushed`, modal/child status, transition coordinator callbacks and actual hit-testing are **未验证**. Those require runtime instrumentation and cannot be honestly fabricated from this recording. Host-model phase logs, if provided elsewhere, must remain explicitly labeled as models.

## Artifacts and reproducibility

- `analyze.py`: all commands, detector and derived figures; run with the absolute Python path in `provenance.json`.
- `ffprobe-stream.json`, `ffprobe-frames.json`: source metadata and all PTS samples.
- `all-frames.csv`: 182 full samples, frame RGB hashes, original/expanded ROI measurements.
- `wide-green-components.csv`: expanded geometric components, without silently changing the original detector.
- `contact-sheet.png`, `bottom-strip.png`, `visibility-trace.png`, `pop-roi-counterexample.png`: visual checks.
- `summary.json`, `provenance.json`, `run.log`: matches, source before/after hash, exact commands, dependency versions and output hashes.
""", encoding="utf-8")
after = sha(SOURCE)
provenance = {
    "source": str(SOURCE.relative_to(ROOT)),
    "source_size": SOURCE.stat().st_size,
    "source_sha256_before": before,
    "source_sha256_after": after,
    "source_unchanged": before == after,
    "python": sys.executable,
    "python_version": sys.version,
    "numpy_version": np.__version__,
    "ffmpeg_version": run(["ffmpeg", "-version"]).decode().splitlines()[0],
    "ffprobe_command": probe_command,
    "timestamp_command": timestamp_command,
    "decode_command": decode_command,
    "decoded_frame_count": len(frames),
    "decoded_rgb_sequence_sha256": hashlib.sha256(raw).hexdigest(),
    "frame_numbering": "1-based output sequence, fps_mode=passthrough; no CFR duplication or synthesis",
    "detector": "inclusive y=1160..1270; g>120 AND int16(g)-int16(r)>50 AND int16(g)-int16(b)>30; visible iff at least one matching pixel; bbox inclusive",
    "expanded_component_detector": "Same green predicate in inclusive y=600..1270; 8-connected components filtered to width>=121, height>=16, pixels>=100. Reports rendered wide-green shapes, not UIKit object identity. Used because fixed bottom ROI misses upward motion during pop.",
    "script_sha256": sha(Path(__file__)),
    "outputs": {str(path.relative_to(OUT)): sha(path) for path in sorted(OUT.iterdir()) if path.is_file() and path.name not in {"provenance.json", "run.log"}},
}
(OUT / "provenance.json").write_text(json.dumps(provenance, indent=2, ensure_ascii=False) + "\n")
print(json.dumps({key: summary[key] for key in ("source_sha256", "decoded_frame_count", "size", "duration_seconds", "visible_green_windows_inclusive", "all_supplied_numbered_keyframes_match")}, indent=2))
