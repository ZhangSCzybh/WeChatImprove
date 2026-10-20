
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0ed00: d10103ff    	sub	sp, sp, #0x40
105c0ed04: a90157f6    	stp	x22, x21, [sp, #0x10]
105c0ed08: a9024ff4    	stp	x20, x19, [sp, #0x20]
105c0ed0c: a9037bfd    	stp	x29, x30, [sp, #0x30]
105c0ed10: 9100c3fd    	add	x29, sp, #0x30
105c0ed14: aa0003f3    	mov	x19, x0
105c0ed18: 900d81a8    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c0ed1c: 52800029    	mov	w9, #0x1                ; =1
105c0ed20: 39101509    	strb	w9, [x8, #0x405]
105c0ed24: b00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0ed28: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c0ed2c: d00d2788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c0ed30: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105c0ed34: 94806102    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ed38: aa1d03fd    	mov	x29, x29
105c0ed3c: 94806103    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0ed40: aa0003f4    	mov	x20, x0
105c0ed44: f00d2b28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105c0ed48: f942fd00    	ldr	x0, [x8, #0x5f8] ; ��: 
105c0ed4c: b00d2788    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105c0ed50: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105c0ed54: 948060fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ed58: aa0003e2    	mov	x2, x0
105c0ed5c: f00d1148    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c0ed60: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105c0ed64: aa1403e0    	mov	x0, x20
105c0ed68: 948060f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ed6c: aa1d03fd    	mov	x29, x29
105c0ed70: 948060f6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0ed74: aa0003f5    	mov	x21, x0
105c0ed78: b00d2e88    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
105c0ed7c: 910b0108    	add	x8, x8, #0x2c0
105c0ed80: b9800108    	ldrsw	x8, [x8]
105c0ed84: f8686a62    	ldr	x2, [x19, x8]
105c0ed88: d00d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c0ed8c: f942a501    	ldr	x1, [x8, #0x548] ; getTranslateInfo:
105c0ed90: 948060eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ed94: aa1d03fd    	mov	x29, x29
105c0ed98: 948060ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0ed9c: aa0003f3    	mov	x19, x0
105c0eda0: aa1503e0    	mov	x0, x21
105c0eda4: 948060ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0eda8: aa1403e0    	mov	x0, x20
105c0edac: 948060ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0edb0: b40002d3    	cbz	x19, 0x105c0ee08 <_Flutter_MMFoundation_BindContext+0x20ea9ec>
105c0edb4: 900d1d88    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c0edb8: f941a101    	ldr	x1, [x8, #0x340] ; isTranslateFailed
105c0edbc: aa1303e0    	mov	x0, x19
105c0edc0: 948060df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0edc4: 37000220    	tbnz	w0, #0x0, 0x105c0ee08 <_Flutter_MMFoundation_BindContext+0x20ea9ec>
105c0edc8: d00d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c0edcc: f942c114    	ldr	x20, [x8, #0x580] ; translateStatus
105c0edd0: aa1303e0    	mov	x0, x19
105c0edd4: aa1403e1    	mov	x1, x20
105c0edd8: 948060d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0eddc: 34000160    	cbz	w0, 0x105c0ee08 <_Flutter_MMFoundation_BindContext+0x20ea9ec>
105c0ede0: aa1303e0    	mov	x0, x19
105c0ede4: aa1403e1    	mov	x1, x20
105c0ede8: 948060d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0edec: 7100041f    	cmp	w0, #0x1
105c0edf0: 540001e1    	b.ne	0x105c0ee2c <_Flutter_MMFoundation_BindContext+0x20eaa10>
105c0edf4: d00d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c0edf8: f942a901    	ldr	x1, [x8, #0x550] ; bNeedHideLoading
105c0edfc: aa1303e0    	mov	x0, x19
105c0ee00: 948060cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ee04: 36000140    	tbz	w0, #0x0, 0x105c0ee2c <_Flutter_MMFoundation_BindContext+0x20eaa10>
105c0ee08: 52800014    	mov	w20, #0x0               ; =0
105c0ee0c: aa1303e0    	mov	x0, x19
105c0ee10: 948060d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0ee14: aa1403e0    	mov	x0, x20
105c0ee18: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105c0ee1c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105c0ee20: a94157f6    	ldp	x22, x21, [sp, #0x10]
105c0ee24: 910103ff    	add	sp, sp, #0x40
105c0ee28: d65f03c0    	ret
105c0ee2c: d00d11e8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
105c0ee30: f9436501    	ldr	x1, [x8, #0x6c8] ; showOriginTextNow
105c0ee34: aa1303e0    	mov	x0, x19
105c0ee38: 948060c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ee3c: 52000014    	eor	w20, w0, #0x1
105c0ee40: b00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0ee44: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
105c0ee48: f00d1148    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c0ee4c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105c0ee50: b00c6188    	adrp	x8, 0x11e83f000 <dyld_stub_binder+0x11e83f000>
105c0ee54: 911aa108    	add	x8, x8, #0x6a8
105c0ee58: a90053e8    	stp	x8, x20, [sp]
105c0ee5c: 900ae8c5    	adrp	x5, 0x11b926000 <dyld_stub_binder+0x11b926000>
105c0ee60: 912d9ca5    	add	x5, x5, #0xb67
105c0ee64: 900ae8c7    	adrp	x7, 0x11b926000 <dyld_stub_binder+0x11b926000>
105c0ee68: 9130cce7    	add	x7, x7, #0xc33
105c0ee6c: 52800042    	mov	w2, #0x2                ; =2
105c0ee70: d2800003    	mov	x3, #0x0                ; =0
105c0ee74: 52800004    	mov	w4, #0x0                ; =0
105c0ee78: 52806606    	mov	w6, #0x330              ; =816
105c0ee7c: 948060b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0ee80: 17ffffe3    	b	0x105c0ee0c <_Flutter_MMFoundation_BindContext+0x20ea9f0>