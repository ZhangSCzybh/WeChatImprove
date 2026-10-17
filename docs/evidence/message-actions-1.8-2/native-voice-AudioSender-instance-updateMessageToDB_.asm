
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017a618: d10203ff    	sub	sp, sp, #0x80
10017a61c: a9026ffc    	stp	x28, x27, [sp, #0x20]
10017a620: a90367fa    	stp	x26, x25, [sp, #0x30]
10017a624: a9045ff8    	stp	x24, x23, [sp, #0x40]
10017a628: a90557f6    	stp	x22, x21, [sp, #0x50]
10017a62c: a9064ff4    	stp	x20, x19, [sp, #0x60]
10017a630: a9077bfd    	stp	x29, x30, [sp, #0x70]
10017a634: 9101c3fd    	add	x29, sp, #0x70
10017a638: aa0203f3    	mov	x19, x2
10017a63c: aa0003f4    	mov	x20, x0
10017a640: f0105588    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
10017a644: 52800029    	mov	w9, #0x1                ; =1
10017a648: 391f1509    	strb	w9, [x8, #0x7c5]
10017a64c: aa0203e0    	mov	x0, x2
10017a650: 95eab2ba    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10017a654: b00fffdc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10017a658: f9453798    	ldr	x24, [x28, #0xa68]
10017a65c: d00fe608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10017a660: f947d116    	ldr	x22, [x8, #0xfa0] ; m_uiMesLocalID
10017a664: aa1303e0    	mov	x0, x19
10017a668: aa1603e1    	mov	x1, x22
10017a66c: 95eab2b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a670: aa0003f9    	mov	x25, x0
10017a674: b00fe608    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10017a678: f9450117    	ldr	x23, [x8, #0xa00] ; m_uiStatus
10017a67c: aa1303e0    	mov	x0, x19
10017a680: aa1703e1    	mov	x1, x23
10017a684: 95eab2ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a688: f00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017a68c: f942a915    	ldr	x21, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10017a690: a90083f9    	stp	x25, x0, [sp, #0x8]
10017a694: 900f19a8    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10017a698: 9106a108    	add	x8, x8, #0x1a8
10017a69c: f90003e8    	str	x8, [sp]
10017a6a0: 900d85a3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a6a4: 911fe463    	add	x3, x3, #0x7f9
10017a6a8: 900d85a5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a6ac: 912014a5    	add	x5, x5, #0x805
10017a6b0: 900d85a7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a6b4: 913be0e7    	add	x7, x7, #0xef8
10017a6b8: aa1803e0    	mov	x0, x24
10017a6bc: aa1503e1    	mov	x1, x21
10017a6c0: 52800042    	mov	w2, #0x2                ; =2
10017a6c4: 52800004    	mov	w4, #0x0                ; =0
10017a6c8: 52806d46    	mov	w6, #0x36a              ; =874
10017a6cc: 95eab29c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a6d0: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a6d4: f9459901    	ldr	x1, [x8, #0xb30] ; getChatName:
10017a6d8: aa1403e0    	mov	x0, x20
10017a6dc: aa1303e2    	mov	x2, x19
10017a6e0: 95eab297    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a6e4: aa1d03fd    	mov	x29, x29
10017a6e8: 95eab298    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a6ec: aa0003f4    	mov	x20, x0
10017a6f0: b40009e0    	cbz	x0, 0x10017a82c <__text+0x17282c>
10017a6f4: b00fe628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10017a6f8: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
10017a6fc: aa1303e0    	mov	x0, x19
10017a700: d2800002    	mov	x2, #0x0                ; =0
10017a704: 95eab28e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a708: aa1303e0    	mov	x0, x19
10017a70c: aa1603e1    	mov	x1, x22
10017a710: 95eab28b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a714: 34000b80    	cbz	w0, 0x10017a884 <__text+0x172884>
10017a718: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a71c: f9459d01    	ldr	x1, [x8, #0xb38] ; m_isEnterpriseMsg
10017a720: aa1303e0    	mov	x0, x19
10017a724: 95eab286    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a728: aa0003f9    	mov	x25, x0
10017a72c: b00fffc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10017a730: f945e900    	ldr	x0, [x8, #0xbd0]
10017a734: d00ffc28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10017a738: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10017a73c: 95eab280    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a740: aa1d03fd    	mov	x29, x29
10017a744: 95eab281    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a748: aa0003f8    	mov	x24, x0
10017a74c: b00ffc28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10017a750: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10017a754: 34000c79    	cbz	w25, 0x10017a8e0 <__text+0x1728e0>
10017a758: f00fffc8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10017a75c: f942a100    	ldr	x0, [x8, #0x540]
10017a760: 95eab277    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a764: aa0003e2    	mov	x2, x0
10017a768: f00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017a76c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10017a770: aa1803e0    	mov	x0, x24
10017a774: 95eab272    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a778: aa1d03fd    	mov	x29, x29
10017a77c: 95eab273    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a780: aa0003f9    	mov	x25, x0
10017a784: aa1803e0    	mov	x0, x24
10017a788: 95eab273    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a78c: aa1303e0    	mov	x0, x19
10017a790: aa1603e1    	mov	x1, x22
10017a794: 95eab26a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a798: aa0003f8    	mov	x24, x0
10017a79c: b00fe628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10017a7a0: f940d91a    	ldr	x26, [x8, #0x1b0] ; m_nsToUsr
10017a7a4: aa1303e0    	mov	x0, x19
10017a7a8: aa1a03e1    	mov	x1, x26
10017a7ac: 95eab264    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a7b0: aa1d03fd    	mov	x29, x29
10017a7b4: 95eab265    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a7b8: aa0003fb    	mov	x27, x0
10017a7bc: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a7c0: f945a901    	ldr	x1, [x8, #0xb50] ; GetMsg:LocalID:Brand:
10017a7c4: aa1903e0    	mov	x0, x25
10017a7c8: aa1403e2    	mov	x2, x20
10017a7cc: aa1803e3    	mov	x3, x24
10017a7d0: aa1b03e4    	mov	x4, x27
10017a7d4: 95eab25a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a7d8: aa1d03fd    	mov	x29, x29
10017a7dc: 95eab25b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a7e0: aa0003f8    	mov	x24, x0
10017a7e4: aa1b03e0    	mov	x0, x27
10017a7e8: 95eab25b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a7ec: aa1303e0    	mov	x0, x19
10017a7f0: aa1a03e1    	mov	x1, x26
10017a7f4: 95eab252    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a7f8: aa1d03fd    	mov	x29, x29
10017a7fc: 95eab253    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a800: aa0003fa    	mov	x26, x0
10017a804: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a808: f945ad01    	ldr	x1, [x8, #0xb58] ; UpdateVoiceMessage:MsgWrap:Brand:
10017a80c: aa1903e0    	mov	x0, x25
10017a810: aa1403e2    	mov	x2, x20
10017a814: aa1303e3    	mov	x3, x19
10017a818: aa1a03e4    	mov	x4, x26
10017a81c: 95eab248    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a820: aa1a03e0    	mov	x0, x26
10017a824: 95eab24c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a828: 1400004d    	b	0x10017a95c <__text+0x17295c>
10017a82c: f9453797    	ldr	x23, [x28, #0xa68]
10017a830: aa1303e0    	mov	x0, x19
10017a834: aa1603e1    	mov	x1, x22
10017a838: 95eab241    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a83c: 900f19a8    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10017a840: 91072108    	add	x8, x8, #0x1c8
10017a844: a90003e8    	stp	x8, x0, [sp]
10017a848: 900d85a3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a84c: 911fe463    	add	x3, x3, #0x7f9
10017a850: 900d85a5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a854: 912014a5    	add	x5, x5, #0x805
10017a858: 900d85a7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a85c: 913be0e7    	add	x7, x7, #0xef8
10017a860: aa1703e0    	mov	x0, x23
10017a864: aa1503e1    	mov	x1, x21
10017a868: 52800082    	mov	w2, #0x4                ; =4
10017a86c: 52800004    	mov	w4, #0x0                ; =0
10017a870: 52806da6    	mov	w6, #0x36d              ; =877
10017a874: 95eab232    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a878: 528013c0    	mov	w0, #0x9e               ; =158
10017a87c: 528007e1    	mov	w1, #0x3f               ; =63
10017a880: 14000012    	b	0x10017a8c8 <__text+0x1728c8>
10017a884: f9453780    	ldr	x0, [x28, #0xa68]
10017a888: 900f19a8    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10017a88c: 9107a108    	add	x8, x8, #0x1e8
10017a890: f90003e8    	str	x8, [sp]
10017a894: 900d85a3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a898: 911fe463    	add	x3, x3, #0x7f9
10017a89c: 900d85a5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a8a0: 912014a5    	add	x5, x5, #0x805
10017a8a4: 900d85a7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a8a8: 913be0e7    	add	x7, x7, #0xef8
10017a8ac: aa1503e1    	mov	x1, x21
10017a8b0: 52800082    	mov	w2, #0x4                ; =4
10017a8b4: 52800004    	mov	w4, #0x0                ; =0
10017a8b8: 52806ea6    	mov	w6, #0x375              ; =885
10017a8bc: 95eab220    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a8c0: 528013c0    	mov	w0, #0x9e               ; =158
10017a8c4: 52800801    	mov	w1, #0x40               ; =64
10017a8c8: 52800022    	mov	w2, #0x1                ; =1
10017a8cc: 52800003    	mov	w3, #0x0                ; =0
10017a8d0: 52800004    	mov	w4, #0x0                ; =0
10017a8d4: 9477562a    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10017a8d8: 52800015    	mov	w21, #0x0               ; =0
10017a8dc: 1400004a    	b	0x10017aa04 <__text+0x172a04>
10017a8e0: d00fffc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10017a8e4: f9403100    	ldr	x0, [x8, #0x60]
10017a8e8: 95eab215    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a8ec: aa0003e2    	mov	x2, x0
10017a8f0: f00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017a8f4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10017a8f8: aa1803e0    	mov	x0, x24
10017a8fc: 95eab210    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a900: aa1d03fd    	mov	x29, x29
10017a904: 95eab211    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a908: aa0003f9    	mov	x25, x0
10017a90c: aa1803e0    	mov	x0, x24
10017a910: 95eab211    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a914: aa1303e0    	mov	x0, x19
10017a918: aa1603e1    	mov	x1, x22
10017a91c: 95eab208    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a920: aa0003e3    	mov	x3, x0
10017a924: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a928: f945b101    	ldr	x1, [x8, #0xb60] ; GetMsg:LocalID:
10017a92c: aa1903e0    	mov	x0, x25
10017a930: aa1403e2    	mov	x2, x20
10017a934: 95eab202    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a938: aa1d03fd    	mov	x29, x29
10017a93c: 95eab203    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017a940: aa0003f8    	mov	x24, x0
10017a944: b00fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017a948: f945b501    	ldr	x1, [x8, #0xb68] ; UpdateVoiceMessage:MsgWrap:
10017a94c: aa1903e0    	mov	x0, x25
10017a950: aa1403e2    	mov	x2, x20
10017a954: aa1303e3    	mov	x3, x19
10017a958: 95eab1f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a95c: aa1903e0    	mov	x0, x25
10017a960: 95eab1fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017a964: b40004b8    	cbz	x24, 0x10017a9f8 <__text+0x1729f8>
10017a968: aa1803e0    	mov	x0, x24
10017a96c: aa1703e1    	mov	x1, x23
10017a970: 95eab1f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a974: 7100081f    	cmp	w0, #0x2
10017a978: 540000c0    	b.eq	0x10017a990 <__text+0x172990>
10017a97c: aa1803e0    	mov	x0, x24
10017a980: aa1703e1    	mov	x1, x23
10017a984: 95eab1ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a988: 7100141f    	cmp	w0, #0x5
10017a98c: 54000361    	b.ne	0x10017a9f8 <__text+0x1729f8>
10017a990: f9453799    	ldr	x25, [x28, #0xa68]
10017a994: aa1803e0    	mov	x0, x24
10017a998: aa1603e1    	mov	x1, x22
10017a99c: 95eab1e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a9a0: aa0003f6    	mov	x22, x0
10017a9a4: aa1803e0    	mov	x0, x24
10017a9a8: aa1703e1    	mov	x1, x23
10017a9ac: 95eab1e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a9b0: a90083f6    	stp	x22, x0, [sp, #0x8]
10017a9b4: 900f19a8    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10017a9b8: 91082108    	add	x8, x8, #0x208
10017a9bc: f90003e8    	str	x8, [sp]
10017a9c0: 900d85a3    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a9c4: 911fe463    	add	x3, x3, #0x7f9
10017a9c8: 900d85a5    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a9cc: 912014a5    	add	x5, x5, #0x805
10017a9d0: 900d85a7    	adrp	x7, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017a9d4: 913be0e7    	add	x7, x7, #0xef8
10017a9d8: aa1903e0    	mov	x0, x25
10017a9dc: aa1503e1    	mov	x1, x21
10017a9e0: 52800042    	mov	w2, #0x2                ; =2
10017a9e4: 52800004    	mov	w4, #0x0                ; =0
10017a9e8: 52807166    	mov	w6, #0x38b              ; =907
10017a9ec: 95eab1d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017a9f0: 52800015    	mov	w21, #0x0               ; =0
10017a9f4: 14000002    	b	0x10017a9fc <__text+0x1729fc>
10017a9f8: 52800035    	mov	w21, #0x1               ; =1
10017a9fc: aa1803e0    	mov	x0, x24
10017aa00: 95eab1d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017aa04: aa1403e0    	mov	x0, x20
10017aa08: 95eab1d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017aa0c: aa1303e0    	mov	x0, x19
10017aa10: 95eab1d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017aa14: aa1503e0    	mov	x0, x21
10017aa18: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10017aa1c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10017aa20: a94557f6    	ldp	x22, x21, [sp, #0x50]
10017aa24: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10017aa28: a94367fa    	ldp	x26, x25, [sp, #0x30]
10017aa2c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10017aa30: 910203ff    	add	sp, sp, #0x80
10017aa34: d65f03c0    	ret
