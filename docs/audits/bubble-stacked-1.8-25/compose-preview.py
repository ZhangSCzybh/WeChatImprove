from PIL import Image,ImageDraw,ImageFont
from pathlib import Path
root=Path(__file__).parent
font='/System/Library/Fonts/STHeiti Light.ttc'
canvas=Image.new('RGB',(1420,1660),'#ededed');d=ImageDraw.Draw(canvas)
for palette in range(2):
 base=palette*810
 d.text((60,base+28),'叠边样式 · 黑白底色' if not palette else '叠边样式 · 自定义底色',font=ImageFont.truetype(font,42),fill='#202020')
 for side in range(2):
  d.text((64+side*700,base+94),'接收方' if not side else '发送方',font=ImageFont.truetype(font,28),fill='#666666')
 for row,(group,label) in enumerate([(0,'单条消息'),(1,'连续消息 · 首条'),(2,'连续消息 · 中间'),(3,'连续消息 · 末条')]):
  for side in range(2):
   im=Image.open(root/f'bubble-{palette}-{side}-{group}.png').convert('RGBA')
   x=64 if side==0 else 1356-im.width;y=base+155+row*150
   canvas.paste(im,(x,y),im)
   d.text((x+32,y+30),label,font=ImageFont.truetype(font,35),fill='white' if side else '#151515')
canvas.save(root/'stacked-preview.png')
print(root/'stacked-preview.png')
