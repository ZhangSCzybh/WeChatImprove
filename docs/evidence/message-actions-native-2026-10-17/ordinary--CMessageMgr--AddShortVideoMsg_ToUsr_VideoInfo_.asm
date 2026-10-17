
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b350c4: d101c3ff    	sub	sp, sp, #0x70
104b350c8: a9035ff8    	stp	x24, x23, [sp, #0x30]
104b350cc: a90457f6    	stp	x22, x21, [sp, #0x40]
104b350d0: a9054ff4    	stp	x20, x19, [sp, #0x50]
104b350d4: a9067bfd    	stp	x29, x30, [sp, #0x60]
104b350d8: 910183fd    	add	x29, sp, #0x60
104b350dc: aa0403f6    	mov	x22, x4
104b350e0: aa0303f3    	mov	x19, x3
104b350e4: aa0203f5    	mov	x21, x2
104b350e8: aa0003f4    	mov	x20, x0
104b350ec: b00e0848    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b350f0: 52800029    	mov	w9, #0x1                ; =1
104b350f4: 39158109    	strb	w9, [x8, #0x560]
104b350f8: aa0303e0    	mov	x0, x3
104b350fc: 94c3c80f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35100: 900db2e8    	adrp	x8, 0x120191000 <dyld_stub_binder+0x120191000>
104b35104: f9402117    	ldr	x23, [x8, #0x40]
104b35108: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3510c: f947d918    	ldr	x24, [x8, #0xfb0] ; video_size
104b35110: aa1603e0    	mov	x0, x22
104b35114: 94c3c809    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35118: aa1503e0    	mov	x0, x21
104b3511c: 94c3c807    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35120: aa1603e0    	mov	x0, x22
104b35124: aa1803e1    	mov	x1, x24
104b35128: 94c3c805    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3512c: aa0003e2    	mov	x2, x0
104b35130: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35134: f944bd01    	ldr	x1, [x8, #0x978] ; reportUploadSize:
104b35138: aa1703e0    	mov	x0, x23
104b3513c: 94c3c800    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35140: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35144: f947f901    	ldr	x1, [x8, #0xff0] ; setM_uiVideoSource:
104b35148: aa1603e0    	mov	x0, x22
104b3514c: 52800062    	mov	w2, #0x3                ; =3
104b35150: 94c3c7fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35154: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35158: f944b901    	ldr	x1, [x8, #0x970] ; AddVideoMsg:ToUsr:VideoInfo:MsgType:
104b3515c: aa1403e0    	mov	x0, x20
104b35160: aa1503e2    	mov	x2, x21
104b35164: aa1303e3    	mov	x3, x19
104b35168: aa1603e4    	mov	x4, x22
104b3516c: 528007c5    	mov	w5, #0x3e               ; =62
104b35170: 94c3c7f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35174: aa1d03fd    	mov	x29, x29
104b35178: 94c3c7f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3517c: aa0003f4    	mov	x20, x0
104b35180: aa1603e0    	mov	x0, x22
104b35184: 94c3c7f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35188: aa1503e0    	mov	x0, x21
104b3518c: 94c3c7f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35190: d00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b35194: f945e900    	ldr	x0, [x8, #0xbd0]
104b35198: f00dae48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3519c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b351a0: 94c3c7e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b351a4: aa1d03fd    	mov	x29, x29
104b351a8: 94c3c7e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b351ac: aa0003f5    	mov	x21, x0
104b351b0: f00db1c8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b351b4: f9458516    	ldr	x22, [x8, #0xb08]
104b351b8: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b351bc: f944c117    	ldr	x23, [x8, #0x980] ; OnSendSight:
104b351c0: b00c55c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
104b351c4: f947e108    	ldr	x8, [x8, #0xfc0]
104b351c8: f90007e8    	str	x8, [sp, #0x8]
104b351cc: 900a1268    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104b351d0: fd41c100    	ldr	d0, [x8, #0x380]
104b351d4: 90000008    	adrp	x8, 0x104b35000 <_Flutter_MMFoundation_BindContext+0x1010be4>
104b351d8: 91093108    	add	x8, x8, #0x24c
104b351dc: b00c5609    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
104b351e0: 91238129    	add	x9, x9, #0x8e0
104b351e4: fd000be0    	str	d0, [sp, #0x10]
104b351e8: a901a7e8    	stp	x8, x9, [sp, #0x18]
104b351ec: f90017f3    	str	x19, [sp, #0x28]
104b351f0: b00d9828    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104b351f4: f9404918    	ldr	x24, [x8, #0x90] ; callExtension:selector:block:
104b351f8: aa1303e0    	mov	x0, x19
104b351fc: 94c3c7cf    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35200: 910023e4    	add	x4, sp, #0x8
104b35204: aa1503e0    	mov	x0, x21
104b35208: aa1803e1    	mov	x1, x24
104b3520c: aa1603e2    	mov	x2, x22
104b35210: aa1703e3    	mov	x3, x23
104b35214: 94c3c7ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35218: aa1503e0    	mov	x0, x21
104b3521c: 94c3c7ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35220: f94017e0    	ldr	x0, [sp, #0x28]
104b35224: 94c3c7cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35228: aa1303e0    	mov	x0, x19
104b3522c: 94c3c7ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35230: aa1403e0    	mov	x0, x20
104b35234: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104b35238: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104b3523c: a94457f6    	ldp	x22, x21, [sp, #0x40]
104b35240: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104b35244: 9101c3ff    	add	sp, sp, #0x70
104b35248: 14c3c7ca    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104b3524c: aa0103e8    	mov	x8, x1
104b35250: f9401002    	ldr	x2, [x0, #0x20]
104b35254: b00da289    	adrp	x9, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35258: f944c121    	ldr	x1, [x9, #0x980] ; OnSendSight:
104b3525c: aa0803e0    	mov	x0, x8
104b35260: 14c3c7b7    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>