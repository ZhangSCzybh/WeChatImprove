
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe760c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
108fe7610: a90157f6    	stp	x22, x21, [sp, #0x10]
108fe7614: a9024ff4    	stp	x20, x19, [sp, #0x20]
108fe7618: a9037bfd    	stp	x29, x30, [sp, #0x30]
108fe761c: 9100c3fd    	add	x29, sp, #0x30
108fe7620: aa0003f3    	mov	x19, x0
108fe7624: d00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe7628: 52800029    	mov	w9, #0x1                ; =1
108fe762c: 3938b109    	strb	w9, [x8, #0xe2c]
108fe7630: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe7634: b9849918    	ldrsw	x24, [x8, #0x498]
108fe7638: f8786802    	ldr	x2, [x0, x24]
108fe763c: b50007c2    	cbnz	x2, 0x108fe7734 <_Flutter_MMFoundation_BindContext+0x54c3318>
108fe7640: 900b8c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108fe7644: f945e900    	ldr	x0, [x8, #0xbd0]
108fe7648: b00b88c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108fe764c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
108fe7650: 95a1cf7d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7654: aa1d03fd    	mov	x29, x29
108fe7658: 95a1cf7e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe765c: aa0003f4    	mov	x20, x0
108fe7660: b00b8c68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
108fe7664: f9404100    	ldr	x0, [x8, #0x80]
108fe7668: 900b88c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108fe766c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
108fe7670: 95a1cf75    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7674: aa0003e2    	mov	x2, x0
108fe7678: d00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe767c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108fe7680: aa1403e0    	mov	x0, x20
108fe7684: 95a1cf70    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7688: aa1d03fd    	mov	x29, x29
108fe768c: 95a1cf71    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe7690: aa0003f5    	mov	x21, x0
108fe7694: 900b8c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108fe7698: f9462d00    	ldr	x0, [x8, #0xc58]
108fe769c: f00b72a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
108fe76a0: f9465101    	ldr	x1, [x8, #0xca0] ; FG_2
108fe76a4: 95a1cf68    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe76a8: aa1d03fd    	mov	x29, x29
108fe76ac: 95a1cf69    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe76b0: aa0003f6    	mov	x22, x0
108fe76b4: b00b72a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108fe76b8: f9437901    	ldr	x1, [x8, #0x6f0] ; svgImageNamed:size:color:
108fe76bc: b00aaec2    	adrp	x2, 0x11e5c0000 <dyld_stub_binder+0x11e5c0000>
108fe76c0: 9104a042    	add	x2, x2, #0x128
108fe76c4: 1e661000    	fmov	d0, #16.00000000
108fe76c8: 1e661001    	fmov	d1, #16.00000000
108fe76cc: aa1503e0    	mov	x0, x21
108fe76d0: aa1603e3    	mov	x3, x22
108fe76d4: 95a1cf5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe76d8: aa1d03fd    	mov	x29, x29
108fe76dc: 95a1cf5d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe76e0: aa0003f7    	mov	x23, x0
108fe76e4: aa1603e0    	mov	x0, x22
108fe76e8: 95a1cf5d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe76ec: aa1503e0    	mov	x0, x21
108fe76f0: 95a1cf5b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe76f4: aa1403e0    	mov	x0, x20
108fe76f8: 95a1cf59    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe76fc: b00b8c68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
108fe7700: f940b900    	ldr	x0, [x8, #0x170]
108fe7704: 95a1cf59    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
108fe7708: 900b88e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108fe770c: f9400101    	ldr	x1, [x8]
108fe7710: aa1703e2    	mov	x2, x23
108fe7714: 95a1cf4c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7718: f8786a68    	ldr	x8, [x19, x24]
108fe771c: f8386a60    	str	x0, [x19, x24]
108fe7720: aa0803e0    	mov	x0, x8
108fe7724: 95a1cf4e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe7728: aa1703e0    	mov	x0, x23
108fe772c: 95a1cf4c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe7730: f8786a62    	ldr	x2, [x19, x24]
108fe7734: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe7738: b9845d08    	ldrsw	x8, [x8, #0x45c]
108fe773c: f8686a60    	ldr	x0, [x19, x8]
108fe7740: f00b88a8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
108fe7744: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
108fe7748: a9437bfd    	ldp	x29, x30, [sp, #0x30]
108fe774c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
108fe7750: a94157f6    	ldp	x22, x21, [sp, #0x10]
108fe7754: a8c45ff8    	ldp	x24, x23, [sp], #0x40
108fe7758: 15a1cf3b    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
