
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bdb14: d10103ff    	sub	sp, sp, #0x40
10a9bdb18: a90157f6    	stp	x22, x21, [sp, #0x10]
10a9bdb1c: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a9bdb20: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a9bdb24: 9100c3fd    	add	x29, sp, #0x30
10a9bdb28: d00b14a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a9bdb2c: 52800029    	mov	w9, #0x1                ; =1
10a9bdb30: 3913f909    	strb	w9, [x8, #0x4fe]
10a9bdb34: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bdb38: b98ea915    	ldrsw	x21, [x8, #0xea8]
10a9bdb3c: f8756814    	ldr	x20, [x0, x21]
10a9bdb40: b4000094    	cbz	x20, 0x10a9bdb50 <_Flutter_MMFoundation_BindContext+0x6e99734>
10a9bdb44: aa1403e0    	mov	x0, x20
10a9bdb48: 953a763e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bdb4c: 1400002d    	b	0x10a9bdc00 <_Flutter_MMFoundation_BindContext+0x6e997e4>
10a9bdb50: aa0003f3    	mov	x19, x0
10a9bdb54: d00ac5e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a9bdb58: b98e9916    	ldrsw	x22, [x8, #0xe98]
10a9bdb5c: f8766808    	ldr	x8, [x0, x22]
10a9bdb60: b4000328    	cbz	x8, 0x10a9bdbc4 <_Flutter_MMFoundation_BindContext+0x6e997a8>
10a9bdb64: 910023e0    	add	x0, sp, #0x8
10a9bdb68: 9539d32e    	bl	0x10f832820 <_UR_96F1_B25D+0x3a3b490>
10a9bdb6c: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bdb70: f945f914    	ldr	x20, [x8, #0xbf0] ; setIsDynamicImg:
10a9bdb74: aa1303e0    	mov	x0, x19
10a9bdb78: aa1403e1    	mov	x1, x20
10a9bdb7c: 52800002    	mov	w2, #0x0                ; =0
10a9bdb80: 953a7631    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdb84: f8766a60    	ldr	x0, [x19, x22]
10a9bdb88: f9400808    	ldr	x8, [x0, #0x10]
10a9bdb8c: d63f0100    	blr	x8
10a9bdb90: aa1d03fd    	mov	x29, x29
10a9bdb94: 953a762f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9bdb98: f8756a68    	ldr	x8, [x19, x21]
10a9bdb9c: f8356a60    	str	x0, [x19, x21]
10a9bdba0: aa0803e0    	mov	x0, x8
10a9bdba4: 953a762e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdba8: f8756a68    	ldr	x8, [x19, x21]
10a9bdbac: b4000108    	cbz	x8, 0x10a9bdbcc <_Flutter_MMFoundation_BindContext+0x6e997b0>
10a9bdbb0: f8766a60    	ldr	x0, [x19, x22]
10a9bdbb4: f8366a7f    	str	xzr, [x19, x22]
10a9bdbb8: 953a7629    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bdbbc: f8756a60    	ldr	x0, [x19, x21]
10a9bdbc0: 14000004    	b	0x10a9bdbd0 <_Flutter_MMFoundation_BindContext+0x6e997b4>
10a9bdbc4: d2800014    	mov	x20, #0x0               ; =0
10a9bdbc8: 1400000e    	b	0x10a9bdc00 <_Flutter_MMFoundation_BindContext+0x6e997e4>
10a9bdbcc: d2800000    	mov	x0, #0x0                ; =0
10a9bdbd0: b00aa428    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10a9bdbd4: f9443901    	ldr	x1, [x8, #0x870] ; isDynamicImage
10a9bdbd8: 953a761b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdbdc: aa0003e2    	mov	x2, x0
10a9bdbe0: aa1303e0    	mov	x0, x19
10a9bdbe4: aa1403e1    	mov	x1, x20
10a9bdbe8: 953a7617    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bdbec: f8756a74    	ldr	x20, [x19, x21]
10a9bdbf0: aa1403e0    	mov	x0, x20
10a9bdbf4: 953a7613    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bdbf8: 910023e0    	add	x0, sp, #0x8
10a9bdbfc: 9539d30a    	bl	0x10f832824 <_UR_96F1_B25D+0x3a3b494>
10a9bdc00: aa1403e0    	mov	x0, x20
10a9bdc04: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a9bdc08: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a9bdc0c: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a9bdc10: 910103ff    	add	sp, sp, #0x40
10a9bdc14: 153a7619    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>