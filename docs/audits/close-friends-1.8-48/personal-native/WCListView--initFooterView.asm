
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ffbda4: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
108ffbda8: a9015ff8    	stp	x24, x23, [sp, #0x10]
108ffbdac: a90257f6    	stp	x22, x21, [sp, #0x20]
108ffbdb0: a9034ff4    	stp	x20, x19, [sp, #0x30]
108ffbdb4: a9047bfd    	stp	x29, x30, [sp, #0x40]
108ffbdb8: 910103fd    	add	x29, sp, #0x40
108ffbdbc: aa0003f3    	mov	x19, x0
108ffbdc0: d00be288    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108ffbdc4: 52800029    	mov	w9, #0x1                ; =1
108ffbdc8: 3939f509    	strb	w9, [x8, #0xe7d]
108ffbdcc: b00b8bf6    	adrp	x22, 0x120178000 <dyld_stub_binder+0x120178000>
108ffbdd0: f9416ad4    	ldr	x20, [x22, #0x2d0]
108ffbdd4: b00b9348    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffbdd8: b9857d15    	ldrsw	x21, [x8, #0x57c]
108ffbddc: f8756800    	ldr	x0, [x0, x21]
108ffbde0: 900b8888    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
108ffbde4: f947a501    	ldr	x1, [x8, #0xf48] ; width
108ffbde8: 95a17d97    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbdec: 900b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffbdf0: f940a901    	ldr	x1, [x8, #0x150] ; defaultHeightWithWidth:
108ffbdf4: aa1403e0    	mov	x0, x20
108ffbdf8: 95a17d93    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbdfc: 1e604008    	fmov	d8, d0
108ffbe00: f9416ac0    	ldr	x0, [x22, #0x2d0]
108ffbe04: 95a17d99    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
108ffbe08: aa0003f4    	mov	x20, x0
108ffbe0c: 900b8bd7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
108ffbe10: f94702e0    	ldr	x0, [x23, #0xe00]
108ffbe14: b00b7208    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108ffbe18: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
108ffbe1c: aa1303e2    	mov	x2, x19
108ffbe20: 95a17d89    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbe24: 1e604002    	fmov	d2, d0
108ffbe28: f00b8828    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
108ffbe2c: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
108ffbe30: 9e6703e0    	fmov	d0, xzr
108ffbe34: 9e6703e1    	fmov	d1, xzr
108ffbe38: aa1403e0    	mov	x0, x20
108ffbe3c: 1e604103    	fmov	d3, d8
108ffbe40: 95a17d81    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbe44: b00b9348    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffbe48: b9859116    	ldrsw	x22, [x8, #0x590]
108ffbe4c: f8766a68    	ldr	x8, [x19, x22]
108ffbe50: f8366a60    	str	x0, [x19, x22]
108ffbe54: aa0803e0    	mov	x0, x8
108ffbe58: 95a17d81    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffbe5c: f8766a60    	ldr	x0, [x19, x22]
108ffbe60: 900b74e8    	adrp	x8, 0x11fe97000 <dyld_stub_binder+0x11fe97000>
108ffbe64: f9449d01    	ldr	x1, [x8, #0x938] ; useMMSettingStyle
108ffbe68: 95a17d77    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbe6c: f8766a60    	ldr	x0, [x19, x22]
108ffbe70: d00b7308    	adrp	x8, 0x11fe5d000 <dyld_stub_binder+0x11fe5d000>
108ffbe74: f9425914    	ldr	x20, [x8, #0x4b0] ; setM_heightLimit:
108ffbe78: d2f80b28    	mov	x8, #-0x3fa7000000000000 ; =-4586634745500139520
108ffbe7c: 9e670100    	fmov	d0, x8
108ffbe80: aa1403e1    	mov	x1, x20
108ffbe84: 95a17d70    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbe88: f94702e0    	ldr	x0, [x23, #0xe00]
108ffbe8c: d00b7208    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
108ffbe90: f946a501    	ldr	x1, [x8, #0xd48] ; pageScopeHeightFor:
108ffbe94: aa1303e2    	mov	x2, x19
108ffbe98: 95a17d6b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbe9c: 1e7c1001    	fmov	d1, #-0.50000000
108ffbea0: 1e610800    	fmul	d0, d0, d1
108ffbea4: f8766a60    	ldr	x0, [x19, x22]
108ffbea8: aa1403e1    	mov	x1, x20
108ffbeac: 95a17d66    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbeb0: f8766a60    	ldr	x0, [x19, x22]
108ffbeb4: d00b71e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108ffbeb8: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
108ffbebc: aa1303e2    	mov	x2, x19
108ffbec0: 95a17d61    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbec4: 900b8bd7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
108ffbec8: f9462ee0    	ldr	x0, [x23, #0xc58]
108ffbecc: f00b7208    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
108ffbed0: f9465101    	ldr	x1, [x8, #0xca0] ; FG_2
108ffbed4: 95a17d5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbed8: aa1d03fd    	mov	x29, x29
108ffbedc: 95a17d5d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffbee0: aa0003f4    	mov	x20, x0
108ffbee4: f8766a60    	ldr	x0, [x19, x22]
108ffbee8: b00b7308    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
108ffbeec: f946f901    	ldr	x1, [x8, #0xdf0] ; setM_textColor:
108ffbef0: aa1403e2    	mov	x2, x20
108ffbef4: 95a17d54    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbef8: aa1403e0    	mov	x0, x20
108ffbefc: 95a17d58    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffbf00: f9462ee0    	ldr	x0, [x23, #0xc58]
108ffbf04: b00b7208    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108ffbf08: f940a101    	ldr	x1, [x8, #0x140] ; cellBackgroundColor
108ffbf0c: 95a17d4e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbf10: aa1d03fd    	mov	x29, x29
108ffbf14: 95a17d4f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffbf18: aa0003f4    	mov	x20, x0
108ffbf1c: f8766a60    	ldr	x0, [x19, x22]
108ffbf20: 900b8868    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
108ffbf24: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
108ffbf28: aa1403e2    	mov	x2, x20
108ffbf2c: 95a17d46    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffbf30: aa1403e0    	mov	x0, x20
108ffbf34: 95a17d4a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffbf38: f8766a62    	ldr	x2, [x19, x22]
108ffbf3c: f8756a60    	ldr	x0, [x19, x21]
108ffbf40: f00b7288    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
108ffbf44: f9406d01    	ldr	x1, [x8, #0xd8] ; setTableFooterView:
108ffbf48: a9447bfd    	ldp	x29, x30, [sp, #0x40]
108ffbf4c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
108ffbf50: a94257f6    	ldp	x22, x21, [sp, #0x20]
108ffbf54: a9415ff8    	ldp	x24, x23, [sp, #0x10]
108ffbf58: 6cc523e9    	ldp	d9, d8, [sp], #0x50
108ffbf5c: 15a17d3a    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
