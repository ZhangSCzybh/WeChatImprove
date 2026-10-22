
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ad5288: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
106ad528c: a9015ff8    	stp	x24, x23, [sp, #0x10]
106ad5290: a90257f6    	stp	x22, x21, [sp, #0x20]
106ad5294: a9034ff4    	stp	x20, x19, [sp, #0x30]
106ad5298: a9047bfd    	stp	x29, x30, [sp, #0x40]
106ad529c: 910103fd    	add	x29, sp, #0x40
106ad52a0: aa0003f3    	mov	x19, x0
106ad52a4: 900d0b88    	adrp	x8, 0x120c45000 <dyld_stub_binder+0x120c45000>
106ad52a8: 52800029    	mov	w9, #0x1                ; =1
106ad52ac: 3921f509    	strb	w9, [x8, #0x87d]
106ad52b0: f00cb148    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106ad52b4: f946f115    	ldr	x21, [x8, #0xde0] ; delegate
106ad52b8: aa1503e1    	mov	x1, x21
106ad52bc: 944547a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad52c0: aa1d03fd    	mov	x29, x29
106ad52c4: 944547a1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad52c8: aa0003f4    	mov	x20, x0
106ad52cc: b40004e0    	cbz	x0, 0x106ad5368 <_Flutter_MMFoundation_BindContext+0x2fb0f4c>
106ad52d0: aa1303e0    	mov	x0, x19
106ad52d4: aa1503e1    	mov	x1, x21
106ad52d8: 94454799    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad52dc: aa1d03fd    	mov	x29, x29
106ad52e0: 9445479a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad52e4: aa0003f6    	mov	x22, x0
106ad52e8: b00ca8e8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
106ad52ec: f9450917    	ldr	x23, [x8, #0xa10] ; findParentFeed:
106ad52f0: b00cb188    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
106ad52f4: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
106ad52f8: aa1703e2    	mov	x2, x23
106ad52fc: 94454790    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5300: 34000380    	cbz	w0, 0x106ad5370 <_Flutter_MMFoundation_BindContext+0x2fb0f54>
106ad5304: aa1303e0    	mov	x0, x19
106ad5308: aa1503e1    	mov	x1, x21
106ad530c: 9445478c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5310: aa1d03fd    	mov	x29, x29
106ad5314: 9445478d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5318: aa0003f8    	mov	x24, x0
106ad531c: b00c9d28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
106ad5320: f945f901    	ldr	x1, [x8, #0xbf0] ; mediaItem
106ad5324: aa1303e0    	mov	x0, x19
106ad5328: 94454785    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad532c: aa1d03fd    	mov	x29, x29
106ad5330: 94454786    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5334: aa0003f9    	mov	x25, x0
106ad5338: aa1803e0    	mov	x0, x24
106ad533c: aa1703e1    	mov	x1, x23
106ad5340: aa1903e2    	mov	x2, x25
106ad5344: 9445477e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5348: aa1d03fd    	mov	x29, x29
106ad534c: 9445477f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5350: aa0003f5    	mov	x21, x0
106ad5354: aa1903e0    	mov	x0, x25
106ad5358: 9445477f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad535c: aa1803e0    	mov	x0, x24
106ad5360: 9445477d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5364: 14000004    	b	0x106ad5374 <_Flutter_MMFoundation_BindContext+0x2fb0f58>
106ad5368: d2800015    	mov	x21, #0x0               ; =0
106ad536c: 14000004    	b	0x106ad537c <_Flutter_MMFoundation_BindContext+0x2fb0f60>
106ad5370: d2800015    	mov	x21, #0x0               ; =0
106ad5374: aa1603e0    	mov	x0, x22
106ad5378: 94454777    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad537c: aa1403e0    	mov	x0, x20
106ad5380: 94454775    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5384: d00c9f28    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
106ad5388: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
106ad538c: aa1503e0    	mov	x0, x21
106ad5390: 9445476b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5394: aa0003f4    	mov	x20, x0
106ad5398: b00ca8e8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
106ad539c: f9450d01    	ldr	x1, [x8, #0xa18] ; privateImageView
106ad53a0: aa1303e0    	mov	x0, x19
106ad53a4: 94454766    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad53a8: aa1d03fd    	mov	x29, x29
106ad53ac: 94454767    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad53b0: aa0003f3    	mov	x19, x0
106ad53b4: f00cb188    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ad53b8: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
106ad53bc: 52000282    	eor	w2, w20, #0x1
106ad53c0: 9445475f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad53c4: aa1303e0    	mov	x0, x19
106ad53c8: 94454763    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad53cc: aa1503e0    	mov	x0, x21
106ad53d0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
106ad53d4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
106ad53d8: a94257f6    	ldp	x22, x21, [sp, #0x20]
106ad53dc: a9415ff8    	ldp	x24, x23, [sp, #0x10]
106ad53e0: a8c567fa    	ldp	x26, x25, [sp], #0x50
106ad53e4: 1445475c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
