
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105779e00: d10203ff    	sub	sp, sp, #0x80
105779e04: a90367fa    	stp	x26, x25, [sp, #0x30]
105779e08: a9045ff8    	stp	x24, x23, [sp, #0x40]
105779e0c: a90557f6    	stp	x22, x21, [sp, #0x50]
105779e10: a9064ff4    	stp	x20, x19, [sp, #0x60]
105779e14: a9077bfd    	stp	x29, x30, [sp, #0x70]
105779e18: 9101c3fd    	add	x29, sp, #0x70
105779e1c: aa0303f4    	mov	x20, x3
105779e20: aa0203f3    	mov	x19, x2
105779e24: aa0003f5    	mov	x21, x0
105779e28: 900da648    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
105779e2c: 52800029    	mov	w9, #0x1                ; =1
105779e30: 390c5109    	strb	w9, [x8, #0x314]
105779e34: aa0203e0    	mov	x0, x2
105779e38: 9492b4c0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105779e3c: aa1403e0    	mov	x0, x20
105779e40: 9492b4be    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105779e44: f00d3608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105779e48: f947d117    	ldr	x23, [x8, #0xfa0] ; m_uiMesLocalID
105779e4c: aa1703e1    	mov	x1, x23
105779e50: 9492b4bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779e54: 340017a0    	cbz	w0, 0x10577a148 <_Flutter_MMFoundation_BindContext+0x1c55d2c>
105779e58: d00d4c48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105779e5c: f946e916    	ldr	x22, [x8, #0xdd0] ; length
105779e60: aa1303e0    	mov	x0, x19
105779e64: aa1603e1    	mov	x1, x22
105779e68: 9492b4b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779e6c: d00d3628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105779e70: f940d918    	ldr	x24, [x8, #0x1b0] ; m_nsToUsr
105779e74: b40016e0    	cbz	x0, 0x10577a150 <_Flutter_MMFoundation_BindContext+0x1c55d34>
105779e78: aa1403e0    	mov	x0, x20
105779e7c: aa1803e1    	mov	x1, x24
105779e80: 9492b4af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779e84: aa1d03fd    	mov	x29, x29
105779e88: 9492b4b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105779e8c: aa0003f9    	mov	x25, x0
105779e90: aa1603e1    	mov	x1, x22
105779e94: 9492b4aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779e98: aa0003f6    	mov	x22, x0
105779e9c: aa1903e0    	mov	x0, x25
105779ea0: 9492b4ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779ea4: b4001576    	cbz	x22, 0x10577a150 <_Flutter_MMFoundation_BindContext+0x1c55d34>
105779ea8: b00d50e8    	adrp	x8, 0x120196000 <dyld_stub_binder+0x120196000>
105779eac: f943b500    	ldr	x0, [x8, #0x768]
105779eb0: 9492b4aa    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105779eb4: aa0003f6    	mov	x22, x0
105779eb8: b00d3628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105779ebc: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
105779ec0: aa1403e0    	mov	x0, x20
105779ec4: 9492b49e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779ec8: aa1d03fd    	mov	x29, x29
105779ecc: 9492b49f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105779ed0: aa0003f9    	mov	x25, x0
105779ed4: d00d36c8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
105779ed8: f9435901    	ldr	x1, [x8, #0x6b0] ; setMessage:
105779edc: aa1603e0    	mov	x0, x22
105779ee0: aa1903e2    	mov	x2, x25
105779ee4: 9492b496    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779ee8: aa1903e0    	mov	x0, x25
105779eec: 9492b49a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779ef0: f00d3608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105779ef4: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
105779ef8: aa1403e0    	mov	x0, x20
105779efc: 9492b490    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f00: aa0003e2    	mov	x2, x0
105779f04: f00d3628    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
105779f08: f9431d01    	ldr	x1, [x8, #0x638] ; setCreateTime:
105779f0c: aa1603e0    	mov	x0, x22
105779f10: 9492b48b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f14: b00d3628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105779f18: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
105779f1c: aa1403e0    	mov	x0, x20
105779f20: 9492b487    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f24: aa0003e2    	mov	x2, x0
105779f28: 900d4c88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105779f2c: f947b501    	ldr	x1, [x8, #0xf68] ; setType:
105779f30: aa1603e0    	mov	x0, x22
105779f34: 9492b482    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f38: d00d3688    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
105779f3c: f9421d01    	ldr	x1, [x8, #0x438] ; m_uiEmojiStatFlag
105779f40: aa1403e0    	mov	x0, x20
105779f44: 9492b47e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f48: aa0003e2    	mov	x2, x0
105779f4c: 900d4c88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105779f50: f945ad01    	ldr	x1, [x8, #0xb58] ; setStatus:
105779f54: aa1603e0    	mov	x0, x22
105779f58: 9492b479    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f5c: f00d3948    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
105779f60: f9422501    	ldr	x1, [x8, #0x448] ; m_uiImgStatus
105779f64: aa1403e0    	mov	x0, x20
105779f68: 9492b475    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f6c: aa0003e2    	mov	x2, x0
105779f70: f00d37c8    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
105779f74: f9419501    	ldr	x1, [x8, #0x328] ; setImageStatus:
105779f78: aa1603e0    	mov	x0, x22
105779f7c: 9492b470    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f80: aa1403e0    	mov	x0, x20
105779f84: aa1803e1    	mov	x1, x24
105779f88: 9492b46d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779f8c: aa1d03fd    	mov	x29, x29
105779f90: 9492b46e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105779f94: aa0003f8    	mov	x24, x0
105779f98: d00d3608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105779f9c: f9433501    	ldr	x1, [x8, #0x668] ; setUserName:
105779fa0: aa1603e0    	mov	x0, x22
105779fa4: aa1803e2    	mov	x2, x24
105779fa8: 9492b465    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779fac: aa1803e0    	mov	x0, x24
105779fb0: 9492b469    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779fb4: aa1403e0    	mov	x0, x20
105779fb8: aa1703e1    	mov	x1, x23
105779fbc: 9492b460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779fc0: aa0003e2    	mov	x2, x0
105779fc4: 900d36a8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
105779fc8: f9402101    	ldr	x1, [x8, #0x40] ; setMsgLocalId:
105779fcc: aa1603e0    	mov	x0, x22
105779fd0: 9492b45b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779fd4: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105779fd8: f9467900    	ldr	x0, [x8, #0xcf0]
105779fdc: f00d3608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105779fe0: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
105779fe4: 9492b456    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779fe8: aa0003e2    	mov	x2, x0
105779fec: b00d4c88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105779ff0: f940d101    	ldr	x1, [x8, #0x1a0] ; setVersion:
105779ff4: aa1603e0    	mov	x0, x22
105779ff8: 9492b451    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779ffc: d00d3628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10577a000: f944f101    	ldr	x1, [x8, #0x9e0] ; m_nsMsgSource
10577a004: aa1403e0    	mov	x0, x20
10577a008: 9492b44d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a00c: aa1d03fd    	mov	x29, x29
10577a010: 9492b44e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577a014: aa0003f8    	mov	x24, x0
10577a018: d00d3628    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10577a01c: f9432901    	ldr	x1, [x8, #0x650] ; setMsgSource:
10577a020: aa1603e0    	mov	x0, x22
10577a024: aa1803e2    	mov	x2, x24
10577a028: 9492b445    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a02c: aa1803e0    	mov	x0, x24
10577a030: 9492b449    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577a034: f00d3be8    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
10577a038: f945a501    	ldr	x1, [x8, #0xb48] ; m_easterEggIncludedType
10577a03c: aa1403e0    	mov	x0, x20
10577a040: 9492b43f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a044: b50000c0    	cbnz	x0, 0x10577a05c <_Flutter_MMFoundation_BindContext+0x1c55c40>
10577a048: d00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577a04c: f941fd01    	ldr	x1, [x8, #0x3f8] ; setNeedCheckEasterEgg:
10577a050: aa1603e0    	mov	x0, x22
10577a054: 52800022    	mov	w2, #0x1                ; =1
10577a058: 9492b439    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a05c: 900d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577a060: b98ce908    	ldrsw	x8, [x8, #0xce8]
10577a064: f8686aa1    	ldr	x1, [x21, x8]
10577a068: 910083e0    	add	x0, sp, #0x20
10577a06c: 94924cb1    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
10577a070: d00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577a074: f9420101    	ldr	x1, [x8, #0x400] ; loadMessages
10577a078: aa1503e0    	mov	x0, x21
10577a07c: 9492b430    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a080: aa1d03fd    	mov	x29, x29
10577a084: 9492b431    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577a088: aa0003f8    	mov	x24, x0
10577a08c: aa1403e0    	mov	x0, x20
10577a090: aa1703e1    	mov	x1, x23
10577a094: 9492b42a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a098: aa0003e4    	mov	x4, x0
10577a09c: d00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577a0a0: f9420501    	ldr	x1, [x8, #0x408] ; deleteSendMsgInArray:withChatName:localId:
10577a0a4: aa1503e0    	mov	x0, x21
10577a0a8: aa1803e2    	mov	x2, x24
10577a0ac: aa1303e3    	mov	x3, x19
10577a0b0: 9492b423    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a0b4: 900d3608    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10577a0b8: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
10577a0bc: aa1803e0    	mov	x0, x24
10577a0c0: aa1603e2    	mov	x2, x22
10577a0c4: 9492b41e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a0c8: d00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577a0cc: f9420901    	ldr	x1, [x8, #0x410] ; saveMessages:
10577a0d0: aa1503e0    	mov	x0, x21
10577a0d4: aa1803e2    	mov	x2, x24
10577a0d8: 9492b419    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a0dc: b00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577a0e0: f9453515    	ldr	x21, [x8, #0xa68]
10577a0e4: d00d4c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10577a0e8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10577a0ec: aa1803e0    	mov	x0, x24
10577a0f0: 9492b413    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a0f4: f00d35e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10577a0f8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10577a0fc: d00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577a100: 91362108    	add	x8, x8, #0xd88
10577a104: a90003e8    	stp	x8, x0, [sp]
10577a108: f00ad543    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
10577a10c: 9107f063    	add	x3, x3, #0x1fc
10577a110: f00b0b25    	adrp	x5, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577a114: 910cf0a5    	add	x5, x5, #0x33c
10577a118: f00b0b27    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577a11c: 910f84e7    	add	x7, x7, #0x3e1
10577a120: aa1503e0    	mov	x0, x21
10577a124: 52800042    	mov	w2, #0x2                ; =2
10577a128: 52800004    	mov	w4, #0x0                ; =0
10577a12c: 52801426    	mov	w6, #0xa1               ; =161
10577a130: 9492b403    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a134: aa1803e0    	mov	x0, x24
10577a138: 9492b407    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577a13c: 910083e0    	add	x0, sp, #0x20
10577a140: 94924c7d    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
10577a144: 1400001c    	b	0x10577a1b4 <_Flutter_MMFoundation_BindContext+0x1c55d98>
10577a148: b00d3628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10577a14c: f940d918    	ldr	x24, [x8, #0x1b0] ; m_nsToUsr
10577a150: b00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577a154: f9453515    	ldr	x21, [x8, #0xa68]
10577a158: aa1403e0    	mov	x0, x20
10577a15c: aa1803e1    	mov	x1, x24
10577a160: 9492b3f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a164: aa1d03fd    	mov	x29, x29
10577a168: 9492b3f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577a16c: aa0003f6    	mov	x22, x0
10577a170: f00d35e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10577a174: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10577a178: a90083f3    	stp	x19, x0, [sp, #0x8]
10577a17c: d00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577a180: 9135a108    	add	x8, x8, #0xd68
10577a184: f90003e8    	str	x8, [sp]
10577a188: f00ad543    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
10577a18c: 9107f063    	add	x3, x3, #0x1fc
10577a190: f00b0b25    	adrp	x5, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577a194: 910cf0a5    	add	x5, x5, #0x33c
10577a198: f00b0b27    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577a19c: 910f84e7    	add	x7, x7, #0x3e1
10577a1a0: aa1503e0    	mov	x0, x21
10577a1a4: 52800082    	mov	w2, #0x4                ; =4
10577a1a8: 52800004    	mov	w4, #0x0                ; =0
10577a1ac: 52801106    	mov	w6, #0x88               ; =136
10577a1b0: 9492b3e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577a1b4: aa1603e0    	mov	x0, x22
10577a1b8: 9492b3e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577a1bc: aa1403e0    	mov	x0, x20
10577a1c0: 9492b3e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577a1c4: aa1303e0    	mov	x0, x19
10577a1c8: 9492b3e3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577a1cc: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10577a1d0: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10577a1d4: a94557f6    	ldp	x22, x21, [sp, #0x50]
10577a1d8: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10577a1dc: a94367fa    	ldp	x26, x25, [sp, #0x30]
10577a1e0: 910203ff    	add	sp, sp, #0x80
10577a1e4: d65f03c0    	ret
