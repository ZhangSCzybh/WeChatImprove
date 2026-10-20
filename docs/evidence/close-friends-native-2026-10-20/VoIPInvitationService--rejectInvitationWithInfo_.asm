
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1061219ac: d101c3ff    	sub	sp, sp, #0x70
1061219b0: a9035ff8    	stp	x24, x23, [sp, #0x30]
1061219b4: a90457f6    	stp	x22, x21, [sp, #0x40]
1061219b8: a9054ff4    	stp	x20, x19, [sp, #0x50]
1061219bc: a9067bfd    	stp	x29, x30, [sp, #0x60]
1061219c0: 910183fd    	add	x29, sp, #0x60
1061219c4: aa0203f3    	mov	x19, x2
1061219c8: aa0203e0    	mov	x0, x2
1061219cc: 946c15db    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1061219d0: d00d0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1061219d4: f945e900    	ldr	x0, [x8, #0xbd0]
1061219d8: f00cfee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1061219dc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1061219e0: 946c15d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061219e4: aa1d03fd    	mov	x29, x29
1061219e8: 946c15d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061219ec: aa0003f4    	mov	x20, x0
1061219f0: b00d0288    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
1061219f4: f9414515    	ldr	x21, [x8, #0x288]
1061219f8: d00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1061219fc: f945e516    	ldr	x22, [x8, #0xbc8] ; voIPInvitationServiceDidRejectWithInfo:
106121a00: b00ba668    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
106121a04: f947e108    	ldr	x8, [x8, #0xfc0]
106121a08: f90007e8    	str	x8, [sp, #0x8]
106121a0c: 90096308    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
106121a10: fd41c100    	ldr	d0, [x8, #0x380]
106121a14: 90000008    	adrp	x8, 0x106121000 <_Flutter_MMFoundation_BindContext+0x25fcbe4>
106121a18: 912a3108    	add	x8, x8, #0xa8c
106121a1c: b00ba6a9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
106121a20: 91238129    	add	x9, x9, #0x8e0
106121a24: fd000be0    	str	d0, [sp, #0x10]
106121a28: a901a7e8    	stp	x8, x9, [sp, #0x18]
106121a2c: f90017f3    	str	x19, [sp, #0x28]
106121a30: b00ce8c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106121a34: f940d517    	ldr	x23, [x8, #0x1a8] ; callExtensionOnMainThread:selector:sync:block:
106121a38: aa1303e0    	mov	x0, x19
106121a3c: 946c15bf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106121a40: 910023e5    	add	x5, sp, #0x8
106121a44: aa1403e0    	mov	x0, x20
106121a48: aa1703e1    	mov	x1, x23
106121a4c: aa1503e2    	mov	x2, x21
106121a50: aa1603e3    	mov	x3, x22
106121a54: 52800024    	mov	w4, #0x1                ; =1
106121a58: 946c15b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106121a5c: aa1403e0    	mov	x0, x20
106121a60: 946c15bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106121a64: f94017e0    	ldr	x0, [sp, #0x28]
106121a68: 946c15bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106121a6c: aa1303e0    	mov	x0, x19
106121a70: 946c15b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106121a74: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106121a78: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106121a7c: a94457f6    	ldp	x22, x21, [sp, #0x40]
106121a80: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106121a84: 9101c3ff    	add	sp, sp, #0x70
106121a88: d65f03c0    	ret
