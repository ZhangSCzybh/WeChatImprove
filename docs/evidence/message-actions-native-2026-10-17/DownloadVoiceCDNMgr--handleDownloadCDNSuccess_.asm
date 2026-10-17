
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101173cb4: d10303ff    	sub	sp, sp, #0xc0
101173cb8: a9066ffc    	stp	x28, x27, [sp, #0x60]
101173cbc: a90767fa    	stp	x26, x25, [sp, #0x70]
101173cc0: a9085ff8    	stp	x24, x23, [sp, #0x80]
101173cc4: a90957f6    	stp	x22, x21, [sp, #0x90]
101173cc8: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
101173ccc: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
101173cd0: 9102c3fd    	add	x29, sp, #0xb0
101173cd4: aa0203f4    	mov	x20, x2
101173cd8: aa0003f3    	mov	x19, x0
101173cdc: d00fd5e8    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
101173ce0: 52800029    	mov	w9, #0x1                ; =1
101173ce4: 39095509    	strb	w9, [x8, #0x255]
101173ce8: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173cec: f9447915    	ldr	x21, [x8, #0x8f0] ; setBDownloading:
101173cf0: aa0203e0    	mov	x0, x2
101173cf4: 95aacd11    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101173cf8: aa1303e0    	mov	x0, x19
101173cfc: aa1503e1    	mov	x1, x21
101173d00: 52800002    	mov	w2, #0x0                ; =0
101173d04: 95aacd0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173d08: 900f8008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101173d0c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
101173d10: d00f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101173d14: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101173d18: f00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
101173d1c: 911aa108    	add	x8, x8, #0x6a8
101173d20: f90003e8    	str	x8, [sp]
101173d24: d00d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
101173d28: 9107f063    	add	x3, x3, #0x1fc
101173d2c: b00d1045    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101173d30: 9108b0a5    	add	x5, x5, #0x22c
101173d34: b00d1047    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101173d38: 911ab8e7    	add	x7, x7, #0x6ae
101173d3c: 52800042    	mov	w2, #0x2                ; =2
101173d40: 52800004    	mov	w4, #0x0                ; =0
101173d44: 52802da6    	mov	w6, #0x16d              ; =365
101173d48: 95aaccfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173d4c: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173d50: f944a501    	ldr	x1, [x8, #0x948] ; reportDownloadCDNSuccess:
101173d54: aa1303e0    	mov	x0, x19
101173d58: aa1403e2    	mov	x2, x20
101173d5c: 95aaccf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173d60: 900f8008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101173d64: f9454515    	ldr	x21, [x8, #0xa88]
101173d68: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173d6c: f9448516    	ldr	x22, [x8, #0x908] ; m_nsChatUsrName
101173d70: aa1403e0    	mov	x0, x20
101173d74: aa1603e1    	mov	x1, x22
101173d78: 95aaccf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173d7c: aa1d03fd    	mov	x29, x29
101173d80: 95aaccf2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173d84: aa0003f7    	mov	x23, x0
101173d88: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173d8c: f9467518    	ldr	x24, [x8, #0xce8] ; m_uiLocalID
101173d90: aa1403e0    	mov	x0, x20
101173d94: aa1803e1    	mov	x1, x24
101173d98: 95aacce9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173d9c: f00f7ca8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101173da0: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
101173da4: a90003f7    	stp	x23, x0, [sp]
101173da8: d00e9e82    	adrp	x2, 0x11e545000 <dyld_stub_binder+0x11e545000>
101173dac: 9134a042    	add	x2, x2, #0xd28
101173db0: aa1503e0    	mov	x0, x21
101173db4: 95aacce2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173db8: aa1d03fd    	mov	x29, x29
101173dbc: 95aacce3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173dc0: aa0003f5    	mov	x21, x0
101173dc4: f90013e0    	str	x0, [sp, #0x20]
101173dc8: aa1703e0    	mov	x0, x23
101173dcc: 95aacce2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173dd0: b00f7c88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101173dd4: f9402d01    	ldr	x1, [x8, #0x58] ; lock
101173dd8: aa1303e0    	mov	x0, x19
101173ddc: 95aaccd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173de0: aa1d03fd    	mov	x29, x29
101173de4: 95aaccd9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173de8: aa0003f7    	mov	x23, x0
101173dec: 910143e0    	add	x0, sp, #0x50
101173df0: aa1703e1    	mov	x1, x23
101173df4: 95aa654f    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
101173df8: aa1703e0    	mov	x0, x23
101173dfc: 95aaccd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173e00: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173e04: f9442d01    	ldr	x1, [x8, #0x858] ; readyDownloadItems
101173e08: aa1303e0    	mov	x0, x19
101173e0c: 95aacccc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173e10: aa1d03fd    	mov	x29, x29
101173e14: 95aacccd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173e18: aa0003f7    	mov	x23, x0
101173e1c: 900f6648    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101173e20: f9462101    	ldr	x1, [x8, #0xc40] ; safeRemoveObjectForKey:
101173e24: aa1503e2    	mov	x2, x21
101173e28: 95aaccc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173e2c: aa1703e0    	mov	x0, x23
101173e30: 95aaccc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173e34: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173e38: f9445901    	ldr	x1, [x8, #0x8b0] ; updateItemToPB
101173e3c: aa1303e0    	mov	x0, x19
101173e40: 95aaccbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173e44: 910143e0    	add	x0, sp, #0x50
101173e48: 95aa653b    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
101173e4c: b00f7c68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101173e50: f946f101    	ldr	x1, [x8, #0xde0] ; delegate
101173e54: aa1303e0    	mov	x0, x19
101173e58: 95aaccb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173e5c: aa1d03fd    	mov	x29, x29
101173e60: 95aaccba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173e64: aa0003f7    	mov	x23, x0
101173e68: aa1403e0    	mov	x0, x20
101173e6c: aa1603e1    	mov	x1, x22
101173e70: 95aaccb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173e74: aa1d03fd    	mov	x29, x29
101173e78: 95aaccb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173e7c: aa0003f6    	mov	x22, x0
101173e80: aa1403e0    	mov	x0, x20
101173e84: aa1803e1    	mov	x1, x24
101173e88: 95aaccad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173e8c: b9001fe0    	str	w0, [sp, #0x1c]
101173e90: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173e94: f9467901    	ldr	x1, [x8, #0xcf0] ; m_n64SvrID
101173e98: aa1403e0    	mov	x0, x20
101173e9c: 95aacca8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173ea0: aa0003f9    	mov	x25, x0
101173ea4: b00f6648    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101173ea8: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
101173eac: aa1403e0    	mov	x0, x20
101173eb0: 95aacca3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173eb4: aa0003fa    	mov	x26, x0
101173eb8: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173ebc: f943ed01    	ldr	x1, [x8, #0x7d8] ; m_uiVoiceTime
101173ec0: aa1403e0    	mov	x0, x20
101173ec4: 95aacc9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173ec8: aa0003fb    	mov	x27, x0
101173ecc: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173ed0: f9467d01    	ldr	x1, [x8, #0xcf8] ; m_uiOffset
101173ed4: aa1403e0    	mov	x0, x20
101173ed8: 95aacc99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173edc: aa0003fc    	mov	x28, x0
101173ee0: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173ee4: f9468101    	ldr	x1, [x8, #0xd00] ; m_uiLen
101173ee8: aa1403e0    	mov	x0, x20
101173eec: 95aacc94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173ef0: aa0003f5    	mov	x21, x0
101173ef4: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173ef8: f9456501    	ldr	x1, [x8, #0xac8] ; m_dtVoice
101173efc: aa1403e0    	mov	x0, x20
101173f00: 95aacc8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173f04: aa1d03fd    	mov	x29, x29
101173f08: 95aacc90    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173f0c: aa0003f8    	mov	x24, x0
101173f10: aa1403e0    	mov	x0, x20
101173f14: 95aacc90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173f18: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173f1c: f9447501    	ldr	x1, [x8, #0x8e8] ; OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:
101173f20: d2800028    	mov	x8, #0x1                ; =1
101173f24: f2c00068    	movk	x8, #0x3, lsl #32
101173f28: a900a3f8    	stp	x24, x8, [sp, #0x8]
101173f2c: b90003f5    	str	w21, [sp]
101173f30: aa1703e0    	mov	x0, x23
101173f34: aa1603e2    	mov	x2, x22
101173f38: b9401fe3    	ldr	w3, [sp, #0x1c]
101173f3c: aa1903e4    	mov	x4, x25
101173f40: aa1a03e5    	mov	x5, x26
101173f44: aa1b03e6    	mov	x6, x27
101173f48: aa1c03e7    	mov	x7, x28
101173f4c: 95aacc7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173f50: aa1803e0    	mov	x0, x24
101173f54: 95aacc80    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173f58: aa1603e0    	mov	x0, x22
101173f5c: 95aacc7e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173f60: aa1703e0    	mov	x0, x23
101173f64: 95aacc7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173f68: f00e23c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101173f6c: f947e108    	ldr	x8, [x8, #0xfc0]
101173f70: f90017e8    	str	x8, [sp, #0x28]
101173f74: d00be068    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101173f78: fd41c100    	ldr	d0, [x8, #0x380]
101173f7c: 90000008    	adrp	x8, 0x101173000 <__text+0x116b000>
101173f80: 913f4108    	add	x8, x8, #0xfd0
101173f84: fd001be0    	str	d0, [sp, #0x30]
101173f88: f00e2409    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
101173f8c: 9115c129    	add	x9, x9, #0x570
101173f90: a903a7e8    	stp	x8, x9, [sp, #0x38]
101173f94: f90027f3    	str	x19, [sp, #0x48]
101173f98: 900e23e0    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101173f9c: f9408c00    	ldr	x0, [x0, #0x118]
101173fa0: 9100a3e1    	add	x1, sp, #0x28
101173fa4: 95aa649f    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
101173fa8: f94013e0    	ldr	x0, [sp, #0x20]
101173fac: 95aacc6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173fb0: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
101173fb4: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
101173fb8: a94957f6    	ldp	x22, x21, [sp, #0x90]
101173fbc: a9485ff8    	ldp	x24, x23, [sp, #0x80]
101173fc0: a94767fa    	ldp	x26, x25, [sp, #0x70]
101173fc4: a9466ffc    	ldp	x28, x27, [sp, #0x60]
101173fc8: 910303ff    	add	sp, sp, #0xc0
101173fcc: d65f03c0    	ret
101173fd0: f9401000    	ldr	x0, [x0, #0x20]
101173fd4: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173fd8: f9443501    	ldr	x1, [x8, #0x868] ; startDownload
101173fdc: 15aacc58    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>