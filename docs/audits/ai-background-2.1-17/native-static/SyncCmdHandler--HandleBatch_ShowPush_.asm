
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105b3e794: d101c3ff    	sub	sp, sp, #0x70
105b3e798: a90457f6    	stp	x22, x21, [sp, #0x40]
105b3e79c: a9054ff4    	stp	x20, x19, [sp, #0x50]
105b3e7a0: a9067bfd    	stp	x29, x30, [sp, #0x60]
105b3e7a4: 910183fd    	add	x29, sp, #0x60
105b3e7a8: aa0303f5    	mov	x21, x3
105b3e7ac: aa0203f3    	mov	x19, x2
105b3e7b0: aa0003f4    	mov	x20, x0
105b3e7b4: 900d8828    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105b3e7b8: 52800029    	mov	w9, #0x1                ; =1
105b3e7bc: 3903c109    	strb	w9, [x8, #0xf0]
105b3e7c0: 900d37a8    	adrp	x8, 0x120232000 <dyld_stub_binder+0x120232000>
105b3e7c4: b9855508    	ldrsw	x8, [x8, #0x554]
105b3e7c8: f8686800    	ldr	x0, [x0, x8]
105b3e7cc: d00d2e08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105b3e7d0: f9435101    	ldr	x1, [x8, #0x6a0]
105b3e7d4: 9483a25a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e7d8: b4000400    	cbz	x0, 0x105b3e858 <_Flutter_MMFoundation_BindContext+0x201a43c>
105b3e7dc: b00d31a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105b3e7e0: f945e900    	ldr	x0, [x8, #0xbd0]
105b3e7e4: d00d2e08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105b3e7e8: f944e901    	ldr	x1, [x8, #0x9d0]
105b3e7ec: 9483a254    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e7f0: aa1d03fd    	mov	x29, x29
105b3e7f4: 9483a255    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105b3e7f8: aa0003f6    	mov	x22, x0
105b3e7fc: d00d3188    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
105b3e800: f9462502    	ldr	x2, [x8, #0xc48]
105b3e804: d00d23e8    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
105b3e808: f940bd03    	ldr	x3, [x8, #0x178]
105b3e80c: 900bd588    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
105b3e810: f947e108    	ldr	x8, [x8, #0xfc0]
105b3e814: f9000fe8    	str	x8, [sp, #0x18]
105b3e818: f0099208    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
105b3e81c: fd41c100    	ldr	d0, [x8, #0x380]
105b3e820: 90000008    	adrp	x8, 0x105b3e000 <_Flutter_MMFoundation_BindContext+0x2019be4>
105b3e824: 9123f108    	add	x8, x8, #0x8fc
105b3e828: 900bd5c9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
105b3e82c: 91238129    	add	x9, x9, #0x8e0
105b3e830: fd0013e0    	str	d0, [sp, #0x20]
105b3e834: a902a7e8    	stp	x8, x9, [sp, #0x28]
105b3e838: f9001ff4    	str	x20, [sp, #0x38]
105b3e83c: 900d17e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105b3e840: f940d501    	ldr	x1, [x8, #0x1a8]
105b3e844: 910063e5    	add	x5, sp, #0x18
105b3e848: 52800004    	mov	w4, #0x0                ; =0
105b3e84c: 9483a23c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e850: aa1603e0    	mov	x0, x22
105b3e854: 9483a240    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105b3e858: d00d23e8    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
105b3e85c: f940c101    	ldr	x1, [x8, #0x180]
105b3e860: aa1403e0    	mov	x0, x20
105b3e864: aa1303e2    	mov	x2, x19
105b3e868: aa1503e3    	mov	x3, x21
105b3e86c: 9483a234    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e870: aa0003f6    	mov	x22, x0
105b3e874: 36000140    	tbz	w0, #0x0, 0x105b3e89c <_Flutter_MMFoundation_BindContext+0x201a480>
105b3e878: d00d23e8    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
105b3e87c: f940c501    	ldr	x1, [x8, #0x188]
105b3e880: aa1403e0    	mov	x0, x20
105b3e884: 9483a22e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e888: d00d23e8    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
105b3e88c: f940c901    	ldr	x1, [x8, #0x190]
105b3e890: aa1403e0    	mov	x0, x20
105b3e894: 9483a22a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e898: 14000013    	b	0x105b3e8e4 <_Flutter_MMFoundation_BindContext+0x201a4c8>
105b3e89c: b00d31a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105b3e8a0: f9453500    	ldr	x0, [x8, #0xa68]
105b3e8a4: f00d17c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105b3e8a8: f942a901    	ldr	x1, [x8, #0x550]
105b3e8ac: a900d7f3    	stp	x19, x21, [sp, #0x8]
105b3e8b0: b00c67a8    	adrp	x8, 0x11e833000 <dyld_stub_binder+0x11e833000>
105b3e8b4: 9117a108    	add	x8, x8, #0x5e8
105b3e8b8: f90003e8    	str	x8, [sp]
105b3e8bc: d00ac103    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105b3e8c0: 91270063    	add	x3, x3, #0x9c0
105b3e8c4: 900aeee5    	adrp	x5, 0x11b91a000 <dyld_stub_binder+0x11b91a000>
105b3e8c8: 912998a5    	add	x5, x5, #0xa66
105b3e8cc: 900aeee7    	adrp	x7, 0x11b91a000 <dyld_stub_binder+0x11b91a000>
105b3e8d0: 9134c8e7    	add	x7, x7, #0xd32
105b3e8d4: 52800082    	mov	w2, #0x4                ; =4
105b3e8d8: 52800004    	mov	w4, #0x0                ; =0
105b3e8dc: 52802b86    	mov	w6, #0x15c              ; =348
105b3e8e0: 9483a217    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105b3e8e4: aa1603e0    	mov	x0, x22
105b3e8e8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105b3e8ec: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105b3e8f0: a94457f6    	ldp	x22, x21, [sp, #0x40]
105b3e8f4: 9101c3ff    	add	sp, sp, #0x70
105b3e8f8: d65f03c0    	ret
