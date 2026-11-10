
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a18f7c: d10203ff    	sub	sp, sp, #0x80
101a18f80: a90367fa    	stp	x26, x25, [sp, #0x30]
101a18f84: a9045ff8    	stp	x24, x23, [sp, #0x40]
101a18f88: a90557f6    	stp	x22, x21, [sp, #0x50]
101a18f8c: a9064ff4    	stp	x20, x19, [sp, #0x60]
101a18f90: a9077bfd    	stp	x29, x30, [sp, #0x70]
101a18f94: 9101c3fd    	add	x29, sp, #0x70
101a18f98: aa0003f4    	mov	x20, x0
101a18f9c: b00ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a18fa0: 52800029    	mov	w9, #0x1                ; =1
101a18fa4: 393b1d09    	strb	w9, [x8, #0xec7]
101a18fa8: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18fac: b98cf508    	ldrsw	x8, [x8, #0xcf4]
101a18fb0: f8686800    	ldr	x0, [x0, x8]
101a18fb4: b4000080    	cbz	x0, 0x101a18fc4 <__text+0x1a10fc4>
101a18fb8: b00e8175    	adrp	x21, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18fbc: 912362b5    	add	x21, x21, #0x8d8
101a18fc0: 14000006    	b	0x101a18fd8 <__text+0x1a10fd8>
101a18fc4: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18fc8: b98ced08    	ldrsw	x8, [x8, #0xcec]
101a18fcc: f8686a80    	ldr	x0, [x20, x8]
101a18fd0: b00e8175    	adrp	x21, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18fd4: 912342b5    	add	x21, x21, #0x8d0
101a18fd8: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18fdc: f944ad01    	ldr	x1, [x8, #0x958]
101a18fe0: 95883b21    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18fe4: aa1d03fd    	mov	x29, x29
101a18fe8: 95883b26    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18fec: aa0003f3    	mov	x19, x0
101a18ff0: f94002a1    	ldr	x1, [x21]
101a18ff4: aa1403e0    	mov	x0, x20
101a18ff8: d2800002    	mov	x2, #0x0                ; =0
101a18ffc: 95883b1a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19000: b00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a19004: b98cdd08    	ldrsw	x8, [x8, #0xcdc]
101a19008: 52800069    	mov	w9, #0x3                ; =3
101a1900c: 72a01fe9    	movk	w9, #0xff, lsl #16
101a19010: b8286a89    	str	w9, [x20, x8]
101a19014: b00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a19018: b98cf108    	ldrsw	x8, [x8, #0xcf0]
101a1901c: b8286a9f    	str	wzr, [x20, x8]
101a19020: 900e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a19024: f9449901    	ldr	x1, [x8, #0x930]
101a19028: aa1403e0    	mov	x0, x20
101a1902c: 95883b0e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19030: 900e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a19034: f9449116    	ldr	x22, [x8, #0x920]
101a19038: aa1403e0    	mov	x0, x20
101a1903c: aa1603e1    	mov	x1, x22
101a19040: 95883b09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19044: 900e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a19048: f9440115    	ldr	x21, [x8, #0x800]
101a1904c: b00e97d9    	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a19050: 7100341f    	cmp	w0, #0xd
101a19054: 54000440    	b.eq	0x101a190dc <__text+0x1a110dc>
101a19058: f943c320    	ldr	x0, [x25, #0x780]
101a1905c: aa1503e1    	mov	x1, x21
101a19060: 95883b01    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19064: aa1d03fd    	mov	x29, x29
101a19068: 95883b06    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a1906c: aa0003f7    	mov	x23, x0
101a19070: f00e97c8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a19074: f9401d00    	ldr	x0, [x8, #0x38]
101a19078: b00e9468    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a1907c: f9428501    	ldr	x1, [x8, #0x508]
101a19080: 95883af9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19084: aa0003e2    	mov	x2, x0
101a19088: 900e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a1908c: f9452101    	ldr	x1, [x8, #0xa40]
101a19090: aa1703e0    	mov	x0, x23
101a19094: 95883af4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a19098: aa1d03fd    	mov	x29, x29
101a1909c: 95883af9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a190a0: aa0003f8    	mov	x24, x0
101a190a4: aa1403e0    	mov	x0, x20
101a190a8: aa1603e1    	mov	x1, x22
101a190ac: 95883aee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a190b0: aa0003e3    	mov	x3, x0
101a190b4: d00e7dc8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
101a190b8: f9440101    	ldr	x1, [x8, #0x800]
101a190bc: aa1803e0    	mov	x0, x24
101a190c0: 52800002    	mov	w2, #0x0                ; =0
101a190c4: aa1403e4    	mov	x4, x20
101a190c8: 95883ae7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a190cc: aa1803e0    	mov	x0, x24
101a190d0: 95883ae8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a190d4: aa1703e0    	mov	x0, x23
101a190d8: 95883ae6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a190dc: f943c320    	ldr	x0, [x25, #0x780]
101a190e0: aa1503e1    	mov	x1, x21
101a190e4: 95883ae0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a190e8: aa1d03fd    	mov	x29, x29
101a190ec: 95883ae5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a190f0: aa0003f4    	mov	x20, x0
101a190f4: f00e97a8    	adrp	x8, 0x11ed10000 <dyld_stub_binder+0x11ed10000>
101a190f8: f9402d15    	ldr	x21, [x8, #0x58]
101a190fc: 900e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a19100: f944b116    	ldr	x22, [x8, #0x960]
101a19104: f00de988    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
101a19108: f9449908    	ldr	x8, [x8, #0x930]
101a1910c: f90007e8    	str	x8, [sp, #0x8]
101a19110: d00af568    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
101a19114: fd434100    	ldr	d0, [x8, #0x680]
101a19118: 90000008    	adrp	x8, 0x101a19000 <__text+0x1a11000>
101a1911c: 91064108    	add	x8, x8, #0x190
101a19120: f00d4329    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
101a19124: 911f8129    	add	x9, x9, #0x7e0
101a19128: fd000be0    	str	d0, [sp, #0x10]
101a1912c: a901a7e8    	stp	x8, x9, [sp, #0x18]
101a19130: f90017f3    	str	x19, [sp, #0x28]
101a19134: 900e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a19138: f9472d17    	ldr	x23, [x8, #0xe58]
101a1913c: aa1303e0    	mov	x0, x19
101a19140: 95883acd    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a19144: 910023e4    	add	x4, sp, #0x8
101a19148: aa1403e0    	mov	x0, x20
101a1914c: aa1703e1    	mov	x1, x23
101a19150: aa1503e2    	mov	x2, x21
101a19154: aa1603e3    	mov	x3, x22
101a19158: 95883ac3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a1915c: aa1403e0    	mov	x0, x20
101a19160: 95883ac4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a19164: f94017e0    	ldr	x0, [sp, #0x28]
101a19168: 95883ac2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a1916c: aa1303e0    	mov	x0, x19
101a19170: 95883ac0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a19174: a9477bfd    	ldp	x29, x30, [sp, #0x70]
101a19178: a9464ff4    	ldp	x20, x19, [sp, #0x60]
101a1917c: a94557f6    	ldp	x22, x21, [sp, #0x50]
101a19180: a9445ff8    	ldp	x24, x23, [sp, #0x40]
101a19184: a94367fa    	ldp	x26, x25, [sp, #0x30]
101a19188: 910203ff    	add	sp, sp, #0x80
101a1918c: d65f03c0    	ret
101a19190: aa0103e8    	mov	x8, x1
101a19194: f9401002    	ldr	x2, [x0, #0x20]
101a19198: 900e8169    	adrp	x9, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a1919c: f944b121    	ldr	x1, [x9, #0x960]
101a191a0: aa0803e0    	mov	x0, x8
101a191a4: 15883ab0    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
