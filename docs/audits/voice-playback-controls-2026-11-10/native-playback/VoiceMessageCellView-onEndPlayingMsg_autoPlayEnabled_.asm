
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1065864d4: d10203ff    	sub	sp, sp, #0x80
1065864d8: a9026ffc    	stp	x28, x27, [sp, #0x20]
1065864dc: a90367fa    	stp	x26, x25, [sp, #0x30]
1065864e0: a9045ff8    	stp	x24, x23, [sp, #0x40]
1065864e4: a90557f6    	stp	x22, x21, [sp, #0x50]
1065864e8: a9064ff4    	stp	x20, x19, [sp, #0x60]
1065864ec: a9077bfd    	stp	x29, x30, [sp, #0x70]
1065864f0: 9101c3fd    	add	x29, sp, #0x70
1065864f4: aa0203f3    	mov	x19, x2
1065864f8: aa0003f4    	mov	x20, x0
1065864fc: d00b8e28    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
106586500: f9451908    	ldr	x8, [x8, #0xa30]
106586504: f9400108    	ldr	x8, [x8]
106586508: f9000fe8    	str	x8, [sp, #0x18]
10658650c: b00c8e88    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106586510: 52800029    	mov	w9, #0x1                ; =1
106586514: 39088509    	strb	w9, [x8, #0x221]
106586518: aa0203e0    	mov	x0, x2
10658651c: 945a85d6    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
106586520: 900c2248    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106586524: f941c115    	ldr	x21, [x8, #0x380]
106586528: aa1403e0    	mov	x0, x20
10658652c: aa1503e1    	mov	x1, x21
106586530: 945a85cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586534: aa1d03fd    	mov	x29, x29
106586538: 945a85d2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658653c: aa0003f6    	mov	x22, x0
106586540: b00c2f68    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106586544: f9429101    	ldr	x1, [x8, #0x520]
106586548: 945a85c7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658654c: aa0003f7    	mov	x23, x0
106586550: aa1603e0    	mov	x0, x22
106586554: 945a85c7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586558: 900c42a8    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658655c: b98c8508    	ldrsw	x8, [x8, #0xc84]
106586560: f8686a80    	ldr	x0, [x20, x8]
106586564: b00c3928    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106586568: f9458d16    	ldr	x22, [x8, #0xb18]
10658656c: 520002e2    	eor	w2, w23, #0x1
106586570: aa1603e1    	mov	x1, x22
106586574: 945a85bc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586578: 900c42a8    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658657c: b98c8908    	ldrsw	x8, [x8, #0xc88]
106586580: f8686a80    	ldr	x0, [x20, x8]
106586584: aa1603e1    	mov	x1, x22
106586588: 52800022    	mov	w2, #0x1                ; =1
10658658c: 945a85b6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586590: 900c2258    	adrp	x24, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106586594: b00c225c    	adrp	x28, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106586598: 37000337    	tbnz	w23, #0x0, 0x1065865fc <_Flutter_MMFoundation_BindContext+0x280d2c8>
10658659c: aa1403e0    	mov	x0, x20
1065865a0: aa1503e1    	mov	x1, x21
1065865a4: 945a85b0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065865a8: aa1d03fd    	mov	x29, x29
1065865ac: 945a85b5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065865b0: aa0003f6    	mov	x22, x0
1065865b4: f941bf01    	ldr	x1, [x24, #0x378]
1065865b8: 945a85ab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065865bc: aa1d03fd    	mov	x29, x29
1065865c0: 945a85b0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065865c4: aa0003f7    	mov	x23, x0
1065865c8: f9466f81    	ldr	x1, [x28, #0xcd8]
1065865cc: aa1303e2    	mov	x2, x19
1065865d0: 945a85a5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065865d4: aa0003f8    	mov	x24, x0
1065865d8: aa1703e0    	mov	x0, x23
1065865dc: 945a85a5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065865e0: aa1603e0    	mov	x0, x22
1065865e4: 945a85a3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065865e8: 340000b8    	cbz	w24, 0x1065865fc <_Flutter_MMFoundation_BindContext+0x280d2c8>
1065865ec: b00c2f68    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
1065865f0: f9424d01    	ldr	x1, [x8, #0x498]
1065865f4: aa1403e0    	mov	x0, x20
1065865f8: 945a859b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065865fc: 900c3c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106586600: f943c100    	ldr	x0, [x8, #0x780]
106586604: f00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106586608: f9440116    	ldr	x22, [x8, #0x800]
10658660c: aa1603e1    	mov	x1, x22
106586610: 945a8595    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586614: aa1d03fd    	mov	x29, x29
106586618: 945a859a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658661c: aa0003f9    	mov	x25, x0
106586620: d00c3c68    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
106586624: f9406900    	ldr	x0, [x8, #0xd0]
106586628: 900c3908    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10658662c: f9428517    	ldr	x23, [x8, #0x508]
106586630: aa1703e1    	mov	x1, x23
106586634: 945a858c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586638: aa0003e2    	mov	x2, x0
10658663c: f00c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106586640: f9452118    	ldr	x24, [x8, #0xa40]
106586644: aa1903e0    	mov	x0, x25
106586648: aa1803e1    	mov	x1, x24
10658664c: 945a8586    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586650: aa1d03fd    	mov	x29, x29
106586654: 945a858b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586658: aa0003fa    	mov	x26, x0
10658665c: b00c2228    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106586660: f947d901    	ldr	x1, [x8, #0xfb0]
106586664: 945a8580    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586668: aa0003fb    	mov	x27, x0
10658666c: aa1a03e0    	mov	x0, x26
106586670: 945a8580    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586674: aa1903e0    	mov	x0, x25
106586678: 945a857e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658667c: 3700107b    	tbnz	w27, #0x0, 0x106586888 <_Flutter_MMFoundation_BindContext+0x280d554>
106586680: aa1403e0    	mov	x0, x20
106586684: aa1503e1    	mov	x1, x21
106586688: 945a8577    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658668c: aa1d03fd    	mov	x29, x29
106586690: 945a857c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586694: aa0003fa    	mov	x26, x0
106586698: 900c2248    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10658669c: f941bd19    	ldr	x25, [x8, #0x378]
1065866a0: aa1903e1    	mov	x1, x25
1065866a4: 945a8570    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065866a8: aa1d03fd    	mov	x29, x29
1065866ac: 945a8575    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065866b0: aa0003fb    	mov	x27, x0
1065866b4: f9466f81    	ldr	x1, [x28, #0xcd8]
1065866b8: aa1303e2    	mov	x2, x19
1065866bc: 945a856a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065866c0: aa0003fc    	mov	x28, x0
1065866c4: aa1b03e0    	mov	x0, x27
1065866c8: 945a856a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065866cc: aa1a03e0    	mov	x0, x26
1065866d0: 945a8568    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065866d4: 34000dbc    	cbz	w28, 0x106586888 <_Flutter_MMFoundation_BindContext+0x280d554>
1065866d8: aa1403e0    	mov	x0, x20
1065866dc: aa1503e1    	mov	x1, x21
1065866e0: 945a8561    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065866e4: aa1d03fd    	mov	x29, x29
1065866e8: 945a8566    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065866ec: aa0003fa    	mov	x26, x0
1065866f0: aa1903e1    	mov	x1, x25
1065866f4: 945a855c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065866f8: aa1d03fd    	mov	x29, x29
1065866fc: 945a8561    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586700: aa0003fb    	mov	x27, x0
106586704: 900c2248    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106586708: f9403901    	ldr	x1, [x8, #0x70]
10658670c: 945a8556    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586710: aa1d03fd    	mov	x29, x29
106586714: 945a855b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586718: aa0003f9    	mov	x25, x0
10658671c: aa1b03e0    	mov	x0, x27
106586720: 945a8554    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586724: aa1a03e0    	mov	x0, x26
106586728: 945a8552    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658672c: 900c3c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106586730: f943c100    	ldr	x0, [x8, #0x780]
106586734: aa1603e1    	mov	x1, x22
106586738: 945a854b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658673c: aa1d03fd    	mov	x29, x29
106586740: 945a8550    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586744: aa0003fa    	mov	x26, x0
106586748: d00c3c68    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
10658674c: f9406d00    	ldr	x0, [x8, #0xd8]
106586750: aa1703e1    	mov	x1, x23
106586754: 945a8544    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586758: aa0003e2    	mov	x2, x0
10658675c: aa1a03e0    	mov	x0, x26
106586760: aa1803e1    	mov	x1, x24
106586764: 945a8540    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586768: aa1d03fd    	mov	x29, x29
10658676c: 945a8545    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586770: aa0003fb    	mov	x27, x0
106586774: b00c2f68    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106586778: f943c501    	ldr	x1, [x8, #0x788]
10658677c: aa1903e2    	mov	x2, x25
106586780: 945a8539    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586784: aa0003fc    	mov	x28, x0
106586788: aa1b03e0    	mov	x0, x27
10658678c: 945a8539    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586790: aa1a03e0    	mov	x0, x26
106586794: 945a8537    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586798: 3400075c    	cbz	w28, 0x106586880 <_Flutter_MMFoundation_BindContext+0x280d54c>
10658679c: 900c3c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065867a0: f943c100    	ldr	x0, [x8, #0x780]
1065867a4: aa1603e1    	mov	x1, x22
1065867a8: 945a852f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065867ac: aa1d03fd    	mov	x29, x29
1065867b0: 945a8534    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065867b4: aa0003f6    	mov	x22, x0
1065867b8: 900c3c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065867bc: f9460900    	ldr	x0, [x8, #0xc10]
1065867c0: aa1703e1    	mov	x1, x23
1065867c4: 945a8528    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065867c8: aa0003e2    	mov	x2, x0
1065867cc: aa1603e0    	mov	x0, x22
1065867d0: aa1803e1    	mov	x1, x24
1065867d4: 945a8524    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065867d8: aa1d03fd    	mov	x29, x29
1065867dc: 945a8529    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065867e0: aa0003f7    	mov	x23, x0
1065867e4: f00b50c8    	adrp	x8, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
1065867e8: 911b6108    	add	x8, x8, #0x6d8
1065867ec: a900e7e8    	stp	x8, x25, [sp, #0x8]
1065867f0: 900c3c68    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065867f4: f9434d00    	ldr	x0, [x8, #0x698]
1065867f8: 900c3908    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1065867fc: f947e101    	ldr	x1, [x8, #0xfc0]
106586800: 910043e2    	add	x2, sp, #0x10
106586804: 910023e3    	add	x3, sp, #0x8
106586808: 52800024    	mov	w4, #0x1                ; =1
10658680c: 945a8516    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586810: aa1d03fd    	mov	x29, x29
106586814: 945a851b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586818: aa0003f8    	mov	x24, x0
10658681c: d00c2228    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
106586820: f9428d01    	ldr	x1, [x8, #0x518]
106586824: b00b70a2    	adrp	x2, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
106586828: 912e6042    	add	x2, x2, #0xb98
10658682c: aa1703e0    	mov	x0, x23
106586830: aa1803e3    	mov	x3, x24
106586834: 52916c84    	mov	w4, #0x8b64             ; =35684
106586838: 945a850b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658683c: aa1803e0    	mov	x0, x24
106586840: 945a850c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586844: aa1703e0    	mov	x0, x23
106586848: 945a850a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658684c: aa1603e0    	mov	x0, x22
106586850: 945a8508    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586854: aa1403e0    	mov	x0, x20
106586858: aa1503e1    	mov	x1, x21
10658685c: 945a8502    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586860: aa1d03fd    	mov	x29, x29
106586864: 945a8507    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106586868: aa0003f4    	mov	x20, x0
10658686c: b00c2f68    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106586870: f943c901    	ldr	x1, [x8, #0x790]
106586874: 945a84fc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106586878: aa1403e0    	mov	x0, x20
10658687c: 945a84fd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586880: aa1903e0    	mov	x0, x25
106586884: 945a84fb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586888: aa1303e0    	mov	x0, x19
10658688c: 945a84f9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106586890: f9400fe8    	ldr	x8, [sp, #0x18]
106586894: d00b8e29    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
106586898: f9451929    	ldr	x9, [x9, #0xa30]
10658689c: f9400129    	ldr	x9, [x9]
1065868a0: eb08013f    	cmp	x9, x8
1065868a4: 54000121    	b.ne	0x1065868c8 <_Flutter_MMFoundation_BindContext+0x280d594>
1065868a8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1065868ac: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1065868b0: a94557f6    	ldp	x22, x21, [sp, #0x50]
1065868b4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1065868b8: a94367fa    	ldp	x26, x25, [sp, #0x30]
1065868bc: a9426ffc    	ldp	x28, x27, [sp, #0x20]
1065868c0: 910203ff    	add	sp, sp, #0x80
1065868c4: d65f03c0    	ret
1065868c8: 945a839a    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
