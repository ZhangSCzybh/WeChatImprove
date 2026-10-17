
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104af9d0c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104af9d10: a9015ff8    	stp	x24, x23, [sp, #0x10]
104af9d14: a90257f6    	stp	x22, x21, [sp, #0x20]
104af9d18: a9034ff4    	stp	x20, x19, [sp, #0x30]
104af9d1c: a9047bfd    	stp	x29, x30, [sp, #0x40]
104af9d20: 910103fd    	add	x29, sp, #0x40
104af9d24: d10c03ff    	sub	sp, sp, #0x300
104af9d28: aa0503f5    	mov	x21, x5
104af9d2c: aa0403f6    	mov	x22, x4
104af9d30: aa0303f3    	mov	x19, x3
104af9d34: aa0203f4    	mov	x20, x2
104af9d38: aa0003f7    	mov	x23, x0
104af9d3c: d00c57a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104af9d40: f9405908    	ldr	x8, [x8, #0xb0]
104af9d44: f9400108    	ldr	x8, [x8]
104af9d48: f81b83a8    	stur	x8, [x29, #-0x48]
104af9d4c: b00e0a28    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104af9d50: 52800029    	mov	w9, #0x1                ; =1
104af9d54: 39128d09    	strb	w9, [x8, #0x4a3]
104af9d58: d00db428    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
104af9d5c: f9409d18    	ldr	x24, [x8, #0x138]
104af9d60: 900d9a68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104af9d64: f9456119    	ldr	x25, [x8, #0xac0] ; msgLocalId
104af9d68: aa0203e0    	mov	x0, x2
104af9d6c: 94c4b4f3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104af9d70: aa1803e0    	mov	x0, x24
104af9d74: aa1903e1    	mov	x1, x25
104af9d78: 94c4b4f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af9d7c: aa0003f8    	mov	x24, x0
104af9d80: b90037f3    	str	w19, [sp, #0x34]
104af9d84: 9100e3e0    	add	x0, sp, #0x38
104af9d88: 9100d3e1    	add	x1, sp, #0x34
104af9d8c: 96e43e9b    	bl	0x1004097f8 <__text+0x4017f8>
104af9d90: 910663e8    	add	x8, sp, #0x198
104af9d94: 9102e300    	add	x0, x24, #0xb8
104af9d98: 9100e3e1    	add	x1, sp, #0x38
104af9d9c: 94c44b8f    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104af9da0: 910043e8    	add	x8, sp, #0x10
104af9da4: 91002118    	add	x24, x8, #0x8
104af9da8: a9027ff8    	stp	x24, xzr, [sp, #0x20]
104af9dac: d00c57e8    	adrp	x8, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
104af9db0: 9139e108    	add	x8, x8, #0xe78
104af9db4: a90163e8    	stp	x8, x24, [sp, #0x10]
104af9db8: b00da468    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104af9dbc: f940bd01    	ldr	x1, [x8, #0x178] ; GetMsg:Where:order:Limit:hasError:needOriginContent:
104af9dc0: 910663e3    	add	x3, sp, #0x198
104af9dc4: 910043e4    	add	x4, sp, #0x10
104af9dc8: aa1703e0    	mov	x0, x23
104af9dcc: aa1403e2    	mov	x2, x20
104af9dd0: 52800025    	mov	w5, #0x1                ; =1
104af9dd4: aa1603e6    	mov	x6, x22
104af9dd8: aa1503e7    	mov	x7, x21
104af9ddc: 94c4b4d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af9de0: aa1d03fd    	mov	x29, x29
104af9de4: 94c4b4d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af9de8: aa0003f5    	mov	x21, x0
104af9dec: aa1403e0    	mov	x0, x20
104af9df0: 94c4b4d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af9df4: aa1803e0    	mov	x0, x24
104af9df8: 96d66b39    	bl	0x100094adc <__text+0x8cadc>
104af9dfc: 910663e0    	add	x0, sp, #0x198
104af9e00: 94c44ba0    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104af9e04: 9100e3e0    	add	x0, sp, #0x38
104af9e08: 94c44b9e    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104af9e0c: 34000133    	cbz	w19, 0x104af9e30 <_Flutter_MMFoundation_BindContext+0xfd5a14>
104af9e10: 900db048    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104af9e14: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
104af9e18: aa1503e0    	mov	x0, x21
104af9e1c: 94c4b4c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af9e20: aa1d03fd    	mov	x29, x29
104af9e24: 94c4b4c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104af9e28: aa0003f3    	mov	x19, x0
104af9e2c: 14000012    	b	0x104af9e74 <_Flutter_MMFoundation_BindContext+0xfd5a58>
104af9e30: d00db3c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104af9e34: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
104af9e38: 900d9a08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104af9e3c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104af9e40: b00ce548    	adrp	x8, 0x11e7a2000 <dyld_stub_binder+0x11e7a2000>
104af9e44: 9114a108    	add	x8, x8, #0x528
104af9e48: f90003e8    	str	x8, [sp]
104af9e4c: f00b67e5    	adrp	x5, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af9e50: 91027ca5    	add	x5, x5, #0x9f
104af9e54: f00b67e7    	adrp	x7, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104af9e58: 911414e7    	add	x7, x7, #0x505
104af9e5c: 52800082    	mov	w2, #0x4                ; =4
104af9e60: d2800003    	mov	x3, #0x0                ; =0
104af9e64: 52800004    	mov	w4, #0x0                ; =0
104af9e68: 52805e66    	mov	w6, #0x2f3              ; =755
104af9e6c: 94c4b4b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104af9e70: d2800013    	mov	x19, #0x0               ; =0
104af9e74: aa1503e0    	mov	x0, x21
104af9e78: 94c4b4b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104af9e7c: f85b83a8    	ldur	x8, [x29, #-0x48]
104af9e80: d00c57a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104af9e84: f9405929    	ldr	x9, [x9, #0xb0]
104af9e88: f9400129    	ldr	x9, [x9]
104af9e8c: eb08013f    	cmp	x9, x8
104af9e90: 54000121    	b.ne	0x104af9eb4 <_Flutter_MMFoundation_BindContext+0xfd5a98>
104af9e94: aa1303e0    	mov	x0, x19
104af9e98: 910c03ff    	add	sp, sp, #0x300
104af9e9c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104af9ea0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104af9ea4: a94257f6    	ldp	x22, x21, [sp, #0x20]
104af9ea8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104af9eac: a8c567fa    	ldp	x26, x25, [sp], #0x50
104af9eb0: 14c4b4b0    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104af9eb4: 94c4b4b0    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>