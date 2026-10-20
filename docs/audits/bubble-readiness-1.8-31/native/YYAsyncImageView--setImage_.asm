
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bb698: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a9bb69c: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a9bb6a0: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a9bb6a4: 910083fd    	add	x29, sp, #0x20
10a9bb6a8: aa0203f3    	mov	x19, x2
10a9bb6ac: aa0003f4    	mov	x20, x0
10a9bb6b0: 900b14c8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bb6b4: 52800029    	mov	w9, #0x1                ; =1
10a9bb6b8: 3913c509    	strb	w9, [x8, #0x4f1]
10a9bb6bc: aa0203e0    	mov	x0, x2
10a9bb6c0: 953a7f60    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bb6c4: 900abdc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a9bb6c8: f9463100    	ldr	x0, [x8, #0xc60]
10a9bb6cc: 900aba28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a9bb6d0: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
10a9bb6d4: 953a7f5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb6d8: aa1d03fd    	mov	x29, x29
10a9bb6dc: 953a7f5d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bb6e0: aa0003f5    	mov	x21, x0
10a9bb6e4: 900aba68    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a9bb6e8: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
10a9bb6ec: aa1403e0    	mov	x0, x20
10a9bb6f0: aa1503e2    	mov	x2, x21
10a9bb6f4: 953a7f54    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb6f8: aa1503e0    	mov	x0, x21
10a9bb6fc: 953a7f58    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bb700: b00abdd5    	adrp	x21, 0x120174000 <dyld_stub_binder+0x120174000>
10a9bb704: f9450ea0    	ldr	x0, [x21, #0xa18]
10a9bb708: 900aba28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a9bb70c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a9bb710: 953a7f4d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb714: aa0003e2    	mov	x2, x0
10a9bb718: 900aba48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a9bb71c: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10a9bb720: aa1303e0    	mov	x0, x19
10a9bb724: 953a7f48    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb728: 36000100    	tbz	w0, #0x0, 0x10a9bb748 <_Flutter_MMFoundation_BindContext+0x6e9732c>
10a9bb72c: 900ac608    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bb730: b98e6d15    	ldrsw	x21, [x8, #0xe6c]
10a9bb734: aa1303e0    	mov	x0, x19
10a9bb738: 953a7f42    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bb73c: f8756a80    	ldr	x0, [x20, x21]
10a9bb740: f8356a93    	str	x19, [x20, x21]
10a9bb744: 1400000d    	b	0x10a9bb778 <_Flutter_MMFoundation_BindContext+0x6e9735c>
10a9bb748: f9450ea0    	ldr	x0, [x21, #0xa18]
10a9bb74c: d00ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bb750: f945a501    	ldr	x1, [x8, #0xb48] ; imageWithUIImage:
10a9bb754: aa1303e2    	mov	x2, x19
10a9bb758: 953a7f3b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb75c: aa1d03fd    	mov	x29, x29
10a9bb760: 953a7f3c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bb764: aa0003e8    	mov	x8, x0
10a9bb768: 900ac609    	adrp	x9, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bb76c: b98e6d35    	ldrsw	x21, [x9, #0xe6c]
10a9bb770: f8756a80    	ldr	x0, [x20, x21]
10a9bb774: f8356a88    	str	x8, [x20, x21]
10a9bb778: 953a7f39    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bb77c: f8756a80    	ldr	x0, [x20, x21]
10a9bb780: 900aba68    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a9bb784: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
10a9bb788: aa1403e2    	mov	x2, x20
10a9bb78c: 953a7f2e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb790: f8756a80    	ldr	x0, [x20, x21]
10a9bb794: d00ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bb798: f945a901    	ldr	x1, [x8, #0xb50] ; asyncLoad
10a9bb79c: 953a7f2a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb7a0: 900aba48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a9bb7a4: f9469501    	ldr	x1, [x8, #0xd28] ; layer
10a9bb7a8: aa1403e0    	mov	x0, x20
10a9bb7ac: 953a7f26    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb7b0: aa1d03fd    	mov	x29, x29
10a9bb7b4: 953a7f27    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bb7b8: aa0003f4    	mov	x20, x0
10a9bb7bc: b00aba68    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a9bb7c0: f9479d01    	ldr	x1, [x8, #0xf38] ; setNeedsDisplay
10a9bb7c4: 953a7f20    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bb7c8: aa1403e0    	mov	x0, x20
10a9bb7cc: 953a7f24    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bb7d0: aa1303e0    	mov	x0, x19
10a9bb7d4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a9bb7d8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a9bb7dc: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a9bb7e0: 153a7f1f    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>