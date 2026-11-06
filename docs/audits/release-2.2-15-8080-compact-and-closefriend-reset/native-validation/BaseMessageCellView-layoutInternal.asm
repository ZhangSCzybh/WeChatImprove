
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002bbe54: d10283ff    	sub	sp, sp, #0xa0
1002bbe58: 6d0323e9    	stp	d9, d8, [sp, #0x30]
1002bbe5c: a9046ffc    	stp	x28, x27, [sp, #0x40]
1002bbe60: a90567fa    	stp	x26, x25, [sp, #0x50]
1002bbe64: a9065ff8    	stp	x24, x23, [sp, #0x60]
1002bbe68: a90757f6    	stp	x22, x21, [sp, #0x70]
1002bbe6c: a9084ff4    	stp	x20, x19, [sp, #0x80]
1002bbe70: a9097bfd    	stp	x29, x30, [sp, #0x90]
1002bbe74: 910243fd    	add	x29, sp, #0x90
1002bbe78: aa0003f3    	mov	x19, x0
1002bbe7c: b00fa428    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002bbe80: 52800029    	mov	w9, #0x1                ; =1
1002bbe84: 3924e509    	strb	w9, [x8, #0x939]
1002bbe88: 900f3888    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1002bbe8c: f9477101    	ldr	x1, [x8, #0xee0]
1002bbe90: 95e5af75    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbe94: f00f52a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002bbe98: f9452d00    	ldr	x0, [x8, #0xa58]
1002bbe9c: 95e5af5b    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
1002bbea0: f00ea468    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1002bbea4: f9465508    	ldr	x8, [x8, #0xca8]
1002bbea8: 6d400500    	ldp	d0, d1, [x8]
1002bbeac: 6d410d02    	ldp	d2, d3, [x8, #0x10]
1002bbeb0: b00f4f68    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002bbeb4: f9418501    	ldr	x1, [x8, #0x308]
1002bbeb8: 95e5af6b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbebc: f00f5608    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002bbec0: b98b6d1b    	ldrsw	x27, [x8, #0xb6c]
1002bbec4: f87b6a68    	ldr	x8, [x19, x27]
1002bbec8: f83b6a60    	str	x0, [x19, x27]
1002bbecc: aa0803e0    	mov	x0, x8
1002bbed0: 95e5af68    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bbed4: f87b6a62    	ldr	x2, [x19, x27]
1002bbed8: d00f4f48    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1002bbedc: f9456501    	ldr	x1, [x8, #0xac8]
1002bbee0: aa1303e0    	mov	x0, x19
1002bbee4: 95e5af60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbee8: f00f3888    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002bbeec: f941d501    	ldr	x1, [x8, #0x3a8]
1002bbef0: aa1303e0    	mov	x0, x19
1002bbef4: 95e5af5c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbef8: f87b6a60    	ldr	x0, [x19, x27]
1002bbefc: 900f4f68    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
1002bbf00: f9478114    	ldr	x20, [x8, #0xf00]
1002bbf04: aa1403e1    	mov	x1, x20
1002bbf08: 95e5af57    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbf0c: 4ea01c08    	mov.16b	v8, v0
1002bbf10: f00f3888    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002bbf14: f941c115    	ldr	x21, [x8, #0x380]
1002bbf18: aa1303e0    	mov	x0, x19
1002bbf1c: aa1503e1    	mov	x1, x21
1002bbf20: 95e5af51    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbf24: aa1d03fd    	mov	x29, x29
1002bbf28: 95e5af56    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bbf2c: aa0003f7    	mov	x23, x0
1002bbf30: 900f38a8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
1002bbf34: f946f116    	ldr	x22, [x8, #0xde0]
1002bbf38: aa1603e1    	mov	x1, x22
1002bbf3c: 95e5af4a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbf40: 7ee1d508    	fabd	d8, d8, d1
1002bbf44: aa1703e0    	mov	x0, x23
1002bbf48: 95e5af4a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bbf4c: 1e6e1000    	fmov	d0, #1.00000000
1002bbf50: 1e602100    	fcmp	d8, d0
1002bbf54: 5400102d    	b.le	0x1002bc158 <__text+0x2b4158>
1002bbf58: aa1303e0    	mov	x0, x19
1002bbf5c: aa1503e1    	mov	x1, x21
1002bbf60: 95e5af41    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbf64: aa1d03fd    	mov	x29, x29
1002bbf68: 95e5af46    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bbf6c: aa0003f7    	mov	x23, x0
1002bbf70: f00f3888    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002bbf74: f941bd18    	ldr	x24, [x8, #0x378]
1002bbf78: aa1803e1    	mov	x1, x24
1002bbf7c: 95e5af3a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbf80: aa1d03fd    	mov	x29, x29
1002bbf84: 95e5af3f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bbf88: aa0003f9    	mov	x25, x0
1002bbf8c: f00f3888    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002bbf90: f941f901    	ldr	x1, [x8, #0x3f0]
1002bbf94: 95e5af34    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbf98: aa0003fa    	mov	x26, x0
1002bbf9c: aa1903e0    	mov	x0, x25
1002bbfa0: 95e5af34    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bbfa4: aa1703e0    	mov	x0, x23
1002bbfa8: 95e5af32    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bbfac: f00f52a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002bbfb0: f9431d00    	ldr	x0, [x8, #0x638]
1002bbfb4: d00f4f88    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1002bbfb8: f942e501    	ldr	x1, [x8, #0x5c8]
1002bbfbc: f90003fa    	str	x26, [sp]
1002bbfc0: d00e6702    	adrp	x2, 0x11cf9d000 <dyld_stub_binder+0x11cf9d000>
1002bbfc4: 913fe042    	add	x2, x2, #0xff8
1002bbfc8: 95e5af27    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbfcc: aa1d03fd    	mov	x29, x29
1002bbfd0: 95e5af2c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bbfd4: aa0003f7    	mov	x23, x0
1002bbfd8: 7100c75f    	cmp	w26, #0x31
1002bbfdc: 54000401    	b.ne	0x1002bc05c <__text+0x2b405c>
1002bbfe0: aa1303e0    	mov	x0, x19
1002bbfe4: aa1503e1    	mov	x1, x21
1002bbfe8: 95e5af1f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bbfec: aa1d03fd    	mov	x29, x29
1002bbff0: 95e5af24    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bbff4: aa0003f9    	mov	x25, x0
1002bbff8: aa1803e1    	mov	x1, x24
1002bbffc: 95e5af1a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc000: aa1d03fd    	mov	x29, x29
1002bc004: 95e5af1f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bc008: aa0003f8    	mov	x24, x0
1002bc00c: d00f3888    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002bc010: f941fd01    	ldr	x1, [x8, #0x3f8]
1002bc014: 95e5af14    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc018: b00f4f88    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1002bc01c: f9429501    	ldr	x1, [x8, #0x528]
1002bc020: f90003e0    	str	x0, [sp]
1002bc024: d00e6802    	adrp	x2, 0x11cfbe000 <dyld_stub_binder+0x11cfbe000>
1002bc028: 910ce042    	add	x2, x2, #0x338
1002bc02c: aa1703e0    	mov	x0, x23
1002bc030: 95e5af0d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc034: aa1d03fd    	mov	x29, x29
1002bc038: 95e5af12    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bc03c: aa0003fa    	mov	x26, x0
1002bc040: aa1703e0    	mov	x0, x23
1002bc044: 95e5af0b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bc048: aa1803e0    	mov	x0, x24
1002bc04c: 95e5af09    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bc050: aa1903e0    	mov	x0, x25
1002bc054: 95e5af07    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bc058: aa1a03f7    	mov	x23, x26
1002bc05c: d00f52a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002bc060: f9430d18    	ldr	x24, [x8, #0x618]
1002bc064: d00f4f48    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002bc068: f9428501    	ldr	x1, [x8, #0x508]
1002bc06c: aa1303e0    	mov	x0, x19
1002bc070: 95e5aefd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc074: aa0003f9    	mov	x25, x0
1002bc078: f87b6a60    	ldr	x0, [x19, x27]
1002bc07c: aa1403e1    	mov	x1, x20
1002bc080: 95e5aef9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc084: 4ea01c08    	mov.16b	v8, v0
1002bc088: aa1303e0    	mov	x0, x19
1002bc08c: aa1503e1    	mov	x1, x21
1002bc090: 95e5aef5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc094: aa1d03fd    	mov	x29, x29
1002bc098: 95e5aefa    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bc09c: aa0003fa    	mov	x26, x0
1002bc0a0: aa1603e1    	mov	x1, x22
1002bc0a4: 95e5aef0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc0a8: b00f3868    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002bc0ac: f9418901    	ldr	x1, [x8, #0x310]
1002bc0b0: f90013f7    	str	x23, [sp, #0x20]
1002bc0b4: 6d0107e8    	stp	d8, d1, [sp, #0x10]
1002bc0b8: d00e6808    	adrp	x8, 0x11cfbe000 <dyld_stub_binder+0x11cfbe000>
1002bc0bc: 910d6108    	add	x8, x8, #0x358
1002bc0c0: a90067e8    	stp	x8, x25, [sp]
1002bc0c4: d00cc825    	adrp	x5, 0x119bc2000 <dyld_stub_binder+0x119bc2000>
1002bc0c8: 912490a5    	add	x5, x5, #0x924
1002bc0cc: d00cc827    	adrp	x7, 0x119bc2000 <dyld_stub_binder+0x119bc2000>
1002bc0d0: 912648e7    	add	x7, x7, #0x992
1002bc0d4: aa1803e0    	mov	x0, x24
1002bc0d8: 52800082    	mov	w2, #0x4                ; =4
1002bc0dc: d2800003    	mov	x3, #0x0                ; =0
1002bc0e0: 52800004    	mov	w4, #0x0                ; =0
1002bc0e4: 52800d46    	mov	w6, #0x6a               ; =106
1002bc0e8: 95e5aedf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc0ec: aa1a03e0    	mov	x0, x26
1002bc0f0: 95e5aee0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bc0f4: aa1303e0    	mov	x0, x19
1002bc0f8: aa1503e1    	mov	x1, x21
1002bc0fc: 95e5aeda    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc100: aa1d03fd    	mov	x29, x29
1002bc104: 95e5aedf    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002bc108: aa0003f5    	mov	x21, x0
1002bc10c: f87b6a60    	ldr	x0, [x19, x27]
1002bc110: aa1403e1    	mov	x1, x20
1002bc114: 95e5aed4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc118: f00f38e8    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002bc11c: f9416501    	ldr	x1, [x8, #0x2c8]
1002bc120: aa1503e0    	mov	x0, x21
1002bc124: 95e5aed0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002bc128: aa1503e0    	mov	x0, x21
1002bc12c: 95e5aed1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bc130: aa1703e0    	mov	x0, x23
1002bc134: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1002bc138: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1002bc13c: a94757f6    	ldp	x22, x21, [sp, #0x70]
1002bc140: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1002bc144: a94567fa    	ldp	x26, x25, [sp, #0x50]
1002bc148: a9446ffc    	ldp	x28, x27, [sp, #0x40]
1002bc14c: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
1002bc150: 910283ff    	add	sp, sp, #0xa0
1002bc154: 15e5aec7    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002bc158: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1002bc15c: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1002bc160: a94757f6    	ldp	x22, x21, [sp, #0x70]
1002bc164: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1002bc168: a94567fa    	ldp	x26, x25, [sp, #0x50]
1002bc16c: a9446ffc    	ldp	x28, x27, [sp, #0x40]
1002bc170: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
1002bc174: 910283ff    	add	sp, sp, #0xa0
1002bc178: d65f03c0    	ret
