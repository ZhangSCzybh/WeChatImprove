
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1000c7e48: d10103ff    	sub	sp, sp, #0x40
1000c7e4c: a90157f6    	stp	x22, x21, [sp, #0x10]
1000c7e50: a9024ff4    	stp	x20, x19, [sp, #0x20]
1000c7e54: a9037bfd    	stp	x29, x30, [sp, #0x30]
1000c7e58: 9100c3fd    	add	x29, sp, #0x30
1000c7e5c: aa0003f3    	mov	x19, x0
1000c7e60: b0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c7e64: f9453d14    	ldr	x20, [x8, #0xa78]
1000c7e68: f00feba8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000c7e6c: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
1000c7e70: 95ed7cb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7e74: aa1d03fd    	mov	x29, x29
1000c7e78: 95ed7cb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c7e7c: aa0003f5    	mov	x21, x0
1000c7e80: f00feba8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000c7e84: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
1000c7e88: 95ed7cad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7e8c: aa1d03fd    	mov	x29, x29
1000c7e90: 95ed7cae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c7e94: aa0003f6    	mov	x22, x0
1000c7e98: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c7e9c: f9412101    	ldr	x1, [x8, #0x240] ; reportLongPressMessageMenuFromMessageWrap:
1000c7ea0: aa1403e0    	mov	x0, x20
1000c7ea4: aa1603e2    	mov	x2, x22
1000c7ea8: 95ed7ca5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7eac: aa1603e0    	mov	x0, x22
1000c7eb0: 95ed7ca9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c7eb4: aa1503e0    	mov	x0, x21
1000c7eb8: 95ed7ca7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c7ebc: b0100788    	adrp	x8, 0x1201b8000 <dyld_stub_binder+0x1201b8000>
1000c7ec0: f9408908    	ldr	x8, [x8, #0x110] ; ��)
1000c7ec4: a90023f3    	stp	x19, x8, [sp]
1000c7ec8: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c7ecc: f9412501    	ldr	x1, [x8, #0x248] ; onLongTouch
1000c7ed0: 910003e0    	mov	x0, sp
1000c7ed4: 95ed7c9c    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1000c7ed8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1000c7edc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1000c7ee0: a94157f6    	ldp	x22, x21, [sp, #0x10]
1000c7ee4: 910103ff    	add	sp, sp, #0x40
1000c7ee8: d65f03c0    	ret
