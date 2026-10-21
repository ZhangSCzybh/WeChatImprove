
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109dd9fbc: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
109dd9fc0: a90167fa    	stp	x26, x25, [sp, #0x10]
109dd9fc4: a9025ff8    	stp	x24, x23, [sp, #0x20]
109dd9fc8: a90357f6    	stp	x22, x21, [sp, #0x30]
109dd9fcc: a9044ff4    	stp	x20, x19, [sp, #0x40]
109dd9fd0: a9057bfd    	stp	x29, x30, [sp, #0x50]
109dd9fd4: 910143fd    	add	x29, sp, #0x50
109dd9fd8: aa0003f3    	mov	x19, x0
109dd9fdc: f00b73a8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109dd9fe0: 52800029    	mov	w9, #0x1                ; =1
109dd9fe4: 3926e909    	strb	w9, [x8, #0x9ba]
109dd9fe8: 900b0688    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109dd9fec: f9403101    	ldr	x1, [x8, #0x60] ; enableLargeInput
109dd9ff0: 956a0515    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9ff4: 34000bc0    	cbz	w0, 0x109dda16c <_Flutter_MMFoundation_BindContext+0x62b5d50>
109dd9ff8: d00b0368    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
109dd9ffc: f9430514    	ldr	x20, [x8, #0x608] ; textView
109dda000: aa1303e0    	mov	x0, x19
109dda004: aa1403e1    	mov	x1, x20
109dda008: 956a050f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda00c: aa1d03fd    	mov	x29, x29
109dda010: 956a0510    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda014: aa0003f5    	mov	x21, x0
109dda018: f00b1968    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109dda01c: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109dda020: b00a3602    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
109dda024: 91032042    	add	x2, x2, #0xc8
109dda028: 956a0507    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda02c: aa1503e0    	mov	x0, x21
109dda030: 956a050b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda034: f00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dda038: f9411915    	ldr	x21, [x8, #0x230] ; searchBarDelegate
109dda03c: aa1303e0    	mov	x0, x19
109dda040: aa1503e1    	mov	x1, x21
109dda044: 956a0500    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda048: aa1d03fd    	mov	x29, x29
109dda04c: 956a0501    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda050: b4001580    	cbz	x0, 0x109dda300 <_Flutter_MMFoundation_BindContext+0x62b5ee4>
109dda054: aa0003f7    	mov	x23, x0
109dda058: aa1303e0    	mov	x0, x19
109dda05c: aa1503e1    	mov	x1, x21
109dda060: 956a04f9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda064: aa1d03fd    	mov	x29, x29
109dda068: 956a04fa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda06c: aa0003f8    	mov	x24, x0
109dda070: f00b0668    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109dda074: f9415516    	ldr	x22, [x8, #0x2a8] ; mmInputBoxTextChanged:text:
109dda078: 900b1968    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109dda07c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109dda080: aa1603e2    	mov	x2, x22
109dda084: 956a04f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda088: aa0003f9    	mov	x25, x0
109dda08c: aa1803e0    	mov	x0, x24
109dda090: 956a04f3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda094: aa1703e0    	mov	x0, x23
109dda098: 956a04f1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda09c: 34001339    	cbz	w25, 0x109dda300 <_Flutter_MMFoundation_BindContext+0x62b5ee4>
109dda0a0: aa1303e0    	mov	x0, x19
109dda0a4: aa1503e1    	mov	x1, x21
109dda0a8: 956a04e7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda0ac: aa1d03fd    	mov	x29, x29
109dda0b0: 956a04e8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda0b4: aa0003f5    	mov	x21, x0
109dda0b8: aa1303e0    	mov	x0, x19
109dda0bc: aa1403e1    	mov	x1, x20
109dda0c0: 956a04e1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda0c4: aa1d03fd    	mov	x29, x29
109dda0c8: 956a04e2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda0cc: aa0003f7    	mov	x23, x0
109dda0d0: aa1403e1    	mov	x1, x20
109dda0d4: 956a04dc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda0d8: aa1d03fd    	mov	x29, x29
109dda0dc: 956a04dd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda0e0: aa0003f8    	mov	x24, x0
109dda0e4: d00b1948    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
109dda0e8: f9431501    	ldr	x1, [x8, #0x628] ; markedTextRange
109dda0ec: 956a04d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda0f0: aa1d03fd    	mov	x29, x29
109dda0f4: 956a04d7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda0f8: aa0003f9    	mov	x25, x0
109dda0fc: aa1303e0    	mov	x0, x19
109dda100: aa1403e1    	mov	x1, x20
109dda104: 956a04d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda108: aa1d03fd    	mov	x29, x29
109dda10c: 956a04d1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda110: aa0003f3    	mov	x19, x0
109dda114: b00b1988    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109dda118: f9401501    	ldr	x1, [x8, #0x28] ; text
109dda11c: 956a04ca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda120: aa1d03fd    	mov	x29, x29
109dda124: 956a04cb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda128: aa0003f4    	mov	x20, x0
109dda12c: aa1503e0    	mov	x0, x21
109dda130: aa1603e1    	mov	x1, x22
109dda134: aa1903e2    	mov	x2, x25
109dda138: aa1403e3    	mov	x3, x20
109dda13c: 956a04c2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda140: aa1403e0    	mov	x0, x20
109dda144: 956a04c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda148: aa1303e0    	mov	x0, x19
109dda14c: 956a04c4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda150: aa1903e0    	mov	x0, x25
109dda154: 956a04c2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda158: aa1803e0    	mov	x0, x24
109dda15c: 956a04c0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda160: aa1703e0    	mov	x0, x23
109dda164: 956a04be    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda168: 1400005e    	b	0x109dda2e0 <_Flutter_MMFoundation_BindContext+0x62b5ec4>
109dda16c: 900b0528    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109dda170: f945e514    	ldr	x20, [x8, #0xbc8] ; textField
109dda174: aa1303e0    	mov	x0, x19
109dda178: aa1403e1    	mov	x1, x20
109dda17c: 956a04b2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda180: aa1d03fd    	mov	x29, x29
109dda184: 956a04b3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda188: aa0003f5    	mov	x21, x0
109dda18c: f00b1968    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109dda190: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109dda194: b00a3602    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
109dda198: 91032042    	add	x2, x2, #0xc8
109dda19c: 956a04aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda1a0: aa1503e0    	mov	x0, x21
109dda1a4: 956a04ae    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda1a8: aa1303e0    	mov	x0, x19
109dda1ac: aa1403e1    	mov	x1, x20
109dda1b0: 956a04a5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda1b4: aa1d03fd    	mov	x29, x29
109dda1b8: 956a04a6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda1bc: aa0003f5    	mov	x21, x0
109dda1c0: d00b1928    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109dda1c4: f946f116    	ldr	x22, [x8, #0xde0] ; delegate
109dda1c8: aa1603e1    	mov	x1, x22
109dda1cc: 956a049e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda1d0: aa1d03fd    	mov	x29, x29
109dda1d4: 956a049f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda1d8: b40006c0    	cbz	x0, 0x109dda2b0 <_Flutter_MMFoundation_BindContext+0x62b5e94>
109dda1dc: aa0003f8    	mov	x24, x0
109dda1e0: aa1303e0    	mov	x0, x19
109dda1e4: aa1403e1    	mov	x1, x20
109dda1e8: 956a0497    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda1ec: aa1d03fd    	mov	x29, x29
109dda1f0: 956a0498    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda1f4: aa0003f9    	mov	x25, x0
109dda1f8: aa1603e1    	mov	x1, x22
109dda1fc: 956a0492    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda200: aa1d03fd    	mov	x29, x29
109dda204: 956a0493    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda208: aa0003fa    	mov	x26, x0
109dda20c: 900b0ce8    	adrp	x8, 0x11ff76000 <dyld_stub_binder+0x11ff76000>
109dda210: f9426917    	ldr	x23, [x8, #0x4d0] ; textFieldShouldClear:
109dda214: 900b1968    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109dda218: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109dda21c: aa1703e2    	mov	x2, x23
109dda220: 956a0489    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda224: aa0003fb    	mov	x27, x0
109dda228: aa1a03e0    	mov	x0, x26
109dda22c: 956a048c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda230: aa1903e0    	mov	x0, x25
109dda234: 956a048a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda238: aa1803e0    	mov	x0, x24
109dda23c: 956a0488    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda240: aa1503e0    	mov	x0, x21
109dda244: 956a0486    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda248: 3400039b    	cbz	w27, 0x109dda2b8 <_Flutter_MMFoundation_BindContext+0x62b5e9c>
109dda24c: aa1303e0    	mov	x0, x19
109dda250: aa1403e1    	mov	x1, x20
109dda254: 956a047c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda258: aa1d03fd    	mov	x29, x29
109dda25c: 956a047d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda260: aa0003f5    	mov	x21, x0
109dda264: aa1603e1    	mov	x1, x22
109dda268: 956a0477    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda26c: aa1d03fd    	mov	x29, x29
109dda270: 956a0478    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda274: aa0003f6    	mov	x22, x0
109dda278: aa1303e0    	mov	x0, x19
109dda27c: aa1403e1    	mov	x1, x20
109dda280: 956a0471    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda284: aa1d03fd    	mov	x29, x29
109dda288: 956a0472    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda28c: aa0003f8    	mov	x24, x0
109dda290: aa1603e0    	mov	x0, x22
109dda294: aa1703e1    	mov	x1, x23
109dda298: aa1803e2    	mov	x2, x24
109dda29c: 956a046a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda2a0: aa1803e0    	mov	x0, x24
109dda2a4: 956a046e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda2a8: aa1603e0    	mov	x0, x22
109dda2ac: 956a046c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda2b0: aa1503e0    	mov	x0, x21
109dda2b4: 956a046a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda2b8: aa1303e0    	mov	x0, x19
109dda2bc: aa1403e1    	mov	x1, x20
109dda2c0: 956a0461    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda2c4: aa1d03fd    	mov	x29, x29
109dda2c8: 956a0462    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dda2cc: aa0003f5    	mov	x21, x0
109dda2d0: b00b0528    	adrp	x8, 0x11fe7f000 <dyld_stub_binder+0x11fe7f000>
109dda2d4: f9429d01    	ldr	x1, [x8, #0x538] ; sendActionsForControlEvents:
109dda2d8: 52a00042    	mov	w2, #0x20000            ; =131072
109dda2dc: 956a045a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dda2e0: aa1503e0    	mov	x0, x21
109dda2e4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
109dda2e8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
109dda2ec: a94357f6    	ldp	x22, x21, [sp, #0x30]
109dda2f0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109dda2f4: a94167fa    	ldp	x26, x25, [sp, #0x10]
109dda2f8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
109dda2fc: 156a0458    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dda300: a9457bfd    	ldp	x29, x30, [sp, #0x50]
109dda304: a9444ff4    	ldp	x20, x19, [sp, #0x40]
109dda308: a94357f6    	ldp	x22, x21, [sp, #0x30]
109dda30c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109dda310: a94167fa    	ldp	x26, x25, [sp, #0x10]
109dda314: a8c66ffc    	ldp	x28, x27, [sp], #0x60
109dda318: d65f03c0    	ret
