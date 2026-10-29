
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6edd8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104a6eddc: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a6ede0: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a6ede4: 910083fd    	add	x29, sp, #0x20
104a6ede8: b00db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6edec: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104a6edf0: d00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6edf4: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104a6edf8: 94c6e0d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6edfc: aa1d03fd    	mov	x29, x29
104a6ee00: 94c6e0d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6ee04: aa0003f3    	mov	x19, x0
104a6ee08: d00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6ee0c: f9401d00    	ldr	x0, [x8, #0x38] ; class MMNewSessionMgr
104a6ee10: b00db488    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a6ee14: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104a6ee18: 94c6e0c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ee1c: aa0003e2    	mov	x2, x0
104a6ee20: f00d9e48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a6ee24: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104a6ee28: aa1303e0    	mov	x0, x19
104a6ee2c: 94c6e0c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ee30: aa1d03fd    	mov	x29, x29
104a6ee34: 94c6e0c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6ee38: aa0003f4    	mov	x20, x0
104a6ee3c: d00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6ee40: f9406101    	ldr	x1, [x8, #0xc0] ; selector GetUnreadNotifySessionCount
104a6ee44: 94c6e0be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ee48: 2a0003f5    	mov	w21, w0
104a6ee4c: aa1403e0    	mov	x0, x20
104a6ee50: 94c6e0c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ee54: aa1303e0    	mov	x0, x19
104a6ee58: 94c6e0bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ee5c: aa1503e0    	mov	x0, x21
104a6ee60: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a6ee64: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a6ee68: a8c357f6    	ldp	x22, x21, [sp], #0x30
104a6ee6c: d65f03c0    	ret
