
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105aea920: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105aea924: a9014ff4    	stp	x20, x19, [sp, #0x10]
105aea928: a9027bfd    	stp	x29, x30, [sp, #0x20]
105aea92c: 910083fd    	add	x29, sp, #0x20
105aea930: aa0003f3    	mov	x19, x0
105aea934: d00ce348    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
105aea938: 52800029    	mov	w9, #0x1                ; =1
105aea93c: 39335109    	strb	w9, [x8, #0xcd4]
105aea940: d00c7a48    	adrp	x8, 0x11ea34000 <dyld_stub_binder+0x11ea34000>
105aea944: f9427101    	ldr	x1, [x8, #0x4e0] ; selector: endMultiSelect
105aea948: 9484f4c7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea94c: f00c9728    	adrp	x8, 0x11edd1000 <dyld_stub_binder+0x11edd1000>
105aea950: b984b508    	ldrsw	x8, [x8, #0x4b4] ; ivar: SessionSelectController.m_selectView offset=304
105aea954: f8686a60    	ldr	x0, [x19, x8]
105aea958: d00c8328    	adrp	x8, 0x11eb50000 <dyld_stub_binder+0x11eb50000>
105aea95c: f9443d01    	ldr	x1, [x8, #0x878] ; selector: getForwardParams
105aea960: 9484f4c1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea964: aa1d03fd    	mov	x29, x29
105aea968: 9484f4c6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105aea96c: aa0003f3    	mov	x19, x0
105aea970: 900c9148    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105aea974: f9431900    	ldr	x0, [x8, #0x630]
105aea978: 900c8de8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105aea97c: f947d501    	ldr	x1, [x8, #0xfa8] ; selector: dictionaryWithDictionary:
105aea980: aa1303e2    	mov	x2, x19
105aea984: 9484f4b8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea988: aa1d03fd    	mov	x29, x29
105aea98c: 9484f4bd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105aea990: aa0003f4    	mov	x20, x0
105aea994: f00c76e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105aea998: f941a901    	ldr	x1, [x8, #0x350] ; selector: safeSetObject:forKey:
105aea99c: f00bc242    	adrp	x2, 0x11d335000 <dyld_stub_binder+0x11d335000>
105aea9a0: 91016042    	add	x2, x2, #0x58 ; CFString: forward_multi_next_btn
105aea9a4: f00ba5a3    	adrp	x3, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
105aea9a8: 9112e063    	add	x3, x3, #0x4b8 ; CFString: view_id
105aea9ac: 9484f4ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea9b0: 900c9148    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105aea9b4: f943c100    	ldr	x0, [x8, #0x780]
105aea9b8: f00c76e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105aea9bc: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
105aea9c0: 9484f4a9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea9c4: aa1d03fd    	mov	x29, x29
105aea9c8: 9484f4ae    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105aea9cc: aa0003f5    	mov	x21, x0
105aea9d0: 900c9148    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105aea9d4: f9460900    	ldr	x0, [x8, #0xc10]
105aea9d8: 900c8de8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105aea9dc: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
105aea9e0: 9484f4a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea9e4: aa0003e2    	mov	x2, x0
105aea9e8: f00c76e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105aea9ec: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
105aea9f0: aa1503e0    	mov	x0, x21
105aea9f4: 9484f49c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aea9f8: aa1d03fd    	mov	x29, x29
105aea9fc: 9484f4a1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105aeaa00: aa0003f6    	mov	x22, x0
105aeaa04: d00c7708    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
105aeaa08: f9428d01    	ldr	x1, [x8, #0x518] ; selector: reportCustomEvent:params:routeRule:
105aeaa0c: f00ba5a2    	adrp	x2, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
105aeaa10: 91126042    	add	x2, x2, #0x498 ; CFString: view_clk
105aeaa14: aa1403e3    	mov	x3, x20
105aeaa18: 528fca24    	mov	w4, #0x7e51             ; =32337
105aeaa1c: 9484f492    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105aeaa20: aa1603e0    	mov	x0, x22
105aeaa24: 9484f493    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105aeaa28: aa1503e0    	mov	x0, x21
105aeaa2c: 9484f491    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105aeaa30: aa1403e0    	mov	x0, x20
105aeaa34: 9484f48f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105aeaa38: aa1303e0    	mov	x0, x19
105aeaa3c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105aeaa40: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105aeaa44: a8c357f6    	ldp	x22, x21, [sp], #0x30
105aeaa48: 1484f48a    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
