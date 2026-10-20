
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10292f008: d10203ff    	sub	sp, sp, #0x80
10292f00c: a9045ff8    	stp	x24, x23, [sp, #0x40]
10292f010: a90557f6    	stp	x22, x21, [sp, #0x50]
10292f014: a9064ff4    	stp	x20, x19, [sp, #0x60]
10292f018: a9077bfd    	stp	x29, x30, [sp, #0x70]
10292f01c: 9101c3fd    	add	x29, sp, #0x70
10292f020: aa0303f3    	mov	x19, x3
10292f024: aa0203f4    	mov	x20, x2
10292f028: aa0003f5    	mov	x21, x0
10292f02c: f00f1828    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
10292f030: 52800029    	mov	w9, #0x1                ; =1
10292f034: 392b8509    	strb	w9, [x8, #0xae1]
10292f038: 900ec228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10292f03c: f9453516    	ldr	x22, [x8, #0xa68] ; class=iConsole
10292f040: 900ec238    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10292f044: f9458b00    	ldr	x0, [x24, #0xb10]
10292f048: b00ebea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10292f04c: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
10292f050: 954be03b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f054: aa1d03fd    	mov	x29, x29
10292f058: 954be03c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10292f05c: aa0003f7    	mov	x23, x0
10292f060: f9458b00    	ldr	x0, [x24, #0xb10]
10292f064: b00ebea8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10292f068: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
10292f06c: aa1303e2    	mov	x2, x19
10292f070: 954be033    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f074: aa1d03fd    	mov	x29, x29
10292f078: 954be034    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10292f07c: aa0003f8    	mov	x24, x0
10292f080: d00ea848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10292f084: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
10292f088: a90083f7    	stp	x23, x0, [sp, #0x8]
10292f08c: 900de9c8    	adrp	x8, 0x11e667000 <dyld_stub_binder+0x11e667000>
10292f090: 911a2108    	add	x8, x8, #0x688 ; cfstring='Prepare to hangup ... (%@, %@)'
10292f094: f90003e8    	str	x8, [sp]
10292f098: d00c5a83    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
10292f09c: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
10292f0a0: d00c6205    	adrp	x5, 0x11b571000 <dyld_stub_binder+0x11b571000>
10292f0a4: 9139e8a5    	add	x5, x5, #0xe7a ; cstring='MMConfSDKService.mm'
10292f0a8: 900c6227    	adrp	x7, 0x11b573000 <dyld_stub_binder+0x11b573000>
10292f0ac: 910088e7    	add	x7, x7, #0x22 ; cstring='-[MMConfSDKService hangup:isSubCall:]'
10292f0b0: aa1603e0    	mov	x0, x22
10292f0b4: 52800042    	mov	w2, #0x2                ; =2
10292f0b8: 52800004    	mov	w4, #0x0                ; =0
10292f0bc: 52815046    	mov	w6, #0xa82              ; =2690
10292f0c0: 954be01f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10292f0c4: aa1803e0    	mov	x0, x24
10292f0c8: 954be023    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10292f0cc: aa1703e0    	mov	x0, x23
10292f0d0: 954be021    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10292f0d4: d00ec688    	adrp	x8, 0x120201000 <dyld_stub_binder+0x120201000>
10292f0d8: b98d0108    	ldrsw	x8, [x8, #0xd00]
10292f0dc: f8686aa0    	ldr	x0, [x21, x8]
10292f0e0: f00d65e8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10292f0e4: f947e108    	ldr	x8, [x8, #0xfc0]
10292f0e8: f9000fe8    	str	x8, [sp, #0x18]
10292f0ec: d00b2288    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10292f0f0: fd423900    	ldr	d0, [x8, #0x470]
10292f0f4: fd0013e0    	str	d0, [sp, #0x20]
10292f0f8: 90000008    	adrp	x8, 0x10292f000 <_Flutter_Image_provideRelativePathByUrl+0xd3beb0>
10292f0fc: 9104d108    	add	x8, x8, #0x134
10292f100: f00d6829    	adrp	x9, 0x11d636000 <dyld_stub_binder+0x11d636000>
10292f104: 913de129    	add	x9, x9, #0xf78
10292f108: a902a7e8    	stp	x8, x9, [sp, #0x28]
10292f10c: b9003bf4    	str	w20, [sp, #0x38]
10292f110: 3900f3f3    	strb	w19, [sp, #0x3c]
10292f114: 910063e1    	add	x1, sp, #0x18
10292f118: 954b7842    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
10292f11c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10292f120: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10292f124: a94557f6    	ldp	x22, x21, [sp, #0x50]
10292f128: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10292f12c: 910203ff    	add	sp, sp, #0x80
10292f130: d65f03c0    	ret
