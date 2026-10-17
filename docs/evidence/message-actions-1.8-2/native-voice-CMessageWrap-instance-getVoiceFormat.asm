
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9abc4: d10143ff    	sub	sp, sp, #0x50
104b9abc8: a9015ff8    	stp	x24, x23, [sp, #0x10]
104b9abcc: a90257f6    	stp	x22, x21, [sp, #0x20]
104b9abd0: a9034ff4    	stp	x20, x19, [sp, #0x30]
104b9abd4: a9047bfd    	stp	x29, x30, [sp, #0x40]
104b9abd8: 910103fd    	add	x29, sp, #0x40
104b9abdc: aa0003f3    	mov	x19, x0
104b9abe0: 900e0528    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b9abe4: 52800029    	mov	w9, #0x1                ; =1
104b9abe8: 391a0509    	strb	w9, [x8, #0x681]
104b9abec: f00d9508    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b9abf0: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104b9abf4: 94c23152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9abf8: aa1d03fd    	mov	x29, x29
104b9abfc: 94c23153    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9ac00: aa0003f4    	mov	x20, x0
104b9ac04: 9420628b    	bl	0x1053b3630 <_Flutter_MMFoundation_BindContext+0x188f214>
104b9ac08: aa0003f5    	mov	x21, x0
104b9ac0c: aa1403e0    	mov	x0, x20
104b9ac10: 94c23151    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9ac14: b00daed6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b9ac18: f00d94f7    	adrp	x23, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9ac1c: b00d9f78    	adrp	x24, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104b9ac20: 710006bf    	cmp	w21, #0x1
104b9ac24: 54000201    	b.ne	0x104b9ac64 <_Flutter_MMFoundation_BindContext+0x1076848>
104b9ac28: f9458301    	ldr	x1, [x24, #0xb00] ; getVoicePath
104b9ac2c: aa1303e0    	mov	x0, x19
104b9ac30: 94c23143    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ac34: aa1d03fd    	mov	x29, x29
104b9ac38: 94c23144    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9ac3c: aa0003f5    	mov	x21, x0
104b9ac40: b00daec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9ac44: f9463500    	ldr	x0, [x8, #0xc68]
104b9ac48: f00d94e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9ac4c: f9467901    	ldr	x1, [x8, #0xcf0] ; FileExist:
104b9ac50: aa1503e2    	mov	x2, x21
104b9ac54: 94c2313a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ac58: 360002e0    	tbz	w0, #0x0, 0x104b9acb4 <_Flutter_MMFoundation_BindContext+0x1076898>
104b9ac5c: 12800014    	mov	w20, #-0x1              ; =-1
104b9ac60: 14000024    	b	0x104b9acf0 <_Flutter_MMFoundation_BindContext+0x10768d4>
104b9ac64: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9ac68: f9457d01    	ldr	x1, [x8, #0xaf8] ; m_uiVoiceFormat
104b9ac6c: aa1303e0    	mov	x0, x19
104b9ac70: 94c23133    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ac74: aa0003f4    	mov	x20, x0
104b9ac78: f94536c0    	ldr	x0, [x22, #0xa68]
104b9ac7c: f942aae1    	ldr	x1, [x23, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b9ac80: f00ce068    	adrp	x8, 0x11e7a9000 <dyld_stub_binder+0x11e7a9000>
104b9ac84: 9128a108    	add	x8, x8, #0xa28
104b9ac88: a90053e8    	stp	x8, x20, [sp]
104b9ac8c: 900b6365    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9ac90: 911a58a5    	add	x5, x5, #0x696
104b9ac94: 900b6367    	adrp	x7, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9ac98: 911aace7    	add	x7, x7, #0x6ab
104b9ac9c: 52800042    	mov	w2, #0x2                ; =2
104b9aca0: d2800003    	mov	x3, #0x0                ; =0
104b9aca4: 52800004    	mov	w4, #0x0                ; =0
104b9aca8: 52801ba6    	mov	w6, #0xdd               ; =221
104b9acac: 94c23124    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9acb0: 14000012    	b	0x104b9acf8 <_Flutter_MMFoundation_BindContext+0x10768dc>
104b9acb4: f94536c0    	ldr	x0, [x22, #0xa68]
104b9acb8: f942aae1    	ldr	x1, [x23, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b9acbc: f00ce068    	adrp	x8, 0x11e7a9000 <dyld_stub_binder+0x11e7a9000>
104b9acc0: 91282108    	add	x8, x8, #0xa08
104b9acc4: f90003e8    	str	x8, [sp]
104b9acc8: 900b6365    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9accc: 911a58a5    	add	x5, x5, #0x696
104b9acd0: 900b6367    	adrp	x7, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9acd4: 911aace7    	add	x7, x7, #0x6ab
104b9acd8: 52800042    	mov	w2, #0x2                ; =2
104b9acdc: d2800003    	mov	x3, #0x0                ; =0
104b9ace0: 52800004    	mov	w4, #0x0                ; =0
104b9ace4: 52801b06    	mov	w6, #0xd8               ; =216
104b9ace8: 94c23115    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9acec: 52800034    	mov	w20, #0x1               ; =1
104b9acf0: aa1503e0    	mov	x0, x21
104b9acf4: 94c23118    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9acf8: 11000688    	add	w8, w20, #0x1
104b9acfc: 7100211f    	cmp	w8, #0x8
104b9ad00: 52800029    	mov	w9, #0x1                ; =1
104b9ad04: 1ac82128    	lsl	w8, w9, w8
104b9ad08: 52802429    	mov	w9, #0x121              ; =289
104b9ad0c: 0a090108    	and	w8, w8, w9
104b9ad10: 7a409904    	ccmp	w8, #0x0, #0x4, ls
104b9ad14: 540006a0    	b.eq	0x104b9ade8 <_Flutter_MMFoundation_BindContext+0x10769cc>
104b9ad18: f9458301    	ldr	x1, [x24, #0xb00] ; getVoicePath
104b9ad1c: aa1303e0    	mov	x0, x19
104b9ad20: 94c23107    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ad24: aa1d03fd    	mov	x29, x29
104b9ad28: 94c23108    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9ad2c: aa0003f3    	mov	x19, x0
104b9ad30: b00daec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9ad34: f9459500    	ldr	x0, [x8, #0xb28]
104b9ad38: d00dab28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b9ad3c: f945f501    	ldr	x1, [x8, #0xbe8] ; dataWithContentsOfFile:
104b9ad40: aa1303e2    	mov	x2, x19
104b9ad44: 94c230fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ad48: aa1d03fd    	mov	x29, x29
104b9ad4c: 94c230ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9ad50: aa0003f5    	mov	x21, x0
104b9ad54: b00daed8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104b9ad58: f9463b00    	ldr	x0, [x24, #0xc70]
104b9ad5c: b00d9f68    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104b9ad60: f9417501    	ldr	x1, [x8, #0x2e8] ; isSilkFile:
104b9ad64: aa1503e2    	mov	x2, x21
104b9ad68: 94c230f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ad6c: 36000060    	tbz	w0, #0x0, 0x104b9ad78 <_Flutter_MMFoundation_BindContext+0x107695c>
104b9ad70: 52800094    	mov	w20, #0x4               ; =4
104b9ad74: 1400000b    	b	0x104b9ada0 <_Flutter_MMFoundation_BindContext+0x1076984>
104b9ad78: f9463b00    	ldr	x0, [x24, #0xc70]
104b9ad7c: b00d9f68    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104b9ad80: f9417901    	ldr	x1, [x8, #0x2f0] ; isOpusFile:
104b9ad84: aa1503e2    	mov	x2, x21
104b9ad88: 94c230ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ad8c: 3100069f    	cmn	w20, #0x1
104b9ad90: 1a9403e8    	csel	w8, wzr, w20, eq
104b9ad94: 7100001f    	cmp	w0, #0x0
104b9ad98: 528000e9    	mov	w9, #0x7                ; =7
104b9ad9c: 1a881134    	csel	w20, w9, w8, ne
104b9ada0: f94536c0    	ldr	x0, [x22, #0xa68]
104b9ada4: f942aae1    	ldr	x1, [x23, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b9ada8: f00ce068    	adrp	x8, 0x11e7a9000 <dyld_stub_binder+0x11e7a9000>
104b9adac: 91292108    	add	x8, x8, #0xa48
104b9adb0: a90053e8    	stp	x8, x20, [sp]
104b9adb4: 900b6365    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9adb8: 911a58a5    	add	x5, x5, #0x696
104b9adbc: 900b6367    	adrp	x7, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9adc0: 911aace7    	add	x7, x7, #0x6ab
104b9adc4: 52800042    	mov	w2, #0x2                ; =2
104b9adc8: d2800003    	mov	x3, #0x0                ; =0
104b9adcc: 52800004    	mov	w4, #0x0                ; =0
104b9add0: 52801d66    	mov	w6, #0xeb               ; =235
104b9add4: 94c230da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9add8: aa1503e0    	mov	x0, x21
104b9addc: 94c230de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9ade0: aa1303e0    	mov	x0, x19
104b9ade4: 94c230dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9ade8: aa1403e0    	mov	x0, x20
104b9adec: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104b9adf0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104b9adf4: a94257f6    	ldp	x22, x21, [sp, #0x20]
104b9adf8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104b9adfc: 910143ff    	add	sp, sp, #0x50
104b9ae00: d65f03c0    	ret
