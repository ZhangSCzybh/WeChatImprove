
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471ec04: d101c3ff    	sub	sp, sp, #0x70
10471ec08: a90267fa    	stp	x26, x25, [sp, #0x20]
10471ec0c: a9035ff8    	stp	x24, x23, [sp, #0x30]
10471ec10: a90457f6    	stp	x22, x21, [sp, #0x40]
10471ec14: a9054ff4    	stp	x20, x19, [sp, #0x50]
10471ec18: a9067bfd    	stp	x29, x30, [sp, #0x60]
10471ec1c: 910183fd    	add	x29, sp, #0x60
10471ec20: aa0203f3    	mov	x19, x2
10471ec24: aa0003f4    	mov	x20, x0
10471ec28: f00e28e8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10471ec2c: 52800029    	mov	w9, #0x1                ; =1
10471ec30: 39195509    	strb	w9, [x8, #0x655]
10471ec34: d00dd528    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
10471ec38: f945fd08    	ldr	x8, [x8, #0xbf8] ; ��6
10471ec3c: a90123e0    	stp	x0, x8, [sp, #0x10]
10471ec40: d00dcf48    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10471ec44: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
10471ec48: 910043e0    	add	x0, sp, #0x10
10471ec4c: 94d4213e    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10471ec50: b00dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471ec54: f9453500    	ldr	x0, [x8, #0xa68] ; �gH
10471ec58: f00db8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10471ec5c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10471ec60: 900d0268    	adrp	x8, 0x11e76a000 <dyld_stub_binder+0x11e76a000>
10471ec64: 91332108    	add	x8, x8, #0xcc8
10471ec68: a9004fe8    	stp	x8, x19, [sp]
10471ec6c: d00b83c5    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
10471ec70: 910b10a5    	add	x5, x5, #0x2c4
10471ec74: d00b83c7    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
10471ec78: 910f3ce7    	add	x7, x7, #0x3cf
10471ec7c: 52800042    	mov	w2, #0x2                ; =2
10471ec80: d2800003    	mov	x3, #0x0                ; =0
10471ec84: 52800004    	mov	w4, #0x0                ; =0
10471ec88: 528016e6    	mov	w6, #0xb7               ; =183
10471ec8c: 94d4212c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ec90: 900dba48    	adrp	x8, 0x11fe66000 <dyld_stub_binder+0x11fe66000>
10471ec94: f943d915    	ldr	x21, [x8, #0x7b0] ; customDelegate
10471ec98: aa1403e0    	mov	x0, x20
10471ec9c: aa1503e1    	mov	x1, x21
10471eca0: 94d42127    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471eca4: aa1d03fd    	mov	x29, x29
10471eca8: 94d42128    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471ecac: b40003e0    	cbz	x0, 0x10471ed28 <_Flutter_MMFoundation_BindContext+0xbfa90c>
10471ecb0: aa0003f7    	mov	x23, x0
10471ecb4: aa1403e0    	mov	x0, x20
10471ecb8: aa1503e1    	mov	x1, x21
10471ecbc: 94d42120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ecc0: aa1d03fd    	mov	x29, x29
10471ecc4: 94d42121    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471ecc8: aa0003f8    	mov	x24, x0
10471eccc: f00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471ecd0: f9458916    	ldr	x22, [x8, #0xb10] ; onTabBarHiddenChanged:
10471ecd4: 900dcf48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10471ecd8: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
10471ecdc: aa1603e2    	mov	x2, x22
10471ece0: 94d42117    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ece4: aa0003f9    	mov	x25, x0
10471ece8: aa1803e0    	mov	x0, x24
10471ecec: 94d4211a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471ecf0: aa1703e0    	mov	x0, x23
10471ecf4: 94d42118    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471ecf8: 34000199    	cbz	w25, 0x10471ed28 <_Flutter_MMFoundation_BindContext+0xbfa90c>
10471ecfc: aa1403e0    	mov	x0, x20
10471ed00: aa1503e1    	mov	x1, x21
10471ed04: 94d4210e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ed08: aa1d03fd    	mov	x29, x29
10471ed0c: 94d4210f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471ed10: aa0003f4    	mov	x20, x0
10471ed14: aa1603e1    	mov	x1, x22
10471ed18: aa1303e2    	mov	x2, x19
10471ed1c: 94d42108    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471ed20: aa1403e0    	mov	x0, x20
10471ed24: 94d4210c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471ed28: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10471ed2c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10471ed30: a94457f6    	ldp	x22, x21, [sp, #0x40]
10471ed34: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10471ed38: a94267fa    	ldp	x26, x25, [sp, #0x20]
10471ed3c: 9101c3ff    	add	sp, sp, #0x70
10471ed40: d65f03c0    	ret
10471ed44: d10103ff    	sub	sp, sp, #0x40
10471ed48: 6d0223e9    	stp	d9, d8, [sp, #0x20]
10471ed4c: a9037bfd    	stp	x29, x30, [sp, #0x30]
10471ed50: 9100c3fd    	add	x29, sp, #0x30
10471ed54: 1e604008    	fmov	d8, d0
10471ed58: d00dd528    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
10471ed5c: f945fd08    	ldr	x8, [x8, #0xbf8] ; ��6
10471ed60: a90123e0    	stp	x0, x8, [sp, #0x10]
10471ed64: 900dcf48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10471ed68: f9476901    	ldr	x1, [x8, #0xed0] ; setAlpha:
10471ed6c: 910043e0    	add	x0, sp, #0x10
10471ed70: 94d420f5    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10471ed74: b00dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471ed78: f9453500    	ldr	x0, [x8, #0xa68] ; �gH
10471ed7c: f00db8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10471ed80: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10471ed84: fd0007e8    	str	d8, [sp, #0x8]
10471ed88: 900d0268    	adrp	x8, 0x11e76a000 <dyld_stub_binder+0x11e76a000>
10471ed8c: 9133a108    	add	x8, x8, #0xce8
10471ed90: f90003e8    	str	x8, [sp]
10471ed94: d00b83c5    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
10471ed98: 910b10a5    	add	x5, x5, #0x2c4
10471ed9c: d00b83c7    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
10471eda0: 910fd8e7    	add	x7, x7, #0x3f6
10471eda4: 52800042    	mov	w2, #0x2                ; =2
10471eda8: d2800003    	mov	x3, #0x0                ; =0
10471edac: 52800004    	mov	w4, #0x0                ; =0
10471edb0: 528017a6    	mov	w6, #0xbd               ; =189
10471edb4: 94d420e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471edb8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10471edbc: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
10471edc0: 910103ff    	add	sp, sp, #0x40
10471edc4: d65f03c0    	ret
