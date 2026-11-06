
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101037ec0: d10183ff    	sub	sp, sp, #0x60
101037ec4: a90167fa    	stp	x26, x25, [sp, #0x10]
101037ec8: a9025ff8    	stp	x24, x23, [sp, #0x20]
101037ecc: a90357f6    	stp	x22, x21, [sp, #0x30]
101037ed0: a9044ff4    	stp	x20, x19, [sp, #0x40]
101037ed4: a9057bfd    	stp	x29, x30, [sp, #0x50]
101037ed8: 910143fd    	add	x29, sp, #0x50
101037edc: aa0003f3    	mov	x19, x0
101037ee0: 900f3868    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
101037ee4: 52800029    	mov	w9, #0x1                ; =1
101037ee8: 39277d09    	strb	w9, [x8, #0x9df]
101037eec: d00ee908    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
101037ef0: f947e108    	ldr	x8, [x8, #0xfc0]
101037ef4: a90023e0    	stp	x0, x8, [sp]
101037ef8: f00ecca8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101037efc: f941ed01    	ldr	x1, [x8, #0x3d8] ; selector: onAppear
101037f00: 910003e0    	mov	x0, sp
101037f04: 95afbf59    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
101037f08: f00ee6e8    	adrp	x8, 0x11ed16000 <dyld_stub_binder+0x11ed16000>
101037f0c: f9458116    	ldr	x22, [x8, #0xb00]
101037f10: f00ecca8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101037f14: f941c114    	ldr	x20, [x8, #0x380] ; selector: viewModel
101037f18: aa1303e0    	mov	x0, x19
101037f1c: aa1403e1    	mov	x1, x20
101037f20: 95afbf51    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101037f24: aa1d03fd    	mov	x29, x29
101037f28: 95afbf56    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101037f2c: aa0003f7    	mov	x23, x0
101037f30: d00ecc88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101037f34: f9451901    	ldr	x1, [x8, #0xa30] ; selector: contact
101037f38: 95afbf4b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101037f3c: aa1d03fd    	mov	x29, x29
101037f40: 95afbf50    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101037f44: aa0003f8    	mov	x24, x0
101037f48: aa1303e0    	mov	x0, x19
101037f4c: aa1403e1    	mov	x1, x20
101037f50: 95afbf45    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101037f54: aa1d03fd    	mov	x29, x29
101037f58: 95afbf4a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101037f5c: aa0003f9    	mov	x25, x0
101037f60: f00ecca8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101037f64: f941bd15    	ldr	x21, [x8, #0x378] ; selector: messageWrap
101037f68: aa1503e1    	mov	x1, x21
101037f6c: 95afbf3e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101037f70: aa1d03fd    	mov	x29, x29
101037f74: 95afbf43    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101037f78: aa0003fa    	mov	x26, x0
101037f7c: f00ecd88    	adrp	x8, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
101037f80: f9474101    	ldr	x1, [x8, #0xe80] ; selector: canJumpWhenClickKFWorkerAvatar:messageWrap:
101037f84: aa1603e0    	mov	x0, x22
101037f88: aa1803e2    	mov	x2, x24
101037f8c: aa1a03e3    	mov	x3, x26
101037f90: 95afbf35    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101037f94: aa0003f6    	mov	x22, x0
101037f98: aa1a03e0    	mov	x0, x26
101037f9c: 95afbf35    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101037fa0: aa1903e0    	mov	x0, x25
101037fa4: 95afbf33    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101037fa8: aa1803e0    	mov	x0, x24
101037fac: 95afbf31    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101037fb0: aa1703e0    	mov	x0, x23
101037fb4: 95afbf2f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101037fb8: 340005f6    	cbz	w22, 0x101038074 <__text+0x1030074>
101037fbc: f00eea28    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
101037fc0: 912b9108    	add	x8, x8, #0xae4
101037fc4: b980011a    	ldrsw	x26, [x8] ; ivar: BaseChatCellView.m_delegate offset=8
101037fc8: 8b1a0260    	add	x0, x19, x26
101037fcc: 95afbf24    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101037fd0: b4000520    	cbz	x0, 0x101038074 <__text+0x1030074>
101037fd4: aa0003f7    	mov	x23, x0
101037fd8: 8b1a0260    	add	x0, x19, x26
101037fdc: 95afbf20    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
101037fe0: aa0003f8    	mov	x24, x0
101037fe4: f00ecd28    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
101037fe8: f942e516    	ldr	x22, [x8, #0x5c8] ; selector: onKFWorkerMsgDisplay:
101037fec: f00ee388    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101037ff0: f9440501    	ldr	x1, [x8, #0x808] ; selector: respondsToSelector:
101037ff4: aa1603e2    	mov	x2, x22
101037ff8: 95afbf1b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101037ffc: aa0003f9    	mov	x25, x0
101038000: aa1803e0    	mov	x0, x24
101038004: 95afbf1b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038008: aa1703e0    	mov	x0, x23
10103800c: 95afbf19    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038010: 34000339    	cbz	w25, 0x101038074 <__text+0x1030074>
101038014: 8b1a0260    	add	x0, x19, x26
101038018: 95afbf11    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10103801c: aa0003f7    	mov	x23, x0
101038020: aa1303e0    	mov	x0, x19
101038024: aa1403e1    	mov	x1, x20
101038028: 95afbf0f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103802c: aa1d03fd    	mov	x29, x29
101038030: 95afbf14    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101038034: aa0003f8    	mov	x24, x0
101038038: aa1503e1    	mov	x1, x21
10103803c: 95afbf0a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038040: aa1d03fd    	mov	x29, x29
101038044: 95afbf0f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101038048: aa0003f9    	mov	x25, x0
10103804c: aa1703e0    	mov	x0, x23
101038050: aa1603e1    	mov	x1, x22
101038054: aa1903e2    	mov	x2, x25
101038058: 95afbf03    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103805c: aa1903e0    	mov	x0, x25
101038060: 95afbf04    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038064: aa1803e0    	mov	x0, x24
101038068: 95afbf02    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103806c: aa1703e0    	mov	x0, x23
101038070: 95afbf00    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038074: aa1303e0    	mov	x0, x19
101038078: aa1403e1    	mov	x1, x20
10103807c: 95afbefa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038080: aa1d03fd    	mov	x29, x29
101038084: 95afbeff    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101038088: aa0003f6    	mov	x22, x0
10103808c: aa1503e1    	mov	x1, x21
101038090: 95afbef5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101038094: aa1d03fd    	mov	x29, x29
101038098: 95afbefa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103809c: aa0003f7    	mov	x23, x0
1010380a0: f00ecd08    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1010380a4: f943b501    	ldr	x1, [x8, #0x768] ; selector: IsInviteShareMessage
1010380a8: 95afbeef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010380ac: aa0003f8    	mov	x24, x0
1010380b0: aa1703e0    	mov	x0, x23
1010380b4: 95afbeef    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010380b8: aa1603e0    	mov	x0, x22
1010380bc: 95afbeed    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010380c0: 340002f8    	cbz	w24, 0x10103811c <__text+0x103011c>
1010380c4: d00ee6c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010380c8: f9472916    	ldr	x22, [x8, #0xe50]
1010380cc: aa1303e0    	mov	x0, x19
1010380d0: aa1403e1    	mov	x1, x20
1010380d4: 95afbee4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010380d8: aa1d03fd    	mov	x29, x29
1010380dc: 95afbee9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010380e0: aa0003f3    	mov	x19, x0
1010380e4: aa1503e1    	mov	x1, x21
1010380e8: 95afbedf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010380ec: aa1d03fd    	mov	x29, x29
1010380f0: 95afbee4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010380f4: aa0003f4    	mov	x20, x0
1010380f8: b00ecf08    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
1010380fc: f946c901    	ldr	x1, [x8, #0xd90] ; selector: reportWhenShowHistoryMsg:
101038100: aa1603e0    	mov	x0, x22
101038104: aa1403e2    	mov	x2, x20
101038108: 95afbed7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103810c: aa1403e0    	mov	x0, x20
101038110: 95afbed8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101038114: aa1303e0    	mov	x0, x19
101038118: 95afbed6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103811c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101038120: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101038124: a94357f6    	ldp	x22, x21, [sp, #0x30]
101038128: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10103812c: a94167fa    	ldp	x26, x25, [sp, #0x10]
101038130: 910183ff    	add	sp, sp, #0x60
101038134: d65f03c0    	ret
