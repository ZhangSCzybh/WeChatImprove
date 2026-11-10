
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a9544: f00fa4a8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002a9548: 52800029    	mov	w9, #0x1                ; =1
1002a954c: 3923bd09    	strb	w9, [x8, #0x8ef]
1002a9550: f9401808    	ldr	x8, [x0, #0x30]
1002a9554: f100091f    	cmp	x8, #0x2
1002a9558: 54000a01    	b.ne	0x1002a9698 <__text+0x2a1698>
1002a955c: d10203ff    	sub	sp, sp, #0x80
1002a9560: a90557f6    	stp	x22, x21, [sp, #0x50]
1002a9564: a9064ff4    	stp	x20, x19, [sp, #0x60]
1002a9568: a9077bfd    	stp	x29, x30, [sp, #0x70]
1002a956c: 9101c3fd    	add	x29, sp, #0x70
1002a9570: aa0003f3    	mov	x19, x0
1002a9574: f9400408    	ldr	x8, [x0, #0x8]
1002a9578: f9401d00    	ldr	x0, [x8, #0x38]
1002a957c: b4000860    	cbz	x0, 0x1002a9688 <__text+0x2a1688>
1002a9580: d2800001    	mov	x1, #0x0                ; =0
1002a9584: 95e5f371    	bl	0x107c26348 <_Flutter_MMFoundation_BindContext+0x3ead014>
1002a9588: 340002e0    	cbz	w0, 0x1002a95e4 <__text+0x2a15e4>
1002a958c: aa0003f4    	mov	x20, x0
1002a9590: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9594: f9430d15    	ldr	x21, [x8, #0x618]
1002a9598: 95e58d4c    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a959c: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a95a0: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1002a95a4: 900cc8c8    	adrp	x8, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a95a8: 9128f908    	add	x8, x8, #0xa3e
1002a95ac: a90123f4    	stp	x20, x8, [sp, #0x10]
1002a95b0: f00e6788    	adrp	x8, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a95b4: 910ce108    	add	x8, x8, #0x338 ; CFString: throw %s,%d: %s
1002a95b8: a90003e8    	stp	x8, x0, [sp]
1002a95bc: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a95c0: 9120a4a5    	add	x5, x5, #0x829
1002a95c4: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a95c8: 912e2ce7    	add	x7, x7, #0xb8b
1002a95cc: aa1503e0    	mov	x0, x21
1002a95d0: 52800082    	mov	w2, #0x4                ; =4
1002a95d4: d2800003    	mov	x3, #0x0                ; =0
1002a95d8: 52800004    	mov	w4, #0x0                ; =0
1002a95dc: 52803b06    	mov	w6, #0x1d8              ; =472
1002a95e0: 95e5f9a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a95e4: f00f5008    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1002a95e8: f944c101    	ldr	x1, [x8, #0x980] ; selector: setState:
1002a95ec: aa1303e0    	mov	x0, x19
1002a95f0: 52800022    	mov	w2, #0x1                ; =1
1002a95f4: 95e5f99c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a95f8: d100a3a0    	sub	x0, x29, #0x28
1002a95fc: aa1303e1    	mov	x1, x19
1002a9600: 95e5f996    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
1002a9604: f00ea508    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a9608: f9449908    	ldr	x8, [x8, #0x930]
1002a960c: f90013e8    	str	x8, [sp, #0x20]
1002a9610: d00bb0e8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1002a9614: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
1002a9618: 90000008    	adrp	x8, 0x1002a9000 <__text+0x2a1000>
1002a961c: 911a7108    	add	x8, x8, #0x69c
1002a9620: fd0017e0    	str	d0, [sp, #0x28]
1002a9624: f00dfea9    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
1002a9628: 91110129    	add	x9, x9, #0x440
1002a962c: a90327e8    	stp	x8, x9, [sp, #0x30]
1002a9630: 910083f3    	add	x19, sp, #0x20
1002a9634: 91008260    	add	x0, x19, #0x20
1002a9638: d100a3a1    	sub	x1, x29, #0x28
1002a963c: 95e5f97d    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
1002a9640: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9644: f9447d00    	ldr	x0, [x8, #0x8f8]
1002a9648: f00f4fe8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002a964c: f9446501    	ldr	x1, [x8, #0x8c8] ; selector: isMainThread
1002a9650: 95e5f985    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9654: 340000a0    	cbz	w0, 0x1002a9668 <__text+0x2a1668>
1002a9658: f9401be8    	ldr	x8, [sp, #0x30]
1002a965c: 910083e0    	add	x0, sp, #0x20
1002a9660: d63f0100    	blr	x8
1002a9664: 14000005    	b	0x1002a9678 <__text+0x2a1678>
1002a9668: f00ea500    	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a966c: f9454c00    	ldr	x0, [x0, #0xa98]
1002a9670: 910083e1    	add	x1, sp, #0x20
1002a9674: 95e58d4a    	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
1002a9678: 91008260    	add	x0, x19, #0x20
1002a967c: 95e5f96e    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1002a9680: d100a3a0    	sub	x0, x29, #0x28
1002a9684: 95e5f96c    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
1002a9688: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1002a968c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1002a9690: a94557f6    	ldp	x22, x21, [sp, #0x50]
1002a9694: 910203ff    	add	sp, sp, #0x80
1002a9698: d65f03c0    	ret
1002a969c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1002a96a0: a90157f6    	stp	x22, x21, [sp, #0x10]
1002a96a4: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002a96a8: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002a96ac: 9100c3fd    	add	x29, sp, #0x30
1002a96b0: 91008000    	add	x0, x0, #0x20
1002a96b4: 95e5f96a    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a96b8: aa0003f3    	mov	x19, x0
1002a96bc: b40003e0    	cbz	x0, 0x1002a9738 <__text+0x2a1738>
1002a96c0: f9400668    	ldr	x8, [x19, #0x8]
1002a96c4: 9103e100    	add	x0, x8, #0xf8
1002a96c8: 95e5f965    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a96cc: b4000360    	cbz	x0, 0x1002a9738 <__text+0x2a1738>
1002a96d0: aa0003f5    	mov	x21, x0
1002a96d4: f9400668    	ldr	x8, [x19, #0x8]
1002a96d8: 9103e100    	add	x0, x8, #0xf8
1002a96dc: 95e5f960    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a96e0: aa0003f6    	mov	x22, x0
1002a96e4: d00f3948    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1002a96e8: f944c914    	ldr	x20, [x8, #0x990] ; selector: audioPlayerDidStartPlaying:
1002a96ec: b00f5008    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1002a96f0: f9440501    	ldr	x1, [x8, #0x808] ; selector: respondsToSelector:
1002a96f4: aa1403e2    	mov	x2, x20
1002a96f8: 95e5f95b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a96fc: aa0003f7    	mov	x23, x0
1002a9700: aa1603e0    	mov	x0, x22
1002a9704: 95e5f95b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9708: aa1503e0    	mov	x0, x21
1002a970c: 95e5f959    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9710: 34000157    	cbz	w23, 0x1002a9738 <__text+0x2a1738>
1002a9714: f9400668    	ldr	x8, [x19, #0x8]
1002a9718: 9103e100    	add	x0, x8, #0xf8
1002a971c: 95e5f950    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a9720: aa0003f5    	mov	x21, x0
1002a9724: aa1403e1    	mov	x1, x20
1002a9728: aa1303e2    	mov	x2, x19
1002a972c: 95e5f94e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9730: aa1503e0    	mov	x0, x21
1002a9734: 95e5f94f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9738: aa1303e0    	mov	x0, x19
1002a973c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002a9740: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002a9744: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002a9748: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1002a974c: 15e5f949    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
