
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101034d7c: d10203ff    	sub	sp, sp, #0x80
101034d80: 6d0123e9    	stp	d9, d8, [sp, #0x10]
101034d84: a9026ffc    	stp	x28, x27, [sp, #0x20]
101034d88: a90367fa    	stp	x26, x25, [sp, #0x30]
101034d8c: a9045ff8    	stp	x24, x23, [sp, #0x40]
101034d90: a90557f6    	stp	x22, x21, [sp, #0x50]
101034d94: a9064ff4    	stp	x20, x19, [sp, #0x60]
101034d98: a9077bfd    	stp	x29, x30, [sp, #0x70]
101034d9c: 9101c3fd    	add	x29, sp, #0x70
101034da0: aa0003f3    	mov	x19, x0
101034da4: f00f3868    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
101034da8: 52800029    	mov	w9, #0x1                ; =1
101034dac: 39275d09    	strb	w9, [x8, #0x9d7]
101034db0: b00ee928    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
101034db4: f947e108    	ldr	x8, [x8, #0xfc0]
101034db8: a90023e0    	stp	x0, x8, [sp]
101034dbc: 900ecce8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
101034dc0: f9407d01    	ldr	x1, [x8, #0xf8] ; selector: setViewModel:
101034dc4: 910003e0    	mov	x0, sp
101034dc8: 95afcba8    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
101034dcc: d00eccc8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
101034dd0: f941c114    	ldr	x20, [x8, #0x380] ; selector: viewModel
101034dd4: aa1303e0    	mov	x0, x19
101034dd8: aa1403e1    	mov	x1, x20
101034ddc: 95afcba2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034de0: aa1d03fd    	mov	x29, x29
101034de4: 95afcba7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034de8: b4001300    	cbz	x0, 0x101035048 <__text+0x102d048>
101034dec: aa0003f5    	mov	x21, x0
101034df0: aa1303e0    	mov	x0, x19
101034df4: aa1403e1    	mov	x1, x20
101034df8: 95afcb9b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034dfc: aa1d03fd    	mov	x29, x29
101034e00: 95afcba0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034e04: aa0003f7    	mov	x23, x0
101034e08: b00ecca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101034e0c: f9451916    	ldr	x22, [x8, #0xa30] ; selector: contact
101034e10: aa1603e1    	mov	x1, x22
101034e14: 95afcb94    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034e18: aa1d03fd    	mov	x29, x29
101034e1c: 95afcb99    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034e20: aa0003f8    	mov	x24, x0
101034e24: 95afcb93    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034e28: aa1703e0    	mov	x0, x23
101034e2c: 95afcb91    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034e30: aa1503e0    	mov	x0, x21
101034e34: 95afcb8f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034e38: b4001098    	cbz	x24, 0x101035048 <__text+0x102d048>
101034e3c: aa1303e0    	mov	x0, x19
101034e40: aa1403e1    	mov	x1, x20
101034e44: 95afcb88    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034e48: aa1d03fd    	mov	x29, x29
101034e4c: 95afcb8d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034e50: aa0003f7    	mov	x23, x0
101034e54: aa1603e1    	mov	x1, x22
101034e58: 95afcb83    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034e5c: aa1d03fd    	mov	x29, x29
101034e60: 95afcb88    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034e64: aa0003f8    	mov	x24, x0
101034e68: f00ecca8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
101034e6c: f9431101    	ldr	x1, [x8, #0x620] ; selector: m_nsUsrName
101034e70: 95afcb7d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034e74: aa1d03fd    	mov	x29, x29
101034e78: 95afcb82    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034e7c: aa0003f5    	mov	x21, x0
101034e80: aa1803e0    	mov	x0, x24
101034e84: 95afcb7b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034e88: aa1703e0    	mov	x0, x23
101034e8c: 95afcb79    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034e90: d00ee6fb    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101034e94: f943c360    	ldr	x0, [x27, #0x780]
101034e98: b00ecca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101034e9c: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
101034ea0: aa1703e1    	mov	x1, x23
101034ea4: 95afcb70    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034ea8: aa1d03fd    	mov	x29, x29
101034eac: 95afcb75    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034eb0: aa0003f9    	mov	x25, x0
101034eb4: f00ee6c8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
101034eb8: f942b502    	ldr	x2, [x8, #0x568]
101034ebc: 900eccc8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101034ec0: f943d118    	ldr	x24, [x8, #0x7a0] ; selector: registerExtension:withKey:withTarget:
101034ec4: aa1803e1    	mov	x1, x24
101034ec8: aa1503e3    	mov	x3, x21
101034ecc: aa1303e4    	mov	x4, x19
101034ed0: 95afcb65    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034ed4: aa1903e0    	mov	x0, x25
101034ed8: 95afcb66    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034edc: f943c360    	ldr	x0, [x27, #0x780]
101034ee0: aa1703e1    	mov	x1, x23
101034ee4: 95afcb60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034ee8: aa1d03fd    	mov	x29, x29
101034eec: 95afcb65    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034ef0: aa0003f9    	mov	x25, x0
101034ef4: f00ee6c8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
101034ef8: f9445102    	ldr	x2, [x8, #0x8a0]
101034efc: aa1803e1    	mov	x1, x24
101034f00: aa1503e3    	mov	x3, x21
101034f04: aa1303e4    	mov	x4, x19
101034f08: 95afcb57    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034f0c: aa1903e0    	mov	x0, x25
101034f10: 95afcb58    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034f14: f943c360    	ldr	x0, [x27, #0x780]
101034f18: aa1703e1    	mov	x1, x23
101034f1c: 95afcb52    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034f20: aa1d03fd    	mov	x29, x29
101034f24: 95afcb57    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034f28: aa0003f9    	mov	x25, x0
101034f2c: f00ee6c8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
101034f30: f9434902    	ldr	x2, [x8, #0x690]
101034f34: aa1803e1    	mov	x1, x24
101034f38: aa1503e3    	mov	x3, x21
101034f3c: aa1303e4    	mov	x4, x19
101034f40: 95afcb49    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034f44: aa1903e0    	mov	x0, x25
101034f48: 95afcb4a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034f4c: aa1303e0    	mov	x0, x19
101034f50: aa1403e1    	mov	x1, x20
101034f54: 95afcb44    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034f58: aa1d03fd    	mov	x29, x29
101034f5c: 95afcb49    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034f60: aa0003f9    	mov	x25, x0
101034f64: aa1603e1    	mov	x1, x22
101034f68: 95afcb3f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034f6c: aa1d03fd    	mov	x29, x29
101034f70: 95afcb44    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034f74: aa0003f6    	mov	x22, x0
101034f78: 900ee708    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101034f7c: f9479d00    	ldr	x0, [x8, #0xf38]
101034f80: d00ee388    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101034f84: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101034f88: 95afcb37    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034f8c: aa0003e2    	mov	x2, x0
101034f90: 900ee3a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101034f94: f9444901    	ldr	x1, [x8, #0x890] ; selector: isKindOfClass:
101034f98: aa1603e0    	mov	x0, x22
101034f9c: 95afcb32    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034fa0: 34000300    	cbz	w0, 0x101035000 <__text+0x102d000>
101034fa4: 900ee3a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101034fa8: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
101034fac: aa1503e0    	mov	x0, x21
101034fb0: 95afcb2d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034fb4: aa0003fa    	mov	x26, x0
101034fb8: aa1603e0    	mov	x0, x22
101034fbc: 95afcb2d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034fc0: aa1903e0    	mov	x0, x25
101034fc4: 95afcb2b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101034fc8: b400025a    	cbz	x26, 0x101035010 <__text+0x102d010>
101034fcc: f943c360    	ldr	x0, [x27, #0x780]
101034fd0: aa1703e1    	mov	x1, x23
101034fd4: 95afcb24    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034fd8: aa1d03fd    	mov	x29, x29
101034fdc: 95afcb29    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101034fe0: aa0003f9    	mov	x25, x0
101034fe4: f00ee6c8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
101034fe8: f9466502    	ldr	x2, [x8, #0xcc8]
101034fec: aa1803e1    	mov	x1, x24
101034ff0: aa1503e3    	mov	x3, x21
101034ff4: aa1303e4    	mov	x4, x19
101034ff8: 95afcb1b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034ffc: 14000003    	b	0x101035008 <__text+0x102d008>
101035000: aa1603e0    	mov	x0, x22
101035004: 95afcb1b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035008: aa1903e0    	mov	x0, x25
10103500c: 95afcb19    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035010: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035014: f9463d01    	ldr	x1, [x8, #0xc78] ; selector: extTarget
101035018: aa1303e0    	mov	x0, x19
10103501c: 95afcb12    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035020: aa1d03fd    	mov	x29, x29
101035024: 95afcb17    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101035028: aa0003f6    	mov	x22, x0
10103502c: b00ecdc8    	adrp	x8, 0x11e9ee000 <dyld_stub_binder+0x11e9ee000>
101035030: f941f901    	ldr	x1, [x8, #0x3f0] ; selector: registerExtension
101035034: 95afcb0c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035038: aa1603e0    	mov	x0, x22
10103503c: 95afcb0d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035040: aa1503e0    	mov	x0, x21
101035044: 95afcb0b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035048: aa1303e0    	mov	x0, x19
10103504c: aa1403e1    	mov	x1, x20
101035050: 95afcb05    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035054: aa1d03fd    	mov	x29, x29
101035058: 95afcb0a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103505c: aa0003f5    	mov	x21, x0
101035060: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035064: f9464101    	ldr	x1, [x8, #0xc80] ; selector: shakeHeadAnimationProgress
101035068: 95afcaff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103506c: 4ea01c08    	mov.16b	v8, v0
101035070: aa1503e0    	mov	x0, x21
101035074: 95afcaff    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035078: 1e602108    	fcmp	d8, #0.0
10103507c: 540000ed    	b.le	0x101035098 <__text+0x102d098>
101035080: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
101035084: f9464501    	ldr	x1, [x8, #0xc88] ; selector: startShakeHeadAnimationFromStart:
101035088: aa1303e0    	mov	x0, x19
10103508c: 52800002    	mov	w2, #0x0                ; =0
101035090: 95afcaf5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035094: 14000005    	b	0x1010350a8 <__text+0x102d0a8>
101035098: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10103509c: f9464901    	ldr	x1, [x8, #0xc90] ; selector: removeShakeHeadAnimation
1010350a0: aa1303e0    	mov	x0, x19
1010350a4: 95afcaf0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010350a8: 900ecf28    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
1010350ac: f9464d01    	ldr	x1, [x8, #0xc98] ; selector: tryConfigChatBotReport
1010350b0: aa1303e0    	mov	x0, x19
1010350b4: 95afcaec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010350b8: aa1303e0    	mov	x0, x19
1010350bc: aa1403e1    	mov	x1, x20
1010350c0: 95afcae9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010350c4: aa1d03fd    	mov	x29, x29
1010350c8: 95afcaee    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010350cc: aa0003f4    	mov	x20, x0
1010350d0: b00eccc8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1010350d4: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
1010350d8: 95afcae3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010350dc: aa1d03fd    	mov	x29, x29
1010350e0: 95afcae8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010350e4: aa0003f5    	mov	x21, x0
1010350e8: d00ecd28    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1010350ec: f9434101    	ldr	x1, [x8, #0x680] ; selector: belongs2MediaGroup
1010350f0: 95afcadd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010350f4: aa0003f6    	mov	x22, x0
1010350f8: aa1503e0    	mov	x0, x21
1010350fc: 95afcadd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035100: aa1403e0    	mov	x0, x20
101035104: 95afcadb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101035108: 34000236    	cbz	w22, 0x10103514c <__text+0x102d14c>
10103510c: b00ee6e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101035110: f943c100    	ldr	x0, [x8, #0x780]
101035114: 900ecca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101035118: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10103511c: 95afcad2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035120: aa1d03fd    	mov	x29, x29
101035124: 95afcad7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101035128: aa0003f4    	mov	x20, x0
10103512c: d00ee6c8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
101035130: f9466902    	ldr	x2, [x8, #0xcd0]
101035134: 900ecca8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101035138: f9478501    	ldr	x1, [x8, #0xf08] ; selector: registerExtension:withTarget:
10103513c: aa1303e3    	mov	x3, x19
101035140: 95afcac9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101035144: aa1403e0    	mov	x0, x20
101035148: 95afcaca    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103514c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
101035150: a9464ff4    	ldp	x20, x19, [sp, #0x60]
101035154: a94557f6    	ldp	x22, x21, [sp, #0x50]
101035158: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10103515c: a94367fa    	ldp	x26, x25, [sp, #0x30]
101035160: a9426ffc    	ldp	x28, x27, [sp, #0x20]
101035164: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
101035168: 910203ff    	add	sp, sp, #0x80
10103516c: d65f03c0    	ret
