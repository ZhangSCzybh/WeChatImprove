
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bd6ac: d10103ff    	sub	sp, sp, #0x40
10a9bd6b0: 6d0123e9    	stp	d9, d8, [sp, #0x10]
10a9bd6b4: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a9bd6b8: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a9bd6bc: 9100c3fd    	add	x29, sp, #0x30
10a9bd6c0: 1e604028    	fmov	d8, d1
10a9bd6c4: 1e604009    	fmov	d9, d0
10a9bd6c8: aa0203f3    	mov	x19, x2
10a9bd6cc: aa0003f4    	mov	x20, x0
10a9bd6d0: d00b14a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bd6d4: 52800029    	mov	w9, #0x1                ; =1
10a9bd6d8: 3913ed09    	strb	w9, [x8, #0x4fb]
10a9bd6dc: aa0203e0    	mov	x0, x2
10a9bd6e0: 953a7758    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bd6e4: 900ac0c8    	adrp	x8, 0x1201d5000 <dyld_stub_binder+0x1201d5000>
10a9bd6e8: f9455908    	ldr	x8, [x8, #0xab0]
10a9bd6ec: a90023f4    	stp	x20, x8, [sp]
10a9bd6f0: b00aba28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a9bd6f4: f9466901    	ldr	x1, [x8, #0xcd0] ; init
10a9bd6f8: 910003e0    	mov	x0, sp
10a9bd6fc: 953a7754    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a9bd700: aa0003f4    	mov	x20, x0
10a9bd704: b4000400    	cbz	x0, 0x10a9bd784 <_Flutter_MMFoundation_BindContext+0x6e99368>
10a9bd708: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bd70c: f945e101    	ldr	x1, [x8, #0xbc0] ; setPrefertSize:
10a9bd710: aa1403e0    	mov	x0, x20
10a9bd714: 1e604120    	fmov	d0, d9
10a9bd718: 1e604101    	fmov	d1, d8
10a9bd71c: 953a774a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd720: aa1303e0    	mov	x0, x19
10a9bd724: 953a7762    	bl	0x10f85b4ac <_UR_96F1_B25D+0x3a6411c>
10a9bd728: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bd72c: b98e9909    	ldrsw	x9, [x8, #0xe98]
10a9bd730: f8696a88    	ldr	x8, [x20, x9]
10a9bd734: f8296a80    	str	x0, [x20, x9]
10a9bd738: aa0803e0    	mov	x0, x8
10a9bd73c: 953a7748    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd740: b00abf88    	adrp	x8, 0x1201ae000 <dyld_stub_binder+0x1201ae000>
10a9bd744: f9429500    	ldr	x0, [x8, #0x528]
10a9bd748: 953a7746    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a9bd74c: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bd750: b98e9d09    	ldrsw	x9, [x8, #0xe9c]
10a9bd754: f8696a88    	ldr	x8, [x20, x9]
10a9bd758: f8296a80    	str	x0, [x20, x9]
10a9bd75c: aa0803e0    	mov	x0, x8
10a9bd760: 953a773f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd764: 52800020    	mov	w0, #0x1                ; =1
10a9bd768: 953a77c1    	bl	0x10f85b66c <_UR_96F1_B25D+0x3a642dc>
10a9bd76c: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bd770: b98ea109    	ldrsw	x9, [x8, #0xea0]
10a9bd774: f8696a88    	ldr	x8, [x20, x9]
10a9bd778: f8296a80    	str	x0, [x20, x9]
10a9bd77c: aa0803e0    	mov	x0, x8
10a9bd780: 953a7737    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd784: aa1303e0    	mov	x0, x19
10a9bd788: 953a7735    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd78c: aa1403e0    	mov	x0, x20
10a9bd790: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9bd794: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9bd798: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
10a9bd79c: 910103ff    	add	sp, sp, #0x40
10a9bd7a0: d65f03c0    	ret