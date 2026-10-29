
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116715630: d101c3ff    	sub	sp, sp, #0x70
116715634: a9054ff4    	stp	x20, x19, [sp, #0x50]
116715638: a9067bfd    	stp	x29, x30, [sp, #0x60]
11671563c: 910183fd    	add	x29, sp, #0x60
116715640: ad0107e0    	stp	q0, q1, [sp, #0x20]
116715644: aa0003f3    	mov	x19, x0
116715648: f004d2e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
11671564c: f9406100    	ldr	x0, [x8, #0xc0] ; class UIScreen
116715650: f004cf68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
116715654: f9413101    	ldr	x1, [x8, #0x260] ; selector mainScreen
116715658: 947051a5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671565c: aa1d03fd    	mov	x29, x29
116715660: 947051cd    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116715664: aa0003f4    	mov	x20, x0
116715668: b004cf88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
11671566c: f944d901    	ldr	x1, [x8, #0x9b0] ; selector scale
116715670: 9470519f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715674: 3d8007e0    	str	q0, [sp, #0x10]
116715678: aa1403e0    	mov	x0, x20
11671567c: 947051b7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116715680: 9004cf68    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
116715684: f945a114    	ldr	x20, [x8, #0xb40] ; selector frame
116715688: aa1303e0    	mov	x0, x19
11671568c: aa1403e1    	mov	x1, x20
116715690: 94705197    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715694: 3d8003e2    	str	q2, [sp]
116715698: aa1303e0    	mov	x0, x19
11671569c: aa1403e1    	mov	x1, x20
1167156a0: 94705193    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167156a4: 3dc003e1    	ldr	q1, [sp]
1167156a8: 6e180461    	mov.d	v1[1], v3[0]
1167156ac: 6f07f400    	fmov.2d	v0, #-0.50000000
1167156b0: 6e60dc20    	fmul.2d	v0, v1, v0
1167156b4: ad410be1    	ldp	q1, q2, [sp, #0x20]
1167156b8: 6e180441    	mov.d	v1[1], v2[0]
1167156bc: 4e60d420    	fadd.2d	v0, v1, v0
1167156c0: 4ea11c23    	mov.16b	v3, v1
1167156c4: 3dc007e2    	ldr	q2, [sp, #0x10]
1167156c8: 4e080441    	dup.2d	v1, v2[0]
1167156cc: 4fc29002    	fmul.2d	v2, v0, v2[0]
1167156d0: 6ee19842    	frinti.2d	v2, v2
1167156d4: 6e61fc41    	fdiv.2d	v1, v2, v1
1167156d8: 4ee0d420    	fsub.2d	v0, v1, v0
1167156dc: 4e60d460    	fadd.2d	v0, v3, v0
1167156e0: b004d628    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1167156e4: f9459908    	ldr	x8, [x8, #0xb30]
1167156e8: a93e23b3    	stp	x19, x8, [x29, #-0x20]
1167156ec: d004cf88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1167156f0: f9425101    	ldr	x1, [x8, #0x4a0] ; selector setCenter:
1167156f4: 5e180401    	mov	d1, v0[1]
1167156f8: d10083a0    	sub	x0, x29, #0x20
1167156fc: 9470517f    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116715700: a9467bfd    	ldp	x29, x30, [sp, #0x60]
116715704: a9454ff4    	ldp	x20, x19, [sp, #0x50]
116715708: 9101c3ff    	add	sp, sp, #0x70
11671570c: d65f03c0    	ret
