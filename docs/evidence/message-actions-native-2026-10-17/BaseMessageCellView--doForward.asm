
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002ad10c: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1002ad110: a90167fa    	stp	x26, x25, [sp, #0x10]
1002ad114: a9025ff8    	stp	x24, x23, [sp, #0x20]
1002ad118: a90357f6    	stp	x22, x21, [sp, #0x30]
1002ad11c: a9044ff4    	stp	x20, x19, [sp, #0x40]
1002ad120: a9057bfd    	stp	x29, x30, [sp, #0x50]
1002ad124: 910143fd    	add	x29, sp, #0x50
1002ad128: aa0003f3    	mov	x19, x0
1002ad12c: 90104c08    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002ad130: 52800029    	mov	w9, #0x1                ; =1
1002ad134: 3931a909    	strb	w9, [x8, #0xc6a]
1002ad138: d00ff628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002ad13c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1002ad140: f00ff288    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1002ad144: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1002ad148: 95e5e7fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad14c: aa1d03fd    	mov	x29, x29
1002ad150: 95e5e7fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad154: aa0003f6    	mov	x22, x0
1002ad158: f00ff628    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1002ad15c: f9454900    	ldr	x0, [x8, #0xa90] ; �|. 
1002ad160: d00ff288    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002ad164: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1002ad168: 95e5e7f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad16c: aa0003e2    	mov	x2, x0
1002ad170: 900fdc68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1002ad174: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1002ad178: aa1603e0    	mov	x0, x22
1002ad17c: 95e5e7f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad180: aa1d03fd    	mov	x29, x29
1002ad184: 95e5e7f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad188: aa0003f7    	mov	x23, x0
1002ad18c: b00fdc88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002ad190: f9410914    	ldr	x20, [x8, #0x210] ; viewModel
1002ad194: aa1303e0    	mov	x0, x19
1002ad198: aa1403e1    	mov	x1, x20
1002ad19c: 95e5e7e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad1a0: aa1d03fd    	mov	x29, x29
1002ad1a4: 95e5e7e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad1a8: aa0003f8    	mov	x24, x0
1002ad1ac: b00fdc88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1002ad1b0: f9410515    	ldr	x21, [x8, #0x208] ; messageWrap
1002ad1b4: aa1503e1    	mov	x1, x21
1002ad1b8: 95e5e7e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad1bc: aa1d03fd    	mov	x29, x29
1002ad1c0: 95e5e7e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad1c4: aa0003f9    	mov	x25, x0
1002ad1c8: d00ff988    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002ad1cc: 91086108    	add	x8, x8, #0x218
1002ad1d0: b980011c    	ldrsw	x28, [x8]
1002ad1d4: 8b1c0260    	add	x0, x19, x28
1002ad1d8: 95e5e7ed    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002ad1dc: aa0003fa    	mov	x26, x0
1002ad1e0: d00fdc68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002ad1e4: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
1002ad1e8: 95e5e7d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad1ec: aa1d03fd    	mov	x29, x29
1002ad1f0: 95e5e7d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad1f4: aa0003fb    	mov	x27, x0
1002ad1f8: d00fdc88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1002ad1fc: f941e501    	ldr	x1, [x8, #0x3c8] ; forwardMessage:fromViewController:forwardType:
1002ad200: aa1703e0    	mov	x0, x23
1002ad204: aa1903e2    	mov	x2, x25
1002ad208: aa1b03e3    	mov	x3, x27
1002ad20c: 52800084    	mov	w4, #0x4                ; =4
1002ad210: 95e5e7cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad214: aa1b03e0    	mov	x0, x27
1002ad218: 95e5e7cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad21c: aa1a03e0    	mov	x0, x26
1002ad220: 95e5e7cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad224: aa1903e0    	mov	x0, x25
1002ad228: 95e5e7cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad22c: aa1803e0    	mov	x0, x24
1002ad230: 95e5e7c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad234: aa1703e0    	mov	x0, x23
1002ad238: 95e5e7c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad23c: aa1603e0    	mov	x0, x22
1002ad240: 95e5e7c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad244: 8b1c0260    	add	x0, x19, x28
1002ad248: 95e5e7d1    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002ad24c: b40005e0    	cbz	x0, 0x1002ad308 <__text+0x2a5308>
1002ad250: aa0003f7    	mov	x23, x0
1002ad254: 8b1c0260    	add	x0, x19, x28
1002ad258: 95e5e7cd    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002ad25c: aa0003f8    	mov	x24, x0
1002ad260: b00fdce8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002ad264: f9445116    	ldr	x22, [x8, #0x8a0] ; onClickForwardMenu:
1002ad268: b00ff2c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1002ad26c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1002ad270: aa1603e2    	mov	x2, x22
1002ad274: 95e5e7b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad278: aa0003f9    	mov	x25, x0
1002ad27c: aa1803e0    	mov	x0, x24
1002ad280: 95e5e7b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad284: aa1703e0    	mov	x0, x23
1002ad288: 95e5e7b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad28c: 340003f9    	cbz	w25, 0x1002ad308 <__text+0x2a5308>
1002ad290: 8b1c0260    	add	x0, x19, x28
1002ad294: 95e5e7be    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1002ad298: aa0003f7    	mov	x23, x0
1002ad29c: aa1303e0    	mov	x0, x19
1002ad2a0: aa1403e1    	mov	x1, x20
1002ad2a4: 95e5e7a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad2a8: aa1d03fd    	mov	x29, x29
1002ad2ac: 95e5e7a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad2b0: aa0003f3    	mov	x19, x0
1002ad2b4: aa1503e1    	mov	x1, x21
1002ad2b8: 95e5e7a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad2bc: aa1d03fd    	mov	x29, x29
1002ad2c0: 95e5e7a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002ad2c4: aa0003f4    	mov	x20, x0
1002ad2c8: aa1703e0    	mov	x0, x23
1002ad2cc: aa1603e1    	mov	x1, x22
1002ad2d0: aa1403e2    	mov	x2, x20
1002ad2d4: 95e5e79a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002ad2d8: aa1403e0    	mov	x0, x20
1002ad2dc: 95e5e79e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad2e0: aa1303e0    	mov	x0, x19
1002ad2e4: 95e5e79c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad2e8: aa1703e0    	mov	x0, x23
1002ad2ec: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1002ad2f0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1002ad2f4: a94357f6    	ldp	x22, x21, [sp, #0x30]
1002ad2f8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1002ad2fc: a94167fa    	ldp	x26, x25, [sp, #0x10]
1002ad300: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1002ad304: 15e5e794    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002ad308: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1002ad30c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1002ad310: a94357f6    	ldp	x22, x21, [sp, #0x30]
1002ad314: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1002ad318: a94167fa    	ldp	x26, x25, [sp, #0x10]
1002ad31c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1002ad320: d65f03c0    	ret