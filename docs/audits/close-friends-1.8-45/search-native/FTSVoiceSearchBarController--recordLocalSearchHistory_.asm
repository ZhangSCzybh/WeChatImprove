
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182b7a0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10182b7a4: a9014ff4    	stp	x20, x19, [sp, #0x10]
10182b7a8: a9027bfd    	stp	x29, x30, [sp, #0x20]
10182b7ac: 910083fd    	add	x29, sp, #0x20
10182b7b0: aa0203f3    	mov	x19, x2
10182b7b4: aa0003f4    	mov	x20, x0
10182b7b8: 900f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182b7bc: f943e515    	ldr	x21, [x8, #0x7c8] ; searchIntentionController
10182b7c0: aa0203e0    	mov	x0, x2
10182b7c4: 958fee5d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10182b7c8: aa1403e0    	mov	x0, x20
10182b7cc: aa1503e1    	mov	x1, x21
10182b7d0: 958fee5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182b7d4: aa1d03fd    	mov	x29, x29
10182b7d8: 958fee5c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182b7dc: aa0003f4    	mov	x20, x0
10182b7e0: 900f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182b7e4: f945c501    	ldr	x1, [x8, #0xb88] ; addLocalSearchHistoryFor:
10182b7e8: aa1303e2    	mov	x2, x19
10182b7ec: 958fee54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182b7f0: aa1303e0    	mov	x0, x19
10182b7f4: 958fee58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182b7f8: aa1403e0    	mov	x0, x20
10182b7fc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10182b800: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10182b804: a8c357f6    	ldp	x22, x21, [sp], #0x30
10182b808: 158fee53    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
