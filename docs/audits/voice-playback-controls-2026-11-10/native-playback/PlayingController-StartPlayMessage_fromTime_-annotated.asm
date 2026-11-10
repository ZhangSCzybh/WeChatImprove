
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565bf10: d105c3ff    	sub	sp, sp, #0x170
10565bf14: a9116ffc    	stp	x28, x27, [sp, #0x110]
10565bf18: a91267fa    	stp	x26, x25, [sp, #0x120]
10565bf1c: a9135ff8    	stp	x24, x23, [sp, #0x130]
10565bf20: a91457f6    	stp	x22, x21, [sp, #0x140]
10565bf24: a9154ff4    	stp	x20, x19, [sp, #0x150]
10565bf28: a9167bfd    	stp	x29, x30, [sp, #0x160]
10565bf2c: 910583fd    	add	x29, sp, #0x160
10565bf30: b9002fe3    	str	w3, [sp, #0x2c]
10565bf34: aa0203f3    	mov	x19, x2
10565bf38: aa0003f4    	mov	x20, x0
10565bf3c: b00c0788    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10565bf40: f9451908    	ldr	x8, [x8, #0xa30]
10565bf44: f9400108    	ldr	x8, [x8]
10565bf48: f81a03a8    	stur	x8, [x29, #-0x60]
10565bf4c: 900d07c8    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
10565bf50: 52800029    	mov	w9, #0x1                ; =1
10565bf54: 39300509    	strb	w9, [x8, #0xc01]
10565bf58: aa0203e0    	mov	x0, x2
10565bf5c: 94972f46    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10565bf60: 900c9ba8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565bf64: f9434901    	ldr	x1, [x8, #0x690] ; selector: GetMsgClientMsgID
10565bf68: aa1303e0    	mov	x0, x19
10565bf6c: 94972f3e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565bf70: aa1d03fd    	mov	x29, x29
10565bf74: 94972f43    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565bf78: aa0003f5    	mov	x21, x0
10565bf7c: f00cb5b6    	adrp	x22, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565bf80: f943c2c0    	ldr	x0, [x22, #0x780]
10565bf84: d00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565bf88: f9440117    	ldr	x23, [x8, #0x800] ; selector: currentContext
10565bf8c: aa1703e1    	mov	x1, x23
10565bf90: 94972f35    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565bf94: aa1d03fd    	mov	x29, x29
10565bf98: 94972f3a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565bf9c: aa0003fa    	mov	x26, x0
10565bfa0: b00cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565bfa4: f9401d00    	ldr	x0, [x8, #0x38]
10565bfa8: f00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565bfac: f9428518    	ldr	x24, [x8, #0x508] ; selector: class
10565bfb0: aa1803e1    	mov	x1, x24
10565bfb4: 94972f2c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565bfb8: aa0003e2    	mov	x2, x0
10565bfbc: d00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565bfc0: f9452119    	ldr	x25, [x8, #0xa40] ; selector: getService:
10565bfc4: aa1a03e0    	mov	x0, x26
10565bfc8: aa1903e1    	mov	x1, x25
10565bfcc: 94972f26    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565bfd0: aa1d03fd    	mov	x29, x29
10565bfd4: 94972f2b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565bfd8: aa0003fb    	mov	x27, x0
10565bfdc: f943c2c0    	ldr	x0, [x22, #0x780]
10565bfe0: aa1703e1    	mov	x1, x23
10565bfe4: 94972f20    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565bfe8: aa1d03fd    	mov	x29, x29
10565bfec: 94972f25    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565bff0: aa0003fc    	mov	x28, x0
10565bff4: d00cb5c8    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10565bff8: f940fd00    	ldr	x0, [x8, #0x1f8]
10565bffc: aa1803e1    	mov	x1, x24
10565c000: 94972f19    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c004: aa0003e2    	mov	x2, x0
10565c008: aa1c03e0    	mov	x0, x28
10565c00c: aa1903e1    	mov	x1, x25
10565c010: 94972f15    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c014: aa1d03fd    	mov	x29, x29
10565c018: 94972f1a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c01c: aa0003f6    	mov	x22, x0
10565c020: 900c9e48    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
10565c024: f9430101    	ldr	x1, [x8, #0x600] ; selector: setActive:scene:identifier:listener:
10565c028: aa1b03e0    	mov	x0, x27
10565c02c: 52800022    	mov	w2, #0x1                ; =1
10565c030: 52800003    	mov	w3, #0x0                ; =0
10565c034: f9001bf5    	str	x21, [sp, #0x30]
10565c038: aa1503e4    	mov	x4, x21
10565c03c: aa1603e5    	mov	x5, x22
10565c040: 94972f09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c044: aa0003f5    	mov	x21, x0
10565c048: aa1603e0    	mov	x0, x22
10565c04c: 94972f09    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c050: aa1c03e0    	mov	x0, x28
10565c054: 94972f07    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c058: aa1b03e0    	mov	x0, x27
10565c05c: 94972f05    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c060: aa1a03e0    	mov	x0, x26
10565c064: 94972f03    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c068: 340019f5    	cbz	w21, 0x10565c3a4 <_Flutter_MMFoundation_BindContext+0x18e3070>
10565c06c: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c070: f9430d00    	ldr	x0, [x8, #0x618]
10565c074: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565c078: b988051c    	ldrsw	x28, [x8, #0x804] ; ivar: PlayingController.m_bPlaying offset=8
10565c07c: 387c6a88    	ldrb	w8, [x20, x28]
10565c080: 900cbb89    	adrp	x9, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565c084: b988013a    	ldrsw	x26, [x9, #0x800] ; ivar: PlayingController.m_uiMesLocalID offset=12
10565c088: b00c9b69    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c08c: f9418921    	ldr	x1, [x9, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10565c090: b87a6a89    	ldr	w9, [x20, x26]
10565c094: a900a7e8    	stp	x8, x9, [sp, #0x8]
10565c098: 900be589    	adrp	x9, 0x11d30c000 <dyld_stub_binder+0x11d30c000>
10565c09c: 913d6129    	add	x9, x9, #0xf58 ; CFString: playing:%d, msgLocalId:%u
10565c0a0: f90003e9    	str	x9, [sp]
10565c0a4: f00a5f45    	adrp	x5, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c0a8: 913600a5    	add	x5, x5, #0xd80
10565c0ac: f00a5f47    	adrp	x7, 0x11a247000 <dyld_stub_binder+0x11a247000>
10565c0b0: 913654e7    	add	x7, x7, #0xd95
10565c0b4: 52800042    	mov	w2, #0x2                ; =2
10565c0b8: d2800003    	mov	x3, #0x0                ; =0
10565c0bc: 52800004    	mov	w4, #0x0                ; =0
10565c0c0: 528009c6    	mov	w6, #0x4e               ; =78
10565c0c4: 94972ee8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c0c8: 387c6a88    	ldrb	w8, [x20, x28]
10565c0cc: 7100051f    	cmp	w8, #0x1
10565c0d0: aa1403f6    	mov	x22, x20
10565c0d4: 54000061    	b.ne	0x10565c0e0 <_Flutter_MMFoundation_BindContext+0x18e2dac>
10565c0d8: 383c6adf    	strb	wzr, [x22, x28]
10565c0dc: b83a6adf    	str	wzr, [x22, x26]
10565c0e0: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c0e4: f943c100    	ldr	x0, [x8, #0x780]
10565c0e8: aa1703e1    	mov	x1, x23
10565c0ec: 94972ede    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c0f0: aa1d03fd    	mov	x29, x29
10565c0f4: 94972ee3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c0f8: aa0003f5    	mov	x21, x0
10565c0fc: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565c100: f9401500    	ldr	x0, [x8, #0x28]
10565c104: aa1803e1    	mov	x1, x24
10565c108: 94972ed7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c10c: aa0003e2    	mov	x2, x0
10565c110: aa1503e0    	mov	x0, x21
10565c114: aa1903e1    	mov	x1, x25
10565c118: 94972ed3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c11c: aa1d03fd    	mov	x29, x29
10565c120: 94972ed8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c124: aa0003f7    	mov	x23, x0
10565c128: aa1503e0    	mov	x0, x21
10565c12c: 94972ed1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c130: f00cb5a8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10565c134: f9430900    	ldr	x0, [x8, #0x610]
10565c138: b00cb288    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10565c13c: f9400d01    	ldr	x1, [x8, #0x18] ; selector: sharedInstance
10565c140: 94972ec9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c144: aa1d03fd    	mov	x29, x29
10565c148: 94972ece    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c14c: aa0003f5    	mov	x21, x0
10565c150: f00cb588    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
10565c154: f942f502    	ldr	x2, [x8, #0x5e8]
10565c158: d00c9ee8    	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
10565c15c: f9468518    	ldr	x24, [x8, #0xd08] ; selector: GetPathOfAppRemindAttach:retStrPath:
10565c160: f00c9b88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565c164: f940f901    	ldr	x1, [x8, #0x1f0] ; selector: getClsMethodObservers:selector:
10565c168: aa1803e3    	mov	x3, x24
10565c16c: 94972ebe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c170: aa1d03fd    	mov	x29, x29
10565c174: 94972ec3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c178: aa0003f9    	mov	x25, x0
10565c17c: aa1503e0    	mov	x0, x21
10565c180: 94972ebc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c184: 4f00e400    	movi.16b	v0, #0x0
10565c188: ad0303e0    	stp	q0, q0, [sp, #0x60]
10565c18c: ad0203e0    	stp	q0, q0, [sp, #0x40]
10565c190: d00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565c194: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10565c198: 910103e2    	add	x2, sp, #0x40
10565c19c: 910203e3    	add	x3, sp, #0x80
10565c1a0: aa1903e0    	mov	x0, x25
10565c1a4: 52800204    	mov	w4, #0x10               ; =16
10565c1a8: 94972eaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c1ac: b4000180    	cbz	x0, 0x10565c1dc <_Flutter_MMFoundation_BindContext+0x18e2ea8>
10565c1b0: f94027e8    	ldr	x8, [sp, #0x48]
10565c1b4: f9400100    	ldr	x0, [x8]
10565c1b8: f9001fff    	str	xzr, [sp, #0x38]
10565c1bc: 9100e3e3    	add	x3, sp, #0x38
10565c1c0: aa1803e1    	mov	x1, x24
10565c1c4: aa1303e2    	mov	x2, x19
10565c1c8: 94972ea7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c1cc: f9401ff8    	ldr	x24, [sp, #0x38]
10565c1d0: aa1803e0    	mov	x0, x24
10565c1d4: 94972ea8    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10565c1d8: 14000002    	b	0x10565c1e0 <_Flutter_MMFoundation_BindContext+0x18e2eac>
10565c1dc: d2800018    	mov	x24, #0x0               ; =0
10565c1e0: aa1903e0    	mov	x0, x25
10565c1e4: 94972ea3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c1e8: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c1ec: f9478101    	ldr	x1, [x8, #0xf00] ; selector: m_isEnterpriseMsg
10565c1f0: aa1303e0    	mov	x0, x19
10565c1f4: 94972e9c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c1f8: 900c9b99    	adrp	x25, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565c1fc: 340006e0    	cbz	w0, 0x10565c2d8 <_Flutter_MMFoundation_BindContext+0x18e2fa4>
10565c200: 900cb5d4    	adrp	x20, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565c204: f940b695    	ldr	x21, [x20, #0x168]
10565c208: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c20c: f947b501    	ldr	x1, [x8, #0xf68] ; selector: m_nsBizChatId
10565c210: aa1303e0    	mov	x0, x19
10565c214: 94972e94    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c218: aa1d03fd    	mov	x29, x29
10565c21c: 94972e99    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c220: f90013f6    	str	x22, [sp, #0x20]
10565c224: aa0003f6    	mov	x22, x0
10565c228: f947e721    	ldr	x1, [x25, #0xfc8] ; selector: m_uiMesLocalID
10565c22c: aa1303e0    	mov	x0, x19
10565c230: 94972e8d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c234: aa0003f9    	mov	x25, x0
10565c238: f940b680    	ldr	x0, [x20, #0x168]
10565c23c: d00c9ee8    	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
10565c240: f9459d01    	ldr	x1, [x8, #0xb38] ; selector: getEnterpriseChatBrandUserName:
10565c244: aa1303e2    	mov	x2, x19
10565c248: 94972e87    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c24c: aa1d03fd    	mov	x29, x29
10565c250: 94972e8c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c254: aa1a03f4    	mov	x20, x26
10565c258: aa0003fa    	mov	x26, x0
10565c25c: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565c260: f9445100    	ldr	x0, [x8, #0x8a0]
10565c264: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c268: f9450101    	ldr	x1, [x8, #0xa00] ; selector: GetDocPath
10565c26c: 94972e7e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c270: aa1d03fd    	mov	x29, x29
10565c274: 94972e83    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c278: aa0003fb    	mov	x27, x0
10565c27c: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c280: f947b901    	ldr	x1, [x8, #0xf70] ; selector: GetPathOfMesAudio:LocalID:Brand:DocPath:
10565c284: aa1503e0    	mov	x0, x21
10565c288: aa1603e2    	mov	x2, x22
10565c28c: aa1903e3    	mov	x3, x25
10565c290: 900c9b99    	adrp	x25, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565c294: aa1a03e4    	mov	x4, x26
10565c298: aa1b03e5    	mov	x5, x27
10565c29c: 94972e72    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c2a0: aa1d03fd    	mov	x29, x29
10565c2a4: 94972e77    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565c2a8: aa0003f5    	mov	x21, x0
10565c2ac: aa1803e0    	mov	x0, x24
10565c2b0: 94972e70    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c2b4: aa1b03e0    	mov	x0, x27
10565c2b8: 94972e6e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c2bc: aa1a03e0    	mov	x0, x26
10565c2c0: aa1403fa    	mov	x26, x20
10565c2c4: 94972e6b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c2c8: aa1603e0    	mov	x0, x22
10565c2cc: f94013f6    	ldr	x22, [sp, #0x20]
10565c2d0: 94972e68    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c2d4: aa1503f8    	mov	x24, x21
10565c2d8: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565c2dc: f9435501    	ldr	x1, [x8, #0x6a8] ; selector: isPlaying
10565c2e0: aa1703e0    	mov	x0, x23
10565c2e4: 94972e60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c2e8: 900cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565c2ec: b9880914    	ldrsw	x20, [x8, #0x808] ; ivar: PlayingController.m_msgWrap offset=16
10565c2f0: 34000320    	cbz	w0, 0x10565c354 <_Flutter_MMFoundation_BindContext+0x18e3020>
10565c2f4: f8746ac0    	ldr	x0, [x22, x20]
10565c2f8: f00c9b88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565c2fc: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: IsSameMsg:
10565c300: aa1303e2    	mov	x2, x19
10565c304: 94972e58    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c308: 340000e0    	cbz	w0, 0x10565c324 <_Flutter_MMFoundation_BindContext+0x18e2ff0>
10565c30c: b00ca728    	adrp	x8, 0x11eb41000 <dyld_stub_binder+0x11eb41000>
10565c310: f945cd01    	ldr	x1, [x8, #0xb98] ; selector: reportStopVoice:
10565c314: aa1603e0    	mov	x0, x22
10565c318: 52800022    	mov	w2, #0x1                ; =1
10565c31c: 94972e52    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c320: 14000007    	b	0x10565c33c <_Flutter_MMFoundation_BindContext+0x18e3008>
10565c324: b00ca728    	adrp	x8, 0x11eb41000 <dyld_stub_binder+0x11eb41000>
10565c328: f945d101    	ldr	x1, [x8, #0xba0] ; selector: reportStopVoice:subReason:
10565c32c: aa1603e0    	mov	x0, x22
10565c330: 52800042    	mov	w2, #0x2                ; =2
10565c334: 5280fae3    	mov	w3, #0x7d7              ; =2007
10565c338: 94972e4b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c33c: 900cb6c8    	adrp	x8, 0x11ed34000 <dyld_stub_binder+0x11ed34000>
10565c340: f9473500    	ldr	x0, [x8, #0xe68]
10565c344: b00ca728    	adrp	x8, 0x11eb41000 <dyld_stub_binder+0x11eb41000>
10565c348: f945d501    	ldr	x1, [x8, #0xba8] ; selector: updateVoiceStopReason:
10565c34c: 52800042    	mov	w2, #0x2                ; =2
10565c350: 94972e45    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c354: 8b1402c0    	add	x0, x22, x20
10565c358: aa1303e1    	mov	x1, x19
10565c35c: 94972e50    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
10565c360: f00c9ba8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
10565c364: f944d901    	ldr	x1, [x8, #0x9b0] ; selector: StartPlay:Path:fromTime:
10565c368: aa1703e0    	mov	x0, x23
10565c36c: aa1303e2    	mov	x2, x19
10565c370: aa1803e3    	mov	x3, x24
10565c374: b9402fe4    	ldr	w4, [sp, #0x2c]
10565c378: 94972e3b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c37c: 52800028    	mov	w8, #0x1                ; =1
10565c380: 383c6ac8    	strb	w8, [x22, x28]
10565c384: f947e721    	ldr	x1, [x25, #0xfc8] ; selector: m_uiMesLocalID
10565c388: aa1303e0    	mov	x0, x19
10565c38c: 94972e36    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565c390: b83a6ac0    	str	w0, [x22, x26]
10565c394: aa1803e0    	mov	x0, x24
10565c398: 94972e36    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c39c: aa1703e0    	mov	x0, x23
10565c3a0: 94972e34    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c3a4: f9401be0    	ldr	x0, [sp, #0x30]
10565c3a8: 94972e32    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c3ac: aa1303e0    	mov	x0, x19
10565c3b0: 94972e30    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565c3b4: f85a03a8    	ldur	x8, [x29, #-0x60]
10565c3b8: 900c0789    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10565c3bc: f9451929    	ldr	x9, [x9, #0xa30]
10565c3c0: f9400129    	ldr	x9, [x9]
10565c3c4: eb08013f    	cmp	x9, x8
10565c3c8: 54000121    	b.ne	0x10565c3ec <_Flutter_MMFoundation_BindContext+0x18e30b8>
10565c3cc: a9567bfd    	ldp	x29, x30, [sp, #0x160]
10565c3d0: a9554ff4    	ldp	x20, x19, [sp, #0x150]
10565c3d4: a95457f6    	ldp	x22, x21, [sp, #0x140]
10565c3d8: a9535ff8    	ldp	x24, x23, [sp, #0x130]
10565c3dc: a95267fa    	ldp	x26, x25, [sp, #0x120]
10565c3e0: a9516ffc    	ldp	x28, x27, [sp, #0x110]
10565c3e4: 9105c3ff    	add	sp, sp, #0x170
10565c3e8: d65f03c0    	ret
10565c3ec: 94972cd1    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
