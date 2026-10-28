
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511320c: d10203ff    	sub	sp, sp, #0x80
105113210: 6d0323e9    	stp	d9, d8, [sp, #0x30]
105113214: a9045ff8    	stp	x24, x23, [sp, #0x40]
105113218: a90557f6    	stp	x22, x21, [sp, #0x50]
10511321c: a9064ff4    	stp	x20, x19, [sp, #0x60]
105113220: a9077bfd    	stp	x29, x30, [sp, #0x70]
105113224: 9101c3fd    	add	x29, sp, #0x70
105113228: aa0003f3    	mov	x19, x0
10511322c: 900dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105113230: 52800029    	mov	w9, #0x1                ; =1
105113234: 392d5d09    	strb	w9, [x8, #0xb57]
105113238: f00d8588    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
10511323c: f9406108    	ldr	x8, [x8, #0xc0] ; NewMainFrameViewController
105113240: a90223e0    	stp	x0, x8, [sp, #0x20]
105113244: b00d6948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105113248: f941a101    	ldr	x1, [x8, #0x340] ; viewDidLayoutSubviews
10511324c: 910083e0    	add	x0, sp, #0x20
105113250: 94ac4fbd    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105113254: b00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105113258: b9834918    	ldrsw	x24, [x8, #0x348]
10511325c: fc786a69    	ldr	d9, [x19, x24]
105113260: 900d7fc8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105113264: f946d514    	ldr	x20, [x8, #0xda8] ; view
105113268: aa1303e0    	mov	x0, x19
10511326c: aa1403e1    	mov	x1, x20
105113270: 94ac4fb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113274: aa1d03fd    	mov	x29, x29
105113278: 94ac4fb4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511327c: aa0003f6    	mov	x22, x0
105113280: f00d7f68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105113284: f9449d15    	ldr	x21, [x8, #0x938] ; height
105113288: aa1503e1    	mov	x1, x21
10511328c: 94ac4fac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113290: 1e604008    	fmov	d8, d0
105113294: aa1603e0    	mov	x0, x22
105113298: 94ac4faf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511329c: 1e682120    	fcmp	d9, d8
1051132a0: 540005a0    	b.eq	0x105113354 <_Flutter_MMFoundation_BindContext+0x15eef38>
1051132a4: 900d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051132a8: f9453516    	ldr	x22, [x8, #0xa68] ; iConsole
1051132ac: fc786a68    	ldr	d8, [x19, x24]
1051132b0: aa1303e0    	mov	x0, x19
1051132b4: aa1403e1    	mov	x1, x20
1051132b8: 94ac4fa1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051132bc: aa1d03fd    	mov	x29, x29
1051132c0: 94ac4fa2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051132c4: aa0003f7    	mov	x23, x0
1051132c8: aa1503e1    	mov	x1, x21
1051132cc: 94ac4f9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051132d0: d00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051132d4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1051132d8: 6d0083e8    	stp	d8, d0, [sp, #0x8]
1051132dc: b00cb608    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
1051132e0: 9114a108    	add	x8, x8, #0x528 ; CFString 'view did resize, lastScreenHeight=%f self.view.height=%f'
1051132e4: f90003e8    	str	x8, [sp]
1051132e8: b00b3a25    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
1051132ec: 9122e0a5    	add	x5, x5, #0x8b8
1051132f0: b00b3a27    	adrp	x7, 0x11b858000 <dyld_stub_binder+0x11b858000>
1051132f4: 91302ce7    	add	x7, x7, #0xc0b
1051132f8: aa1603e0    	mov	x0, x22
1051132fc: 52800042    	mov	w2, #0x2                ; =2
105113300: d2800003    	mov	x3, #0x0                ; =0
105113304: 52800004    	mov	w4, #0x0                ; =0
105113308: 52805606    	mov	w6, #0x2b0              ; =688
10511330c: 94ac4f8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113310: aa1703e0    	mov	x0, x23
105113314: 94ac4f90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113318: aa1303e0    	mov	x0, x19
10511331c: aa1403e1    	mov	x1, x20
105113320: 94ac4f87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113324: aa1d03fd    	mov	x29, x29
105113328: 94ac4f88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511332c: aa0003f4    	mov	x20, x0
105113330: aa1503e1    	mov	x1, x21
105113334: 94ac4f82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113338: fc386a60    	str	d0, [x19, x24]
10511333c: aa1403e0    	mov	x0, x20
105113340: 94ac4f85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113344: 900d6968    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105113348: f941a501    	ldr	x1, [x8, #0x348] ; viewDidTransitionToNewSize
10511334c: aa1303e0    	mov	x0, x19
105113350: 94ac4f7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113354: f00d7428    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105113358: f9460101    	ldr	x1, [x8, #0xc00] ; reLayoutSubviews
10511335c: aa1303e0    	mov	x0, x19
105113360: 94ac4f77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113364: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105113368: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10511336c: a94557f6    	ldp	x22, x21, [sp, #0x50]
105113370: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105113374: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
105113378: 910203ff    	add	sp, sp, #0x80
10511337c: d65f03c0    	ret
