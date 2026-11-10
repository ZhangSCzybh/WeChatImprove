
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565cef0: d101c3ff    	sub	sp, sp, #0x70
10565cef4: a9016ffc    	stp	x28, x27, [sp, #0x10]
10565cef8: a90267fa    	stp	x26, x25, [sp, #0x20]
10565cefc: a9035ff8    	stp	x24, x23, [sp, #0x30]
10565cf00: a90457f6    	stp	x22, x21, [sp, #0x40]
10565cf04: a9054ff4    	stp	x20, x19, [sp, #0x50]
10565cf08: a9067bfd    	stp	x29, x30, [sp, #0x60]
10565cf0c: 910183fd    	add	x29, sp, #0x60
10565cf10: aa0303f4    	mov	x20, x3
10565cf14: aa0203f3    	mov	x19, x2
10565cf18: aa0003f5    	mov	x21, x0
10565cf1c: f00d07a8    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
10565cf20: 52800029    	mov	w9, #0x1                ; =1
10565cf24: 39301909    	strb	w9, [x8, #0xc06]
10565cf28: aa0203e0    	mov	x0, x2
10565cf2c: 94972b52    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10565cf30: 36000e54    	tbz	w20, #0x0, 0x10565d0f8 <_Flutter_MMFoundation_BindContext+0x18e3dc4>
10565cf34: d00cb5bb    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565cf38: f943c360    	ldr	x0, [x27, #0x780]
10565cf3c: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565cf40: f9440115    	ldr	x21, [x8, #0x800]
10565cf44: aa1503e1    	mov	x1, x21
10565cf48: 94972b47    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cf4c: aa1d03fd    	mov	x29, x29
10565cf50: 94972b4c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cf54: aa0003f8    	mov	x24, x0
10565cf58: d00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565cf5c: f9469100    	ldr	x0, [x8, #0xd20]
10565cf60: d00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565cf64: f9428516    	ldr	x22, [x8, #0x508]
10565cf68: aa1603e1    	mov	x1, x22
10565cf6c: 94972b3e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cf70: aa0003e2    	mov	x2, x0
10565cf74: b00c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565cf78: f9452117    	ldr	x23, [x8, #0xa40]
10565cf7c: aa1803e0    	mov	x0, x24
10565cf80: aa1703e1    	mov	x1, x23
10565cf84: 94972b38    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cf88: aa1d03fd    	mov	x29, x29
10565cf8c: 94972b3d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cf90: aa0003f9    	mov	x25, x0
10565cf94: d00c9ba8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
10565cf98: f9449d01    	ldr	x1, [x8, #0x938]
10565cf9c: 94972b32    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cfa0: aa1d03fd    	mov	x29, x29
10565cfa4: 94972b37    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cfa8: aa0003fa    	mov	x26, x0
10565cfac: 900c9ba8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
10565cfb0: f9424501    	ldr	x1, [x8, #0x488]
10565cfb4: 94972b2c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cfb8: aa1d03fd    	mov	x29, x29
10565cfbc: 94972b31    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cfc0: aa0003f4    	mov	x20, x0
10565cfc4: aa1a03e0    	mov	x0, x26
10565cfc8: 94972b2a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cfcc: aa1903e0    	mov	x0, x25
10565cfd0: 94972b28    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cfd4: aa1803e0    	mov	x0, x24
10565cfd8: 94972b26    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565cfdc: 900cb5c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565cfe0: f9471118    	ldr	x24, [x8, #0xe20]
10565cfe4: b00cb288    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10565cfe8: f9472901    	ldr	x1, [x8, #0xe50]
10565cfec: aa1403e0    	mov	x0, x20
10565cff0: 94972b1d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565cff4: aa1d03fd    	mov	x29, x29
10565cff8: 94972b22    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565cffc: aa0003f9    	mov	x25, x0
10565d000: b00c9be8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
10565d004: f945a501    	ldr	x1, [x8, #0xb48]
10565d008: aa1803e0    	mov	x0, x24
10565d00c: aa1903e2    	mov	x2, x25
10565d010: 94972b15    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d014: aa0003f8    	mov	x24, x0
10565d018: aa1903e0    	mov	x0, x25
10565d01c: 94972b15    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d020: b00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565d024: f9446500    	ldr	x0, [x8, #0x8c8]
10565d028: f00cb248    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10565d02c: f9455d01    	ldr	x1, [x8, #0xab8]
10565d030: 94972b0d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d034: 34000ee0    	cbz	w0, 0x10565d210 <_Flutter_MMFoundation_BindContext+0x18e3edc>
10565d038: f943c360    	ldr	x0, [x27, #0x780]
10565d03c: aa1503e1    	mov	x1, x21
10565d040: 94972b09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d044: aa1d03fd    	mov	x29, x29
10565d048: 94972b0e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d04c: aa0003f5    	mov	x21, x0
10565d050: f00cb5a8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565d054: f940b900    	ldr	x0, [x8, #0x170]
10565d058: aa1603e1    	mov	x1, x22
10565d05c: 94972b02    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d060: aa0003e2    	mov	x2, x0
10565d064: aa1503e0    	mov	x0, x21
10565d068: aa1703e1    	mov	x1, x23
10565d06c: 94972afe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d070: aa1d03fd    	mov	x29, x29
10565d074: 94972b03    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d078: aa0003f6    	mov	x22, x0
10565d07c: b00cb5a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565d080: f9431d17    	ldr	x23, [x8, #0x638]
10565d084: f00c9b68    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10565d088: f947e501    	ldr	x1, [x8, #0xfc8]
10565d08c: aa1303e0    	mov	x0, x19
10565d090: 94972af5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d094: 900cb288    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10565d098: f942e501    	ldr	x1, [x8, #0x5c8]
10565d09c: f90003e0    	str	x0, [sp]
10565d0a0: b00bca22    	adrp	x2, 0x11cfa2000 <dyld_stub_binder+0x11cfa2000>
10565d0a4: 912be042    	add	x2, x2, #0xaf8
10565d0a8: aa1703e0    	mov	x0, x23
10565d0ac: 94972aee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d0b0: aa1d03fd    	mov	x29, x29
10565d0b4: 94972af3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d0b8: aa0003f7    	mov	x23, x0
10565d0bc: b00ca448    	adrp	x8, 0x11eae6000 <dyld_stub_binder+0x11eae6000>
10565d0c0: f9471901    	ldr	x1, [x8, #0xe30]
10565d0c4: 52000305    	eor	w5, w24, #0x1
10565d0c8: aa1603e0    	mov	x0, x22
10565d0cc: 528000c2    	mov	w2, #0x6                ; =6
10565d0d0: d2800003    	mov	x3, #0x0                ; =0
10565d0d4: aa1703e4    	mov	x4, x23
10565d0d8: 94972ae3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d0dc: aa1703e0    	mov	x0, x23
10565d0e0: 94972ae4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d0e4: aa1603e0    	mov	x0, x22
10565d0e8: 94972ae2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d0ec: aa1503e0    	mov	x0, x21
10565d0f0: 94972ae0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d0f4: 14000047    	b	0x10565d210 <_Flutter_MMFoundation_BindContext+0x18e3edc>
10565d0f8: d00c9b88    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10565d0fc: f9434901    	ldr	x1, [x8, #0x690]
10565d100: aa1303e0    	mov	x0, x19
10565d104: 94972ad8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d108: aa1d03fd    	mov	x29, x29
10565d10c: 94972add    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d110: aa0003f4    	mov	x20, x0
10565d114: b00cb5bb    	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10565d118: f943c360    	ldr	x0, [x27, #0x780]
10565d11c: 900c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565d120: f9440117    	ldr	x23, [x8, #0x800]
10565d124: aa1703e1    	mov	x1, x23
10565d128: 94972acf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d12c: aa1d03fd    	mov	x29, x29
10565d130: 94972ad4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d134: aa0003f6    	mov	x22, x0
10565d138: f00cb5a8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10565d13c: f9401d00    	ldr	x0, [x8, #0x38]
10565d140: b00cb248    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10565d144: f9428518    	ldr	x24, [x8, #0x508]
10565d148: aa1803e1    	mov	x1, x24
10565d14c: 94972ac6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d150: aa0003e2    	mov	x2, x0
10565d154: 900c9b68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10565d158: f9452119    	ldr	x25, [x8, #0xa40]
10565d15c: aa1603e0    	mov	x0, x22
10565d160: aa1903e1    	mov	x1, x25
10565d164: 94972ac0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d168: aa1d03fd    	mov	x29, x29
10565d16c: 94972ac5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d170: aa0003fa    	mov	x26, x0
10565d174: f943c360    	ldr	x0, [x27, #0x780]
10565d178: aa1703e1    	mov	x1, x23
10565d17c: 94972aba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d180: aa1d03fd    	mov	x29, x29
10565d184: 94972abf    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d188: aa0003f7    	mov	x23, x0
10565d18c: 900cb5c8    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10565d190: f940fd00    	ldr	x0, [x8, #0x1f8]
10565d194: aa1803e1    	mov	x1, x24
10565d198: 94972ab3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d19c: aa0003e2    	mov	x2, x0
10565d1a0: aa1703e0    	mov	x0, x23
10565d1a4: aa1903e1    	mov	x1, x25
10565d1a8: 94972aaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d1ac: aa1d03fd    	mov	x29, x29
10565d1b0: 94972ab4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10565d1b4: aa0003f8    	mov	x24, x0
10565d1b8: f00c9e28    	adrp	x8, 0x11ea24000 <dyld_stub_binder+0x11ea24000>
10565d1bc: f9430101    	ldr	x1, [x8, #0x600]
10565d1c0: aa1a03e0    	mov	x0, x26
10565d1c4: 52800002    	mov	w2, #0x0                ; =0
10565d1c8: 52800003    	mov	w3, #0x0                ; =0
10565d1cc: aa1403e4    	mov	x4, x20
10565d1d0: aa1803e5    	mov	x5, x24
10565d1d4: 94972aa4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10565d1d8: aa1803e0    	mov	x0, x24
10565d1dc: 94972aa5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d1e0: aa1703e0    	mov	x0, x23
10565d1e4: 94972aa3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d1e8: aa1a03e0    	mov	x0, x26
10565d1ec: 94972aa1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d1f0: aa1603e0    	mov	x0, x22
10565d1f4: 94972a9f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d1f8: f00cbb68    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565d1fc: b9880508    	ldrsw	x8, [x8, #0x804]
10565d200: 38286abf    	strb	wzr, [x21, x8]
10565d204: f00cbb68    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565d208: b9880108    	ldrsw	x8, [x8, #0x800]
10565d20c: b8286abf    	str	wzr, [x21, x8]
10565d210: aa1403e0    	mov	x0, x20
10565d214: 94972a97    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10565d218: aa1303e0    	mov	x0, x19
10565d21c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10565d220: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10565d224: a94457f6    	ldp	x22, x21, [sp, #0x40]
10565d228: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10565d22c: a94267fa    	ldp	x26, x25, [sp, #0x20]
10565d230: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10565d234: 9101c3ff    	add	sp, sp, #0x70
10565d238: 14972a8e    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
