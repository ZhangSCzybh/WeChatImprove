
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104f3a030: d10203ff    	sub	sp, sp, #0x80
104f3a034: a9026ffc    	stp	x28, x27, [sp, #0x20]
104f3a038: a90367fa    	stp	x26, x25, [sp, #0x30]
104f3a03c: a9045ff8    	stp	x24, x23, [sp, #0x40]
104f3a040: a90557f6    	stp	x22, x21, [sp, #0x50]
104f3a044: a9064ff4    	stp	x20, x19, [sp, #0x60]
104f3a048: a9077bfd    	stp	x29, x30, [sp, #0x70]
104f3a04c: 9101c3fd    	add	x29, sp, #0x70
104f3a050: aa0203f3    	mov	x19, x2
104f3a054: aa0003f5    	mov	x21, x0
104f3a058: b00de828    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104f3a05c: 52800029    	mov	w9, #0x1                ; =1
104f3a060: 39103509    	strb	w9, [x8, #0x40d]
104f3a064: aa0203e0    	mov	x0, x2
104f3a068: 94b3b434    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104f3a06c: 52800040    	mov	w0, #0x2                ; =2
104f3a070: 94b34c74    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f3a074: 34000560    	cbz	w0, 0x104f3a120 <_Flutter_MMFoundation_BindContext+0x1415d04>
104f3a078: 94b3b44a    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f3a07c: aa0003f4    	mov	x20, x0
104f3a080: b00d91d7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a084: f94546e0    	ldr	x0, [x23, #0xa88]
104f3a088: 94b3b436    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f3a08c: aa0003f6    	mov	x22, x0
104f3a090: f94546e0    	ldr	x0, [x23, #0xa88]
104f3a094: 900d8e88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f3a098: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f3a09c: f90003ff    	str	xzr, [sp]
104f3a0a0: 900cc442    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f3a0a4: 912c2042    	add	x2, x2, #0xb08 ; cfstring='onInviteMultiTalk'
104f3a0a8: 94b3b425    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a0ac: aa1d03fd    	mov	x29, x29
104f3a0b0: 94b3b426    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a0b4: aa0003f7    	mov	x23, x0
104f3a0b8: 900d8e48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f3a0bc: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f3a0c0: b00cab08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a0c4: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f3a0c8: a90003e8    	stp	x8, x0, [sp]
104f3a0cc: b00cab02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a0d0: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f3a0d4: aa1603e0    	mov	x0, x22
104f3a0d8: 94b3b419    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a0dc: aa0003f6    	mov	x22, x0
104f3a0e0: aa1703e0    	mov	x0, x23
104f3a0e4: 94b3b41c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a0e8: b00b4721    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f3a0ec: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f3a0f0: 900b47e2    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f3a0f4: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f3a0f8: b00b47e4    	adrp	x4, 0x11b837000 <dyld_stub_binder+0x11b837000>
104f3a0fc: 9132b084    	add	x4, x4, #0xcac ; cstring='-[MultiTalkMgr onInviteMultiTalk:]'
104f3a100: 52800040    	mov	w0, #0x2                ; =2
104f3a104: 5280cf63    	mov	w3, #0x67b              ; =1659
104f3a108: aa1603e5    	mov	x5, x22
104f3a10c: 94b34c4e    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f3a110: aa1603e0    	mov	x0, x22
104f3a114: 94b3b410    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a118: aa1403e0    	mov	x0, x20
104f3a11c: 94b3b424    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f3a120: 900d78a8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104f3a124: f944cd01    	ldr	x1, [x8, #0x998] ; selector=isMultiTalkActive
104f3a128: aa1503e0    	mov	x0, x21
104f3a12c: 94b3b404    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a130: 340007c0    	cbz	w0, 0x104f3a228 <_Flutter_MMFoundation_BindContext+0x1415e0c>
104f3a134: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a138: f943e101    	ldr	x1, [x8, #0x7c0] ; selector=mainViewController
104f3a13c: aa1503e0    	mov	x0, x21
104f3a140: 94b3b3ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a144: aa1d03fd    	mov	x29, x29
104f3a148: 94b3b400    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a14c: aa0003f4    	mov	x20, x0
104f3a150: b00d82c8    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
104f3a154: f9454d01    	ldr	x1, [x8, #0xa98] ; selector=isTheSameWithGroup:
104f3a158: aa1303e2    	mov	x2, x19
104f3a15c: 94b3b3f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a160: aa0003f6    	mov	x22, x0
104f3a164: aa1403e0    	mov	x0, x20
104f3a168: 94b3b3fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a16c: 340005f6    	cbz	w22, 0x104f3a228 <_Flutter_MMFoundation_BindContext+0x1415e0c>
104f3a170: 52800040    	mov	w0, #0x2                ; =2
104f3a174: 94b34c33    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f3a178: 34002b20    	cbz	w0, 0x104f3a6dc <_Flutter_MMFoundation_BindContext+0x14162c0>
104f3a17c: 94b3b409    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f3a180: aa0003f4    	mov	x20, x0
104f3a184: b00d91d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a188: f94546c0    	ldr	x0, [x22, #0xa88]
104f3a18c: 94b3b3f5    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f3a190: aa0003f5    	mov	x21, x0
104f3a194: f94546c0    	ldr	x0, [x22, #0xa88]
104f3a198: 900d8e88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f3a19c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f3a1a0: f90003ff    	str	xzr, [sp]
104f3a1a4: 900cc442    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f3a1a8: 912ca042    	add	x2, x2, #0xb28 ; cfstring='ignore same groupInfo when isMultiTalkActive'
104f3a1ac: 94b3b3e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a1b0: aa1d03fd    	mov	x29, x29
104f3a1b4: 94b3b3e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a1b8: aa0003f6    	mov	x22, x0
104f3a1bc: 900d8e48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f3a1c0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f3a1c4: b00cab08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a1c8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f3a1cc: a90003e8    	stp	x8, x0, [sp]
104f3a1d0: b00cab02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a1d4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f3a1d8: aa1503e0    	mov	x0, x21
104f3a1dc: 94b3b3d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a1e0: aa0003f5    	mov	x21, x0
104f3a1e4: aa1603e0    	mov	x0, x22
104f3a1e8: 94b3b3db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a1ec: b00b4721    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f3a1f0: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f3a1f4: 900b47e2    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f3a1f8: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f3a1fc: b00b47e4    	adrp	x4, 0x11b837000 <dyld_stub_binder+0x11b837000>
104f3a200: 9132b084    	add	x4, x4, #0xcac ; cstring='-[MultiTalkMgr onInviteMultiTalk:]'
104f3a204: 52800040    	mov	w0, #0x2                ; =2
104f3a208: 5280cfe3    	mov	w3, #0x67f              ; =1663
104f3a20c: aa1503e5    	mov	x5, x21
104f3a210: 94b34c0d    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f3a214: aa1503e0    	mov	x0, x21
104f3a218: 94b3b3cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a21c: aa1403e0    	mov	x0, x20
104f3a220: 94b3b3e3    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f3a224: 1400012e    	b	0x104f3a6dc <_Flutter_MMFoundation_BindContext+0x14162c0>
104f3a228: b00d92c8    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104f3a22c: f946e100    	ldr	x0, [x8, #0xdc0] ; class=MultiTalkServerConfig
104f3a230: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a234: f945c501    	ldr	x1, [x8, #0xb88] ; selector=shouldBlockReceiver
104f3a238: 94b3b3c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a23c: aa0003e8    	mov	x8, x0
104f3a240: b00d92c9    	adrp	x9, 0x120193000 <dyld_stub_binder+0x120193000>
104f3a244: f9469d20    	ldr	x0, [x9, #0xd38] ; class=MultiTalkMonoMsgIdKeyReport
104f3a248: 34000968    	cbz	w8, 0x104f3a374 <_Flutter_MMFoundation_BindContext+0x1415f58>
104f3a24c: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a250: f945c901    	ldr	x1, [x8, #0xb90] ; selector=msgServerBlockMultiTalk
104f3a254: 94b3b3ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a258: 52800040    	mov	w0, #0x2                ; =2
104f3a25c: 94b34bf9    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f3a260: 34000560    	cbz	w0, 0x104f3a30c <_Flutter_MMFoundation_BindContext+0x1415ef0>
104f3a264: 94b3b3cf    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f3a268: aa0003f4    	mov	x20, x0
104f3a26c: b00d91d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a270: f94546c0    	ldr	x0, [x22, #0xa88]
104f3a274: 94b3b3bb    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f3a278: aa0003f5    	mov	x21, x0
104f3a27c: f94546c0    	ldr	x0, [x22, #0xa88]
104f3a280: 900d8e88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f3a284: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f3a288: f90003ff    	str	xzr, [sp]
104f3a28c: 900cc442    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f3a290: 912d2042    	add	x2, x2, #0xb48 ; cfstring='shouldBlockReceiver'
104f3a294: 94b3b3aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a298: aa1d03fd    	mov	x29, x29
104f3a29c: 94b3b3ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a2a0: aa0003f6    	mov	x22, x0
104f3a2a4: 900d8e48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f3a2a8: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f3a2ac: b00cab08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a2b0: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f3a2b4: a90003e8    	stp	x8, x0, [sp]
104f3a2b8: b00cab02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a2bc: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f3a2c0: aa1503e0    	mov	x0, x21
104f3a2c4: 94b3b39e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a2c8: aa0003f5    	mov	x21, x0
104f3a2cc: aa1603e0    	mov	x0, x22
104f3a2d0: 94b3b3a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a2d4: b00b4721    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f3a2d8: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f3a2dc: 900b47e2    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f3a2e0: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f3a2e4: b00b47e4    	adrp	x4, 0x11b837000 <dyld_stub_binder+0x11b837000>
104f3a2e8: 9132b084    	add	x4, x4, #0xcac ; cstring='-[MultiTalkMgr onInviteMultiTalk:]'
104f3a2ec: 52800040    	mov	w0, #0x2                ; =2
104f3a2f0: 5280d0c3    	mov	w3, #0x686              ; =1670
104f3a2f4: aa1503e5    	mov	x5, x21
104f3a2f8: 94b34bd3    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f3a2fc: aa1503e0    	mov	x0, x21
104f3a300: 94b3b395    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a304: aa1403e0    	mov	x0, x20
104f3a308: 94b3b3a9    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f3a30c: b00d91c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a310: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f3a314: d00d8e28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104f3a318: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
104f3a31c: 94b3b388    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a320: aa1d03fd    	mov	x29, x29
104f3a324: 94b3b389    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a328: aa0003f4    	mov	x20, x0
104f3a32c: b00d9208    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104f3a330: f945cd00    	ldr	x0, [x8, #0xb98] ; class=ConfSDKServiceMgr
104f3a334: b00d8e28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104f3a338: f947ad01    	ldr	x1, [x8, #0xf58] ; selector=class
104f3a33c: 94b3b380    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a340: aa0003e2    	mov	x2, x0
104f3a344: f00d77e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f3a348: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
104f3a34c: aa1403e0    	mov	x0, x20
104f3a350: 94b3b37b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a354: aa1d03fd    	mov	x29, x29
104f3a358: 94b3b37c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a35c: aa0003f5    	mov	x21, x0
104f3a360: f00d7a48    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104f3a364: f945c101    	ldr	x1, [x8, #0xb80] ; selector=hangup:
104f3a368: 52800022    	mov	w2, #0x1                ; =1
104f3a36c: 94b3b374    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a370: 140000d7    	b	0x104f3a6cc <_Flutter_MMFoundation_BindContext+0x14162b0>
104f3a374: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a378: f945cd01    	ldr	x1, [x8, #0xb98] ; selector=msgSyncInvite
104f3a37c: 94b3b370    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a380: b00d92d6    	adrp	x22, 0x120193000 <dyld_stub_binder+0x120193000>
104f3a384: f9467ad4    	ldr	x20, [x22, #0xcf0] ; class=MultiTalkMonoMsg
104f3a388: d00d7c88    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
104f3a38c: f947fd01    	ldr	x1, [x8, #0xff8] ; selector=mroomid
104f3a390: aa1303e0    	mov	x0, x19
104f3a394: 94b3b36a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a398: aa0003e2    	mov	x2, x0
104f3a39c: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a3a0: f945d101    	ldr	x1, [x8, #0xba0] ; selector=inviteMsgWithRoomID:
104f3a3a4: aa1403e0    	mov	x0, x20
104f3a3a8: 94b3b365    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a3ac: aa1d03fd    	mov	x29, x29
104f3a3b0: 94b3b366    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a3b4: aa0003f4    	mov	x20, x0
104f3a3b8: b00d82c8    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
104f3a3bc: f9454901    	ldr	x1, [x8, #0xa90] ; selector=setM_group:
104f3a3c0: aa1303e2    	mov	x2, x19
104f3a3c4: 94b3b35e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a3c8: f9467ac0    	ldr	x0, [x22, #0xcf0] ; class=MultiTalkMonoMsg
104f3a3cc: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a3d0: f945d501    	ldr	x1, [x8, #0xba8] ; selector=getInviteUserFromGroup:
104f3a3d4: aa1303e2    	mov	x2, x19
104f3a3d8: 94b3b359    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a3dc: aa1d03fd    	mov	x29, x29
104f3a3e0: 94b3b35a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a3e4: aa0003f7    	mov	x23, x0
104f3a3e8: f00d79c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
104f3a3ec: f9431116    	ldr	x22, [x8, #0x620] ; selector=setM_fromUser:
104f3a3f0: aa1403e0    	mov	x0, x20
104f3a3f4: aa1603e1    	mov	x1, x22
104f3a3f8: aa1703e2    	mov	x2, x23
104f3a3fc: 94b3b350    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a400: aa1703e0    	mov	x0, x23
104f3a404: 94b3b354    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a408: f00d77e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f3a40c: f946d101    	ldr	x1, [x8, #0xda0] ; selector=setM_delegate:
104f3a410: aa1403e0    	mov	x0, x20
104f3a414: aa1503e2    	mov	x2, x21
104f3a418: 94b3b349    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a41c: d00d8288    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104f3a420: f9450915    	ldr	x21, [x8, #0xa10] ; selector=m_fromUser
104f3a424: aa1403e0    	mov	x0, x20
104f3a428: aa1503e1    	mov	x1, x21
104f3a42c: 94b3b344    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a430: aa1d03fd    	mov	x29, x29
104f3a434: 94b3b345    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a438: aa0003f7    	mov	x23, x0
104f3a43c: b00d8e48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104f3a440: f946e901    	ldr	x1, [x8, #0xdd0] ; selector=length
104f3a444: 94b3b33e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a448: b00d91c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a44c: d00d8e29    	adrp	x9, 0x120100000 <dyld_stub_binder+0x120100000>
104f3a450: b00d8e39    	adrp	x25, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104f3a454: f00d77f8    	adrp	x24, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f3a458: b5000800    	cbnz	x0, 0x104f3a558 <_Flutter_MMFoundation_BindContext+0x141613c>
104f3a45c: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f3a460: f944e921    	ldr	x1, [x9, #0x9d0] ; selector=currentContext
104f3a464: f9000fe1    	str	x1, [sp, #0x18]
104f3a468: 94b3b335    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a46c: aa1d03fd    	mov	x29, x29
104f3a470: 94b3b336    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a474: aa0003fb    	mov	x27, x0
104f3a478: b00d9208    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104f3a47c: f940fd00    	ldr	x0, [x8, #0x1f8] ; class=VoIPilinkMgr
104f3a480: f947af39    	ldr	x25, [x25, #0xf58] ; selector=class
104f3a484: aa1903e1    	mov	x1, x25
104f3a488: 94b3b32d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a48c: aa0003e2    	mov	x2, x0
104f3a490: f946431a    	ldr	x26, [x24, #0xc80] ; selector=getService:
104f3a494: aa1b03e0    	mov	x0, x27
104f3a498: aa1a03e1    	mov	x1, x26
104f3a49c: 94b3b328    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a4a0: aa1d03fd    	mov	x29, x29
104f3a4a4: 94b3b329    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a4a8: aa0003fc    	mov	x28, x0
104f3a4ac: 900d7de8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
104f3a4b0: f9402d01    	ldr	x1, [x8, #0x58] ; selector=changeToMultiTalk
104f3a4b4: 94b3b322    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a4b8: aa0003f8    	mov	x24, x0
104f3a4bc: aa1c03e0    	mov	x0, x28
104f3a4c0: 94b3b325    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a4c4: aa1b03e0    	mov	x0, x27
104f3a4c8: 94b3b323    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a4cc: aa1703e0    	mov	x0, x23
104f3a4d0: 94b3b321    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a4d4: 34000478    	cbz	w24, 0x104f3a560 <_Flutter_MMFoundation_BindContext+0x1416144>
104f3a4d8: b00d91c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a4dc: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f3a4e0: f9400fe1    	ldr	x1, [sp, #0x18]
104f3a4e4: 94b3b316    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a4e8: aa1d03fd    	mov	x29, x29
104f3a4ec: 94b3b317    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a4f0: aa0003f7    	mov	x23, x0
104f3a4f4: b00d9208    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104f3a4f8: f940fd00    	ldr	x0, [x8, #0x1f8] ; class=VoIPilinkMgr
104f3a4fc: aa1903e1    	mov	x1, x25
104f3a500: 94b3b30f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a504: aa0003e2    	mov	x2, x0
104f3a508: aa1703e0    	mov	x0, x23
104f3a50c: aa1a03e1    	mov	x1, x26
104f3a510: 94b3b30b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a514: aa1d03fd    	mov	x29, x29
104f3a518: 94b3b30c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a51c: aa0003f8    	mov	x24, x0
104f3a520: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a524: f945d901    	ldr	x1, [x8, #0xbb0] ; selector=getCallerName
104f3a528: 94b3b305    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a52c: aa1d03fd    	mov	x29, x29
104f3a530: 94b3b306    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a534: aa0003f9    	mov	x25, x0
104f3a538: aa1403e0    	mov	x0, x20
104f3a53c: aa1603e1    	mov	x1, x22
104f3a540: aa1903e2    	mov	x2, x25
104f3a544: 94b3b2fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a548: aa1903e0    	mov	x0, x25
104f3a54c: 94b3b302    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a550: aa1803e0    	mov	x0, x24
104f3a554: 94b3b300    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a558: aa1703e0    	mov	x0, x23
104f3a55c: 94b3b2fe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a560: 52800040    	mov	w0, #0x2                ; =2
104f3a564: 94b34b37    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
104f3a568: 340006a0    	cbz	w0, 0x104f3a63c <_Flutter_MMFoundation_BindContext+0x1416220>
104f3a56c: 94b3b30d    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104f3a570: aa0003f6    	mov	x22, x0
104f3a574: b00d91d8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a578: f9454700    	ldr	x0, [x24, #0xa88]
104f3a57c: 94b3b2f9    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104f3a580: aa0003f7    	mov	x23, x0
104f3a584: f9454718    	ldr	x24, [x24, #0xa88]
104f3a588: aa1403e0    	mov	x0, x20
104f3a58c: aa1503e1    	mov	x1, x21
104f3a590: 94b3b2eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a594: aa1d03fd    	mov	x29, x29
104f3a598: 94b3b2ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a59c: aa0003f5    	mov	x21, x0
104f3a5a0: 900d8e88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104f3a5a4: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
104f3a5a8: a900ffe0    	stp	x0, xzr, [sp, #0x8]
104f3a5ac: f90003f3    	str	x19, [sp]
104f3a5b0: 900cc442    	adrp	x2, 0x11e7c2000 <dyld_stub_binder+0x11e7c2000>
104f3a5b4: 912da042    	add	x2, x2, #0xb68 ; cfstring='tempMonoMsg: %@, %@'
104f3a5b8: aa1803e0    	mov	x0, x24
104f3a5bc: 94b3b2e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a5c0: aa1d03fd    	mov	x29, x29
104f3a5c4: 94b3b2e1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a5c8: aa0003f8    	mov	x24, x0
104f3a5cc: 900d8e48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104f3a5d0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
104f3a5d4: b00cab08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a5d8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
104f3a5dc: a90003e8    	stp	x8, x0, [sp]
104f3a5e0: b00cab02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104f3a5e4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
104f3a5e8: aa1703e0    	mov	x0, x23
104f3a5ec: 94b3b2d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a5f0: aa0003f7    	mov	x23, x0
104f3a5f4: aa1803e0    	mov	x0, x24
104f3a5f8: 94b3b2d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a5fc: aa1503e0    	mov	x0, x21
104f3a600: 94b3b2d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a604: b00b4721    	adrp	x1, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104f3a608: 9124bc21    	add	x1, x1, #0x92f ; cstring='MultiTalk'
104f3a60c: 900b47e2    	adrp	x2, 0x11b836000 <dyld_stub_binder+0x11b836000>
104f3a610: 912f0842    	add	x2, x2, #0xbc2 ; cstring='MultiTalkMgr.mm'
104f3a614: b00b47e4    	adrp	x4, 0x11b837000 <dyld_stub_binder+0x11b837000>
104f3a618: 9132b084    	add	x4, x4, #0xcac ; cstring='-[MultiTalkMgr onInviteMultiTalk:]'
104f3a61c: 52800040    	mov	w0, #0x2                ; =2
104f3a620: 5280d303    	mov	w3, #0x698              ; =1688
104f3a624: aa1703e5    	mov	x5, x23
104f3a628: 94b34b07    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
104f3a62c: aa1703e0    	mov	x0, x23
104f3a630: 94b3b2c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a634: aa1603e0    	mov	x0, x22
104f3a638: 94b3b2dd    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104f3a63c: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a640: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector=mMuteNotification
104f3a644: aa1303e0    	mov	x0, x19
104f3a648: 94b3b2bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a64c: aa0003e2    	mov	x2, x0
104f3a650: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a654: f945e101    	ldr	x1, [x8, #0xbc0] ; selector=setM_muteNotification:
104f3a658: aa1403e0    	mov	x0, x20
104f3a65c: 94b3b2b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a660: b00d91c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104f3a664: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
104f3a668: d00d8e28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104f3a66c: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
104f3a670: 94b3b2b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a674: aa1d03fd    	mov	x29, x29
104f3a678: 94b3b2b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a67c: aa0003f5    	mov	x21, x0
104f3a680: b00d92a8    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
104f3a684: f9473900    	ldr	x0, [x8, #0xe70] ; class=MonoServiceMsgMgr
104f3a688: b00d8e28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104f3a68c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector=class
104f3a690: 94b3b2ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a694: aa0003e2    	mov	x2, x0
104f3a698: f00d77e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104f3a69c: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
104f3a6a0: aa1503e0    	mov	x0, x21
104f3a6a4: 94b3b2a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a6a8: aa1d03fd    	mov	x29, x29
104f3a6ac: 94b3b2a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104f3a6b0: aa0003f6    	mov	x22, x0
104f3a6b4: d00d82c8    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
104f3a6b8: f945e501    	ldr	x1, [x8, #0xbc8] ; selector=inQueueMsg:
104f3a6bc: aa1403e2    	mov	x2, x20
104f3a6c0: 94b3b29f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104f3a6c4: aa1603e0    	mov	x0, x22
104f3a6c8: 94b3b2a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a6cc: aa1503e0    	mov	x0, x21
104f3a6d0: 94b3b2a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a6d4: aa1403e0    	mov	x0, x20
104f3a6d8: 94b3b29f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104f3a6dc: aa1303e0    	mov	x0, x19
104f3a6e0: a9477bfd    	ldp	x29, x30, [sp, #0x70]
104f3a6e4: a9464ff4    	ldp	x20, x19, [sp, #0x60]
104f3a6e8: a94557f6    	ldp	x22, x21, [sp, #0x50]
104f3a6ec: a9445ff8    	ldp	x24, x23, [sp, #0x40]
104f3a6f0: a94367fa    	ldp	x26, x25, [sp, #0x30]
104f3a6f4: a9426ffc    	ldp	x28, x27, [sp, #0x20]
104f3a6f8: 910203ff    	add	sp, sp, #0x80
104f3a6fc: 14b3b296    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
