
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c10644: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
105c10648: a90157f6    	stp	x22, x21, [sp, #0x10]
105c1064c: a9024ff4    	stp	x20, x19, [sp, #0x20]
105c10650: a9037bfd    	stp	x29, x30, [sp, #0x30]
105c10654: 9100c3fd    	add	x29, sp, #0x30
105c10658: aa0003f3    	mov	x19, x0
105c1065c: d00d8188    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c10660: 52800029    	mov	w9, #0x1                ; =1
105c10664: 39103909    	strb	w9, [x8, #0x40e]
105c10668: f00d1168    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c1066c: f9415d01    	ldr	x1, [x8, #0x2b8] ; isTailPart
105c10670: 94805ab3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10674: 340005e0    	cbz	w0, 0x105c10730 <_Flutter_MMFoundation_BindContext+0x20ec314>
105c10678: f00d1168    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c1067c: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
105c10680: aa1303e0    	mov	x0, x19
105c10684: 94805aae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10688: 37000540    	tbnz	w0, #0x0, 0x105c10730 <_Flutter_MMFoundation_BindContext+0x20ec314>
105c1068c: b00d2b34    	adrp	x20, 0x120175000 <dyld_stub_binder+0x120175000>
105c10690: f9430680    	ldr	x0, [x20, #0x608] ; 8�) 
105c10694: 900d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c10698: f942cd01    	ldr	x1, [x8, #0x598] ; isAutoTranslateAllSessions
105c1069c: 94805aa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c106a0: 37000480    	tbnz	w0, #0x0, 0x105c10730 <_Flutter_MMFoundation_BindContext+0x20ec314>
105c106a4: f00d2e68    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
105c106a8: 910b0108    	add	x8, x8, #0x2c0
105c106ac: f9430694    	ldr	x20, [x20, #0x608] ; 8�) 
105c106b0: b9800118    	ldrsw	x24, [x8]
105c106b4: f8786a60    	ldr	x0, [x19, x24]
105c106b8: b00d1168    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105c106bc: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
105c106c0: 94805a9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c106c4: aa1d03fd    	mov	x29, x29
105c106c8: 94805aa0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c106cc: aa0003f5    	mov	x21, x0
105c106d0: 900d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c106d4: f9430d01    	ldr	x1, [x8, #0x618] ; canShowAutoTranslateEntry:
105c106d8: aa1403e0    	mov	x0, x20
105c106dc: aa1503e2    	mov	x2, x21
105c106e0: 94805a97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c106e4: aa0003f4    	mov	x20, x0
105c106e8: aa1503e0    	mov	x0, x21
105c106ec: 94805a9a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c106f0: 34000214    	cbz	w20, 0x105c10730 <_Flutter_MMFoundation_BindContext+0x20ec314>
105c106f4: d00d1508    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
105c106f8: f942c901    	ldr	x1, [x8, #0x590] ; translateInfo
105c106fc: aa1303e0    	mov	x0, x19
105c10700: 94805a8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10704: aa1d03fd    	mov	x29, x29
105c10708: 94805a90    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c1070c: aa0003f4    	mov	x20, x0
105c10710: 900d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c10714: f942c101    	ldr	x1, [x8, #0x580] ; translateStatus
105c10718: 94805a89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c1071c: aa0003f5    	mov	x21, x0
105c10720: aa1403e0    	mov	x0, x20
105c10724: 94805a8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c10728: 710006bf    	cmp	w21, #0x1
105c1072c: 54000101    	b.ne	0x105c1074c <_Flutter_MMFoundation_BindContext+0x20ec330>
105c10730: 52800013    	mov	w19, #0x0               ; =0
105c10734: aa1303e0    	mov	x0, x19
105c10738: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105c1073c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105c10740: a94157f6    	ldp	x22, x21, [sp, #0x10]
105c10744: a8c45ff8    	ldp	x24, x23, [sp], #0x40
105c10748: d65f03c0    	ret
105c1074c: b00d1d68    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c10750: f9479501    	ldr	x1, [x8, #0xf28] ; isAutoTransEnable
105c10754: aa1303e0    	mov	x0, x19
105c10758: 94805a79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c1075c: aa0003f4    	mov	x20, x0
105c10760: 900d2788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c10764: f946f115    	ldr	x21, [x8, #0xde0] ; delegate
105c10768: aa1303e0    	mov	x0, x19
105c1076c: aa1503e1    	mov	x1, x21
105c10770: 94805a73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10774: aa1d03fd    	mov	x29, x29
105c10778: 94805a74    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c1077c: aa0003f6    	mov	x22, x0
105c10780: 340001d4    	cbz	w20, 0x105c107b8 <_Flutter_MMFoundation_BindContext+0x20ec39c>
105c10784: f8786a62    	ldr	x2, [x19, x24]
105c10788: b00d1d68    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c1078c: f947a501    	ldr	x1, [x8, #0xf48] ; isLastTranslateAvailableMsg:includeSelf:showTranslateInfo:
105c10790: 52800033    	mov	w19, #0x1               ; =1
105c10794: aa1603e0    	mov	x0, x22
105c10798: 52800003    	mov	w3, #0x0                ; =0
105c1079c: 52800024    	mov	w4, #0x1                ; =1
105c107a0: 94805a67    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c107a4: aa0003f4    	mov	x20, x0
105c107a8: aa1603e0    	mov	x0, x22
105c107ac: 94805a6a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c107b0: 3607fc14    	tbz	w20, #0x0, 0x105c10730 <_Flutter_MMFoundation_BindContext+0x20ec314>
105c107b4: 17ffffe0    	b	0x105c10734 <_Flutter_MMFoundation_BindContext+0x20ec318>
105c107b8: d00d1d68    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c107bc: f941cd01    	ldr	x1, [x8, #0x398] ; firstMsgAfterEnterSession
105c107c0: aa1603e0    	mov	x0, x22
105c107c4: 94805a5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c107c8: aa1d03fd    	mov	x29, x29
105c107cc: 94805a5f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c107d0: aa0003f4    	mov	x20, x0
105c107d4: aa1603e0    	mov	x0, x22
105c107d8: 94805a5f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c107dc: b40007d4    	cbz	x20, 0x105c108d4 <_Flutter_MMFoundation_BindContext+0x20ec4b8>
105c107e0: f8786a60    	ldr	x0, [x19, x24]
105c107e4: 900d1168    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105c107e8: f947d116    	ldr	x22, [x8, #0xfa0] ; m_uiMesLocalID
105c107ec: aa1603e1    	mov	x1, x22
105c107f0: 94805a53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c107f4: aa0003f7    	mov	x23, x0
105c107f8: aa1403e0    	mov	x0, x20
105c107fc: aa1603e1    	mov	x1, x22
105c10800: 94805a4f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10804: 6b0002ff    	cmp	w23, w0
105c10808: 54000663    	b.lo	0x105c108d4 <_Flutter_MMFoundation_BindContext+0x20ec4b8>
105c1080c: aa1303e0    	mov	x0, x19
105c10810: aa1503e1    	mov	x1, x21
105c10814: 94805a4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10818: aa1d03fd    	mov	x29, x29
105c1081c: 94805a4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c10820: aa0003f5    	mov	x21, x0
105c10824: f8786a62    	ldr	x2, [x19, x24]
105c10828: b00d1d68    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
105c1082c: f947a501    	ldr	x1, [x8, #0xf48] ; isLastTranslateAvailableMsg:includeSelf:showTranslateInfo:
105c10830: 52800003    	mov	w3, #0x0                ; =0
105c10834: 52800004    	mov	w4, #0x0                ; =0
105c10838: 94805a41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c1083c: aa0003f6    	mov	x22, x0
105c10840: aa1503e0    	mov	x0, x21
105c10844: 94805a44    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c10848: 34000476    	cbz	w22, 0x105c108d4 <_Flutter_MMFoundation_BindContext+0x20ec4b8>
105c1084c: f00d2b08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c10850: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c10854: 900d2788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c10858: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105c1085c: 94805a38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10860: aa1d03fd    	mov	x29, x29
105c10864: 94805a39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c10868: aa0003f5    	mov	x21, x0
105c1086c: b00d2b28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105c10870: f942fd00    	ldr	x0, [x8, #0x5f8] ; ��: 
105c10874: f00d2768    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105c10878: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105c1087c: 94805a30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10880: aa0003e2    	mov	x2, x0
105c10884: b00d1148    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c10888: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105c1088c: aa1503e0    	mov	x0, x21
105c10890: 94805a2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c10894: aa1d03fd    	mov	x29, x29
105c10898: 94805a2c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c1089c: aa0003f6    	mov	x22, x0
105c108a0: f8786a62    	ldr	x2, [x19, x24]
105c108a4: 900d11a8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
105c108a8: f9427501    	ldr	x1, [x8, #0x4e8] ; showTranslatedTextNow:
105c108ac: 94805a24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c108b0: aa0003f3    	mov	x19, x0
105c108b4: aa1603e0    	mov	x0, x22
105c108b8: 94805a27    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c108bc: aa1503e0    	mov	x0, x21
105c108c0: 94805a25    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c108c4: 36000113    	tbz	w19, #0x0, 0x105c108e4 <_Flutter_MMFoundation_BindContext+0x20ec4c8>
105c108c8: aa1403e0    	mov	x0, x20
105c108cc: 94805a22    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c108d0: 17ffff98    	b	0x105c10730 <_Flutter_MMFoundation_BindContext+0x20ec314>
105c108d4: 52800013    	mov	w19, #0x0               ; =0
105c108d8: aa1403e0    	mov	x0, x20
105c108dc: 94805a1e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c108e0: 17ffff95    	b	0x105c10734 <_Flutter_MMFoundation_BindContext+0x20ec318>
105c108e4: 52800033    	mov	w19, #0x1               ; =1
105c108e8: 17fffffc    	b	0x105c108d8 <_Flutter_MMFoundation_BindContext+0x20ec4bc>