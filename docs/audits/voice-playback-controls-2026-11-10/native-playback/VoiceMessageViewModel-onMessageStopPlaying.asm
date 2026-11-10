
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10658c9d8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10658c9dc: a9017bfd    	stp	x29, x30, [sp, #0x10]
10658c9e0: 910043fd    	add	x29, sp, #0x10
10658c9e4: aa0003f3    	mov	x19, x0
10658c9e8: d00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658c9ec: b98d1908    	ldrsw	x8, [x8, #0xd18]
10658c9f0: d2e7fe09    	mov	x9, #0x3ff0000000000000 ; =4607182418800017408
10658c9f4: f8286809    	str	x9, [x0, x8]
10658c9f8: f00c2328    	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
10658c9fc: f942c101    	ldr	x1, [x8, #0x580]
10658ca00: 52800002    	mov	w2, #0x0                ; =0
10658ca04: 945a6c98    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658ca08: f00c2208    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10658ca0c: f9410101    	ldr	x1, [x8, #0x200]
10658ca10: aa1303e0    	mov	x0, x19
10658ca14: 945a6c94    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658ca18: aa1d03fd    	mov	x29, x29
10658ca1c: 945a6c99    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658ca20: aa0003f4    	mov	x20, x0
10658ca24: f00c26a8    	adrp	x8, 0x11ea63000 <dyld_stub_binder+0x11ea63000>
10658ca28: f9479101    	ldr	x1, [x8, #0xf20]
10658ca2c: 945a6c8e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658ca30: aa1403e0    	mov	x0, x20
10658ca34: 945a6c8f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658ca38: d00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658ca3c: b98d3108    	ldrsw	x8, [x8, #0xd30]
10658ca40: f8686a60    	ldr	x0, [x19, x8]
10658ca44: 900c38e8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10658ca48: f9433101    	ldr	x1, [x8, #0x660]
10658ca4c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10658ca50: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10658ca54: 145a6c84    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
