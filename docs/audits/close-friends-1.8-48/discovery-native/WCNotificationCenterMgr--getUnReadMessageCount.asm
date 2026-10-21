
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1092bf798: d100c3ff    	sub	sp, sp, #0x30
1092bf79c: a9014ff4    	stp	x20, x19, [sp, #0x10]
1092bf7a0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1092bf7a4: 910083fd    	add	x29, sp, #0x20
1092bf7a8: aa0003f3    	mov	x19, x0
1092bf7ac: 900b7d48    	adrp	x8, 0x120267000 <dyld_stub_binder+0x120267000>
1092bf7b0: b9811514    	ldrsw	x20, [x8, #0x114]
1092bf7b4: b8746808    	ldr	w8, [x0, x20]
1092bf7b8: 36f801a8    	tbz	w8, #0x1f, 0x1092bf7ec <_Flutter_MMFoundation_BindContext+0x579b3d0>
1092bf7bc: 900b7d48    	adrp	x8, 0x120267000 <dyld_stub_binder+0x120267000>
1092bf7c0: b9811d08    	ldrsw	x8, [x8, #0x11c]
1092bf7c4: f8686a60    	ldr	x0, [x19, x8]
1092bf7c8: b00b5f68    	adrp	x8, 0x11feac000 <dyld_stub_binder+0x11feac000>
1092bf7cc: f941f901    	ldr	x1, [x8, #0x3f0] ; getUnReadMessageCount
1092bf7d0: 95966f1d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bf7d4: b8346a60    	str	w0, [x19, x20]
1092bf7d8: b00b5f08    	adrp	x8, 0x11fea0000 <dyld_stub_binder+0x11fea0000>
1092bf7dc: f947a101    	ldr	x1, [x8, #0xf40] ; saveSetting
1092bf7e0: aa1303e0    	mov	x0, x19
1092bf7e4: 95966f18    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bf7e8: b8746a68    	ldr	w8, [x19, x20]
1092bf7ec: 900b75a9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1092bf7f0: f9453520    	ldr	x0, [x9, #0xa68]
1092bf7f4: d00b5bc9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1092bf7f8: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1092bf7fc: d00a8f09    	adrp	x9, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
1092bf800: 912a2129    	add	x9, x9, #0xa88
1092bf804: a90023e9    	stp	x9, x8, [sp]
1092bf808: b008fae3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
1092bf80c: 912b2863    	add	x3, x3, #0xaca
1092bf810: d0094c65    	adrp	x5, 0x11bc4d000 <dyld_stub_binder+0x11bc4d000>
1092bf814: 912fc4a5    	add	x5, x5, #0xbf1
1092bf818: f0094c67    	adrp	x7, 0x11bc4e000 <dyld_stub_binder+0x11bc4e000>
1092bf81c: 91049ce7    	add	x7, x7, #0x127
1092bf820: 52800042    	mov	w2, #0x2                ; =2
1092bf824: 52800004    	mov	w4, #0x0                ; =0
1092bf828: 52803886    	mov	w6, #0x1c4              ; =452
1092bf82c: 95966f06    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1092bf830: b8746a60    	ldr	w0, [x19, x20]
1092bf834: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1092bf838: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1092bf83c: 9100c3ff    	add	sp, sp, #0x30
1092bf840: d65f03c0    	ret
