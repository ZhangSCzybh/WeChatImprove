
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101767434: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
101767438: a9017bfd    	stp	x29, x30, [sp, #0x10]
10176743c: 910043fd    	add	x29, sp, #0x10
101767440: aa0003f3    	mov	x19, x0
101767444: 900f3a08    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
101767448: f9453101    	ldr	x1, [x8, #0xa60] ; listAdapter
10176744c: 9592ff3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767450: aa1d03fd    	mov	x29, x29
101767454: 9592ff3d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767458: aa0003f4    	mov	x20, x0
10176745c: f00f4ce8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101767460: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
101767464: 9592ff36    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767468: aa1403e0    	mov	x0, x20
10176746c: 9592ff3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101767470: f00f4d08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101767474: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
101767478: aa1303e0    	mov	x0, x19
10176747c: 9592ff30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767480: aa1d03fd    	mov	x29, x29
101767484: 9592ff31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767488: aa0003f3    	mov	x19, x0
10176748c: 900f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101767490: f946b901    	ldr	x1, [x8, #0xd70] ; layoutIfNeeded
101767494: 9592ff2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767498: aa1303e0    	mov	x0, x19
10176749c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1017674a0: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1017674a4: 1592ff2c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
