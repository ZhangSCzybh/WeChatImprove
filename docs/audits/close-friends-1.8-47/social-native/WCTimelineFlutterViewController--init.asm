
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a12646c: d10483ff    	sub	sp, sp, #0x120
10a126470: a90c6ffc    	stp	x28, x27, [sp, #0xc0]
10a126474: a90d67fa    	stp	x26, x25, [sp, #0xd0]
10a126478: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
10a12647c: a90f57f6    	stp	x22, x21, [sp, #0xf0]
10a126480: a9104ff4    	stp	x20, x19, [sp, #0x100]
10a126484: a9117bfd    	stp	x29, x30, [sp, #0x110]
10a126488: 910443fd    	add	x29, sp, #0x110
10a12648c: aa0003f4    	mov	x20, x0
10a126490: b009a648    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a126494: f9405908    	ldr	x8, [x8, #0xb0]
10a126498: f9400108    	ldr	x8, [x8]
10a12649c: f81a03a8    	stur	x8, [x29, #-0x60]
10a1264a0: f00b5948    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a1264a4: 52800029    	mov	w9, #0x1                ; =1
10a1264a8: 3917e109    	strb	w9, [x8, #0x5f8]
10a1264ac: f00b0268    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a1264b0: f9434d00    	ldr	x0, [x8, #0x698]
10a1264b4: 955cd3ed    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a1264b8: aa0003f3    	mov	x19, x0
10a1264bc: f00b0268    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a1264c0: f9435100    	ldr	x0, [x8, #0x6a0]
10a1264c4: d00ae8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1264c8: f944b901    	ldr	x1, [x8, #0x970] ; defaultGroup
10a1264cc: 955cd3de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1264d0: aa1d03fd    	mov	x29, x29
10a1264d4: 955cd3df    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1264d8: aa0003f5    	mov	x21, x0
10a1264dc: d00ae8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1264e0: f944bd01    	ldr	x1, [x8, #0x978] ; initWithEngineGroup:plugin:
10a1264e4: b00a1c23    	adrp	x3, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
10a1264e8: 9109a063    	add	x3, x3, #0x268
10a1264ec: aa1303e0    	mov	x0, x19
10a1264f0: aa1503e2    	mov	x2, x21
10a1264f4: 955cd3d4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1264f8: aa0003f7    	mov	x23, x0
10a1264fc: f9000be0    	str	x0, [sp, #0x10]
10a126500: aa1503e0    	mov	x0, x21
10a126504: 955cd3d6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126508: b00a1d08    	adrp	x8, 0x11e4c7000 <dyld_stub_binder+0x11e4c7000>
10a12650c: 910ba108    	add	x8, x8, #0x2e8
10a126510: f81803a8    	stur	x8, [x29, #-0x80]
10a126514: b00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a126518: f9471100    	ldr	x0, [x8, #0xe20]
10a12651c: f00ae8a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a126520: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
10a126524: 955cd3c8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a126528: aa1d03fd    	mov	x29, x29
10a12652c: 955cd3c9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a126530: aa0003f5    	mov	x21, x0
10a126534: 900a48e8    	adrp	x8, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a126538: 913ea108    	add	x8, x8, #0xfa8
10a12653c: a93883a8    	stp	x8, x0, [x29, #-0x78]
10a126540: b00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a126544: f9458900    	ldr	x0, [x8, #0xb10]
10a126548: d00afee8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a12654c: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
10a126550: 52800002    	mov	w2, #0x0                ; =0
10a126554: 955cd3bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a126558: aa1d03fd    	mov	x29, x29
10a12655c: 955cd3bd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a126560: aa0003f6    	mov	x22, x0
10a126564: f81983a0    	stur	x0, [x29, #-0x68]
10a126568: b00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a12656c: f9457500    	ldr	x0, [x8, #0xae8]
10a126570: f00afec8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a126574: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
10a126578: d101c3a2    	sub	x2, x29, #0x70
10a12657c: d10203a3    	sub	x3, x29, #0x80
10a126580: 52800044    	mov	w4, #0x2                ; =2
10a126584: 955cd3b0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a126588: aa1d03fd    	mov	x29, x29
10a12658c: 955cd3b1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a126590: aa0003f3    	mov	x19, x0
10a126594: aa1603e0    	mov	x0, x22
10a126598: 955cd3b1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12659c: aa1503e0    	mov	x0, x21
10a1265a0: 955cd3af    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1265a4: d00ae8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1265a8: f944c101    	ldr	x1, [x8, #0x980] ; push:arguments:
10a1265ac: d00a1dc2    	adrp	x2, 0x11e4e0000 <dyld_stub_binder+0x11e4e0000>
10a1265b0: 910e2042    	add	x2, x2, #0x388
10a1265b4: aa1703e0    	mov	x0, x23
10a1265b8: f90017f3    	str	x19, [sp, #0x28]
10a1265bc: aa1303e3    	mov	x3, x19
10a1265c0: 955cd3a1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1265c4: b00b0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a1265c8: f9432900    	ldr	x0, [x8, #0x650]
10a1265cc: 955cd3a5    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1265d0: aa0003f3    	mov	x19, x0
10a1265d4: b00aff08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a1265d8: f9451515    	ldr	x21, [x8, #0xa28] ; setDelegate:
10a1265dc: aa1503e1    	mov	x1, x21
10a1265e0: f9000ff4    	str	x20, [sp, #0x18]
10a1265e4: aa1403e2    	mov	x2, x20
10a1265e8: 955cd397    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1265ec: 900b0428    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
10a1265f0: f9429500    	ldr	x0, [x8, #0x528]
10a1265f4: 955cd39b    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1265f8: aa0003f7    	mov	x23, x0
10a1265fc: aa1503e1    	mov	x1, x21
10a126600: aa1403e2    	mov	x2, x20
10a126604: 955cd390    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a126608: 900b0288    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a12660c: f946fd00    	ldr	x0, [x8, #0xdf8]
10a126610: 955cd394    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a126614: f90007e0    	str	x0, [sp, #0x8]
10a126618: f90023e0    	str	x0, [sp, #0x40]
10a12661c: b00b0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a126620: f9431100    	ldr	x0, [x8, #0x620]
10a126624: 955cd38f    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a126628: aa0003f9    	mov	x25, x0
10a12662c: f90027e0    	str	x0, [sp, #0x48]
10a126630: b00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a126634: f9429900    	ldr	x0, [x8, #0x530] ; Xw.
10a126638: 955cd38a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a12663c: aa0003fa    	mov	x26, x0
10a126640: a9054fe0    	stp	x0, x19, [sp, #0x50]
10a126644: f90013f3    	str	x19, [sp, #0x20]
10a126648: b00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a12664c: f9429d00    	ldr	x0, [x8, #0x538]
10a126650: 955cd384    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a126654: aa0003fb    	mov	x27, x0
10a126658: f90033e0    	str	x0, [sp, #0x60]
10a12665c: f00b0288    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
10a126660: f940d500    	ldr	x0, [x8, #0x1a8]
10a126664: 955cd37f    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a126668: aa0003fc    	mov	x28, x0
10a12666c: f90037e0    	str	x0, [sp, #0x68]
10a126670: b00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a126674: f942a100    	ldr	x0, [x8, #0x540]
10a126678: 955cd37a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a12667c: aa0003f5    	mov	x21, x0
10a126680: f9003be0    	str	x0, [sp, #0x70]
10a126684: b00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a126688: f942b100    	ldr	x0, [x8, #0x560]
10a12668c: 955cd375    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a126690: aa0003f4    	mov	x20, x0
10a126694: f9003fe0    	str	x0, [sp, #0x78]
10a126698: b00b0288    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
10a12669c: f940e900    	ldr	x0, [x8, #0x1d0]
10a1266a0: 900ae968    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a1266a4: f9413101    	ldr	x1, [x8, #0x260] ; plugin
10a1266a8: 955cd367    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1266ac: aa1d03fd    	mov	x29, x29
10a1266b0: 955cd368    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1266b4: aa0003f8    	mov	x24, x0
10a1266b8: a9085fe0    	stp	x0, x23, [sp, #0x80]
10a1266bc: b00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a1266c0: f9456d00    	ldr	x0, [x8, #0xad8]
10a1266c4: b00afec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a1266c8: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
10a1266cc: 910103e2    	add	x2, sp, #0x40
10a1266d0: 52800143    	mov	w3, #0xa                ; =10
10a1266d4: 955cd35c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1266d8: aa1d03fd    	mov	x29, x29
10a1266dc: 955cd35d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1266e0: aa0003f6    	mov	x22, x0
10a1266e4: d00ae8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1266e8: f944c901    	ldr	x1, [x8, #0x990] ; addPlugins:
10a1266ec: f9400bf3    	ldr	x19, [sp, #0x10]
10a1266f0: aa1303e0    	mov	x0, x19
10a1266f4: aa1603e2    	mov	x2, x22
10a1266f8: 955cd353    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1266fc: aa1603e0    	mov	x0, x22
10a126700: 955cd357    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126704: aa1803e0    	mov	x0, x24
10a126708: 955cd355    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12670c: aa1403e0    	mov	x0, x20
10a126710: 955cd353    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126714: aa1503e0    	mov	x0, x21
10a126718: 955cd351    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12671c: aa1c03e0    	mov	x0, x28
10a126720: 955cd34f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126724: aa1b03e0    	mov	x0, x27
10a126728: 955cd34d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12672c: aa1a03e0    	mov	x0, x26
10a126730: 955cd34b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126734: aa1903e0    	mov	x0, x25
10a126738: 955cd349    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12673c: f94007e0    	ldr	x0, [sp, #0x8]
10a126740: 955cd347    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126744: d00b0568    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a126748: f940b508    	ldr	x8, [x8, #0x168]
10a12674c: f9400fe9    	ldr	x9, [sp, #0x18]
10a126750: a90323e9    	stp	x9, x8, [sp, #0x30]
10a126754: d00ae8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a126758: f944c501    	ldr	x1, [x8, #0x988] ; initWithFlutterInstance:
10a12675c: 9100c3e0    	add	x0, sp, #0x30
10a126760: aa1303e2    	mov	x2, x19
10a126764: 955cd33a    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a126768: aa0003f4    	mov	x20, x0
10a12676c: b40000c0    	cbz	x0, 0x10a126784 <_Flutter_MMFoundation_BindContext+0x6602368>
10a126770: d00af328    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10a126774: f942ad01    	ldr	x1, [x8, #0x558] ; setInstance:
10a126778: aa1403e0    	mov	x0, x20
10a12677c: aa1303e2    	mov	x2, x19
10a126780: 955cd331    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a126784: aa1703e0    	mov	x0, x23
10a126788: 955cd335    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12678c: f94013e0    	ldr	x0, [sp, #0x20]
10a126790: 955cd333    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a126794: f94017e0    	ldr	x0, [sp, #0x28]
10a126798: 955cd331    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12679c: aa1303e0    	mov	x0, x19
10a1267a0: 955cd32f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1267a4: f85a03a8    	ldur	x8, [x29, #-0x60]
10a1267a8: b009a649    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a1267ac: f9405929    	ldr	x9, [x9, #0xb0]
10a1267b0: f9400129    	ldr	x9, [x9]
10a1267b4: eb08013f    	cmp	x9, x8
10a1267b8: 54000141    	b.ne	0x10a1267e0 <_Flutter_MMFoundation_BindContext+0x66023c4>
10a1267bc: aa1403e0    	mov	x0, x20
10a1267c0: a9517bfd    	ldp	x29, x30, [sp, #0x110]
10a1267c4: a9504ff4    	ldp	x20, x19, [sp, #0x100]
10a1267c8: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
10a1267cc: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
10a1267d0: a94d67fa    	ldp	x26, x25, [sp, #0xd0]
10a1267d4: a94c6ffc    	ldp	x28, x27, [sp, #0xc0]
10a1267d8: 910483ff    	add	sp, sp, #0x120
10a1267dc: d65f03c0    	ret
10a1267e0: 955cd327    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
