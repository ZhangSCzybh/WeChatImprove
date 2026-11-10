
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a18988: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101a1898c: a90157f6    	stp	x22, x21, [sp, #0x10]
101a18990: a9024ff4    	stp	x20, x19, [sp, #0x20]
101a18994: a9037bfd    	stp	x29, x30, [sp, #0x30]
101a18998: 9100c3fd    	add	x29, sp, #0x30
101a1899c: aa0003f3    	mov	x19, x0
101a189a0: b00ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a189a4: 52800029    	mov	w9, #0x1                ; =1
101a189a8: 393b1109    	strb	w9, [x8, #0xec4]
101a189ac: d00e7f28    	adrp	x8, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
101a189b0: f9444d15    	ldr	x21, [x8, #0x898]
101a189b4: aa1503e1    	mov	x1, x21
101a189b8: 95883cab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a189bc: aa1d03fd    	mov	x29, x29
101a189c0: 95883cb0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a189c4: aa0003f4    	mov	x20, x0
101a189c8: 95883caa    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a189cc: b4000b74    	cbz	x20, 0x101a18b38 <__text+0x1a10b38>
101a189d0: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a189d4: f9449116    	ldr	x22, [x8, #0x920]
101a189d8: aa1303e0    	mov	x0, x19
101a189dc: aa1603e1    	mov	x1, x22
101a189e0: 95883ca1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a189e4: 7100341f    	cmp	w0, #0xd
101a189e8: 54000480    	b.eq	0x101a18a78 <__text+0x1a10a78>
101a189ec: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a189f0: f943c100    	ldr	x0, [x8, #0x780]
101a189f4: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a189f8: f9440101    	ldr	x1, [x8, #0x800]
101a189fc: 95883c9a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a00: aa1d03fd    	mov	x29, x29
101a18a04: 95883c9f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18a08: aa0003f7    	mov	x23, x0
101a18a0c: 900e97e8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a18a10: f9401d00    	ldr	x0, [x8, #0x38]
101a18a14: d00e9468    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a18a18: f9428501    	ldr	x1, [x8, #0x508]
101a18a1c: 95883c92    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a20: aa0003e2    	mov	x2, x0
101a18a24: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a18a28: f9452101    	ldr	x1, [x8, #0xa40]
101a18a2c: aa1703e0    	mov	x0, x23
101a18a30: 95883c8d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a34: aa1d03fd    	mov	x29, x29
101a18a38: 95883c92    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18a3c: aa0003f8    	mov	x24, x0
101a18a40: aa1303e0    	mov	x0, x19
101a18a44: aa1603e1    	mov	x1, x22
101a18a48: 95883c87    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a4c: aa0003e3    	mov	x3, x0
101a18a50: f00e7dc8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
101a18a54: f9440101    	ldr	x1, [x8, #0x800]
101a18a58: aa1803e0    	mov	x0, x24
101a18a5c: 52800002    	mov	w2, #0x0                ; =0
101a18a60: aa1303e4    	mov	x4, x19
101a18a64: 95883c80    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a68: aa1803e0    	mov	x0, x24
101a18a6c: 95883c81    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18a70: aa1703e0    	mov	x0, x23
101a18a74: 95883c7f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18a78: aa1303e0    	mov	x0, x19
101a18a7c: aa1503e1    	mov	x1, x21
101a18a80: 95883c79    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a84: aa1d03fd    	mov	x29, x29
101a18a88: 95883c7e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18a8c: aa0003f5    	mov	x21, x0
101a18a90: b00e9488    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
101a18a94: f946ad01    	ldr	x1, [x8, #0xd58]
101a18a98: 95883c73    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18a9c: aa1503e0    	mov	x0, x21
101a18aa0: 95883c74    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18aa4: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18aa8: f9434900    	ldr	x0, [x8, #0x690]
101a18aac: 95883c57    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
101a18ab0: d00e7dc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
101a18ab4: f9405901    	ldr	x1, [x8, #0xb0]
101a18ab8: 9e6703e0    	fmov	d0, xzr
101a18abc: 95883c6a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18ac0: aa0003f5    	mov	x21, x0
101a18ac4: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18ac8: b98ce508    	ldrsw	x8, [x8, #0xce4]
101a18acc: f8686a62    	ldr	x2, [x19, x8]
101a18ad0: b00e94a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101a18ad4: f9442501    	ldr	x1, [x8, #0x848]
101a18ad8: 95883c63    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18adc: 1e790008    	fcvtzu	w8, d0
101a18ae0: d00e9bc9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18ae4: b98ce929    	ldrsw	x9, [x9, #0xce8]
101a18ae8: b8696a6a    	ldr	w10, [x19, x9]
101a18aec: 52807d0b    	mov	w11, #0x3e8             ; =1000
101a18af0: 1b0b2908    	madd	w8, w8, w11, w10
101a18af4: b8296a68    	str	w8, [x19, x9]
101a18af8: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18afc: f9447101    	ldr	x1, [x8, #0x8e0]
101a18b00: aa1303e0    	mov	x0, x19
101a18b04: d2800002    	mov	x2, #0x0                ; =0
101a18b08: 95883c57    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18b0c: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18b10: f9449901    	ldr	x1, [x8, #0x930]
101a18b14: aa1303e0    	mov	x0, x19
101a18b18: 95883c53    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18b1c: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18b20: b98cdd08    	ldrsw	x8, [x8, #0xcdc]
101a18b24: 52800049    	mov	w9, #0x2                ; =2
101a18b28: 72a01fe9    	movk	w9, #0xff, lsl #16
101a18b2c: b8286a69    	str	w9, [x19, x8]
101a18b30: aa1503e0    	mov	x0, x21
101a18b34: 95883c4f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18b38: f100029f    	cmp	x20, #0x0
101a18b3c: 1a9f07e0    	cset	w0, ne
101a18b40: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101a18b44: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101a18b48: a94157f6    	ldp	x22, x21, [sp, #0x10]
101a18b4c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101a18b50: d65f03c0    	ret
