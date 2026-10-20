from pathlib import Path
import sys
from PIL import Image, ImageDraw, ImageFont

source = Path(sys.argv[1])
output = Path(__file__).parent / 'connected-preview.png'
font_path = '/System/Library/Fonts/STHeiti Light.ttc'
canvas = Image.new('RGB', (1420, 1170), '#ededed')
draw = ImageDraw.Draw(canvas)

def label(x, y, text, size=32, color='#505050'):
    draw.text((x, y), text, font=ImageFont.truetype(font_path, size), fill=color)

label(64, 28, '连续圆角 · 单条 / 两条 / 多条', 42, '#202020')
label(64, 98, '接收方 · 左侧连接', 28)
label(1015, 98, '发送方 · 右侧连接', 28)

for heading_y, first_y, title, groups, texts in [
    (150, 195, '单条消息', [0], ['四角圆角']),
    (350, 395, '连续两条', [1, 3], ['第一条', '第二条']),
    (675, 720, '连续多条', [1, 2, 3], ['第一条', '中间条', '最后一条']),
]:
    label(64, heading_y, title, 28)
    for row, group in enumerate(groups):
        for outgoing in range(2):
            bubble = Image.open(source / f'bubble-1-{outgoing}-{group}.png').convert('RGBA')
            x = 1356 - bubble.width if outgoing else 64
            y = first_y + row * 124
            canvas.paste(bubble, (x, y), bubble)
            label(x + 32, y + 30, texts[row], 35, 'white' if outgoing else '#151515')

label(64, 1115, '生产渲染器生成的形状示意；颜色可自定义，图中间距仅供展示。', 24)
canvas.resize((1065, 878), Image.Resampling.LANCZOS).save(output)
print(output)
