
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101699820: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101699824: a9014ff4    	stp	x20, x19, [sp, #0x10]
101699828: a9027bfd    	stp	x29, x30, [sp, #0x20]
10169982c: 910083fd    	add	x29, sp, #0x20
101699830: aa0003f3    	mov	x19, x0
101699834: b00f4068    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101699838: f9432d01    	ldr	x1, [x8, #0x658] ; numberOfSearchItems
10169983c: 95963640    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101699840: b40002a0    	cbz	x0, 0x101699894 <__text+0x1691894>
101699844: aa0003f4    	mov	x20, x0
101699848: b00f4068    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
10169984c: f942d515    	ldr	x21, [x8, #0x5a8] ; maxDisplayItemsCount
101699850: aa1303e0    	mov	x0, x19
101699854: aa1503e1    	mov	x1, x21
101699858: 95963639    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10169985c: eb00029f    	cmp	x20, x0
101699860: 540000a9    	b.ls	0x101699874 <__text+0x1691874>
101699864: aa1303e0    	mov	x0, x19
101699868: aa1503e1    	mov	x1, x21
10169986c: 95963634    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101699870: 91000414    	add	x20, x0, #0x1
101699874: b00f4068    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101699878: f9435901    	ldr	x1, [x8, #0x6b0] ; hasFoldButton
10169987c: aa1303e0    	mov	x0, x19
101699880: 9596362f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101699884: 7100001f    	cmp	w0, #0x0
101699888: 52800028    	mov	w8, #0x1                ; =1
10169988c: 9a880508    	cinc	x8, x8, ne
101699890: 8b140100    	add	x0, x8, x20
101699894: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101699898: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10169989c: a8c357f6    	ldp	x22, x21, [sp], #0x30
1016998a0: d65f03c0    	ret
