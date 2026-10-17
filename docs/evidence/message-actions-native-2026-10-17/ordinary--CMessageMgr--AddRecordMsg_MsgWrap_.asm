
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b42fb4: d10543ff    	sub	sp, sp, #0x150
104b42fb8: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
104b42fbc: a91067fa    	stp	x26, x25, [sp, #0x100]
104b42fc0: a9115ff8    	stp	x24, x23, [sp, #0x110]
104b42fc4: a91257f6    	stp	x22, x21, [sp, #0x120]
104b42fc8: a9134ff4    	stp	x20, x19, [sp, #0x130]
104b42fcc: a9147bfd    	stp	x29, x30, [sp, #0x140]
104b42fd0: 910503fd    	add	x29, sp, #0x140
104b42fd4: aa0303f4    	mov	x20, x3
104b42fd8: aa0203f3    	mov	x19, x2
104b42fdc: aa0003f5    	mov	x21, x0
104b42fe0: b00c5568    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b42fe4: f9405908    	ldr	x8, [x8, #0xb0]
104b42fe8: f9400108    	ldr	x8, [x8]
104b42fec: f81a83a8    	stur	x8, [x29, #-0x58]
104b42ff0: 900e07e8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b42ff4: 52800029    	mov	w9, #0x1                ; =1
104b42ff8: 39163d09    	strb	w9, [x8, #0x58f]
104b42ffc: aa0203e0    	mov	x0, x2
104b43000: 94c3904e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b43004: aa1403e0    	mov	x0, x20
104b43008: 94c3904c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b4300c: b4001554    	cbz	x20, 0x104b432b4 <_Flutter_MMFoundation_BindContext+0x101ee98>
104b43010: b00db188    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b43014: f9411d00    	ldr	x0, [x8, #0x238]
104b43018: d00d99e8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104b4301c: f9428901    	ldr	x1, [x8, #0x510] ; IsRecordOrNoteMsg:
104b43020: aa1403e2    	mov	x2, x20
104b43024: 94c39046    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43028: 36001820    	tbz	w0, #0x0, 0x104b4332c <_Flutter_MMFoundation_BindContext+0x101ef10>
104b4302c: 900d97e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b43030: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b43034: aa1403e0    	mov	x0, x20
104b43038: d2800002    	mov	x2, #0x0                ; =0
104b4303c: 94c39040    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43040: b00d97c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b43044: f9454d01    	ldr	x1, [x8, #0xa98] ; AddLocalMsg:MsgWrap:
104b43048: aa1503e0    	mov	x0, x21
104b4304c: aa1303e2    	mov	x2, x19
104b43050: aa1403e3    	mov	x3, x20
104b43054: 94c3903a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43058: b00d97c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b4305c: f947d116    	ldr	x22, [x8, #0xfa0] ; m_uiMesLocalID
104b43060: aa1403e0    	mov	x0, x20
104b43064: aa1603e1    	mov	x1, x22
104b43068: 94c39035    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b4306c: 340018c0    	cbz	w0, 0x104b43384 <_Flutter_MMFoundation_BindContext+0x101ef68>
104b43070: 900d9848    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b43074: f9406917    	ldr	x23, [x8, #0xd0] ; revokeBatchId
104b43078: aa1403e0    	mov	x0, x20
104b4307c: aa1703e1    	mov	x1, x23
104b43080: 94c3902f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43084: aa1d03fd    	mov	x29, x29
104b43088: 94c39030    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b4308c: aa0003f9    	mov	x25, x0
104b43090: 900dae08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b43094: f946e918    	ldr	x24, [x8, #0xdd0] ; length
104b43098: aa1803e1    	mov	x1, x24
104b4309c: 94c39028    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b430a0: aa0003fa    	mov	x26, x0
104b430a4: aa1903e0    	mov	x0, x25
104b430a8: 94c3902b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b430ac: b400053a    	cbz	x26, 0x104b43150 <_Flutter_MMFoundation_BindContext+0x101ed34>
104b430b0: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b430b4: f945e900    	ldr	x0, [x8, #0xbd0]
104b430b8: b00dade8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b430bc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b430c0: 94c3901f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b430c4: aa1d03fd    	mov	x29, x29
104b430c8: 94c39020    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b430cc: aa0003f9    	mov	x25, x0
104b430d0: f00db188    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b430d4: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7 
104b430d8: 900dade8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b430dc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b430e0: 94c39017    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b430e4: aa0003e2    	mov	x2, x0
104b430e8: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b430ec: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b430f0: aa1903e0    	mov	x0, x25
104b430f4: 94c39012    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b430f8: aa1d03fd    	mov	x29, x29
104b430fc: 94c39013    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b43100: aa0003fa    	mov	x26, x0
104b43104: aa1403e0    	mov	x0, x20
104b43108: aa1703e1    	mov	x1, x23
104b4310c: 94c3900c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43110: aa1d03fd    	mov	x29, x29
104b43114: 94c3900d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b43118: aa0003f7    	mov	x23, x0
104b4311c: f00da208    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b43120: f943dd01    	ldr	x1, [x8, #0x7b8] ; addBatchSendForUser:record:identifier:
104b43124: aa1a03e0    	mov	x0, x26
104b43128: aa1303e2    	mov	x2, x19
104b4312c: aa1403e3    	mov	x3, x20
104b43130: aa1703e4    	mov	x4, x23
104b43134: 94c39002    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43138: aa1703e0    	mov	x0, x23
104b4313c: 94c39006    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43140: aa1a03e0    	mov	x0, x26
104b43144: 94c39004    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43148: aa1903e0    	mov	x0, x25
104b4314c: 94c39002    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43150: f00d9848    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104b43154: f9464d01    	ldr	x1, [x8, #0xc98] ; ForceChangeForDisplay
104b43158: aa1403e0    	mov	x0, x20
104b4315c: 94c38ff8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43160: f00d97c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b43164: f9417901    	ldr	x1, [x8, #0x2f0] ; m_oRecordItem
104b43168: aa1403e0    	mov	x0, x20
104b4316c: 94c38ff4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43170: aa1d03fd    	mov	x29, x29
104b43174: 94c38ff5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b43178: aa0003f7    	mov	x23, x0
104b4317c: b00d97e8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b43180: f9427d01    	ldr	x1, [x8, #0x4f8] ; dataList
104b43184: 94c38fee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43188: aa1d03fd    	mov	x29, x29
104b4318c: 94c38fef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b43190: aa0003f9    	mov	x25, x0
104b43194: b00d9b08    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b43198: f9436901    	ldr	x1, [x8, #0x6d0] ; copyDataForDataList:msgWrap:
104b4319c: aa1503e0    	mov	x0, x21
104b431a0: aa1903e2    	mov	x2, x25
104b431a4: aa1403e3    	mov	x3, x20
104b431a8: 94c38fe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b431ac: aa1903e0    	mov	x0, x25
104b431b0: 94c38fe9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b431b4: aa1703e0    	mov	x0, x23
104b431b8: 94c38fe7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b431bc: 900d97e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b431c0: f9402917    	ldr	x23, [x8, #0x50] ; m_dtThumbnail
104b431c4: aa1403e0    	mov	x0, x20
104b431c8: aa1703e1    	mov	x1, x23
104b431cc: 94c38fdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b431d0: aa1d03fd    	mov	x29, x29
104b431d4: 94c38fdd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b431d8: aa0003f9    	mov	x25, x0
104b431dc: aa1803e1    	mov	x1, x24
104b431e0: 94c38fd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b431e4: aa0003f8    	mov	x24, x0
104b431e8: aa1903e0    	mov	x0, x25
104b431ec: 94c38fda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b431f0: b40014f8    	cbz	x24, 0x104b4348c <_Flutter_MMFoundation_BindContext+0x101f070>
104b431f4: b00db188    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b431f8: f9451500    	ldr	x0, [x8, #0xa28]
104b431fc: f00dae28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b43200: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b43204: 94c38fce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43208: aa1d03fd    	mov	x29, x29
104b4320c: 94c38fcf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b43210: aa0003fa    	mov	x26, x0
104b43214: b00db168    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b43218: f9456902    	ldr	x2, [x8, #0xad0]
104b4321c: 900d97e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b43220: f9402d18    	ldr	x24, [x8, #0x58] ; GetPathOfAppThumb:LocalID:retStrPath:
104b43224: 900d97e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b43228: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104b4322c: aa1803e3    	mov	x3, x24
104b43230: 94c38fc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43234: aa1d03fd    	mov	x29, x29
104b43238: 94c38fc4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b4323c: aa0003f9    	mov	x25, x0
104b43240: aa1a03e0    	mov	x0, x26
104b43244: 94c38fc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43248: 4f00e400    	movi.16b	v0, #0x0
104b4324c: ad0203e0    	stp	q0, q0, [sp, #0x40]
104b43250: ad0103e0    	stp	q0, q0, [sp, #0x20]
104b43254: b00dade8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b43258: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104b4325c: 910083e2    	add	x2, sp, #0x20
104b43260: 9101a3e3    	add	x3, sp, #0x68
104b43264: aa1903e0    	mov	x0, x25
104b43268: 52800204    	mov	w4, #0x10               ; =16
104b4326c: 94c38fb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43270: b4000ae0    	cbz	x0, 0x104b433cc <_Flutter_MMFoundation_BindContext+0x101efb0>
104b43274: f94017e8    	ldr	x8, [sp, #0x28]
104b43278: f940011a    	ldr	x26, [x8]
104b4327c: aa1403e0    	mov	x0, x20
104b43280: aa1603e1    	mov	x1, x22
104b43284: 94c38fae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43288: aa0003e3    	mov	x3, x0
104b4328c: f9000fff    	str	xzr, [sp, #0x18]
104b43290: 910063e4    	add	x4, sp, #0x18
104b43294: aa1a03e0    	mov	x0, x26
104b43298: aa1803e1    	mov	x1, x24
104b4329c: aa1303e2    	mov	x2, x19
104b432a0: 94c38fa7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b432a4: f9400ff8    	ldr	x24, [sp, #0x18]
104b432a8: aa1803e0    	mov	x0, x24
104b432ac: 94c38fa3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b432b0: 14000048    	b	0x104b433d0 <_Flutter_MMFoundation_BindContext+0x101efb4>
104b432b4: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b432b8: f9453515    	ldr	x21, [x8, #0xa68]
104b432bc: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b432c0: f9454500    	ldr	x0, [x8, #0xa88]
104b432c4: b00d97c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b432c8: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b432cc: aa1303e2    	mov	x2, x19
104b432d0: 94c38f9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b432d4: aa1d03fd    	mov	x29, x29
104b432d8: 94c38f9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b432dc: aa0003f6    	mov	x22, x0
104b432e0: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b432e4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b432e8: b00ce308    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b432ec: 913aa108    	add	x8, x8, #0xea8
104b432f0: a90003e8    	stp	x8, x0, [sp]
104b432f4: d00b3703    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b432f8: 9107f063    	add	x3, x3, #0x1fc
104b432fc: b00b65c5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b43300: 910cb4a5    	add	x5, x5, #0x32d
104b43304: f00b65c7    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b43308: 913cb0e7    	add	x7, x7, #0xf2c
104b4330c: aa1503e0    	mov	x0, x21
104b43310: 52800082    	mov	w2, #0x4                ; =4
104b43314: 52800004    	mov	w4, #0x0                ; =0
104b43318: 52826686    	mov	w6, #0x1334             ; =4916
104b4331c: 94c38f88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43320: aa1603e0    	mov	x0, x22
104b43324: 94c38f8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43328: 14000080    	b	0x104b43528 <_Flutter_MMFoundation_BindContext+0x101f10c>
104b4332c: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b43330: f9453515    	ldr	x21, [x8, #0xa68]
104b43334: f00d97c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b43338: f9414101    	ldr	x1, [x8, #0x280] ; m_uiAppMsgInnerType
104b4333c: aa1403e0    	mov	x0, x20
104b43340: 94c38f7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43344: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b43348: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b4334c: d00ce308    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
104b43350: 91232108    	add	x8, x8, #0x8c8
104b43354: a90003e8    	stp	x8, x0, [sp]
104b43358: d00b3703    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b4335c: 9107f063    	add	x3, x3, #0x1fc
104b43360: b00b65c5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b43364: 910cb4a5    	add	x5, x5, #0x32d
104b43368: f00b65c7    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b4336c: 913cb0e7    	add	x7, x7, #0xf2c
104b43370: aa1503e0    	mov	x0, x21
104b43374: 52800082    	mov	w2, #0x4                ; =4
104b43378: 52800004    	mov	w4, #0x0                ; =0
104b4337c: 52826726    	mov	w6, #0x1339             ; =4921
104b43380: 14000011    	b	0x104b433c4 <_Flutter_MMFoundation_BindContext+0x101efa8>
104b43384: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b43388: f9453500    	ldr	x0, [x8, #0xa68]
104b4338c: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b43390: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b43394: d00ce308    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
104b43398: 9123a108    	add	x8, x8, #0x8e8
104b4339c: f90003e8    	str	x8, [sp]
104b433a0: d00b3703    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b433a4: 9107f063    	add	x3, x3, #0x1fc
104b433a8: b00b65c5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b433ac: 910cb4a5    	add	x5, x5, #0x32d
104b433b0: f00b65c7    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b433b4: 913cb0e7    	add	x7, x7, #0xf2c
104b433b8: 52800082    	mov	w2, #0x4                ; =4
104b433bc: 52800004    	mov	w4, #0x0                ; =0
104b433c0: 52826806    	mov	w6, #0x1340             ; =4928
104b433c4: 94c38f5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b433c8: 14000058    	b	0x104b43528 <_Flutter_MMFoundation_BindContext+0x101f10c>
104b433cc: d2800018    	mov	x24, #0x0               ; =0
104b433d0: aa1903e0    	mov	x0, x25
104b433d4: 94c38f60    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b433d8: 900db199    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
104b433dc: f9463720    	ldr	x0, [x25, #0xc68]
104b433e0: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b433e4: f946f101    	ldr	x1, [x8, #0xde0] ; RemoveFile:
104b433e8: aa1803e2    	mov	x2, x24
104b433ec: 94c38f54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b433f0: f9463720    	ldr	x0, [x25, #0xc68]
104b433f4: f00d97c8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b433f8: f9409101    	ldr	x1, [x8, #0x120] ; CreateFile:
104b433fc: aa1803e2    	mov	x2, x24
104b43400: 94c38f4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43404: aa1403e0    	mov	x0, x20
104b43408: aa1703e1    	mov	x1, x23
104b4340c: 94c38f4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43410: aa1d03fd    	mov	x29, x29
104b43414: 94c38f4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b43418: aa0003f7    	mov	x23, x0
104b4341c: b00dae48    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
104b43420: f9401501    	ldr	x1, [x8, #0x28] ; writeToFile:atomically:
104b43424: aa1803e2    	mov	x2, x24
104b43428: 52800003    	mov	w3, #0x0                ; =0
104b4342c: 94c38f44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43430: aa0003f9    	mov	x25, x0
104b43434: aa1703e0    	mov	x0, x23
104b43438: 94c38f47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b4343c: 37000259    	tbnz	w25, #0x0, 0x104b43484 <_Flutter_MMFoundation_BindContext+0x101f068>
104b43440: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b43444: f9453500    	ldr	x0, [x8, #0xa68]
104b43448: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b4344c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b43450: b00cd1e8    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b43454: 910ea108    	add	x8, x8, #0x3a8
104b43458: a90063e8    	stp	x8, x24, [sp]
104b4345c: d00b3703    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b43460: 9107f063    	add	x3, x3, #0x1fc
104b43464: b00b65c5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b43468: 910cb4a5    	add	x5, x5, #0x32d
104b4346c: f00b65c7    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b43470: 913cb0e7    	add	x7, x7, #0xf2c
104b43474: 52800062    	mov	w2, #0x3                ; =3
104b43478: 52800004    	mov	w4, #0x0                ; =0
104b4347c: 52826aa6    	mov	w6, #0x1355             ; =4949
104b43480: 94c38f2f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43484: aa1803e0    	mov	x0, x24
104b43488: 94c38f33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b4348c: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b43490: f9453517    	ldr	x23, [x8, #0xa68]
104b43494: 900db188    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b43498: f9454500    	ldr	x0, [x8, #0xa88]
104b4349c: b00d97c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b434a0: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b434a4: aa1303e2    	mov	x2, x19
104b434a8: 94c38f25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b434ac: aa1d03fd    	mov	x29, x29
104b434b0: 94c38f26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b434b4: aa0003f8    	mov	x24, x0
104b434b8: aa1403e0    	mov	x0, x20
104b434bc: aa1603e1    	mov	x1, x22
104b434c0: 94c38f1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b434c4: d00d97a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b434c8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b434cc: a90083f8    	stp	x24, x0, [sp, #0x8]
104b434d0: d00ce308    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
104b434d4: 91242108    	add	x8, x8, #0x908
104b434d8: f90003e8    	str	x8, [sp]
104b434dc: b00b65c5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b434e0: 910cb4a5    	add	x5, x5, #0x32d
104b434e4: f00b65c7    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b434e8: 913cb0e7    	add	x7, x7, #0xf2c
104b434ec: aa1703e0    	mov	x0, x23
104b434f0: 52800042    	mov	w2, #0x2                ; =2
104b434f4: d2800003    	mov	x3, #0x0                ; =0
104b434f8: 52800004    	mov	w4, #0x0                ; =0
104b434fc: 52826b26    	mov	w6, #0x1359             ; =4953
104b43500: 94c38f0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43504: aa1803e0    	mov	x0, x24
104b43508: 94c38f13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b4350c: 900db708    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b43510: b9896108    	ldrsw	x8, [x8, #0x960]
104b43514: f8686aa0    	ldr	x0, [x21, x8]
104b43518: f00d99e8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104b4351c: f9420501    	ldr	x1, [x8, #0x408] ; StartUploadRecordMsg:
104b43520: aa1403e2    	mov	x2, x20
104b43524: 94c38f06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b43528: aa1403e0    	mov	x0, x20
104b4352c: 94c38f0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43530: aa1303e0    	mov	x0, x19
104b43534: 94c38f08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b43538: f85a83a8    	ldur	x8, [x29, #-0x58]
104b4353c: 900c5569    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b43540: f9405929    	ldr	x9, [x9, #0xb0]
104b43544: f9400129    	ldr	x9, [x9]
104b43548: eb08013f    	cmp	x9, x8
104b4354c: 54000121    	b.ne	0x104b43570 <_Flutter_MMFoundation_BindContext+0x101f154>
104b43550: a9547bfd    	ldp	x29, x30, [sp, #0x140]
104b43554: a9534ff4    	ldp	x20, x19, [sp, #0x130]
104b43558: a95257f6    	ldp	x22, x21, [sp, #0x120]
104b4355c: a9515ff8    	ldp	x24, x23, [sp, #0x110]
104b43560: a95067fa    	ldp	x26, x25, [sp, #0x100]
104b43564: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
104b43568: 910543ff    	add	sp, sp, #0x150
104b4356c: d65f03c0    	ret
104b43570: 94c38f01    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>