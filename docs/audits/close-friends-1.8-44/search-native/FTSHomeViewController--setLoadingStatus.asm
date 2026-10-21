
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101766e4c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101766e50: a9014ff4    	stp	x20, x19, [sp, #0x10]
101766e54: a9027bfd    	stp	x29, x30, [sp, #0x20]
101766e58: 910083fd    	add	x29, sp, #0x20
101766e5c: aa0003f3    	mov	x19, x0
101766e60: f00f3a08    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101766e64: f940b101    	ldr	x1, [x8, #0x160] ; feedbackButton
101766e68: 959300b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766e6c: aa1d03fd    	mov	x29, x29
101766e70: 959300b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766e74: aa0003f4    	mov	x20, x0
101766e78: d00f4d08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
101766e7c: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
101766e80: 52800022    	mov	w2, #0x1                ; =1
101766e84: 959300ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766e88: aa1403e0    	mov	x0, x20
101766e8c: 959300b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766e90: 900f3768    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
101766e94: f9403114    	ldr	x20, [x8, #0x60] ; footerView
101766e98: aa1303e0    	mov	x0, x19
101766e9c: aa1403e1    	mov	x1, x20
101766ea0: 959300a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766ea4: aa1d03fd    	mov	x29, x29
101766ea8: 959300a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766eac: aa0003f5    	mov	x21, x0
101766eb0: 900f4d28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101766eb4: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
101766eb8: aa1303e0    	mov	x0, x19
101766ebc: 959300a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766ec0: aa1d03fd    	mov	x29, x29
101766ec4: 959300a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766ec8: aa0003f6    	mov	x22, x0
101766ecc: 900f3748    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
101766ed0: f9406d01    	ldr	x1, [x8, #0xd8] ; setTableFooterView:
101766ed4: aa1503e2    	mov	x2, x21
101766ed8: 95930099    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766edc: aa1603e0    	mov	x0, x22
101766ee0: 9593009d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766ee4: aa1503e0    	mov	x0, x21
101766ee8: 9593009b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101766eec: aa1303e0    	mov	x0, x19
101766ef0: aa1403e1    	mov	x1, x20
101766ef4: 95930092    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766ef8: aa1d03fd    	mov	x29, x29
101766efc: 95930093    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101766f00: aa0003f3    	mov	x19, x0
101766f04: d00f37a8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
101766f08: f9472d01    	ldr	x1, [x8, #0xe58] ; resetStatus:
101766f0c: 52800022    	mov	w2, #0x1                ; =1
101766f10: 9593008b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101766f14: aa1303e0    	mov	x0, x19
101766f18: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101766f1c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101766f20: a8c357f6    	ldp	x22, x21, [sp], #0x30
101766f24: 1593008c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
