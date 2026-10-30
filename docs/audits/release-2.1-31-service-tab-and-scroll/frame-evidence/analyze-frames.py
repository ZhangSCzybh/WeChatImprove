#!/usr/bin/env python3
"""Original-sample numeric ROI evidence only; private images stay outside repo.

Requires ffmpeg/ffprobe and NumPy. No fps filter, frame resampling, OCR, or claim
that pixel positions are actual UIKit geometry/event delivery measurements.
"""
import csv
import hashlib
import json
from pathlib import Path
import platform
import subprocess
from collections import Counter

import numpy as np

ROOT = Path(__file__).resolve().parents[4]
OUTPUT = Path(__file__).resolve().parent
SOURCE = ROOT / 'docs/feedbacks/2026-10-30-service-tab-hide-scroll-block.mp4'
ROIS = {'aggregate_content': [40, 450, 550, 620],
        'aggregate_card_backing': [280, 450, 520, 620],
        'lower_green_icon': [42, 640, 105, 698],
        'lower_steady_content': [110, 637, 550, 700],
        'touch_marker': [0, 700, 165, 920],
        'top_card': [22, 213, 571, 330]}


def sha(path):
    with path.open('rb') as file:
        return hashlib.file_digest(file, 'sha256').hexdigest()


def save(name, value):
    (OUTPUT / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n')


def roi(frame, key):
    x0, y0, x1, y1 = ROIS[key]
    return frame[y0:y1, x0:x1]


def mean_absolute(first, second):
    return round(float(np.abs(first.astype(float)-second.astype(float)).mean()), 9)


def main():
    probe_command = ['ffprobe', '-v', 'error', '-select_streams', 'v:0', '-count_frames',
                     '-show_streams', '-show_frames', '-show_entries',
                     'stream=codec_name,width,height,pix_fmt,color_range,color_space,r_frame_rate,avg_frame_rate,time_base,duration_ts,duration,nb_frames,nb_read_frames:frame=pts,pts_time,best_effort_timestamp,best_effort_timestamp_time,duration,duration_time',
                     '-of', 'json', str(SOURCE)]
    info = json.loads(subprocess.check_output(probe_command))
    stream, samples = info['streams'][0], info['frames']
    assert (stream['width'], stream['height']) == (592, 1280)
    decode_command = ['ffmpeg', '-hide_banner', '-loglevel', 'error', '-i', str(SOURCE),
                      '-map', '0:v:0', '-an', '-sn', '-dn', '-fps_mode', 'passthrough',
                      '-pix_fmt', 'rgb24', '-f', 'rawvideo', 'pipe:1']
    raw = subprocess.check_output(decode_command)
    frames = np.frombuffer(raw, np.uint8).reshape(-1, 1280, 592, 3)
    assert len(frames) == len(samples) == int(stream['nb_read_frames'])
    numerator, denominator = map(int, stream['time_base'].split('/'))
    reference = frames[80]
    rows, timestamps = [], []
    for index, (frame, sample) in enumerate(zip(frames, samples)):
        pts = int(sample['pts'])
        timing = {'frame0': index, 'frame1': index+1, 'pts_ticks': pts,
                  'pts_seconds': round(pts*numerator/denominator, 9),
                  'next_pts_delta_ticks': int(samples[index+1]['pts'])-pts if index+1<len(samples) else None}
        timestamps.append(timing)
        aggregate = roi(frame, 'aggregate_content').astype(float)
        blue = ((aggregate[:,:,2]-aggregate[:,:,0] > 70) &
                (aggregate[:,:,2]-aggregate[:,:,1] > 30) & (aggregate[:,:,2] > 150))
        backing = roi(frame, 'aggregate_card_backing')
        green = roi(frame, 'lower_green_icon').astype(float)
        green_mask = (green[:,:,1]-green[:,:,0]>60) & (green[:,:,1]-green[:,:,2]>20)
        green_y, green_x = np.nonzero(green_mask)
        touch = roi(frame, 'touch_marker').astype(float)
        touch_mask = (touch[:,:,0]-touch[:,:,1]>50) & (touch[:,:,0]-touch[:,:,2]>45) & (touch[:,:,0]>150)
        touch_y,touch_x = np.nonzero(touch_mask)
        near_white = frame[440:710,280:520].min(axis=2)>=250
        scan = near_white.mean(axis=1)
        starts=np.flatnonzero(scan>.98)
        row = {**timing, 'aggregate_blue_pixel_count': int(blue.sum()),
               'aggregate_backing_white_fraction': round(float((backing.min(axis=2)>=250).mean()),9),
               'aggregate_backing_mean_rgb': round(float(backing.mean()),9),
               'first_near_white_y_440_709': int(starts[0]+440) if len(starts) else None,
               'lower_icon_green_pixel_count': int(green_mask.sum()),
               'lower_icon_green_centroid_y': round(float(green_y.mean()+640),9) if len(green_y) else None,
               'lower_icon_mae_to_frame0_80': mean_absolute(roi(frame,'lower_green_icon'),roi(reference,'lower_green_icon')),
               'lower_content_mae_to_frame0_80': mean_absolute(roi(frame,'lower_steady_content'),roi(reference,'lower_steady_content')),
               'top_card_mae_to_frame0_80': mean_absolute(roi(frame,'top_card'),roi(reference,'top_card')),
               'touch_marker_red_pixel_count': int(touch_mask.sum()),
               'touch_marker_centroid_x': round(float(touch_x.mean()),9) if len(touch_x) else None,
               'touch_marker_centroid_y': round(float(touch_y.mean()+700),9) if len(touch_y) else None}
        rows.append(row)
    with (OUTPUT/'service-timeline.csv').open('w',newline='') as file:
        writer=csv.DictWriter(file,fieldnames=list(rows[0]));writer.writeheader();writer.writerows(rows)
    save('service-pts.json',timestamps)
    metadata={'source':str(SOURCE.relative_to(ROOT)), 'source_sha256':sha(SOURCE),'bytes':SOURCE.stat().st_size,
              'script_sha256':sha(Path(__file__)),'python':platform.python_version(),'numpy':np.__version__,
              'ffmpeg':subprocess.check_output(['ffmpeg','-version'],text=True).splitlines()[0],
              'ffprobe':subprocess.check_output(['ffprobe','-version'],text=True).splitlines()[0],
              'stream':stream,'decoded_count':len(frames),'numbering':'frame0 is presentation-order original decoded sample index; frame1=frame0+1',
              'sampling':'rgb24 passthrough; no fps filter, padding, resampling or OCR',
              'pts_delta_histogram_ticks':dict(Counter(t['next_pts_delta_ticks'] for t in timestamps if t['next_pts_delta_ticks'] is not None)),
              'roi_xyxy_half_open':ROIS}
    save('video-metadata.json',metadata)
    save('numeric-summary.json',{'initial_reference_frame0':5,'restored_reference_frame0':80,
          'inspected_return_window':[row for row in rows[60:75]],
          'fully_exposed_missing_frame0':[64,65,66],'first_restored_frame0':67,
          'first_restored_pts_seconds':rows[67]['pts_seconds'],
          'full_exposure_missing_duration_to_restored_seconds':round(rows[67]['pts_seconds']-rows[64]['pts_seconds'],9),
          'interpretation_limits':['ROI colors and pixel centroids cannot identify the sensitive predicate, policy, UIView identity, touch delivery, contentSize, contentOffset or gesture flags.',
             'Lower row/icon pixels in fully exposed missing samples are compared with restored samples; a backing top-edge change alone does not prove row y positions or scroll offset moved.',
             'User-reported frame labels differ from original passthrough decode. Both zero- and one-based indexes and PTS are recorded without relabeling or duplicating samples.']})
    print(json.dumps({'decoded_count':len(frames),'output':str(OUTPUT),'return_window':rows[62:71]},ensure_ascii=False,indent=2))


if __name__=='__main__':
    main()
