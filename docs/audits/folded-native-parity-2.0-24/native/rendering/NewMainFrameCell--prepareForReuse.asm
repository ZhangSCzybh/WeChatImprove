
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1050fcea8: d100c3ff    	sub	sp, sp, #0x30
1050fceac: a9014ff4    	stp	x20, x19, [sp, #0x10]
1050fceb0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1050fceb4: 910083fd    	add	x29, sp, #0x20
1050fceb8: aa0003f3    	mov	x19, x0
1050fcebc: d00d8648    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
1050fcec0: f9405508    	ldr	x8, [x8, #0xa8] ; NewMainFrameCell
1050fcec4: a90023e0    	stp	x0, x8, [sp]
1050fcec8: d00d6a08    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1050fcecc: f9410d01    	ldr	x1, [x8, #0x218] ; prepareForReuse
1050fced0: 910003e0    	mov	x0, sp
1050fced4: 94aca89c    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1050fced8: f00d8028    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1050fcedc: f9469501    	ldr	x1, [x8, #0xd28] ; layer
1050fcee0: aa1303e0    	mov	x0, x19
1050fcee4: 94aca896    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fcee8: aa1d03fd    	mov	x29, x29
1050fceec: 94aca897    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1050fcef0: aa0003f3    	mov	x19, x0
1050fcef4: d00d8048    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1050fcef8: f9409501    	ldr	x1, [x8, #0x128] ; removeAnimationForKey:
1050fcefc: f00cb6a2    	adrp	x2, 0x11e7d3000 <dyld_stub_binder+0x11e7d3000>
1050fcf00: 910ca042    	add	x2, x2, #0x328 ; CFString 'BG_ANIMATION_KEY'
1050fcf04: 94aca88e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1050fcf08: aa1303e0    	mov	x0, x19
1050fcf0c: 94aca892    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1050fcf10: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1050fcf14: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1050fcf18: 9100c3ff    	add	sp, sp, #0x30
1050fcf1c: d65f03c0    	ret
