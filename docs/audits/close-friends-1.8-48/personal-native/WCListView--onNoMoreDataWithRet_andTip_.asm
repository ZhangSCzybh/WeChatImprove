
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10900e128: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10900e12c: a9014ff4    	stp	x20, x19, [sp, #0x10]
10900e130: a9027bfd    	stp	x29, x30, [sp, #0x20]
10900e134: 910083fd    	add	x29, sp, #0x20
10900e138: aa0303f3    	mov	x19, x3
10900e13c: aa0203f5    	mov	x21, x2
10900e140: aa0003f4    	mov	x20, x0
10900e144: f00be1e8    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
10900e148: 52800029    	mov	w9, #0x1                ; =1
10900e14c: 393af509    	strb	w9, [x8, #0xebd]
10900e150: aa0303e0    	mov	x0, x3
10900e154: 95a134bb    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10900e158: f10006bf    	cmp	x21, #0x1
10900e15c: 54000241    	b.ne	0x10900e1a4 <_Flutter_MMFoundation_BindContext+0x54e9d88>
10900e160: d00b92a8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10900e164: b9859d08    	ldrsw	x8, [x8, #0x59c]
10900e168: 38686a88    	ldrb	w8, [x20, x8]
10900e16c: 7100051f    	cmp	w8, #0x1
10900e170: 54000101    	b.ne	0x10900e190 <_Flutter_MMFoundation_BindContext+0x54e9d74>
10900e174: d00b92a8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10900e178: b985a108    	ldrsw	x8, [x8, #0x5a0]
10900e17c: f8686a80    	ldr	x0, [x20, x8]
10900e180: d00b8788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10900e184: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10900e188: 95a134af    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10900e18c: b40003c0    	cbz	x0, 0x10900e204 <_Flutter_MMFoundation_BindContext+0x54e9de8>
10900e190: 52800002    	mov	w2, #0x0                ; =0
10900e194: b00b82c8    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10900e198: f940f901    	ldr	x1, [x8, #0x1f0] ; showNoContentTips:
10900e19c: aa1403e0    	mov	x0, x20
10900e1a0: 95a134a9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10900e1a4: d00b92a8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10900e1a8: b9859108    	ldrsw	x8, [x8, #0x590]
10900e1ac: f8686a80    	ldr	x0, [x20, x8]
10900e1b0: d00b7268    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10900e1b4: f9472901    	ldr	x1, [x8, #0xe50] ; onStateOfNoMoreData:
10900e1b8: aa1303e2    	mov	x2, x19
10900e1bc: 95a134a2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10900e1c0: b00b82c8    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10900e1c4: f9410101    	ldr	x1, [x8, #0x200] ; multipleImageViewController
10900e1c8: aa1403e0    	mov	x0, x20
10900e1cc: 95a1349e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10900e1d0: aa1d03fd    	mov	x29, x29
10900e1d4: 95a1349f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10900e1d8: aa0003f4    	mov	x20, x0
10900e1dc: 900b7e48    	adrp	x8, 0x11ffd6000 <dyld_stub_binder+0x11ffd6000>
10900e1e0: f946d501    	ldr	x1, [x8, #0xda8] ; noMoreData
10900e1e4: 95a13498    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10900e1e8: aa1403e0    	mov	x0, x20
10900e1ec: 95a1349c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10900e1f0: aa1303e0    	mov	x0, x19
10900e1f4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10900e1f8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10900e1fc: a8c357f6    	ldp	x22, x21, [sp], #0x30
10900e200: 15a13497    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10900e204: 52800022    	mov	w2, #0x1                ; =1
10900e208: 17ffffe3    	b	0x10900e194 <_Flutter_MMFoundation_BindContext+0x54e9d78>
