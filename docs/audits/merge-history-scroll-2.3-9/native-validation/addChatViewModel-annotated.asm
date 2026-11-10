
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10032a888: 6dba23e9    	stp	d9, d8, [sp, #-0x60]!
10032a88c: a90167fa    	stp	x26, x25, [sp, #0x10]
10032a890: a9025ff8    	stp	x24, x23, [sp, #0x20]
10032a894: a90357f6    	stp	x22, x21, [sp, #0x30]
10032a898: a9044ff4    	stp	x20, x19, [sp, #0x40]
10032a89c: a9057bfd    	stp	x29, x30, [sp, #0x50]
10032a8a0: 910143fd    	add	x29, sp, #0x50
10032a8a4: aa0303f5    	mov	x21, x3
10032a8a8: aa0203f3    	mov	x19, x2
10032a8ac: aa0003f4    	mov	x20, x0
10032a8b0: d00fa0a8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10032a8b4: 52800029    	mov	w9, #0x1                ; =1
10032a8b8: 392a8909    	strb	w9, [x8, #0xaa2]
10032a8bc: aa0203e0    	mov	x0, x2
10032a8c0: 95e3f4ed    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10032a8c4: 900f4be8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10032a8c8: f9469d01    	ldr	x1, [x8, #0xd38] ; selector: delegate
10032a8cc: aa1303e0    	mov	x0, x19
10032a8d0: 95e3f4e5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a8d4: aa1d03fd    	mov	x29, x29
10032a8d8: 95e3f4ea    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032a8dc: aa0003f6    	mov	x22, x0
10032a8e0: 95e3f4e4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032a8e4: b50000d6    	cbnz	x22, 0x10032a8fc <__text+0x3228fc>
10032a8e8: b00f4c08    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
10032a8ec: f9430d01    	ldr	x1, [x8, #0x618] ; selector: setDelegate:
10032a8f0: aa1303e0    	mov	x0, x19
10032a8f4: aa1403e2    	mov	x2, x20
10032a8f8: 95e3f4db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a8fc: 900f52a8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032a900: b98cf51a    	ldrsw	x26, [x8, #0xcf4] ; ivar: BaseMsgContentViewController.m_arrMessageNodeData offset=112
10032a904: f87a6a80    	ldr	x0, [x20, x26]
10032a908: 34000155    	cbz	w21, 0x10032a930 <__text+0x322930>
10032a90c: 900f52a8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10032a910: b98d6d08    	ldrsw	x8, [x8, #0xd6c] ; ivar: BaseMsgContentViewController.m_moreMsgIndex offset=136
10032a914: f8686a83    	ldr	x3, [x20, x8]
10032a918: 91000469    	add	x9, x3, #0x1
10032a91c: f8286a89    	str	x9, [x20, x8]
10032a920: b00f3508    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032a924: f9456d01    	ldr	x1, [x8, #0xad8] ; selector: safeInsertObject:atIndex:
10032a928: aa1303e2    	mov	x2, x19
10032a92c: 14000034    	b	0x10032a9fc <__text+0x3229fc>
10032a930: 900f4be8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10032a934: f9442901    	ldr	x1, [x8, #0x850] ; selector: count
10032a938: 95e3f4cb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a93c: f1000402    	subs	x2, x0, #0x1
10032a940: 54000544    	b.mi	0x10032a9e8 <__text+0x3229e8>
10032a944: aa0003f8    	mov	x24, x0
10032a948: f00f4be8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10032a94c: f9431115    	ldr	x21, [x8, #0x620] ; selector: objectAtIndexedSubscript:
10032a950: d00f3528    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
10032a954: f943e916    	ldr	x22, [x8, #0x7d0] ; selector: createTime
10032a958: f87a6a80    	ldr	x0, [x20, x26]
10032a95c: aa1503e1    	mov	x1, x21
10032a960: 95e3f4c1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a964: aa1d03fd    	mov	x29, x29
10032a968: 95e3f4c6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032a96c: aa0003f7    	mov	x23, x0
10032a970: aa1603e1    	mov	x1, x22
10032a974: 95e3f4bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a978: 4ea01c08    	mov.16b	v8, v0
10032a97c: aa1303e0    	mov	x0, x19
10032a980: aa1603e1    	mov	x1, x22
10032a984: 95e3f4b8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a988: 1e602100    	fcmp	d8, d0
10032a98c: 540003cd    	b.le	0x10032aa04 <__text+0x322a04>
10032a990: d1000719    	sub	x25, x24, #0x1
10032a994: aa1703e0    	mov	x0, x23
10032a998: 95e3f4b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032a99c: f100033f    	cmp	x25, #0x0
10032a9a0: 5400024d    	b.le	0x10032a9e8 <__text+0x3229e8>
10032a9a4: d1000b02    	sub	x2, x24, #0x2
10032a9a8: f87a6a80    	ldr	x0, [x20, x26]
10032a9ac: aa1503e1    	mov	x1, x21
10032a9b0: 95e3f4ad    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a9b4: aa1d03fd    	mov	x29, x29
10032a9b8: 95e3f4b2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10032a9bc: aa0003f7    	mov	x23, x0
10032a9c0: aa1603e1    	mov	x1, x22
10032a9c4: 95e3f4a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a9c8: 4ea01c08    	mov.16b	v8, v0
10032a9cc: aa1303e0    	mov	x0, x19
10032a9d0: aa1603e1    	mov	x1, x22
10032a9d4: 95e3f4a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032a9d8: 1e602100    	fcmp	d8, d0
10032a9dc: aa1903f8    	mov	x24, x25
10032a9e0: 54fffd8c    	b.gt	0x10032a990 <__text+0x322990>
10032a9e4: 14000009    	b	0x10032aa08 <__text+0x322a08>
10032a9e8: f87a6a80    	ldr	x0, [x20, x26]
10032a9ec: b00f3508    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032a9f0: f9456d01    	ldr	x1, [x8, #0xad8] ; selector: safeInsertObject:atIndex:
10032a9f4: aa1303e2    	mov	x2, x19
10032a9f8: d2800003    	mov	x3, #0x0                ; =0
10032a9fc: 95e3f49a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032aa00: 1400000a    	b	0x10032aa28 <__text+0x322a28>
10032aa04: aa1803f9    	mov	x25, x24
10032aa08: f87a6a80    	ldr	x0, [x20, x26]
10032aa0c: b00f3508    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10032aa10: f9456d01    	ldr	x1, [x8, #0xad8] ; selector: safeInsertObject:atIndex:
10032aa14: aa1303e2    	mov	x2, x19
10032aa18: aa1903e3    	mov	x3, x25
10032aa1c: 95e3f492    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10032aa20: aa1703e0    	mov	x0, x23
10032aa24: 95e3f493    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10032aa28: aa1303e0    	mov	x0, x19
10032aa2c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10032aa30: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10032aa34: a94357f6    	ldp	x22, x21, [sp, #0x30]
10032aa38: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10032aa3c: a94167fa    	ldp	x26, x25, [sp, #0x10]
10032aa40: 6cc623e9    	ldp	d9, d8, [sp], #0x60
10032aa44: 15e3f48b    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
