
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff8d78: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104ff8d7c: a9014ff4    	stp	x20, x19, [sp, #0x10]
104ff8d80: a9027bfd    	stp	x29, x30, [sp, #0x20]
104ff8d84: 910083fd    	add	x29, sp, #0x20
104ff8d88: aa0203e0    	mov	x0, x2
104ff8d8c: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8d90: f9478901    	ldr	x1, [x8, #0xf10] ; referAction
104ff8d94: 94b0b8ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8d98: aa1d03fd    	mov	x29, x29
104ff8d9c: 94b0b8eb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8da0: aa0003f3    	mov	x19, x0
104ff8da4: f00d7628    	adrp	x8, 0x11febf000 <dyld_stub_binder+0x11febf000>
104ff8da8: f9408101    	ldr	x1, [x8, #0x100] ; fromUsername
104ff8dac: 94b0b8e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8db0: aa1d03fd    	mov	x29, x29
104ff8db4: 94b0b8e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8db8: aa0003f4    	mov	x20, x0
104ff8dbc: aa1303e0    	mov	x0, x19
104ff8dc0: 94b0b8e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8dc4: f00d8bc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ff8dc8: f9471100    	ldr	x0, [x8, #0xe20]
104ff8dcc: b00d7228    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ff8dd0: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
104ff8dd4: 94b0b8da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8dd8: aa1d03fd    	mov	x29, x29
104ff8ddc: 94b0b8db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8de0: aa0003f3    	mov	x19, x0
104ff8de4: f00d8848    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ff8de8: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
104ff8dec: aa1403e0    	mov	x0, x20
104ff8df0: aa1303e2    	mov	x2, x19
104ff8df4: 94b0b8d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8df8: aa0003f5    	mov	x21, x0
104ff8dfc: aa1303e0    	mov	x0, x19
104ff8e00: 94b0b8d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8e04: aa1403e0    	mov	x0, x20
104ff8e08: 94b0b8d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8e0c: aa1503e0    	mov	x0, x21
104ff8e10: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ff8e14: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ff8e18: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ff8e1c: d65f03c0    	ret
