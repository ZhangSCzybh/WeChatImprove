
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a76e94: d101c3ff    	sub	sp, sp, #0x70
104a76e98: a9016ffc    	stp	x28, x27, [sp, #0x10]
104a76e9c: a90267fa    	stp	x26, x25, [sp, #0x20]
104a76ea0: a9035ff8    	stp	x24, x23, [sp, #0x30]
104a76ea4: a90457f6    	stp	x22, x21, [sp, #0x40]
104a76ea8: a9054ff4    	stp	x20, x19, [sp, #0x50]
104a76eac: a9067bfd    	stp	x29, x30, [sp, #0x60]
104a76eb0: 910183fd    	add	x29, sp, #0x60
104a76eb4: aa0003f3    	mov	x19, x0
104a76eb8: 900e0e48    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a76ebc: 52800029    	mov	w9, #0x1                ; =1
104a76ec0: 390b3d09    	strb	w9, [x8, #0x2cf]
104a76ec4: 39004409    	strb	w9, [x0, #0x11]
104a76ec8: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76ecc: f9419d01    	ldr	x1, [x8, #0x338] ; setM_textForGreenLabel:
104a76ed0: d2800002    	mov	x2, #0x0                ; =0
104a76ed4: 94c6c09a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76ed8: f9400660    	ldr	x0, [x19, #0x8]
104a76edc: f00d9e68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a76ee0: f944c515    	ldr	x21, [x8, #0x988] ; m_msgWrap
104a76ee4: aa1503e1    	mov	x1, x21
104a76ee8: 94c6c095    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76eec: aa1d03fd    	mov	x29, x29
104a76ef0: 94c6c096    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76ef4: aa0003f4    	mov	x20, x0
104a76ef8: 94c6c097    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76efc: b4000534    	cbz	x20, 0x104a76fa0 <_Flutter_MMFoundation_BindContext+0xf52b84>
104a76f00: d00db7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a76f04: f9400116    	ldr	x22, [x8]
104a76f08: f9400660    	ldr	x0, [x19, #0x8]
104a76f0c: b00d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a76f10: f947d914    	ldr	x20, [x8, #0xfb0] ; m_contact
104a76f14: aa1403e1    	mov	x1, x20
104a76f18: 94c6c089    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76f1c: aa1d03fd    	mov	x29, x29
104a76f20: 94c6c08a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76f24: aa0003f7    	mov	x23, x0
104a76f28: b00d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a76f2c: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
104a76f30: 94c6c083    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76f34: aa1d03fd    	mov	x29, x29
104a76f38: 94c6c084    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76f3c: aa0003f8    	mov	x24, x0
104a76f40: d00d9e48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a76f44: f946c901    	ldr	x1, [x8, #0xd90] ; IsChatRoom:
104a76f48: aa1603e0    	mov	x0, x22
104a76f4c: aa1803e2    	mov	x2, x24
104a76f50: 94c6c07b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76f54: aa0003f6    	mov	x22, x0
104a76f58: aa1803e0    	mov	x0, x24
104a76f5c: 94c6c07e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76f60: aa1703e0    	mov	x0, x23
104a76f64: 94c6c07c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76f68: 34000696    	cbz	w22, 0x104a77038 <_Flutter_MMFoundation_BindContext+0xf52c1c>
104a76f6c: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76f70: f941a101    	ldr	x1, [x8, #0x340] ; getGroupName
104a76f74: aa1303e0    	mov	x0, x19
104a76f78: 94c6c071    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76f7c: aa1d03fd    	mov	x29, x29
104a76f80: 94c6c072    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76f84: aa0003f4    	mov	x20, x0
104a76f88: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76f8c: f941a501    	ldr	x1, [x8, #0x348] ; makeTextSession:
104a76f90: aa1303e0    	mov	x0, x19
104a76f94: aa1403e2    	mov	x2, x20
104a76f98: 94c6c069    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76f9c: 1400024c    	b	0x104a778cc <_Flutter_MMFoundation_BindContext+0xf534b0>
104a76fa0: b00db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a76fa4: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a76fa8: d00db448    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a76fac: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a76fb0: 94c6c063    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76fb4: aa1d03fd    	mov	x29, x29
104a76fb8: 94c6c064    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76fbc: aa0003f4    	mov	x20, x0
104a76fc0: b00db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a76fc4: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
104a76fc8: b00db448    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a76fcc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104a76fd0: 94c6c05b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76fd4: aa0003e2    	mov	x2, x0
104a76fd8: f00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a76fdc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a76fe0: aa1403e0    	mov	x0, x20
104a76fe4: 94c6c056    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76fe8: aa1d03fd    	mov	x29, x29
104a76fec: 94c6c057    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76ff0: aa0003f5    	mov	x21, x0
104a76ff4: f00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a76ff8: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104a76ffc: b00cd1e2    	adrp	x2, 0x11e4b3000 <dyld_stub_binder+0x11e4b3000>
104a77000: 9103a042    	add	x2, x2, #0xe8 ; CFString 'MessageContent_NoMessage'
104a77004: 94c6c04e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77008: aa1d03fd    	mov	x29, x29
104a7700c: 94c6c04f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77010: aa0003f6    	mov	x22, x0
104a77014: 900da068    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a77018: f9406901    	ldr	x1, [x8, #0xd0] ; setM_textForMessageLabel:
104a7701c: aa1303e0    	mov	x0, x19
104a77020: aa1603e2    	mov	x2, x22
104a77024: 94c6c046    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77028: aa1603e0    	mov	x0, x22
104a7702c: 94c6c04a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77030: aa1503e0    	mov	x0, x21
104a77034: 14000225    	b	0x104a778c8 <_Flutter_MMFoundation_BindContext+0xf534ac>
104a77038: f9400660    	ldr	x0, [x19, #0x8]
104a7703c: aa1403e1    	mov	x1, x20
104a77040: 94c6c03f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77044: aa1d03fd    	mov	x29, x29
104a77048: 94c6c040    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7704c: aa0003f7    	mov	x23, x0
104a77050: b00d9f48    	adrp	x8, 0x11fe60000 <dyld_stub_binder+0x11fe60000>
104a77054: f9468d01    	ldr	x1, [x8, #0xd18] ; isEnterpriseChatSubBrand
104a77058: 94c6c039    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7705c: 34001160    	cbz	w0, 0x104a77288 <_Flutter_MMFoundation_BindContext+0xf52e6c>
104a77060: aa1703e0    	mov	x0, x23
104a77064: 94c6c03c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77068: 900d9e68    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104a7706c: f9459d18    	ldr	x24, [x8, #0xb38] ; m_isEnterpriseMsg
104a77070: f9400660    	ldr	x0, [x19, #0x8]
104a77074: aa1503e1    	mov	x1, x21
104a77078: 94c6c031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7707c: aa1d03fd    	mov	x29, x29
104a77080: 94c6c032    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77084: aa0003f4    	mov	x20, x0
104a77088: aa1803e1    	mov	x1, x24
104a7708c: 94c6c02c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77090: 34002580    	cbz	w0, 0x104a77540 <_Flutter_MMFoundation_BindContext+0xf53124>
104a77094: f00d9e28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104a77098: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
104a7709c: aa1403e0    	mov	x0, x20
104a770a0: 94c6c027    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a770a4: 5284e248    	mov	w8, #0x2712             ; =10002
104a770a8: 6b08001f    	cmp	w0, w8
104a770ac: 540024a0    	b.eq	0x104a77540 <_Flutter_MMFoundation_BindContext+0xf53124>
104a770b0: 900db7fb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104a770b4: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
104a770b8: b00db448    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a770bc: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
104a770c0: aa1603e1    	mov	x1, x22
104a770c4: 94c6c01e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a770c8: aa1d03fd    	mov	x29, x29
104a770cc: 94c6c01f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a770d0: aa0003f9    	mov	x25, x0
104a770d4: 900db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a770d8: f9462900    	ldr	x0, [x8, #0xc50] ; MMLanguageMgr
104a770dc: 900db448    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a770e0: f947ad17    	ldr	x23, [x8, #0xf58] ; class
104a770e4: aa1703e1    	mov	x1, x23
104a770e8: 94c6c015    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a770ec: aa0003e2    	mov	x2, x0
104a770f0: d00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a770f4: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
104a770f8: aa1903e0    	mov	x0, x25
104a770fc: aa1803e1    	mov	x1, x24
104a77100: 94c6c00f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77104: aa1d03fd    	mov	x29, x29
104a77108: 94c6c010    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7710c: aa0003fa    	mov	x26, x0
104a77110: d00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a77114: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
104a77118: b00ce922    	adrp	x2, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a7711c: 912fa042    	add	x2, x2, #0xbe8 ; CFString 'Contacts_Me'
104a77120: 94c6c007    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77124: aa1d03fd    	mov	x29, x29
104a77128: 94c6c008    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7712c: aa0003f5    	mov	x21, x0
104a77130: aa1a03e0    	mov	x0, x26
104a77134: 94c6c008    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77138: aa1903e0    	mov	x0, x25
104a7713c: 94c6c006    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77140: b00db7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a77144: f9411d00    	ldr	x0, [x8, #0x238] ; CMessageWrap
104a77148: d00d9e28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a7714c: f9478d01    	ldr	x1, [x8, #0xf18] ; isSenderFromMsgWrap:
104a77150: aa1403e2    	mov	x2, x20
104a77154: 94c6bffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77158: 370007e0    	tbnz	w0, #0x0, 0x104a77254 <_Flutter_MMFoundation_BindContext+0xf52e38>
104a7715c: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
104a77160: aa1603e1    	mov	x1, x22
104a77164: 94c6bff6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77168: aa1d03fd    	mov	x29, x29
104a7716c: 94c6bff7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77170: aa0003f6    	mov	x22, x0
104a77174: b00db808    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
104a77178: f943fd00    	ldr	x0, [x8, #0x7f8] ; EnterpriseContactMgr
104a7717c: aa1703e1    	mov	x1, x23
104a77180: 94c6bfef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77184: aa0003e2    	mov	x2, x0
104a77188: aa1603e0    	mov	x0, x22
104a7718c: aa1803e1    	mov	x1, x24
104a77190: 94c6bfeb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77194: aa1d03fd    	mov	x29, x29
104a77198: 94c6bfec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7719c: aa0003f7    	mov	x23, x0
104a771a0: 900d9e48    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a771a4: f941e901    	ldr	x1, [x8, #0x3d0] ; m_nsRealChatUsr
104a771a8: aa1403e0    	mov	x0, x20
104a771ac: 94c6bfe4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a771b0: aa1d03fd    	mov	x29, x29
104a771b4: 94c6bfe5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a771b8: aa0003f8    	mov	x24, x0
104a771bc: d00d9e28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a771c0: f9429d01    	ldr	x1, [x8, #0x538] ; m_nsFromUsr
104a771c4: aa1403e0    	mov	x0, x20
104a771c8: 94c6bfdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a771cc: aa1d03fd    	mov	x29, x29
104a771d0: 94c6bfde    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a771d4: aa0003f9    	mov	x25, x0
104a771d8: 900da088    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
104a771dc: f9408d01    	ldr	x1, [x8, #0x118] ; getOrAddContactByUserName:brand:toDB:inDB:
104a771e0: aa1703e0    	mov	x0, x23
104a771e4: aa1803e2    	mov	x2, x24
104a771e8: aa1903e3    	mov	x3, x25
104a771ec: 52800004    	mov	w4, #0x0                ; =0
104a771f0: d2800005    	mov	x5, #0x0                ; =0
104a771f4: 94c6bfd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a771f8: aa1d03fd    	mov	x29, x29
104a771fc: 94c6bfd3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77200: aa0003fa    	mov	x26, x0
104a77204: aa1903e0    	mov	x0, x25
104a77208: 94c6bfd3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7720c: aa1803e0    	mov	x0, x24
104a77210: 94c6bfd1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77214: aa1703e0    	mov	x0, x23
104a77218: 94c6bfcf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7721c: aa1603e0    	mov	x0, x22
104a77220: 94c6bfcd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77224: f00d9e88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104a77228: f9452101    	ldr	x1, [x8, #0xa40] ; m_nsContactDisplayName
104a7722c: aa1a03e0    	mov	x0, x26
104a77230: 94c6bfc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77234: aa1d03fd    	mov	x29, x29
104a77238: 94c6bfc4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7723c: aa0003f6    	mov	x22, x0
104a77240: aa1503e0    	mov	x0, x21
104a77244: 94c6bfc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77248: aa1a03e0    	mov	x0, x26
104a7724c: 94c6bfc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77250: aa1603f5    	mov	x21, x22
104a77254: 900db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a77258: f9454500    	ldr	x0, [x8, #0xa88]
104a7725c: f00db488    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a77260: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a77264: f90003f5    	str	x21, [sp]
104a77268: b00cd842    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a7726c: 91202042    	add	x2, x2, #0x808 ; CFString '%@: '
104a77270: 94c6bfb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77274: aa1d03fd    	mov	x29, x29
104a77278: 94c6bfb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7727c: aa0003f6    	mov	x22, x0
104a77280: aa1503e0    	mov	x0, x21
104a77284: 1400018a    	b	0x104a778ac <_Flutter_MMFoundation_BindContext+0xf53490>
104a77288: f9400660    	ldr	x0, [x19, #0x8]
104a7728c: aa1403e1    	mov	x1, x20
104a77290: 94c6bfab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77294: aa1d03fd    	mov	x29, x29
104a77298: 94c6bfac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7729c: aa0003f9    	mov	x25, x0
104a772a0: b00d9ea8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104a772a4: f940f916    	ldr	x22, [x8, #0x1f0] ; isEnterpriseMainBrand
104a772a8: aa1603e1    	mov	x1, x22
104a772ac: 94c6bfa4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a772b0: 36000280    	tbz	w0, #0x0, 0x104a77300 <_Flutter_MMFoundation_BindContext+0xf52ee4>
104a772b4: f9400660    	ldr	x0, [x19, #0x8]
104a772b8: aa1503e1    	mov	x1, x21
104a772bc: 94c6bfa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a772c0: aa1d03fd    	mov	x29, x29
104a772c4: 94c6bfa1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a772c8: aa0003fa    	mov	x26, x0
104a772cc: 900d9e68    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104a772d0: f9459d18    	ldr	x24, [x8, #0xb38] ; m_isEnterpriseMsg
104a772d4: aa1803e1    	mov	x1, x24
104a772d8: 94c6bf99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a772dc: aa0003fb    	mov	x27, x0
104a772e0: aa1a03e0    	mov	x0, x26
104a772e4: 94c6bf9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a772e8: aa1903e0    	mov	x0, x25
104a772ec: 94c6bf9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a772f0: aa1703e0    	mov	x0, x23
104a772f4: 94c6bf98    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a772f8: 35ffebdb    	cbnz	w27, 0x104a77070 <_Flutter_MMFoundation_BindContext+0xf52c54>
104a772fc: 14000005    	b	0x104a77310 <_Flutter_MMFoundation_BindContext+0xf52ef4>
104a77300: aa1903e0    	mov	x0, x25
104a77304: 94c6bf94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77308: aa1703e0    	mov	x0, x23
104a7730c: 94c6bf92    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77310: d00db7e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104a77314: f940d517    	ldr	x23, [x8, #0x1a8] ; PluginUtil
104a77318: f9400660    	ldr	x0, [x19, #0x8]
104a7731c: aa1403e1    	mov	x1, x20
104a77320: 94c6bf87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77324: aa1d03fd    	mov	x29, x29
104a77328: 94c6bf88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7732c: aa0003f8    	mov	x24, x0
104a77330: f00d9e88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104a77334: f9455501    	ldr	x1, [x8, #0xaa8] ; getPluginContactType:
104a77338: aa1703e0    	mov	x0, x23
104a7733c: aa1803e2    	mov	x2, x24
104a77340: 94c6bf7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77344: aa0003f7    	mov	x23, x0
104a77348: aa1803e0    	mov	x0, x24
104a7734c: 94c6bf82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77350: f1002eff    	cmp	x23, #0xb
104a77354: 54000361    	b.ne	0x104a773c0 <_Flutter_MMFoundation_BindContext+0xf52fa4>
104a77358: d00db7e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104a7735c: f9446114    	ldr	x20, [x8, #0x8c0] ; ReaderWrap
104a77360: f9400660    	ldr	x0, [x19, #0x8]
104a77364: aa1503e1    	mov	x1, x21
104a77368: 94c6bf75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7736c: aa1d03fd    	mov	x29, x29
104a77370: 94c6bf76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77374: aa0003f5    	mov	x21, x0
104a77378: b00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a7737c: f941a901    	ldr	x1, [x8, #0x350] ; getFirstReaderTitle:
104a77380: aa1403e0    	mov	x0, x20
104a77384: aa1503e2    	mov	x2, x21
104a77388: 94c6bf6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7738c: aa1d03fd    	mov	x29, x29
104a77390: 94c6bf6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77394: aa0003f4    	mov	x20, x0
104a77398: aa1503e0    	mov	x0, x21
104a7739c: 94c6bf6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a773a0: 900cd128    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a773a4: 91032108    	add	x8, x8, #0xc8 ; CFString ''
104a773a8: f100029f    	cmp	x20, #0x0
104a773ac: 9a940102    	csel	x2, x8, x20, eq
104a773b0: 900da068    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a773b4: f9406901    	ldr	x1, [x8, #0xd0] ; setM_textForMessageLabel:
104a773b8: aa1303e0    	mov	x0, x19
104a773bc: 17fffef7    	b	0x104a76f98 <_Flutter_MMFoundation_BindContext+0xf52b7c>
104a773c0: f9400660    	ldr	x0, [x19, #0x8]
104a773c4: aa1403e1    	mov	x1, x20
104a773c8: 94c6bf5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a773cc: aa1d03fd    	mov	x29, x29
104a773d0: 94c6bf5e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a773d4: aa0003f7    	mov	x23, x0
104a773d8: b00d9e68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a773dc: f9437101    	ldr	x1, [x8, #0x6e0] ; isServiceBrand
104a773e0: 94c6bf57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a773e4: aa0003f9    	mov	x25, x0
104a773e8: aa1703e0    	mov	x0, x23
104a773ec: 94c6bf5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a773f0: 900db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a773f4: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a773f8: b00db448    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a773fc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a77400: 94c6bf4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77404: aa1d03fd    	mov	x29, x29
104a77408: 94c6bf50    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7740c: aa0003f7    	mov	x23, x0
104a77410: 900db448    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a77414: f947ad18    	ldr	x24, [x8, #0xf58] ; class
104a77418: 340009b9    	cbz	w25, 0x104a7754c <_Flutter_MMFoundation_BindContext+0xf53130>
104a7741c: b00db7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a77420: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
104a77424: aa1803e1    	mov	x1, x24
104a77428: 94c6bf45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7742c: aa0003e2    	mov	x2, x0
104a77430: d00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a77434: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a77438: aa1703e0    	mov	x0, x23
104a7743c: 94c6bf40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77440: aa1d03fd    	mov	x29, x29
104a77444: 94c6bf41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77448: aa0003f6    	mov	x22, x0
104a7744c: f9400660    	ldr	x0, [x19, #0x8]
104a77450: aa1503e1    	mov	x1, x21
104a77454: 94c6bf3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77458: aa1d03fd    	mov	x29, x29
104a7745c: 94c6bf3b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77460: aa0003f5    	mov	x21, x0
104a77464: 900d9ea8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104a77468: f9415501    	ldr	x1, [x8, #0x2a8] ; getMessageChatContactByMessageWrap:
104a7746c: aa1603e0    	mov	x0, x22
104a77470: aa1503e2    	mov	x2, x21
104a77474: 94c6bf32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77478: aa1d03fd    	mov	x29, x29
104a7747c: 94c6bf33    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77480: aa0003f4    	mov	x20, x0
104a77484: aa1503e0    	mov	x0, x21
104a77488: 94c6bf33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7748c: aa1603e0    	mov	x0, x22
104a77490: 94c6bf31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77494: aa1703e0    	mov	x0, x23
104a77498: 94c6bf2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7749c: f00db7e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104a774a0: f9412d00    	ldr	x0, [x8, #0x258] ; KFContact
104a774a4: aa1803e1    	mov	x1, x24
104a774a8: 94c6bf25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a774ac: aa0003e2    	mov	x2, x0
104a774b0: 900db468    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a774b4: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
104a774b8: aa1403e0    	mov	x0, x20
104a774bc: 94c6bf20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a774c0: 34000400    	cbz	w0, 0x104a77540 <_Flutter_MMFoundation_BindContext+0xf53124>
104a774c4: aa1403e0    	mov	x0, x20
104a774c8: 94c6bf1c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a774cc: b00d9e68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a774d0: f9403901    	ldr	x1, [x8, #0x70] ; nickName
104a774d4: 94c6bf1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a774d8: aa1d03fd    	mov	x29, x29
104a774dc: 94c6bf1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a774e0: aa0003f5    	mov	x21, x0
104a774e4: b00da2c8    	adrp	x8, 0x11fed0000 <dyld_stub_binder+0x11fed0000>
104a774e8: f9436501    	ldr	x1, [x8, #0x6c8] ; kfType
104a774ec: aa1403e0    	mov	x0, x20
104a774f0: 94c6bf13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a774f4: 7100081f    	cmp	w0, #0x2
104a774f8: 54001d01    	b.ne	0x104a77898 <_Flutter_MMFoundation_BindContext+0xf5347c>
104a774fc: 900db468    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a77500: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104a77504: aa1503e0    	mov	x0, x21
104a77508: 94c6bf0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7750c: b4001920    	cbz	x0, 0x104a77830 <_Flutter_MMFoundation_BindContext+0xf53414>
104a77510: 900db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a77514: f9454500    	ldr	x0, [x8, #0xa88]
104a77518: f00db488    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a7751c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a77520: f90003f5    	str	x21, [sp]
104a77524: b00cd842    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a77528: 91202042    	add	x2, x2, #0x808 ; CFString '%@: '
104a7752c: 94c6bf04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77530: aa1d03fd    	mov	x29, x29
104a77534: 94c6bf05    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77538: aa0003f6    	mov	x22, x0
104a7753c: 140000d9    	b	0x104a778a0 <_Flutter_MMFoundation_BindContext+0xf53484>
104a77540: 900cd136    	adrp	x22, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a77544: 910322d6    	add	x22, x22, #0xc8 ; CFString ''
104a77548: 140000da    	b	0x104a778b0 <_Flutter_MMFoundation_BindContext+0xf53494>
104a7754c: b00db7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a77550: f941c100    	ldr	x0, [x8, #0x380] ; BrandTimelineMsgMgr
104a77554: aa1803e1    	mov	x1, x24
104a77558: 94c6bef9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7755c: aa0003e2    	mov	x2, x0
104a77560: d00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a77564: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a77568: aa1703e0    	mov	x0, x23
104a7756c: 94c6bef4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77570: aa1d03fd    	mov	x29, x29
104a77574: 94c6bef5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77578: aa0003f8    	mov	x24, x0
104a7757c: 900d9ee8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104a77580: f9478101    	ldr	x1, [x8, #0xf00] ; useSimulatedNativePersonalCenter
104a77584: 94c6beee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77588: aa0003f9    	mov	x25, x0
104a7758c: aa1803e0    	mov	x0, x24
104a77590: 94c6bef1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77594: aa1703e0    	mov	x0, x23
104a77598: 94c6beef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7759c: 340005b9    	cbz	w25, 0x104a77650 <_Flutter_MMFoundation_BindContext+0xf53234>
104a775a0: f9400660    	ldr	x0, [x19, #0x8]
104a775a4: d00d9e28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a775a8: f942e101    	ldr	x1, [x8, #0x5c0] ; m_uBrandNotifyType
104a775ac: 94c6bee4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a775b0: 361001e0    	tbz	w0, #0x2, 0x104a775ec <_Flutter_MMFoundation_BindContext+0xf531d0>
104a775b4: 900da068    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104a775b8: f9403901    	ldr	x1, [x8, #0x70] ; m_textForMessageLabel
104a775bc: aa1303e0    	mov	x0, x19
104a775c0: 94c6bedf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a775c4: aa1d03fd    	mov	x29, x29
104a775c8: 94c6bee0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a775cc: aa0003f7    	mov	x23, x0
104a775d0: 900db468    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a775d4: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104a775d8: 94c6bed9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a775dc: aa0003f8    	mov	x24, x0
104a775e0: aa1703e0    	mov	x0, x23
104a775e4: 94c6bedc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a775e8: b5001158    	cbnz	x24, 0x104a77810 <_Flutter_MMFoundation_BindContext+0xf533f4>
104a775ec: 900db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a775f0: f9453517    	ldr	x23, [x8, #0xa68] ; iConsole
104a775f4: f9400660    	ldr	x0, [x19, #0x8]
104a775f8: aa1503e1    	mov	x1, x21
104a775fc: 94c6bed0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77600: aa1d03fd    	mov	x29, x29
104a77604: 94c6bed1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77608: aa0003f5    	mov	x21, x0
104a7760c: d00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a77610: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104a77614: b00ce928    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a77618: 9130a108    	add	x8, x8, #0xc28 ; CFString 'textForMessageLabel is nil when receive brand notify. msg: %@'
104a7761c: a90003e8    	stp	x8, x0, [sp]
104a77620: 900b6bc5    	adrp	x5, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a77624: 9123fca5    	add	x5, x5, #0x8ff
104a77628: 900b6bc7    	adrp	x7, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a7762c: 9125c4e7    	add	x7, x7, #0x971
104a77630: aa1703e0    	mov	x0, x23
104a77634: 52800082    	mov	w2, #0x4                ; =4
104a77638: d2800003    	mov	x3, #0x0                ; =0
104a7763c: 52800004    	mov	w4, #0x0                ; =0
104a77640: 528029c6    	mov	w6, #0x14e              ; =334
104a77644: 94c6bebe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77648: aa1503e0    	mov	x0, x21
104a7764c: 94c6bec2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77650: b00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a77654: f941a501    	ldr	x1, [x8, #0x348] ; makeTextSession:
104a77658: 900cd122    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a7765c: 91032042    	add	x2, x2, #0xc8 ; CFString ''
104a77660: aa1303e0    	mov	x0, x19
104a77664: 94c6beb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77668: f9400660    	ldr	x0, [x19, #0x8]
104a7766c: aa1403e1    	mov	x1, x20
104a77670: 94c6beb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77674: aa1d03fd    	mov	x29, x29
104a77678: 94c6beb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7767c: aa0003f5    	mov	x21, x0
104a77680: b00d9e68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a77684: f9449919    	ldr	x25, [x8, #0x930] ; isEqualToName:
104a77688: f00cd142    	adrp	x2, 0x11e4a2000 <dyld_stub_binder+0x11e4a2000>
104a7768c: 91162042    	add	x2, x2, #0x588 ; CFString 'brandsessionholder'
104a77690: aa1903e1    	mov	x1, x25
104a77694: 94c6beaa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77698: 37000800    	tbnz	w0, #0x0, 0x104a77798 <_Flutter_MMFoundation_BindContext+0xf5337c>
104a7769c: f9400660    	ldr	x0, [x19, #0x8]
104a776a0: aa1403e1    	mov	x1, x20
104a776a4: 94c6bea6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a776a8: aa1d03fd    	mov	x29, x29
104a776ac: 94c6bea7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a776b0: aa0003f7    	mov	x23, x0
104a776b4: f00cd142    	adrp	x2, 0x11e4a2000 <dyld_stub_binder+0x11e4a2000>
104a776b8: 9100a042    	add	x2, x2, #0x28 ; CFString 'brandservicesessionholder'
104a776bc: aa1903e1    	mov	x1, x25
104a776c0: 94c6be9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a776c4: 37000660    	tbnz	w0, #0x0, 0x104a77790 <_Flutter_MMFoundation_BindContext+0xf53374>
104a776c8: f9400660    	ldr	x0, [x19, #0x8]
104a776cc: aa1403e1    	mov	x1, x20
104a776d0: 94c6be9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a776d4: aa1d03fd    	mov	x29, x29
104a776d8: 94c6be9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a776dc: aa0003f8    	mov	x24, x0
104a776e0: b00cd1c2    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a776e4: 91392042    	add	x2, x2, #0xe48 ; CFString 'brandsessionholder_weapp'
104a776e8: aa1903e1    	mov	x1, x25
104a776ec: 94c6be94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a776f0: 370004c0    	tbnz	w0, #0x0, 0x104a77788 <_Flutter_MMFoundation_BindContext+0xf5336c>
104a776f4: f9400660    	ldr	x0, [x19, #0x8]
104a776f8: aa1403e1    	mov	x1, x20
104a776fc: 94c6be90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77700: aa1d03fd    	mov	x29, x29
104a77704: 94c6be91    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77708: aa0003fa    	mov	x26, x0
104a7770c: aa1603e1    	mov	x1, x22
104a77710: 94c6be8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77714: 37000360    	tbnz	w0, #0x0, 0x104a77780 <_Flutter_MMFoundation_BindContext+0xf53364>
104a77718: f9400660    	ldr	x0, [x19, #0x8]
104a7771c: aa1403e1    	mov	x1, x20
104a77720: 94c6be87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77724: aa1d03fd    	mov	x29, x29
104a77728: 94c6be88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7772c: aa0003f6    	mov	x22, x0
104a77730: b00cd1c2    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a77734: 9139a042    	add	x2, x2, #0xe68 ; CFString 'fav_weapp_messages'
104a77738: aa1903e1    	mov	x1, x25
104a7773c: 94c6be80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77740: 370001c0    	tbnz	w0, #0x0, 0x104a77778 <_Flutter_MMFoundation_BindContext+0xf5335c>
104a77744: f9400660    	ldr	x0, [x19, #0x8]
104a77748: aa1403e1    	mov	x1, x20
104a7774c: 94c6be7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77750: aa1d03fd    	mov	x29, x29
104a77754: 94c6be7d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77758: aa0003fb    	mov	x27, x0
104a7775c: b00cd1c2    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a77760: 913a2042    	add	x2, x2, #0xe88 ; CFString 'opencustomerservicemsg'
104a77764: aa1903e1    	mov	x1, x25
104a77768: 94c6be75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7776c: 36000c20    	tbz	w0, #0x0, 0x104a778f0 <_Flutter_MMFoundation_BindContext+0xf534d4>
104a77770: aa1b03e0    	mov	x0, x27
104a77774: 94c6be78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77778: aa1603e0    	mov	x0, x22
104a7777c: 94c6be76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77780: aa1a03e0    	mov	x0, x26
104a77784: 94c6be74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77788: aa1803e0    	mov	x0, x24
104a7778c: 94c6be72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77790: aa1703e0    	mov	x0, x23
104a77794: 94c6be70    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77798: aa1503e0    	mov	x0, x21
104a7779c: 94c6be6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a777a0: b00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a777a4: f941ad01    	ldr	x1, [x8, #0x358] ; makeTextForQuoteMessage
104a777a8: aa1303e0    	mov	x0, x19
104a777ac: 94c6be64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a777b0: f9400660    	ldr	x0, [x19, #0x8]
104a777b4: aa1403e1    	mov	x1, x20
104a777b8: 94c6be61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a777bc: aa1d03fd    	mov	x29, x29
104a777c0: 94c6be62    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a777c4: aa0003f4    	mov	x20, x0
104a777c8: 900d9e28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a777cc: f947bd01    	ldr	x1, [x8, #0xf78] ; m_isPlugin
104a777d0: 94c6be5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a777d4: aa0003f5    	mov	x21, x0
104a777d8: aa1403e0    	mov	x0, x20
104a777dc: 94c6be5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a777e0: 34000195    	cbz	w21, 0x104a77810 <_Flutter_MMFoundation_BindContext+0xf533f4>
104a777e4: b00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a777e8: f941b101    	ldr	x1, [x8, #0x360] ; makeTextForPluginMessage
104a777ec: aa1303e0    	mov	x0, x19
104a777f0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104a777f4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104a777f8: a94457f6    	ldp	x22, x21, [sp, #0x40]
104a777fc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104a77800: a94267fa    	ldp	x26, x25, [sp, #0x20]
104a77804: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104a77808: 9101c3ff    	add	sp, sp, #0x70
104a7780c: 14c6be4c    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77810: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104a77814: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104a77818: a94457f6    	ldp	x22, x21, [sp, #0x40]
104a7781c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104a77820: a94267fa    	ldp	x26, x25, [sp, #0x20]
104a77824: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104a77828: 9101c3ff    	add	sp, sp, #0x70
104a7782c: d65f03c0    	ret
104a77830: 900db7e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a77834: f9453516    	ldr	x22, [x8, #0xa68] ; iConsole
104a77838: b00da2c8    	adrp	x8, 0x11fed0000 <dyld_stub_binder+0x11fed0000>
104a7783c: f9436101    	ldr	x1, [x8, #0x6c0] ; kfOpenId
104a77840: aa1403e0    	mov	x0, x20
104a77844: 94c6be3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77848: aa1d03fd    	mov	x29, x29
104a7784c: 94c6be3f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77850: aa0003f7    	mov	x23, x0
104a77854: d00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a77858: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104a7785c: b00ce928    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a77860: 91302108    	add	x8, x8, #0xc08 ; CFString "receive a guide kf's msg, but can't get the nickname now. kfId = %@"
104a77864: a90003e8    	stp	x8, x0, [sp]
104a77868: 900b6bc5    	adrp	x5, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a7786c: 9123fca5    	add	x5, x5, #0x8ff
104a77870: 900b6bc7    	adrp	x7, 0x11b7ef000 <dyld_stub_binder+0x11b7ef000>
104a77874: 9125c4e7    	add	x7, x7, #0x971
104a77878: aa1603e0    	mov	x0, x22
104a7787c: 52800042    	mov	w2, #0x2                ; =2
104a77880: d2800003    	mov	x3, #0x0                ; =0
104a77884: 52800004    	mov	w4, #0x0                ; =0
104a77888: 52802826    	mov	w6, #0x141              ; =321
104a7788c: 94c6be2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77890: aa1703e0    	mov	x0, x23
104a77894: 94c6be30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77898: 900cd136    	adrp	x22, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a7789c: 910322d6    	add	x22, x22, #0xc8 ; CFString ''
104a778a0: aa1503e0    	mov	x0, x21
104a778a4: 94c6be2c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a778a8: aa1403e0    	mov	x0, x20
104a778ac: 94c6be2a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a778b0: b00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a778b4: f941a501    	ldr	x1, [x8, #0x348] ; makeTextSession:
104a778b8: aa1303e0    	mov	x0, x19
104a778bc: aa1603e2    	mov	x2, x22
104a778c0: 94c6be1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a778c4: aa1603e0    	mov	x0, x22
104a778c8: 94c6be23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a778cc: aa1403e0    	mov	x0, x20
104a778d0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104a778d4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104a778d8: a94457f6    	ldp	x22, x21, [sp, #0x40]
104a778dc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104a778e0: a94267fa    	ldp	x26, x25, [sp, #0x20]
104a778e4: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104a778e8: 9101c3ff    	add	sp, sp, #0x70
104a778ec: 14c6be1a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a778f0: f9400660    	ldr	x0, [x19, #0x8]
104a778f4: aa1403e1    	mov	x1, x20
104a778f8: 94c6be11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a778fc: aa1d03fd    	mov	x29, x29
104a77900: 94c6be12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a77904: aa0003fc    	mov	x28, x0
104a77908: b00cd1c2    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
104a7790c: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
104a77910: aa1903e1    	mov	x1, x25
104a77914: 94c6be0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a77918: aa0003f9    	mov	x25, x0
104a7791c: aa1c03e0    	mov	x0, x28
104a77920: 94c6be0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77924: aa1b03e0    	mov	x0, x27
104a77928: 94c6be0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7792c: aa1603e0    	mov	x0, x22
104a77930: 94c6be09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77934: aa1a03e0    	mov	x0, x26
104a77938: 94c6be07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7793c: aa1803e0    	mov	x0, x24
104a77940: 94c6be05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77944: aa1703e0    	mov	x0, x23
104a77948: 94c6be03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7794c: aa1503e0    	mov	x0, x21
104a77950: 94c6be01    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a77954: 3707f279    	tbnz	w25, #0x0, 0x104a777a0 <_Flutter_MMFoundation_BindContext+0xf53384>
104a77958: 17ffff96    	b	0x104a777b0 <_Flutter_MMFoundation_BindContext+0xf53394>
