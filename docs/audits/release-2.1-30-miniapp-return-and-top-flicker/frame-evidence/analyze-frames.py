#!/usr/bin/env python3
"""Decode original video samples without resampling; save numerical evidence only.

Requires ffmpeg/ffprobe, NumPy and Pillow. Optional private PNGs may only be
written outside the checkout. No OCR, identity strings or image arrays are saved
in the public audit. Frame numbers are presentation-order decode indexes.
"""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import platform
import subprocess
from collections import Counter

import numpy as np
import PIL
from PIL import Image, ImageDraw

SOURCES = {
    "miniapp": "docs/feedbacks/2026-10-30-miniapp-return-leak.mp4",
    "chat": "docs/feedbacks/2026-10-30-chat-return-top-flicker.mp4",
}
PRIVATE_SELECTIONS = {"miniapp": range(98, 117), "chat": range(49, 58)}
# These conservative widths were inspected in the supplied video. They avoid
# the foreground chat page and its boundary shadow; they are NOT measured UI
# frame widths or runtime transition coordinates.
CHAT_VISIBLE_WIDTHS = {49: 25, 50: 35, 51: 45, 52: 110, 53: 265, 54: 420}
CARD_ROI = (25, 225, 560, 320)
UPPER_LIST_ROI = (25, 220, 560, 650)
PATCH_A = (44, 905, 100, 967)
PATCH_B = (44, 993, 100, 1057)


def sha(path):
    with path.open("rb") as source:
        return hashlib.file_digest(source, "sha256").hexdigest()


def save(path, value):
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def probe(path):
    command = ["ffprobe", "-v", "error", "-select_streams", "v:0",
               "-count_frames", "-show_streams", "-show_frames",
               "-show_entries",
               "stream=codec_name,width,height,pix_fmt,color_range,color_space,"
               "r_frame_rate,avg_frame_rate,time_base,duration_ts,duration,"
               "nb_frames,nb_read_frames:frame=pts,pts_time,best_effort_timestamp,"
               "best_effort_timestamp_time,duration,duration_time", "-of", "json", str(path)]
    return json.loads(subprocess.check_output(command))


def decode(path, width, height):
    command = ["ffmpeg", "-hide_banner", "-loglevel", "error", "-i", str(path),
               "-map", "0:v:0", "-an", "-sn", "-dn", "-fps_mode", "passthrough",
               "-pix_fmt", "rgb24", "-f", "rawvideo", "pipe:1"]
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    size = width * height * 3
    try:
        while True:
            data = process.stdout.read(size)
            if not data:
                break
            if len(data) != size:
                raise RuntimeError("Incomplete raw frame; no sample padding is allowed")
            yield np.frombuffer(data, np.uint8).reshape(height, width, 3)
        errors = process.stderr.read().decode(errors="replace")
        if process.wait() != 0:
            raise RuntimeError("ffmpeg decode failed: " + errors)
    finally:
        process.stdout.close()
        process.stderr.close()
        if process.poll() is None:
            process.kill()
            process.wait()


def crop(array, rect):
    x0, y0, x1, y1 = rect
    return array[y0:y1, x0:x1]


def mae(first, second):
    return float(np.abs(first.astype(float) - second.astype(float)).mean())


def rounded(value):
    return round(float(value), 9)


def longest_run(values):
    best = current = None
    for value in values:
        value = int(value)
        if current and value == current[1] + 1:
            current[1] = value
        else:
            current = [value, value]
        if best is None or current[1] - current[0] > best[1] - best[0]:
            best = current.copy()
    return best or [None, None]


def registration(frame, reference, width):
    """Fit Y = a * shifted_reference + b on an unobscured visible crop.

    This intentionally permits a single common brightness transform across
    text AND backing pixels, instead of treating <255 as a missing backing.
    It does not identify the UIKit layer that caused that transform.
    """
    current = frame[225:320, :width].astype(float).mean(axis=2).ravel()
    candidates = []
    for shift in range(-180, 1):
        expected = reference[225:320, -shift:width-shift].astype(float).mean(axis=2)
        if expected.shape != (95, width):
            continue
        expected = expected.ravel()
        variance = expected.var()
        if variance < 5:
            continue
        scale = np.mean((expected - expected.mean()) * (current - current.mean())) / variance
        offset = current.mean() - scale * expected.mean()
        residual = current - scale * expected - offset
        candidates.append((float(np.mean(residual**2)), shift, float(scale), float(offset),
                           float(np.abs(residual).mean()), float(np.quantile(np.abs(residual), .95))))
    if not candidates:
        return None
    candidates.sort()
    mse, shift, scale, offset, absolute, p95 = candidates[0]
    return {"safe_visible_width_px": width, "registration_dx_px": shift,
            "registration_scale": rounded(scale), "registration_offset": rounded(offset),
            "registration_mse": rounded(mse), "registration_mae": rounded(absolute),
            "registration_p95_abs": rounded(p95),
            "registration_next_best_mse": rounded(candidates[1][0])}


