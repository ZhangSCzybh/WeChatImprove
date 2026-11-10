
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a180d4: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101a180d8: a9015ff8    	stp	x24, x23, [sp, #0x10]
101a180dc: a90257f6    	stp	x22, x21, [sp, #0x20]
101a180e0: a9034ff4    	stp	x20, x19, [sp, #0x30]
101a180e4: a9047bfd    	stp	x29, x30, [sp, #0x40]
101a180e8: 910103fd    	add	x29, sp, #0x40
101a180ec: aa0303f5    	mov	x21, x3
101a180f0: aa0203f3    	mov	x19, x2
101a180f4: aa0003f4    	mov	x20, x0
101a180f8: b00ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a180fc: 52800029    	mov	w9, #0x1                ; =1
101a18100: 393b0509    	strb	w9, [x8, #0xec1]
101a18104: aa0203e0    	mov	x0, x2
101a18108: 95883edb    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a1810c: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18110: f9447901    	ldr	x1, [x8, #0x8f0]
101a18114: aa1403e0    	mov	x0, x20
101a18118: 95883ed3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a1811c: aa1d03fd    	mov	x29, x29
101a18120: 95883ed8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18124: aa0003f6    	mov	x22, x0
101a18128: 95883ed2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a1812c: b4000516    	cbz	x22, 0x101a181cc <__text+0x1a101cc>
101a18130: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18134: f9434900    	ldr	x0, [x8, #0x690]
101a18138: 95883eb4    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
101a1813c: d00e7dc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
101a18140: f9405901    	ldr	x1, [x8, #0xb0]
101a18144: 9e6703e0    	fmov	d0, xzr
101a18148: 95883ec7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a1814c: aa0003f6    	mov	x22, x0
101a18150: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18154: b98ce508    	ldrsw	x8, [x8, #0xce4]
101a18158: f8686a82    	ldr	x2, [x20, x8]
101a1815c: b00e94a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101a18160: f9442501    	ldr	x1, [x8, #0x848]
101a18164: 95883ec0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18168: 1e790019    	fcvtzu	w25, d0
101a1816c: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18170: b98ce908    	ldrsw	x8, [x8, #0xce8]
101a18174: b8686a9a    	ldr	w26, [x20, x8]
101a18178: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a1817c: b98ced18    	ldrsw	x24, [x8, #0xcec]
101a18180: f8786a80    	ldr	x0, [x20, x24]
101a18184: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18188: f9447d17    	ldr	x23, [x8, #0x8f8]
101a1818c: aa1703e1    	mov	x1, x23
101a18190: 95883eb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18194: 12807ce8    	mov	w8, #-0x3e8             ; =-1000
101a18198: 4b1a03e9    	neg	w9, w26
101a1819c: 1b082728    	madd	w8, w25, w8, w9
101a181a0: 0b000108    	add	w8, w8, w0
101a181a4: 711f451f    	cmp	w8, #0x7d1
101a181a8: 540003a3    	b.lo	0x101a1821c <__text+0x1a1021c>
101a181ac: f8786a82    	ldr	x2, [x20, x24]
101a181b0: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a181b4: f9446d01    	ldr	x1, [x8, #0x8d8]
101a181b8: aa1403e0    	mov	x0, x20
101a181bc: 95883eaa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a181c0: aa1603e0    	mov	x0, x22
101a181c4: 95883eab    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a181c8: 14000003    	b	0x101a181d4 <__text+0x1a101d4>
101a181cc: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a181d0: f9447d17    	ldr	x23, [x8, #0x8f8]
101a181d4: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a181d8: f9446901    	ldr	x1, [x8, #0x8d0]
101a181dc: aa1403e0    	mov	x0, x20
101a181e0: aa1303e2    	mov	x2, x19
101a181e4: 95883ea0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a181e8: aa1303e0    	mov	x0, x19
101a181ec: aa1703e1    	mov	x1, x23
101a181f0: 95883e9d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a181f4: 6b0002bf    	cmp	w21, w0
101a181f8: 1a9583e2    	csel	w2, wzr, w21, hi
101a181fc: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18200: b98cf108    	ldrsw	x8, [x8, #0xcf0]
101a18204: b8286a82    	str	w2, [x20, x8]
101a18208: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a1820c: f9448101    	ldr	x1, [x8, #0x900]
101a18210: aa1403e0    	mov	x0, x20
101a18214: 95883e94    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18218: 14000003    	b	0x101a18224 <__text+0x1a10224>
101a1821c: aa1603e0    	mov	x0, x22
101a18220: 95883e94    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18224: aa1303e0    	mov	x0, x19
101a18228: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101a1822c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101a18230: a94257f6    	ldp	x22, x21, [sp, #0x20]
101a18234: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101a18238: a8c567fa    	ldp	x26, x25, [sp], #0x50
101a1823c: 15883e8d    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
