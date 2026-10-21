
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104cc8794: d10143ff    	sub	sp, sp, #0x50
104cc8798: a9034ff4    	stp	x20, x19, [sp, #0x30]
104cc879c: a9047bfd    	stp	x29, x30, [sp, #0x40]
104cc87a0: 910103fd    	add	x29, sp, #0x40
104cc87a4: aa0003f3    	mov	x19, x0
104cc87a8: f00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cc87ac: f9453500    	ldr	x0, [x8, #0xa68]
104cc87b0: b00d8b88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cc87b4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cc87b8: b00cd768    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cc87bc: 9110a108    	add	x8, x8, #0x428
104cc87c0: f90003e8    	str	x8, [sp]
104cc87c4: f00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc87c8: 911a5863    	add	x3, x3, #0x696
104cc87cc: f00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc87d0: 9129b4a5    	add	x5, x5, #0xa6d
104cc87d4: f00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc87d8: 912ad0e7    	add	x7, x7, #0xab4
104cc87dc: 52800042    	mov	w2, #0x2                ; =2
104cc87e0: 52800004    	mov	w4, #0x0                ; =0
104cc87e4: 52800aa6    	mov	w6, #0x55               ; =85
104cc87e8: 94bd7a55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc87ec: f00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cc87f0: f946a500    	ldr	x0, [x8, #0xd48]
104cc87f4: f00da1c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104cc87f8: f9444d01    	ldr	x1, [x8, #0x898] ; isMainThread
104cc87fc: 94bd7a50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc8800: 34000100    	cbz	w0, 0x104cc8820 <_Flutter_MMFoundation_BindContext+0x11a4404>
104cc8804: 900d9628    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc8808: f9449501    	ldr	x1, [x8, #0x928] ; internalCheckMsgQueue
104cc880c: aa1303e0    	mov	x0, x19
104cc8810: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104cc8814: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104cc8818: 910143ff    	add	sp, sp, #0x50
104cc881c: 14bd7a48    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc8820: d00c4928    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
104cc8824: f947e108    	ldr	x8, [x8, #0xfc0]
104cc8828: f90007e8    	str	x8, [sp, #0x8]
104cc882c: b00a05c8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
104cc8830: fd41c100    	ldr	d0, [x8, #0x380]
104cc8834: 90000008    	adrp	x8, 0x104cc8000 <_Flutter_MMFoundation_BindContext+0x11a3be4>
104cc8838: 9121c108    	add	x8, x8, #0x870
104cc883c: fd000be0    	str	d0, [sp, #0x10]
104cc8840: d00c4969    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
104cc8844: 9115c129    	add	x9, x9, #0x570
104cc8848: a901a7e8    	stp	x8, x9, [sp, #0x18]
104cc884c: f90017f3    	str	x19, [sp, #0x28]
104cc8850: f00c4920    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104cc8854: f9408c00    	ldr	x0, [x0, #0x118]
104cc8858: 910023e1    	add	x1, sp, #0x8
104cc885c: 94bd1271    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
104cc8860: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104cc8864: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104cc8868: 910143ff    	add	sp, sp, #0x50
104cc886c: d65f03c0    	ret
