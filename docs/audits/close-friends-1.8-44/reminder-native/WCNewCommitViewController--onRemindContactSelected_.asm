
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1092a7420: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1092a7424: a9014ff4    	stp	x20, x19, [sp, #0x10]
1092a7428: a9027bfd    	stp	x29, x30, [sp, #0x20]
1092a742c: 910083fd    	add	x29, sp, #0x20
1092a7430: aa0203f3    	mov	x19, x2
1092a7434: aa0003f4    	mov	x20, x0
1092a7438: 900b6688    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
1092a743c: f942dd15    	ldr	x21, [x8, #0x5b8] ; enhanceDraftSaveController
1092a7440: aa0203e0    	mov	x0, x2
1092a7444: 9596cfff    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
1092a7448: aa1403e0    	mov	x0, x20
1092a744c: aa1503e1    	mov	x1, x21
1092a7450: 9596cffd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092a7454: aa1d03fd    	mov	x29, x29
1092a7458: 9596cffe    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1092a745c: aa0003f5    	mov	x21, x0
1092a7460: b00b6e48    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
1092a7464: f942a501    	ldr	x1, [x8, #0x548] ; setDraftRemindContactUsernames:
1092a7468: aa1303e2    	mov	x2, x19
1092a746c: 9596cff6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092a7470: aa1303e0    	mov	x0, x19
1092a7474: 9596cffa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092a7478: aa1503e0    	mov	x0, x21
1092a747c: 9596cff8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1092a7480: b00b6e48    	adrp	x8, 0x120070000 <dyld_stub_binder+0x120070000>
1092a7484: f9412901    	ldr	x1, [x8, #0x250] ; recordReportStr
1092a7488: aa1403e0    	mov	x0, x20
1092a748c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1092a7490: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1092a7494: a8c357f6    	ldp	x22, x21, [sp], #0x30
1092a7498: 1596cfeb    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
