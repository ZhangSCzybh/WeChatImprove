
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0bc00: 900d3148    	adrp	x8, 0x120233000 <dyld_stub_binder+0x120233000>
105c0bc04: b9802908    	ldrsw	x8, [x8, #0x28]
105c0bc08: 38686808    	ldrb	w8, [x0, x8]
105c0bc0c: 36000068    	tbz	w8, #0x0, 0x105c0bc18 <_Flutter_MMFoundation_BindContext+0x20e77fc>
105c0bc10: 52800020    	mov	w0, #0x1                ; =1
105c0bc14: d65f03c0    	ret
105c0bc18: d100c3ff    	sub	sp, sp, #0x30
105c0bc1c: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c0bc20: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c0bc24: 910083fd    	add	x29, sp, #0x20
105c0bc28: aa0003f3    	mov	x19, x0
105c0bc2c: 900d11a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c0bc30: f9414d01    	ldr	x1, [x8, #0x298] ; shouldShowWeAppEntranceTail
105c0bc34: 94806d42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0bc38: 36000060    	tbz	w0, #0x0, 0x105c0bc44 <_Flutter_MMFoundation_BindContext+0x20e7828>
105c0bc3c: 52800020    	mov	w0, #0x1                ; =1
105c0bc40: 14000008    	b	0x105c0bc60 <_Flutter_MMFoundation_BindContext+0x20e7844>
105c0bc44: 900d2de8    	adrp	x8, 0x1201c7000 <dyld_stub_binder+0x1201c7000>
105c0bc48: f947d108    	ldr	x8, [x8, #0xfa0]
105c0bc4c: a90023f3    	stp	x19, x8, [sp]
105c0bc50: 900d11a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c0bc54: f9415501    	ldr	x1, [x8, #0x2a8] ; isShowSourceView
105c0bc58: 910003e0    	mov	x0, sp
105c0bc5c: 94806d3a    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105c0bc60: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c0bc64: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c0bc68: 9100c3ff    	add	sp, sp, #0x30
105c0bc6c: d65f03c0    	ret