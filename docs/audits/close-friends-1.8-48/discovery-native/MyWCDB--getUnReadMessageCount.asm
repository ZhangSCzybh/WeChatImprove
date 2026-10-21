
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff80ac: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104ff80b0: a9014ff4    	stp	x20, x19, [sp, #0x10]
104ff80b4: a9027bfd    	stp	x29, x30, [sp, #0x20]
104ff80b8: 910083fd    	add	x29, sp, #0x20
104ff80bc: d11603ff    	sub	sp, sp, #0x580
104ff80c0: f00c2fa8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff80c4: f9405908    	ldr	x8, [x8, #0xb0]
104ff80c8: f9400108    	ldr	x8, [x8]
104ff80cc: f81d83a8    	stur	x8, [x29, #-0x28]
104ff80d0: f00de228    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ff80d4: 52800029    	mov	w9, #0x1                ; =1
104ff80d8: 391ac909    	strb	w9, [x8, #0x6b2]
104ff80dc: f9401013    	ldr	x19, [x0, #0x20]
104ff80e0: f00d8cd4    	adrp	x20, 0x120193000 <dyld_stub_binder+0x120193000>
104ff80e4: f947f680    	ldr	x0, [x20, #0xfe8]
104ff80e8: b00d7208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ff80ec: f947d501    	ldr	x1, [x8, #0xfa8] ; allProperties
104ff80f0: 94b0bc13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff80f4: 910b43e8    	add	x8, sp, #0x2d0
104ff80f8: 94b0538e    	bl	0x107c0cf30 <_Flutter_MMFoundation_BindContext+0x40e8b14>
104ff80fc: 9110c3e0    	add	x0, sp, #0x430
104ff8100: 910b43e1    	add	x1, sp, #0x2d0
104ff8104: 94b052d0    	bl	0x107c0cc44 <_Flutter_MMFoundation_BindContext+0x40e8828>
104ff8108: f947f680    	ldr	x0, [x20, #0xfe8]
104ff810c: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8110: f946d501    	ldr	x1, [x8, #0xda8] ; m_flag
104ff8114: 94b0bc0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8118: aa0003f4    	mov	x20, x0
104ff811c: b9000fff    	str	wzr, [sp, #0xc]
104ff8120: 910043e0    	add	x0, sp, #0x10
104ff8124: 910033e1    	add	x1, sp, #0xc
104ff8128: 96c25ed4    	bl	0x10008fc78 <__text+0x87c78>
104ff812c: 9105c3e8    	add	x8, sp, #0x170
104ff8130: 9102e280    	add	x0, x20, #0xb8
104ff8134: 910043e1    	add	x1, sp, #0x10
104ff8138: 94b052a8    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104ff813c: f00d72c8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104ff8140: f9428901    	ldr	x1, [x8, #0x510] ; getValueOnResultColumn:where:
104ff8144: 9110c3e2    	add	x2, sp, #0x430
104ff8148: 9105c3e3    	add	x3, sp, #0x170
104ff814c: aa1303e0    	mov	x0, x19
104ff8150: 94b0bbfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8154: aa1d03fd    	mov	x29, x29
104ff8158: 94b0bbfc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff815c: aa0003f4    	mov	x20, x0
104ff8160: b00d7228    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ff8164: f9465d01    	ldr	x1, [x8, #0xcb8] ; numberValue
104ff8168: 94b0bbf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff816c: aa1d03fd    	mov	x29, x29
104ff8170: 94b0bbf6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8174: aa0003f5    	mov	x21, x0
104ff8178: f00d8888    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ff817c: f9424901    	ldr	x1, [x8, #0x490] ; unsignedIntValue
104ff8180: 94b0bbef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8184: aa0003f3    	mov	x19, x0
104ff8188: aa1503e0    	mov	x0, x21
104ff818c: 94b0bbf2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8190: aa1403e0    	mov	x0, x20
104ff8194: 94b0bbf0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8198: 9105c3e0    	add	x0, sp, #0x170
104ff819c: 94b052b9    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff81a0: 910043e0    	add	x0, sp, #0x10
104ff81a4: 94b052b7    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff81a8: 9110c3e0    	add	x0, sp, #0x430
104ff81ac: 94b052a5    	bl	0x107c0cc40 <_Flutter_MMFoundation_BindContext+0x40e8824>
104ff81b0: 910b43e0    	add	x0, sp, #0x2d0
104ff81b4: 94b052b3    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff81b8: f85d83a8    	ldur	x8, [x29, #-0x28]
104ff81bc: f00c2fa9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff81c0: f9405929    	ldr	x9, [x9, #0xb0]
104ff81c4: f9400129    	ldr	x9, [x9]
104ff81c8: eb08013f    	cmp	x9, x8
104ff81cc: 540000e1    	b.ne	0x104ff81e8 <_Flutter_MMFoundation_BindContext+0x14d3dcc>
104ff81d0: aa1303e0    	mov	x0, x19
104ff81d4: 911603ff    	add	sp, sp, #0x580
104ff81d8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ff81dc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ff81e0: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ff81e4: d65f03c0    	ret
104ff81e8: 94b0bbe3    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
