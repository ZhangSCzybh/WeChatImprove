
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe74bc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
108fe74c0: a90157f6    	stp	x22, x21, [sp, #0x10]
108fe74c4: a9024ff4    	stp	x20, x19, [sp, #0x20]
108fe74c8: a9037bfd    	stp	x29, x30, [sp, #0x30]
108fe74cc: 9100c3fd    	add	x29, sp, #0x30
108fe74d0: aa0003f3    	mov	x19, x0
108fe74d4: d00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe74d8: 52800029    	mov	w9, #0x1                ; =1
108fe74dc: 3938ad09    	strb	w9, [x8, #0xe2b]
108fe74e0: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe74e4: b9849518    	ldrsw	x24, [x8, #0x494]
108fe74e8: f8786802    	ldr	x2, [x0, x24]
108fe74ec: b50007c2    	cbnz	x2, 0x108fe75e4 <_Flutter_MMFoundation_BindContext+0x54c31c8>
108fe74f0: 900b8c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108fe74f4: f945e900    	ldr	x0, [x8, #0xbd0]
108fe74f8: b00b88c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108fe74fc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
108fe7500: 95a1cfd1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7504: aa1d03fd    	mov	x29, x29
108fe7508: 95a1cfd2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe750c: aa0003f4    	mov	x20, x0
108fe7510: b00b8c68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
108fe7514: f9404100    	ldr	x0, [x8, #0x80]
108fe7518: 900b88c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108fe751c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
108fe7520: 95a1cfc9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7524: aa0003e2    	mov	x2, x0
108fe7528: d00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe752c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108fe7530: aa1403e0    	mov	x0, x20
108fe7534: 95a1cfc4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7538: aa1d03fd    	mov	x29, x29
108fe753c: 95a1cfc5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe7540: aa0003f5    	mov	x21, x0
108fe7544: 900b8c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108fe7548: f9462d00    	ldr	x0, [x8, #0xc58]
108fe754c: f00b72a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
108fe7550: f9465101    	ldr	x1, [x8, #0xca0] ; FG_2
108fe7554: 95a1cfbc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7558: aa1d03fd    	mov	x29, x29
108fe755c: 95a1cfbd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe7560: aa0003f6    	mov	x22, x0
108fe7564: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe7568: f9437901    	ldr	x1, [x8, #0x6f0] ; svgImageNamed:size:color:
108fe756c: 900abf62    	adrp	x2, 0x11e7d3000 <dyld_stub_binder+0x11e7d3000>
108fe7570: 91222042    	add	x2, x2, #0x888
108fe7574: 1e661000    	fmov	d0, #16.00000000
108fe7578: 1e661001    	fmov	d1, #16.00000000
108fe757c: aa1503e0    	mov	x0, x21
108fe7580: aa1603e3    	mov	x3, x22
108fe7584: 95a1cfb0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7588: aa1d03fd    	mov	x29, x29
108fe758c: 95a1cfb1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe7590: aa0003f7    	mov	x23, x0
108fe7594: aa1603e0    	mov	x0, x22
108fe7598: 95a1cfb1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe759c: aa1503e0    	mov	x0, x21
108fe75a0: 95a1cfaf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe75a4: aa1403e0    	mov	x0, x20
108fe75a8: 95a1cfad    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe75ac: b00b8c68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
108fe75b0: f940b900    	ldr	x0, [x8, #0x170]
108fe75b4: 95a1cfad    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
108fe75b8: 900b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe75bc: f9400101    	ldr	x1, [x8]
108fe75c0: aa1703e2    	mov	x2, x23
108fe75c4: 95a1cfa0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe75c8: f8786a68    	ldr	x8, [x19, x24]
108fe75cc: f8386a60    	str	x0, [x19, x24]
108fe75d0: aa0803e0    	mov	x0, x8
108fe75d4: 95a1cfa2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe75d8: aa1703e0    	mov	x0, x23
108fe75dc: 95a1cfa0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe75e0: f8786a62    	ldr	x2, [x19, x24]
108fe75e4: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe75e8: b9845d08    	ldrsw	x8, [x8, #0x45c]
108fe75ec: f8686a60    	ldr	x0, [x19, x8]
108fe75f0: f00b88a8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
108fe75f4: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
108fe75f8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
108fe75fc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
108fe7600: a94157f6    	ldp	x22, x21, [sp, #0x10]
108fe7604: a8c45ff8    	ldp	x24, x23, [sp], #0x40
108fe7608: 15a1cf8f    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
