
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109993f9c: d10143ff    	sub	sp, sp, #0x50
109993fa0: a9015ff8    	stp	x24, x23, [sp, #0x10]
109993fa4: a90257f6    	stp	x22, x21, [sp, #0x20]
109993fa8: a9034ff4    	stp	x20, x19, [sp, #0x30]
109993fac: a9047bfd    	stp	x29, x30, [sp, #0x40]
109993fb0: 910103fd    	add	x29, sp, #0x40
109993fb4: 900b95e8    	adrp	x8, 0x120c4f000 <dyld_stub_binder+0x120c4f000>
109993fb8: 52800029    	mov	w9, #0x1                ; =1
109993fbc: 39356109    	strb	w9, [x8, #0xd58]
109993fc0: f00b41e8    	adrp	x8, 0x1201d2000 <dyld_stub_binder+0x1201d2000>
109993fc4: f9478108    	ldr	x8, [x8, #0xf00]
109993fc8: a90023e0    	stp	x0, x8, [sp]
109993fcc: f00b3b68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
109993fd0: f9478d01    	ldr	x1, [x8, #0xf18] ; initWithData:
109993fd4: 910003e0    	mov	x0, sp
109993fd8: 957b1d1d    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
109993fdc: aa0003f3    	mov	x19, x0
109993fe0: b4000520    	cbz	x0, 0x109994084 <_Flutter_MMFoundation_BindContext+0x5e6fc68>
109993fe4: 900b3f17    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
109993fe8: f945eae0    	ldr	x0, [x23, #0xbd0] ; ��d 
109993fec: b00b3b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109993ff0: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
109993ff4: aa1403e1    	mov	x1, x20
109993ff8: 957b1d13    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109993ffc: aa1d03fd    	mov	x29, x29
109994000: 957b1d14    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994004: aa0003f5    	mov	x21, x0
109994008: b00b3ee8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
10999400c: f947f102    	ldr	x2, [x8, #0xfe0]
109994010: d00b2528    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
109994014: f940a116    	ldr	x22, [x8, #0x140] ; registerExtension:withTarget:
109994018: aa1603e1    	mov	x1, x22
10999401c: aa1303e3    	mov	x3, x19
109994020: 957b1d09    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994024: aa1503e0    	mov	x0, x21
109994028: 957b1d0d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10999402c: f945eae0    	ldr	x0, [x23, #0xbd0] ; ��d 
109994030: aa1403e1    	mov	x1, x20
109994034: 957b1d04    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994038: aa1d03fd    	mov	x29, x29
10999403c: 957b1d05    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994040: aa0003f4    	mov	x20, x0
109994044: 900b3ee8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
109994048: f9457102    	ldr	x2, [x8, #0xae0]
10999404c: aa1603e1    	mov	x1, x22
109994050: aa1303e3    	mov	x3, x19
109994054: 957b1cfc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994058: aa1403e0    	mov	x0, x20
10999405c: 957b1d00    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994060: b00b3fc8    	adrp	x8, 0x12018d000 <dyld_stub_binder+0x12018d000>
109994064: f9471500    	ldr	x0, [x8, #0xe28] ; �kD 
109994068: 957b1cfe    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10999406c: b00b46c8    	adrp	x8, 0x12026d000 <dyld_stub_binder+0x12026d000>
109994070: b98efd09    	ldrsw	x9, [x8, #0xefc]
109994074: f8696a68    	ldr	x8, [x19, x9]
109994078: f8296a60    	str	x0, [x19, x9]
10999407c: aa0803e0    	mov	x0, x8
109994080: 957b1cf7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994084: aa1303e0    	mov	x0, x19
109994088: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10999408c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109994090: a94257f6    	ldp	x22, x21, [sp, #0x20]
109994094: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109994098: 910143ff    	add	sp, sp, #0x50
10999409c: d65f03c0    	ret