
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106eb2ef4: d101c3ff    	sub	sp, sp, #0x70
106eb2ef8: a9016ffc    	stp	x28, x27, [sp, #0x10]
106eb2efc: a90267fa    	stp	x26, x25, [sp, #0x20]
106eb2f00: a9035ff8    	stp	x24, x23, [sp, #0x30]
106eb2f04: a90457f6    	stp	x22, x21, [sp, #0x40]
106eb2f08: a9054ff4    	stp	x20, x19, [sp, #0x50]
106eb2f0c: a9067bfd    	stp	x29, x30, [sp, #0x60]
106eb2f10: 910183fd    	add	x29, sp, #0x60
106eb2f14: aa0303f6    	mov	x22, x3
106eb2f18: aa0203f3    	mov	x19, x2
106eb2f1c: aa0003f4    	mov	x20, x0
106eb2f20: 900ceca8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106eb2f24: 52800029    	mov	w9, #0x1                ; =1
106eb2f28: 391d1109    	strb	w9, [x8, #0x744]
106eb2f2c: aa0203e0    	mov	x0, x2
106eb2f30: 9435d082    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106eb2f34: f00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb2f38: b9847d08    	ldrsw	x8, [x8, #0x47c]
106eb2f3c: 38286a9f    	strb	wzr, [x20, x8]
106eb2f40: b10006df    	cmn	x22, #0x1
106eb2f44: 540025c0    	b.eq	0x106eb33fc <_Flutter_MMFoundation_BindContext+0x338efe0>
106eb2f48: b00c7c48    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106eb2f4c: f9475d15    	ldr	x21, [x8, #0xeb8] ; cancelButtonIndex
106eb2f50: aa1303e0    	mov	x0, x19
106eb2f54: aa1503e1    	mov	x1, x21
106eb2f58: 9435d079    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2f5c: eb16001f    	cmp	x0, x22
106eb2f60: 54000c21    	b.ne	0x106eb30e4 <_Flutter_MMFoundation_BindContext+0x338ecc8>
106eb2f64: aa1303e0    	mov	x0, x19
106eb2f68: aa1503e1    	mov	x1, x21
106eb2f6c: 9435d074    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2f70: eb16001f    	cmp	x0, x22
106eb2f74: 54002441    	b.ne	0x106eb33fc <_Flutter_MMFoundation_BindContext+0x338efe0>
106eb2f78: b00c92c8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106eb2f7c: f9457515    	ldr	x21, [x8, #0xae8] ; userInfo
106eb2f80: aa1303e0    	mov	x0, x19
106eb2f84: aa1503e1    	mov	x1, x21
106eb2f88: 9435d06d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2f8c: aa1d03fd    	mov	x29, x29
106eb2f90: 9435d06e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb2f94: aa0003f6    	mov	x22, x0
106eb2f98: 9435d06f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb2f9c: b4002316    	cbz	x22, 0x106eb33fc <_Flutter_MMFoundation_BindContext+0x338efe0>
106eb2fa0: aa1303e0    	mov	x0, x19
106eb2fa4: aa1503e1    	mov	x1, x21
106eb2fa8: 9435d065    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2fac: aa1d03fd    	mov	x29, x29
106eb2fb0: 9435d066    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb2fb4: aa0003fa    	mov	x26, x0
106eb2fb8: b00c9608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106eb2fbc: f9454500    	ldr	x0, [x8, #0xa88]
106eb2fc0: b00c9268    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106eb2fc4: f947ad16    	ldr	x22, [x8, #0xf58] ; class
106eb2fc8: aa1603e1    	mov	x1, x22
106eb2fcc: 9435d05c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2fd0: aa0003e2    	mov	x2, x0
106eb2fd4: b00c9288    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106eb2fd8: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
106eb2fdc: aa1a03e0    	mov	x0, x26
106eb2fe0: 9435d057    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2fe4: 34002080    	cbz	w0, 0x106eb33f4 <_Flutter_MMFoundation_BindContext+0x338efd8>
106eb2fe8: b00c9608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106eb2fec: f945e900    	ldr	x0, [x8, #0xbd0]
106eb2ff0: d00c9268    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106eb2ff4: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106eb2ff8: 9435d051    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb2ffc: aa1d03fd    	mov	x29, x29
106eb3000: 9435d052    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3004: aa0003f5    	mov	x21, x0
106eb3008: 900c9608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106eb300c: f9462900    	ldr	x0, [x8, #0xc50]
106eb3010: aa1603e1    	mov	x1, x22
106eb3014: 9435d04a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3018: aa0003e2    	mov	x2, x0
106eb301c: d00c7c28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106eb3020: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106eb3024: aa1503e0    	mov	x0, x21
106eb3028: 9435d045    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb302c: aa1d03fd    	mov	x29, x29
106eb3030: 9435d046    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3034: aa0003f6    	mov	x22, x0
106eb3038: d00c7c28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106eb303c: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
106eb3040: b00bd1c2    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106eb3044: 91352042    	add	x2, x2, #0xd48
106eb3048: 9435d03d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb304c: aa1d03fd    	mov	x29, x29
106eb3050: 9435d03e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3054: aa0003f7    	mov	x23, x0
106eb3058: 900c9288    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106eb305c: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
106eb3060: aa1a03e0    	mov	x0, x26
106eb3064: aa1703e2    	mov	x2, x23
106eb3068: 9435d035    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb306c: aa0003f8    	mov	x24, x0
106eb3070: aa1703e0    	mov	x0, x23
106eb3074: 9435d038    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb3078: aa1603e0    	mov	x0, x22
106eb307c: 9435d036    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb3080: aa1503e0    	mov	x0, x21
106eb3084: 9435d034    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb3088: 34001b78    	cbz	w24, 0x106eb33f4 <_Flutter_MMFoundation_BindContext+0x338efd8>
106eb308c: f00c92a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106eb3090: f947c101    	ldr	x1, [x8, #0xf80] ; tag
106eb3094: aa1303e0    	mov	x0, x19
106eb3098: 9435d029    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb309c: aa0003f6    	mov	x22, x0
106eb30a0: d00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb30a4: b984c115    	ldrsw	x21, [x8, #0x4c0]
106eb30a8: f8756a80    	ldr	x0, [x20, x21]
106eb30ac: b00c9268    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106eb30b0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
106eb30b4: 9435d022    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb30b8: eb0002df    	cmp	x22, x0
106eb30bc: 54001822    	b.hs	0x106eb33c0 <_Flutter_MMFoundation_BindContext+0x338efa4>
106eb30c0: f8756a80    	ldr	x0, [x20, x21]
106eb30c4: f00c7c28    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106eb30c8: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
106eb30cc: aa1603e2    	mov	x2, x22
106eb30d0: 9435d01b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb30d4: aa1d03fd    	mov	x29, x29
106eb30d8: 9435d01c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb30dc: aa0003f6    	mov	x22, x0
106eb30e0: 140000b9    	b	0x106eb33c4 <_Flutter_MMFoundation_BindContext+0x338efa8>
106eb30e4: f00c92a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106eb30e8: f947c101    	ldr	x1, [x8, #0xf80] ; tag
106eb30ec: aa1303e0    	mov	x0, x19
106eb30f0: 9435d013    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb30f4: aa0003f5    	mov	x21, x0
106eb30f8: d00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb30fc: b984c117    	ldrsw	x23, [x8, #0x4c0]
106eb3100: f8776a80    	ldr	x0, [x20, x23]
106eb3104: b00c9268    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106eb3108: f9435101    	ldr	x1, [x8, #0x6a0] ; count
106eb310c: 9435d00c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3110: eb0002bf    	cmp	x21, x0
106eb3114: 54001742    	b.hs	0x106eb33fc <_Flutter_MMFoundation_BindContext+0x338efe0>
106eb3118: f8776a80    	ldr	x0, [x20, x23]
106eb311c: f00c7c28    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106eb3120: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
106eb3124: aa1503e2    	mov	x2, x21
106eb3128: 9435d005    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb312c: aa1d03fd    	mov	x29, x29
106eb3130: 9435d006    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3134: f90007e0    	str	x0, [sp, #0x8]
106eb3138: 900c7c68    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106eb313c: f941e101    	ldr	x1, [x8, #0x3c0] ; buttonTitleAtIndex:
106eb3140: aa1303e0    	mov	x0, x19
106eb3144: aa1603e2    	mov	x2, x22
106eb3148: 9435cffd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb314c: aa1d03fd    	mov	x29, x29
106eb3150: 9435cffe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3154: aa0003f9    	mov	x25, x0
106eb3158: 900c9608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106eb315c: f945e900    	ldr	x0, [x8, #0xbd0]
106eb3160: b00c9268    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106eb3164: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
106eb3168: aa1603e1    	mov	x1, x22
106eb316c: 9435cff4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3170: aa1d03fd    	mov	x29, x29
106eb3174: 9435cff5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3178: aa0003fa    	mov	x26, x0
106eb317c: 900c9608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106eb3180: f9462900    	ldr	x0, [x8, #0xc50]
106eb3184: 900c9268    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106eb3188: f947ad17    	ldr	x23, [x8, #0xf58] ; class
106eb318c: aa1703e1    	mov	x1, x23
106eb3190: 9435cfeb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3194: aa0003e2    	mov	x2, x0
106eb3198: d00c7c28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106eb319c: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
106eb31a0: aa1a03e0    	mov	x0, x26
106eb31a4: aa1803e1    	mov	x1, x24
106eb31a8: 9435cfe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb31ac: aa1d03fd    	mov	x29, x29
106eb31b0: 9435cfe6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb31b4: aa0003fb    	mov	x27, x0
106eb31b8: d00c7c28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106eb31bc: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
106eb31c0: d00bafa2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
106eb31c4: 91042042    	add	x2, x2, #0x108
106eb31c8: 9435cfdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb31cc: aa1d03fd    	mov	x29, x29
106eb31d0: 9435cfde    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb31d4: aa0003fc    	mov	x28, x0
106eb31d8: 900c9288    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106eb31dc: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
106eb31e0: aa1903e0    	mov	x0, x25
106eb31e4: aa1c03e2    	mov	x2, x28
106eb31e8: 9435cfd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb31ec: aa0003f5    	mov	x21, x0
106eb31f0: aa1c03e0    	mov	x0, x28
106eb31f4: 9435cfd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb31f8: aa1b03e0    	mov	x0, x27
106eb31fc: 9435cfd6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb3200: aa1a03e0    	mov	x0, x26
106eb3204: 9435cfd4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb3208: aa1903e0    	mov	x0, x25
106eb320c: 9435cfd2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb3210: 34000895    	cbz	w21, 0x106eb3320 <_Flutter_MMFoundation_BindContext+0x338ef04>
106eb3214: d00c9748    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106eb3218: f943ad00    	ldr	x0, [x8, #0x758]
106eb321c: d00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb3220: b9844d19    	ldrsw	x25, [x8, #0x44c]
106eb3224: f8796a83    	ldr	x3, [x20, x25]
106eb3228: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb322c: f9449d01    	ldr	x1, [x8, #0x938] ; reportDeleteComment:with:confirm:
106eb3230: f94007fa    	ldr	x26, [sp, #0x8]
106eb3234: aa1a03e2    	mov	x2, x26
106eb3238: 52800024    	mov	w4, #0x1                ; =1
106eb323c: 9435cfc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3240: 900c9608    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106eb3244: f945e900    	ldr	x0, [x8, #0xbd0]
106eb3248: aa1603e1    	mov	x1, x22
106eb324c: 9435cfbc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3250: aa1d03fd    	mov	x29, x29
106eb3254: 9435cfbd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3258: aa0003f5    	mov	x21, x0
106eb325c: b00c9608    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106eb3260: f9428500    	ldr	x0, [x8, #0x508]
106eb3264: aa1703e1    	mov	x1, x23
106eb3268: 9435cfb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb326c: aa0003e2    	mov	x2, x0
106eb3270: aa1503e0    	mov	x0, x21
106eb3274: aa1803e1    	mov	x1, x24
106eb3278: 9435cfb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb327c: aa1d03fd    	mov	x29, x29
106eb3280: 9435cfb2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb3284: aa0003f6    	mov	x22, x0
106eb3288: f8796a82    	ldr	x2, [x20, x25]
106eb328c: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb3290: f944a101    	ldr	x1, [x8, #0x940] ; deleteCommentWithDataItem:comment:
106eb3294: aa1a03e3    	mov	x3, x26
106eb3298: 9435cfa9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb329c: aa0003f7    	mov	x23, x0
106eb32a0: aa1603e0    	mov	x0, x22
106eb32a4: 9435cfac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb32a8: aa1503e0    	mov	x0, x21
106eb32ac: 9435cfaa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb32b0: d00c8a48    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106eb32b4: f9468d01    	ldr	x1, [x8, #0xd18] ; albumFeedBehaviourSession
106eb32b8: aa1403e0    	mov	x0, x20
106eb32bc: 9435cfa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb32c0: aa1d03fd    	mov	x29, x29
106eb32c4: 9435cfa1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106eb32c8: aa0003f5    	mov	x21, x0
106eb32cc: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb32d0: f944a501    	ldr	x1, [x8, #0x948] ; recordCommentFlag:
106eb32d4: 52800082    	mov	w2, #0x4                ; =4
106eb32d8: 9435cf99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb32dc: aa1503e0    	mov	x0, x21
106eb32e0: 9435cf9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb32e4: d00c9635    	adrp	x21, 0x120179000 <dyld_stub_binder+0x120179000>
106eb32e8: f9455ea0    	ldr	x0, [x21, #0xab8]
106eb32ec: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb32f0: f9447101    	ldr	x1, [x8, #0x8e0] ; Deletion_startLoadingInViewController:
106eb32f4: aa1403e2    	mov	x2, x20
106eb32f8: 9435cf91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb32fc: 370007d7    	tbnz	w23, #0x0, 0x106eb33f4 <_Flutter_MMFoundation_BindContext+0x338efd8>
106eb3300: f9455ea0    	ldr	x0, [x21, #0xab8]
106eb3304: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb3308: f944a901    	ldr	x1, [x8, #0x950] ; Deletion_stopLoadingInViewController:withResult:delay:
106eb330c: 1e6c1000    	fmov	d0, #0.50000000
106eb3310: aa1403e2    	mov	x2, x20
106eb3314: 92800003    	mov	x3, #-0x1               ; =-1
106eb3318: 9435cf89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb331c: 14000036    	b	0x106eb33f4 <_Flutter_MMFoundation_BindContext+0x338efd8>
106eb3320: f94007fa    	ldr	x26, [sp, #0x8]
106eb3324: d00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb3328: b985c515    	ldrsw	x21, [x8, #0x5c4]
106eb332c: f8756a88    	ldr	x8, [x20, x21]
106eb3330: d00c9c98    	adrp	x24, 0x120245000 <dyld_stub_binder+0x120245000>
106eb3334: d00c92b7    	adrp	x23, 0x120109000 <dyld_stub_binder+0x120109000>
106eb3338: f00c8a56    	adrp	x22, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb333c: b4000148    	cbz	x8, 0x106eb3364 <_Flutter_MMFoundation_BindContext+0x338ef48>
106eb3340: b985b308    	ldrsw	x8, [x24, #0x5b0]
106eb3344: f8686a80    	ldr	x0, [x20, x8]
106eb3348: f9468ee1    	ldr	x1, [x23, #0xd18] ; setText:
106eb334c: 900baf42    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106eb3350: 91032042    	add	x2, x2, #0xc8
106eb3354: 9435cf7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3358: f946c2c1    	ldr	x1, [x22, #0xd80] ; clearExtBean
106eb335c: aa1403e0    	mov	x0, x20
106eb3360: 9435cf77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3364: d00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb3368: b986d108    	ldrsw	x8, [x8, #0x6d0]
106eb336c: f8686a80    	ldr	x0, [x20, x8]
106eb3370: b4000180    	cbz	x0, 0x106eb33a0 <_Flutter_MMFoundation_BindContext+0x338ef84>
106eb3374: f8286a9f    	str	xzr, [x20, x8]
106eb3378: 9435cf77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb337c: b985b308    	ldrsw	x8, [x24, #0x5b0]
106eb3380: f8686a80    	ldr	x0, [x20, x8]
106eb3384: f9468ee1    	ldr	x1, [x23, #0xd18] ; setText:
106eb3388: 900baf42    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106eb338c: 91032042    	add	x2, x2, #0xc8
106eb3390: 9435cf6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb3394: f946c2c1    	ldr	x1, [x22, #0xd80] ; clearExtBean
106eb3398: aa1403e0    	mov	x0, x20
106eb339c: 9435cf68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb33a0: 8b150280    	add	x0, x20, x21
106eb33a4: aa1a03e1    	mov	x1, x26
106eb33a8: 9435cf66    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
106eb33ac: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb33b0: f9448901    	ldr	x1, [x8, #0x910] ; becomeInput
106eb33b4: aa1403e0    	mov	x0, x20
106eb33b8: 9435cf61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb33bc: 1400000e    	b	0x106eb33f4 <_Flutter_MMFoundation_BindContext+0x338efd8>
106eb33c0: d2800016    	mov	x22, #0x0               ; =0
106eb33c4: d00c9748    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106eb33c8: f943ad00    	ldr	x0, [x8, #0x758]
106eb33cc: d00c9c88    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106eb33d0: b9844d08    	ldrsw	x8, [x8, #0x44c]
106eb33d4: f8686a83    	ldr	x3, [x20, x8]
106eb33d8: f00c8a48    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106eb33dc: f9449d01    	ldr	x1, [x8, #0x938] ; reportDeleteComment:with:confirm:
106eb33e0: aa1603e2    	mov	x2, x22
106eb33e4: 52800004    	mov	w4, #0x0                ; =0
106eb33e8: 9435cf55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106eb33ec: aa1603e0    	mov	x0, x22
106eb33f0: 9435cf59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb33f4: aa1a03e0    	mov	x0, x26
106eb33f8: 9435cf57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106eb33fc: aa1303e0    	mov	x0, x19
106eb3400: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106eb3404: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106eb3408: a94457f6    	ldp	x22, x21, [sp, #0x40]
106eb340c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106eb3410: a94267fa    	ldp	x26, x25, [sp, #0x20]
106eb3414: a9416ffc    	ldp	x28, x27, [sp, #0x10]
106eb3418: 9101c3ff    	add	sp, sp, #0x70
106eb341c: 1435cf4e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
