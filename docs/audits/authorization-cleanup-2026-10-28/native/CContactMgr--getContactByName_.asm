
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fcd954: d10143ff    	sub	sp, sp, #0x50
100fcd958: a9015ff8    	stp	x24, x23, [sp, #0x10]
100fcd95c: a90257f6    	stp	x22, x21, [sp, #0x20]
100fcd960: a9034ff4    	stp	x20, x19, [sp, #0x30]
100fcd964: a9047bfd    	stp	x29, x30, [sp, #0x40]
100fcd968: 910103fd    	add	x29, sp, #0x40
100fcd96c: aa0203f3    	mov	x19, x2
100fcd970: aa0003f4    	mov	x20, x0
100fcd974: f00fe308    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100fcd978: 52800029    	mov	w9, #0x1                ; =1
100fcd97c: 392fd109    	strb	w9, [x8, #0xbf4]
100fcd980: aa0203e0    	mov	x0, x2
100fcd984: 95b165ed    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fcd988: b40001d3    	cbz	x19, 0x100fcd9c0 <__text+0xfc59c0>
100fcd98c: d00f89a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100fcd990: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
100fcd994: aa1303e0    	mov	x0, x19
100fcd998: 95b165e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcd99c: b4000120    	cbz	x0, 0x100fcd9c0 <__text+0xfc59c0>
100fcd9a0: d00f89a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100fcd9a4: f943c915    	ldr	x21, [x8, #0x790] ; selector isEqualToString:
100fcd9a8: f00eaba2    	adrp	x2, 0x11e544000 <dyld_stub_binder+0x11e544000>
100fcd9ac: 912e2042    	add	x2, x2, #0xb88 ; CFString 'weibo'
100fcd9b0: aa1303e0    	mov	x0, x19
100fcd9b4: aa1503e1    	mov	x1, x21
100fcd9b8: 95b165e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcd9bc: 36000160    	tbz	w0, #0x0, 0x100fcd9e8 <__text+0xfc59e8>
100fcd9c0: d2800016    	mov	x22, #0x0               ; =0
100fcd9c4: aa1303e0    	mov	x0, x19
100fcd9c8: 95b165e3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcd9cc: aa1603e0    	mov	x0, x22
100fcd9d0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100fcd9d4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100fcd9d8: a94257f6    	ldp	x22, x21, [sp, #0x20]
100fcd9dc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100fcd9e0: 910143ff    	add	sp, sp, #0x50
100fcd9e4: 15b165e3    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
100fcd9e8: d00f8d36    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
100fcd9ec: f94782c0    	ldr	x0, [x22, #0xf00] ; class CContact
100fcd9f0: d00f73a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100fcd9f4: f9410501    	ldr	x1, [x8, #0x208] ; selector isWeAppUserName:
100fcd9f8: aa1303e2    	mov	x2, x19
100fcd9fc: 95b165d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcda00: 34000540    	cbz	w0, 0x100fcdaa8 <__text+0xfc5aa8>
100fcda04: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcda08: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
100fcda0c: 900f7368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fcda10: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
100fcda14: 900eabc8    	adrp	x8, 0x11e545000 <dyld_stub_binder+0x11e545000>
100fcda18: 9101a108    	add	x8, x8, #0x68 ; CFString 'get weapp contact in contactMgr, userName=%@'
100fcda1c: a9004fe8    	stp	x8, x19, [sp]
100fcda20: b00d1283    	adrp	x3, 0x11b21e000 <dyld_stub_binder+0x11b21e000>
100fcda24: 9124b863    	add	x3, x3, #0x92e ; string 'Contact'
100fcda28: b00d1cc5    	adrp	x5, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcda2c: 911520a5    	add	x5, x5, #0x548 ; string 'ContactMgr.mm'
100fcda30: b00d1cc7    	adrp	x7, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcda34: 913588e7    	add	x7, x7, #0xd62 ; string '-[CContactMgr getContactByName:]'
100fcda38: 52800062    	mov	w2, #0x3                ; =3
100fcda3c: 52800004    	mov	w4, #0x0                ; =0
100fcda40: 52809286    	mov	w6, #0x494              ; =1172
100fcda44: 95b165be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcda48: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcda4c: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
100fcda50: f00f8988    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fcda54: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
100fcda58: 95b165b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcda5c: aa1d03fd    	mov	x29, x29
100fcda60: 95b165ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcda64: aa0003f4    	mov	x20, x0
100fcda68: f00f8d28    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fcda6c: f945d100    	ldr	x0, [x8, #0xba0] ; class WAContactMgr
100fcda70: d00f8988    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fcda74: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
100fcda78: 95b165b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcda7c: aa0003e2    	mov	x2, x0
100fcda80: 900f7368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fcda84: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
100fcda88: aa1403e0    	mov	x0, x20
100fcda8c: 95b165ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcda90: aa1d03fd    	mov	x29, x29
100fcda94: 95b165ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcda98: aa0003f5    	mov	x21, x0
100fcda9c: d00f7388    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100fcdaa0: f9463101    	ldr	x1, [x8, #0xc60] ; selector getCContactWithWeAppUserName:
100fcdaa4: 1400002f    	b	0x100fcdb60 <__text+0xfc5b60>
100fcdaa8: f94782c0    	ldr	x0, [x22, #0xf00] ; class CContact
100fcdaac: b00f73e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100fcdab0: f9479901    	ldr	x1, [x8, #0xf30] ; selector isWeWorkKFUserName:
100fcdab4: aa1303e2    	mov	x2, x19
100fcdab8: 95b165a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdabc: 34000660    	cbz	w0, 0x100fcdb88 <__text+0xfc5b88>
100fcdac0: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcdac4: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
100fcdac8: 900f7368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fcdacc: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
100fcdad0: 900eabc8    	adrp	x8, 0x11e545000 <dyld_stub_binder+0x11e545000>
100fcdad4: 91022108    	add	x8, x8, #0x88 ; CFString 'get wwkf contact in contactMgr, userName=%@'
100fcdad8: a9004fe8    	stp	x8, x19, [sp]
100fcdadc: b00d1283    	adrp	x3, 0x11b21e000 <dyld_stub_binder+0x11b21e000>
100fcdae0: 9124b863    	add	x3, x3, #0x92e ; string 'Contact'
100fcdae4: b00d1cc5    	adrp	x5, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcdae8: 911520a5    	add	x5, x5, #0x548 ; string 'ContactMgr.mm'
100fcdaec: b00d1cc7    	adrp	x7, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcdaf0: 913588e7    	add	x7, x7, #0xd62 ; string '-[CContactMgr getContactByName:]'
100fcdaf4: 52800042    	mov	w2, #0x2                ; =2
100fcdaf8: 52800004    	mov	w4, #0x0                ; =0
100fcdafc: 52809326    	mov	w6, #0x499              ; =1177
100fcdb00: 95b1658f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdb04: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcdb08: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
100fcdb0c: f00f8988    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fcdb10: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
100fcdb14: 95b1658a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdb18: aa1d03fd    	mov	x29, x29
100fcdb1c: 95b1658b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdb20: aa0003f4    	mov	x20, x0
100fcdb24: b00f8d68    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
100fcdb28: f9415900    	ldr	x0, [x8, #0x2b0] ; class WWKFContactMgr
100fcdb2c: d00f8988    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fcdb30: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
100fcdb34: 95b16582    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdb38: aa0003e2    	mov	x2, x0
100fcdb3c: 900f7368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fcdb40: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
100fcdb44: aa1403e0    	mov	x0, x20
100fcdb48: 95b1657d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdb4c: aa1d03fd    	mov	x29, x29
100fcdb50: 95b1657e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdb54: aa0003f5    	mov	x21, x0
100fcdb58: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdb5c: f9406901    	ldr	x1, [x8, #0xd0] ; selector getCContactWithWWKFUserName:
100fcdb60: aa1303e2    	mov	x2, x19
100fcdb64: 95b16576    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdb68: aa1d03fd    	mov	x29, x29
100fcdb6c: 95b16577    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdb70: aa0003f6    	mov	x22, x0
100fcdb74: aa1503e0    	mov	x0, x21
100fcdb78: 95b16577    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdb7c: aa1403e0    	mov	x0, x20
100fcdb80: 95b16575    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdb84: 17ffff90    	b	0x100fcd9c4 <__text+0xfc59c4>
100fcdb88: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcdb8c: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
100fcdb90: d00f73a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100fcdb94: f9462101    	ldr	x1, [x8, #0xc40] ; selector isEnterpriseUsrName:
100fcdb98: aa1303e2    	mov	x2, x19
100fcdb9c: 95b16568    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdba0: 34000260    	cbz	w0, 0x100fcdbec <__text+0xfc5bec>
100fcdba4: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcdba8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
100fcdbac: 900f7368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fcdbb0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
100fcdbb4: 900eabc8    	adrp	x8, 0x11e545000 <dyld_stub_binder+0x11e545000>
100fcdbb8: 9102a108    	add	x8, x8, #0xa8 ; CFString 'get enterprise contact in contactMgr.'
100fcdbbc: f90003e8    	str	x8, [sp]
100fcdbc0: b00d1283    	adrp	x3, 0x11b21e000 <dyld_stub_binder+0x11b21e000>
100fcdbc4: 9124b863    	add	x3, x3, #0x92e ; string 'Contact'
100fcdbc8: b00d1cc5    	adrp	x5, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcdbcc: 911520a5    	add	x5, x5, #0x548 ; string 'ContactMgr.mm'
100fcdbd0: b00d1cc7    	adrp	x7, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcdbd4: 913588e7    	add	x7, x7, #0xd62 ; string '-[CContactMgr getContactByName:]'
100fcdbd8: 52800062    	mov	w2, #0x3                ; =3
100fcdbdc: 52800004    	mov	w4, #0x0                ; =0
100fcdbe0: 528093c6    	mov	w6, #0x49e              ; =1182
100fcdbe4: 95b16556    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdbe8: 17ffff76    	b	0x100fcd9c0 <__text+0xfc59c0>
100fcdbec: 900f90e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fcdbf0: b98d1908    	ldrsw	x8, [x8, #0xd18]
100fcdbf4: f8686a88    	ldr	x8, [x20, x8]
100fcdbf8: b40008a8    	cbz	x8, 0x100fcdd0c <__text+0xfc5d0c>
100fcdbfc: b00f75c8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fcdc00: f947c101    	ldr	x1, [x8, #0xf80] ; selector getContactFromDic:
100fcdc04: aa1403e0    	mov	x0, x20
100fcdc08: aa1303e2    	mov	x2, x19
100fcdc0c: 95b1654c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdc10: aa1d03fd    	mov	x29, x29
100fcdc14: 95b1654d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdc18: aa0003f6    	mov	x22, x0
100fcdc1c: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdc20: f9406d17    	ldr	x23, [x8, #0xd8] ; selector isCacheAllLoaded
100fcdc24: aa1403e0    	mov	x0, x20
100fcdc28: aa1703e1    	mov	x1, x23
100fcdc2c: 95b16544    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdc30: 34000260    	cbz	w0, 0x100fcdc7c <__text+0xfc5c7c>
100fcdc34: 900f90e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fcdc38: b98d6108    	ldrsw	x8, [x8, #0xd60]
100fcdc3c: 38686a88    	ldrb	w8, [x20, x8]
100fcdc40: 7100051f    	cmp	w8, #0x1
100fcdc44: 540001c1    	b.ne	0x100fcdc7c <__text+0xfc5c7c>
100fcdc48: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdc4c: f9407101    	ldr	x1, [x8, #0xe0] ; selector contactCacheOptimizeMgr
100fcdc50: aa1403e0    	mov	x0, x20
100fcdc54: 95b1653a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdc58: aa1d03fd    	mov	x29, x29
100fcdc5c: 95b1653b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdc60: aa0003f8    	mov	x24, x0
100fcdc64: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdc68: f9407501    	ldr	x1, [x8, #0xe8] ; selector recordUseContactUserName:
100fcdc6c: aa1303e2    	mov	x2, x19
100fcdc70: 95b16533    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdc74: aa1803e0    	mov	x0, x24
100fcdc78: 95b16537    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdc7c: b50004b6    	cbnz	x22, 0x100fcdd10 <__text+0xfc5d10>
100fcdc80: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdc84: f9407101    	ldr	x1, [x8, #0xe0] ; selector contactCacheOptimizeMgr
100fcdc88: aa1403e0    	mov	x0, x20
100fcdc8c: 95b1652c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdc90: aa1d03fd    	mov	x29, x29
100fcdc94: 95b1652d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdc98: aa0003f6    	mov	x22, x0
100fcdc9c: f00f7528    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
100fcdca0: f943e101    	ldr	x1, [x8, #0x7c0] ; selector isOpenContactCacheOptimize
100fcdca4: 95b16526    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdca8: 34000680    	cbz	w0, 0x100fcdd78 <__text+0xfc5d78>
100fcdcac: aa1403e0    	mov	x0, x20
100fcdcb0: aa1703e1    	mov	x1, x23
100fcdcb4: 95b16522    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdcb8: 36000600    	tbz	w0, #0x0, 0x100fcdd78 <__text+0xfc5d78>
100fcdcbc: 900f90e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fcdcc0: b98d1508    	ldrsw	x8, [x8, #0xd14]
100fcdcc4: f8686a80    	ldr	x0, [x20, x8]
100fcdcc8: f00f89a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fcdccc: f947f101    	ldr	x1, [x8, #0xfe0] ; selector objectForKey:
100fcdcd0: aa1303e2    	mov	x2, x19
100fcdcd4: 95b1651a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdcd8: aa1d03fd    	mov	x29, x29
100fcdcdc: 95b1651b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdce0: aa0003f8    	mov	x24, x0
100fcdce4: 95b1651c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdce8: aa1603e0    	mov	x0, x22
100fcdcec: 95b1651a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdcf0: b5000498    	cbnz	x24, 0x100fcdd80 <__text+0xfc5d80>
100fcdcf4: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdcf8: f9407901    	ldr	x1, [x8, #0xf0] ; selector addChatRoomStrangerRemark:
100fcdcfc: aa1403e0    	mov	x0, x20
100fcdd00: aa1303e2    	mov	x2, x19
100fcdd04: 95b1650e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdd08: 1400001e    	b	0x100fcdd80 <__text+0xfc5d80>
100fcdd0c: d2800016    	mov	x22, #0x0               ; =0
100fcdd10: 900f90e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fcdd14: b98d0108    	ldrsw	x8, [x8, #0xd00]
100fcdd18: 38686a88    	ldrb	w8, [x20, x8]
100fcdd1c: 7100051f    	cmp	w8, #0x1
100fcdd20: 54ffe521    	b.ne	0x100fcd9c4 <__text+0xfc59c4>
100fcdd24: f00f7368    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fcdd28: f9476101    	ldr	x1, [x8, #0xec0] ; selector m_uiType
100fcdd2c: aa1603e0    	mov	x0, x22
100fcdd30: 95b16503    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdd34: 52802168    	mov	w8, #0x10b              ; =267
100fcdd38: 6a08001f    	tst	w0, w8
100fcdd3c: 54ffe441    	b.ne	0x100fcd9c4 <__text+0xfc59c4>
100fcdd40: d00f7368    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fcdd44: f9434d01    	ldr	x1, [x8, #0x698] ; selector m_nsUsrName
100fcdd48: aa1603e0    	mov	x0, x22
100fcdd4c: 95b164fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdd50: aa1d03fd    	mov	x29, x29
100fcdd54: 95b164fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdd58: aa0003f5    	mov	x21, x0
100fcdd5c: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcdd60: f9407d01    	ldr	x1, [x8, #0xf8] ; selector updateCache:
100fcdd64: aa1403e0    	mov	x0, x20
100fcdd68: aa1503e2    	mov	x2, x21
100fcdd6c: 95b164f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdd70: aa1503e0    	mov	x0, x21
100fcdd74: 17ffff83    	b	0x100fcdb80 <__text+0xfc5b80>
100fcdd78: aa1603e0    	mov	x0, x22
100fcdd7c: 95b164f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdd80: aa1403e0    	mov	x0, x20
100fcdd84: aa1703e1    	mov	x1, x23
100fcdd88: 95b164ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdd8c: 340001a0    	cbz	w0, 0x100fcddc0 <__text+0xfc5dc0>
100fcdd90: 900f90e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fcdd94: b98d1508    	ldrsw	x8, [x8, #0xd14]
100fcdd98: f8686a80    	ldr	x0, [x20, x8]
100fcdd9c: f00f89a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100fcdda0: f947f101    	ldr	x1, [x8, #0xfe0] ; selector objectForKey:
100fcdda4: aa1303e2    	mov	x2, x19
100fcdda8: 95b164e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcddac: aa1d03fd    	mov	x29, x29
100fcddb0: 95b164e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcddb4: aa0003f6    	mov	x22, x0
100fcddb8: 95b164e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcddbc: b4000616    	cbz	x22, 0x100fcde7c <__text+0xfc5e7c>
100fcddc0: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcddc4: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
100fcddc8: f00f8988    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fcddcc: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
100fcddd0: 95b164db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcddd4: aa1d03fd    	mov	x29, x29
100fcddd8: 95b164dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdddc: aa0003f6    	mov	x22, x0
100fcdde0: f00f7368    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fcdde4: f9453501    	ldr	x1, [x8, #0xa68] ; selector userName
100fcdde8: 95b164d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcddec: aa1d03fd    	mov	x29, x29
100fcddf0: 95b164d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcddf4: aa0003f7    	mov	x23, x0
100fcddf8: aa1503e1    	mov	x1, x21
100fcddfc: aa1303e2    	mov	x2, x19
100fcde00: 95b164cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcde04: aa0003f5    	mov	x21, x0
100fcde08: aa1703e0    	mov	x0, x23
100fcde0c: 95b164d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcde10: aa1603e0    	mov	x0, x22
100fcde14: 95b164d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcde18: 34000135    	cbz	w21, 0x100fcde3c <__text+0xfc5e3c>
100fcde1c: d00f75c8    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fcde20: f9400501    	ldr	x1, [x8, #0x8] ; selector addSelfContactToCache
100fcde24: aa1403e0    	mov	x0, x20
100fcde28: 95b164c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcde2c: aa1d03fd    	mov	x29, x29
100fcde30: 95b164c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcde34: aa0003f6    	mov	x22, x0
100fcde38: 17fffee3    	b	0x100fcd9c4 <__text+0xfc59c4>
100fcde3c: 900f74a8    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
100fcde40: f9430501    	ldr	x1, [x8, #0x608] ; selector getContactFromDB:
100fcde44: aa1403e0    	mov	x0, x20
100fcde48: aa1303e2    	mov	x2, x19
100fcde4c: 95b164bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcde50: aa1d03fd    	mov	x29, x29
100fcde54: 95b164bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcde58: b4000120    	cbz	x0, 0x100fcde7c <__text+0xfc5e7c>
100fcde5c: aa0003f6    	mov	x22, x0
100fcde60: f00f7528    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
100fcde64: f9456501    	ldr	x1, [x8, #0xac8] ; selector setContactToDic:forKey:
100fcde68: aa1403e0    	mov	x0, x20
100fcde6c: aa1603e2    	mov	x2, x22
100fcde70: aa1303e3    	mov	x3, x19
100fcde74: 95b164b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcde78: 17ffffa6    	b	0x100fcdd10 <__text+0xfc5d10>
100fcde7c: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcde80: f9453514    	ldr	x20, [x8, #0xa68] ; class iConsole
100fcde84: d00f8d28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fcde88: f9454500    	ldr	x0, [x8, #0xa88] ; class NSString
100fcde8c: f00f7368    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fcde90: f947c901    	ldr	x1, [x8, #0xf90] ; selector generatePrivacyString:
100fcde94: aa1303e2    	mov	x2, x19
100fcde98: 95b164a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcde9c: aa1d03fd    	mov	x29, x29
100fcdea0: 95b164aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fcdea4: aa0003f5    	mov	x21, x0
100fcdea8: 900f7368    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fcdeac: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
100fcdeb0: 900eabc8    	adrp	x8, 0x11e545000 <dyld_stub_binder+0x11e545000>
100fcdeb4: 91032108    	add	x8, x8, #0xc8 ; CFString "can't find contact:%@"
100fcdeb8: a90003e8    	stp	x8, x0, [sp]
100fcdebc: b00d1283    	adrp	x3, 0x11b21e000 <dyld_stub_binder+0x11b21e000>
100fcdec0: 9124b863    	add	x3, x3, #0x92e ; string 'Contact'
100fcdec4: b00d1cc5    	adrp	x5, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcdec8: 911520a5    	add	x5, x5, #0x548 ; string 'ContactMgr.mm'
100fcdecc: b00d1cc7    	adrp	x7, 0x11b366000 <dyld_stub_binder+0x11b366000>
100fcded0: 913588e7    	add	x7, x7, #0xd62 ; string '-[CContactMgr getContactByName:]'
100fcded4: aa1403e0    	mov	x0, x20
100fcded8: 52800022    	mov	w2, #0x1                ; =1
100fcdedc: 52800004    	mov	w4, #0x0                ; =0
100fcdee0: 528097a6    	mov	w6, #0x4bd              ; =1213
100fcdee4: 95b16496    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fcdee8: aa1503e0    	mov	x0, x21
100fcdeec: 95b1649a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fcdef0: 17fffeb4    	b	0x100fcd9c0 <__text+0xfc59c0>
