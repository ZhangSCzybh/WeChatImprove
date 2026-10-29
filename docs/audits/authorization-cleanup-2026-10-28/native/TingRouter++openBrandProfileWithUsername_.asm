
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105e3071c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105e30720: a9014ff4    	stp	x20, x19, [sp, #0x10]
105e30724: a9027bfd    	stp	x29, x30, [sp, #0x20]
105e30728: 910083fd    	add	x29, sp, #0x20
105e3072c: d00d0ca8    	adrp	x8, 0x11ffc6000 <dyld_stub_binder+0x11ffc6000>
105e30730: f944ed01    	ldr	x1, [x8, #0x9d8] ; selector brandContactByUserName:
105e30734: 9477da82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105e30738: aa1d03fd    	mov	x29, x29
105e3073c: 9477da83    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105e30740: aa0003f3    	mov	x19, x0
105e30744: 900d1a28    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105e30748: f9400900    	ldr	x0, [x8, #0x10] ; class ContactInfoViewController
105e3074c: 9477da83    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105e30750: aa0003f4    	mov	x20, x0
105e30754: f00d0048    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105e30758: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector setM_contact:
105e3075c: aa1303e2    	mov	x2, x19
105e30760: 9477da77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105e30764: f00d0048    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105e30768: f946e901    	ldr	x1, [x8, #0xdd0] ; selector setM_uiFromScene:
105e3076c: aa1403e0    	mov	x0, x20
105e30770: 52800782    	mov	w2, #0x3c               ; =60
105e30774: 9477da72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105e30778: b00d0048    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105e3077c: f946d101    	ldr	x1, [x8, #0xda0] ; selector setM_delegate:
105e30780: aa1403e0    	mov	x0, x20
105e30784: d2800002    	mov	x2, #0x0                ; =0
105e30788: 9477da6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105e3078c: 900d1a28    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105e30790: f9408d00    	ldr	x0, [x8, #0x118] ; class CAppViewControllerManager
105e30794: d00d0088    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105e30798: f942a101    	ldr	x1, [x8, #0x540] ; selector topNavigationControllerOnMainWindow
105e3079c: 9477da68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105e307a0: aa1d03fd    	mov	x29, x29
105e307a4: 9477da69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105e307a8: aa0003f5    	mov	x21, x0
105e307ac: f00d0048    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105e307b0: f944e101    	ldr	x1, [x8, #0x9c0] ; selector PushViewController:animated:
105e307b4: aa1403e2    	mov	x2, x20
105e307b8: 52800023    	mov	w3, #0x1                ; =1
105e307bc: 9477da60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105e307c0: aa1503e0    	mov	x0, x21
105e307c4: 9477da64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105e307c8: aa1403e0    	mov	x0, x20
105e307cc: 9477da62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105e307d0: aa1303e0    	mov	x0, x19
105e307d4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105e307d8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105e307dc: a8c357f6    	ldp	x22, x21, [sp], #0x30
105e307e0: 1477da5d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
