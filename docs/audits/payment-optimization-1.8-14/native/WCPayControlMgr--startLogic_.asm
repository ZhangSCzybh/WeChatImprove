
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109429204: d10203ff    	sub	sp, sp, #0x80
109429208: a9026ffc    	stp	x28, x27, [sp, #0x20]
10942920c: a90367fa    	stp	x26, x25, [sp, #0x30]
109429210: a9045ff8    	stp	x24, x23, [sp, #0x40]
109429214: a90557f6    	stp	x22, x21, [sp, #0x50]
109429218: a9064ff4    	stp	x20, x19, [sp, #0x60]
10942921c: a9077bfd    	stp	x29, x30, [sp, #0x70]
109429220: 9101c3fd    	add	x29, sp, #0x70
109429224: aa0203f3    	mov	x19, x2
109429228: aa0003f7    	mov	x23, x0
10942922c: b00bc128    	adrp	x8, 0x120c4e000 <dyld_stub_binder+0x120c4e000>
109429230: 52800029    	mov	w9, #0x1                ; =1
109429234: 3936f509    	strb	w9, [x8, #0xdbd]
109429238: d00b6a5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10942923c: f945eb54    	ldr	x20, [x26, #0xbd0] ; ��d 
109429240: f00b66a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109429244: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
109429248: aa0203e0    	mov	x0, x2
10942924c: 9590c87d    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109429250: aa1403e0    	mov	x0, x20
109429254: aa1503e1    	mov	x1, x21
109429258: 9590c87b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942925c: aa1d03fd    	mov	x29, x29
109429260: 9590c87c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109429264: aa0003f8    	mov	x24, x0
109429268: d00b6ac8    	adrp	x8, 0x120183000 <dyld_stub_binder+0x120183000>
10942926c: f9456100    	ldr	x0, [x8, #0xac0]
109429270: d00b66a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109429274: f947ad14    	ldr	x20, [x8, #0xf58] ; class
109429278: aa1403e1    	mov	x1, x20
10942927c: 9590c872    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429280: aa0003e2    	mov	x2, x0
109429284: 900b5088    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109429288: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
10942928c: aa1803e0    	mov	x0, x24
109429290: aa1603e1    	mov	x1, x22
109429294: 9590c86c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429298: aa1d03fd    	mov	x29, x29
10942929c: 9590c86d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094292a0: aa0003f9    	mov	x25, x0
1094292a4: 900b6268    	adrp	x8, 0x120075000 <dyld_stub_binder+0x120075000>
1094292a8: f9458d01    	ldr	x1, [x8, #0xb18] ; reportStartLogic:
1094292ac: aa1303e2    	mov	x2, x19
1094292b0: 9590c865    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094292b4: aa1903e0    	mov	x0, x25
1094292b8: 9590c869    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094292bc: aa1803e0    	mov	x0, x24
1094292c0: 9590c867    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094292c4: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
1094292c8: aa1503e1    	mov	x1, x21
1094292cc: 9590c85e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094292d0: aa1d03fd    	mov	x29, x29
1094292d4: 9590c85f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094292d8: aa0003f8    	mov	x24, x0
1094292dc: b00b6a7b    	adrp	x27, 0x120176000 <dyld_stub_binder+0x120176000>
1094292e0: f943bf60    	ldr	x0, [x27, #0x778] ; ��D 
1094292e4: aa1403e1    	mov	x1, x20
1094292e8: 9590c857    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094292ec: aa0003e2    	mov	x2, x0
1094292f0: aa1803e0    	mov	x0, x24
1094292f4: aa1603e1    	mov	x1, x22
1094292f8: 9590c853    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094292fc: aa1d03fd    	mov	x29, x29
109429300: 9590c854    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109429304: aa0003f9    	mov	x25, x0
109429308: 900b6268    	adrp	x8, 0x120075000 <dyld_stub_binder+0x120075000>
10942930c: f9459101    	ldr	x1, [x8, #0xb20] ; StartWCPay
109429310: 9590c84d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109429314: aa1903e0    	mov	x0, x25
109429318: 9590c851    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10942931c: aa1803e0    	mov	x0, x24
109429320: 9590c84f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429324: 900b6d48    	adrp	x8, 0x1201d1000 <dyld_stub_binder+0x1201d1000>
109429328: f947d108    	ldr	x8, [x8, #0xfa0] ; �!D 
10942932c: a90123f7    	stp	x23, x8, [sp, #0x10]
109429330: d00b5328    	adrp	x8, 0x11fe8f000 <dyld_stub_binder+0x11fe8f000>
109429334: f940b901    	ldr	x1, [x8, #0x170] ; startLogic:
109429338: 910043e0    	add	x0, sp, #0x10
10942933c: aa1303e2    	mov	x2, x19
109429340: 9590c843    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
109429344: aa0003f7    	mov	x23, x0
109429348: d00b6a48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10942934c: f9453518    	ldr	x24, [x8, #0xa68] ; �gH 
109429350: aa1303e0    	mov	x0, x19
109429354: aa1403e1    	mov	x1, x20
109429358: 9590c83b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942935c: 900b5088    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109429360: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109429364: f00aada8    	adrp	x8, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
109429368: 9100a108    	add	x8, x8, #0x28 ; CFSTR WCPayControlMgr start Logic : %@
10942936c: a90003e8    	stp	x8, x0, [sp]
109429370: f008f103    	adrp	x3, 0x11b24c000 <dyld_stub_binder+0x11b24c000>
109429374: 910fac63    	add	x3, x3, #0x3eb
109429378: 900941c5    	adrp	x5, 0x11bc61000 <dyld_stub_binder+0x11bc61000>
10942937c: 913cd4a5    	add	x5, x5, #0xf35
109429380: 900941c7    	adrp	x7, 0x11bc61000 <dyld_stub_binder+0x11bc61000>
109429384: 913d20e7    	add	x7, x7, #0xf48
109429388: aa1803e0    	mov	x0, x24
10942938c: 52800042    	mov	w2, #0x2                ; =2
109429390: 52800004    	mov	w4, #0x0                ; =0
109429394: 52801c66    	mov	w6, #0xe3               ; =227
109429398: 9590c82b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942939c: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
1094293a0: aa1503e1    	mov	x1, x21
1094293a4: 9590c828    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094293a8: aa1d03fd    	mov	x29, x29
1094293ac: 9590c829    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094293b0: aa0003f5    	mov	x21, x0
1094293b4: f943bf60    	ldr	x0, [x27, #0x778] ; ��D 
1094293b8: aa1403e1    	mov	x1, x20
1094293bc: 9590c822    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094293c0: aa0003e2    	mov	x2, x0
1094293c4: aa1503e0    	mov	x0, x21
1094293c8: aa1603e1    	mov	x1, x22
1094293cc: 9590c81e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094293d0: aa1d03fd    	mov	x29, x29
1094293d4: 9590c81f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1094293d8: aa0003f6    	mov	x22, x0
1094293dc: aa1303e0    	mov	x0, x19
1094293e0: aa1403e1    	mov	x1, x20
1094293e4: 9590c818    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1094293e8: aa0003f4    	mov	x20, x0
1094293ec: aa1303e0    	mov	x0, x19
1094293f0: 9590c81b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1094293f4: aa1403e0    	mov	x0, x20
1094293f8: 9590c826    	bl	0x10f85b490 <_UR_96F1_B25D+0x3a64100>
1094293fc: aa1d03fd    	mov	x29, x29
109429400: 9590c814    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109429404: aa0003f3    	mov	x19, x0
109429408: 900b6268    	adrp	x8, 0x120075000 <dyld_stub_binder+0x120075000>
10942940c: f9459501    	ldr	x1, [x8, #0xb28] ; setCurrentSceneValue:
109429410: aa1603e0    	mov	x0, x22
109429414: aa1303e2    	mov	x2, x19
109429418: 9590c80b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10942941c: aa1303e0    	mov	x0, x19
109429420: 9590c80f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429424: aa1603e0    	mov	x0, x22
109429428: 9590c80d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10942942c: aa1503e0    	mov	x0, x21
109429430: 9590c80b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109429434: aa1703e0    	mov	x0, x23
109429438: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10942943c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
109429440: a94557f6    	ldp	x22, x21, [sp, #0x50]
109429444: a9445ff8    	ldp	x24, x23, [sp, #0x40]
109429448: a94367fa    	ldp	x26, x25, [sp, #0x30]
10942944c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
109429450: 910203ff    	add	sp, sp, #0x80
109429454: d65f03c0    	ret