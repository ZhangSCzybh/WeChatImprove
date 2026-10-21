
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff86c8: a9bc6ffc    	stp	x28, x27, [sp, #-0x40]!
104ff86cc: a90157f6    	stp	x22, x21, [sp, #0x10]
104ff86d0: a9024ff4    	stp	x20, x19, [sp, #0x20]
104ff86d4: a9037bfd    	stp	x29, x30, [sp, #0x30]
104ff86d8: 9100c3fd    	add	x29, sp, #0x30
104ff86dc: d11103ff    	sub	sp, sp, #0x440
104ff86e0: aa0003f3    	mov	x19, x0
104ff86e4: f00c2fa8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff86e8: f9405908    	ldr	x8, [x8, #0xb0]
104ff86ec: f9400108    	ldr	x8, [x8]
104ff86f0: f81c83a8    	stur	x8, [x29, #-0x38]
104ff86f4: f00de228    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ff86f8: 52800029    	mov	w9, #0x1                ; =1
104ff86fc: 391ad909    	strb	w9, [x8, #0x6b6]
104ff8700: f9401014    	ldr	x20, [x0, #0x20]
104ff8704: f00d8cd6    	adrp	x22, 0x120193000 <dyld_stub_binder+0x120193000>
104ff8708: f947f6c0    	ldr	x0, [x22, #0xfe8]
104ff870c: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8710: f946d501    	ldr	x1, [x8, #0xda8] ; m_flag
104ff8714: 94b0ba8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8718: aa0003f5    	mov	x21, x0
104ff871c: b90027ff    	str	wzr, [sp, #0x24]
104ff8720: 9105e3e0    	add	x0, sp, #0x178
104ff8724: 910093e1    	add	x1, sp, #0x24
104ff8728: 96c25d54    	bl	0x10008fc78 <__text+0x87c78>
104ff872c: 910b63e8    	add	x8, sp, #0x2d8
104ff8730: 9102e2a0    	add	x0, x21, #0xb8
104ff8734: 9105e3e1    	add	x1, sp, #0x178
104ff8738: 94b05128    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104ff873c: f947f6c0    	ldr	x0, [x22, #0xfe8]
104ff8740: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8744: f946bd01    	ldr	x1, [x8, #0xd78] ; m_localId
104ff8748: 94b0ba7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff874c: f009eca1    	adrp	x1, 0x118d8f000 <dyld_stub_binder+0x118d8f000>
104ff8750: 91154021    	add	x1, x1, #0x550
104ff8754: 9100a3e8    	add	x8, sp, #0x28
104ff8758: 94b05185    	bl	0x107c0cd6c <_Flutter_MMFoundation_BindContext+0x40e8950>
104ff875c: 910003e8    	mov	x8, sp
104ff8760: 91002115    	add	x21, x8, #0x8
104ff8764: a900d7f5    	stp	x21, x21, [sp, #0x8]
104ff8768: f9000fff    	str	xzr, [sp, #0x18]
104ff876c: 52802c00    	mov	w0, #0x160              ; =352
104ff8770: 94b0ba83    	bl	0x107c2717c <_Flutter_MMFoundation_BindContext+0x4102d60>
104ff8774: aa0003f6    	mov	x22, x0
104ff8778: a8817c1f    	stp	xzr, xzr, [x0], #0x10
104ff877c: 9100a3e1    	add	x1, sp, #0x28
104ff8780: 96c270f3    	bl	0x100094b4c <__text+0x8cb4c>
104ff8784: 900c9a68    	adrp	x8, 0x11e344000 <dyld_stub_binder+0x11e344000>
104ff8788: 91212108    	add	x8, x8, #0x848
104ff878c: 91004108    	add	x8, x8, #0x10
104ff8790: a900a2d5    	stp	x21, x8, [x22, #0x8]
104ff8794: f94007e8    	ldr	x8, [sp, #0x8]
104ff8798: f9400fe9    	ldr	x9, [sp, #0x18]
104ff879c: f90002c8    	str	x8, [x22]
104ff87a0: f9000516    	str	x22, [x8, #0x8]
104ff87a4: 91000528    	add	x8, x9, #0x1
104ff87a8: f9000fe8    	str	x8, [sp, #0x18]
104ff87ac: f00c2fe8    	adrp	x8, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
104ff87b0: 9139e108    	add	x8, x8, #0xe78
104ff87b4: a9005be8    	stp	x8, x22, [sp]
104ff87b8: b00d7228    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ff87bc: f9466501    	ldr	x1, [x8, #0xcc8] ; getObjectsWhere:orders:
104ff87c0: 910b63e2    	add	x2, sp, #0x2d8
104ff87c4: 910003e3    	mov	x3, sp
104ff87c8: aa1403e0    	mov	x0, x20
104ff87cc: 94b0ba5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff87d0: aa1d03fd    	mov	x29, x29
104ff87d4: 94b0ba5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff87d8: aa0003f4    	mov	x20, x0
104ff87dc: aa1503e0    	mov	x0, x21
104ff87e0: 96c270bf    	bl	0x100094adc <__text+0x8cadc>
104ff87e4: 9100a3e0    	add	x0, sp, #0x28
104ff87e8: 94b050e7    	bl	0x107c0cb84 <_Flutter_MMFoundation_BindContext+0x40e8768>
104ff87ec: 910b63e0    	add	x0, sp, #0x2d8
104ff87f0: 94b05124    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff87f4: 9105e3e0    	add	x0, sp, #0x178
104ff87f8: 94b05122    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff87fc: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8800: f9478501    	ldr	x1, [x8, #0xf08] ; WCMessagesFromDBMessages:
104ff8804: aa1303e0    	mov	x0, x19
104ff8808: aa1403e2    	mov	x2, x20
104ff880c: 94b0ba4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8810: aa1d03fd    	mov	x29, x29
104ff8814: 94b0ba4d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8818: aa0003f3    	mov	x19, x0
104ff881c: aa1403e0    	mov	x0, x20
104ff8820: 94b0ba4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8824: f85c83a8    	ldur	x8, [x29, #-0x38]
104ff8828: f00c2fa9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff882c: f9405929    	ldr	x9, [x9, #0xb0]
104ff8830: f9400129    	ldr	x9, [x9]
104ff8834: eb08013f    	cmp	x9, x8
104ff8838: 54000101    	b.ne	0x104ff8858 <_Flutter_MMFoundation_BindContext+0x14d443c>
104ff883c: aa1303e0    	mov	x0, x19
104ff8840: 911103ff    	add	sp, sp, #0x440
104ff8844: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104ff8848: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104ff884c: a94157f6    	ldp	x22, x21, [sp, #0x10]
104ff8850: a8c46ffc    	ldp	x28, x27, [sp], #0x40
104ff8854: 14b0ba47    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104ff8858: 94b0ba47    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
