
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1092bfd90: d10683ff    	sub	sp, sp, #0x1a0
1092bfd94: a9146ffc    	stp	x28, x27, [sp, #0x140]
1092bfd98: a91567fa    	stp	x26, x25, [sp, #0x150]
1092bfd9c: a9165ff8    	stp	x24, x23, [sp, #0x160]
1092bfda0: a91757f6    	stp	x22, x21, [sp, #0x170]
1092bfda4: a9184ff4    	stp	x20, x19, [sp, #0x180]
1092bfda8: a9197bfd    	stp	x29, x30, [sp, #0x190]
1092bfdac: 910643fd    	add	x29, sp, #0x190
1092bfdb0: 900a1988    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1092bfdb4: f9405908    	ldr	x8, [x8, #0xb0]
1092bfdb8: f9400108    	ldr	x8, [x8]
1092bfdbc: f81a03a8    	stur	x8, [x29, #-0x60]
1092bfdc0: f00bcc68    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
1092bfdc4: 52800029    	mov	w9, #0x1                ; =1
1092bfdc8: 39245909    	strb	w9, [x8, #0x916]
1092bfdcc: 900b7d48    	adrp	x8, 0x120267000 <dyld_stub_binder+0x120267000>
1092bfdd0: b9811d08    	ldrsw	x8, [x8, #0x11c]
1092bfdd4: f90017e0    	str	x0, [sp, #0x28]
1092bfdd8: f8686800    	ldr	x0, [x0, x8]
1092bfddc: b00b6d88    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
1092bfde0: f9442501    	ldr	x1, [x8, #0x848] ; getUnreadWCMessages
1092bfde4: 95966d98    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfde8: aa1d03fd    	mov	x29, x29
1092bfdec: 95966d99    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092bfdf0: 4f00e400    	movi.16b	v0, #0x0
1092bfdf4: ad0383e0    	stp	q0, q0, [sp, #0x70]
1092bfdf8: ad0483e0    	stp	q0, q0, [sp, #0x90]
1092bfdfc: b00b7208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1092bfe00: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1092bfe04: 9101c3e2    	add	x2, sp, #0x70
1092bfe08: 9102c3e3    	add	x3, sp, #0xb0
1092bfe0c: a90303e1    	stp	x1, x0, [sp, #0x30]
1092bfe10: 52800204    	mov	w4, #0x10               ; =16
1092bfe14: 95966d8c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfe18: f90037e0    	str	x0, [sp, #0x68]
1092bfe1c: b4000ca0    	cbz	x0, 0x1092bffb0 <_Flutter_MMFoundation_BindContext+0x579bb94>
1092bfe20: f94043e8    	ldr	x8, [sp, #0x80]
1092bfe24: f9400108    	ldr	x8, [x8]
1092bfe28: f90023e8    	str	x8, [sp, #0x40]
1092bfe2c: d2800015    	mov	x21, #0x0               ; =0
1092bfe30: f00b5d88    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
1092bfe34: f942651a    	ldr	x26, [x8, #0x4c8] ; comment
1092bfe38: b00b5be8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1092bfe3c: f9471109    	ldr	x9, [x8, #0xe20] ; username
1092bfe40: b00b5be8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1092bfe44: f947c908    	ldr	x8, [x8, #0xf90] ; generatePrivacyString:
1092bfe48: a905a7e8    	stp	x8, x9, [sp, #0x58]
1092bfe4c: f00b5fc8    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1092bfe50: f942c109    	ldr	x9, [x8, #0x580] ; commentID
1092bfe54: 900b6a08    	adrp	x8, 0x11ffff000 <dyld_stub_binder+0x11ffff000>
1092bfe58: f943c908    	ldr	x8, [x8, #0x790] ; hasRead
1092bfe5c: a904a7e8    	stp	x8, x9, [sp, #0x48]
1092bfe60: d00b5bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1092bfe64: f942a914    	ldr	x20, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1092bfe68: f94043e8    	ldr	x8, [sp, #0x80]
1092bfe6c: f9400108    	ldr	x8, [x8]
1092bfe70: f94023e9    	ldr	x9, [sp, #0x40]
1092bfe74: eb09011f    	cmp	x8, x9
1092bfe78: 54000060    	b.eq	0x1092bfe84 <_Flutter_MMFoundation_BindContext+0x579ba68>
1092bfe7c: f9401fe0    	ldr	x0, [sp, #0x38]
1092bfe80: 95966d76    	bl	0x10f85b458 <_UR_96F1_B25D+0x3a640c8>
1092bfe84: f9403fe8    	ldr	x8, [sp, #0x78]
1092bfe88: f8757918    	ldr	x24, [x8, x21, lsl #3]
1092bfe8c: 900b75a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1092bfe90: f9453519    	ldr	x25, [x8, #0xa68]
1092bfe94: 900b75a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1092bfe98: f9454516    	ldr	x22, [x8, #0xa88]
1092bfe9c: aa1803e0    	mov	x0, x24
1092bfea0: aa1a03e1    	mov	x1, x26
1092bfea4: 95966d68    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfea8: aa1d03fd    	mov	x29, x29
1092bfeac: 95966d69    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092bfeb0: aa0003f7    	mov	x23, x0
1092bfeb4: f94033e1    	ldr	x1, [sp, #0x60]
1092bfeb8: 95966d63    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfebc: aa1d03fd    	mov	x29, x29
1092bfec0: 95966d64    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092bfec4: aa0003fb    	mov	x27, x0
1092bfec8: aa1603e0    	mov	x0, x22
1092bfecc: f9402fe1    	ldr	x1, [sp, #0x58]
1092bfed0: aa1b03e2    	mov	x2, x27
1092bfed4: 95966d5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfed8: aa1d03fd    	mov	x29, x29
1092bfedc: 95966d5d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092bfee0: aa0003f6    	mov	x22, x0
1092bfee4: aa1803e0    	mov	x0, x24
1092bfee8: aa1a03e1    	mov	x1, x26
1092bfeec: 95966d56    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfef0: aa1d03fd    	mov	x29, x29
1092bfef4: 95966d57    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092bfef8: aa0003fc    	mov	x28, x0
1092bfefc: f9402be1    	ldr	x1, [sp, #0x50]
1092bff00: 95966d51    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bff04: aa1d03fd    	mov	x29, x29
1092bff08: 95966d52    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092bff0c: aa0003f3    	mov	x19, x0
1092bff10: aa1803e0    	mov	x0, x24
1092bff14: f94027e1    	ldr	x1, [sp, #0x48]
1092bff18: 95966d4b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bff1c: a90103f3    	stp	x19, x0, [sp, #0x10]
1092bff20: d00ab888    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1092bff24: 910c2108    	add	x8, x8, #0x308
1092bff28: a9005be8    	stp	x8, x22, [sp]
1092bff2c: aa1903e0    	mov	x0, x25
1092bff30: aa1403e1    	mov	x1, x20
1092bff34: 52800022    	mov	w2, #0x1                ; =1
1092bff38: b008fae3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
1092bff3c: 912b2863    	add	x3, x3, #0xaca
1092bff40: 52800004    	mov	w4, #0x0                ; =0
1092bff44: d0094c65    	adrp	x5, 0x11bc4d000 <dyld_stub_binder+0x11bc4d000>
1092bff48: 912fc4a5    	add	x5, x5, #0xbf1
1092bff4c: 528040e6    	mov	w6, #0x207              ; =519
1092bff50: f0094c67    	adrp	x7, 0x11bc4e000 <dyld_stub_binder+0x11bc4e000>
1092bff54: 9107a4e7    	add	x7, x7, #0x1e9
1092bff58: 95966d3b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bff5c: aa1303e0    	mov	x0, x19
1092bff60: 95966d3f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092bff64: aa1c03e0    	mov	x0, x28
1092bff68: 95966d3d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092bff6c: aa1603e0    	mov	x0, x22
1092bff70: 95966d3b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092bff74: aa1b03e0    	mov	x0, x27
1092bff78: 95966d39    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092bff7c: aa1703e0    	mov	x0, x23
1092bff80: 95966d37    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092bff84: 910006b5    	add	x21, x21, #0x1
1092bff88: f94037e8    	ldr	x8, [sp, #0x68]
1092bff8c: eb15011f    	cmp	x8, x21
1092bff90: 54fff6c1    	b.ne	0x1092bfe68 <_Flutter_MMFoundation_BindContext+0x579ba4c>
1092bff94: 9101c3e2    	add	x2, sp, #0x70
1092bff98: 9102c3e3    	add	x3, sp, #0xb0
1092bff9c: a94303e1    	ldp	x1, x0, [sp, #0x30]
1092bffa0: 52800204    	mov	w4, #0x10               ; =16
1092bffa4: 95966d28    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bffa8: f90037e0    	str	x0, [sp, #0x68]
1092bffac: b5fff400    	cbnz	x0, 0x1092bfe2c <_Flutter_MMFoundation_BindContext+0x579ba10>
1092bffb0: 900b7d48    	adrp	x8, 0x120267000 <dyld_stub_binder+0x120267000>
1092bffb4: b9811514    	ldrsw	x20, [x8, #0x114]
1092bffb8: f94017f6    	ldr	x22, [sp, #0x28]
1092bffbc: b8b46ad5    	ldrsw	x21, [x22, x20]
1092bffc0: b00b7208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1092bffc4: f9435113    	ldr	x19, [x8, #0x6a0] ; count
1092bffc8: f9401fe0    	ldr	x0, [sp, #0x38]
1092bffcc: aa1303e1    	mov	x1, x19
1092bffd0: 95966d1d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bffd4: eb15001f    	cmp	x0, x21
1092bffd8: 54000120    	b.eq	0x1092bfffc <_Flutter_MMFoundation_BindContext+0x579bbe0>
1092bffdc: f9401fe0    	ldr	x0, [sp, #0x38]
1092bffe0: aa1303e1    	mov	x1, x19
1092bffe4: 95966d18    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bffe8: b8346ac0    	str	w0, [x22, x20]
1092bffec: b00b5f08    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
1092bfff0: f947a101    	ldr	x1, [x8, #0xf40] ; saveSetting
1092bfff4: aa1603e0    	mov	x0, x22
1092bfff8: 95966d13    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bfffc: f85a03a8    	ldur	x8, [x29, #-0x60]
1092c0000: f00a1969    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1092c0004: f9405929    	ldr	x9, [x9, #0xb0]
1092c0008: f9400129    	ldr	x9, [x9]
1092c000c: eb08013f    	cmp	x9, x8
1092c0010: 54000141    	b.ne	0x1092c0038 <_Flutter_MMFoundation_BindContext+0x579bc1c>
1092c0014: f9401fe0    	ldr	x0, [sp, #0x38]
1092c0018: a9597bfd    	ldp	x29, x30, [sp, #0x190]
1092c001c: a9584ff4    	ldp	x20, x19, [sp, #0x180]
1092c0020: a95757f6    	ldp	x22, x21, [sp, #0x170]
1092c0024: a9565ff8    	ldp	x24, x23, [sp, #0x160]
1092c0028: a95567fa    	ldp	x26, x25, [sp, #0x150]
1092c002c: a9546ffc    	ldp	x28, x27, [sp, #0x140]
1092c0030: 910683ff    	add	sp, sp, #0x1a0
1092c0034: 15966d11    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
1092c0038: 95966d11    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
