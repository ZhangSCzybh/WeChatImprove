
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a09dd68: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a09dd6c: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a09dd70: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a09dd74: 910083fd    	add	x29, sp, #0x20
10a09dd78: aa0203f3    	mov	x19, x2
10a09dd7c: aa0003f4    	mov	x20, x0
10a09dd80: aa0203e0    	mov	x0, x2
10a09dd84: 955ef5af    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09dd88: f00b0ea8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a09dd8c: b9813115    	ldrsw	x21, [x8, #0x130]
10a09dd90: f8756a82    	ldr	x2, [x20, x21]
10a09dd94: eb13005f    	cmp	x2, x19
10a09dd98: 540000a0    	b.eq	0x10a09ddac <_Flutter_MMFoundation_BindContext+0x6579990>
10a09dd9c: 8b150280    	add	x0, x20, x21
10a09dda0: aa1303e1    	mov	x1, x19
10a09dda4: 955ef5a9    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
10a09dda8: f8756a82    	ldr	x2, [x20, x21]
10a09ddac: 900b0728    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a09ddb0: f9419500    	ldr	x0, [x8, #0x328]
10a09ddb4: 900afb08    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
10a09ddb8: f9472901    	ldr	x1, [x8, #0xe50] ; getImageCommentCountFromDataItem:
10a09ddbc: 955ef5a2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ddc0: aa0003e2    	mov	x2, x0
10a09ddc4: 900afb08    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
10a09ddc8: f9472d01    	ldr	x1, [x8, #0xe58] ; setTotalCommentPicCount:
10a09ddcc: aa1403e0    	mov	x0, x20
10a09ddd0: 955ef59d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ddd4: f00aece8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a09ddd8: f941b101    	ldr	x1, [x8, #0x360] ; initView
10a09dddc: aa1403e0    	mov	x0, x20
10a09dde0: 955ef599    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09dde4: f00affc8    	adrp	x8, 0x120098000 <dyld_stub_binder+0x120098000>
10a09dde8: f9471d01    	ldr	x1, [x8, #0xe38] ; initHasNewStoryArray
10a09ddec: aa1403e0    	mov	x0, x20
10a09ddf0: 955ef595    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ddf4: aa1303e0    	mov	x0, x19
10a09ddf8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a09ddfc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a09de00: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a09de04: 155ef596    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
