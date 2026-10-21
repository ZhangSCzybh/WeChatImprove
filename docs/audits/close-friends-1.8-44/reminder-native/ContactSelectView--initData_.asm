
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10100fb80: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
10100fb84: a9015ff8    	stp	x24, x23, [sp, #0x10]
10100fb88: a90257f6    	stp	x22, x21, [sp, #0x20]
10100fb8c: a9034ff4    	stp	x20, x19, [sp, #0x30]
10100fb90: a9047bfd    	stp	x29, x30, [sp, #0x40]
10100fb94: 910103fd    	add	x29, sp, #0x40
10100fb98: aa0203f4    	mov	x20, x2
10100fb9c: aa0003f3    	mov	x19, x0
10100fba0: b00fe108    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
10100fba4: 52800029    	mov	w9, #0x1                ; =1
10100fba8: 39339d09    	strb	w9, [x8, #0xce7]
10100fbac: d00f8ec8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
10100fbb0: b98fd515    	ldrsw	x21, [x8, #0xfd4]
10100fbb4: f8756800    	ldr	x0, [x0, x21]
10100fbb8: b5000120    	cbnz	x0, 0x10100fbdc <__text+0x1007bdc>
10100fbbc: 900f8b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10100fbc0: f9454100    	ldr	x0, [x8, #0xa80]
10100fbc4: 95b05d65    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10100fbc8: f8756a68    	ldr	x8, [x19, x21]
10100fbcc: f8356a60    	str	x0, [x19, x21]
10100fbd0: aa0803e0    	mov	x0, x8
10100fbd4: 95b05d60    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fbd8: f8756a60    	ldr	x0, [x19, x21]
10100fbdc: f00f8768    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10100fbe0: f947f501    	ldr	x1, [x8, #0xfe8] ; allKeys
10100fbe4: 95b05d56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fbe8: aa1d03fd    	mov	x29, x29
10100fbec: 95b05d57    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10100fbf0: aa0003f5    	mov	x21, x0
10100fbf4: b00f87a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10100fbf8: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
10100fbfc: 95b05d50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fc00: aa0003f6    	mov	x22, x0
10100fc04: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100fc08: f9417501    	ldr	x1, [x8, #0x2e8] ; setMultiSelectOrderKey:
10100fc0c: aa1303e0    	mov	x0, x19
10100fc10: aa1603e2    	mov	x2, x22
10100fc14: 95b05d4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fc18: aa1603e0    	mov	x0, x22
10100fc1c: 95b05d4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fc20: aa1503e0    	mov	x0, x21
10100fc24: 95b05d4c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fc28: 900f8b48    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
10100fc2c: f9446900    	ldr	x0, [x8, #0x8d0] ; ContactsDataLogic
10100fc30: 95b05d4c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10100fc34: f00f7228    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10100fc38: f942d501    	ldr	x1, [x8, #0x5a8] ; initWithScene:delegate:
10100fc3c: aa1403e2    	mov	x2, x20
10100fc40: aa1303e3    	mov	x3, x19
10100fc44: 95b05d3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fc48: d00f8ec8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
10100fc4c: b98ff119    	ldrsw	x25, [x8, #0xff0]
10100fc50: f8796a68    	ldr	x8, [x19, x25]
10100fc54: f8396a60    	str	x0, [x19, x25]
10100fc58: aa0803e0    	mov	x0, x8
10100fc5c: 95b05d3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fc60: f8796a60    	ldr	x0, [x19, x25]
10100fc64: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100fc68: f9417901    	ldr	x1, [x8, #0x2f0] ; hasGroupContacts
10100fc6c: 95b05d34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fc70: 37000120    	tbnz	w0, #0x0, 0x10100fc94 <__text+0x1007c94>
10100fc74: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100fc78: f9417d01    	ldr	x1, [x8, #0x2f8] ; isHadChatRoomGroup
10100fc7c: aa1303e0    	mov	x0, x19
10100fc80: 95b05d2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fc84: 34000080    	cbz	w0, 0x10100fc94 <__text+0x1007c94>
10100fc88: d00f8ec8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
10100fc8c: b98fbd08    	ldrsw	x8, [x8, #0xfbc]
10100fc90: 38286a7f    	strb	wzr, [x19, x8]
10100fc94: 900f8b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10100fc98: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
10100fc9c: b00f8788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10100fca0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10100fca4: 95b05d26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fca8: aa1d03fd    	mov	x29, x29
10100fcac: 95b05d27    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10100fcb0: aa0003f5    	mov	x21, x0
10100fcb4: d00f8b28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10100fcb8: f942ed00    	ldr	x0, [x8, #0x5d8] ; ContactTagMgr
10100fcbc: 900f8788    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10100fcc0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10100fcc4: 95b05d1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fcc8: aa0003e2    	mov	x2, x0
10100fccc: d00f7148    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10100fcd0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10100fcd4: aa1503e0    	mov	x0, x21
10100fcd8: 95b05d19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fcdc: aa1d03fd    	mov	x29, x29
10100fce0: 95b05d1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10100fce4: aa0003f6    	mov	x22, x0
10100fce8: b00f7328    	adrp	x8, 0x11fe74000 <dyld_stub_binder+0x11fe74000>
10100fcec: f9476901    	ldr	x1, [x8, #0xed0] ; getAllLabelsFromLocal
10100fcf0: 95b05d13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fcf4: aa1d03fd    	mov	x29, x29
10100fcf8: 95b05d14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10100fcfc: aa0003f7    	mov	x23, x0
10100fd00: b00f8788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10100fd04: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10100fd08: 95b05d0d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fd0c: b4000100    	cbz	x0, 0x10100fd2c <__text+0x1007d2c>
10100fd10: aa1703e0    	mov	x0, x23
10100fd14: 95b05d10    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fd18: aa1603e0    	mov	x0, x22
10100fd1c: 95b05d0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fd20: aa1503e0    	mov	x0, x21
10100fd24: 95b05d0c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fd28: 14000010    	b	0x10100fd68 <__text+0x1007d68>
10100fd2c: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100fd30: f9418101    	ldr	x1, [x8, #0x300] ; canShowContactTagWithoutTagData
10100fd34: aa1303e0    	mov	x0, x19
10100fd38: 95b05d01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fd3c: aa0003f8    	mov	x24, x0
10100fd40: aa1703e0    	mov	x0, x23
10100fd44: 95b05d04    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fd48: aa1603e0    	mov	x0, x22
10100fd4c: 95b05d02    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fd50: aa1503e0    	mov	x0, x21
10100fd54: 95b05d00    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fd58: 37000098    	tbnz	w24, #0x0, 0x10100fd68 <__text+0x1007d68>
10100fd5c: d00f8ec8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
10100fd60: b98fc108    	ldrsw	x8, [x8, #0xfc0]
10100fd64: 38286a7f    	strb	wzr, [x19, x8]
10100fd68: f00f8ec8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10100fd6c: b9800d16    	ldrsw	x22, [x8, #0xc]
10100fd70: b8766a68    	ldr	w8, [x19, x22]
10100fd74: d00f7255    	adrp	x21, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10100fd78: 7100651f    	cmp	w8, #0x19
10100fd7c: 54000188    	b.hi	0x10100fdac <__text+0x1007dac>
10100fd80: 52800029    	mov	w9, #0x1                ; =1
10100fd84: 1ac82129    	lsl	w9, w9, w8
10100fd88: 52800f6a    	mov	w10, #0x7b              ; =123
10100fd8c: 72a0440a    	movk	w10, #0x220, lsl #16
10100fd90: 6a0a013f    	tst	w9, w10
10100fd94: 540000c0    	b.eq	0x10100fdac <__text+0x1007dac>
10100fd98: f8796a60    	ldr	x0, [x19, x25]
10100fd9c: f94252a1    	ldr	x1, [x21, #0x4a0] ; setM_eFTSSearchType:
10100fda0: 52800022    	mov	w2, #0x1                ; =1
10100fda4: 95b05ce6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fda8: b8766a68    	ldr	w8, [x19, x22]
10100fdac: d00f7257    	adrp	x23, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10100fdb0: 7100491f    	cmp	w8, #0x12
10100fdb4: 54000060    	b.eq	0x10100fdc0 <__text+0x1007dc0>
10100fdb8: 71003d1f    	cmp	w8, #0xf
10100fdbc: 540002c1    	b.ne	0x10100fe14 <__text+0x1007e14>
10100fdc0: f8796a60    	ldr	x0, [x19, x25]
10100fdc4: f94252a1    	ldr	x1, [x21, #0x4a0] ; setM_eFTSSearchType:
10100fdc8: 52800042    	mov	w2, #0x2                ; =2
10100fdcc: 95b05cdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fdd0: f8796a60    	ldr	x0, [x19, x25]
10100fdd4: f9424ae1    	ldr	x1, [x23, #0x490] ; setM_enAsyncSearchOption:
10100fdd8: 52800042    	mov	w2, #0x2                ; =2
10100fddc: 95b05cd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fde0: 900f8b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10100fde4: f9455500    	ldr	x0, [x8, #0xaa8]
10100fde8: 900f8788    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10100fdec: f941a101    	ldr	x1, [x8, #0x340] ; array
10100fdf0: 95b05cd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fdf4: aa1d03fd    	mov	x29, x29
10100fdf8: 95b05cd4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10100fdfc: f00f8ec8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10100fe00: b9801109    	ldrsw	x9, [x8, #0x10]
10100fe04: f8696a68    	ldr	x8, [x19, x9]
10100fe08: f8296a60    	str	x0, [x19, x9]
10100fe0c: aa0803e0    	mov	x0, x8
10100fe10: 95b05cd1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100fe14: 71004e9f    	cmp	w20, #0x13
10100fe18: 540000c0    	b.eq	0x10100fe30 <__text+0x1007e30>
10100fe1c: 71004a9f    	cmp	w20, #0x12
10100fe20: 540001a1    	b.ne	0x10100fe54 <__text+0x1007e54>
10100fe24: 52800214    	mov	w20, #0x10              ; =16
10100fe28: 52800102    	mov	w2, #0x8                ; =8
10100fe2c: 14000003    	b	0x10100fe38 <__text+0x1007e38>
10100fe30: 52800082    	mov	w2, #0x4                ; =4
10100fe34: 52800094    	mov	w20, #0x4               ; =4
10100fe38: f8796a60    	ldr	x0, [x19, x25]
10100fe3c: f9424ae1    	ldr	x1, [x23, #0x490] ; setM_enAsyncSearchOption:
10100fe40: 95b05cbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fe44: f8796a60    	ldr	x0, [x19, x25]
10100fe48: f94252a1    	ldr	x1, [x21, #0x4a0] ; setM_eFTSSearchType:
10100fe4c: aa1403e2    	mov	x2, x20
10100fe50: 95b05cbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fe54: 900f8b38    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10100fe58: f947df00    	ldr	x0, [x24, #0xfb8] ; CGroupMgr
10100fe5c: b00f7168    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10100fe60: f940bd14    	ldr	x20, [x8, #0x178] ; isSupportOpenIMGroup
10100fe64: aa1403e1    	mov	x1, x20
10100fe68: 95b05cb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fe6c: 340003a0    	cbz	w0, 0x10100fee0 <__text+0x1007ee0>
10100fe70: b8766a68    	ldr	w8, [x19, x22]
10100fe74: 71001d1f    	cmp	w8, #0x7
10100fe78: 54000060    	b.eq	0x10100fe84 <__text+0x1007e84>
10100fe7c: 7100091f    	cmp	w8, #0x2
10100fe80: 540000a1    	b.ne	0x10100fe94 <__text+0x1007e94>
10100fe84: f8796a60    	ldr	x0, [x19, x25]
10100fe88: f94252a1    	ldr	x1, [x21, #0x4a0] ; setM_eFTSSearchType:
10100fe8c: 52800122    	mov	w2, #0x9                ; =9
10100fe90: 95b05cab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fe94: f00f8ec8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10100fe98: b9801508    	ldrsw	x8, [x8, #0x14]
10100fe9c: f8686a60    	ldr	x0, [x19, x8]
10100fea0: b00f7168    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10100fea4: f944bd01    	ldr	x1, [x8, #0x978] ; isOpenImChatroomAndUpgradeOpenIMChatroom
10100fea8: 95b05ca5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100feac: 340001a0    	cbz	w0, 0x10100fee0 <__text+0x1007ee0>
10100feb0: b8766a68    	ldr	w8, [x19, x22]
10100feb4: 7100111f    	cmp	w8, #0x4
10100feb8: 54000148    	b.hi	0x10100fee0 <__text+0x1007ee0>
10100febc: 52800029    	mov	w9, #0x1                ; =1
10100fec0: 1ac82128    	lsl	w8, w9, w8
10100fec4: 52800349    	mov	w9, #0x1a               ; =26
10100fec8: 6a09011f    	tst	w8, w9
10100fecc: 540000a0    	b.eq	0x10100fee0 <__text+0x1007ee0>
10100fed0: f8796a60    	ldr	x0, [x19, x25]
10100fed4: f94252a1    	ldr	x1, [x21, #0x4a0] ; setM_eFTSSearchType:
10100fed8: 52800122    	mov	w2, #0x9                ; =9
10100fedc: 95b05c98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fee0: f8796a60    	ldr	x0, [x19, x25]
10100fee4: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100fee8: f9418501    	ldr	x1, [x8, #0x308] ; m_hadOpenIMContact
10100feec: 95b05c94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100fef0: f00f8ec8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10100fef4: b980191a    	ldrsw	x26, [x8, #0x18]
10100fef8: 383a6a60    	strb	w0, [x19, x26]
10100fefc: f947df00    	ldr	x0, [x24, #0xfb8] ; CGroupMgr
10100ff00: aa1403e1    	mov	x1, x20
10100ff04: 95b05c8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ff08: b8766a68    	ldr	w8, [x19, x22]
10100ff0c: 36000080    	tbz	w0, #0x0, 0x10100ff1c <__text+0x1007f1c>
10100ff10: 7100751f    	cmp	w8, #0x1d
10100ff14: 54000140    	b.eq	0x10100ff3c <__text+0x1007f3c>
10100ff18: 14000012    	b	0x10100ff60 <__text+0x1007f60>
10100ff1c: 7100091f    	cmp	w8, #0x2
10100ff20: 540000a0    	b.eq	0x10100ff34 <__text+0x1007f34>
10100ff24: 7100751f    	cmp	w8, #0x1d
10100ff28: 540000a0    	b.eq	0x10100ff3c <__text+0x1007f3c>
10100ff2c: 71001d1f    	cmp	w8, #0x7
10100ff30: 54000181    	b.ne	0x10100ff60 <__text+0x1007f60>
10100ff34: 383a6a7f    	strb	wzr, [x19, x26]
10100ff38: 1400000a    	b	0x10100ff60 <__text+0x1007f60>
10100ff3c: 383a6a7f    	strb	wzr, [x19, x26]
10100ff40: f8796a60    	ldr	x0, [x19, x25]
10100ff44: f94252a1    	ldr	x1, [x21, #0x4a0] ; setM_eFTSSearchType:
10100ff48: 52800022    	mov	w2, #0x1                ; =1
10100ff4c: 95b05c7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ff50: f8796a60    	ldr	x0, [x19, x25]
10100ff54: f9424ae1    	ldr	x1, [x23, #0x490] ; setM_enAsyncSearchOption:
10100ff58: 52800022    	mov	w2, #0x1                ; =1
10100ff5c: 95b05c78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ff60: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100ff64: f9418901    	ldr	x1, [x8, #0x310] ; shouldExtraMemberMatch
10100ff68: aa1303e0    	mov	x0, x19
10100ff6c: 95b05c74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ff70: aa0003e2    	mov	x2, x0
10100ff74: f8796a60    	ldr	x0, [x19, x25]
10100ff78: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100ff7c: f9418d01    	ldr	x1, [x8, #0x318] ; setBMemberMatch:
10100ff80: 95b05c6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ff84: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100ff88: f9419101    	ldr	x1, [x8, #0x320] ; shouldExtraMemberMatchWithGroup
10100ff8c: aa1303e0    	mov	x0, x19
10100ff90: 95b05c6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ff94: aa0003e2    	mov	x2, x0
10100ff98: f8796a60    	ldr	x0, [x19, x25]
10100ff9c: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100ffa0: f9419501    	ldr	x1, [x8, #0x328] ; setBMemberMatchWithGroups:
10100ffa4: 95b05c66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ffa8: b00f73c8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10100ffac: f9404101    	ldr	x1, [x8, #0x80] ; checkIsOpenRecommendAlreadyHadGroupSwitch
10100ffb0: aa1303e0    	mov	x0, x19
10100ffb4: 95b05c62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10100ffb8: 34000280    	cbz	w0, 0x101010008 <__text+0x1008008>
10100ffbc: 900f8b68    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10100ffc0: f947f500    	ldr	x0, [x8, #0xfe8] ; ContactsSearchGroupDataLogic
10100ffc4: 95b05c65    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10100ffc8: f00f8ec8    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10100ffcc: b9800914    	ldrsw	x20, [x8, #0x8]
10100ffd0: f8746a68    	ldr	x8, [x19, x20]
10100ffd4: f8346a60    	str	x0, [x19, x20]
10100ffd8: aa0803e0    	mov	x0, x8
10100ffdc: 95b05c5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10100ffe0: f8746a60    	ldr	x0, [x19, x20]
10100ffe4: 900f87c8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10100ffe8: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
10100ffec: aa1303e2    	mov	x2, x19
10100fff0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10100fff4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10100fff8: a94257f6    	ldp	x22, x21, [sp, #0x20]
10100fffc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101010000: a8c567fa    	ldp	x26, x25, [sp], #0x50
101010004: 15b05c4e    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101010008: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10101000c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101010010: a94257f6    	ldp	x22, x21, [sp, #0x20]
101010014: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101010018: a8c567fa    	ldp	x26, x25, [sp], #0x50
10101001c: d65f03c0    	ret
