
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecda98: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101ecda9c: a9015ff8    	stp	x24, x23, [sp, #0x10]
101ecdaa0: a90257f6    	stp	x22, x21, [sp, #0x20]
101ecdaa4: a9034ff4    	stp	x20, x19, [sp, #0x30]
101ecdaa8: a9047bfd    	stp	x29, x30, [sp, #0x40]
101ecdaac: 910103fd    	add	x29, sp, #0x40
101ecdab0: aa0203f3    	mov	x19, x2
101ecdab4: aa0003f4    	mov	x20, x0
101ecdab8: f00f6b28    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101ecdabc: 52800029    	mov	w9, #0x1                ; =1
101ecdac0: 390eb509    	strb	w9, [x8, #0x3ad]
101ecdac4: aa0203e0    	mov	x0, x2
101ecdac8: 9575659c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101ecdacc: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecdad0: b987ad08    	ldrsw	x8, [x8, #0x7ac]
101ecdad4: b8686a88    	ldr	w8, [x20, x8]
101ecdad8: 7100111f    	cmp	w8, #0x4
101ecdadc: 540003a1    	b.ne	0x101ecdb50 <_Flutter_Image_provideRelativePathByUrl+0x2daa00>
101ecdae0: b00efc48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101ecdae4: f9429d01    	ldr	x1, [x8, #0x538] ; isExisted:
101ecdae8: aa1403e0    	mov	x0, x20
101ecdaec: aa1303e2    	mov	x2, x19
101ecdaf0: 95756593    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdaf4: 37000e80    	tbnz	w0, #0x0, 0x101ecdcc4 <_Flutter_Image_provideRelativePathByUrl+0x2dab74>
101ecdaf8: b00efc48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101ecdafc: f9429901    	ldr	x1, [x8, #0x530] ; isSelected:
101ecdb00: aa1403e0    	mov	x0, x20
101ecdb04: aa1303e2    	mov	x2, x19
101ecdb08: 9575658d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdb0c: 340005e0    	cbz	w0, 0x101ecdbc8 <_Flutter_Image_provideRelativePathByUrl+0x2daa78>
101ecdb10: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecdb14: b987b508    	ldrsw	x8, [x8, #0x7b4]
101ecdb18: f8686a96    	ldr	x22, [x20, x8]
101ecdb1c: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecdb20: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
101ecdb24: aa1303e0    	mov	x0, x19
101ecdb28: 95756585    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdb2c: aa1d03fd    	mov	x29, x29
101ecdb30: 95756586    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecdb34: aa0003f5    	mov	x21, x0
101ecdb38: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecdb3c: f9462101    	ldr	x1, [x8, #0xc40] ; safeRemoveObjectForKey:
101ecdb40: aa1603e0    	mov	x0, x22
101ecdb44: aa1503e2    	mov	x2, x21
101ecdb48: 9575657d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdb4c: 14000052    	b	0x101ecdc94 <_Flutter_Image_provideRelativePathByUrl+0x2dab44>
101ecdb50: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecdb54: b987b919    	ldrsw	x25, [x8, #0x7b8]
101ecdb58: 8b190280    	add	x0, x20, x25
101ecdb5c: 9575658c    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecdb60: b4000b20    	cbz	x0, 0x101ecdcc4 <_Flutter_Image_provideRelativePathByUrl+0x2dab74>
101ecdb64: aa0003f6    	mov	x22, x0
101ecdb68: 8b190280    	add	x0, x20, x25
101ecdb6c: 95756588    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecdb70: aa0003f7    	mov	x23, x0
101ecdb74: b00effe8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
101ecdb78: f944cd15    	ldr	x21, [x8, #0x998] ; onGroupSelectContactReturn:
101ecdb7c: b00f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101ecdb80: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101ecdb84: aa1503e2    	mov	x2, x21
101ecdb88: 9575656d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdb8c: aa0003f8    	mov	x24, x0
101ecdb90: aa1703e0    	mov	x0, x23
101ecdb94: 95756570    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdb98: aa1603e0    	mov	x0, x22
101ecdb9c: 9575656e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdba0: 34000938    	cbz	w24, 0x101ecdcc4 <_Flutter_Image_provideRelativePathByUrl+0x2dab74>
101ecdba4: 8b190280    	add	x0, x20, x25
101ecdba8: 95756579    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecdbac: aa0003f4    	mov	x20, x0
101ecdbb0: aa1503e1    	mov	x1, x21
101ecdbb4: aa1303e2    	mov	x2, x19
101ecdbb8: 95756561    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdbbc: aa1403e0    	mov	x0, x20
101ecdbc0: 95756565    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdbc4: 14000040    	b	0x101ecdcc4 <_Flutter_Image_provideRelativePathByUrl+0x2dab74>
101ecdbc8: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecdbcc: b987b918    	ldrsw	x24, [x8, #0x7b8]
101ecdbd0: 8b180280    	add	x0, x20, x24
101ecdbd4: 9575656e    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecdbd8: b40003e0    	cbz	x0, 0x101ecdc54 <_Flutter_Image_provideRelativePathByUrl+0x2dab04>
101ecdbdc: aa0003f5    	mov	x21, x0
101ecdbe0: 8b180280    	add	x0, x20, x24
101ecdbe4: 9575656a    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecdbe8: aa0003f6    	mov	x22, x0
101ecdbec: 900efce8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
101ecdbf0: f940d517    	ldr	x23, [x8, #0x1a8] ; onShouldSelectContact:
101ecdbf4: b00f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101ecdbf8: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101ecdbfc: aa1703e2    	mov	x2, x23
101ecdc00: 9575654f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdc04: 36000200    	tbz	w0, #0x0, 0x101ecdc44 <_Flutter_Image_provideRelativePathByUrl+0x2daaf4>
101ecdc08: 8b180280    	add	x0, x20, x24
101ecdc0c: 95756560    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101ecdc10: aa0003f8    	mov	x24, x0
101ecdc14: aa1703e1    	mov	x1, x23
101ecdc18: aa1303e2    	mov	x2, x19
101ecdc1c: 95756548    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdc20: aa0003f7    	mov	x23, x0
101ecdc24: aa1803e0    	mov	x0, x24
101ecdc28: 9575654b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdc2c: aa1603e0    	mov	x0, x22
101ecdc30: 95756549    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdc34: aa1503e0    	mov	x0, x21
101ecdc38: 95756547    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdc3c: 350000d7    	cbnz	w23, 0x101ecdc54 <_Flutter_Image_provideRelativePathByUrl+0x2dab04>
101ecdc40: 14000017    	b	0x101ecdc9c <_Flutter_Image_provideRelativePathByUrl+0x2dab4c>
101ecdc44: aa1603e0    	mov	x0, x22
101ecdc48: 95756543    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdc4c: aa1503e0    	mov	x0, x21
101ecdc50: 95756541    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdc54: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecdc58: b987b508    	ldrsw	x8, [x8, #0x7b4]
101ecdc5c: f8686a96    	ldr	x22, [x20, x8]
101ecdc60: d00efb68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101ecdc64: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
101ecdc68: aa1303e0    	mov	x0, x19
101ecdc6c: 95756534    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdc70: aa1d03fd    	mov	x29, x29
101ecdc74: 95756535    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101ecdc78: aa0003f5    	mov	x21, x0
101ecdc7c: 900efb68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101ecdc80: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
101ecdc84: aa1603e0    	mov	x0, x22
101ecdc88: aa1303e2    	mov	x2, x19
101ecdc8c: aa1503e3    	mov	x3, x21
101ecdc90: 9575652b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdc94: aa1503e0    	mov	x0, x21
101ecdc98: 9575652f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101ecdc9c: b00effe8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
101ecdca0: f944c101    	ldr	x1, [x8, #0x980] ; updateRightBarBtn
101ecdca4: aa1403e0    	mov	x0, x20
101ecdca8: 95756525    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdcac: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecdcb0: b987bd08    	ldrsw	x8, [x8, #0x7bc]
101ecdcb4: f8686a80    	ldr	x0, [x20, x8]
101ecdcb8: b00f11c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101ecdcbc: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
101ecdcc0: 9575651f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecdcc4: aa1303e0    	mov	x0, x19
101ecdcc8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101ecdccc: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101ecdcd0: a94257f6    	ldp	x22, x21, [sp, #0x20]
101ecdcd4: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101ecdcd8: a8c567fa    	ldp	x26, x25, [sp], #0x50
101ecdcdc: 1575651e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
