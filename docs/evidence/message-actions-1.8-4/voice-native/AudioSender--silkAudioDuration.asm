
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177be0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100177be4: a9017bfd    	stp	x29, x30, [sp, #0x10]
100177be8: 910043fd    	add	x29, sp, #0x10
100177bec: aa0003f3    	mov	x19, x0
100177bf0: f0100328    	adrp	x8, 0x1201de000 <dyld_stub_binder+0x1201de000>
100177bf4: b9829114    	ldrsw	x20, [x8, #0x290]
100177bf8: f8746800    	ldr	x0, [x0, x20]
100177bfc: 900fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100177c00: f9438101    	ldr	x1, [x8, #0x700] ; getVoiceFormat
100177c04: 95eabd4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100177c08: f100101f    	cmp	x0, #0x4
100177c0c: 540000e1    	b.ne	0x100177c28 <__text+0x16fc28>
100177c10: f8746a60    	ldr	x0, [x19, x20]
100177c14: 900fe668    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100177c18: f944f501    	ldr	x1, [x8, #0x9e8] ; audioDuration
100177c1c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100177c20: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100177c24: 15eabd46    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100177c28: 52800000    	mov	w0, #0x0                ; =0
100177c2c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100177c30: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100177c34: d65f03c0    	ret
