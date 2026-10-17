
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b328b4: d10183ff    	sub	sp, sp, #0x60
104b328b8: a9025ff8    	stp	x24, x23, [sp, #0x20]
104b328bc: a90357f6    	stp	x22, x21, [sp, #0x30]
104b328c0: a9044ff4    	stp	x20, x19, [sp, #0x40]
104b328c4: a9057bfd    	stp	x29, x30, [sp, #0x50]
104b328c8: 910143fd    	add	x29, sp, #0x50
104b328cc: aa0303f5    	mov	x21, x3
104b328d0: aa0203f4    	mov	x20, x2
104b328d4: aa0003f6    	mov	x22, x0
104b328d8: b00db788    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b328dc: b9895508    	ldrsw	x8, [x8, #0x954]
104b328e0: f8686813    	ldr	x19, [x0, x8]
104b328e4: d00d9868    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b328e8: f941c117    	ldr	x23, [x8, #0x380] ; GetMsg:n64SvrID:
104b328ec: aa0203e0    	mov	x0, x2
104b328f0: 94c3d212    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b328f4: aa1303e0    	mov	x0, x19
104b328f8: aa1703e1    	mov	x1, x23
104b328fc: aa1403e2    	mov	x2, x20
104b32900: aa1503e3    	mov	x3, x21
104b32904: 94c3d20e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b32908: aa1d03fd    	mov	x29, x29
104b3290c: 94c3d20f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b32910: aa0003f3    	mov	x19, x0
104b32914: b4000180    	cbz	x0, 0x104b32944 <_Flutter_MMFoundation_BindContext+0x100e528>
104b32918: b00da208    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
104b3291c: f9461d01    	ldr	x1, [x8, #0xc38] ; CheckMessageStatus:Msg:
104b32920: aa1603e0    	mov	x0, x22
104b32924: aa1403e2    	mov	x2, x20
104b32928: aa1303e3    	mov	x3, x19
104b3292c: 94c3d204    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b32930: aa1403e0    	mov	x0, x20
104b32934: 94c3d208    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b32938: aa1303e0    	mov	x0, x19
104b3293c: 94c3d1ff    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b32940: 14000021    	b	0x104b329c4 <_Flutter_MMFoundation_BindContext+0x100e5a8>
104b32944: b00db208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b32948: f9453516    	ldr	x22, [x8, #0xa68] ; �gH 
104b3294c: b00db208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b32950: f9454500    	ldr	x0, [x8, #0xa88]
104b32954: d00d9848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b32958: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b3295c: aa1403e2    	mov	x2, x20
104b32960: 94c3d1f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b32964: aa1d03fd    	mov	x29, x29
104b32968: 94c3d1f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3296c: aa0003f7    	mov	x23, x0
104b32970: aa1403e0    	mov	x0, x20
104b32974: 94c3d1f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b32978: f00d9828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3297c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b32980: a900d7f7    	stp	x23, x21, [sp, #0x8]
104b32984: d00ce388    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b32988: 912e2108    	add	x8, x8, #0xb88
104b3298c: f90003e8    	str	x8, [sp]
104b32990: f00b3783    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b32994: 9107f063    	add	x3, x3, #0x1fc
104b32998: d00b6645    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3299c: 910cb4a5    	add	x5, x5, #0x32d
104b329a0: f00b6647    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b329a4: 9119dce7    	add	x7, x7, #0x677
104b329a8: aa1603e0    	mov	x0, x22
104b329ac: 52800022    	mov	w2, #0x1                ; =1
104b329b0: 52800004    	mov	w4, #0x0                ; =0
104b329b4: 52810246    	mov	w6, #0x812              ; =2066
104b329b8: 94c3d1e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b329bc: aa1703e0    	mov	x0, x23
104b329c0: 94c3d1e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b329c4: aa1303e0    	mov	x0, x19
104b329c8: 94c3d1e3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b329cc: aa1303e0    	mov	x0, x19
104b329d0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104b329d4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104b329d8: a94357f6    	ldp	x22, x21, [sp, #0x30]
104b329dc: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104b329e0: 910183ff    	add	sp, sp, #0x60
104b329e4: 14c3d1e3    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>