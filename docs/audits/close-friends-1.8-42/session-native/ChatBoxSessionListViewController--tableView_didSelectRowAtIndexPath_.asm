
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4b130: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100e4b134: a90157f6    	stp	x22, x21, [sp, #0x10]
100e4b138: a9024ff4    	stp	x20, x19, [sp, #0x20]
100e4b13c: a9037bfd    	stp	x29, x30, [sp, #0x30]
100e4b140: 9100c3fd    	add	x29, sp, #0x30
100e4b144: aa0303f3    	mov	x19, x3
100e4b148: aa0203f5    	mov	x21, x2
100e4b14c: aa0003f4    	mov	x20, x0
100e4b150: b00fef28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e4b154: 52800029    	mov	w9, #0x1                ; =1
100e4b158: 3918a509    	strb	w9, [x8, #0x629]
100e4b15c: b00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e4b160: f947f916    	ldr	x22, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
100e4b164: aa0303e0    	mov	x0, x3
100e4b168: 95b76ff4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4b16c: aa1503e0    	mov	x0, x21
100e4b170: aa1603e1    	mov	x1, x22
100e4b174: aa1303e2    	mov	x2, x19
100e4b178: 52800023    	mov	w3, #0x1                ; =1
100e4b17c: 95b76ff0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b180: 900f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e4b184: f945e900    	ldr	x0, [x8, #0xbd0]
100e4b188: b00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4b18c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100e4b190: 95b76feb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b194: aa1d03fd    	mov	x29, x29
100e4b198: 95b76fec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b19c: aa0003f5    	mov	x21, x0
100e4b1a0: 900f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4b1a4: f9420500    	ldr	x0, [x8, #0x408]
100e4b1a8: 900f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4b1ac: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100e4b1b0: 95b76fe3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b1b4: aa0003e2    	mov	x2, x0
100e4b1b8: d00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4b1bc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100e4b1c0: aa1503e0    	mov	x0, x21
100e4b1c4: 95b76fde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b1c8: aa1d03fd    	mov	x29, x29
100e4b1cc: 95b76fdf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b1d0: aa0003f6    	mov	x22, x0
100e4b1d4: f00f95c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100e4b1d8: f9440917    	ldr	x23, [x8, #0x810] ; row
100e4b1dc: aa1303e0    	mov	x0, x19
100e4b1e0: aa1703e1    	mov	x1, x23
100e4b1e4: 95b76fd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b1e8: aa0003e2    	mov	x2, x0
100e4b1ec: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4b1f0: f943e901    	ldr	x1, [x8, #0x7d0] ; getSessionAtIndex:
100e4b1f4: aa1603e0    	mov	x0, x22
100e4b1f8: 95b76fd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b1fc: aa1d03fd    	mov	x29, x29
100e4b200: 95b76fd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4b204: aa0003f8    	mov	x24, x0
100e4b208: aa1603e0    	mov	x0, x22
100e4b20c: 95b76fd2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b210: aa1503e0    	mov	x0, x21
100e4b214: 95b76fd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b218: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4b21c: f943f501    	ldr	x1, [x8, #0x7e8] ; openSession:atIndexPath:
100e4b220: aa1403e0    	mov	x0, x20
100e4b224: aa1803e2    	mov	x2, x24
100e4b228: aa1303e3    	mov	x3, x19
100e4b22c: 95b76fc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b230: b00f9ce8    	adrp	x8, 0x1201e8000 <dyld_stub_binder+0x1201e8000>
100e4b234: b9856d08    	ldrsw	x8, [x8, #0x56c]
100e4b238: f8686a94    	ldr	x20, [x20, x8]
100e4b23c: aa1303e0    	mov	x0, x19
100e4b240: aa1703e1    	mov	x1, x23
100e4b244: 95b76fbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b248: aa0003f5    	mov	x21, x0
100e4b24c: aa1303e0    	mov	x0, x19
100e4b250: 95b76fc1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b254: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4b258: f943f901    	ldr	x1, [x8, #0x7f0] ; reportClickSession:status:index:
100e4b25c: aa1403e0    	mov	x0, x20
100e4b260: aa1803e2    	mov	x2, x24
100e4b264: d2800003    	mov	x3, #0x0                ; =0
100e4b268: aa1503e4    	mov	x4, x21
100e4b26c: 95b76fb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b270: aa1803e0    	mov	x0, x24
100e4b274: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100e4b278: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100e4b27c: a94157f6    	ldp	x22, x21, [sp, #0x10]
100e4b280: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100e4b284: 15b76fb4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
