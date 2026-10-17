
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c49968: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101c4996c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101c49970: a9027bfd    	stp	x29, x30, [sp, #0x20]
101c49974: 910083fd    	add	x29, sp, #0x20
101c49978: aa0203f3    	mov	x19, x2
101c4997c: aa0003f4    	mov	x20, x0
101c49980: b00f1368    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
101c49984: f9404d15    	ldr	x21, [x8, #0x98] ; GetDisplayContent
101c49988: aa0203e0    	mov	x0, x2
101c4998c: 957f75eb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c49990: aa1303e0    	mov	x0, x19
101c49994: aa1503e1    	mov	x1, x21
101c49998: 957f75e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4999c: aa1d03fd    	mov	x29, x29
101c499a0: 957f75ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c499a4: aa0003f5    	mov	x21, x0
101c499a8: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c499ac: f9423d01    	ldr	x1, [x8, #0x478] ; GenTextMsgWithContent:
101c499b0: aa1403e0    	mov	x0, x20
101c499b4: aa1503e2    	mov	x2, x21
101c499b8: 957f75e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c499bc: aa1d03fd    	mov	x29, x29
101c499c0: 957f75e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c499c4: aa0003f4    	mov	x20, x0
101c499c8: aa1503e0    	mov	x0, x21
101c499cc: 957f75e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c499d0: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c499d4: f9418101    	ldr	x1, [x8, #0x300] ; m_ignoreSoftBank
101c499d8: aa1303e0    	mov	x0, x19
101c499dc: 957f75d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c499e0: aa0003e2    	mov	x2, x0
101c499e4: d00f1008    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c499e8: f9424101    	ldr	x1, [x8, #0x480] ; setM_ignoreSoftBank:
101c499ec: aa1403e0    	mov	x0, x20
101c499f0: 957f75d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c499f4: b00f1008    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
101c499f8: f947fd01    	ldr	x1, [x8, #0xff8] ; m_weappSourceUsername
101c499fc: aa1303e0    	mov	x0, x19
101c49a00: 957f75cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49a04: aa1d03fd    	mov	x29, x29
101c49a08: 957f75d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c49a0c: aa0003f5    	mov	x21, x0
101c49a10: aa1303e0    	mov	x0, x19
101c49a14: 957f75d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c49a18: 900f13a8    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c49a1c: f941b501    	ldr	x1, [x8, #0x368] ; setM_weappSourceUsername:
101c49a20: aa1403e0    	mov	x0, x20
101c49a24: aa1503e2    	mov	x2, x21
101c49a28: 957f75c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49a2c: aa1503e0    	mov	x0, x21
101c49a30: 957f75c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c49a34: d00f1008    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c49a38: f941b101    	ldr	x1, [x8, #0x360] ; UpdateMsgSource
101c49a3c: aa1403e0    	mov	x0, x20
101c49a40: 957f75bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c49a44: aa1403e0    	mov	x0, x20
101c49a48: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101c49a4c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101c49a50: a8c357f6    	ldp	x22, x21, [sp], #0x30
101c49a54: 157f75c7    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>