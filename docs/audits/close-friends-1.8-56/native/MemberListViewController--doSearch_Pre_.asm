
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104add300: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104add304: a9017bfd    	stp	x29, x30, [sp, #0x10]
104add308: 910043fd    	add	x29, sp, #0x10
104add30c: aa0003f3    	mov	x19, x0
104add310: d00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104add314: b9869514    	ldrsw	x20, [x8, #0x694]
104add318: f8746800    	ldr	x0, [x0, x20]
104add31c: 900d9b08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104add320: f940ad01    	ldr	x1, [x8, #0x158] ; doSearch:
104add324: 94c52786    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104add328: f8746a60    	ldr	x0, [x19, x20]
104add32c: f00d9d48    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
104add330: f940a101    	ldr	x1, [x8, #0x140] ; getFilteredContacts
104add334: 94c52782    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104add338: aa1d03fd    	mov	x29, x29
104add33c: 94c52783    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104add340: aa0003f4    	mov	x20, x0
104add344: d00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104add348: b9869108    	ldrsw	x8, [x8, #0x690]
104add34c: f8686a60    	ldr	x0, [x19, x8]
104add350: 900d9be8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104add354: f943c901    	ldr	x1, [x8, #0x790] ; setArrResult:
104add358: aa1403e2    	mov	x2, x20
104add35c: 94c52778    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104add360: aa1403e0    	mov	x0, x20
104add364: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104add368: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104add36c: 14c5277a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
