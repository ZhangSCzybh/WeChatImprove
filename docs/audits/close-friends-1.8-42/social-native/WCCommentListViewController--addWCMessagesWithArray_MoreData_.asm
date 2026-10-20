
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106edeecc: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
106edeed0: a90167fa    	stp	x26, x25, [sp, #0x10]
106edeed4: a9025ff8    	stp	x24, x23, [sp, #0x20]
106edeed8: a90357f6    	stp	x22, x21, [sp, #0x30]
106edeedc: a9044ff4    	stp	x20, x19, [sp, #0x40]
106edeee0: a9057bfd    	stp	x29, x30, [sp, #0x50]
106edeee4: 910143fd    	add	x29, sp, #0x50
106edeee8: d10703ff    	sub	sp, sp, #0x1c0
106edeeec: aa0303f6    	mov	x22, x3
106edeef0: aa0203fa    	mov	x26, x2
106edeef4: aa0003f4    	mov	x20, x0
106edeef8: b00b3888    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106edeefc: f9405908    	ldr	x8, [x8, #0xb0]
106edef00: f9400108    	ldr	x8, [x8]
106edef04: f81a03a8    	stur	x8, [x29, #-0x60]
106edef08: 900ceb48    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106edef0c: 52800029    	mov	w9, #0x1                ; =1
106edef10: 391f8509    	strb	w9, [x8, #0x7e1]
106edef14: aa0203e0    	mov	x0, x2
106edef18: 94352088    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106edef1c: 4f00e400    	movi.16b	v0, #0x0
106edef20: ad0883e0    	stp	q0, q0, [sp, #0x110]
106edef24: ad0783e0    	stp	q0, q0, [sp, #0xf0]
106edef28: d00c9108    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106edef2c: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
106edef30: 9103c3e2    	add	x2, sp, #0xf0
106edef34: d10383a3    	sub	x3, x29, #0xe0
106edef38: aa1a03e0    	mov	x0, x26
106edef3c: f90003e1    	str	x1, [sp]
106edef40: 52800204    	mov	w4, #0x10               ; =16
106edef44: 9435207e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edef48: f9004be0    	str	x0, [sp, #0x90]
106edef4c: b4003a40    	cbz	x0, 0x106edf694 <_Flutter_MMFoundation_BindContext+0x33bb278>
106edef50: f94083e8    	ldr	x8, [sp, #0x100]
106edef54: f9400108    	ldr	x8, [x8]
106edef58: f90043e8    	str	x8, [sp, #0x80]
106edef5c: f90023fa    	str	x26, [sp, #0x40]
106edef60: b9004ff6    	str	w22, [sp, #0x4c]
106edef64: d2800019    	mov	x25, #0x0               ; =0
106edef68: b00c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edef6c: f9436d08    	ldr	x8, [x8, #0x6d8] ; getObjIDByWCMessage:
106edef70: f90047e8    	str	x8, [sp, #0x88]
106edef74: 900c7ca8    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
106edef78: f942651b    	ldr	x27, [x8, #0x4c8] ; comment
106edef7c: b00c9168    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106edef80: f941c917    	ldr	x23, [x8, #0x390] ; type
106edef84: d00c9108    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106edef88: f944e909    	ldr	x9, [x8, #0x9d0] ; currentContext
106edef8c: b00c9108    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106edef90: f947ad08    	ldr	x8, [x8, #0xf58] ; class
106edef94: a90a27e8    	stp	x8, x9, [sp, #0xa0]
106edef98: f00c7ac8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106edef9c: f9464108    	ldr	x8, [x8, #0xc80] ; getService:
106edefa0: f9004fe8    	str	x8, [sp, #0x98]
106edefa4: f00c7b68    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
106edefa8: f9422d09    	ldr	x9, [x8, #0x458] ; getDataItemByID:
106edefac: b00c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edefb0: f943d50a    	ldr	x10, [x8, #0x7a8] ; getCommentMessageListType:dataItem:moreData:
106edefb4: b00c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edefb8: f943d908    	ldr	x8, [x8, #0x7b0] ; addWCMessages:forListType:
106edefbc: a906abe8    	stp	x8, x10, [sp, #0x68]
106edefc0: d00c9108    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106edefc4: f9424d0a    	ldr	x10, [x8, #0x498] ; containsObject:
106edefc8: b00c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edefcc: f943e108    	ldr	x8, [x8, #0x7c0] ; updatedItemIds
106edefd0: a90127e8    	stp	x8, x9, [sp, #0x10]
106edefd4: 900c7ae8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106edefd8: f943c509    	ldr	x9, [x8, #0x788] ; safeAddObject:
106edefdc: b00c7c88    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
106edefe0: f943f108    	ldr	x8, [x8, #0x7e0] ; updateDataItemDetail:
106edefe4: f90007e8    	str	x8, [sp, #0x8]
106edefe8: f00c8828    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
106edefec: f9452d08    	ldr	x8, [x8, #0xa58] ; getAdvertiseData:
106edeff0: f9003fe8    	str	x8, [sp, #0x78]
106edeff4: b00c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edeff8: f943e508    	ldr	x8, [x8, #0x7c8] ; bUnreadOnly
106edeffc: a90523ea    	stp	x10, x8, [sp, #0x50]
106edf000: f00c9148    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106edf004: f9448d08    	ldr	x8, [x8, #0x918] ; source
106edf008: a90327e8    	stp	x8, x9, [sp, #0x30]
106edf00c: b00c8888    	adrp	x8, 0x11fff0000 <dyld_stub_binder+0x11fff0000>
106edf010: f9413909    	ldr	x9, [x8, #0x270] ; remindFriendsInfoData
106edf014: 900c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edf018: f943dd08    	ldr	x8, [x8, #0x7b8] ; updateDataItemDetail:source:RemindFriendsInfoData:
106edf01c: a90227e8    	stp	x8, x9, [sp, #0x20]
106edf020: d00c7ac8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106edf024: f942c908    	ldr	x8, [x8, #0x590] ; safeSetObject:forKey:
106edf028: f90033e8    	str	x8, [sp, #0x60]
106edf02c: a90b5ffb    	stp	x27, x23, [sp, #0xb0]
106edf030: f94083e8    	ldr	x8, [sp, #0x100]
106edf034: f9400108    	ldr	x8, [x8]
106edf038: f94043e9    	ldr	x9, [sp, #0x80]
106edf03c: eb09011f    	cmp	x8, x9
106edf040: 54000060    	b.eq	0x106edf04c <_Flutter_MMFoundation_BindContext+0x33bac30>
106edf044: aa1a03e0    	mov	x0, x26
106edf048: 94352042    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
106edf04c: f9407fe8    	ldr	x8, [sp, #0xf8]
106edf050: f8797918    	ldr	x24, [x8, x25, lsl #3]
106edf054: aa1403e0    	mov	x0, x20
106edf058: f94047e1    	ldr	x1, [sp, #0x88]
106edf05c: aa1803e2    	mov	x2, x24
106edf060: 94352037    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf064: aa1d03fd    	mov	x29, x29
106edf068: 94352038    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf06c: aa0003f5    	mov	x21, x0
106edf070: aa1803e0    	mov	x0, x24
106edf074: aa1b03e1    	mov	x1, x27
106edf078: 94352031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf07c: aa1d03fd    	mov	x29, x29
106edf080: 94352032    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf084: aa0003f3    	mov	x19, x0
106edf088: aa1703e1    	mov	x1, x23
106edf08c: 9435202c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf090: 71001c1f    	cmp	w0, #0x7
106edf094: 540002c0    	b.eq	0x106edf0ec <_Flutter_MMFoundation_BindContext+0x33bacd0>
106edf098: aa1503fc    	mov	x28, x21
106edf09c: aa1603f5    	mov	x21, x22
106edf0a0: aa1a03f6    	mov	x22, x26
106edf0a4: aa1403fa    	mov	x26, x20
106edf0a8: aa1803e0    	mov	x0, x24
106edf0ac: aa1b03e1    	mov	x1, x27
106edf0b0: 94352023    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf0b4: aa1d03fd    	mov	x29, x29
106edf0b8: 94352024    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf0bc: aa0003f7    	mov	x23, x0
106edf0c0: f9405ff4    	ldr	x20, [sp, #0xb8]
106edf0c4: aa1403e1    	mov	x1, x20
106edf0c8: 9435201d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf0cc: 7100201f    	cmp	w0, #0x8
106edf0d0: 540009e1    	b.ne	0x106edf20c <_Flutter_MMFoundation_BindContext+0x33badf0>
106edf0d4: aa1703e0    	mov	x0, x23
106edf0d8: 9435201f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf0dc: aa1a03f4    	mov	x20, x26
106edf0e0: aa1603fa    	mov	x26, x22
106edf0e4: aa1503f6    	mov	x22, x21
106edf0e8: aa1c03f5    	mov	x21, x28
106edf0ec: aa1303e0    	mov	x0, x19
106edf0f0: 94352019    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf0f4: 900c94a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106edf0f8: f945e900    	ldr	x0, [x8, #0xbd0]
106edf0fc: f94057e1    	ldr	x1, [sp, #0xa8]
106edf100: 9435200f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf104: aa1d03fd    	mov	x29, x29
106edf108: 94352010    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf10c: aa0003f7    	mov	x23, x0
106edf110: b00c94a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106edf114: f9428500    	ldr	x0, [x8, #0x508]
106edf118: f94053e1    	ldr	x1, [sp, #0xa0]
106edf11c: 94352008    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf120: aa0003e2    	mov	x2, x0
106edf124: aa1703e0    	mov	x0, x23
106edf128: f9404fe1    	ldr	x1, [sp, #0x98]
106edf12c: 94352004    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf130: aa1d03fd    	mov	x29, x29
106edf134: 94352005    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf138: aa0003fb    	mov	x27, x0
106edf13c: f9403fe1    	ldr	x1, [sp, #0x78]
106edf140: aa1503e2    	mov	x2, x21
106edf144: 94351ffe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf148: aa1d03fd    	mov	x29, x29
106edf14c: 94351fff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf150: aa0003f3    	mov	x19, x0
106edf154: aa1b03e0    	mov	x0, x27
106edf158: 94351fff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf15c: aa1703e0    	mov	x0, x23
106edf160: 94351ffd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf164: f10002bf    	cmp	x21, #0x0
106edf168: fa401a64    	ccmp	x19, #0x0, #0x4, ne
106edf16c: 54000b61    	b.ne	0x106edf2d8 <_Flutter_MMFoundation_BindContext+0x33baebc>
106edf170: aa1403e0    	mov	x0, x20
106edf174: f9402fe1    	ldr	x1, [sp, #0x58]
106edf178: 94351ff1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf17c: f9405bfb    	ldr	x27, [sp, #0xb0]
106edf180: 34002680    	cbz	w0, 0x106edf650 <_Flutter_MMFoundation_BindContext+0x33bb234>
106edf184: 37002676    	tbnz	w22, #0x0, 0x106edf650 <_Flutter_MMFoundation_BindContext+0x33bb234>
106edf188: aa1403e0    	mov	x0, x20
106edf18c: f9403be1    	ldr	x1, [sp, #0x70]
106edf190: aa1803e2    	mov	x2, x24
106edf194: aa1303e3    	mov	x3, x19
106edf198: 52800004    	mov	w4, #0x0                ; =0
106edf19c: 94351fe8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf1a0: aa0003e3    	mov	x3, x0
106edf1a4: aa1403e0    	mov	x0, x20
106edf1a8: f94037e1    	ldr	x1, [sp, #0x68]
106edf1ac: aa1803e2    	mov	x2, x24
106edf1b0: 94351fe3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf1b4: aa1803e0    	mov	x0, x24
106edf1b8: aa1b03e1    	mov	x1, x27
106edf1bc: 94351fe0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf1c0: aa1d03fd    	mov	x29, x29
106edf1c4: 94351fe1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf1c8: aa0003f7    	mov	x23, x0
106edf1cc: f9405fe1    	ldr	x1, [sp, #0xb8]
106edf1d0: 94351fdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf1d4: 7100401f    	cmp	w0, #0x10
106edf1d8: 54002381    	b.ne	0x106edf648 <_Flutter_MMFoundation_BindContext+0x33bb22c>
106edf1dc: d00c9b28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106edf1e0: b989891a    	ldrsw	x26, [x8, #0x988]
106edf1e4: f87a6a80    	ldr	x0, [x20, x26]
106edf1e8: f9402be1    	ldr	x1, [sp, #0x50]
106edf1ec: aa1503e2    	mov	x2, x21
106edf1f0: 94351fd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf1f4: aa0003f6    	mov	x22, x0
106edf1f8: aa1703e0    	mov	x0, x23
106edf1fc: 94351fd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf200: 36001796    	tbz	w22, #0x0, 0x106edf4f0 <_Flutter_MMFoundation_BindContext+0x33bb0d4>
106edf204: f94023fa    	ldr	x26, [sp, #0x40]
106edf208: 140000b8    	b	0x106edf4e8 <_Flutter_MMFoundation_BindContext+0x33bb0cc>
106edf20c: aa1803e0    	mov	x0, x24
106edf210: aa1b03e1    	mov	x1, x27
106edf214: 94351fca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf218: aa1d03fd    	mov	x29, x29
106edf21c: 94351fcb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf220: aa0003fb    	mov	x27, x0
106edf224: aa1403e1    	mov	x1, x20
106edf228: 94351fc5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf22c: aa0003f4    	mov	x20, x0
106edf230: aa1b03e0    	mov	x0, x27
106edf234: 94351fc8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf238: aa1703e0    	mov	x0, x23
106edf23c: 94351fc6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf240: aa1303e0    	mov	x0, x19
106edf244: 94351fc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf248: 7100429f    	cmp	w20, #0x10
106edf24c: aa1a03f4    	mov	x20, x26
106edf250: aa1603fa    	mov	x26, x22
106edf254: aa1503f6    	mov	x22, x21
106edf258: aa1c03f5    	mov	x21, x28
106edf25c: 54fff4c0    	b.eq	0x106edf0f4 <_Flutter_MMFoundation_BindContext+0x33bacd8>
106edf260: 900c94a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106edf264: f945e900    	ldr	x0, [x8, #0xbd0]
106edf268: f94057e1    	ldr	x1, [sp, #0xa8]
106edf26c: 94351fb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf270: aa1d03fd    	mov	x29, x29
106edf274: 94351fb5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf278: aa0003f7    	mov	x23, x0
106edf27c: b00c94a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106edf280: f9428500    	ldr	x0, [x8, #0x508]
106edf284: f94053e1    	ldr	x1, [sp, #0xa0]
106edf288: 94351fad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf28c: aa0003e2    	mov	x2, x0
106edf290: aa1703e0    	mov	x0, x23
106edf294: f9404fe1    	ldr	x1, [sp, #0x98]
106edf298: 94351fa9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf29c: aa1d03fd    	mov	x29, x29
106edf2a0: 94351faa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf2a4: aa0003fb    	mov	x27, x0
106edf2a8: f9400fe1    	ldr	x1, [sp, #0x18]
106edf2ac: aa1503e2    	mov	x2, x21
106edf2b0: 94351fa3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf2b4: aa1d03fd    	mov	x29, x29
106edf2b8: 94351fa4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf2bc: aa0003f3    	mov	x19, x0
106edf2c0: aa1b03e0    	mov	x0, x27
106edf2c4: 94351fa4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf2c8: aa1703e0    	mov	x0, x23
106edf2cc: 94351fa2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf2d0: b4000cb5    	cbz	x21, 0x106edf464 <_Flutter_MMFoundation_BindContext+0x33bb048>
106edf2d4: b4000c93    	cbz	x19, 0x106edf464 <_Flutter_MMFoundation_BindContext+0x33bb048>
106edf2d8: f9405bfb    	ldr	x27, [sp, #0xb0]
106edf2dc: d00c9b28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106edf2e0: b9897d08    	ldrsw	x8, [x8, #0x97c]
106edf2e4: f8686a80    	ldr	x0, [x20, x8]
106edf2e8: f94033e1    	ldr	x1, [sp, #0x60]
106edf2ec: aa1303e2    	mov	x2, x19
106edf2f0: aa1503e3    	mov	x3, x21
106edf2f4: 94351f92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf2f8: aa1403e0    	mov	x0, x20
106edf2fc: f9403be1    	ldr	x1, [sp, #0x70]
106edf300: aa1803e2    	mov	x2, x24
106edf304: aa1303e3    	mov	x3, x19
106edf308: aa1603e4    	mov	x4, x22
106edf30c: 94351f8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf310: aa0003e3    	mov	x3, x0
106edf314: aa1403e0    	mov	x0, x20
106edf318: f94037e1    	ldr	x1, [sp, #0x68]
106edf31c: aa1803e2    	mov	x2, x24
106edf320: 94351f87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf324: aa1803e0    	mov	x0, x24
106edf328: aa1b03e1    	mov	x1, x27
106edf32c: 94351f84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf330: aa1d03fd    	mov	x29, x29
106edf334: 94351f85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf338: aa0003f7    	mov	x23, x0
106edf33c: f9405fe1    	ldr	x1, [sp, #0xb8]
106edf340: 94351f7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf344: 7100401f    	cmp	w0, #0x10
106edf348: 54001801    	b.ne	0x106edf648 <_Flutter_MMFoundation_BindContext+0x33bb22c>
106edf34c: d00c9b28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106edf350: b9898916    	ldrsw	x22, [x8, #0x988]
106edf354: f8766a80    	ldr	x0, [x20, x22]
106edf358: f9402be1    	ldr	x1, [sp, #0x50]
106edf35c: aa1503e2    	mov	x2, x21
106edf360: 94351f77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf364: aa0003fb    	mov	x27, x0
106edf368: aa1703e0    	mov	x0, x23
106edf36c: 94351f7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf370: 3600009b    	tbz	w27, #0x0, 0x106edf380 <_Flutter_MMFoundation_BindContext+0x33baf64>
106edf374: b9404ff6    	ldr	w22, [sp, #0x4c]
106edf378: f9405bfb    	ldr	x27, [sp, #0xb0]
106edf37c: 140000b5    	b	0x106edf650 <_Flutter_MMFoundation_BindContext+0x33bb234>
106edf380: f8766a80    	ldr	x0, [x20, x22]
106edf384: f9401fe1    	ldr	x1, [sp, #0x38]
106edf388: aa1503e2    	mov	x2, x21
106edf38c: 94351f6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf390: 900c94a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106edf394: f945e900    	ldr	x0, [x8, #0xbd0]
106edf398: f94057e1    	ldr	x1, [sp, #0xa8]
106edf39c: 94351f68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf3a0: aa1d03fd    	mov	x29, x29
106edf3a4: 94351f69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf3a8: aa0003f7    	mov	x23, x0
106edf3ac: b00c94a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106edf3b0: f9428500    	ldr	x0, [x8, #0x508]
106edf3b4: f94053e1    	ldr	x1, [sp, #0xa0]
106edf3b8: 94351f61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf3bc: aa0003e2    	mov	x2, x0
106edf3c0: aa1703e0    	mov	x0, x23
106edf3c4: f9404fe1    	ldr	x1, [sp, #0x98]
106edf3c8: 94351f5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf3cc: aa1d03fd    	mov	x29, x29
106edf3d0: 94351f5e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf3d4: aa0003fb    	mov	x27, x0
106edf3d8: aa1803e0    	mov	x0, x24
106edf3dc: f9405bfa    	ldr	x26, [sp, #0xb0]
106edf3e0: aa1a03e1    	mov	x1, x26
106edf3e4: 94351f56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf3e8: aa1d03fd    	mov	x29, x29
106edf3ec: 94351f57    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf3f0: aa0003fc    	mov	x28, x0
106edf3f4: f9401be1    	ldr	x1, [sp, #0x30]
106edf3f8: 94351f51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf3fc: aa0003f6    	mov	x22, x0
106edf400: aa1803e0    	mov	x0, x24
106edf404: aa1a03e1    	mov	x1, x26
106edf408: 94351f4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf40c: aa1d03fd    	mov	x29, x29
106edf410: 94351f4e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf414: aa0003f8    	mov	x24, x0
106edf418: f94017e1    	ldr	x1, [sp, #0x28]
106edf41c: 94351f48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf420: aa1d03fd    	mov	x29, x29
106edf424: 94351f49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf428: aa0003fa    	mov	x26, x0
106edf42c: aa1b03e0    	mov	x0, x27
106edf430: f94013e1    	ldr	x1, [sp, #0x20]
106edf434: aa1503e2    	mov	x2, x21
106edf438: aa1603e3    	mov	x3, x22
106edf43c: aa1a03e4    	mov	x4, x26
106edf440: 94351f3f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf444: aa1a03e0    	mov	x0, x26
106edf448: f94023fa    	ldr	x26, [sp, #0x40]
106edf44c: 94351f42    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf450: aa1803e0    	mov	x0, x24
106edf454: 94351f40    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf458: aa1c03e0    	mov	x0, x28
106edf45c: 94351f3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf460: 14000076    	b	0x106edf638 <_Flutter_MMFoundation_BindContext+0x33bb21c>
106edf464: aa1403e0    	mov	x0, x20
106edf468: f9403be1    	ldr	x1, [sp, #0x70]
106edf46c: aa1803e2    	mov	x2, x24
106edf470: aa1303e3    	mov	x3, x19
106edf474: aa1603e4    	mov	x4, x22
106edf478: 94351f31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf47c: aa0003e3    	mov	x3, x0
106edf480: aa1403e0    	mov	x0, x20
106edf484: f94037e1    	ldr	x1, [sp, #0x68]
106edf488: aa1803e2    	mov	x2, x24
106edf48c: 94351f2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf490: d00c9b28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106edf494: b9898918    	ldrsw	x24, [x8, #0x988]
106edf498: f8786a80    	ldr	x0, [x20, x24]
106edf49c: f9402bf7    	ldr	x23, [sp, #0x50]
106edf4a0: aa1703e1    	mov	x1, x23
106edf4a4: aa1503e2    	mov	x2, x21
106edf4a8: 94351f25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf4ac: f9405bfb    	ldr	x27, [sp, #0xb0]
106edf4b0: 37000d00    	tbnz	w0, #0x0, 0x106edf650 <_Flutter_MMFoundation_BindContext+0x33bb234>
106edf4b4: aa1403e0    	mov	x0, x20
106edf4b8: f9400be1    	ldr	x1, [sp, #0x10]
106edf4bc: 94351f20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf4c0: aa1d03fd    	mov	x29, x29
106edf4c4: 94351f21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf4c8: aa0003f6    	mov	x22, x0
106edf4cc: aa1703e1    	mov	x1, x23
106edf4d0: aa1503e2    	mov	x2, x21
106edf4d4: 94351f1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf4d8: aa0003f7    	mov	x23, x0
106edf4dc: aa1603e0    	mov	x0, x22
106edf4e0: 94351f1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf4e4: 36000797    	tbz	w23, #0x0, 0x106edf5d4 <_Flutter_MMFoundation_BindContext+0x33bb1b8>
106edf4e8: b9404ff6    	ldr	w22, [sp, #0x4c]
106edf4ec: 14000059    	b	0x106edf650 <_Flutter_MMFoundation_BindContext+0x33bb234>
106edf4f0: f87a6a80    	ldr	x0, [x20, x26]
106edf4f4: f9401fe1    	ldr	x1, [sp, #0x38]
106edf4f8: aa1503e2    	mov	x2, x21
106edf4fc: 94351f10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf500: 900c94a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106edf504: f945e900    	ldr	x0, [x8, #0xbd0]
106edf508: f94057e1    	ldr	x1, [sp, #0xa8]
106edf50c: 94351f0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf510: aa1d03fd    	mov	x29, x29
106edf514: 94351f0d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf518: aa0003f7    	mov	x23, x0
106edf51c: b00c94a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106edf520: f9428500    	ldr	x0, [x8, #0x508]
106edf524: f94053e1    	ldr	x1, [sp, #0xa0]
106edf528: 94351f05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf52c: aa0003e2    	mov	x2, x0
106edf530: aa1703e0    	mov	x0, x23
106edf534: f9404fe1    	ldr	x1, [sp, #0x98]
106edf538: 94351f01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf53c: aa1d03fd    	mov	x29, x29
106edf540: 94351f02    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf544: aa1b03fc    	mov	x28, x27
106edf548: aa0003fb    	mov	x27, x0
106edf54c: aa1803e0    	mov	x0, x24
106edf550: aa1c03e1    	mov	x1, x28
106edf554: 94351efa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf558: aa1d03fd    	mov	x29, x29
106edf55c: 94351efb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf560: aa0003f6    	mov	x22, x0
106edf564: f9401be1    	ldr	x1, [sp, #0x30]
106edf568: 94351ef5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf56c: aa0003fa    	mov	x26, x0
106edf570: aa1803e0    	mov	x0, x24
106edf574: aa1c03e1    	mov	x1, x28
106edf578: 94351ef1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf57c: aa1d03fd    	mov	x29, x29
106edf580: 94351ef2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf584: aa0003f8    	mov	x24, x0
106edf588: f94017e1    	ldr	x1, [sp, #0x28]
106edf58c: 94351eec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf590: aa1d03fd    	mov	x29, x29
106edf594: 94351eed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf598: aa0003fc    	mov	x28, x0
106edf59c: aa1b03e0    	mov	x0, x27
106edf5a0: f94013e1    	ldr	x1, [sp, #0x20]
106edf5a4: aa1503e2    	mov	x2, x21
106edf5a8: aa1a03e3    	mov	x3, x26
106edf5ac: aa1c03e4    	mov	x4, x28
106edf5b0: 94351ee3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf5b4: aa1c03e0    	mov	x0, x28
106edf5b8: 94351ee7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf5bc: aa1803e0    	mov	x0, x24
106edf5c0: 94351ee5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf5c4: aa1603e0    	mov	x0, x22
106edf5c8: 94351ee3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf5cc: f94023fa    	ldr	x26, [sp, #0x40]
106edf5d0: 1400001a    	b	0x106edf638 <_Flutter_MMFoundation_BindContext+0x33bb21c>
106edf5d4: f8786a80    	ldr	x0, [x20, x24]
106edf5d8: f9401fe1    	ldr	x1, [sp, #0x38]
106edf5dc: aa1503e2    	mov	x2, x21
106edf5e0: 94351ed7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf5e4: 900c94a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106edf5e8: f945e900    	ldr	x0, [x8, #0xbd0]
106edf5ec: f94057e1    	ldr	x1, [sp, #0xa8]
106edf5f0: 94351ed3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf5f4: aa1d03fd    	mov	x29, x29
106edf5f8: 94351ed4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf5fc: aa0003f7    	mov	x23, x0
106edf600: b00c94a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106edf604: f9428500    	ldr	x0, [x8, #0x508]
106edf608: f94053e1    	ldr	x1, [sp, #0xa0]
106edf60c: 94351ecc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf610: aa0003e2    	mov	x2, x0
106edf614: aa1703e0    	mov	x0, x23
106edf618: f9404fe1    	ldr	x1, [sp, #0x98]
106edf61c: 94351ec8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf620: aa1d03fd    	mov	x29, x29
106edf624: 94351ec9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf628: aa0003fb    	mov	x27, x0
106edf62c: f94007e1    	ldr	x1, [sp, #0x8]
106edf630: aa1503e2    	mov	x2, x21
106edf634: 94351ec2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf638: b9404ff6    	ldr	w22, [sp, #0x4c]
106edf63c: aa1b03e0    	mov	x0, x27
106edf640: 94351ec5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf644: f9405bfb    	ldr	x27, [sp, #0xb0]
106edf648: aa1703e0    	mov	x0, x23
106edf64c: 94351ec2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf650: aa1303e0    	mov	x0, x19
106edf654: 94351ec0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf658: aa1503e0    	mov	x0, x21
106edf65c: 94351ebe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf660: 91000739    	add	x25, x25, #0x1
106edf664: f9404be8    	ldr	x8, [sp, #0x90]
106edf668: eb19011f    	cmp	x8, x25
106edf66c: f9405ff7    	ldr	x23, [sp, #0xb8]
106edf670: 54ffce01    	b.ne	0x106edf030 <_Flutter_MMFoundation_BindContext+0x33bac14>
106edf674: 9103c3e2    	add	x2, sp, #0xf0
106edf678: d10383a3    	sub	x3, x29, #0xe0
106edf67c: aa1a03e0    	mov	x0, x26
106edf680: f94003e1    	ldr	x1, [sp]
106edf684: 52800204    	mov	w4, #0x10               ; =16
106edf688: 94351ead    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf68c: f9004be0    	str	x0, [sp, #0x90]
106edf690: b5ffc6a0    	cbnz	x0, 0x106edef64 <_Flutter_MMFoundation_BindContext+0x33bab48>
106edf694: 900c8908    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
106edf698: f943e901    	ldr	x1, [x8, #0x7d0] ; updateArrSectionTitleType
106edf69c: aa1403e0    	mov	x0, x20
106edf6a0: 94351ea7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf6a4: f00b3868    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
106edf6a8: f947e108    	ldr	x8, [x8, #0xfc0]
106edf6ac: f90063e8    	str	x8, [sp, #0xc0]
106edf6b0: d008f508    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106edf6b4: fd41c100    	ldr	d0, [x8, #0x380]
106edf6b8: 90000008    	adrp	x8, 0x106edf000 <_Flutter_MMFoundation_BindContext+0x33babe4>
106edf6bc: 911e3108    	add	x8, x8, #0x78c
106edf6c0: fd0067e0    	str	d0, [sp, #0xc8]
106edf6c4: 900b38c9    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
106edf6c8: 91044129    	add	x9, x9, #0x110
106edf6cc: a90d27e8    	stp	x8, x9, [sp, #0xd0]
106edf6d0: f90073f4    	str	x20, [sp, #0xe0]
106edf6d4: aa1a03e0    	mov	x0, x26
106edf6d8: 94351e98    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106edf6dc: f90077fa    	str	x26, [sp, #0xe8]
106edf6e0: d2800000    	mov	x0, #0x0                ; =0
106edf6e4: d2800001    	mov	x1, #0x0                ; =0
106edf6e8: 94351eac    	bl	0x107c27198 <_Flutter_MMFoundation_BindContext+0x4102d7c>
106edf6ec: aa1d03fd    	mov	x29, x29
106edf6f0: 94351e96    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106edf6f4: aa0003f3    	mov	x19, x0
106edf6f8: 910303e1    	add	x1, sp, #0xc0
106edf6fc: 9434b6c9    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
106edf700: aa1303e0    	mov	x0, x19
106edf704: 94351e94    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf708: d00c9b28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106edf70c: b9897908    	ldrsw	x8, [x8, #0x978]
106edf710: f8686a80    	ldr	x0, [x20, x8]
106edf714: b00c9108    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106edf718: f9435101    	ldr	x1, [x8, #0x6a0] ; count
106edf71c: 94351e88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf720: b5000100    	cbnz	x0, 0x106edf740 <_Flutter_MMFoundation_BindContext+0x33bb324>
106edf724: d00c9b28    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106edf728: b9896908    	ldrsw	x8, [x8, #0x968]
106edf72c: 38286a9f    	strb	wzr, [x20, x8]
106edf730: f00c7ba8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
106edf734: f9454101    	ldr	x1, [x8, #0xa80] ; initTableFooterView
106edf738: aa1403e0    	mov	x0, x20
106edf73c: 94351e80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106edf740: f94077e0    	ldr	x0, [sp, #0xe8]
106edf744: 94351e84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf748: aa1a03e0    	mov	x0, x26
106edf74c: 94351e82    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106edf750: f85a03a8    	ldur	x8, [x29, #-0x60]
106edf754: 900b3889    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106edf758: f9405929    	ldr	x9, [x9, #0xb0]
106edf75c: f9400129    	ldr	x9, [x9]
106edf760: eb08013f    	cmp	x9, x8
106edf764: 54000121    	b.ne	0x106edf788 <_Flutter_MMFoundation_BindContext+0x33bb36c>
106edf768: 910703ff    	add	sp, sp, #0x1c0
106edf76c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106edf770: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106edf774: a94357f6    	ldp	x22, x21, [sp, #0x30]
106edf778: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106edf77c: a94167fa    	ldp	x26, x25, [sp, #0x10]
106edf780: a8c66ffc    	ldp	x28, x27, [sp], #0x60
106edf784: d65f03c0    	ret
106edf788: 94351e7b    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
