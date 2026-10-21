
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101ecd588: d100c3ff    	sub	sp, sp, #0x30
101ecd58c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101ecd590: a9027bfd    	stp	x29, x30, [sp, #0x20]
101ecd594: 910083fd    	add	x29, sp, #0x20
101ecd598: aa0003f3    	mov	x19, x0
101ecd59c: 900f1788    	adrp	x8, 0x1201bd000 <dyld_stub_binder+0x1201bd000>
101ecd5a0: f9402508    	ldr	x8, [x8, #0x48] ;  "/
101ecd5a4: a90023e0    	stp	x0, x8, [sp]
101ecd5a8: f00efb68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101ecd5ac: f941a901    	ldr	x1, [x8, #0x350] ; viewDidLoad
101ecd5b0: 910003e0    	mov	x0, sp
101ecd5b4: 957566e4    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
101ecd5b8: b00f11a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
101ecd5bc: f9468101    	ldr	x1, [x8, #0xd00] ; initData
101ecd5c0: aa1303e0    	mov	x0, x19
101ecd5c4: 957566de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd5c8: f00efb68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101ecd5cc: f941b101    	ldr	x1, [x8, #0x360] ; initView
101ecd5d0: aa1303e0    	mov	x0, x19
101ecd5d4: 957566da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd5d8: d00f1528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101ecd5dc: f9470100    	ldr	x0, [x8, #0xe00]
101ecd5e0: f00efb68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101ecd5e4: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
101ecd5e8: aa1303e2    	mov	x2, x19
101ecd5ec: 957566d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101ecd5f0: d00f1948    	adrp	x8, 0x1201f7000 <dyld_stub_binder+0x1201f7000>
101ecd5f4: b987c508    	ldrsw	x8, [x8, #0x7c4]
101ecd5f8: fc286a60    	str	d0, [x19, x8]
101ecd5fc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101ecd600: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101ecd604: 9100c3ff    	add	sp, sp, #0x30
101ecd608: d65f03c0    	ret
