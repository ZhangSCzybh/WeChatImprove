# 2.2-18 supplied recording: tab-bar leak pixel analysis

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
