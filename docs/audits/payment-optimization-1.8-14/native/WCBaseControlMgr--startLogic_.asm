
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106b42880: d10143ff    	sub	sp, sp, #0x50
106b42884: a90257f6    	stp	x22, x21, [sp, #0x20]
106b42888: a9034ff4    	stp	x20, x19, [sp, #0x30]
106b4288c: a9047bfd    	stp	x29, x30, [sp, #0x40]
106b42890: 910103fd    	add	x29, sp, #0x40
106b42894: aa0203f3    	mov	x19, x2
106b42898: aa0003f4    	mov	x20, x0
106b4289c: f00d0808    	adrp	x8, 0x120c45000 <dyld_stub_binder+0x120c45000>
106b428a0: 52800029    	mov	w9, #0x1                ; =1
106b428a4: 3927fd09    	strb	w9, [x8, #0x9ff]
106b428a8: 900cdc88    	adrp	x8, 0x1206d2000 <dyld_stub_binder+0x1206d2000>
106b428ac: b94d9909    	ldr	w9, [x8, #0xd98]
106b428b0: 11000535    	add	w21, w9, #0x1
106b428b4: b90d9915    	str	w21, [x8, #0xd98]
106b428b8: d00ca588    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106b428bc: f9405116    	ldr	x22, [x8, #0xa0] ; setM_tag:
106b428c0: aa0203e0    	mov	x0, x2
106b428c4: 9443921d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106b428c8: aa1303e0    	mov	x0, x19
106b428cc: aa1603e1    	mov	x1, x22
106b428d0: aa1503e2    	mov	x2, x21
106b428d4: 9443921a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b428d8: 900cb808    	adrp	x8, 0x120242000 <dyld_stub_binder+0x120242000>
106b428dc: b9839916    	ldrsw	x22, [x8, #0x398]
106b428e0: f8766a80    	ldr	x0, [x20, x22]
106b428e4: b00cae08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106b428e8: f9466101    	ldr	x1, [x8, #0xcc0] ; lastObject
106b428ec: 94439214    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b428f0: aa1d03fd    	mov	x29, x29
106b428f4: 94439215    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106b428f8: aa0003f5    	mov	x21, x0
106b428fc: b40000a0    	cbz	x0, 0x106b42910 <_Flutter_MMFoundation_BindContext+0x301e4f4>
106b42900: f00cae08    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
106b42904: f943a901    	ldr	x1, [x8, #0x750] ; pause
106b42908: aa1503e0    	mov	x0, x21
106b4290c: 9443920c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b42910: f8766a80    	ldr	x0, [x20, x22]
106b42914: 900c97c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106b42918: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
106b4291c: aa1303e2    	mov	x2, x19
106b42920: 94439207    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b42924: b00c9848    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
106b42928: f940a901    	ldr	x1, [x8, #0x150] ; startLogic
106b4292c: aa1303e0    	mov	x0, x19
106b42930: 94439203    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b42934: b00cb188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106b42938: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
106b4293c: f8766a88    	ldr	x8, [x20, x22]
106b42940: f00c97a9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106b42944: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106b42948: a900a3f4    	stp	x20, x8, [sp, #0x8]
106b4294c: 900bec88    	adrp	x8, 0x11e8d2000 <dyld_stub_binder+0x11e8d2000>
106b42950: 913aa108    	add	x8, x8, #0xea8 ; CFSTR startLogic:%@ m_arrLogicStack: %@
106b42954: f90003e8    	str	x8, [sp]
106b42958: b00a77c5    	adrp	x5, 0x11ba3b000 <dyld_stub_binder+0x11ba3b000>
106b4295c: 910f2ca5    	add	x5, x5, #0x3cb
106b42960: b00a77c7    	adrp	x7, 0x11ba3b000 <dyld_stub_binder+0x11ba3b000>
106b42964: 910f7ce7    	add	x7, x7, #0x3df
106b42968: 52800042    	mov	w2, #0x2                ; =2
106b4296c: d2800003    	mov	x3, #0x0                ; =0
106b42970: 52800004    	mov	w4, #0x0                ; =0
106b42974: 52800826    	mov	w6, #0x41               ; =65
106b42978: 944391f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b4297c: 900c9ca8    	adrp	x8, 0x11fed6000 <dyld_stub_binder+0x11fed6000>
106b42980: f9434101    	ldr	x1, [x8, #0x680] ; m_tag
106b42984: aa1303e0    	mov	x0, x19
106b42988: 944391ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106b4298c: aa0003f4    	mov	x20, x0
106b42990: aa1303e0    	mov	x0, x19
106b42994: 944391f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b42998: aa1503e0    	mov	x0, x21
106b4299c: 944391ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106b429a0: aa1403e0    	mov	x0, x20
106b429a4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106b429a8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106b429ac: a94257f6    	ldp	x22, x21, [sp, #0x20]
106b429b0: 910143ff    	add	sp, sp, #0x50
106b429b4: d65f03c0    	ret