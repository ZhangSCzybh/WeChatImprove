
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b326c8: d101c3ff    	sub	sp, sp, #0x70
104b326cc: a90267fa    	stp	x26, x25, [sp, #0x20]
104b326d0: a9035ff8    	stp	x24, x23, [sp, #0x30]
104b326d4: a90457f6    	stp	x22, x21, [sp, #0x40]
104b326d8: a9054ff4    	stp	x20, x19, [sp, #0x50]
104b326dc: a9067bfd    	stp	x29, x30, [sp, #0x60]
104b326e0: 910183fd    	add	x29, sp, #0x60
104b326e4: aa0503f3    	mov	x19, x5
104b326e8: aa0403f7    	mov	x23, x4
104b326ec: aa0303f5    	mov	x21, x3
104b326f0: aa0203f4    	mov	x20, x2
104b326f4: aa0003f6    	mov	x22, x0
104b326f8: b00db788    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b326fc: b9895508    	ldrsw	x8, [x8, #0x954]
104b32700: f8686818    	ldr	x24, [x0, x8]
104b32704: 900d9d28    	adrp	x8, 0x11fed6000 <dyld_stub_binder+0x11fed6000>
104b32708: f944ed19    	ldr	x25, [x8, #0x9d8] ; GetMsg:LocalID:hasError:needOriginContent:
104b3270c: aa0203e0    	mov	x0, x2
104b32710: 94c3d28a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b32714: aa1803e0    	mov	x0, x24
104b32718: aa1903e1    	mov	x1, x25
104b3271c: aa1403e2    	mov	x2, x20
104b32720: aa1503e3    	mov	x3, x21
104b32724: aa1703e4    	mov	x4, x23
104b32728: aa1303e5    	mov	x5, x19
104b3272c: 94c3d284    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b32730: aa1d03fd    	mov	x29, x29
104b32734: 94c3d285    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b32738: aa0003f3    	mov	x19, x0
104b3273c: b4000180    	cbz	x0, 0x104b3276c <_Flutter_MMFoundation_BindContext+0x100e350>
104b32740: b00da208    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
104b32744: f9461d01    	ldr	x1, [x8, #0xc38] ; CheckMessageStatus:Msg:
104b32748: aa1603e0    	mov	x0, x22
104b3274c: aa1403e2    	mov	x2, x20
104b32750: aa1303e3    	mov	x3, x19
104b32754: 94c3d27a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b32758: aa1403e0    	mov	x0, x20
104b3275c: 94c3d27e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b32760: aa1303e0    	mov	x0, x19
104b32764: 94c3d275    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b32768: 14000021    	b	0x104b327ec <_Flutter_MMFoundation_BindContext+0x100e3d0>
104b3276c: b00db208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b32770: f9453516    	ldr	x22, [x8, #0xa68] ; �gH 
104b32774: b00db208    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b32778: f9454500    	ldr	x0, [x8, #0xa88]
104b3277c: d00d9848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b32780: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b32784: aa1403e2    	mov	x2, x20
104b32788: 94c3d26d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3278c: aa1d03fd    	mov	x29, x29
104b32790: 94c3d26e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b32794: aa0003f7    	mov	x23, x0
104b32798: aa1403e0    	mov	x0, x20
104b3279c: 94c3d26e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b327a0: f00d9828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b327a4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b327a8: a900d7f7    	stp	x23, x21, [sp, #0x8]
104b327ac: d00ce388    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b327b0: 912da108    	add	x8, x8, #0xb68
104b327b4: f90003e8    	str	x8, [sp]
104b327b8: f00b3783    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b327bc: 9107f063    	add	x3, x3, #0x1fc
104b327c0: d00b6645    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b327c4: 910cb4a5    	add	x5, x5, #0x32d
104b327c8: f00b6647    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b327cc: 91185ce7    	add	x7, x7, #0x617
104b327d0: aa1603e0    	mov	x0, x22
104b327d4: 52800022    	mov	w2, #0x1                ; =1
104b327d8: 52800004    	mov	w4, #0x0                ; =0
104b327dc: 5280ff66    	mov	w6, #0x7fb              ; =2043
104b327e0: 94c3d257    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b327e4: aa1703e0    	mov	x0, x23
104b327e8: 94c3d25b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b327ec: aa1303e0    	mov	x0, x19
104b327f0: 94c3d259    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b327f4: aa1303e0    	mov	x0, x19
104b327f8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104b327fc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104b32800: a94457f6    	ldp	x22, x21, [sp, #0x40]
104b32804: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104b32808: a94267fa    	ldp	x26, x25, [sp, #0x20]
104b3280c: 9101c3ff    	add	sp, sp, #0x70
104b32810: 14c3d258    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>