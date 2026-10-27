
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105753f7c: d100c3ff    	sub	sp, sp, #0x30
105753f80: a9014ff4    	stp	x20, x19, [sp, #0x10]
105753f84: a9027bfd    	stp	x29, x30, [sp, #0x20]
105753f88: 910083fd    	add	x29, sp, #0x20
105753f8c: aa0003f3    	mov	x19, x0
105753f90: 900d53a8    	adrp	x8, 0x1201c7000 <dyld_stub_binder+0x1201c7000>
105753f94: f9412908    	ldr	x8, [x8, #0x250] ; @u9
105753f98: a90023e0    	stp	x0, x8, [sp]
105753f9c: b00d3748    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105753fa0: f941a901    	ldr	x1, [x8, #0x350] ; viewDidLoad
105753fa4: 910003e0    	mov	x0, sp
105753fa8: 94934c67    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105753fac: 900d42e8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
105753fb0: f9476d01    	ldr	x1, [x8, #0xed8] ; calculateExistCount
105753fb4: aa1303e0    	mov	x0, x19
105753fb8: 94934c61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105753fbc: f00d4d68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105753fc0: f9468101    	ldr	x1, [x8, #0xd00] ; initData
105753fc4: aa1303e0    	mov	x0, x19
105753fc8: 94934c5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105753fcc: b00d3748    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105753fd0: f941b101    	ldr	x1, [x8, #0x360] ; initView
105753fd4: aa1303e0    	mov	x0, x19
105753fd8: 94934c59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105753fdc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105753fe0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105753fe4: 9100c3ff    	add	sp, sp, #0x30
105753fe8: d65f03c0    	ret
