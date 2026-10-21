
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017676d8: d100c3ff    	sub	sp, sp, #0x30
1017676dc: a9014ff4    	stp	x20, x19, [sp, #0x10]
1017676e0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1017676e4: 910083fd    	add	x29, sp, #0x20
1017676e8: aa0003f3    	mov	x19, x0
1017676ec: 900f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017676f0: f9453500    	ldr	x0, [x8, #0xa68]
1017676f4: d00f3688    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1017676f8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1017676fc: 900e7168    	adrp	x8, 0x11e593000 <dyld_stub_binder+0x11e593000>
101767700: 91102108    	add	x8, x8, #0x408
101767704: f90003e8    	str	x8, [sp]
101767708: b00ce363    	adrp	x3, 0x11b3d4000 <dyld_stub_binder+0x11b3d4000>
10176770c: 91212063    	add	x3, x3, #0x848
101767710: 900ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101767714: 911b74a5    	add	x5, x5, #0x6dd
101767718: b00ce3e7    	adrp	x7, 0x11b3e4000 <dyld_stub_binder+0x11b3e4000>
10176771c: 911874e7    	add	x7, x7, #0x61d
101767720: 52800042    	mov	w2, #0x2                ; =2
101767724: 52800004    	mov	w4, #0x0                ; =0
101767728: 5280a366    	mov	w6, #0x51b              ; =1307
10176772c: 9592fe84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767730: 900f36a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101767734: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
101767738: aa1303e0    	mov	x0, x19
10176773c: 9592fe80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767740: aa1d03fd    	mov	x29, x29
101767744: 9592fe81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101767748: aa0003f3    	mov	x19, x0
10176774c: 900f3928    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
101767750: f9427101    	ldr	x1, [x8, #0x4e0] ; inputBoxResignFirstResponder
101767754: 9592fe7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101767758: aa1303e0    	mov	x0, x19
10176775c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101767760: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101767764: 9100c3ff    	add	sp, sp, #0x30
101767768: 1592fe7b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
