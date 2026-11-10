
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae2f24: d10503ff    	sub	sp, sp, #0x140
105ae2f28: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
105ae2f2c: a90f67fa    	stp	x26, x25, [sp, #0xf0]
105ae2f30: a9105ff8    	stp	x24, x23, [sp, #0x100]
105ae2f34: a91157f6    	stp	x22, x21, [sp, #0x110]
105ae2f38: a9124ff4    	stp	x20, x19, [sp, #0x120]
105ae2f3c: a9137bfd    	stp	x29, x30, [sp, #0x130]
105ae2f40: 9104c3fd    	add	x29, sp, #0x130
105ae2f44: aa0303f4    	mov	x20, x3
105ae2f48: aa0203f3    	mov	x19, x2
105ae2f4c: aa0003f5    	mov	x21, x0
105ae2f50: d00be348    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
105ae2f54: f9451908    	ldr	x8, [x8, #0xa30]
105ae2f58: f9400108    	ldr	x8, [x8]
105ae2f5c: f81a03a8    	stur	x8, [x29, #-0x60]
105ae2f60: d00ce388    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105ae2f64: 52800029    	mov	w9, #0x1                ; =1
105ae2f68: 3932d909    	strb	w9, [x8, #0xcb6]
105ae2f6c: aa0203e0    	mov	x0, x2
105ae2f70: 94851341    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae2f74: aa1403e0    	mov	x0, x20
105ae2f78: 9485133f    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae2f7c: d00c8e28    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105ae2f80: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
105ae2f84: aa1503e0    	mov	x0, x21
105ae2f88: 94851337    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2f8c: aa0003f5    	mov	x21, x0
105ae2f90: b4000aa0    	cbz	x0, 0x105ae30e4 <_Flutter_MMFoundation_BindContext+0x1d69db0>
105ae2f94: f00c8e28    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae2f98: f9418d01    	ldr	x1, [x8, #0x318] ; selector: mutableCopy
105ae2f9c: aa1303e0    	mov	x0, x19
105ae2fa0: 94851331    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2fa4: f00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae2fa8: b984a909    	ldrsw	x9, [x8, #0x4a8] ; ivar: SessionSelectController.m_selectedContacts offset=128
105ae2fac: f8696aa8    	ldr	x8, [x21, x9]
105ae2fb0: f8296aa0    	str	x0, [x21, x9]
105ae2fb4: aa0803e0    	mov	x0, x8
105ae2fb8: 9485132e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae2fbc: 900c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae2fc0: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
105ae2fc4: aa1403e0    	mov	x0, x20
105ae2fc8: 94851327    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2fcc: b40008c0    	cbz	x0, 0x105ae30e4 <_Flutter_MMFoundation_BindContext+0x1d69db0>
105ae2fd0: a9004ff5    	stp	x21, x19, [sp]
105ae2fd4: 900c9188    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105ae2fd8: f9431900    	ldr	x0, [x8, #0x630]
105ae2fdc: f00c8e28    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105ae2fe0: f941e901    	ldr	x1, [x8, #0x3d0] ; selector: new
105ae2fe4: 94851320    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae2fe8: aa0003f6    	mov	x22, x0
105ae2fec: 4f00e400    	movi.16b	v0, #0x0
105ae2ff0: ad0083e0    	stp	q0, q0, [sp, #0x10]
105ae2ff4: ad0183e0    	stp	q0, q0, [sp, #0x30]
105ae2ff8: aa1403e0    	mov	x0, x20
105ae2ffc: 9485131e    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae3000: f00c8e08    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae3004: f9442d17    	ldr	x23, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
105ae3008: 910043e2    	add	x2, sp, #0x10
105ae300c: 910143e3    	add	x3, sp, #0x50
105ae3010: aa1703e1    	mov	x1, x23
105ae3014: 52800204    	mov	w4, #0x10               ; =16
105ae3018: 94851313    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae301c: b4000520    	cbz	x0, 0x105ae30c0 <_Flutter_MMFoundation_BindContext+0x1d69d8c>
105ae3020: aa0003f8    	mov	x24, x0
105ae3024: f94013e8    	ldr	x8, [sp, #0x20]
105ae3028: f9400113    	ldr	x19, [x8]
105ae302c: d2800015    	mov	x21, #0x0               ; =0
105ae3030: 900c7748    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
105ae3034: f9431119    	ldr	x25, [x8, #0x620] ; selector: m_nsUsrName
105ae3038: d00c7728    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105ae303c: f941a91a    	ldr	x26, [x8, #0x350] ; selector: safeSetObject:forKey:
105ae3040: f94013e8    	ldr	x8, [sp, #0x20]
105ae3044: f9400108    	ldr	x8, [x8]
105ae3048: eb13011f    	cmp	x8, x19
105ae304c: 54000060    	b.eq	0x105ae3058 <_Flutter_MMFoundation_BindContext+0x1d69d24>
105ae3050: aa1403e0    	mov	x0, x20
105ae3054: 948512fa    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
105ae3058: f9400fe8    	ldr	x8, [sp, #0x18]
105ae305c: f875791b    	ldr	x27, [x8, x21, lsl #3]
105ae3060: aa1b03e0    	mov	x0, x27
105ae3064: aa1903e1    	mov	x1, x25
105ae3068: 948512ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae306c: aa1d03fd    	mov	x29, x29
105ae3070: 94851304    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105ae3074: aa0003fc    	mov	x28, x0
105ae3078: aa1603e0    	mov	x0, x22
105ae307c: aa1a03e1    	mov	x1, x26
105ae3080: aa1b03e2    	mov	x2, x27
105ae3084: aa1c03e3    	mov	x3, x28
105ae3088: 948512f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae308c: aa1c03e0    	mov	x0, x28
105ae3090: 948512f8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae3094: 910006b5    	add	x21, x21, #0x1
105ae3098: eb15031f    	cmp	x24, x21
105ae309c: 54fffd21    	b.ne	0x105ae3040 <_Flutter_MMFoundation_BindContext+0x1d69d0c>
105ae30a0: 910043e2    	add	x2, sp, #0x10
105ae30a4: 910143e3    	add	x3, sp, #0x50
105ae30a8: aa1403e0    	mov	x0, x20
105ae30ac: aa1703e1    	mov	x1, x23
105ae30b0: 52800204    	mov	w4, #0x10               ; =16
105ae30b4: 948512ec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae30b8: aa0003f8    	mov	x24, x0
105ae30bc: b5fffb80    	cbnz	x0, 0x105ae302c <_Flutter_MMFoundation_BindContext+0x1d69cf8>
105ae30c0: aa1403e0    	mov	x0, x20
105ae30c4: 948512eb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae30c8: d00c9768    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105ae30cc: b984ad08    	ldrsw	x8, [x8, #0x4ac] ; ivar: SessionSelectController.m_dicRequiredContact offset=136
105ae30d0: f94003f5    	ldr	x21, [sp]
105ae30d4: f8686aa0    	ldr	x0, [x21, x8]
105ae30d8: f8286ab6    	str	x22, [x21, x8]
105ae30dc: 948512e5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae30e0: f94007f3    	ldr	x19, [sp, #0x8]
105ae30e4: aa1403e0    	mov	x0, x20
105ae30e8: 948512e2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae30ec: aa1303e0    	mov	x0, x19
105ae30f0: 948512e0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae30f4: f85a03a8    	ldur	x8, [x29, #-0x60]
105ae30f8: b00be349    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
105ae30fc: f9451929    	ldr	x9, [x9, #0xa30]
105ae3100: f9400129    	ldr	x9, [x9]
105ae3104: eb08013f    	cmp	x9, x8
105ae3108: 54000141    	b.ne	0x105ae3130 <_Flutter_MMFoundation_BindContext+0x1d69dfc>
105ae310c: aa1503e0    	mov	x0, x21
105ae3110: a9537bfd    	ldp	x29, x30, [sp, #0x130]
105ae3114: a9524ff4    	ldp	x20, x19, [sp, #0x120]
105ae3118: a95157f6    	ldp	x22, x21, [sp, #0x110]
105ae311c: a9505ff8    	ldp	x24, x23, [sp, #0x100]
105ae3120: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
105ae3124: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
105ae3128: 910503ff    	add	sp, sp, #0x140
105ae312c: d65f03c0    	ret
105ae3130: 94851180    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
