
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bbba4: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a9bbba8: a90157f6    	stp	x22, x21, [sp, #0x10]
10a9bbbac: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a9bbbb0: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a9bbbb4: 9100c3fd    	add	x29, sp, #0x30
10a9bbbb8: aa0103f3    	mov	x19, x1
10a9bbbbc: aa0003f4    	mov	x20, x0
10a9bbbc0: aa0103e0    	mov	x0, x1
10a9bbbc4: 953a7e1f    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bbbc8: f9401288    	ldr	x8, [x20, #0x20]
10a9bbbcc: f9400508    	ldr	x8, [x8, #0x8]
10a9bbbd0: 39406108    	ldrb	w8, [x8, #0x18]
10a9bbbd4: 360001e8    	tbz	w8, #0x0, 0x10a9bbc10 <_Flutter_MMFoundation_BindContext+0x6e977f4>
10a9bbbd8: 9100a280    	add	x0, x20, #0x28
10a9bbbdc: 953a7e2e    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9bbbe0: aa0003f7    	mov	x23, x0
10a9bbbe4: f00aae88    	adrp	x8, 0x11ff8e000 <dyld_stub_binder+0x11ff8e000>
10a9bbbe8: f9440116    	ldr	x22, [x8, #0x800] ; decodeImage
10a9bbbec: aa1603e1    	mov	x1, x22
10a9bbbf0: 953a7e15    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbbf4: aa1d03fd    	mov	x29, x29
10a9bbbf8: 953a7e16    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bbbfc: aa0003f5    	mov	x21, x0
10a9bbc00: aa1703e0    	mov	x0, x23
10a9bbc04: 953a7e16    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bbc08: b5000355    	cbnz	x21, 0x10a9bbc70 <_Flutter_MMFoundation_BindContext+0x6e97854>
10a9bbc0c: 14000003    	b	0x10a9bbc18 <_Flutter_MMFoundation_BindContext+0x6e977fc>
10a9bbc10: f00aae88    	adrp	x8, 0x11ff8e000 <dyld_stub_binder+0x11ff8e000>
10a9bbc14: f9440116    	ldr	x22, [x8, #0x800] ; decodeImage
10a9bbc18: 9100c280    	add	x0, x20, #0x30
10a9bbc1c: 953a7e1e    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9bbc20: aa0003f7    	mov	x23, x0
10a9bbc24: aa1603e1    	mov	x1, x22
10a9bbc28: 953a7e07    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbc2c: aa1d03fd    	mov	x29, x29
10a9bbc30: 953a7e08    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bbc34: aa0003f5    	mov	x21, x0
10a9bbc38: aa1703e0    	mov	x0, x23
10a9bbc3c: 953a7e08    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bbc40: b5000195    	cbnz	x21, 0x10a9bbc70 <_Flutter_MMFoundation_BindContext+0x6e97854>
10a9bbc44: 9100e280    	add	x0, x20, #0x38
10a9bbc48: 953a7e13    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9bbc4c: aa0003f4    	mov	x20, x0
10a9bbc50: f00aba28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a9bbc54: f9453d01    	ldr	x1, [x8, #0xa78] ; image
10a9bbc58: 953a7dfb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bbc5c: aa1d03fd    	mov	x29, x29
10a9bbc60: 953a7dfc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bbc64: aa0003f5    	mov	x21, x0
10a9bbc68: aa1403e0    	mov	x0, x20
10a9bbc6c: 953a7dfc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bbc70: aa1303e0    	mov	x0, x19
10a9bbc74: 953a7dfa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bbc78: aa1503e0    	mov	x0, x21
10a9bbc7c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9bbc80: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9bbc84: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9bbc88: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a9bbc8c: 153a7dfb    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>