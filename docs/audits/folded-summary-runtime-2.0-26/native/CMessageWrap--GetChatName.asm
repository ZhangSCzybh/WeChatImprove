
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba3d3c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104ba3d40: a9014ff4    	stp	x20, x19, [sp, #0x10]
104ba3d44: a9027bfd    	stp	x29, x30, [sp, #0x20]
104ba3d48: 910083fd    	add	x29, sp, #0x20
104ba3d4c: aa0003f3    	mov	x19, x0
104ba3d50: f00e04c8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ba3d54: 52800029    	mov	w9, #0x1                ; =1
104ba3d58: 391a7109    	strb	w9, [x8, #0x69c]
104ba3d5c: 900d9548    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104ba3d60: f9433914    	ldr	x20, [x8, #0x670]
104ba3d64: aa1403e1    	mov	x1, x20
104ba3d68: 94c20cf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3d6c: aa1d03fd    	mov	x29, x29
104ba3d70: 94c20cf6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba3d74: aa0003f5    	mov	x21, x0
104ba3d78: 900dab08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ba3d7c: f946e901    	ldr	x1, [x8, #0xdd0]
104ba3d80: 94c20cef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3d84: aa0003f6    	mov	x22, x0
104ba3d88: aa1503e0    	mov	x0, x21
104ba3d8c: 94c20cf2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba3d90: b4000116    	cbz	x22, 0x104ba3db0 <_Flutter_MMFoundation_BindContext+0x107f994>
104ba3d94: aa1303e0    	mov	x0, x19
104ba3d98: aa1403e1    	mov	x1, x20
104ba3d9c: 94c20ce8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3da0: aa1d03fd    	mov	x29, x29
104ba3da4: 94c20ce9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba3da8: aa0003f4    	mov	x20, x0
104ba3dac: 14000022    	b	0x104ba3e34 <_Flutter_MMFoundation_BindContext+0x107fa18>
104ba3db0: b00dae88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104ba3db4: f9411d00    	ldr	x0, [x8, #0x238]
104ba3db8: d00d94c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba3dbc: f9478d01    	ldr	x1, [x8, #0xf18]
104ba3dc0: aa1303e2    	mov	x2, x19
104ba3dc4: 94c20cde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3dc8: 900d94e8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104ba3dcc: 9106c108    	add	x8, x8, #0x1b0
104ba3dd0: d00d94c9    	adrp	x9, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba3dd4: 9114e129    	add	x9, x9, #0x538
104ba3dd8: 7100001f    	cmp	w0, #0x0
104ba3ddc: 9a891108    	csel	x8, x8, x9, ne
104ba3de0: f9400101    	ldr	x1, [x8]
104ba3de4: aa1303e0    	mov	x0, x19
104ba3de8: 94c20cd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3dec: aa1d03fd    	mov	x29, x29
104ba3df0: 94c20cd6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba3df4: aa0003f4    	mov	x20, x0
104ba3df8: 900d9508    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104ba3dfc: f9459d01    	ldr	x1, [x8, #0xb38]
104ba3e00: aa1303e0    	mov	x0, x19
104ba3e04: 94c20cce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3e08: 34000160    	cbz	w0, 0x104ba3e34 <_Flutter_MMFoundation_BindContext+0x107fa18>
104ba3e0c: 900d9508    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104ba3e10: f945d101    	ldr	x1, [x8, #0xba0]
104ba3e14: aa1303e0    	mov	x0, x19
104ba3e18: 94c20cc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba3e1c: aa1d03fd    	mov	x29, x29
104ba3e20: 94c20cca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba3e24: aa0003f3    	mov	x19, x0
104ba3e28: aa1403e0    	mov	x0, x20
104ba3e2c: 94c20cca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba3e30: aa1303f4    	mov	x20, x19
104ba3e34: aa1403e0    	mov	x0, x20
104ba3e38: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ba3e3c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ba3e40: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ba3e44: 14c20ccb    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
