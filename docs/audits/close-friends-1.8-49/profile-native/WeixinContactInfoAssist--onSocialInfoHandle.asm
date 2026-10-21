
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a93e160: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10a93e164: a90157f6    	stp	x22, x21, [sp, #0x10]
10a93e168: a9024ff4    	stp	x20, x19, [sp, #0x20]
10a93e16c: a9037bfd    	stp	x29, x30, [sp, #0x30]
10a93e170: 9100c3fd    	add	x29, sp, #0x30
10a93e174: aa0003f3    	mov	x19, x0
10a93e178: b00b18a8    	adrp	x8, 0x120c53000 <dyld_stub_binder+0x120c53000>
10a93e17c: 52800029    	mov	w9, #0x1                ; =1
10a93e180: 390b1109    	strb	w9, [x8, #0x2c4]
10a93e184: d00aaa48    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
10a93e188: f944b101    	ldr	x1, [x8, #0x960] ; genSocialInfomationViewController
10a93e18c: 953c74ae    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a93e190: aa1d03fd    	mov	x29, x29
10a93e194: 953c74af    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a93e198: aa0003f4    	mov	x20, x0
10a93e19c: b00ac508    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10a93e1a0: 91096108    	add	x8, x8, #0x258
10a93e1a4: b9800108    	ldrsw	x8, [x8]
10a93e1a8: 8b080260    	add	x0, x19, x8
10a93e1ac: 953c74ba    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a93e1b0: aa0003f5    	mov	x21, x0
10a93e1b4: b00aa7e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a93e1b8: f945d501    	ldr	x1, [x8, #0xba8] ; getViewController
10a93e1bc: 953c74a2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a93e1c0: aa1d03fd    	mov	x29, x29
10a93e1c4: 953c74a3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a93e1c8: aa0003f6    	mov	x22, x0
10a93e1cc: d00abe28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a93e1d0: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10a93e1d4: 953c749c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a93e1d8: aa1d03fd    	mov	x29, x29
10a93e1dc: 953c749d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a93e1e0: aa0003f7    	mov	x23, x0
10a93e1e4: b00aa7e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a93e1e8: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
10a93e1ec: aa1403e2    	mov	x2, x20
10a93e1f0: 52800023    	mov	w3, #0x1                ; =1
10a93e1f4: 953c7494    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a93e1f8: aa1703e0    	mov	x0, x23
10a93e1fc: 953c7498    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a93e200: aa1603e0    	mov	x0, x22
10a93e204: 953c7496    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a93e208: aa1503e0    	mov	x0, x21
10a93e20c: 953c7494    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a93e210: b00ac9e8    	adrp	x8, 0x12027b000 <dyld_stub_binder+0x12027b000>
10a93e214: b986f908    	ldrsw	x8, [x8, #0x6f8]
10a93e218: f8686a75    	ldr	x21, [x19, x8]
10a93e21c: f8286a74    	str	x20, [x19, x8]
10a93e220: aa1403e0    	mov	x0, x20
10a93e224: 953c7487    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a93e228: aa1503e0    	mov	x0, x21
10a93e22c: 953c748c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a93e230: d00abb88    	adrp	x8, 0x1200b0000 <dyld_stub_binder+0x1200b0000>
10a93e234: f944a915    	ldr	x21, [x8, #0x950] ; reportContactInfoItemClickWithReportScene:
10a93e238: aa1303e0    	mov	x0, x19
10a93e23c: aa1503e1    	mov	x1, x21
10a93e240: 528000c2    	mov	w2, #0x6                ; =6
10a93e244: 953c7480    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a93e248: aa1303e0    	mov	x0, x19
10a93e24c: aa1503e1    	mov	x1, x21
10a93e250: 52800482    	mov	w2, #0x24               ; =36
10a93e254: 953c747c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a93e258: aa1403e0    	mov	x0, x20
10a93e25c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10a93e260: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10a93e264: a94157f6    	ldp	x22, x21, [sp, #0x10]
10a93e268: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10a93e26c: 153c747c    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
