
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047271bc: d10143ff    	sub	sp, sp, #0x50
1047271c0: 6d012beb    	stp	d11, d10, [sp, #0x10]
1047271c4: 6d0223e9    	stp	d9, d8, [sp, #0x20]
1047271c8: a9034ff4    	stp	x20, x19, [sp, #0x30]
1047271cc: a9047bfd    	stp	x29, x30, [sp, #0x40]
1047271d0: 910103fd    	add	x29, sp, #0x40
1047271d4: 1e604068    	fmov	d8, d3
1047271d8: 1e604049    	fmov	d9, d2
1047271dc: 1e60402a    	fmov	d10, d1
1047271e0: 1e60400b    	fmov	d11, d0
1047271e4: aa0203f3    	mov	x19, x2
1047271e8: aa0003f4    	mov	x20, x0
1047271ec: aa0203e0    	mov	x0, x2
1047271f0: 94d3ffd2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047271f4: b00dd4e8    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
1047271f8: f9460d08    	ldr	x8, [x8, #0xc18]
1047271fc: a90023f4    	stp	x20, x8, [sp]
104727200: f00dcec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104727204: f947d901    	ldr	x1, [x8, #0xfb0] ; selector initWithFrame:
104727208: 910003e0    	mov	x0, sp
10472720c: 1e604160    	fmov	d0, d11
104727210: 1e604141    	fmov	d1, d10
104727214: 1e604122    	fmov	d2, d9
104727218: 1e604103    	fmov	d3, d8
10472721c: 94d3ffca    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104727220: aa0003f4    	mov	x20, x0
104727224: b40001c0    	cbz	x0, 0x10472725c <_Flutter_MMFoundation_BindContext+0xc02e40>
104727228: 900dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472722c: b98a0908    	ldrsw	x8, [x8, #0xa08]
104727230: 8b080280    	add	x0, x20, x8
104727234: aa1303e1    	mov	x1, x19
104727238: 94d3ffc2    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
10472723c: d00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104727240: f9466901    	ldr	x1, [x8, #0xcd0] ; selector preloadURLImages
104727244: aa1403e0    	mov	x0, x20
104727248: 94d3ffbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472724c: f00db8a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104727250: f940b501    	ldr	x1, [x8, #0x168] ; selector setupUI
104727254: aa1403e0    	mov	x0, x20
104727258: 94d3ffb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472725c: aa1303e0    	mov	x0, x19
104727260: 94d3ffbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104727264: aa1403e0    	mov	x0, x20
104727268: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10472726c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104727270: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
104727274: 6d412beb    	ldp	d11, d10, [sp, #0x10]
104727278: 910143ff    	add	sp, sp, #0x50
10472727c: d65f03c0    	ret
