
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c3b1a0: d10143ff    	sub	sp, sp, #0x50
101c3b1a4: a9034ff4    	stp	x20, x19, [sp, #0x30]
101c3b1a8: a9047bfd    	stp	x29, x30, [sp, #0x40]
101c3b1ac: 910103fd    	add	x29, sp, #0x40
101c3b1b0: aa0003e1    	mov	x1, x0
101c3b1b4: d10063a0    	sub	x0, x29, #0x18
101c3b1b8: 957fafed    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
101c3b1bc: f00dcd88    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101c3b1c0: f947e108    	ldr	x8, [x8, #0xfc0]
101c3b1c4: f90003e8    	str	x8, [sp]
101c3b1c8: d00b8a28    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101c3b1cc: fd41c100    	ldr	d0, [x8, #0x380]
101c3b1d0: 90000008    	adrp	x8, 0x101c3b000 <_Flutter_Image_provideRelativePathByUrl+0x47eb0>
101c3b1d4: 9108e108    	add	x8, x8, #0x238
101c3b1d8: fd0007e0    	str	d0, [sp, #0x8]
101c3b1dc: f00dcdc9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
101c3b1e0: 91150129    	add	x9, x9, #0x540
101c3b1e4: a90127e8    	stp	x8, x9, [sp, #0x10]
101c3b1e8: 910003f3    	mov	x19, sp
101c3b1ec: 91008260    	add	x0, x19, #0x20
101c3b1f0: d10063a1    	sub	x1, x29, #0x18
101c3b1f4: 957fafe1    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
101c3b1f8: d2800000    	mov	x0, #0x0                ; =0
101c3b1fc: 52994001    	mov	w1, #0xca00             ; =51712
101c3b200: 72a77341    	movk	w1, #0x3b9a, lsl #16
101c3b204: 957fafef    	bl	0x107c271c0 <_Flutter_MMFoundation_BindContext+0x4102da4>
101c3b208: 900dcda1    	adrp	x1, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c3b20c: f9408c21    	ldr	x1, [x1, #0x118]
101c3b210: 910003e2    	mov	x2, sp
101c3b214: 957f4805    	bl	0x107c0d228 <_Flutter_MMFoundation_BindContext+0x40e8e0c>
101c3b218: 91008260    	add	x0, x19, #0x20
101c3b21c: 957fafdd    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
101c3b220: d10063a0    	sub	x0, x29, #0x18
101c3b224: 957fafdb    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
101c3b228: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101c3b22c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101c3b230: 910143ff    	add	sp, sp, #0x50
101c3b234: d65f03c0    	ret
101c3b238: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101c3b23c: a90157f6    	stp	x22, x21, [sp, #0x10]
101c3b240: a9024ff4    	stp	x20, x19, [sp, #0x20]
101c3b244: a9037bfd    	stp	x29, x30, [sp, #0x30]
101c3b248: 9100c3fd    	add	x29, sp, #0x30
101c3b24c: 91008000    	add	x0, x0, #0x20
101c3b250: 957fafcf    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c3b254: aa0003f3    	mov	x19, x0
101c3b258: b4000440    	cbz	x0, 0x101c3b2e0 <_Flutter_Image_provideRelativePathByUrl+0x48190>
101c3b25c: d00f1268    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101c3b260: f942c901    	ldr	x1, [x8, #0x590] ; dismissViewController
101c3b264: aa1303e0    	mov	x0, x19
101c3b268: 957fafb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3b26c: b00f2dc8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c3b270: b9892518    	ldrsw	x24, [x8, #0x924]
101c3b274: 8b180260    	add	x0, x19, x24
101c3b278: 957fafc5    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c3b27c: b4000320    	cbz	x0, 0x101c3b2e0 <_Flutter_Image_provideRelativePathByUrl+0x48190>
101c3b280: aa0003f5    	mov	x21, x0
101c3b284: 8b180260    	add	x0, x19, x24
101c3b288: 957fafc1    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c3b28c: aa0003f6    	mov	x22, x0
101c3b290: b00f1408    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c3b294: f946b114    	ldr	x20, [x8, #0xd60] ; OnForwardMessageSend:
101c3b298: f00f2648    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101c3b29c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
101c3b2a0: aa1403e2    	mov	x2, x20
101c3b2a4: 957fafa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3b2a8: aa0003f7    	mov	x23, x0
101c3b2ac: aa1603e0    	mov	x0, x22
101c3b2b0: 957fafa9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3b2b4: aa1503e0    	mov	x0, x21
101c3b2b8: 957fafa7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3b2bc: 34000137    	cbz	w23, 0x101c3b2e0 <_Flutter_Image_provideRelativePathByUrl+0x48190>
101c3b2c0: 8b180260    	add	x0, x19, x24
101c3b2c4: 957fafb2    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c3b2c8: aa0003f5    	mov	x21, x0
101c3b2cc: aa1403e1    	mov	x1, x20
101c3b2d0: aa1303e2    	mov	x2, x19
101c3b2d4: 957faf9a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3b2d8: aa1503e0    	mov	x0, x21
101c3b2dc: 957faf9e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3b2e0: aa1303e0    	mov	x0, x19
101c3b2e4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101c3b2e8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101c3b2ec: a94157f6    	ldp	x22, x21, [sp, #0x10]
101c3b2f0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101c3b2f4: 157faf98    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>