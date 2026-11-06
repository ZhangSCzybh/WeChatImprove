
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10103df7c: d10383ff    	sub	sp, sp, #0xe0
10103df80: 6d0723e9    	stp	d9, d8, [sp, #0x70]
10103df84: a9086ffc    	stp	x28, x27, [sp, #0x80]
10103df88: a90967fa    	stp	x26, x25, [sp, #0x90]
10103df8c: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
10103df90: a90b57f6    	stp	x22, x21, [sp, #0xb0]
10103df94: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
10103df98: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
10103df9c: 910343fd    	add	x29, sp, #0xd0
10103dfa0: aa0003f3    	mov	x19, x0
10103dfa4: d00f3828    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
10103dfa8: 52800029    	mov	w9, #0x1                ; =1
10103dfac: 3927e509    	strb	w9, [x8, #0x9f9]
10103dfb0: 900eea68    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
10103dfb4: b988b517    	ldrsw	x23, [x8, #0x8b4]
10103dfb8: f8776808    	ldr	x8, [x0, x23]
10103dfbc: b50001a8    	cbnz	x8, 0x10103dff0 <__text+0x1035ff0>
10103dfc0: d00ee6a8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10103dfc4: f942fd00    	ldr	x0, [x8, #0x5f8]
10103dfc8: 95afa711    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
10103dfcc: f8776a68    	ldr	x8, [x19, x23]
10103dfd0: f8376a60    	str	x0, [x19, x23]
10103dfd4: aa0803e0    	mov	x0, x8
10103dfd8: 95afa726    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103dfdc: f8776a60    	ldr	x0, [x19, x23]
10103dfe0: f00ee368    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
10103dfe4: f9469d01    	ldr	x1, [x8, #0xd38]
10103dfe8: 52800022    	mov	w2, #0x1                ; =1
10103dfec: 95afa71e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103dff0: b00ecc88    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10103dff4: f941c115    	ldr	x21, [x8, #0x380]
10103dff8: aa1303e0    	mov	x0, x19
10103dffc: aa1503e1    	mov	x1, x21
10103e000: 95afa719    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e004: aa1d03fd    	mov	x29, x29
10103e008: 95afa71e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e00c: aa0003f4    	mov	x20, x0
10103e010: f00ecc88    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10103e014: f9464501    	ldr	x1, [x8, #0xc88]
10103e018: 95afa713    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e01c: 34000160    	cbz	w0, 0x10103e048 <__text+0x1036048>
10103e020: aa1403e0    	mov	x0, x20
10103e024: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
10103e028: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
10103e02c: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
10103e030: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
10103e034: a94967fa    	ldp	x26, x25, [sp, #0x90]
10103e038: a9486ffc    	ldp	x28, x27, [sp, #0x80]
10103e03c: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
10103e040: 910383ff    	add	sp, sp, #0xe0
10103e044: 15afa70b    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e048: aa1303e0    	mov	x0, x19
10103e04c: aa1503e1    	mov	x1, x21
10103e050: 95afa705    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e054: aa1d03fd    	mov	x29, x29
10103e058: 95afa70a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e05c: aa0003f5    	mov	x21, x0
10103e060: f00ecc88    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10103e064: f9458101    	ldr	x1, [x8, #0xb00]
10103e068: 95afa6ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e06c: aa0003f6    	mov	x22, x0
10103e070: aa1503e0    	mov	x0, x21
10103e074: 95afa6ff    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e078: aa1403e0    	mov	x0, x20
10103e07c: 95afa6fd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e080: 37000c36    	tbnz	w22, #0x0, 0x10103e204 <__text+0x1036204>
10103e084: f00ecec8    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10103e088: f9468901    	ldr	x1, [x8, #0xd10]
10103e08c: aa1303e0    	mov	x0, x19
10103e090: 95afa6f5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e094: 34000240    	cbz	w0, 0x10103e0dc <__text+0x10360dc>
10103e098: f00ecec8    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
10103e09c: f947d501    	ldr	x1, [x8, #0xfa8]
10103e0a0: aa1303e0    	mov	x0, x19
10103e0a4: 95afa6f0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e0a8: f8776a60    	ldr	x0, [x19, x23]
10103e0ac: b00ee368    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10103e0b0: f9458d01    	ldr	x1, [x8, #0xb18]
10103e0b4: 52800022    	mov	w2, #0x1                ; =1
10103e0b8: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
10103e0bc: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
10103e0c0: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
10103e0c4: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
10103e0c8: a94967fa    	ldp	x26, x25, [sp, #0x90]
10103e0cc: a9486ffc    	ldp	x28, x27, [sp, #0x80]
10103e0d0: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
10103e0d4: 910383ff    	add	sp, sp, #0xe0
10103e0d8: 15afa6e3    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e0dc: 900ee6a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10103e0e0: f944d900    	ldr	x0, [x8, #0x9b0]
10103e0e4: d00ecc68    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10103e0e8: f942b501    	ldr	x1, [x8, #0x568]
10103e0ec: 95afa6de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e0f0: aa0003f4    	mov	x20, x0
10103e0f4: 9101a3e0    	add	x0, sp, #0x68
10103e0f8: aa1303e1    	mov	x1, x19
10103e0fc: 95afa6d7    	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
10103e100: b00ee6b9    	adrp	x25, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10103e104: d00e387a    	adrp	x26, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10103e108: f9449b5a    	ldr	x26, [x26, #0x930]
10103e10c: f9430335    	ldr	x21, [x25, #0x600]
10103e110: f9001ffa    	str	x26, [sp, #0x38]
10103e114: b00b4448    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10103e118: fd434108    	ldr	d8, [x8, #0x680]
10103e11c: 90000008    	adrp	x8, 0x10103e000 <__text+0x1036000>
10103e120: 9108a108    	add	x8, x8, #0x228
10103e124: fd0023e8    	str	d8, [sp, #0x40]
10103e128: f00d92db    	adrp	x27, 0x11c299000 <dyld_stub_binder+0x11c299000>
10103e12c: 9132837b    	add	x27, x27, #0xca0
10103e130: a904efe8    	stp	x8, x27, [sp, #0x48]
10103e134: 9100e3f8    	add	x24, sp, #0x38
10103e138: 91008300    	add	x0, x24, #0x20
10103e13c: 9101a3e1    	add	x1, sp, #0x68
10103e140: 95afa6bc    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
10103e144: 390183f4    	strb	w20, [sp, #0x60]
10103e148: b00ecc88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10103e14c: f940d516    	ldr	x22, [x8, #0x1a8]
10103e150: 9100e3e2    	add	x2, sp, #0x38
10103e154: aa1503e0    	mov	x0, x21
10103e158: aa1603e1    	mov	x1, x22
10103e15c: 95afa6c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e160: aa1d03fd    	mov	x29, x29
10103e164: 95afa6c7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e168: aa0003f5    	mov	x21, x0
10103e16c: f8776a60    	ldr	x0, [x19, x23]
10103e170: b00ee368    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10103e174: f945c501    	ldr	x1, [x8, #0xb88]
10103e178: aa1503e2    	mov	x2, x21
10103e17c: 95afa6ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e180: aa1503e0    	mov	x0, x21
10103e184: 95afa6bb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e188: f9430335    	ldr	x21, [x25, #0x600]
10103e18c: f90007fa    	str	x26, [sp, #0x8]
10103e190: fd000be8    	str	d8, [sp, #0x10]
10103e194: 90000008    	adrp	x8, 0x10103e000 <__text+0x1036000>
10103e198: 910b1108    	add	x8, x8, #0x2c4
10103e19c: a901efe8    	stp	x8, x27, [sp, #0x18]
10103e1a0: 910023f9    	add	x25, sp, #0x8
10103e1a4: 91008320    	add	x0, x25, #0x20
10103e1a8: 9101a3e1    	add	x1, sp, #0x68
10103e1ac: 95afa6a1    	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
10103e1b0: 3900c3f4    	strb	w20, [sp, #0x30]
10103e1b4: 910023e2    	add	x2, sp, #0x8
10103e1b8: aa1503e0    	mov	x0, x21
10103e1bc: aa1603e1    	mov	x1, x22
10103e1c0: 95afa6a9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e1c4: aa1d03fd    	mov	x29, x29
10103e1c8: 95afa6ae    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e1cc: aa0003f4    	mov	x20, x0
10103e1d0: f8776a60    	ldr	x0, [x19, x23]
10103e1d4: b00ee368    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10103e1d8: f9459901    	ldr	x1, [x8, #0xb30]
10103e1dc: aa1403e2    	mov	x2, x20
10103e1e0: 95afa6a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e1e4: aa1403e0    	mov	x0, x20
10103e1e8: 95afa6a2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e1ec: 91008320    	add	x0, x25, #0x20
10103e1f0: 95afa691    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
10103e1f4: 91008300    	add	x0, x24, #0x20
10103e1f8: 95afa68f    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
10103e1fc: 9101a3e0    	add	x0, sp, #0x68
10103e200: 95afa68d    	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
10103e204: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
10103e208: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
10103e20c: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
10103e210: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
10103e214: a94967fa    	ldp	x26, x25, [sp, #0x90]
10103e218: a9486ffc    	ldp	x28, x27, [sp, #0x80]
10103e21c: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
10103e220: 910383ff    	add	sp, sp, #0xe0
10103e224: d65f03c0    	ret
10103e228: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10103e22c: a9014ff4    	stp	x20, x19, [sp, #0x10]
10103e230: a9027bfd    	stp	x29, x30, [sp, #0x20]
10103e234: 910083fd    	add	x29, sp, #0x20
10103e238: aa0003f3    	mov	x19, x0
10103e23c: 91008000    	add	x0, x0, #0x20
10103e240: 95afa687    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10103e244: aa0003f4    	mov	x20, x0
10103e248: 900ecc88    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10103e24c: f941c101    	ldr	x1, [x8, #0x380]
10103e250: 95afa685    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e254: aa1d03fd    	mov	x29, x29
10103e258: 95afa68a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e25c: aa0003f5    	mov	x21, x0
10103e260: b00ecc88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10103e264: f9470901    	ldr	x1, [x8, #0xe10]
10103e268: 95afa67f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e26c: aa1d03fd    	mov	x29, x29
10103e270: 95afa684    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e274: aa0003f6    	mov	x22, x0
10103e278: 3940a263    	ldrb	w3, [x19, #0x28]
10103e27c: f00ecc88    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10103e280: f9437901    	ldr	x1, [x8, #0x6f0]
10103e284: 52800002    	mov	w2, #0x0                ; =0
10103e288: 95afa677    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e28c: aa1d03fd    	mov	x29, x29
10103e290: 95afa67c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e294: aa0003f3    	mov	x19, x0
10103e298: aa1603e0    	mov	x0, x22
10103e29c: 95afa675    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e2a0: aa1503e0    	mov	x0, x21
10103e2a4: 95afa673    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e2a8: aa1403e0    	mov	x0, x20
10103e2ac: 95afa671    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e2b0: aa1303e0    	mov	x0, x19
10103e2b4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10103e2b8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10103e2bc: a8c357f6    	ldp	x22, x21, [sp], #0x30
10103e2c0: 15afa658    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
10103e2c4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10103e2c8: a9014ff4    	stp	x20, x19, [sp, #0x10]
10103e2cc: a9027bfd    	stp	x29, x30, [sp, #0x20]
10103e2d0: 910083fd    	add	x29, sp, #0x20
10103e2d4: aa0003f3    	mov	x19, x0
10103e2d8: 91008000    	add	x0, x0, #0x20
10103e2dc: 95afa660    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
10103e2e0: aa0003f4    	mov	x20, x0
10103e2e4: 900ecc88    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10103e2e8: f941c101    	ldr	x1, [x8, #0x380]
10103e2ec: 95afa65e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e2f0: aa1d03fd    	mov	x29, x29
10103e2f4: 95afa663    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e2f8: aa0003f5    	mov	x21, x0
10103e2fc: b00ecc88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10103e300: f9470901    	ldr	x1, [x8, #0xe10]
10103e304: 95afa658    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e308: aa1d03fd    	mov	x29, x29
10103e30c: 95afa65d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e310: aa0003f6    	mov	x22, x0
10103e314: 3940a263    	ldrb	w3, [x19, #0x28]
10103e318: f00ecc88    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
10103e31c: f9437901    	ldr	x1, [x8, #0x6f0]
10103e320: 52800022    	mov	w2, #0x1                ; =1
10103e324: 95afa650    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10103e328: aa1d03fd    	mov	x29, x29
10103e32c: 95afa655    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10103e330: aa0003f3    	mov	x19, x0
10103e334: aa1603e0    	mov	x0, x22
10103e338: 95afa64e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e33c: aa1503e0    	mov	x0, x21
10103e340: 95afa64c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e344: aa1403e0    	mov	x0, x20
10103e348: 95afa64a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10103e34c: aa1303e0    	mov	x0, x19
10103e350: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10103e354: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10103e358: a8c357f6    	ldp	x22, x21, [sp], #0x30
10103e35c: 15afa631    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
