
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10616e748: d10143ff    	sub	sp, sp, #0x50
10616e74c: a9015ff8    	stp	x24, x23, [sp, #0x10]
10616e750: a90257f6    	stp	x22, x21, [sp, #0x20]
10616e754: a9034ff4    	stp	x20, x19, [sp, #0x30]
10616e758: a9047bfd    	stp	x29, x30, [sp, #0x40]
10616e75c: 910103fd    	add	x29, sp, #0x40
10616e760: b00d56a8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10616e764: 52800029    	mov	w9, #0x1                ; =1
10616e768: 391be109    	strb	w9, [x8, #0x6f8]
10616e76c: d00d02c8    	adrp	x8, 0x1201c8000 <dyld_stub_binder+0x1201c8000>
10616e770: f9477108    	ldr	x8, [x8, #0xee0]
10616e774: a90023e0    	stp	x0, x8, [sp]
10616e778: 900cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616e77c: f9466901    	ldr	x1, [x8, #0xcd0] ; selector=init
10616e780: 910003e0    	mov	x0, sp
10616e784: 946ae270    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10616e788: aa0003f3    	mov	x19, x0
10616e78c: b4000800    	cbz	x0, 0x10616e88c <_Flutter_MMFoundation_BindContext+0x264a470>
10616e790: b00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616e794: f9455500    	ldr	x0, [x8, #0xaa8]
10616e798: b00cfc88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10616e79c: f941a101    	ldr	x1, [x8, #0x340] ; selector=array
10616e7a0: 946ae267    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e7a4: aa1d03fd    	mov	x29, x29
10616e7a8: 946ae268    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616e7ac: aa0003f4    	mov	x20, x0
10616e7b0: f00cf308    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10616e7b4: f940e901    	ldr	x1, [x8, #0x1d0] ; selector=setHandledInviteMsgs:
10616e7b8: aa1303e0    	mov	x0, x19
10616e7bc: aa1403e2    	mov	x2, x20
10616e7c0: 946ae25f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e7c4: aa1403e0    	mov	x0, x20
10616e7c8: 946ae263    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616e7cc: b00ce668    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10616e7d0: f940e101    	ldr	x1, [x8, #0x1c0] ; selector=clear
10616e7d4: aa1303e0    	mov	x0, x19
10616e7d8: 946ae259    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e7dc: b00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616e7e0: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
10616e7e4: d00cfc88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10616e7e8: f944e914    	ldr	x20, [x8, #0x9d0] ; selector=currentContext
10616e7ec: aa1403e1    	mov	x1, x20
10616e7f0: 946ae253    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e7f4: aa1d03fd    	mov	x29, x29
10616e7f8: 946ae254    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616e7fc: aa0003f5    	mov	x21, x0
10616e800: 900d0028    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10616e804: f9430502    	ldr	x2, [x8, #0x608] ; protocol=VoIPConfSDKServiceExtension
10616e808: 900ce668    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10616e80c: f940a116    	ldr	x22, [x8, #0x140] ; selector=registerExtension:withTarget:
10616e810: aa1603e1    	mov	x1, x22
10616e814: aa1303e3    	mov	x3, x19
10616e818: 946ae249    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e81c: aa1503e0    	mov	x0, x21
10616e820: 946ae24d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616e824: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
10616e828: aa1403e1    	mov	x1, x20
10616e82c: 946ae244    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e830: aa1d03fd    	mov	x29, x29
10616e834: 946ae245    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616e838: aa0003f5    	mov	x21, x0
10616e83c: f00d0008    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
10616e840: f944a902    	ldr	x2, [x8, #0x950] ; protocol=MMConfSDKServiceExtension
10616e844: aa1603e1    	mov	x1, x22
10616e848: aa1303e3    	mov	x3, x19
10616e84c: 946ae23c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e850: aa1503e0    	mov	x0, x21
10616e854: 946ae240    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616e858: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
10616e85c: aa1403e1    	mov	x1, x20
10616e860: 946ae237    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e864: aa1d03fd    	mov	x29, x29
10616e868: 946ae238    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616e86c: aa0003f4    	mov	x20, x0
10616e870: 900d0028    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10616e874: f9414502    	ldr	x2, [x8, #0x288] ; protocol=VoIPInvitationServiceExtension
10616e878: aa1603e1    	mov	x1, x22
10616e87c: aa1303e3    	mov	x3, x19
10616e880: 946ae22f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616e884: aa1403e0    	mov	x0, x20
10616e888: 946ae233    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616e88c: aa1303e0    	mov	x0, x19
10616e890: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10616e894: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10616e898: a94257f6    	ldp	x22, x21, [sp, #0x20]
10616e89c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10616e8a0: 910143ff    	add	sp, sp, #0x50
10616e8a4: d65f03c0    	ret
