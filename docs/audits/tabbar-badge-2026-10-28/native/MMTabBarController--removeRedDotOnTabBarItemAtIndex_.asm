
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047268f8: d10103ff    	sub	sp, sp, #0x40
1047268fc: a90157f6    	stp	x22, x21, [sp, #0x10]
104726900: a9024ff4    	stp	x20, x19, [sp, #0x20]
104726904: a9037bfd    	stp	x29, x30, [sp, #0x30]
104726908: 9100c3fd    	add	x29, sp, #0x30
10472690c: aa0003f4    	mov	x20, x0
104726910: f00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104726914: 52800029    	mov	w9, #0x1                ; =1
104726918: b00dd7ca    	adrp	x10, 0x12021f000 <dyld_stub_binder+0x12021f000>
10472691c: b989ed4a    	ldrsw	x10, [x10, #0x9ec]
104726920: f86a680a    	ldr	x10, [x0, x10]
104726924: 391a0909    	strb	w9, [x8, #0x682]
104726928: b00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10472692c: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104726930: f00db888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104726934: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104726938: eb02015f    	cmp	x10, x2
10472693c: 54000769    	b.ls	0x104726a28 <_Flutter_MMFoundation_BindContext+0xc0260c>
104726940: aa0203f3    	mov	x19, x2
104726944: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104726948: 910f2108    	add	x8, x8, #0x3c8 ; CFString 'remove %lu'
10472694c: a9000be8    	stp	x8, x2, [sp]
104726950: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104726954: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104726958: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
10472695c: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104726960: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726964: 913cb0e7    	add	x7, x7, #0xf2c ; string '-[MMTabBarController removeRedDotOnTabBarItemAtIndex:]'
104726968: 52800042    	mov	w2, #0x2                ; =2
10472696c: 52800004    	mov	w4, #0x0                ; =0
104726970: 52804706    	mov	w6, #0x238              ; =568
104726974: 94d401f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726978: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10472697c: f9465501    	ldr	x1, [x8, #0xca8] ; selector getTabbarItemForIndex:
104726980: aa1403e0    	mov	x0, x20
104726984: aa1303e2    	mov	x2, x19
104726988: 94d401ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472698c: aa1d03fd    	mov	x29, x29
104726990: 94d401ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104726994: aa0003f5    	mov	x21, x0
104726998: b00db8c8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10472699c: f947a501    	ldr	x1, [x8, #0xf48] ; selector setAccessibilityValue:
1047269a0: d2800002    	mov	x2, #0x0                ; =0
1047269a4: 94d401e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047269a8: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
1047269ac: f942f101    	ldr	x1, [x8, #0x5e0] ; selector setBadgeValue:
1047269b0: aa1503e0    	mov	x0, x21
1047269b4: d2800002    	mov	x2, #0x0                ; =0
1047269b8: 94d401e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047269bc: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047269c0: f945f901    	ldr	x1, [x8, #0xbf0] ; selector customTabBar
1047269c4: aa1403e0    	mov	x0, x20
1047269c8: 94d401dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047269cc: aa1d03fd    	mov	x29, x29
1047269d0: 94d401de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047269d4: aa0003f4    	mov	x20, x0
1047269d8: b00dbd08    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
1047269dc: f9457101    	ldr	x1, [x8, #0xae0] ; selector tabBarItemViewAtIndex:
1047269e0: aa1303e2    	mov	x2, x19
1047269e4: 94d401d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047269e8: aa1d03fd    	mov	x29, x29
1047269ec: 94d401d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047269f0: aa0003f3    	mov	x19, x0
1047269f4: f00dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047269f8: f9465d01    	ldr	x1, [x8, #0xcb8] ; selector removeSmallRedDot
1047269fc: 94d401d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726a00: aa1303e0    	mov	x0, x19
104726a04: 94d401d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726a08: aa1403e0    	mov	x0, x20
104726a0c: 94d401d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726a10: aa1503e0    	mov	x0, x21
104726a14: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104726a18: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104726a1c: a94157f6    	ldp	x22, x21, [sp, #0x10]
104726a20: 910103ff    	add	sp, sp, #0x40
104726a24: 14d401cc    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104726a28: b00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104726a2c: 910da108    	add	x8, x8, #0x368 ; CFString 'Index >= view controllers count!'
104726a30: f90003e8    	str	x8, [sp]
104726a34: 900b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104726a38: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104726a3c: d00b8385    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726a40: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
104726a44: d00b8387    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104726a48: 913cb0e7    	add	x7, x7, #0xf2c ; string '-[MMTabBarController removeRedDotOnTabBarItemAtIndex:]'
104726a4c: 52800062    	mov	w2, #0x3                ; =3
104726a50: 52800004    	mov	w4, #0x0                ; =0
104726a54: 528046a6    	mov	w6, #0x235              ; =565
104726a58: 94d401b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104726a5c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104726a60: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104726a64: a94157f6    	ldp	x22, x21, [sp, #0x10]
104726a68: 910103ff    	add	sp, sp, #0x40
104726a6c: d65f03c0    	ret
