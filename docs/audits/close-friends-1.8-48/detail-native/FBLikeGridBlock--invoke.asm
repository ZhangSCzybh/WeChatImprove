
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e8cb90: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106e8cb94: a9014ff4    	stp	x20, x19, [sp, #0x10]
106e8cb98: a9027bfd    	stp	x29, x30, [sp, #0x20]
106e8cb9c: 910083fd    	add	x29, sp, #0x20
106e8cba0: aa0103f3    	mov	x19, x1
106e8cba4: aa0003f4    	mov	x20, x0
106e8cba8: aa0103e0    	mov	x0, x1
106e8cbac: 94366963    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8cbb0: 91008280    	add	x0, x20, #0x20
106e8cbb4: 94366976    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106e8cbb8: aa0003f4    	mov	x20, x0
106e8cbbc: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8cbc0: f943ad01    	ldr	x1, [x8, #0x758] ; handleClickedOnAdFirstLikeForContact:
106e8cbc4: aa1303e2    	mov	x2, x19
106e8cbc8: 9436695d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cbcc: 370003c0    	tbnz	w0, #0x0, 0x106e8cc44 <_Flutter_MMFoundation_BindContext+0x3368828>
106e8cbd0: 900c9748    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e8cbd4: f9400900    	ldr	x0, [x8, #0x10] ; `:,
106e8cbd8: 94366960    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106e8cbdc: aa0003f5    	mov	x21, x0
106e8cbe0: f00c7d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e8cbe4: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
106e8cbe8: aa1303e2    	mov	x2, x19
106e8cbec: 94366954    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cbf0: f00c7d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e8cbf4: f946e901    	ldr	x1, [x8, #0xdd0] ; setM_uiFromScene:
106e8cbf8: aa1503e0    	mov	x0, x21
106e8cbfc: 52800b62    	mov	w2, #0x5b               ; =91
106e8cc00: 9436694f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cc04: 900c93c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106e8cc08: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
106e8cc0c: aa1403e0    	mov	x0, x20
106e8cc10: 9436694b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cc14: aa1d03fd    	mov	x29, x29
106e8cc18: 9436694c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8cc1c: aa0003f6    	mov	x22, x0
106e8cc20: f00c7d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e8cc24: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
106e8cc28: aa1503e2    	mov	x2, x21
106e8cc2c: 52800023    	mov	w3, #0x1                ; =1
106e8cc30: 94366943    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cc34: aa1603e0    	mov	x0, x22
106e8cc38: 94366947    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8cc3c: aa1503e0    	mov	x0, x21
106e8cc40: 94366945    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8cc44: aa1403e0    	mov	x0, x20
106e8cc48: 94366943    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8cc4c: aa1303e0    	mov	x0, x19
106e8cc50: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106e8cc54: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106e8cc58: a8c357f6    	ldp	x22, x21, [sp], #0x30
106e8cc5c: 1436693e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
