
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9bd4a4: d101c3ff    	sub	sp, sp, #0x70
10a9bd4a8: 6d0323e9    	stp	d9, d8, [sp, #0x30]
10a9bd4ac: a90457f6    	stp	x22, x21, [sp, #0x40]
10a9bd4b0: a9054ff4    	stp	x20, x19, [sp, #0x50]
10a9bd4b4: a9067bfd    	stp	x29, x30, [sp, #0x60]
10a9bd4b8: 910183fd    	add	x29, sp, #0x60
10a9bd4bc: aa0203f3    	mov	x19, x2
10a9bd4c0: aa0203e0    	mov	x0, x2
10a9bd4c4: 953a77df    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bd4c8: f00abda8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a9bd4cc: f9450d00    	ldr	x0, [x8, #0xa18]
10a9bd4d0: 953a77e6    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a9bd4d4: aa0003f4    	mov	x20, x0
10a9bd4d8: b0096188    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a9bd4dc: f947e108    	ldr	x8, [x8, #0xfc0]
10a9bd4e0: f90007e8    	str	x8, [sp, #0x8]
10a9bd4e4: 90071e28    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a9bd4e8: fd41c100    	ldr	d0, [x8, #0x380]
10a9bd4ec: 90000008    	adrp	x8, 0x10a9bd000 <_Flutter_MMFoundation_BindContext+0x6e98be4>
10a9bd4f0: 9115b108    	add	x8, x8, #0x56c
10a9bd4f4: fd000be0    	str	d0, [sp, #0x10]
10a9bd4f8: f0096289    	adrp	x9, 0x11d610000 <dyld_stub_binder+0x11d610000>
10a9bd4fc: 9103a129    	add	x9, x9, #0xe8
10a9bd500: a901a7e8    	stp	x8, x9, [sp, #0x18]
10a9bd504: f90017f3    	str	x19, [sp, #0x28]
10a9bd508: 90096188    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
10a9bd50c: f9417908    	ldr	x8, [x8, #0x2f0]
10a9bd510: 6d402508    	ldp	d8, d9, [x8]
10a9bd514: 900ab7a8    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9bd518: f945dd15    	ldr	x21, [x8, #0xbb8] ; initWithBlock:prefertSize:
10a9bd51c: aa1303e0    	mov	x0, x19
10a9bd520: 953a77c8    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9bd524: 910023e2    	add	x2, sp, #0x8
10a9bd528: aa1403e0    	mov	x0, x20
10a9bd52c: aa1503e1    	mov	x1, x21
10a9bd530: 1e604100    	fmov	d0, d8
10a9bd534: 1e604121    	fmov	d1, d9
10a9bd538: 953a77c3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9bd53c: aa0003f4    	mov	x20, x0
10a9bd540: f94017e0    	ldr	x0, [sp, #0x28]
10a9bd544: 953a77c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd548: aa1303e0    	mov	x0, x19
10a9bd54c: 953a77c4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9bd550: aa1403e0    	mov	x0, x20
10a9bd554: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a9bd558: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a9bd55c: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a9bd560: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
10a9bd564: 9101c3ff    	add	sp, sp, #0x70
10a9bd568: 153a77c4    	b	0x10f85b478 <_UR_96F1_B25D+0x3a640e8>