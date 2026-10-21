
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0aae6c: d10103ff    	sub	sp, sp, #0x40
10a0aae70: a90157f6    	stp	x22, x21, [sp, #0x10]
10a0aae74: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a0aae78: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a0aae7c: 9100c3fd    	add	x29, sp, #0x30
10a0aae80: aa0203f4    	mov	x20, x2
10a0aae84: aa0003f3    	mov	x19, x0
10a0aae88: f00b5d28    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0aae8c: 52800029    	mov	w9, #0x1                ; =1
10a0aae90: 39110909    	strb	w9, [x8, #0x442]
10a0aae94: d00b0948    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a0aae98: f9405508    	ldr	x8, [x8, #0xa8]
10a0aae9c: a90023e0    	stp	x0, x8, [sp]
10a0aaea0: d00aed88    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a0aaea4: f9472915    	ldr	x21, [x8, #0xe50] ; onStateOfNoMoreData:
10a0aaea8: aa0203e0    	mov	x0, x2
10a0aaeac: 955ec165    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0aaeb0: 910003e0    	mov	x0, sp
10a0aaeb4: aa1503e1    	mov	x1, x21
10a0aaeb8: aa1403e2    	mov	x2, x20
10a0aaebc: 955ec164    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a0aaec0: d00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0aaec4: b9818d08    	ldrsw	x8, [x8, #0x18c]
10a0aaec8: f8686a62    	ldr	x2, [x19, x8]
10a0aaecc: d00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0aaed0: b9817d16    	ldrsw	x22, [x8, #0x17c]
10a0aaed4: b40000a2    	cbz	x2, 0x10a0aaee8 <_Flutter_MMFoundation_BindContext+0x6586acc>
10a0aaed8: f8766a60    	ldr	x0, [x19, x22]
10a0aaedc: d00b02e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0aaee0: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
10a0aaee4: 955ec158    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaee8: f8766a60    	ldr	x0, [x19, x22]
10a0aaeec: f00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0aaef0: f9469101    	ldr	x1, [x8, #0xd20] ; setTextAlignment:
10a0aaef4: d2800002    	mov	x2, #0x0                ; =0
10a0aaef8: 955ec153    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaefc: f8766a60    	ldr	x0, [x19, x22]
10a0aaf00: 900b02e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0aaf04: f9471901    	ldr	x1, [x8, #0xe30] ; setAdjustsFontSizeToFitWidth:
10a0aaf08: 52800022    	mov	w2, #0x1                ; =1
10a0aaf0c: 955ec14e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaf10: f00af128    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
10a0aaf14: f9439901    	ldr	x1, [x8, #0x730] ; m_textColor
10a0aaf18: aa1303e0    	mov	x0, x19
10a0aaf1c: 955ec14a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaf20: aa1d03fd    	mov	x29, x29
10a0aaf24: 955ec14b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0aaf28: aa0003f5    	mov	x21, x0
10a0aaf2c: f8766a60    	ldr	x0, [x19, x22]
10a0aaf30: f00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0aaf34: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
10a0aaf38: aa1503e2    	mov	x2, x21
10a0aaf3c: 955ec142    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaf40: aa1503e0    	mov	x0, x21
10a0aaf44: 955ec146    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0aaf48: f8766a60    	ldr	x0, [x19, x22]
10a0aaf4c: f00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0aaf50: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
10a0aaf54: aa1403e2    	mov	x2, x20
10a0aaf58: 955ec13b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaf5c: f8766a60    	ldr	x0, [x19, x22]
10a0aaf60: d00b02e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0aaf64: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
10a0aaf68: 52800022    	mov	w2, #0x1                ; =1
10a0aaf6c: 955ec136    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaf70: 900aef08    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
10a0aaf74: f9461d01    	ldr	x1, [x8, #0xc38] ; genStandardTerminatorViewWithTip:
10a0aaf78: aa1303e0    	mov	x0, x19
10a0aaf7c: aa1403e2    	mov	x2, x20
10a0aaf80: 955ec131    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aaf84: aa1403e0    	mov	x0, x20
10a0aaf88: 955ec135    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0aaf8c: d00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0aaf90: b9817908    	ldrsw	x8, [x8, #0x178]
10a0aaf94: f8686a60    	ldr	x0, [x19, x8]
10a0aaf98: 900aecc8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10a0aaf9c: f947fd01    	ldr	x1, [x8, #0xff8] ; stopAnimating
10a0aafa0: 955ec129    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aafa4: d00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0aafa8: b9819908    	ldrsw	x8, [x8, #0x198]
10a0aafac: 38686a68    	ldrb	w8, [x19, x8]
10a0aafb0: 370000c8    	tbnz	w8, #0x0, 0x10a0aafc8 <_Flutter_MMFoundation_BindContext+0x6586bac>
10a0aafb4: b00b02e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a0aafb8: f946bd01    	ldr	x1, [x8, #0xd78] ; setEnabled:
10a0aafbc: aa1303e0    	mov	x0, x19
10a0aafc0: 52800002    	mov	w2, #0x0                ; =0
10a0aafc4: 955ec120    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0aafc8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a0aafcc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a0aafd0: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a0aafd4: 910103ff    	add	sp, sp, #0x40
10a0aafd8: d65f03c0    	ret
