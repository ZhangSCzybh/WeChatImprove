
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1091f973c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1091f9740: a90157f6    	stp	x22, x21, [sp, #0x10]
1091f9744: a9024ff4    	stp	x20, x19, [sp, #0x20]
1091f9748: a9037bfd    	stp	x29, x30, [sp, #0x30]
1091f974c: 9100c3fd    	add	x29, sp, #0x30
1091f9750: aa0203f3    	mov	x19, x2
1091f9754: aa0003f4    	mov	x20, x0
1091f9758: b00bd2a8    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
1091f975c: 52800029    	mov	w9, #0x1                ; =1
1091f9760: 39185509    	strb	w9, [x8, #0x615]
1091f9764: aa0203e0    	mov	x0, x2
1091f9768: 95998736    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1091f976c: f00b7828    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1091f9770: f9450501    	ldr	x1, [x8, #0xa08] ; currentItem
1091f9774: aa1403e0    	mov	x0, x20
1091f9778: 95998733    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f977c: aa1d03fd    	mov	x29, x29
1091f9780: 95998734    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f9784: aa0003f5    	mov	x21, x0
1091f9788: 900b62e8    	adrp	x8, 0x11fe55000 <dyld_stub_binder+0x11fe55000>
1091f978c: f943cd01    	ldr	x1, [x8, #0x798] ; itemType
1091f9790: 9599872d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f9794: f100041f    	cmp	x0, #0x1
1091f9798: 54000521    	b.ne	0x1091f983c <_Flutter_MMFoundation_BindContext+0x56d5420>
1091f979c: 900b6388    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
1091f97a0: f9418116    	ldr	x22, [x8, #0x300] ; selectedContacts
1091f97a4: aa1503e0    	mov	x0, x21
1091f97a8: aa1603e1    	mov	x1, x22
1091f97ac: 95998726    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f97b0: aa1d03fd    	mov	x29, x29
1091f97b4: 95998727    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f97b8: aa0003f7    	mov	x23, x0
1091f97bc: b00b7868    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1091f97c0: f9408101    	ldr	x1, [x8, #0x100] ; removeAllObjects
1091f97c4: 95998720    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f97c8: aa1703e0    	mov	x0, x23
1091f97cc: 95998724    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f97d0: f00b7828    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1091f97d4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1091f97d8: aa1303e0    	mov	x0, x19
1091f97dc: 9599871a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f97e0: b40002e0    	cbz	x0, 0x1091f983c <_Flutter_MMFoundation_BindContext+0x56d5420>
1091f97e4: aa1503e0    	mov	x0, x21
1091f97e8: aa1603e1    	mov	x1, x22
1091f97ec: 95998716    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f97f0: aa1d03fd    	mov	x29, x29
1091f97f4: 95998717    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f97f8: aa0003f6    	mov	x22, x0
1091f97fc: b00b7828    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1091f9800: f947f901    	ldr	x1, [x8, #0xff0] ; allObjects
1091f9804: aa1303e0    	mov	x0, x19
1091f9808: 9599870f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f980c: aa1d03fd    	mov	x29, x29
1091f9810: 95998710    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1091f9814: aa0003f7    	mov	x23, x0
1091f9818: b00b7828    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1091f981c: f946f901    	ldr	x1, [x8, #0xdf0] ; addObjectsFromArray:
1091f9820: aa1603e0    	mov	x0, x22
1091f9824: aa1703e2    	mov	x2, x23
1091f9828: 95998707    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f982c: aa1703e0    	mov	x0, x23
1091f9830: 9599870b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f9834: aa1603e0    	mov	x0, x22
1091f9838: 95998709    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f983c: d00b6208    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1091f9840: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
1091f9844: aa1403e0    	mov	x0, x20
1091f9848: 959986ff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1091f984c: aa1503e0    	mov	x0, x21
1091f9850: 95998703    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1091f9854: aa1303e0    	mov	x0, x19
1091f9858: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1091f985c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1091f9860: a94157f6    	ldp	x22, x21, [sp, #0x10]
1091f9864: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1091f9868: 159986fd    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
