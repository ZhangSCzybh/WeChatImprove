
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e7cc04: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106e7cc08: a9014ff4    	stp	x20, x19, [sp, #0x10]
106e7cc0c: a9027bfd    	stp	x29, x30, [sp, #0x20]
106e7cc10: 910083fd    	add	x29, sp, #0x20
106e7cc14: aa0003f3    	mov	x19, x0
106e7cc18: f00c97a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e7cc1c: f9474d00    	ldr	x0, [x8, #0xe98]
106e7cc20: 9436a94e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106e7cc24: aa0003f4    	mov	x20, x0
106e7cc28: b00c9e48    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e7cc2c: b984dd15    	ldrsw	x21, [x8, #0x4dc]
106e7cc30: f8756a60    	ldr	x0, [x19, x21]
106e7cc34: f00c9468    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
106e7cc38: f947a501    	ldr	x1, [x8, #0xf48] ; width
106e7cc3c: 9436a940    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7cc40: 1e604002    	fmov	d2, d0
106e7cc44: 900c9468    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106e7cc48: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
106e7cc4c: d2e80d28    	mov	x8, #0x4069000000000000 ; =4641240890982006784
106e7cc50: 9e670103    	fmov	d3, x8
106e7cc54: 9e6703e0    	fmov	d0, xzr
106e7cc58: 9e6703e1    	fmov	d1, xzr
106e7cc5c: aa1403e0    	mov	x0, x20
106e7cc60: 9436a937    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7cc64: d00c8c08    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e7cc68: f940cd01    	ldr	x1, [x8, #0x198] ; _recreateMainViewsInTableHeaderView:
106e7cc6c: aa1303e0    	mov	x0, x19
106e7cc70: aa1403e2    	mov	x2, x20
106e7cc74: 9436a932    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7cc78: d00c8c08    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e7cc7c: f940d101    	ldr	x1, [x8, #0x1a0] ; _recreateExtensionViewsInTableHeaderView:
106e7cc80: aa1303e0    	mov	x0, x19
106e7cc84: aa1403e2    	mov	x2, x20
106e7cc88: 9436a92d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7cc8c: d00c8c08    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e7cc90: f940d501    	ldr	x1, [x8, #0x1a8] ; _layoutTableHeaderView:
106e7cc94: aa1303e0    	mov	x0, x19
106e7cc98: aa1403e2    	mov	x2, x20
106e7cc9c: 9436a928    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7cca0: f8756a60    	ldr	x0, [x19, x21]
106e7cca4: 900c7e08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e7cca8: f940d901    	ldr	x1, [x8, #0x1b0] ; setTableHeaderView:
106e7ccac: aa1403e2    	mov	x2, x20
106e7ccb0: 9436a923    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7ccb4: d00c8c08    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e7ccb8: f940d901    	ldr	x1, [x8, #0x1b0] ; _layoutSubviewsInTableHeaderView:
106e7ccbc: aa1303e0    	mov	x0, x19
106e7ccc0: aa1403e2    	mov	x2, x20
106e7ccc4: 9436a91e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e7ccc8: aa1403e0    	mov	x0, x20
106e7cccc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106e7ccd0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106e7ccd4: a8c357f6    	ldp	x22, x21, [sp], #0x30
106e7ccd8: 1436a91f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
