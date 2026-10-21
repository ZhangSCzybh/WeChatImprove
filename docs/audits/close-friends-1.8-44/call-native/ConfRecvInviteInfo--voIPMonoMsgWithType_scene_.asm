
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100bdb980: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100bdb984: a9014ff4    	stp	x20, x19, [sp, #0x10]
100bdb988: a9027bfd    	stp	x29, x30, [sp, #0x20]
100bdb98c: 910083fd    	add	x29, sp, #0x20
100bdb990: aa0303f4    	mov	x20, x3
100bdb994: aa0203f6    	mov	x22, x2
100bdb998: aa0003f5    	mov	x21, x0
100bdb99c: 901002a8    	adrp	x8, 0x120c2f000 <dyld_stub_binder+0x120c2f000>
100bdb9a0: 52800029    	mov	w9, #0x1                ; =1
100bdb9a4: 39381909    	strb	w9, [x8, #0xe06]
100bdb9a8: f00face8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
100bdb9ac: f941e500    	ldr	x0, [x8, #0x3c8] ; 0[;
100bdb9b0: 95c12dea    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100bdb9b4: aa0003f3    	mov	x19, x0
100bdb9b8: 900facc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100bdb9bc: f9467900    	ldr	x0, [x8, #0xcf0]
100bdb9c0: b00f9308    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100bdb9c4: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
100bdb9c8: 95c12ddd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdb9cc: aa0003e2    	mov	x2, x0
100bdb9d0: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdb9d4: f942f501    	ldr	x1, [x8, #0x5e8] ; setM_receiveTime:
100bdb9d8: aa1303e0    	mov	x0, x19
100bdb9dc: 95c12dd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdb9e0: 95c0c2d8    	bl	0x107c0c540 <_Flutter_MMFoundation_BindContext+0x40e8124>
100bdb9e4: aa0003e2    	mov	x2, x0
100bdb9e8: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdb9ec: f942f901    	ldr	x1, [x8, #0x5f0] ; setRecvTime:
100bdb9f0: aa1303e0    	mov	x0, x19
100bdb9f4: 95c12dd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdb9f8: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdb9fc: f942fd01    	ldr	x1, [x8, #0x5f8] ; setM_msgType:
100bdba00: aa1303e0    	mov	x0, x19
100bdba04: aa1603e2    	mov	x2, x22
100bdba08: 95c12dcd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba0c: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdba10: f9429101    	ldr	x1, [x8, #0x520] ; roomType
100bdba14: aa1503e0    	mov	x0, x21
100bdba18: 95c12dc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba1c: 7100041f    	cmp	w0, #0x1
100bdba20: 1a9f07e2    	cset	w2, ne
100bdba24: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdba28: f9430101    	ldr	x1, [x8, #0x600] ; setM_mode:
100bdba2c: aa1303e0    	mov	x0, x19
100bdba30: 95c12dc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba34: f00f9388    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100bdba38: f9450516    	ldr	x22, [x8, #0xa08] ; roomid
100bdba3c: aa1503e0    	mov	x0, x21
100bdba40: aa1603e1    	mov	x1, x22
100bdba44: 95c12dbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba48: aa0003e2    	mov	x2, x0
100bdba4c: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdba50: f9430501    	ldr	x1, [x8, #0x608] ; setM_roomId:
100bdba54: aa1303e0    	mov	x0, x19
100bdba58: 95c12db9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba5c: aa1503e0    	mov	x0, x21
100bdba60: aa1603e1    	mov	x1, x22
100bdba64: 95c12db6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba68: aa0003e2    	mov	x2, x0
100bdba6c: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdba70: f9430901    	ldr	x1, [x8, #0x610] ; setM_roomKey:
100bdba74: aa1303e0    	mov	x0, x19
100bdba78: 95c12db1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba7c: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdba80: f9430d01    	ldr	x1, [x8, #0x618] ; callerUsername
100bdba84: aa1503e0    	mov	x0, x21
100bdba88: 95c12dad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdba8c: aa1d03fd    	mov	x29, x29
100bdba90: 95c12dae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100bdba94: aa0003f5    	mov	x21, x0
100bdba98: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdba9c: f9431101    	ldr	x1, [x8, #0x620] ; setM_fromUser:
100bdbaa0: aa1303e0    	mov	x0, x19
100bdbaa4: aa1503e2    	mov	x2, x21
100bdbaa8: 95c12da5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdbaac: aa1503e0    	mov	x0, x21
100bdbab0: 95c12da9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100bdbab4: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdbab8: f9431501    	ldr	x1, [x8, #0x628] ; setM_fromScene:
100bdbabc: aa1303e0    	mov	x0, x19
100bdbac0: aa1403e2    	mov	x2, x20
100bdbac4: 95c12d9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdbac8: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdbacc: f9431901    	ldr	x1, [x8, #0x630] ; setM_fromAnswered:
100bdbad0: aa1303e0    	mov	x0, x19
100bdbad4: 52800002    	mov	w2, #0x0                ; =0
100bdbad8: 95c12d99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdbadc: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdbae0: f9431d01    	ldr	x1, [x8, #0x638] ; setHasHolded:
100bdbae4: aa1303e0    	mov	x0, x19
100bdbae8: 52800022    	mov	w2, #0x1                ; =1
100bdbaec: 95c12d94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdbaf0: d00f94c8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
100bdbaf4: f9432101    	ldr	x1, [x8, #0x640] ; setIsFromIlink:
100bdbaf8: aa1303e0    	mov	x0, x19
100bdbafc: 52800022    	mov	w2, #0x1                ; =1
100bdbb00: 95c12d8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100bdbb04: aa1303e0    	mov	x0, x19
100bdbb08: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100bdbb0c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100bdbb10: a8c357f6    	ldp	x22, x21, [sp], #0x30
100bdbb14: 15c12d97    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
