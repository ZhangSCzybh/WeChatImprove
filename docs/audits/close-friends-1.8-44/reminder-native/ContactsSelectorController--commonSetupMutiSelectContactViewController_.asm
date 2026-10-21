
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106f43e90: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106f43e94: a9014ff4    	stp	x20, x19, [sp, #0x10]
106f43e98: a9027bfd    	stp	x29, x30, [sp, #0x20]
106f43e9c: 910083fd    	add	x29, sp, #0x20
106f43ea0: aa0203f3    	mov	x19, x2
106f43ea4: aa0003f4    	mov	x20, x0
106f43ea8: b00c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f43eac: f9449115    	ldr	x21, [x8, #0x920] ; selectContactVCTitleText
106f43eb0: aa0203e0    	mov	x0, x2
106f43eb4: 94338ca1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106f43eb8: aa1403e0    	mov	x0, x20
106f43ebc: aa1503e1    	mov	x1, x21
106f43ec0: 94338c9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ec4: aa1d03fd    	mov	x29, x29
106f43ec8: 94338ca0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f43ecc: aa0003f5    	mov	x21, x0
106f43ed0: 900c7a48    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
106f43ed4: f9464d01    	ldr	x1, [x8, #0xc98] ; setM_viewcontrllerTitle:
106f43ed8: aa1303e0    	mov	x0, x19
106f43edc: aa1503e2    	mov	x2, x21
106f43ee0: 94338c97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43ee4: aa1503e0    	mov	x0, x21
106f43ee8: 94338c9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f43eec: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43ef0: f9470101    	ldr	x1, [x8, #0xe00] ; setM_commonSearchScene:
106f43ef4: aa1303e0    	mov	x0, x19
106f43ef8: 528002a2    	mov	w2, #0x15               ; =21
106f43efc: 94338c90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43f00: d00c9808    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106f43f04: b98d9108    	ldrsw	x8, [x8, #0xd90]
106f43f08: b8686a82    	ldr	w2, [x20, x8]
106f43f0c: f00c7888    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
106f43f10: f9413d01    	ldr	x1, [x8, #0x278] ; setM_memberCountLimit:
106f43f14: aa1303e0    	mov	x0, x19
106f43f18: 94338c89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43f1c: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43f20: f946f501    	ldr	x1, [x8, #0xde8] ; setM_bShowHistoryGroup:
106f43f24: aa1303e0    	mov	x0, x19
106f43f28: 52800002    	mov	w2, #0x0                ; =0
106f43f2c: 94338c84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43f30: 900c77c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f43f34: f945d101    	ldr	x1, [x8, #0xba0] ; setM_scene:
106f43f38: aa1303e0    	mov	x0, x19
106f43f3c: 52800042    	mov	w2, #0x2                ; =2
106f43f40: 94338c7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43f44: 900c7a08    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
106f43f48: f9435101    	ldr	x1, [x8, #0x6a0] ; setM_uiGroupScene:
106f43f4c: aa1303e0    	mov	x0, x19
106f43f50: 528002a2    	mov	w2, #0x15               ; =21
106f43f54: 94338c7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f43f58: aa1303e0    	mov	x0, x19
106f43f5c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106f43f60: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106f43f64: a8c357f6    	ldp	x22, x21, [sp], #0x30
106f43f68: 14338c7b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
