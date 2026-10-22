
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe8bac: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
108fe8bb0: a9014ff4    	stp	x20, x19, [sp, #0x10]
108fe8bb4: a9027bfd    	stp	x29, x30, [sp, #0x20]
108fe8bb8: 910083fd    	add	x29, sp, #0x20
108fe8bbc: aa0003f3    	mov	x19, x0
108fe8bc0: b00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe8bc4: 52800029    	mov	w9, #0x1                ; =1
108fe8bc8: 3938cd09    	strb	w9, [x8, #0xe33]
108fe8bcc: d00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe8bd0: f9477101    	ldr	x1, [x8, #0xee0] ; resetStatuses
108fe8bd4: 95a1ca1c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8bd8: f9400a68    	ldr	x8, [x19, #0x10]
108fe8bdc: b4000d68    	cbz	x8, 0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8be0: f9400e68    	ldr	x8, [x19, #0x18]
108fe8be4: b4000d28    	cbz	x8, 0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8be8: f9401260    	ldr	x0, [x19, #0x20]
108fe8bec: b4000ce0    	cbz	x0, 0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8bf0: d00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe8bf4: f9477501    	ldr	x1, [x8, #0xee8] ; accessoryContentType
108fe8bf8: 95a1ca13    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8bfc: f100041f    	cmp	x0, #0x1
108fe8c00: 54000c40    	b.eq	0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8c04: f9401260    	ldr	x0, [x19, #0x20]
108fe8c08: b00b7fe8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
108fe8c0c: f9426d15    	ldr	x21, [x8, #0x4d8] ; pageContext
108fe8c10: aa1503e1    	mov	x1, x21
108fe8c14: 95a1ca0c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8c18: aa1d03fd    	mov	x29, x29
108fe8c1c: 95a1ca0d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8c20: aa0003f4    	mov	x20, x0
108fe8c24: f00b80a8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
108fe8c28: f942cd01    	ldr	x1, [x8, #0x598] ; canPlayLivePhotos
108fe8c2c: 95a1ca06    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8c30: 36000340    	tbz	w0, #0x0, 0x108fe8c98 <_Flutter_MMFoundation_BindContext+0x54c487c>
108fe8c34: f9401260    	ldr	x0, [x19, #0x20]
108fe8c38: aa1503e1    	mov	x1, x21
108fe8c3c: 95a1ca02    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8c40: aa1d03fd    	mov	x29, x29
108fe8c44: 95a1ca03    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8c48: aa0003f5    	mov	x21, x0
108fe8c4c: f00b80a8    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
108fe8c50: f942d101    	ldr	x1, [x8, #0x5a0] ; showsLivePhotoIconInThumbView
108fe8c54: 95a1c9fc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8c58: 360001c0    	tbz	w0, #0x0, 0x108fe8c90 <_Flutter_MMFoundation_BindContext+0x54c4874>
108fe8c5c: f9400a60    	ldr	x0, [x19, #0x10]
108fe8c60: d00b80c8    	adrp	x8, 0x120002000 <dyld_stub_binder+0x120002000>
108fe8c64: f9427501    	ldr	x1, [x8, #0x4e8] ; hasLivePhoto
108fe8c68: 95a1c9f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8c6c: aa0003f6    	mov	x22, x0
108fe8c70: aa1503e0    	mov	x0, x21
108fe8c74: 95a1c9fa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8c78: aa1403e0    	mov	x0, x20
108fe8c7c: 95a1c9f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8c80: 34000116    	cbz	w22, 0x108fe8ca0 <_Flutter_MMFoundation_BindContext+0x54c4884>
108fe8c84: 52800028    	mov	w8, #0x1                ; =1
108fe8c88: 39003268    	strb	w8, [x19, #0xc]
108fe8c8c: 14000005    	b	0x108fe8ca0 <_Flutter_MMFoundation_BindContext+0x54c4884>
108fe8c90: aa1503e0    	mov	x0, x21
108fe8c94: 95a1c9f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8c98: aa1403e0    	mov	x0, x20
108fe8c9c: 95a1c9f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8ca0: f9400a60    	ldr	x0, [x19, #0x10]
108fe8ca4: d00b80e8    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
108fe8ca8: f9431d14    	ldr	x20, [x8, #0x638] ; isMine
108fe8cac: aa1403e1    	mov	x1, x20
108fe8cb0: 95a1c9e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8cb4: 34000120    	cbz	w0, 0x108fe8cd8 <_Flutter_MMFoundation_BindContext+0x54c48bc>
108fe8cb8: f9400a60    	ldr	x0, [x19, #0x10]
108fe8cbc: 900b76a8    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
108fe8cc0: f942c101    	ldr	x1, [x8, #0x580] ; isUploadFailed
108fe8cc4: 95a1c9e0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8cc8: 34000080    	cbz	w0, 0x108fe8cd8 <_Flutter_MMFoundation_BindContext+0x54c48bc>
108fe8ccc: 52800028    	mov	w8, #0x1                ; =1
108fe8cd0: 39002e68    	strb	w8, [x19, #0xb]
108fe8cd4: 1400002d    	b	0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8cd8: f9400a60    	ldr	x0, [x19, #0x10]
108fe8cdc: aa1403e1    	mov	x1, x20
108fe8ce0: 95a1c9d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8ce4: 34000260    	cbz	w0, 0x108fe8d30 <_Flutter_MMFoundation_BindContext+0x54c4914>
108fe8ce8: f9400a60    	ldr	x0, [x19, #0x10]
108fe8cec: f00b7688    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
108fe8cf0: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
108fe8cf4: 95a1c9d4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8cf8: 34000080    	cbz	w0, 0x108fe8d08 <_Flutter_MMFoundation_BindContext+0x54c48ec>
108fe8cfc: 52800028    	mov	w8, #0x1                ; =1
108fe8d00: 79001268    	strh	w8, [x19, #0x8]
108fe8d04: 1400000b    	b	0x108fe8d30 <_Flutter_MMFoundation_BindContext+0x54c4914>
108fe8d08: f9400a60    	ldr	x0, [x19, #0x10]
108fe8d0c: b00b7fe8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
108fe8d10: f942cd01    	ldr	x1, [x8, #0x598] ; hasSharedGroup
108fe8d14: 95a1c9cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8d18: 3900227f    	strb	wzr, [x19, #0x8]
108fe8d1c: 34000080    	cbz	w0, 0x108fe8d2c <_Flutter_MMFoundation_BindContext+0x54c4910>
108fe8d20: 52800028    	mov	w8, #0x1                ; =1
108fe8d24: 39002668    	strb	w8, [x19, #0x9]
108fe8d28: 14000002    	b	0x108fe8d30 <_Flutter_MMFoundation_BindContext+0x54c4914>
108fe8d2c: 3900267f    	strb	wzr, [x19, #0x9]
108fe8d30: f9400a60    	ldr	x0, [x19, #0x10]
108fe8d34: aa1403e1    	mov	x1, x20
108fe8d38: 95a1c9c3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8d3c: 34000260    	cbz	w0, 0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8d40: f9400e60    	ldr	x0, [x19, #0x18]
108fe8d44: d00b8048    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
108fe8d48: f9440901    	ldr	x1, [x8, #0x810] ; homepageType
108fe8d4c: 95a1c9be    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8d50: f100041f    	cmp	x0, #0x1
108fe8d54: 540001a0    	b.eq	0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8d58: f9401260    	ldr	x0, [x19, #0x20]
108fe8d5c: b00b7fe8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
108fe8d60: f9428901    	ldr	x1, [x8, #0x510] ; isStarEnabled
108fe8d64: 95a1c9b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8d68: 360000e0    	tbz	w0, #0x0, 0x108fe8d84 <_Flutter_MMFoundation_BindContext+0x54c4968>
108fe8d6c: f9400a60    	ldr	x0, [x19, #0x10]
108fe8d70: b00b7fe8    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
108fe8d74: f942b901    	ldr	x1, [x8, #0x570] ; isStarred
108fe8d78: 95a1c9b3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8d7c: 39002a60    	strb	w0, [x19, #0xa]
108fe8d80: 14000002    	b	0x108fe8d88 <_Flutter_MMFoundation_BindContext+0x54c496c>
108fe8d84: 39002a7f    	strb	wzr, [x19, #0xa]
108fe8d88: a9427bfd    	ldp	x29, x30, [sp, #0x20]
108fe8d8c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
108fe8d90: a8c357f6    	ldp	x22, x21, [sp], #0x30
108fe8d94: d65f03c0    	ret
