
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6ae1c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100f6ae20: a90157f6    	stp	x22, x21, [sp, #0x10]
100f6ae24: a9024ff4    	stp	x20, x19, [sp, #0x20]
100f6ae28: a9037bfd    	stp	x29, x30, [sp, #0x30]
100f6ae2c: 9100c3fd    	add	x29, sp, #0x30
100f6ae30: aa0003f7    	mov	x23, x0
100f6ae34: d00fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f6ae38: 52800035    	mov	w21, #0x1               ; =1
100f6ae3c: 39297d15    	strb	w21, [x8, #0xa5f]
100f6ae40: b00f9088    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100f6ae44: f9454900    	ldr	x0, [x8, #0xa90] ; �7 
100f6ae48: 900f8d08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100f6ae4c: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
100f6ae50: 95b2f0bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ae54: aa1d03fd    	mov	x29, x29
100f6ae58: 95b2f0bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6ae5c: aa0003f3    	mov	x19, x0
100f6ae60: f00f93e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f6ae64: b984f108    	ldrsw	x8, [x8, #0x4f0]
100f6ae68: f8686af4    	ldr	x20, [x23, x8]
100f6ae6c: 900f7708    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100f6ae70: f940b901    	ldr	x1, [x8, #0x170] ; splitPosition
100f6ae74: aa1703e0    	mov	x0, x23
100f6ae78: 95b2f0b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ae7c: aa0003f6    	mov	x22, x0
100f6ae80: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6ae84: f9414d01    	ldr	x1, [x8, #0x298] ; bubbleStyle
100f6ae88: aa1703e0    	mov	x0, x23
100f6ae8c: 95b2f0ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6ae90: aa0003f8    	mov	x24, x0
100f6ae94: b00f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6ae98: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
100f6ae9c: aa1703e0    	mov	x0, x23
100f6aea0: 95b2f0a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6aea4: 37000180    	tbnz	w0, #0x0, 0x100f6aed4 <__text+0xf62ed4>
100f6aea8: b00f93a8    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
100f6aeac: 910b0108    	add	x8, x8, #0x2c0
100f6aeb0: b9800108    	ldrsw	x8, [x8]
100f6aeb4: f8686ae0    	ldr	x0, [x23, x8]
100f6aeb8: b00f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6aebc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f6aec0: 95b2f09f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6aec4: 900f7708    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
100f6aec8: f9425101    	ldr	x1, [x8, #0x4a0] ; isPreViewMsg
100f6aecc: 95b2f09c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6aed0: aa0003f5    	mov	x21, x0
100f6aed4: f00f78c8    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
100f6aed8: f9415101    	ldr	x1, [x8, #0x2a0] ; bubbleInfoWithType:position:style:isSender:
100f6aedc: aa1303e0    	mov	x0, x19
100f6aee0: aa1403e2    	mov	x2, x20
100f6aee4: aa1603e3    	mov	x3, x22
100f6aee8: aa1803e4    	mov	x4, x24
100f6aeec: aa1503e5    	mov	x5, x21
100f6aef0: 95b2f093    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6aef4: aa1d03fd    	mov	x29, x29
100f6aef8: 95b2f094    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6aefc: aa0003f4    	mov	x20, x0
100f6af00: aa1303e0    	mov	x0, x19
100f6af04: 95b2f094    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6af08: aa1403e0    	mov	x0, x20
100f6af0c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100f6af10: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100f6af14: a94157f6    	ldp	x22, x21, [sp, #0x10]
100f6af18: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100f6af1c: 15b2f095    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>