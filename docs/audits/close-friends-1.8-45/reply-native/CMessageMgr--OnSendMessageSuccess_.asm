
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3e954: d10103ff    	sub	sp, sp, #0x40
104b3e958: a90157f6    	stp	x22, x21, [sp, #0x10]
104b3e95c: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b3e960: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b3e964: 9100c3fd    	add	x29, sp, #0x30
104b3e968: aa0203f3    	mov	x19, x2
104b3e96c: aa0003f4    	mov	x20, x0
104b3e970: b00db1a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3e974: f9453515    	ldr	x21, [x8, #0xa68]
104b3e978: f00d97c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3e97c: f942a916    	ldr	x22, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3e980: aa0203e0    	mov	x0, x2
104b3e984: 94c3a1ed    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3e988: f00ce328    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
104b3e98c: 9110a108    	add	x8, x8, #0x428
104b3e990: a9004fe8    	stp	x8, x19, [sp]
104b3e994: f00b3723    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3e998: 9107f063    	add	x3, x3, #0x1fc
104b3e99c: d00b65e5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3e9a0: 910cb4a5    	add	x5, x5, #0x32d
104b3e9a4: 900b6607    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3e9a8: 911d78e7    	add	x7, x7, #0x75e
104b3e9ac: aa1503e0    	mov	x0, x21
104b3e9b0: aa1603e1    	mov	x1, x22
104b3e9b4: 52800022    	mov	w2, #0x1                ; =1
104b3e9b8: 52800004    	mov	w4, #0x0                ; =0
104b3e9bc: 5281ff86    	mov	w6, #0xffc              ; =4092
104b3e9c0: 94c3a1df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3e9c4: f00d97e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b3e9c8: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104b3e9cc: aa1303e0    	mov	x0, x19
104b3e9d0: 94c3a1db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3e9d4: aa1d03fd    	mov	x29, x29
104b3e9d8: 94c3a1dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3e9dc: aa0003f5    	mov	x21, x0
104b3e9e0: b00d9828    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3e9e4: f9464d01    	ldr	x1, [x8, #0xc98] ; AsyncOnModMsg:MsgWrap:
104b3e9e8: aa1403e0    	mov	x0, x20
104b3e9ec: aa1503e2    	mov	x2, x21
104b3e9f0: aa1303e3    	mov	x3, x19
104b3e9f4: 94c3a1d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3e9f8: aa1303e0    	mov	x0, x19
104b3e9fc: 94c3a1d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3ea00: aa1503e0    	mov	x0, x21
104b3ea04: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b3ea08: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b3ea0c: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b3ea10: 910103ff    	add	sp, sp, #0x40
104b3ea14: 14c3a1d0    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
