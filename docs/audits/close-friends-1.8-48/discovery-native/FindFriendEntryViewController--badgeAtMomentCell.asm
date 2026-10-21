
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b50da0: b00f3128    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
101b50da4: 900f3529    	adrp	x9, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101b50da8: b9802929    	ldrsw	x9, [x9, #0x28]
101b50dac: f8696802    	ldr	x2, [x0, x9]
101b50db0: f9407500    	ldr	x0, [x8, #0xe8]
101b50db4: 900f1b48    	adrp	x8, 0x11feb8000 <dyld_stub_binder+0x11feb8000>
101b50db8: f943a901    	ldr	x1, [x8, #0x750] ; badgeAtMomentCell:
101b50dbc: 158358e0    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
