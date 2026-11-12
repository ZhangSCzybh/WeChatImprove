
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000010aec2da4 <_mmkv_importFrom>:
10b635598: a9bc6ffc    	stp	x28, x27, [sp, #-0x40]!
10b63559c: a90157f6    	stp	x22, x21, [sp, #0x10]
10b6355a0: a9024ff4    	stp	x20, x19, [sp, #0x20]
10b6355a4: a9037bfd    	stp	x29, x30, [sp, #0x30]
10b6355a8: 9100c3fd    	add	x29, sp, #0x30
10b6355ac: d10783ff    	sub	sp, sp, #0x1e0
10b6355b0: aa0203f4    	mov	x20, x2
10b6355b4: aa0003f3    	mov	x19, x0
10b6355b8: f00908a8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10b6355bc: f9451908    	ldr	x8, [x8, #0xa30] ; 0x11d74ca30 __got
10b6355c0: f9400108    	ldr	x8, [x8]
10b6355c4: f81c83a8    	stur	x8, [x29, #-0x38]
10b6355c8: 39017fe1    	strb	w1, [sp, #0x5f]
10b6355cc: a904ffff    	stp	xzr, xzr, [sp, #0x48]
10b6355d0: f9400c00    	ldr	x0, [x0, #0x18]
10b6355d4: 52800148    	mov	w8, #0xa                ; =10
10b6355d8: 9102a3e9    	add	x9, sp, #0xa8
10b6355dc: a914a7e8    	stp	x8, x9, [sp, #0x148]
10b6355e0: a91583ff    	stp	xzr, x0, [sp, #0x158]
10b6355e4: 9508a9d7    	bl	0x10f85fd40 <_GetBoxIamBizTLRecFeedsDataUtil+0xdee24>
10b6355e8: f9400668    	ldr	x8, [x19, #0x8]
10b6355ec: b4000248    	cbz	x8, 0x10b635634 <_mmkv_importFrom+0x772890>
10b6355f0: 91002108    	add	x8, x8, #0x8
10b6355f4: 88dffd08    	ldar	w8, [x8]
10b6355f8: 7100051f    	cmp	w8, #0x1
10b6355fc: 540001c1    	b.ne	0x10b635634 <_mmkv_importFrom+0x772890>
10b635600: f9400268    	ldr	x8, [x19]
10b635604: f9400109    	ldr	x9, [x8]
10b635608: f9400a68    	ldr	x8, [x19, #0x10]
10b63560c: eb09011f    	cmp	x8, x9
10b635610: 54000041    	b.ne	0x10b635618 <_mmkv_importFrom+0x772874>
10b635614: f9400528    	ldr	x8, [x9, #0x8]
10b635618: f90043e8    	str	x8, [sp, #0x80]
10b63561c: 9102a3e1    	add	x1, sp, #0xa8
10b635620: 910203e3    	add	x3, sp, #0x80
10b635624: aa1303e0    	mov	x0, x19
10b635628: 52800002    	mov	w2, #0x0                ; =0
10b63562c: 52800024    	mov	w4, #0x1                ; =1
10b635630: 97fff9cd    	bl	0x10b633d64 <_mmkv_importFrom+0x770fc0>
10b635634: 910123e0    	add	x0, sp, #0x48
10b635638: aa1303e1    	mov	x1, x19
10b63563c: 97fff9a1    	bl	0x10b633cc0 <_mmkv_importFrom+0x770f1c>
10b635640: f940b3e0    	ldr	x0, [sp, #0x160]
10b635644: 9508a9c1    	bl	0x10f85fd48 <_GetBoxIamBizTLRecFeedsDataUtil+0xdee2c>
10b635648: f940abe8    	ldr	x8, [sp, #0x150]
10b63564c: b4000088    	cbz	x8, 0x10b63565c <_mmkv_importFrom+0x7728b8>
10b635650: 9102a3e0    	add	x0, sp, #0xa8
10b635654: 910203e1    	add	x1, sp, #0x80
10b635658: 97fffaf6    	bl	0x10b634230 <_mmkv_importFrom+0x77148c>
10b63565c: 3902a3ff    	strb	wzr, [sp, #0xa8]
10b635660: 9102a3f6    	add	x22, sp, #0xa8
10b635664: 910022c8    	add	x8, x22, #0x8
10b635668: 52800149    	mov	w9, #0xa                ; =10
10b63566c: a91a23e9    	stp	x9, x8, [sp, #0x1a0]
10b635670: 91017fe8    	add	x8, sp, #0x5f
10b635674: a91b23ff    	stp	xzr, x8, [sp, #0x1b0]
10b635678: a91cffff    	stp	xzr, xzr, [sp, #0x1c8]
10b63567c: f900e3f4    	str	x20, [sp, #0x1c0]
10b635680: f94027e8    	ldr	x8, [sp, #0x48]
10b635684: f9400114    	ldr	x20, [x8]
10b635688: f9400915    	ldr	x21, [x8, #0x10]
10b63568c: f9400688    	ldr	x8, [x20, #0x8]
10b635690: a902d3e8    	stp	x8, x20, [sp, #0x28]
10b635694: a903d3f6    	stp	x22, x20, [sp, #0x38]
10b635698: 9100a3e0    	add	x0, sp, #0x28
10b63569c: 94000092    	bl	0x10b6358e4 <_mmkv_importFrom+0x772b40>
10b6356a0: f94027e8    	ldr	x8, [sp, #0x48]
10b6356a4: f9400108    	ldr	x8, [x8]
10b6356a8: a900a3e8    	stp	x8, x8, [sp, #0x8]
10b6356ac: a901a3f6    	stp	x22, x8, [sp, #0x18]
10b6356b0: 910023e0    	add	x0, sp, #0x8
10b6356b4: 9400008c    	bl	0x10b6358e4 <_mmkv_importFrom+0x772b40>
10b6356b8: 3cc283e0    	ldur	q0, [sp, #0x28]
10b6356bc: 3cc383e1    	ldur	q1, [sp, #0x38]
10b6356c0: ad0407e0    	stp	q0, q1, [sp, #0x80]
10b6356c4: 3cc083e0    	ldur	q0, [sp, #0x8]
10b6356c8: 3cc183e1    	ldur	q1, [sp, #0x18]
10b6356cc: ad0307e0    	stp	q0, q1, [sp, #0x60]
10b6356d0: 910203e1    	add	x1, sp, #0x80
10b6356d4: 910183e2    	add	x2, sp, #0x60
10b6356d8: aa1503e0    	mov	x0, x21
10b6356dc: 9400002d    	bl	0x10b635790 <_mmkv_importFrom+0x7729ec>
10b6356e0: b941cfe8    	ldr	w8, [sp, #0x1cc]
10b6356e4: b941cbe9    	ldr	w9, [sp, #0x1c8]
10b6356e8: 6b09011f    	cmp	w8, w9
10b6356ec: 54000089    	b.ls	0x10b6356fc <_mmkv_importFrom+0x772958>
10b6356f0: aa1303e0    	mov	x0, x19
10b6356f4: aa1403e1    	mov	x1, x20
10b6356f8: 940000f5    	bl	0x10b635acc <_mmkv_importFrom+0x772d28>
10b6356fc: 9102a3e0    	add	x0, sp, #0xa8
10b635700: 94000187    	bl	0x10b635d1c <_mmkv_importFrom+0x772f78>
10b635704: f9402bf3    	ldr	x19, [sp, #0x50]
10b635708: b40002b3    	cbz	x19, 0x10b63575c <_mmkv_importFrom+0x7729b8>
10b63570c: 91002268    	add	x8, x19, #0x8
10b635710: 885ffd09    	ldaxr	w9, [x8]
10b635714: 71000529    	subs	w9, w9, #0x1
10b635718: 880afd09    	stlxr	w10, w9, [x8]
10b63571c: 35ffffaa    	cbnz	w10, 0x10b635710 <_mmkv_importFrom+0x77296c>
10b635720: 540001e1    	b.ne	0x10b63575c <_mmkv_importFrom+0x7729b8>
10b635724: aa1303f4    	mov	x20, x19
10b635728: f840c688    	ldr	x8, [x20], #0xc
10b63572c: f9400908    	ldr	x8, [x8, #0x10]
10b635730: aa1303e0    	mov	x0, x19
10b635734: d63f0100    	blr	x8
10b635738: 885ffe88    	ldaxr	w8, [x20]
10b63573c: 71000508    	subs	w8, w8, #0x1
10b635740: 8809fe88    	stlxr	w9, w8, [x20]
10b635744: 35ffffa9    	cbnz	w9, 0x10b635738 <_mmkv_importFrom+0x772994>
10b635748: 540000a1    	b.ne	0x10b63575c <_mmkv_importFrom+0x7729b8>
10b63574c: f9400268    	ldr	x8, [x19]
10b635750: f9400d08    	ldr	x8, [x8, #0x18]
10b635754: aa1303e0    	mov	x0, x19
10b635758: d63f0100    	blr	x8
10b63575c: f85c83a8    	ldur	x8, [x29, #-0x38]
10b635760: f00908a9    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10b635764: f9451929    	ldr	x9, [x9, #0xa30] ; 0x11d74ca30 __got
10b635768: f9400129    	ldr	x9, [x9]
10b63576c: eb08013f    	cmp	x9, x8
10b635770: 540000e1    	b.ne	0x10b63578c <_mmkv_importFrom+0x7729e8>
10b635774: 910783ff    	add	sp, sp, #0x1e0
10b635778: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10b63577c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10b635780: a94157f6    	ldp	x22, x21, [sp, #0x10]
10b635784: a8c46ffc    	ldp	x28, x27, [sp], #0x40
10b635788: d65f03c0    	ret
10b63578c: 9508a69a    	bl	0x10f85f1f4 <_GetBoxIamBizTLRecFeedsDataUtil+0xde2d8>
