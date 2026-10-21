
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a94db08: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10a94db0c: a90167fa    	stp	x26, x25, [sp, #0x10]
10a94db10: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a94db14: a90357f6    	stp	x22, x21, [sp, #0x30]
10a94db18: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a94db1c: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a94db20: 910143fd    	add	x29, sp, #0x50
10a94db24: aa0003f4    	mov	x20, x0
10a94db28: d00b1828    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a94db2c: 52800029    	mov	w9, #0x1                ; =1
10a94db30: 390bc509    	strb	w9, [x8, #0x2f1]
10a94db34: d00ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94db38: 91096108    	add	x8, x8, #0x258
10a94db3c: b980011c    	ldrsw	x28, [x8]
10a94db40: 8b1c0000    	add	x0, x0, x28
10a94db44: 953c3654    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a94db48: aa0003f6    	mov	x22, x0
10a94db4c: d00aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94db50: f945d515    	ldr	x21, [x8, #0xba8] ; getViewController
10a94db54: aa1503e1    	mov	x1, x21
10a94db58: 953c363b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94db5c: aa1d03fd    	mov	x29, x29
10a94db60: 953c363c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94db64: aa0003f8    	mov	x24, x0
10a94db68: f00abda8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a94db6c: f945dd17    	ldr	x23, [x8, #0xbb8] ; navigationController
10a94db70: aa1703e1    	mov	x1, x23
10a94db74: 953c3634    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94db78: aa1d03fd    	mov	x29, x29
10a94db7c: 953c3635    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94db80: aa0003f9    	mov	x25, x0
10a94db84: d00abde8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a94db88: f946e501    	ldr	x1, [x8, #0xdc8] ; viewControllers
10a94db8c: 953c362e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94db90: aa1d03fd    	mov	x29, x29
10a94db94: 953c362f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94db98: aa0003f3    	mov	x19, x0
10a94db9c: aa1903e0    	mov	x0, x25
10a94dba0: 953c362f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dba4: aa1803e0    	mov	x0, x24
10a94dba8: 953c362d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dbac: aa1603e0    	mov	x0, x22
10a94dbb0: 953c362b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dbb4: b00abda8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a94dbb8: f945fd01    	ldr	x1, [x8, #0xbf8] ; indexOfObject:
10a94dbbc: aa1303e0    	mov	x0, x19
10a94dbc0: aa1403e2    	mov	x2, x20
10a94dbc4: 953c3620    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dbc8: d1000416    	sub	x22, x0, #0x1
10a94dbcc: d00ac498    	adrp	x24, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94dbd0: 91093318    	add	x24, x24, #0x24c
10a94dbd4: f10006df    	cmp	x22, #0x1
10a94dbd8: 54000b8b    	b.lt	0x10a94dd48 <_Flutter_MMFoundation_BindContext+0x6e2992c>
10a94dbdc: f00abd88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a94dbe0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10a94dbe4: aa1303e0    	mov	x0, x19
10a94dbe8: 953c3617    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dbec: eb0002df    	cmp	x22, x0
10a94dbf0: 54000ac2    	b.hs	0x10a94dd48 <_Flutter_MMFoundation_BindContext+0x6e2992c>
10a94dbf4: b00aa768    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a94dbf8: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
10a94dbfc: aa1303e0    	mov	x0, x19
10a94dc00: aa1603e2    	mov	x2, x22
10a94dc04: 953c3610    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dc08: aa1d03fd    	mov	x29, x29
10a94dc0c: 953c3611    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dc10: aa0003f6    	mov	x22, x0
10a94dc14: d00ac228    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a94dc18: f9439d00    	ldr	x0, [x8, #0x738]
10a94dc1c: d00abd88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a94dc20: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a94dc24: 953c3608    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dc28: aa0003e2    	mov	x2, x0
10a94dc2c: d00abda8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a94dc30: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10a94dc34: aa1603e0    	mov	x0, x22
10a94dc38: 953c3603    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dc3c: 34000820    	cbz	w0, 0x10a94dd40 <_Flutter_MMFoundation_BindContext+0x6e29924>
10a94dc40: d00aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94dc44: f947d901    	ldr	x1, [x8, #0xfb0] ; m_contact
10a94dc48: aa1603e0    	mov	x0, x22
10a94dc4c: 953c35fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dc50: aa1d03fd    	mov	x29, x29
10a94dc54: 953c35ff    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dc58: aa0003f8    	mov	x24, x0
10a94dc5c: d00aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94dc60: f9434d19    	ldr	x25, [x8, #0x698] ; m_nsUsrName
10a94dc64: aa1903e1    	mov	x1, x25
10a94dc68: 953c35f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dc6c: aa1d03fd    	mov	x29, x29
10a94dc70: 953c35f8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dc74: aa0003fa    	mov	x26, x0
10a94dc78: d00ac488    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94dc7c: 91093108    	add	x8, x8, #0x24c
10a94dc80: b9800108    	ldrsw	x8, [x8]
10a94dc84: f8686a80    	ldr	x0, [x20, x8]
10a94dc88: aa1903e1    	mov	x1, x25
10a94dc8c: 953c35ee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dc90: aa1d03fd    	mov	x29, x29
10a94dc94: 953c35ef    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dc98: aa0003f9    	mov	x25, x0
10a94dc9c: d00abda8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a94dca0: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10a94dca4: aa1a03e0    	mov	x0, x26
10a94dca8: aa1903e2    	mov	x2, x25
10a94dcac: 953c35e6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dcb0: aa0003fb    	mov	x27, x0
10a94dcb4: aa1903e0    	mov	x0, x25
10a94dcb8: 953c35e9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dcbc: aa1a03e0    	mov	x0, x26
10a94dcc0: 953c35e7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dcc4: aa1803e0    	mov	x0, x24
10a94dcc8: d00ac498    	adrp	x24, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a94dccc: 91093318    	add	x24, x24, #0x24c
10a94dcd0: 953c35e3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dcd4: 3400037b    	cbz	w27, 0x10a94dd40 <_Flutter_MMFoundation_BindContext+0x6e29924>
10a94dcd8: 8b1c0280    	add	x0, x20, x28
10a94dcdc: 953c35ee    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a94dce0: aa0003f4    	mov	x20, x0
10a94dce4: aa1503e1    	mov	x1, x21
10a94dce8: 953c35d7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dcec: aa1d03fd    	mov	x29, x29
10a94dcf0: 953c35d8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dcf4: aa0003f5    	mov	x21, x0
10a94dcf8: aa1703e1    	mov	x1, x23
10a94dcfc: 953c35d2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dd00: aa1d03fd    	mov	x29, x29
10a94dd04: 953c35d3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dd08: aa0003f7    	mov	x23, x0
10a94dd0c: d00aa768    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a94dd10: f9478101    	ldr	x1, [x8, #0xf00] ; PopViewControllerAnimated:
10a94dd14: 52800022    	mov	w2, #0x1                ; =1
10a94dd18: 953c35cb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dd1c: aa1d03fd    	mov	x29, x29
10a94dd20: 953c35d3    	bl	0x10f85b46c <_UR_96F1_B25D+0x3a640dc>
10a94dd24: aa1703e0    	mov	x0, x23
10a94dd28: 953c35cd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dd2c: aa1503e0    	mov	x0, x21
10a94dd30: 953c35cb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dd34: aa1403e0    	mov	x0, x20
10a94dd38: 953c35c9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dd3c: 14000054    	b	0x10a94de8c <_Flutter_MMFoundation_BindContext+0x6e29a70>
10a94dd40: aa1603e0    	mov	x0, x22
10a94dd44: 953c35c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94dd48: 900ac168    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
10a94dd4c: f945a516    	ldr	x22, [x8, #0xb48]
10a94dd50: 8b1c0280    	add	x0, x20, x28
10a94dd54: 953c35d0    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a94dd58: aa0003f7    	mov	x23, x0
10a94dd5c: aa1503e1    	mov	x1, x21
10a94dd60: 953c35b9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dd64: aa1d03fd    	mov	x29, x29
10a94dd68: 953c35ba    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94dd6c: aa0003f5    	mov	x21, x0
10a94dd70: b9800308    	ldrsw	x8, [x24]
10a94dd74: f8686a98    	ldr	x24, [x20, x8]
10a94dd78: 900aa8e8    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
10a94dd7c: f9405901    	ldr	x1, [x8, #0xb0] ; transferFromSceneToSourceScene
10a94dd80: aa1403e0    	mov	x0, x20
10a94dd84: 953c35b0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dd88: aa0003e4    	mov	x4, x0
10a94dd8c: d00ac968    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a94dd90: b9870d08    	ldrsw	x8, [x8, #0x70c]
10a94dd94: b8686a85    	ldr	w5, [x20, x8]
10a94dd98: f0096be8    	adrp	x8, 0x11d6cc000 <dyld_stub_binder+0x11d6cc000>
10a94dd9c: 9129e108    	add	x8, x8, #0xa78
10a94dda0: f9400106    	ldr	x6, [x8]
10a94dda4: d00ab148    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
10a94dda8: f9417d01    	ldr	x1, [x8, #0x2f8] ; navigateToUserPageViewController:contact:scene:thumbnailCnt:source:
10a94ddac: aa1603e0    	mov	x0, x22
10a94ddb0: aa1503e2    	mov	x2, x21
10a94ddb4: aa1803e3    	mov	x3, x24
10a94ddb8: 953c35a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ddbc: aa1503e0    	mov	x0, x21
10a94ddc0: 953c35a7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94ddc4: aa1703e0    	mov	x0, x23
10a94ddc8: 953c35a5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94ddcc: f00abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a94ddd0: f944a901    	ldr	x1, [x8, #0x950] ; reportContactInfoItemClickWithReportScene:
10a94ddd4: aa1403e0    	mov	x0, x20
10a94ddd8: 52800062    	mov	w2, #0x3                ; =3
10a94dddc: 953c359a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94dde0: b00aa9c8    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
10a94dde4: f9448515    	ldr	x21, [x8, #0x908] ; snsJumpData
10a94dde8: aa1403e0    	mov	x0, x20
10a94ddec: aa1503e1    	mov	x1, x21
10a94ddf0: 953c3595    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94ddf4: aa1d03fd    	mov	x29, x29
10a94ddf8: 953c3596    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94ddfc: aa0003f6    	mov	x22, x0
10a94de00: 953c3597    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94de04: b4000496    	cbz	x22, 0x10a94de94 <_Flutter_MMFoundation_BindContext+0x6e29a78>
10a94de08: b00ac308    	adrp	x8, 0x1201ae000 <dyld_stub_binder+0x1201ae000>
10a94de0c: f9412900    	ldr	x0, [x8, #0x250]
10a94de10: 953c3594    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a94de14: aa0003f6    	mov	x22, x0
10a94de18: aa1403e0    	mov	x0, x20
10a94de1c: aa1503e1    	mov	x1, x21
10a94de20: 953c3589    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94de24: aa1d03fd    	mov	x29, x29
10a94de28: 953c358a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94de2c: aa0003f7    	mov	x23, x0
10a94de30: f00abb08    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a94de34: f9455101    	ldr	x1, [x8, #0xaa0] ; setJumpDst:
10a94de38: 52800042    	mov	w2, #0x2                ; =2
10a94de3c: 953c3582    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94de40: aa1703e0    	mov	x0, x23
10a94de44: 953c3586    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94de48: aa1403e0    	mov	x0, x20
10a94de4c: aa1503e1    	mov	x1, x21
10a94de50: 953c357d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94de54: aa1d03fd    	mov	x29, x29
10a94de58: 953c357e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a94de5c: aa0003f4    	mov	x20, x0
10a94de60: 900aba68    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a94de64: f9458901    	ldr	x1, [x8, #0xb10] ; setJumpData:
10a94de68: aa1603e0    	mov	x0, x22
10a94de6c: aa1403e2    	mov	x2, x20
10a94de70: 953c3575    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94de74: aa1403e0    	mov	x0, x20
10a94de78: 953c3579    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94de7c: d00aa7e8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10a94de80: f9420101    	ldr	x1, [x8, #0x400] ; report
10a94de84: aa1603e0    	mov	x0, x22
10a94de88: 953c356f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a94de8c: aa1603e0    	mov	x0, x22
10a94de90: 953c3573    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a94de94: aa1303e0    	mov	x0, x19
10a94de98: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a94de9c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a94dea0: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a94dea4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a94dea8: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a94deac: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10a94deb0: 153c356b    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
