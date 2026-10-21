
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10577b304: d10183ff    	sub	sp, sp, #0x60
10577b308: a90167fa    	stp	x26, x25, [sp, #0x10]
10577b30c: a9025ff8    	stp	x24, x23, [sp, #0x20]
10577b310: a90357f6    	stp	x22, x21, [sp, #0x30]
10577b314: a9044ff4    	stp	x20, x19, [sp, #0x40]
10577b318: a9057bfd    	stp	x29, x30, [sp, #0x50]
10577b31c: 910143fd    	add	x29, sp, #0x50
10577b320: d00da628    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
10577b324: 52800029    	mov	w9, #0x1                ; =1
10577b328: 390c6909    	strb	w9, [x8, #0x31a]
10577b32c: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b330: b98cfd19    	ldrsw	x25, [x8, #0xcfc]
10577b334: 38796808    	ldrb	w8, [x0, x25]
10577b338: 37000ca8    	tbnz	w8, #0x0, 0x10577b4cc <_Flutter_MMFoundation_BindContext+0x1c570b0>
10577b33c: aa0003f3    	mov	x19, x0
10577b340: b00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577b344: f9421501    	ldr	x1, [x8, #0x428] ; GetCountOfSendMessage
10577b348: 9492af7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b34c: b40009e0    	cbz	x0, 0x10577b488 <_Flutter_MMFoundation_BindContext+0x1c5706c>
10577b350: f00d5008    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
10577b354: f9467500    	ldr	x0, [x8, #0xce8]
10577b358: 9492af80    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10577b35c: aa0003f4    	mov	x20, x0
10577b360: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b364: f9479900    	ldr	x0, [x8, #0xf30]
10577b368: 9492af7c    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10577b36c: aa0003f5    	mov	x21, x0
10577b370: 900d3608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10577b374: f9446501    	ldr	x1, [x8, #0x8c8] ; setM_pbRequest:
10577b378: aa1403e2    	mov	x2, x20
10577b37c: 9492af70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b380: 900d3608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10577b384: f9446901    	ldr	x1, [x8, #0x8d0] ; setM_uiCgi:
10577b388: aa1503e0    	mov	x0, x21
10577b38c: 52804142    	mov	w2, #0x20a              ; =522
10577b390: 9492af6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b394: f00d50c8    	adrp	x8, 0x120196000 <dyld_stub_binder+0x120196000>
10577b398: f943b900    	ldr	x0, [x8, #0x770] ; pw9
10577b39c: 900d4c28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10577b3a0: f947ad16    	ldr	x22, [x8, #0xf58] ; class
10577b3a4: aa1603e1    	mov	x1, x22
10577b3a8: 9492af65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b3ac: aa0003e2    	mov	x2, x0
10577b3b0: 900d3868    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
10577b3b4: f9414501    	ldr	x1, [x8, #0x288] ; setM_eventHandlerClass:
10577b3b8: aa1503e0    	mov	x0, x21
10577b3bc: 9492af60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b3c0: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b3c4: f945e900    	ldr	x0, [x8, #0xbd0]
10577b3c8: b00d4c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10577b3cc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10577b3d0: 9492af5b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b3d4: aa1d03fd    	mov	x29, x29
10577b3d8: 9492af5c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b3dc: aa0003f7    	mov	x23, x0
10577b3e0: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b3e4: f9479d00    	ldr	x0, [x8, #0xf38]
10577b3e8: aa1603e1    	mov	x1, x22
10577b3ec: 9492af54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b3f0: aa0003e2    	mov	x2, x0
10577b3f4: d00d35e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10577b3f8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10577b3fc: aa1703e0    	mov	x0, x23
10577b400: 9492af4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b404: aa1d03fd    	mov	x29, x29
10577b408: 9492af50    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b40c: aa0003f8    	mov	x24, x0
10577b410: 900d3608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10577b414: f9446d01    	ldr	x1, [x8, #0x8d8] ; CreateProtobufEvent:Flag:
10577b418: aa1503e2    	mov	x2, x21
10577b41c: 528000a3    	mov	w3, #0x5                ; =5
10577b420: 9492af47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b424: aa0003f6    	mov	x22, x0
10577b428: aa1803e0    	mov	x0, x24
10577b42c: 9492af4a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b430: aa1703e0    	mov	x0, x23
10577b434: 9492af48    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b438: 34000156    	cbz	w22, 0x10577b460 <_Flutter_MMFoundation_BindContext+0x1c57044>
10577b43c: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b440: f9464900    	ldr	x0, [x8, #0xc90]
10577b444: 900d3608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10577b448: f9447101    	ldr	x1, [x8, #0x8e0] ; addPBEventObserverListItem:andValue:
10577b44c: aa1603e2    	mov	x2, x22
10577b450: aa1303e3    	mov	x3, x19
10577b454: 9492af3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b458: 52800028    	mov	w8, #0x1                ; =1
10577b45c: 38396a68    	strb	w8, [x19, x25]
10577b460: aa1503e0    	mov	x0, x21
10577b464: 9492af3c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b468: aa1403e0    	mov	x0, x20
10577b46c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10577b470: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10577b474: a94357f6    	ldp	x22, x21, [sp, #0x30]
10577b478: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10577b47c: a94167fa    	ldp	x26, x25, [sp, #0x10]
10577b480: 910183ff    	add	sp, sp, #0x60
10577b484: 1492af34    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b488: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b48c: f9453500    	ldr	x0, [x8, #0xa68]
10577b490: d00d35e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10577b494: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10577b498: b00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577b49c: 9138a108    	add	x8, x8, #0xe28
10577b4a0: f90003e8    	str	x8, [sp]
10577b4a4: d00ad543    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
10577b4a8: 9107f063    	add	x3, x3, #0x1fc
10577b4ac: d00b0b25    	adrp	x5, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577b4b0: 910cf0a5    	add	x5, x5, #0x33c
10577b4b4: d00b0b27    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577b4b8: 9115cce7    	add	x7, x7, #0x573
10577b4bc: 52800042    	mov	w2, #0x2                ; =2
10577b4c0: 52800004    	mov	w4, #0x0                ; =0
10577b4c4: 528027a6    	mov	w6, #0x13d              ; =317
10577b4c8: 9492af1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b4cc: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10577b4d0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10577b4d4: a94357f6    	ldp	x22, x21, [sp, #0x30]
10577b4d8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10577b4dc: a94167fa    	ldp	x26, x25, [sp, #0x10]
10577b4e0: 910183ff    	add	sp, sp, #0x60
10577b4e4: d65f03c0    	ret
