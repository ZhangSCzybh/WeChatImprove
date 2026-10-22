
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1067f8f14: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1067f8f18: a9017bfd    	stp	x29, x30, [sp, #0x10]
1067f8f1c: 910043fd    	add	x29, sp, #0x10
1067f8f20: aa0003f3    	mov	x19, x0
1067f8f24: b00cc888    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1067f8f28: f940f901    	ldr	x1, [x8, #0x1f0] ; setParams:
1067f8f2c: 9450b884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8f30: b00cbf68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8f34: f9422101    	ldr	x1, [x8, #0x440] ; setupActionAreaElements
1067f8f38: aa1303e0    	mov	x0, x19
1067f8f3c: 9450b880    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8f40: b00cbf68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8f44: f9422501    	ldr	x1, [x8, #0x448] ; canDisplayForOneLine
1067f8f48: aa1303e0    	mov	x0, x19
1067f8f4c: 9450b87c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8f50: b00cbf68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8f54: 91114108    	add	x8, x8, #0x450
1067f8f58: b00cbf69    	adrp	x9, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8f5c: 91116129    	add	x9, x9, #0x458
1067f8f60: 7100001f    	cmp	w0, #0x0
1067f8f64: 9a891108    	csel	x8, x8, x9, ne
1067f8f68: f9400101    	ldr	x1, [x8]
1067f8f6c: aa1303e0    	mov	x0, x19
1067f8f70: 9450b873    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8f74: b00cbf68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8f78: f9423101    	ldr	x1, [x8, #0x460] ; createElementsRowInfo
1067f8f7c: aa1303e0    	mov	x0, x19
1067f8f80: 9450b86f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8f84: aa1d03fd    	mov	x29, x29
1067f8f88: 9450b870    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067f8f8c: aa0003f4    	mov	x20, x0
1067f8f90: b00cbf68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8f94: f9423501    	ldr	x1, [x8, #0x468] ; setElementsRowInfo:
1067f8f98: aa1303e0    	mov	x0, x19
1067f8f9c: aa1403e2    	mov	x2, x20
1067f8fa0: 9450b867    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8fa4: aa1403e0    	mov	x0, x20
1067f8fa8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1067f8fac: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1067f8fb0: 1450b869    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
