
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017ea0c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10017ea10: a9014ff4    	stp	x20, x19, [sp, #0x10]
10017ea14: a9027bfd    	stp	x29, x30, [sp, #0x20]
10017ea18: 910083fd    	add	x29, sp, #0x20
10017ea1c: 52800000    	mov	w0, #0x0                ; =0
10017ea20: f0105568    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
10017ea24: 52800029    	mov	w9, #0x1                ; =1
10017ea28: 391f4909    	strb	w9, [x8, #0x7d2]
10017ea2c: 71000c7f    	cmp	w3, #0x3
10017ea30: 5400012c    	b.gt	0x10017ea54 <__text+0x176a54>
10017ea34: 34000483    	cbz	w3, 0x10017eac4 <__text+0x176ac4>
10017ea38: 7100047f    	cmp	w3, #0x1
10017ea3c: 54000901    	b.ne	0x10017eb5c <__text+0x176b5c>
10017ea40: 52911128    	mov	w8, #0x8889             ; =34953
10017ea44: 72b11108    	movk	w8, #0x8888, lsl #16
10017ea48: 9ba87c48    	umull	x8, w2, w8
10017ea4c: d365fd08    	lsr	x8, x8, #37
10017ea50: 14000022    	b	0x10017ead8 <__text+0x176ad8>
10017ea54: 7100107f    	cmp	w3, #0x4
10017ea58: 54000460    	b.eq	0x10017eae4 <__text+0x176ae4>
10017ea5c: 71001c7f    	cmp	w3, #0x7
10017ea60: 540007e1    	b.ne	0x10017eb5c <__text+0x176b5c>
10017ea64: b00fffa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10017ea68: f945e900    	ldr	x0, [x8, #0xbd0]
10017ea6c: d00ffc08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10017ea70: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10017ea74: 95eaa1b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017ea78: aa1d03fd    	mov	x29, x29
10017ea7c: 95eaa1b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017ea80: aa0003f3    	mov	x19, x0
10017ea84: f00fffa8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10017ea88: f9405100    	ldr	x0, [x8, #0xa0]
10017ea8c: b00ffc08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10017ea90: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10017ea94: 95eaa1aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017ea98: aa0003e2    	mov	x2, x0
10017ea9c: f00fe5c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017eaa0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10017eaa4: aa1303e0    	mov	x0, x19
10017eaa8: 95eaa1a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017eaac: aa1d03fd    	mov	x29, x29
10017eab0: 95eaa1a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017eab4: aa0003f4    	mov	x20, x0
10017eab8: b00fe628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017eabc: f946b101    	ldr	x1, [x8, #0xd60] ; opusAudioDuration
10017eac0: 14000020    	b	0x10017eb40 <__text+0x176b40>
10017eac4: 53017c48    	lsr	w8, w2, #1
10017eac8: 52849269    	mov	w9, #0x2493             ; =9363
10017eacc: 72b24929    	movk	w9, #0x9249, lsl #16
10017ead0: 9ba97d08    	umull	x8, w8, w9
10017ead4: d362fd08    	lsr	x8, x8, #34
10017ead8: 0b080908    	add	w8, w8, w8, lsl #2
10017eadc: 531e7500    	lsl	w0, w8, #2
10017eae0: 1400001f    	b	0x10017eb5c <__text+0x176b5c>
10017eae4: b00fffa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10017eae8: f945e900    	ldr	x0, [x8, #0xbd0]
10017eaec: d00ffc08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10017eaf0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10017eaf4: 95eaa192    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017eaf8: aa1d03fd    	mov	x29, x29
10017eafc: 95eaa193    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017eb00: aa0003f3    	mov	x19, x0
10017eb04: f00fffa8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10017eb08: f9405100    	ldr	x0, [x8, #0xa0]
10017eb0c: b00ffc08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10017eb10: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10017eb14: 95eaa18a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017eb18: aa0003e2    	mov	x2, x0
10017eb1c: f00fe5c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017eb20: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10017eb24: aa1303e0    	mov	x0, x19
10017eb28: 95eaa185    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017eb2c: aa1d03fd    	mov	x29, x29
10017eb30: 95eaa186    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017eb34: aa0003f4    	mov	x20, x0
10017eb38: b00fe628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017eb3c: f946ad01    	ldr	x1, [x8, #0xd58] ; silkAudioDuration
10017eb40: 95eaa17f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017eb44: aa0003f5    	mov	x21, x0
10017eb48: aa1403e0    	mov	x0, x20
10017eb4c: 95eaa182    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017eb50: aa1303e0    	mov	x0, x19
10017eb54: 95eaa180    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017eb58: aa1503e0    	mov	x0, x21
10017eb5c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10017eb60: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10017eb64: a8c357f6    	ldp	x22, x21, [sp], #0x30
10017eb68: d65f03c0    	ret