
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10658b1a4: d10143ff    	sub	sp, sp, #0x50
10658b1a8: a9015ff8    	stp	x24, x23, [sp, #0x10]
10658b1ac: a90257f6    	stp	x22, x21, [sp, #0x20]
10658b1b0: a9034ff4    	stp	x20, x19, [sp, #0x30]
10658b1b4: a9047bfd    	stp	x29, x30, [sp, #0x40]
10658b1b8: 910103fd    	add	x29, sp, #0x40
10658b1bc: aa0003f3    	mov	x19, x0
10658b1c0: 900c8e68    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
10658b1c4: 52800029    	mov	w9, #0x1                ; =1
10658b1c8: 3908e509    	strb	w9, [x8, #0x239]
10658b1cc: f00c2208    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10658b1d0: f941bd14    	ldr	x20, [x8, #0x378] ; selector: messageWrap
10658b1d4: aa1403e1    	mov	x1, x20
10658b1d8: 945a72a3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b1dc: aa1d03fd    	mov	x29, x29
10658b1e0: 945a72a8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b1e4: aa0003f5    	mov	x21, x0
10658b1e8: 900c2248    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10658b1ec: f9454d01    	ldr	x1, [x8, #0xa98] ; selector: m_uiVoiceTime
10658b1f0: 945a729d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b1f4: aa0003f6    	mov	x22, x0
10658b1f8: aa1503e0    	mov	x0, x21
10658b1fc: 945a729d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b200: 53037ec8    	lsr	w8, w22, #3
10658b204: 7109c51f    	cmp	w8, #0x271
10658b208: 540003e3    	b.lo	0x10658b284 <_Flutter_MMFoundation_BindContext+0x2811f50>
10658b20c: f00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b210: f943c100    	ldr	x0, [x8, #0x780]
10658b214: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b218: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10658b21c: 945a7292    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b220: aa1d03fd    	mov	x29, x29
10658b224: 945a7297    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b228: aa0003f5    	mov	x21, x0
10658b22c: d00c3c48    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10658b230: f940fd00    	ldr	x0, [x8, #0x1f8]
10658b234: f00c38c8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10658b238: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10658b23c: 945a728a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b240: aa0003e2    	mov	x2, x0
10658b244: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b248: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10658b24c: aa1503e0    	mov	x0, x21
10658b250: 945a7285    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b254: aa1d03fd    	mov	x29, x29
10658b258: 945a728a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b25c: aa0003f6    	mov	x22, x0
10658b260: d00c2d08    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
10658b264: f9462501    	ldr	x1, [x8, #0xc48] ; selector: isShowingMinimizeView
10658b268: 945a727f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b26c: aa0003f7    	mov	x23, x0
10658b270: aa1603e0    	mov	x0, x22
10658b274: 945a727f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b278: aa1503e0    	mov	x0, x21
10658b27c: 945a727d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b280: 36000077    	tbz	w23, #0x0, 0x10658b28c <_Flutter_MMFoundation_BindContext+0x2811f58>
10658b284: 52800000    	mov	w0, #0x0                ; =0
10658b288: 1400003a    	b	0x10658b370 <_Flutter_MMFoundation_BindContext+0x281203c>
10658b28c: f00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b290: f9470915    	ldr	x21, [x8, #0xe10]
10658b294: aa1303e0    	mov	x0, x19
10658b298: aa1403e1    	mov	x1, x20
10658b29c: 945a7272    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b2a0: aa1d03fd    	mov	x29, x29
10658b2a4: 945a7277    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b2a8: aa0003f6    	mov	x22, x0
10658b2ac: f00c2208    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10658b2b0: f9402501    	ldr	x1, [x8, #0x48] ; selector: isSenderFromMsgWrap:
10658b2b4: aa1503e0    	mov	x0, x21
10658b2b8: aa1603e2    	mov	x2, x22
10658b2bc: 945a726a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b2c0: aa0003f5    	mov	x21, x0
10658b2c4: aa1603e0    	mov	x0, x22
10658b2c8: 945a726a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b2cc: 37000515    	tbnz	w21, #0x0, 0x10658b36c <_Flutter_MMFoundation_BindContext+0x2812038>
10658b2d0: f00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658b2d4: b98d1508    	ldrsw	x8, [x8, #0xd14] ; ivar: VoiceMessageViewModel.m_startPlayCount offset=116
10658b2d8: b8686a68    	ldr	w8, [x19, x8]
10658b2dc: 7100051f    	cmp	w8, #0x1
10658b2e0: 54000461    	b.ne	0x10658b36c <_Flutter_MMFoundation_BindContext+0x2812038>
10658b2e4: f00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658b2e8: b98d1108    	ldrsw	x8, [x8, #0xd10] ; ivar: VoiceMessageViewModel.m_isLastStatusUnPlay offset=112
10658b2ec: 38686a68    	ldrb	w8, [x19, x8]
10658b2f0: 7100051f    	cmp	w8, #0x1
10658b2f4: 540003c1    	b.ne	0x10658b36c <_Flutter_MMFoundation_BindContext+0x2812038>
10658b2f8: f00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658b2fc: f9430d15    	ldr	x21, [x8, #0x618]
10658b300: aa1303e0    	mov	x0, x19
10658b304: aa1403e1    	mov	x1, x20
10658b308: 945a7257    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b30c: aa1d03fd    	mov	x29, x29
10658b310: 945a725c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658b314: aa0003f3    	mov	x19, x0
10658b318: b00c2208    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10658b31c: f947e501    	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
10658b320: 945a7251    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b324: d00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658b328: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10658b32c: 900b7088    	adrp	x8, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
10658b330: 9138e108    	add	x8, x8, #0xe38 ; CFString: first play %u
10658b334: a90003e8    	stp	x8, x0, [sp]
10658b338: d009eee5    	adrp	x5, 0x11a369000 <dyld_stub_binder+0x11a369000>
10658b33c: 911fb4a5    	add	x5, x5, #0x7ed
10658b340: d009eee7    	adrp	x7, 0x11a369000 <dyld_stub_binder+0x11a369000>
10658b344: 9121e4e7    	add	x7, x7, #0x879
10658b348: aa1503e0    	mov	x0, x21
10658b34c: 52800042    	mov	w2, #0x2                ; =2
10658b350: d2800003    	mov	x3, #0x0                ; =0
10658b354: 52800004    	mov	w4, #0x0                ; =0
10658b358: 52803586    	mov	w6, #0x1ac              ; =428
10658b35c: 945a7242    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658b360: aa1303e0    	mov	x0, x19
10658b364: 945a7243    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658b368: 17ffffc7    	b	0x10658b284 <_Flutter_MMFoundation_BindContext+0x2811f50>
10658b36c: 52800020    	mov	w0, #0x1                ; =1
10658b370: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10658b374: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10658b378: a94257f6    	ldp	x22, x21, [sp, #0x20]
10658b37c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10658b380: 910143ff    	add	sp, sp, #0x50
10658b384: d65f03c0    	ret
