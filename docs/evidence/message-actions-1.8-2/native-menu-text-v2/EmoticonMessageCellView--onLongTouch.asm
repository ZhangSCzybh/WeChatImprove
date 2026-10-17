
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10152ee9c: d10103ff    	sub	sp, sp, #0x40
10152eea0: a90157f6    	stp	x22, x21, [sp, #0x10]
10152eea4: a9024ff4    	stp	x20, x19, [sp, #0x20]
10152eea8: a9037bfd    	stp	x29, x30, [sp, #0x30]
10152eeac: 9100c3fd    	add	x29, sp, #0x30
10152eeb0: aa0003f3    	mov	x19, x0
10152eeb4: d00f6228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10152eeb8: f9453d14    	ldr	x20, [x8, #0xa78]
10152eebc: 900f4888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10152eec0: f9410901    	ldr	x1, [x8, #0x210] ; viewModel
10152eec4: 959be09e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152eec8: aa1d03fd    	mov	x29, x29
10152eecc: 959be09f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152eed0: aa0003f5    	mov	x21, x0
10152eed4: 900f4888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10152eed8: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
10152eedc: 959be098    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152eee0: aa1d03fd    	mov	x29, x29
10152eee4: 959be099    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10152eee8: aa0003f6    	mov	x22, x0
10152eeec: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152eef0: f9412101    	ldr	x1, [x8, #0x240] ; reportLongPressMessageMenuFromMessageWrap:
10152eef4: aa1403e0    	mov	x0, x20
10152eef8: aa1603e2    	mov	x2, x22
10152eefc: 959be090    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10152ef00: aa1603e0    	mov	x0, x22
10152ef04: 959be094    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152ef08: aa1503e0    	mov	x0, x21
10152ef0c: 959be092    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10152ef10: b00f6468    	adrp	x8, 0x1201bb000 <dyld_stub_binder+0x1201bb000>
10152ef14: f9431108    	ldr	x8, [x8, #0x620] ; �b- 
10152ef18: a90023f3    	stp	x19, x8, [sp]
10152ef1c: b00f4888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10152ef20: f9412501    	ldr	x1, [x8, #0x248] ; onLongTouch
10152ef24: 910003e0    	mov	x0, sp
10152ef28: 959be087    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10152ef2c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10152ef30: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10152ef34: a94157f6    	ldp	x22, x21, [sp, #0x10]
10152ef38: 910103ff    	add	sp, sp, #0x40
10152ef3c: d65f03c0    	ret