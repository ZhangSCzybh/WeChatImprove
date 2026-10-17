
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b32814: d10103ff    	sub	sp, sp, #0x40
104b32818: a90157f6    	stp	x22, x21, [sp, #0x10]
104b3281c: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b32820: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b32824: 9100c3fd    	add	x29, sp, #0x30
104b32828: aa0303f3    	mov	x19, x3
104b3282c: aa0203f4    	mov	x20, x2
104b32830: aa0003f5    	mov	x21, x0
104b32834: aa0203e0    	mov	x0, x2
104b32838: 94c3d240    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3283c: 94c3d259    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
104b32840: aa0003f6    	mov	x22, x0
104b32844: 39003fff    	strb	wzr, [sp, #0xf]
104b32848: 900d9d28    	adrp	x8, 0x11fed6000 <dyld_stub_binder+0x11fed6000>
104b3284c: f944ed01    	ldr	x1, [x8, #0x9d8] ; GetMsg:LocalID:hasError:needOriginContent:
104b32850: 91003fe4    	add	x4, sp, #0xf
104b32854: aa1503e0    	mov	x0, x21
104b32858: aa1403e2    	mov	x2, x20
104b3285c: aa1303e3    	mov	x3, x19
104b32860: 52800005    	mov	w5, #0x0                ; =0
104b32864: 94c3d236    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b32868: aa1d03fd    	mov	x29, x29
104b3286c: 94c3d237    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b32870: aa0003f3    	mov	x19, x0
104b32874: aa1603e0    	mov	x0, x22
104b32878: 94c3d24d    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
104b3287c: aa1403e0    	mov	x0, x20
104b32880: 94c3d235    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b32884: aa1303e0    	mov	x0, x19
104b32888: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b3288c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b32890: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b32894: 910103ff    	add	sp, sp, #0x40
104b32898: 14c3d236    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>