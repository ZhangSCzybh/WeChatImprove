
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4ae28: 6db82beb    	stp	d11, d10, [sp, #-0x80]!
100e4ae2c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
100e4ae30: a9026ffc    	stp	x28, x27, [sp, #0x20]
100e4ae34: a90367fa    	stp	x26, x25, [sp, #0x30]
100e4ae38: a9045ff8    	stp	x24, x23, [sp, #0x40]
100e4ae3c: a90557f6    	stp	x22, x21, [sp, #0x50]
100e4ae40: a9064ff4    	stp	x20, x19, [sp, #0x60]
100e4ae44: a9077bfd    	stp	x29, x30, [sp, #0x70]
100e4ae48: 9101c3fd    	add	x29, sp, #0x70
100e4ae4c: aa0303f5    	mov	x21, x3
100e4ae50: aa0203f3    	mov	x19, x2
100e4ae54: d00fef28    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e4ae58: 52800029    	mov	w9, #0x1                ; =1
100e4ae5c: 3918a109    	strb	w9, [x8, #0x628]
100e4ae60: d00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4ae64: f9477514    	ldr	x20, [x8, #0xee8] ; dequeueReusableCellWithIdentifier:
100e4ae68: aa0303e0    	mov	x0, x3
100e4ae6c: 95b770b3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4ae70: aa1303e0    	mov	x0, x19
100e4ae74: 95b770b1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e4ae78: 900eb742    	adrp	x2, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e4ae7c: 9129a042    	add	x2, x2, #0xa68
100e4ae80: aa1403e1    	mov	x1, x20
100e4ae84: 95b770ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4ae88: aa1d03fd    	mov	x29, x29
100e4ae8c: 95b770af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4ae90: aa0003f4    	mov	x20, x0
100e4ae94: b5000160    	cbnz	x0, 0x100e4aec0 <__text+0xe42ec0>
100e4ae98: b00f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4ae9c: f9421100    	ldr	x0, [x8, #0x420] ; PR8
100e4aea0: 95b770b0    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100e4aea4: f00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4aea8: f9463501    	ldr	x1, [x8, #0xc68] ; initWithStyle:reuseIdentifier:
100e4aeac: 900eb743    	adrp	x3, 0x11e532000 <dyld_stub_binder+0x11e532000>
100e4aeb0: 9129a063    	add	x3, x3, #0xa68
100e4aeb4: d2800002    	mov	x2, #0x0                ; =0
100e4aeb8: 95b770a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4aebc: aa0003f4    	mov	x20, x0
100e4aec0: b00f995c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
100e4aec4: f945eb80    	ldr	x0, [x28, #0xbd0]
100e4aec8: d00f95a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e4aecc: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
100e4aed0: aa1603e1    	mov	x1, x22
100e4aed4: 95b7709a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4aed8: aa1d03fd    	mov	x29, x29
100e4aedc: 95b7709b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4aee0: aa0003f7    	mov	x23, x0
100e4aee4: b00f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4aee8: f9420500    	ldr	x0, [x8, #0x408]
100e4aeec: b00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e4aef0: f947ad18    	ldr	x24, [x8, #0xf58] ; class
100e4aef4: aa1803e1    	mov	x1, x24
100e4aef8: 95b77091    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4aefc: aa0003e2    	mov	x2, x0
100e4af00: f00f7f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e4af04: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
100e4af08: aa1703e0    	mov	x0, x23
100e4af0c: aa1903e1    	mov	x1, x25
100e4af10: 95b7708b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4af14: aa1d03fd    	mov	x29, x29
100e4af18: 95b7708c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4af1c: aa0003fa    	mov	x26, x0
100e4af20: 900f95e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100e4af24: f9440901    	ldr	x1, [x8, #0x810] ; row
100e4af28: aa1503e0    	mov	x0, x21
100e4af2c: 95b77084    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4af30: aa0003fb    	mov	x27, x0
100e4af34: aa1503e0    	mov	x0, x21
100e4af38: 95b77087    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4af3c: d00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4af40: f943e901    	ldr	x1, [x8, #0x7d0] ; getSessionAtIndex:
100e4af44: aa1a03e0    	mov	x0, x26
100e4af48: aa1b03e2    	mov	x2, x27
100e4af4c: 95b7707c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4af50: aa1d03fd    	mov	x29, x29
100e4af54: 95b7707d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4af58: aa0003f5    	mov	x21, x0
100e4af5c: aa1a03e0    	mov	x0, x26
100e4af60: 95b7707d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4af64: aa1703e0    	mov	x0, x23
100e4af68: 95b7707b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4af6c: f945eb80    	ldr	x0, [x28, #0xbd0]
100e4af70: aa1603e1    	mov	x1, x22
100e4af74: 95b77072    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4af78: aa1d03fd    	mov	x29, x29
100e4af7c: 95b77073    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4af80: aa0003f6    	mov	x22, x0
100e4af84: b00f9988    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100e4af88: f9420100    	ldr	x0, [x8, #0x400]
100e4af8c: aa1803e1    	mov	x1, x24
100e4af90: 95b7706b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4af94: aa0003e2    	mov	x2, x0
100e4af98: aa1603e0    	mov	x0, x22
100e4af9c: aa1903e1    	mov	x1, x25
100e4afa0: 95b77067    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4afa4: aa1d03fd    	mov	x29, x29
100e4afa8: 95b77068    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4afac: aa0003f7    	mov	x23, x0
100e4afb0: d00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4afb4: f943ed01    	ldr	x1, [x8, #0x7d8] ; getCellData:
100e4afb8: aa1503e2    	mov	x2, x21
100e4afbc: 95b77060    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4afc0: aa1d03fd    	mov	x29, x29
100e4afc4: 95b77061    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4afc8: aa0003f8    	mov	x24, x0
100e4afcc: aa1703e0    	mov	x0, x23
100e4afd0: 95b77061    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4afd4: aa1603e0    	mov	x0, x22
100e4afd8: 95b7705f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4afdc: f00f95a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100e4afe0: f945a101    	ldr	x1, [x8, #0xb40] ; frame
100e4afe4: aa1303e0    	mov	x0, x19
100e4afe8: 95b77055    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4afec: 1e604008    	fmov	d8, d0
100e4aff0: 1e604029    	fmov	d9, d1
100e4aff4: 1e60404a    	fmov	d10, d2
100e4aff8: 1e60406b    	fmov	d11, d3
100e4affc: aa1303e0    	mov	x0, x19
100e4b000: 95b77055    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b004: b00f81a8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e4b008: f943f101    	ldr	x1, [x8, #0x7e0] ; updateContentView:tableViewFrame:
100e4b00c: aa1403e0    	mov	x0, x20
100e4b010: aa1803e2    	mov	x2, x24
100e4b014: 1e604100    	fmov	d0, d8
100e4b018: 1e604121    	fmov	d1, d9
100e4b01c: 1e604142    	fmov	d2, d10
100e4b020: 1e604163    	fmov	d3, d11
100e4b024: 95b77046    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4b028: aa1803e0    	mov	x0, x24
100e4b02c: 95b7704a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b030: aa1503e0    	mov	x0, x21
100e4b034: 95b77048    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4b038: aa1403e0    	mov	x0, x20
100e4b03c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100e4b040: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100e4b044: a94557f6    	ldp	x22, x21, [sp, #0x50]
100e4b048: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100e4b04c: a94367fa    	ldp	x26, x25, [sp, #0x30]
100e4b050: a9426ffc    	ldp	x28, x27, [sp, #0x20]
100e4b054: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
100e4b058: 6cc82beb    	ldp	d11, d10, [sp], #0x80
100e4b05c: 15b77045    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
