
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6ff6c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104a6ff70: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a6ff74: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a6ff78: 910083fd    	add	x29, sp, #0x20
104a6ff7c: aa0203f3    	mov	x19, x2
104a6ff80: aa0003f4    	mov	x20, x0
104a6ff84: aa0203e0    	mov	x0, x2
104a6ff88: 94c6dc6c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a6ff8c: f9401a94    	ldr	x20, [x20, #0x30]
104a6ff90: b00d9ea8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a6ff94: f947d901    	ldr	x1, [x8, #0xfb0] ; selector m_nsUserName
104a6ff98: aa1303e0    	mov	x0, x19
104a6ff9c: 94c6dc68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ffa0: aa1d03fd    	mov	x29, x29
104a6ffa4: 94c6dc69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6ffa8: aa0003f5    	mov	x21, x0
104a6ffac: b00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6ffb0: f9424d01    	ldr	x1, [x8, #0x498] ; selector containsObject:
104a6ffb4: aa1403e0    	mov	x0, x20
104a6ffb8: aa1503e2    	mov	x2, x21
104a6ffbc: 94c6dc60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ffc0: aa0003f4    	mov	x20, x0
104a6ffc4: aa1503e0    	mov	x0, x21
104a6ffc8: 94c6dc63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ffcc: 36000074    	tbz	w20, #0x0, 0x104a6ffd8 <_Flutter_MMFoundation_BindContext+0xf4bbbc>
104a6ffd0: 52800034    	mov	w20, #0x1               ; =1
104a6ffd4: 1400000e    	b	0x104a7000c <_Flutter_MMFoundation_BindContext+0xf4bbf0>
104a6ffd8: d00d9ea8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a6ffdc: f9413501    	ldr	x1, [x8, #0x268] ; selector m_bShowUnReadAsRedDot
104a6ffe0: aa1303e0    	mov	x0, x19
104a6ffe4: 94c6dc56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ffe8: 36000060    	tbz	w0, #0x0, 0x104a6fff4 <_Flutter_MMFoundation_BindContext+0xf4bbd8>
104a6ffec: 52800014    	mov	w20, #0x0               ; =0
104a6fff0: 14000007    	b	0x104a7000c <_Flutter_MMFoundation_BindContext+0xf4bbf0>
104a6fff4: d00d9e68    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a6fff8: f942e501    	ldr	x1, [x8, #0x5c8] ; selector m_uUnReadCount
104a6fffc: aa1303e0    	mov	x0, x19
104a70000: 94c6dc4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a70004: 7100001f    	cmp	w0, #0x0
104a70008: 1a9f07f4    	cset	w20, ne
104a7000c: aa1303e0    	mov	x0, x19
104a70010: 94c6dc51    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a70014: aa1403e0    	mov	x0, x20
104a70018: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a7001c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a70020: a8c357f6    	ldp	x22, x21, [sp], #0x30
104a70024: d65f03c0    	ret