def private_sheet(private, key):
    files = sorted(private.glob(key + "-[0-9][0-9][0-9].png"))
    rect = (0, 170, 592, 370) if key == "chat" else (0, 170, 592, 1150)
    width, height = (592, 200) if key == "chat" else (296, 490)
    columns = 3 if key == "chat" else 4
    sheet = Image.new("RGB", (columns*width, ((len(files)+columns-1)//columns)*(height+25)), "#444444")
    draw = ImageDraw.Draw(sheet)
    for index, path in enumerate(files):
        image = Image.open(path).crop(rect).resize((width, height))
        x, y = index % columns * width, index // columns * (height+25)
        sheet.paste(image, (x, y+25))
        zero = int(path.stem.split("-")[-1])
        draw.text((x+5, y+5), f"index0={zero} index1={zero+1}", fill="white")
    sheet.save(private / (key + "-contact.png"))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[4])
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parent)
    parser.add_argument("--private-output", type=Path)
    args = parser.parse_args()
    root, output = args.root.resolve(), args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    private = args.private_output.resolve() if args.private_output else None
    if private:
        if private.is_relative_to(root):
            raise SystemExit("Private images must stay outside the checkout")
        private.mkdir(parents=True, exist_ok=True)
    metadata = {"script_sha256": sha(Path(__file__).resolve()),
                "python": platform.python_version(), "numpy": np.__version__, "pillow": PIL.__version__,
                "ffmpeg": subprocess.check_output(["ffmpeg", "-version"], text=True).splitlines()[0],
                "ffprobe": subprocess.check_output(["ffprobe", "-version"], text=True).splitlines()[0],
                "numbering": "frame0 is original presentation-order decoded sample index; frame1=frame0+1",
                "decoder": "rgb24 rawvideo, fps_mode=passthrough; no fps filter, resampling, padding or OCR",
                "rois_xyxy_half_open": {"card": CARD_ROI, "upper_list": UPPER_LIST_ROI,
                                         "local_patch_a": PATCH_A, "local_patch_b": PATCH_B},
                "chat_visible_widths": CHAT_VISIBLE_WIDTHS, "sources": {}}
    summaries = {}
    for key, name in SOURCES.items():
        path = root / name
        information = probe(path)
        stream, samples = information["streams"][0], information["frames"]
        width, height = stream["width"], stream["height"]
        assert (width, height) == (592, 1280)
        references = {}
        needed = {104, 114} if key == "miniapp" else {56}
        first_count = 0
        for index, frame in enumerate(decode(path, width, height)):
            first_count += 1
            if index in needed:
                references[index] = frame.copy()
            if private and index in PRIVATE_SELECTIONS[key]:
                Image.fromarray(frame).save(private / f"{key}-{index:03d}.png")
        assert first_count == len(samples) == int(stream["nb_read_frames"])
        time_num, time_den = map(int, stream["time_base"].split("/"))
        frames, rows = [], []
        for index, frame in enumerate(decode(path, width, height)):
            sample = samples[index]
            pts = int(sample["pts"])
            next_delta = int(samples[index+1]["pts"]) - pts if index+1 < len(samples) else None
            timing = {"frame0": index, "frame1": index+1, "pts_ticks": pts,
                      "pts_seconds": rounded(pts*time_num/time_den),
                      "duration_ticks": int(sample["duration"]) if "duration" in sample else None,
                      "next_pts_delta_ticks": next_delta}
            frames.append(timing)
            card = crop(frame, CARD_ROI)
            upper = crop(frame, UPPER_LIST_ROI)
            gray = frame.astype(float).mean(axis=2)
            row = {**timing, "card_mean_rgb": rounded(card.mean()),
                   "card_std_rgb": rounded(card.std()),
                   "card_near_white_fraction": rounded((card.min(axis=2) >= 252).mean()),
                   "upper_list_std_rgb": rounded(upper.std()),
                   "upper_list_dark_fraction": rounded((upper.mean(axis=2) < 180).mean()),
                   "safe_visible_width_px": None, "registration_dx_px": None,
                   "registration_scale": None, "registration_offset": None,
                   "registration_mse": None, "registration_mae": None,
                   "registration_p95_abs": None, "registration_next_best_mse": None,
                   "registered_card_middle_median": None, "registered_gap_median": None,
                   "local_patch_a_mae_to_104": None, "local_patch_b_mae_to_104": None,
                   "local_patch_a_mae_to_114": None, "local_patch_b_mae_to_114": None,
                   "inner_card_scan_white_y_start": None, "inner_card_scan_white_y_end": None,
                   "top_mae_to_56": None, "top_exact_rgb_fraction_to_56": None}
            if key == "miniapp":
                for letter, rect in (("a", PATCH_A), ("b", PATCH_B)):
                    for ref_index in (104, 114):
                        row[f"local_patch_{letter}_mae_to_{ref_index}"] = rounded(mae(crop(frame, rect), crop(references[ref_index], rect)))
                white_y = np.flatnonzero(frame[340:535, 25:28].mean(axis=(1, 2)) >= 252) + 340
                row["inner_card_scan_white_y_start"], row["inner_card_scan_white_y_end"] = longest_run(white_y)
            else:
                reference = references[56]
                if 49 <= index <= 98:
                    visible = CHAT_VISIBLE_WIDTHS.get(index, 550)
                    row.update(registration(frame, reference, visible))
                    row["registered_card_middle_median"] = rounded(np.median(gray[265:275, :visible]))
                    row["registered_gap_median"] = rounded(np.median(gray[333:340, :visible]))
                    if private and index in (52, 53, 54, 55):
                        shift = row["registration_dx_px"]
                        expected = reference[225:320, -shift:visible-shift].astype(float)
                        adjusted = np.clip(expected*row["registration_scale"] + row["registration_offset"], 0, 255).astype(np.uint8)
                        observed = frame[225:320, :visible]
                        difference = np.clip(np.abs(observed.astype(float)-adjusted.astype(float))*6, 0, 255).astype(np.uint8)
                        sheet = Image.new("RGB", (visible*3, 120), "#444444")
                        draw = ImageDraw.Draw(sheet)
                        for panel, (array, label) in enumerate(((observed, "observed"), (adjusted, "shift + common fit"), (difference, "abs difference x6"))):
                            sheet.paste(Image.fromarray(array), (panel*visible, 25))
                            draw.text((panel*visible+3, 5), label, fill="white")
                        sheet.save(private / f"chat-registered-{index:03d}.png")
                rect = (21, 212, 572, 331)
                current, expected = crop(frame, rect), crop(reference, rect)
                row["top_mae_to_56"] = rounded(mae(current, expected))
                row["top_exact_rgb_fraction_to_56"] = rounded(np.all(current == expected, axis=2).mean())
            rows.append(row)
        assert len(rows) == len(samples)
        with (output / (key + "-timeline.csv")).open("w", newline="") as target:
            writer = csv.DictWriter(target, fieldnames=list(rows[0]))
            writer.writeheader()
            writer.writerows(rows)
        save(output / (key + "-pts.json"), frames)
        deltas = Counter(row["next_pts_delta_ticks"] for row in rows if row["next_pts_delta_ticks"] is not None)
        metadata["sources"][key] = {"source": name, "sha256": sha(path), "bytes": path.stat().st_size,
                                     "stream": stream, "decoded_count": len(rows),
                                     "pts_delta_histogram_ticks": dict(sorted(deltas.items())),
                                     "non_nominal_delta_after_frame0": [row["frame0"] for row in rows
                                                                          if row["next_pts_delta_ticks"] not in (20, None)]}
        if key == "miniapp":
            # Thresholds compare anonymous local image patches, not policy or
            # session identities. Semantic labels still require human review.
            matching = [row for row in rows[100:131] if row["local_patch_a_mae_to_104"] < 5
                        and row["local_patch_b_mae_to_104"] < 5 and row["upper_list_std_rgb"] > 5]
            first, last = matching[0]["frame0"], matching[-1]["frame0"]
            changed = next(row["frame0"] for row in rows[last+1:] if row["local_patch_a_mae_to_114"] < 5
                           and row["local_patch_b_mae_to_114"] < 5)
            summaries[key] = {"inspected_range": [rows[n] for n in range(98, 117)],
                              "local_patch_match_threshold_mae": 5,
                              "reference_104_matching_frame0_start": first, "reference_104_matching_frame0_end": last,
                              "first_reference_114_matching_picture_frame0": changed,
                              "matching_sample_count": len(matching),
                              "matching_pts_span_to_first_changed_picture_seconds": rounded((int(samples[changed]["pts"])-int(samples[first]["pts"]))*time_num/time_den),
                              "upper_list_without_content_frame0": [row["frame0"] for row in rows[100:first]
                                                                       if row["upper_list_std_rgb"] < 1 and row["upper_list_dark_fraction"] == 0]}
        else:
            stable = rows[55:99]
            summaries[key] = {"transition": [rows[n] for n in range(49, 58)],
                              "stable_frame0_range_inclusive": [55, 98],
                              "stable_count": len(stable),
                              "stable_max_abs_registration_dx_px": max(abs(row["registration_dx_px"]) for row in stable),
                              "stable_max_top_mae_to_56": max(row["top_mae_to_56"] for row in stable),
                              "stable_min_exact_rgb_fraction_to_56": min(row["top_exact_rgb_fraction_to_56"] for row in stable)}
        if private:
            private_sheet(private, key)
    save(output / "video-metadata.json", metadata)
    save(output / "numeric-summary.json", summaries)
    print(json.dumps({"output": str(output), "private_images": str(private) if private else None,
                      "counts": {key: value["decoded_count"] for key, value in metadata["sources"].items()}}, indent=2))


if __name__ == "__main__":
    main()
