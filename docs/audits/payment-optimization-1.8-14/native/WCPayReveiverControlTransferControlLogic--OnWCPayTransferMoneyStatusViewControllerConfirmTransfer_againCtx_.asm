
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1099947b0: d10443ff    	sub	sp, sp, #0x110
1099947b4: 6d0a23e9    	stp	d9, d8, [sp, #0xa0]
1099947b8: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
1099947bc: a90c67fa    	stp	x26, x25, [sp, #0xc0]
1099947c0: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
1099947c4: a90e57f6    	stp	x22, x21, [sp, #0xe0]
1099947c8: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
1099947cc: a9107bfd    	stp	x29, x30, [sp, #0x100]
1099947d0: 910403fd    	add	x29, sp, #0x100
1099947d4: aa0303f4    	mov	x20, x3
1099947d8: aa0203f3    	mov	x19, x2
1099947dc: aa0003f5    	mov	x21, x0
1099947e0: f00b95c8    	adrp	x8, 0x120c4f000 <dyld_stub_binder+0x120c4f000>
1099947e4: 52800029    	mov	w9, #0x1                ; =1
1099947e8: 39356909    	strb	w9, [x8, #0xd5a]
1099947ec: aa0203e0    	mov	x0, x2
1099947f0: 957b1b14    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1099947f4: aa1403e0    	mov	x0, x20
1099947f8: 957b1b12    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1099947fc: d00b4568    	adrp	x8, 0x120242000 <dyld_stub_binder+0x120242000>
109994800: 910e1108    	add	x8, x8, #0x384
109994804: b9800108    	ldrsw	x8, [x8]
109994808: 52800089    	mov	w9, #0x4                ; =4
10999480c: b8286aa9    	str	w9, [x21, x8]
109994810: f00b3efb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
109994814: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
109994818: 900b3b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10999481c: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
109994820: aa1603e1    	mov	x1, x22
109994824: 957b1b08    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994828: aa1d03fd    	mov	x29, x29
10999482c: 957b1b09    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994830: aa0003f7    	mov	x23, x0
109994834: d00b3f1c    	adrp	x28, 0x120176000 <dyld_stub_binder+0x120176000>
109994838: f943bf80    	ldr	x0, [x28, #0x778] ; ��D 
10999483c: f00b3b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109994840: f947ad18    	ldr	x24, [x8, #0xf58] ; class
109994844: aa1803e1    	mov	x1, x24
109994848: 957b1aff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10999484c: aa0003e2    	mov	x2, x0
109994850: b00b2528    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109994854: f9464119    	ldr	x25, [x8, #0xc80] ; getService:
109994858: aa1703e0    	mov	x0, x23
10999485c: aa1903e1    	mov	x1, x25
109994860: 957b1af9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994864: aa1d03fd    	mov	x29, x29
109994868: 957b1afa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10999486c: aa0003fa    	mov	x26, x0
109994870: d00b2dc8    	adrp	x8, 0x11ff4e000 <dyld_stub_binder+0x11ff4e000>
109994874: f943bd01    	ldr	x1, [x8, #0x778] ; setRealnameReportScene:
109994878: 52807e02    	mov	w2, #0x3f0              ; =1008
10999487c: 957b1af2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994880: aa1a03e0    	mov	x0, x26
109994884: 957b1af6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994888: aa1703e0    	mov	x0, x23
10999488c: 957b1af4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994890: d101c3a0    	sub	x0, x29, #0x70
109994894: aa1503e1    	mov	x1, x21
109994898: 957b1af7    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
10999489c: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
1099948a0: aa1603e1    	mov	x1, x22
1099948a4: 957b1ae8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099948a8: aa1d03fd    	mov	x29, x29
1099948ac: 957b1ae9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099948b0: aa0003f5    	mov	x21, x0
1099948b4: f943bf80    	ldr	x0, [x28, #0x778] ; ��D 
1099948b8: aa1803e1    	mov	x1, x24
1099948bc: 957b1ae2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099948c0: aa0003e2    	mov	x2, x0
1099948c4: aa1503e0    	mov	x0, x21
1099948c8: aa1903e1    	mov	x1, x25
1099948cc: 957b1ade    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099948d0: aa1d03fd    	mov	x29, x29
1099948d4: 957b1adf    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1099948d8: aa0003f6    	mov	x22, x0
1099948dc: d009e2d8    	adrp	x24, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1099948e0: f947e318    	ldr	x24, [x24, #0xfc0]
1099948e4: f9002ff8    	str	x24, [sp, #0x58]
1099948e8: b0079f68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1099948ec: fd41c108    	ldr	d8, [x8, #0x380]
1099948f0: 90000008    	adrp	x8, 0x109994000 <_Flutter_MMFoundation_BindContext+0x5e6fbe4>
1099948f4: 91286108    	add	x8, x8, #0xa18
1099948f8: fd0033e8    	str	d8, [sp, #0x60]
1099948fc: f009e329    	adrp	x9, 0x11d5fb000 <dyld_stub_binder+0x11d5fb000>
109994900: 91056129    	add	x9, x9, #0x158
109994904: a906a7e8    	stp	x8, x9, [sp, #0x68]
109994908: 910163f7    	add	x23, sp, #0x58
10999490c: 9100c2e0    	add	x0, x23, #0x30
109994910: d101c3a1    	sub	x1, x29, #0x70
109994914: 957b1adb    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
109994918: a907d3f3    	stp	x19, x20, [sp, #0x78]
10999491c: f9001bf8    	str	x24, [sp, #0x30]
109994920: 90000008    	adrp	x8, 0x109994000 <_Flutter_MMFoundation_BindContext+0x5e6fbe4>
109994924: 913e6108    	add	x8, x8, #0xf98
109994928: fd001fe8    	str	d8, [sp, #0x38]
10999492c: d009e319    	adrp	x25, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
109994930: 91150339    	add	x25, x25, #0x540
109994934: a90467e8    	stp	x8, x25, [sp, #0x40]
109994938: 9100c3fa    	add	x26, sp, #0x30
10999493c: aa1403e0    	mov	x0, x20
109994940: 957b1ac0    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109994944: aa1303e0    	mov	x0, x19
109994948: 957b1abe    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10999494c: 91008340    	add	x0, x26, #0x20
109994950: d101c3a1    	sub	x1, x29, #0x70
109994954: 957b1acb    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
109994958: f90007f8    	str	x24, [sp, #0x8]
10999495c: fd000be8    	str	d8, [sp, #0x10]
109994960: 90000008    	adrp	x8, 0x109994000 <_Flutter_MMFoundation_BindContext+0x5e6fbe4>
109994964: 913f3108    	add	x8, x8, #0xfcc
109994968: a901e7e8    	stp	x8, x25, [sp, #0x18]
10999496c: 910023f8    	add	x24, sp, #0x8
109994970: 91008300    	add	x0, x24, #0x20
109994974: d101c3a1    	sub	x1, x29, #0x70
109994978: 957b1ac2    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
10999497c: d00b29e8    	adrp	x8, 0x11fed2000 <dyld_stub_binder+0x11fed2000>
109994980: f9467d01    	ldr	x1, [x8, #0xcf8] ; checkAndShowRealnameLicense:acceptCallback:denyCallback:startLoadingCallback:stopLoadingCallback:
109994984: 9009e9a4    	adrp	x4, 0x11d6c8000 <dyld_stub_binder+0x11d6c8000>
109994988: 9100a084    	add	x4, x4, #0x28
10999498c: 910163e3    	add	x3, sp, #0x58
109994990: 9100c3e5    	add	x5, sp, #0x30
109994994: 910023e6    	add	x6, sp, #0x8
109994998: aa1603e0    	mov	x0, x22
10999499c: 52800042    	mov	w2, #0x2                ; =2
1099949a0: 957b1aa9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1099949a4: aa1603e0    	mov	x0, x22
1099949a8: 957b1aad    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099949ac: aa1503e0    	mov	x0, x21
1099949b0: 957b1aab    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099949b4: 91008300    	add	x0, x24, #0x20
1099949b8: 957b1ab8    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
1099949bc: 91008340    	add	x0, x26, #0x20
1099949c0: 957b1ab6    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
1099949c4: f94043e0    	ldr	x0, [sp, #0x80]
1099949c8: 957b1aa5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099949cc: f9403fe0    	ldr	x0, [sp, #0x78]
1099949d0: 957b1aa3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099949d4: aa1403e0    	mov	x0, x20
1099949d8: 957b1aa1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099949dc: aa1303e0    	mov	x0, x19
1099949e0: 957b1a9f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1099949e4: 9100c2e0    	add	x0, x23, #0x30
1099949e8: 957b1aac    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
1099949ec: d101c3a0    	sub	x0, x29, #0x70
1099949f0: 957b1aaa    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
1099949f4: a9507bfd    	ldp	x29, x30, [sp, #0x100]
1099949f8: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
1099949fc: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
109994a00: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
109994a04: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
109994a08: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
109994a0c: 6d4a23e9    	ldp	d9, d8, [sp, #0xa0]
109994a10: 910443ff    	add	sp, sp, #0x110
109994a14: d65f03c0    	ret
109994a18: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
109994a1c: a90167fa    	stp	x26, x25, [sp, #0x10]
109994a20: a9025ff8    	stp	x24, x23, [sp, #0x20]
109994a24: a90357f6    	stp	x22, x21, [sp, #0x30]
109994a28: a9044ff4    	stp	x20, x19, [sp, #0x40]
109994a2c: a9057bfd    	stp	x29, x30, [sp, #0x50]
109994a30: 910143fd    	add	x29, sp, #0x50
109994a34: aa0003f5    	mov	x21, x0
109994a38: 9100c000    	add	x0, x0, #0x30
109994a3c: 957b1a96    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
109994a40: aa0003f3    	mov	x19, x0
109994a44: b4002980    	cbz	x0, 0x109994f74 <_Flutter_MMFoundation_BindContext+0x5e70b58>
109994a48: f00b2528    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109994a4c: f9460d01    	ldr	x1, [x8, #0xc18] ; startLoadingBlocked
109994a50: aa1303e0    	mov	x0, x19
109994a54: 957b1a7c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994a58: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994a5c: f945b901    	ldr	x1, [x8, #0xb70] ; bIsOpenIM
109994a60: aa1303e0    	mov	x0, x19
109994a64: 957b1a78    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994a68: 34000b80    	cbz	w0, 0x109994bd8 <_Flutter_MMFoundation_BindContext+0x5e707bc>
109994a6c: b00b40a8    	adrp	x8, 0x1201a9000 <dyld_stub_binder+0x1201a9000>
109994a70: f947fd00    	ldr	x0, [x8, #0xff8] ; �sK 
109994a74: 957b1a7b    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109994a78: aa0003f4    	mov	x20, x0
109994a7c: 900b46a8    	adrp	x8, 0x120268000 <dyld_stub_binder+0x120268000>
109994a80: 91264108    	add	x8, x8, #0x990
109994a84: b9800117    	ldrsw	x23, [x8]
109994a88: f8776a60    	ldr	x0, [x19, x23]
109994a8c: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109994a90: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
109994a94: 957b1a6c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994a98: aa1d03fd    	mov	x29, x29
109994a9c: 957b1a6d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994aa0: aa0003f6    	mov	x22, x0
109994aa4: d00b3748    	adrp	x8, 0x12007e000 <dyld_stub_binder+0x12007e000>
109994aa8: f9478901    	ldr	x1, [x8, #0xf10] ; setTransferId:
109994aac: aa1403e0    	mov	x0, x20
109994ab0: aa1603e2    	mov	x2, x22
109994ab4: 957b1a64    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ab8: aa1603e0    	mov	x0, x22
109994abc: 957b1a68    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994ac0: f8776a60    	ldr	x0, [x19, x23]
109994ac4: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994ac8: f9459901    	ldr	x1, [x8, #0xb30] ; m_nsControlTransationID
109994acc: 957b1a5e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ad0: aa1d03fd    	mov	x29, x29
109994ad4: 957b1a5f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994ad8: aa0003f6    	mov	x22, x0
109994adc: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994ae0: f945d101    	ldr	x1, [x8, #0xba0] ; setCftTradeId:
109994ae4: aa1403e0    	mov	x0, x20
109994ae8: aa1603e2    	mov	x2, x22
109994aec: 957b1a56    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994af0: aa1603e0    	mov	x0, x22
109994af4: 957b1a5a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994af8: f8776a60    	ldr	x0, [x19, x23]
109994afc: b00b29e8    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
109994b00: f941dd01    	ldr	x1, [x8, #0x3b8] ; selectedTransferChatroomUsername
109994b04: 957b1a50    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994b08: aa1d03fd    	mov	x29, x29
109994b0c: 957b1a51    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994b10: aa0003f6    	mov	x22, x0
109994b14: b00b2708    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
109994b18: f942a901    	ldr	x1, [x8, #0x550] ; setRoomid:
109994b1c: aa1403e0    	mov	x0, x20
109994b20: aa1603e2    	mov	x2, x22
109994b24: 957b1a48    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994b28: aa1603e0    	mov	x0, x22
109994b2c: 957b1a4c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994b30: f94012a2    	ldr	x2, [x21, #0x20]
109994b34: f00b3708    	adrp	x8, 0x120077000 <dyld_stub_binder+0x120077000>
109994b38: f943c101    	ldr	x1, [x8, #0x780] ; setLeftButtonContinue:
109994b3c: aa1403e0    	mov	x0, x20
109994b40: 957b1a41    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994b44: f94016a2    	ldr	x2, [x21, #0x28]
109994b48: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994b4c: f945d501    	ldr	x1, [x8, #0xba8] ; setAgainCtx:
109994b50: aa1403e0    	mov	x0, x20
109994b54: 957b1a3c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994b58: b00b2748    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
109994b5c: f9463901    	ldr	x1, [x8, #0xc70] ; setOp:
109994b60: aa1403e0    	mov	x0, x20
109994b64: 52800022    	mov	w2, #0x1                ; =1
109994b68: 957b1a37    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994b6c: d00b40a8    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
109994b70: f9400100    	ldr	x0, [x8]
109994b74: 957b1a3d    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
109994b78: 900b2548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109994b7c: f942a101    	ldr	x1, [x8, #0x540] ; initWithDelegate:
109994b80: aa1303e2    	mov	x2, x19
109994b84: 957b1a30    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994b88: aa0003f5    	mov	x21, x0
109994b8c: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994b90: f945d901    	ldr	x1, [x8, #0xbb0] ; setUnionConfirmCgi:
109994b94: aa1303e0    	mov	x0, x19
109994b98: aa1503e2    	mov	x2, x21
109994b9c: 957b1a2a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ba0: aa1503e0    	mov	x0, x21
109994ba4: 957b1a2e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994ba8: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994bac: f945dd01    	ldr	x1, [x8, #0xbb8] ; unionConfirmCgi
109994bb0: aa1303e0    	mov	x0, x19
109994bb4: 957b1a24    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994bb8: aa1d03fd    	mov	x29, x29
109994bbc: 957b1a25    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994bc0: aa0003f5    	mov	x21, x0
109994bc4: b00b28c8    	adrp	x8, 0x11fead000 <dyld_stub_binder+0x11fead000>
109994bc8: f946fd01    	ldr	x1, [x8, #0xdf8] ; startWithRequest:
109994bcc: aa1403e2    	mov	x2, x20
109994bd0: 957b1a1d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994bd4: 140000e4    	b	0x109994f64 <_Flutter_MMFoundation_BindContext+0x5e70b48>
109994bd8: d00b40a8    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
109994bdc: f9400500    	ldr	x0, [x8, #0x8] ; X�D 
109994be0: 957b1a20    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109994be4: aa0003f4    	mov	x20, x0
109994be8: 900b46a8    	adrp	x8, 0x120268000 <dyld_stub_binder+0x120268000>
109994bec: 91264108    	add	x8, x8, #0x990
109994bf0: b980011b    	ldrsw	x27, [x8]
109994bf4: f87b6a60    	ldr	x0, [x19, x27]
109994bf8: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994bfc: f9459d01    	ldr	x1, [x8, #0xb38] ; m_nsCurrentUserName
109994c00: 957b1a11    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c04: aa1d03fd    	mov	x29, x29
109994c08: 957b1a12    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994c0c: aa0003f6    	mov	x22, x0
109994c10: f00b3328    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
109994c14: f9426101    	ldr	x1, [x8, #0x4c0] ; setM_nsFromUserName:
109994c18: aa1403e0    	mov	x0, x20
109994c1c: aa1603e2    	mov	x2, x22
109994c20: 957b1a09    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c24: aa1603e0    	mov	x0, x22
109994c28: 957b1a0d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994c2c: f87b6a60    	ldr	x0, [x19, x27]
109994c30: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109994c34: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
109994c38: 957b1a03    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c3c: aa1d03fd    	mov	x29, x29
109994c40: 957b1a04    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994c44: aa0003f6    	mov	x22, x0
109994c48: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109994c4c: f9409d01    	ldr	x1, [x8, #0x138] ; setM_nsTransferID:
109994c50: aa1403e0    	mov	x0, x20
109994c54: aa1603e2    	mov	x2, x22
109994c58: 957b19fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c5c: aa1603e0    	mov	x0, x22
109994c60: 957b19ff    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994c64: f87b6a60    	ldr	x0, [x19, x27]
109994c68: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994c6c: f945a101    	ldr	x1, [x8, #0xb40] ; m_uiTransferInvalidTime
109994c70: 957b19f5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c74: aa0003e2    	mov	x2, x0
109994c78: d00b3728    	adrp	x8, 0x12007a000 <dyld_stub_binder+0x12007a000>
109994c7c: f943c101    	ldr	x1, [x8, #0x780] ; setM_uiInvalidTime:
109994c80: aa1403e0    	mov	x0, x20
109994c84: 957b19f0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c88: f94012a2    	ldr	x2, [x21, #0x20]
109994c8c: f00b3748    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109994c90: f9449101    	ldr	x1, [x8, #0x920] ; setLeft_button_continue:
109994c94: aa1403e0    	mov	x0, x20
109994c98: 957b19eb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994c9c: f87b6a60    	ldr	x0, [x19, x27]
109994ca0: b00b29e8    	adrp	x8, 0x11fed1000 <dyld_stub_binder+0x11fed1000>
109994ca4: f941dd15    	ldr	x21, [x8, #0x3b8] ; selectedTransferChatroomUsername
109994ca8: aa1503e1    	mov	x1, x21
109994cac: 957b19e6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994cb0: aa1d03fd    	mov	x29, x29
109994cb4: 957b19e7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994cb8: aa0003f6    	mov	x22, x0
109994cbc: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994cc0: f945c501    	ldr	x1, [x8, #0xb88] ; setGroup_username:
109994cc4: aa1403e0    	mov	x0, x20
109994cc8: aa1603e2    	mov	x2, x22
109994ccc: 957b19de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994cd0: aa1603e0    	mov	x0, x22
109994cd4: 957b19e2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994cd8: f87b6a60    	ldr	x0, [x19, x27]
109994cdc: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994ce0: f945e101    	ldr	x1, [x8, #0xbc0] ; recvChannelType
109994ce4: 957b19d8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ce8: aa0003e2    	mov	x2, x0
109994cec: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994cf0: f945e501    	ldr	x1, [x8, #0xbc8] ; setRecv_channel_type:
109994cf4: aa1403e0    	mov	x0, x20
109994cf8: 957b19d3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994cfc: f87b6a60    	ldr	x0, [x19, x27]
109994d00: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994d04: f945e901    	ldr	x1, [x8, #0xbd0] ; recvBindSerial
109994d08: 957b19cf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994d0c: aa1d03fd    	mov	x29, x29
109994d10: 957b19d0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994d14: aa0003f6    	mov	x22, x0
109994d18: d00b36e8    	adrp	x8, 0x120072000 <dyld_stub_binder+0x120072000>
109994d1c: f941e901    	ldr	x1, [x8, #0x3d0] ; setBind_serial:
109994d20: aa1403e0    	mov	x0, x20
109994d24: aa1603e2    	mov	x2, x22
109994d28: 957b19c7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994d2c: aa1603e0    	mov	x0, x22
109994d30: 957b19cb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994d34: f87b6a60    	ldr	x0, [x19, x27]
109994d38: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994d3c: f945ed01    	ldr	x1, [x8, #0xbd8] ; m_subChannelId
109994d40: 957b19c1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994d44: aa0003e2    	mov	x2, x0
109994d48: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994d4c: f945f101    	ldr	x1, [x8, #0xbe0] ; setSub_recv_channel_id:
109994d50: aa1403e0    	mov	x0, x20
109994d54: 957b19bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994d58: f87b6a60    	ldr	x0, [x19, x27]
109994d5c: f00b3748    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109994d60: f9454901    	ldr	x1, [x8, #0xa90] ; m_nsTransferAttach
109994d64: 957b19b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994d68: aa1d03fd    	mov	x29, x29
109994d6c: 957b19b9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994d70: aa0003f6    	mov	x22, x0
109994d74: b00b25c8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109994d78: f940e101    	ldr	x1, [x8, #0x1c0] ; setM_nsTransferAttach:
109994d7c: aa1403e0    	mov	x0, x20
109994d80: aa1603e2    	mov	x2, x22
109994d84: 957b19b0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994d88: aa1603e0    	mov	x0, x22
109994d8c: 957b19b4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994d90: f00b3efc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
109994d94: f945eb80    	ldr	x0, [x28, #0xbd0] ; ��d 
109994d98: 900b3b68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109994d9c: f944e916    	ldr	x22, [x8, #0x9d0] ; currentContext
109994da0: aa1603e1    	mov	x1, x22
109994da4: 957b19a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994da8: aa1d03fd    	mov	x29, x29
109994dac: 957b19a9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994db0: aa0003f9    	mov	x25, x0
109994db4: 900b3f08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
109994db8: f9401500    	ldr	x0, [x8, #0x28] ; P;, 
109994dbc: f00b3b48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109994dc0: f947ad17    	ldr	x23, [x8, #0xf58] ; class
109994dc4: aa1703e1    	mov	x1, x23
109994dc8: 957b199f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994dcc: aa0003e2    	mov	x2, x0
109994dd0: b00b2528    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109994dd4: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
109994dd8: aa1903e0    	mov	x0, x25
109994ddc: aa1803e1    	mov	x1, x24
109994de0: 957b1999    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994de4: aa1d03fd    	mov	x29, x29
109994de8: 957b199a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994dec: aa0003fa    	mov	x26, x0
109994df0: f87b6a60    	ldr	x0, [x19, x27]
109994df4: aa1503e1    	mov	x1, x21
109994df8: 957b1993    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994dfc: aa1d03fd    	mov	x29, x29
109994e00: 957b1994    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994e04: aa0003fb    	mov	x27, x0
109994e08: 900b2548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109994e0c: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
109994e10: aa1a03e0    	mov	x0, x26
109994e14: aa1b03e2    	mov	x2, x27
109994e18: 957b198b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994e1c: aa1d03fd    	mov	x29, x29
109994e20: 957b198c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994e24: aa0003f5    	mov	x21, x0
109994e28: aa1b03e0    	mov	x0, x27
109994e2c: 957b198c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994e30: aa1a03e0    	mov	x0, x26
109994e34: 957b198a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994e38: aa1903e0    	mov	x0, x25
109994e3c: 957b1988    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994e40: b4000195    	cbz	x21, 0x109994e70 <_Flutter_MMFoundation_BindContext+0x5e70a54>
109994e44: 900b2548    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109994e48: f944bd01    	ldr	x1, [x8, #0x978] ; isOpenImChatroomAndUpgradeOpenIMChatroom
109994e4c: aa1503e0    	mov	x0, x21
109994e50: 957b197d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994e54: 7100001f    	cmp	w0, #0x0
109994e58: 52800028    	mov	w8, #0x1                ; =1
109994e5c: 1a880502    	cinc	w2, w8, ne
109994e60: b00b2c08    	adrp	x8, 0x11ff15000 <dyld_stub_binder+0x11ff15000>
109994e64: f9432501    	ldr	x1, [x8, #0x648] ; setGroupType:
109994e68: aa1403e0    	mov	x0, x20
109994e6c: 957b1976    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994e70: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994e74: f945f519    	ldr	x25, [x8, #0xbe8] ; recvChannelSubTitleClickInfo
109994e78: aa1303e0    	mov	x0, x19
109994e7c: aa1903e1    	mov	x1, x25
109994e80: 957b1971    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994e84: aa1d03fd    	mov	x29, x29
109994e88: 957b1972    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994e8c: aa0003fa    	mov	x26, x0
109994e90: 957b1973    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994e94: b40002da    	cbz	x26, 0x109994eec <_Flutter_MMFoundation_BindContext+0x5e70ad0>
109994e98: aa1303e0    	mov	x0, x19
109994e9c: aa1903e1    	mov	x1, x25
109994ea0: 957b1969    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ea4: aa1d03fd    	mov	x29, x29
109994ea8: 957b196a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994eac: aa0003f9    	mov	x25, x0
109994eb0: f00b2528    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109994eb4: f943ad01    	ldr	x1, [x8, #0x758] ; JSONRepresentation
109994eb8: 957b1963    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ebc: aa1d03fd    	mov	x29, x29
109994ec0: 957b1964    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994ec4: aa0003fa    	mov	x26, x0
109994ec8: aa1903e0    	mov	x0, x25
109994ecc: 957b1964    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994ed0: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994ed4: f945f901    	ldr	x1, [x8, #0xbf0] ; setSub_title_clicked:
109994ed8: aa1403e0    	mov	x0, x20
109994edc: aa1a03e2    	mov	x2, x26
109994ee0: 957b1959    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ee4: aa1a03e0    	mov	x0, x26
109994ee8: 957b195d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994eec: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994ef0: f945fd01    	ldr	x1, [x8, #0xbf8] ; setRecvChannelSubTitleClickInfo:
109994ef4: aa1303e0    	mov	x0, x19
109994ef8: d2800002    	mov	x2, #0x0                ; =0
109994efc: 957b1952    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994f00: f945eb80    	ldr	x0, [x28, #0xbd0] ; ��d 
109994f04: aa1603e1    	mov	x1, x22
109994f08: 957b194f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994f0c: aa1d03fd    	mov	x29, x29
109994f10: 957b1950    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994f14: aa0003f6    	mov	x22, x0
109994f18: d00b3f08    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
109994f1c: f943bd00    	ldr	x0, [x8, #0x778] ; ��D 
109994f20: aa1703e1    	mov	x1, x23
109994f24: 957b1948    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994f28: aa0003e2    	mov	x2, x0
109994f2c: aa1603e0    	mov	x0, x22
109994f30: aa1803e1    	mov	x1, x24
109994f34: 957b1944    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994f38: aa1d03fd    	mov	x29, x29
109994f3c: 957b1945    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109994f40: aa0003f7    	mov	x23, x0
109994f44: d00b3788    	adrp	x8, 0x120086000 <dyld_stub_binder+0x120086000>
109994f48: f9460101    	ldr	x1, [x8, #0xc00] ; ConfirmTransferMoney:
109994f4c: aa1403e2    	mov	x2, x20
109994f50: 957b193d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994f54: aa1703e0    	mov	x0, x23
109994f58: 957b1941    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994f5c: aa1603e0    	mov	x0, x22
109994f60: 957b193f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994f64: aa1503e0    	mov	x0, x21
109994f68: 957b193d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994f6c: aa1403e0    	mov	x0, x20
109994f70: 957b193b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994f74: aa1303e0    	mov	x0, x19
109994f78: a9457bfd    	ldp	x29, x30, [sp, #0x50]
109994f7c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
109994f80: a94357f6    	ldp	x22, x21, [sp, #0x30]
109994f84: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109994f88: a94167fa    	ldp	x26, x25, [sp, #0x10]
109994f8c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
109994f90: 157b1933    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994f94: d65f03c0    	ret
109994f98: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
109994f9c: a9017bfd    	stp	x29, x30, [sp, #0x10]
109994fa0: 910043fd    	add	x29, sp, #0x10
109994fa4: 91008000    	add	x0, x0, #0x20
109994fa8: 957b193b    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
109994fac: aa0003f3    	mov	x19, x0
109994fb0: d00b3ba8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109994fb4: f9452101    	ldr	x1, [x8, #0xa40] ; startLoading
109994fb8: 957b1923    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994fbc: aa1303e0    	mov	x0, x19
109994fc0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
109994fc4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
109994fc8: 157b1925    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109994fcc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
109994fd0: a9017bfd    	stp	x29, x30, [sp, #0x10]
109994fd4: 910043fd    	add	x29, sp, #0x10
109994fd8: 91008000    	add	x0, x0, #0x20
109994fdc: 957b192e    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
109994fe0: aa0003f3    	mov	x19, x0
109994fe4: d00b3ba8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109994fe8: f9460101    	ldr	x1, [x8, #0xc00] ; stopLoading
109994fec: 957b1916    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109994ff0: aa1303e0    	mov	x0, x19
109994ff4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
109994ff8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
109994ffc: 157b1918    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>