
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471ebb4: d100c3ff    	sub	sp, sp, #0x30
10471ebb8: a9014ff4    	stp	x20, x19, [sp, #0x10]
10471ebbc: a9027bfd    	stp	x29, x30, [sp, #0x20]
10471ebc0: 910083fd    	add	x29, sp, #0x20
10471ebc4: aa0003f3    	mov	x19, x0
10471ebc8: d00dd528    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
10471ebcc: f945fd08    	ldr	x8, [x8, #0xbf8]
10471ebd0: a90023e0    	stp	x0, x8, [sp]
10471ebd4: f00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471ebd8: f9458101    	ldr	x1, [x8, #0xb00] ; selector setItems:animated:
10471ebdc: 910003e0    	mov	x0, sp
10471ebe0: 94d42159    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10471ebe4: f00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471ebe8: f9458501    	ldr	x1, [x8, #0xb08] ; selector createTabBarItemViews
10471ebec: aa1303e0    	mov	x0, x19
10471ebf0: 94d42153    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ebf4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10471ebf8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10471ebfc: 9100c3ff    	add	sp, sp, #0x30
10471ec00: d65f03c0    	ret
