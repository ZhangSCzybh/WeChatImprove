
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1063a3e30: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1063a3e34: a9014ff4    	stp	x20, x19, [sp, #0x10]
1063a3e38: a9027bfd    	stp	x29, x30, [sp, #0x20]
1063a3e3c: 910083fd    	add	x29, sp, #0x20
1063a3e40: aa0003f3    	mov	x19, x0
1063a3e44: f00ce188    	adrp	x8, 0x11ffd6000 <dyld_stub_binder+0x11ffd6000>
1063a3e48: f9470114    	ldr	x20, [x8, #0xe00] ; selector=m_videoVoipCallerViewController
1063a3e4c: aa1403e1    	mov	x1, x20
1063a3e50: 94620cbb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1063a3e54: aa1d03fd    	mov	x29, x29
1063a3e58: 94620cbc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1063a3e5c: aa0003f5    	mov	x21, x0
1063a3e60: f00ce148    	adrp	x8, 0x11ffce000 <dyld_stub_binder+0x11ffce000>
1063a3e64: f9465d01    	ldr	x1, [x8, #0xcb8] ; selector=setDisableToPlayRecentStatusSound:
1063a3e68: 52800022    	mov	w2, #0x1                ; =1
1063a3e6c: 94620cb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1063a3e70: aa1503e0    	mov	x0, x21
1063a3e74: 94620cb8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1063a3e78: aa1303e0    	mov	x0, x19
1063a3e7c: aa1403e1    	mov	x1, x20
1063a3e80: 94620caf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1063a3e84: aa1d03fd    	mov	x29, x29
1063a3e88: 94620cb0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1063a3e8c: aa0003f3    	mov	x19, x0
1063a3e90: f00ce148    	adrp	x8, 0x11ffce000 <dyld_stub_binder+0x11ffce000>
1063a3e94: f9470d01    	ldr	x1, [x8, #0xe18] ; selector=refreshRecentStatusAudioSession
1063a3e98: 94620ca9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1063a3e9c: aa1303e0    	mov	x0, x19
1063a3ea0: 94620cad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1063a3ea4: d00cefa8    	adrp	x8, 0x120199000 <dyld_stub_binder+0x120199000>
1063a3ea8: f9405500    	ldr	x0, [x8, #0xa8] ; class=VoIPEventStatistics
1063a3eac: f00ce148    	adrp	x8, 0x11ffce000 <dyld_stub_binder+0x11ffce000>
1063a3eb0: f947cd01    	ldr	x1, [x8, #0xf98] ; selector=statWithType:
1063a3eb4: 528000c2    	mov	w2, #0x6                ; =6
1063a3eb8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1063a3ebc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1063a3ec0: a8c357f6    	ldp	x22, x21, [sp], #0x30
1063a3ec4: 14620c9e    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
