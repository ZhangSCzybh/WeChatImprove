
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10577b4e8: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10577b4ec: a90167fa    	stp	x26, x25, [sp, #0x10]
10577b4f0: a9025ff8    	stp	x24, x23, [sp, #0x20]
10577b4f4: a90357f6    	stp	x22, x21, [sp, #0x30]
10577b4f8: a9044ff4    	stp	x20, x19, [sp, #0x40]
10577b4fc: a9057bfd    	stp	x29, x30, [sp, #0x50]
10577b500: 910143fd    	add	x29, sp, #0x50
10577b504: d108c3ff    	sub	sp, sp, #0x230
10577b508: aa0303f3    	mov	x19, x3
10577b50c: aa0203f4    	mov	x20, x2
10577b510: aa0003f5    	mov	x21, x0
10577b514: 900bf3a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10577b518: f9405908    	ldr	x8, [x8, #0xb0]
10577b51c: f9400108    	ldr	x8, [x8]
10577b520: f81a03a8    	stur	x8, [x29, #-0x60]
10577b524: d00da628    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
10577b528: 52800029    	mov	w9, #0x1                ; =1
10577b52c: 390c6d09    	strb	w9, [x8, #0x31b]
10577b530: aa0203e0    	mov	x0, x2
10577b534: 9492af01    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10577b538: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b53c: f9464900    	ldr	x0, [x8, #0xc90]
10577b540: d00d35e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10577b544: f9473501    	ldr	x1, [x8, #0xe68] ; removePBEventObserverListItem:andValue:
10577b548: aa1303e2    	mov	x2, x19
10577b54c: aa1503e3    	mov	x3, x21
10577b550: 9492aefb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b554: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b558: b98ce908    	ldrsw	x8, [x8, #0xce8]
10577b55c: f8686aa1    	ldr	x1, [x21, x8]
10577b560: 910443e0    	add	x0, sp, #0x110
10577b564: 94924773    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
10577b568: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b56c: b98cfd08    	ldrsw	x8, [x8, #0xcfc]
10577b570: 38286abf    	strb	wzr, [x21, x8]
10577b574: f00d3608    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10577b578: f9478901    	ldr	x1, [x8, #0xf10] ; m_oUserData
10577b57c: aa1403e0    	mov	x0, x20
10577b580: 9492aeef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b584: aa1d03fd    	mov	x29, x29
10577b588: 9492aef0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b58c: aa0003f6    	mov	x22, x0
10577b590: b00d4c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10577b594: f9435113    	ldr	x19, [x8, #0x6a0] ; count
10577b598: aa1303e1    	mov	x1, x19
10577b59c: 9492aee8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b5a0: b40018c0    	cbz	x0, 0x10577b8b8 <_Flutter_MMFoundation_BindContext+0x1c5749c>
10577b5a4: a90257f3    	stp	x19, x21, [sp, #0x20]
10577b5a8: f9001bf4    	str	x20, [sp, #0x30]
10577b5ac: b00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577b5b0: f9420101    	ldr	x1, [x8, #0x400] ; loadMessages
10577b5b4: aa1503e0    	mov	x0, x21
10577b5b8: 9492aee1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b5bc: aa1d03fd    	mov	x29, x29
10577b5c0: 9492aee2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b5c4: aa0003f8    	mov	x24, x0
10577b5c8: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b5cc: f9455500    	ldr	x0, [x8, #0xaa8]
10577b5d0: 900d4c28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10577b5d4: f941a101    	ldr	x1, [x8, #0x340] ; array
10577b5d8: 9492aed9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b5dc: aa1d03fd    	mov	x29, x29
10577b5e0: 9492aeda    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b5e4: f9003fe0    	str	x0, [sp, #0x78]
10577b5e8: 4f00e400    	movi.16b	v0, #0x0
10577b5ec: ad0683e0    	stp	q0, q0, [sp, #0xd0]
10577b5f0: ad0783e0    	stp	q0, q0, [sp, #0xf0]
10577b5f4: aa1603e0    	mov	x0, x22
10577b5f8: 9492aed0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10577b5fc: b00d4c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10577b600: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
10577b604: 910343e2    	add	x2, sp, #0xd0
10577b608: d10383a3    	sub	x3, x29, #0xe0
10577b60c: f90037e1    	str	x1, [sp, #0x68]
10577b610: 52800204    	mov	w4, #0x10               ; =16
10577b614: 9492aeca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b618: f9002fe0    	str	x0, [sp, #0x58]
10577b61c: b4000e60    	cbz	x0, 0x10577b7e8 <_Flutter_MMFoundation_BindContext+0x1c573cc>
10577b620: f94073e8    	ldr	x8, [sp, #0xe0]
10577b624: f9400108    	ldr	x8, [x8]
10577b628: a903dbe8    	stp	x8, x22, [sp, #0x38]
10577b62c: f90047f8    	str	x24, [sp, #0x88]
10577b630: d2800013    	mov	x19, #0x0               ; =0
10577b634: b00d3608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10577b638: f947d109    	ldr	x9, [x8, #0xfa0] ; m_uiMesLocalID
10577b63c: 900d3628    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10577b640: f940d908    	ldr	x8, [x8, #0x1b0] ; m_nsToUsr
10577b644: a904a7e8    	stp	x8, x9, [sp, #0x48]
10577b648: f94073e8    	ldr	x8, [sp, #0xe0]
10577b64c: f9400108    	ldr	x8, [x8]
10577b650: f9401fe9    	ldr	x9, [sp, #0x38]
10577b654: eb09011f    	cmp	x8, x9
10577b658: 54000060    	b.eq	0x10577b664 <_Flutter_MMFoundation_BindContext+0x1c57248>
10577b65c: aa1603e0    	mov	x0, x22
10577b660: 9492aebc    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10577b664: f9406fe8    	ldr	x8, [sp, #0xd8]
10577b668: f90033f3    	str	x19, [sp, #0x60]
10577b66c: f8737913    	ldr	x19, [x8, x19, lsl #3]
10577b670: aa1303e0    	mov	x0, x19
10577b674: f9402be1    	ldr	x1, [sp, #0x50]
10577b678: 9492aeb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b67c: aa0003f7    	mov	x23, x0
10577b680: aa1303e0    	mov	x0, x19
10577b684: f94027e1    	ldr	x1, [sp, #0x48]
10577b688: 9492aead    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b68c: aa1d03fd    	mov	x29, x29
10577b690: 9492aeae    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b694: aa0003f3    	mov	x19, x0
10577b698: 4f00e400    	movi.16b	v0, #0x0
10577b69c: ad0483e0    	stp	q0, q0, [sp, #0x90]
10577b6a0: ad0583e0    	stp	q0, q0, [sp, #0xb0]
10577b6a4: aa1803e0    	mov	x0, x24
10577b6a8: 9492aea4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10577b6ac: 910243e2    	add	x2, sp, #0x90
10577b6b0: 910483e3    	add	x3, sp, #0x120
10577b6b4: f94037e1    	ldr	x1, [sp, #0x68]
10577b6b8: 52800204    	mov	w4, #0x10               ; =16
10577b6bc: 9492aea0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b6c0: b4000720    	cbz	x0, 0x10577b7a4 <_Flutter_MMFoundation_BindContext+0x1c57388>
10577b6c4: aa0003f4    	mov	x20, x0
10577b6c8: f94053e8    	ldr	x8, [sp, #0xa0]
10577b6cc: f940011b    	ldr	x27, [x8]
10577b6d0: d280001c    	mov	x28, #0x0               ; =0
10577b6d4: b00d3608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10577b6d8: f9453515    	ldr	x21, [x8, #0xa68] ; userName
10577b6dc: 900d4c48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10577b6e0: f943c91a    	ldr	x26, [x8, #0x790] ; isEqualToString:
10577b6e4: d00d3648    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10577b6e8: f9456108    	ldr	x8, [x8, #0xac0] ; msgLocalId
10577b6ec: f9003be8    	str	x8, [sp, #0x70]
10577b6f0: f00d35e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10577b6f4: f943c508    	ldr	x8, [x8, #0x788] ; safeAddObject:
10577b6f8: f90043e8    	str	x8, [sp, #0x80]
10577b6fc: f94053e8    	ldr	x8, [sp, #0xa0]
10577b700: f9400108    	ldr	x8, [x8]
10577b704: eb1b011f    	cmp	x8, x27
10577b708: 54000060    	b.eq	0x10577b714 <_Flutter_MMFoundation_BindContext+0x1c572f8>
10577b70c: f94047e0    	ldr	x0, [sp, #0x88]
10577b710: 9492ae90    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
10577b714: f9404fe8    	ldr	x8, [sp, #0x98]
10577b718: f87c7919    	ldr	x25, [x8, x28, lsl #3]
10577b71c: aa1903e0    	mov	x0, x25
10577b720: aa1503e1    	mov	x1, x21
10577b724: 9492ae86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b728: aa1d03fd    	mov	x29, x29
10577b72c: 9492ae87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577b730: aa0003f8    	mov	x24, x0
10577b734: aa1a03e1    	mov	x1, x26
10577b738: aa1303e2    	mov	x2, x19
10577b73c: 9492ae80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b740: aa0003f6    	mov	x22, x0
10577b744: aa1803e0    	mov	x0, x24
10577b748: 9492ae83    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b74c: 34000156    	cbz	w22, 0x10577b774 <_Flutter_MMFoundation_BindContext+0x1c57358>
10577b750: 340000d7    	cbz	w23, 0x10577b768 <_Flutter_MMFoundation_BindContext+0x1c5734c>
10577b754: aa1903e0    	mov	x0, x25
10577b758: f9403be1    	ldr	x1, [sp, #0x70]
10577b75c: 9492ae78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b760: 6b17001f    	cmp	w0, w23
10577b764: 54000081    	b.ne	0x10577b774 <_Flutter_MMFoundation_BindContext+0x1c57358>
10577b768: a94787e0    	ldp	x0, x1, [sp, #0x78]
10577b76c: aa1903e2    	mov	x2, x25
10577b770: 9492ae73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b774: 9100079c    	add	x28, x28, #0x1
10577b778: eb1c029f    	cmp	x20, x28
10577b77c: 54fffc01    	b.ne	0x10577b6fc <_Flutter_MMFoundation_BindContext+0x1c572e0>
10577b780: 910243e2    	add	x2, sp, #0x90
10577b784: 910483e3    	add	x3, sp, #0x120
10577b788: f94047f8    	ldr	x24, [sp, #0x88]
10577b78c: aa1803e0    	mov	x0, x24
10577b790: f94037e1    	ldr	x1, [sp, #0x68]
10577b794: 52800204    	mov	w4, #0x10               ; =16
10577b798: 9492ae69    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b79c: aa0003f4    	mov	x20, x0
10577b7a0: b5fff980    	cbnz	x0, 0x10577b6d0 <_Flutter_MMFoundation_BindContext+0x1c572b4>
10577b7a4: aa1803e0    	mov	x0, x24
10577b7a8: 9492ae6b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b7ac: aa1303e0    	mov	x0, x19
10577b7b0: 9492ae69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b7b4: a945cfe8    	ldp	x8, x19, [sp, #0x58]
10577b7b8: 91000673    	add	x19, x19, #0x1
10577b7bc: eb08027f    	cmp	x19, x8
10577b7c0: f94023f6    	ldr	x22, [sp, #0x40]
10577b7c4: 54fff421    	b.ne	0x10577b648 <_Flutter_MMFoundation_BindContext+0x1c5722c>
10577b7c8: 910343e2    	add	x2, sp, #0xd0
10577b7cc: d10383a3    	sub	x3, x29, #0xe0
10577b7d0: aa1603e0    	mov	x0, x22
10577b7d4: f94037e1    	ldr	x1, [sp, #0x68]
10577b7d8: 52800204    	mov	w4, #0x10               ; =16
10577b7dc: 9492ae58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b7e0: f9002fe0    	str	x0, [sp, #0x58]
10577b7e4: b5fff260    	cbnz	x0, 0x10577b630 <_Flutter_MMFoundation_BindContext+0x1c57214>
10577b7e8: aa1603e0    	mov	x0, x22
10577b7ec: 9492ae5a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b7f0: f9403ff9    	ldr	x25, [sp, #0x78]
10577b7f4: aa1903e0    	mov	x0, x25
10577b7f8: f94013f7    	ldr	x23, [sp, #0x20]
10577b7fc: aa1703e1    	mov	x1, x23
10577b800: 9492ae4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b804: f94017f5    	ldr	x21, [sp, #0x28]
10577b808: b4000160    	cbz	x0, 0x10577b834 <_Flutter_MMFoundation_BindContext+0x1c57418>
10577b80c: f00d4c48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10577b810: f9415101    	ldr	x1, [x8, #0x2a0] ; removeObjectsInArray:
10577b814: aa1803e0    	mov	x0, x24
10577b818: aa1903e2    	mov	x2, x25
10577b81c: 9492ae48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b820: b00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577b824: f9420901    	ldr	x1, [x8, #0x410] ; saveMessages:
10577b828: aa1503e0    	mov	x0, x21
10577b82c: aa1803e2    	mov	x2, x24
10577b830: 9492ae43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b834: 900d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577b838: f9453513    	ldr	x19, [x8, #0xa68]
10577b83c: aa1903e0    	mov	x0, x25
10577b840: aa1703e1    	mov	x1, x23
10577b844: 9492ae3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b848: aa0003f4    	mov	x20, x0
10577b84c: f00d5588    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10577b850: b98cf508    	ldrsw	x8, [x8, #0xcf4]
10577b854: f8686aa0    	ldr	x0, [x21, x8]
10577b858: aa1703e1    	mov	x1, x23
10577b85c: 9492ae38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b860: d00d35e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10577b864: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10577b868: a90083f4    	stp	x20, x0, [sp, #0x8]
10577b86c: b00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577b870: 9136a108    	add	x8, x8, #0xda8
10577b874: f90003e8    	str	x8, [sp]
10577b878: d00ad543    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
10577b87c: 9107f063    	add	x3, x3, #0x1fc
10577b880: d00b0b25    	adrp	x5, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577b884: 910cf0a5    	add	x5, x5, #0x33c
10577b888: d00b0b27    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
10577b88c: 911678e7    	add	x7, x7, #0x59e
10577b890: aa1303e0    	mov	x0, x19
10577b894: 52800042    	mov	w2, #0x2                ; =2
10577b898: 52800004    	mov	w4, #0x0                ; =0
10577b89c: 52802d06    	mov	w6, #0x168              ; =360
10577b8a0: 9492ae27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b8a4: aa1903e0    	mov	x0, x25
10577b8a8: 9492ae2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b8ac: aa1803e0    	mov	x0, x24
10577b8b0: 9492ae29    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b8b4: f9401bf4    	ldr	x20, [sp, #0x30]
10577b8b8: aa1603e0    	mov	x0, x22
10577b8bc: 9492ae26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b8c0: 910443e0    	add	x0, sp, #0x110
10577b8c4: 9492469c    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
10577b8c8: b00d41a8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
10577b8cc: f9421501    	ldr	x1, [x8, #0x428] ; GetCountOfSendMessage
10577b8d0: aa1503e0    	mov	x0, x21
10577b8d4: 9492ae1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b8d8: b40000a0    	cbz	x0, 0x10577b8ec <_Flutter_MMFoundation_BindContext+0x1c574d0>
10577b8dc: f00d4048    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
10577b8e0: f943f501    	ldr	x1, [x8, #0x7e8] ; SendMsg
10577b8e4: aa1503e0    	mov	x0, x21
10577b8e8: 9492ae15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577b8ec: aa1403e0    	mov	x0, x20
10577b8f0: 9492ae19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577b8f4: f85a03a8    	ldur	x8, [x29, #-0x60]
10577b8f8: 900bf3a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10577b8fc: f9405929    	ldr	x9, [x9, #0xb0]
10577b900: f9400129    	ldr	x9, [x9]
10577b904: eb08013f    	cmp	x9, x8
10577b908: 54000121    	b.ne	0x10577b92c <_Flutter_MMFoundation_BindContext+0x1c57510>
10577b90c: 9108c3ff    	add	sp, sp, #0x230
10577b910: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10577b914: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10577b918: a94357f6    	ldp	x22, x21, [sp, #0x30]
10577b91c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10577b920: a94167fa    	ldp	x26, x25, [sp, #0x10]
10577b924: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10577b928: d65f03c0    	ret
10577b92c: 9492ae12    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
