
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a73be8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104a73bec: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a73bf0: 910043fd    	add	x29, sp, #0x10
104a73bf4: aa0003f3    	mov	x19, x0
104a73bf8: 900dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a73bfc: b980f908    	ldrsw	x8, [x8, #0xf8]
104a73c00: f8686800    	ldr	x0, [x0, x8]
104a73c04: f00db488    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a73c08: f9404501    	ldr	x1, [x8, #0x88] ; selector reloadData
104a73c0c: 94c6cd4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73c10: b00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a73c14: f9411d01    	ldr	x1, [x8, #0x238] ; selector updateBottomTitle
104a73c18: aa1303e0    	mov	x0, x19
104a73c1c: 94c6cd48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a73c20: d00d9e68    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
104a73c24: f944dd01    	ldr	x1, [x8, #0x9b8] ; selector updateLayout
104a73c28: aa1303e0    	mov	x0, x19
104a73c2c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a73c30: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104a73c34: 14c6cd42    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
