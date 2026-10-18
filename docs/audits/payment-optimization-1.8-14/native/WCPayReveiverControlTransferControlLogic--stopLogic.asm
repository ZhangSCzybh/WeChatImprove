
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109994730: d100c3ff    	sub	sp, sp, #0x30
109994734: a9014ff4    	stp	x20, x19, [sp, #0x10]
109994738: a9027bfd    	stp	x29, x30, [sp, #0x20]
10999473c: 910083fd    	add	x29, sp, #0x20
109994740: aa0003f3    	mov	x19, x0
109994744: d00b3ba8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109994748: f9460101    	ldr	x1, [x8, #0xc00] ; stopLoading
10999474c: 957b1b3e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994750: 900b3088    	adrp	x8, 0x11ffa4000 <dyld_stub_binder+0x11ffa4000>
109994754: f942a901    	ldr	x1, [x8, #0x550] ; gotoRootViewControllerWithAnimated:
109994758: aa1303e0    	mov	x0, x19
10999475c: 52800022    	mov	w2, #0x1                ; =1
109994760: 957b1b39    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994764: d00b41e8    	adrp	x8, 0x1201d2000 <dyld_stub_binder+0x1201d2000>
109994768: f9478108    	ldr	x8, [x8, #0xf00]
10999476c: a90023f3    	stp	x19, x8, [sp]
109994770: d00b2668    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
109994774: f9438d01    	ldr	x1, [x8, #0x718] ; stopLogic
109994778: 910003e0    	mov	x0, sp
10999477c: 957b1b34    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
109994780: a9427bfd    	ldp	x29, x30, [sp, #0x20]
109994784: a9414ff4    	ldp	x20, x19, [sp, #0x10]
109994788: 9100c3ff    	add	sp, sp, #0x30
10999478c: d65f03c0    	ret