
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628d990: 6db733ed    	stp	d13, d12, [sp, #-0x90]!
10628d994: 6d012beb    	stp	d11, d10, [sp, #0x10]
10628d998: 6d0223e9    	stp	d9, d8, [sp, #0x20]
10628d99c: a9036ffc    	stp	x28, x27, [sp, #0x30]
10628d9a0: a90467fa    	stp	x26, x25, [sp, #0x40]
10628d9a4: a9055ff8    	stp	x24, x23, [sp, #0x50]
10628d9a8: a90657f6    	stp	x22, x21, [sp, #0x60]
10628d9ac: a9074ff4    	stp	x20, x19, [sp, #0x70]
10628d9b0: a9087bfd    	stp	x29, x30, [sp, #0x80]
10628d9b4: 910203fd    	add	x29, sp, #0x80
10628d9b8: aa0003f3    	mov	x19, x0
10628d9bc: d00d4da8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10628d9c0: 52800029    	mov	w9, #0x1                ; =1
10628d9c4: 3928ed09    	strb	w9, [x8, #0xa3b]
10628d9c8: 900ce7c8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
10628d9cc: f9423101    	ldr	x1, [x8, #0x460] ; voiceTimeLength
10628d9d0: 946665db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628d9d4: 1e604008    	fmov	d8, d0
10628d9d8: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628d9dc: f947ed01    	ldr	x1, [x8, #0xfd8] ; displayTextSize
10628d9e0: aa1303e0    	mov	x0, x19
10628d9e4: 946665d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628d9e8: 1e604009    	fmov	d9, d0
10628d9ec: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628d9f0: f9403d1b    	ldr	x27, [x8, #0x78] ; 8�6 
10628d9f4: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628d9f8: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628d9fc: f00cf388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10628da00: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
10628da04: aa1403e1    	mov	x1, x20
10628da08: 946665cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628da0c: aa1d03fd    	mov	x29, x29
10628da10: 946665ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628da14: aa0003fc    	mov	x28, x0
10628da18: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628da1c: f9404100    	ldr	x0, [x8, #0x80]
10628da20: d00cf388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10628da24: f947ad15    	ldr	x21, [x8, #0xf58] ; class
10628da28: aa1503e1    	mov	x1, x21
10628da2c: 946665c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628da30: aa0003e2    	mov	x2, x0
10628da34: 900cdd68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10628da38: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
10628da3c: aa1c03e0    	mov	x0, x28
10628da40: aa1603e1    	mov	x1, x22
10628da44: 946665be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628da48: aa1d03fd    	mov	x29, x29
10628da4c: 946665bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628da50: aa0003f8    	mov	x24, x0
10628da54: d00cdd68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10628da58: f947fd17    	ldr	x23, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10628da5c: b00c10c2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628da60: 91242042    	add	x2, x2, #0x908
10628da64: b00c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628da68: 9124a063    	add	x3, x3, #0x928
10628da6c: aa1703e1    	mov	x1, x23
10628da70: 946665b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628da74: aa1d03fd    	mov	x29, x29
10628da78: 946665b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628da7c: aa0003f9    	mov	x25, x0
10628da80: f00cdd68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10628da84: f940011a    	ldr	x26, [x8]
10628da88: aa1b03e0    	mov	x0, x27
10628da8c: aa1a03e1    	mov	x1, x26
10628da90: aa1903e2    	mov	x2, x25
10628da94: 946665aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628da98: 1e60400a    	fmov	d10, d0
10628da9c: aa1903e0    	mov	x0, x25
10628daa0: 946665ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628daa4: aa1803e0    	mov	x0, x24
10628daa8: 946665ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628daac: aa1c03e0    	mov	x0, x28
10628dab0: 946665a9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dab4: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628dab8: f9465d01    	ldr	x1, [x8, #0xcb8] ; dialectFeedbackShowing
10628dabc: aa1303e0    	mov	x0, x19
10628dac0: 9466659f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dac4: aa0003f8    	mov	x24, x0
10628dac8: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628dacc: f9450100    	ldr	x0, [x8, #0xa00] ; 0�7 
10628dad0: f00cdfa8    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
10628dad4: f946c901    	ldr	x1, [x8, #0xd90] ; getTextMessageNodeWidth:
10628dad8: aa1303e2    	mov	x2, x19
10628dadc: 94666598    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dae0: 1e60400b    	fmov	d11, d0
10628dae4: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628dae8: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
10628daec: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628daf0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628daf4: aa1403e1    	mov	x1, x20
10628daf8: 94666591    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dafc: aa1d03fd    	mov	x29, x29
10628db00: 94666592    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628db04: aa0003f4    	mov	x20, x0
10628db08: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628db0c: f9404100    	ldr	x0, [x8, #0x80]
10628db10: aa1503e1    	mov	x1, x21
10628db14: 9466658a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628db18: aa0003e2    	mov	x2, x0
10628db1c: aa1403e0    	mov	x0, x20
10628db20: aa1603e1    	mov	x1, x22
10628db24: 94666586    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628db28: aa1d03fd    	mov	x29, x29
10628db2c: 94666587    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628db30: aa0003f5    	mov	x21, x0
10628db34: aa1703e1    	mov	x1, x23
10628db38: b00c10c2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628db3c: 91242042    	add	x2, x2, #0x908
10628db40: b00c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628db44: 9124a063    	add	x3, x3, #0x928
10628db48: 9466657d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628db4c: aa1d03fd    	mov	x29, x29
10628db50: 9466657e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628db54: aa0003f6    	mov	x22, x0
10628db58: aa1303e0    	mov	x0, x19
10628db5c: aa1a03e1    	mov	x1, x26
10628db60: aa1603e2    	mov	x2, x22
10628db64: 94666576    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628db68: 1e60100c    	fmov	d12, #2.00000000
10628db6c: 1f4c2c00    	fmadd	d0, d0, d12, d11
10628db70: 1e773001    	fmov	d1, #-25.00000000
10628db74: 1e612801    	fadd	d1, d0, d1
10628db78: 7100031f    	cmp	w24, #0x0
10628db7c: 1e601c2b    	fcsel	d11, d1, d0, ne
10628db80: aa1603e0    	mov	x0, x22
10628db84: 94666574    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628db88: aa1503e0    	mov	x0, x21
10628db8c: 94666572    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628db90: aa1403e0    	mov	x0, x20
10628db94: 94666570    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628db98: 1f4c2540    	fmadd	d0, d10, d12, d9
10628db9c: 1e602100    	fcmp	d8, d0
10628dba0: 1e684c00    	fcsel	d0, d0, d8, mi
10628dba4: 1e6b2000    	fcmp	d0, d11
10628dba8: 1e6b4c00    	fcsel	d0, d0, d11, mi
10628dbac: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10628dbb0: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10628dbb4: a94657f6    	ldp	x22, x21, [sp, #0x60]
10628dbb8: a9455ff8    	ldp	x24, x23, [sp, #0x50]
10628dbbc: a94467fa    	ldp	x26, x25, [sp, #0x40]
10628dbc0: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10628dbc4: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
10628dbc8: 6d412beb    	ldp	d11, d10, [sp, #0x10]
10628dbcc: 6cc933ed    	ldp	d13, d12, [sp], #0x90
10628dbd0: d65f03c0    	ret