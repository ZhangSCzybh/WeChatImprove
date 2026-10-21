
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ddae9c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
109ddaea0: a90157f6    	stp	x22, x21, [sp, #0x10]
109ddaea4: a9024ff4    	stp	x20, x19, [sp, #0x20]
109ddaea8: a9037bfd    	stp	x29, x30, [sp, #0x30]
109ddaeac: 9100c3fd    	add	x29, sp, #0x30
109ddaeb0: aa0203f3    	mov	x19, x2
109ddaeb4: aa0003f4    	mov	x20, x0
109ddaeb8: f00b0668    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109ddaebc: f9403115    	ldr	x21, [x8, #0x60] ; enableLargeInput
109ddaec0: aa0203e0    	mov	x0, x2
109ddaec4: 956a015f    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109ddaec8: aa1403e0    	mov	x0, x20
109ddaecc: aa1503e1    	mov	x1, x21
109ddaed0: 956a015d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddaed4: 340002c0    	cbz	w0, 0x109ddaf2c <_Flutter_MMFoundation_BindContext+0x62b6b10>
109ddaed8: b00b0368    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
109ddaedc: f9430515    	ldr	x21, [x8, #0x608] ; textView
109ddaee0: aa1403e0    	mov	x0, x20
109ddaee4: aa1503e1    	mov	x1, x21
109ddaee8: 956a0157    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddaeec: aa1d03fd    	mov	x29, x29
109ddaef0: 956a0158    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddaef4: aa0003f6    	mov	x22, x0
109ddaef8: aa1503e1    	mov	x1, x21
109ddaefc: 956a0152    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddaf00: aa1d03fd    	mov	x29, x29
109ddaf04: 956a0153    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddaf08: aa0003f7    	mov	x23, x0
109ddaf0c: d00b0b68    	adrp	x8, 0x11ff48000 <dyld_stub_binder+0x11ff48000>
109ddaf10: f9464d01    	ldr	x1, [x8, #0xc98] ; unmarkText
109ddaf14: 956a014c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddaf18: aa1703e0    	mov	x0, x23
109ddaf1c: 956a0150    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddaf20: aa1603e0    	mov	x0, x22
109ddaf24: 956a014e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddaf28: 14000003    	b	0x109ddaf34 <_Flutter_MMFoundation_BindContext+0x62b6b18>
109ddaf2c: 900b0528    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109ddaf30: f945e515    	ldr	x21, [x8, #0xbc8] ; textField
109ddaf34: aa1403e0    	mov	x0, x20
109ddaf38: aa1503e1    	mov	x1, x21
109ddaf3c: 956a0142    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddaf40: aa1d03fd    	mov	x29, x29
109ddaf44: 956a0143    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddaf48: aa0003f4    	mov	x20, x0
109ddaf4c: f00b1968    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109ddaf50: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109ddaf54: aa1303e2    	mov	x2, x19
109ddaf58: 956a013b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddaf5c: aa1303e0    	mov	x0, x19
109ddaf60: 956a013f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddaf64: aa1403e0    	mov	x0, x20
109ddaf68: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109ddaf6c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109ddaf70: a94157f6    	ldp	x22, x21, [sp, #0x10]
109ddaf74: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109ddaf78: 156a0139    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
