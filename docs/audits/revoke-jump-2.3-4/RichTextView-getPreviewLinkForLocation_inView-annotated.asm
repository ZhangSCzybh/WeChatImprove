
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1058a0be0: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1058a0be4: a90157f6    	stp	x22, x21, [sp, #0x10]
1058a0be8: a9024ff4    	stp	x20, x19, [sp, #0x20]
1058a0bec: a9037bfd    	stp	x29, x30, [sp, #0x30]
1058a0bf0: 9100c3fd    	add	x29, sp, #0x30
1058a0bf4: aa0203f3    	mov	x19, x2
1058a0bf8: 4ea11c28    	mov.16b	v8, v1
1058a0bfc: 4ea01c09    	mov.16b	v9, v0
1058a0c00: aa0003f4    	mov	x20, x0
1058a0c04: 900cf5a8    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
1058a0c08: 52800029    	mov	w9, #0x1                ; =1
1058a0c0c: 39112909    	strb	w9, [x8, #0x44a]
1058a0c10: aa0203e0    	mov	x0, x2
1058a0c14: 948e1c18    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1058a0c18: eb13029f    	cmp	x20, x19
1058a0c1c: 54000140    	b.eq	0x1058a0c44 <_Flutter_MMFoundation_BindContext+0x1b27910>
1058a0c20: f00c89a8    	adrp	x8, 0x11e9d7000 <dyld_stub_binder+0x11e9d7000>
1058a0c24: f944a901    	ldr	x1, [x8, #0x950] ; selector: convertPoint:fromView:
1058a0c28: aa1403e0    	mov	x0, x20
1058a0c2c: 4ea91d20    	mov.16b	v0, v9
1058a0c30: 4ea81d01    	mov.16b	v1, v8
1058a0c34: aa1303e2    	mov	x2, x19
1058a0c38: 948e1c0b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0c3c: 4ea01c09    	mov.16b	v9, v0
1058a0c40: 4ea11c28    	mov.16b	v8, v1
1058a0c44: d00c8d48    	adrp	x8, 0x11ea4a000 <dyld_stub_binder+0x11ea4a000>
1058a0c48: f9403d01    	ldr	x1, [x8, #0x78] ; selector: bTouchBeginOnLink
1058a0c4c: aa1403e0    	mov	x0, x20
1058a0c50: 948e1c05    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0c54: 34000380    	cbz	w0, 0x1058a0cc4 <_Flutter_MMFoundation_BindContext+0x1b27990>
1058a0c58: f00ca388    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1058a0c5c: f9442900    	ldr	x0, [x8, #0x850]
1058a0c60: d00ca968    	adrp	x8, 0x11edce000 <dyld_stub_binder+0x11edce000>
1058a0c64: b98eb508    	ldrsw	x8, [x8, #0xeb4]
1058a0c68: f8686a82    	ldr	x2, [x20, x8]
1058a0c6c: f00c8a68    	adrp	x8, 0x11e9ef000 <dyld_stub_binder+0x11e9ef000>
1058a0c70: f9426501    	ldr	x1, [x8, #0x4c8] ; selector: targetLinkStyleFromStyles:withPoint:
1058a0c74: 4ea91d20    	mov.16b	v0, v9
1058a0c78: 4ea81d01    	mov.16b	v1, v8
1058a0c7c: 948e1bfa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0c80: aa1d03fd    	mov	x29, x29
1058a0c84: 948e1bff    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1058a0c88: aa0003f4    	mov	x20, x0
1058a0c8c: f00c9388    	adrp	x8, 0x11eb13000 <dyld_stub_binder+0x11eb13000>
1058a0c90: f9432901    	ldr	x1, [x8, #0x650] ; selector: eDataDectorType
1058a0c94: 948e1bf4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0c98: f100081f    	cmp	x0, #0x2
1058a0c9c: 540000c1    	b.ne	0x1058a0cb4 <_Flutter_MMFoundation_BindContext+0x1b27980>
1058a0ca0: d00c8968    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1058a0ca4: f943dd01    	ldr	x1, [x8, #0x7b8] ; selector: jumpType
1058a0ca8: aa1403e0    	mov	x0, x20
1058a0cac: 948e1bee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0cb0: b40001c0    	cbz	x0, 0x1058a0ce8 <_Flutter_MMFoundation_BindContext+0x1b279b4>
1058a0cb4: d2800015    	mov	x21, #0x0               ; =0
1058a0cb8: aa1403e0    	mov	x0, x20
1058a0cbc: 948e1bed    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a0cc0: 14000002    	b	0x1058a0cc8 <_Flutter_MMFoundation_BindContext+0x1b27994>
1058a0cc4: d2800015    	mov	x21, #0x0               ; =0
1058a0cc8: aa1303e0    	mov	x0, x19
1058a0ccc: 948e1be9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a0cd0: aa1503e0    	mov	x0, x21
1058a0cd4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1058a0cd8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1058a0cdc: a94157f6    	ldp	x22, x21, [sp, #0x10]
1058a0ce0: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1058a0ce4: 148e1bcf    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
1058a0ce8: f00c8a68    	adrp	x8, 0x11e9ef000 <dyld_stub_binder+0x11e9ef000>
1058a0cec: f9426901    	ldr	x1, [x8, #0x4d0] ; selector: nsUrl
1058a0cf0: aa1403e0    	mov	x0, x20
1058a0cf4: 948e1bdc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0cf8: aa1d03fd    	mov	x29, x29
1058a0cfc: 948e1be1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1058a0d00: aa0003f5    	mov	x21, x0
1058a0d04: 17ffffed    	b	0x1058a0cb8 <_Flutter_MMFoundation_BindContext+0x1b27984>
