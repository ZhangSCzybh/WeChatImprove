
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1058a0040: d10243ff    	sub	sp, sp, #0x90
1058a0044: 6d0623e9    	stp	d9, d8, [sp, #0x60]
1058a0048: a9074ff4    	stp	x20, x19, [sp, #0x70]
1058a004c: a9087bfd    	stp	x29, x30, [sp, #0x80]
1058a0050: 910203fd    	add	x29, sp, #0x80
1058a0054: 4ea11c28    	mov.16b	v8, v1
1058a0058: 4ea01c09    	mov.16b	v9, v0
1058a005c: aa0203e8    	mov	x8, x2
1058a0060: aa0003f3    	mov	x19, x0
1058a0064: 900cf5a9    	adrp	x9, 0x11f754000 <dyld_stub_binder+0x11f754000>
1058a0068: 5280002a    	mov	w10, #0x1               ; =1
1058a006c: 3911192a    	strb	w10, [x9, #0x446]
1058a0070: a93d7fbf    	stp	xzr, xzr, [x29, #-0x30]
1058a0074: 92f00209    	mov	x9, #0x7fefffffffffffff ; =9218868437227405311
1058a0078: f81c83a9    	stur	x9, [x29, #-0x38]
1058a007c: 900bf569    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1058a0080: f9449529    	ldr	x9, [x9, #0x928]
1058a0084: f90003e9    	str	x9, [sp]
1058a0088: f0090129    	adrp	x9, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1058a008c: fd434520    	ldr	d0, [x9, #0x688]
1058a0090: fd0007e0    	str	d0, [sp, #0x8]
1058a0094: 90000009    	adrp	x9, 0x1058a0000 <_Flutter_MMFoundation_BindContext+0x1b26ccc>
1058a0098: 91051129    	add	x9, x9, #0x144
1058a009c: f00b530a    	adrp	x10, 0x11c303000 <dyld_stub_binder+0x11c303000>
1058a00a0: 9107014a    	add	x10, x10, #0x1c0
1058a00a4: a9012be9    	stp	x9, x10, [sp, #0x10]
1058a00a8: 6d0207e9    	stp	d9, d1, [sp, #0x20]
1058a00ac: d100e3a9    	sub	x9, x29, #0x38
1058a00b0: d100a3aa    	sub	x10, x29, #0x28
1058a00b4: a9032be9    	stp	x9, x10, [sp, #0x30]
1058a00b8: d100c3a9    	sub	x9, x29, #0x30
1058a00bc: f90023e9    	str	x9, [sp, #0x40]
1058a00c0: f00ca029    	adrp	x9, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
1058a00c4: f9415d21    	ldr	x1, [x9, #0x2b8] ; selector: enumerateObjectsUsingBlock:
1058a00c8: 910003e2    	mov	x2, sp
1058a00cc: aa0803e0    	mov	x0, x8
1058a00d0: 948e1ee5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a00d4: f85d03a0    	ldur	x0, [x29, #-0x30]
1058a00d8: b4000200    	cbz	x0, 0x1058a0118 <_Flutter_MMFoundation_BindContext+0x1b26de4>
1058a00dc: f00ca028    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
1058a00e0: f9433501    	ldr	x1, [x8, #0x668] ; selector: frame
1058a00e4: 948e1ee0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a00e8: 900c9548    	adrp	x8, 0x11eb48000 <dyld_stub_binder+0x11eb48000>
1058a00ec: f9451901    	ldr	x1, [x8, #0xa30] ; selector: expandHitAreaForRect:
1058a00f0: aa1303e0    	mov	x0, x19
1058a00f4: 948e1edc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a00f8: 4ea91d24    	mov.16b	v4, v9
1058a00fc: 4ea81d05    	mov.16b	v5, v8
1058a0100: 948e19b1    	bl	0x107c267c4 <_Flutter_MMFoundation_BindContext+0x3ead490>
1058a0104: 340000a0    	cbz	w0, 0x1058a0118 <_Flutter_MMFoundation_BindContext+0x1b26de4>
1058a0108: f85d83b3    	ldur	x19, [x29, #-0x28]
1058a010c: aa1303e0    	mov	x0, x19
1058a0110: 948e1ed9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1058a0114: 14000002    	b	0x1058a011c <_Flutter_MMFoundation_BindContext+0x1b26de8>
1058a0118: d2800013    	mov	x19, #0x0               ; =0
1058a011c: f85d03a0    	ldur	x0, [x29, #-0x30]
1058a0120: 948e1ed4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a0124: f85d83a0    	ldur	x0, [x29, #-0x28]
1058a0128: 948e1ed2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a012c: aa1303e0    	mov	x0, x19
1058a0130: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1058a0134: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1058a0138: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
1058a013c: 910243ff    	add	sp, sp, #0x90
1058a0140: 148e1eb8    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
1058a0144: 6db63bef    	stp	d15, d14, [sp, #-0xa0]!
1058a0148: 6d0133ed    	stp	d13, d12, [sp, #0x10]
1058a014c: 6d022beb    	stp	d11, d10, [sp, #0x20]
1058a0150: 6d0323e9    	stp	d9, d8, [sp, #0x30]
1058a0154: a9046ffc    	stp	x28, x27, [sp, #0x40]
1058a0158: a90567fa    	stp	x26, x25, [sp, #0x50]
1058a015c: a9065ff8    	stp	x24, x23, [sp, #0x60]
1058a0160: a90757f6    	stp	x22, x21, [sp, #0x70]
1058a0164: a9084ff4    	stp	x20, x19, [sp, #0x80]
1058a0168: a9097bfd    	stp	x29, x30, [sp, #0x90]
1058a016c: 910243fd    	add	x29, sp, #0x90
1058a0170: aa0303f4    	mov	x20, x3
1058a0174: aa0103f3    	mov	x19, x1
1058a0178: aa0003f5    	mov	x21, x0
1058a017c: aa0103e0    	mov	x0, x1
1058a0180: 948e1ebd    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1058a0184: 900c9008    	adrp	x8, 0x11eaa0000 <dyld_stub_binder+0x11eaa0000>
1058a0188: f9424d01    	ldr	x1, [x8, #0x498] ; selector: isSelectable
1058a018c: aa1303e0    	mov	x0, x19
1058a0190: 948e1eb5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0194: 34000ec0    	cbz	w0, 0x1058a036c <_Flutter_MMFoundation_BindContext+0x1b27038>
1058a0198: d00c8e28    	adrp	x8, 0x11ea66000 <dyld_stub_binder+0x11ea66000>
1058a019c: f941b116    	ldr	x22, [x8, #0x360] ; selector: eventRespondStyle
1058a01a0: aa1303e0    	mov	x0, x19
1058a01a4: aa1603e1    	mov	x1, x22
1058a01a8: 948e1eaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a01ac: aa1d03fd    	mov	x29, x29
1058a01b0: 948e1eb4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1058a01b4: d00ca39c    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1058a01b8: b4000400    	cbz	x0, 0x1058a0238 <_Flutter_MMFoundation_BindContext+0x1b26f04>
1058a01bc: aa0003f9    	mov	x25, x0
1058a01c0: aa1303e0    	mov	x0, x19
1058a01c4: aa1603e1    	mov	x1, x22
1058a01c8: 948e1ea7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a01cc: aa1d03fd    	mov	x29, x29
1058a01d0: 948e1eac    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1058a01d4: aa0003fa    	mov	x26, x0
1058a01d8: f9478780    	ldr	x0, [x28, #0xf08]
1058a01dc: d00ca028    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1058a01e0: f9428517    	ldr	x23, [x8, #0x508] ; selector: class
1058a01e4: aa1703e1    	mov	x1, x23
1058a01e8: 948e1e9f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a01ec: aa0003e2    	mov	x2, x0
1058a01f0: 900ca048    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1058a01f4: f9444918    	ldr	x24, [x8, #0x890] ; selector: isKindOfClass:
1058a01f8: aa1a03e0    	mov	x0, x26
1058a01fc: aa1803e1    	mov	x1, x24
1058a0200: 948e1e99    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0204: aa0003fb    	mov	x27, x0
1058a0208: aa1a03e0    	mov	x0, x26
1058a020c: 948e1e99    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a0210: aa1903e0    	mov	x0, x25
1058a0214: 948e1e97    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a0218: 3400019b    	cbz	w27, 0x1058a0248 <_Flutter_MMFoundation_BindContext+0x1b26f14>
1058a021c: aa1303e0    	mov	x0, x19
1058a0220: aa1603e1    	mov	x1, x22
1058a0224: 948e1e90    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0228: aa1d03fd    	mov	x29, x29
1058a022c: 948e1e95    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1058a0230: aa0003f6    	mov	x22, x0
1058a0234: 14000010    	b	0x1058a0274 <_Flutter_MMFoundation_BindContext+0x1b26f40>
1058a0238: d00ca028    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1058a023c: f9428517    	ldr	x23, [x8, #0x508] ; selector: class
1058a0240: 900ca048    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1058a0244: f9444918    	ldr	x24, [x8, #0x890] ; selector: isKindOfClass:
1058a0248: f9478780    	ldr	x0, [x28, #0xf08]
1058a024c: aa1703e1    	mov	x1, x23
1058a0250: 948e1e85    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0254: aa0003e2    	mov	x2, x0
1058a0258: aa1303e0    	mov	x0, x19
1058a025c: aa1803e1    	mov	x1, x24
1058a0260: 948e1e81    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0264: 340007e0    	cbz	w0, 0x1058a0360 <_Flutter_MMFoundation_BindContext+0x1b2702c>
1058a0268: aa1303e0    	mov	x0, x19
1058a026c: 948e1e82    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1058a0270: aa1303f6    	mov	x22, x19
1058a0274: f00ca028    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
1058a0278: f9433501    	ldr	x1, [x8, #0x668] ; selector: frame
1058a027c: aa1303e0    	mov	x0, x19
1058a0280: 948e1e79    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1058a0284: 4ea01c08    	mov.16b	v8, v0
1058a0288: 4ea11c29    	mov.16b	v9, v1
1058a028c: 4ea21c4a    	mov.16b	v10, v2
1058a0290: 4ea31c6b    	mov.16b	v11, v3
1058a0294: 948e1956    	bl	0x107c267ec <_Flutter_MMFoundation_BindContext+0x3ead4b8>
1058a0298: fd4012ac    	ldr	d12, [x21, #0x20]
1058a029c: 1e6c380d    	fsub	d13, d0, d12
1058a02a0: 4ea81d00    	mov.16b	v0, v8
1058a02a4: 4ea91d21    	mov.16b	v1, v9
1058a02a8: 4eaa1d42    	mov.16b	v2, v10
1058a02ac: 4eab1d63    	mov.16b	v3, v11
1058a02b0: 948e194b    	bl	0x107c267dc <_Flutter_MMFoundation_BindContext+0x3ead4a8>
1058a02b4: 1e603980    	fsub	d0, d12, d0
1058a02b8: 1e6021a0    	fcmp	d13, d0
1058a02bc: 1e6d4c00    	fcsel	d0, d0, d13, mi
1058a02c0: 1e602008    	fcmp	d0, #0.0
1058a02c4: 9e6703ec    	fmov	d12, xzr
1058a02c8: 1e604d8d    	fcsel	d13, d12, d0, mi
1058a02cc: 4ea81d00    	mov.16b	v0, v8
1058a02d0: 4ea91d21    	mov.16b	v1, v9
1058a02d4: 4eaa1d42    	mov.16b	v2, v10
1058a02d8: 4eab1d63    	mov.16b	v3, v11
1058a02dc: 948e1945    	bl	0x107c267f0 <_Flutter_MMFoundation_BindContext+0x3ead4bc>
1058a02e0: fd4016ae    	ldr	d14, [x21, #0x28]
1058a02e4: 1e6e380f    	fsub	d15, d0, d14
1058a02e8: 4ea81d00    	mov.16b	v0, v8
1058a02ec: 4ea91d21    	mov.16b	v1, v9
1058a02f0: 4eaa1d42    	mov.16b	v2, v10
1058a02f4: 4eab1d63    	mov.16b	v3, v11
1058a02f8: 948e193a    	bl	0x107c267e0 <_Flutter_MMFoundation_BindContext+0x3ead4ac>
1058a02fc: 1e6039c0    	fsub	d0, d14, d0
1058a0300: 1e6021e0    	fcmp	d15, d0
1058a0304: 1e6f4c00    	fcsel	d0, d0, d15, mi
1058a0308: 1e602008    	fcmp	d0, #0.0
1058a030c: 1e604d80    	fcsel	d0, d12, d0, mi
1058a0310: 1e6021a0    	fcmp	d13, d0
1058a0314: 1e6d4c08    	fcsel	d8, d0, d13, mi
1058a0318: f9401aa8    	ldr	x8, [x21, #0x30]
1058a031c: fd400100    	ldr	d0, [x8]
1058a0320: 1e602100    	fcmp	d8, d0
1058a0324: 54000145    	b.pl	0x1058a034c <_Flutter_MMFoundation_BindContext+0x1b27018>
1058a0328: f9401ea0    	ldr	x0, [x21, #0x38]
1058a032c: aa1603e1    	mov	x1, x22
1058a0330: 948e1e5b    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
1058a0334: f94022a0    	ldr	x0, [x21, #0x40]
1058a0338: aa1303e1    	mov	x1, x19
1058a033c: 948e1e58    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
1058a0340: f9401aa8    	ldr	x8, [x21, #0x30]
1058a0344: fd000108    	str	d8, [x8]
1058a0348: 4ea81d00    	mov.16b	v0, v8
1058a034c: 1e602008    	fcmp	d0, #0.0
1058a0350: 540000a1    	b.ne	0x1058a0364 <_Flutter_MMFoundation_BindContext+0x1b27030>
1058a0354: 52800028    	mov	w8, #0x1                ; =1
1058a0358: 39000288    	strb	w8, [x20]
1058a035c: 14000002    	b	0x1058a0364 <_Flutter_MMFoundation_BindContext+0x1b27030>
1058a0360: d2800016    	mov	x22, #0x0               ; =0
1058a0364: aa1603e0    	mov	x0, x22
1058a0368: 948e1e42    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1058a036c: aa1303e0    	mov	x0, x19
1058a0370: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1058a0374: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1058a0378: a94757f6    	ldp	x22, x21, [sp, #0x70]
1058a037c: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1058a0380: a94567fa    	ldp	x26, x25, [sp, #0x50]
1058a0384: a9446ffc    	ldp	x28, x27, [sp, #0x40]
1058a0388: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
1058a038c: 6d422beb    	ldp	d11, d10, [sp, #0x20]
1058a0390: 6d4133ed    	ldp	d13, d12, [sp, #0x10]
1058a0394: 6cca3bef    	ldp	d15, d14, [sp], #0xa0
1058a0398: 148e1e36    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
