
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bd5e0: d101c3ff    	sub	sp, sp, #0x70
10a9bd5e4: 6d0323e9    	stp	d9, d8, [sp, #0x30]
10a9bd5e8: a90457f6    	stp	x22, x21, [sp, #0x40]
10a9bd5ec: a9054ff4    	stp	x20, x19, [sp, #0x50]
10a9bd5f0: a9067bfd    	stp	x29, x30, [sp, #0x60]
10a9bd5f4: 910183fd    	add	x29, sp, #0x60
10a9bd5f8: 1e604028    	fmov	d8, d1
10a9bd5fc: 1e604009    	fmov	d9, d0
10a9bd600: aa0203f3    	mov	x19, x2
10a9bd604: aa0203e0    	mov	x0, x2
10a9bd608: 953a778e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bd60c: f00abda8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a9bd610: f9450d00    	ldr	x0, [x8, #0xa18]
10a9bd614: 953a7795    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a9bd618: aa0003f4    	mov	x20, x0
10a9bd61c: b0096188    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a9bd620: f947e108    	ldr	x8, [x8, #0xfc0]
10a9bd624: f90007e8    	str	x8, [sp, #0x8]
10a9bd628: 90071e28    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9bd62c: fd41c100    	ldr	d0, [x8, #0x380]
10a9bd630: 90000008    	adrp	x8, 0x10a9bd000 <_Flutter_MMFoundation_BindContext+0x6e98be4>
10a9bd634: 911a9108    	add	x8, x8, #0x6a4
10a9bd638: f0096289    	adrp	x9, 0x11d610000 <dyld_stub_binder+0x11d610000>
10a9bd63c: 9103a129    	add	x9, x9, #0xe8
10a9bd640: fd000be0    	str	d0, [sp, #0x10]
10a9bd644: a901a7e8    	stp	x8, x9, [sp, #0x18]
10a9bd648: f90017f3    	str	x19, [sp, #0x28]
10a9bd64c: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bd650: f945dd15    	ldr	x21, [x8, #0xbb8] ; initWithBlock:prefertSize:
10a9bd654: aa1303e0    	mov	x0, x19
10a9bd658: 953a777a    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bd65c: 910023e2    	add	x2, sp, #0x8
10a9bd660: aa1403e0    	mov	x0, x20
10a9bd664: aa1503e1    	mov	x1, x21
10a9bd668: 1e604120    	fmov	d0, d9
10a9bd66c: 1e604101    	fmov	d1, d8
10a9bd670: 953a7775    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd674: aa0003f4    	mov	x20, x0
10a9bd678: f94017e0    	ldr	x0, [sp, #0x28]
10a9bd67c: 953a7778    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd680: aa1303e0    	mov	x0, x19
10a9bd684: 953a7776    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd688: aa1403e0    	mov	x0, x20
10a9bd68c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a9bd690: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a9bd694: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a9bd698: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
10a9bd69c: 9101c3ff    	add	sp, sp, #0x70
10a9bd6a0: 153a7776    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>