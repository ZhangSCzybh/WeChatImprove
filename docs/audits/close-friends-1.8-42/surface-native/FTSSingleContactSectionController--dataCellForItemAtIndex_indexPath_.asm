
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017e0260: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1017e0264: a90167fa    	stp	x26, x25, [sp, #0x10]
1017e0268: a9025ff8    	stp	x24, x23, [sp, #0x20]
1017e026c: a90357f6    	stp	x22, x21, [sp, #0x30]
1017e0270: a9044ff4    	stp	x20, x19, [sp, #0x40]
1017e0274: a9057bfd    	stp	x29, x30, [sp, #0x50]
1017e0278: 910143fd    	add	x29, sp, #0x50
1017e027c: aa0303f3    	mov	x19, x3
1017e0280: aa0203f4    	mov	x20, x2
1017e0284: aa0003f5    	mov	x21, x0
1017e0288: d00fa288    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
1017e028c: 52800029    	mov	w9, #0x1                ; =1
1017e0290: 3929a909    	strb	w9, [x8, #0xa6a]
1017e0294: aa0303e0    	mov	x0, x3
1017e0298: 95911ba8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017e029c: b00f5088    	adrp	x8, 0x1201f1000 <dyld_stub_binder+0x1201f1000>
1017e02a0: b986a508    	ldrsw	x8, [x8, #0x6a4] ; ivar FTSSingleContactSectionController._contacts
1017e02a4: f8686aa0    	ldr	x0, [x21, x8]
1017e02a8: d00f32c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1017e02ac: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
1017e02b0: aa1403e2    	mov	x2, x20
1017e02b4: 95911ba2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e02b8: aa1d03fd    	mov	x29, x29
1017e02bc: 95911ba3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e02c0: aa0003f6    	mov	x22, x0
1017e02c4: 900f4928    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1017e02c8: f9447d01    	ldr	x1, [x8, #0x8f8] ; model
1017e02cc: 95911b9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e02d0: aa1d03fd    	mov	x29, x29
1017e02d4: 95911b9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e02d8: aa0003f4    	mov	x20, x0
1017e02dc: aa1603e0    	mov	x0, x22
1017e02e0: 95911b9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e02e4: f00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e02e8: f9478100    	ldr	x0, [x8, #0xf00] ;  /,
1017e02ec: f00f48e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1017e02f0: f947ad17    	ldr	x23, [x8, #0xf58] ; class
1017e02f4: aa1703e1    	mov	x1, x23
1017e02f8: 95911b91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e02fc: aa0003e2    	mov	x2, x0
1017e0300: f00f4908    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017e0304: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1017e0308: aa1403e0    	mov	x0, x20
1017e030c: 95911b8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0310: 34000dc0    	cbz	w0, 0x1017e04c8 <__text+0x17d84c8>
1017e0314: d00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e0318: f9424901    	ldr	x1, [x8, #0x490] ; tableViewContext
1017e031c: aa1503e0    	mov	x0, x21
1017e0320: 95911b87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0324: aa1d03fd    	mov	x29, x29
1017e0328: 95911b88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e032c: aa0003f8    	mov	x24, x0
1017e0330: f00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e0334: f9461d00    	ldr	x0, [x8, #0xc38]
1017e0338: aa1703e1    	mov	x1, x23
1017e033c: 95911b80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0340: aa0003f6    	mov	x22, x0
1017e0344: d00f4928    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1017e0348: f9440901    	ldr	x1, [x8, #0x810] ; row
1017e034c: aa1303e0    	mov	x0, x19
1017e0350: 95911b7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0354: aa0003e4    	mov	x4, x0
1017e0358: d00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e035c: f9424d01    	ldr	x1, [x8, #0x498] ; dequeueReusableCellOfClass:forSectionController:atIndex:
1017e0360: aa1803e0    	mov	x0, x24
1017e0364: aa1603e2    	mov	x2, x22
1017e0368: aa1503e3    	mov	x3, x21
1017e036c: 95911b74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0370: aa1d03fd    	mov	x29, x29
1017e0374: 95911b75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0378: aa0003f6    	mov	x22, x0
1017e037c: aa1803e0    	mov	x0, x24
1017e0380: 95911b75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0384: f00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e0388: f945e918    	ldr	x24, [x8, #0xbd0]
1017e038c: 900f4908    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017e0390: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
1017e0394: aa1403e0    	mov	x0, x20
1017e0398: 95911b68    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1017e039c: aa1803e0    	mov	x0, x24
1017e03a0: aa1903e1    	mov	x1, x25
1017e03a4: 95911b66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e03a8: aa1d03fd    	mov	x29, x29
1017e03ac: 95911b67    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e03b0: aa0003f8    	mov	x24, x0
1017e03b4: f00f4c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017e03b8: f9477100    	ldr	x0, [x8, #0xee0]
1017e03bc: aa1703e1    	mov	x1, x23
1017e03c0: 95911b5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e03c4: aa0003e2    	mov	x2, x0
1017e03c8: b00f32c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017e03cc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1017e03d0: aa1803e0    	mov	x0, x24
1017e03d4: 95911b5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e03d8: aa1d03fd    	mov	x29, x29
1017e03dc: 95911b5b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e03e0: aa0003f7    	mov	x23, x0
1017e03e4: f00f32c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1017e03e8: f9430d01    	ldr	x1, [x8, #0x618] ; ftsContactMgr
1017e03ec: 95911b54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e03f0: aa1d03fd    	mov	x29, x29
1017e03f4: 95911b55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e03f8: aa0003f9    	mov	x25, x0
1017e03fc: f00f32c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1017e0400: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
1017e0404: aa1403e0    	mov	x0, x20
1017e0408: 95911b4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e040c: aa1d03fd    	mov	x29, x29
1017e0410: 95911b4e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0414: aa0003fa    	mov	x26, x0
1017e0418: d00f3628    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
1017e041c: f943a101    	ldr	x1, [x8, #0x740] ; ftsTaskKey
1017e0420: aa1503e0    	mov	x0, x21
1017e0424: 95911b46    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0428: aa1d03fd    	mov	x29, x29
1017e042c: 95911b47    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0430: aa0003f5    	mov	x21, x0
1017e0434: d00f3528    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
1017e0438: f9441901    	ldr	x1, [x8, #0x830] ; getMatchTipForUserName:taskKey:
1017e043c: aa1903e0    	mov	x0, x25
1017e0440: aa1a03e2    	mov	x2, x26
1017e0444: aa1503e3    	mov	x3, x21
1017e0448: 95911b3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e044c: aa1d03fd    	mov	x29, x29
1017e0450: 95911b3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017e0454: aa0003fb    	mov	x27, x0
1017e0458: aa1503e0    	mov	x0, x21
1017e045c: 95911b3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0460: aa1a03e0    	mov	x0, x26
1017e0464: 95911b3c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0468: aa1903e0    	mov	x0, x25
1017e046c: 95911b3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0470: aa1703e0    	mov	x0, x23
1017e0474: 95911b38    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0478: aa1803e0    	mov	x0, x24
1017e047c: 95911b36    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e0480: b00f32c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017e0484: f9463d01    	ldr	x1, [x8, #0xc78] ; updateContact:matchTip:
1017e0488: aa1603e0    	mov	x0, x22
1017e048c: aa1403e2    	mov	x2, x20
1017e0490: aa1b03e3    	mov	x3, x27
1017e0494: 95911b2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e0498: aa1403e0    	mov	x0, x20
1017e049c: 95911b2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e04a0: d00f32c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1017e04a4: f943a501    	ldr	x1, [x8, #0x748] ; attachObject:forKey:
1017e04a8: f00e6d43    	adrp	x3, 0x11e58b000 <dyld_stub_binder+0x11e58b000>
1017e04ac: 91092063    	add	x3, x3, #0x248
1017e04b0: aa1603e0    	mov	x0, x22
1017e04b4: aa1b03e2    	mov	x2, x27
1017e04b8: 95911b21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017e04bc: aa1b03e0    	mov	x0, x27
1017e04c0: 95911b25    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e04c4: 14000002    	b	0x1017e04cc <__text+0x17d84cc>
1017e04c8: d2800016    	mov	x22, #0x0               ; =0
1017e04cc: aa1403e0    	mov	x0, x20
1017e04d0: 95911b21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e04d4: aa1303e0    	mov	x0, x19
1017e04d8: 95911b1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017e04dc: aa1603e0    	mov	x0, x22
1017e04e0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1017e04e4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1017e04e8: a94357f6    	ldp	x22, x21, [sp, #0x30]
1017e04ec: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1017e04f0: a94167fa    	ldp	x26, x25, [sp, #0x10]
1017e04f4: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1017e04f8: 15911b1e    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
