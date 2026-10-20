
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0ebcc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105c0ebd0: a9014ff4    	stp	x20, x19, [sp, #0x10]
105c0ebd4: a9027bfd    	stp	x29, x30, [sp, #0x20]
105c0ebd8: 910083fd    	add	x29, sp, #0x20
105c0ebdc: aa0003f3    	mov	x19, x0
105c0ebe0: 900d81a8    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c0ebe4: 52800029    	mov	w9, #0x1                ; =1
105c0ebe8: 39101109    	strb	w9, [x8, #0x404]
105c0ebec: f00d1d68    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c0ebf0: f9478d01    	ldr	x1, [x8, #0xf18] ; canShowTranslateView
105c0ebf4: 94806152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ebf8: 34000700    	cbz	w0, 0x105c0ecd8 <_Flutter_MMFoundation_BindContext+0x20ea8bc>
105c0ebfc: b00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0ec00: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c0ec04: d00d2788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c0ec08: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105c0ec0c: 9480614c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ec10: aa1d03fd    	mov	x29, x29
105c0ec14: 9480614d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0ec18: aa0003f4    	mov	x20, x0
105c0ec1c: f00d2b28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105c0ec20: f942fd00    	ldr	x0, [x8, #0x5f8] ; ��: 
105c0ec24: b00d2788    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105c0ec28: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105c0ec2c: 94806144    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ec30: aa0003e2    	mov	x2, x0
105c0ec34: f00d1148    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c0ec38: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105c0ec3c: aa1403e0    	mov	x0, x20
105c0ec40: 9480613f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ec44: aa1d03fd    	mov	x29, x29
105c0ec48: 94806140    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0ec4c: aa0003f5    	mov	x21, x0
105c0ec50: b00d2e88    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
105c0ec54: 910b0108    	add	x8, x8, #0x2c0
105c0ec58: b9800108    	ldrsw	x8, [x8]
105c0ec5c: f8686a62    	ldr	x2, [x19, x8]
105c0ec60: d00d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c0ec64: f942a501    	ldr	x1, [x8, #0x548] ; getTranslateInfo:
105c0ec68: 94806135    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ec6c: aa1d03fd    	mov	x29, x29
105c0ec70: 94806136    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0ec74: aa0003f3    	mov	x19, x0
105c0ec78: aa1503e0    	mov	x0, x21
105c0ec7c: 94806136    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ec80: aa1403e0    	mov	x0, x20
105c0ec84: 94806134    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ec88: d00d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c0ec8c: f942b101    	ldr	x1, [x8, #0x560] ; translatedText
105c0ec90: aa1303e0    	mov	x0, x19
105c0ec94: 9480612a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ec98: aa1d03fd    	mov	x29, x29
105c0ec9c: 9480612b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0eca0: aa0003f4    	mov	x20, x0
105c0eca4: b00d27a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105c0eca8: f946e901    	ldr	x1, [x8, #0xdd0] ; length
105c0ecac: 94806124    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ecb0: aa0003f5    	mov	x21, x0
105c0ecb4: aa1403e0    	mov	x0, x20
105c0ecb8: 94806127    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ecbc: b4000135    	cbz	x21, 0x105c0ece0 <_Flutter_MMFoundation_BindContext+0x20ea8c4>
105c0ecc0: 900d1d88    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c0ecc4: f9419d01    	ldr	x1, [x8, #0x338] ; isTranslating
105c0ecc8: aa1303e0    	mov	x0, x19
105c0eccc: 9480611c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ecd0: 52000014    	eor	w20, w0, #0x1
105c0ecd4: 14000004    	b	0x105c0ece4 <_Flutter_MMFoundation_BindContext+0x20ea8c8>
105c0ecd8: 52800014    	mov	w20, #0x0               ; =0
105c0ecdc: 14000004    	b	0x105c0ecec <_Flutter_MMFoundation_BindContext+0x20ea8d0>
105c0ece0: 52800014    	mov	w20, #0x0               ; =0
105c0ece4: aa1303e0    	mov	x0, x19
105c0ece8: 9480611b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ecec: aa1403e0    	mov	x0, x20
105c0ecf0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105c0ecf4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105c0ecf8: a8c357f6    	ldp	x22, x21, [sp], #0x30
105c0ecfc: d65f03c0    	ret