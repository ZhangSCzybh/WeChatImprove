
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177c38: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100177c3c: a9017bfd    	stp	x29, x30, [sp, #0x10]
100177c40: 910043fd    	add	x29, sp, #0x10
100177c44: aa0003f3    	mov	x19, x0
100177c48: f0100328    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100177c4c: b9829114    	ldrsw	x20, [x8, #0x290]
100177c50: f8746800    	ldr	x0, [x0, x20]
100177c54: 900fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100177c58: f9438101    	ldr	x1, [x8, #0x700] ; getVoiceFormat
100177c5c: 95eabd38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100177c60: f1001c1f    	cmp	x0, #0x7
100177c64: 540000e1    	b.ne	0x100177c80 <__text+0x16fc80>
100177c68: f8746a60    	ldr	x0, [x19, x20]
100177c6c: 900fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100177c70: f944f501    	ldr	x1, [x8, #0x9e8] ; audioDuration
100177c74: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100177c78: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100177c7c: 15eabd30    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100177c80: 52800000    	mov	w0, #0x0                ; =0
100177c84: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100177c88: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100177c8c: d65f03c0    	ret
