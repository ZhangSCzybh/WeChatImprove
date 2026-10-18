
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109429864: d10103ff    	sub	sp, sp, #0x40
109429868: a90157f6    	stp	x22, x21, [sp, #0x10]
10942986c: a9024ff4    	stp	x20, x19, [sp, #0x20]
109429870: a9037bfd    	stp	x29, x30, [sp, #0x30]
109429874: 9100c3fd    	add	x29, sp, #0x30
109429878: aa0003f3    	mov	x19, x0
10942987c: b00bc128    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
109429880: 52800029    	mov	w9, #0x1                ; =1
109429884: 39370109    	strb	w9, [x8, #0xdc0]
109429888: 900b6d48    	adrp	x8, 0x1201d1000 <dyld_stub_binder+0x1201d1000>
10942988c: f947d108    	ldr	x8, [x8, #0xfa0] ; �!D 
109429890: a90023e0    	stp	x0, x8, [sp]
109429894: f00b5a28    	adrp	x8, 0x11ff70000 <dyld_stub_binder+0x11ff70000>
109429898: f944d101    	ldr	x1, [x8, #0x9a0] ; stopLogic:
10942989c: 910003e0    	mov	x0, sp
1094298a0: 9590c6eb    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
1094298a4: b00b70c8    	adrp	x8, 0x120242000 <dyld_stub_binder+0x120242000>
1094298a8: 910e6108    	add	x8, x8, #0x398
1094298ac: b9800108    	ldrsw	x8, [x8]
1094298b0: f8686a60    	ldr	x0, [x19, x8]
1094298b4: d00b66c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1094298b8: f9466101    	ldr	x1, [x8, #0xcc0] ; lastObject
1094298bc: 9590c6e2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094298c0: aa1d03fd    	mov	x29, x29
1094298c4: 9590c6e3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094298c8: aa0003f3    	mov	x19, x0
1094298cc: d00b6a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1094298d0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1094298d4: f00b66a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1094298d8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1094298dc: 9590c6da    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094298e0: aa1d03fd    	mov	x29, x29
1094298e4: 9590c6db    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094298e8: aa0003f4    	mov	x20, x0
1094298ec: b00b6a68    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1094298f0: f943bd00    	ldr	x0, [x8, #0x778] ; ��D 
1094298f4: d00b66a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1094298f8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
1094298fc: aa1603e1    	mov	x1, x22
109429900: 9590c6d1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429904: aa0003e2    	mov	x2, x0
109429908: 900b5088    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10942990c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
109429910: aa1403e0    	mov	x0, x20
109429914: 9590c6cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429918: aa1d03fd    	mov	x29, x29
10942991c: 9590c6cd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109429920: aa0003f5    	mov	x21, x0
109429924: b4000213    	cbz	x19, 0x109429964 <_Flutter_MMFoundation_BindContext+0x5905548>
109429928: aa1303e0    	mov	x0, x19
10942992c: aa1603e1    	mov	x1, x22
109429930: 9590c6c5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429934: 9590c6d7    	bl	0x10f85b490 <_UR_96F1_B25D+0x3a64100>
109429938: aa1d03fd    	mov	x29, x29
10942993c: 9590c6c5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109429940: aa0003f6    	mov	x22, x0
109429944: 900b6268    	adrp	x8, 0x120075000 <dyld_stub_binder+0x120075000>
109429948: f9459501    	ldr	x1, [x8, #0xb28] ; setCurrentSceneValue:
10942994c: aa1503e0    	mov	x0, x21
109429950: aa1603e2    	mov	x2, x22
109429954: 9590c6bc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429958: aa1603e0    	mov	x0, x22
10942995c: 9590c6c0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429960: 14000006    	b	0x109429978 <_Flutter_MMFoundation_BindContext+0x590555c>
109429964: 900b6268    	adrp	x8, 0x120075000 <dyld_stub_binder+0x120075000>
109429968: f9459501    	ldr	x1, [x8, #0xb28] ; setCurrentSceneValue:
10942996c: aa1503e0    	mov	x0, x21
109429970: d2800002    	mov	x2, #0x0                ; =0
109429974: 9590c6b4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429978: aa1503e0    	mov	x0, x21
10942997c: 9590c6b8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429980: aa1403e0    	mov	x0, x20
109429984: 9590c6b6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429988: aa1303e0    	mov	x0, x19
10942998c: 9590c6b4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429990: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109429994: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109429998: a94157f6    	ldp	x22, x21, [sp, #0x10]
10942999c: 910103ff    	add	sp, sp, #0x40
1094299a0: d65f03c0    	ret