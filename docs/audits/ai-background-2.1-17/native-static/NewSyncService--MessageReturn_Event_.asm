
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105182ac4: d10183ff    	sub	sp, sp, #0x60
105182ac8: a9025ff8    	stp	x24, x23, [sp, #0x20]
105182acc: a90357f6    	stp	x22, x21, [sp, #0x30]
105182ad0: a9044ff4    	stp	x20, x19, [sp, #0x40]
105182ad4: a9057bfd    	stp	x29, x30, [sp, #0x50]
105182ad8: 910143fd    	add	x29, sp, #0x50
105182adc: aa0303f5    	mov	x21, x3
105182ae0: aa0203f3    	mov	x19, x2
105182ae4: aa0003f4    	mov	x20, x0
105182ae8: b00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105182aec: 52800029    	mov	w9, #0x1                ; =1
105182af0: 39337909    	strb	w9, [x8, #0xcde]
105182af4: aa0203e0    	mov	x0, x2
105182af8: 94aa9190    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105182afc: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182b00: f9473116    	ldr	x22, [x8, #0xe60]
105182b04: aa1303e0    	mov	x0, x19
105182b08: aa1603e1    	mov	x1, x22
105182b0c: 94aa918c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182b10: 710aa41f    	cmp	w0, #0x2a9
105182b14: 54000101    	b.ne	0x105182b34 <_Flutter_MMFoundation_BindContext+0x165e718>
105182b18: d00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105182b1c: f942d501    	ldr	x1, [x8, #0x5a8]
105182b20: aa1403e0    	mov	x0, x20
105182b24: aa1303e2    	mov	x2, x19
105182b28: aa1503e3    	mov	x3, x21
105182b2c: 94aa9184    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182b30: 140000c4    	b	0x105182e40 <_Flutter_MMFoundation_BindContext+0x165ea24>
105182b34: aa1303e0    	mov	x0, x19
105182b38: aa1603e1    	mov	x1, x22
105182b3c: 94aa9180    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182b40: 7102281f    	cmp	w0, #0x8a
105182b44: 54000d81    	b.ne	0x105182cf4 <_Flutter_MMFoundation_BindContext+0x165e8d8>
105182b48: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105182b4c: b9891d08    	ldrsw	x8, [x8, #0x91c]
105182b50: b8286a9f    	str	wzr, [x20, x8]
105182b54: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182b58: f9453517    	ldr	x23, [x8, #0xa68]
105182b5c: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182b60: f946b516    	ldr	x22, [x8, #0xd68]
105182b64: aa1303e0    	mov	x0, x19
105182b68: aa1603e1    	mov	x1, x22
105182b6c: 94aa9174    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182b70: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182b74: f942a901    	ldr	x1, [x8, #0x550]
105182b78: a90083f5    	stp	x21, x0, [sp, #0x8]
105182b7c: b00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105182b80: 913f2108    	add	x8, x8, #0xfc8
105182b84: f90003e8    	str	x8, [sp]
105182b88: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182b8c: 91270063    	add	x3, x3, #0x9c0
105182b90: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182b94: 912b00a5    	add	x5, x5, #0xac0
105182b98: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182b9c: 913c4ce7    	add	x7, x7, #0xf13
105182ba0: aa1703e0    	mov	x0, x23
105182ba4: 52800042    	mov	w2, #0x2                ; =2
105182ba8: 52800004    	mov	w4, #0x0                ; =0
105182bac: 52804026    	mov	w6, #0x201              ; =513
105182bb0: 94aa9163    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182bb4: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182bb8: f9464900    	ldr	x0, [x8, #0xc90]
105182bbc: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182bc0: f9473501    	ldr	x1, [x8, #0xe68]
105182bc4: aa1503e2    	mov	x2, x21
105182bc8: aa1403e3    	mov	x3, x20
105182bcc: 94aa915c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182bd0: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182bd4: f9447901    	ldr	x1, [x8, #0x8f0]
105182bd8: aa1303e0    	mov	x0, x19
105182bdc: 94aa9158    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182be0: aa1d03fd    	mov	x29, x29
105182be4: 94aa9159    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182be8: aa0003f5    	mov	x21, x0
105182bec: 900d7c28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
105182bf0: f9450901    	ldr	x1, [x8, #0xa10]
105182bf4: 94aa9152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182bf8: 7100301f    	cmp	w0, #0xc
105182bfc: 54000221    	b.ne	0x105182c40 <_Flutter_MMFoundation_BindContext+0x165e824>
105182c00: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182c04: f9458d00    	ldr	x0, [x8, #0xb18]
105182c08: d00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105182c0c: f946b101    	ldr	x1, [x8, #0xd60]
105182c10: 94aa914b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182c14: aa1d03fd    	mov	x29, x29
105182c18: 94aa914c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182c1c: aa0003f7    	mov	x23, x0
105182c20: f00d7c08    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
105182c24: f944d501    	ldr	x1, [x8, #0x9a8]
105182c28: d00cb142    	adrp	x2, 0x11e7ac000 <dyld_stub_binder+0x11e7ac000>
105182c2c: 910da042    	add	x2, x2, #0x368
105182c30: d2800003    	mov	x3, #0x0                ; =0
105182c34: 94aa9142    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182c38: aa1703e0    	mov	x0, x23
105182c3c: 94aa9146    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182c40: aa1303e0    	mov	x0, x19
105182c44: aa1603e1    	mov	x1, x22
105182c48: 94aa913d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182c4c: 7100041f    	cmp	w0, #0x1
105182c50: 54000bc1    	b.ne	0x105182dc8 <_Flutter_MMFoundation_BindContext+0x165e9ac>
105182c54: d00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105182c58: f9423101    	ldr	x1, [x8, #0x460]
105182c5c: aa1403e0    	mov	x0, x20
105182c60: 94aa9137    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182c64: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105182c68: b9892108    	ldrsw	x8, [x8, #0x920]
105182c6c: 52800029    	mov	w9, #0x1                ; =1
105182c70: 38286a89    	strb	w9, [x20, x8]
105182c74: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182c78: f945e900    	ldr	x0, [x8, #0xbd0]
105182c7c: d00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105182c80: f944e901    	ldr	x1, [x8, #0x9d0]
105182c84: 94aa912e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182c88: aa1d03fd    	mov	x29, x29
105182c8c: 94aa912f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182c90: aa0003f4    	mov	x20, x0
105182c94: d00d7f68    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
105182c98: f9462502    	ldr	x2, [x8, #0xc48]
105182c9c: d00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105182ca0: f942d903    	ldr	x3, [x8, #0x5b0]
105182ca4: 900d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105182ca8: f9404901    	ldr	x1, [x8, #0x90]
105182cac: 900c2764    	adrp	x4, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
105182cb0: 911a0084    	add	x4, x4, #0x680
105182cb4: 94aa9122    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182cb8: aa1403e0    	mov	x0, x20
105182cbc: 94aa9126    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182cc0: 52801200    	mov	w0, #0x90               ; =144
105182cc4: 52800081    	mov	w1, #0x4                ; =4
105182cc8: 52800022    	mov	w2, #0x1                ; =1
105182ccc: 52800003    	mov	w3, #0x0                ; =0
105182cd0: 52800004    	mov	w4, #0x0                ; =0
105182cd4: 9737352a    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
105182cd8: b00cb2a1    	adrp	x1, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105182cdc: 913fa021    	add	x1, x1, #0xfe8
105182ce0: 52915720    	mov	w0, #0x8ab9             ; =35513
105182ce4: 52800002    	mov	w2, #0x0                ; =0
105182ce8: 52800003    	mov	w3, #0x0                ; =0
105182cec: 9743a7fd    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
105182cf0: 14000052    	b	0x105182e38 <_Flutter_MMFoundation_BindContext+0x165ea1c>
105182cf4: aa1303e0    	mov	x0, x19
105182cf8: aa1603e1    	mov	x1, x22
105182cfc: 94aa9110    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182d00: 71022c1f    	cmp	w0, #0x8b
105182d04: 540009e1    	b.ne	0x105182e40 <_Flutter_MMFoundation_BindContext+0x165ea24>
105182d08: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182d0c: f9453514    	ldr	x20, [x8, #0xa68]
105182d10: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182d14: f946b516    	ldr	x22, [x8, #0xd68]
105182d18: aa1303e0    	mov	x0, x19
105182d1c: aa1603e1    	mov	x1, x22
105182d20: 94aa9107    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182d24: f00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105182d28: f942a901    	ldr	x1, [x8, #0x550]
105182d2c: b00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105182d30: 913f2108    	add	x8, x8, #0xfc8
105182d34: a90083f5    	stp	x21, x0, [sp, #0x8]
105182d38: f90003e8    	str	x8, [sp]
105182d3c: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182d40: 91270063    	add	x3, x3, #0x9c0
105182d44: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182d48: 912b00a5    	add	x5, x5, #0xac0
105182d4c: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182d50: 913c4ce7    	add	x7, x7, #0xf13
105182d54: aa1403e0    	mov	x0, x20
105182d58: 52800042    	mov	w2, #0x2                ; =2
105182d5c: 52800004    	mov	w4, #0x0                ; =0
105182d60: 52804326    	mov	w6, #0x219              ; =537
105182d64: 94aa90f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182d68: aa1303e0    	mov	x0, x19
105182d6c: aa1603e1    	mov	x1, x22
105182d70: 94aa90f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182d74: 7100041f    	cmp	w0, #0x1
105182d78: 54000641    	b.ne	0x105182e40 <_Flutter_MMFoundation_BindContext+0x165ea24>
105182d7c: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182d80: f945e900    	ldr	x0, [x8, #0xbd0]
105182d84: d00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105182d88: f944e901    	ldr	x1, [x8, #0x9d0]
105182d8c: 94aa90ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182d90: aa1d03fd    	mov	x29, x29
105182d94: 94aa90ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182d98: aa0003f4    	mov	x20, x0
105182d9c: f00d7f68    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
105182da0: f9439902    	ldr	x2, [x8, #0x730]
105182da4: d00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105182da8: f942e103    	ldr	x3, [x8, #0x5c0]
105182dac: 900d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105182db0: f9404901    	ldr	x1, [x8, #0x90]
105182db4: 900c2764    	adrp	x4, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
105182db8: 911a8084    	add	x4, x4, #0x6a0
105182dbc: 94aa90e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182dc0: aa1403e0    	mov	x0, x20
105182dc4: 1400001e    	b	0x105182e3c <_Flutter_MMFoundation_BindContext+0x165ea20>
105182dc8: 900d65e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105182dcc: f9478901    	ldr	x1, [x8, #0xf10]
105182dd0: aa1303e0    	mov	x0, x19
105182dd4: 94aa90da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182dd8: aa1d03fd    	mov	x29, x29
105182ddc: 94aa90db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182de0: aa0003f6    	mov	x22, x0
105182de4: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182de8: f9447d01    	ldr	x1, [x8, #0x8f8]
105182dec: aa1303e0    	mov	x0, x19
105182df0: 94aa90d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182df4: aa1d03fd    	mov	x29, x29
105182df8: 94aa90d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182dfc: aa0003f7    	mov	x23, x0
105182e00: b00d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105182e04: f943b901    	ldr	x1, [x8, #0x770]
105182e08: aa1603e0    	mov	x0, x22
105182e0c: 94aa90cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182e10: aa0003e3    	mov	x3, x0
105182e14: d00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105182e18: f942dd01    	ldr	x1, [x8, #0x5b8]
105182e1c: aa1403e0    	mov	x0, x20
105182e20: aa1703e2    	mov	x2, x23
105182e24: 94aa90c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182e28: aa1703e0    	mov	x0, x23
105182e2c: 94aa90ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182e30: aa1603e0    	mov	x0, x22
105182e34: 94aa90c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182e38: aa1503e0    	mov	x0, x21
105182e3c: 94aa90c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182e40: aa1303e0    	mov	x0, x19
105182e44: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105182e48: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105182e4c: a94357f6    	ldp	x22, x21, [sp, #0x30]
105182e50: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105182e54: 910183ff    	add	sp, sp, #0x60
105182e58: 14aa90bf    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
