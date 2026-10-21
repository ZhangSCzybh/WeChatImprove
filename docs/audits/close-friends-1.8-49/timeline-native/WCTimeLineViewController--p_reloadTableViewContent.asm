
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b926c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10a0b9270: a9017bfd    	stp	x29, x30, [sp, #0x10]
10a0b9274: 910043fd    	add	x29, sp, #0x10
10a0b9278: aa0003f3    	mov	x19, x0
10a0b927c: 900afa88    	adrp	x8, 0x120009000 <dyld_stub_binder+0x120009000>
10a0b9280: f9404901    	ldr	x1, [x8, #0x90] ; reloadDataWrap
10a0b9284: 955e8870    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9288: 900af828    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
10a0b928c: f9479d01    	ldr	x1, [x8, #0xf38] ; updateContentOffset
10a0b9290: aa1303e0    	mov	x0, x19
10a0b9294: 955e886c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9298: d00afd88    	adrp	x8, 0x12006b000 <dyld_stub_binder+0x12006b000>
10a0b929c: f9400901    	ldr	x1, [x8, #0x10] ; handleAfterReloadTableView
10a0b92a0: aa1303e0    	mov	x0, x19
10a0b92a4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10a0b92a8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10a0b92ac: 155e8866    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
