
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109dd9bb0: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
109dd9bb4: a90167fa    	stp	x26, x25, [sp, #0x10]
109dd9bb8: a9025ff8    	stp	x24, x23, [sp, #0x20]
109dd9bbc: a90357f6    	stp	x22, x21, [sp, #0x30]
109dd9bc0: a9044ff4    	stp	x20, x19, [sp, #0x40]
109dd9bc4: a9057bfd    	stp	x29, x30, [sp, #0x50]
109dd9bc8: 910143fd    	add	x29, sp, #0x50
109dd9bcc: aa0003f3    	mov	x19, x0
109dd9bd0: f00b73a8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109dd9bd4: 52800029    	mov	w9, #0x1                ; =1
109dd9bd8: 3926e509    	strb	w9, [x8, #0x9b9]
109dd9bdc: 900b0688    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109dd9be0: f9403101    	ldr	x1, [x8, #0x60] ; enableLargeInput
109dd9be4: 956a0618    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9be8: 34000c00    	cbz	w0, 0x109dd9d68 <_Flutter_MMFoundation_BindContext+0x62b594c>
109dd9bec: d00b0368    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
109dd9bf0: f9430515    	ldr	x21, [x8, #0x608] ; textView
109dd9bf4: aa1303e0    	mov	x0, x19
109dd9bf8: aa1503e1    	mov	x1, x21
109dd9bfc: 956a0612    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9c00: aa1d03fd    	mov	x29, x29
109dd9c04: 956a0613    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9c08: aa0003f4    	mov	x20, x0
109dd9c0c: 900b1988    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109dd9c10: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109dd9c14: d00a3602    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
109dd9c18: 91032042    	add	x2, x2, #0xc8
109dd9c1c: 956a060a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9c20: aa1403e0    	mov	x0, x20
109dd9c24: 956a060e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9c28: 900b15c8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd9c2c: f9411914    	ldr	x20, [x8, #0x230] ; searchBarDelegate
109dd9c30: aa1303e0    	mov	x0, x19
109dd9c34: aa1403e1    	mov	x1, x20
109dd9c38: 956a0603    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9c3c: aa1d03fd    	mov	x29, x29
109dd9c40: 956a0604    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9c44: b4001540    	cbz	x0, 0x109dd9eec <_Flutter_MMFoundation_BindContext+0x62b5ad0>
109dd9c48: aa0003f7    	mov	x23, x0
109dd9c4c: aa1303e0    	mov	x0, x19
109dd9c50: aa1403e1    	mov	x1, x20
109dd9c54: 956a05fc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9c58: aa1d03fd    	mov	x29, x29
109dd9c5c: 956a05fd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9c60: aa0003f8    	mov	x24, x0
109dd9c64: 900b0688    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
109dd9c68: f9415516    	ldr	x22, [x8, #0x2a8] ; mmInputBoxTextChanged:text:
109dd9c6c: b00b1968    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109dd9c70: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109dd9c74: aa1603e2    	mov	x2, x22
109dd9c78: 956a05f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9c7c: aa0003f9    	mov	x25, x0
109dd9c80: aa1803e0    	mov	x0, x24
109dd9c84: 956a05f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9c88: aa1703e0    	mov	x0, x23
109dd9c8c: 956a05f4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9c90: 340012f9    	cbz	w25, 0x109dd9eec <_Flutter_MMFoundation_BindContext+0x62b5ad0>
109dd9c94: aa1303e0    	mov	x0, x19
109dd9c98: aa1403e1    	mov	x1, x20
109dd9c9c: 956a05ea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9ca0: aa1d03fd    	mov	x29, x29
109dd9ca4: 956a05eb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9ca8: aa0003f7    	mov	x23, x0
109dd9cac: aa1303e0    	mov	x0, x19
109dd9cb0: aa1503e1    	mov	x1, x21
109dd9cb4: 956a05e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9cb8: aa1d03fd    	mov	x29, x29
109dd9cbc: 956a05e5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9cc0: aa0003f8    	mov	x24, x0
109dd9cc4: aa1503e1    	mov	x1, x21
109dd9cc8: 956a05df    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9ccc: aa1d03fd    	mov	x29, x29
109dd9cd0: 956a05e0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9cd4: aa0003f9    	mov	x25, x0
109dd9cd8: f00b1948    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
109dd9cdc: f9431501    	ldr	x1, [x8, #0x628] ; markedTextRange
109dd9ce0: 956a05d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9ce4: aa1d03fd    	mov	x29, x29
109dd9ce8: 956a05da    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9cec: aa0003fa    	mov	x26, x0
109dd9cf0: aa1303e0    	mov	x0, x19
109dd9cf4: aa1503e1    	mov	x1, x21
109dd9cf8: 956a05d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9cfc: aa1d03fd    	mov	x29, x29
109dd9d00: 956a05d4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9d04: aa0003f5    	mov	x21, x0
109dd9d08: d00b1988    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109dd9d0c: f9401501    	ldr	x1, [x8, #0x28] ; text
109dd9d10: 956a05cd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9d14: aa1d03fd    	mov	x29, x29
109dd9d18: 956a05ce    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9d1c: aa0003fb    	mov	x27, x0
109dd9d20: aa1703e0    	mov	x0, x23
109dd9d24: aa1603e1    	mov	x1, x22
109dd9d28: aa1a03e2    	mov	x2, x26
109dd9d2c: aa1b03e3    	mov	x3, x27
109dd9d30: 956a05c5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9d34: aa1b03e0    	mov	x0, x27
109dd9d38: 956a05c9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9d3c: aa1503e0    	mov	x0, x21
109dd9d40: 956a05c7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9d44: aa1a03e0    	mov	x0, x26
109dd9d48: 956a05c5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9d4c: aa1903e0    	mov	x0, x25
109dd9d50: 956a05c3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9d54: aa1803e0    	mov	x0, x24
109dd9d58: 956a05c1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9d5c: aa1703e0    	mov	x0, x23
109dd9d60: 956a05bf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9d64: 14000062    	b	0x109dd9eec <_Flutter_MMFoundation_BindContext+0x62b5ad0>
109dd9d68: b00b0528    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109dd9d6c: f945e514    	ldr	x20, [x8, #0xbc8] ; textField
109dd9d70: aa1303e0    	mov	x0, x19
109dd9d74: aa1403e1    	mov	x1, x20
109dd9d78: 956a05b3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9d7c: aa1d03fd    	mov	x29, x29
109dd9d80: 956a05b4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9d84: aa0003f5    	mov	x21, x0
109dd9d88: 900b1988    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109dd9d8c: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
109dd9d90: d00a3602    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
109dd9d94: 91032042    	add	x2, x2, #0xc8
109dd9d98: 956a05ab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9d9c: aa1503e0    	mov	x0, x21
109dd9da0: 956a05af    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9da4: aa1303e0    	mov	x0, x19
109dd9da8: aa1403e1    	mov	x1, x20
109dd9dac: 956a05a6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9db0: aa1d03fd    	mov	x29, x29
109dd9db4: 956a05a7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9db8: aa0003f5    	mov	x21, x0
109dd9dbc: f00b1928    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109dd9dc0: f946f116    	ldr	x22, [x8, #0xde0] ; delegate
109dd9dc4: aa1603e1    	mov	x1, x22
109dd9dc8: 956a059f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9dcc: aa1d03fd    	mov	x29, x29
109dd9dd0: 956a05a0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9dd4: b40006c0    	cbz	x0, 0x109dd9eac <_Flutter_MMFoundation_BindContext+0x62b5a90>
109dd9dd8: aa0003f8    	mov	x24, x0
109dd9ddc: aa1303e0    	mov	x0, x19
109dd9de0: aa1403e1    	mov	x1, x20
109dd9de4: 956a0598    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9de8: aa1d03fd    	mov	x29, x29
109dd9dec: 956a0599    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9df0: aa0003f9    	mov	x25, x0
109dd9df4: aa1603e1    	mov	x1, x22
109dd9df8: 956a0593    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9dfc: aa1d03fd    	mov	x29, x29
109dd9e00: 956a0594    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9e04: aa0003fa    	mov	x26, x0
109dd9e08: b00b0ce8    	adrp	x8, 0x11ff76000 <dyld_stub_binder+0x11ff76000>
109dd9e0c: f9426917    	ldr	x23, [x8, #0x4d0] ; textFieldShouldClear:
109dd9e10: b00b1968    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109dd9e14: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109dd9e18: aa1703e2    	mov	x2, x23
109dd9e1c: 956a058a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9e20: aa0003fb    	mov	x27, x0
109dd9e24: aa1a03e0    	mov	x0, x26
109dd9e28: 956a058d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9e2c: aa1903e0    	mov	x0, x25
109dd9e30: 956a058b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9e34: aa1803e0    	mov	x0, x24
109dd9e38: 956a0589    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9e3c: aa1503e0    	mov	x0, x21
109dd9e40: 956a0587    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9e44: 3400039b    	cbz	w27, 0x109dd9eb4 <_Flutter_MMFoundation_BindContext+0x62b5a98>
109dd9e48: aa1303e0    	mov	x0, x19
109dd9e4c: aa1403e1    	mov	x1, x20
109dd9e50: 956a057d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9e54: aa1d03fd    	mov	x29, x29
109dd9e58: 956a057e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9e5c: aa0003f5    	mov	x21, x0
109dd9e60: aa1603e1    	mov	x1, x22
109dd9e64: 956a0578    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9e68: aa1d03fd    	mov	x29, x29
109dd9e6c: 956a0579    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9e70: aa0003f6    	mov	x22, x0
109dd9e74: aa1303e0    	mov	x0, x19
109dd9e78: aa1403e1    	mov	x1, x20
109dd9e7c: 956a0572    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9e80: aa1d03fd    	mov	x29, x29
109dd9e84: 956a0573    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9e88: aa0003f8    	mov	x24, x0
109dd9e8c: aa1603e0    	mov	x0, x22
109dd9e90: aa1703e1    	mov	x1, x23
109dd9e94: aa1803e2    	mov	x2, x24
109dd9e98: 956a056b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9e9c: aa1803e0    	mov	x0, x24
109dd9ea0: 956a056f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9ea4: aa1603e0    	mov	x0, x22
109dd9ea8: 956a056d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9eac: aa1503e0    	mov	x0, x21
109dd9eb0: 956a056b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9eb4: aa1303e0    	mov	x0, x19
109dd9eb8: aa1403e1    	mov	x1, x20
109dd9ebc: 956a0562    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9ec0: aa1d03fd    	mov	x29, x29
109dd9ec4: 956a0563    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9ec8: aa0003f4    	mov	x20, x0
109dd9ecc: d00b0528    	adrp	x8, 0x11fe7f000 <dyld_stub_binder+0x11fe7f000>
109dd9ed0: f9429d01    	ldr	x1, [x8, #0x538] ; sendActionsForControlEvents:
109dd9ed4: 52a00042    	mov	w2, #0x20000            ; =131072
109dd9ed8: 956a055b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9edc: aa1403e0    	mov	x0, x20
109dd9ee0: 956a055f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9ee4: 900b15c8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd9ee8: f9411914    	ldr	x20, [x8, #0x230] ; searchBarDelegate
109dd9eec: b00b0668    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
109dd9ef0: f943b901    	ldr	x1, [x8, #0x770] ; inputBoxBecomeFirstResponder
109dd9ef4: aa1303e0    	mov	x0, x19
109dd9ef8: 956a0553    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9efc: aa1303e0    	mov	x0, x19
109dd9f00: aa1403e1    	mov	x1, x20
109dd9f04: 956a0550    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9f08: aa1d03fd    	mov	x29, x29
109dd9f0c: 956a0551    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9f10: b4000480    	cbz	x0, 0x109dd9fa0 <_Flutter_MMFoundation_BindContext+0x62b5b84>
109dd9f14: aa0003f6    	mov	x22, x0
109dd9f18: aa1303e0    	mov	x0, x19
109dd9f1c: aa1403e1    	mov	x1, x20
109dd9f20: 956a0549    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9f24: aa1d03fd    	mov	x29, x29
109dd9f28: 956a054a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9f2c: aa0003f7    	mov	x23, x0
109dd9f30: 900b15c8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd9f34: f9412915    	ldr	x21, [x8, #0x250] ; mmInputBoxClear
109dd9f38: b00b1968    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109dd9f3c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109dd9f40: aa1503e2    	mov	x2, x21
109dd9f44: 956a0540    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9f48: aa0003f8    	mov	x24, x0
109dd9f4c: aa1703e0    	mov	x0, x23
109dd9f50: 956a0543    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9f54: aa1603e0    	mov	x0, x22
109dd9f58: 956a0541    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9f5c: 34000238    	cbz	w24, 0x109dd9fa0 <_Flutter_MMFoundation_BindContext+0x62b5b84>
109dd9f60: aa1303e0    	mov	x0, x19
109dd9f64: aa1403e1    	mov	x1, x20
109dd9f68: 956a0537    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9f6c: aa1d03fd    	mov	x29, x29
109dd9f70: 956a0538    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd9f74: aa0003f3    	mov	x19, x0
109dd9f78: aa1503e1    	mov	x1, x21
109dd9f7c: 956a0532    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd9f80: aa1303e0    	mov	x0, x19
109dd9f84: a9457bfd    	ldp	x29, x30, [sp, #0x50]
109dd9f88: a9444ff4    	ldp	x20, x19, [sp, #0x40]
109dd9f8c: a94357f6    	ldp	x22, x21, [sp, #0x30]
109dd9f90: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109dd9f94: a94167fa    	ldp	x26, x25, [sp, #0x10]
109dd9f98: a8c66ffc    	ldp	x28, x27, [sp], #0x60
109dd9f9c: 156a0530    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd9fa0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
109dd9fa4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
109dd9fa8: a94357f6    	ldp	x22, x21, [sp, #0x30]
109dd9fac: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109dd9fb0: a94167fa    	ldp	x26, x25, [sp, #0x10]
109dd9fb4: a8c66ffc    	ldp	x28, x27, [sp], #0x60
109dd9fb8: d65f03c0    	ret
