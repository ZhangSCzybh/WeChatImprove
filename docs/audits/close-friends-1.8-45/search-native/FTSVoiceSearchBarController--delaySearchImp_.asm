
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182a008: d10203ff    	sub	sp, sp, #0x80
10182a00c: a9026ffc    	stp	x28, x27, [sp, #0x20]
10182a010: a90367fa    	stp	x26, x25, [sp, #0x30]
10182a014: a9045ff8    	stp	x24, x23, [sp, #0x40]
10182a018: a90557f6    	stp	x22, x21, [sp, #0x50]
10182a01c: a9064ff4    	stp	x20, x19, [sp, #0x60]
10182a020: a9077bfd    	stp	x29, x30, [sp, #0x70]
10182a024: 9101c3fd    	add	x29, sp, #0x70
10182a028: aa0203f3    	mov	x19, x2
10182a02c: aa0003f5    	mov	x21, x0
10182a030: 900fa048    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10182a034: 52800029    	mov	w9, #0x1                ; =1
10182a038: 392ce109    	strb	w9, [x8, #0xb38]
10182a03c: aa0203e0    	mov	x0, x2
10182a040: 958ff43e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10182a044: 900f33e8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10182a048: f9436901    	ldr	x1, [x8, #0x6d0] ; searchBarText
10182a04c: aa1503e0    	mov	x0, x21
10182a050: 958ff43b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a054: aa1d03fd    	mov	x29, x29
10182a058: 958ff43c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a05c: aa0003f4    	mov	x20, x0
10182a060: b00f4a59    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10182a064: f9453720    	ldr	x0, [x25, #0xa68]
10182a068: f00f3068    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182a06c: f942a916    	ldr	x22, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10182a070: f00e6b68    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10182a074: 91252108    	add	x8, x8, #0x948
10182a078: a90053e8    	stp	x8, x20, [sp]
10182a07c: d00cd243    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10182a080: 91388063    	add	x3, x3, #0xe20
10182a084: b00cde25    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182a088: 912160a5    	add	x5, x5, #0x858
10182a08c: b00cde27    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182a090: 913e5ce7    	add	x7, x7, #0xf97
10182a094: aa1603e1    	mov	x1, x22
10182a098: 52800042    	mov	w2, #0x2                ; =2
10182a09c: 52800004    	mov	w4, #0x0                ; =0
10182a0a0: 5280b7e6    	mov	w6, #0x5bf              ; =1471
10182a0a4: 958ff426    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a0a8: b00f46c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10182a0ac: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10182a0b0: aa1403e0    	mov	x0, x20
10182a0b4: aa1303e2    	mov	x2, x19
10182a0b8: 958ff421    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a0bc: 34000f20    	cbz	w0, 0x10182a2a0 <__text+0x18222a0>
10182a0c0: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a0c4: f9467900    	ldr	x0, [x8, #0xcf0]
10182a0c8: f00f3168    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
10182a0cc: f9436501    	ldr	x1, [x8, #0x6c8] ; trimString:
10182a0d0: aa1303e2    	mov	x2, x19
10182a0d4: 958ff41a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a0d8: aa1d03fd    	mov	x29, x29
10182a0dc: 958ff41b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a0e0: aa0003f7    	mov	x23, x0
10182a0e4: b00f46c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10182a0e8: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10182a0ec: 958ff414    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a0f0: aa0003f8    	mov	x24, x0
10182a0f4: aa1703e0    	mov	x0, x23
10182a0f8: 958ff417    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a0fc: b4000d38    	cbz	x24, 0x10182a2a0 <__text+0x18222a0>
10182a100: 900f33e8    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10182a104: f942fd01    	ldr	x1, [x8, #0x5f8] ; reloadSearchData
10182a108: aa1503e0    	mov	x0, x21
10182a10c: 958ff40c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a110: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a114: f945e900    	ldr	x0, [x8, #0xbd0]
10182a118: d00f46a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10182a11c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10182a120: f9000fe1    	str	x1, [sp, #0x18]
10182a124: 958ff406    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a128: aa1d03fd    	mov	x29, x29
10182a12c: 958ff407    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a130: aa0003fa    	mov	x26, x0
10182a134: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a138: f9477100    	ldr	x0, [x8, #0xee0]
10182a13c: b00f46a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10182a140: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10182a144: f9000be1    	str	x1, [sp, #0x10]
10182a148: 958ff3fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a14c: aa0003e2    	mov	x2, x0
10182a150: f00f3068    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182a154: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
10182a158: aa1a03e0    	mov	x0, x26
10182a15c: aa1803e1    	mov	x1, x24
10182a160: 958ff3f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a164: aa1d03fd    	mov	x29, x29
10182a168: 958ff3f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a16c: aa0003fb    	mov	x27, x0
10182a170: 900f32e8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10182a174: f9454d19    	ldr	x25, [x8, #0xa98] ; ftsReportMgr
10182a178: aa1903e1    	mov	x1, x25
10182a17c: 958ff3f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a180: aa1d03fd    	mov	x29, x29
10182a184: 958ff3f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a188: aa0003fc    	mov	x28, x0
10182a18c: f00f33e8    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10182a190: f9411101    	ldr	x1, [x8, #0x220] ; getExtInfo
10182a194: aa1503e0    	mov	x0, x21
10182a198: 958ff3e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a19c: aa1d03fd    	mov	x29, x29
10182a1a0: 958ff3ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a1a4: aa0003f6    	mov	x22, x0
10182a1a8: b00f3088    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10182a1ac: f943ad01    	ldr	x1, [x8, #0x758] ; JSONRepresentation
10182a1b0: 958ff3e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a1b4: aa1d03fd    	mov	x29, x29
10182a1b8: 958ff3e4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a1bc: aa0003f7    	mov	x23, x0
10182a1c0: f00f33e8    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10182a1c4: f9412901    	ldr	x1, [x8, #0x250] ; newCTREndSearch:force:
10182a1c8: aa1c03e0    	mov	x0, x28
10182a1cc: aa1703e2    	mov	x2, x23
10182a1d0: 52800003    	mov	w3, #0x0                ; =0
10182a1d4: 958ff3da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a1d8: aa1703e0    	mov	x0, x23
10182a1dc: 958ff3de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a1e0: aa1603e0    	mov	x0, x22
10182a1e4: 958ff3dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a1e8: aa1c03e0    	mov	x0, x28
10182a1ec: 958ff3da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a1f0: aa1b03e0    	mov	x0, x27
10182a1f4: 958ff3d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a1f8: aa1a03e0    	mov	x0, x26
10182a1fc: 958ff3d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a200: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a204: f9458d01    	ldr	x1, [x8, #0xb18] ; doFTSSearch:
10182a208: aa1503e0    	mov	x0, x21
10182a20c: aa1303e2    	mov	x2, x19
10182a210: 958ff3cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a214: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a218: f945e900    	ldr	x0, [x8, #0xbd0]
10182a21c: f9400fe1    	ldr	x1, [sp, #0x18]
10182a220: 958ff3c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a224: aa1d03fd    	mov	x29, x29
10182a228: 958ff3c8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a22c: aa0003f5    	mov	x21, x0
10182a230: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a234: f9477100    	ldr	x0, [x8, #0xee0]
10182a238: f9400be1    	ldr	x1, [sp, #0x10]
10182a23c: 958ff3c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a240: aa0003e2    	mov	x2, x0
10182a244: aa1503e0    	mov	x0, x21
10182a248: aa1803e1    	mov	x1, x24
10182a24c: 958ff3bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a250: aa1d03fd    	mov	x29, x29
10182a254: 958ff3bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a258: aa0003f6    	mov	x22, x0
10182a25c: aa1903e1    	mov	x1, x25
10182a260: 958ff3b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a264: aa1d03fd    	mov	x29, x29
10182a268: 958ff3b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a26c: aa0003f7    	mov	x23, x0
10182a270: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a274: f9459101    	ldr	x1, [x8, #0xb20] ; newCTRBeginSearch:isVoiceInput:
10182a278: aa1303e2    	mov	x2, x19
10182a27c: 52800003    	mov	w3, #0x0                ; =0
10182a280: 958ff3af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a284: aa1703e0    	mov	x0, x23
10182a288: 958ff3b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a28c: aa1603e0    	mov	x0, x22
10182a290: 958ff3b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a294: aa1503e0    	mov	x0, x21
10182a298: 958ff3af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a29c: 14000010    	b	0x10182a2dc <__text+0x18222dc>
10182a2a0: f9453720    	ldr	x0, [x25, #0xa68]
10182a2a4: f00e6b68    	adrp	x8, 0x11e599000 <dyld_stub_binder+0x11e599000>
10182a2a8: 9125a108    	add	x8, x8, #0x968
10182a2ac: a90053e8    	stp	x8, x20, [sp]
10182a2b0: d00cd243    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10182a2b4: 91388063    	add	x3, x3, #0xe20
10182a2b8: b00cde25    	adrp	x5, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182a2bc: 912160a5    	add	x5, x5, #0x858
10182a2c0: b00cde27    	adrp	x7, 0x11b3ef000 <dyld_stub_binder+0x11b3ef000>
10182a2c4: 913e5ce7    	add	x7, x7, #0xf97
10182a2c8: aa1603e1    	mov	x1, x22
10182a2cc: 52800042    	mov	w2, #0x2                ; =2
10182a2d0: 52800004    	mov	w4, #0x0                ; =0
10182a2d4: 5280b826    	mov	w6, #0x5c1              ; =1473
10182a2d8: 958ff399    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a2dc: aa1403e0    	mov	x0, x20
10182a2e0: 958ff39d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a2e4: aa1303e0    	mov	x0, x19
10182a2e8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10182a2ec: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10182a2f0: a94557f6    	ldp	x22, x21, [sp, #0x50]
10182a2f4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10182a2f8: a94367fa    	ldp	x26, x25, [sp, #0x30]
10182a2fc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10182a300: 910203ff    	add	sp, sp, #0x80
10182a304: 158ff394    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
