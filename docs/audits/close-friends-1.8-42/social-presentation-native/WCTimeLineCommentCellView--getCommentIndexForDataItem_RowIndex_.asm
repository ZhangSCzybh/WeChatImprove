
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a09ad94: d10183ff    	sub	sp, sp, #0x60
10a09ad98: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a09ad9c: a90357f6    	stp	x22, x21, [sp, #0x30]
10a09ada0: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a09ada4: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a09ada8: 910143fd    	add	x29, sp, #0x50
10a09adac: aa0303f4    	mov	x20, x3
10a09adb0: aa0203f3    	mov	x19, x2
10a09adb4: aa0203e0    	mov	x0, x2
10a09adb8: 955f01a2    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09adbc: 900aede8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a09adc0: f9447501    	ldr	x1, [x8, #0x8e8] ; likeCount
10a09adc4: aa1303e0    	mov	x0, x19
10a09adc8: 955f019f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09adcc: 7100041f    	cmp	w0, #0x1
10a09add0: 92800028    	mov	x8, #-0x2               ; =-2
10a09add4: 9a88a508    	cinc	x8, x8, lt
10a09add8: 900aee09    	adrp	x9, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a09addc: f9465536    	ldr	x22, [x9, #0xca8] ; commentCount
10a09ade0: ab140115    	adds	x21, x8, x20
10a09ade4: 540000c4    	b.mi	0x10a09adfc <_Flutter_MMFoundation_BindContext+0x65769e0>
10a09ade8: aa1303e0    	mov	x0, x19
10a09adec: aa1603e1    	mov	x1, x22
10a09adf0: 955f0195    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09adf4: eb20c2bf    	cmp	x21, w0, sxtw
10a09adf8: 5400030b    	b.lt	0x10a09ae58 <_Flutter_MMFoundation_BindContext+0x6576a3c>
10a09adfc: b00b06c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a09ae00: f9453517    	ldr	x23, [x8, #0xa68]
10a09ae04: aa1303e0    	mov	x0, x19
10a09ae08: aa1603e1    	mov	x1, x22
10a09ae0c: 955f018e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ae10: 93407c08    	sxtw	x8, w0
10a09ae14: f00aece9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a09ae18: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a09ae1c: a90123f5    	stp	x21, x8, [sp, #0x10]
10a09ae20: b00a4d28    	adrp	x8, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a09ae24: 9120a108    	add	x8, x8, #0x828
10a09ae28: a90053e8    	stp	x8, x20, [sp]
10a09ae2c: d008e345    	adrp	x5, 0x11bd04000 <dyld_stub_binder+0x11bd04000>
10a09ae30: 913a70a5    	add	x5, x5, #0xe9c
10a09ae34: d008e347    	adrp	x7, 0x11bd04000 <dyld_stub_binder+0x11bd04000>
10a09ae38: 913b18e7    	add	x7, x7, #0xec6
10a09ae3c: aa1703e0    	mov	x0, x23
10a09ae40: 52800082    	mov	w2, #0x4                ; =4
10a09ae44: d2800003    	mov	x3, #0x0                ; =0
10a09ae48: 52800004    	mov	w4, #0x0                ; =0
10a09ae4c: 52802806    	mov	w6, #0x140              ; =320
10a09ae50: 955f017d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09ae54: 92f00015    	mov	x21, #0x7fffffffffffffff ; =9223372036854775807
10a09ae58: aa1303e0    	mov	x0, x19
10a09ae5c: 955f0180    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09ae60: aa1503e0    	mov	x0, x21
10a09ae64: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a09ae68: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a09ae6c: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a09ae70: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a09ae74: 910183ff    	add	sp, sp, #0x60
10a09ae78: d65f03c0    	ret
