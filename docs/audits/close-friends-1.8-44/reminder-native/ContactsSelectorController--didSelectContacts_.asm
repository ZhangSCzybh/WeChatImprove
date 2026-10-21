
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106f4474c: d10503ff    	sub	sp, sp, #0x140
106f44750: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
106f44754: a90f67fa    	stp	x26, x25, [sp, #0xf0]
106f44758: a9105ff8    	stp	x24, x23, [sp, #0x100]
106f4475c: a91157f6    	stp	x22, x21, [sp, #0x110]
106f44760: a9124ff4    	stp	x20, x19, [sp, #0x120]
106f44764: a9137bfd    	stp	x29, x30, [sp, #0x130]
106f44768: 9104c3fd    	add	x29, sp, #0x130
106f4476c: aa0203f3    	mov	x19, x2
106f44770: f90007e0    	str	x0, [sp, #0x8]
106f44774: f00b3548    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106f44778: f9405908    	ldr	x8, [x8, #0xb0]
106f4477c: f9400108    	ldr	x8, [x8]
106f44780: f81a03a8    	stur	x8, [x29, #-0x60]
106f44784: d00ce808    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106f44788: 52800029    	mov	w9, #0x1                ; =1
106f4478c: 39259d09    	strb	w9, [x8, #0x967]
106f44790: aa0203e0    	mov	x0, x2
106f44794: 94338a69    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106f44798: f00c9168    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106f4479c: f9455500    	ldr	x0, [x8, #0xaa8]
106f447a0: 94338a6e    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106f447a4: aa0003f5    	mov	x21, x0
106f447a8: 4f00e400    	movi.16b	v0, #0x0
106f447ac: ad0083e0    	stp	q0, q0, [sp, #0x10]
106f447b0: ad0183e0    	stp	q0, q0, [sp, #0x30]
106f447b4: aa1303e0    	mov	x0, x19
106f447b8: 94338a60    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106f447bc: 900c8de8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106f447c0: f9435516    	ldr	x22, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
106f447c4: 910043e2    	add	x2, sp, #0x10
106f447c8: 910143e3    	add	x3, sp, #0x50
106f447cc: aa1603e1    	mov	x1, x22
106f447d0: 52800204    	mov	w4, #0x10               ; =16
106f447d4: 94338a5a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f447d8: b4000580    	cbz	x0, 0x106f44888 <_Flutter_MMFoundation_BindContext+0x342046c>
106f447dc: aa0003f7    	mov	x23, x0
106f447e0: f94013e8    	ldr	x8, [sp, #0x20]
106f447e4: f940011c    	ldr	x28, [x8]
106f447e8: d2800014    	mov	x20, #0x0               ; =0
106f447ec: f00c77a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f447f0: f9434d18    	ldr	x24, [x8, #0x698] ; m_nsUsrName
106f447f4: f00c8de8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106f447f8: f946e919    	ldr	x25, [x8, #0xdd0] ; length
106f447fc: d00c8dc8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
106f44800: f946f51a    	ldr	x26, [x8, #0xde8] ; addObject:
106f44804: f94013e8    	ldr	x8, [sp, #0x20]
106f44808: f9400108    	ldr	x8, [x8]
106f4480c: eb1c011f    	cmp	x8, x28
106f44810: 54000060    	b.eq	0x106f4481c <_Flutter_MMFoundation_BindContext+0x3420400>
106f44814: aa1303e0    	mov	x0, x19
106f44818: 94338a4e    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
106f4481c: f9400fe8    	ldr	x8, [sp, #0x18]
106f44820: f8747900    	ldr	x0, [x8, x20, lsl #3]
106f44824: aa1803e1    	mov	x1, x24
106f44828: 94338a45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f4482c: aa1d03fd    	mov	x29, x29
106f44830: 94338a46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f44834: aa0003fb    	mov	x27, x0
106f44838: aa1903e1    	mov	x1, x25
106f4483c: 94338a40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44840: b40000a0    	cbz	x0, 0x106f44854 <_Flutter_MMFoundation_BindContext+0x3420438>
106f44844: aa1503e0    	mov	x0, x21
106f44848: aa1a03e1    	mov	x1, x26
106f4484c: aa1b03e2    	mov	x2, x27
106f44850: 94338a3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44854: aa1b03e0    	mov	x0, x27
106f44858: 94338a3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f4485c: 91000694    	add	x20, x20, #0x1
106f44860: eb1402ff    	cmp	x23, x20
106f44864: 54fffd01    	b.ne	0x106f44804 <_Flutter_MMFoundation_BindContext+0x34203e8>
106f44868: 910043e2    	add	x2, sp, #0x10
106f4486c: 910143e3    	add	x3, sp, #0x50
106f44870: aa1303e0    	mov	x0, x19
106f44874: aa1603e1    	mov	x1, x22
106f44878: 52800204    	mov	w4, #0x10               ; =16
106f4487c: 94338a30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44880: aa0003f7    	mov	x23, x0
106f44884: b5fffb20    	cbnz	x0, 0x106f447e8 <_Flutter_MMFoundation_BindContext+0x34203cc>
106f44888: aa1303e0    	mov	x0, x19
106f4488c: 94338a32    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44890: 900c8e08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106f44894: f9450916    	ldr	x22, [x8, #0xa10] ; mutableCopy
106f44898: aa1503e0    	mov	x0, x21
106f4489c: aa1603e1    	mov	x1, x22
106f448a0: 94338a27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f448a4: aa0003f7    	mov	x23, x0
106f448a8: d00c7848    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
106f448ac: f943a901    	ldr	x1, [x8, #0x750] ; setArrContacts:
106f448b0: f94007fa    	ldr	x26, [sp, #0x8]
106f448b4: aa1a03e0    	mov	x0, x26
106f448b8: aa1703e2    	mov	x2, x23
106f448bc: 94338a20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f448c0: aa1703e0    	mov	x0, x23
106f448c4: 94338a24    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f448c8: 900c8de8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106f448cc: f946f117    	ldr	x23, [x8, #0xde0] ; delegate
106f448d0: aa1a03e0    	mov	x0, x26
106f448d4: aa1703e1    	mov	x1, x23
106f448d8: 94338a19    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f448dc: aa1d03fd    	mov	x29, x29
106f448e0: 94338a1a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f448e4: d00c8e1c    	adrp	x28, 0x120106000 <dyld_stub_binder+0x120106000>
106f448e8: b40004c0    	cbz	x0, 0x106f44980 <_Flutter_MMFoundation_BindContext+0x3420564>
106f448ec: aa0003f9    	mov	x25, x0
106f448f0: aa1a03e0    	mov	x0, x26
106f448f4: aa1703e1    	mov	x1, x23
106f448f8: 94338a11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f448fc: aa1d03fd    	mov	x29, x29
106f44900: 94338a12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f44904: aa0003fa    	mov	x26, x0
106f44908: 900c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f4490c: f944ad18    	ldr	x24, [x8, #0x958] ; onRemindContactSelected:
106f44910: f9436381    	ldr	x1, [x28, #0x6c0] ; respondsToSelector:
106f44914: aa1803e2    	mov	x2, x24
106f44918: 94338a09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f4491c: aa0003fb    	mov	x27, x0
106f44920: aa1a03e0    	mov	x0, x26
106f44924: f94007fa    	ldr	x26, [sp, #0x8]
106f44928: 94338a0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f4492c: aa1903e0    	mov	x0, x25
106f44930: 94338a09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44934: 3400027b    	cbz	w27, 0x106f44980 <_Flutter_MMFoundation_BindContext+0x3420564>
106f44938: aa1a03e0    	mov	x0, x26
106f4493c: aa1703e1    	mov	x1, x23
106f44940: 943389ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44944: aa1d03fd    	mov	x29, x29
106f44948: 94338a00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f4494c: aa0003f7    	mov	x23, x0
106f44950: aa1503e0    	mov	x0, x21
106f44954: aa1603e1    	mov	x1, x22
106f44958: 943389f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f4495c: aa0003f6    	mov	x22, x0
106f44960: aa1703e0    	mov	x0, x23
106f44964: aa1803e1    	mov	x1, x24
106f44968: aa1603e2    	mov	x2, x22
106f4496c: 943389f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44970: aa1603e0    	mov	x0, x22
106f44974: 943389f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44978: aa1703e0    	mov	x0, x23
106f4497c: 943389f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44980: b00c9808    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106f44984: b98d8108    	ldrsw	x8, [x8, #0xd80]
106f44988: f8686b40    	ldr	x0, [x26, x8]
106f4498c: d00c8e08    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106f44990: f9403501    	ldr	x1, [x8, #0x68] ; reload
106f44994: 943389ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44998: b00c9808    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106f4499c: b98d8514    	ldrsw	x20, [x8, #0xd84]
106f449a0: 8b140340    	add	x0, x26, x20
106f449a4: 943389fa    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106f449a8: b40002e0    	cbz	x0, 0x106f44a04 <_Flutter_MMFoundation_BindContext+0x34205e8>
106f449ac: aa0003f7    	mov	x23, x0
106f449b0: 8b140340    	add	x0, x26, x20
106f449b4: 943389f6    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106f449b8: aa0003f8    	mov	x24, x0
106f449bc: 900c85e8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
106f449c0: f942e116    	ldr	x22, [x8, #0x5c0] ; updateSelectorView
106f449c4: f9436381    	ldr	x1, [x28, #0x6c0] ; respondsToSelector:
106f449c8: aa1603e2    	mov	x2, x22
106f449cc: 943389dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f449d0: aa0003f9    	mov	x25, x0
106f449d4: aa1803e0    	mov	x0, x24
106f449d8: 943389df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f449dc: aa1703e0    	mov	x0, x23
106f449e0: 943389dd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f449e4: 34000119    	cbz	w25, 0x106f44a04 <_Flutter_MMFoundation_BindContext+0x34205e8>
106f449e8: 8b140340    	add	x0, x26, x20
106f449ec: 943389e8    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
106f449f0: aa0003f4    	mov	x20, x0
106f449f4: aa1603e1    	mov	x1, x22
106f449f8: 943389d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f449fc: aa1403e0    	mov	x0, x20
106f44a00: 943389d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44a04: aa1503e0    	mov	x0, x21
106f44a08: 943389d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44a0c: aa1303e0    	mov	x0, x19
106f44a10: 943389d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44a14: f85a03a8    	ldur	x8, [x29, #-0x60]
106f44a18: f00b3549    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
106f44a1c: f9405929    	ldr	x9, [x9, #0xb0]
106f44a20: f9400129    	ldr	x9, [x9]
106f44a24: eb08013f    	cmp	x9, x8
106f44a28: 54000121    	b.ne	0x106f44a4c <_Flutter_MMFoundation_BindContext+0x3420630>
106f44a2c: a9537bfd    	ldp	x29, x30, [sp, #0x130]
106f44a30: a9524ff4    	ldp	x20, x19, [sp, #0x120]
106f44a34: a95157f6    	ldp	x22, x21, [sp, #0x110]
106f44a38: a9505ff8    	ldp	x24, x23, [sp, #0x100]
106f44a3c: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
106f44a40: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
106f44a44: 910503ff    	add	sp, sp, #0x140
106f44a48: d65f03c0    	ret
106f44a4c: 943389ca    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
