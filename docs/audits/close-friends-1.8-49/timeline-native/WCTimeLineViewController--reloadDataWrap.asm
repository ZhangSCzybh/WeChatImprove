
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b9048: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10a0b904c: a9017bfd    	stp	x29, x30, [sp, #0x10]
10a0b9050: 910043fd    	add	x29, sp, #0x10
10a0b9054: aa0003f3    	mov	x19, x0
10a0b9058: f00b0dc8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b905c: b981f908    	ldrsw	x8, [x8, #0x1f8]
10a0b9060: 52800029    	mov	w9, #0x1                ; =1
10a0b9064: 38286809    	strb	w9, [x0, x8]
10a0b9068: f00b0dc8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b906c: b981fd08    	ldrsw	x8, [x8, #0x1fc]
10a0b9070: f8686800    	ldr	x0, [x0, x8]
10a0b9074: b00b0268    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0b9078: f9408101    	ldr	x1, [x8, #0x100] ; removeAllObjects
10a0b907c: 955e88f2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9080: b00b0288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0b9084: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
10a0b9088: aa1303e0    	mov	x0, x19
10a0b908c: 955e88ee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9090: aa1d03fd    	mov	x29, x29
10a0b9094: 955e88ef    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9098: aa0003f3    	mov	x19, x0
10a0b909c: b00b0268    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0b90a0: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
10a0b90a4: 955e88e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b90a8: aa1303e0    	mov	x0, x19
10a0b90ac: 955e88ec    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b90b0: d00b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b90b4: f945e900    	ldr	x0, [x8, #0xbd0]
10a0b90b8: f00b0228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0b90bc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a0b90c0: 955e88e1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b90c4: aa1d03fd    	mov	x29, x29
10a0b90c8: 955e88e2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b90cc: aa0003f3    	mov	x19, x0
10a0b90d0: b00b05c8    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10a0b90d4: f940cd02    	ldr	x2, [x8, #0x198]
10a0b90d8: d00afd88    	adrp	x8, 0x12006b000 <dyld_stub_binder+0x12006b000>
10a0b90dc: f9400103    	ldr	x3, [x8]
10a0b90e0: b00aec08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a0b90e4: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
10a0b90e8: f009b084    	adrp	x4, 0x11d6cc000 <dyld_stub_binder+0x11d6cc000>
10a0b90ec: 911ec084    	add	x4, x4, #0x7b0
10a0b90f0: 955e88d5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b90f4: aa1303e0    	mov	x0, x19
10a0b90f8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10a0b90fc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10a0b9100: 155e88d7    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
