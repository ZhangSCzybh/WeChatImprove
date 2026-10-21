
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106262994: d10183ff    	sub	sp, sp, #0x60
106262998: a90167fa    	stp	x26, x25, [sp, #0x10]
10626299c: a9025ff8    	stp	x24, x23, [sp, #0x20]
1062629a0: a90357f6    	stp	x22, x21, [sp, #0x30]
1062629a4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1062629a8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1062629ac: 910143fd    	add	x29, sp, #0x50
1062629b0: aa0303f4    	mov	x20, x3
1062629b4: aa0203f3    	mov	x19, x2
1062629b8: aa0003f6    	mov	x22, x0
1062629bc: b00d4f08    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062629c0: 52800029    	mov	w9, #0x1                ; =1
1062629c4: 39269509    	strb	w9, [x8, #0x9a5]
1062629c8: aa0203e0    	mov	x0, x2
1062629cc: 946711db    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1062629d0: aa1403e0    	mov	x0, x20
1062629d4: 946711d9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1062629d8: 52800040    	mov	w0, #0x2                ; =2
1062629dc: 9466aa19    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1062629e0: 900cdf79    	adrp	x25, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1062629e4: 340005e0    	cbz	w0, 0x106262aa0 <_Flutter_MMFoundation_BindContext+0x273e684>
1062629e8: 946711ee    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1062629ec: aa0003f5    	mov	x21, x0
1062629f0: b00cf898    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1062629f4: f9454700    	ldr	x0, [x24, #0xa88]
1062629f8: 946711da    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1062629fc: aa0003f7    	mov	x23, x0
106262a00: f9454718    	ldr	x24, [x24, #0xa88]
106262a04: f9450721    	ldr	x1, [x25, #0xa08] ; roomid
106262a08: aa1303e0    	mov	x0, x19
106262a0c: 946711cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262a10: 900cf548    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106262a14: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106262a18: a9007fe0    	stp	x0, xzr, [sp]
106262a1c: f00c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106262a20: 91252042    	add	x2, x2, #0x948
106262a24: aa1803e0    	mov	x0, x24
106262a28: 946711c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262a2c: aa1d03fd    	mov	x29, x29
106262a30: 946711c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262a34: aa0003f8    	mov	x24, x0
106262a38: 900cf508    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106262a3c: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106262a40: b00c11c8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106262a44: 91352108    	add	x8, x8, #0xd48
106262a48: a90003e8    	stp	x8, x0, [sp]
106262a4c: b00c11c2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106262a50: 9134a042    	add	x2, x2, #0xd28
106262a54: aa1703e0    	mov	x0, x23
106262a58: 946711b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262a5c: aa0003f7    	mov	x23, x0
106262a60: aa1803e0    	mov	x0, x24
106262a64: 946711bc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262a68: f00a7d81    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106262a6c: 9124e421    	add	x1, x1, #0x939
106262a70: 900ab9e2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106262a74: 91112042    	add	x2, x2, #0x448
106262a78: d00ab9e4    	adrp	x4, 0x11b9a0000 <dyld_stub_binder+0x11b9a0000>
106262a7c: 91334c84    	add	x4, x4, #0xcd3
106262a80: 52800040    	mov	w0, #0x2                ; =2
106262a84: 52818be3    	mov	w3, #0xc5f              ; =3167
106262a88: aa1703e5    	mov	x5, x23
106262a8c: 9466a9ee    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106262a90: aa1703e0    	mov	x0, x23
106262a94: 946711b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262a98: aa1503e0    	mov	x0, x21
106262a9c: 946711c4    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106262aa0: 900ce2a8    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
106262aa4: f946e101    	ldr	x1, [x8, #0xdc0] ; setIsActived:
106262aa8: aa1603e0    	mov	x0, x22
106262aac: 52800022    	mov	w2, #0x1                ; =1
106262ab0: 946711a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262ab4: 900cdec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106262ab8: f947c101    	ldr	x1, [x8, #0xf80] ; setIsThisTalkIlink:
106262abc: aa1603e0    	mov	x0, x22
106262ac0: 52800022    	mov	w2, #0x1                ; =1
106262ac4: 9467119e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262ac8: 900ce4a8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
106262acc: f942a101    	ldr	x1, [x8, #0x540] ; subCall
106262ad0: aa1303e0    	mov	x0, x19
106262ad4: 9467119a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262ad8: 34000de0    	cbz	w0, 0x106262c94 <_Flutter_MMFoundation_BindContext+0x273e878>
106262adc: b00cf988    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
106262ae0: f9467915    	ldr	x21, [x8, #0xcf0]
106262ae4: f9450737    	ldr	x23, [x25, #0xa08] ; roomid
106262ae8: aa1303e0    	mov	x0, x19
106262aec: aa1703e1    	mov	x1, x23
106262af0: 94671193    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262af4: aa0003e2    	mov	x2, x0
106262af8: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262afc: f945d101    	ldr	x1, [x8, #0xba0] ; inviteMsgWithRoomID:
106262b00: aa1503e0    	mov	x0, x21
106262b04: 9467118e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262b08: aa1d03fd    	mov	x29, x29
106262b0c: 9467118f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262b10: aa0003f5    	mov	x21, x0
106262b14: 900cf8a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106262b18: f9457500    	ldr	x0, [x8, #0xae8]
106262b1c: 9467118f    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106262b20: aa0003f6    	mov	x22, x0
106262b24: aa1303e0    	mov	x0, x19
106262b28: aa1703e1    	mov	x1, x23
106262b2c: 94671184    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262b30: aa0003e2    	mov	x2, x0
106262b34: d00ce348    	adrp	x8, 0x11fecc000 <dyld_stub_binder+0x11fecc000>
106262b38: f947c101    	ldr	x1, [x8, #0xf80] ; setMroomid:
106262b3c: aa1603e0    	mov	x0, x22
106262b40: 9467117f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262b44: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262b48: f946b117    	ldr	x23, [x8, #0xd60] ; wxGroupid
106262b4c: aa1403e0    	mov	x0, x20
106262b50: aa1703e1    	mov	x1, x23
106262b54: 9467117a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262b58: aa1d03fd    	mov	x29, x29
106262b5c: 9467117b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262b60: aa0003f8    	mov	x24, x0
106262b64: 900cdf68    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
106262b68: f944f501    	ldr	x1, [x8, #0x9e8] ; setMMultiTalkGroupId:
106262b6c: aa1603e0    	mov	x0, x22
106262b70: aa1803e2    	mov	x2, x24
106262b74: 94671172    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262b78: aa1803e0    	mov	x0, x24
106262b7c: 94671176    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262b80: aa1403e0    	mov	x0, x20
106262b84: aa1703e1    	mov	x1, x23
106262b88: 9467116d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262b8c: aa1d03fd    	mov	x29, x29
106262b90: 9467116e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262b94: aa0003f7    	mov	x23, x0
106262b98: 900cdf68    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
106262b9c: f944f901    	ldr	x1, [x8, #0x9f0] ; setMWxGroupId:
106262ba0: aa1603e0    	mov	x0, x22
106262ba4: aa1703e2    	mov	x2, x23
106262ba8: 94671165    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262bac: aa1703e0    	mov	x0, x23
106262bb0: 94671169    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262bb4: b00ce988    	adrp	x8, 0x11ff93000 <dyld_stub_binder+0x11ff93000>
106262bb8: f9454901    	ldr	x1, [x8, #0xa90] ; setM_group:
106262bbc: aa1503e0    	mov	x0, x21
106262bc0: aa1603e2    	mov	x2, x22
106262bc4: 9467115e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262bc8: b00ce2e8    	adrp	x8, 0x11febf000 <dyld_stub_binder+0x11febf000>
106262bcc: f9408101    	ldr	x1, [x8, #0x100] ; fromUsername
106262bd0: aa1403e0    	mov	x0, x20
106262bd4: 9467115a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262bd8: aa1d03fd    	mov	x29, x29
106262bdc: 9467115b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262be0: aa0003f7    	mov	x23, x0
106262be4: f00ce088    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
106262be8: f9431101    	ldr	x1, [x8, #0x620] ; setM_fromUser:
106262bec: aa1503e0    	mov	x0, x21
106262bf0: aa1703e2    	mov	x2, x23
106262bf4: 94671152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262bf8: aa1703e0    	mov	x0, x23
106262bfc: 94671156    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262c00: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262c04: f9470501    	ldr	x1, [x8, #0xe08] ; mutenotification
106262c08: aa1403e0    	mov	x0, x20
106262c0c: 9467114c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262c10: aa0003e2    	mov	x2, x0
106262c14: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262c18: f945e101    	ldr	x1, [x8, #0xbc0] ; setM_muteNotification:
106262c1c: aa1503e0    	mov	x0, x21
106262c20: 94671147    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262c24: b00cf888    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106262c28: f945e900    	ldr	x0, [x8, #0xbd0]
106262c2c: d00cf4e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106262c30: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106262c34: 94671142    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262c38: aa1d03fd    	mov	x29, x29
106262c3c: 94671143    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262c40: aa0003f7    	mov	x23, x0
106262c44: b00cf968    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
106262c48: f9473900    	ldr	x0, [x8, #0xe70]
106262c4c: b00cf4e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106262c50: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106262c54: 9467113a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262c58: aa0003e2    	mov	x2, x0
106262c5c: f00cdea8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106262c60: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106262c64: aa1703e0    	mov	x0, x23
106262c68: 94671135    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262c6c: aa1d03fd    	mov	x29, x29
106262c70: 94671136    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262c74: aa0003f8    	mov	x24, x0
106262c78: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262c7c: f945e501    	ldr	x1, [x8, #0xbc8] ; inQueueMsg:
106262c80: aa1503e2    	mov	x2, x21
106262c84: 9467112e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262c88: aa1803e0    	mov	x0, x24
106262c8c: 94671132    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262c90: 14000036    	b	0x106262d68 <_Flutter_MMFoundation_BindContext+0x273e94c>
106262c94: d00ceb48    	adrp	x8, 0x11ffcc000 <dyld_stub_binder+0x11ffcc000>
106262c98: f943d501    	ldr	x1, [x8, #0x7a8] ; notificationPushType
106262c9c: aa1603e0    	mov	x0, x22
106262ca0: 94671127    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262ca4: 7100081f    	cmp	w0, #0x2
106262ca8: 52800068    	mov	w8, #0x3                ; =3
106262cac: 1a9f0102    	csel	w2, w8, wzr, eq
106262cb0: b00ceb88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106262cb4: f944c501    	ldr	x1, [x8, #0x988] ; inviteVoIPMonoMsg:
106262cb8: aa1303e0    	mov	x0, x19
106262cbc: 94671120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262cc0: aa1d03fd    	mov	x29, x29
106262cc4: 94671121    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262cc8: aa0003f5    	mov	x21, x0
106262ccc: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262cd0: f9470501    	ldr	x1, [x8, #0xe08] ; mutenotification
106262cd4: aa1403e0    	mov	x0, x20
106262cd8: 94671119    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262cdc: aa0003e2    	mov	x2, x0
106262ce0: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262ce4: f945e101    	ldr	x1, [x8, #0xbc0] ; setM_muteNotification:
106262ce8: aa1503e0    	mov	x0, x21
106262cec: 94671114    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262cf0: f00cdea8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106262cf4: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
106262cf8: aa1503e0    	mov	x0, x21
106262cfc: aa1603e2    	mov	x2, x22
106262d00: 9467110f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262d04: b00cf888    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106262d08: f945e900    	ldr	x0, [x8, #0xbd0]
106262d0c: d00cf4e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106262d10: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106262d14: 9467110a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262d18: aa1d03fd    	mov	x29, x29
106262d1c: 9467110b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262d20: aa0003f6    	mov	x22, x0
106262d24: b00cf968    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
106262d28: f9473900    	ldr	x0, [x8, #0xe70]
106262d2c: b00cf4e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106262d30: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106262d34: 94671102    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262d38: aa0003e2    	mov	x2, x0
106262d3c: f00cdea8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106262d40: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106262d44: aa1603e0    	mov	x0, x22
106262d48: 946710fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262d4c: aa1d03fd    	mov	x29, x29
106262d50: 946710fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262d54: aa0003f7    	mov	x23, x0
106262d58: d00ce988    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
106262d5c: f945e501    	ldr	x1, [x8, #0xbc8] ; inQueueMsg:
106262d60: aa1503e2    	mov	x2, x21
106262d64: 946710f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262d68: aa1703e0    	mov	x0, x23
106262d6c: 946710fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262d70: aa1603e0    	mov	x0, x22
106262d74: 946710f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262d78: aa1503e0    	mov	x0, x21
106262d7c: 946710f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262d80: aa1403e0    	mov	x0, x20
106262d84: 946710f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262d88: aa1303e0    	mov	x0, x19
106262d8c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106262d90: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106262d94: a94357f6    	ldp	x22, x21, [sp, #0x30]
106262d98: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106262d9c: a94167fa    	ldp	x26, x25, [sp, #0x10]
106262da0: 910183ff    	add	sp, sp, #0x60
106262da4: 146710ec    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
