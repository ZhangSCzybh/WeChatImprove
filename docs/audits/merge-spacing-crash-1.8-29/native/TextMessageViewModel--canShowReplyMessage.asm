
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c10b50: d100c3ff    	sub	sp, sp, #0x30
105c10b54: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c10b58: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c10b5c: 910083fd    	add	x29, sp, #0x20
105c10b60: aa0003f3    	mov	x19, x0
105c10b64: f00d2da8    	adrp	x8, 0x1201c7000 <dyld_stub_binder+0x1201c7000>
105c10b68: f947d108    	ldr	x8, [x8, #0xfa0]
105c10b6c: a90023e0    	stp	x0, x8, [sp]
105c10b70: 900d13a8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
105c10b74: f9463501    	ldr	x1, [x8, #0xc68] ; canShowReplyMessage
105c10b78: 910003e0    	mov	x0, sp
105c10b7c: 94805972    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105c10b80: 340001c0    	cbz	w0, 0x105c10bb8 <_Flutter_MMFoundation_BindContext+0x20ec79c>
105c10b84: f00d1168    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c10b88: f9415d01    	ldr	x1, [x8, #0x2b8] ; isTailPart
105c10b8c: aa1303e0    	mov	x0, x19
105c10b90: 9480596b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10b94: 36000060    	tbz	w0, #0x0, 0x105c10ba0 <_Flutter_MMFoundation_BindContext+0x20ec784>
105c10b98: 52800020    	mov	w0, #0x1                ; =1
105c10b9c: 14000007    	b	0x105c10bb8 <_Flutter_MMFoundation_BindContext+0x20ec79c>
105c10ba0: d00d11c8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
105c10ba4: f940b901    	ldr	x1, [x8, #0x170] ; splitPosition
105c10ba8: aa1303e0    	mov	x0, x19
105c10bac: 94805964    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10bb0: f100001f    	cmp	x0, #0x0
105c10bb4: 1a9f17e0    	cset	w0, eq
105c10bb8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c10bbc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c10bc0: 9100c3ff    	add	sp, sp, #0x30
105c10bc4: d65f03c0    	ret