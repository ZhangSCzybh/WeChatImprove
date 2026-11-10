
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fe06f4: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100fe06f8: a90157f6    	stp	x22, x21, [sp, #0x10]
100fe06fc: a9024ff4    	stp	x20, x19, [sp, #0x20]
100fe0700: a9037bfd    	stp	x29, x30, [sp, #0x30]
100fe0704: 9100c3fd    	add	x29, sp, #0x30
100fe0708: aa0003f3    	mov	x19, x0
100fe070c: f00f3b08    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fe0710: 52800029    	mov	w9, #0x1                ; =1
100fe0714: 3922d509    	strb	w9, [x8, #0x8b5]
100fe0718: f00ecf68    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
100fe071c: f9410114    	ldr	x20, [x8, #0x200]
100fe0720: aa1403e1    	mov	x1, x20
100fe0724: 95b11d50    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0728: aa1d03fd    	mov	x29, x29
100fe072c: 95b11d55    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe0730: aa0003f5    	mov	x21, x0
100fe0734: b00ee9a8    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
100fe0738: f9447900    	ldr	x0, [x8, #0x8f0]
100fe073c: d00ee628    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fe0740: f9428501    	ldr	x1, [x8, #0x508]
100fe0744: 95b11d48    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0748: aa0003e2    	mov	x2, x0
100fe074c: 900ee648    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100fe0750: f9444901    	ldr	x1, [x8, #0x890]
100fe0754: aa1503e0    	mov	x0, x21
100fe0758: 95b11d43    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe075c: aa0003f6    	mov	x22, x0
100fe0760: aa1503e0    	mov	x0, x21
100fe0764: 95b11d43    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe0768: 34000876    	cbz	w22, 0x100fe0874 <__text+0xfd8874>
100fe076c: aa1303e0    	mov	x0, x19
100fe0770: aa1403e1    	mov	x1, x20
100fe0774: 95b11d3c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0778: aa1d03fd    	mov	x29, x29
100fe077c: 95b11d41    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe0780: aa0003f4    	mov	x20, x0
100fe0784: b40000c0    	cbz	x0, 0x100fe079c <__text+0xfd879c>
100fe0788: d00ecfc8    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
100fe078c: f945b101    	ldr	x1, [x8, #0xb60]
100fe0790: aa1403e0    	mov	x0, x20
100fe0794: 95b11d34    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0798: 37000620    	tbnz	w0, #0x0, 0x100fe085c <__text+0xfd885c>
100fe079c: b00ecf88    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
100fe07a0: f9436d15    	ldr	x21, [x8, #0x6d8]
100fe07a4: aa1303e0    	mov	x0, x19
100fe07a8: aa1503e1    	mov	x1, x21
100fe07ac: 95b11d2e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe07b0: aa1403e0    	mov	x0, x20
100fe07b4: aa1503e1    	mov	x1, x21
100fe07b8: 95b11d2b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe07bc: b00ecf88    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
100fe07c0: f9436901    	ldr	x1, [x8, #0x6d0]
100fe07c4: aa1303e0    	mov	x0, x19
100fe07c8: 95b11d27    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe07cc: d00ee988    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fe07d0: f9444d15    	ldr	x21, [x8, #0x898]
100fe07d4: d00ee628    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fe07d8: f9469d16    	ldr	x22, [x8, #0xd38]
100fe07dc: aa1303e0    	mov	x0, x19
100fe07e0: aa1603e1    	mov	x1, x22
100fe07e4: 95b11d20    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe07e8: aa1d03fd    	mov	x29, x29
100fe07ec: 95b11d25    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe07f0: aa0003f7    	mov	x23, x0
100fe07f4: 900ed1c8    	adrp	x8, 0x11ea18000 <dyld_stub_binder+0x11ea18000>
100fe07f8: f9439518    	ldr	x24, [x8, #0x728]
100fe07fc: b00ecf48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fe0800: f9476101    	ldr	x1, [x8, #0xec0]
100fe0804: aa1503e0    	mov	x0, x21
100fe0808: aa1703e2    	mov	x2, x23
100fe080c: aa1803e3    	mov	x3, x24
100fe0810: aa1403e4    	mov	x4, x20
100fe0814: 95b11d14    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0818: aa1703e0    	mov	x0, x23
100fe081c: 95b11d15    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe0820: aa1303e0    	mov	x0, x19
100fe0824: aa1603e1    	mov	x1, x22
100fe0828: 95b11d0f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe082c: aa1d03fd    	mov	x29, x29
100fe0830: 95b11d14    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fe0834: aa0003f3    	mov	x19, x0
100fe0838: b00ecf48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fe083c: f9476501    	ldr	x1, [x8, #0xec8]
100fe0840: f00b4728    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100fe0844: fd455100    	ldr	d0, [x8, #0xaa0]
100fe0848: aa1803e2    	mov	x2, x24
100fe084c: aa1403e3    	mov	x3, x20
100fe0850: 95b11d05    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fe0854: aa1303e0    	mov	x0, x19
100fe0858: 95b11d06    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe085c: aa1403e0    	mov	x0, x20
100fe0860: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100fe0864: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100fe0868: a94157f6    	ldp	x22, x21, [sp, #0x10]
100fe086c: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100fe0870: 15b11d00    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fe0874: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100fe0878: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100fe087c: a94157f6    	ldp	x22, x21, [sp, #0x10]
100fe0880: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100fe0884: d65f03c0    	ret
