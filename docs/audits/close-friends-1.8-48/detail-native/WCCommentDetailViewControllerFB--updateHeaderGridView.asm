
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e8bf80: d107c3ff    	sub	sp, sp, #0x1f0
106e8bf84: 6d1823e9    	stp	d9, d8, [sp, #0x180]
106e8bf88: a9196ffc    	stp	x28, x27, [sp, #0x190]
106e8bf8c: a91a67fa    	stp	x26, x25, [sp, #0x1a0]
106e8bf90: a91b5ff8    	stp	x24, x23, [sp, #0x1b0]
106e8bf94: a91c57f6    	stp	x22, x21, [sp, #0x1c0]
106e8bf98: a91d4ff4    	stp	x20, x19, [sp, #0x1d0]
106e8bf9c: a91e7bfd    	stp	x29, x30, [sp, #0x1e0]
106e8bfa0: 910783fd    	add	x29, sp, #0x1e0
106e8bfa4: 900b3b28    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106e8bfa8: f9405908    	ldr	x8, [x8, #0xb0]
106e8bfac: f9400108    	ldr	x8, [x8]
106e8bfb0: f81903a8    	stur	x8, [x29, #-0x70]
106e8bfb4: f00cedc8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e8bfb8: 52800029    	mov	w9, #0x1                ; =1
106e8bfbc: 391aa909    	strb	w9, [x8, #0x6aa]
106e8bfc0: d00c9dc8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e8bfc4: b9845d08    	ldrsw	x8, [x8, #0x45c]
106e8bfc8: 38686808    	ldrb	w8, [x0, x8]
106e8bfcc: 37005c28    	tbnz	w8, #0x0, 0x106e8cb50 <_Flutter_MMFoundation_BindContext+0x3368734>
106e8bfd0: aa0003f3    	mov	x19, x0
106e8bfd4: d00c9dc8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e8bfd8: b985bd19    	ldrsw	x25, [x8, #0x5bc]
106e8bfdc: f8796800    	ldr	x0, [x0, x25]
106e8bfe0: f8396a7f    	str	xzr, [x19, x25]
106e8bfe4: 94366c5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8bfe8: d00c9dc8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e8bfec: b984c51c    	ldrsw	x28, [x8, #0x4c4]
106e8bff0: f87c6a60    	ldr	x0, [x19, x28]
106e8bff4: b00c93a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e8bff8: f943511a    	ldr	x26, [x8, #0x6a0] ; count
106e8bffc: aa1a03e1    	mov	x1, x26
106e8c000: 94366c4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c004: b4005a60    	cbz	x0, 0x106e8cb50 <_Flutter_MMFoundation_BindContext+0x3368734>
106e8c008: b00c9dc8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e8c00c: b9844d18    	ldrsw	x24, [x8, #0x44c]
106e8c010: f8786a60    	ldr	x0, [x19, x24]
106e8c014: 900c7e88    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
106e8c018: f9439d01    	ldr	x1, [x8, #0x738] ; contentObj
106e8c01c: 94366c48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c020: aa1d03fd    	mov	x29, x29
106e8c024: 94366c49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c028: aa0003f4    	mov	x20, x0
106e8c02c: f00c93e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e8c030: f941c901    	ldr	x1, [x8, #0x390] ; type
106e8c034: 94366c42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c038: aa0003fb    	mov	x27, x0
106e8c03c: aa1403e0    	mov	x0, x20
106e8c040: 94366c45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c044: f8786a60    	ldr	x0, [x19, x24]
106e8c048: d00c8148    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
106e8c04c: f9403d17    	ldr	x23, [x8, #0x78] ; advertiseInfo
106e8c050: aa1703e1    	mov	x1, x23
106e8c054: 94366c3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c058: aa1d03fd    	mov	x29, x29
106e8c05c: 94366c3b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c060: aa0003f4    	mov	x20, x0
106e8c064: b00c8ae8    	adrp	x8, 0x11ffe9000 <dyld_stub_binder+0x11ffe9000>
106e8c068: f9429901    	ldr	x1, [x8, #0x530] ; isSocialLikeAd
106e8c06c: 94366c34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c070: aa0003f5    	mov	x21, x0
106e8c074: aa1403e0    	mov	x0, x20
106e8c078: 94366c37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c07c: f9002ffa    	str	x26, [sp, #0x58]
106e8c080: b90057fb    	str	w27, [sp, #0x54]
106e8c084: 34000555    	cbz	w21, 0x106e8c12c <_Flutter_MMFoundation_BindContext+0x3367d10>
106e8c088: f8786a60    	ldr	x0, [x19, x24]
106e8c08c: aa1703e1    	mov	x1, x23
106e8c090: 94366c2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c094: aa1d03fd    	mov	x29, x29
106e8c098: 94366c2c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c09c: aa0003f4    	mov	x20, x0
106e8c0a0: b00c8ae8    	adrp	x8, 0x11ffe9000 <dyld_stub_binder+0x11ffe9000>
106e8c0a4: f9431901    	ldr	x1, [x8, #0x630] ; isFireworkCheerAd
106e8c0a8: 94366c25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c0ac: aa0003f5    	mov	x21, x0
106e8c0b0: aa1403e0    	mov	x0, x20
106e8c0b4: 94366c28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c0b8: f8786a60    	ldr	x0, [x19, x24]
106e8c0bc: f90027f8    	str	x24, [sp, #0x48]
106e8c0c0: 340003b5    	cbz	w21, 0x106e8c134 <_Flutter_MMFoundation_BindContext+0x3367d18>
106e8c0c4: d00c8448    	adrp	x8, 0x11ff16000 <dyld_stub_binder+0x11ff16000>
106e8c0c8: f9403901    	ldr	x1, [x8, #0x70] ; likeFlag
106e8c0cc: 94366c1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c0d0: aa0003f5    	mov	x21, x0
106e8c0d4: f8786a60    	ldr	x0, [x19, x24]
106e8c0d8: aa1703e1    	mov	x1, x23
106e8c0dc: 94366c18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c0e0: aa1d03fd    	mov	x29, x29
106e8c0e4: 94366c19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c0e8: aa0003f4    	mov	x20, x0
106e8c0ec: 900c8ae8    	adrp	x8, 0x11ffe8000 <dyld_stub_binder+0x11ffe8000>
106e8c0f0: f9478101    	ldr	x1, [x8, #0xf00] ; adSocialLikeInfo
106e8c0f4: 94366c12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c0f8: aa1d03fd    	mov	x29, x29
106e8c0fc: 94366c13    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c100: aa0003f6    	mov	x22, x0
106e8c104: b00c8ae8    	adrp	x8, 0x11ffe9000 <dyld_stub_binder+0x11ffe9000>
106e8c108: f942a101    	ldr	x1, [x8, #0x540] ; fireworkCheerInfo
106e8c10c: 94366c0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c110: aa1d03fd    	mov	x29, x29
106e8c114: 94366c0d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c118: aa0003f8    	mov	x24, x0
106e8c11c: 34000315    	cbz	w21, 0x106e8c17c <_Flutter_MMFoundation_BindContext+0x3367d60>
106e8c120: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8c124: f9439901    	ldr	x1, [x8, #0x730] ; fetchFireworkLikedIconEscapingForXML
106e8c128: 14000017    	b	0x106e8c184 <_Flutter_MMFoundation_BindContext+0x3367d68>
106e8c12c: d280001b    	mov	x27, #0x0               ; =0
106e8c130: 14000042    	b	0x106e8c238 <_Flutter_MMFoundation_BindContext+0x3367e1c>
106e8c134: aa1703e1    	mov	x1, x23
106e8c138: 94366c01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c13c: aa1d03fd    	mov	x29, x29
106e8c140: 94366c02    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c144: aa0003f4    	mov	x20, x0
106e8c148: 900c8ae8    	adrp	x8, 0x11ffe8000 <dyld_stub_binder+0x11ffe8000>
106e8c14c: f9478101    	ldr	x1, [x8, #0xf00] ; adSocialLikeInfo
106e8c150: 94366bfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c154: aa1d03fd    	mov	x29, x29
106e8c158: 94366bfc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c15c: aa0003f6    	mov	x22, x0
106e8c160: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8c164: f943a101    	ldr	x1, [x8, #0x740] ; fetchCheerIconEscapingForXML
106e8c168: 94366bf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c16c: aa1d03fd    	mov	x29, x29
106e8c170: 94366bf6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c174: aa0003f5    	mov	x21, x0
106e8c178: 1400000a    	b	0x106e8c1a0 <_Flutter_MMFoundation_BindContext+0x3367d84>
106e8c17c: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8c180: f9439d01    	ldr	x1, [x8, #0x738] ; fetchFireworkNormalIconEscapingForXML
106e8c184: aa1803e0    	mov	x0, x24
106e8c188: 94366bed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c18c: aa1d03fd    	mov	x29, x29
106e8c190: 94366bee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c194: aa0003f5    	mov	x21, x0
106e8c198: aa1803e0    	mov	x0, x24
106e8c19c: 94366bee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c1a0: aa1603e0    	mov	x0, x22
106e8c1a4: 94366bec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c1a8: aa1403e0    	mov	x0, x20
106e8c1ac: 94366bea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c1b0: f00c9728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c1b4: f9454514    	ldr	x20, [x8, #0xa88]
106e8c1b8: f00c9738    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c1bc: f9461b00    	ldr	x0, [x24, #0xc30]
106e8c1c0: f00c8288    	adrp	x8, 0x11fedf000 <dyld_stub_binder+0x11fedf000>
106e8c1c4: f944cd16    	ldr	x22, [x8, #0x998] ; dynamicLength:forModule:
106e8c1c8: 1e661000    	fmov	d0, #16.00000000
106e8c1cc: aa1603e1    	mov	x1, x22
106e8c1d0: 52800022    	mov	w2, #0x1                ; =1
106e8c1d4: 94366bda    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c1d8: 1e604008    	fmov	d8, d0
106e8c1dc: f9461b00    	ldr	x0, [x24, #0xc30]
106e8c1e0: 1e661000    	fmov	d0, #16.00000000
106e8c1e4: aa1603e1    	mov	x1, x22
106e8c1e8: 52800022    	mov	w2, #0x1                ; =1
106e8c1ec: 94366bd4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c1f0: f00bb068    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106e8c1f4: 91032108    	add	x8, x8, #0xc8
106e8c1f8: f10002bf    	cmp	x21, #0x0
106e8c1fc: 9a950108    	csel	x8, x8, x21, eq
106e8c200: d00c93e9    	adrp	x9, 0x12010a000 <dyld_stub_binder+0x12010a000>
106e8c204: f946a521    	ldr	x1, [x9, #0xd48] ; stringWithFormat:
106e8c208: f9000be8    	str	x8, [sp, #0x10]
106e8c20c: 6d0003e8    	stp	d8, d0, [sp]
106e8c210: 900bd302    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c214: 912e2042    	add	x2, x2, #0xb88
106e8c218: aa1403e0    	mov	x0, x20
106e8c21c: 94366bc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c220: aa1d03fd    	mov	x29, x29
106e8c224: 94366bc9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c228: aa0003fb    	mov	x27, x0
106e8c22c: aa1503e0    	mov	x0, x21
106e8c230: 94366bc9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c234: f94027f8    	ldr	x24, [sp, #0x48]
106e8c238: f8786a60    	ldr	x0, [x19, x24]
106e8c23c: d00c8008    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
106e8c240: f942ad01    	ldr	x1, [x8, #0x558] ; isAd
106e8c244: 94366bbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c248: a9066ffc    	stp	x28, x27, [sp, #0x60]
106e8c24c: 340015e0    	cbz	w0, 0x106e8c508 <_Flutter_MMFoundation_BindContext+0x33680ec>
106e8c250: f8786a60    	ldr	x0, [x19, x24]
106e8c254: aa1703e1    	mov	x1, x23
106e8c258: 94366bb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c25c: aa1d03fd    	mov	x29, x29
106e8c260: 94366bba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c264: aa0003f4    	mov	x20, x0
106e8c268: 900c8ae8    	adrp	x8, 0x11ffe8000 <dyld_stub_binder+0x11ffe8000>
106e8c26c: f9461101    	ldr	x1, [x8, #0xc20] ; adUsePreferedInfo
106e8c270: 94366bb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c274: 360007e0    	tbz	w0, #0x0, 0x106e8c370 <_Flutter_MMFoundation_BindContext+0x3367f54>
106e8c278: f8786a60    	ldr	x0, [x19, x24]
106e8c27c: aa1703e1    	mov	x1, x23
106e8c280: 94366baf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c284: aa1d03fd    	mov	x29, x29
106e8c288: 94366bb0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c28c: aa0003f6    	mov	x22, x0
106e8c290: 900c8ae8    	adrp	x8, 0x11ffe8000 <dyld_stub_binder+0x11ffe8000>
106e8c294: f9461901    	ldr	x1, [x8, #0xc30] ; adPreferAvatar
106e8c298: f9003fe1    	str	x1, [sp, #0x78]
106e8c29c: 94366ba8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c2a0: aa1d03fd    	mov	x29, x29
106e8c2a4: 94366ba9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c2a8: aa1c03f5    	mov	x21, x28
106e8c2ac: aa1303fc    	mov	x28, x19
106e8c2b0: aa1803f3    	mov	x19, x24
106e8c2b4: aa0003f8    	mov	x24, x0
106e8c2b8: f00c93a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e8c2bc: f946e901    	ldr	x1, [x8, #0xdd0] ; length
106e8c2c0: 94366b9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c2c4: aa0003fa    	mov	x26, x0
106e8c2c8: aa1803e0    	mov	x0, x24
106e8c2cc: aa1303f8    	mov	x24, x19
106e8c2d0: aa1c03f3    	mov	x19, x28
106e8c2d4: aa1503fc    	mov	x28, x21
106e8c2d8: 94366b9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c2dc: aa1603e0    	mov	x0, x22
106e8c2e0: 94366b9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c2e4: aa1403e0    	mov	x0, x20
106e8c2e8: 94366b9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c2ec: b400047a    	cbz	x26, 0x106e8c378 <_Flutter_MMFoundation_BindContext+0x3367f5c>
106e8c2f0: f8786a60    	ldr	x0, [x19, x24]
106e8c2f4: aa1703e1    	mov	x1, x23
106e8c2f8: 94366b91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c2fc: aa1d03fd    	mov	x29, x29
106e8c300: 94366b92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c304: aa0003f4    	mov	x20, x0
106e8c308: f9403fe1    	ldr	x1, [sp, #0x78]
106e8c30c: 94366b8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c310: aa1d03fd    	mov	x29, x29
106e8c314: 94366b8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c318: aa0003fa    	mov	x26, x0
106e8c31c: aa1403e0    	mov	x0, x20
106e8c320: 94366b8d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c324: f00c9728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c328: f9453500    	ldr	x0, [x8, #0xa68]
106e8c32c: b00c7d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e8c330: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106e8c334: 900bd308    	adrp	x8, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c338: 912ea108    	add	x8, x8, #0xba8
106e8c33c: a9006be8    	stp	x8, x26, [sp]
106e8c340: 900a1c83    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
106e8c344: 912b2863    	add	x3, x3, #0xaca
106e8c348: 900a5ec5    	adrp	x5, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e8c34c: 910820a5    	add	x5, x5, #0x208
106e8c350: 900a5ec7    	adrp	x7, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e8c354: 913380e7    	add	x7, x7, #0xce0
106e8c358: 52800042    	mov	w2, #0x2                ; =2
106e8c35c: 52800004    	mov	w4, #0x0                ; =0
106e8c360: 5281f8c6    	mov	w6, #0xfc6              ; =4038
106e8c364: 94366b76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c368: b500041a    	cbnz	x26, 0x106e8c3e8 <_Flutter_MMFoundation_BindContext+0x3367fcc>
106e8c36c: 14000067    	b	0x106e8c508 <_Flutter_MMFoundation_BindContext+0x33680ec>
106e8c370: aa1403e0    	mov	x0, x20
106e8c374: 94366b78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c378: f00c9874    	adrp	x20, 0x12019b000 <dyld_stub_binder+0x12019b000>
106e8c37c: f940de80    	ldr	x0, [x20, #0x1b8] ; 0r=
106e8c380: f8786a62    	ldr	x2, [x19, x24]
106e8c384: b00c8b88    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106e8c388: f947bd01    	ldr	x1, [x8, #0xf78] ; shouldUseAsyncAvatarInfoInDetailForDataItem:
106e8c38c: 94366b6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c390: 34000bc0    	cbz	w0, 0x106e8c508 <_Flutter_MMFoundation_BindContext+0x33680ec>
106e8c394: f940de80    	ldr	x0, [x20, #0x1b8] ; 0r=
106e8c398: f8786a62    	ldr	x2, [x19, x24]
106e8c39c: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8c3a0: f943a501    	ldr	x1, [x8, #0x748] ; fetchAsyncAvatarUrlForDataItem:
106e8c3a4: 94366b66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c3a8: aa1d03fd    	mov	x29, x29
106e8c3ac: 94366b67    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c3b0: aa0003f4    	mov	x20, x0
106e8c3b4: f00c93a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e8c3b8: f946e901    	ldr	x1, [x8, #0xdd0] ; length
106e8c3bc: 94366b60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c3c0: b40000a0    	cbz	x0, 0x106e8c3d4 <_Flutter_MMFoundation_BindContext+0x3367fb8>
106e8c3c4: aa1403e0    	mov	x0, x20
106e8c3c8: 94366b5c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c3cc: aa1403fa    	mov	x26, x20
106e8c3d0: 14000003    	b	0x106e8c3dc <_Flutter_MMFoundation_BindContext+0x3367fc0>
106e8c3d4: f00bb07a    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106e8c3d8: 9103235a    	add	x26, x26, #0xc8
106e8c3dc: aa1403e0    	mov	x0, x20
106e8c3e0: 94366b5d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c3e4: b400093a    	cbz	x26, 0x106e8c508 <_Flutter_MMFoundation_BindContext+0x33680ec>
106e8c3e8: 4f00e400    	movi.16b	v0, #0x0
106e8c3ec: ad0683e0    	stp	q0, q0, [sp, #0xd0]
106e8c3f0: ad0583e0    	stp	q0, q0, [sp, #0xb0]
106e8c3f4: f87c6a60    	ldr	x0, [x19, x28]
106e8c3f8: 94366b50    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c3fc: 900c93a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e8c400: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
106e8c404: 9102c3e2    	add	x2, sp, #0xb0
106e8c408: 9103c3e3    	add	x3, sp, #0xf0
106e8c40c: f9003be0    	str	x0, [sp, #0x70]
106e8c410: f90023e1    	str	x1, [sp, #0x40]
106e8c414: 52800204    	mov	w4, #0x10               ; =16
106e8c418: 94366b49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c41c: aa0003f6    	mov	x22, x0
106e8c420: b4000e00    	cbz	x0, 0x106e8c5e0 <_Flutter_MMFoundation_BindContext+0x33681c4>
106e8c424: a90367fa    	stp	x26, x25, [sp, #0x30]
106e8c428: f9003ff3    	str	x19, [sp, #0x78]
106e8c42c: aa1803f3    	mov	x19, x24
106e8c430: f94063e8    	ldr	x8, [sp, #0xc0]
106e8c434: f9400118    	ldr	x24, [x8]
106e8c438: 900c7d88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8c43c: f00c93a9    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
106e8c440: 900c8b2a    	adrp	x10, 0x11fff0000 <dyld_stub_binder+0x11fff0000>
106e8c444: d2800019    	mov	x25, #0x0               ; =0
106e8c448: f9471115    	ldr	x21, [x8, #0xe20] ; username
106e8c44c: f946e93a    	ldr	x26, [x9, #0xdd0] ; length
106e8c450: f945755b    	ldr	x27, [x10, #0xae8] ; isAdvertiserFirstLikeForUserComment:
106e8c454: f94063e8    	ldr	x8, [sp, #0xc0]
106e8c458: f9400108    	ldr	x8, [x8]
106e8c45c: eb18011f    	cmp	x8, x24
106e8c460: 54000060    	b.eq	0x106e8c46c <_Flutter_MMFoundation_BindContext+0x3368050>
106e8c464: f9403be0    	ldr	x0, [sp, #0x70]
106e8c468: 94366b3a    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
106e8c46c: f9405fe8    	ldr	x8, [sp, #0xb8]
106e8c470: f8797917    	ldr	x23, [x8, x25, lsl #3]
106e8c474: aa1703e0    	mov	x0, x23
106e8c478: aa1503e1    	mov	x1, x21
106e8c47c: 94366b30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c480: aa1d03fd    	mov	x29, x29
106e8c484: 94366b31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c488: aa0003fc    	mov	x28, x0
106e8c48c: aa1a03e1    	mov	x1, x26
106e8c490: 94366b2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c494: b4000160    	cbz	x0, 0x106e8c4c0 <_Flutter_MMFoundation_BindContext+0x33680a4>
106e8c498: f9403fe8    	ldr	x8, [sp, #0x78]
106e8c49c: f8736900    	ldr	x0, [x8, x19]
106e8c4a0: aa1b03e1    	mov	x1, x27
106e8c4a4: aa1703e2    	mov	x2, x23
106e8c4a8: 94366b25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c4ac: aa0003f4    	mov	x20, x0
106e8c4b0: aa1c03e0    	mov	x0, x28
106e8c4b4: 94366b28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c4b8: 34000094    	cbz	w20, 0x106e8c4c8 <_Flutter_MMFoundation_BindContext+0x33680ac>
106e8c4bc: 14000015    	b	0x106e8c510 <_Flutter_MMFoundation_BindContext+0x33680f4>
106e8c4c0: aa1c03e0    	mov	x0, x28
106e8c4c4: 94366b24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c4c8: 91000739    	add	x25, x25, #0x1
106e8c4cc: eb1902df    	cmp	x22, x25
106e8c4d0: 54fffc21    	b.ne	0x106e8c454 <_Flutter_MMFoundation_BindContext+0x3368038>
106e8c4d4: 9102c3e2    	add	x2, sp, #0xb0
106e8c4d8: 9103c3e3    	add	x3, sp, #0xf0
106e8c4dc: f9403be0    	ldr	x0, [sp, #0x70]
106e8c4e0: f94023e1    	ldr	x1, [sp, #0x40]
106e8c4e4: 52800204    	mov	w4, #0x10               ; =16
106e8c4e8: 94366b15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c4ec: aa0003f6    	mov	x22, x0
106e8c4f0: 900c7d88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8c4f4: f00c93a9    	adrp	x9, 0x120103000 <dyld_stub_binder+0x120103000>
106e8c4f8: 900c8b2a    	adrp	x10, 0x11fff0000 <dyld_stub_binder+0x11fff0000>
106e8c4fc: b5fffa40    	cbnz	x0, 0x106e8c444 <_Flutter_MMFoundation_BindContext+0x3368028>
106e8c500: a94367fa    	ldp	x26, x25, [sp, #0x30]
106e8c504: 14000036    	b	0x106e8c5dc <_Flutter_MMFoundation_BindContext+0x33681c0>
106e8c508: f9003fff    	str	xzr, [sp, #0x78]
106e8c50c: 1400003a    	b	0x106e8c5f4 <_Flutter_MMFoundation_BindContext+0x33681d8>
106e8c510: f00c9728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c514: f9454100    	ldr	x0, [x8, #0xa80]
106e8c518: b00c93a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
106e8c51c: f9400501    	ldr	x1, [x8, #0x8] ; dictionary
106e8c520: 94366b07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c524: aa1d03fd    	mov	x29, x29
106e8c528: 94366b08    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c52c: aa0003f6    	mov	x22, x0
106e8c530: aa1703e0    	mov	x0, x23
106e8c534: aa1503e1    	mov	x1, x21
106e8c538: 94366b01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c53c: aa1d03fd    	mov	x29, x29
106e8c540: 94366b02    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c544: aa0003f4    	mov	x20, x0
106e8c548: b00c7d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e8c54c: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
106e8c550: aa1603e0    	mov	x0, x22
106e8c554: f9401bfa    	ldr	x26, [sp, #0x30]
106e8c558: aa1a03e2    	mov	x2, x26
106e8c55c: aa1403e3    	mov	x3, x20
106e8c560: 94366af7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c564: aa1403e0    	mov	x0, x20
106e8c568: 94366afb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c56c: f00c9728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c570: f9453514    	ldr	x20, [x8, #0xa68]
106e8c574: aa1703e0    	mov	x0, x23
106e8c578: aa1503e1    	mov	x1, x21
106e8c57c: 94366af0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c580: aa1d03fd    	mov	x29, x29
106e8c584: 94366af1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c588: aa0003f5    	mov	x21, x0
106e8c58c: b00c7d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e8c590: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106e8c594: a900ebe0    	stp	x0, x26, [sp, #0x8]
106e8c598: 900bd308    	adrp	x8, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c59c: 912f2108    	add	x8, x8, #0xbc8
106e8c5a0: f90003e8    	str	x8, [sp]
106e8c5a4: 900a1c83    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
106e8c5a8: 912b2863    	add	x3, x3, #0xaca
106e8c5ac: 900a5ec5    	adrp	x5, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e8c5b0: 910820a5    	add	x5, x5, #0x208
106e8c5b4: 900a5ec7    	adrp	x7, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e8c5b8: 913380e7    	add	x7, x7, #0xce0
106e8c5bc: aa1403e0    	mov	x0, x20
106e8c5c0: 52800042    	mov	w2, #0x2                ; =2
106e8c5c4: 52800004    	mov	w4, #0x0                ; =0
106e8c5c8: 5281fae6    	mov	w6, #0xfd7              ; =4055
106e8c5cc: 94366adc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c5d0: aa1503e0    	mov	x0, x21
106e8c5d4: 94366ae0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c5d8: f9401ff9    	ldr	x25, [sp, #0x38]
106e8c5dc: f9403ff3    	ldr	x19, [sp, #0x78]
106e8c5e0: f9003ff6    	str	x22, [sp, #0x78]
106e8c5e4: f9403be0    	ldr	x0, [sp, #0x70]
106e8c5e8: 94366adb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c5ec: aa1a03e0    	mov	x0, x26
106e8c5f0: 94366ad9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c5f4: b00c8b88    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106e8c5f8: f947cd16    	ldr	x22, [x8, #0xf98] ; isSpringStyle
106e8c5fc: aa1303e0    	mov	x0, x19
106e8c600: aa1603e1    	mov	x1, x22
106e8c604: 94366ace    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c608: f00c973b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c60c: 900c9758    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
106e8c610: 34000640    	cbz	w0, 0x106e8c6d8 <_Flutter_MMFoundation_BindContext+0x33682bc>
106e8c614: f00c973a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c618: f9463348    	ldr	x8, [x26, #0xc60]
106e8c61c: f90013e8    	str	x8, [sp, #0x20]
106e8c620: f945eb60    	ldr	x0, [x27, #0xbd0]
106e8c624: 900c93a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e8c628: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106e8c62c: f90027e1    	str	x1, [sp, #0x48]
106e8c630: 94366ac3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c634: aa1d03fd    	mov	x29, x29
106e8c638: 94366ac4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c63c: aa0003f4    	mov	x20, x0
106e8c640: f9404300    	ldr	x0, [x24, #0x80]
106e8c644: f00c9388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e8c648: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106e8c64c: f90023e1    	str	x1, [sp, #0x40]
106e8c650: 94366abb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c654: aa0003e2    	mov	x2, x0
106e8c658: b00c7d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e8c65c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106e8c660: f9001bf4    	str	x20, [sp, #0x30]
106e8c664: aa1403e0    	mov	x0, x20
106e8c668: f9003be1    	str	x1, [sp, #0x70]
106e8c66c: 94366ab4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c670: aa1d03fd    	mov	x29, x29
106e8c674: 94366ab5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c678: 900c7d88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8c67c: f9400514    	ldr	x20, [x8, #0x8] ; colorList
106e8c680: f90017e0    	str	x0, [sp, #0x28]
106e8c684: aa1403e1    	mov	x1, x20
106e8c688: 94366aad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c68c: aa1d03fd    	mov	x29, x29
106e8c690: 94366aae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c694: 900c7d88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8c698: f9400915    	ldr	x21, [x8, #0x10] ; getColorByName:
106e8c69c: 900bd302    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c6a0: 9110a042    	add	x2, x2, #0x428
106e8c6a4: f9000fe0    	str	x0, [sp, #0x18]
106e8c6a8: aa1503e1    	mov	x1, x21
106e8c6ac: 94366aa4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c6b0: aa1d03fd    	mov	x29, x29
106e8c6b4: 94366aa5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c6b8: aa0003f7    	mov	x23, x0
106e8c6bc: 94366a9f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c6c0: f9001ff9    	str	x25, [sp, #0x38]
106e8c6c4: b40001c0    	cbz	x0, 0x106e8c6fc <_Flutter_MMFoundation_BindContext+0x33682e0>
106e8c6c8: aa1703e0    	mov	x0, x23
106e8c6cc: 94366a9b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c6d0: aa1703fc    	mov	x28, x23
106e8c6d4: 14000011    	b	0x106e8c718 <_Flutter_MMFoundation_BindContext+0x33682fc>
106e8c6d8: d2800018    	mov	x24, #0x0               ; =0
106e8c6dc: 900c93a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e8c6e0: f944e91a    	ldr	x26, [x8, #0x9d0] ; currentContext
106e8c6e4: f00c9388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e8c6e8: f947ad1c    	ldr	x28, [x8, #0xf58] ; class
106e8c6ec: b00c7d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e8c6f0: f9464108    	ldr	x8, [x8, #0xc80] ; getService:
106e8c6f4: f9003be8    	str	x8, [sp, #0x70]
106e8c6f8: 14000056    	b	0x106e8c850 <_Flutter_MMFoundation_BindContext+0x3368434>
106e8c6fc: f9463340    	ldr	x0, [x26, #0xc60]
106e8c700: f00c9388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e8c704: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
106e8c708: 94366a8d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c70c: aa1d03fd    	mov	x29, x29
106e8c710: 94366a8e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c714: aa0003fc    	mov	x28, x0
106e8c718: aa1703e0    	mov	x0, x23
106e8c71c: 94366a8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c720: f945eb60    	ldr	x0, [x27, #0xbd0]
106e8c724: f94027e1    	ldr	x1, [sp, #0x48]
106e8c728: 94366a85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c72c: aa1d03fd    	mov	x29, x29
106e8c730: 94366a86    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c734: aa0003fb    	mov	x27, x0
106e8c738: f9404300    	ldr	x0, [x24, #0x80]
106e8c73c: f94023e1    	ldr	x1, [sp, #0x40]
106e8c740: 94366a7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c744: aa0003e2    	mov	x2, x0
106e8c748: aa1b03e0    	mov	x0, x27
106e8c74c: f9403be1    	ldr	x1, [sp, #0x70]
106e8c750: 94366a7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c754: aa1d03fd    	mov	x29, x29
106e8c758: 94366a7c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c75c: aa0003f9    	mov	x25, x0
106e8c760: aa1403e1    	mov	x1, x20
106e8c764: 94366a76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c768: aa1d03fd    	mov	x29, x29
106e8c76c: 94366a77    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c770: aa0003f4    	mov	x20, x0
106e8c774: 900bd302    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c778: 91112042    	add	x2, x2, #0x448
106e8c77c: aa1503e1    	mov	x1, x21
106e8c780: 94366a6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c784: aa1d03fd    	mov	x29, x29
106e8c788: 94366a70    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c78c: aa0003f5    	mov	x21, x0
106e8c790: 94366a6a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c794: b40000a0    	cbz	x0, 0x106e8c7a8 <_Flutter_MMFoundation_BindContext+0x336838c>
106e8c798: aa1503e0    	mov	x0, x21
106e8c79c: 94366a67    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c7a0: aa1503fa    	mov	x26, x21
106e8c7a4: 14000008    	b	0x106e8c7c4 <_Flutter_MMFoundation_BindContext+0x33683a8>
106e8c7a8: f9463340    	ldr	x0, [x26, #0xc60]
106e8c7ac: f00c9388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106e8c7b0: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
106e8c7b4: 94366a62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c7b8: aa1d03fd    	mov	x29, x29
106e8c7bc: 94366a63    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c7c0: aa0003fa    	mov	x26, x0
106e8c7c4: f94013f8    	ldr	x24, [sp, #0x20]
106e8c7c8: aa1503e0    	mov	x0, x21
106e8c7cc: 94366a62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c7d0: f00c7d88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106e8c7d4: f946bd01    	ldr	x1, [x8, #0xd78] ; colorInLightMode:DarkMode:
106e8c7d8: aa1803e0    	mov	x0, x24
106e8c7dc: aa1c03e2    	mov	x2, x28
106e8c7e0: aa1a03e3    	mov	x3, x26
106e8c7e4: 94366a56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c7e8: aa1d03fd    	mov	x29, x29
106e8c7ec: 94366a57    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c7f0: aa0003f8    	mov	x24, x0
106e8c7f4: aa1a03e0    	mov	x0, x26
106e8c7f8: 94366a57    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c7fc: aa1503e0    	mov	x0, x21
106e8c800: 94366a55    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c804: aa1403e0    	mov	x0, x20
106e8c808: 94366a53    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c80c: aa1903e0    	mov	x0, x25
106e8c810: 94366a51    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c814: aa1b03e0    	mov	x0, x27
106e8c818: 94366a4f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c81c: aa1c03e0    	mov	x0, x28
106e8c820: 94366a4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c824: aa1703e0    	mov	x0, x23
106e8c828: 94366a4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c82c: f9400fe0    	ldr	x0, [sp, #0x18]
106e8c830: 94366a49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c834: f94017e0    	ldr	x0, [sp, #0x28]
106e8c838: 94366a47    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c83c: f9401be0    	ldr	x0, [sp, #0x30]
106e8c840: 94366a45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c844: a943f3f9    	ldp	x25, x28, [sp, #0x38]
106e8c848: f00c973b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c84c: f94027fa    	ldr	x26, [sp, #0x48]
106e8c850: b94057e8    	ldr	w8, [sp, #0x54]
106e8c854: 7100551f    	cmp	w8, #0x15
106e8c858: 1a9f17f4    	cset	w20, eq
106e8c85c: aa1303e0    	mov	x0, x19
106e8c860: aa1603e1    	mov	x1, x22
106e8c864: 94366a36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c868: 900bd308    	adrp	x8, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c86c: 912fa108    	add	x8, x8, #0xbe8
106e8c870: 7100001f    	cmp	w0, #0x0
106e8c874: 9a9f1115    	csel	x21, x8, xzr, ne
106e8c878: b00c9888    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
106e8c87c: f9447116    	ldr	x22, [x8, #0x8e0] ; p6C
106e8c880: aa1503e0    	mov	x0, x21
106e8c884: 94366a2d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8c888: aa1603e0    	mov	x0, x22
106e8c88c: 94366a35    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106e8c890: aa0003f6    	mov	x22, x0
106e8c894: a945a3e1    	ldp	x1, x8, [sp, #0x58]
106e8c898: f8686a77    	ldr	x23, [x19, x8]
106e8c89c: aa1703e0    	mov	x0, x23
106e8c8a0: 94366a27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c8a4: aa0003e3    	mov	x3, x0
106e8c8a8: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8c8ac: f943a901    	ldr	x1, [x8, #0x750] ; initWithUserInfos:likeCount:isHBComment:customTextContent:customHeadImgUrlDic:customIconImageColor:customIconSVGImageName:
106e8c8b0: f90003f5    	str	x21, [sp]
106e8c8b4: aa1603e0    	mov	x0, x22
106e8c8b8: aa1703e2    	mov	x2, x23
106e8c8bc: aa1403e4    	mov	x4, x20
106e8c8c0: f94037e5    	ldr	x5, [sp, #0x68]
106e8c8c4: f9403fe6    	ldr	x6, [sp, #0x78]
106e8c8c8: f90033f8    	str	x24, [sp, #0x60]
106e8c8cc: aa1803e7    	mov	x7, x24
106e8c8d0: 94366a1b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c8d4: aa0003f4    	mov	x20, x0
106e8c8d8: aa1503e0    	mov	x0, x21
106e8c8dc: 94366a1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c8e0: f8796a60    	ldr	x0, [x19, x25]
106e8c8e4: f8396a74    	str	x20, [x19, x25]
106e8c8e8: 94366a1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c8ec: 9102a3e0    	add	x0, sp, #0xa8
106e8c8f0: aa1303e1    	mov	x1, x19
106e8c8f4: 94366a1e    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
106e8c8f8: d00b3b08    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
106e8c8fc: f947e108    	ldr	x8, [x8, #0xfc0]
106e8c900: f90043e8    	str	x8, [sp, #0x80]
106e8c904: b008f7a8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106e8c908: fd41c100    	ldr	d0, [x8, #0x380]
106e8c90c: 90000008    	adrp	x8, 0x106e8c000 <_Flutter_MMFoundation_BindContext+0x3367be4>
106e8c910: 912e4108    	add	x8, x8, #0xb90
106e8c914: fd0047e0    	str	d0, [sp, #0x88]
106e8c918: f00b3c09    	adrp	x9, 0x11d60f000 <dyld_stub_binder+0x11d60f000>
106e8c91c: 91152129    	add	x9, x9, #0x548
106e8c920: a90927e8    	stp	x8, x9, [sp, #0x90]
106e8c924: 910203f8    	add	x24, sp, #0x80
106e8c928: 91008300    	add	x0, x24, #0x20
106e8c92c: 9102a3e1    	add	x1, sp, #0xa8
106e8c930: 94366a12    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
106e8c934: f8796a60    	ldr	x0, [x19, x25]
106e8c938: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8c93c: f942ad01    	ldr	x1, [x8, #0x558] ; setOnHedaImageClick:
106e8c940: 910203e2    	add	x2, sp, #0x80
106e8c944: 943669fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c948: 900c9748    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e8c94c: f9403d14    	ldr	x20, [x8, #0x78]
106e8c950: f945eb60    	ldr	x0, [x27, #0xbd0]
106e8c954: aa1a03e1    	mov	x1, x26
106e8c958: 943669f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c95c: aa1d03fd    	mov	x29, x29
106e8c960: 943669fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c964: aa0003f5    	mov	x21, x0
106e8c968: 900c9748    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106e8c96c: f9404100    	ldr	x0, [x8, #0x80]
106e8c970: aa1c03e1    	mov	x1, x28
106e8c974: 943669f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c978: aa0003e2    	mov	x2, x0
106e8c97c: aa1503e0    	mov	x0, x21
106e8c980: f9403be1    	ldr	x1, [sp, #0x70]
106e8c984: 943669ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c988: aa1d03fd    	mov	x29, x29
106e8c98c: 943669ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c990: aa0003f6    	mov	x22, x0
106e8c994: f00c7d68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106e8c998: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
106e8c99c: 900bd302    	adrp	x2, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c9a0: 911f2042    	add	x2, x2, #0x7c8
106e8c9a4: 900bd303    	adrp	x3, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e8c9a8: 910fa063    	add	x3, x3, #0x3e8
106e8c9ac: 943669e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c9b0: aa1d03fd    	mov	x29, x29
106e8c9b4: 943669e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e8c9b8: aa0003f7    	mov	x23, x0
106e8c9bc: 900c7d88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e8c9c0: f9400101    	ldr	x1, [x8]
106e8c9c4: aa1403e0    	mov	x0, x20
106e8c9c8: aa1703e2    	mov	x2, x23
106e8c9cc: 943669dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c9d0: f8796a60    	ldr	x0, [x19, x25]
106e8c9d4: 900c93e8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106e8c9d8: f9418d01    	ldr	x1, [x8, #0x318] ; setImageHeight:
106e8c9dc: 943669d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8c9e0: aa1703e0    	mov	x0, x23
106e8c9e4: 943669dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c9e8: aa1603e0    	mov	x0, x22
106e8c9ec: 943669da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c9f0: aa1503e0    	mov	x0, x21
106e8c9f4: 943669d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8c9f8: f00c9736    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
106e8c9fc: f9468ec0    	ldr	x0, [x22, #0xd18]
106e8ca00: f00c93a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e8ca04: f9457d14    	ldr	x20, [x8, #0xaf8] ; isiPad
106e8ca08: aa1403e1    	mov	x1, x20
106e8ca0c: 943669cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca10: 1e629000    	fmov	d0, #5.00000000
106e8ca14: d00c93b5    	adrp	x21, 0x120102000 <dyld_stub_binder+0x120102000>
106e8ca18: 37000100    	tbnz	w0, #0x0, 0x106e8ca38 <_Flutter_MMFoundation_BindContext+0x336861c>
106e8ca1c: f8796a60    	ldr	x0, [x19, x25]
106e8ca20: f94556a1    	ldr	x1, [x21, #0xaa8] ; imageHeight
106e8ca24: 943669c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca28: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8ca2c: f942b101    	ldr	x1, [x8, #0x560] ; calculateLikeIconRightMarginWithLikeIconSize:
106e8ca30: aa1303e0    	mov	x0, x19
106e8ca34: 943669c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca38: f8796a60    	ldr	x0, [x19, x25]
106e8ca3c: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8ca40: f942b501    	ldr	x1, [x8, #0x568] ; setRowSpace:
106e8ca44: 943669be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca48: f9468ec0    	ldr	x0, [x22, #0xd18]
106e8ca4c: aa1403e1    	mov	x1, x20
106e8ca50: 943669bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca54: 340002c0    	cbz	w0, 0x106e8caac <_Flutter_MMFoundation_BindContext+0x3368690>
106e8ca58: 900c8b48    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
106e8ca5c: f9430d01    	ldr	x1, [x8, #0x618] ; getCommentViewWidth
106e8ca60: aa1303e0    	mov	x0, x19
106e8ca64: 943669b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca68: d2f80928    	mov	x8, #-0x3fb7000000000000 ; =-4591138345127510016
106e8ca6c: 9e670101    	fmov	d1, x8
106e8ca70: 1e612800    	fadd	d0, d0, d1
106e8ca74: 1e749001    	fmov	d1, #-10.00000000
106e8ca78: 1e612809    	fadd	d9, d0, d1
106e8ca7c: f8796a60    	ldr	x0, [x19, x25]
106e8ca80: f94556a1    	ldr	x1, [x21, #0xaa8] ; imageHeight
106e8ca84: 943669ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca88: 1e604008    	fmov	d8, d0
106e8ca8c: f8796a60    	ldr	x0, [x19, x25]
106e8ca90: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8ca94: f942b901    	ldr	x1, [x8, #0x570] ; rowSpace
106e8ca98: 943669a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8ca9c: 1e602900    	fadd	d0, d8, d0
106e8caa0: 1e601920    	fdiv	d0, d9, d0
106e8caa4: 1e654000    	frintm	d0, d0
106e8caa8: 14000010    	b	0x106e8cae8 <_Flutter_MMFoundation_BindContext+0x33686cc>
106e8caac: f8796a60    	ldr	x0, [x19, x25]
106e8cab0: f94556a1    	ldr	x1, [x21, #0xaa8] ; imageHeight
106e8cab4: 943669a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cab8: 1e604008    	fmov	d8, d0
106e8cabc: f8796a60    	ldr	x0, [x19, x25]
106e8cac0: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8cac4: f942b901    	ldr	x1, [x8, #0x570] ; rowSpace
106e8cac8: 9436699d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cacc: 1e604001    	fmov	d1, d0
106e8cad0: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8cad4: f942bd01    	ldr	x1, [x8, #0x578] ; getLikeIconCountPerLineWithLikeIconSize:likeIconRowSpace:
106e8cad8: aa1303e0    	mov	x0, x19
106e8cadc: 1e604100    	fmov	d0, d8
106e8cae0: 94366997    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cae4: 1e630000    	ucvtf	d0, w0
106e8cae8: 1e790002    	fcvtzu	w2, d0
106e8caec: f8796a60    	ldr	x0, [x19, x25]
106e8caf0: d00c8b88    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e8caf4: f942c101    	ldr	x1, [x8, #0x580] ; setCountPerLine:
106e8caf8: 94366991    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cafc: f8796a60    	ldr	x0, [x19, x25]
106e8cb00: 900c8388    	adrp	x8, 0x11fefc000 <dyld_stub_binder+0x11fefc000>
106e8cb04: f9472101    	ldr	x1, [x8, #0xe40] ; fitTheSubviews
106e8cb08: 9436698d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cb0c: f8796a60    	ldr	x0, [x19, x25]
106e8cb10: b00c7d68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e8cb14: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
106e8cb18: d008f7a8    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
106e8cb1c: fd40a100    	ldr	d0, [x8, #0x140]
106e8cb20: 9e6703e1    	fmov	d1, xzr
106e8cb24: 94366986    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e8cb28: 91008300    	add	x0, x24, #0x20
106e8cb2c: 94366999    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106e8cb30: 9102a3e0    	add	x0, sp, #0xa8
106e8cb34: 94366997    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
106e8cb38: f94033e0    	ldr	x0, [sp, #0x60]
106e8cb3c: 94366986    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8cb40: f9403fe0    	ldr	x0, [sp, #0x78]
106e8cb44: 94366984    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8cb48: f94037e0    	ldr	x0, [sp, #0x68]
106e8cb4c: 94366982    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e8cb50: f85903a8    	ldur	x8, [x29, #-0x70]
106e8cb54: f00b3b09    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106e8cb58: f9405929    	ldr	x9, [x9, #0xb0]
106e8cb5c: f9400129    	ldr	x9, [x9]
106e8cb60: eb08013f    	cmp	x9, x8
106e8cb64: 54000141    	b.ne	0x106e8cb8c <_Flutter_MMFoundation_BindContext+0x3368770>
106e8cb68: a95e7bfd    	ldp	x29, x30, [sp, #0x1e0]
106e8cb6c: a95d4ff4    	ldp	x20, x19, [sp, #0x1d0]
106e8cb70: a95c57f6    	ldp	x22, x21, [sp, #0x1c0]
106e8cb74: a95b5ff8    	ldp	x24, x23, [sp, #0x1b0]
106e8cb78: a95a67fa    	ldp	x26, x25, [sp, #0x1a0]
106e8cb7c: a9596ffc    	ldp	x28, x27, [sp, #0x190]
106e8cb80: 6d5823e9    	ldp	d9, d8, [sp, #0x180]
106e8cb84: 9107c3ff    	add	sp, sp, #0x1f0
106e8cb88: d65f03c0    	ret
106e8cb8c: 9436697a    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
