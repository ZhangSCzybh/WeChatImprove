
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e47fc0: d10543ff    	sub	sp, sp, #0x150
100e47fc4: a90f6ffc    	stp	x28, x27, [sp, #0xf0]
100e47fc8: a91067fa    	stp	x26, x25, [sp, #0x100]
100e47fcc: a9115ff8    	stp	x24, x23, [sp, #0x110]
100e47fd0: a91257f6    	stp	x22, x21, [sp, #0x120]
100e47fd4: a9134ff4    	stp	x20, x19, [sp, #0x130]
100e47fd8: a9147bfd    	stp	x29, x30, [sp, #0x140]
100e47fdc: 910503fd    	add	x29, sp, #0x140
100e47fe0: aa0203f3    	mov	x19, x2
100e47fe4: aa0003f4    	mov	x20, x0
100e47fe8: 900e3d48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100e47fec: f9405908    	ldr	x8, [x8, #0xb0]
100e47ff0: f9400108    	ldr	x8, [x8]
100e47ff4: f81a03a8    	stur	x8, [x29, #-0x60]
100e47ff8: b00fef48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e47ffc: 52800029    	mov	w9, #0x1                ; =1
100e48000: 39186509    	strb	w9, [x8, #0x619]
100e48004: aa0203e0    	mov	x0, x2
100e48008: 95b77c4c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4800c: 4f00e400    	movi.16b	v0, #0x0
100e48010: ad0203e0    	stp	q0, q0, [sp, #0x40]
100e48014: ad0103e0    	stp	q0, q0, [sp, #0x20]
100e48018: d00f95a8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
100e4801c: f947f501    	ldr	x1, [x8, #0xfe8] ; allKeys
100e48020: f9000bf3    	str	x19, [sp, #0x10]
100e48024: aa1303e0    	mov	x0, x19
100e48028: 95b77c45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4802c: aa1d03fd    	mov	x29, x29
100e48030: 95b77c46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48034: aa0003f5    	mov	x21, x0
100e48038: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4803c: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
100e48040: 910083e2    	add	x2, sp, #0x20
100e48044: 910183e3    	add	x3, sp, #0x60
100e48048: f90007e1    	str	x1, [sp, #0x8]
100e4804c: 52800204    	mov	w4, #0x10               ; =16
100e48050: 95b77c3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48054: b4000800    	cbz	x0, 0x100e48154 <__text+0xe40154>
100e48058: aa0003f7    	mov	x23, x0
100e4805c: f9401be8    	ldr	x8, [sp, #0x30]
100e48060: 52800036    	mov	w22, #0x1               ; =1
100e48064: 900f81c9    	adrp	x9, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48068: f9400113    	ldr	x19, [x8]
100e4806c: 900f95e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e48070: b00f7faa    	adrp	x10, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e48074: 900f81cb    	adrp	x11, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48078: f9000ff5    	str	x21, [sp, #0x18]
100e4807c: d2800015    	mov	x21, #0x0               ; =0
100e48080: f9436d38    	ldr	x24, [x9, #0x6d8] ; isContactInChatBox:
100e48084: f947f119    	ldr	x25, [x8, #0xfe0] ; objectForKey:
100e48088: f9478d5a    	ldr	x26, [x10, #0xf18] ; isSenderFromMsgWrap:
100e4808c: f943717b    	ldr	x27, [x11, #0x6e0] ; shouldShowNotifyForMessage:
100e48090: f9401be8    	ldr	x8, [sp, #0x30]
100e48094: f9400108    	ldr	x8, [x8]
100e48098: eb13011f    	cmp	x8, x19
100e4809c: 54000060    	b.eq	0x100e480a8 <__text+0xe400a8>
100e480a0: f9400fe0    	ldr	x0, [sp, #0x18]
100e480a4: 95b77c2b    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
100e480a8: f94017e8    	ldr	x8, [sp, #0x28]
100e480ac: f875791c    	ldr	x28, [x8, x21, lsl #3]
100e480b0: aa1403e0    	mov	x0, x20
100e480b4: aa1803e1    	mov	x1, x24
100e480b8: aa1c03e2    	mov	x2, x28
100e480bc: 95b77c20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e480c0: 340002a0    	cbz	w0, 0x100e48114 <__text+0xe40114>
100e480c4: f9400be0    	ldr	x0, [sp, #0x10]
100e480c8: aa1903e1    	mov	x1, x25
100e480cc: aa1c03e2    	mov	x2, x28
100e480d0: 95b77c1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e480d4: aa1d03fd    	mov	x29, x29
100e480d8: 95b77c1c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e480dc: aa0003fc    	mov	x28, x0
100e480e0: 900f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e480e4: f9411d00    	ldr	x0, [x8, #0x238] ; CMessageWrap
100e480e8: aa1a03e1    	mov	x1, x26
100e480ec: aa1c03e2    	mov	x2, x28
100e480f0: 95b77c13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e480f4: 0a160016    	and	w22, w0, w22
100e480f8: aa1403e0    	mov	x0, x20
100e480fc: aa1b03e1    	mov	x1, x27
100e48100: aa1c03e2    	mov	x2, x28
100e48104: 95b77c0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48108: 350002c0    	cbnz	w0, 0x100e48160 <__text+0xe40160>
100e4810c: aa1c03e0    	mov	x0, x28
100e48110: 95b77c11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48114: 910006b5    	add	x21, x21, #0x1
100e48118: eb1502ff    	cmp	x23, x21
100e4811c: 54fffba1    	b.ne	0x100e48090 <__text+0xe40090>
100e48120: 910083e2    	add	x2, sp, #0x20
100e48124: 910183e3    	add	x3, sp, #0x60
100e48128: f9400ff5    	ldr	x21, [sp, #0x18]
100e4812c: aa1503e0    	mov	x0, x21
100e48130: f94007e1    	ldr	x1, [sp, #0x8]
100e48134: 52800204    	mov	w4, #0x10               ; =16
100e48138: 95b77c01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4813c: aa0003f7    	mov	x23, x0
100e48140: 900f81c9    	adrp	x9, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48144: 900f95e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100e48148: b00f7faa    	adrp	x10, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100e4814c: 900f81cb    	adrp	x11, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48150: b5fff960    	cbnz	x0, 0x100e4807c <__text+0xe4007c>
100e48154: aa1503e0    	mov	x0, x21
100e48158: 95b77bff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4815c: 14000020    	b	0x100e481dc <__text+0xe401dc>
100e48160: 900f7fa8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e48164: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
100e48168: aa1c03e0    	mov	x0, x28
100e4816c: 95b77bf4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48170: aa0003f7    	mov	x23, x0
100e48174: aa1c03e0    	mov	x0, x28
100e48178: 95b77bf7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4817c: f9400fe0    	ldr	x0, [sp, #0x18]
100e48180: 95b77bf5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e48184: 37000236    	tbnz	w22, #0x0, 0x100e481c8 <__text+0xe401c8>
100e48188: 900f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e4818c: f9408500    	ldr	x0, [x8, #0x108] ; MemoryMappedKV
100e48190: b00f7fc8    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100e48194: f946fd01    	ldr	x1, [x8, #0xdf8] ; defaultMemoryMappedKV
100e48198: 95b77be9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4819c: aa1d03fd    	mov	x29, x29
100e481a0: 95b77bea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e481a4: aa0003f5    	mov	x21, x0
100e481a8: f00f95e8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
100e481ac: f9416101    	ldr	x1, [x8, #0x2c0] ; setBool:forKey:
100e481b0: d00eb743    	adrp	x3, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e481b4: 911f2063    	add	x3, x3, #0x7c8 ; CFString 'MMKV_CHATBOX_SESSION_IS_UNREAD'
100e481b8: 52800022    	mov	w2, #0x1                ; =1
100e481bc: 95b77be0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e481c0: aa1503e0    	mov	x0, x21
100e481c4: 95b77be4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e481c8: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e481cc: f9437501    	ldr	x1, [x8, #0x6e8] ; updateChatBoxSessionWithSortTime:
100e481d0: aa1403e0    	mov	x0, x20
100e481d4: aa1703e2    	mov	x2, x23
100e481d8: 95b77bd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e481dc: f9400be0    	ldr	x0, [sp, #0x10]
100e481e0: 95b77bdd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e481e4: f85a03a8    	ldur	x8, [x29, #-0x60]
100e481e8: f00e3d29    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100e481ec: f9405929    	ldr	x9, [x9, #0xb0]
100e481f0: f9400129    	ldr	x9, [x9]
100e481f4: eb08013f    	cmp	x9, x8
100e481f8: 54000121    	b.ne	0x100e4821c <__text+0xe4021c>
100e481fc: a9547bfd    	ldp	x29, x30, [sp, #0x140]
100e48200: a9534ff4    	ldp	x20, x19, [sp, #0x130]
100e48204: a95257f6    	ldp	x22, x21, [sp, #0x120]
100e48208: a9515ff8    	ldp	x24, x23, [sp, #0x110]
100e4820c: a95067fa    	ldp	x26, x25, [sp, #0x100]
100e48210: a94f6ffc    	ldp	x28, x27, [sp, #0xf0]
100e48214: 910543ff    	add	sp, sp, #0x150
100e48218: d65f03c0    	ret
100e4821c: 95b77bd6    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
