
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104728b94: 6dbb23e9    	stp	d9, d8, [sp, #-0x50]!
104728b98: a9015ff8    	stp	x24, x23, [sp, #0x10]
104728b9c: a90257f6    	stp	x22, x21, [sp, #0x20]
104728ba0: a9034ff4    	stp	x20, x19, [sp, #0x30]
104728ba4: a9047bfd    	stp	x29, x30, [sp, #0x40]
104728ba8: 910103fd    	add	x29, sp, #0x40
104728bac: aa0003f3    	mov	x19, x0
104728bb0: b00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104728bb4: 52800029    	mov	w9, #0x1                ; =1
104728bb8: 391a3509    	strb	w9, [x8, #0x68d]
104728bbc: d00db8e8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104728bc0: f9423d01    	ldr	x1, [x8, #0x478] ; selector unreadCount
104728bc4: 94d3f95e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728bc8: f100001f    	cmp	x0, #0x0
104728bcc: 540001ec    	b.gt	0x104728c08 <_Flutter_MMFoundation_BindContext+0xc047ec>
104728bd0: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728bd4: f9467101    	ldr	x1, [x8, #0xce0] ; selector badgeString
104728bd8: aa1303e0    	mov	x0, x19
104728bdc: 94d3f958    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728be0: aa1d03fd    	mov	x29, x29
104728be4: 94d3f959    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728be8: aa0003f4    	mov	x20, x0
104728bec: f00dcec8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104728bf0: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
104728bf4: 94d3f952    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728bf8: aa0003f5    	mov	x21, x0
104728bfc: aa1403e0    	mov	x0, x20
104728c00: 94d3f955    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728c04: b40004b5    	cbz	x21, 0x104728c98 <_Flutter_MMFoundation_BindContext+0xc0487c>
104728c08: d00dbb88    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
104728c0c: f9408914    	ldr	x20, [x8, #0x110] ; selector badgeView
104728c10: aa1303e0    	mov	x0, x19
104728c14: aa1403e1    	mov	x1, x20
104728c18: 94d3f949    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728c1c: aa1d03fd    	mov	x29, x29
104728c20: 94d3f94a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728c24: aa0003f5    	mov	x21, x0
104728c28: d00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104728c2c: f941d901    	ldr	x1, [x8, #0x3b0] ; selector setY:
104728c30: 1e621000    	fmov	d0, #4.00000000
104728c34: 94d3f942    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728c38: aa1503e0    	mov	x0, x21
104728c3c: 94d3f946    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728c40: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728c44: f9469d01    	ldr	x1, [x8, #0xd38] ; selector getBadgeViewRightMarginPortrait
104728c48: aa1303e0    	mov	x0, x19
104728c4c: 94d3f93c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728c50: 1e604008    	fmov	d8, d0
104728c54: aa1303e0    	mov	x0, x19
104728c58: aa1403e1    	mov	x1, x20
104728c5c: 94d3f938    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728c60: aa1d03fd    	mov	x29, x29
104728c64: 94d3f939    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728c68: aa0003f4    	mov	x20, x0
104728c6c: d00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104728c70: f941cd01    	ldr	x1, [x8, #0x398] ; selector setX:
104728c74: 1e604100    	fmov	d0, d8
104728c78: 94d3f931    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728c7c: aa1403e0    	mov	x0, x20
104728c80: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104728c84: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104728c88: a94257f6    	ldp	x22, x21, [sp, #0x20]
104728c8c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104728c90: 6cc523e9    	ldp	d9, d8, [sp], #0x50
104728c94: 14d3f930    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728c98: d00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104728c9c: f9458514    	ldr	x20, [x8, #0xb08] ; selector imageView
104728ca0: aa1303e0    	mov	x0, x19
104728ca4: aa1403e1    	mov	x1, x20
104728ca8: 94d3f925    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728cac: aa1d03fd    	mov	x29, x29
104728cb0: 94d3f926    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728cb4: aa0003f5    	mov	x21, x0
104728cb8: 900dcf28    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
104728cbc: f9402901    	ldr	x1, [x8, #0x50] ; selector y
104728cc0: 94d3f91f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728cc4: 1e604008    	fmov	d8, d0
104728cc8: d00dbb88    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
104728ccc: f9408916    	ldr	x22, [x8, #0x110] ; selector badgeView
104728cd0: aa1303e0    	mov	x0, x19
104728cd4: aa1603e1    	mov	x1, x22
104728cd8: 94d3f919    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728cdc: aa1d03fd    	mov	x29, x29
104728ce0: 94d3f91a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728ce4: aa0003f7    	mov	x23, x0
104728ce8: d00dcf08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104728cec: f941d901    	ldr	x1, [x8, #0x3b0] ; selector setY:
104728cf0: 1e604100    	fmov	d0, d8
104728cf4: 94d3f912    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728cf8: aa1703e0    	mov	x0, x23
104728cfc: 94d3f916    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728d00: aa1503e0    	mov	x0, x21
104728d04: 94d3f914    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728d08: aa1303e0    	mov	x0, x19
104728d0c: aa1403e1    	mov	x1, x20
104728d10: 94d3f90b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728d14: aa1d03fd    	mov	x29, x29
104728d18: 94d3f90c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728d1c: aa0003f4    	mov	x20, x0
104728d20: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104728d24: f9431d01    	ldr	x1, [x8, #0x638] ; selector right
104728d28: 94d3f905    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728d2c: 1e604008    	fmov	d8, d0
104728d30: aa1303e0    	mov	x0, x19
104728d34: aa1603e1    	mov	x1, x22
104728d38: 94d3f901    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728d3c: aa1d03fd    	mov	x29, x29
104728d40: 94d3f902    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728d44: aa0003f3    	mov	x19, x0
104728d48: 900db8a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104728d4c: f9401501    	ldr	x1, [x8, #0x28] ; selector setRight:
104728d50: 1e604100    	fmov	d0, d8
104728d54: 94d3f8fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728d58: aa1303e0    	mov	x0, x19
104728d5c: 94d3f8fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728d60: 17ffffc7    	b	0x104728c7c <_Flutter_MMFoundation_BindContext+0xc04860>
