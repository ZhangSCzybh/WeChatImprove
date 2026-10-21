
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9cdd0: d10103ff    	sub	sp, sp, #0x40
104b9cdd4: a90157f6    	stp	x22, x21, [sp, #0x10]
104b9cdd8: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b9cddc: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b9cde0: 9100c3fd    	add	x29, sp, #0x30
104b9cde4: aa0203f3    	mov	x19, x2
104b9cde8: aa0003f4    	mov	x20, x0
104b9cdec: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9cdf0: b9826915    	ldrsw	x21, [x8, #0x268]
104b9cdf4: 7100145f    	cmp	w2, #0x5
104b9cdf8: 540002e1    	b.ne	0x104b9ce54 <_Flutter_MMFoundation_BindContext+0x1078a38>
104b9cdfc: b8756a88    	ldr	w8, [x20, x21]
104b9ce00: 7100151f    	cmp	w8, #0x5
104b9ce04: 54000280    	b.eq	0x104b9ce54 <_Flutter_MMFoundation_BindContext+0x1078a38>
104b9ce08: f00daea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9ce0c: f9453500    	ldr	x0, [x8, #0xa68]
104b9ce10: 900db448    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104b9ce14: b9825508    	ldrsw	x8, [x8, #0x254]
104b9ce18: b00d94e9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b9ce1c: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b9ce20: b8686a88    	ldr	w8, [x20, x8]
104b9ce24: b00ce069    	adrp	x9, 0x11e7a9000 <dyld_stub_binder+0x11e7a9000>
104b9ce28: 912da129    	add	x9, x9, #0xb68
104b9ce2c: a90023e9    	stp	x9, x8, [sp]
104b9ce30: d00b6345    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9ce34: 9123a0a5    	add	x5, x5, #0x8e8
104b9ce38: d00b6347    	adrp	x7, 0x11b806000 <dyld_stub_binder+0x11b806000>
104b9ce3c: 91266ce7    	add	x7, x7, #0x99b
104b9ce40: 52800042    	mov	w2, #0x2                ; =2
104b9ce44: d2800003    	mov	x3, #0x0                ; =0
104b9ce48: 52800004    	mov	w4, #0x0                ; =0
104b9ce4c: 52802f26    	mov	w6, #0x179              ; =377
104b9ce50: 94c228bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ce54: b8356a93    	str	w19, [x20, x21]
104b9ce58: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b9ce5c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b9ce60: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b9ce64: 910103ff    	add	sp, sp, #0x40
104b9ce68: d65f03c0    	ret
