
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1052ad4fc: d10383ff    	sub	sp, sp, #0xe0
1052ad500: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
1052ad504: a90b57f6    	stp	x22, x21, [sp, #0xb0]
1052ad508: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
1052ad50c: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
1052ad510: 910343fd    	add	x29, sp, #0xd0
1052ad514: aa0203f3    	mov	x19, x2
1052ad518: f00dcc88    	adrp	x8, 0x120c40000 <dyld_stub_binder+0x120c40000>
1052ad51c: 52800029    	mov	w9, #0x1                ; =1
1052ad520: 39051909    	strb	w9, [x8, #0x146]
1052ad524: aa0203e0    	mov	x0, x2
1052ad528: 94a5e704    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1052ad52c: d00d72a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1052ad530: f946e914    	ldr	x20, [x8, #0xdd0] ; length
1052ad534: aa1303e0    	mov	x0, x19
1052ad538: aa1403e1    	mov	x1, x20
1052ad53c: 94a5e700    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad540: b4000620    	cbz	x0, 0x1052ad604 <_Flutter_MMFoundation_BindContext+0x17891e8>
1052ad544: f81c83bf    	stur	xzr, [x29, #-0x38]
1052ad548: aa1303e0    	mov	x0, x19
1052ad54c: 94a5e717    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1052ad550: d00d7288    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1052ad554: f9447515    	ldr	x21, [x8, #0x8e8] ; bytes
1052ad558: aa1503e1    	mov	x1, x21
1052ad55c: 94a5e6f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad560: aa0003f6    	mov	x22, x0
1052ad564: aa1303e0    	mov	x0, x19
1052ad568: aa1403e1    	mov	x1, x20
1052ad56c: 94a5e6f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad570: aa0003e1    	mov	x1, x0
1052ad574: d100d3a2    	sub	x2, x29, #0x34
1052ad578: d100e3a3    	sub	x3, x29, #0x38
1052ad57c: aa1603e0    	mov	x0, x22
1052ad580: 94a57bff    	bl	0x107c0c57c <_Flutter_MMFoundation_BindContext+0x40e8160>
1052ad584: 36000600    	tbz	w0, #0x0, 0x1052ad644 <_Flutter_MMFoundation_BindContext+0x1789228>
1052ad588: b85cc3a8    	ldur	w8, [x29, #-0x34]
1052ad58c: 35000068    	cbnz	w8, 0x1052ad598 <_Flutter_MMFoundation_BindContext+0x178917c>
1052ad590: 5287d008    	mov	w8, #0x3e80             ; =16000
1052ad594: b81cc3a8    	stur	w8, [x29, #-0x34]
1052ad598: 9100c3e0    	add	x0, sp, #0x30
1052ad59c: 94a57bf5    	bl	0x107c0c570 <_Flutter_MMFoundation_BindContext+0x40e8154>
1052ad5a0: 297907a8    	ldp	w8, w1, [x29, #-0x38]
1052ad5a4: 7100051f    	cmp	w8, #0x1
1052ad5a8: 1a9fc502    	csinc	w2, w8, wzr, gt
1052ad5ac: 9100c3e0    	add	x0, sp, #0x30
1052ad5b0: 529f4003    	mov	w3, #0xfa00             ; =64000
1052ad5b4: 52800024    	mov	w4, #0x1                ; =1
1052ad5b8: 94a57bf2    	bl	0x107c0c580 <_Flutter_MMFoundation_BindContext+0x40e8164>
1052ad5bc: 34000680    	cbz	w0, 0x1052ad68c <_Flutter_MMFoundation_BindContext+0x1789270>
1052ad5c0: d00d7628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1052ad5c4: f9453508    	ldr	x8, [x8, #0xa68]
1052ad5c8: 900d5c69    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1052ad5cc: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1052ad5d0: 900ca9c9    	adrp	x9, 0x11e7e5000 <dyld_stub_binder+0x11e7e5000>
1052ad5d4: 9119a129    	add	x9, x9, #0x668
1052ad5d8: a90003e9    	stp	x9, x0, [sp]
1052ad5dc: b00b2e45    	adrp	x5, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad5e0: 9126b0a5    	add	x5, x5, #0x9ac
1052ad5e4: b00b2e47    	adrp	x7, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad5e8: 913ae8e7    	add	x7, x7, #0xeba
1052ad5ec: aa0803e0    	mov	x0, x8
1052ad5f0: 52800082    	mov	w2, #0x4                ; =4
1052ad5f4: d2800003    	mov	x3, #0x0                ; =0
1052ad5f8: 52800004    	mov	w4, #0x0                ; =0
1052ad5fc: 52804b86    	mov	w6, #0x25c              ; =604
1052ad600: 14000071    	b	0x1052ad7c4 <_Flutter_MMFoundation_BindContext+0x17893a8>
1052ad604: d00d7628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1052ad608: f9453500    	ldr	x0, [x8, #0xa68]
1052ad60c: 900d5c68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1052ad610: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1052ad614: 900ca9c8    	adrp	x8, 0x11e7e5000 <dyld_stub_binder+0x11e7e5000>
1052ad618: 9118a108    	add	x8, x8, #0x628
1052ad61c: f90003e8    	str	x8, [sp]
1052ad620: b00b2e45    	adrp	x5, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad624: 9126b0a5    	add	x5, x5, #0x9ac
1052ad628: b00b2e47    	adrp	x7, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad62c: 913ae8e7    	add	x7, x7, #0xeba
1052ad630: 52800082    	mov	w2, #0x4                ; =4
1052ad634: d2800003    	mov	x3, #0x0                ; =0
1052ad638: 52800004    	mov	w4, #0x0                ; =0
1052ad63c: 52804906    	mov	w6, #0x248              ; =584
1052ad640: 14000010    	b	0x1052ad680 <_Flutter_MMFoundation_BindContext+0x1789264>
1052ad644: d00d7628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1052ad648: f9453500    	ldr	x0, [x8, #0xa68]
1052ad64c: 900d5c68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1052ad650: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1052ad654: 900ca9c8    	adrp	x8, 0x11e7e5000 <dyld_stub_binder+0x11e7e5000>
1052ad658: 91192108    	add	x8, x8, #0x648
1052ad65c: f90003e8    	str	x8, [sp]
1052ad660: b00b2e45    	adrp	x5, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad664: 9126b0a5    	add	x5, x5, #0x9ac
1052ad668: b00b2e47    	adrp	x7, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad66c: 913ae8e7    	add	x7, x7, #0xeba
1052ad670: 52800082    	mov	w2, #0x4                ; =4
1052ad674: d2800003    	mov	x3, #0x0                ; =0
1052ad678: 52800004    	mov	w4, #0x0                ; =0
1052ad67c: 52804a06    	mov	w6, #0x250              ; =592
1052ad680: 94a5e6af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad684: 52800014    	mov	w20, #0x0               ; =0
1052ad688: 14000053    	b	0x1052ad7d4 <_Flutter_MMFoundation_BindContext+0x17893b8>
1052ad68c: aa1303e0    	mov	x0, x19
1052ad690: aa1403e1    	mov	x1, x20
1052ad694: 94a5e6aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad698: 52800648    	mov	w8, #0x32               ; =50
1052ad69c: 1b087c16    	mul	w22, w0, w8
1052ad6a0: 93407ec0    	sxtw	x0, w22
1052ad6a4: 94a5e75b    	bl	0x107c27410 <_Flutter_MMFoundation_BindContext+0x4102ff4>
1052ad6a8: aa0003f7    	mov	x23, x0
1052ad6ac: b9002fff    	str	wzr, [sp, #0x2c]
1052ad6b0: aa1303e0    	mov	x0, x19
1052ad6b4: 94a5e6bd    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
1052ad6b8: aa1503e1    	mov	x1, x21
1052ad6bc: 94a5e6a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad6c0: aa0003f5    	mov	x21, x0
1052ad6c4: aa1303e0    	mov	x0, x19
1052ad6c8: aa1403e1    	mov	x1, x20
1052ad6cc: 94a5e69c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad6d0: aa0003e2    	mov	x2, x0
1052ad6d4: 9100c3e0    	add	x0, sp, #0x30
1052ad6d8: 9100b3e5    	add	x5, sp, #0x2c
1052ad6dc: aa1503e1    	mov	x1, x21
1052ad6e0: aa1703e3    	mov	x3, x23
1052ad6e4: aa1603e4    	mov	x4, x22
1052ad6e8: 94a57ba8    	bl	0x107c0c588 <_Flutter_MMFoundation_BindContext+0x40e816c>
1052ad6ec: aa0003f4    	mov	x20, x0
1052ad6f0: aa1703e0    	mov	x0, x23
1052ad6f4: 94a5e73a    	bl	0x107c273dc <_Flutter_MMFoundation_BindContext+0x4102fc0>
1052ad6f8: 9100c3e0    	add	x0, sp, #0x30
1052ad6fc: 94a57b9e    	bl	0x107c0c574 <_Flutter_MMFoundation_BindContext+0x40e8158>
1052ad700: 35000454    	cbnz	w20, 0x1052ad788 <_Flutter_MMFoundation_BindContext+0x178936c>
1052ad704: b9402fe8    	ldr	w8, [sp, #0x2c]
1052ad708: 34000408    	cbz	w8, 0x1052ad788 <_Flutter_MMFoundation_BindContext+0x178936c>
1052ad70c: 29792ba9    	ldp	w9, w10, [x29, #-0x38]
1052ad710: 7100053f    	cmp	w9, #0x1
1052ad714: 1a9fc529    	csinc	w9, w9, wzr, gt
1052ad718: 1e220100    	scvtf	s0, w8
1052ad71c: 1b0a7d2b    	mul	w11, w9, w10
1052ad720: 531f796b    	lsl	w11, w11, #1
1052ad724: 1e220161    	scvtf	s1, w11
1052ad728: 1e211800    	fdiv	s0, s0, s1
1052ad72c: 52a88f4b    	mov	w11, #0x447a0000        ; =1148846080
1052ad730: 1e270161    	fmov	s1, w11
1052ad734: 1e210800    	fmul	s0, s0, s1
1052ad738: 1e390014    	fcvtzu	w20, s0
1052ad73c: d00d762b    	adrp	x11, 0x120173000 <dyld_stub_binder+0x120173000>
1052ad740: f9453560    	ldr	x0, [x11, #0xa68]
1052ad744: 900d5c6b    	adrp	x11, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1052ad748: f942a961    	ldr	x1, [x11, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1052ad74c: a90127ea    	stp	x10, x9, [sp, #0x10]
1052ad750: 900ca9c9    	adrp	x9, 0x11e7e5000 <dyld_stub_binder+0x11e7e5000>
1052ad754: 911aa129    	add	x9, x9, #0x6a8
1052ad758: a90023e9    	stp	x9, x8, [sp]
1052ad75c: f90013f4    	str	x20, [sp, #0x20]
1052ad760: b00b2e45    	adrp	x5, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad764: 9126b0a5    	add	x5, x5, #0x9ac
1052ad768: b00b2e47    	adrp	x7, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad76c: 913ae8e7    	add	x7, x7, #0xeba
1052ad770: 52800042    	mov	w2, #0x2                ; =2
1052ad774: d2800003    	mov	x3, #0x0                ; =0
1052ad778: 52800004    	mov	w4, #0x0                ; =0
1052ad77c: 52804ee6    	mov	w6, #0x277              ; =631
1052ad780: 94a5e66f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad784: 14000012    	b	0x1052ad7cc <_Flutter_MMFoundation_BindContext+0x17893b0>
1052ad788: d00d7628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1052ad78c: f9453500    	ldr	x0, [x8, #0xa68]
1052ad790: 900d5c68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1052ad794: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1052ad798: 900ca9c8    	adrp	x8, 0x11e7e5000 <dyld_stub_binder+0x11e7e5000>
1052ad79c: 911a2108    	add	x8, x8, #0x688
1052ad7a0: a90053e8    	stp	x8, x20, [sp]
1052ad7a4: b00b2e45    	adrp	x5, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad7a8: 9126b0a5    	add	x5, x5, #0x9ac
1052ad7ac: b00b2e47    	adrp	x7, 0x11b876000 <dyld_stub_binder+0x11b876000>
1052ad7b0: 913ae8e7    	add	x7, x7, #0xeba
1052ad7b4: 52800082    	mov	w2, #0x4                ; =4
1052ad7b8: d2800003    	mov	x3, #0x0                ; =0
1052ad7bc: 52800004    	mov	w4, #0x0                ; =0
1052ad7c0: 52804d46    	mov	w6, #0x26a              ; =618
1052ad7c4: 94a5e65e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1052ad7c8: 52800014    	mov	w20, #0x0               ; =0
1052ad7cc: 9100c3e0    	add	x0, sp, #0x30
1052ad7d0: 94a57b6a    	bl	0x107c0c578 <_Flutter_MMFoundation_BindContext+0x40e815c>
1052ad7d4: aa1303e0    	mov	x0, x19
1052ad7d8: 94a5e65f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1052ad7dc: aa1403e0    	mov	x0, x20
1052ad7e0: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
1052ad7e4: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
1052ad7e8: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
1052ad7ec: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
1052ad7f0: 910383ff    	add	sp, sp, #0xe0
1052ad7f4: d65f03c0    	ret