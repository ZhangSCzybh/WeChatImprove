
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3f920: d10183ff    	sub	sp, sp, #0x60
104b3f924: a9025ff8    	stp	x24, x23, [sp, #0x20]
104b3f928: a90357f6    	stp	x22, x21, [sp, #0x30]
104b3f92c: a9044ff4    	stp	x20, x19, [sp, #0x40]
104b3f930: a9057bfd    	stp	x29, x30, [sp, #0x50]
104b3f934: 910143fd    	add	x29, sp, #0x50
104b3f938: aa0303f4    	mov	x20, x3
104b3f93c: aa0203f3    	mov	x19, x2
104b3f940: aa0003f5    	mov	x21, x0
104b3f944: 900db1a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3f948: f9453516    	ldr	x22, [x8, #0xa68]
104b3f94c: d00d97c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3f950: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3f954: aa0203e0    	mov	x0, x2
104b3f958: 94c39df8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3f95c: a900d3f3    	stp	x19, x20, [sp, #0x8]
104b3f960: d00ce328    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
104b3f964: 91152108    	add	x8, x8, #0x548
104b3f968: f90003e8    	str	x8, [sp]
104b3f96c: d00b3723    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3f970: 9107f063    	add	x3, x3, #0x1fc
104b3f974: b00b65e5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3f978: 910cb4a5    	add	x5, x5, #0x32d
104b3f97c: f00b65e7    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3f980: 912260e7    	add	x7, x7, #0x898
104b3f984: aa1603e0    	mov	x0, x22
104b3f988: aa1703e1    	mov	x1, x23
104b3f98c: 52800022    	mov	w2, #0x1                ; =1
104b3f990: 52800004    	mov	w4, #0x0                ; =0
104b3f994: 528216e6    	mov	w6, #0x10b7             ; =4279
104b3f998: 94c39de9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3f99c: d00d97e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b3f9a0: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104b3f9a4: aa1303e0    	mov	x0, x19
104b3f9a8: 94c39de5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3f9ac: aa1d03fd    	mov	x29, x29
104b3f9b0: 94c39de6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3f9b4: aa0003f6    	mov	x22, x0
104b3f9b8: 900d9828    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3f9bc: f9464d01    	ldr	x1, [x8, #0xc98] ; AsyncOnModMsg:MsgWrap:
104b3f9c0: aa1503e0    	mov	x0, x21
104b3f9c4: aa1603e2    	mov	x2, x22
104b3f9c8: aa1303e3    	mov	x3, x19
104b3f9cc: 94c39ddc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3f9d0: f00da228    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3f9d4: f945ed01    	ldr	x1, [x8, #0xbd8] ; AsyncOnSendVoiceError:MsgWrap:ErroNO:
104b3f9d8: aa1503e0    	mov	x0, x21
104b3f9dc: aa1603e2    	mov	x2, x22
104b3f9e0: aa1303e3    	mov	x3, x19
104b3f9e4: aa1403e4    	mov	x4, x20
104b3f9e8: 94c39dd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3f9ec: aa1303e0    	mov	x0, x19
104b3f9f0: 94c39dd9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3f9f4: aa1603e0    	mov	x0, x22
104b3f9f8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104b3f9fc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104b3fa00: a94357f6    	ldp	x22, x21, [sp, #0x30]
104b3fa04: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104b3fa08: 910183ff    	add	sp, sp, #0x60
104b3fa0c: 14c39dd2    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
