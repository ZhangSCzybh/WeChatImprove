
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104cc9f2c: d10203ff    	sub	sp, sp, #0x80
104cc9f30: a9026ffc    	stp	x28, x27, [sp, #0x20]
104cc9f34: a90367fa    	stp	x26, x25, [sp, #0x30]
104cc9f38: a9045ff8    	stp	x24, x23, [sp, #0x40]
104cc9f3c: a90557f6    	stp	x22, x21, [sp, #0x50]
104cc9f40: a9064ff4    	stp	x20, x19, [sp, #0x60]
104cc9f44: a9077bfd    	stp	x29, x30, [sp, #0x70]
104cc9f48: 9101c3fd    	add	x29, sp, #0x70
104cc9f4c: aa0203f3    	mov	x19, x2
104cc9f50: aa0003f5    	mov	x21, x0
104cc9f54: b00dfba8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104cc9f58: 52800029    	mov	w9, #0x1                ; =1
104cc9f5c: 392c5909    	strb	w9, [x8, #0xb16]
104cc9f60: aa0203e0    	mov	x0, x2
104cc9f64: 94bd7475    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104cc9f68: f00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc9f6c: f9446101    	ldr	x1, [x8, #0x8c0] ; isCancelMsg
104cc9f70: aa1303e0    	mov	x0, x19
104cc9f74: 94bd7472    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9f78: 34000260    	cbz	w0, 0x104cc9fc4 <_Flutter_MMFoundation_BindContext+0x11a5ba8>
104cc9f7c: d00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cc9f80: f9453500    	ldr	x0, [x8, #0xa68]
104cc9f84: 900d8b88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cc9f88: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cc9f8c: 900cd768    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cc9f90: 911d2108    	add	x8, x8, #0x748
104cc9f94: f90003e8    	str	x8, [sp]
104cc9f98: d00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc9f9c: 911a5863    	add	x3, x3, #0x696
104cc9fa0: d00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc9fa4: 9129b4a5    	add	x5, x5, #0xa6d
104cc9fa8: d00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc9fac: 913ed8e7    	add	x7, x7, #0xfb6
104cc9fb0: 52800082    	mov	w2, #0x4                ; =4
104cc9fb4: 52800004    	mov	w4, #0x0                ; =0
104cc9fb8: 52802be6    	mov	w6, #0x15f              ; =351
104cc9fbc: 94bd7460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9fc0: 140000c2    	b	0x104cca2c8 <_Flutter_MMFoundation_BindContext+0x11a5eac>
104cc9fc4: f00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc9fc8: f9449916    	ldr	x22, [x8, #0x930] ; m_msgHistory
104cc9fcc: aa1503e0    	mov	x0, x21
104cc9fd0: aa1603e1    	mov	x1, x22
104cc9fd4: 94bd745a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9fd8: aa1d03fd    	mov	x29, x29
104cc9fdc: 94bd745b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cc9fe0: aa0003f4    	mov	x20, x0
104cc9fe4: f00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc9fe8: f9449d01    	ldr	x1, [x8, #0x938] ; hasHistoryMsg:
104cc9fec: aa1303e2    	mov	x2, x19
104cc9ff0: 94bd7453    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9ff4: aa0003f7    	mov	x23, x0
104cc9ff8: aa1403e0    	mov	x0, x20
104cc9ffc: 94bd7456    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca000: 34000497    	cbz	w23, 0x104cca090 <_Flutter_MMFoundation_BindContext+0x11a5c74>
104cca004: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca008: f9453500    	ldr	x0, [x8, #0xa68]
104cca00c: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca010: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca014: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca018: 911a2108    	add	x8, x8, #0x688
104cca01c: f90003e8    	str	x8, [sp]
104cca020: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca024: 911a5863    	add	x3, x3, #0x696
104cca028: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca02c: 9129b4a5    	add	x5, x5, #0xa6d
104cca030: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca034: 913ed8e7    	add	x7, x7, #0xfb6
104cca038: 52800042    	mov	w2, #0x2                ; =2
104cca03c: 52800004    	mov	w4, #0x0                ; =0
104cca040: 52802ca6    	mov	w6, #0x165              ; =357
104cca044: 94bd743e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca048: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca04c: f9448501    	ldr	x1, [x8, #0x908] ; m_queue
104cca050: aa1503e0    	mov	x0, x21
104cca054: 94bd743a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca058: aa1d03fd    	mov	x29, x29
104cca05c: 94bd743b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca060: aa0003f4    	mov	x20, x0
104cca064: d00d8ba8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104cca068: f944c101    	ldr	x1, [x8, #0x980] ; safeRemoveObject:
104cca06c: aa1303e2    	mov	x2, x19
104cca070: 94bd7433    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca074: aa1403e0    	mov	x0, x20
104cca078: 94bd7437    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca07c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca080: f9448d01    	ldr	x1, [x8, #0x918] ; checkMsgQueue
104cca084: aa1503e0    	mov	x0, x21
104cca088: 94bd742d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca08c: 1400008f    	b	0x104cca2c8 <_Flutter_MMFoundation_BindContext+0x11a5eac>
104cca090: 900da588    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
104cca094: f941e500    	ldr	x0, [x8, #0x3c8] ; 0[;
104cca098: b00da1a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104cca09c: f947ad18    	ldr	x24, [x8, #0xf58] ; class
104cca0a0: aa1803e1    	mov	x1, x24
104cca0a4: 94bd7426    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca0a8: aa0003e2    	mov	x2, x0
104cca0ac: b00da1c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104cca0b0: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
104cca0b4: aa1303e0    	mov	x0, x19
104cca0b8: 94bd7421    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca0bc: 36000440    	tbz	w0, #0x0, 0x104cca144 <_Flutter_MMFoundation_BindContext+0x11a5d28>
104cca0c0: aa1303e0    	mov	x0, x19
104cca0c4: 94bd741d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104cca0c8: 900da568    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104cca0cc: f9421514    	ldr	x20, [x8, #0x428]
104cca0d0: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca0d4: f9450d17    	ldr	x23, [x8, #0xa18] ; m_roomId
104cca0d8: aa1703e1    	mov	x1, x23
104cca0dc: 94bd7418    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca0e0: aa0003f9    	mov	x25, x0
104cca0e4: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca0e8: f9451101    	ldr	x1, [x8, #0xa20] ; m_roomKey
104cca0ec: aa1303e0    	mov	x0, x19
104cca0f0: 94bd7413    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca0f4: aa0003fa    	mov	x26, x0
104cca0f8: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca0fc: f944c901    	ldr	x1, [x8, #0x990] ; m_mode
104cca100: aa1303e0    	mov	x0, x19
104cca104: 94bd740e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca108: aa0003e4    	mov	x4, x0
104cca10c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca110: f9451501    	ldr	x1, [x8, #0xa28] ; ReportVoipGotNotifyWithRoomId:WithRoomKey:WithRoomType:
104cca114: aa1403e0    	mov	x0, x20
104cca118: aa1903e2    	mov	x2, x25
104cca11c: aa1a03e3    	mov	x3, x26
104cca120: 94bd7407    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca124: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca128: f9451901    	ldr	x1, [x8, #0xa30] ; isSimuCallPreCheck:
104cca12c: aa1503e0    	mov	x0, x21
104cca130: aa1303e2    	mov	x2, x19
104cca134: 94bd7402    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca138: aa0003fa    	mov	x26, x0
104cca13c: aa1303f4    	mov	x20, x19
104cca140: 14000005    	b	0x104cca154 <_Flutter_MMFoundation_BindContext+0x11a5d38>
104cca144: d2800014    	mov	x20, #0x0               ; =0
104cca148: 5280001a    	mov	w26, #0x0               ; =0
104cca14c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca150: f9450d17    	ldr	x23, [x8, #0xa18] ; m_roomId
104cca154: aa1503e0    	mov	x0, x21
104cca158: aa1603e1    	mov	x1, x22
104cca15c: 94bd73f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca160: aa1d03fd    	mov	x29, x29
104cca164: 94bd73f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca168: aa0003f9    	mov	x25, x0
104cca16c: aa1403e0    	mov	x0, x20
104cca170: aa1703e1    	mov	x1, x23
104cca174: 94bd73f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca178: aa0003f7    	mov	x23, x0
104cca17c: f00d8bc8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104cca180: f9431101    	ldr	x1, [x8, #0x620] ; serviceType
104cca184: aa1403e0    	mov	x0, x20
104cca188: 94bd73ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca18c: aa1d03fd    	mov	x29, x29
104cca190: 94bd73ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca194: aa0003fb    	mov	x27, x0
104cca198: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca19c: f9451d01    	ldr	x1, [x8, #0xa38] ; hasCancelMsgWithRoomID:serviceType:
104cca1a0: aa1903e0    	mov	x0, x25
104cca1a4: aa1703e2    	mov	x2, x23
104cca1a8: aa1b03e3    	mov	x3, x27
104cca1ac: 94bd73e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca1b0: aa0003f7    	mov	x23, x0
104cca1b4: aa1b03e0    	mov	x0, x27
104cca1b8: 94bd73e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca1bc: aa1903e0    	mov	x0, x25
104cca1c0: 94bd73e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca1c4: 34000277    	cbz	w23, 0x104cca210 <_Flutter_MMFoundation_BindContext+0x11a5df4>
104cca1c8: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca1cc: f9453500    	ldr	x0, [x8, #0xa68]
104cca1d0: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca1d4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca1d8: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca1dc: 911da108    	add	x8, x8, #0x768
104cca1e0: a90053e8    	stp	x8, x20, [sp]
104cca1e4: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca1e8: 911a5863    	add	x3, x3, #0x696
104cca1ec: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca1f0: 9129b4a5    	add	x5, x5, #0xa6d
104cca1f4: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca1f8: 913ed8e7    	add	x7, x7, #0xfb6
104cca1fc: 52800042    	mov	w2, #0x2                ; =2
104cca200: 52800004    	mov	w4, #0x0                ; =0
104cca204: 52802e86    	mov	w6, #0x174              ; =372
104cca208: 94bd73cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca20c: 1400001c    	b	0x104cca27c <_Flutter_MMFoundation_BindContext+0x11a5e60>
104cca210: 900d8f08    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
104cca214: f9475901    	ldr	x1, [x8, #0xeb0] ; isOutOfDate
104cca218: aa1303e0    	mov	x0, x19
104cca21c: 94bd73c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca220: 34000660    	cbz	w0, 0x104cca2ec <_Flutter_MMFoundation_BindContext+0x11a5ed0>
104cca224: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca228: f9453500    	ldr	x0, [x8, #0xa68]
104cca22c: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca230: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca234: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca238: 911e2108    	add	x8, x8, #0x788
104cca23c: a9004fe8    	stp	x8, x19, [sp]
104cca240: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca244: 911a5863    	add	x3, x3, #0x696
104cca248: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca24c: 9129b4a5    	add	x5, x5, #0xa6d
104cca250: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca254: 913ed8e7    	add	x7, x7, #0xfb6
104cca258: 52800042    	mov	w2, #0x2                ; =2
104cca25c: 52800004    	mov	w4, #0x0                ; =0
104cca260: 52802f66    	mov	w6, #0x17b              ; =379
104cca264: 94bd73b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca268: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca26c: f9434100    	ldr	x0, [x8, #0x680]
104cca270: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca274: f9452101    	ldr	x1, [x8, #0xa40] ; logicMsgOutdate
104cca278: 94bd73b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca27c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca280: f9448501    	ldr	x1, [x8, #0x908] ; m_queue
104cca284: aa1503e0    	mov	x0, x21
104cca288: 94bd73ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca28c: aa1d03fd    	mov	x29, x29
104cca290: 94bd73ae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca294: aa0003f6    	mov	x22, x0
104cca298: d00d8ba8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104cca29c: f944c101    	ldr	x1, [x8, #0x980] ; safeRemoveObject:
104cca2a0: aa1303e2    	mov	x2, x19
104cca2a4: 94bd73a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca2a8: aa1603e0    	mov	x0, x22
104cca2ac: 94bd73aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca2b0: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca2b4: f9448d01    	ldr	x1, [x8, #0x918] ; checkMsgQueue
104cca2b8: aa1503e0    	mov	x0, x21
104cca2bc: 94bd73a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca2c0: aa1403e0    	mov	x0, x20
104cca2c4: 94bd73a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca2c8: aa1303e0    	mov	x0, x19
104cca2cc: a9477bfd    	ldp	x29, x30, [sp, #0x70]
104cca2d0: a9464ff4    	ldp	x20, x19, [sp, #0x60]
104cca2d4: a94557f6    	ldp	x22, x21, [sp, #0x50]
104cca2d8: a9445ff8    	ldp	x24, x23, [sp, #0x40]
104cca2dc: a94367fa    	ldp	x26, x25, [sp, #0x30]
104cca2e0: a9426ffc    	ldp	x28, x27, [sp, #0x20]
104cca2e4: 910203ff    	add	sp, sp, #0x80
104cca2e8: 14bd739b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca2ec: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca2f0: f9452501    	ldr	x1, [x8, #0xa48] ; isMonoServiceCheckingServer
104cca2f4: aa1503e0    	mov	x0, x21
104cca2f8: 94bd7391    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca2fc: 340002e0    	cbz	w0, 0x104cca358 <_Flutter_MMFoundation_BindContext+0x11a5f3c>
104cca300: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca304: f9453500    	ldr	x0, [x8, #0xa68]
104cca308: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca30c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca310: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca314: 911ea108    	add	x8, x8, #0x7a8
104cca318: f90003e8    	str	x8, [sp]
104cca31c: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca320: 911a5863    	add	x3, x3, #0x696
104cca324: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca328: 9129b4a5    	add	x5, x5, #0xa6d
104cca32c: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca330: 913ed8e7    	add	x7, x7, #0xfb6
104cca334: 52800042    	mov	w2, #0x2                ; =2
104cca338: 52800004    	mov	w4, #0x0                ; =0
104cca33c: 52803066    	mov	w6, #0x183              ; =387
104cca340: 94bd737f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca344: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca348: f9434100    	ldr	x0, [x8, #0x680]
104cca34c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca350: f9452901    	ldr	x1, [x8, #0xa50] ; logicCheckingServer
104cca354: 17ffffda    	b	0x104cca2bc <_Flutter_MMFoundation_BindContext+0x11a5ea0>
104cca358: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca35c: f946b119    	ldr	x25, [x8, #0xd60] ; m_delegate
104cca360: aa1303e0    	mov	x0, x19
104cca364: aa1903e1    	mov	x1, x25
104cca368: 94bd7375    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca36c: aa1d03fd    	mov	x29, x29
104cca370: 94bd7376    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca374: aa0003fc    	mov	x28, x0
104cca378: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca37c: f9452d1b    	ldr	x27, [x8, #0xa58] ; onMonoServiceMsgHandleWithMsg:
104cca380: 900da1e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104cca384: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
104cca388: f9000fe1    	str	x1, [sp, #0x18]
104cca38c: aa1b03e2    	mov	x2, x27
104cca390: 94bd736b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca394: aa0003f7    	mov	x23, x0
104cca398: aa1c03e0    	mov	x0, x28
104cca39c: 94bd736e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca3a0: 34000597    	cbz	w23, 0x104cca450 <_Flutter_MMFoundation_BindContext+0x11a6034>
104cca3a4: aa1303e0    	mov	x0, x19
104cca3a8: aa1903e1    	mov	x1, x25
104cca3ac: 94bd7364    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca3b0: aa1d03fd    	mov	x29, x29
104cca3b4: 94bd7365    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca3b8: aa0003f7    	mov	x23, x0
104cca3bc: aa1b03e1    	mov	x1, x27
104cca3c0: aa1303e2    	mov	x2, x19
104cca3c4: 94bd735e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca3c8: aa0003fb    	mov	x27, x0
104cca3cc: aa1703e0    	mov	x0, x23
104cca3d0: 94bd7361    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca3d4: 340003fb    	cbz	w27, 0x104cca450 <_Flutter_MMFoundation_BindContext+0x11a6034>
104cca3d8: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca3dc: f9453500    	ldr	x0, [x8, #0xa68]
104cca3e0: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca3e4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca3e8: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca3ec: 911f2108    	add	x8, x8, #0x7c8
104cca3f0: f90003e8    	str	x8, [sp]
104cca3f4: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca3f8: 911a5863    	add	x3, x3, #0x696
104cca3fc: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca400: 9129b4a5    	add	x5, x5, #0xa6d
104cca404: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca408: 913ed8e7    	add	x7, x7, #0xfb6
104cca40c: 52800042    	mov	w2, #0x2                ; =2
104cca410: 52800004    	mov	w4, #0x0                ; =0
104cca414: 52803146    	mov	w6, #0x18a              ; =394
104cca418: 94bd7349    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca41c: aa1503e0    	mov	x0, x21
104cca420: aa1603e1    	mov	x1, x22
104cca424: 94bd7346    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca428: aa1d03fd    	mov	x29, x29
104cca42c: 94bd7347    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca430: aa0003f6    	mov	x22, x0
104cca434: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca438: f944a101    	ldr	x1, [x8, #0x940] ; addHistoryWithMsg:
104cca43c: aa1303e2    	mov	x2, x19
104cca440: 94bd733f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca444: aa1603e0    	mov	x0, x22
104cca448: 94bd7343    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca44c: 17ffff8c    	b	0x104cca27c <_Flutter_MMFoundation_BindContext+0x11a5e60>
104cca450: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca454: f9453101    	ldr	x1, [x8, #0xa60] ; isMonoServiceUIExist
104cca458: aa1503e0    	mov	x0, x21
104cca45c: 94bd7338    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca460: 52000008    	eor	w8, w0, #0x1
104cca464: 2a080348    	orr	w8, w26, w8
104cca468: 7100051f    	cmp	w8, #0x1
104cca46c: 54000f21    	b.ne	0x104cca650 <_Flutter_MMFoundation_BindContext+0x11a6234>
104cca470: aa1503e0    	mov	x0, x21
104cca474: aa1603e1    	mov	x1, x22
104cca478: 94bd7331    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca47c: aa1d03fd    	mov	x29, x29
104cca480: 94bd7332    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca484: aa0003f6    	mov	x22, x0
104cca488: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca48c: f944a101    	ldr	x1, [x8, #0x940] ; addHistoryWithMsg:
104cca490: aa1303e2    	mov	x2, x19
104cca494: 94bd732a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca498: aa1603e0    	mov	x0, x22
104cca49c: 94bd732e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca4a0: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca4a4: f9448501    	ldr	x1, [x8, #0x908] ; m_queue
104cca4a8: aa1503e0    	mov	x0, x21
104cca4ac: 94bd7324    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca4b0: aa1d03fd    	mov	x29, x29
104cca4b4: 94bd7325    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca4b8: aa0003f6    	mov	x22, x0
104cca4bc: d00d8ba8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104cca4c0: f944c101    	ldr	x1, [x8, #0x980] ; safeRemoveObject:
104cca4c4: aa1303e2    	mov	x2, x19
104cca4c8: 94bd731d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca4cc: aa1603e0    	mov	x0, x22
104cca4d0: 94bd7321    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca4d4: b00da55c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
104cca4d8: f9453780    	ldr	x0, [x28, #0xa68]
104cca4dc: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca4e0: f942a91b    	ldr	x27, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca4e4: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca4e8: 911fa108    	add	x8, x8, #0x7e8
104cca4ec: a9006be8    	stp	x8, x26, [sp]
104cca4f0: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca4f4: 911a5863    	add	x3, x3, #0x696
104cca4f8: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca4fc: 9129b4a5    	add	x5, x5, #0xa6d
104cca500: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca504: 913ed8e7    	add	x7, x7, #0xfb6
104cca508: aa1b03e1    	mov	x1, x27
104cca50c: 52800042    	mov	w2, #0x2                ; =2
104cca510: 52800004    	mov	w4, #0x0                ; =0
104cca514: 52803346    	mov	w6, #0x19a              ; =410
104cca518: 94bd7309    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca51c: aa1303e0    	mov	x0, x19
104cca520: aa1903fa    	mov	x26, x25
104cca524: aa1903e1    	mov	x1, x25
104cca528: 94bd7305    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca52c: aa1d03fd    	mov	x29, x29
104cca530: 94bd7306    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca534: aa0003f7    	mov	x23, x0
104cca538: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca53c: f9453516    	ldr	x22, [x8, #0xa68] ; onMonoServiceMsgStartWithMsg:
104cca540: f9400fe1    	ldr	x1, [sp, #0x18]
104cca544: aa1603e2    	mov	x2, x22
104cca548: 94bd72fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca54c: aa0003f9    	mov	x25, x0
104cca550: aa1703e0    	mov	x0, x23
104cca554: 94bd7300    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca558: f9453780    	ldr	x0, [x28, #0xa68]
104cca55c: 360010f9    	tbz	w25, #0x0, 0x104cca778 <_Flutter_MMFoundation_BindContext+0x11a635c>
104cca560: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca564: 9120a108    	add	x8, x8, #0x828
104cca568: a9004fe8    	stp	x8, x19, [sp]
104cca56c: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca570: 911a5863    	add	x3, x3, #0x696
104cca574: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca578: 9129b4a5    	add	x5, x5, #0xa6d
104cca57c: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca580: 913ed8e7    	add	x7, x7, #0xfb6
104cca584: aa1b03e1    	mov	x1, x27
104cca588: 52800042    	mov	w2, #0x2                ; =2
104cca58c: 52800004    	mov	w4, #0x0                ; =0
104cca590: 52803446    	mov	w6, #0x1a2              ; =418
104cca594: 94bd72ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca598: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca59c: f9434100    	ldr	x0, [x8, #0x680]
104cca5a0: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca5a4: f9453d01    	ldr	x1, [x8, #0xa78] ; logicStartUI
104cca5a8: 94bd72e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca5ac: b40003b4    	cbz	x20, 0x104cca620 <_Flutter_MMFoundation_BindContext+0x11a6204>
104cca5b0: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca5b4: f945e900    	ldr	x0, [x8, #0xbd0]
104cca5b8: d00da1a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104cca5bc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104cca5c0: 94bd72df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca5c4: aa1d03fd    	mov	x29, x29
104cca5c8: 94bd72e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca5cc: aa0003f5    	mov	x21, x0
104cca5d0: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca5d4: f940cd00    	ldr	x0, [x8, #0x198]
104cca5d8: aa1803e1    	mov	x1, x24
104cca5dc: 94bd72d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca5e0: aa0003e2    	mov	x2, x0
104cca5e4: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca5e8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104cca5ec: aa1503e0    	mov	x0, x21
104cca5f0: 94bd72d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca5f4: aa1d03fd    	mov	x29, x29
104cca5f8: 94bd72d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca5fc: aa0003f7    	mov	x23, x0
104cca600: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca604: f9454101    	ldr	x1, [x8, #0xa80] ; handleInviteMessage:
104cca608: aa1403e2    	mov	x2, x20
104cca60c: 94bd72cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca610: aa1703e0    	mov	x0, x23
104cca614: 94bd72d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca618: aa1503e0    	mov	x0, x21
104cca61c: 94bd72ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca620: aa1303e0    	mov	x0, x19
104cca624: aa1a03e1    	mov	x1, x26
104cca628: 94bd72c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca62c: aa1d03fd    	mov	x29, x29
104cca630: 94bd72c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca634: aa0003f5    	mov	x21, x0
104cca638: aa1603e1    	mov	x1, x22
104cca63c: aa1303e2    	mov	x2, x19
104cca640: 94bd72bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca644: aa1503e0    	mov	x0, x21
104cca648: 94bd72c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca64c: 17ffff1d    	b	0x104cca2c0 <_Flutter_MMFoundation_BindContext+0x11a5ea4>
104cca650: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca654: f9454501    	ldr	x1, [x8, #0xa88] ; isMonoServiceUIWorking
104cca658: aa1503e0    	mov	x0, x21
104cca65c: 94bd72b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca660: 34000b20    	cbz	w0, 0x104cca7c4 <_Flutter_MMFoundation_BindContext+0x11a63a8>
104cca664: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca668: f9448501    	ldr	x1, [x8, #0x908] ; m_queue
104cca66c: aa1503e0    	mov	x0, x21
104cca670: 94bd72b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca674: aa1d03fd    	mov	x29, x29
104cca678: 94bd72b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca67c: aa0003f7    	mov	x23, x0
104cca680: d00d8ba8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104cca684: f944c101    	ldr	x1, [x8, #0x980] ; safeRemoveObject:
104cca688: aa1303e2    	mov	x2, x19
104cca68c: 94bd72ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca690: aa1703e0    	mov	x0, x23
104cca694: 94bd72b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca698: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca69c: f9453500    	ldr	x0, [x8, #0xa68]
104cca6a0: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca6a4: f942a918    	ldr	x24, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca6a8: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca6ac: 91212108    	add	x8, x8, #0x848
104cca6b0: f90003e8    	str	x8, [sp]
104cca6b4: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca6b8: 911a5863    	add	x3, x3, #0x696
104cca6bc: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca6c0: 9129b4a5    	add	x5, x5, #0xa6d
104cca6c4: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca6c8: 913ed8e7    	add	x7, x7, #0xfb6
104cca6cc: aa1803e1    	mov	x1, x24
104cca6d0: 52800042    	mov	w2, #0x2                ; =2
104cca6d4: 52800004    	mov	w4, #0x0                ; =0
104cca6d8: 52803646    	mov	w6, #0x1b2              ; =434
104cca6dc: 94bd7298    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca6e0: aa1303e0    	mov	x0, x19
104cca6e4: aa1903fc    	mov	x28, x25
104cca6e8: aa1903e1    	mov	x1, x25
104cca6ec: 94bd7294    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca6f0: aa1d03fd    	mov	x29, x29
104cca6f4: 94bd7295    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca6f8: aa0003fa    	mov	x26, x0
104cca6fc: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca700: f945491b    	ldr	x27, [x8, #0xa90] ; onMonoServiceMsgHoldWithMsg:
104cca704: f9400ff9    	ldr	x25, [sp, #0x18]
104cca708: aa1903e1    	mov	x1, x25
104cca70c: aa1b03e2    	mov	x2, x27
104cca710: 94bd728b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca714: 36000840    	tbz	w0, #0x0, 0x104cca81c <_Flutter_MMFoundation_BindContext+0x11a6400>
104cca718: aa1303e0    	mov	x0, x19
104cca71c: aa1c03e1    	mov	x1, x28
104cca720: 94bd7287    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca724: aa1d03fd    	mov	x29, x29
104cca728: 94bd7288    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca72c: aa0003f7    	mov	x23, x0
104cca730: aa1b03e1    	mov	x1, x27
104cca734: aa1303e2    	mov	x2, x19
104cca738: 94bd7281    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca73c: aa0003fb    	mov	x27, x0
104cca740: aa1703e0    	mov	x0, x23
104cca744: 94bd7284    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca748: aa1a03e0    	mov	x0, x26
104cca74c: 94bd7282    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca750: 340006bb    	cbz	w27, 0x104cca824 <_Flutter_MMFoundation_BindContext+0x11a6408>
104cca754: aa1503e0    	mov	x0, x21
104cca758: aa1603e1    	mov	x1, x22
104cca75c: 94bd7278    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca760: aa1d03fd    	mov	x29, x29
104cca764: 94bd7279    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca768: aa0003f5    	mov	x21, x0
104cca76c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca770: f944a101    	ldr	x1, [x8, #0x940] ; addHistoryWithMsg:
104cca774: 17ffffb2    	b	0x104cca63c <_Flutter_MMFoundation_BindContext+0x11a6220>
104cca778: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca77c: 91202108    	add	x8, x8, #0x808
104cca780: f90003e8    	str	x8, [sp]
104cca784: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca788: 911a5863    	add	x3, x3, #0x696
104cca78c: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca790: 9129b4a5    	add	x5, x5, #0xa6d
104cca794: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca798: 913ed8e7    	add	x7, x7, #0xfb6
104cca79c: aa1b03e1    	mov	x1, x27
104cca7a0: 52800082    	mov	w2, #0x4                ; =4
104cca7a4: 52800004    	mov	w4, #0x0                ; =0
104cca7a8: 52803386    	mov	w6, #0x19c              ; =412
104cca7ac: 94bd7264    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca7b0: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca7b4: f9434100    	ldr	x0, [x8, #0x680]
104cca7b8: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca7bc: f9453901    	ldr	x1, [x8, #0xa70] ; delegateStartNotExist
104cca7c0: 1400007b    	b	0x104cca9ac <_Flutter_MMFoundation_BindContext+0x11a6590>
104cca7c4: b00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cca7c8: f9453500    	ldr	x0, [x8, #0xa68]
104cca7cc: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cca7d0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cca7d4: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca7d8: 9123a108    	add	x8, x8, #0x8e8
104cca7dc: f90003e8    	str	x8, [sp]
104cca7e0: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca7e4: 911a5863    	add	x3, x3, #0x696
104cca7e8: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca7ec: 9129b4a5    	add	x5, x5, #0xa6d
104cca7f0: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca7f4: 913ed8e7    	add	x7, x7, #0xfb6
104cca7f8: 52800042    	mov	w2, #0x2                ; =2
104cca7fc: 52800004    	mov	w4, #0x0                ; =0
104cca800: 528039c6    	mov	w6, #0x1ce              ; =462
104cca804: 94bd724e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca808: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca80c: f9434100    	ldr	x0, [x8, #0x680]
104cca810: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca814: f9455d01    	ldr	x1, [x8, #0xab8] ; logicUIWorkingWaitNextCheck
104cca818: 17fffea9    	b	0x104cca2bc <_Flutter_MMFoundation_BindContext+0x11a5ea0>
104cca81c: aa1a03e0    	mov	x0, x26
104cca820: 94bd724d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca824: aa1303e0    	mov	x0, x19
104cca828: aa1c03e1    	mov	x1, x28
104cca82c: 94bd7244    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca830: aa1d03fd    	mov	x29, x29
104cca834: 94bd7245    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca838: aa0003f7    	mov	x23, x0
104cca83c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca840: f9454d1a    	ldr	x26, [x8, #0xa98] ; onMonoServiceMsgRejectWithMsg:
104cca844: aa1903e1    	mov	x1, x25
104cca848: aa1a03e2    	mov	x2, x26
104cca84c: 94bd723c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca850: aa0003f9    	mov	x25, x0
104cca854: aa1703e0    	mov	x0, x23
104cca858: 94bd723f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca85c: b00da55b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104cca860: f9453760    	ldr	x0, [x27, #0xa68]
104cca864: 34000819    	cbz	w25, 0x104cca964 <_Flutter_MMFoundation_BindContext+0x11a6548>
104cca868: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca86c: 9121a108    	add	x8, x8, #0x868
104cca870: a9004fe8    	stp	x8, x19, [sp]
104cca874: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca878: 911a5863    	add	x3, x3, #0x696
104cca87c: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca880: 9129b4a5    	add	x5, x5, #0xa6d
104cca884: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca888: 913ed8e7    	add	x7, x7, #0xfb6
104cca88c: aa1803e1    	mov	x1, x24
104cca890: 52800042    	mov	w2, #0x2                ; =2
104cca894: 52800004    	mov	w4, #0x0                ; =0
104cca898: 52803766    	mov	w6, #0x1bb              ; =443
104cca89c: 94bd7228    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca8a0: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca8a4: f9434100    	ldr	x0, [x8, #0x680]
104cca8a8: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca8ac: f9455101    	ldr	x1, [x8, #0xaa0] ; logicRejectMsg
104cca8b0: 94bd7223    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca8b4: aa1303e0    	mov	x0, x19
104cca8b8: aa1c03e1    	mov	x1, x28
104cca8bc: 94bd7220    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca8c0: aa1d03fd    	mov	x29, x29
104cca8c4: 94bd7221    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca8c8: aa0003f7    	mov	x23, x0
104cca8cc: aa1a03e1    	mov	x1, x26
104cca8d0: aa1303e2    	mov	x2, x19
104cca8d4: 94bd721a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca8d8: aa0003f9    	mov	x25, x0
104cca8dc: aa1703e0    	mov	x0, x23
104cca8e0: 94bd721d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca8e4: f9453760    	ldr	x0, [x27, #0xa68]
104cca8e8: 34000679    	cbz	w25, 0x104cca9b4 <_Flutter_MMFoundation_BindContext+0x11a6598>
104cca8ec: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca8f0: 91222108    	add	x8, x8, #0x888
104cca8f4: f90003e8    	str	x8, [sp]
104cca8f8: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca8fc: 911a5863    	add	x3, x3, #0x696
104cca900: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca904: 9129b4a5    	add	x5, x5, #0xa6d
104cca908: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca90c: 913ed8e7    	add	x7, x7, #0xfb6
104cca910: aa1803e1    	mov	x1, x24
104cca914: 52800042    	mov	w2, #0x2                ; =2
104cca918: 52800004    	mov	w4, #0x0                ; =0
104cca91c: 528037c6    	mov	w6, #0x1be              ; =446
104cca920: 94bd7207    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca924: aa1503e0    	mov	x0, x21
104cca928: aa1603e1    	mov	x1, x22
104cca92c: 94bd7204    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca930: aa1d03fd    	mov	x29, x29
104cca934: 94bd7205    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cca938: aa0003f6    	mov	x22, x0
104cca93c: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca940: f944a101    	ldr	x1, [x8, #0x940] ; addHistoryWithMsg:
104cca944: aa1303e2    	mov	x2, x19
104cca948: 94bd71fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca94c: aa1603e0    	mov	x0, x22
104cca950: 94bd7201    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cca954: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca958: f9455501    	ldr	x1, [x8, #0xaa8] ; didMonoServiceMsgReject
104cca95c: aa1503e0    	mov	x0, x21
104cca960: 14000013    	b	0x104cca9ac <_Flutter_MMFoundation_BindContext+0x11a6590>
104cca964: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca968: 91232108    	add	x8, x8, #0x8c8
104cca96c: f90003e8    	str	x8, [sp]
104cca970: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca974: 911a5863    	add	x3, x3, #0x696
104cca978: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca97c: 9129b4a5    	add	x5, x5, #0xa6d
104cca980: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca984: 913ed8e7    	add	x7, x7, #0xfb6
104cca988: aa1803e1    	mov	x1, x24
104cca98c: 52800082    	mov	w2, #0x4                ; =4
104cca990: 52800004    	mov	w4, #0x0                ; =0
104cca994: 528038c6    	mov	w6, #0x1c6              ; =454
104cca998: 94bd71e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca99c: b00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cca9a0: f9434100    	ldr	x0, [x8, #0x680]
104cca9a4: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cca9a8: f9455901    	ldr	x1, [x8, #0xab0] ; delegateRejectNotExist
104cca9ac: 94bd71e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca9b0: 17fffe40    	b	0x104cca2b0 <_Flutter_MMFoundation_BindContext+0x11a5e94>
104cca9b4: f00cd748    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cca9b8: 9122a108    	add	x8, x8, #0x8a8
104cca9bc: f90003e8    	str	x8, [sp]
104cca9c0: b00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca9c4: 911a5863    	add	x3, x3, #0x696
104cca9c8: b00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca9cc: 9129b4a5    	add	x5, x5, #0xa6d
104cca9d0: b00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cca9d4: 913ed8e7    	add	x7, x7, #0xfb6
104cca9d8: aa1803e1    	mov	x1, x24
104cca9dc: 52800042    	mov	w2, #0x2                ; =2
104cca9e0: 52800004    	mov	w4, #0x0                ; =0
104cca9e4: 52803866    	mov	w6, #0x1c3              ; =451
104cca9e8: 94bd71d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cca9ec: 17fffe31    	b	0x104cca2b0 <_Flutter_MMFoundation_BindContext+0x11a5e94>
