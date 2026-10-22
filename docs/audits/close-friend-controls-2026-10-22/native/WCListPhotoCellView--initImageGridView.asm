
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ff5618: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
108ff561c: a9014ff4    	stp	x20, x19, [sp, #0x10]
108ff5620: a9027bfd    	stp	x29, x30, [sp, #0x20]
108ff5624: 910083fd    	add	x29, sp, #0x20
108ff5628: aa0003f3    	mov	x19, x0
108ff562c: 900be2c8    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108ff5630: 52800029    	mov	w9, #0x1                ; =1
108ff5634: 39396d09    	strb	w9, [x8, #0xe5b]
108ff5638: f00b9368    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ff563c: b9856115    	ldrsw	x21, [x8, #0x560]
108ff5640: f8756800    	ldr	x0, [x0, x21]
108ff5644: b50003e0    	cbnz	x0, 0x108ff56c0 <_Flutter_MMFoundation_BindContext+0x54d12a4>
108ff5648: d00b8be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108ff564c: f9474d00    	ldr	x0, [x8, #0xe98]
108ff5650: 95a19786    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
108ff5654: 900a2fc8    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
108ff5658: f9416d08    	ldr	x8, [x8, #0x2d8]
108ff565c: 6d400500    	ldp	d0, d1, [x8]
108ff5660: 6d410d02    	ldp	d2, d3, [x8, #0x10]
108ff5664: b00b8868    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
108ff5668: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
108ff566c: 95a19776    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff5670: f8756a68    	ldr	x8, [x19, x21]
108ff5674: f8356a60    	str	x0, [x19, x21]
108ff5678: aa0803e0    	mov	x0, x8
108ff567c: 95a19778    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ff5680: d00b8be8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108ff5684: f9463100    	ldr	x0, [x8, #0xc60]
108ff5688: d00b8848    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108ff568c: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
108ff5690: 95a1976d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff5694: aa1d03fd    	mov	x29, x29
108ff5698: 95a1976e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ff569c: aa0003f4    	mov	x20, x0
108ff56a0: f8756a60    	ldr	x0, [x19, x21]
108ff56a4: d00b8888    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
108ff56a8: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
108ff56ac: aa1403e2    	mov	x2, x20
108ff56b0: 95a19765    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff56b4: aa1403e0    	mov	x0, x20
108ff56b8: 95a19769    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ff56bc: f8756a60    	ldr	x0, [x19, x21]
108ff56c0: d00b7228    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ff56c4: f947f901    	ldr	x1, [x8, #0xff0] ; removeAllSubViews
108ff56c8: 95a1975f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff56cc: f00b9368    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ff56d0: 91117108    	add	x8, x8, #0x45c
108ff56d4: b9800108    	ldrsw	x8, [x8]
108ff56d8: f8686a60    	ldr	x0, [x19, x8]
108ff56dc: f8756a62    	ldr	x2, [x19, x21]
108ff56e0: b00b8848    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
108ff56e4: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
108ff56e8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
108ff56ec: a9414ff4    	ldp	x20, x19, [sp, #0x10]
108ff56f0: a8c357f6    	ldp	x22, x21, [sp], #0x30
108ff56f4: 15a19754    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
