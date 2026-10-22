
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109b31ec4: d10243ff    	sub	sp, sp, #0x90
109b31ec8: 6d012beb    	stp	d11, d10, [sp, #0x10]
109b31ecc: 6d0223e9    	stp	d9, d8, [sp, #0x20]
109b31ed0: a9036ffc    	stp	x28, x27, [sp, #0x30]
109b31ed4: a90467fa    	stp	x26, x25, [sp, #0x40]
109b31ed8: a9055ff8    	stp	x24, x23, [sp, #0x50]
109b31edc: a90657f6    	stp	x22, x21, [sp, #0x60]
109b31ee0: a9074ff4    	stp	x20, x19, [sp, #0x70]
109b31ee4: a9087bfd    	stp	x29, x30, [sp, #0x80]
109b31ee8: 910203fd    	add	x29, sp, #0x80
109b31eec: aa0003f3    	mov	x19, x0
109b31ef0: f00b88e8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109b31ef4: 52800029    	mov	w9, #0x1                ; =1
109b31ef8: 3908a509    	strb	w9, [x8, #0x229]
109b31efc: f00b2e68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109b31f00: f9427516    	ldr	x22, [x8, #0x4e8] ; contentView
109b31f04: aa1603e1    	mov	x1, x22
109b31f08: 9574a54f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31f0c: aa1d03fd    	mov	x29, x29
109b31f10: 9574a550    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31f14: aa0003f4    	mov	x20, x0
109b31f18: d00b2e88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109b31f1c: f943f915    	ldr	x21, [x8, #0x7f0] ; isHidden
109b31f20: aa1503e1    	mov	x1, x21
109b31f24: 9574a548    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31f28: aa0003f7    	mov	x23, x0
109b31f2c: aa1403e0    	mov	x0, x20
109b31f30: 9574a54b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31f34: d00b2ec8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109b31f38: b00b2eb4    	adrp	x20, 0x120106000 <dyld_stub_binder+0x120106000>
109b31f3c: b00b2e9c    	adrp	x28, 0x120102000 <dyld_stub_binder+0x120102000>
109b31f40: 9007929b    	adrp	x27, 0x118d81000 <dyld_stub_binder+0x118d81000>
109b31f44: b0079299    	adrp	x25, 0x118d82000 <dyld_stub_binder+0x118d82000>
109b31f48: f00b185a    	adrp	x26, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109b31f4c: 340000b7    	cbz	w23, 0x109b31f60 <_Flutter_MMFoundation_BindContext+0x600db44>
109b31f50: b00b2608    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
109b31f54: f9450d17    	ldr	x23, [x8, #0xa18] ; privateImageView
109b31f58: 9e6703e9    	fmov	d9, xzr
109b31f5c: 14000088    	b	0x109b3217c <_Flutter_MMFoundation_BindContext+0x600dd60>
109b31f60: f947a501    	ldr	x1, [x8, #0xf48] ; wordingUseScope
109b31f64: aa1303e0    	mov	x0, x19
109b31f68: 9574a537    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31f6c: 1e604008    	fmov	d8, d0
109b31f70: f9445297    	ldr	x23, [x20, #0x8a0] ; safeAreaInsets
109b31f74: aa1303e0    	mov	x0, x19
109b31f78: aa1703e1    	mov	x1, x23
109b31f7c: 9574a532    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31f80: 1e661009    	fmov	d9, #16.00000000
109b31f84: 1e692820    	fadd	d0, d1, d9
109b31f88: 1e603908    	fsub	d8, d8, d0
109b31f8c: aa1303e0    	mov	x0, x19
109b31f90: aa1703e1    	mov	x1, x23
109b31f94: 9574a52c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31f98: 1e692860    	fadd	d0, d3, d9
109b31f9c: 1e603908    	fsub	d8, d8, d0
109b31fa0: b00b2608    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
109b31fa4: f9450d01    	ldr	x1, [x8, #0xa18] ; privateImageView
109b31fa8: f90007e1    	str	x1, [sp, #0x8]
109b31fac: aa1303e0    	mov	x0, x19
109b31fb0: 9574a525    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31fb4: aa1d03fd    	mov	x29, x29
109b31fb8: 9574a526    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31fbc: aa0003f8    	mov	x24, x0
109b31fc0: aa1503e1    	mov	x1, x21
109b31fc4: 9574a520    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31fc8: aa0003f9    	mov	x25, x0
109b31fcc: aa1803e0    	mov	x0, x24
109b31fd0: 9574a523    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31fd4: d2f80828    	mov	x8, #-0x3fbf000000000000 ; =-4593390144941195264
109b31fd8: 9e670100    	fmov	d0, x8
109b31fdc: 1e602900    	fadd	d0, d8, d0
109b31fe0: 7100033f    	cmp	w25, #0x0
109b31fe4: 1e601d08    	fcsel	d8, d8, d0, ne
109b31fe8: aa1303e0    	mov	x0, x19
109b31fec: aa1603e1    	mov	x1, x22
109b31ff0: 9574a515    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31ff4: aa1d03fd    	mov	x29, x29
109b31ff8: 9574a516    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31ffc: aa0003f8    	mov	x24, x0
109b32000: d00b1868    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
109b32004: f9472901    	ldr	x1, [x8, #0xe50] ; setFWidth:
109b32008: 1e604100    	fmov	d0, d8
109b3200c: 9574a50e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32010: aa1803e0    	mov	x0, x24
109b32014: 9574a512    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b32018: aa1303e0    	mov	x0, x19
109b3201c: aa1603e1    	mov	x1, x22
109b32020: 9574a509    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32024: aa1d03fd    	mov	x29, x29
109b32028: 9574a50a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b3202c: aa0003f8    	mov	x24, x0
109b32030: f00b1848    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
109b32034: f943c101    	ldr	x1, [x8, #0x780] ; dataItem
109b32038: aa1303e0    	mov	x0, x19
109b3203c: 9574a502    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32040: aa1d03fd    	mov	x29, x29
109b32044: 9574a503    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b32048: aa0003f9    	mov	x25, x0
109b3204c: d00b1868    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
109b32050: f9417501    	ldr	x1, [x8, #0x2e8] ; contentDesc
109b32054: 9574a4fc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32058: aa1d03fd    	mov	x29, x29
109b3205c: 9574a4fd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b32060: aa1c03f4    	mov	x20, x28
109b32064: aa1b03fc    	mov	x28, x27
109b32068: aa1a03fb    	mov	x27, x26
109b3206c: aa0003fa    	mov	x26, x0
109b32070: d00b1868    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
109b32074: f9417101    	ldr	x1, [x8, #0x2e0] ; setContent:
109b32078: aa1803e0    	mov	x0, x24
109b3207c: aa1a03e2    	mov	x2, x26
109b32080: 9574a4f1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32084: aa1a03e0    	mov	x0, x26
109b32088: aa1b03fa    	mov	x26, x27
109b3208c: aa1c03fb    	mov	x27, x28
109b32090: aa1403fc    	mov	x28, x20
109b32094: 9574a4f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b32098: aa1903e0    	mov	x0, x25
109b3209c: 90079299    	adrp	x25, 0x118d82000 <dyld_stub_binder+0x118d82000>
109b320a0: 9574a4ef    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b320a4: aa1803e0    	mov	x0, x24
109b320a8: 9574a4ed    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b320ac: aa1303e0    	mov	x0, x19
109b320b0: aa1703e1    	mov	x1, x23
109b320b4: 9574a4e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b320b8: 1e692828    	fadd	d8, d1, d9
109b320bc: aa1303e0    	mov	x0, x19
109b320c0: aa1603e1    	mov	x1, x22
109b320c4: 9574a4e0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b320c8: aa1d03fd    	mov	x29, x29
109b320cc: 9574a4e1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b320d0: aa0003f7    	mov	x23, x0
109b320d4: d00b1848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109b320d8: f9432101    	ldr	x1, [x8, #0x640] ; setLeft:
109b320dc: 1e604100    	fmov	d0, d8
109b320e0: 9574a4d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b320e4: aa1703e0    	mov	x0, x23
109b320e8: 9574a4dd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b320ec: f9449e97    	ldr	x23, [x20, #0x938] ; saveDump:withReportType:withReportID:
109b320f0: aa1303e0    	mov	x0, x19
109b320f4: aa1703e1    	mov	x1, x23
109b320f8: 9574a4d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b320fc: fd45c761    	ldr	d1, [x27, #0xb88]
109b32100: 1e612800    	fadd	d0, d0, d1
109b32104: 1e751001    	fmov	d1, #-12.00000000
109b32108: 1e612800    	fadd	d0, d0, d1
109b3210c: 1e6c1001    	fmov	d1, #0.50000000
109b32110: 1e610800    	fmul	d0, d0, d1
109b32114: fd40a321    	ldr	d1, [x25, #0x140]
109b32118: 1e612808    	fadd	d8, d0, d1
109b3211c: aa1303e0    	mov	x0, x19
109b32120: aa1603e1    	mov	x1, x22
109b32124: 9574a4c8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32128: aa1d03fd    	mov	x29, x29
109b3212c: 9574a4c9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b32130: aa0003f8    	mov	x24, x0
109b32134: f9401b41    	ldr	x1, [x26, #0x30] ; setCenterY:
109b32138: 1e604100    	fmov	d0, d8
109b3213c: 9574a4c2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32140: aa1803e0    	mov	x0, x24
109b32144: 9574a4c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b32148: aa1303e0    	mov	x0, x19
109b3214c: aa1603e1    	mov	x1, x22
109b32150: 9574a4bd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32154: aa1d03fd    	mov	x29, x29
109b32158: 9574a4be    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b3215c: aa0003f6    	mov	x22, x0
109b32160: aa1703e1    	mov	x1, x23
109b32164: f94007f7    	ldr	x23, [sp, #0x8]
109b32168: 9574a4b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b3216c: 9e6703e1    	fmov	d1, xzr
109b32170: 1e612809    	fadd	d9, d0, d1
109b32174: aa1603e0    	mov	x0, x22
109b32178: 9574a4b9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b3217c: aa1303e0    	mov	x0, x19
109b32180: aa1703e1    	mov	x1, x23
109b32184: 9574a4b0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32188: aa1d03fd    	mov	x29, x29
109b3218c: 9574a4b1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b32190: aa0003f6    	mov	x22, x0
109b32194: aa1503e1    	mov	x1, x21
109b32198: 9574a4ab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b3219c: aa0003f5    	mov	x21, x0
109b321a0: aa1603e0    	mov	x0, x22
109b321a4: 9574a4ae    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b321a8: 36000075    	tbz	w21, #0x0, 0x109b321b4 <_Flutter_MMFoundation_BindContext+0x600dd98>
109b321ac: b00b2edc    	adrp	x28, 0x12010b000 <dyld_stub_binder+0x12010b000>
109b321b0: 14000033    	b	0x109b3227c <_Flutter_MMFoundation_BindContext+0x600de60>
109b321b4: aa1c03f4    	mov	x20, x28
109b321b8: b00b2edc    	adrp	x28, 0x12010b000 <dyld_stub_binder+0x12010b000>
109b321bc: f947a781    	ldr	x1, [x28, #0xf48] ; width
109b321c0: aa1303e0    	mov	x0, x19
109b321c4: 9574a4a0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b321c8: 1e604008    	fmov	d8, d0
109b321cc: 900b2ea8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109b321d0: f9445101    	ldr	x1, [x8, #0x8a0] ; safeAreaInsets
109b321d4: aa1303e0    	mov	x0, x19
109b321d8: 9574a49b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b321dc: 1e661000    	fmov	d0, #16.00000000
109b321e0: 1e602860    	fadd	d0, d3, d0
109b321e4: 1e603908    	fsub	d8, d8, d0
109b321e8: aa1303e0    	mov	x0, x19
109b321ec: aa1703e1    	mov	x1, x23
109b321f0: 9574a495    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b321f4: aa1d03fd    	mov	x29, x29
109b321f8: 9574a496    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b321fc: aa0003f5    	mov	x21, x0
109b32200: d00b1848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109b32204: f9401501    	ldr	x1, [x8, #0x28] ; setRight:
109b32208: 1e604100    	fmov	d0, d8
109b3220c: 9574a48e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32210: aa1503e0    	mov	x0, x21
109b32214: 9574a492    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b32218: f9449e81    	ldr	x1, [x20, #0x938] ; saveDump:withReportType:withReportID:
109b3221c: aa1303e0    	mov	x0, x19
109b32220: 9574a489    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32224: fd45c761    	ldr	d1, [x27, #0xb88]
109b32228: 1e612800    	fadd	d0, d0, d1
109b3222c: 1e751001    	fmov	d1, #-12.00000000
109b32230: 1e612800    	fadd	d0, d0, d1
109b32234: 1e6c1001    	fmov	d1, #0.50000000
109b32238: 1e610800    	fmul	d0, d0, d1
109b3223c: fd40a321    	ldr	d1, [x25, #0x140]
109b32240: 1e612808    	fadd	d8, d0, d1
109b32244: aa1303e0    	mov	x0, x19
109b32248: aa1703e1    	mov	x1, x23
109b3224c: 9574a47e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32250: aa1d03fd    	mov	x29, x29
109b32254: 9574a47f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b32258: aa0003f4    	mov	x20, x0
109b3225c: f9401b41    	ldr	x1, [x26, #0x30] ; setCenterY:
109b32260: 1e604100    	fmov	d0, d8
109b32264: 9574a478    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32268: aa1403e0    	mov	x0, x20
109b3226c: 9574a47c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b32270: 1e66d000    	fmov	d0, #22.00000000
109b32274: 1e602120    	fcmp	d9, d0
109b32278: 1e694c09    	fcsel	d9, d0, d9, mi
109b3227c: 900b19e8    	adrp	x8, 0x11fe6e000 <dyld_stub_binder+0x11fe6e000>
109b32280: f9473d01    	ldr	x1, [x8, #0xe78] ; fittingSize
109b32284: aa1303e0    	mov	x0, x19
109b32288: 9574a46f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b3228c: 340001a0    	cbz	w0, 0x109b322c0 <_Flutter_MMFoundation_BindContext+0x600dea4>
109b32290: fd40a320    	ldr	d0, [x25, #0x140]
109b32294: 1e602920    	fadd	d0, d9, d0
109b32298: 1e651001    	fmov	d1, #12.00000000
109b3229c: 1e612808    	fadd	d8, d0, d1
109b322a0: f947a781    	ldr	x1, [x28, #0xf48] ; width
109b322a4: aa1303e0    	mov	x0, x19
109b322a8: 9574a467    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b322ac: f00b2ea8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109b322b0: f9453d01    	ldr	x1, [x8, #0xa78] ; setSize:
109b322b4: aa1303e0    	mov	x0, x19
109b322b8: 1e604101    	fmov	d1, d8
109b322bc: 9574a462    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b322c0: b00b2e68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109b322c4: f943d501    	ldr	x1, [x8, #0x7a8] ; bounds
109b322c8: aa1303e0    	mov	x0, x19
109b322cc: 9574a45e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b322d0: 1e604008    	fmov	d8, d0
109b322d4: 1e604029    	fmov	d9, d1
109b322d8: 1e60404a    	fmov	d10, d2
109b322dc: 1e60406b    	fmov	d11, d3
109b322e0: d00b1b28    	adrp	x8, 0x11fe98000 <dyld_stub_binder+0x11fe98000>
109b322e4: f9476101    	ldr	x1, [x8, #0xec0] ; backgroundLayer
109b322e8: aa1303e0    	mov	x0, x19
109b322ec: 9574a456    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b322f0: aa1d03fd    	mov	x29, x29
109b322f4: 9574a457    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b322f8: aa0003f3    	mov	x19, x0
109b322fc: d00b2ea8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
109b32300: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
109b32304: 1e604100    	fmov	d0, d8
109b32308: 1e604121    	fmov	d1, d9
109b3230c: 1e604142    	fmov	d2, d10
109b32310: 1e604163    	fmov	d3, d11
109b32314: 9574a44c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b32318: aa1303e0    	mov	x0, x19
109b3231c: a9487bfd    	ldp	x29, x30, [sp, #0x80]
109b32320: a9474ff4    	ldp	x20, x19, [sp, #0x70]
109b32324: a94657f6    	ldp	x22, x21, [sp, #0x60]
109b32328: a9455ff8    	ldp	x24, x23, [sp, #0x50]
109b3232c: a94467fa    	ldp	x26, x25, [sp, #0x40]
109b32330: a9436ffc    	ldp	x28, x27, [sp, #0x30]
109b32334: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
109b32338: 6d412beb    	ldp	d11, d10, [sp, #0x10]
109b3233c: 910243ff    	add	sp, sp, #0x90
109b32340: 1574a447    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
