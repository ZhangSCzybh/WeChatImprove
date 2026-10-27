
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1028b7610: d100c3ff    	sub	sp, sp, #0x30
1028b7614: a9014ff4    	stp	x20, x19, [sp, #0x10]
1028b7618: a9027bfd    	stp	x29, x30, [sp, #0x20]
1028b761c: 910083fd    	add	x29, sp, #0x20
1028b7620: aa0003f3    	mov	x19, x0
1028b7624: 900ead28    	adrp	x8, 0x11fe5b000 <dyld_stub_binder+0x11fe5b000>
1028b7628: f940fd01    	ldr	x1, [x8, #0x1f8] ; stringByEscapingAllLineBreak
1028b762c: aa0203e0    	mov	x0, x2
1028b7630: 954dbec3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028b7634: aa1d03fd    	mov	x29, x29
1028b7638: 954dbec4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028b763c: aa0003f4    	mov	x20, x0
1028b7640: 900ec848    	adrp	x8, 0x1201bf000 <dyld_stub_binder+0x1201bf000>
1028b7644: f942c908    	ldr	x8, [x8, #0x590] ; NoLineBreakLabel
1028b7648: a90023f3    	stp	x19, x8, [sp]
1028b764c: d00ec288    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1028b7650: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
1028b7654: 910003e0    	mov	x0, sp
1028b7658: aa1403e2    	mov	x2, x20
1028b765c: 954dbeba    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1028b7660: aa1403e0    	mov	x0, x20
1028b7664: 954dbebc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028b7668: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1028b766c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1028b7670: 9100c3ff    	add	sp, sp, #0x30
1028b7674: d65f03c0    	ret
