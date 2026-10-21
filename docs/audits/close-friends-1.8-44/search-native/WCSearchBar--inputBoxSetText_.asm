
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109ddac3c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
109ddac40: a9015ff8    	stp	x24, x23, [sp, #0x10]
109ddac44: a90257f6    	stp	x22, x21, [sp, #0x20]
109ddac48: a9034ff4    	stp	x20, x19, [sp, #0x30]
109ddac4c: a9047bfd    	stp	x29, x30, [sp, #0x40]
109ddac50: 910103fd    	add	x29, sp, #0x40
109ddac54: aa0203f5    	mov	x21, x2
109ddac58: aa0003f3    	mov	x19, x0
109ddac5c: d00b73a8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109ddac60: 52800029    	mov	w9, #0x1                ; =1
109ddac64: 3926f509    	strb	w9, [x8, #0x9bd]
109ddac68: f00b0668    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109ddac6c: f9403114    	ldr	x20, [x8, #0x60] ; enableLargeInput
109ddac70: aa0203e0    	mov	x0, x2
109ddac74: 956a01f3    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109ddac78: aa1303e0    	mov	x0, x19
109ddac7c: aa1403e1    	mov	x1, x20
109ddac80: 956a01f1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddac84: 34000be0    	cbz	w0, 0x109ddae00 <_Flutter_MMFoundation_BindContext+0x62b69e4>
109ddac88: b00b0368    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
109ddac8c: f9430514    	ldr	x20, [x8, #0x608] ; textView
109ddac90: aa1303e0    	mov	x0, x19
109ddac94: aa1403e1    	mov	x1, x20
109ddac98: 956a01eb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddac9c: aa1d03fd    	mov	x29, x29
109ddaca0: 956a01ec    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddaca4: aa0003f6    	mov	x22, x0
109ddaca8: f00b1968    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109ddacac: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109ddacb0: aa1503e2    	mov	x2, x21
109ddacb4: 956a01e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddacb8: aa1503e0    	mov	x0, x21
109ddacbc: 956a01e8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddacc0: aa1603e0    	mov	x0, x22
109ddacc4: 956a01e6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddacc8: f00b15a8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109ddaccc: f9411915    	ldr	x21, [x8, #0x230] ; searchBarDelegate
109ddacd0: aa1303e0    	mov	x0, x19
109ddacd4: aa1503e1    	mov	x1, x21
109ddacd8: 956a01db    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddacdc: aa1d03fd    	mov	x29, x29
109ddace0: 956a01dc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddace4: b4000d00    	cbz	x0, 0x109ddae84 <_Flutter_MMFoundation_BindContext+0x62b6a68>
109ddace8: aa0003f7    	mov	x23, x0
109ddacec: aa1303e0    	mov	x0, x19
109ddacf0: aa1503e1    	mov	x1, x21
109ddacf4: 956a01d4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddacf8: aa1d03fd    	mov	x29, x29
109ddacfc: 956a01d5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddad00: aa0003f8    	mov	x24, x0
109ddad04: f00b0668    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109ddad08: f9415516    	ldr	x22, [x8, #0x2a8] ; mmInputBoxTextChanged:text:
109ddad0c: 900b1968    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109ddad10: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109ddad14: aa1603e2    	mov	x2, x22
109ddad18: 956a01cb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddad1c: aa0003f9    	mov	x25, x0
109ddad20: aa1803e0    	mov	x0, x24
109ddad24: 956a01ce    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddad28: aa1703e0    	mov	x0, x23
109ddad2c: 956a01cc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddad30: 34000ab9    	cbz	w25, 0x109ddae84 <_Flutter_MMFoundation_BindContext+0x62b6a68>
109ddad34: aa1303e0    	mov	x0, x19
109ddad38: aa1503e1    	mov	x1, x21
109ddad3c: 956a01c2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddad40: aa1d03fd    	mov	x29, x29
109ddad44: 956a01c3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddad48: aa0003f5    	mov	x21, x0
109ddad4c: aa1303e0    	mov	x0, x19
109ddad50: aa1403e1    	mov	x1, x20
109ddad54: 956a01bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddad58: aa1d03fd    	mov	x29, x29
109ddad5c: 956a01bd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddad60: aa0003f7    	mov	x23, x0
109ddad64: aa1403e1    	mov	x1, x20
109ddad68: 956a01b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddad6c: aa1d03fd    	mov	x29, x29
109ddad70: 956a01b8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddad74: aa0003f8    	mov	x24, x0
109ddad78: d00b1948    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
109ddad7c: f9431501    	ldr	x1, [x8, #0x628] ; markedTextRange
109ddad80: 956a01b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddad84: aa1d03fd    	mov	x29, x29
109ddad88: 956a01b2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddad8c: aa0003f9    	mov	x25, x0
109ddad90: aa1303e0    	mov	x0, x19
109ddad94: aa1403e1    	mov	x1, x20
109ddad98: 956a01ab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddad9c: aa1d03fd    	mov	x29, x29
109ddada0: 956a01ac    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddada4: aa0003f3    	mov	x19, x0
109ddada8: b00b1988    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109ddadac: f9401501    	ldr	x1, [x8, #0x28] ; text
109ddadb0: 956a01a5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddadb4: aa1d03fd    	mov	x29, x29
109ddadb8: 956a01a6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddadbc: aa0003f4    	mov	x20, x0
109ddadc0: aa1503e0    	mov	x0, x21
109ddadc4: aa1603e1    	mov	x1, x22
109ddadc8: aa1903e2    	mov	x2, x25
109ddadcc: aa1403e3    	mov	x3, x20
109ddadd0: 956a019d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddadd4: aa1403e0    	mov	x0, x20
109ddadd8: 956a01a1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddaddc: aa1303e0    	mov	x0, x19
109ddade0: 956a019f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddade4: aa1903e0    	mov	x0, x25
109ddade8: 956a019d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddadec: aa1803e0    	mov	x0, x24
109ddadf0: 956a019b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddadf4: aa1703e0    	mov	x0, x23
109ddadf8: 956a0199    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddadfc: 1400001b    	b	0x109ddae68 <_Flutter_MMFoundation_BindContext+0x62b6a4c>
109ddae00: 900b0528    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109ddae04: f945e514    	ldr	x20, [x8, #0xbc8] ; textField
109ddae08: aa1303e0    	mov	x0, x19
109ddae0c: aa1403e1    	mov	x1, x20
109ddae10: 956a018d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddae14: aa1d03fd    	mov	x29, x29
109ddae18: 956a018e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddae1c: aa0003f6    	mov	x22, x0
109ddae20: f00b1968    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109ddae24: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109ddae28: aa1503e2    	mov	x2, x21
109ddae2c: 956a0186    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddae30: aa1503e0    	mov	x0, x21
109ddae34: 956a018a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddae38: aa1603e0    	mov	x0, x22
109ddae3c: 956a0188    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddae40: aa1303e0    	mov	x0, x19
109ddae44: aa1403e1    	mov	x1, x20
109ddae48: 956a017f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddae4c: aa1d03fd    	mov	x29, x29
109ddae50: 956a0180    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109ddae54: aa0003f5    	mov	x21, x0
109ddae58: b00b0528    	adrp	x8, 0x11fe7f000 <dyld_stub_binder+0x11fe7f000>
109ddae5c: f9429d01    	ldr	x1, [x8, #0x538] ; sendActionsForControlEvents:
109ddae60: 52a00042    	mov	w2, #0x20000            ; =131072
109ddae64: 956a0178    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109ddae68: aa1503e0    	mov	x0, x21
109ddae6c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109ddae70: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109ddae74: a94257f6    	ldp	x22, x21, [sp, #0x20]
109ddae78: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109ddae7c: a8c567fa    	ldp	x26, x25, [sp], #0x50
109ddae80: 156a0177    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109ddae84: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109ddae88: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109ddae8c: a94257f6    	ldp	x22, x21, [sp, #0x20]
109ddae90: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109ddae94: a8c567fa    	ldp	x26, x25, [sp], #0x50
109ddae98: d65f03c0    	ret
