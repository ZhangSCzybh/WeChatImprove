
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b9114: d100c3ff    	sub	sp, sp, #0x30
10a0b9118: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a0b911c: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a0b9120: 910083fd    	add	x29, sp, #0x20
10a0b9124: aa0003f3    	mov	x19, x0
10a0b9128: f00b0dc8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b912c: b9824d08    	ldrsw	x8, [x8, #0x24c]
10a0b9130: 38686808    	ldrb	w8, [x0, x8]
10a0b9134: 7100051f    	cmp	w8, #0x1
10a0b9138: 54000321    	b.ne	0x10a0b919c <_Flutter_MMFoundation_BindContext+0x6594d80>
10a0b913c: d00b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b9140: f9468d00    	ldr	x0, [x8, #0xd18]
10a0b9144: b00aec08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a0b9148: f946e901    	ldr	x1, [x8, #0xdd0] ; isiPhone
10a0b914c: 955e88be    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9150: 34000260    	cbz	w0, 0x10a0b919c <_Flutter_MMFoundation_BindContext+0x6594d80>
10a0b9154: d00b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0b9158: f9453500    	ldr	x0, [x8, #0xa68]
10a0b915c: 900aec08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0b9160: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0b9164: f00a4848    	adrp	x8, 0x11e9c4000 <dyld_stub_binder+0x11e9c4000>
10a0b9168: 911f2108    	add	x8, x8, #0x7c8
10a0b916c: f90003e8    	str	x8, [sp]
10a0b9170: f0088b03    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0b9174: 912b2863    	add	x3, x3, #0xaca
10a0b9178: 9008e265    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0b917c: 912850a5    	add	x5, x5, #0xa14
10a0b9180: 9008e267    	adrp	x7, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0b9184: 9130fce7    	add	x7, x7, #0xc3f
10a0b9188: 52800042    	mov	w2, #0x2                ; =2
10a0b918c: 52800004    	mov	w4, #0x0                ; =0
10a0b9190: 52808c66    	mov	w6, #0x463              ; =1123
10a0b9194: 955e88ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9198: 14000011    	b	0x10a0b91dc <_Flutter_MMFoundation_BindContext+0x6594dc0>
10a0b919c: f00b0dc8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b91a0: b9820908    	ldrsw	x8, [x8, #0x208]
10a0b91a4: 38686a68    	ldrb	w8, [x19, x8]
10a0b91a8: 7100051f    	cmp	w8, #0x1
10a0b91ac: 54000101    	b.ne	0x10a0b91cc <_Flutter_MMFoundation_BindContext+0x6594db0>
10a0b91b0: b00afd88    	adrp	x8, 0x12006a000 <dyld_stub_binder+0x12006a000>
10a0b91b4: f947fd01    	ldr	x1, [x8, #0xff8] ; p_reloadTableViewContent
10a0b91b8: aa1303e0    	mov	x0, x19
10a0b91bc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a0b91c0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a0b91c4: 9100c3ff    	add	sp, sp, #0x30
10a0b91c8: 155e889f    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b91cc: f00b0dc8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0b91d0: b9820d08    	ldrsw	x8, [x8, #0x20c]
10a0b91d4: 52800029    	mov	w9, #0x1                ; =1
10a0b91d8: 38286a69    	strb	w9, [x19, x8]
10a0b91dc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a0b91e0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a0b91e4: 9100c3ff    	add	sp, sp, #0x30
10a0b91e8: d65f03c0    	ret
