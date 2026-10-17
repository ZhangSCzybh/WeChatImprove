
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10117385c: d10303ff    	sub	sp, sp, #0xc0
101173860: a9066ffc    	stp	x28, x27, [sp, #0x60]
101173864: a90767fa    	stp	x26, x25, [sp, #0x70]
101173868: a9085ff8    	stp	x24, x23, [sp, #0x80]
10117386c: a90957f6    	stp	x22, x21, [sp, #0x90]
101173870: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
101173874: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
101173878: 9102c3fd    	add	x29, sp, #0xb0
10117387c: aa0203f3    	mov	x19, x2
101173880: aa0003f4    	mov	x20, x0
101173884: d00fd5e8    	adrp	x8, 0x120c31000 <dyld_stub_binder+0x120c31000>
101173888: 52800029    	mov	w9, #0x1                ; =1
10117388c: 39095109    	strb	w9, [x8, #0x254]
101173890: aa0203e0    	mov	x0, x2
101173894: 95aace29    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101173898: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
10117389c: f9447901    	ldr	x1, [x8, #0x8f0] ; setBDownloading:
1011738a0: aa1403e0    	mov	x0, x20
1011738a4: 52800002    	mov	w2, #0x0                ; =0
1011738a8: 95aace25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011738ac: 900f8008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1011738b0: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
1011738b4: d00f6628    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1011738b8: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1011738bc: f00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
1011738c0: 9119a108    	add	x8, x8, #0x668
1011738c4: f90003e8    	str	x8, [sp]
1011738c8: d00d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
1011738cc: 9107f063    	add	x3, x3, #0x1fc
1011738d0: b00d1045    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011738d4: 9108b0a5    	add	x5, x5, #0x22c
1011738d8: b00d1047    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
1011738dc: 911928e7    	add	x7, x7, #0x64a
1011738e0: aa1703e1    	mov	x1, x23
1011738e4: 52800042    	mov	w2, #0x2                ; =2
1011738e8: 52800004    	mov	w4, #0x0                ; =0
1011738ec: 52802946    	mov	w6, #0x14a              ; =330
1011738f0: 95aace13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011738f4: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011738f8: f9449d01    	ldr	x1, [x8, #0x938] ; reportDownloadCDNFail:
1011738fc: aa1403e0    	mov	x0, x20
101173900: aa1303e2    	mov	x2, x19
101173904: 95aace0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173908: 900f8008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10117390c: f9454515    	ldr	x21, [x8, #0xa88]
101173910: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173914: f9448518    	ldr	x24, [x8, #0x908] ; m_nsChatUsrName
101173918: aa1303e0    	mov	x0, x19
10117391c: aa1803e1    	mov	x1, x24
101173920: 95aace07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173924: aa1d03fd    	mov	x29, x29
101173928: 95aace08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10117392c: aa0003f9    	mov	x25, x0
101173930: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173934: f9467516    	ldr	x22, [x8, #0xce8] ; m_uiLocalID
101173938: aa1303e0    	mov	x0, x19
10117393c: aa1603e1    	mov	x1, x22
101173940: 95aacdff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173944: f00f7ca8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101173948: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10117394c: a90003f9    	stp	x25, x0, [sp]
101173950: d00e9e82    	adrp	x2, 0x11e545000 <dyld_stub_binder+0x11e545000>
101173954: 9134a042    	add	x2, x2, #0xd28
101173958: aa1503e0    	mov	x0, x21
10117395c: 95aacdf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173960: aa1d03fd    	mov	x29, x29
101173964: 95aacdf9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173968: aa0003f5    	mov	x21, x0
10117396c: aa1903e0    	mov	x0, x25
101173970: 95aacdf9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173974: b00f7c88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101173978: f9402d01    	ldr	x1, [x8, #0x58] ; lock
10117397c: aa1403e0    	mov	x0, x20
101173980: 95aacdef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173984: aa1d03fd    	mov	x29, x29
101173988: 95aacdf0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10117398c: aa0003f9    	mov	x25, x0
101173990: 910143e0    	add	x0, sp, #0x50
101173994: aa1903e1    	mov	x1, x25
101173998: 95aa6666    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
10117399c: aa1903e0    	mov	x0, x25
1011739a0: 95aacded    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011739a4: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011739a8: f9442d01    	ldr	x1, [x8, #0x858] ; readyDownloadItems
1011739ac: aa1403e0    	mov	x0, x20
1011739b0: 95aacde3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011739b4: aa1d03fd    	mov	x29, x29
1011739b8: 95aacde4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1011739bc: aa0003f9    	mov	x25, x0
1011739c0: 900f6648    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1011739c4: f9462101    	ldr	x1, [x8, #0xc40] ; safeRemoveObjectForKey:
1011739c8: aa1503e2    	mov	x2, x21
1011739cc: 95aacddc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011739d0: aa1903e0    	mov	x0, x25
1011739d4: 95aacde0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1011739d8: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
1011739dc: f9445901    	ldr	x1, [x8, #0x8b0] ; updateItemToPB
1011739e0: aa1403e0    	mov	x0, x20
1011739e4: 95aacdd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1011739e8: 910143e0    	add	x0, sp, #0x50
1011739ec: 95aa6652    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
1011739f0: b00f7c68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1011739f4: f946f11a    	ldr	x26, [x8, #0xde0] ; delegate
1011739f8: aa1403e0    	mov	x0, x20
1011739fc: aa1a03e1    	mov	x1, x26
101173a00: 95aacdcf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173a04: aa1d03fd    	mov	x29, x29
101173a08: 95aacdd0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173a0c: aa0003fb    	mov	x27, x0
101173a10: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173a14: f944a119    	ldr	x25, [x8, #0x940] ; onCDNDownloadFail:LocalID:n64SvrID:CreateTime:Xml:
101173a18: f00f7c88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101173a1c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101173a20: aa1903e2    	mov	x2, x25
101173a24: 95aacdc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173a28: aa0003fc    	mov	x28, x0
101173a2c: aa1b03e0    	mov	x0, x27
101173a30: 95aacdc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173a34: 3400077c    	cbz	w28, 0x101173b20 <__text+0x116bb20>
101173a38: 900f8008    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101173a3c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
101173a40: f00e9ee8    	adrp	x8, 0x11e552000 <dyld_stub_binder+0x11e552000>
101173a44: 911a2108    	add	x8, x8, #0x688
101173a48: f90003e8    	str	x8, [sp]
101173a4c: d00d0583    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
101173a50: 9107f063    	add	x3, x3, #0x1fc
101173a54: b00d1045    	adrp	x5, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101173a58: 9108b0a5    	add	x5, x5, #0x22c
101173a5c: b00d1047    	adrp	x7, 0x11b37c000 <dyld_stub_binder+0x11b37c000>
101173a60: 911928e7    	add	x7, x7, #0x64a
101173a64: aa1703e1    	mov	x1, x23
101173a68: 52800042    	mov	w2, #0x2                ; =2
101173a6c: 52800004    	mov	w4, #0x0                ; =0
101173a70: 52802a86    	mov	w6, #0x154              ; =340
101173a74: 95aacdb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173a78: aa1403e0    	mov	x0, x20
101173a7c: aa1a03e1    	mov	x1, x26
101173a80: 95aacdaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173a84: aa1d03fd    	mov	x29, x29
101173a88: 95aacdb0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173a8c: aa0003f7    	mov	x23, x0
101173a90: aa1303e0    	mov	x0, x19
101173a94: aa1803e1    	mov	x1, x24
101173a98: 95aacda9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173a9c: aa1d03fd    	mov	x29, x29
101173aa0: 95aacdaa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173aa4: aa0003f8    	mov	x24, x0
101173aa8: aa1303e0    	mov	x0, x19
101173aac: aa1603e1    	mov	x1, x22
101173ab0: 95aacda3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173ab4: aa0003f6    	mov	x22, x0
101173ab8: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173abc: f9467901    	ldr	x1, [x8, #0xcf0] ; m_n64SvrID
101173ac0: aa1303e0    	mov	x0, x19
101173ac4: 95aacd9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173ac8: aa0003fb    	mov	x27, x0
101173acc: b00f6648    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101173ad0: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
101173ad4: aa1303e0    	mov	x0, x19
101173ad8: 95aacd99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173adc: aa0003fc    	mov	x28, x0
101173ae0: b00f6708    	adrp	x8, 0x11fe54000 <dyld_stub_binder+0x11fe54000>
101173ae4: f944ed01    	ldr	x1, [x8, #0x9d8] ; xml
101173ae8: aa1303e0    	mov	x0, x19
101173aec: 95aacd94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173af0: aa1d03fd    	mov	x29, x29
101173af4: 95aacd95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173af8: aa0003fa    	mov	x26, x0
101173afc: aa1703e0    	mov	x0, x23
101173b00: aa1903e1    	mov	x1, x25
101173b04: aa1803e2    	mov	x2, x24
101173b08: aa1603e3    	mov	x3, x22
101173b0c: aa1b03e4    	mov	x4, x27
101173b10: aa1c03e5    	mov	x5, x28
101173b14: aa1a03e6    	mov	x6, x26
101173b18: 95aacd89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b1c: 14000040    	b	0x101173c1c <__text+0x116bc1c>
101173b20: aa1403e0    	mov	x0, x20
101173b24: aa1a03e1    	mov	x1, x26
101173b28: 95aacd85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b2c: aa1d03fd    	mov	x29, x29
101173b30: 95aacd86    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173b34: aa0003f7    	mov	x23, x0
101173b38: aa1303e0    	mov	x0, x19
101173b3c: aa1803e1    	mov	x1, x24
101173b40: 95aacd7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b44: aa1d03fd    	mov	x29, x29
101173b48: 95aacd80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173b4c: aa0003f8    	mov	x24, x0
101173b50: aa1303e0    	mov	x0, x19
101173b54: aa1603e1    	mov	x1, x22
101173b58: 95aacd79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b5c: b90027e0    	str	w0, [sp, #0x24]
101173b60: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173b64: f9467901    	ldr	x1, [x8, #0xcf0] ; m_n64SvrID
101173b68: aa1303e0    	mov	x0, x19
101173b6c: 95aacd74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b70: f9000fe0    	str	x0, [sp, #0x18]
101173b74: b00f6648    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101173b78: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
101173b7c: aa1303e0    	mov	x0, x19
101173b80: 95aacd6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b84: aa0003fb    	mov	x27, x0
101173b88: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173b8c: f943ed01    	ldr	x1, [x8, #0x7d8] ; m_uiVoiceTime
101173b90: aa1303e0    	mov	x0, x19
101173b94: 95aacd6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173b98: aa0003fc    	mov	x28, x0
101173b9c: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173ba0: f9467d01    	ldr	x1, [x8, #0xcf8] ; m_uiOffset
101173ba4: aa1303e0    	mov	x0, x19
101173ba8: 95aacd65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173bac: aa1503f9    	mov	x25, x21
101173bb0: aa0003f5    	mov	x21, x0
101173bb4: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173bb8: f9468101    	ldr	x1, [x8, #0xd00] ; m_uiLen
101173bbc: aa1303e0    	mov	x0, x19
101173bc0: 95aacd5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173bc4: aa0003f6    	mov	x22, x0
101173bc8: 900f6688    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
101173bcc: f9456501    	ldr	x1, [x8, #0xac8] ; m_dtVoice
101173bd0: aa1303e0    	mov	x0, x19
101173bd4: 95aacd5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173bd8: aa1d03fd    	mov	x29, x29
101173bdc: 95aacd5b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101173be0: aa0003fa    	mov	x26, x0
101173be4: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173be8: f9447501    	ldr	x1, [x8, #0x8e8] ; OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:
101173bec: d2c00088    	mov	x8, #0x400000000        ; =17179869184
101173bf0: a900a3e0    	stp	x0, x8, [sp, #0x8]
101173bf4: b90003f6    	str	w22, [sp]
101173bf8: aa1703e0    	mov	x0, x23
101173bfc: aa1803e2    	mov	x2, x24
101173c00: b94027e3    	ldr	w3, [sp, #0x24]
101173c04: f9400fe4    	ldr	x4, [sp, #0x18]
101173c08: aa1b03e5    	mov	x5, x27
101173c0c: aa1c03e6    	mov	x6, x28
101173c10: aa1503e7    	mov	x7, x21
101173c14: aa1903f5    	mov	x21, x25
101173c18: 95aacd49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101173c1c: aa1a03e0    	mov	x0, x26
101173c20: 95aacd4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173c24: aa1803e0    	mov	x0, x24
101173c28: 95aacd4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173c2c: aa1703e0    	mov	x0, x23
101173c30: 95aacd49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173c34: f00e23c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101173c38: f947e108    	ldr	x8, [x8, #0xfc0]
101173c3c: f90017e8    	str	x8, [sp, #0x28]
101173c40: d00be068    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101173c44: fd41c100    	ldr	d0, [x8, #0x380]
101173c48: 90000008    	adrp	x8, 0x101173000 <__text+0x116b000>
101173c4c: 91329108    	add	x8, x8, #0xca4
101173c50: fd001be0    	str	d0, [sp, #0x30]
101173c54: f00e2409    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
101173c58: 9115c129    	add	x9, x9, #0x570
101173c5c: a903a7e8    	stp	x8, x9, [sp, #0x38]
101173c60: f90027f4    	str	x20, [sp, #0x48]
101173c64: 900e23e0    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101173c68: f9408c00    	ldr	x0, [x0, #0x118]
101173c6c: 9100a3e1    	add	x1, sp, #0x28
101173c70: 95aa656c    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
101173c74: aa1503e0    	mov	x0, x21
101173c78: 95aacd37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173c7c: aa1303e0    	mov	x0, x19
101173c80: 95aacd35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101173c84: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
101173c88: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
101173c8c: a94957f6    	ldp	x22, x21, [sp, #0x90]
101173c90: a9485ff8    	ldp	x24, x23, [sp, #0x80]
101173c94: a94767fa    	ldp	x26, x25, [sp, #0x70]
101173c98: a9466ffc    	ldp	x28, x27, [sp, #0x60]
101173c9c: 910303ff    	add	sp, sp, #0xc0
101173ca0: d65f03c0    	ret
101173ca4: f9401000    	ldr	x0, [x0, #0x20]
101173ca8: f00f68c8    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
101173cac: f9443501    	ldr	x1, [x8, #0x868] ; startDownload
101173cb0: 15aacd23    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>