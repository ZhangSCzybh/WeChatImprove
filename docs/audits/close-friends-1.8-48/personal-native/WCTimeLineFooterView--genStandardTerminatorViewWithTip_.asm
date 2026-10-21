
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0aafdc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a0aafe0: a90157f6    	stp	x22, x21, [sp, #0x10]
10a0aafe4: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a0aafe8: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a0aafec: 9100c3fd    	add	x29, sp, #0x30
10a0aaff0: aa0203f3    	mov	x19, x2
10a0aaff4: aa0003f4    	mov	x20, x0
10a0aaff8: f00b5d28    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0aaffc: 52800029    	mov	w9, #0x1                ; =1
10a0ab000: 39110d09    	strb	w9, [x8, #0x443]
10a0ab004: aa0203e0    	mov	x0, x2
10a0ab008: 955ec10e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0ab00c: b00afca8    	adrp	x8, 0x120040000 <dyld_stub_binder+0x120040000>
10a0ab010: f941a501    	ldr	x1, [x8, #0x348] ; getTerminatorViewParams
10a0ab014: aa1403e0    	mov	x0, x20
10a0ab018: 955ec10b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab01c: aa1d03fd    	mov	x29, x29
10a0ab020: 955ec10c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ab024: aa0003f5    	mov	x21, x0
10a0ab028: 900b02c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a0ab02c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a0ab030: aa1303e0    	mov	x0, x19
10a0ab034: 955ec104    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab038: b4000620    	cbz	x0, 0x10a0ab0fc <_Flutter_MMFoundation_BindContext+0x6586ce0>
10a0ab03c: f00aece8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10a0ab040: f9422901    	ldr	x1, [x8, #0x450] ; setIconImage:
10a0ab044: aa1503e0    	mov	x0, x21
10a0ab048: d2800002    	mov	x2, #0x0                ; =0
10a0ab04c: 955ec0fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab050: d00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0ab054: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
10a0ab058: aa1503e0    	mov	x0, x21
10a0ab05c: aa1303e2    	mov	x2, x19
10a0ab060: 955ec0f9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab064: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab068: b9817d08    	ldrsw	x8, [x8, #0x17c]
10a0ab06c: f8686a80    	ldr	x0, [x20, x8]
10a0ab070: d00b02a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a0ab074: f9456d01    	ldr	x1, [x8, #0xad8] ; font
10a0ab078: 955ec0f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab07c: aa1d03fd    	mov	x29, x29
10a0ab080: 955ec0f4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ab084: aa0003f6    	mov	x22, x0
10a0ab088: 900aed68    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
10a0ab08c: f9458901    	ldr	x1, [x8, #0xb10] ; setTitleFont:
10a0ab090: aa1503e0    	mov	x0, x21
10a0ab094: aa1603e2    	mov	x2, x22
10a0ab098: 955ec0eb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab09c: aa1603e0    	mov	x0, x22
10a0ab0a0: 955ec0ef    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab0a4: d00af128    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
10a0ab0a8: f9439901    	ldr	x1, [x8, #0x730] ; m_textColor
10a0ab0ac: aa1403e0    	mov	x0, x20
10a0ab0b0: 955ec0e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab0b4: aa1d03fd    	mov	x29, x29
10a0ab0b8: 955ec0e6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0ab0bc: aa0003f6    	mov	x22, x0
10a0ab0c0: b00aec88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0ab0c4: f9415501    	ldr	x1, [x8, #0x2a8] ; setTitleColor:
10a0ab0c8: aa1503e0    	mov	x0, x21
10a0ab0cc: aa1603e2    	mov	x2, x22
10a0ab0d0: 955ec0dd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab0d4: aa1603e0    	mov	x0, x22
10a0ab0d8: 955ec0e1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab0dc: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab0e0: b9819d08    	ldrsw	x8, [x8, #0x19c]
10a0ab0e4: f8686a82    	ldr	x2, [x20, x8]
10a0ab0e8: b40000a2    	cbz	x2, 0x10a0ab0fc <_Flutter_MMFoundation_BindContext+0x6586ce0>
10a0ab0ec: d00aef48    	adrp	x8, 0x11fe95000 <dyld_stub_binder+0x11fe95000>
10a0ab0f0: f945dd01    	ldr	x1, [x8, #0xbb8] ; setLineColor:
10a0ab0f4: aa1503e0    	mov	x0, x21
10a0ab0f8: 955ec0d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab0fc: b00b0e48    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0ab100: b981a117    	ldrsw	x23, [x8, #0x1a0]
10a0ab104: f8776a80    	ldr	x0, [x20, x23]
10a0ab108: f00b02c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0ab10c: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
10a0ab110: 955ec0cd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab114: b00b0708    	adrp	x8, 0x12018c000 <dyld_stub_binder+0x12018c000>
10a0ab118: f9403500    	ldr	x0, [x8, #0x68]
10a0ab11c: 955ec0d3    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a0ab120: aa0003f6    	mov	x22, x0
10a0ab124: 900b02a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0ab128: f943d501    	ldr	x1, [x8, #0x7a8] ; bounds
10a0ab12c: aa1403e0    	mov	x0, x20
10a0ab130: 955ec0c5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab134: d00aef48    	adrp	x8, 0x11fe95000 <dyld_stub_binder+0x11fe95000>
10a0ab138: f9422d01    	ldr	x1, [x8, #0x458] ; initWithFrame:params:
10a0ab13c: aa1603e0    	mov	x0, x22
10a0ab140: aa1503e2    	mov	x2, x21
10a0ab144: 955ec0c0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab148: f8776a88    	ldr	x8, [x20, x23]
10a0ab14c: f8376a80    	str	x0, [x20, x23]
10a0ab150: aa0803e0    	mov	x0, x8
10a0ab154: 955ec0c2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab158: f8776a80    	ldr	x0, [x20, x23]
10a0ab15c: d00b02e8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a0ab160: f9466501    	ldr	x1, [x8, #0xcc8] ; setTag:
10a0ab164: 5280d202    	mov	w2, #0x690              ; =1680
10a0ab168: 955ec0b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab16c: f8776a82    	ldr	x2, [x20, x23]
10a0ab170: f00b0288    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10a0ab174: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
10a0ab178: aa1403e0    	mov	x0, x20
10a0ab17c: 955ec0b2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0ab180: aa1503e0    	mov	x0, x21
10a0ab184: 955ec0b6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0ab188: aa1303e0    	mov	x0, x19
10a0ab18c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a0ab190: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a0ab194: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a0ab198: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a0ab19c: 155ec0b0    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
