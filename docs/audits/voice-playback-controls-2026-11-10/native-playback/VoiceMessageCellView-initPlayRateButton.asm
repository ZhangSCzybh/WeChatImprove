
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106576840: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
106576844: a90157f6    	stp	x22, x21, [sp, #0x10]
106576848: a9024ff4    	stp	x20, x19, [sp, #0x20]
10657684c: a9037bfd    	stp	x29, x30, [sp, #0x30]
106576850: 9100c3fd    	add	x29, sp, #0x30
106576854: aa0003f3    	mov	x19, x0
106576858: b00c8f08    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
10657685c: 52800029    	mov	w9, #0x1                ; =1
106576860: 3907b109    	strb	w9, [x8, #0x1ec]
106576864: 900c4328    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106576868: b98c8917    	ldrsw	x23, [x8, #0xc88]
10657686c: f8776808    	ldr	x8, [x0, x23]
106576870: b5001008    	cbnz	x8, 0x106576a70 <_Flutter_MMFoundation_BindContext+0x27fd73c>
106576874: 900c3ce8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106576878: f946a500    	ldr	x0, [x8, #0xd48]
10657687c: 900c3988    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106576880: f940e901    	ldr	x1, [x8, #0x1d0]
106576884: d2800002    	mov	x2, #0x0                ; =0
106576888: 945ac4f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657688c: aa1d03fd    	mov	x29, x29
106576890: 945ac4fc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106576894: f8776a68    	ldr	x8, [x19, x23]
106576898: f8376a60    	str	x0, [x19, x23]
10657689c: aa0803e0    	mov	x0, x8
1065768a0: 945ac4f4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065768a4: f8776a60    	ldr	x0, [x19, x23]
1065768a8: b00c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1065768ac: f9458901    	ldr	x1, [x8, #0xb10]
1065768b0: 1e669000    	fmov	d0, #20.00000000
1065768b4: 945ac4ec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065768b8: f8776a60    	ldr	x0, [x19, x23]
1065768bc: d00c3988    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1065768c0: f9465101    	ldr	x1, [x8, #0xca0]
1065768c4: 945ac4e8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065768c8: aa1d03fd    	mov	x29, x29
1065768cc: 945ac4ed    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065768d0: aa0003f4    	mov	x20, x0
1065768d4: b00c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1065768d8: f9426101    	ldr	x1, [x8, #0x4c0]
1065768dc: 1e649000    	fmov	d0, #10.00000000
1065768e0: 945ac4e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065768e4: aa1403e0    	mov	x0, x20
1065768e8: 945ac4e2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065768ec: f8776a60    	ldr	x0, [x19, x23]
1065768f0: b00c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1065768f4: f941c101    	ldr	x1, [x8, #0x380]
1065768f8: 52800022    	mov	w2, #0x1                ; =1
1065768fc: 945ac4da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576900: 900c3ce8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106576904: f9440900    	ldr	x0, [x8, #0x810]
106576908: 900c3988    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10657690c: f942a901    	ldr	x1, [x8, #0x550]
106576910: 945ac4d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576914: aa1d03fd    	mov	x29, x29
106576918: 945ac4da    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10657691c: aa0003f4    	mov	x20, x0
106576920: f8776a60    	ldr	x0, [x19, x23]
106576924: b00c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106576928: f9401d01    	ldr	x1, [x8, #0x38]
10657692c: aa1403e2    	mov	x2, x20
106576930: 945ac4cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576934: aa1403e0    	mov	x0, x20
106576938: 945ac4ce    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10657693c: f8776a74    	ldr	x20, [x19, x23]
106576940: 900c22c8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106576944: f941c101    	ldr	x1, [x8, #0x380]
106576948: aa1303e0    	mov	x0, x19
10657694c: 945ac4c6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576950: aa1d03fd    	mov	x29, x29
106576954: 945ac4cb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106576958: aa0003f5    	mov	x21, x0
10657695c: b00c2fe8    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106576960: f942a501    	ldr	x1, [x8, #0x548]
106576964: 945ac4c0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576968: aa1d03fd    	mov	x29, x29
10657696c: 945ac4c5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106576970: aa0003f6    	mov	x22, x0
106576974: d00c39a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
106576978: f945c901    	ldr	x1, [x8, #0xb90]
10657697c: aa1403e0    	mov	x0, x20
106576980: aa1603e2    	mov	x2, x22
106576984: d2800003    	mov	x3, #0x0                ; =0
106576988: 945ac4b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657698c: aa1603e0    	mov	x0, x22
106576990: 945ac4b8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106576994: aa1503e0    	mov	x0, x21
106576998: 945ac4b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10657699c: f8776a60    	ldr	x0, [x19, x23]
1065769a0: b00c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1065769a4: f9458d01    	ldr	x1, [x8, #0xb18]
1065769a8: 52800022    	mov	w2, #0x1                ; =1
1065769ac: 945ac4ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065769b0: b00c2fe8    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
1065769b4: f942a901    	ldr	x1, [x8, #0x550]
1065769b8: aa1303e0    	mov	x0, x19
1065769bc: 945ac4aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065769c0: 900c3ce8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065769c4: f943f100    	ldr	x0, [x8, #0x7e0]
1065769c8: f00c39a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1065769cc: f9436901    	ldr	x1, [x8, #0x6d0]
1065769d0: 1e651000    	fmov	d0, #12.00000000
1065769d4: 945ac4a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065769d8: aa1d03fd    	mov	x29, x29
1065769dc: 945ac4a9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065769e0: aa0003f4    	mov	x20, x0
1065769e4: f8776a60    	ldr	x0, [x19, x23]
1065769e8: f00c39a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1065769ec: f9445101    	ldr	x1, [x8, #0x8a0]
1065769f0: 945ac49d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065769f4: aa1d03fd    	mov	x29, x29
1065769f8: 945ac4a2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065769fc: aa0003f5    	mov	x21, x0
106576a00: b00c39a8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106576a04: f9450501    	ldr	x1, [x8, #0xa08]
106576a08: aa1403e2    	mov	x2, x20
106576a0c: 945ac496    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576a10: aa1503e0    	mov	x0, x21
106576a14: 945ac497    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106576a18: aa1403e0    	mov	x0, x20
106576a1c: 945ac495    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106576a20: f8776a60    	ldr	x0, [x19, x23]
106576a24: d00c22c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
106576a28: f9423501    	ldr	x1, [x8, #0x468]
106576a2c: 1e609000    	fmov	d0, #2.50000000
106576a30: 1e641001    	fmov	d1, #8.00000000
106576a34: 1e609002    	fmov	d2, #2.50000000
106576a38: 1e641003    	fmov	d3, #8.00000000
106576a3c: 945ac48a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576a40: f8776a60    	ldr	x0, [x19, x23]
106576a44: f00c2288    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106576a48: f9453101    	ldr	x1, [x8, #0xa60]
106576a4c: 945ac486    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576a50: f8776a60    	ldr	x0, [x19, x23]
106576a54: b00c2fe8    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106576a58: f942ad03    	ldr	x3, [x8, #0x558]
106576a5c: f00c3968    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
106576a60: f9456901    	ldr	x1, [x8, #0xad0]
106576a64: aa1303e2    	mov	x2, x19
106576a68: 52800804    	mov	w4, #0x40               ; =64
106576a6c: 945ac47e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106576a70: b00c2fe8    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106576a74: f942b101    	ldr	x1, [x8, #0x560]
106576a78: aa1303e0    	mov	x0, x19
106576a7c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
106576a80: a9424ff4    	ldp	x20, x19, [sp, #0x20]
106576a84: a94157f6    	ldp	x22, x21, [sp, #0x10]
106576a88: a8c45ff8    	ldp	x24, x23, [sp], #0x40
106576a8c: 145ac476    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
