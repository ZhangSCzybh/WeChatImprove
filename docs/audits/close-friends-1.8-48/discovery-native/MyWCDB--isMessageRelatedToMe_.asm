
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff8e74: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104ff8e78: a9017bfd    	stp	x29, x30, [sp, #0x10]
104ff8e7c: 910043fd    	add	x29, sp, #0x10
104ff8e80: aa0203f3    	mov	x19, x2
104ff8e84: aa0003f4    	mov	x20, x0
104ff8e88: aa0203e0    	mov	x0, x2
104ff8e8c: 94b0b8ab    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104ff8e90: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8e94: f9478d01    	ldr	x1, [x8, #0xf18] ; isMentionedMySelf:
104ff8e98: aa1403e0    	mov	x0, x20
104ff8e9c: aa1303e2    	mov	x2, x19
104ff8ea0: 94b0b8a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8ea4: 370000e0    	tbnz	w0, #0x0, 0x104ff8ec0 <_Flutter_MMFoundation_BindContext+0x14d4aa4>
104ff8ea8: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8eac: f9479101    	ldr	x1, [x8, #0xf20] ; isRefSelfCommentWithMsg:
104ff8eb0: aa1403e0    	mov	x0, x20
104ff8eb4: aa1303e2    	mov	x2, x19
104ff8eb8: 94b0b8a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8ebc: 36000060    	tbz	w0, #0x0, 0x104ff8ec8 <_Flutter_MMFoundation_BindContext+0x14d4aac>
104ff8ec0: 52800034    	mov	w20, #0x1               ; =1
104ff8ec4: 14000007    	b	0x104ff8ee0 <_Flutter_MMFoundation_BindContext+0x14d4ac4>
104ff8ec8: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8ecc: f9479501    	ldr	x1, [x8, #0xf28] ; mentionSelfPost:
104ff8ed0: aa1403e0    	mov	x0, x20
104ff8ed4: aa1303e2    	mov	x2, x19
104ff8ed8: 94b0b899    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8edc: aa0003f4    	mov	x20, x0
104ff8ee0: aa1303e0    	mov	x0, x19
104ff8ee4: 94b0b89c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8ee8: aa1403e0    	mov	x0, x20
104ff8eec: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104ff8ef0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104ff8ef4: d65f03c0    	ret
