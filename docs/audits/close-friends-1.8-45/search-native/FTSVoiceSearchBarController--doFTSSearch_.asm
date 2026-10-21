
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101829d74: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101829d78: a9014ff4    	stp	x20, x19, [sp, #0x10]
101829d7c: a9027bfd    	stp	x29, x30, [sp, #0x20]
101829d80: 910083fd    	add	x29, sp, #0x20
101829d84: aa0203f3    	mov	x19, x2
101829d88: d00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101829d8c: f945e914    	ldr	x20, [x8, #0xbd0]
101829d90: f00f46a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101829d94: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
101829d98: aa0203e0    	mov	x0, x2
101829d9c: 958ff4e7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101829da0: aa1403e0    	mov	x0, x20
101829da4: aa1503e1    	mov	x1, x21
101829da8: 958ff4e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829dac: aa1d03fd    	mov	x29, x29
101829db0: 958ff4e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829db4: aa0003f4    	mov	x20, x0
101829db8: d00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101829dbc: f9477100    	ldr	x0, [x8, #0xee0]
101829dc0: d00f46a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101829dc4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101829dc8: 958ff4dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829dcc: aa0003e2    	mov	x2, x0
101829dd0: 900f3088    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101829dd4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101829dd8: aa1403e0    	mov	x0, x20
101829ddc: 958ff4d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829de0: aa1d03fd    	mov	x29, x29
101829de4: 958ff4d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101829de8: aa0003f5    	mov	x21, x0
101829dec: d00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
101829df0: f9458901    	ldr	x1, [x8, #0xb10] ; startSearchForHomePage:
101829df4: aa1303e2    	mov	x2, x19
101829df8: 958ff4d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101829dfc: aa1303e0    	mov	x0, x19
101829e00: 958ff4d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829e04: aa1503e0    	mov	x0, x21
101829e08: 958ff4d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101829e0c: aa1403e0    	mov	x0, x20
101829e10: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101829e14: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101829e18: a8c357f6    	ldp	x22, x21, [sp], #0x30
101829e1c: 158ff4ce    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
