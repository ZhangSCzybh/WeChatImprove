
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1058f85b4: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1058f85b8: a90167fa    	stp	x26, x25, [sp, #0x10]
1058f85bc: a9025ff8    	stp	x24, x23, [sp, #0x20]
1058f85c0: a90357f6    	stp	x22, x21, [sp, #0x30]
1058f85c4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1058f85c8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1058f85cc: 910143fd    	add	x29, sp, #0x50
1058f85d0: aa0003f3    	mov	x19, x0
1058f85d4: b00d9a48    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1058f85d8: 52800029    	mov	w9, #0x1                ; =1
1058f85dc: 39230509    	strb	w9, [x8, #0x8c1]
1058f85e0: f00d43c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1058f85e4: f9455500    	ldr	x0, [x8, #0xaa8]
1058f85e8: f00d4028    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1058f85ec: f941a101    	ldr	x1, [x8, #0x340] ; array
1058f85f0: 948cbad3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f85f4: aa1d03fd    	mov	x29, x29
1058f85f8: 948cbad4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f85fc: aa0003f4    	mov	x20, x0
1058f8600: d00d2a28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1058f8604: f9410919    	ldr	x25, [x8, #0x210] ; viewModel
1058f8608: aa1303e0    	mov	x0, x19
1058f860c: aa1903e1    	mov	x1, x25
1058f8610: 948cbacb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8614: aa1d03fd    	mov	x29, x29
1058f8618: 948cbacc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f861c: aa0003f5    	mov	x21, x0
1058f8620: d00d3548    	adrp	x8, 0x11ffa2000 <dyld_stub_binder+0x11ffa2000>
1058f8624: f9455501    	ldr	x1, [x8, #0xaa8] ; sharedContact
1058f8628: 948cbac5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f862c: aa1d03fd    	mov	x29, x29
1058f8630: 948cbac6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f8634: aa0003f6    	mov	x22, x0
1058f8638: f00d2a08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1058f863c: f947b501    	ldr	x1, [x8, #0xf68] ; isBrandContact
1058f8640: 948cbabf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8644: 37000300    	tbnz	w0, #0x0, 0x1058f86a4 <_Flutter_MMFoundation_BindContext+0x1dd4288>
1058f8648: aa1303e0    	mov	x0, x19
1058f864c: aa1903e1    	mov	x1, x25
1058f8650: 948cbabb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8654: aa1d03fd    	mov	x29, x29
1058f8658: 948cbabc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f865c: aa0003f7    	mov	x23, x0
1058f8660: d00d2a28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1058f8664: f941051a    	ldr	x26, [x8, #0x208] ; messageWrap
1058f8668: aa1a03e1    	mov	x1, x26
1058f866c: 948cbab4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8670: aa1d03fd    	mov	x29, x29
1058f8674: 948cbab5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f8678: aa0003f8    	mov	x24, x0
1058f867c: d00d2a28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1058f8680: f9413d1b    	ldr	x27, [x8, #0x278] ; m_uiMessageType
1058f8684: aa1b03e1    	mov	x1, x27
1058f8688: 948cbaad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f868c: 71010c1f    	cmp	w0, #0x43
1058f8690: 54000481    	b.ne	0x1058f8720 <_Flutter_MMFoundation_BindContext+0x1dd4304>
1058f8694: aa1803e0    	mov	x0, x24
1058f8698: 948cbaaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f869c: aa1703e0    	mov	x0, x23
1058f86a0: 948cbaad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f86a4: aa1603e0    	mov	x0, x22
1058f86a8: 948cbaab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f86ac: aa1503e0    	mov	x0, x21
1058f86b0: 948cbaa9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f86b4: d00d2a28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1058f86b8: f9415101    	ldr	x1, [x8, #0x2a0] ; forwardMenuItem
1058f86bc: aa1303e0    	mov	x0, x19
1058f86c0: 948cba9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f86c4: aa1d03fd    	mov	x29, x29
1058f86c8: 948cbaa0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f86cc: aa0003f5    	mov	x21, x0
1058f86d0: d00d2a08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1058f86d4: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1058f86d8: aa1403e0    	mov	x0, x20
1058f86dc: aa1503e2    	mov	x2, x21
1058f86e0: 948cba97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f86e4: aa1503e0    	mov	x0, x21
1058f86e8: 948cba9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f86ec: d00d2a28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1058f86f0: f9415501    	ldr	x1, [x8, #0x2a8] ; addRevokeOrDeleteMenuItem:
1058f86f4: aa1303e0    	mov	x0, x19
1058f86f8: aa1403e2    	mov	x2, x20
1058f86fc: 948cba90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8700: aa1403e0    	mov	x0, x20
1058f8704: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1058f8708: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1058f870c: a94357f6    	ldp	x22, x21, [sp, #0x30]
1058f8710: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1058f8714: a94167fa    	ldp	x26, x25, [sp, #0x10]
1058f8718: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1058f871c: 148cba95    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
1058f8720: aa1303e0    	mov	x0, x19
1058f8724: aa1903e1    	mov	x1, x25
1058f8728: 948cba85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f872c: aa1d03fd    	mov	x29, x29
1058f8730: 948cba86    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f8734: aa0003f9    	mov	x25, x0
1058f8738: aa1a03e1    	mov	x1, x26
1058f873c: 948cba80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8740: aa1d03fd    	mov	x29, x29
1058f8744: 948cba81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1058f8748: aa0003fa    	mov	x26, x0
1058f874c: aa1b03e1    	mov	x1, x27
1058f8750: 948cba7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f8754: 7100a81f    	cmp	w0, #0x2a
1058f8758: 54000281    	b.ne	0x1058f87a8 <_Flutter_MMFoundation_BindContext+0x1dd438c>
1058f875c: d00d3548    	adrp	x8, 0x11ffa2000 <dyld_stub_binder+0x11ffa2000>
1058f8760: f9456101    	ldr	x1, [x8, #0xac0] ; isOpenIMChat
1058f8764: aa1303e0    	mov	x0, x19
1058f8768: 948cba75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1058f876c: aa0003fb    	mov	x27, x0
1058f8770: aa1a03e0    	mov	x0, x26
1058f8774: 948cba78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f8778: aa1903e0    	mov	x0, x25
1058f877c: 948cba76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f8780: aa1803e0    	mov	x0, x24
1058f8784: 948cba74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f8788: aa1703e0    	mov	x0, x23
1058f878c: 948cba72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f8790: aa1603e0    	mov	x0, x22
1058f8794: 948cba70    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f8798: aa1503e0    	mov	x0, x21
1058f879c: 948cba6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f87a0: 3607f8bb    	tbz	w27, #0x0, 0x1058f86b4 <_Flutter_MMFoundation_BindContext+0x1dd4298>
1058f87a4: 17ffffd2    	b	0x1058f86ec <_Flutter_MMFoundation_BindContext+0x1dd42d0>
1058f87a8: aa1a03e0    	mov	x0, x26
1058f87ac: 948cba6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f87b0: aa1903e0    	mov	x0, x25
1058f87b4: 948cba68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f87b8: aa1803e0    	mov	x0, x24
1058f87bc: 948cba66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f87c0: aa1703e0    	mov	x0, x23
1058f87c4: 948cba64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f87c8: aa1603e0    	mov	x0, x22
1058f87cc: 948cba62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1058f87d0: 17ffffc5    	b	0x1058f86e4 <_Flutter_MMFoundation_BindContext+0x1dd42c8>