
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105778300: d10103ff    	sub	sp, sp, #0x40
105778304: a90157f6    	stp	x22, x21, [sp, #0x10]
105778308: a9024ff4    	stp	x20, x19, [sp, #0x20]
10577830c: a9037bfd    	stp	x29, x30, [sp, #0x30]
105778310: 9100c3fd    	add	x29, sp, #0x30
105778314: aa0203f3    	mov	x19, x2
105778318: aa0003f4    	mov	x20, x0
10577831c: aa0203e0    	mov	x0, x2
105778320: 9492bb86    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105778324: 900d3648    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
105778328: f9435901    	ldr	x1, [x8, #0x6b0] ; canRetry
10577832c: aa1303e0    	mov	x0, x19
105778330: 9492bb83    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778334: 370004e0    	tbnz	w0, #0x0, 0x1057783d0 <_Flutter_MMFoundation_BindContext+0x1c53fb4>
105778338: f00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577833c: f9453500    	ldr	x0, [x8, #0xa68]
105778340: b00d3608    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105778344: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105778348: 900c84c8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577834c: 91302108    	add	x8, x8, #0xc08
105778350: f90003e8    	str	x8, [sp]
105778354: 900b0b45    	adrp	x5, 0x11b8e0000 <dyld_stub_binder+0x11b8e0000>
105778358: 913f2ca5    	add	x5, x5, #0xfcb
10577835c: b00b0b47    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
105778360: 910680e7    	add	x7, x7, #0x1a0
105778364: 52800042    	mov	w2, #0x2                ; =2
105778368: d2800003    	mov	x3, #0x0                ; =0
10577836c: 52800004    	mov	w4, #0x0                ; =0
105778370: 52801926    	mov	w6, #0xc9               ; =201
105778374: 9492bb72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778378: f00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577837c: f9456d00    	ldr	x0, [x8, #0xad8]
105778380: d00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105778384: b98cb908    	ldrsw	x8, [x8, #0xcb8]
105778388: f8686a82    	ldr	x2, [x20, x8]
10577838c: f00d4c28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105778390: f941b101    	ldr	x1, [x8, #0x360] ; arrayWithArray:
105778394: 9492bb6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778398: aa1d03fd    	mov	x29, x29
10577839c: 9492bb6b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057783a0: aa0003f5    	mov	x21, x0
1057783a4: d00d3628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1057783a8: f947a101    	ldr	x1, [x8, #0xf40] ; setM_oUserData:
1057783ac: aa1303e0    	mov	x0, x19
1057783b0: aa1503e2    	mov	x2, x21
1057783b4: 9492bb62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057783b8: aa1503e0    	mov	x0, x21
1057783bc: 9492bb66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057783c0: 900d41c8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
1057783c4: f941f501    	ldr	x1, [x8, #0x3e8] ; HandleSendFail
1057783c8: aa1403e0    	mov	x0, x20
1057783cc: 9492bb5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057783d0: aa1303e0    	mov	x0, x19
1057783d4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1057783d8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1057783dc: a94157f6    	ldp	x22, x21, [sp, #0x10]
1057783e0: 910103ff    	add	sp, sp, #0x40
1057783e4: 1492bb5c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
