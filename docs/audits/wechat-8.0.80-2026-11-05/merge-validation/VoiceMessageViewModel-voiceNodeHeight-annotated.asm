
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106589714: d10343ff    	sub	sp, sp, #0xd0
106589718: 6d0433ed    	stp	d13, d12, [sp, #0x40]
10658971c: 6d052beb    	stp	d11, d10, [sp, #0x50]
106589720: 6d0623e9    	stp	d9, d8, [sp, #0x60]
106589724: a9076ffc    	stp	x28, x27, [sp, #0x70]
106589728: a90867fa    	stp	x26, x25, [sp, #0x80]
10658972c: a9095ff8    	stp	x24, x23, [sp, #0x90]
106589730: a90a57f6    	stp	x22, x21, [sp, #0xa0]
106589734: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
106589738: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10658973c: 910303fd    	add	x29, sp, #0xc0
106589740: f9001be0    	str	x0, [sp, #0x30]
106589744: d00c8e68    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106589748: 52800029    	mov	w9, #0x1                ; =1
10658974c: 3908c509    	strb	w9, [x8, #0x231]
106589750: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589754: f9461d13    	ldr	x19, [x8, #0xc38]
106589758: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658975c: f943c100    	ldr	x0, [x8, #0x780]
106589760: 900c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106589764: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
106589768: f9001fe1    	str	x1, [sp, #0x38]
10658976c: 945a793e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589770: aa1d03fd    	mov	x29, x29
106589774: 945a7943    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589778: aa0003fb    	mov	x27, x0
10658977c: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589780: f9462100    	ldr	x0, [x8, #0xc40]
106589784: b00c38e8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106589788: f9428517    	ldr	x23, [x8, #0x508] ; selector: class
10658978c: aa1703e1    	mov	x1, x23
106589790: 945a7935    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589794: aa0003e2    	mov	x2, x0
106589798: 900c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658979c: f945211a    	ldr	x26, [x8, #0xa40] ; selector: getService:
1065897a0: aa1b03e0    	mov	x0, x27
1065897a4: aa1a03e1    	mov	x1, x26
1065897a8: 945a792f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065897ac: aa1d03fd    	mov	x29, x29
1065897b0: 945a7934    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065897b4: aa0003fc    	mov	x28, x0
1065897b8: d00c2208    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1065897bc: f9477516    	ldr	x22, [x8, #0xee8] ; selector: getValueOfProperty:inRuleSet:
1065897c0: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
1065897c4: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
1065897c8: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1065897cc: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
1065897d0: aa1603e1    	mov	x1, x22
1065897d4: 945a7924    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065897d8: aa1d03fd    	mov	x29, x29
1065897dc: 945a7929    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065897e0: aa0003f4    	mov	x20, x0
1065897e4: d00c2208    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1065897e8: f9477919    	ldr	x25, [x8, #0xef0] ; selector: parseFloatFromValues:
1065897ec: aa1303e0    	mov	x0, x19
1065897f0: aa1903e1    	mov	x1, x25
1065897f4: aa1403e2    	mov	x2, x20
1065897f8: 945a791b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065897fc: 4ea01c08    	mov.16b	v8, v0
106589800: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589804: f943f100    	ldr	x0, [x8, #0x7e0]
106589808: 900c2228    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10658980c: f9478918    	ldr	x24, [x8, #0xf10] ; selector: systemFont
106589810: aa1803e1    	mov	x1, x24
106589814: 945a7914    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589818: aa1d03fd    	mov	x29, x29
10658981c: 945a7919    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589820: aa0003f3    	mov	x19, x0
106589824: d00c2208    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
106589828: f947ed15    	ldr	x21, [x8, #0xfd8] ; selector: lineHeight
10658982c: aa1503e1    	mov	x1, x21
106589830: 945a790d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589834: 1e64c000    	frintp	d0, d0
106589838: 1e60100a    	fmov	d10, #2.00000000
10658983c: 1f4a0108    	fmadd	d8, d8, d10, d0
106589840: aa1303e0    	mov	x0, x19
106589844: 945a790b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589848: aa1403e0    	mov	x0, x20
10658984c: f9401bf4    	ldr	x20, [sp, #0x30]
106589850: 945a7908    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589854: aa1c03e0    	mov	x0, x28
106589858: 945a7906    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658985c: aa1b03e0    	mov	x0, x27
106589860: 945a7904    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589864: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589868: f9440101    	ldr	x1, [x8, #0x800] ; selector: canShowTranslateLoadingView
10658986c: aa1403e0    	mov	x0, x20
106589870: 945a78fd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589874: 34000700    	cbz	w0, 0x106589954 <_Flutter_MMFoundation_BindContext+0x2810620>
106589878: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658987c: f9461d13    	ldr	x19, [x8, #0xc38]
106589880: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589884: f943c100    	ldr	x0, [x8, #0x780]
106589888: f9401fe1    	ldr	x1, [sp, #0x38]
10658988c: 945a78f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589890: aa1d03fd    	mov	x29, x29
106589894: 945a78fb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589898: aa0003fb    	mov	x27, x0
10658989c: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065898a0: f9462100    	ldr	x0, [x8, #0xc40]
1065898a4: aa1703e1    	mov	x1, x23
1065898a8: 945a78ef    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065898ac: aa0003e2    	mov	x2, x0
1065898b0: aa1b03e0    	mov	x0, x27
1065898b4: aa1a03e1    	mov	x1, x26
1065898b8: 945a78eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065898bc: aa1d03fd    	mov	x29, x29
1065898c0: 945a78f0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065898c4: aa0003f7    	mov	x23, x0
1065898c8: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
1065898cc: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
1065898d0: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
1065898d4: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
1065898d8: aa1603e1    	mov	x1, x22
1065898dc: 945a78e2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065898e0: aa1d03fd    	mov	x29, x29
1065898e4: 945a78e7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065898e8: aa0003f6    	mov	x22, x0
1065898ec: aa1303e0    	mov	x0, x19
1065898f0: aa1903e1    	mov	x1, x25
1065898f4: aa1603e2    	mov	x2, x22
1065898f8: 945a78db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065898fc: 4ea01c09    	mov.16b	v9, v0
106589900: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589904: f943f100    	ldr	x0, [x8, #0x7e0]
106589908: aa1803e1    	mov	x1, x24
10658990c: 945a78d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589910: aa1d03fd    	mov	x29, x29
106589914: 945a78db    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589918: aa0003f4    	mov	x20, x0
10658991c: aa1503e1    	mov	x1, x21
106589920: 945a78d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589924: 1e64c000    	frintp	d0, d0
106589928: 1f4a0120    	fmadd	d0, d9, d10, d0
10658992c: 1e602908    	fadd	d8, d8, d0
106589930: aa1403e0    	mov	x0, x20
106589934: 945a78cf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589938: aa1603e0    	mov	x0, x22
10658993c: 945a78cd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589940: aa1703e0    	mov	x0, x23
106589944: 945a78cb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589948: aa1b03e0    	mov	x0, x27
10658994c: 945a78c9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589950: 1400018d    	b	0x106589f84 <_Flutter_MMFoundation_BindContext+0x2810c50>
106589954: a9025ff5    	stp	x21, x23, [sp, #0x20]
106589958: f9000ff8    	str	x24, [sp, #0x18]
10658995c: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589960: f9420901    	ldr	x1, [x8, #0x410] ; selector: canShowTranslateText
106589964: aa1403e0    	mov	x0, x20
106589968: 945a78bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658996c: 340030c0    	cbz	w0, 0x106589f84 <_Flutter_MMFoundation_BindContext+0x2810c50>
106589970: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589974: f9421101    	ldr	x1, [x8, #0x420] ; selector: isTranslateEnd
106589978: aa1403e0    	mov	x0, x20
10658997c: 945a78ba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589980: 900c2ea8    	adrp	x8, 0x11eb5d000 <dyld_stub_binder+0x11eb5d000>
106589984: 91178108    	add	x8, x8, #0x5e0
106589988: d00c2f49    	adrp	x9, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
10658998c: 911fe129    	add	x9, x9, #0x7f8
106589990: 7100001f    	cmp	w0, #0x0
106589994: 9a891108    	csel	x8, x8, x9, ne
106589998: f9400101    	ldr	x1, [x8]
10658999c: aa1403e0    	mov	x0, x20
1065899a0: 945a78b1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065899a4: 1e612908    	fadd	d8, d8, d1
1065899a8: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065899ac: f9461d13    	ldr	x19, [x8, #0xc38]
1065899b0: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065899b4: f943c100    	ldr	x0, [x8, #0x780]
1065899b8: f9401fe1    	ldr	x1, [sp, #0x38]
1065899bc: 945a78aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065899c0: aa1d03fd    	mov	x29, x29
1065899c4: 945a78af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065899c8: aa1403f8    	mov	x24, x20
1065899cc: aa0003f4    	mov	x20, x0
1065899d0: b00c3c57    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1065899d4: f94622e0    	ldr	x0, [x23, #0xc40]
1065899d8: f94017e1    	ldr	x1, [sp, #0x28]
1065899dc: 945a78a2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065899e0: aa0003e2    	mov	x2, x0
1065899e4: aa1403e0    	mov	x0, x20
1065899e8: aa1a03e1    	mov	x1, x26
1065899ec: 945a789e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065899f0: aa1d03fd    	mov	x29, x29
1065899f4: 945a78a3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1065899f8: aa0003fb    	mov	x27, x0
1065899fc: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
106589a00: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
106589a04: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589a08: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
106589a0c: f9000bf6    	str	x22, [sp, #0x10]
106589a10: aa1603e1    	mov	x1, x22
106589a14: 945a7894    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589a18: aa1d03fd    	mov	x29, x29
106589a1c: 945a7899    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589a20: aa0003fc    	mov	x28, x0
106589a24: aa1303e0    	mov	x0, x19
106589a28: aa1903f5    	mov	x21, x25
106589a2c: aa1903e1    	mov	x1, x25
106589a30: aa1c03e2    	mov	x2, x28
106589a34: 945a788c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589a38: 1e60100b    	fmov	d11, #2.00000000
106589a3c: 1f4b2008    	fmadd	d8, d0, d11, d8
106589a40: aa1c03e0    	mov	x0, x28
106589a44: 945a788b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589a48: aa1b03e0    	mov	x0, x27
106589a4c: 945a7889    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589a50: aa1403e0    	mov	x0, x20
106589a54: aa1803f3    	mov	x19, x24
106589a58: 945a7886    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589a5c: 1e62100c    	fmov	d12, #4.00000000
106589a60: 1e6c2908    	fadd	d8, d8, d12
106589a64: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589a68: f9423101    	ldr	x1, [x8, #0x460] ; selector: canShowTextTranslateView
106589a6c: aa1803e0    	mov	x0, x24
106589a70: 945a787d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589a74: f90007fa    	str	x26, [sp, #0x8]
106589a78: 340008c0    	cbz	w0, 0x106589b90 <_Flutter_MMFoundation_BindContext+0x281085c>
106589a7c: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589a80: f9423901    	ldr	x1, [x8, #0x470] ; selector: canShowTextTranslateText
106589a84: aa1303e0    	mov	x0, x19
106589a88: 945a7877    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589a8c: 340008e0    	cbz	w0, 0x106589ba8 <_Flutter_MMFoundation_BindContext+0x2810874>
106589a90: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589a94: f941b901    	ldr	x1, [x8, #0x370] ; selector: textTranslateInfo
106589a98: aa1303e0    	mov	x0, x19
106589a9c: 945a7872    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589aa0: aa1d03fd    	mov	x29, x29
106589aa4: 945a7877    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589aa8: aa0003fc    	mov	x28, x0
106589aac: b00c3c57    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589ab0: f943c2e0    	ldr	x0, [x23, #0x780]
106589ab4: f9401fe1    	ldr	x1, [sp, #0x38]
106589ab8: 945a786b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589abc: aa1d03fd    	mov	x29, x29
106589ac0: 945a7870    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589ac4: aa0003f3    	mov	x19, x0
106589ac8: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589acc: f9440100    	ldr	x0, [x8, #0x800]
106589ad0: f94017f9    	ldr	x25, [sp, #0x28]
106589ad4: aa1903e1    	mov	x1, x25
106589ad8: 945a7863    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589adc: aa0003e2    	mov	x2, x0
106589ae0: aa1303e0    	mov	x0, x19
106589ae4: aa1a03e1    	mov	x1, x26
106589ae8: 945a785f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589aec: aa1d03fd    	mov	x29, x29
106589af0: 945a7864    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589af4: aa0003f4    	mov	x20, x0
106589af8: 900c2208    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106589afc: f9452501    	ldr	x1, [x8, #0xa48] ; selector: getStringForCurLanguage:
106589b00: 900b5982    	adrp	x2, 0x11d0b9000 <dyld_stub_binder+0x11d0b9000>
106589b04: 911ee042    	add	x2, x2, #0x7b8 ; CFString: MessageContent_Translate_Success
106589b08: 945a7857    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589b0c: aa1d03fd    	mov	x29, x29
106589b10: 945a785c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589b14: aa0003f7    	mov	x23, x0
106589b18: aa1403e0    	mov	x0, x20
106589b1c: 945a7855    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589b20: aa1303e0    	mov	x0, x19
106589b24: 945a7853    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589b28: 900c2608    	adrp	x8, 0x11ea49000 <dyld_stub_binder+0x11ea49000>
106589b2c: f947f11b    	ldr	x27, [x8, #0xfe0] ; selector: brandWording
106589b30: aa1c03e0    	mov	x0, x28
106589b34: aa1b03e1    	mov	x1, x27
106589b38: 945a784b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589b3c: aa1d03fd    	mov	x29, x29
106589b40: 945a7850    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589b44: aa0003f3    	mov	x19, x0
106589b48: f00c38e8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
106589b4c: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
106589b50: 945a7845    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589b54: aa0003f4    	mov	x20, x0
106589b58: aa1303e0    	mov	x0, x19
106589b5c: 945a7845    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589b60: b00c3c56    	adrp	x22, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589b64: f90003fc    	str	x28, [sp]
106589b68: b4000854    	cbz	x20, 0x106589c70 <_Flutter_MMFoundation_BindContext+0x281093c>
106589b6c: aa1c03e0    	mov	x0, x28
106589b70: aa1b03e1    	mov	x1, x27
106589b74: 945a783c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589b78: aa1d03fd    	mov	x29, x29
106589b7c: 945a7841    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589b80: aa0003fb    	mov	x27, x0
106589b84: aa1703e0    	mov	x0, x23
106589b88: 945a783a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589b8c: 1400003a    	b	0x106589c74 <_Flutter_MMFoundation_BindContext+0x2810940>
106589b90: aa1a03f6    	mov	x22, x26
106589b94: f94017f9    	ldr	x25, [sp, #0x28]
106589b98: f9401ff4    	ldr	x20, [sp, #0x38]
106589b9c: b00c3c57    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589ba0: f9400bf8    	ldr	x24, [sp, #0x10]
106589ba4: 1400008c    	b	0x106589dd4 <_Flutter_MMFoundation_BindContext+0x2810aa0>
106589ba8: b00c3c57    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589bac: f9461ef3    	ldr	x19, [x23, #0xc38]
106589bb0: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589bb4: f943c100    	ldr	x0, [x8, #0x780]
106589bb8: f9401ff4    	ldr	x20, [sp, #0x38]
106589bbc: aa1403e1    	mov	x1, x20
106589bc0: 945a7829    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589bc4: aa1d03fd    	mov	x29, x29
106589bc8: 945a782e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589bcc: aa0003fc    	mov	x28, x0
106589bd0: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589bd4: f9462100    	ldr	x0, [x8, #0xc40]
106589bd8: f94017f9    	ldr	x25, [sp, #0x28]
106589bdc: aa1903e1    	mov	x1, x25
106589be0: 945a7821    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589be4: aa0003e2    	mov	x2, x0
106589be8: aa1c03e0    	mov	x0, x28
106589bec: aa1a03e1    	mov	x1, x26
106589bf0: 945a781d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589bf4: aa1d03fd    	mov	x29, x29
106589bf8: 945a7822    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589bfc: aa0003fa    	mov	x26, x0
106589c00: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
106589c04: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
106589c08: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589c0c: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
106589c10: f9400bf8    	ldr	x24, [sp, #0x10]
106589c14: aa1803e1    	mov	x1, x24
106589c18: 945a7813    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589c1c: aa1d03fd    	mov	x29, x29
106589c20: 945a7818    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589c24: aa0003f6    	mov	x22, x0
106589c28: aa1303e0    	mov	x0, x19
106589c2c: aa1503e1    	mov	x1, x21
106589c30: aa1603e2    	mov	x2, x22
106589c34: 945a780c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589c38: 4ea01c09    	mov.16b	v9, v0
106589c3c: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589c40: f943f100    	ldr	x0, [x8, #0x7e0]
106589c44: f9400fe1    	ldr	x1, [sp, #0x18]
106589c48: 945a7807    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589c4c: aa1d03fd    	mov	x29, x29
106589c50: 945a780c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589c54: aa0003fb    	mov	x27, x0
106589c58: f94013e1    	ldr	x1, [sp, #0x20]
106589c5c: 945a7802    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589c60: 1e64c000    	frintp	d0, d0
106589c64: 1e601001    	fmov	d1, #2.00000000
106589c68: 1f410129    	fmadd	d9, d9, d1, d0
106589c6c: 14000050    	b	0x106589dac <_Flutter_MMFoundation_BindContext+0x2810a78>
106589c70: aa1703fb    	mov	x27, x23
106589c74: d00c2f48    	adrp	x8, 0x11eb73000 <dyld_stub_binder+0x11eb73000>
106589c78: f941c101    	ldr	x1, [x8, #0x380] ; selector: textTranslateTextSize
106589c7c: aa1803e0    	mov	x0, x24
106589c80: 945a77f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589c84: 4ea11c29    	mov.16b	v9, v1
106589c88: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589c8c: f9463913    	ldr	x19, [x8, #0xc70]
106589c90: 900c2248    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
106589c94: f9424901    	ldr	x1, [x8, #0x490] ; selector: chatViewControllerWidth
106589c98: aa1803e0    	mov	x0, x24
106589c9c: 945a77f2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589ca0: 4ea01c0a    	mov.16b	v10, v0
106589ca4: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589ca8: f943f100    	ldr	x0, [x8, #0x7e0]
106589cac: 900c3928    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
106589cb0: f9436901    	ldr	x1, [x8, #0x6d0] ; selector: systemFontOfSize:
106589cb4: 1e64d000    	fmov	d0, #11.00000000
106589cb8: 945a77eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589cbc: aa1d03fd    	mov	x29, x29
106589cc0: 945a77f0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589cc4: aa0003f4    	mov	x20, x0
106589cc8: f00c2208    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
106589ccc: f9403101    	ldr	x1, [x8, #0x60] ; selector: labelHeight:maxWidth:font:
106589cd0: aa1303e0    	mov	x0, x19
106589cd4: aa1b03e2    	mov	x2, x27
106589cd8: 4eaa1d40    	mov.16b	v0, v10
106589cdc: aa1403e3    	mov	x3, x20
106589ce0: 945a77e1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589ce4: 4ea01c0a    	mov.16b	v10, v0
106589ce8: aa1403e0    	mov	x0, x20
106589cec: 945a77e1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589cf0: f9461ed3    	ldr	x19, [x22, #0xc38]
106589cf4: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589cf8: f943c100    	ldr	x0, [x8, #0x780]
106589cfc: f9401ff7    	ldr	x23, [sp, #0x38]
106589d00: aa1703e1    	mov	x1, x23
106589d04: 945a77d8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589d08: aa1d03fd    	mov	x29, x29
106589d0c: 945a77dd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589d10: aa0003f6    	mov	x22, x0
106589d14: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589d18: f9462100    	ldr	x0, [x8, #0xc40]
106589d1c: aa1903e1    	mov	x1, x25
106589d20: 945a77d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589d24: aa0003e2    	mov	x2, x0
106589d28: aa1603e0    	mov	x0, x22
106589d2c: aa1a03e1    	mov	x1, x26
106589d30: 945a77cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589d34: aa1d03fd    	mov	x29, x29
106589d38: 945a77d2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589d3c: aa1b03fa    	mov	x26, x27
106589d40: aa0003fb    	mov	x27, x0
106589d44: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
106589d48: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
106589d4c: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589d50: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
106589d54: f9400bf8    	ldr	x24, [sp, #0x10]
106589d58: aa1803e1    	mov	x1, x24
106589d5c: 945a77c2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589d60: aa1d03fd    	mov	x29, x29
106589d64: 945a77c7    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589d68: aa0003f4    	mov	x20, x0
106589d6c: aa1303e0    	mov	x0, x19
106589d70: aa1503e1    	mov	x1, x21
106589d74: aa1403e2    	mov	x2, x20
106589d78: 945a77bb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589d7c: 1e601001    	fmov	d1, #2.00000000
106589d80: 1f412400    	fmadd	d0, d0, d1, d9
106589d84: 1e631001    	fmov	d1, #6.00000000
106589d88: 1e612800    	fadd	d0, d0, d1
106589d8c: 1e602940    	fadd	d0, d10, d0
106589d90: 1e621001    	fmov	d1, #4.00000000
106589d94: 1e612809    	fadd	d9, d0, d1
106589d98: aa1403e0    	mov	x0, x20
106589d9c: aa1703f4    	mov	x20, x23
106589da0: b00c3c57    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589da4: 945a77b3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589da8: f94003fc    	ldr	x28, [sp]
106589dac: 1e692908    	fadd	d8, d8, d9
106589db0: aa1b03e0    	mov	x0, x27
106589db4: 945a77af    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589db8: aa1603e0    	mov	x0, x22
106589dbc: 945a77ad    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589dc0: aa1a03e0    	mov	x0, x26
106589dc4: 945a77ab    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589dc8: aa1c03e0    	mov	x0, x28
106589dcc: 945a77a9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589dd0: f94007f6    	ldr	x22, [sp, #0x8]
106589dd4: f9461ef3    	ldr	x19, [x23, #0xc38]
106589dd8: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589ddc: f943c100    	ldr	x0, [x8, #0x780]
106589de0: aa1403e1    	mov	x1, x20
106589de4: 945a77a0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589de8: aa1d03fd    	mov	x29, x29
106589dec: 945a77a5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589df0: aa0003fa    	mov	x26, x0
106589df4: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589df8: f9462100    	ldr	x0, [x8, #0xc40]
106589dfc: aa1903e1    	mov	x1, x25
106589e00: 945a7799    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589e04: aa0003e2    	mov	x2, x0
106589e08: aa1a03e0    	mov	x0, x26
106589e0c: aa1603e1    	mov	x1, x22
106589e10: 945a7795    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589e14: aa1d03fd    	mov	x29, x29
106589e18: 945a779a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589e1c: aa1403f6    	mov	x22, x20
106589e20: aa0003f4    	mov	x20, x0
106589e24: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
106589e28: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
106589e2c: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589e30: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
106589e34: aa1803e1    	mov	x1, x24
106589e38: 945a778b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589e3c: aa1d03fd    	mov	x29, x29
106589e40: 945a7790    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589e44: aa0003fb    	mov	x27, x0
106589e48: aa1303e0    	mov	x0, x19
106589e4c: aa1503e1    	mov	x1, x21
106589e50: aa1b03e2    	mov	x2, x27
106589e54: 945a7784    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589e58: 4ea01c09    	mov.16b	v9, v0
106589e5c: b00c3c5c    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589e60: f943f380    	ldr	x0, [x28, #0x7e0]
106589e64: aa1803fc    	mov	x28, x24
106589e68: f9400ff8    	ldr	x24, [sp, #0x18]
106589e6c: aa1803e1    	mov	x1, x24
106589e70: 945a777d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589e74: aa1d03fd    	mov	x29, x29
106589e78: 945a7782    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589e7c: aa0003f3    	mov	x19, x0
106589e80: f9001ff5    	str	x21, [sp, #0x38]
106589e84: f94013f5    	ldr	x21, [sp, #0x20]
106589e88: aa1503e1    	mov	x1, x21
106589e8c: 945a7776    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589e90: 1e64c000    	frintp	d0, d0
106589e94: 1f4b0120    	fmadd	d0, d9, d11, d0
106589e98: 1f4b3009    	fmadd	d9, d0, d11, d12
106589e9c: aa1303e0    	mov	x0, x19
106589ea0: 945a7774    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589ea4: aa1b03e0    	mov	x0, x27
106589ea8: 945a7772    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589eac: aa1403e0    	mov	x0, x20
106589eb0: 945a7770    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589eb4: aa1a03e0    	mov	x0, x26
106589eb8: 945a776e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106589ebc: 1e692100    	fcmp	d8, d9
106589ec0: 54000625    	b.pl	0x106589f84 <_Flutter_MMFoundation_BindContext+0x2810c50>
106589ec4: f9461ef3    	ldr	x19, [x23, #0xc38]
106589ec8: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589ecc: f943c100    	ldr	x0, [x8, #0x780]
106589ed0: aa1603e1    	mov	x1, x22
106589ed4: 945a7764    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589ed8: aa1d03fd    	mov	x29, x29
106589edc: 945a7769    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589ee0: aa0003fb    	mov	x27, x0
106589ee4: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589ee8: f9462100    	ldr	x0, [x8, #0xc40]
106589eec: aa1903e1    	mov	x1, x25
106589ef0: 945a775d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589ef4: aa0003e2    	mov	x2, x0
106589ef8: aa1b03e0    	mov	x0, x27
106589efc: f94007e1    	ldr	x1, [sp, #0x8]
106589f00: 945a7759    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589f04: aa1d03fd    	mov	x29, x29
106589f08: 945a775e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589f0c: aa0003f7    	mov	x23, x0
106589f10: d00b5102    	adrp	x2, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
106589f14: 9107e042    	add	x2, x2, #0x1f8 ; CFString: text_message_margin_top
106589f18: d00b50e3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
106589f1c: 9130e063    	add	x3, x3, #0xc38 ; CFString: #message_node_view
106589f20: aa1c03e1    	mov	x1, x28
106589f24: 945a7750    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589f28: aa1d03fd    	mov	x29, x29
106589f2c: 945a7755    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589f30: aa0003f6    	mov	x22, x0
106589f34: aa1303e0    	mov	x0, x19
106589f38: f9401fe1    	ldr	x1, [sp, #0x38]
106589f3c: aa1603e2    	mov	x2, x22
106589f40: 945a7749    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589f44: 4ea01c08    	mov.16b	v8, v0
106589f48: b00c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106589f4c: f943f100    	ldr	x0, [x8, #0x7e0]
106589f50: aa1803e1    	mov	x1, x24
106589f54: 945a7744    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589f58: aa1d03fd    	mov	x29, x29
106589f5c: 945a7749    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106589f60: aa0003f4    	mov	x20, x0
106589f64: aa1503e1    	mov	x1, x21
106589f68: 945a773f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106589f6c: 1e64c000    	frintp	d0, d0
106589f70: 1e601001    	fmov	d1, #2.00000000
106589f74: 1f410100    	fmadd	d0, d8, d1, d0
106589f78: 1e621002    	fmov	d2, #4.00000000
106589f7c: 1f410808    	fmadd	d8, d0, d1, d2
106589f80: 17fffe6c    	b	0x106589930 <_Flutter_MMFoundation_BindContext+0x28105fc>
106589f84: 4ea81d00    	mov.16b	v0, v8
106589f88: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
106589f8c: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
106589f90: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
106589f94: a9495ff8    	ldp	x24, x23, [sp, #0x90]
106589f98: a94867fa    	ldp	x26, x25, [sp, #0x80]
106589f9c: a9476ffc    	ldp	x28, x27, [sp, #0x70]
106589fa0: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
106589fa4: 6d452beb    	ldp	d11, d10, [sp, #0x50]
106589fa8: 6d4433ed    	ldp	d13, d12, [sp, #0x40]
106589fac: 910343ff    	add	sp, sp, #0xd0
106589fb0: d65f03c0    	ret
