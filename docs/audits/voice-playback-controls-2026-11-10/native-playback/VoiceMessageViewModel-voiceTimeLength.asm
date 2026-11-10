
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106588dbc: d10283ff    	sub	sp, sp, #0xa0
106588dc0: 6d0323e9    	stp	d9, d8, [sp, #0x30]
106588dc4: a9046ffc    	stp	x28, x27, [sp, #0x40]
106588dc8: a90567fa    	stp	x26, x25, [sp, #0x50]
106588dcc: a9065ff8    	stp	x24, x23, [sp, #0x60]
106588dd0: a90757f6    	stp	x22, x21, [sp, #0x70]
106588dd4: a9084ff4    	stp	x20, x19, [sp, #0x80]
106588dd8: a9097bfd    	stp	x29, x30, [sp, #0x90]
106588ddc: 910243fd    	add	x29, sp, #0x90
106588de0: aa0003f6    	mov	x22, x0
106588de4: f00c8e68    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106588de8: 52800029    	mov	w9, #0x1                ; =1
106588dec: d00c3faa    	adrp	x10, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
106588df0: 912e314a    	add	x10, x10, #0xb8c
106588df4: 3908b909    	strb	w9, [x8, #0x22e]
106588df8: b9800148    	ldrsw	x8, [x10]
106588dfc: f8686800    	ldr	x0, [x0, x8]
106588e00: f00c2248    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
106588e04: f9454d01    	ldr	x1, [x8, #0xa98]
106588e08: 945a7b97    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588e0c: 1107d008    	add	w8, w0, #0x1f4
106588e10: 5289ba69    	mov	w9, #0x4dd3             ; =19923
106588e14: 72a20c49    	movk	w9, #0x1062, lsl #16
106588e18: 9ba97d08    	umull	x8, w8, w9
106588e1c: d366fd08    	lsr	x8, x8, #38
106588e20: 52807d09    	mov	w9, #0x3e8              ; =1000
106588e24: 1b097d15    	mul	w21, w8, w9
106588e28: f00c3c58    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
106588e2c: d00c3c49    	adrp	x9, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106588e30: d00c3c5a    	adrp	x26, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106588e34: 711f3ebf    	cmp	w21, #0x7cf
106588e38: 540005c8    	b.hi	0x106588ef0 <_Flutter_MMFoundation_BindContext+0x280fbbc>
106588e3c: f942f71c    	ldr	x28, [x24, #0x5e8]
106588e40: f943c120    	ldr	x0, [x9, #0x780]
106588e44: b00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106588e48: f9440101    	ldr	x1, [x8, #0x800]
106588e4c: f90013e1    	str	x1, [sp, #0x20]
106588e50: 945a7b85    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588e54: aa1d03fd    	mov	x29, x29
106588e58: 945a7b8a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588e5c: aa0003f4    	mov	x20, x0
106588e60: f9462340    	ldr	x0, [x26, #0xc40]
106588e64: d00c38e8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106588e68: f9428513    	ldr	x19, [x8, #0x508]
106588e6c: aa1303e1    	mov	x1, x19
106588e70: 945a7b7d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588e74: aa0003e2    	mov	x2, x0
106588e78: b00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106588e7c: f9452117    	ldr	x23, [x8, #0xa40]
106588e80: f9000ff4    	str	x20, [sp, #0x18]
106588e84: aa1403e0    	mov	x0, x20
106588e88: aa1703e1    	mov	x1, x23
106588e8c: 945a7b76    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588e90: aa1d03fd    	mov	x29, x29
106588e94: 945a7b7b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588e98: aa0003f4    	mov	x20, x0
106588e9c: f00c2208    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106588ea0: f9477501    	ldr	x1, [x8, #0xee8]
106588ea4: b00b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
106588ea8: 910ce042    	add	x2, x2, #0x338
106588eac: f00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106588eb0: 9130e063    	add	x3, x3, #0xc38
106588eb4: f90017e1    	str	x1, [sp, #0x28]
106588eb8: 945a7b6b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588ebc: aa1d03fd    	mov	x29, x29
106588ec0: 945a7b70    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588ec4: aa0003fb    	mov	x27, x0
106588ec8: f00c2228    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106588ecc: f9471519    	ldr	x25, [x8, #0xe28]
106588ed0: aa1c03e0    	mov	x0, x28
106588ed4: aa1903e1    	mov	x1, x25
106588ed8: aa1b03e2    	mov	x2, x27
106588edc: aa1603e3    	mov	x3, x22
106588ee0: 945a7b61    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588ee4: 4ea01c08    	mov.16b	v8, v0
106588ee8: aa1a03f5    	mov	x21, x26
106588eec: 140000d1    	b	0x106589230 <_Flutter_MMFoundation_BindContext+0x280fefc>
106588ef0: 53047ea8    	lsr	w8, w21, #4
106588ef4: 7109c11f    	cmp	w8, #0x270
106588ef8: 54000c88    	b.hi	0x106589088 <_Flutter_MMFoundation_BindContext+0x280fd54>
106588efc: f942f708    	ldr	x8, [x24, #0x5e8]
106588f00: f90017e8    	str	x8, [sp, #0x28]
106588f04: f943c120    	ldr	x0, [x9, #0x780]
106588f08: b00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106588f0c: f944011c    	ldr	x28, [x8, #0x800]
106588f10: aa1c03e1    	mov	x1, x28
106588f14: 945a7b54    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588f18: aa1d03fd    	mov	x29, x29
106588f1c: 945a7b59    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588f20: aa0003f9    	mov	x25, x0
106588f24: f9000fe0    	str	x0, [sp, #0x18]
106588f28: f9462340    	ldr	x0, [x26, #0xc40]
106588f2c: aa1a03f4    	mov	x20, x26
106588f30: d00c38e8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106588f34: f9428513    	ldr	x19, [x8, #0x508]
106588f38: aa1303e1    	mov	x1, x19
106588f3c: 945a7b4a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588f40: aa0003e2    	mov	x2, x0
106588f44: b00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106588f48: f9452117    	ldr	x23, [x8, #0xa40]
106588f4c: aa1903e0    	mov	x0, x25
106588f50: aa1703e1    	mov	x1, x23
106588f54: 945a7b44    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588f58: aa1d03fd    	mov	x29, x29
106588f5c: 945a7b49    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588f60: f9000be0    	str	x0, [sp, #0x10]
106588f64: f00c2208    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106588f68: f947751a    	ldr	x26, [x8, #0xee8]
106588f6c: b00b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
106588f70: 910ce042    	add	x2, x2, #0x338
106588f74: f00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106588f78: 9130e063    	add	x3, x3, #0xc38
106588f7c: aa1a03e1    	mov	x1, x26
106588f80: 945a7b39    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588f84: aa1d03fd    	mov	x29, x29
106588f88: 945a7b3e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588f8c: aa0003fb    	mov	x27, x0
106588f90: f00c2228    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106588f94: f9471519    	ldr	x25, [x8, #0xe28]
106588f98: f94017e0    	ldr	x0, [sp, #0x28]
106588f9c: aa1903e1    	mov	x1, x25
106588fa0: aa1b03e2    	mov	x2, x27
106588fa4: aa1603e3    	mov	x3, x22
106588fa8: 945a7b2f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588fac: 4ea01c08    	mov.16b	v8, v0
106588fb0: f942f708    	ldr	x8, [x24, #0x5e8]
106588fb4: f90007e8    	str	x8, [sp, #0x8]
106588fb8: d00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106588fbc: f943c100    	ldr	x0, [x8, #0x780]
106588fc0: f90013fc    	str	x28, [sp, #0x20]
106588fc4: aa1c03e1    	mov	x1, x28
106588fc8: 945a7b27    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588fcc: aa1d03fd    	mov	x29, x29
106588fd0: 945a7b2c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588fd4: aa0003f8    	mov	x24, x0
106588fd8: f9462280    	ldr	x0, [x20, #0xc40]
106588fdc: aa1303e1    	mov	x1, x19
106588fe0: 945a7b21    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588fe4: aa0003e2    	mov	x2, x0
106588fe8: aa1803e0    	mov	x0, x24
106588fec: aa1703e1    	mov	x1, x23
106588ff0: 945a7b1d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106588ff4: aa1d03fd    	mov	x29, x29
106588ff8: 945a7b22    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106588ffc: aa0003f4    	mov	x20, x0
106589000: 900b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
106589004: 910d6042    	add	x2, x2, #0x358
106589008: f90017fa    	str	x26, [sp, #0x28]
10658900c: aa1a03e1    	mov	x1, x26
106589010: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589014: 9130e063    	add	x3, x3, #0xc38
106589018: 945a7b13    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658901c: aa1d03fd    	mov	x29, x29
106589020: 945a7b18    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589024: aa0003fc    	mov	x28, x0
106589028: f94007e0    	ldr	x0, [sp, #0x8]
10658902c: aa1903e1    	mov	x1, x25
106589030: aa1c03e2    	mov	x2, x28
106589034: aa1603e3    	mov	x3, x22
106589038: 945a7b0b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658903c: 0b150ea8    	add	w8, w21, w21, lsl #3
106589040: b00c3c55    	adrp	x21, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589044: 1288c9e9    	mov	w9, #-0x4650            ; =-18000
106589048: 0b090108    	add	w8, w8, w9
10658904c: 5289ba69    	mov	w9, #0x4dd3             ; =19923
106589050: 72a20c49    	movk	w9, #0x1062, lsl #16
106589054: 9ba97d08    	umull	x8, w8, w9
106589058: d366fd08    	lsr	x8, x8, #38
10658905c: 1e630101    	ucvtf	d1, w8
106589060: 1f412008    	fmadd	d8, d0, d1, d8
106589064: aa1c03e0    	mov	x0, x28
106589068: 945a7b02    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658906c: aa1403e0    	mov	x0, x20
106589070: f9400bf4    	ldr	x20, [sp, #0x10]
106589074: 945a7aff    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589078: aa1803e0    	mov	x0, x24
10658907c: d00c3c58    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
106589080: 945a7afc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589084: 1400006b    	b	0x106589230 <_Flutter_MMFoundation_BindContext+0x280fefc>
106589088: f942f71c    	ldr	x28, [x24, #0x5e8]
10658908c: f943c120    	ldr	x0, [x9, #0x780]
106589090: 900c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106589094: f9440101    	ldr	x1, [x8, #0x800]
106589098: f90013e1    	str	x1, [sp, #0x20]
10658909c: 945a7af2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065890a0: aa1d03fd    	mov	x29, x29
1065890a4: 945a7af7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065890a8: aa0003f9    	mov	x25, x0
1065890ac: f9462340    	ldr	x0, [x26, #0xc40]
1065890b0: b00c38e8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1065890b4: f9428513    	ldr	x19, [x8, #0x508]
1065890b8: aa1303e1    	mov	x1, x19
1065890bc: 945a7aea    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065890c0: aa0003e2    	mov	x2, x0
1065890c4: 900c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1065890c8: f9452117    	ldr	x23, [x8, #0xa40]
1065890cc: f9000ff9    	str	x25, [sp, #0x18]
1065890d0: aa1903e0    	mov	x0, x25
1065890d4: aa1703e1    	mov	x1, x23
1065890d8: 945a7ae3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065890dc: aa1d03fd    	mov	x29, x29
1065890e0: 945a7ae8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065890e4: aa0003f4    	mov	x20, x0
1065890e8: d00c2208    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1065890ec: f9477508    	ldr	x8, [x8, #0xee8]
1065890f0: f90017e8    	str	x8, [sp, #0x28]
1065890f4: 53057ea8    	lsr	w8, w21, #5
1065890f8: 711d491f    	cmp	w8, #0x752
1065890fc: 540015e8    	b.hi	0x1065893b8 <_Flutter_MMFoundation_BindContext+0x2810084>
106589100: 900b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
106589104: 910ce042    	add	x2, x2, #0x338
106589108: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
10658910c: 9130e063    	add	x3, x3, #0xc38
106589110: aa1403e0    	mov	x0, x20
106589114: f94017fa    	ldr	x26, [sp, #0x28]
106589118: aa1a03e1    	mov	x1, x26
10658911c: 945a7ad2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589120: aa1d03fd    	mov	x29, x29
106589124: 945a7ad7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589128: aa0003fb    	mov	x27, x0
10658912c: d00c2228    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106589130: f9471519    	ldr	x25, [x8, #0xe28]
106589134: aa1c03e0    	mov	x0, x28
106589138: aa1903e1    	mov	x1, x25
10658913c: aa1b03e2    	mov	x2, x27
106589140: aa1603e3    	mov	x3, x22
106589144: 945a7ac8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589148: 4ea01c08    	mov.16b	v8, v0
10658914c: f942f708    	ldr	x8, [x24, #0x5e8]
106589150: f90007e8    	str	x8, [sp, #0x8]
106589154: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589158: f943c100    	ldr	x0, [x8, #0x780]
10658915c: f94013e1    	ldr	x1, [sp, #0x20]
106589160: 945a7ac1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589164: aa1d03fd    	mov	x29, x29
106589168: 945a7ac6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658916c: aa0003fc    	mov	x28, x0
106589170: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589174: f9462100    	ldr	x0, [x8, #0xc40]
106589178: aa1303e1    	mov	x1, x19
10658917c: 945a7aba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589180: aa0003e2    	mov	x2, x0
106589184: aa1c03e0    	mov	x0, x28
106589188: aa1703e1    	mov	x1, x23
10658918c: 945a7ab6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589190: aa1d03fd    	mov	x29, x29
106589194: 945a7abb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589198: f9000bf3    	str	x19, [sp, #0x10]
10658919c: aa1403f3    	mov	x19, x20
1065891a0: aa0003f4    	mov	x20, x0
1065891a4: 900b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
1065891a8: 910d6042    	add	x2, x2, #0x358
1065891ac: aa1a03e1    	mov	x1, x26
1065891b0: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1065891b4: 9130e063    	add	x3, x3, #0xc38
1065891b8: 945a7aab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065891bc: aa1d03fd    	mov	x29, x29
1065891c0: 945a7ab0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065891c4: aa0003f8    	mov	x24, x0
1065891c8: f94007e0    	ldr	x0, [sp, #0x8]
1065891cc: aa1903e1    	mov	x1, x25
1065891d0: aa1803e2    	mov	x2, x24
1065891d4: aa1603e3    	mov	x3, x22
1065891d8: 945a7aa3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065891dc: 52800148    	mov	w8, #0xa                ; =10
1065891e0: 528f2c09    	mov	w9, #0x7960             ; =31072
1065891e4: 72bfffc9    	movk	w9, #0xfffe, lsl #16
1065891e8: 1b0826a8    	madd	w8, w21, w8, w9
1065891ec: 5282eb29    	mov	w9, #0x1759             ; =5977
1065891f0: 72ba36e9    	movk	w9, #0xd1b7, lsl #16
1065891f4: 9ba97d08    	umull	x8, w8, w9
1065891f8: d36dfd08    	lsr	x8, x8, #45
1065891fc: 11012108    	add	w8, w8, #0x48
106589200: 1e630101    	ucvtf	d1, w8
106589204: 1f412008    	fmadd	d8, d0, d1, d8
106589208: aa1803e0    	mov	x0, x24
10658920c: d00c3c58    	adrp	x24, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
106589210: 945a7a98    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589214: aa1403e0    	mov	x0, x20
106589218: aa1303f4    	mov	x20, x19
10658921c: f9400bf3    	ldr	x19, [sp, #0x10]
106589220: 945a7a94    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589224: aa1c03e0    	mov	x0, x28
106589228: 945a7a92    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658922c: b00c3c55    	adrp	x21, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589230: aa1b03e0    	mov	x0, x27
106589234: 945a7a8f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589238: aa1403e0    	mov	x0, x20
10658923c: 945a7a8d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589240: f9400fe0    	ldr	x0, [sp, #0x18]
106589244: 945a7a8b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589248: f942f714    	ldr	x20, [x24, #0x5e8]
10658924c: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589250: f943c100    	ldr	x0, [x8, #0x780]
106589254: f94013e1    	ldr	x1, [sp, #0x20]
106589258: 945a7a83    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658925c: aa1d03fd    	mov	x29, x29
106589260: 945a7a88    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589264: aa1803fc    	mov	x28, x24
106589268: aa0003f8    	mov	x24, x0
10658926c: f94622a0    	ldr	x0, [x21, #0xc40]
106589270: aa1303e1    	mov	x1, x19
106589274: 945a7a7c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589278: aa0003e2    	mov	x2, x0
10658927c: aa1803e0    	mov	x0, x24
106589280: aa1703e1    	mov	x1, x23
106589284: 945a7a78    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589288: aa1d03fd    	mov	x29, x29
10658928c: 945a7a7d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589290: aa0003fa    	mov	x26, x0
106589294: 900b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
106589298: 910de042    	add	x2, x2, #0x378
10658929c: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1065892a0: 9130e063    	add	x3, x3, #0xc38
1065892a4: f94017e1    	ldr	x1, [sp, #0x28]
1065892a8: 945a7a6f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065892ac: aa1d03fd    	mov	x29, x29
1065892b0: 945a7a74    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065892b4: aa0003fb    	mov	x27, x0
1065892b8: aa1403e0    	mov	x0, x20
1065892bc: aa1903e1    	mov	x1, x25
1065892c0: aa1b03e2    	mov	x2, x27
1065892c4: aa1603e3    	mov	x3, x22
1065892c8: 945a7a67    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065892cc: 4ea01c09    	mov.16b	v9, v0
1065892d0: aa1b03e0    	mov	x0, x27
1065892d4: 945a7a67    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065892d8: aa1a03e0    	mov	x0, x26
1065892dc: 945a7a65    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065892e0: aa1803e0    	mov	x0, x24
1065892e4: 945a7a63    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065892e8: 1e692100    	fcmp	d8, d9
1065892ec: 5400052d    	b.le	0x106589390 <_Flutter_MMFoundation_BindContext+0x281005c>
1065892f0: aa1603fa    	mov	x26, x22
1065892f4: f942f794    	ldr	x20, [x28, #0x5e8]
1065892f8: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065892fc: f943c100    	ldr	x0, [x8, #0x780]
106589300: f94013e1    	ldr	x1, [sp, #0x20]
106589304: 945a7a58    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589308: aa1d03fd    	mov	x29, x29
10658930c: 945a7a5d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589310: aa0003f8    	mov	x24, x0
106589314: f94622a0    	ldr	x0, [x21, #0xc40]
106589318: aa1303e1    	mov	x1, x19
10658931c: 945a7a52    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589320: aa0003e2    	mov	x2, x0
106589324: aa1803e0    	mov	x0, x24
106589328: aa1703e1    	mov	x1, x23
10658932c: 945a7a4e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589330: aa1d03fd    	mov	x29, x29
106589334: 945a7a53    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589338: aa0003f5    	mov	x21, x0
10658933c: 900b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
106589340: 910de042    	add	x2, x2, #0x378
106589344: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589348: 9130e063    	add	x3, x3, #0xc38
10658934c: f94017e1    	ldr	x1, [sp, #0x28]
106589350: 945a7a45    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589354: aa1d03fd    	mov	x29, x29
106589358: 945a7a4a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658935c: aa0003f6    	mov	x22, x0
106589360: aa1403e0    	mov	x0, x20
106589364: aa1903e1    	mov	x1, x25
106589368: aa1603e2    	mov	x2, x22
10658936c: aa1a03e3    	mov	x3, x26
106589370: 945a7a3d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589374: 4ea01c08    	mov.16b	v8, v0
106589378: aa1603e0    	mov	x0, x22
10658937c: 945a7a3d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589380: aa1503e0    	mov	x0, x21
106589384: 945a7a3b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589388: aa1803e0    	mov	x0, x24
10658938c: 945a7a39    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589390: 4ea81d00    	mov.16b	v0, v8
106589394: a9497bfd    	ldp	x29, x30, [sp, #0x90]
106589398: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10658939c: a94757f6    	ldp	x22, x21, [sp, #0x70]
1065893a0: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1065893a4: a94567fa    	ldp	x26, x25, [sp, #0x50]
1065893a8: a9446ffc    	ldp	x28, x27, [sp, #0x40]
1065893ac: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
1065893b0: 910283ff    	add	sp, sp, #0xa0
1065893b4: d65f03c0    	ret
1065893b8: 900b69a2    	adrp	x2, 0x11d2bd000 <dyld_stub_binder+0x11d2bd000>
1065893bc: 910de042    	add	x2, x2, #0x378
1065893c0: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1065893c4: 9130e063    	add	x3, x3, #0xc38
1065893c8: aa1403e0    	mov	x0, x20
1065893cc: f94017e1    	ldr	x1, [sp, #0x28]
1065893d0: 17fffeba    	b	0x106588eb8 <_Flutter_MMFoundation_BindContext+0x280fb84>
