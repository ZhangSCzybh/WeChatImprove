
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1042bae20: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1042bae24: a90157f6    	stp	x22, x21, [sp, #0x10]
1042bae28: a9024ff4    	stp	x20, x19, [sp, #0x20]
1042bae2c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1042bae30: 9100c3fd    	add	x29, sp, #0x30
1042bae34: aa0303f3    	mov	x19, x3
1042bae38: d00e4c08    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
1042bae3c: 52800029    	mov	w9, #0x1                ; =1
1042bae40: 3915ad09    	strb	w9, [x8, #0x56b]
1042bae44: d00df657    	adrp	x23, 0x120184000 <dyld_stub_binder+0x120184000>
1042bae48: f942eaf4    	ldr	x20, [x23, #0x5d0]
1042bae4c: f00de508    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042bae50: f9475515    	ldr	x21, [x8, #0xea8] ; localUsrDirPath
1042bae54: aa0303e0    	mov	x0, x3
1042bae58: 94e5b0b8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1042bae5c: aa1403e0    	mov	x0, x20
1042bae60: aa1503e1    	mov	x1, x21
1042bae64: 94e5b0b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042bae68: aa1d03fd    	mov	x29, x29
1042bae6c: 94e5b0b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042bae70: aa0003f5    	mov	x21, x0
1042bae74: f00de4a8    	adrp	x8, 0x11ff51000 <dyld_stub_binder+0x11ff51000>
1042bae78: f945d514    	ldr	x20, [x8, #0xba8] ; addPathToBePreserved:
1042bae7c: aa1303e0    	mov	x0, x19
1042bae80: aa1403e1    	mov	x1, x20
1042bae84: aa1503e2    	mov	x2, x21
1042bae88: 94e5b0ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042bae8c: aa1503e0    	mov	x0, x21
1042bae90: 94e5b0b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042bae94: f942eae0    	ldr	x0, [x23, #0x5d0]
1042bae98: b00de428    	adrp	x8, 0x11ff3f000 <dyld_stub_binder+0x11ff3f000>
1042bae9c: f940c101    	ldr	x1, [x8, #0x180] ; liveStickersTempBasePath
1042baea0: 94e5b0a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baea4: aa1d03fd    	mov	x29, x29
1042baea8: 94e5b0a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042baeac: aa0003f5    	mov	x21, x0
1042baeb0: 900df288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1042baeb4: f9465101    	ldr	x1, [x8, #0xca0] ; stringByAppendingPathComponent:
1042baeb8: b00d1762    	adrp	x2, 0x11e5a7000 <dyld_stub_binder+0x11e5a7000>
1042baebc: 911c2042    	add	x2, x2, #0x708
1042baec0: 94e5b09f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baec4: aa1d03fd    	mov	x29, x29
1042baec8: 94e5b0a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042baecc: aa0003f6    	mov	x22, x0
1042baed0: aa1303e0    	mov	x0, x19
1042baed4: aa1403e1    	mov	x1, x20
1042baed8: aa1603e2    	mov	x2, x22
1042baedc: 94e5b098    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baee0: aa1603e0    	mov	x0, x22
1042baee4: 94e5b09c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042baee8: aa1503e0    	mov	x0, x21
1042baeec: 94e5b09a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042baef0: f942eae0    	ldr	x0, [x23, #0x5d0]
1042baef4: f00de508    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042baef8: f947c101    	ldr	x1, [x8, #0xf80] ; liveWeffectBasePath
1042baefc: 94e5b090    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baf00: aa1d03fd    	mov	x29, x29
1042baf04: 94e5b091    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042baf08: aa0003f5    	mov	x21, x0
1042baf0c: aa1303e0    	mov	x0, x19
1042baf10: aa1403e1    	mov	x1, x20
1042baf14: aa1503e2    	mov	x2, x21
1042baf18: 94e5b089    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baf1c: aa1503e0    	mov	x0, x21
1042baf20: 94e5b08d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042baf24: f942eae0    	ldr	x0, [x23, #0x5d0]
1042baf28: f00de508    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042baf2c: f9479501    	ldr	x1, [x8, #0xf28] ; GetLiveAdvertisementBaseDir
1042baf30: 94e5b083    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baf34: aa1d03fd    	mov	x29, x29
1042baf38: 94e5b084    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042baf3c: aa0003f5    	mov	x21, x0
1042baf40: aa1303e0    	mov	x0, x19
1042baf44: aa1403e1    	mov	x1, x20
1042baf48: aa1503e2    	mov	x2, x21
1042baf4c: 94e5b07c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042baf50: aa1303e0    	mov	x0, x19
1042baf54: 94e5b080    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042baf58: aa1503e0    	mov	x0, x21
1042baf5c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1042baf60: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1042baf64: a94157f6    	ldp	x22, x21, [sp, #0x10]
1042baf68: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1042baf6c: 14e5b07a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
