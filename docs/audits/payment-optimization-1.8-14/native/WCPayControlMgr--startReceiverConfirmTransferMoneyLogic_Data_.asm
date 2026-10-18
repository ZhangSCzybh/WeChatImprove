
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1094328e4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1094328e8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1094328ec: a9027bfd    	stp	x29, x30, [sp, #0x20]
1094328f0: 910083fd    	add	x29, sp, #0x20
1094328f4: aa0303f3    	mov	x19, x3
1094328f8: aa0203f4    	mov	x20, x2
1094328fc: aa0003f5    	mov	x21, x0
109432900: d00b6ba8    	adrp	x8, 0x1201a8000 <dyld_stub_binder+0x1201a8000>
109432904: f9423d16    	ldr	x22, [x8, #0x478]
109432908: aa0303e0    	mov	x0, x3
10943290c: 9590a2cd    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109432910: aa1403e0    	mov	x0, x20
109432914: 9590a2cb    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109432918: aa1603e0    	mov	x0, x22
10943291c: 9590a2d3    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
109432920: 900b6688    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
109432924: f9478d01    	ldr	x1, [x8, #0xf18] ; initWithData:
109432928: aa1303e2    	mov	x2, x19
10943292c: 9590a2c6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109432930: aa0003f6    	mov	x22, x0
109432934: aa1303e0    	mov	x0, x19
109432938: 9590a2c9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10943293c: d00b50e8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
109432940: f9450d01    	ldr	x1, [x8, #0xa18] ; setRootViewControllerDelegate:
109432944: aa1603e0    	mov	x0, x22
109432948: aa1403e2    	mov	x2, x20
10943294c: 9590a2be    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109432950: aa1403e0    	mov	x0, x20
109432954: 9590a2c2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109432958: b00b52e8    	adrp	x8, 0x11fe8f000 <dyld_stub_binder+0x11fe8f000>
10943295c: f940b901    	ldr	x1, [x8, #0x170] ; startLogic:
109432960: aa1503e0    	mov	x0, x21
109432964: aa1603e2    	mov	x2, x22
109432968: 9590a2b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10943296c: 900b9508    	adrp	x8, 0x1206d2000 <dyld_stub_binder+0x1206d2000>
109432970: 91366108    	add	x8, x8, #0xd98 ; CFSTR WCCommentImageHelperDelegate
109432974: b9400113    	ldr	w19, [x8]
109432978: aa1603e0    	mov	x0, x22
10943297c: 9590a2b8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109432980: aa1303e0    	mov	x0, x19
109432984: a9427bfd    	ldp	x29, x30, [sp, #0x20]
109432988: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10943298c: a8c357f6    	ldp	x22, x21, [sp], #0x30
109432990: d65f03c0    	ret