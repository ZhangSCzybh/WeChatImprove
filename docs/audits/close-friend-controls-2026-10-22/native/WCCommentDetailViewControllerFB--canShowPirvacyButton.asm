
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e875cc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106e875d0: a9014ff4    	stp	x20, x19, [sp, #0x10]
106e875d4: a9027bfd    	stp	x29, x30, [sp, #0x20]
106e875d8: 910083fd    	add	x29, sp, #0x20
106e875dc: aa0003f3    	mov	x19, x0
106e875e0: 900c98a8    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
106e875e4: f940d114    	ldr	x20, [x8, #0x1a0]
106e875e8: d00c7da8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106e875ec: f943c101    	ldr	x1, [x8, #0x780] ; dataItem
106e875f0: 94367ed3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e875f4: aa1d03fd    	mov	x29, x29
106e875f8: 94367ed4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e875fc: aa0003f5    	mov	x21, x0
106e87600: b00c8b68    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106e87604: f9426901    	ldr	x1, [x8, #0x4d0] ; dynamicTagEnabled
106e87608: aa1303e0    	mov	x0, x19
106e8760c: 94367ecc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87610: aa0003e3    	mov	x3, x0
106e87614: d00c8ae8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106e87618: f9429501    	ldr	x1, [x8, #0x528] ; canShowShareGroupButtonWithDataItem:isDynamicTagEnabled:
106e8761c: aa1403e0    	mov	x0, x20
106e87620: aa1503e2    	mov	x2, x21
106e87624: 94367ec6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e87628: aa0003f3    	mov	x19, x0
106e8762c: aa1503e0    	mov	x0, x21
106e87630: 94367ec9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e87634: aa1303e0    	mov	x0, x19
106e87638: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106e8763c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106e87640: a8c357f6    	ldp	x22, x21, [sp], #0x30
106e87644: d65f03c0    	ret
