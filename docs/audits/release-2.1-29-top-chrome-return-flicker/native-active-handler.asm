
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aa8398: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104aa839c: a9015ff8    	stp	x24, x23, [sp, #0x10]
104aa83a0: a90257f6    	stp	x22, x21, [sp, #0x20]
104aa83a4: a9034ff4    	stp	x20, x19, [sp, #0x30]
104aa83a8: a9047bfd    	stp	x29, x30, [sp, #0x40]
104aa83ac: 910103fd    	add	x29, sp, #0x40
104aa83b0: aa0303f3    	mov	x19, x3
104aa83b4: aa0203f5    	mov	x21, x2
104aa83b8: aa0003f4    	mov	x20, x0
104aa83bc: d00e0ca8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104aa83c0: 52800029    	mov	w9, #0x1                ; =1
104aa83c4: 390d8d09    	strb	w9, [x8, #0x363]
104aa83c8: aa0303e0    	mov	x0, x3
104aa83cc: 94c5fb5b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104aa83d0: f00db648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa83d4: f945e900    	ldr	x0, [x8, #0xbd0]
104aa83d8: 900db2c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104aa83dc: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104aa83e0: 94c5fb57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa83e4: aa1d03fd    	mov	x29, x29
104aa83e8: 94c5fb58    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa83ec: aa0003f6    	mov	x22, x0
104aa83f0: d00db668    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104aa83f4: f9424100    	ldr	x0, [x8, #0x480]
104aa83f8: f00db2a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aa83fc: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104aa8400: 94c5fb4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8404: aa0003e2    	mov	x2, x0
104aa8408: b00d9c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aa840c: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104aa8410: aa1603e0    	mov	x0, x22
104aa8414: 94c5fb4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8418: aa1d03fd    	mov	x29, x29
104aa841c: 94c5fb4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa8420: aa0003f7    	mov	x23, x0
104aa8424: 900da6e8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104aa8428: f9467101    	ldr	x1, [x8, #0xce0] ; selector resetCurrentRedEnvLaunchMode
104aa842c: 94c5fb44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8430: aa1703e0    	mov	x0, x23
104aa8434: 94c5fb48    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8438: aa1603e0    	mov	x0, x22
104aa843c: 94c5fb46    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8440: f00dbbd9    	adrp	x25, 0x120223000 <dyld_stub_binder+0x120223000>
104aa8444: d00db2f8    	adrp	x24, 0x120106000 <dyld_stub_binder+0x120106000>
104aa8448: b40002b5    	cbz	x21, 0x104aa849c <_Flutter_MMFoundation_BindContext+0xf84080>
104aa844c: b983173a    	ldrsw	x26, [x25, #0x314]
104aa8450: 8b1a0280    	add	x0, x20, x26
104aa8454: 94c5fb4e    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104aa8458: aa0003f6    	mov	x22, x0
104aa845c: 900da6e8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104aa8460: f9465d15    	ldr	x21, [x8, #0xcb8] ; selector cancelSelectedCell
104aa8464: f9436301    	ldr	x1, [x24, #0x6c0] ; selector respondsToSelector:
104aa8468: aa1503e2    	mov	x2, x21
104aa846c: 94c5fb34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8470: aa0003f7    	mov	x23, x0
104aa8474: aa1603e0    	mov	x0, x22
104aa8478: 94c5fb37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa847c: 34000117    	cbz	w23, 0x104aa849c <_Flutter_MMFoundation_BindContext+0xf84080>
104aa8480: 8b1a0280    	add	x0, x20, x26
104aa8484: 94c5fb42    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104aa8488: aa0003f6    	mov	x22, x0
104aa848c: aa1503e1    	mov	x1, x21
104aa8490: 94c5fb2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8494: aa1603e0    	mov	x0, x22
104aa8498: 94c5fb2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa849c: 900db668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aa84a0: f9408d00    	ldr	x0, [x8, #0x118]
104aa84a4: 900d9ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aa84a8: f9423901    	ldr	x1, [x8, #0x470] ; selector getAppViewControllerManager
104aa84ac: 94c5fb24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa84b0: aa1d03fd    	mov	x29, x29
104aa84b4: 94c5fb25    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa84b8: aa0003f5    	mov	x21, x0
104aa84bc: d00d9cc8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104aa84c0: f941bd01    	ldr	x1, [x8, #0x378] ; selector isUsingSplitView
104aa84c4: 94c5fb1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa84c8: aa0003f6    	mov	x22, x0
104aa84cc: aa1503e0    	mov	x0, x21
104aa84d0: 94c5fb21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa84d4: 340002d6    	cbz	w22, 0x104aa852c <_Flutter_MMFoundation_BindContext+0xf84110>
104aa84d8: b9831739    	ldrsw	x25, [x25, #0x314]
104aa84dc: 8b190280    	add	x0, x20, x25
104aa84e0: 94c5fb2b    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104aa84e4: aa0003f6    	mov	x22, x0
104aa84e8: 900da6e8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104aa84ec: f9467515    	ldr	x21, [x8, #0xce8] ; selector selectCellForName:
104aa84f0: f9436301    	ldr	x1, [x24, #0x6c0] ; selector respondsToSelector:
104aa84f4: aa1503e2    	mov	x2, x21
104aa84f8: 94c5fb11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa84fc: aa0003f7    	mov	x23, x0
104aa8500: aa1603e0    	mov	x0, x22
104aa8504: 94c5fb14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8508: 34000137    	cbz	w23, 0x104aa852c <_Flutter_MMFoundation_BindContext+0xf84110>
104aa850c: 8b190280    	add	x0, x20, x25
104aa8510: 94c5fb1f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
104aa8514: aa0003f4    	mov	x20, x0
104aa8518: aa1503e1    	mov	x1, x21
104aa851c: aa1303e2    	mov	x2, x19
104aa8520: 94c5fb07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8524: aa1403e0    	mov	x0, x20
104aa8528: 94c5fb0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa852c: aa1303e0    	mov	x0, x19
104aa8530: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104aa8534: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104aa8538: a94257f6    	ldp	x22, x21, [sp, #0x20]
104aa853c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104aa8540: a8c567fa    	ldp	x26, x25, [sp], #0x50
104aa8544: 14c5fb04    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
