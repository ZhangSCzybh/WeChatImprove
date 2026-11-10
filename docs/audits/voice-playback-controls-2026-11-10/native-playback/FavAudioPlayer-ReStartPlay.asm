
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a18b54: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101a18b58: a90157f6    	stp	x22, x21, [sp, #0x10]
101a18b5c: a9024ff4    	stp	x20, x19, [sp, #0x20]
101a18b60: a9037bfd    	stp	x29, x30, [sp, #0x30]
101a18b64: 9100c3fd    	add	x29, sp, #0x30
101a18b68: aa0003f3    	mov	x19, x0
101a18b6c: b00ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a18b70: 52800029    	mov	w9, #0x1                ; =1
101a18b74: 393b1509    	strb	w9, [x8, #0xec5]
101a18b78: d00e7f28    	adrp	x8, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
101a18b7c: f9444d14    	ldr	x20, [x8, #0x898]
101a18b80: aa1403e1    	mov	x1, x20
101a18b84: 95883c38    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18b88: aa1d03fd    	mov	x29, x29
101a18b8c: 95883c3d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18b90: aa0003f5    	mov	x21, x0
101a18b94: 95883c37    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18b98: b4000b55    	cbz	x21, 0x101a18d00 <__text+0x1a10d00>
101a18b9c: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18ba0: f9449115    	ldr	x21, [x8, #0x920]
101a18ba4: aa1303e0    	mov	x0, x19
101a18ba8: aa1503e1    	mov	x1, x21
101a18bac: 95883c2e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18bb0: 7100341f    	cmp	w0, #0xd
101a18bb4: 540004c0    	b.eq	0x101a18c4c <__text+0x1a10c4c>
101a18bb8: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18bbc: f943c100    	ldr	x0, [x8, #0x780]
101a18bc0: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a18bc4: f9440101    	ldr	x1, [x8, #0x800]
101a18bc8: 95883c27    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18bcc: aa1d03fd    	mov	x29, x29
101a18bd0: 95883c2c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18bd4: aa0003f6    	mov	x22, x0
101a18bd8: 900e97e8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a18bdc: f9401d00    	ldr	x0, [x8, #0x38]
101a18be0: d00e9468    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a18be4: f9428501    	ldr	x1, [x8, #0x508]
101a18be8: 95883c1f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18bec: aa0003e2    	mov	x2, x0
101a18bf0: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a18bf4: f9452101    	ldr	x1, [x8, #0xa40]
101a18bf8: aa1603e0    	mov	x0, x22
101a18bfc: 95883c1a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18c00: aa1d03fd    	mov	x29, x29
101a18c04: 95883c1f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18c08: aa0003f7    	mov	x23, x0
101a18c0c: aa1303e0    	mov	x0, x19
101a18c10: aa1503e1    	mov	x1, x21
101a18c14: 95883c14    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18c18: aa0003e3    	mov	x3, x0
101a18c1c: f00e7dc8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
101a18c20: f9440101    	ldr	x1, [x8, #0x800]
101a18c24: aa1703e0    	mov	x0, x23
101a18c28: 52800022    	mov	w2, #0x1                ; =1
101a18c2c: aa1303e4    	mov	x4, x19
101a18c30: 95883c0d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18c34: aa0003f5    	mov	x21, x0
101a18c38: aa1703e0    	mov	x0, x23
101a18c3c: 95883c0d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18c40: aa1603e0    	mov	x0, x22
101a18c44: 95883c0b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18c48: 340005d5    	cbz	w21, 0x101a18d00 <__text+0x1a10d00>
101a18c4c: aa1303e0    	mov	x0, x19
101a18c50: aa1403e1    	mov	x1, x20
101a18c54: 95883c04    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18c58: aa1d03fd    	mov	x29, x29
101a18c5c: 95883c09    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18c60: aa0003f4    	mov	x20, x0
101a18c64: d00e9488    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
101a18c68: f9442d01    	ldr	x1, [x8, #0x858]
101a18c6c: 95883bfe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18c70: aa1403e0    	mov	x0, x20
101a18c74: 95883bff    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18c78: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18c7c: f9434900    	ldr	x0, [x8, #0x690]
101a18c80: 95883be2    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
101a18c84: d00e7dc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
101a18c88: f9405901    	ldr	x1, [x8, #0xb0]
101a18c8c: 9e6703e0    	fmov	d0, xzr
101a18c90: 95883bf5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18c94: aa0003f4    	mov	x20, x0
101a18c98: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18c9c: f9447101    	ldr	x1, [x8, #0x8e0]
101a18ca0: aa1303e0    	mov	x0, x19
101a18ca4: aa1403e2    	mov	x2, x20
101a18ca8: 95883bef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18cac: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18cb0: f9449d01    	ldr	x1, [x8, #0x938]
101a18cb4: aa1303e0    	mov	x0, x19
101a18cb8: 95883beb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18cbc: 1e790008    	fcvtzu	w8, d0
101a18cc0: d00e9bc9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18cc4: b98cf129    	ldrsw	x9, [x9, #0xcf0]
101a18cc8: b8296a68    	str	w8, [x19, x9]
101a18ccc: 900e7de8    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
101a18cd0: f9435d01    	ldr	x1, [x8, #0x6b8]
101a18cd4: aa1303e0    	mov	x0, x19
101a18cd8: 95883be3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18cdc: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18ce0: b98cdd08    	ldrsw	x8, [x8, #0xcdc]
101a18ce4: 52800029    	mov	w9, #0x1                ; =1
101a18ce8: 72a01fe9    	movk	w9, #0xff, lsl #16
101a18cec: b8286a69    	str	w9, [x19, x8]
101a18cf0: aa1403e0    	mov	x0, x20
101a18cf4: 95883bdf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18cf8: 52800020    	mov	w0, #0x1                ; =1
101a18cfc: 14000002    	b	0x101a18d04 <__text+0x1a10d04>
101a18d00: 52800000    	mov	w0, #0x0                ; =0
101a18d04: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101a18d08: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101a18d0c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101a18d10: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101a18d14: d65f03c0    	ret
