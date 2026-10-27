
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10575701c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
105757020: a9015ff8    	stp	x24, x23, [sp, #0x10]
105757024: a90257f6    	stp	x22, x21, [sp, #0x20]
105757028: a9034ff4    	stp	x20, x19, [sp, #0x30]
10575702c: a9047bfd    	stp	x29, x30, [sp, #0x40]
105757030: 910103fd    	add	x29, sp, #0x40
105757034: aa0303f4    	mov	x20, x3
105757038: aa0203f3    	mov	x19, x2
10575703c: aa0003f6    	mov	x22, x0
105757040: d00da748    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
105757044: 52800029    	mov	w9, #0x1                ; =1
105757048: 390a5d09    	strb	w9, [x8, #0x297]
10575704c: aa0203e0    	mov	x0, x2
105757050: 9493403a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105757054: aa1403e0    	mov	x0, x20
105757058: 94934038    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10575705c: b00d3728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105757060: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
105757064: aa1303e0    	mov	x0, x19
105757068: aa1403e2    	mov	x2, x20
10575706c: 52800023    	mov	w3, #0x1                ; =1
105757070: 94934033    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757074: f00d4d68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
105757078: f9440901    	ldr	x1, [x8, #0x810] ; row
10575707c: aa1403e0    	mov	x0, x20
105757080: 9493402f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757084: aa0003e2    	mov	x2, x0
105757088: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10575708c: b98b6908    	ldrsw	x8, [x8, #0xb68]
105757090: f8686ac0    	ldr	x0, [x22, x8]
105757094: f00d3708    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105757098: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
10575709c: 94934028    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057570a0: aa1d03fd    	mov	x29, x29
1057570a4: 94934029    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057570a8: aa0003f5    	mov	x21, x0
1057570ac: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
1057570b0: b98b6d1a    	ldrsw	x26, [x8, #0xb6c]
1057570b4: 8b1a02c0    	add	x0, x22, x26
1057570b8: 94934035    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057570bc: aa0003f8    	mov	x24, x0
1057570c0: 900d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
1057570c4: f9478517    	ldr	x23, [x8, #0xf08] ; onShouldTagSelectContact:withDicMultiSelect:andDicExistContact:
1057570c8: f00d4d68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057570cc: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1057570d0: aa1703e2    	mov	x2, x23
1057570d4: 9493401a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057570d8: aa0003f9    	mov	x25, x0
1057570dc: aa1803e0    	mov	x0, x24
1057570e0: 9493401d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057570e4: 34000239    	cbz	w25, 0x105757128 <_Flutter_MMFoundation_BindContext+0x1c32d0c>
1057570e8: 8b1a02c0    	add	x0, x22, x26
1057570ec: 94934028    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1057570f0: aa0003f8    	mov	x24, x0
1057570f4: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
1057570f8: b98b4908    	ldrsw	x8, [x8, #0xb48]
1057570fc: f8686ac3    	ldr	x3, [x22, x8]
105757100: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105757104: b98b7108    	ldrsw	x8, [x8, #0xb70]
105757108: f8686ac4    	ldr	x4, [x22, x8]
10575710c: aa1703e1    	mov	x1, x23
105757110: aa1503e2    	mov	x2, x21
105757114: 9493400a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757118: aa0003f7    	mov	x23, x0
10575711c: aa1803e0    	mov	x0, x24
105757120: 9493400d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105757124: 340010b7    	cbz	w23, 0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
105757128: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
10575712c: b98b4d08    	ldrsw	x8, [x8, #0xb4c]
105757130: b8686ac8    	ldr	w8, [x22, x8]
105757134: 7100051f    	cmp	w8, #0x1
105757138: 540006a0    	b.eq	0x10575720c <_Flutter_MMFoundation_BindContext+0x1c32df0>
10575713c: 7100091f    	cmp	w8, #0x2
105757140: 540001a0    	b.eq	0x105757174 <_Flutter_MMFoundation_BindContext+0x1c32d58>
105757144: 71000d1f    	cmp	w8, #0x3
105757148: 54000b81    	b.ne	0x1057572b8 <_Flutter_MMFoundation_BindContext+0x1c32e9c>
10575714c: b4000f75    	cbz	x21, 0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
105757150: 900d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
105757154: f9478901    	ldr	x1, [x8, #0xf10] ; updateMultiSelect:contact:tableView:allSelectMode:
105757158: aa1603e0    	mov	x0, x22
10575715c: aa1403e2    	mov	x2, x20
105757160: aa1503e3    	mov	x3, x21
105757164: aa1303e4    	mov	x4, x19
105757168: 52800005    	mov	w5, #0x0                ; =0
10575716c: 94933ff4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757170: 14000061    	b	0x1057572f4 <_Flutter_MMFoundation_BindContext+0x1c32ed8>
105757174: b4000e35    	cbz	x21, 0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
105757178: b00d50e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10575717c: f9400900    	ldr	x0, [x8, #0x10] ; `:,
105757180: 94933ff6    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105757184: aa0003f7    	mov	x23, x0
105757188: 900d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10575718c: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
105757190: aa1503e2    	mov	x2, x21
105757194: 94933fea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757198: 900d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10575719c: f946e901    	ldr	x1, [x8, #0xdd0] ; setM_uiFromScene:
1057571a0: aa1703e0    	mov	x0, x23
1057571a4: 528009a2    	mov	w2, #0x4d               ; =77
1057571a8: 94933fe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057571ac: 900d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057571b0: f946e101    	ldr	x1, [x8, #0xdc0] ; setHidesBottomBarWhenPushed:
1057571b4: 52800039    	mov	w25, #0x1               ; =1
1057571b8: aa1703e0    	mov	x0, x23
1057571bc: 52800022    	mov	w2, #0x1                ; =1
1057571c0: 94933fdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057571c4: b00d4d68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1057571c8: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
1057571cc: aa1603e0    	mov	x0, x22
1057571d0: 94933fdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057571d4: aa1d03fd    	mov	x29, x29
1057571d8: 94933fdc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057571dc: aa0003f8    	mov	x24, x0
1057571e0: 900d3728    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1057571e4: f944e101    	ldr	x1, [x8, #0x9c0] ; PushViewController:animated:
1057571e8: aa1703e2    	mov	x2, x23
1057571ec: 52800023    	mov	w3, #0x1                ; =1
1057571f0: 94933fd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057571f4: aa1803e0    	mov	x0, x24
1057571f8: 94933fd7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057571fc: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105757200: b98b5508    	ldrsw	x8, [x8, #0xb54]
105757204: 38286ad9    	strb	w25, [x22, x8]
105757208: 14000029    	b	0x1057572ac <_Flutter_MMFoundation_BindContext+0x1c32e90>
10575720c: b4000975    	cbz	x21, 0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
105757210: 900d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105757214: f945e900    	ldr	x0, [x8, #0xbd0]
105757218: b00d4d48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10575721c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105757220: 94933fc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757224: aa1d03fd    	mov	x29, x29
105757228: 94933fc8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10575722c: aa0003f7    	mov	x23, x0
105757230: b00d50e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105757234: f940a100    	ldr	x0, [x8, #0x140]
105757238: 900d4d48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10575723c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105757240: 94933fbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757244: aa0003e2    	mov	x2, x0
105757248: d00d3708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10575724c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105757250: aa1703e0    	mov	x0, x23
105757254: 94933fba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757258: aa1d03fd    	mov	x29, x29
10575725c: 94933fbb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105757260: aa0003f8    	mov	x24, x0
105757264: b00d4d68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
105757268: f945dd01    	ldr	x1, [x8, #0xbb8] ; navigationController
10575726c: aa1603e0    	mov	x0, x22
105757270: 94933fb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757274: aa1d03fd    	mov	x29, x29
105757278: 94933fb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10575727c: aa0003f6    	mov	x22, x0
105757280: f00d3748    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105757284: f9424101    	ldr	x1, [x8, #0x480] ; PushOtherBaseMsgControllerByContact:navigationController:animated:
105757288: aa1803e0    	mov	x0, x24
10575728c: aa1503e2    	mov	x2, x21
105757290: aa1603e3    	mov	x3, x22
105757294: 52800024    	mov	w4, #0x1                ; =1
105757298: 94933fa9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10575729c: aa1603e0    	mov	x0, x22
1057572a0: 94933fad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057572a4: aa1803e0    	mov	x0, x24
1057572a8: 94933fab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057572ac: aa1703e0    	mov	x0, x23
1057572b0: 94933fa9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057572b4: 14000021    	b	0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
1057572b8: f10002bf    	cmp	x21, #0x0
1057572bc: 7a441900    	ccmp	w8, #0x4, #0x0, ne
1057572c0: 540003c1    	b.ne	0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
1057572c4: 900d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
1057572c8: f9478901    	ldr	x1, [x8, #0xf10] ; updateMultiSelect:contact:tableView:allSelectMode:
1057572cc: aa1603e0    	mov	x0, x22
1057572d0: aa1403e2    	mov	x2, x20
1057572d4: aa1503e3    	mov	x3, x21
1057572d8: aa1303e4    	mov	x4, x19
1057572dc: 52800005    	mov	w5, #0x0                ; =0
1057572e0: 94933f97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057572e4: f00d3b88    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
1057572e8: f944c101    	ldr	x1, [x8, #0x980] ; updateRightBarBtn
1057572ec: aa1603e0    	mov	x0, x22
1057572f0: 94933f93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057572f4: f00d4d68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1057572f8: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
1057572fc: aa1303e0    	mov	x0, x19
105757300: 94933f8f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757304: f00d56a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105757308: b98b6108    	ldrsw	x8, [x8, #0xb60]
10575730c: f8686ad7    	ldr	x23, [x22, x8]
105757310: b4000157    	cbz	x23, 0x105757338 <_Flutter_MMFoundation_BindContext+0x1c32f1c>
105757314: 900d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
105757318: f9478d01    	ldr	x1, [x8, #0xf18] ; checkIfAllMemberSelected
10575731c: aa1603e0    	mov	x0, x22
105757320: 94933f87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757324: aa0003e2    	mov	x2, x0
105757328: f00d37e8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10575732c: f942a501    	ldr	x1, [x8, #0x548] ; updatePanelView:
105757330: aa1703e0    	mov	x0, x23
105757334: 94933f82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105757338: aa1503e0    	mov	x0, x21
10575733c: 94933f86    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105757340: aa1403e0    	mov	x0, x20
105757344: 94933f84    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105757348: aa1303e0    	mov	x0, x19
10575734c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
105757350: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105757354: a94257f6    	ldp	x22, x21, [sp, #0x20]
105757358: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10575735c: a8c567fa    	ldp	x26, x25, [sp], #0x50
105757360: 14933f7d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
