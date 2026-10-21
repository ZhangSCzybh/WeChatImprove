
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e9024c: d10303ff    	sub	sp, sp, #0xc0
106e90250: a9066ffc    	stp	x28, x27, [sp, #0x60]
106e90254: a90767fa    	stp	x26, x25, [sp, #0x70]
106e90258: a9085ff8    	stp	x24, x23, [sp, #0x80]
106e9025c: a90957f6    	stp	x22, x21, [sp, #0x90]
106e90260: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
106e90264: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
106e90268: 9102c3fd    	add	x29, sp, #0xb0
106e9026c: aa0503f7    	mov	x23, x5
106e90270: f9002fe4    	str	x4, [sp, #0x58]
106e90274: aa0303f4    	mov	x20, x3
106e90278: aa0203f3    	mov	x19, x2
106e9027c: aa0003f5    	mov	x21, x0
106e90280: d00ceda8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e90284: 52800029    	mov	w9, #0x1                ; =1
106e90288: 391ae909    	strb	w9, [x8, #0x6ba]
106e9028c: aa0203e0    	mov	x0, x2
106e90290: 94365baa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e90294: aa1403e0    	mov	x0, x20
106e90298: 94365ba8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e9029c: d00c8148    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
106e902a0: f942c101    	ldr	x1, [x8, #0x580] ; commentID
106e902a4: 94365ba6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e902a8: aa1d03fd    	mov	x29, x29
106e902ac: 94365ba7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e902b0: aa0003f8    	mov	x24, x0
106e902b4: f00c9388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e902b8: f9424901    	ldr	x1, [x8, #0x490] ; intValue
106e902bc: 94365ba0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e902c0: 7100041f    	cmp	w0, #0x1
106e902c4: 5400008b    	b.lt	0x106e902d4 <_Flutter_MMFoundation_BindContext+0x336beb8>
106e902c8: aa1803e0    	mov	x0, x24
106e902cc: 94365ba2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e902d0: 14000011    	b	0x106e90314 <_Flutter_MMFoundation_BindContext+0x336bef8>
106e902d4: f00c8148    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106e902d8: f9475501    	ldr	x1, [x8, #0xea8] ; comment64ID
106e902dc: aa1403e0    	mov	x0, x20
106e902e0: 94365b97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e902e4: aa1d03fd    	mov	x29, x29
106e902e8: 94365b98    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e902ec: aa0003f9    	mov	x25, x0
106e902f0: f00c9388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e902f4: f946e901    	ldr	x1, [x8, #0xdd0] ; length
106e902f8: 94365b91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e902fc: aa0003fa    	mov	x26, x0
106e90300: aa1903e0    	mov	x0, x25
106e90304: 94365b94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90308: aa1803e0    	mov	x0, x24
106e9030c: 94365b92    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90310: b400179a    	cbz	x26, 0x106e90600 <_Flutter_MMFoundation_BindContext+0x336c1e4>
106e90314: 340016d7    	cbz	w23, 0x106e905ec <_Flutter_MMFoundation_BindContext+0x336c1d0>
106e90318: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e9031c: b9847d09    	ldrsw	x9, [x8, #0x47c]
106e90320: 38696aa8    	ldrb	w8, [x21, x9]
106e90324: 370016e8    	tbnz	w8, #0x0, 0x106e90600 <_Flutter_MMFoundation_BindContext+0x336c1e4>
106e90328: 900c9728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e9032c: f9405100    	ldr	x0, [x8, #0xa0]
106e90330: f9002be9    	str	x9, [sp, #0x50]
106e90334: 94365b8b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106e90338: f9001fe0    	str	x0, [sp, #0x38]
106e9033c: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90340: f945e900    	ldr	x0, [x8, #0xbd0]
106e90344: aa0803f6    	mov	x22, x8
106e90348: 900c9388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e9034c: f944e917    	ldr	x23, [x8, #0x9d0] ; currentContext
106e90350: aa1703e1    	mov	x1, x23
106e90354: 94365b7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90358: aa1d03fd    	mov	x29, x29
106e9035c: 94365b7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90360: aa0003fa    	mov	x26, x0
106e90364: f90027e0    	str	x0, [sp, #0x48]
106e90368: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e9036c: f9462900    	ldr	x0, [x8, #0xc50]
106e90370: aa0803fc    	mov	x28, x8
106e90374: f00c9368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e90378: f947ad19    	ldr	x25, [x8, #0xf58] ; class
106e9037c: aa1903e1    	mov	x1, x25
106e90380: 94365b6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90384: aa0003e2    	mov	x2, x0
106e90388: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e9038c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106e90390: aa1a03e0    	mov	x0, x26
106e90394: aa0103fb    	mov	x27, x1
106e90398: 94365b69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9039c: aa1d03fd    	mov	x29, x29
106e903a0: 94365b6a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e903a4: f90023e0    	str	x0, [sp, #0x40]
106e903a8: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e903ac: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
106e903b0: 900bd2e2    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e903b4: 91352042    	add	x2, x2, #0xd48
106e903b8: aa0103fa    	mov	x26, x1
106e903bc: 94365b60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e903c0: aa1d03fd    	mov	x29, x29
106e903c4: 94365b61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e903c8: f90007e0    	str	x0, [sp, #0x8]
106e903cc: f945eac0    	ldr	x0, [x22, #0xbd0]
106e903d0: aa1703e1    	mov	x1, x23
106e903d4: f90017f7    	str	x23, [sp, #0x28]
106e903d8: 94365b59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e903dc: aa1d03fd    	mov	x29, x29
106e903e0: 94365b5a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e903e4: aa0003f8    	mov	x24, x0
106e903e8: f9000be0    	str	x0, [sp, #0x10]
106e903ec: f9462b80    	ldr	x0, [x28, #0xc50]
106e903f0: aa1903e1    	mov	x1, x25
106e903f4: aa1903fc    	mov	x28, x25
106e903f8: f90013f9    	str	x25, [sp, #0x20]
106e903fc: 94365b50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90400: aa0003e2    	mov	x2, x0
106e90404: aa1803e0    	mov	x0, x24
106e90408: aa1b03f8    	mov	x24, x27
106e9040c: f9001bfb    	str	x27, [sp, #0x30]
106e90410: aa1b03e1    	mov	x1, x27
106e90414: 94365b4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90418: aa1d03fd    	mov	x29, x29
106e9041c: 94365b4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90420: aa0003fb    	mov	x27, x0
106e90424: f00bb062    	adrp	x2, 0x11e49f000 <dyld_stub_binder+0x11e49f000>
106e90428: 9128a042    	add	x2, x2, #0xa28
106e9042c: aa1a03f9    	mov	x25, x26
106e90430: f9000ffa    	str	x26, [sp, #0x18]
106e90434: aa1a03e1    	mov	x1, x26
106e90438: 94365b41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9043c: aa1d03fd    	mov	x29, x29
106e90440: 94365b42    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90444: aa0003fa    	mov	x26, x0
106e90448: f945eac0    	ldr	x0, [x22, #0xbd0]
106e9044c: aa1703e1    	mov	x1, x23
106e90450: 94365b3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90454: aa1d03fd    	mov	x29, x29
106e90458: 94365b3c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e9045c: aa0003f6    	mov	x22, x0
106e90460: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90464: f9462900    	ldr	x0, [x8, #0xc50]
106e90468: aa1c03e1    	mov	x1, x28
106e9046c: 94365b34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90470: aa0003e2    	mov	x2, x0
106e90474: aa1603e0    	mov	x0, x22
106e90478: aa1803e1    	mov	x1, x24
106e9047c: 94365b30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90480: aa1d03fd    	mov	x29, x29
106e90484: 94365b31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90488: aa0003f8    	mov	x24, x0
106e9048c: b00bb0c2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
106e90490: 91042042    	add	x2, x2, #0x108
106e90494: aa1903e1    	mov	x1, x25
106e90498: 94365b29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9049c: aa1d03fd    	mov	x29, x29
106e904a0: 94365b2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e904a4: aa0003f9    	mov	x25, x0
106e904a8: 900c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e904ac: f9406901    	ldr	x1, [x8, #0xd0] ; initWithTitle:delegate:cancelButtonTitle:destructiveButtonTitle:otherButtonTitles:
106e904b0: f9401fe0    	ldr	x0, [sp, #0x38]
106e904b4: f94007f7    	ldr	x23, [sp, #0x8]
106e904b8: aa1703e2    	mov	x2, x23
106e904bc: aa1503e3    	mov	x3, x21
106e904c0: aa1a03e4    	mov	x4, x26
106e904c4: aa1903e5    	mov	x5, x25
106e904c8: d2800006    	mov	x6, #0x0                ; =0
106e904cc: 94365b1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e904d0: aa0003fc    	mov	x28, x0
106e904d4: aa1903e0    	mov	x0, x25
106e904d8: 94365b1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e904dc: aa1803e0    	mov	x0, x24
106e904e0: 94365b1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e904e4: aa1603e0    	mov	x0, x22
106e904e8: 94365b1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e904ec: aa1a03e0    	mov	x0, x26
106e904f0: 94365b19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e904f4: aa1b03e0    	mov	x0, x27
106e904f8: 94365b17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e904fc: f9400be0    	ldr	x0, [sp, #0x10]
106e90500: 94365b15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90504: aa1703e0    	mov	x0, x23
106e90508: 94365b13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9050c: f94023e0    	ldr	x0, [sp, #0x40]
106e90510: 94365b11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90514: f94027e0    	ldr	x0, [sp, #0x48]
106e90518: 94365b0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9051c: b00c93c8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
106e90520: f9466501    	ldr	x1, [x8, #0xcc8] ; setTag:
106e90524: aa1c03e0    	mov	x0, x28
106e90528: f9402fe2    	ldr	x2, [sp, #0x58]
106e9052c: 94365b04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90530: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90534: f945e900    	ldr	x0, [x8, #0xbd0]
106e90538: f94017e1    	ldr	x1, [sp, #0x28]
106e9053c: 94365b00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90540: aa1d03fd    	mov	x29, x29
106e90544: 94365b01    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90548: aa0003f6    	mov	x22, x0
106e9054c: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e90550: f9462900    	ldr	x0, [x8, #0xc50]
106e90554: f94013e1    	ldr	x1, [sp, #0x20]
106e90558: 94365af9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9055c: aa0003e2    	mov	x2, x0
106e90560: aa1603e0    	mov	x0, x22
106e90564: f9401be1    	ldr	x1, [sp, #0x30]
106e90568: 94365af5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9056c: aa1d03fd    	mov	x29, x29
106e90570: 94365af6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90574: aa0003f7    	mov	x23, x0
106e90578: f9400fe1    	ldr	x1, [sp, #0x18]
106e9057c: 900bd2e2    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e90580: 91352042    	add	x2, x2, #0xd48
106e90584: 94365aee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90588: aa1d03fd    	mov	x29, x29
106e9058c: 94365aef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90590: aa0003f8    	mov	x24, x0
106e90594: d00c93c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106e90598: f9406101    	ldr	x1, [x8, #0xc0] ; setUserInfo:
106e9059c: aa1c03e0    	mov	x0, x28
106e905a0: aa1803e2    	mov	x2, x24
106e905a4: 94365ae6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e905a8: aa1803e0    	mov	x0, x24
106e905ac: 94365aea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e905b0: aa1703e0    	mov	x0, x23
106e905b4: 94365ae8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e905b8: aa1603e0    	mov	x0, x22
106e905bc: 94365ae6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e905c0: 900c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e905c4: f9407101    	ldr	x1, [x8, #0xe0] ; showInView:
106e905c8: aa1c03e0    	mov	x0, x28
106e905cc: aa1303e2    	mov	x2, x19
106e905d0: 94365adb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e905d4: 52800028    	mov	w8, #0x1                ; =1
106e905d8: f9402be9    	ldr	x9, [sp, #0x50]
106e905dc: 38296aa8    	strb	w8, [x21, x9]
106e905e0: aa1c03e0    	mov	x0, x28
106e905e4: 94365adc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e905e8: 14000006    	b	0x106e90600 <_Flutter_MMFoundation_BindContext+0x336c1e4>
106e905ec: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e905f0: f9448101    	ldr	x1, [x8, #0x900] ; showConfirmDeleteAlert:
106e905f4: aa1503e0    	mov	x0, x21
106e905f8: f9402fe2    	ldr	x2, [sp, #0x58]
106e905fc: 94365ad0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90600: aa1403e0    	mov	x0, x20
106e90604: 94365ad4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90608: aa1303e0    	mov	x0, x19
106e9060c: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
106e90610: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
106e90614: a94957f6    	ldp	x22, x21, [sp, #0x90]
106e90618: a9485ff8    	ldp	x24, x23, [sp, #0x80]
106e9061c: a94767fa    	ldp	x26, x25, [sp, #0x70]
106e90620: a9466ffc    	ldp	x28, x27, [sp, #0x60]
106e90624: 910303ff    	add	sp, sp, #0xc0
106e90628: 14365acb    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
