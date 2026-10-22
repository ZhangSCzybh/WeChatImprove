
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe8068: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
108fe806c: a90167fa    	stp	x26, x25, [sp, #0x10]
108fe8070: a9025ff8    	stp	x24, x23, [sp, #0x20]
108fe8074: a90357f6    	stp	x22, x21, [sp, #0x30]
108fe8078: a9044ff4    	stp	x20, x19, [sp, #0x40]
108fe807c: a9057bfd    	stp	x29, x30, [sp, #0x50]
108fe8080: 910143fd    	add	x29, sp, #0x50
108fe8084: aa0203f3    	mov	x19, x2
108fe8088: aa0003f4    	mov	x20, x0
108fe808c: b00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe8090: 52800029    	mov	w9, #0x1                ; =1
108fe8094: 3938c109    	strb	w9, [x8, #0xe30]
108fe8098: aa0203e0    	mov	x0, x2
108fe809c: 95a1cce9    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108fe80a0: d00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe80a4: f9473d01    	ldr	x1, [x8, #0xe78] ; generateStatusInfoWithDataItem:
108fe80a8: aa1403e0    	mov	x0, x20
108fe80ac: aa1303e2    	mov	x2, x19
108fe80b0: 95a1cce5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe80b4: aa1d03fd    	mov	x29, x29
108fe80b8: 95a1cce6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe80bc: aa0003f4    	mov	x20, x0
108fe80c0: f00b8c48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108fe80c4: f9455500    	ldr	x0, [x8, #0xaa8]
108fe80c8: f00b88a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108fe80cc: f941a101    	ldr	x1, [x8, #0x340] ; array
108fe80d0: 95a1ccdd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe80d4: aa1d03fd    	mov	x29, x29
108fe80d8: 95a1ccde    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe80dc: aa0003f5    	mov	x21, x0
108fe80e0: d00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe80e4: f946f101    	ldr	x1, [x8, #0xde0] ; showsStarredStatus
108fe80e8: aa1403e0    	mov	x0, x20
108fe80ec: 95a1ccd6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe80f0: f00b8c5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
108fe80f4: 900b88db    	adrp	x27, 0x120100000 <dyld_stub_binder+0x120100000>
108fe80f8: f00b8c5c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
108fe80fc: f00b88b9    	adrp	x25, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108fe8100: 340004a0    	cbz	w0, 0x108fe8194 <_Flutter_MMFoundation_BindContext+0x54c3d78>
108fe8104: f945eb40    	ldr	x0, [x26, #0xbd0]
108fe8108: f944eb61    	ldr	x1, [x27, #0x9d0] ; currentContext
108fe810c: 95a1ccce    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8110: aa1d03fd    	mov	x29, x29
108fe8114: 95a1cccf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8118: aa0003f6    	mov	x22, x0
108fe811c: f9462b80    	ldr	x0, [x28, #0xc50]
108fe8120: f947af21    	ldr	x1, [x25, #0xf58] ; class
108fe8124: 95a1ccc8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8128: aa0003e2    	mov	x2, x0
108fe812c: b00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe8130: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108fe8134: aa1603e0    	mov	x0, x22
108fe8138: 95a1ccc3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe813c: aa1d03fd    	mov	x29, x29
108fe8140: 95a1ccc4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8144: aa0003f7    	mov	x23, x0
108fe8148: b00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe814c: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
108fe8150: 900ac822    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
108fe8154: 911b2042    	add	x2, x2, #0x6c8
108fe8158: 95a1ccbb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe815c: aa1d03fd    	mov	x29, x29
108fe8160: 95a1ccbc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8164: aa0003f8    	mov	x24, x0
108fe8168: d00b7288    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108fe816c: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
108fe8170: aa1503e0    	mov	x0, x21
108fe8174: aa1803e2    	mov	x2, x24
108fe8178: 95a1ccb3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe817c: aa1803e0    	mov	x0, x24
108fe8180: 95a1ccb7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8184: aa1703e0    	mov	x0, x23
108fe8188: 95a1ccb5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe818c: aa1603e0    	mov	x0, x22
108fe8190: 95a1ccb3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8194: d00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe8198: f946f901    	ldr	x1, [x8, #0xdf0] ; showsGroupedStatus
108fe819c: aa1403e0    	mov	x0, x20
108fe81a0: 95a1cca9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe81a4: 34000620    	cbz	w0, 0x108fe8268 <_Flutter_MMFoundation_BindContext+0x54c3e4c>
108fe81a8: d00b80c8    	adrp	x8, 0x120002000 <dyld_stub_binder+0x120002000>
108fe81ac: f9402d01    	ldr	x1, [x8, #0x58] ; getPrivacy
108fe81b0: aa1303e0    	mov	x0, x19
108fe81b4: 95a1cca4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe81b8: f100101f    	cmp	x0, #0x4
108fe81bc: 540000c0    	b.eq	0x108fe81d4 <_Flutter_MMFoundation_BindContext+0x54c3db8>
108fe81c0: f100141f    	cmp	x0, #0x5
108fe81c4: 54000521    	b.ne	0x108fe8268 <_Flutter_MMFoundation_BindContext+0x54c3e4c>
108fe81c8: d00ac2f6    	adrp	x22, 0x11e846000 <dyld_stub_binder+0x11e846000>
108fe81cc: 9107a2d6    	add	x22, x22, #0x1e8
108fe81d0: 14000003    	b	0x108fe81dc <_Flutter_MMFoundation_BindContext+0x54c3dc0>
108fe81d4: d00ace96    	adrp	x22, 0x11e9ba000 <dyld_stub_binder+0x11e9ba000>
108fe81d8: 9124a2d6    	add	x22, x22, #0x928
108fe81dc: f945eb40    	ldr	x0, [x26, #0xbd0]
108fe81e0: f944eb61    	ldr	x1, [x27, #0x9d0] ; currentContext
108fe81e4: 95a1cc98    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe81e8: aa1d03fd    	mov	x29, x29
108fe81ec: 95a1cc99    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe81f0: aa0003f7    	mov	x23, x0
108fe81f4: f9462b80    	ldr	x0, [x28, #0xc50]
108fe81f8: f947af21    	ldr	x1, [x25, #0xf58] ; class
108fe81fc: 95a1cc92    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8200: aa0003e2    	mov	x2, x0
108fe8204: b00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe8208: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108fe820c: aa1703e0    	mov	x0, x23
108fe8210: 95a1cc8d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8214: aa1d03fd    	mov	x29, x29
108fe8218: 95a1cc8e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe821c: aa0003f8    	mov	x24, x0
108fe8220: b00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe8224: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
108fe8228: aa1603e2    	mov	x2, x22
108fe822c: 95a1cc86    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8230: aa1d03fd    	mov	x29, x29
108fe8234: 95a1cc87    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8238: aa0003f6    	mov	x22, x0
108fe823c: d00b7288    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108fe8240: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
108fe8244: aa1503e0    	mov	x0, x21
108fe8248: aa1603e2    	mov	x2, x22
108fe824c: 95a1cc7e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8250: aa1603e0    	mov	x0, x22
108fe8254: 95a1cc82    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8258: aa1803e0    	mov	x0, x24
108fe825c: 95a1cc80    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8260: aa1703e0    	mov	x0, x23
108fe8264: 95a1cc7e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8268: d00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe826c: f946f501    	ldr	x1, [x8, #0xde8] ; showsPrivateStatus
108fe8270: aa1403e0    	mov	x0, x20
108fe8274: 95a1cc74    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8278: 340004a0    	cbz	w0, 0x108fe830c <_Flutter_MMFoundation_BindContext+0x54c3ef0>
108fe827c: f945eb40    	ldr	x0, [x26, #0xbd0]
108fe8280: f944eb61    	ldr	x1, [x27, #0x9d0] ; currentContext
108fe8284: 95a1cc70    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe8288: aa1d03fd    	mov	x29, x29
108fe828c: 95a1cc71    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe8290: aa0003f6    	mov	x22, x0
108fe8294: f9462b80    	ldr	x0, [x28, #0xc50]
108fe8298: f947af21    	ldr	x1, [x25, #0xf58] ; class
108fe829c: 95a1cc6a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe82a0: aa0003e2    	mov	x2, x0
108fe82a4: b00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe82a8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108fe82ac: aa1603e0    	mov	x0, x22
108fe82b0: 95a1cc65    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe82b4: aa1d03fd    	mov	x29, x29
108fe82b8: 95a1cc66    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe82bc: aa0003f7    	mov	x23, x0
108fe82c0: b00b7288    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108fe82c4: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
108fe82c8: d00ac2e2    	adrp	x2, 0x11e846000 <dyld_stub_binder+0x11e846000>
108fe82cc: 91072042    	add	x2, x2, #0x1c8
108fe82d0: 95a1cc5d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe82d4: aa1d03fd    	mov	x29, x29
108fe82d8: 95a1cc5e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe82dc: aa0003f8    	mov	x24, x0
108fe82e0: d00b7288    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108fe82e4: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
108fe82e8: aa1503e0    	mov	x0, x21
108fe82ec: aa1803e2    	mov	x2, x24
108fe82f0: 95a1cc55    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe82f4: aa1803e0    	mov	x0, x24
108fe82f8: 95a1cc59    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe82fc: aa1703e0    	mov	x0, x23
108fe8300: 95a1cc57    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8304: aa1603e0    	mov	x0, x22
108fe8308: 95a1cc55    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe830c: aa1403e0    	mov	x0, x20
108fe8310: 95a1cc53    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe8314: aa1303e0    	mov	x0, x19
108fe8318: 95a1cc51    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe831c: aa1503e0    	mov	x0, x21
108fe8320: a9457bfd    	ldp	x29, x30, [sp, #0x50]
108fe8324: a9444ff4    	ldp	x20, x19, [sp, #0x40]
108fe8328: a94357f6    	ldp	x22, x21, [sp, #0x30]
108fe832c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
108fe8330: a94167fa    	ldp	x26, x25, [sp, #0x10]
108fe8334: a8c66ffc    	ldp	x28, x27, [sp], #0x60
108fe8338: 15a1cc50    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
