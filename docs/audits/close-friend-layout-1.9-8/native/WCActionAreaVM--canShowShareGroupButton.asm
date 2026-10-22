
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1067fbb9c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1067fbba0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1067fbba4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1067fbba8: 910083fd    	add	x29, sp, #0x20
1067fbbac: aa0003f3    	mov	x19, x0
1067fbbb0: 900cc828    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1067fbbb4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1067fbbb8: 9450ad61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fbbbc: aa0003f4    	mov	x20, x0
1067fbbc0: d00cb208    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1067fbbc4: f943c101    	ldr	x1, [x8, #0x780] ; dataItem
1067fbbc8: aa1303e0    	mov	x0, x19
1067fbbcc: 9450ad5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fbbd0: aa1d03fd    	mov	x29, x29
1067fbbd4: 9450ad5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1067fbbd8: aa0003f5    	mov	x21, x0
1067fbbdc: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fbbe0: f9429101    	ldr	x1, [x8, #0x520] ; isDynamicTagEnabled
1067fbbe4: aa1303e0    	mov	x0, x19
1067fbbe8: 9450ad55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fbbec: aa0003e3    	mov	x3, x0
1067fbbf0: d00cbf48    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067fbbf4: f9429501    	ldr	x1, [x8, #0x528] ; canShowShareGroupButtonWithDataItem:isDynamicTagEnabled:
1067fbbf8: aa1403e0    	mov	x0, x20
1067fbbfc: aa1503e2    	mov	x2, x21
1067fbc00: 9450ad4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067fbc04: aa0003f3    	mov	x19, x0
1067fbc08: aa1503e0    	mov	x0, x21
1067fbc0c: 9450ad52    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067fbc10: aa1303e0    	mov	x0, x19
1067fbc14: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1067fbc18: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1067fbc1c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1067fbc20: d65f03c0    	ret
