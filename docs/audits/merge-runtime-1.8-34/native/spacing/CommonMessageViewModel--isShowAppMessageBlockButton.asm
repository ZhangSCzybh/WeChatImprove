
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6acb8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100f6acbc: a9014ff4    	stp	x20, x19, [sp, #0x10]
100f6acc0: a9027bfd    	stp	x29, x30, [sp, #0x20]
100f6acc4: 910083fd    	add	x29, sp, #0x20
100f6acc8: aa0003f3    	mov	x19, x0
100f6accc: b00f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6acd0: 910b0108    	add	x8, x8, #0x2c0
100f6acd4: b9800116    	ldrsw	x22, [x8]
100f6acd8: f8766800    	ldr	x0, [x0, x22]
100f6acdc: d00f78c8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f6ace0: f9463d01    	ldr	x1, [x8, #0xc78] ; isShowAppMessageBlockButton
100f6ace4: 95b2f116    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ace8: 36000060    	tbz	w0, #0x0, 0x100f6acf4 <__text+0xf62cf4>
100f6acec: 52800020    	mov	w0, #0x1                ; =1
100f6acf0: 14000020    	b	0x100f6ad70 <__text+0xf62d70>
100f6acf4: b00f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6acf8: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
100f6acfc: d00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6ad00: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100f6ad04: 95b2f10e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ad08: aa1d03fd    	mov	x29, x29
100f6ad0c: 95b2f10f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6ad10: aa0003f4    	mov	x20, x0
100f6ad14: d00f9048    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f6ad18: f9465900    	ldr	x0, [x8, #0xcb0] ; �.: 
100f6ad1c: b00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6ad20: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6ad24: 95b2f106    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ad28: aa0003e2    	mov	x2, x0
100f6ad2c: f00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6ad30: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100f6ad34: aa1403e0    	mov	x0, x20
100f6ad38: 95b2f101    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ad3c: aa1d03fd    	mov	x29, x29
100f6ad40: 95b2f102    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6ad44: aa0003f5    	mov	x21, x0
100f6ad48: f8766a62    	ldr	x2, [x19, x22]
100f6ad4c: d00f76a8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100f6ad50: f9421501    	ldr	x1, [x8, #0x428] ; shouldShowBlockButtonForMsg:
100f6ad54: 95b2f0fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ad58: aa0003f3    	mov	x19, x0
100f6ad5c: aa1503e0    	mov	x0, x21
100f6ad60: 95b2f0fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6ad64: aa1403e0    	mov	x0, x20
100f6ad68: 95b2f0fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6ad6c: aa1303e0    	mov	x0, x19
100f6ad70: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100f6ad74: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100f6ad78: a8c357f6    	ldp	x22, x21, [sp], #0x30
100f6ad7c: d65f03c0    	ret