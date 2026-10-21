
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060fd810: d10103ff    	sub	sp, sp, #0x40
1060fd814: a90157f6    	stp	x22, x21, [sp, #0x10]
1060fd818: a9024ff4    	stp	x20, x19, [sp, #0x20]
1060fd81c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1060fd820: 9100c3fd    	add	x29, sp, #0x30
1060fd824: aa0003f4    	mov	x20, x0
1060fd828: 9100c000    	add	x0, x0, #0x30
1060fd82c: 946ca658    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fd830: aa0003f3    	mov	x19, x0
1060fd834: b40003c0    	cbz	x0, 0x1060fd8ac <_Flutter_MMFoundation_BindContext+0x25d9490>
1060fd838: d00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fd83c: f9453500    	ldr	x0, [x8, #0xa68]
1060fd840: 900ce9e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060fd844: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1060fd848: d00c3b88    	adrp	x8, 0x11e86f000 <dyld_stub_binder+0x11e86f000>
1060fd84c: 91072108    	add	x8, x8, #0x1c8
1060fd850: f90003e8    	str	x8, [sp]
1060fd854: 900a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fd858: 91056463    	add	x3, x3, #0x159
1060fd85c: f00ac425    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fd860: 912838a5    	add	x5, x5, #0xa0e
1060fd864: d00ac447    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fd868: 913604e7    	add	x7, x7, #0xd81
1060fd86c: 52800042    	mov	w2, #0x2                ; =2
1060fd870: 52800004    	mov	w4, #0x0                ; =0
1060fd874: 528245c6    	mov	w6, #0x122e             ; =4654
1060fd878: 946ca631    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd87c: d00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fd880: b98a3908    	ldrsw	x8, [x8, #0xa38]
1060fd884: 8b080260    	add	x0, x19, x8
1060fd888: 946ca641    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fd88c: aa0003f5    	mov	x21, x0
1060fd890: a9420e82    	ldp	x2, x3, [x20, #0x20]
1060fd894: b9403a84    	ldr	w4, [x20, #0x38]
1060fd898: d00cf688    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060fd89c: f941bd01    	ldr	x1, [x8, #0x378] ; receiverOpenUIForRoomInfo:username:receiveMsgTime:
1060fd8a0: 946ca627    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd8a4: aa1503e0    	mov	x0, x21
1060fd8a8: 946ca62b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd8ac: aa1303e0    	mov	x0, x19
1060fd8b0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1060fd8b4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1060fd8b8: a94157f6    	ldp	x22, x21, [sp, #0x10]
1060fd8bc: 910103ff    	add	sp, sp, #0x40
1060fd8c0: 146ca625    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
