
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe7290: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
108fe7294: a9017bfd    	stp	x29, x30, [sp, #0x10]
108fe7298: 910043fd    	add	x29, sp, #0x10
108fe729c: aa0003f3    	mov	x19, x0
108fe72a0: d00be328    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe72a4: 52800029    	mov	w9, #0x1                ; =1
108fe72a8: 3938a509    	strb	w9, [x8, #0xe29]
108fe72ac: b00b93e8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108fe72b0: b9847d08    	ldrsw	x8, [x8, #0x47c]
108fe72b4: f8686802    	ldr	x2, [x0, x8]
108fe72b8: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe72bc: f9473d01    	ldr	x1, [x8, #0xe78] ; generateStatusInfoWithDataItem:
108fe72c0: 95a1d061    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe72c4: aa1d03fd    	mov	x29, x29
108fe72c8: 95a1d062    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe72cc: aa0003f4    	mov	x20, x0
108fe72d0: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe72d4: f946f501    	ldr	x1, [x8, #0xde8] ; showsPrivateStatus
108fe72d8: 95a1d05b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe72dc: 340000a0    	cbz	w0, 0x108fe72f0 <_Flutter_MMFoundation_BindContext+0x54c2ed4>
108fe72e0: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe72e4: f9474101    	ldr	x1, [x8, #0xe80] ; initLockedImageView
108fe72e8: aa1303e0    	mov	x0, x19
108fe72ec: 95a1d056    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe72f0: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe72f4: f946f901    	ldr	x1, [x8, #0xdf0] ; showsGroupedStatus
108fe72f8: aa1403e0    	mov	x0, x20
108fe72fc: 95a1d052    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7300: 340000a0    	cbz	w0, 0x108fe7314 <_Flutter_MMFoundation_BindContext+0x54c2ef8>
108fe7304: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe7308: f9474501    	ldr	x1, [x8, #0xe88] ; initSharedImageView
108fe730c: aa1303e0    	mov	x0, x19
108fe7310: 95a1d04d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7314: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe7318: f946f101    	ldr	x1, [x8, #0xde0] ; showsStarredStatus
108fe731c: aa1403e0    	mov	x0, x20
108fe7320: 95a1d049    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7324: 340000a0    	cbz	w0, 0x108fe7338 <_Flutter_MMFoundation_BindContext+0x54c2f1c>
108fe7328: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe732c: f9474901    	ldr	x1, [x8, #0xe90] ; initStarredImageView
108fe7330: aa1303e0    	mov	x0, x19
108fe7334: 95a1d044    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7338: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe733c: f946fd01    	ldr	x1, [x8, #0xdf8] ; showsFailureStatus
108fe7340: aa1403e0    	mov	x0, x20
108fe7344: 95a1d040    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe7348: 340000a0    	cbz	w0, 0x108fe735c <_Flutter_MMFoundation_BindContext+0x54c2f40>
108fe734c: f00b83e8    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe7350: f9474d01    	ldr	x1, [x8, #0xe98] ; initFailImageView
108fe7354: aa1303e0    	mov	x0, x19
108fe7358: 95a1d03b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe735c: aa1403e0    	mov	x0, x20
108fe7360: a9417bfd    	ldp	x29, x30, [sp, #0x10]
108fe7364: a8c24ff4    	ldp	x20, x19, [sp], #0x20
108fe7368: 15a1d03d    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
