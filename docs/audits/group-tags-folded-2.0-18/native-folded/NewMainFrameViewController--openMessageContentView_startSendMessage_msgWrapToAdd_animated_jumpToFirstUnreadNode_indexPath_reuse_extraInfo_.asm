
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511ceac: d10343ff    	sub	sp, sp, #0xd0
10511ceb0: a9076ffc    	stp	x28, x27, [sp, #0x70]
10511ceb4: a90867fa    	stp	x26, x25, [sp, #0x80]
10511ceb8: a9095ff8    	stp	x24, x23, [sp, #0x90]
10511cebc: a90a57f6    	stp	x22, x21, [sp, #0xa0]
10511cec0: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
10511cec4: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10511cec8: 910303fd    	add	x29, sp, #0xc0
10511cecc: aa0703f3    	mov	x19, x7
10511ced0: b9002fe6    	str	w6, [sp, #0x2c]
10511ced4: aa0503f7    	mov	x23, x5
10511ced8: aa0403f5    	mov	x21, x4
10511cedc: aa0303f9    	mov	x25, x3
10511cee0: aa0203f4    	mov	x20, x2
10511cee4: aa0003fa    	mov	x26, x0
10511cee8: 394043bc    	ldrb	w28, [x29, #0x10]
10511ceec: f9400fb8    	ldr	x24, [x29, #0x18]
10511cef0: f00dd908    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10511cef4: 52800029    	mov	w9, #0x1                ; =1
10511cef8: 392df509    	strb	w9, [x8, #0xb7d]
10511cefc: aa0203e0    	mov	x0, x2
10511cf00: 94ac288e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511cf04: aa1303e0    	mov	x0, x19
10511cf08: 94ac288c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511cf0c: aa1803e0    	mov	x0, x24
10511cf10: 94ac288a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511cf14: aa1503e0    	mov	x0, x21
10511cf18: 94ac2888    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511cf1c: d10163a0    	sub	x0, x29, #0x58
10511cf20: aa1a03e1    	mov	x1, x26
10511cf24: 94ac2892    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
10511cf28: d00c2688    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10511cf2c: f947e108    	ldr	x8, [x8, #0xfc0]
10511cf30: f9001be8    	str	x8, [sp, #0x30]
10511cf34: b009e328    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10511cf38: fd41c100    	ldr	d0, [x8, #0x380]
10511cf3c: b0000008    	adrp	x8, 0x10511d000 <_Flutter_MMFoundation_BindContext+0x15f8be4>
10511cf40: 91004108    	add	x8, x8, #0x10
10511cf44: fd001fe0    	str	d0, [sp, #0x38]
10511cf48: f00c26e9    	adrp	x9, 0x11d5fb000 <dyld_stub_binder+0x11d5fb000>
10511cf4c: 91056129    	add	x9, x9, #0x158
10511cf50: a90427e8    	stp	x8, x9, [sp, #0x40]
10511cf54: 9100c3f6    	add	x22, sp, #0x30
10511cf58: 9100c2c0    	add	x0, x22, #0x30
10511cf5c: d10163a1    	sub	x1, x29, #0x58
10511cf60: 94ac2886    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
10511cf64: a9054ff4    	stp	x20, x19, [sp, #0x50]
10511cf68: d00d73e8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511cf6c: f947e51b    	ldr	x27, [x8, #0xfc8] ; openMessageContentView:startSendMessage:msgWrapToAdd:animated:jumpToFirstUnreadNode:indexPath:reuse:extraInfo:navigationController:completion:
10511cf70: aa1303e0    	mov	x0, x19
10511cf74: 94ac2871    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511cf78: aa1403e0    	mov	x0, x20
10511cf7c: 94ac286f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511cf80: a9015bff    	stp	xzr, x22, [sp, #0x10]
10511cf84: f90007f8    	str	x24, [sp, #0x8]
10511cf88: 390003fc    	strb	w28, [sp]
10511cf8c: aa1a03e0    	mov	x0, x26
10511cf90: aa1b03e1    	mov	x1, x27
10511cf94: aa1403e2    	mov	x2, x20
10511cf98: aa1903e3    	mov	x3, x25
10511cf9c: aa1503e4    	mov	x4, x21
10511cfa0: aa1703e5    	mov	x5, x23
10511cfa4: b9402fe6    	ldr	w6, [sp, #0x2c]
10511cfa8: aa1303e7    	mov	x7, x19
10511cfac: 94ac2864    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511cfb0: aa1803e0    	mov	x0, x24
10511cfb4: 94ac2868    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511cfb8: aa1503e0    	mov	x0, x21
10511cfbc: 94ac2866    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511cfc0: f9402fe0    	ldr	x0, [sp, #0x58]
10511cfc4: 94ac2864    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511cfc8: f9402be0    	ldr	x0, [sp, #0x50]
10511cfcc: 94ac2862    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511cfd0: aa1303e0    	mov	x0, x19
10511cfd4: 94ac2860    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511cfd8: aa1403e0    	mov	x0, x20
10511cfdc: 94ac285e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511cfe0: 9100c2c0    	add	x0, x22, #0x30
10511cfe4: 94ac286b    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10511cfe8: d10163a0    	sub	x0, x29, #0x58
10511cfec: 94ac2869    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
10511cff0: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
10511cff4: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
10511cff8: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
10511cffc: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10511d000: a94867fa    	ldp	x26, x25, [sp, #0x80]
10511d004: a9476ffc    	ldp	x28, x27, [sp, #0x70]
10511d008: 910343ff    	add	sp, sp, #0xd0
10511d00c: d65f03c0    	ret
