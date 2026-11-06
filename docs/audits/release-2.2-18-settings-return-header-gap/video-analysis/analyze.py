#!/usr/bin/env python3
"""Decode the supplied recording without frame duplication and measure visible geometry.

Run with the bundled Python listed in provenance.json (NumPy + Pillow).
Input assets are read only; all outputs stay beside this script.
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
SOURCE = ROOT / "docs/feedbacks/2026-11-06-settings-return-header-gap-jump.mp4"
REFS = ROOT / "docs/feedbacks/2026-11-06-settings-return-header-gap-frames"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def run(command):
    return subprocess.check_output(command)


source_sha_before = sha(SOURCE)
probe_command = ["ffprobe", "-v", "error", "-select_streams", "v:0", "-show_streams", "-show_format", "-of", "json", str(SOURCE)]
frame_command = ["ffprobe", "-v", "error", "-select_streams", "v:0", "-show_frames", "-show_entries", "frame=best_effort_timestamp_time,pkt_dts_time,key_frame", "-of", "json", str(SOURCE)]
decode_command = ["ffmpeg", "-v", "error", "-i", str(SOURCE), "-map", "0:v:0", "-fps_mode", "passthrough", "-f", "rawvideo", "-pix_fmt", "rgb24", "pipe:1"]
probe = json.loads(run(probe_command))
timestamps = json.loads(run(frame_command))
(OUT / "ffprobe-stream.json").write_text(json.dumps(probe, indent=2) + "\n")
(OUT / "ffprobe-frames.json").write_text(json.dumps(timestamps, indent=2) + "\n")
stream = probe["streams"][0]
width, height = stream["width"], stream["height"]
raw = run(decode_command)
assert len(raw) % (width * height * 3) == 0
frames = np.frombuffer(raw, dtype=np.uint8).reshape(-1, height, width, 3)
assert len(frames) == len(timestamps["frames"])
base = frames[10].astype(float)
gray_weights = np.array([0.299, 0.587, 0.114])


def first_white_run(profile, start, stop):
    """An 8-row run >=250 suppresses isolated text/separator bright pixels."""
    return next((y for y in range(start, stop) if np.all(profile[y:y + 8] >= 250)), None)


def ink_box(gray, x0, x1, y0, y1, threshold):
    ys, xs = np.where(gray[y0:y1, x0:x1] < threshold)
    if not len(ys):
        return [None] * 4
    return [int(xs.min() + x0), int(ys.min() + y0), int(xs.max() + x0), int(ys.max() + y0)]


def best_vertical_shift(frame, roi, limit):
    y0, y1, x0, x1 = roi
    template = base[y0:y1, x0:x1]
    scores = [float(np.abs(frame[y0 + shift:y1 + shift, x0:x1].astype(float) - template).mean()) for shift in range(-limit, limit + 1)]
    best = int(np.argmin(scores))
    return best - limit, scores[best]


rows = []
profiles = []
for index, frame in enumerate(frames, 1):
    gray = frame.astype(float) @ gray_weights
    profile = gray[:, 120:471].mean(axis=1)
    main_visible = index <= 21 or 47 <= index <= 94
    if index <= 21:
        phase = "main_before_push"
    elif index <= 35:
        phase = "push_transition"
    elif index <= 42:
        phase = "avatar_subpage"
    elif index <= 54:
        phase = "pop_transition"
    elif index <= 57:
        phase = "main_return_compressed"
    elif index <= 94:
        phase = "main_restored"
    else:
        phase = "system_control_center"
    wx = ink_box(gray, 180, 415, 310, 345, 200) if main_visible else [None] * 4
    title = ink_box(gray, 50, 160, 345, 411, 170) if main_visible else [None] * 4
    shift, error = best_vertical_shift(frame, (370, 1150, 120, 471), 40)
    wx_shift, wx_error = best_vertical_shift(frame, (310, 345, 180, 415), 50)
    row = {
        "frame_1based": index,
        "pts_seconds": timestamps["frames"][index - 1]["best_effort_timestamp_time"],
        "phase_visual_classification": phase,
        "main_visible": main_visible,
        "decoded_rgb_sha256": hashlib.sha256(frame.tobytes()).hexdigest(),
        "first_white_run_y_340_550_candidate": first_white_run(profile, 340, 551),
        "main_account_card_top_y": first_white_run(profile, 340, 551) if main_visible else None,
        "subpage_first_card_top_y": first_white_run(profile, 150, 350) if 25 <= index <= 43 else None,
        "wechat_text_xmin": wx[0], "wechat_text_ymin": wx[1], "wechat_text_xmax": wx[2], "wechat_text_ymax": wx[3],
        "account_title_xmin": title[0], "account_title_ymin": title[1], "account_title_xmax": title[2], "account_title_ymax": title[3],
        "account_title_top_minus_wechat_ink_bottom": title[1] - wx[3] if title[1] is not None and wx[3] is not None else None,
        "list_roi_best_dy": shift,
        "list_roi_rgb_mae_at_best_dy": round(error, 6),
        "wechat_roi_best_dy": wx_shift,
        "wechat_roi_rgb_mae_at_best_dy": round(wx_error, 6),
    }
    rows.append(row)
    for y in range(260, 561):
        profiles.append({"frame_1based": index, "y": y, "gray_mean_x120_to470_inclusive": round(float(profile[y]), 6)})

for filename, data in [("all-frames.csv", rows), ("gray-row-profiles.csv", profiles)]:
    with (OUT / filename).open("w", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(data[0]))
        writer.writeheader()
        writer.writerows(data)

selected = [11, 21, 40, 47, 55, 57, 58, 62, 70]
ref_matches = []
for index in selected:
    output = OUT / f"f{index:03d}.png"
    Image.fromarray(frames[index - 1]).save(output)
    reference = REFS / output.name
    if reference.exists():
        array = np.asarray(Image.open(reference).convert("RGB"))
        ref_matches.append({"frame_1based": index, "reference": str(reference.relative_to(ROOT)), "reference_sha256": sha(reference), "rgb_exact_match": bool(np.array_equal(array, frames[index - 1]))})

font_path = "/System/Library/Fonts/Monaco.ttf"
font = ImageFont.truetype(font_path, 15) if Path(font_path).exists() else ImageFont.load_default()
small = ImageFont.truetype(font_path, 13) if Path(font_path).exists() else ImageFont.load_default()
comparison = Image.new("RGB", (592 * 3, 660), "white")
draw = ImageDraw.Draw(comparison)
for column, index in enumerate([11, 55, 70]):
    x = column * 592
    comparison.paste(Image.fromarray(frames[index - 1]).crop((0, 130, 592, 740)), (x, 45))
    row = rows[index - 1]
    draw.text((x + 12, 8), f"f{index:03d} PTS={row['pts_seconds']} card={row['main_account_card_top_y']}", fill="black", font=font)
    for y, color, label in [(336, "#008b70", "WeChat ink bottom y336"), (row["account_title_ymin"], "#6e45c8", f"section title y{row['account_title_ymin']}"), (row["main_account_card_top_y"], "#d83232", f"card top y{row['main_account_card_top_y']}")]:
        mapped = y - 130 + 45
        draw.line((x + 15, mapped, x + 576, mapped), fill=color, width=1)
        draw.text((x + 210, mapped - 18), label, fill=color, font=small, stroke_width=1, stroke_fill="white")
comparison.save(OUT / "comparison-annotated.png")

sheet_frames = [1, 11, 21, 25, 30, 35, 40, 43, 45, 47, 50, 55, 57, 58, 60, 62, 70, 85, 90, 95, 100, 105, 110, 114]
sheet = Image.new("RGB", (296 * 6, 640 * 4), "white")
draw = ImageDraw.Draw(sheet)
for slot, index in enumerate(sheet_frames):
    x, y = slot % 6 * 296, slot // 6 * 640
    sheet.paste(Image.fromarray(frames[index - 1]).resize((296, 640)), (x, y))
    draw.text((x + 5, y + 70), f"f{index:03d}", fill="red", stroke_width=1, stroke_fill="white", font=small)
sheet.save(OUT / "contact-sheet.png")

# An image plot keeps the original pixel values visible without interactive tooling.
plot = Image.new("RGB", (1250, 500), "white")
draw = ImageDraw.Draw(plot)
left, right, top, bottom = 80, 1210, 55, 430
xpos = lambda n: left + (n - 1) / 93 * (right - left)
ypos = lambda y: bottom - (y - 300) / 130 * (bottom - top)
for y in [318, 336, 362, 386, 390, 413]:
    yy = ypos(y)
    draw.line((left, yy, right, yy), fill="#dddddd", width=1)
    draw.text((12, yy - 8), str(y), fill="black", font=small)
for index in [1, 11, 21, 30, 40, 47, 55, 58, 70, 94]:
    xx = xpos(index)
    draw.line((xx, top, xx, bottom), fill="#eeeeee", width=1)
    draw.text((xx - 18, bottom + 8), f"{index}", fill="black", font=small)
for key, color in [("main_account_card_top_y", "#d83232"), ("account_title_ymin", "#6e45c8"), ("wechat_text_ymax", "#008b70")]:
    previous = None
    for row in rows[:94]:
        value = row[key]
        if value is None:
            previous = None
            continue
        point = (xpos(row["frame_1based"]), ypos(value))
        if previous is not None:
            draw.line((*previous, *point), fill=color, width=3)
        draw.ellipse((point[0] - 2, point[1] - 2, point[0] + 2, point[1] + 2), fill=color)
        previous = point
draw.text((left, 12), "Decoded pixel positions; X = 1-based decoded frame; Y = source pixel coordinate", fill="black", font=font)
draw.text((left, 470), "red: card top   purple: section title ink top   green: WeChat text ink bottom", fill="black", font=font)
plot.save(OUT / "geometry-trace.png")

provenance = {
    "source": str(SOURCE.relative_to(ROOT)), "source_size": SOURCE.stat().st_size, "source_sha256": sha(SOURCE),
    "source_sha256_before": source_sha_before, "source_unchanged_during_analysis": source_sha_before == sha(SOURCE),
    "python": sys.executable, "python_version": sys.version, "numpy_version": np.__version__,
    "ffmpeg_version": run(["ffmpeg", "-version"]).decode().splitlines()[0],
    "ffprobe_command": probe_command, "frame_timestamp_command": frame_command, "decode_command": decode_command,
    "decoded_frame_count": len(frames), "decoded_width": width, "decoded_height": height,
    "decoded_rgb_sequence_sha256": hashlib.sha256(raw).hexdigest(),
    "frame_numbering": "1-based output sequence with fps_mode=passthrough; no synthesized or duplicated CFR frames",
    "grayscale": "0.299 R + 0.587 G + 0.114 B applied to ffmpeg-decoded RGB24",
    "card_detector": "x=120..470 inclusive; first y=340..550 followed by 8 rows whose means are all >=250",
    "wechat_ink": "gray<200 in x=[180,415), y=[310,345); bbox applies only to visually identified main-page frames",
    "account_title_ink": "gray<170 in x=[50,160), y=[345,411); bbox applies only to visually identified main-page frames",
    "list_roi_registration": "minimum RGB mean absolute error against f011 in x=[120,471), y=[370,1150), integer vertical shifts -40..40; meaningful only for visible main page",
    "main_visible_classification": "visual inspection: f001..f021 and f047..f094; transition horizontal motion can affect thresholds and template error",
    "keyframe_matches": ref_matches,
    "script_sha256": sha(Path(__file__)),
    "outputs": {p.name: sha(p) for p in sorted(OUT.iterdir()) if p.is_file() and p.name not in {"provenance.json", "README.md", "run.log"}},
}
(OUT / "provenance.json").write_text(json.dumps(provenance, ensure_ascii=False, indent=2) + "\n")
print(f"source sha256 {provenance['source_sha256']}")
print(f"decoded {len(frames)} frames; ffprobe nb_frames={stream['nb_frames']}; no CFR duplication")
for record in ref_matches:
    print(f"f{record['frame_1based']:03d} provided PNG RGB exact match: {record['rgb_exact_match']}")
for index in [11, 21, 47, 55, 57, 58, 62, 70, 94]:
    row = rows[index - 1]
    print(f"f{index:03d} PTS={row['pts_seconds']} card={row['main_account_card_top_y']} title={row['account_title_ymin']}..{row['account_title_ymax']} WeChat={row['wechat_text_ymin']}..{row['wechat_text_ymax']} list_dy={row['list_roi_best_dy']}")
