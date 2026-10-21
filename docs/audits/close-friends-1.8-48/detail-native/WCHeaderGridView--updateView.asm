
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108f48950: d102c3ff    	sub	sp, sp, #0xb0
108f48954: 6d0423e9    	stp	d9, d8, [sp, #0x40]
108f48958: a9056ffc    	stp	x28, x27, [sp, #0x50]
108f4895c: a90667fa    	stp	x26, x25, [sp, #0x60]
108f48960: a9075ff8    	stp	x24, x23, [sp, #0x70]
108f48964: a90857f6    	stp	x22, x21, [sp, #0x80]
108f48968: a9094ff4    	stp	x20, x19, [sp, #0x90]
108f4896c: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
108f48970: 910283fd    	add	x29, sp, #0xa0
108f48974: aa0003f3    	mov	x19, x0
108f48978: b00be828    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108f4897c: 52800029    	mov	w9, #0x1                ; =1
108f48980: 392e7d09    	strb	w9, [x8, #0xb9f]
108f48984: f00b98c8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f48988: b989e915    	ldrsw	x21, [x8, #0x9e8]
108f4898c: f8756800    	ldr	x0, [x0, x21]
108f48990: f00b98d6    	adrp	x22, 0x120263000 <dyld_stub_binder+0x120263000>
108f48994: d00b8dd7    	adrp	x23, 0x120102000 <dyld_stub_binder+0x120102000>
108f48998: d00b8e14    	adrp	x20, 0x12010a000 <dyld_stub_binder+0x12010a000>
108f4899c: b40001a0    	cbz	x0, 0x108f489d0 <_Flutter_MMFoundation_BindContext+0x54245b4>
108f489a0: b989bec8    	ldrsw	x8, [x22, #0x9bc]
108f489a4: fc686a68    	ldr	d8, [x19, x8]
108f489a8: f9449ee1    	ldr	x1, [x23, #0x938] ; height
108f489ac: 95a44aa6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f489b0: 1e603900    	fsub	d0, d8, d0
108f489b4: 1e6c1001    	fmov	d1, #0.50000000
108f489b8: 1e610800    	fmul	d0, d0, d1
108f489bc: 9e6703e1    	fmov	d1, xzr
108f489c0: 1e616800    	fmaxnm	d0, d0, d1
108f489c4: f8756a60    	ldr	x0, [x19, x21]
108f489c8: f941da81    	ldr	x1, [x20, #0x3b0] ; setY:
108f489cc: 95a44a9e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f489d0: f00b98c8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f489d4: b989ed18    	ldrsw	x24, [x8, #0x9ec]
108f489d8: f8786a60    	ldr	x0, [x19, x24]
108f489dc: b40001a0    	cbz	x0, 0x108f48a10 <_Flutter_MMFoundation_BindContext+0x54245f4>
108f489e0: b989bec8    	ldrsw	x8, [x22, #0x9bc]
108f489e4: fc686a68    	ldr	d8, [x19, x8]
108f489e8: f9449ee1    	ldr	x1, [x23, #0x938] ; height
108f489ec: 95a44a96    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f489f0: 1e603900    	fsub	d0, d8, d0
108f489f4: 1e6c1001    	fmov	d1, #0.50000000
108f489f8: 1e610800    	fmul	d0, d0, d1
108f489fc: 9e6703e1    	fmov	d1, xzr
108f48a00: 1e616800    	fmaxnm	d0, d0, d1
108f48a04: f8786a60    	ldr	x0, [x19, x24]
108f48a08: f941da81    	ldr	x1, [x20, #0x3b0] ; setY:
108f48a0c: 95a44a8e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48a10: f8756a60    	ldr	x0, [x19, x21]
108f48a14: 900b77a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108f48a18: f9431d14    	ldr	x20, [x8, #0x638] ; right
108f48a1c: aa1403e1    	mov	x1, x20
108f48a20: 95a44a89    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48a24: 1e604008    	fmov	d8, d0
108f48a28: f8786a60    	ldr	x0, [x19, x24]
108f48a2c: aa1403e1    	mov	x1, x20
108f48a30: 95a44a85    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48a34: 1e604009    	fmov	d9, d0
108f48a38: f00b98c8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f48a3c: b989dd1c    	ldrsw	x28, [x8, #0x9dc]
108f48a40: 900b8dc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108f48a44: f9435101    	ldr	x1, [x8, #0x6a0] ; count
108f48a48: f87c6a60    	ldr	x0, [x19, x28]
108f48a4c: f9000fe1    	str	x1, [sp, #0x18]
108f48a50: 95a44a7d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48a54: b00b8e08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
108f48a58: f9453d14    	ldr	x20, [x8, #0xa78] ; setSize:
108f48a5c: f00b98db    	adrp	x27, 0x120263000 <dyld_stub_binder+0x120263000>
108f48a60: f00b98da    	adrp	x26, 0x120263000 <dyld_stub_binder+0x120263000>
108f48a64: f00b98d9    	adrp	x25, 0x120263000 <dyld_stub_binder+0x120263000>
108f48a68: b4000b00    	cbz	x0, 0x108f48bc8 <_Flutter_MMFoundation_BindContext+0x54247ac>
108f48a6c: a900d7f8    	stp	x24, x21, [sp, #0x8]
108f48a70: d280001b    	mov	x27, #0x0               ; =0
108f48a74: f9001ff4    	str	x20, [sp, #0x38]
108f48a78: 52800014    	mov	w20, #0x0               ; =0
108f48a7c: 52800015    	mov	w21, #0x0               ; =0
108f48a80: 52800019    	mov	w25, #0x0               ; =0
108f48a84: 1e692100    	fcmp	d8, d9
108f48a88: 1e684d20    	fcsel	d0, d9, d8, mi
108f48a8c: d00b7788    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108f48a90: f942c109    	ldr	x9, [x8, #0x580] ; safeObjectAtIndex:
108f48a94: 1e659001    	fmov	d1, #14.00000000
108f48a98: 1e612808    	fadd	d8, d0, d1
108f48a9c: 900b8e08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
108f48aa0: f9403508    	ldr	x8, [x8, #0x68] ; setFrame:
108f48aa4: a902a7e8    	stp	x8, x9, [sp, #0x28]
108f48aa8: f00b77a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
108f48aac: f9472508    	ldr	x8, [x8, #0xe48] ; setImageSize:
108f48ab0: f90013e8    	str	x8, [sp, #0x20]
108f48ab4: 900b88e8    	adrp	x8, 0x120064000 <dyld_stub_binder+0x120064000>
108f48ab8: f947111a    	ldr	x26, [x8, #0xe20] ; setCustomHeadImageCornerForHeadView:index:
108f48abc: f9400ff8    	ldr	x24, [sp, #0x18]
108f48ac0: f87c6a60    	ldr	x0, [x19, x28]
108f48ac4: f9401be1    	ldr	x1, [sp, #0x30]
108f48ac8: aa1b03e2    	mov	x2, x27
108f48acc: 95a44a5e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48ad0: aa1d03fd    	mov	x29, x29
108f48ad4: 95a44a5f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f48ad8: aa0003fb    	mov	x27, x0
108f48adc: aa1603f7    	mov	x23, x22
108f48ae0: b989bed6    	ldrsw	x22, [x22, #0x9bc]
108f48ae4: fc766a62    	ldr	d2, [x19, x22]
108f48ae8: f00b98c8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f48aec: b989c108    	ldrsw	x8, [x8, #0x9c0]
108f48af0: fc686a60    	ldr	d0, [x19, x8]
108f48af4: 1e602840    	fadd	d0, d2, d0
108f48af8: 1e6302a1    	ucvtf	d1, w21
108f48afc: 1f412000    	fmadd	d0, d0, d1, d8
108f48b00: f00b98c8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f48b04: b989c508    	ldrsw	x8, [x8, #0x9c4]
108f48b08: fc686a61    	ldr	d1, [x19, x8]
108f48b0c: 1e612841    	fadd	d1, d2, d1
108f48b10: 1e630283    	ucvtf	d3, w20
108f48b14: 1e630821    	fmul	d1, d1, d3
108f48b18: f94017e1    	ldr	x1, [sp, #0x28]
108f48b1c: 1e604043    	fmov	d3, d2
108f48b20: 95a44a49    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48b24: fc766a60    	ldr	d0, [x19, x22]
108f48b28: aa1b03e0    	mov	x0, x27
108f48b2c: f94013e1    	ldr	x1, [sp, #0x20]
108f48b30: 1e604001    	fmov	d1, d0
108f48b34: 95a44a44    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48b38: fc766a60    	ldr	d0, [x19, x22]
108f48b3c: aa1703f6    	mov	x22, x23
108f48b40: aa1b03e0    	mov	x0, x27
108f48b44: f9401fe1    	ldr	x1, [sp, #0x38]
108f48b48: 1e604001    	fmov	d1, d0
108f48b4c: 95a44a3e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48b50: aa1303e0    	mov	x0, x19
108f48b54: aa1a03e1    	mov	x1, x26
108f48b58: aa1b03e2    	mov	x2, x27
108f48b5c: aa1903e3    	mov	x3, x25
108f48b60: 95a44a39    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48b64: 110006a8    	add	w8, w21, #0x1
108f48b68: f00b98c9    	adrp	x9, 0x120263000 <dyld_stub_binder+0x120263000>
108f48b6c: b989c929    	ldrsw	x9, [x9, #0x9c8]
108f48b70: b8696a69    	ldr	w9, [x19, x9]
108f48b74: 6b09011f    	cmp	w8, w9
108f48b78: 1a9527f5    	csinc	w21, wzr, w21, hs
108f48b7c: 1a943694    	cinc	w20, w20, hs
108f48b80: aa1b03e0    	mov	x0, x27
108f48b84: 95a44a36    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f48b88: 1100073b    	add	w27, w25, #0x1
108f48b8c: f87c6a60    	ldr	x0, [x19, x28]
108f48b90: aa1803e1    	mov	x1, x24
108f48b94: 95a44a2c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48b98: aa1b03f9    	mov	x25, x27
108f48b9c: eb1b001f    	cmp	x0, x27
108f48ba0: 54fff908    	b.hi	0x108f48ac0 <_Flutter_MMFoundation_BindContext+0x54246a4>
108f48ba4: 11000688    	add	w8, w20, #0x1
108f48ba8: 1e630109    	ucvtf	d9, w8
108f48bac: a940d7f8    	ldp	x24, x21, [sp, #0x8]
108f48bb0: d00b8dd7    	adrp	x23, 0x120102000 <dyld_stub_binder+0x120102000>
108f48bb4: f9401ff4    	ldr	x20, [sp, #0x38]
108f48bb8: f00b98d9    	adrp	x25, 0x120263000 <dyld_stub_binder+0x120263000>
108f48bbc: f00b98da    	adrp	x26, 0x120263000 <dyld_stub_binder+0x120263000>
108f48bc0: f00b98db    	adrp	x27, 0x120263000 <dyld_stub_binder+0x120263000>
108f48bc4: 14000002    	b	0x108f48bcc <_Flutter_MMFoundation_BindContext+0x54247b0>
108f48bc8: 1e6e1009    	fmov	d9, #1.00000000
108f48bcc: f8756a60    	ldr	x0, [x19, x21]
108f48bd0: f9449ef5    	ldr	x21, [x23, #0x938] ; height
108f48bd4: aa1503e1    	mov	x1, x21
108f48bd8: 95a44a1b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48bdc: 1e604008    	fmov	d8, d0
108f48be0: f8786a60    	ldr	x0, [x19, x24]
108f48be4: aa1503e1    	mov	x1, x21
108f48be8: 95a44a17    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48bec: 1e602100    	fcmp	d8, d0
108f48bf0: 1e684c01    	fcsel	d1, d0, d8, mi
108f48bf4: b989cb68    	ldrsw	x8, [x27, #0x9c8]
108f48bf8: bc686a60    	ldr	s0, [x19, x8]
108f48bfc: b989bec8    	ldrsw	x8, [x22, #0x9bc]
108f48c00: fc686a62    	ldr	d2, [x19, x8]
108f48c04: b989c348    	ldrsw	x8, [x26, #0x9c0]
108f48c08: fc686a63    	ldr	d3, [x19, x8]
108f48c0c: 7e61d800    	ucvtf	d0, d0
108f48c10: 1e632844    	fadd	d4, d2, d3
108f48c14: 1f648c00    	fnmsub	d0, d0, d4, d3
108f48c18: b989c728    	ldrsw	x8, [x25, #0x9c4]
108f48c1c: fc686a63    	ldr	d3, [x19, x8]
108f48c20: 1e632842    	fadd	d2, d2, d3
108f48c24: 1f420521    	fmadd	d1, d9, d2, d1
108f48c28: aa1303e0    	mov	x0, x19
108f48c2c: aa1403e1    	mov	x1, x20
108f48c30: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
108f48c34: a9494ff4    	ldp	x20, x19, [sp, #0x90]
108f48c38: a94857f6    	ldp	x22, x21, [sp, #0x80]
108f48c3c: a9475ff8    	ldp	x24, x23, [sp, #0x70]
108f48c40: a94667fa    	ldp	x26, x25, [sp, #0x60]
108f48c44: a9456ffc    	ldp	x28, x27, [sp, #0x50]
108f48c48: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
108f48c4c: 9102c3ff    	add	sp, sp, #0xb0
108f48c50: 15a449fd    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
