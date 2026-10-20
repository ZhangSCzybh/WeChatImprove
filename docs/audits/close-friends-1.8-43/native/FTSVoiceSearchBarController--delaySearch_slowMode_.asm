
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182a308: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10182a30c: a90157f6    	stp	x22, x21, [sp, #0x10]
10182a310: a9024ff4    	stp	x20, x19, [sp, #0x20]
10182a314: a9037bfd    	stp	x29, x30, [sp, #0x30]
10182a318: 9100c3fd    	add	x29, sp, #0x30
10182a31c: aa0303f6    	mov	x22, x3
10182a320: aa0203f3    	mov	x19, x2
10182a324: aa0003f4    	mov	x20, x0
10182a328: b00f4a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10182a32c: f9467517    	ldr	x23, [x8, #0xce8]
10182a330: d00f32e8    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10182a334: f942fd15    	ldr	x21, [x8, #0x5f8] ; delaySearchImp:
10182a338: 900f3088    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10182a33c: f9407d18    	ldr	x24, [x8, #0xf8] ; safeCancelPreviousPerformRequestsWithTarget:selector:object:
10182a340: aa0203e0    	mov	x0, x2
10182a344: 958ff37d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10182a348: aa1703e0    	mov	x0, x23
10182a34c: aa1803e1    	mov	x1, x24
10182a350: aa1403e2    	mov	x2, x20
10182a354: aa1503e3    	mov	x3, x21
10182a358: aa1303e4    	mov	x4, x19
10182a35c: 958ff378    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a360: 36000156    	tbz	w22, #0x0, 0x10182a388 <__text+0x1822388>
10182a364: 900f3088    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10182a368: f9408101    	ldr	x1, [x8, #0x100] ; safePerformSelector:withObject:afterDelay:
10182a36c: f00baaa8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10182a370: fd42c100    	ldr	d0, [x8, #0x580]
10182a374: aa1403e0    	mov	x0, x20
10182a378: aa1503e2    	mov	x2, x21
10182a37c: aa1303e3    	mov	x3, x19
10182a380: 958ff36f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a384: 14000005    	b	0x10182a398 <__text+0x1822398>
10182a388: aa1403e0    	mov	x0, x20
10182a38c: aa1503e1    	mov	x1, x21
10182a390: aa1303e2    	mov	x2, x19
10182a394: 958ff36a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a398: aa1303e0    	mov	x0, x19
10182a39c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10182a3a0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10182a3a4: a94157f6    	ldp	x22, x21, [sp, #0x10]
10182a3a8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10182a3ac: 158ff36a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
