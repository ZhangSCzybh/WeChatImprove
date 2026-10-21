
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1060fd470: d10143ff    	sub	sp, sp, #0x50
1060fd474: a9015ff8    	stp	x24, x23, [sp, #0x10]
1060fd478: a90257f6    	stp	x22, x21, [sp, #0x20]
1060fd47c: a9034ff4    	stp	x20, x19, [sp, #0x30]
1060fd480: a9047bfd    	stp	x29, x30, [sp, #0x40]
1060fd484: 910103fd    	add	x29, sp, #0x40
1060fd488: aa0003f5    	mov	x21, x0
1060fd48c: 9100c000    	add	x0, x0, #0x30
1060fd490: 946ca73f    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fd494: aa0003f3    	mov	x19, x0
1060fd498: b40007a0    	cbz	x0, 0x1060fd58c <_Flutter_MMFoundation_BindContext+0x25d9170>
1060fd49c: f94012b4    	ldr	x20, [x21, #0x20]
1060fd4a0: aa1403e0    	mov	x0, x20
1060fd4a4: 946ca725    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1060fd4a8: f94016a0    	ldr	x0, [x21, #0x28]
1060fd4ac: 900cebc8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
1060fd4b0: f9430d16    	ldr	x22, [x8, #0x618] ; callerUsername
1060fd4b4: aa1603e1    	mov	x1, x22
1060fd4b8: 946ca721    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd4bc: aa1d03fd    	mov	x29, x29
1060fd4c0: 946ca722    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fd4c4: aa0003f7    	mov	x23, x0
1060fd4c8: d00d0028    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1060fd4cc: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1060fd4d0: 946ca71b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd4d4: aa0003f8    	mov	x24, x0
1060fd4d8: aa1703e0    	mov	x0, x23
1060fd4dc: 946ca71e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd4e0: b4000178    	cbz	x24, 0x1060fd50c <_Flutter_MMFoundation_BindContext+0x25d90f0>
1060fd4e4: f94016a0    	ldr	x0, [x21, #0x28]
1060fd4e8: aa1603e1    	mov	x1, x22
1060fd4ec: 946ca714    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd4f0: aa1d03fd    	mov	x29, x29
1060fd4f4: 946ca715    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1060fd4f8: aa0003f6    	mov	x22, x0
1060fd4fc: aa1403e0    	mov	x0, x20
1060fd500: 946ca715    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd504: aa1603f4    	mov	x20, x22
1060fd508: 14000012    	b	0x1060fd550 <_Flutter_MMFoundation_BindContext+0x25d9134>
1060fd50c: d00d03a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1060fd510: f9453500    	ldr	x0, [x8, #0xa68]
1060fd514: 900ce9e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1060fd518: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1060fd51c: d00c3b88    	adrp	x8, 0x11e86f000 <dyld_stub_binder+0x11e86f000>
1060fd520: 91062108    	add	x8, x8, #0x188
1060fd524: f90003e8    	str	x8, [sp]
1060fd528: 900a9c23    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1060fd52c: 91056463    	add	x3, x3, #0x159
1060fd530: f00ac425    	adrp	x5, 0x11b984000 <dyld_stub_binder+0x11b984000>
1060fd534: 912838a5    	add	x5, x5, #0xa0e
1060fd538: d00ac447    	adrp	x7, 0x11b987000 <dyld_stub_binder+0x11b987000>
1060fd53c: 913e00e7    	add	x7, x7, #0xf80
1060fd540: 52800042    	mov	w2, #0x2                ; =2
1060fd544: 52800004    	mov	w4, #0x0                ; =0
1060fd548: 52824226    	mov	w6, #0x1211             ; =4625
1060fd54c: 946ca6fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd550: d00d09c8    	adrp	x8, 0x120237000 <dyld_stub_binder+0x120237000>
1060fd554: b98a3908    	ldrsw	x8, [x8, #0xa38]
1060fd558: 8b080260    	add	x0, x19, x8
1060fd55c: 946ca70c    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1060fd560: aa0003f6    	mov	x22, x0
1060fd564: f94016a2    	ldr	x2, [x21, #0x28]
1060fd568: b9403aa4    	ldr	w4, [x21, #0x38]
1060fd56c: d00cf688    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
1060fd570: f941bd01    	ldr	x1, [x8, #0x378] ; receiverOpenUIForRoomInfo:username:receiveMsgTime:
1060fd574: aa1403e3    	mov	x3, x20
1060fd578: 946ca6f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1060fd57c: aa1603e0    	mov	x0, x22
1060fd580: 946ca6f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd584: aa1403e0    	mov	x0, x20
1060fd588: 946ca6f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1060fd58c: aa1303e0    	mov	x0, x19
1060fd590: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1060fd594: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1060fd598: a94257f6    	ldp	x22, x21, [sp, #0x20]
1060fd59c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1060fd5a0: 910143ff    	add	sp, sp, #0x50
1060fd5a4: 146ca6ec    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
