
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104baaad0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104baaad4: a9014ff4    	stp	x20, x19, [sp, #0x10]
104baaad8: a9027bfd    	stp	x29, x30, [sp, #0x20]
104baaadc: 910083fd    	add	x29, sp, #0x20
104baaae0: aa0303f5    	mov	x21, x3
104baaae4: aa0203f3    	mov	x19, x2
104baaae8: aa0003f6    	mov	x22, x0
104baaaec: 900e04a8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104baaaf0: 52800029    	mov	w9, #0x1                ; =1
104baaaf4: 391ae509    	strb	w9, [x8, #0x6b9]
104baaaf8: aa0203e0    	mov	x0, x2
104baaafc: 94c1f18f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104baab00: f00d95a8    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104baab04: f944cd01    	ldr	x1, [x8, #0x998] ; IsHDImg
104baab08: aa1303e0    	mov	x0, x19
104baab0c: 94c1f18c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baab10: 34000460    	cbz	w0, 0x104baab9c <_Flutter_MMFoundation_BindContext+0x1086780>
104baab14: d00dae48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104baab18: f9411d00    	ldr	x0, [x8, #0x238] ; CMessageWrap
104baab1c: b00d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104baab20: f9471901    	ldr	x1, [x8, #0xe30] ; getMsgHDImgData:
104baab24: aa1303e2    	mov	x2, x19
104baab28: 94c1f185    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baab2c: aa1d03fd    	mov	x29, x29
104baab30: 94c1f186    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104baab34: b4000340    	cbz	x0, 0x104baab9c <_Flutter_MMFoundation_BindContext+0x1086780>
104baab38: aa0003f4    	mov	x20, x0
104baab3c: 37000255    	tbnz	w21, #0x0, 0x104baab84 <_Flutter_MMFoundation_BindContext+0x1086768>
104baab40: b00dae55    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104baab44: f9467aa0    	ldr	x0, [x21, #0xcf0] ; CUtility
104baab48: d00d97a8    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
104baab4c: f947c501    	ldr	x1, [x8, #0xf88] ; imageTypeForImageData:
104baab50: aa1403e2    	mov	x2, x20
104baab54: 94c1f17a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baab58: f100101f    	cmp	x0, #0x4
104baab5c: 54000141    	b.ne	0x104baab84 <_Flutter_MMFoundation_BindContext+0x1086768>
104baab60: f9467aa0    	ldr	x0, [x21, #0xcf0] ; CUtility
104baab64: b00d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104baab68: f9471d01    	ldr	x1, [x8, #0xe38] ; convertHeifDataToJpg:
104baab6c: aa1403e2    	mov	x2, x20
104baab70: 94c1f173    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baab74: aa1d03fd    	mov	x29, x29
104baab78: 94c1f174    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104baab7c: aa0003f5    	mov	x21, x0
104baab80: b5000080    	cbnz	x0, 0x104baab90 <_Flutter_MMFoundation_BindContext+0x1086774>
104baab84: aa1403e0    	mov	x0, x20
104baab88: 94c1f16c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104baab8c: aa1403f5    	mov	x21, x20
104baab90: aa1403e0    	mov	x0, x20
104baab94: 94c1f170    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104baab98: 1400000a    	b	0x104baabc0 <_Flutter_MMFoundation_BindContext+0x10867a4>
104baab9c: b00d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104baaba0: f9472101    	ldr	x1, [x8, #0xe40] ; getMsgMiddleImgData:canUseHeif:
104baaba4: aa1603e0    	mov	x0, x22
104baaba8: aa1303e2    	mov	x2, x19
104baabac: aa1503e3    	mov	x3, x21
104baabb0: 94c1f163    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104baabb4: aa1d03fd    	mov	x29, x29
104baabb8: 94c1f164    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104baabbc: aa0003f5    	mov	x21, x0
104baabc0: aa1303e0    	mov	x0, x19
104baabc4: 94c1f164    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104baabc8: aa1503e0    	mov	x0, x21
104baabcc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104baabd0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104baabd4: a8c357f6    	ldp	x22, x21, [sp], #0x30
104baabd8: 14c1f166    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
