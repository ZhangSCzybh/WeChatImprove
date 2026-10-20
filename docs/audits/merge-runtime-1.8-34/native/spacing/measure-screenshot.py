"""Read the user-supplied original PNG, with no resizing or image mutation."""
from collections import Counter
from pathlib import Path
import json
import subprocess

source = Path('/Users/zhangshichao/Downloads/IMG_7443.PNG')
width, height = 1290, 2796
rgb = subprocess.check_output([
    'ffmpeg', '-v', 'error', '-i', str(source), '-f', 'rawvideo', '-pix_fmt', 'rgb24', 'pipe:1'])
assert len(rgb) == width * height * 3
color = bytes((176, 185, 210))
runs = []
start = None
for y in range(height):
    matched = sum(rgb[(y * width + x) * 3:(y * width + x) * 3 + 3] == color
                  for x in range(580, 1110)) >= 60
    if matched and start is None:
        start = y
    if not matched and start is not None:
        runs.append({'first_row': start, 'last_row': y - 1, 'height_pixels': y - start})
        start = None
result = {
    'source': str(source), 'source_pixels': [width, height], 'bubble_fill_rgb': list(color),
    'runs': runs,
    'first_ordinary_seam_pixels': runs[1]['first_row'] - runs[0]['last_row'] - 1,
    'first_ordinary_pitch_pixels': runs[1]['first_row'] - runs[0]['first_row'],
    'boundary_samples_x1000': {
        str(y): list(rgb[(y * width + 1000) * 3:(y * width + 1000) * 3 + 3])
        for y in [500, 501, 502, 503, 611, 612, 613, 614]},
    'interpretation': 'At 3x, 111px visible bodies are 37pt; 51px blank seams are 17pt. '
                      'This measures visible custom fills, not unavailable UIView frame/contentViewSize runtime values.'
}
Path(__file__).with_name('screenshot-measurements.json').write_text(json.dumps(result, indent=2))
print(json.dumps(result, indent=2))
