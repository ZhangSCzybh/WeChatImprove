
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0b965c: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
10a0b9660: a9016ffc    	stp	x28, x27, [sp, #0x10]
10a0b9664: a90267fa    	stp	x26, x25, [sp, #0x20]
10a0b9668: a9035ff8    	stp	x24, x23, [sp, #0x30]
10a0b966c: a90457f6    	stp	x22, x21, [sp, #0x40]
10a0b9670: a9054ff4    	stp	x20, x19, [sp, #0x50]
10a0b9674: a9067bfd    	stp	x29, x30, [sp, #0x60]
10a0b9678: 910183fd    	add	x29, sp, #0x60
10a0b967c: aa0003f3    	mov	x19, x0
10a0b9680: 900b5cc8    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0b9684: 52800029    	mov	w9, #0x1                ; =1
10a0b9688: 3911d109    	strb	w9, [x8, #0x474]
10a0b968c: b00aecc8    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a0b9690: f9403114    	ldr	x20, [x8, #0x60] ; footerView
10a0b9694: aa1403e1    	mov	x1, x20
10a0b9698: 955e876b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b969c: aa1d03fd    	mov	x29, x29
10a0b96a0: 955e876c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b96a4: aa0003f6    	mov	x22, x0
10a0b96a8: 900aff08    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0b96ac: f941b115    	ldr	x21, [x8, #0x360] ; m_customizedBlankView
10a0b96b0: aa1503e1    	mov	x1, x21
10a0b96b4: 955e8764    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b96b8: aa1d03fd    	mov	x29, x29
10a0b96bc: 955e8765    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b96c0: aa0003f7    	mov	x23, x0
10a0b96c4: d00b0788    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0b96c8: f941f900    	ldr	x0, [x8, #0x3f0] ; ОC
10a0b96cc: d00b0228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0b96d0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a0b96d4: 955e875c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b96d8: aa0003e2    	mov	x2, x0
10a0b96dc: d00b0248    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a0b96e0: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10a0b96e4: aa1703e0    	mov	x0, x23
10a0b96e8: 955e8757    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b96ec: aa0003f8    	mov	x24, x0
10a0b96f0: aa1703e0    	mov	x0, x23
10a0b96f4: 955e875a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b96f8: aa1603e0    	mov	x0, x22
10a0b96fc: 955e8758    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b9700: 34000ed8    	cbz	w24, 0x10a0b98d8 <_Flutter_MMFoundation_BindContext+0x65954bc>
10a0b9704: b00b0288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0b9708: f947bd17    	ldr	x23, [x8, #0xf78] ; tableView
10a0b970c: aa1303e0    	mov	x0, x19
10a0b9710: aa1703e1    	mov	x1, x23
10a0b9714: 955e874c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9718: aa1d03fd    	mov	x29, x29
10a0b971c: 955e874d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9720: aa0003f6    	mov	x22, x0
10a0b9724: b00b0248    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10a0b9728: f9449d18    	ldr	x24, [x8, #0x938] ; height
10a0b972c: aa1803e1    	mov	x1, x24
10a0b9730: 955e8745    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9734: 1e604008    	fmov	d8, d0
10a0b9738: aa1303e0    	mov	x0, x19
10a0b973c: aa1703e1    	mov	x1, x23
10a0b9740: 955e8741    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9744: aa1d03fd    	mov	x29, x29
10a0b9748: 955e8742    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b974c: aa0003f9    	mov	x25, x0
10a0b9750: b00b0228    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10a0b9754: f947c11a    	ldr	x26, [x8, #0xf80] ; adjustedContentInset
10a0b9758: aa1a03e1    	mov	x1, x26
10a0b975c: 955e873a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9760: 1e603908    	fsub	d8, d8, d0
10a0b9764: aa1303e0    	mov	x0, x19
10a0b9768: aa1703e1    	mov	x1, x23
10a0b976c: 955e8736    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9770: aa1d03fd    	mov	x29, x29
10a0b9774: 955e8737    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9778: aa0003fb    	mov	x27, x0
10a0b977c: aa1a03e1    	mov	x1, x26
10a0b9780: 955e8731    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9784: 1e623908    	fsub	d8, d8, d2
10a0b9788: aa1303e0    	mov	x0, x19
10a0b978c: aa1703e1    	mov	x1, x23
10a0b9790: 955e872d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9794: aa1d03fd    	mov	x29, x29
10a0b9798: 955e872e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b979c: aa0003f7    	mov	x23, x0
10a0b97a0: f00aec88    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
10a0b97a4: f9456d01    	ldr	x1, [x8, #0xad8] ; tableHeaderView
10a0b97a8: 955e8727    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b97ac: aa1d03fd    	mov	x29, x29
10a0b97b0: 955e8728    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b97b4: aa0003fa    	mov	x26, x0
10a0b97b8: aa1803e1    	mov	x1, x24
10a0b97bc: 955e8722    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b97c0: 1e603908    	fsub	d8, d8, d0
10a0b97c4: aa1a03e0    	mov	x0, x26
10a0b97c8: 955e8725    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b97cc: aa1703e0    	mov	x0, x23
10a0b97d0: 955e8723    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b97d4: aa1b03e0    	mov	x0, x27
10a0b97d8: 955e8721    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b97dc: aa1903e0    	mov	x0, x25
10a0b97e0: 955e871f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b97e4: aa1603e0    	mov	x0, x22
10a0b97e8: 955e871d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b97ec: 1e682900    	fadd	d0, d8, d8
10a0b97f0: 1e611001    	fmov	d1, #3.00000000
10a0b97f4: 1e611800    	fdiv	d0, d0, d1
10a0b97f8: 1e624000    	fcvt	s0, d0
10a0b97fc: 1e264000    	frinta	s0, s0
10a0b9800: 1e22c000    	fcvt	d0, s0
10a0b9804: d2e80928    	mov	x8, #0x4049000000000000 ; =4632233691727265792
10a0b9808: 9e670101    	fmov	d1, x8
10a0b980c: 1e612000    	fcmp	d0, d1
10a0b9810: 1e604c28    	fcsel	d8, d1, d0, mi
10a0b9814: aa1303e0    	mov	x0, x19
10a0b9818: aa1403e1    	mov	x1, x20
10a0b981c: 955e870a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9820: aa1d03fd    	mov	x29, x29
10a0b9824: 955e870b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b9828: aa0003f6    	mov	x22, x0
10a0b982c: aa1503e1    	mov	x1, x21
10a0b9830: 955e8705    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9834: aa1d03fd    	mov	x29, x29
10a0b9838: 955e8706    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b983c: aa0003f5    	mov	x21, x0
10a0b9840: aa1603e0    	mov	x0, x22
10a0b9844: 955e8706    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b9848: aa1303e0    	mov	x0, x19
10a0b984c: aa1403e1    	mov	x1, x20
10a0b9850: 955e86fd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9854: aa1d03fd    	mov	x29, x29
10a0b9858: 955e86fe    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0b985c: aa0003f3    	mov	x19, x0
10a0b9860: d00b0288    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0b9864: f947a501    	ldr	x1, [x8, #0xf48] ; width
10a0b9868: 955e86f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b986c: b00b0288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0b9870: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
10a0b9874: aa1503e0    	mov	x0, x21
10a0b9878: 955e86f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b987c: aa1303e0    	mov	x0, x19
10a0b9880: 955e86f7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b9884: f00b0268    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0b9888: f9410901    	ldr	x1, [x8, #0x210] ; setHeight:
10a0b988c: aa1503e0    	mov	x0, x21
10a0b9890: 1e604100    	fmov	d0, d8
10a0b9894: 955e86ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b9898: 9009a9a8    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
10a0b989c: f9410508    	ldr	x8, [x8, #0x208]
10a0b98a0: 6d400500    	ldp	d0, d1, [x8]
10a0b98a4: 900aec08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0b98a8: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
10a0b98ac: aa1503e0    	mov	x0, x21
10a0b98b0: 955e86e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0b98b4: aa1503e0    	mov	x0, x21
10a0b98b8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a0b98bc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a0b98c0: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a0b98c4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a0b98c8: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a0b98cc: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a0b98d0: 6cc723e9    	ldp	d9, d8, [sp], #0x70
10a0b98d4: 155e86e2    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0b98d8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10a0b98dc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10a0b98e0: a94457f6    	ldp	x22, x21, [sp, #0x40]
10a0b98e4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10a0b98e8: a94267fa    	ldp	x26, x25, [sp, #0x20]
10a0b98ec: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10a0b98f0: 6cc723e9    	ldp	d9, d8, [sp], #0x70
10a0b98f4: d65f03c0    	ret
