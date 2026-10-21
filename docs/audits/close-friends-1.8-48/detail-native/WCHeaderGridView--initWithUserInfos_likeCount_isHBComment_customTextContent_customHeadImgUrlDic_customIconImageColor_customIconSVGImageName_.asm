
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108f47608: d10383ff    	sub	sp, sp, #0xe0
108f4760c: a9086ffc    	stp	x28, x27, [sp, #0x80]
108f47610: a90967fa    	stp	x26, x25, [sp, #0x90]
108f47614: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
108f47618: a90b57f6    	stp	x22, x21, [sp, #0xb0]
108f4761c: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
108f47620: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
108f47624: 910343fd    	add	x29, sp, #0xd0
108f47628: aa0703f9    	mov	x25, x7
108f4762c: aa0603f8    	mov	x24, x6
108f47630: aa0503f7    	mov	x23, x5
108f47634: aa0403f4    	mov	x20, x4
108f47638: aa0303f5    	mov	x21, x3
108f4763c: aa0203fb    	mov	x27, x2
108f47640: aa0003f6    	mov	x22, x0
108f47644: f9400bba    	ldr	x26, [x29, #0x10]
108f47648: d00be828    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108f4764c: 52800029    	mov	w9, #0x1                ; =1
108f47650: 392e6909    	strb	w9, [x8, #0xb9a]
108f47654: aa0203e0    	mov	x0, x2
108f47658: 95a44f7a    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108f4765c: aa1703e0    	mov	x0, x23
108f47660: 95a44f78    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108f47664: aa1803e0    	mov	x0, x24
108f47668: 95a44f76    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108f4766c: aa1903e0    	mov	x0, x25
108f47670: 95a44f74    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108f47674: aa1a03e0    	mov	x0, x26
108f47678: 95a44f72    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108f4767c: d00b9448    	adrp	x8, 0x1201d1000 <dyld_stub_binder+0x1201d1000>
108f47680: f9404508    	ldr	x8, [x8, #0x88] ; p6C
108f47684: a93a23b6    	stp	x22, x8, [x29, #-0x60]
108f47688: f00b8dc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
108f4768c: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
108f47690: d10183a0    	sub	x0, x29, #0x60
108f47694: 9e6703e0    	fmov	d0, xzr
108f47698: 9e6703e1    	fmov	d1, xzr
108f4769c: 1e649002    	fmov	d2, #10.00000000
108f476a0: 1e649003    	fmov	d3, #10.00000000
108f476a4: 95a44f6a    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
108f476a8: aa0003f6    	mov	x22, x0
108f476ac: b4001ea0    	cbz	x0, 0x108f47a80 <_Flutter_MMFoundation_BindContext+0x5423664>
108f476b0: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f476b4: b989bd08    	ldrsw	x8, [x8, #0x9bc]
108f476b8: d2e80729    	mov	x9, #0x4039000000000000 ; =4627730092099895296
108f476bc: f8286ac9    	str	x9, [x22, x8]
108f476c0: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f476c4: b989c108    	ldrsw	x8, [x8, #0x9c0]
108f476c8: d2e80289    	mov	x9, #0x4014000000000000 ; =4617315517961601024
108f476cc: f8286ac9    	str	x9, [x22, x8]
108f476d0: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f476d4: b989c508    	ldrsw	x8, [x8, #0x9c4]
108f476d8: d2e80309    	mov	x9, #0x4018000000000000 ; =4618441417868443648
108f476dc: f8286ac9    	str	x9, [x22, x8]
108f476e0: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f476e4: b989c908    	ldrsw	x8, [x8, #0x9c8]
108f476e8: 52800109    	mov	w9, #0x8                ; =8
108f476ec: b8286ac9    	str	w9, [x22, x8]
108f476f0: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f476f4: b989cd08    	ldrsw	x8, [x8, #0x9cc]
108f476f8: b8286ad5    	str	w21, [x22, x8]
108f476fc: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f47700: b989d108    	ldrsw	x8, [x8, #0x9d0]
108f47704: 38286ad4    	strb	w20, [x22, x8]
108f47708: b00b88e8    	adrp	x8, 0x120064000 <dyld_stub_binder+0x120064000>
108f4770c: f946e901    	ldr	x1, [x8, #0xdd0] ; setCustomTextContent:
108f47710: aa1603e0    	mov	x0, x22
108f47714: f90017f7    	str	x23, [sp, #0x28]
108f47718: aa1703e2    	mov	x2, x23
108f4771c: 95a44f4a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47720: b00b88e8    	adrp	x8, 0x120064000 <dyld_stub_binder+0x120064000>
108f47724: f946ed01    	ldr	x1, [x8, #0xdd8] ; setCustomHeadImgUrlDic:
108f47728: aa1603e0    	mov	x0, x22
108f4772c: f90013f8    	str	x24, [sp, #0x20]
108f47730: aa1803e2    	mov	x2, x24
108f47734: 95a44f44    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47738: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f4773c: b989d508    	ldrsw	x8, [x8, #0x9d4]
108f47740: 8b0802c0    	add	x0, x22, x8
108f47744: f9000ff9    	str	x25, [sp, #0x18]
108f47748: aa1903e1    	mov	x1, x25
108f4774c: 95a44f3f    	bl	0x10f85b448 <_UR_96F1_B25D+0x3a640b8>
108f47750: b00b88e8    	adrp	x8, 0x120064000 <dyld_stub_binder+0x120064000>
108f47754: f946f101    	ldr	x1, [x8, #0xde0] ; setCustomIconSVGImageName:
108f47758: aa1603e0    	mov	x0, x22
108f4775c: f9000bfa    	str	x26, [sp, #0x10]
108f47760: aa1a03e2    	mov	x2, x26
108f47764: 95a44f38    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47768: 900b9168    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108f4776c: f9455514    	ldr	x20, [x8, #0xaa8]
108f47770: b00b8dc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108f47774: f9435115    	ldr	x21, [x8, #0x6a0] ; count
108f47778: aa1b03e0    	mov	x0, x27
108f4777c: aa1503e1    	mov	x1, x21
108f47780: 95a44f31    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47784: aa0003e2    	mov	x2, x0
108f47788: 900b8dc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108f4778c: f941b501    	ldr	x1, [x8, #0x368] ; arrayWithCapacity:
108f47790: aa1403e0    	mov	x0, x20
108f47794: f90007e1    	str	x1, [sp, #0x8]
108f47798: 95a44f2b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f4779c: aa1d03fd    	mov	x29, x29
108f477a0: 95a44f2c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f477a4: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f477a8: b989d909    	ldrsw	x9, [x8, #0x9d8]
108f477ac: f8696ac8    	ldr	x8, [x22, x9]
108f477b0: f90037f6    	str	x22, [sp, #0x68]
108f477b4: f9002be9    	str	x9, [sp, #0x50]
108f477b8: f8296ac0    	str	x0, [x22, x9]
108f477bc: aa0803e0    	mov	x0, x8
108f477c0: 95a44f27    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f477c4: 900b9168    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108f477c8: f945e900    	ldr	x0, [x8, #0xbd0]
108f477cc: b00b8dc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108f477d0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
108f477d4: 95a44f1c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f477d8: aa1d03fd    	mov	x29, x29
108f477dc: 95a44f1d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f477e0: aa0003f4    	mov	x20, x0
108f477e4: b00b9168    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
108f477e8: f9401500    	ldr	x0, [x8, #0x28] ; P;,
108f477ec: 900b8dc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108f477f0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
108f477f4: 95a44f14    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f477f8: aa0003e2    	mov	x2, x0
108f477fc: d00b7788    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108f47800: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108f47804: aa1403e0    	mov	x0, x20
108f47808: 95a44f0f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f4780c: aa1d03fd    	mov	x29, x29
108f47810: 95a44f10    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f47814: f9002fe0    	str	x0, [sp, #0x58]
108f47818: aa1403e0    	mov	x0, x20
108f4781c: 95a44f10    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47820: aa1b03e0    	mov	x0, x27
108f47824: f90033f5    	str	x21, [sp, #0x60]
108f47828: aa1503e1    	mov	x1, x21
108f4782c: 95a44f06    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47830: b4000c80    	cbz	x0, 0x108f479c0 <_Flutter_MMFoundation_BindContext+0x54235a4>
108f47834: d280001c    	mov	x28, #0x0               ; =0
108f47838: f00b7788    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108f4783c: f942c114    	ldr	x20, [x8, #0x580] ; safeObjectAtIndex:
108f47840: b00b77a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108f47844: f9471115    	ldr	x21, [x8, #0xe20] ; username
108f47848: b00b77a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108f4784c: f940c916    	ldr	x22, [x8, #0x190] ; getContactByName:
108f47850: 900b8de8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108f47854: f9454117    	ldr	x23, [x8, #0xa80] ; isValid
108f47858: b00b77a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108f4785c: f945fd09    	ldr	x9, [x8, #0xbf8] ; setM_nsUsrName:
108f47860: b00b77a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108f47864: f9471508    	ldr	x8, [x8, #0xe28] ; nickname
108f47868: a90427e8    	stp	x8, x9, [sp, #0x40]
108f4786c: d00b77a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
108f47870: f9400109    	ldr	x9, [x8]
108f47874: d00b77a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
108f47878: f9400508    	ldr	x8, [x8, #0x8] ; setM_isExtInfoValid:
108f4787c: a90327e8    	stp	x8, x9, [sp, #0x30]
108f47880: f00b7788    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108f47884: f943c51a    	ldr	x26, [x8, #0x788] ; safeAddObject:
108f47888: aa1b03f3    	mov	x19, x27
108f4788c: aa1b03e0    	mov	x0, x27
108f47890: aa1403e1    	mov	x1, x20
108f47894: aa1c03e2    	mov	x2, x28
108f47898: 95a44eeb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f4789c: aa1d03fd    	mov	x29, x29
108f478a0: 95a44eec    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f478a4: aa0003fb    	mov	x27, x0
108f478a8: aa1503e1    	mov	x1, x21
108f478ac: 95a44ee6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f478b0: aa1d03fd    	mov	x29, x29
108f478b4: 95a44ee7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f478b8: aa0003f8    	mov	x24, x0
108f478bc: f9402fe0    	ldr	x0, [sp, #0x58]
108f478c0: aa1603e1    	mov	x1, x22
108f478c4: aa1803e2    	mov	x2, x24
108f478c8: 95a44edf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f478cc: aa1d03fd    	mov	x29, x29
108f478d0: 95a44ee0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f478d4: aa0003f9    	mov	x25, x0
108f478d8: aa1803e0    	mov	x0, x24
108f478dc: 95a44ee0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f478e0: aa1903e0    	mov	x0, x25
108f478e4: aa1703e1    	mov	x1, x23
108f478e8: 95a44ed7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f478ec: 37000480    	tbnz	w0, #0x0, 0x108f4797c <_Flutter_MMFoundation_BindContext+0x5423560>
108f478f0: 900b9168    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108f478f4: f9478100    	ldr	x0, [x8, #0xf00] ;  /,
108f478f8: 95a44eda    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
108f478fc: aa0003f8    	mov	x24, x0
108f47900: aa1903e0    	mov	x0, x25
108f47904: 95a44ed6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47908: aa1b03e0    	mov	x0, x27
108f4790c: aa1503e1    	mov	x1, x21
108f47910: 95a44ecd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47914: aa1d03fd    	mov	x29, x29
108f47918: 95a44ece    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f4791c: aa0003f9    	mov	x25, x0
108f47920: aa1803e0    	mov	x0, x24
108f47924: f94027e1    	ldr	x1, [sp, #0x48]
108f47928: aa1903e2    	mov	x2, x25
108f4792c: 95a44ec6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47930: aa1903e0    	mov	x0, x25
108f47934: 95a44eca    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47938: aa1b03e0    	mov	x0, x27
108f4793c: f94023e1    	ldr	x1, [sp, #0x40]
108f47940: 95a44ec1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47944: aa1d03fd    	mov	x29, x29
108f47948: 95a44ec2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f4794c: aa0003f9    	mov	x25, x0
108f47950: aa1803e0    	mov	x0, x24
108f47954: f9401fe1    	ldr	x1, [sp, #0x38]
108f47958: aa1903e2    	mov	x2, x25
108f4795c: 95a44eba    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47960: aa1903e0    	mov	x0, x25
108f47964: 95a44ebe    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47968: aa1803e0    	mov	x0, x24
108f4796c: f9401be1    	ldr	x1, [sp, #0x30]
108f47970: 52800022    	mov	w2, #0x1                ; =1
108f47974: 95a44eb4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47978: aa1803f9    	mov	x25, x24
108f4797c: f94037e8    	ldr	x8, [sp, #0x68]
108f47980: f9402be9    	ldr	x9, [sp, #0x50]
108f47984: f8696900    	ldr	x0, [x8, x9]
108f47988: aa1a03e1    	mov	x1, x26
108f4798c: aa1903e2    	mov	x2, x25
108f47990: 95a44ead    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47994: aa1903e0    	mov	x0, x25
108f47998: 95a44eb1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f4799c: aa1b03e0    	mov	x0, x27
108f479a0: 95a44eaf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f479a4: 9100079c    	add	x28, x28, #0x1
108f479a8: aa1303fb    	mov	x27, x19
108f479ac: aa1303e0    	mov	x0, x19
108f479b0: f94033e1    	ldr	x1, [sp, #0x60]
108f479b4: 95a44ea4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f479b8: eb1c001f    	cmp	x0, x28
108f479bc: 54fff668    	b.hi	0x108f47888 <_Flutter_MMFoundation_BindContext+0x542346c>
108f479c0: 900b9175    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
108f479c4: f94556b4    	ldr	x20, [x21, #0xaa8]
108f479c8: aa1b03e0    	mov	x0, x27
108f479cc: f94033f3    	ldr	x19, [sp, #0x60]
108f479d0: aa1303e1    	mov	x1, x19
108f479d4: 95a44e9c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f479d8: aa0003e2    	mov	x2, x0
108f479dc: aa1403e0    	mov	x0, x20
108f479e0: f94007f7    	ldr	x23, [sp, #0x8]
108f479e4: aa1703e1    	mov	x1, x23
108f479e8: 95a44e97    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f479ec: aa1d03fd    	mov	x29, x29
108f479f0: 95a44e98    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f479f4: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f479f8: b989dd09    	ldrsw	x9, [x8, #0x9dc]
108f479fc: f94037f6    	ldr	x22, [sp, #0x68]
108f47a00: f8696ac8    	ldr	x8, [x22, x9]
108f47a04: f8296ac0    	str	x0, [x22, x9]
108f47a08: aa0803e0    	mov	x0, x8
108f47a0c: 95a44e94    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47a10: f94556b4    	ldr	x20, [x21, #0xaa8]
108f47a14: aa1b03e0    	mov	x0, x27
108f47a18: aa1303e1    	mov	x1, x19
108f47a1c: 95a44e8a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47a20: aa0003e2    	mov	x2, x0
108f47a24: aa1403e0    	mov	x0, x20
108f47a28: aa1703e1    	mov	x1, x23
108f47a2c: 95a44e86    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47a30: aa1d03fd    	mov	x29, x29
108f47a34: 95a44e87    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f47a38: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f47a3c: b989e109    	ldrsw	x9, [x8, #0x9e0]
108f47a40: f8696ac8    	ldr	x8, [x22, x9]
108f47a44: f8296ac0    	str	x0, [x22, x9]
108f47a48: aa0803e0    	mov	x0, x8
108f47a4c: 95a44e84    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47a50: b00b77a8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108f47a54: f941b101    	ldr	x1, [x8, #0x360] ; initView
108f47a58: aa1603e0    	mov	x0, x22
108f47a5c: 95a44e7a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47a60: b00b7848    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
108f47a64: f944e501    	ldr	x1, [x8, #0x9c8] ; updateView
108f47a68: aa1603e0    	mov	x0, x22
108f47a6c: 95a44e76    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47a70: f9402fe0    	ldr	x0, [sp, #0x58]
108f47a74: 95a44e7a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47a78: a9425ff8    	ldp	x24, x23, [sp, #0x20]
108f47a7c: a94167fa    	ldp	x26, x25, [sp, #0x10]
108f47a80: aa1a03e0    	mov	x0, x26
108f47a84: 95a44e76    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47a88: aa1903e0    	mov	x0, x25
108f47a8c: 95a44e74    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47a90: aa1803e0    	mov	x0, x24
108f47a94: 95a44e72    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47a98: aa1703e0    	mov	x0, x23
108f47a9c: 95a44e70    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47aa0: aa1b03e0    	mov	x0, x27
108f47aa4: 95a44e6e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f47aa8: aa1603e0    	mov	x0, x22
108f47aac: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
108f47ab0: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
108f47ab4: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
108f47ab8: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
108f47abc: a94967fa    	ldp	x26, x25, [sp, #0x90]
108f47ac0: a9486ffc    	ldp	x28, x27, [sp, #0x80]
108f47ac4: 910383ff    	add	sp, sp, #0xe0
108f47ac8: d65f03c0    	ret
