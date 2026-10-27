
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a769ec: d101c3ff    	sub	sp, sp, #0x70
104a769f0: a90267fa    	stp	x26, x25, [sp, #0x20]
104a769f4: a9035ff8    	stp	x24, x23, [sp, #0x30]
104a769f8: a90457f6    	stp	x22, x21, [sp, #0x40]
104a769fc: a9054ff4    	stp	x20, x19, [sp, #0x50]
104a76a00: a9067bfd    	stp	x29, x30, [sp, #0x60]
104a76a04: 910183fd    	add	x29, sp, #0x60
104a76a08: aa0003f3    	mov	x19, x0
104a76a0c: 900e0e48    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a76a10: 52800029    	mov	w9, #0x1                ; =1
104a76a14: 390b3909    	strb	w9, [x8, #0x2ce]
104a76a18: d00db7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a76a1c: f9400116    	ldr	x22, [x8]
104a76a20: f9400400    	ldr	x0, [x0, #0x8]
104a76a24: b00d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a76a28: f947d914    	ldr	x20, [x8, #0xfb0] ; m_contact
104a76a2c: aa1403e1    	mov	x1, x20
104a76a30: 94c6c1c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76a34: aa1d03fd    	mov	x29, x29
104a76a38: 94c6c1c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76a3c: aa0003f7    	mov	x23, x0
104a76a40: b00d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a76a44: f9434d15    	ldr	x21, [x8, #0x698] ; m_nsUsrName
104a76a48: aa1503e1    	mov	x1, x21
104a76a4c: 94c6c1bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76a50: aa1d03fd    	mov	x29, x29
104a76a54: 94c6c1bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76a58: aa0003f8    	mov	x24, x0
104a76a5c: d00d9e48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a76a60: f946c901    	ldr	x1, [x8, #0xd90] ; IsChatRoom:
104a76a64: aa1603e0    	mov	x0, x22
104a76a68: aa1803e2    	mov	x2, x24
104a76a6c: 94c6c1b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76a70: aa0003f6    	mov	x22, x0
104a76a74: aa1803e0    	mov	x0, x24
104a76a78: 94c6c1b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76a7c: aa1703e0    	mov	x0, x23
104a76a80: 94c6c1b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76a84: 34000bb6    	cbz	w22, 0x104a76bf8 <_Flutter_MMFoundation_BindContext+0xf527dc>
104a76a88: 39404a68    	ldrb	w8, [x19, #0x12]
104a76a8c: b00db469    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
104a76a90: f946e937    	ldr	x23, [x9, #0xdd0] ; length
104a76a94: 370000a8    	tbnz	w8, #0x0, 0x104a76aa8 <_Flutter_MMFoundation_BindContext+0xf5268c>
104a76a98: f9404260    	ldr	x0, [x19, #0x80]
104a76a9c: aa1703e1    	mov	x1, x23
104a76aa0: 94c6c1a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76aa4: b5001de0    	cbnz	x0, 0x104a76e60 <_Flutter_MMFoundation_BindContext+0xf52a44>
104a76aa8: b00db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a76aac: f9478116    	ldr	x22, [x8, #0xf00] ; CContact
104a76ab0: f9400660    	ldr	x0, [x19, #0x8]
104a76ab4: aa1403e1    	mov	x1, x20
104a76ab8: 94c6c1a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76abc: aa1d03fd    	mov	x29, x29
104a76ac0: 94c6c1a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76ac4: aa0003f8    	mov	x24, x0
104a76ac8: 900d9f68    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
104a76acc: f9425901    	ldr	x1, [x8, #0x4b0] ; genChatRoomName:
104a76ad0: aa1603e0    	mov	x0, x22
104a76ad4: aa1803e2    	mov	x2, x24
104a76ad8: 94c6c199    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76adc: aa1d03fd    	mov	x29, x29
104a76ae0: 94c6c19a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76ae4: aa0003f6    	mov	x22, x0
104a76ae8: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76aec: f9419901    	ldr	x1, [x8, #0x330] ; setM_textForNameLabel:
104a76af0: aa1303e0    	mov	x0, x19
104a76af4: aa1603e2    	mov	x2, x22
104a76af8: 94c6c191    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76afc: aa1603e0    	mov	x0, x22
104a76b00: 94c6c195    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76b04: aa1803e0    	mov	x0, x24
104a76b08: 94c6c193    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76b0c: b00db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a76b10: f9453518    	ldr	x24, [x8, #0xa68] ; iConsole
104a76b14: b00da068    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a76b18: f9404101    	ldr	x1, [x8, #0x80] ; m_textForNameLabel
104a76b1c: aa1303e0    	mov	x0, x19
104a76b20: 94c6c187    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76b24: aa1d03fd    	mov	x29, x29
104a76b28: 94c6c188    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76b2c: aa0003f6    	mov	x22, x0
104a76b30: aa1703e1    	mov	x1, x23
104a76b34: 94c6c182    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76b38: aa0003f7    	mov	x23, x0
104a76b3c: b00db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a76b40: f9454519    	ldr	x25, [x8, #0xa88]
104a76b44: f9400660    	ldr	x0, [x19, #0x8]
104a76b48: aa1403e1    	mov	x1, x20
104a76b4c: 94c6c17c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76b50: aa1d03fd    	mov	x29, x29
104a76b54: 94c6c17d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76b58: aa0003f4    	mov	x20, x0
104a76b5c: aa1503e1    	mov	x1, x21
104a76b60: 94c6c177    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76b64: aa1d03fd    	mov	x29, x29
104a76b68: 94c6c178    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76b6c: aa0003f5    	mov	x21, x0
104a76b70: d00d9e28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a76b74: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104a76b78: aa1903e0    	mov	x0, x25
104a76b7c: aa1503e2    	mov	x2, x21
104a76b80: 94c6c16f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76b84: aa1d03fd    	mov	x29, x29
104a76b88: 94c6c170    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76b8c: aa0003f9    	mov	x25, x0
104a76b90: f00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a76b94: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104a76b98: a90083f7    	stp	x23, x0, [sp, #0x8]
104a76b9c: d00ce928    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a76ba0: 912f2108    	add	x8, x8, #0xbc8 ; CFString 'make session title with len %lu for %@'
104a76ba4: f90003e8    	str	x8, [sp]
104a76ba8: b00b6bc5    	adrp	x5, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a76bac: 9123fca5    	add	x5, x5, #0x8ff
104a76bb0: b00b6bc7    	adrp	x7, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a76bb4: 912450e7    	add	x7, x7, #0x914
104a76bb8: aa1803e0    	mov	x0, x24
104a76bbc: 52800042    	mov	w2, #0x2                ; =2
104a76bc0: d2800003    	mov	x3, #0x0                ; =0
104a76bc4: 52800004    	mov	w4, #0x0                ; =0
104a76bc8: 52801e06    	mov	w6, #0xf0               ; =240
104a76bcc: 94c6c15c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76bd0: aa1903e0    	mov	x0, x25
104a76bd4: 94c6c160    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76bd8: aa1503e0    	mov	x0, x21
104a76bdc: 94c6c15e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76be0: aa1403e0    	mov	x0, x20
104a76be4: 94c6c15c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76be8: aa1603e0    	mov	x0, x22
104a76bec: 94c6c15a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76bf0: 39004a7f    	strb	wzr, [x19, #0x12]
104a76bf4: 1400009b    	b	0x104a76e60 <_Flutter_MMFoundation_BindContext+0xf52a44>
104a76bf8: f9400660    	ldr	x0, [x19, #0x8]
104a76bfc: aa1403e1    	mov	x1, x20
104a76c00: 94c6c14f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76c04: aa1d03fd    	mov	x29, x29
104a76c08: 94c6c150    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76c0c: aa0003f6    	mov	x22, x0
104a76c10: b00d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a76c14: f947bd01    	ldr	x1, [x8, #0xf78] ; m_isPlugin
104a76c18: 94c6c149    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76c1c: aa0003f8    	mov	x24, x0
104a76c20: aa1603e0    	mov	x0, x22
104a76c24: 94c6c14c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76c28: f00db7f9    	adrp	x25, 0x120175000 <dyld_stub_binder+0x120175000>
104a76c2c: f940d737    	ldr	x23, [x25, #0x1a8] ; PluginUtil
104a76c30: f9400660    	ldr	x0, [x19, #0x8]
104a76c34: aa1403e1    	mov	x1, x20
104a76c38: 94c6c141    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76c3c: aa1d03fd    	mov	x29, x29
104a76c40: 94c6c142    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76c44: aa0003f6    	mov	x22, x0
104a76c48: 34000998    	cbz	w24, 0x104a76d78 <_Flutter_MMFoundation_BindContext+0xf5295c>
104a76c4c: 900d9ea8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104a76c50: f9455501    	ldr	x1, [x8, #0xaa8] ; getPluginContactType:
104a76c54: aa1703e0    	mov	x0, x23
104a76c58: aa1603e2    	mov	x2, x22
104a76c5c: 94c6c138    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76c60: aa0003f5    	mov	x21, x0
104a76c64: aa1603e0    	mov	x0, x22
104a76c68: 94c6c13b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76c6c: f9400660    	ldr	x0, [x19, #0x8]
104a76c70: aa1403e1    	mov	x1, x20
104a76c74: 94c6c132    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76c78: aa1d03fd    	mov	x29, x29
104a76c7c: 94c6c133    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76c80: aa0003f7    	mov	x23, x0
104a76c84: b00d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a76c88: f9435101    	ldr	x1, [x8, #0x6a0] ; m_nsNickName
104a76c8c: 94c6c12c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76c90: aa1d03fd    	mov	x29, x29
104a76c94: 94c6c12d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76c98: aa0003f8    	mov	x24, x0
104a76c9c: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76ca0: f9419916    	ldr	x22, [x8, #0x330] ; setM_textForNameLabel:
104a76ca4: aa1303e0    	mov	x0, x19
104a76ca8: aa1603e1    	mov	x1, x22
104a76cac: aa1803e2    	mov	x2, x24
104a76cb0: 94c6c123    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76cb4: aa1803e0    	mov	x0, x24
104a76cb8: 94c6c127    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76cbc: aa1703e0    	mov	x0, x23
104a76cc0: 94c6c125    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76cc4: f9400660    	ldr	x0, [x19, #0x8]
104a76cc8: aa1403e1    	mov	x1, x20
104a76ccc: 94c6c11c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76cd0: aa1d03fd    	mov	x29, x29
104a76cd4: 94c6c11d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76cd8: aa0003f4    	mov	x20, x0
104a76cdc: f00d9f08    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104a76ce0: f9422d01    	ldr	x1, [x8, #0x458] ; isPluginPresentedContact
104a76ce4: 94c6c116    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76ce8: aa0003f7    	mov	x23, x0
104a76cec: aa1403e0    	mov	x0, x20
104a76cf0: 94c6c119    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76cf4: 340001f7    	cbz	w23, 0x104a76d30 <_Flutter_MMFoundation_BindContext+0xf52914>
104a76cf8: f940d720    	ldr	x0, [x25, #0x1a8] ; PluginUtil
104a76cfc: 900da088    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
104a76d00: f947c901    	ldr	x1, [x8, #0xf90] ; getPluginLocalizedNickName:
104a76d04: aa1503e2    	mov	x2, x21
104a76d08: 94c6c10d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76d0c: aa1d03fd    	mov	x29, x29
104a76d10: 94c6c10e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76d14: aa0003f4    	mov	x20, x0
104a76d18: aa1303e0    	mov	x0, x19
104a76d1c: aa1603e1    	mov	x1, x22
104a76d20: aa1403e2    	mov	x2, x20
104a76d24: 94c6c106    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76d28: aa1403e0    	mov	x0, x20
104a76d2c: 94c6c10a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76d30: f9404260    	ldr	x0, [x19, #0x80]
104a76d34: b00db468    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a76d38: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104a76d3c: 94c6c100    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76d40: b5000900    	cbnz	x0, 0x104a76e60 <_Flutter_MMFoundation_BindContext+0xf52a44>
104a76d44: f940d720    	ldr	x0, [x25, #0x1a8] ; PluginUtil
104a76d48: 900da088    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
104a76d4c: f947c901    	ldr	x1, [x8, #0xf90] ; getPluginLocalizedNickName:
104a76d50: aa1503e2    	mov	x2, x21
104a76d54: 94c6c0fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76d58: aa1d03fd    	mov	x29, x29
104a76d5c: 94c6c0fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76d60: aa0003f4    	mov	x20, x0
104a76d64: aa1303e0    	mov	x0, x19
104a76d68: aa1603e1    	mov	x1, x22
104a76d6c: aa1403e2    	mov	x2, x20
104a76d70: 94c6c0f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76d74: 14000039    	b	0x104a76e58 <_Flutter_MMFoundation_BindContext+0xf52a3c>
104a76d78: 900d9ea8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104a76d7c: f940e501    	ldr	x1, [x8, #0x1c8] ; isOfficialContact:
104a76d80: aa1703e0    	mov	x0, x23
104a76d84: aa1603e2    	mov	x2, x22
104a76d88: 94c6c0ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76d8c: aa0003f7    	mov	x23, x0
104a76d90: aa1603e0    	mov	x0, x22
104a76d94: 94c6c0f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76d98: 340003b7    	cbz	w23, 0x104a76e0c <_Flutter_MMFoundation_BindContext+0xf529f0>
104a76d9c: f940d736    	ldr	x22, [x25, #0x1a8] ; PluginUtil
104a76da0: f9400660    	ldr	x0, [x19, #0x8]
104a76da4: aa1403e1    	mov	x1, x20
104a76da8: 94c6c0e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76dac: aa1d03fd    	mov	x29, x29
104a76db0: 94c6c0e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76db4: aa0003f4    	mov	x20, x0
104a76db8: aa1503e1    	mov	x1, x21
104a76dbc: 94c6c0e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76dc0: aa1d03fd    	mov	x29, x29
104a76dc4: 94c6c0e1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76dc8: aa0003f5    	mov	x21, x0
104a76dcc: 900da088    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
104a76dd0: f947e101    	ldr	x1, [x8, #0xfc0] ; getOfficialLocNickNameWithUserName:
104a76dd4: aa1603e0    	mov	x0, x22
104a76dd8: aa1503e2    	mov	x2, x21
104a76ddc: 94c6c0d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76de0: aa1d03fd    	mov	x29, x29
104a76de4: 94c6c0d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76de8: aa0003f6    	mov	x22, x0
104a76dec: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76df0: f9419901    	ldr	x1, [x8, #0x330] ; setM_textForNameLabel:
104a76df4: aa1303e0    	mov	x0, x19
104a76df8: aa1603e2    	mov	x2, x22
104a76dfc: 94c6c0d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76e00: aa1603e0    	mov	x0, x22
104a76e04: 94c6c0d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76e08: 14000012    	b	0x104a76e50 <_Flutter_MMFoundation_BindContext+0xf52a34>
104a76e0c: f9400660    	ldr	x0, [x19, #0x8]
104a76e10: aa1403e1    	mov	x1, x20
104a76e14: 94c6c0ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76e18: aa1d03fd    	mov	x29, x29
104a76e1c: 94c6c0cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76e20: aa0003f4    	mov	x20, x0
104a76e24: d00d9e28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a76e28: f944c501    	ldr	x1, [x8, #0x988] ; getContactDisplayName
104a76e2c: 94c6c0c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76e30: aa1d03fd    	mov	x29, x29
104a76e34: 94c6c0c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76e38: aa0003f5    	mov	x21, x0
104a76e3c: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76e40: f9419901    	ldr	x1, [x8, #0x330] ; setM_textForNameLabel:
104a76e44: aa1303e0    	mov	x0, x19
104a76e48: aa1503e2    	mov	x2, x21
104a76e4c: 94c6c0bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76e50: aa1503e0    	mov	x0, x21
104a76e54: 94c6c0c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76e58: aa1403e0    	mov	x0, x20
104a76e5c: 94c6c0be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76e60: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76e64: f9418d01    	ldr	x1, [x8, #0x318] ; updateWidthForNameLabel
104a76e68: aa1303e0    	mov	x0, x19
104a76e6c: 94c6c0b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76e70: 52800028    	mov	w8, #0x1                ; =1
104a76e74: 39004668    	strb	w8, [x19, #0x11]
104a76e78: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104a76e7c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104a76e80: a94457f6    	ldp	x22, x21, [sp, #0x40]
104a76e84: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104a76e88: a94267fa    	ldp	x26, x25, [sp, #0x20]
104a76e8c: 9101c3ff    	add	sp, sp, #0x70
104a76e90: d65f03c0    	ret
