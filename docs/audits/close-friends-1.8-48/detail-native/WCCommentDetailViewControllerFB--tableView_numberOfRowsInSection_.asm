
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e94ac0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106e94ac4: a9014ff4    	stp	x20, x19, [sp, #0x10]
106e94ac8: a9027bfd    	stp	x29, x30, [sp, #0x20]
106e94acc: 910083fd    	add	x29, sp, #0x20
106e94ad0: aa0203f3    	mov	x19, x2
106e94ad4: aa0003f4    	mov	x20, x0
106e94ad8: d00ced88    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e94adc: 52800029    	mov	w9, #0x1                ; =1
106e94ae0: 391b2909    	strb	w9, [x8, #0x6ca]
106e94ae4: aa0203e0    	mov	x0, x2
106e94ae8: 94364994    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e94aec: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e94af0: b9845d08    	ldrsw	x8, [x8, #0x45c]
106e94af4: 38686a88    	ldrb	w8, [x20, x8]
106e94af8: 36000068    	tbz	w8, #0x0, 0x106e94b04 <_Flutter_MMFoundation_BindContext+0x33706e8>
106e94afc: d2800015    	mov	x21, #0x0               ; =0
106e94b00: 14000010    	b	0x106e94b40 <_Flutter_MMFoundation_BindContext+0x3370724>
106e94b04: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e94b08: b984c508    	ldrsw	x8, [x8, #0x4c4]
106e94b0c: f8686a80    	ldr	x0, [x20, x8]
106e94b10: 900c9368    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e94b14: f9435115    	ldr	x21, [x8, #0x6a0] ; count
106e94b18: aa1503e1    	mov	x1, x21
106e94b1c: 94364988    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94b20: aa0003f6    	mov	x22, x0
106e94b24: b00c9d88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e94b28: b984c108    	ldrsw	x8, [x8, #0x4c0]
106e94b2c: f8686a80    	ldr	x0, [x20, x8]
106e94b30: aa1503e1    	mov	x1, x21
106e94b34: 94364982    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94b38: f10002df    	cmp	x22, #0x0
106e94b3c: 9a800415    	cinc	x21, x0, ne
106e94b40: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e94b44: f944fd01    	ldr	x1, [x8, #0x9f8] ; isAdFireworkCheerCommentStyle
106e94b48: aa1403e0    	mov	x0, x20
106e94b4c: 9436497c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94b50: 8b2042b5    	add	x21, x21, w0, uxtw
106e94b54: d00c8b48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e94b58: f9450101    	ldr	x1, [x8, #0xa00] ; shouldShowReadCountRow
106e94b5c: aa1403e0    	mov	x0, x20
106e94b60: 94364977    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e94b64: 8b2042b4    	add	x20, x21, w0, uxtw
106e94b68: aa1303e0    	mov	x0, x19
106e94b6c: 9436497a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e94b70: aa1403e0    	mov	x0, x20
106e94b74: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106e94b78: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106e94b7c: a8c357f6    	ldp	x22, x21, [sp], #0x30
106e94b80: d65f03c0    	ret
