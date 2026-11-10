
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565cb3c: d10203ff    	sub	sp, sp, #0x80
10565cb40: a90557f6    	stp	x22, x21, [sp, #0x50]
10565cb44: a9064ff4    	stp	x20, x19, [sp, #0x60]
10565cb48: a9077bfd    	stp	x29, x30, [sp, #0x70]
10565cb4c: 9101c3fd    	add	x29, sp, #0x70
10565cb50: aa0303f5    	mov	x21, x3
10565cb54: aa0203f3    	mov	x19, x2
10565cb58: aa0003f4    	mov	x20, x0
10565cb5c: f00d07a8    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
10565cb60: 52800029    	mov	w9, #0x1                ; =1
10565cb64: 39301509    	strb	w9, [x8, #0xc05]
10565cb68: aa0203e0    	mov	x0, x2
10565cb6c: 94972c42    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10565cb70: d2800000    	mov	x0, #0x0                ; =0
10565cb74: 52984001    	mov	w1, #0xc200             ; =49664
10565cb78: 72a17d61    	movk	w1, #0xbeb, lsl #16
10565cb7c: 94972b60    	bl	0x107c278fc <_Flutter_MMFoundation_BindContext+0x3eae5c8>
10565cb80: aa0003f6    	mov	x22, x0
10565cb84: 900c0788    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10565cb88: f9449908    	ldr	x8, [x8, #0x930]
10565cb8c: f90013e8    	str	x8, [sp, #0x20]
10565cb90: f0091348    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10565cb94: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
10565cb98: 90000008    	adrp	x8, 0x10565c000 <_Flutter_MMFoundation_BindContext+0x18e2ccc>
10565cb9c: 91320108    	add	x8, x8, #0xc80
10565cba0: fd0017e0    	str	d0, [sp, #0x28]
10565cba4: b00b6129    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
10565cba8: 91004129    	add	x9, x9, #0x10
10565cbac: a90327e8    	stp	x8, x9, [sp, #0x30]
10565cbb0: f90023f4    	str	x20, [sp, #0x40]
10565cbb4: aa1303e0    	mov	x0, x19
10565cbb8: 94972c2f    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10565cbbc: f90027f3    	str	x19, [sp, #0x48]
10565cbc0: 900c0781    	adrp	x1, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10565cbc4: f9454c21    	ldr	x1, [x1, #0xa98]
10565cbc8: 910083e2    	add	x2, sp, #0x20
10565cbcc: aa1603e0    	mov	x0, x22
10565cbd0: 9496bff5    	bl	0x107c0cba4 <_Flutter_MMFoundation_BindContext+0x3e93870>
10565cbd4: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565cbd8: f9430d16    	ldr	x22, [x8, #0x618]
10565cbdc: 900c9b88    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565cbe0: f947e501    	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
10565cbe4: aa1303e0    	mov	x0, x19
10565cbe8: 94972c1f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cbec: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565cbf0: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10565cbf4: a900d7e0    	stp	x0, x21, [sp, #0x8]
10565cbf8: 900be588    	adrp	x8, 0x11d30c000 <dyld_stub_binder+0x11d30c000>
10565cbfc: 913f6108    	add	x8, x8, #0xfd8 ; CFString: track MsgId:%u isForceStop:%d
10565cc00: f90003e8    	str	x8, [sp]
10565cc04: f00a5f45    	adrp	x5, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565cc08: 913600a5    	add	x5, x5, #0xd80
10565cc0c: f00a5f47    	adrp	x7, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565cc10: 91394ce7    	add	x7, x7, #0xe53
10565cc14: aa1603e0    	mov	x0, x22
10565cc18: 52800042    	mov	w2, #0x2                ; =2
10565cc1c: d2800003    	mov	x3, #0x0                ; =0
10565cc20: 52800004    	mov	w4, #0x0                ; =0
10565cc24: 52801d26    	mov	w6, #0xe9               ; =233
10565cc28: 94972c0f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cc2c: 370000d5    	tbnz	w21, #0x0, 0x10565cc44 <_Flutter_MMFoundation_BindContext+0x18e3910>
10565cc30: b00ca728    	adrp	x8, 0x11eb41000 <dyld_stub_binder+0x11eb41000>
10565cc34: f945cd01    	ldr	x1, [x8, #0xb98] ; selector: reportStopVoice:
10565cc38: aa1403e0    	mov	x0, x20
10565cc3c: 52800002    	mov	w2, #0x0                ; =0
10565cc40: 94972c09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cc44: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565cc48: b9880508    	ldrsw	x8, [x8, #0x804] ; ivar: PlayingController.m_bPlaying offset=8
10565cc4c: 38286a9f    	strb	wzr, [x20, x8]
10565cc50: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565cc54: b9880108    	ldrsw	x8, [x8, #0x800] ; ivar: PlayingController.m_uiMesLocalID offset=12
10565cc58: b8286a9f    	str	wzr, [x20, x8]
10565cc5c: f94027e0    	ldr	x0, [sp, #0x48]
10565cc60: 94972c04    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cc64: aa1303e0    	mov	x0, x19
10565cc68: 94972c02    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cc6c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10565cc70: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10565cc74: a94557f6    	ldp	x22, x21, [sp, #0x50]
10565cc78: 910203ff    	add	sp, sp, #0x80
10565cc7c: d65f03c0    	ret
10565cc80: d101c3ff    	sub	sp, sp, #0x70
10565cc84: a9016ffc    	stp	x28, x27, [sp, #0x10]
10565cc88: a90267fa    	stp	x26, x25, [sp, #0x20]
10565cc8c: a9035ff8    	stp	x24, x23, [sp, #0x30]
10565cc90: a90457f6    	stp	x22, x21, [sp, #0x40]
10565cc94: a9054ff4    	stp	x20, x19, [sp, #0x50]
10565cc98: a9067bfd    	stp	x29, x30, [sp, #0x60]
10565cc9c: 910183fd    	add	x29, sp, #0x60
10565cca0: aa0003f4    	mov	x20, x0
10565cca4: f9401008    	ldr	x8, [x0, #0x20]
10565cca8: 900cbb89    	adrp	x9, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565ccac: b9880529    	ldrsw	x9, [x9, #0x804] ; ivar: PlayingController.m_bPlaying offset=8
10565ccb0: 38696909    	ldrb	w9, [x8, x9]
10565ccb4: 7100053f    	cmp	w9, #0x1
10565ccb8: 54000221    	b.ne	0x10565ccfc <_Flutter_MMFoundation_BindContext+0x18e39c8>
10565ccbc: 900cbb89    	adrp	x9, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565ccc0: b9880929    	ldrsw	x9, [x9, #0x808] ; ivar: PlayingController.m_msgWrap offset=16
10565ccc4: f8696900    	ldr	x0, [x8, x9]
10565ccc8: f9401682    	ldr	x2, [x20, #0x28]
10565cccc: f00c9b88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565ccd0: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: IsSameMsg:
10565ccd4: 94972be4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ccd8: 36000120    	tbz	w0, #0x0, 0x10565ccfc <_Flutter_MMFoundation_BindContext+0x18e39c8>
10565ccdc: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10565cce0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10565cce4: a94457f6    	ldp	x22, x21, [sp, #0x40]
10565cce8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10565ccec: a94267fa    	ldp	x26, x25, [sp, #0x20]
10565ccf0: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10565ccf4: 9101c3ff    	add	sp, sp, #0x70
10565ccf8: d65f03c0    	ret
10565ccfc: f9401680    	ldr	x0, [x20, #0x28]
10565cd00: f00c9b88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565cd04: f9434901    	ldr	x1, [x8, #0x690] ; selector: GetMsgClientMsgID
10565cd08: 94972bd7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cd0c: aa1d03fd    	mov	x29, x29
10565cd10: 94972bdc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cd14: aa0003f3    	mov	x19, x0
10565cd18: d00cb5bc    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565cd1c: f943c380    	ldr	x0, [x28, #0x780]
10565cd20: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565cd24: f9440115    	ldr	x21, [x8, #0x800] ; selector: currentContext
10565cd28: aa1503e1    	mov	x1, x21
10565cd2c: 94972bce    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cd30: aa1d03fd    	mov	x29, x29
10565cd34: 94972bd3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cd38: aa0003f8    	mov	x24, x0
10565cd3c: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565cd40: f9401d00    	ldr	x0, [x8, #0x38]
10565cd44: d00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565cd48: f9428516    	ldr	x22, [x8, #0x508] ; selector: class
10565cd4c: aa1603e1    	mov	x1, x22
10565cd50: 94972bc5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cd54: aa0003e2    	mov	x2, x0
10565cd58: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565cd5c: f9452117    	ldr	x23, [x8, #0xa40] ; selector: getService:
10565cd60: aa1803e0    	mov	x0, x24
10565cd64: aa1703e1    	mov	x1, x23
10565cd68: 94972bbf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cd6c: aa1d03fd    	mov	x29, x29
10565cd70: 94972bc4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cd74: aa0003f9    	mov	x25, x0
10565cd78: f943c380    	ldr	x0, [x28, #0x780]
10565cd7c: aa1503e1    	mov	x1, x21
10565cd80: 94972bb9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cd84: aa1d03fd    	mov	x29, x29
10565cd88: 94972bbe    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cd8c: aa0003fa    	mov	x26, x0
10565cd90: b00cb5c8    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10565cd94: f940fd00    	ldr	x0, [x8, #0x1f8]
10565cd98: aa1603e1    	mov	x1, x22
10565cd9c: 94972bb2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cda0: aa0003e2    	mov	x2, x0
10565cda4: aa1a03e0    	mov	x0, x26
10565cda8: aa1703e1    	mov	x1, x23
10565cdac: 94972bae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cdb0: aa1d03fd    	mov	x29, x29
10565cdb4: 94972bb3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cdb8: aa0003fb    	mov	x27, x0
10565cdbc: 900c9e48    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
10565cdc0: f9430101    	ldr	x1, [x8, #0x600] ; selector: setActive:scene:identifier:listener:
10565cdc4: aa1903e0    	mov	x0, x25
10565cdc8: 52800002    	mov	w2, #0x0                ; =0
10565cdcc: 52800003    	mov	w3, #0x0                ; =0
10565cdd0: aa1303e4    	mov	x4, x19
10565cdd4: aa1b03e5    	mov	x5, x27
10565cdd8: 94972ba3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cddc: aa1b03e0    	mov	x0, x27
10565cde0: 94972ba4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cde4: aa1a03e0    	mov	x0, x26
10565cde8: 94972ba2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cdec: aa1903e0    	mov	x0, x25
10565cdf0: 94972ba0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cdf4: aa1803e0    	mov	x0, x24
10565cdf8: 94972b9e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cdfc: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565ce00: f9446500    	ldr	x0, [x8, #0x8c8]
10565ce04: 900cb268    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10565ce08: f9455d01    	ldr	x1, [x8, #0xab8] ; selector: isiPad
10565ce0c: 94972b96    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ce10: 340005e0    	cbz	w0, 0x10565cecc <_Flutter_MMFoundation_BindContext+0x18e3b98>
10565ce14: f943c380    	ldr	x0, [x28, #0x780]
10565ce18: aa1503e1    	mov	x1, x21
10565ce1c: 94972b92    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ce20: aa1d03fd    	mov	x29, x29
10565ce24: 94972b97    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565ce28: aa0003f5    	mov	x21, x0
10565ce2c: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565ce30: f940b900    	ldr	x0, [x8, #0x170]
10565ce34: aa1603e1    	mov	x1, x22
10565ce38: 94972b8b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ce3c: aa0003e2    	mov	x2, x0
10565ce40: aa1503e0    	mov	x0, x21
10565ce44: aa1703e1    	mov	x1, x23
10565ce48: 94972b87    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ce4c: aa1d03fd    	mov	x29, x29
10565ce50: 94972b8c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565ce54: aa0003f6    	mov	x22, x0
10565ce58: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565ce5c: f9431d17    	ldr	x23, [x8, #0x638]
10565ce60: f9401680    	ldr	x0, [x20, #0x28]
10565ce64: 900c9b88    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565ce68: f947e501    	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
10565ce6c: 94972b7e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ce70: b00cb288    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10565ce74: f942e501    	ldr	x1, [x8, #0x5c8] ; selector: stringWithFormat:
10565ce78: f90003e0    	str	x0, [sp]
10565ce7c: d00bca22    	adrp	x2, 0x11cfa2000 <dyld_stub_binder+0x11cfa2000>
10565ce80: 912be042    	add	x2, x2, #0xaf8 ; CFString: %u
10565ce84: aa1703e0    	mov	x0, x23
10565ce88: 94972b77    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ce8c: aa1d03fd    	mov	x29, x29
10565ce90: 94972b7c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565ce94: aa0003f4    	mov	x20, x0
10565ce98: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565ce9c: f947dd01    	ldr	x1, [x8, #0xfb8] ; selector: removeAudioMonoServiceBusiness:subBusiness:serviceId:
10565cea0: aa1603e0    	mov	x0, x22
10565cea4: 528000c2    	mov	w2, #0x6                ; =6
10565cea8: d2800003    	mov	x3, #0x0                ; =0
10565ceac: aa1403e4    	mov	x4, x20
10565ceb0: 94972b6d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565ceb4: aa1403e0    	mov	x0, x20
10565ceb8: 94972b6e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cebc: aa1603e0    	mov	x0, x22
10565cec0: 94972b6c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cec4: aa1503e0    	mov	x0, x21
10565cec8: 94972b6a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cecc: aa1303e0    	mov	x0, x19
10565ced0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10565ced4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10565ced8: a94457f6    	ldp	x22, x21, [sp, #0x40]
10565cedc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10565cee0: a94267fa    	ldp	x26, x25, [sp, #0x20]
10565cee4: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10565cee8: 9101c3ff    	add	sp, sp, #0x70
10565ceec: 14972b61    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
