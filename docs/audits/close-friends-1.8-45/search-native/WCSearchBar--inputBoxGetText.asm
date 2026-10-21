
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ddaf7c: d101c3ff    	sub	sp, sp, #0x70
109ddaf80: a9016ffc    	stp	x28, x27, [sp, #0x10]
109ddaf84: a90267fa    	stp	x26, x25, [sp, #0x20]
109ddaf88: a9035ff8    	stp	x24, x23, [sp, #0x30]
109ddaf8c: a90457f6    	stp	x22, x21, [sp, #0x40]
109ddaf90: a9054ff4    	stp	x20, x19, [sp, #0x50]
109ddaf94: a9067bfd    	stp	x29, x30, [sp, #0x60]
109ddaf98: 910183fd    	add	x29, sp, #0x60
109ddaf9c: aa0003f3    	mov	x19, x0
109ddafa0: d00b73a8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109ddafa4: 52800029    	mov	w9, #0x1                ; =1
109ddafa8: 3926f909    	strb	w9, [x8, #0x9be]
109ddafac: f00b0668    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109ddafb0: f9403101    	ldr	x1, [x8, #0x60] ; enableLargeInput
109ddafb4: 956a0124    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddafb8: aa0003f4    	mov	x20, x0
109ddafbc: d00b15a8    	adrp	x8, 0x120090000 <dyld_stub_binder+0x120090000>
109ddafc0: f9479901    	ldr	x1, [x8, #0xf30] ; enableRemoveEditingWords
109ddafc4: aa1303e0    	mov	x0, x19
109ddafc8: 956a011f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddafcc: b00b1998    	adrp	x24, 0x12010b000 <dyld_stub_binder+0x12010b000>
109ddafd0: 34000234    	cbz	w20, 0x109ddb014 <_Flutter_MMFoundation_BindContext+0x62b6bf8>
109ddafd4: b00b0368    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
109ddafd8: f9430514    	ldr	x20, [x8, #0x608] ; textView
109ddafdc: 34000fc0    	cbz	w0, 0x109ddb1d4 <_Flutter_MMFoundation_BindContext+0x62b6db8>
109ddafe0: aa1303e0    	mov	x0, x19
109ddafe4: aa1403e1    	mov	x1, x20
109ddafe8: 956a0117    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddafec: aa1d03fd    	mov	x29, x29
109ddaff0: 956a0118    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddaff4: aa0003f5    	mov	x21, x0
109ddaff8: f00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddaffc: f9412d01    	ldr	x1, [x8, #0x258] ; confirmedText
109ddb000: 956a0111    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb004: aa1d03fd    	mov	x29, x29
109ddb008: 956a0112    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb00c: aa0003f9    	mov	x25, x0
109ddb010: 1400006d    	b	0x109ddb1c4 <_Flutter_MMFoundation_BindContext+0x62b6da8>
109ddb014: f00b0508    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109ddb018: f945e514    	ldr	x20, [x8, #0xbc8] ; textField
109ddb01c: 34000dc0    	cbz	w0, 0x109ddb1d4 <_Flutter_MMFoundation_BindContext+0x62b6db8>
109ddb020: aa1303e0    	mov	x0, x19
109ddb024: aa1403e1    	mov	x1, x20
109ddb028: 956a0107    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb02c: aa1d03fd    	mov	x29, x29
109ddb030: 956a0108    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb034: aa0003f6    	mov	x22, x0
109ddb038: b00b1948    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
109ddb03c: f9431501    	ldr	x1, [x8, #0x628] ; markedTextRange
109ddb040: 956a0101    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb044: aa1d03fd    	mov	x29, x29
109ddb048: 956a0102    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb04c: aa0003f5    	mov	x21, x0
109ddb050: aa1603e0    	mov	x0, x22
109ddb054: 956a0102    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb058: 900a3616    	adrp	x22, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
109ddb05c: 910322d6    	add	x22, x22, #0xc8
109ddb060: b4000075    	cbz	x21, 0x109ddb06c <_Flutter_MMFoundation_BindContext+0x62b6c50>
109ddb064: f90007ff    	str	xzr, [sp, #0x8]
109ddb068: 14000014    	b	0x109ddb0b8 <_Flutter_MMFoundation_BindContext+0x62b6c9c>
109ddb06c: aa1303e0    	mov	x0, x19
109ddb070: aa1403e1    	mov	x1, x20
109ddb074: 956a00f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb078: aa1d03fd    	mov	x29, x29
109ddb07c: 956a00f5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb080: aa0003f7    	mov	x23, x0
109ddb084: f9401701    	ldr	x1, [x24, #0x28] ; text
109ddb088: 956a00ef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb08c: aa1d03fd    	mov	x29, x29
109ddb090: 956a00f0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb094: aa0003f8    	mov	x24, x0
109ddb098: f100001f    	cmp	x0, #0x0
109ddb09c: 9a8002c0    	csel	x0, x22, x0, eq
109ddb0a0: f90007e0    	str	x0, [sp, #0x8]
109ddb0a4: 956a00e7    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109ddb0a8: aa1803e0    	mov	x0, x24
109ddb0ac: 956a00ec    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb0b0: aa1703e0    	mov	x0, x23
109ddb0b4: 956a00ea    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb0b8: aa1303e0    	mov	x0, x19
109ddb0bc: aa1403e1    	mov	x1, x20
109ddb0c0: 956a00e1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb0c4: aa1d03fd    	mov	x29, x29
109ddb0c8: 956a00e2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb0cc: aa0003f8    	mov	x24, x0
109ddb0d0: 900b1928    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109ddb0d4: f9434901    	ldr	x1, [x8, #0x690] ; beginningOfDocument
109ddb0d8: 956a00db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb0dc: aa1d03fd    	mov	x29, x29
109ddb0e0: 956a00dc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb0e4: aa0003f7    	mov	x23, x0
109ddb0e8: aa1803e0    	mov	x0, x24
109ddb0ec: 956a00dc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb0f0: f00b1968    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109ddb0f4: f944d101    	ldr	x1, [x8, #0x9a0] ; start
109ddb0f8: aa1503e0    	mov	x0, x21
109ddb0fc: 956a00d2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb100: aa1d03fd    	mov	x29, x29
109ddb104: 956a00d3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb108: aa0003f8    	mov	x24, x0
109ddb10c: aa1303e0    	mov	x0, x19
109ddb110: aa1403e1    	mov	x1, x20
109ddb114: 956a00cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb118: aa1d03fd    	mov	x29, x29
109ddb11c: 956a00cd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb120: aa0003f9    	mov	x25, x0
109ddb124: 900b1988    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109ddb128: f9402901    	ldr	x1, [x8, #0x50] ; textRangeFromPosition:toPosition:
109ddb12c: aa1703e2    	mov	x2, x23
109ddb130: aa1803e3    	mov	x3, x24
109ddb134: 956a00c4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb138: aa1d03fd    	mov	x29, x29
109ddb13c: 956a00c5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb140: aa0003fa    	mov	x26, x0
109ddb144: aa1903e0    	mov	x0, x25
109ddb148: 956a00c5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb14c: aa1303e0    	mov	x0, x19
109ddb150: aa1403e1    	mov	x1, x20
109ddb154: 956a00bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb158: aa1d03fd    	mov	x29, x29
109ddb15c: 956a00bd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb160: aa0003fb    	mov	x27, x0
109ddb164: b00b07e8    	adrp	x8, 0x11fed8000 <dyld_stub_binder+0x11fed8000>
109ddb168: f9416901    	ldr	x1, [x8, #0x2d0] ; textInRange:
109ddb16c: aa1a03e2    	mov	x2, x26
109ddb170: 956a00b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb174: aa1d03fd    	mov	x29, x29
109ddb178: 956a00b6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb17c: aa0003fc    	mov	x28, x0
109ddb180: f100001f    	cmp	x0, #0x0
109ddb184: 9a8002d9    	csel	x25, x22, x0, eq
109ddb188: aa1903e0    	mov	x0, x25
109ddb18c: 956a00ad    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109ddb190: f94007e0    	ldr	x0, [sp, #0x8]
109ddb194: 956a00b2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb198: aa1c03e0    	mov	x0, x28
109ddb19c: 956a00b0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1a0: aa1b03e0    	mov	x0, x27
109ddb1a4: 956a00ae    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1a8: aa1a03e0    	mov	x0, x26
109ddb1ac: 956a00ac    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1b0: aa1803e0    	mov	x0, x24
109ddb1b4: 956a00aa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1b8: aa1703e0    	mov	x0, x23
109ddb1bc: 956a00a8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1c0: 900b1998    	adrp	x24, 0x12010b000 <dyld_stub_binder+0x12010b000>
109ddb1c4: aa1503e0    	mov	x0, x21
109ddb1c8: 956a00a5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1cc: aa1903e0    	mov	x0, x25
109ddb1d0: 956a00a3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb1d4: aa1303e0    	mov	x0, x19
109ddb1d8: aa1403e1    	mov	x1, x20
109ddb1dc: 956a009a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb1e0: aa1d03fd    	mov	x29, x29
109ddb1e4: 956a009b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb1e8: aa0003f3    	mov	x19, x0
109ddb1ec: f9401701    	ldr	x1, [x24, #0x28] ; text
109ddb1f0: 956a0095    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb1f4: aa1d03fd    	mov	x29, x29
109ddb1f8: 956a0096    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb1fc: aa0003f4    	mov	x20, x0
109ddb200: aa1303e0    	mov	x0, x19
109ddb204: 956a0096    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb208: 900b1cc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109ddb20c: f9467900    	ldr	x0, [x8, #0xcf0]
109ddb210: d00b03e8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
109ddb214: f9436501    	ldr	x1, [x8, #0x6c8] ; trimString:
109ddb218: aa1403e2    	mov	x2, x20
109ddb21c: 956a008a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddb220: aa1d03fd    	mov	x29, x29
109ddb224: 956a008b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddb228: aa0003f3    	mov	x19, x0
109ddb22c: aa1403e0    	mov	x0, x20
109ddb230: 956a008b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddb234: aa1303e0    	mov	x0, x19
109ddb238: a9467bfd    	ldp	x29, x30, [sp, #0x60]
109ddb23c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
109ddb240: a94457f6    	ldp	x22, x21, [sp, #0x40]
109ddb244: a9435ff8    	ldp	x24, x23, [sp, #0x30]
109ddb248: a94267fa    	ldp	x26, x25, [sp, #0x20]
109ddb24c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
109ddb250: 9101c3ff    	add	sp, sp, #0x70
109ddb254: 156a0089    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>
