
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109dd32b8: d10203ff    	sub	sp, sp, #0x80
109dd32bc: 6d0323e9    	stp	d9, d8, [sp, #0x30]
109dd32c0: a9045ff8    	stp	x24, x23, [sp, #0x40]
109dd32c4: a90557f6    	stp	x22, x21, [sp, #0x50]
109dd32c8: a9064ff4    	stp	x20, x19, [sp, #0x60]
109dd32cc: a9077bfd    	stp	x29, x30, [sp, #0x70]
109dd32d0: 9101c3fd    	add	x29, sp, #0x70
109dd32d4: aa0003f3    	mov	x19, x0
109dd32d8: b00b73e8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109dd32dc: 52800029    	mov	w9, #0x1                ; =1
109dd32e0: 39267909    	strb	w9, [x8, #0x99e]
109dd32e4: d00b24e8    	adrp	x8, 0x120271000 <dyld_stub_binder+0x120271000>
109dd32e8: b9871116    	ldrsw	x22, [x8, #0x710]
109dd32ec: f8766800    	ldr	x0, [x0, x22]
109dd32f0: b5001520    	cbnz	x0, 0x109dd3594 <_Flutter_MMFoundation_BindContext+0x62af178>
109dd32f4: d00b15e8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd32f8: f9400901    	ldr	x1, [x8, #0x10] ; newTextField
109dd32fc: aa1303e0    	mov	x0, x19
109dd3300: 956a2051    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3304: f8766a68    	ldr	x8, [x19, x22]
109dd3308: f8366a60    	str	x0, [x19, x22]
109dd330c: aa0803e0    	mov	x0, x8
109dd3310: 956a2053    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd3314: f8766a60    	ldr	x0, [x19, x22]
109dd3318: 900b19a8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
109dd331c: f942c101    	ldr	x1, [x8, #0x580] ; setClearButtonMode:
109dd3320: d2800002    	mov	x2, #0x0                ; =0
109dd3324: 956a2048    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3328: f8766a60    	ldr	x0, [x19, x22]
109dd332c: d00b0348    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
109dd3330: f940a901    	ldr	x1, [x8, #0x150] ; setReturnKeyType:
109dd3334: 528000c2    	mov	w2, #0x6                ; =6
109dd3338: 956a2043    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd333c: f8766a60    	ldr	x0, [x19, x22]
109dd3340: f00b0548    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109dd3344: f945ed01    	ldr	x1, [x8, #0xbd8] ; setAutocorrectionType:
109dd3348: 52800022    	mov	w2, #0x1                ; =1
109dd334c: 956a203e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3350: f8766a60    	ldr	x0, [x19, x22]
109dd3354: d00b0568    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
109dd3358: f9468101    	ldr	x1, [x8, #0xd00] ; setAutocapitalizationType:
109dd335c: d2800002    	mov	x2, #0x0                ; =0
109dd3360: 956a2039    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3364: 9009c0c8    	adrp	x8, 0x11d5eb000 <dyld_stub_binder+0x11d5eb000>
109dd3368: f947d108    	ldr	x8, [x8, #0xfa0]
109dd336c: f9400102    	ldr	x2, [x8]
109dd3370: f8766a60    	ldr	x0, [x19, x22]
109dd3374: f00b1988    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109dd3378: f946c101    	ldr	x1, [x8, #0xd80] ; setAccessibilityTraits:
109dd337c: 956a2032    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3380: 900b1d08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109dd3384: f9462d00    	ldr	x0, [x8, #0xc58]
109dd3388: 900b1988    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109dd338c: f9462901    	ldr	x1, [x8, #0xc50] ; labelColor
109dd3390: 956a202d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3394: aa1d03fd    	mov	x29, x29
109dd3398: 956a202e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd339c: aa0003f4    	mov	x20, x0
109dd33a0: f8766a60    	ldr	x0, [x19, x22]
109dd33a4: d00b19a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109dd33a8: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
109dd33ac: aa1403e2    	mov	x2, x20
109dd33b0: 956a2025    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd33b4: aa1403e0    	mov	x0, x20
109dd33b8: 956a2029    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd33bc: 900b1d17    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
109dd33c0: f9461af4    	ldr	x20, [x23, #0xc30]
109dd33c4: b00b06a8    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
109dd33c8: f9436915    	ldr	x21, [x8, #0x6d0] ; dynamicFontSize:maxScale:
109dd33cc: d0077d68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
109dd33d0: fd433108    	ldr	d8, [x8, #0x660]
109dd33d4: 1e663000    	fmov	d0, #17.00000000
109dd33d8: aa1403e0    	mov	x0, x20
109dd33dc: aa1503e1    	mov	x1, x21
109dd33e0: 1e604101    	fmov	d1, d8
109dd33e4: 956a2018    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd33e8: f00b19a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109dd33ec: f9479101    	ldr	x1, [x8, #0xf20] ; systemFontOfSize:
109dd33f0: aa1403e0    	mov	x0, x20
109dd33f4: 956a2014    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd33f8: aa1d03fd    	mov	x29, x29
109dd33fc: 956a2015    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd3400: aa0003f4    	mov	x20, x0
109dd3404: f8766a60    	ldr	x0, [x19, x22]
109dd3408: b00b19a8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
109dd340c: f9400501    	ldr	x1, [x8, #0x8] ; setFont:
109dd3410: aa1403e2    	mov	x2, x20
109dd3414: 956a200c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3418: aa1403e0    	mov	x0, x20
109dd341c: 956a2010    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd3420: f9461ae0    	ldr	x0, [x23, #0xc30]
109dd3424: 1e663000    	fmov	d0, #17.00000000
109dd3428: aa1503e1    	mov	x1, x21
109dd342c: 1e604101    	fmov	d1, d8
109dd3430: 956a2005    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3434: f8766a60    	ldr	x0, [x19, x22]
109dd3438: d00b0d08    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
109dd343c: f946e901    	ldr	x1, [x8, #0xdd0] ; setTipsLabelFontSize:
109dd3440: 956a2001    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3444: f8766a60    	ldr	x0, [x19, x22]
109dd3448: 900b06c8    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
109dd344c: f9466d01    	ldr	x1, [x8, #0xcd8] ; setHorizontalFlexablePriority:
109dd3450: 1e249000    	fmov	s0, #10.00000000
109dd3454: 956a1ffc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3458: f8766a60    	ldr	x0, [x19, x22]
109dd345c: f00b0568    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
109dd3460: f942a103    	ldr	x3, [x8, #0x540] ; onTextFieldChanged:
109dd3464: f00b1948    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
109dd3468: f9477114    	ldr	x20, [x8, #0xee0] ; addTarget:action:forControlEvents:
109dd346c: aa1403e1    	mov	x1, x20
109dd3470: aa1303e2    	mov	x2, x19
109dd3474: 52a00044    	mov	w4, #0x20000            ; =131072
109dd3478: 956a1ff3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd347c: f8766a60    	ldr	x0, [x19, x22]
109dd3480: d00b15e8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd3484: f9400d03    	ldr	x3, [x8, #0x18] ; onTextFieldEditingDidBegin:
109dd3488: aa1403e1    	mov	x1, x20
109dd348c: aa1303e2    	mov	x2, x19
109dd3490: 52a00024    	mov	w4, #0x10000            ; =65536
109dd3494: 956a1fec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3498: f8766a60    	ldr	x0, [x19, x22]
109dd349c: d00b15e8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd34a0: f9401103    	ldr	x3, [x8, #0x20] ; onTextFieldEditingDidEnd:
109dd34a4: aa1403e1    	mov	x1, x20
109dd34a8: aa1303e2    	mov	x2, x19
109dd34ac: 52a00084    	mov	w4, #0x40000            ; =262144
109dd34b0: 956a1fe5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd34b4: f8766a74    	ldr	x20, [x19, x22]
109dd34b8: d00b15e8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd34bc: f9401501    	ldr	x1, [x8, #0x28] ; inputAccessoryViewController
109dd34c0: aa1303e0    	mov	x0, x19
109dd34c4: 956a1fe0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd34c8: aa1d03fd    	mov	x29, x29
109dd34cc: 956a1fe1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd34d0: aa0003f5    	mov	x21, x0
109dd34d4: d00b15e8    	adrp	x8, 0x120091000 <dyld_stub_binder+0x120091000>
109dd34d8: f9401901    	ldr	x1, [x8, #0x30] ; setInputAccessoryViewController:
109dd34dc: aa1403e0    	mov	x0, x20
109dd34e0: aa1503e2    	mov	x2, x21
109dd34e4: 956a1fd8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd34e8: aa1503e0    	mov	x0, x21
109dd34ec: 956a1fdc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd34f0: 9100a3e0    	add	x0, sp, #0x28
109dd34f4: aa1303e1    	mov	x1, x19
109dd34f8: 956a1fdf    	bl	0x10f85b474 <_UR_96F1_B25D+0x3a640e4>
109dd34fc: f00b0548    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
109dd3500: f945e501    	ldr	x1, [x8, #0xbc8] ; textField
109dd3504: aa1303e0    	mov	x0, x19
109dd3508: 956a1fcf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd350c: aa1d03fd    	mov	x29, x29
109dd3510: 956a1fd0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109dd3514: aa0003f4    	mov	x20, x0
109dd3518: f009c0c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
109dd351c: f947e108    	ldr	x8, [x8, #0xfc0]
109dd3520: f90003e8    	str	x8, [sp]
109dd3524: d0077d68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
109dd3528: fd41c100    	ldr	d0, [x8, #0x380]
109dd352c: 90000008    	adrp	x8, 0x109dd3000 <_Flutter_MMFoundation_BindContext+0x62aebe4>
109dd3530: 9116c108    	add	x8, x8, #0x5b0
109dd3534: fd0007e0    	str	d0, [sp, #0x8]
109dd3538: f009c7a9    	adrp	x9, 0x11d6ca000 <dyld_stub_binder+0x11d6ca000>
109dd353c: 91184129    	add	x9, x9, #0x610
109dd3540: a90127e8    	stp	x8, x9, [sp, #0x10]
109dd3544: 910003f5    	mov	x21, sp
109dd3548: 910082a0    	add	x0, x21, #0x20
109dd354c: 9100a3e1    	add	x1, sp, #0x28
109dd3550: 956a1fcc    	bl	0x10f85b480 <_UR_96F1_B25D+0x3a640f0>
109dd3554: f00b03a8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
109dd3558: f9400d01    	ldr	x1, [x8, #0x18] ; Observe:keyPath:options:block:
109dd355c: d00a38c3    	adrp	x3, 0x11e4ed000 <dyld_stub_binder+0x11e4ed000>
109dd3560: 91342063    	add	x3, x3, #0xd08
109dd3564: 910003e5    	mov	x5, sp
109dd3568: aa1303e0    	mov	x0, x19
109dd356c: aa1403e2    	mov	x2, x20
109dd3570: 528000a4    	mov	w4, #0x5                ; =5
109dd3574: 956a1fb4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109dd3578: aa1403e0    	mov	x0, x20
109dd357c: 956a1fb8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109dd3580: 910082a0    	add	x0, x21, #0x20
109dd3584: 956a1fc5    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
109dd3588: 9100a3e0    	add	x0, sp, #0x28
109dd358c: 956a1fc3    	bl	0x10f85b498 <_UR_96F1_B25D+0x3a64108>
109dd3590: f8766a60    	ldr	x0, [x19, x22]
109dd3594: a9477bfd    	ldp	x29, x30, [sp, #0x70]
109dd3598: a9464ff4    	ldp	x20, x19, [sp, #0x60]
109dd359c: a94557f6    	ldp	x22, x21, [sp, #0x50]
109dd35a0: a9445ff8    	ldp	x24, x23, [sp, #0x40]
109dd35a4: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
109dd35a8: 910203ff    	add	sp, sp, #0x80
109dd35ac: 156a1faa    	b	0x10f85b454 <_UR_96F1_B25D+0x3a640c4>
