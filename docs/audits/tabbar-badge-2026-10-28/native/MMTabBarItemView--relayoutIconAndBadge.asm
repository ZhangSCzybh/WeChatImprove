
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104728808: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10472880c: a9017bfd    	stp	x29, x30, [sp, #0x10]
104728810: 910043fd    	add	x29, sp, #0x10
104728814: aa0003f3    	mov	x19, x0
104728818: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10472881c: f9469501    	ldr	x1, [x8, #0xd28] ; selector reloadIconImage
104728820: 94d3fa47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728824: b00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104728828: f9467901    	ldr	x1, [x8, #0xcf0] ; selector layoutIcon
10472882c: aa1303e0    	mov	x0, x19
104728830: 94d3fa43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728834: 900dbce8    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
104728838: f9479d01    	ldr	x1, [x8, #0xf38] ; selector layoutBadgeView
10472883c: aa1303e0    	mov	x0, x19
104728840: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104728844: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104728848: 14d3fa3d    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
