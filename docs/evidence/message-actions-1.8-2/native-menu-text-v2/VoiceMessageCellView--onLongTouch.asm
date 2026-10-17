
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10627f1fc: d10103ff    	sub	sp, sp, #0x40
10627f200: a90157f6    	stp	x22, x21, [sp, #0x10]
10627f204: a9024ff4    	stp	x20, x19, [sp, #0x20]
10627f208: a9037bfd    	stp	x29, x30, [sp, #0x30]
10627f20c: 9100c3fd    	add	x29, sp, #0x30
10627f210: aa0003f3    	mov	x19, x0
10627f214: d00cfa48    	adrp	x8, 0x1201c9000 <dyld_stub_binder+0x1201c9000>
10627f218: f9400908    	ldr	x8, [x8, #0x10] ; @<; 
10627f21c: a90023e0    	stp	x0, x8, [sp]
10627f220: 900cde08    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10627f224: f9412501    	ldr	x1, [x8, #0x248] ; onLongTouch
10627f228: 910003e0    	mov	x0, sp
10627f22c: 94669fc6    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10627f230: f00cdde8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10627f234: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
10627f238: aa1303e0    	mov	x0, x19
10627f23c: 94669fc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627f240: aa1d03fd    	mov	x29, x29
10627f244: 94669fc1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10627f248: aa0003f4    	mov	x20, x0
10627f24c: d00cddc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10627f250: f9447101    	ldr	x1, [x8, #0x8e0] ; isPlaying
10627f254: 94669fba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627f258: 34000180    	cbz	w0, 0x10627f288 <_Flutter_MMFoundation_BindContext+0x275ae6c>
10627f25c: 94669fc9    	bl	0x107c27180 <_Flutter_MMFoundation_BindContext+0x4102d64>
10627f260: aa0003f5    	mov	x21, x0
10627f264: aa1403e0    	mov	x0, x20
10627f268: 94669fbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627f26c: 37000135    	tbnz	w21, #0x0, 0x10627f290 <_Flutter_MMFoundation_BindContext+0x275ae74>
10627f270: f00ce088    	adrp	x8, 0x11fe92000 <dyld_stub_binder+0x11fe92000>
10627f274: f9465901    	ldr	x1, [x8, #0xcb0] ; onClick:
10627f278: aa1303e0    	mov	x0, x19
10627f27c: 52800022    	mov	w2, #0x1                ; =1
10627f280: 94669faf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627f284: 14000003    	b	0x10627f290 <_Flutter_MMFoundation_BindContext+0x275ae74>
10627f288: aa1403e0    	mov	x0, x20
10627f28c: 94669fb2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10627f290: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10627f294: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10627f298: a94157f6    	ldp	x22, x21, [sp, #0x10]
10627f29c: 910103ff    	add	sp, sp, #0x40
10627f2a0: d65f03c0    	ret