
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fdfd38: d10203ff    	sub	sp, sp, #0x80
100fdfd3c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
100fdfd40: a9026ffc    	stp	x28, x27, [sp, #0x20]
100fdfd44: a90367fa    	stp	x26, x25, [sp, #0x30]
100fdfd48: a9045ff8    	stp	x24, x23, [sp, #0x40]
100fdfd4c: a90557f6    	stp	x22, x21, [sp, #0x50]
100fdfd50: a9064ff4    	stp	x20, x19, [sp, #0x60]
100fdfd54: a9077bfd    	stp	x29, x30, [sp, #0x70]
100fdfd58: 9101c3fd    	add	x29, sp, #0x70
100fdfd5c: 4ea01c08    	mov.16b	v8, v0
100fdfd60: aa0003f3    	mov	x19, x0
100fdfd64: 900f3b28    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fdfd68: 52800029    	mov	w9, #0x1                ; =1
100fdfd6c: 3922cd09    	strb	w9, [x8, #0x8b3]
100fdfd70: b00ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fdfd74: f9438114    	ldr	x20, [x8, #0x700]
100fdfd78: aa1403e1    	mov	x1, x20
100fdfd7c: 95b11fba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfd80: b00ecf88    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100fdfd84: f943e908    	ldr	x8, [x8, #0x7d0]
100fdfd88: 1e602008    	fcmp	d0, #0.0
100fdfd8c: 9a88c281    	csel	x1, x20, x8, gt
100fdfd90: aa1303e0    	mov	x0, x19
100fdfd94: 95b11fb4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfd98: 4ea01c09    	mov.16b	v9, v0
100fdfd9c: f00ee628    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fdfda0: f9469d16    	ldr	x22, [x8, #0xd38]
100fdfda4: aa1303e0    	mov	x0, x19
100fdfda8: aa1603e1    	mov	x1, x22
100fdfdac: 95b11fae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfdb0: aa1d03fd    	mov	x29, x29
100fdfdb4: 95b11fb3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfdb8: b40004c0    	cbz	x0, 0x100fdfe50 <__text+0xfd7e50>
100fdfdbc: aa0003f4    	mov	x20, x0
100fdfdc0: aa1303e0    	mov	x0, x19
100fdfdc4: aa1603e1    	mov	x1, x22
100fdfdc8: 95b11fa7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfdcc: aa1d03fd    	mov	x29, x29
100fdfdd0: 95b11fac    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfdd4: aa0003f5    	mov	x21, x0
100fdfdd8: b00ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fdfddc: f9438917    	ldr	x23, [x8, #0x710]
100fdfde0: f00ee648    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
100fdfde4: f9440501    	ldr	x1, [x8, #0x808]
100fdfde8: aa1703e2    	mov	x2, x23
100fdfdec: 95b11f9e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfdf0: 36000280    	tbz	w0, #0x0, 0x100fdfe40 <__text+0xfd7e40>
100fdfdf4: aa1303e0    	mov	x0, x19
100fdfdf8: aa1603e1    	mov	x1, x22
100fdfdfc: 95b11f9a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfe00: aa1d03fd    	mov	x29, x29
100fdfe04: 95b11f9f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfe08: aa0003f6    	mov	x22, x0
100fdfe0c: aa1703e1    	mov	x1, x23
100fdfe10: 95b11f95    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfe14: aa0003f7    	mov	x23, x0
100fdfe18: aa1603e0    	mov	x0, x22
100fdfe1c: 95b11f95    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfe20: aa1503e0    	mov	x0, x21
100fdfe24: 95b11f93    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfe28: aa1403e0    	mov	x0, x20
100fdfe2c: 95b11f91    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfe30: 36000117    	tbz	w23, #0x0, 0x100fdfe50 <__text+0xfd7e50>
100fdfe34: b00ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fdfe38: 911c6108    	add	x8, x8, #0x718
100fdfe3c: 14000007    	b	0x100fdfe58 <__text+0xfd7e58>
100fdfe40: aa1503e0    	mov	x0, x21
100fdfe44: 95b11f8b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfe48: aa1403e0    	mov	x0, x20
100fdfe4c: 95b11f89    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfe50: 900ed088    	adrp	x8, 0x11e9ef000 <dyld_stub_binder+0x11e9ef000>
100fdfe54: 913a2108    	add	x8, x8, #0xe88
100fdfe58: f00ee989    	adrp	x9, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdfe5c: f9442120    	ldr	x0, [x9, #0x840]
100fdfe60: 1e790122    	fcvtzu	w2, d9
100fdfe64: f9400101    	ldr	x1, [x8]
100fdfe68: 95b11f7f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfe6c: aa1d03fd    	mov	x29, x29
100fdfe70: 95b11f84    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfe74: d00eed48    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fdfe78: b9846114    	ldrsw	x20, [x8, #0x460]
100fdfe7c: f8746a68    	ldr	x8, [x19, x20]
100fdfe80: f8346a60    	str	x0, [x19, x20]
100fdfe84: aa0803e0    	mov	x0, x8
100fdfe88: 95b11f7a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdfe8c: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdfe90: f946391b    	ldr	x27, [x8, #0xc70]
100fdfe94: f8746a68    	ldr	x8, [x19, x20]
100fdfe98: f90007e8    	str	x8, [sp, #0x8]
100fdfe9c: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdfea0: f944d900    	ldr	x0, [x8, #0x9b0]
100fdfea4: d00ecf68    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
100fdfea8: f946f501    	ldr	x1, [x8, #0xde8]
100fdfeac: aa1303e2    	mov	x2, x19
100fdfeb0: 95b11f6d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfeb4: 4ea01c09    	mov.16b	v9, v0
100fdfeb8: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdfebc: f9461d1c    	ldr	x28, [x8, #0xc38]
100fdfec0: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdfec4: f943c100    	ldr	x0, [x8, #0x780]
100fdfec8: d00ecf48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fdfecc: f9440114    	ldr	x20, [x8, #0x800]
100fdfed0: aa1403e1    	mov	x1, x20
100fdfed4: 95b11f64    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfed8: aa1d03fd    	mov	x29, x29
100fdfedc: 95b11f69    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdfee0: aa0003f9    	mov	x25, x0
100fdfee4: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdfee8: f9462100    	ldr	x0, [x8, #0xc40]
100fdfeec: f00ee628    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fdfef0: f9428515    	ldr	x21, [x8, #0x508]
100fdfef4: aa1503e1    	mov	x1, x21
100fdfef8: 95b11f5b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfefc: aa0003e2    	mov	x2, x0
100fdff00: d00ecf48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fdff04: f9452116    	ldr	x22, [x8, #0xa40]
100fdff08: aa1903e0    	mov	x0, x25
100fdff0c: aa1603e1    	mov	x1, x22
100fdff10: 95b11f55    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdff14: aa1d03fd    	mov	x29, x29
100fdff18: 95b11f5a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdff1c: aa0003f8    	mov	x24, x0
100fdff20: 900ecf68    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fdff24: f9477517    	ldr	x23, [x8, #0xee8]
100fdff28: d00e0322    	adrp	x2, 0x11d045000 <dyld_stub_binder+0x11d045000>
100fdff2c: 913ce042    	add	x2, x2, #0xf38
100fdff30: 900dfe43    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
100fdff34: 9130e063    	add	x3, x3, #0xc38
100fdff38: aa1703e1    	mov	x1, x23
100fdff3c: 95b11f4a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdff40: aa1d03fd    	mov	x29, x29
100fdff44: 95b11f4f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdff48: aa0003fa    	mov	x26, x0
100fdff4c: d00ecf68    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
100fdff50: f9402901    	ldr	x1, [x8, #0x50]
100fdff54: aa1c03e0    	mov	x0, x28
100fdff58: aa1a03e2    	mov	x2, x26
100fdff5c: 95b11f42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdff60: aa1d03fd    	mov	x29, x29
100fdff64: 95b11f47    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdff68: aa0003fc    	mov	x28, x0
100fdff6c: b00ecf88    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100fdff70: f9422501    	ldr	x1, [x8, #0x448]
100fdff74: aa1b03e0    	mov	x0, x27
100fdff78: f94007e2    	ldr	x2, [sp, #0x8]
100fdff7c: 4ea91d20    	mov.16b	v0, v9
100fdff80: aa1c03e3    	mov	x3, x28
100fdff84: 95b11f38    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdff88: 1e649001    	fmov	d1, #10.00000000
100fdff8c: 1e612800    	fadd	d0, d0, d1
100fdff90: d00eed48    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fdff94: b9846508    	ldrsw	x8, [x8, #0x464]
100fdff98: fc286a60    	str	d0, [x19, x8]
100fdff9c: aa1c03e0    	mov	x0, x28
100fdffa0: 95b11f34    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdffa4: aa1a03e0    	mov	x0, x26
100fdffa8: 95b11f32    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdffac: aa1803e0    	mov	x0, x24
100fdffb0: 95b11f30    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdffb4: aa1903e0    	mov	x0, x25
100fdffb8: 95b11f2e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fdffbc: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdffc0: f9461d18    	ldr	x24, [x8, #0xc38]
100fdffc4: f00ee99c    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdffc8: f943c380    	ldr	x0, [x28, #0x780]
100fdffcc: aa1403e1    	mov	x1, x20
100fdffd0: 95b11f25    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdffd4: aa1d03fd    	mov	x29, x29
100fdffd8: 95b11f2a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fdffdc: aa0003f9    	mov	x25, x0
100fdffe0: f00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fdffe4: f9462100    	ldr	x0, [x8, #0xc40]
100fdffe8: aa1503e1    	mov	x1, x21
100fdffec: 95b11f1e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fdfff0: aa0003e2    	mov	x2, x0
100fdfff4: aa1903e0    	mov	x0, x25
100fdfff8: aa1603e1    	mov	x1, x22
100fdfffc: 95b11f1a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0000: aa1d03fd    	mov	x29, x29
100fe0004: 95b11f1f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe0008: aa0003fa    	mov	x26, x0
100fe000c: d00dfe42    	adrp	x2, 0x11cfaa000 <dyld_stub_binder+0x11cfaa000>
100fe0010: 912e6042    	add	x2, x2, #0xb98
100fe0014: d00dfe43    	adrp	x3, 0x11cfaa000 <dyld_stub_binder+0x11cfaa000>
100fe0018: 912ee063    	add	x3, x3, #0xbb8
100fe001c: aa1703e1    	mov	x1, x23
100fe0020: 95b11f11    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0024: aa1d03fd    	mov	x29, x29
100fe0028: 95b11f16    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe002c: aa0003fb    	mov	x27, x0
100fe0030: f00ecf48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fe0034: f9477901    	ldr	x1, [x8, #0xef0]
100fe0038: aa1803e0    	mov	x0, x24
100fe003c: aa1b03e2    	mov	x2, x27
100fe0040: 95b11f09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0044: 4ea01c09    	mov.16b	v9, v0
100fe0048: f00ee988    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
100fe004c: f942f518    	ldr	x24, [x8, #0x5e8]
100fe0050: f943c380    	ldr	x0, [x28, #0x780]
100fe0054: aa1403e1    	mov	x1, x20
100fe0058: 95b11f03    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe005c: aa1d03fd    	mov	x29, x29
100fe0060: 95b11f08    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe0064: aa0003f4    	mov	x20, x0
100fe0068: d00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fe006c: f9462100    	ldr	x0, [x8, #0xc40]
100fe0070: aa1503e1    	mov	x1, x21
100fe0074: 95b11efc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0078: aa0003e2    	mov	x2, x0
100fe007c: aa1403e0    	mov	x0, x20
100fe0080: aa1603e1    	mov	x1, x22
100fe0084: 95b11ef8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0088: aa1d03fd    	mov	x29, x29
100fe008c: 95b11efd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe0090: aa0003f5    	mov	x21, x0
100fe0094: b00e0322    	adrp	x2, 0x11d045000 <dyld_stub_binder+0x11d045000>
100fe0098: 913d6042    	add	x2, x2, #0xf58
100fe009c: aa1703e1    	mov	x1, x23
100fe00a0: f00dfe23    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
100fe00a4: 9130e063    	add	x3, x3, #0xc38
100fe00a8: 95b11eef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe00ac: aa1d03fd    	mov	x29, x29
100fe00b0: 95b11ef4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe00b4: aa0003f6    	mov	x22, x0
100fe00b8: f00ecf68    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
100fe00bc: f9471501    	ldr	x1, [x8, #0xe28]
100fe00c0: aa1803e0    	mov	x0, x24
100fe00c4: aa1603e2    	mov	x2, x22
100fe00c8: aa1303e3    	mov	x3, x19
100fe00cc: 95b11ee6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe00d0: 1e601001    	fmov	d1, #2.00000000
100fe00d4: 1f410129    	fmadd	d9, d9, d1, d0
100fe00d8: aa1603e0    	mov	x0, x22
100fe00dc: 95b11ee5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe00e0: aa1503e0    	mov	x0, x21
100fe00e4: 95b11ee3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe00e8: aa1403e0    	mov	x0, x20
100fe00ec: 95b11ee1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe00f0: aa1b03e0    	mov	x0, x27
100fe00f4: 95b11edf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe00f8: aa1a03e0    	mov	x0, x26
100fe00fc: 95b11edd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe0100: aa1903e0    	mov	x0, x25
100fe0104: 95b11edb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe0108: 900ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fe010c: f9439101    	ldr	x1, [x8, #0x720]
100fe0110: aa1303e0    	mov	x0, x19
100fe0114: 95b11ed4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0118: 340000e0    	cbz	w0, 0x100fe0134 <__text+0xfd8134>
100fe011c: b00eed48    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
100fe0120: b9846908    	ldrsw	x8, [x8, #0x468]
100fe0124: fc686a60    	ldr	d0, [x19, x8]
100fe0128: 1e661001    	fmov	d1, #16.00000000
100fe012c: 1e612800    	fadd	d0, d0, d1
100fe0130: 1e602929    	fadd	d9, d9, d0
100fe0134: 4ea81d00    	mov.16b	v0, v8
100fe0138: 4ea91d21    	mov.16b	v1, v9
100fe013c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100fe0140: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100fe0144: a94557f6    	ldp	x22, x21, [sp, #0x50]
100fe0148: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100fe014c: a94367fa    	ldp	x26, x25, [sp, #0x30]
100fe0150: a9426ffc    	ldp	x28, x27, [sp, #0x20]
100fe0154: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
100fe0158: 910203ff    	add	sp, sp, #0x80
100fe015c: d65f03c0    	ret
