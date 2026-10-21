
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101b4f8a4: d10283ff    	sub	sp, sp, #0xa0
101b4f8a8: 6d0623e9    	stp	d9, d8, [sp, #0x60]
101b4f8ac: a90757f6    	stp	x22, x21, [sp, #0x70]
101b4f8b0: a9084ff4    	stp	x20, x19, [sp, #0x80]
101b4f8b4: a9097bfd    	stp	x29, x30, [sp, #0x90]
101b4f8b8: 910243fd    	add	x29, sp, #0x90
101b4f8bc: aa0003e1    	mov	x1, x0
101b4f8c0: 900f8728    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101b4f8c4: 52800029    	mov	w9, #0x1                ; =1
101b4f8c8: 3919a509    	strb	w9, [x8, #0x669]
101b4f8cc: d100e3a0    	sub	x0, x29, #0x38
101b4f8d0: 95835e27    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
101b4f8d4: f00dd4f5    	adrp	x21, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101b4f8d8: f947e2b5    	ldr	x21, [x21, #0xfc0]
101b4f8dc: f9001bf5    	str	x21, [sp, #0x30]
101b4f8e0: d00b9188    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101b4f8e4: fd41c108    	ldr	d8, [x8, #0x380]
101b4f8e8: 90000008    	adrp	x8, 0x101b4f000 <__text+0x1b47000>
101b4f8ec: 9127d108    	add	x8, x8, #0x9f4
101b4f8f0: fd001fe8    	str	d8, [sp, #0x38]
101b4f8f4: f00dd529    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
101b4f8f8: 91150129    	add	x9, x9, #0x540
101b4f8fc: a90427e8    	stp	x8, x9, [sp, #0x40]
101b4f900: 9100c3f4    	add	x20, sp, #0x30
101b4f904: 91008280    	add	x0, x20, #0x20
101b4f908: d100e3a1    	sub	x1, x29, #0x38
101b4f90c: 95835e1b    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
101b4f910: 9100c3e0    	add	x0, sp, #0x30
101b4f914: 95835e24    	bl	0x107c271a4 <_Flutter_MMFoundation_BindContext+0x4102d88>
101b4f918: aa0003f3    	mov	x19, x0
101b4f91c: 900f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4f920: f946a500    	ldr	x0, [x8, #0xd48]
101b4f924: 900f2da8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101b4f928: f9444d01    	ldr	x1, [x8, #0x898] ; isMainThread
101b4f92c: 95835e04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f930: 340000a0    	cbz	w0, 0x101b4f944 <__text+0x1b47944>
101b4f934: f9400a68    	ldr	x8, [x19, #0x10]
101b4f938: aa1303e0    	mov	x0, x19
101b4f93c: d63f0100    	blr	x8
101b4f940: 14000021    	b	0x101b4f9c4 <__text+0x1b479c4>
101b4f944: 900f3128    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101b4f948: f9453500    	ldr	x0, [x8, #0xa68]
101b4f94c: d00f1748    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101b4f950: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101b4f954: 900e5388    	adrp	x8, 0x11e5bf000 <dyld_stub_binder+0x11e5bf000>
101b4f958: 9108a108    	add	x8, x8, #0x228
101b4f95c: f90003e8    	str	x8, [sp]
101b4f960: d00cc705    	adrp	x5, 0x11b431000 <dyld_stub_binder+0x11b431000>
101b4f964: 9129a8a5    	add	x5, x5, #0xa6a
101b4f968: 900cc727    	adrp	x7, 0x11b433000 <dyld_stub_binder+0x11b433000>
101b4f96c: 912bc8e7    	add	x7, x7, #0xaf2
101b4f970: 52800062    	mov	w2, #0x3                ; =3
101b4f974: d2800003    	mov	x3, #0x0                ; =0
101b4f978: 52800004    	mov	w4, #0x0                ; =0
101b4f97c: 52824526    	mov	w6, #0x1229             ; =4649
101b4f980: 95835def    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101b4f984: f90007f5    	str	x21, [sp, #0x8]
101b4f988: fd000be8    	str	d8, [sp, #0x10]
101b4f98c: 90000008    	adrp	x8, 0x101b4f000 <__text+0x1b47000>
101b4f990: 913b2108    	add	x8, x8, #0xec8
101b4f994: b00dd549    	adrp	x9, 0x11d5f8000 <dyld_stub_binder+0x11d5f8000>
101b4f998: 910a6129    	add	x9, x9, #0x298
101b4f99c: a901a7e8    	stp	x8, x9, [sp, #0x18]
101b4f9a0: aa1303e0    	mov	x0, x19
101b4f9a4: 95835de5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101b4f9a8: f90017f3    	str	x19, [sp, #0x28]
101b4f9ac: 900dd500    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101b4f9b0: f9408c00    	ldr	x0, [x0, #0x118]
101b4f9b4: 910023e1    	add	x1, sp, #0x8
101b4f9b8: 9582f61a    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
101b4f9bc: f94017e0    	ldr	x0, [sp, #0x28]
101b4f9c0: 95835de5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4f9c4: aa1303e0    	mov	x0, x19
101b4f9c8: 95835de3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101b4f9cc: 91008280    	add	x0, x20, #0x20
101b4f9d0: 95835df0    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
101b4f9d4: d100e3a0    	sub	x0, x29, #0x38
101b4f9d8: 95835dee    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
101b4f9dc: a9497bfd    	ldp	x29, x30, [sp, #0x90]
101b4f9e0: a9484ff4    	ldp	x20, x19, [sp, #0x80]
101b4f9e4: a94757f6    	ldp	x22, x21, [sp, #0x70]
101b4f9e8: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
101b4f9ec: 910283ff    	add	sp, sp, #0xa0
101b4f9f0: d65f03c0    	ret
