
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106572670: d101c3ff    	sub	sp, sp, #0x70
106572674: a9016ffc    	stp	x28, x27, [sp, #0x10]
106572678: a90267fa    	stp	x26, x25, [sp, #0x20]
10657267c: a9035ff8    	stp	x24, x23, [sp, #0x30]
106572680: a90457f6    	stp	x22, x21, [sp, #0x40]
106572684: a9054ff4    	stp	x20, x19, [sp, #0x50]
106572688: a9067bfd    	stp	x29, x30, [sp, #0x60]
10657268c: 910183fd    	add	x29, sp, #0x60
106572690: aa0003f3    	mov	x19, x0
106572694: b00c8f28    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106572698: 52800029    	mov	w9, #0x1                ; =1
10657269c: 39077109    	strb	w9, [x8, #0x1dc]
1065726a0: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1065726a4: f941c11c    	ldr	x28, [x8, #0x380] ; selector: viewModel
1065726a8: aa1c03e1    	mov	x1, x28
1065726ac: 945ad56e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065726b0: aa1d03fd    	mov	x29, x29
1065726b4: 945ad573    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065726b8: aa0003f6    	mov	x22, x0
1065726bc: b00c2648    	adrp	x8, 0x11ea3b000 <dyld_stub_binder+0x11ea3b000>
1065726c0: f9416915    	ldr	x21, [x8, #0x2d0] ; selector: msgStatus
1065726c4: aa1503e1    	mov	x1, x21
1065726c8: 945ad567    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065726cc: aa0003f8    	mov	x24, x0
1065726d0: 7100041f    	cmp	w0, #0x1
1065726d4: 54000301    	b.ne	0x106572734 <_Flutter_MMFoundation_BindContext+0x27f9400>
1065726d8: aa1303e0    	mov	x0, x19
1065726dc: aa1c03e1    	mov	x1, x28
1065726e0: 945ad561    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065726e4: aa1d03fd    	mov	x29, x29
1065726e8: 945ad566    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065726ec: aa0003f7    	mov	x23, x0
1065726f0: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1065726f4: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
1065726f8: 945ad55b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065726fc: aa1d03fd    	mov	x29, x29
106572700: 945ad560    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572704: aa0003f9    	mov	x25, x0
106572708: 900c2368    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10657270c: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: IsRecording
106572710: 945ad555    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572714: 34000100    	cbz	w0, 0x106572734 <_Flutter_MMFoundation_BindContext+0x27f9400>
106572718: aa1903e0    	mov	x0, x25
10657271c: 945ad555    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572720: aa1703e0    	mov	x0, x23
106572724: 945ad553    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572728: aa1603e0    	mov	x0, x22
10657272c: 945ad551    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572730: 1400002c    	b	0x1065727e0 <_Flutter_MMFoundation_BindContext+0x27f94ac>
106572734: aa1303e0    	mov	x0, x19
106572738: aa1c03e1    	mov	x1, x28
10657273c: 945ad54a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572740: aa1d03fd    	mov	x29, x29
106572744: 945ad54f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572748: aa0003fa    	mov	x26, x0
10657274c: aa1503e1    	mov	x1, x21
106572750: 945ad545    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572754: 71000c1f    	cmp	w0, #0x3
106572758: 54000a61    	b.ne	0x1065728a4 <_Flutter_MMFoundation_BindContext+0x27f9570>
10657275c: aa1303e0    	mov	x0, x19
106572760: f90007fc    	str	x28, [sp, #0x8]
106572764: aa1c03e1    	mov	x1, x28
106572768: 945ad53f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657276c: aa1d03fd    	mov	x29, x29
106572770: 945ad544    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572774: aa0003fc    	mov	x28, x0
106572778: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10657277c: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
106572780: 945ad539    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572784: aa1d03fd    	mov	x29, x29
106572788: 945ad53e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10657278c: aa0003f4    	mov	x20, x0
106572790: d00c2308    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
106572794: f9455101    	ldr	x1, [x8, #0xaa0] ; selector: IsDownloadEnded
106572798: 945ad533    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657279c: aa0003fb    	mov	x27, x0
1065727a0: aa1403e0    	mov	x0, x20
1065727a4: 945ad533    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065727a8: aa1c03e0    	mov	x0, x28
1065727ac: 945ad531    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065727b0: aa1a03e0    	mov	x0, x26
1065727b4: 945ad52f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065727b8: 7100071f    	cmp	w24, #0x1
1065727bc: 540000a1    	b.ne	0x1065727d0 <_Flutter_MMFoundation_BindContext+0x27f949c>
1065727c0: aa1903e0    	mov	x0, x25
1065727c4: 945ad52b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065727c8: aa1703e0    	mov	x0, x23
1065727cc: 945ad529    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065727d0: aa1603e0    	mov	x0, x22
1065727d4: 945ad527    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065727d8: f94007fc    	ldr	x28, [sp, #0x8]
1065727dc: 3700079b    	tbnz	w27, #0x0, 0x1065728cc <_Flutter_MMFoundation_BindContext+0x27f9598>
1065727e0: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
1065727e4: b98c7908    	ldrsw	x8, [x8, #0xc78] ; ivar: VoiceMessageCellView.m_secLabel offset=200
1065727e8: f8686a60    	ldr	x0, [x19, x8]
1065727ec: b00c39c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1065727f0: f9458d14    	ldr	x20, [x8, #0xb18] ; selector: setHidden:
1065727f4: aa1403e1    	mov	x1, x20
1065727f8: 52800022    	mov	w2, #0x1                ; =1
1065727fc: 945ad51a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572800: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572804: b98c7d08    	ldrsw	x8, [x8, #0xc7c] ; ivar: VoiceMessageCellView.m_playingImageView offset=208
106572808: f8686a60    	ldr	x0, [x19, x8]
10657280c: aa1403e1    	mov	x1, x20
106572810: 52800022    	mov	w2, #0x1                ; =1
106572814: 945ad514    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572818: f00c40a8    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
10657281c: 9122d108    	add	x8, x8, #0x8b4
106572820: b9800115    	ldrsw	x21, [x8]
106572824: f8756a60    	ldr	x0, [x19, x21]
106572828: aa1403e1    	mov	x1, x20
10657282c: 52800022    	mov	w2, #0x1                ; =1
106572830: 945ad50d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572834: b00c3008    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106572838: f9425901    	ldr	x1, [x8, #0x4b0] ; selector: initRecordingView
10657283c: aa1303e0    	mov	x0, x19
106572840: 945ad509    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572844: f8756a60    	ldr	x0, [x19, x21]
106572848: b00c39a8    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
10657284c: f9433501    	ldr	x1, [x8, #0x668] ; selector: frame
106572850: 945ad505    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572854: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572858: b98c9914    	ldrsw	x20, [x8, #0xc98] ; ivar: VoiceMessageCellView.m_recordingView offset=216
10657285c: f8746a60    	ldr	x0, [x19, x20]
106572860: b00c39c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106572864: f9453101    	ldr	x1, [x8, #0xa60] ; selector: setFrame:
106572868: 945ad4ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657286c: 900c4068    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
106572870: 912db108    	add	x8, x8, #0xb6c
106572874: b9800115    	ldrsw	x21, [x8]
106572878: f8756a60    	ldr	x0, [x19, x21]
10657287c: f8746a62    	ldr	x2, [x19, x20]
106572880: f00c3988    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
106572884: f9456501    	ldr	x1, [x8, #0xac8] ; selector: addSubview:
106572888: 945ad4f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657288c: f8756a60    	ldr	x0, [x19, x21]
106572890: f8746a62    	ldr	x2, [x19, x20]
106572894: d00c2328    	adrp	x8, 0x11e9d8000 <dyld_stub_binder+0x11e9d8000>
106572898: f9434101    	ldr	x1, [x8, #0x680] ; selector: sendSubviewToBack:
10657289c: 945ad4f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065728a0: 140000fc    	b	0x106572c90 <_Flutter_MMFoundation_BindContext+0x27f995c>
1065728a4: aa1a03e0    	mov	x0, x26
1065728a8: 945ad4f2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065728ac: 7100071f    	cmp	w24, #0x1
1065728b0: 540000a1    	b.ne	0x1065728c4 <_Flutter_MMFoundation_BindContext+0x27f9590>
1065728b4: aa1903e0    	mov	x0, x25
1065728b8: 945ad4ee    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065728bc: aa1703e0    	mov	x0, x23
1065728c0: 945ad4ec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065728c4: aa1603e0    	mov	x0, x22
1065728c8: 945ad4ea    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065728cc: aa1303e0    	mov	x0, x19
1065728d0: aa1c03e1    	mov	x1, x28
1065728d4: 945ad4e4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065728d8: aa1d03fd    	mov	x29, x29
1065728dc: 945ad4e9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065728e0: aa0003f6    	mov	x22, x0
1065728e4: aa1503e1    	mov	x1, x21
1065728e8: 945ad4df    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065728ec: 7100041f    	cmp	w0, #0x1
1065728f0: 540006c1    	b.ne	0x1065729c8 <_Flutter_MMFoundation_BindContext+0x27f9694>
1065728f4: aa1303e0    	mov	x0, x19
1065728f8: aa1c03e1    	mov	x1, x28
1065728fc: 945ad4da    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572900: aa1d03fd    	mov	x29, x29
106572904: 945ad4df    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572908: aa0003f4    	mov	x20, x0
10657290c: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106572910: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
106572914: 945ad4d4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572918: aa1d03fd    	mov	x29, x29
10657291c: 945ad4d9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572920: aa0003f7    	mov	x23, x0
106572924: 900c2368    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
106572928: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector: IsRecording
10657292c: 945ad4ce    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572930: aa0003f8    	mov	x24, x0
106572934: aa1703e0    	mov	x0, x23
106572938: 945ad4ce    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10657293c: aa1403e0    	mov	x0, x20
106572940: 945ad4cc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572944: aa1603e0    	mov	x0, x22
106572948: 945ad4ca    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10657294c: 37000438    	tbnz	w24, #0x0, 0x1065729d0 <_Flutter_MMFoundation_BindContext+0x27f969c>
106572950: f00c40a8    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
106572954: 9122d108    	add	x8, x8, #0x8b4
106572958: b9800108    	ldrsw	x8, [x8]
10657295c: f8686a60    	ldr	x0, [x19, x8]
106572960: b00c39c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106572964: f9458d14    	ldr	x20, [x8, #0xb18] ; selector: setHidden:
106572968: aa1403e1    	mov	x1, x20
10657296c: 52800002    	mov	w2, #0x0                ; =0
106572970: 945ad4bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572974: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572978: b98c7908    	ldrsw	x8, [x8, #0xc78] ; ivar: VoiceMessageCellView.m_secLabel offset=200
10657297c: f8686a60    	ldr	x0, [x19, x8]
106572980: aa1403e1    	mov	x1, x20
106572984: 52800022    	mov	w2, #0x1                ; =1
106572988: 945ad4b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10657298c: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572990: b98c7d08    	ldrsw	x8, [x8, #0xc7c] ; ivar: VoiceMessageCellView.m_playingImageView offset=208
106572994: f8686a60    	ldr	x0, [x19, x8]
106572998: aa1403e1    	mov	x1, x20
10657299c: 52800022    	mov	w2, #0x1                ; =1
1065729a0: 945ad4b1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065729a4: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
1065729a8: b98c9908    	ldrsw	x8, [x8, #0xc98] ; ivar: VoiceMessageCellView.m_recordingView offset=216
1065729ac: f8686a60    	ldr	x0, [x19, x8]
1065729b0: 900c39c8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1065729b4: f9424901    	ldr	x1, [x8, #0x490] ; selector: removeFromSuperview
1065729b8: 945ad4ab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065729bc: f00c2528    	adrp	x8, 0x11ea19000 <dyld_stub_binder+0x11ea19000>
1065729c0: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector: addSendingView
1065729c4: 140000b1    	b	0x106572c88 <_Flutter_MMFoundation_BindContext+0x27f9954>
1065729c8: aa1603e0    	mov	x0, x22
1065729cc: 945ad4a9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065729d0: aa1303e0    	mov	x0, x19
1065729d4: aa1c03e1    	mov	x1, x28
1065729d8: 945ad4a3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065729dc: aa1d03fd    	mov	x29, x29
1065729e0: 945ad4a8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065729e4: aa0003f6    	mov	x22, x0
1065729e8: aa1503e1    	mov	x1, x21
1065729ec: 945ad49e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065729f0: 7100101f    	cmp	w0, #0x4
1065729f4: 54000321    	b.ne	0x106572a58 <_Flutter_MMFoundation_BindContext+0x27f9724>
1065729f8: aa1303e0    	mov	x0, x19
1065729fc: aa1c03e1    	mov	x1, x28
106572a00: 945ad499    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572a04: aa1d03fd    	mov	x29, x29
106572a08: 945ad49e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572a0c: aa0003f4    	mov	x20, x0
106572a10: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106572a14: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
106572a18: 945ad493    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572a1c: aa1d03fd    	mov	x29, x29
106572a20: 945ad498    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572a24: aa0003f7    	mov	x23, x0
106572a28: d00c2308    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
106572a2c: f9455101    	ldr	x1, [x8, #0xaa0] ; selector: IsDownloadEnded
106572a30: 945ad48d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572a34: aa0003f8    	mov	x24, x0
106572a38: aa1703e0    	mov	x0, x23
106572a3c: 945ad48d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572a40: aa1403e0    	mov	x0, x20
106572a44: 945ad48b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572a48: aa1603e0    	mov	x0, x22
106572a4c: 945ad489    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572a50: 37000098    	tbnz	w24, #0x0, 0x106572a60 <_Flutter_MMFoundation_BindContext+0x27f972c>
106572a54: 14000042    	b	0x106572b5c <_Flutter_MMFoundation_BindContext+0x27f9828>
106572a58: aa1603e0    	mov	x0, x22
106572a5c: 945ad485    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572a60: aa1303e0    	mov	x0, x19
106572a64: aa1c03e1    	mov	x1, x28
106572a68: 945ad47f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572a6c: aa1d03fd    	mov	x29, x29
106572a70: 945ad484    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572a74: aa0003f6    	mov	x22, x0
106572a78: aa1503e1    	mov	x1, x21
106572a7c: 945ad47a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572a80: 7100081f    	cmp	w0, #0x2
106572a84: 54000081    	b.ne	0x106572a94 <_Flutter_MMFoundation_BindContext+0x27f9760>
106572a88: aa1603e0    	mov	x0, x22
106572a8c: 945ad479    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572a90: 14000033    	b	0x106572b5c <_Flutter_MMFoundation_BindContext+0x27f9828>
106572a94: aa1303e0    	mov	x0, x19
106572a98: aa1c03e1    	mov	x1, x28
106572a9c: 945ad472    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572aa0: aa1d03fd    	mov	x29, x29
106572aa4: 945ad477    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572aa8: aa0003f7    	mov	x23, x0
106572aac: aa1503e1    	mov	x1, x21
106572ab0: 945ad46d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572ab4: aa0003f8    	mov	x24, x0
106572ab8: 71000c1f    	cmp	w0, #0x3
106572abc: 54000160    	b.eq	0x106572ae8 <_Flutter_MMFoundation_BindContext+0x27f97b4>
106572ac0: aa1303e0    	mov	x0, x19
106572ac4: aa1c03e1    	mov	x1, x28
106572ac8: 945ad467    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572acc: aa1d03fd    	mov	x29, x29
106572ad0: 945ad46c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572ad4: aa0003f9    	mov	x25, x0
106572ad8: aa1503e1    	mov	x1, x21
106572adc: 945ad462    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572ae0: 7100101f    	cmp	w0, #0x4
106572ae4: 54000721    	b.ne	0x106572bc8 <_Flutter_MMFoundation_BindContext+0x27f9894>
106572ae8: aa1303e0    	mov	x0, x19
106572aec: aa1c03e1    	mov	x1, x28
106572af0: 945ad45d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572af4: aa1d03fd    	mov	x29, x29
106572af8: 945ad462    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572afc: aa0003f4    	mov	x20, x0
106572b00: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106572b04: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
106572b08: 945ad457    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572b0c: aa1d03fd    	mov	x29, x29
106572b10: 945ad45c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572b14: aa0003fb    	mov	x27, x0
106572b18: d00c2308    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
106572b1c: f9455101    	ldr	x1, [x8, #0xaa0] ; selector: IsDownloadEnded
106572b20: 945ad451    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572b24: aa0003fa    	mov	x26, x0
106572b28: aa1b03e0    	mov	x0, x27
106572b2c: 945ad451    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572b30: aa1403e0    	mov	x0, x20
106572b34: 945ad44f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572b38: 71000f1f    	cmp	w24, #0x3
106572b3c: 54000060    	b.eq	0x106572b48 <_Flutter_MMFoundation_BindContext+0x27f9814>
106572b40: aa1903e0    	mov	x0, x25
106572b44: 945ad44b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572b48: aa1703e0    	mov	x0, x23
106572b4c: 945ad449    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572b50: aa1603e0    	mov	x0, x22
106572b54: 945ad447    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572b58: 3600045a    	tbz	w26, #0x0, 0x106572be0 <_Flutter_MMFoundation_BindContext+0x27f98ac>
106572b5c: f00c40a8    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
106572b60: 9122d108    	add	x8, x8, #0x8b4
106572b64: b9800108    	ldrsw	x8, [x8]
106572b68: f8686a60    	ldr	x0, [x19, x8]
106572b6c: b00c39c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106572b70: f9458d14    	ldr	x20, [x8, #0xb18] ; selector: setHidden:
106572b74: aa1403e1    	mov	x1, x20
106572b78: 52800002    	mov	w2, #0x0                ; =0
106572b7c: 945ad43a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572b80: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572b84: b98c7908    	ldrsw	x8, [x8, #0xc78] ; ivar: VoiceMessageCellView.m_secLabel offset=200
106572b88: f8686a60    	ldr	x0, [x19, x8]
106572b8c: aa1403e1    	mov	x1, x20
106572b90: 52800002    	mov	w2, #0x0                ; =0
106572b94: 945ad434    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572b98: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572b9c: b98c7d08    	ldrsw	x8, [x8, #0xc7c] ; ivar: VoiceMessageCellView.m_playingImageView offset=208
106572ba0: f8686a60    	ldr	x0, [x19, x8]
106572ba4: aa1403e1    	mov	x1, x20
106572ba8: 52800002    	mov	w2, #0x0                ; =0
106572bac: 945ad42e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572bb0: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572bb4: b98c9908    	ldrsw	x8, [x8, #0xc98] ; ivar: VoiceMessageCellView.m_recordingView offset=216
106572bb8: f8686a60    	ldr	x0, [x19, x8]
106572bbc: 900c39c8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
106572bc0: f9424901    	ldr	x1, [x8, #0x490] ; selector: removeFromSuperview
106572bc4: 14000032    	b	0x106572c8c <_Flutter_MMFoundation_BindContext+0x27f9958>
106572bc8: aa1903e0    	mov	x0, x25
106572bcc: 945ad429    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572bd0: aa1703e0    	mov	x0, x23
106572bd4: 945ad427    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572bd8: aa1603e0    	mov	x0, x22
106572bdc: 945ad425    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572be0: aa1303e0    	mov	x0, x19
106572be4: aa1c03e1    	mov	x1, x28
106572be8: 945ad41f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572bec: aa1d03fd    	mov	x29, x29
106572bf0: 945ad424    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572bf4: aa0003f4    	mov	x20, x0
106572bf8: aa1503e1    	mov	x1, x21
106572bfc: 945ad41a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c00: aa0003f5    	mov	x21, x0
106572c04: aa1403e0    	mov	x0, x20
106572c08: 945ad41a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572c0c: 710016bf    	cmp	w21, #0x5
106572c10: 54000401    	b.ne	0x106572c90 <_Flutter_MMFoundation_BindContext+0x27f995c>
106572c14: f00c40a8    	adrp	x8, 0x11ed89000 <dyld_stub_binder+0x11ed89000>
106572c18: 9122d108    	add	x8, x8, #0x8b4
106572c1c: b9800108    	ldrsw	x8, [x8]
106572c20: f8686a60    	ldr	x0, [x19, x8]
106572c24: b00c39c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106572c28: f9458d14    	ldr	x20, [x8, #0xb18] ; selector: setHidden:
106572c2c: aa1403e1    	mov	x1, x20
106572c30: 52800002    	mov	w2, #0x0                ; =0
106572c34: 945ad40c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c38: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572c3c: b98c7908    	ldrsw	x8, [x8, #0xc78] ; ivar: VoiceMessageCellView.m_secLabel offset=200
106572c40: f8686a60    	ldr	x0, [x19, x8]
106572c44: aa1403e1    	mov	x1, x20
106572c48: 52800022    	mov	w2, #0x1                ; =1
106572c4c: 945ad406    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c50: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572c54: b98c7d08    	ldrsw	x8, [x8, #0xc7c] ; ivar: VoiceMessageCellView.m_playingImageView offset=208
106572c58: f8686a60    	ldr	x0, [x19, x8]
106572c5c: aa1403e1    	mov	x1, x20
106572c60: 52800002    	mov	w2, #0x0                ; =0
106572c64: 945ad400    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c68: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572c6c: b98c9908    	ldrsw	x8, [x8, #0xc98] ; ivar: VoiceMessageCellView.m_recordingView offset=216
106572c70: f8686a60    	ldr	x0, [x19, x8]
106572c74: 900c39c8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
106572c78: f9424901    	ldr	x1, [x8, #0x490] ; selector: removeFromSuperview
106572c7c: 945ad3fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c80: 900c2308    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
106572c84: f945a101    	ldr	x1, [x8, #0xb40] ; selector: addSendFailButton
106572c88: aa1303e0    	mov	x0, x19
106572c8c: 945ad3f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c90: aa1303e0    	mov	x0, x19
106572c94: aa1c03e1    	mov	x1, x28
106572c98: 945ad3f3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572c9c: aa1d03fd    	mov	x29, x29
106572ca0: 945ad3f8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572ca4: aa0003f5    	mov	x21, x0
106572ca8: b00c22e8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106572cac: f941b101    	ldr	x1, [x8, #0x360] ; selector: isSender
106572cb0: 945ad3ed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572cb4: 370009a0    	tbnz	w0, #0x0, 0x106572de8 <_Flutter_MMFoundation_BindContext+0x27f9ab4>
106572cb8: aa1303e0    	mov	x0, x19
106572cbc: aa1c03e1    	mov	x1, x28
106572cc0: 945ad3e9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572cc4: aa1d03fd    	mov	x29, x29
106572cc8: 945ad3ee    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572ccc: aa0003f6    	mov	x22, x0
106572cd0: 900c22e8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
106572cd4: f941bd18    	ldr	x24, [x8, #0x378] ; selector: messageWrap
106572cd8: aa1803e1    	mov	x1, x24
106572cdc: 945ad3e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572ce0: aa1d03fd    	mov	x29, x29
106572ce4: 945ad3e7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572ce8: aa0003f7    	mov	x23, x0
106572cec: d00c2308    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
106572cf0: f9455101    	ldr	x1, [x8, #0xaa0] ; selector: IsDownloadEnded
106572cf4: 945ad3dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572cf8: 36000700    	tbz	w0, #0x0, 0x106572dd8 <_Flutter_MMFoundation_BindContext+0x27f9aa4>
106572cfc: aa1303e0    	mov	x0, x19
106572d00: aa1c03e1    	mov	x1, x28
106572d04: 945ad3d8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572d08: aa1d03fd    	mov	x29, x29
106572d0c: 945ad3dd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572d10: aa0003f4    	mov	x20, x0
106572d14: aa1803e1    	mov	x1, x24
106572d18: 945ad3d3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572d1c: aa1d03fd    	mov	x29, x29
106572d20: 945ad3d8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106572d24: aa0003f8    	mov	x24, x0
106572d28: d00c2308    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
106572d2c: f9453d01    	ldr	x1, [x8, #0xa78] ; selector: IsUnPlayed
106572d30: 945ad3cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572d34: aa0003f9    	mov	x25, x0
106572d38: aa1803e0    	mov	x0, x24
106572d3c: 945ad3cd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572d40: aa1403e0    	mov	x0, x20
106572d44: 945ad3cb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572d48: aa1703e0    	mov	x0, x23
106572d4c: 945ad3c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572d50: aa1603e0    	mov	x0, x22
106572d54: 945ad3c7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572d58: aa1503e0    	mov	x0, x21
106572d5c: 945ad3c5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572d60: 34000499    	cbz	w25, 0x106572df0 <_Flutter_MMFoundation_BindContext+0x27f9abc>
106572d64: b00c3008    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106572d68: f9425d01    	ldr	x1, [x8, #0x4b8] ; selector: initUnreadView
106572d6c: aa1303e0    	mov	x0, x19
106572d70: 945ad3bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572d74: 900c4068    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
106572d78: 912db108    	add	x8, x8, #0xb6c
106572d7c: b9800108    	ldrsw	x8, [x8]
106572d80: f8686a60    	ldr	x0, [x19, x8]
106572d84: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572d88: b98c9d08    	ldrsw	x8, [x8, #0xc9c] ; ivar: VoiceMessageCellView.m_unreadImageView offset=224
106572d8c: f8686a62    	ldr	x2, [x19, x8]
106572d90: f00c3988    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
106572d94: f9456501    	ldr	x1, [x8, #0xac8] ; selector: addSubview:
106572d98: 945ad3b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572d9c: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572da0: b98c8108    	ldrsw	x8, [x8, #0xc80] ; ivar: VoiceMessageCellView.transTipButtonContainer offset=240
106572da4: f8686a60    	ldr	x0, [x19, x8]
106572da8: b00c39c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
106572dac: f9458d01    	ldr	x1, [x8, #0xb18] ; selector: setHidden:
106572db0: 52800002    	mov	w2, #0x0                ; =0
106572db4: 945ad3ac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572db8: b00c3008    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106572dbc: f9426101    	ldr	x1, [x8, #0x4c0] ; selector: updateQuickTransTipButtonPosition
106572dc0: aa1303e0    	mov	x0, x19
106572dc4: 945ad3a8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572dc8: b00c3008    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106572dcc: f9422501    	ldr	x1, [x8, #0x448] ; selector: reportQuickTransTipExposureIfNeeded
106572dd0: aa1303e0    	mov	x0, x19
106572dd4: 14000012    	b	0x106572e1c <_Flutter_MMFoundation_BindContext+0x27f9ae8>
106572dd8: aa1703e0    	mov	x0, x23
106572ddc: 945ad3a5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572de0: aa1603e0    	mov	x0, x22
106572de4: 945ad3a3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572de8: aa1503e0    	mov	x0, x21
106572dec: 945ad3a1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106572df0: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572df4: b98c9d08    	ldrsw	x8, [x8, #0xc9c] ; ivar: VoiceMessageCellView.m_unreadImageView offset=224
106572df8: f8686a60    	ldr	x0, [x19, x8]
106572dfc: 900c39c8    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
106572e00: f9424914    	ldr	x20, [x8, #0x490] ; selector: removeFromSuperview
106572e04: aa1403e1    	mov	x1, x20
106572e08: 945ad397    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572e0c: 900c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106572e10: b98c8108    	ldrsw	x8, [x8, #0xc80] ; ivar: VoiceMessageCellView.transTipButtonContainer offset=240
106572e14: f8686a60    	ldr	x0, [x19, x8]
106572e18: aa1403e1    	mov	x1, x20
106572e1c: 945ad392    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106572e20: b00c3008    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106572e24: f9421901    	ldr	x1, [x8, #0x430] ; selector: updateVoiceLength
106572e28: aa1303e0    	mov	x0, x19
106572e2c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
106572e30: a9454ff4    	ldp	x20, x19, [sp, #0x50]
106572e34: a94457f6    	ldp	x22, x21, [sp, #0x40]
106572e38: a9435ff8    	ldp	x24, x23, [sp, #0x30]
106572e3c: a94267fa    	ldp	x26, x25, [sp, #0x20]
106572e40: a9416ffc    	ldp	x28, x27, [sp, #0x10]
106572e44: 9101c3ff    	add	sp, sp, #0x70
106572e48: 145ad387    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
