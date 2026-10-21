
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff81ec: a9bc6ffc    	stp	x28, x27, [sp, #-0x40]!
104ff81f0: a90157f6    	stp	x22, x21, [sp, #0x10]
104ff81f4: a9024ff4    	stp	x20, x19, [sp, #0x20]
104ff81f8: a9037bfd    	stp	x29, x30, [sp, #0x30]
104ff81fc: 9100c3fd    	add	x29, sp, #0x30
104ff8200: d12683ff    	sub	sp, sp, #0x9a0
104ff8204: f00c2fa8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff8208: f9405908    	ldr	x8, [x8, #0xb0]
104ff820c: f9400108    	ldr	x8, [x8]
104ff8210: f81c83a8    	stur	x8, [x29, #-0x38]
104ff8214: f00de228    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ff8218: 52800029    	mov	w9, #0x1                ; =1
104ff821c: 391acd09    	strb	w9, [x8, #0x6b3]
104ff8220: f9401013    	ldr	x19, [x0, #0x20]
104ff8224: f00d8cd5    	adrp	x21, 0x120193000 <dyld_stub_binder+0x120193000>
104ff8228: f947f6a0    	ldr	x0, [x21, #0xfe8]
104ff822c: b00d7208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ff8230: f947d501    	ldr	x1, [x8, #0xfa8] ; allProperties
104ff8234: 94b0bbc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8238: 911bc3e8    	add	x8, sp, #0x6f0
104ff823c: 94b0533d    	bl	0x107c0cf30 <_Flutter_MMFoundation_BindContext+0x40e8b14>
104ff8240: 912143e0    	add	x0, sp, #0x850
104ff8244: 911bc3e1    	add	x1, sp, #0x6f0
104ff8248: 94b0527f    	bl	0x107c0cc44 <_Flutter_MMFoundation_BindContext+0x40e8828>
104ff824c: f947f6a0    	ldr	x0, [x21, #0xfe8]
104ff8250: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8254: f946d501    	ldr	x1, [x8, #0xda8] ; m_flag
104ff8258: 94b0bbb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff825c: aa0003f4    	mov	x20, x0
104ff8260: b9000fff    	str	wzr, [sp, #0xc]
104ff8264: 910b43e0    	add	x0, sp, #0x2d0
104ff8268: 910033e1    	add	x1, sp, #0xc
104ff826c: 96c25e83    	bl	0x10008fc78 <__text+0x87c78>
104ff8270: 9110c3f6    	add	x22, sp, #0x430
104ff8274: 9110c3e8    	add	x8, sp, #0x430
104ff8278: 9102e280    	add	x0, x20, #0xb8
104ff827c: 910b43e1    	add	x1, sp, #0x2d0
104ff8280: 94b05256    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104ff8284: f947f6a0    	ldr	x0, [x21, #0xfe8]
104ff8288: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff828c: f9470d01    	ldr	x1, [x8, #0xe18] ; m_messgaeRelevanceType
104ff8290: 94b0bbab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8294: aa0003f4    	mov	x20, x0
104ff8298: 52800048    	mov	w8, #0x2                ; =2
104ff829c: f90003e8    	str	x8, [sp]
104ff82a0: 910043e0    	add	x0, sp, #0x10
104ff82a4: 910003e1    	mov	x1, sp
104ff82a8: 9400003c    	bl	0x104ff8398 <_Flutter_MMFoundation_BindContext+0x14d3f7c>
104ff82ac: 9105c3e8    	add	x8, sp, #0x170
104ff82b0: 9102e280    	add	x0, x20, #0xb8
104ff82b4: 910043e1    	add	x1, sp, #0x10
104ff82b8: 94b05248    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104ff82bc: 911643e8    	add	x8, sp, #0x590
104ff82c0: 9104a2c0    	add	x0, x22, #0x128
104ff82c4: 9105c3e1    	add	x1, sp, #0x170
104ff82c8: 94b05246    	bl	0x107c0cbe0 <_Flutter_MMFoundation_BindContext+0x40e87c4>
104ff82cc: f00d72c8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104ff82d0: f9428901    	ldr	x1, [x8, #0x510] ; getValueOnResultColumn:where:
104ff82d4: 912143e2    	add	x2, sp, #0x850
104ff82d8: 911643e3    	add	x3, sp, #0x590
104ff82dc: aa1303e0    	mov	x0, x19
104ff82e0: 94b0bb97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff82e4: aa1d03fd    	mov	x29, x29
104ff82e8: 94b0bb98    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff82ec: aa0003f4    	mov	x20, x0
104ff82f0: b00d7228    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ff82f4: f9465d01    	ldr	x1, [x8, #0xcb8] ; numberValue
104ff82f8: 94b0bb91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff82fc: aa1d03fd    	mov	x29, x29
104ff8300: 94b0bb92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8304: aa0003f5    	mov	x21, x0
104ff8308: f00d8888    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ff830c: f9424901    	ldr	x1, [x8, #0x490] ; unsignedIntValue
104ff8310: 94b0bb8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8314: aa0003f3    	mov	x19, x0
104ff8318: aa1503e0    	mov	x0, x21
104ff831c: 94b0bb8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8320: aa1403e0    	mov	x0, x20
104ff8324: 94b0bb8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8328: 911643e0    	add	x0, sp, #0x590
104ff832c: 94b05255    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8330: 9105c3e0    	add	x0, sp, #0x170
104ff8334: 94b05253    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8338: 910043e0    	add	x0, sp, #0x10
104ff833c: 94b05251    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8340: 9110c3e0    	add	x0, sp, #0x430
104ff8344: 94b0524f    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8348: 910b43e0    	add	x0, sp, #0x2d0
104ff834c: 94b0524d    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8350: 912143e0    	add	x0, sp, #0x850
104ff8354: 94b0523b    	bl	0x107c0cc40 <_Flutter_MMFoundation_BindContext+0x40e8824>
104ff8358: 911bc3e0    	add	x0, sp, #0x6f0
104ff835c: 94b05249    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8360: f85c83a8    	ldur	x8, [x29, #-0x38]
104ff8364: f00c2fa9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff8368: f9405929    	ldr	x9, [x9, #0xb0]
104ff836c: f9400129    	ldr	x9, [x9]
104ff8370: eb08013f    	cmp	x9, x8
104ff8374: 54000101    	b.ne	0x104ff8394 <_Flutter_MMFoundation_BindContext+0x14d3f78>
104ff8378: aa1303e0    	mov	x0, x19
104ff837c: 912683ff    	add	sp, sp, #0x9a0
104ff8380: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104ff8384: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104ff8388: a94157f6    	ldp	x22, x21, [sp, #0x10]
104ff838c: a8c46ffc    	ldp	x28, x27, [sp], #0x40
104ff8390: d65f03c0    	ret
104ff8394: 94b0bb78    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
