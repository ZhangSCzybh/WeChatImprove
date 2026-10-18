
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1097116c4: d10183ff    	sub	sp, sp, #0x60
1097116c8: a90167fa    	stp	x26, x25, [sp, #0x10]
1097116cc: a9025ff8    	stp	x24, x23, [sp, #0x20]
1097116d0: a90357f6    	stp	x22, x21, [sp, #0x30]
1097116d4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1097116d8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1097116dc: 910143fd    	add	x29, sp, #0x50
1097116e0: aa0203f6    	mov	x22, x2
1097116e4: aa0003f5    	mov	x21, x0
1097116e8: d00ba9e8    	adrp	x8, 0x120c4f000 <dyld_stub_binder+0x120c4f000>
1097116ec: 52800029    	mov	w9, #0x1                ; =1
1097116f0: 39182509    	strb	w9, [x8, #0x609]
1097116f4: d00b5314    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1097116f8: f9454293    	ldr	x19, [x20, #0xa80]
1097116fc: aa0203e0    	mov	x0, x2
109711700: 95852750    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109711704: aa1303e0    	mov	x0, x19
109711708: 95852756    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10971170c: aa0003f3    	mov	x19, x0
109711710: f9454280    	ldr	x0, [x20, #0xa80]
109711714: 95852753    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109711718: aa0003f4    	mov	x20, x0
10971171c: d00b4b28    	adrp	x8, 0x120077000 <dyld_stub_binder+0x120077000>
109711720: f947f901    	ldr	x1, [x8, #0xff0] ; m_nsTransactionID
109711724: aa1603e0    	mov	x0, x22
109711728: 95852747    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10971172c: aa1d03fd    	mov	x29, x29
109711730: 95852748    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711734: aa0003f8    	mov	x24, x0
109711738: 900b3948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10971173c: f942c917    	ldr	x23, [x8, #0x590] ; safeSetObject:forKey:
109711740: f00a9663    	adrp	x3, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
109711744: 91242063    	add	x3, x3, #0x908 ; CFSTR trans_id
109711748: aa1303e0    	mov	x0, x19
10971174c: aa1703e1    	mov	x1, x23
109711750: aa1803e2    	mov	x2, x24
109711754: 9585273c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711758: aa1803e0    	mov	x0, x24
10971175c: 95852740    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711760: 900b39e8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109711764: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
109711768: aa1603e0    	mov	x0, x22
10971176c: 95852736    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711770: aa1d03fd    	mov	x29, x29
109711774: 95852737    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711778: aa0003f8    	mov	x24, x0
10971177c: f00a9663    	adrp	x3, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
109711780: 9123a063    	add	x3, x3, #0x8e8 ; CFSTR transfer_id
109711784: aa1303e0    	mov	x0, x19
109711788: aa1703e1    	mov	x1, x23
10971178c: aa1803e2    	mov	x2, x24
109711790: 9585272d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711794: aa1803e0    	mov	x0, x24
109711798: 95852731    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10971179c: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
1097117a0: f9454501    	ldr	x1, [x8, #0xa88] ; group_username
1097117a4: aa1603e0    	mov	x0, x22
1097117a8: 95852727    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097117ac: aa1d03fd    	mov	x29, x29
1097117b0: 95852728    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1097117b4: aa0003f8    	mov	x24, x0
1097117b8: 900a9763    	adrp	x3, 0x11e9fd000 <dyld_stub_binder+0x11e9fd000>
1097117bc: 9111a063    	add	x3, x3, #0x468 ; CFSTR group_username
1097117c0: aa1303e0    	mov	x0, x19
1097117c4: aa1703e1    	mov	x1, x23
1097117c8: aa1803e2    	mov	x2, x24
1097117cc: 9585271e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097117d0: aa1803e0    	mov	x0, x24
1097117d4: 95852722    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1097117d8: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
1097117dc: f9454901    	ldr	x1, [x8, #0xa90] ; m_nsTransferAttach
1097117e0: aa1603e0    	mov	x0, x22
1097117e4: 95852718    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097117e8: aa1d03fd    	mov	x29, x29
1097117ec: 95852719    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1097117f0: aa0003f8    	mov	x24, x0
1097117f4: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
1097117f8: 9128a063    	add	x3, x3, #0xa28 ; CFSTR transfer_attach
1097117fc: aa1303e0    	mov	x0, x19
109711800: aa1703e1    	mov	x1, x23
109711804: aa1803e2    	mov	x2, x24
109711808: 9585270f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10971180c: aa1803e0    	mov	x0, x24
109711810: 95852713    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711814: d00b5308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109711818: f9454518    	ldr	x24, [x8, #0xa88]
10971181c: 900b39e8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109711820: f940b101    	ldr	x1, [x8, #0x160] ; m_uiInvalidTime
109711824: aa1603e0    	mov	x0, x22
109711828: 95852707    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10971182c: aa0003f9    	mov	x25, x0
109711830: aa1603e0    	mov	x0, x22
109711834: 9585270a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711838: b00b4fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10971183c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
109711840: f90003f9    	str	x25, [sp]
109711844: b00a6ca2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
109711848: 91232042    	add	x2, x2, #0x8c8 ; CFSTR %llu
10971184c: aa1803e0    	mov	x0, x24
109711850: 958526fd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711854: aa1d03fd    	mov	x29, x29
109711858: 958526fe    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10971185c: aa0003f6    	mov	x22, x0
109711860: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711864: 91292063    	add	x3, x3, #0xa48 ; CFSTR invalid_time
109711868: aa1303e0    	mov	x0, x19
10971186c: aa1703e1    	mov	x1, x23
109711870: aa1603e2    	mov	x2, x22
109711874: 958526f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711878: aa1603e0    	mov	x0, x22
10971187c: 958526f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711880: 900b4b68    	adrp	x8, 0x12007d000 <dyld_stub_binder+0x12007d000>
109711884: f9477d01    	ldr	x1, [x8, #0xef8] ; GetWCPayBusinessRequest:WXInnerUseDic:CMDID:OutputType:
109711888: aa1503e0    	mov	x0, x21
10971188c: aa1303e2    	mov	x2, x19
109711890: aa1403e3    	mov	x3, x20
109711894: 52800a84    	mov	w4, #0x54               ; =84
109711898: 52800025    	mov	w5, #0x1                ; =1
10971189c: 958526ea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097118a0: d00b5308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1097118a4: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
1097118a8: 900b3948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1097118ac: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1097118b0: b00a9768    	adrp	x8, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
1097118b4: 9129a108    	add	x8, x8, #0xa68 ; CFSTR MMTENPAY_CGICMD_QUERY_TRANSFER_STATUS start !!
1097118b8: f90003e8    	str	x8, [sp]
1097118bc: f008d9c3    	adrp	x3, 0x11b24c000 <dyld_stub_binder+0x11b24c000>
1097118c0: 910fac63    	add	x3, x3, #0x3eb
1097118c4: f0092bc5    	adrp	x5, 0x11bc8c000 <dyld_stub_binder+0x11bc8c000>
1097118c8: 9133aca5    	add	x5, x5, #0xceb
1097118cc: 90092be7    	adrp	x7, 0x11bc8d000 <dyld_stub_binder+0x11bc8d000>
1097118d0: 9100bce7    	add	x7, x7, #0x2f
1097118d4: 52800022    	mov	w2, #0x1                ; =1
1097118d8: 52800004    	mov	w4, #0x0                ; =0
1097118dc: 528041e6    	mov	w6, #0x20f              ; =527
1097118e0: 958526d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097118e4: aa1403e0    	mov	x0, x20
1097118e8: 958526dd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1097118ec: aa1303e0    	mov	x0, x19
1097118f0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1097118f4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1097118f8: a94357f6    	ldp	x22, x21, [sp, #0x30]
1097118fc: a9425ff8    	ldp	x24, x23, [sp, #0x20]
109711900: a94167fa    	ldp	x26, x25, [sp, #0x10]
109711904: 910183ff    	add	sp, sp, #0x60
109711908: 158526d5    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>