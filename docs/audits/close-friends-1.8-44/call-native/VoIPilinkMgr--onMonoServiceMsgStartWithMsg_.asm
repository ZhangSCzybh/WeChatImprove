
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106265788: d10203ff    	sub	sp, sp, #0x80
10626578c: a9026ffc    	stp	x28, x27, [sp, #0x20]
106265790: a90367fa    	stp	x26, x25, [sp, #0x30]
106265794: a9045ff8    	stp	x24, x23, [sp, #0x40]
106265798: a90557f6    	stp	x22, x21, [sp, #0x50]
10626579c: a9064ff4    	stp	x20, x19, [sp, #0x60]
1062657a0: a9077bfd    	stp	x29, x30, [sp, #0x70]
1062657a4: 9101c3fd    	add	x29, sp, #0x70
1062657a8: aa0203f3    	mov	x19, x2
1062657ac: aa0003f5    	mov	x21, x0
1062657b0: d00d4ee8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062657b4: 52800029    	mov	w9, #0x1                ; =1
1062657b8: 3926b909    	strb	w9, [x8, #0x9ae]
1062657bc: aa0203e0    	mov	x0, x2
1062657c0: 9467065e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1062657c4: b00cf8a8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
1062657c8: f941e500    	ldr	x0, [x8, #0x3c8] ; 0[;
1062657cc: d00cf4c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1062657d0: f947ad14    	ldr	x20, [x8, #0xf58] ; class
1062657d4: aa1403e1    	mov	x1, x20
1062657d8: 94670659    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062657dc: aa0003e2    	mov	x2, x0
1062657e0: d00cf4e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1062657e4: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1062657e8: aa1303e0    	mov	x0, x19
1062657ec: 94670654    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062657f0: 36001120    	tbz	w0, #0x0, 0x106265a14 <_Flutter_MMFoundation_BindContext+0x27415f8>
1062657f4: aa1303e0    	mov	x0, x19
1062657f8: 94670650    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1062657fc: 52800040    	mov	w0, #0x2                ; =2
106265800: 94669e90    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106265804: 34000560    	cbz	w0, 0x1062658b0 <_Flutter_MMFoundation_BindContext+0x2741494>
106265808: 94670666    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10626580c: aa0003f6    	mov	x22, x0
106265810: d00cf878    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106265814: f9454700    	ldr	x0, [x24, #0xa88]
106265818: 94670652    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10626581c: aa0003f7    	mov	x23, x0
106265820: f9454700    	ldr	x0, [x24, #0xa88]
106265824: b00cf528    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106265828: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10626582c: a9007ff3    	stp	x19, xzr, [sp]
106265830: 900c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106265834: 912f2042    	add	x2, x2, #0xbc8
106265838: 94670641    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10626583c: aa1d03fd    	mov	x29, x29
106265840: 94670642    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265844: aa0003f8    	mov	x24, x0
106265848: b00cf4e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10626584c: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106265850: d00c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265854: 91352108    	add	x8, x8, #0xd48
106265858: a90003e8    	stp	x8, x0, [sp]
10626585c: d00c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265860: 9134a042    	add	x2, x2, #0xd28
106265864: aa1703e0    	mov	x0, x23
106265868: 94670635    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10626586c: aa0003f7    	mov	x23, x0
106265870: aa1803e0    	mov	x0, x24
106265874: 94670638    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265878: b00ab7e1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
10626587c: 91373c21    	add	x1, x1, #0xdcf
106265880: b00ab9c2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106265884: 91112042    	add	x2, x2, #0x448
106265888: 900ab9e4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
10626588c: 91063c84    	add	x4, x4, #0x18f
106265890: 52800040    	mov	w0, #0x2                ; =2
106265894: 5281af43    	mov	w3, #0xd7a              ; =3450
106265898: aa1703e5    	mov	x5, x23
10626589c: 94669e6a    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1062658a0: aa1703e0    	mov	x0, x23
1062658a4: 9467062c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062658a8: aa1603e0    	mov	x0, x22
1062658ac: 94670640    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1062658b0: d00cf8a8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1062658b4: f940fd00    	ldr	x0, [x8, #0x1f8]
1062658b8: b00ceb28    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
1062658bc: f9412501    	ldr	x1, [x8, #0x248] ; startVoipViewByVoipMonoMsg:
1062658c0: aa1303e2    	mov	x2, x19
1062658c4: 9467061e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062658c8: aa0003f6    	mov	x22, x0
1062658cc: 52800040    	mov	w0, #0x2                ; =2
1062658d0: 94669e5c    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1062658d4: d00cf87b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1062658d8: f00cf4dc    	adrp	x28, 0x120100000 <dyld_stub_binder+0x120100000>
1062658dc: d00cf95a    	adrp	x26, 0x12018f000 <dyld_stub_binder+0x12018f000>
1062658e0: 900cdeb9    	adrp	x25, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062658e4: 34000ff6    	cbz	w22, 0x106265ae0 <_Flutter_MMFoundation_BindContext+0x27416c4>
1062658e8: 34000560    	cbz	w0, 0x106265994 <_Flutter_MMFoundation_BindContext+0x2741578>
1062658ec: 9467062d    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1062658f0: aa0003f6    	mov	x22, x0
1062658f4: d00cf878    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1062658f8: f9454700    	ldr	x0, [x24, #0xa88]
1062658fc: 94670619    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106265900: aa0003f7    	mov	x23, x0
106265904: f9454700    	ldr	x0, [x24, #0xa88]
106265908: b00cf528    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10626590c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106265910: a9007ff3    	stp	x19, xzr, [sp]
106265914: 900c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106265918: 912fa042    	add	x2, x2, #0xbe8
10626591c: 94670608    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265920: aa1d03fd    	mov	x29, x29
106265924: 94670609    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265928: aa0003f8    	mov	x24, x0
10626592c: b00cf4e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106265930: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106265934: d00c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265938: 91352108    	add	x8, x8, #0xd48
10626593c: a90003e8    	stp	x8, x0, [sp]
106265940: d00c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265944: 9134a042    	add	x2, x2, #0xd28
106265948: aa1703e0    	mov	x0, x23
10626594c: 946705fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265950: aa0003f7    	mov	x23, x0
106265954: aa1803e0    	mov	x0, x24
106265958: 946705ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10626595c: b00ab7e1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
106265960: 91373c21    	add	x1, x1, #0xdcf
106265964: b00ab9c2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106265968: 91112042    	add	x2, x2, #0x448
10626596c: 900ab9e4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106265970: 91063c84    	add	x4, x4, #0x18f
106265974: 52800040    	mov	w0, #0x2                ; =2
106265978: 5281afc3    	mov	w3, #0xd7e              ; =3454
10626597c: aa1703e5    	mov	x5, x23
106265980: 94669e31    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106265984: aa1703e0    	mov	x0, x23
106265988: 946705f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10626598c: aa1603e0    	mov	x0, x22
106265990: 94670607    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106265994: b00cf888    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
106265998: f9421500    	ldr	x0, [x8, #0x428]
10626599c: b00ceb28    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
1062659a0: f9412901    	ldr	x1, [x8, #0x250] ; dataReportAppSettingsWithVoipMonoMsg:
1062659a4: aa1303e2    	mov	x2, x19
1062659a8: 946705e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062659ac: f00cf988    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
1062659b0: f9463100    	ldr	x0, [x8, #0xc60]
1062659b4: b00ceb28    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
1062659b8: f9412d01    	ldr	x1, [x8, #0x258] ; logicStartUIDirectlyOk
1062659bc: 946705e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062659c0: d00cf917    	adrp	x23, 0x120187000 <dyld_stub_binder+0x120187000>
1062659c4: f943aae0    	ldr	x0, [x23, #0x750]
1062659c8: 900ce988    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
1062659cc: f9407501    	ldr	x1, [x8, #0xe8] ; isAppStateActive
1062659d0: 946705db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062659d4: 370012a0    	tbnz	w0, #0x0, 0x106265c28 <_Flutter_MMFoundation_BindContext+0x274180c>
1062659d8: f943aaf6    	ldr	x22, [x23, #0x750]
1062659dc: f00ce928    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
1062659e0: f944c901    	ldr	x1, [x8, #0x990] ; m_mode
1062659e4: aa1303e0    	mov	x0, x19
1062659e8: 946705d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062659ec: 7100001f    	cmp	w0, #0x0
1062659f0: 1a9f17e2    	cset	w2, eq
1062659f4: 900ce988    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
1062659f8: f9407901    	ldr	x1, [x8, #0xf0] ; getIfCanUseCX:isMultiTalk:
1062659fc: aa1603e0    	mov	x0, x22
106265a00: 52800003    	mov	w3, #0x0                ; =0
106265a04: 946705ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265a08: 36001100    	tbz	w0, #0x0, 0x106265c28 <_Flutter_MMFoundation_BindContext+0x274180c>
106265a0c: 52800036    	mov	w22, #0x1               ; =1
106265a10: 1400008b    	b	0x106265c3c <_Flutter_MMFoundation_BindContext+0x2741820>
106265a14: f00cf988    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
106265a18: f9463100    	ldr	x0, [x8, #0xc60]
106265a1c: 900ce988    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
106265a20: f9405101    	ldr	x1, [x8, #0xa0] ; logicStartErrorMsgType
106265a24: 946705c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265a28: 52800080    	mov	w0, #0x4                ; =4
106265a2c: 94669e05    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106265a30: 34000ea0    	cbz	w0, 0x106265c04 <_Flutter_MMFoundation_BindContext+0x27417e8>
106265a34: 946705db    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106265a38: aa0003f4    	mov	x20, x0
106265a3c: d00cf876    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
106265a40: f94546c0    	ldr	x0, [x22, #0xa88]
106265a44: 946705c7    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106265a48: aa0003f5    	mov	x21, x0
106265a4c: f94546c0    	ldr	x0, [x22, #0xa88]
106265a50: b00cf528    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106265a54: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106265a58: a9007ff3    	stp	x19, xzr, [sp]
106265a5c: 900c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106265a60: 912ea042    	add	x2, x2, #0xba8
106265a64: 946705b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265a68: aa1d03fd    	mov	x29, x29
106265a6c: 946705b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265a70: aa0003f6    	mov	x22, x0
106265a74: b00cf4e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106265a78: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106265a7c: d00c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265a80: 91362108    	add	x8, x8, #0xd88
106265a84: a90003e8    	stp	x8, x0, [sp]
106265a88: d00c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265a8c: 9134a042    	add	x2, x2, #0xd28
106265a90: aa1503e0    	mov	x0, x21
106265a94: 946705aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265a98: aa0003f5    	mov	x21, x0
106265a9c: aa1603e0    	mov	x0, x22
106265aa0: 946705ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265aa4: b00ab7e1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
106265aa8: 91373c21    	add	x1, x1, #0xdcf
106265aac: b00ab9c2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106265ab0: 91112042    	add	x2, x2, #0x448
106265ab4: 900ab9e4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106265ab8: 91063c84    	add	x4, x4, #0x18f
106265abc: 52800080    	mov	w0, #0x4                ; =4
106265ac0: 5281ae83    	mov	w3, #0xd74              ; =3444
106265ac4: aa1503e5    	mov	x5, x21
106265ac8: 94669ddf    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106265acc: aa1503e0    	mov	x0, x21
106265ad0: 946705a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265ad4: aa1403e0    	mov	x0, x20
106265ad8: 946705b5    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106265adc: 1400004a    	b	0x106265c04 <_Flutter_MMFoundation_BindContext+0x27417e8>
106265ae0: 34000560    	cbz	w0, 0x106265b8c <_Flutter_MMFoundation_BindContext+0x2741770>
106265ae4: 946705af    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106265ae8: aa0003f5    	mov	x21, x0
106265aec: d00cf877    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
106265af0: f94546e0    	ldr	x0, [x23, #0xa88]
106265af4: 9467059b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106265af8: aa0003f6    	mov	x22, x0
106265afc: f94546e0    	ldr	x0, [x23, #0xa88]
106265b00: b00cf528    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106265b04: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106265b08: a9007ff3    	stp	x19, xzr, [sp]
106265b0c: 900c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106265b10: 9130a042    	add	x2, x2, #0xc28
106265b14: 9467058a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265b18: aa1d03fd    	mov	x29, x29
106265b1c: 9467058b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265b20: aa0003f7    	mov	x23, x0
106265b24: b00cf4e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106265b28: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106265b2c: d00c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265b30: 91352108    	add	x8, x8, #0xd48
106265b34: a90003e8    	stp	x8, x0, [sp]
106265b38: d00c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265b3c: 9134a042    	add	x2, x2, #0xd28
106265b40: aa1603e0    	mov	x0, x22
106265b44: 9467057e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265b48: aa0003f6    	mov	x22, x0
106265b4c: aa1703e0    	mov	x0, x23
106265b50: 94670581    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265b54: b00ab7e1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
106265b58: 91373c21    	add	x1, x1, #0xdcf
106265b5c: b00ab9c2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106265b60: 91112042    	add	x2, x2, #0x448
106265b64: 900ab9e4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106265b68: 91063c84    	add	x4, x4, #0x18f
106265b6c: 52800040    	mov	w0, #0x2                ; =2
106265b70: 5281b3a3    	mov	w3, #0xd9d              ; =3485
106265b74: aa1603e5    	mov	x5, x22
106265b78: 94669db3    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106265b7c: aa1603e0    	mov	x0, x22
106265b80: 94670575    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265b84: aa1503e0    	mov	x0, x21
106265b88: 94670589    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106265b8c: f00cf988    	adrp	x8, 0x120198000 <dyld_stub_binder+0x120198000>
106265b90: f9463100    	ldr	x0, [x8, #0xc60]
106265b94: b00ceb28    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
106265b98: f9413101    	ldr	x1, [x8, #0x260] ; logicStartUIDirectlyError
106265b9c: 94670568    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265ba0: f945eb60    	ldr	x0, [x27, #0xbd0]
106265ba4: f944eb81    	ldr	x1, [x28, #0x9d0] ; currentContext
106265ba8: 94670565    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265bac: aa1d03fd    	mov	x29, x29
106265bb0: 94670566    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265bb4: aa0003f5    	mov	x21, x0
106265bb8: f9473b40    	ldr	x0, [x26, #0xe70]
106265bbc: aa1403e1    	mov	x1, x20
106265bc0: 9467055f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265bc4: aa0003e2    	mov	x2, x0
106265bc8: f9464321    	ldr	x1, [x25, #0xc80] ; getService:
106265bcc: aa1503e0    	mov	x0, x21
106265bd0: 9467055b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265bd4: aa1d03fd    	mov	x29, x29
106265bd8: 9467055c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265bdc: aa0003f4    	mov	x20, x0
106265be0: f00ce928    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
106265be4: f9448d01    	ldr	x1, [x8, #0x918] ; checkMsgQueue
106265be8: 94670555    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265bec: aa1403e0    	mov	x0, x20
106265bf0: 94670559    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265bf4: aa1503e0    	mov	x0, x21
106265bf8: 94670557    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265bfc: aa1303e0    	mov	x0, x19
106265c00: 94670555    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265c04: aa1303e0    	mov	x0, x19
106265c08: a9477bfd    	ldp	x29, x30, [sp, #0x70]
106265c0c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
106265c10: a94557f6    	ldp	x22, x21, [sp, #0x50]
106265c14: a9445ff8    	ldp	x24, x23, [sp, #0x40]
106265c18: a94367fa    	ldp	x26, x25, [sp, #0x30]
106265c1c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
106265c20: 910203ff    	add	sp, sp, #0x80
106265c24: 1467054c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265c28: f943aae0    	ldr	x0, [x23, #0x750]
106265c2c: 900ce488    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
106265c30: f9476901    	ldr	x1, [x8, #0xed0] ; getIfHaveAProcess
106265c34: 94670542    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265c38: aa0003f6    	mov	x22, x0
106265c3c: 900ceb48    	adrp	x8, 0x11ffcd000 <dyld_stub_binder+0x11ffcd000>
106265c40: f9472101    	ldr	x1, [x8, #0xe40] ; setIsCallKit:
106265c44: aa1503e0    	mov	x0, x21
106265c48: aa1603e2    	mov	x2, x22
106265c4c: 9467053c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265c50: 52800040    	mov	w0, #0x2                ; =2
106265c54: 94669d7b    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106265c58: 34000560    	cbz	w0, 0x106265d04 <_Flutter_MMFoundation_BindContext+0x27418e8>
106265c5c: 94670551    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106265c60: aa0003f5    	mov	x21, x0
106265c64: d00cf878    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106265c68: f9454700    	ldr	x0, [x24, #0xa88]
106265c6c: 9467053d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106265c70: aa0003f7    	mov	x23, x0
106265c74: f9454700    	ldr	x0, [x24, #0xa88]
106265c78: b00cf528    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106265c7c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106265c80: a9007ff6    	stp	x22, xzr, [sp]
106265c84: 900c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106265c88: 91302042    	add	x2, x2, #0xc08
106265c8c: 9467052c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265c90: aa1d03fd    	mov	x29, x29
106265c94: 9467052d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265c98: aa0003f8    	mov	x24, x0
106265c9c: b00cf4e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106265ca0: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106265ca4: d00c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265ca8: 91352108    	add	x8, x8, #0xd48
106265cac: a90003e8    	stp	x8, x0, [sp]
106265cb0: d00c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265cb4: 9134a042    	add	x2, x2, #0xd28
106265cb8: aa1703e0    	mov	x0, x23
106265cbc: 94670520    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265cc0: aa0003f7    	mov	x23, x0
106265cc4: aa1803e0    	mov	x0, x24
106265cc8: 94670523    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265ccc: b00ab7e1    	adrp	x1, 0x11b962000 <dyld_stub_binder+0x11b962000>
106265cd0: 91373c21    	add	x1, x1, #0xdcf
106265cd4: b00ab9c2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106265cd8: 91112042    	add	x2, x2, #0x448
106265cdc: 900ab9e4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106265ce0: 91063c84    	add	x4, x4, #0x18f
106265ce4: 52800040    	mov	w0, #0x2                ; =2
106265ce8: 5281b0e3    	mov	w3, #0xd87              ; =3463
106265cec: aa1703e5    	mov	x5, x23
106265cf0: 94669d55    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106265cf4: aa1703e0    	mov	x0, x23
106265cf8: 94670517    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265cfc: aa1503e0    	mov	x0, x21
106265d00: 9467052b    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106265d04: d00cf868    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106265d08: f9468d00    	ldr	x0, [x8, #0xd18]
106265d0c: d00cf4e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106265d10: f9457d01    	ldr	x1, [x8, #0xaf8] ; isiPad
106265d14: 9467050a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265d18: aa0003f7    	mov	x23, x0
106265d1c: d00cf868    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106265d20: f9471100    	ldr	x0, [x8, #0xe20]
106265d24: b00cdea8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106265d28: f946f101    	ldr	x1, [x8, #0xde0] ; getMainSetting
106265d2c: 94670504    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265d30: aa1d03fd    	mov	x29, x29
106265d34: 94670505    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265d38: aa0003f8    	mov	x24, x0
106265d3c: f00cdea8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106265d40: f942d501    	ldr	x1, [x8, #0x5a8] ; m_uiExtStatus
106265d44: 946704fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265d48: aa0003f5    	mov	x21, x0
106265d4c: aa1803e0    	mov	x0, x24
106265d50: 94670501    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265d54: 34000077    	cbz	w23, 0x106265d60 <_Flutter_MMFoundation_BindContext+0x2741944>
106265d58: 376ff255    	tbnz	w21, #0xd, 0x106265ba0 <_Flutter_MMFoundation_BindContext+0x2741784>
106265d5c: 14000002    	b	0x106265d64 <_Flutter_MMFoundation_BindContext+0x2741948>
106265d60: 3767f215    	tbnz	w21, #0xc, 0x106265ba0 <_Flutter_MMFoundation_BindContext+0x2741784>
106265d64: 900ce988    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
106265d68: f9406501    	ldr	x1, [x8, #0xc8] ; m_muteNotification
106265d6c: aa1303e0    	mov	x0, x19
106265d70: 946704f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265d74: 3707f160    	tbnz	w0, #0x0, 0x106265ba0 <_Flutter_MMFoundation_BindContext+0x2741784>
106265d78: 34000796    	cbz	w22, 0x106265e68 <_Flutter_MMFoundation_BindContext+0x2741a4c>
106265d7c: 52800040    	mov	w0, #0x2                ; =2
106265d80: 94669d30    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106265d84: 34fff0e0    	cbz	w0, 0x106265ba0 <_Flutter_MMFoundation_BindContext+0x2741784>
106265d88: 94670506    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106265d8c: aa0003f5    	mov	x21, x0
106265d90: d00cf877    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
106265d94: f94546e0    	ldr	x0, [x23, #0xa88]
106265d98: 946704f2    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106265d9c: aa0003f6    	mov	x22, x0
106265da0: f94546f7    	ldr	x23, [x23, #0xa88]
106265da4: d00cf868    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106265da8: f9458900    	ldr	x0, [x8, #0xb10]
106265dac: f00cf4e8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
106265db0: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
106265db4: 52800022    	mov	w2, #0x1                ; =1
106265db8: 946704e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265dbc: aa1d03fd    	mov	x29, x29
106265dc0: 946704e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265dc4: aa0003f8    	mov	x24, x0
106265dc8: b00cf528    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106265dcc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106265dd0: a900fff3    	stp	x19, xzr, [sp, #0x8]
106265dd4: f90003e0    	str	x0, [sp]
106265dd8: 900c2a82    	adrp	x2, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
106265ddc: 9116a042    	add	x2, x2, #0x5a8
106265de0: aa1703e0    	mov	x0, x23
106265de4: 946704d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265de8: aa1d03fd    	mov	x29, x29
106265dec: 946704d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265df0: aa0003f7    	mov	x23, x0
106265df4: b00cf4e8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106265df8: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106265dfc: d00c11a8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265e00: 91352108    	add	x8, x8, #0xd48
106265e04: a90003e8    	stp	x8, x0, [sp]
106265e08: d00c11a2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106265e0c: 9134a042    	add	x2, x2, #0xd28
106265e10: aa1603e0    	mov	x0, x22
106265e14: 946704ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265e18: aa0003f6    	mov	x22, x0
106265e1c: aa1703e0    	mov	x0, x23
106265e20: 946704cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265e24: aa1803e0    	mov	x0, x24
106265e28: 946704cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265e2c: 900a7d81    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106265e30: 9124e421    	add	x1, x1, #0x939
106265e34: b00ab9c2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106265e38: 91112042    	add	x2, x2, #0x448
106265e3c: 900ab9e4    	adrp	x4, 0x11b9a1000 <dyld_stub_binder+0x11b9a1000>
106265e40: 91063c84    	add	x4, x4, #0x18f
106265e44: 52800040    	mov	w0, #0x2                ; =2
106265e48: 5281b2c3    	mov	w3, #0xd96              ; =3478
106265e4c: aa1603e5    	mov	x5, x22
106265e50: 94669cfd    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106265e54: aa1603e0    	mov	x0, x22
106265e58: 946704bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265e5c: aa1503e0    	mov	x0, x21
106265e60: 946704d3    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106265e64: 17ffff4f    	b	0x106265ba0 <_Flutter_MMFoundation_BindContext+0x2741784>
106265e68: f945eb60    	ldr	x0, [x27, #0xbd0]
106265e6c: f944eb81    	ldr	x1, [x28, #0x9d0] ; currentContext
106265e70: 946704b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265e74: aa1d03fd    	mov	x29, x29
106265e78: 946704b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265e7c: aa0003f5    	mov	x21, x0
106265e80: f9473b40    	ldr	x0, [x26, #0xe70]
106265e84: aa1403e1    	mov	x1, x20
106265e88: 946704ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265e8c: aa0003e2    	mov	x2, x0
106265e90: f9464321    	ldr	x1, [x25, #0xc80] ; getService:
106265e94: aa1503e0    	mov	x0, x21
106265e98: 946704a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265e9c: aa1d03fd    	mov	x29, x29
106265ea0: 946704aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106265ea4: aa0003f6    	mov	x22, x0
106265ea8: d00ceb68    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106265eac: f944d101    	ldr	x1, [x8, #0x9a0] ; showLocalNotificationByIlinkWithMsg:repeatVibration:isCallkitAvailable:
106265eb0: aa1303e2    	mov	x2, x19
106265eb4: 52800023    	mov	w3, #0x1                ; =1
106265eb8: 52800004    	mov	w4, #0x0                ; =0
106265ebc: 946704a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106265ec0: aa1603e0    	mov	x0, x22
106265ec4: 946704a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265ec8: aa1503e0    	mov	x0, x21
106265ecc: 946704a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106265ed0: 17ffff34    	b	0x106265ba0 <_Flutter_MMFoundation_BindContext+0x2741784>
