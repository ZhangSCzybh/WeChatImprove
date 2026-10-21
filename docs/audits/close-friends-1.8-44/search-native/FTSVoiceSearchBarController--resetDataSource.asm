
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10182a6d0: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10182a6d4: a90167fa    	stp	x26, x25, [sp, #0x10]
10182a6d8: a9025ff8    	stp	x24, x23, [sp, #0x20]
10182a6dc: a90357f6    	stp	x22, x21, [sp, #0x30]
10182a6e0: a9044ff4    	stp	x20, x19, [sp, #0x40]
10182a6e4: a9057bfd    	stp	x29, x30, [sp, #0x50]
10182a6e8: 910143fd    	add	x29, sp, #0x50
10182a6ec: aa0003f3    	mov	x19, x0
10182a6f0: 900fa048    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
10182a6f4: 52800029    	mov	w9, #0x1                ; =1
10182a6f8: 392ce909    	strb	w9, [x8, #0xb3a]
10182a6fc: b00f4aa8    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
10182a700: f943ed00    	ldr	x0, [x8, #0x7d8]
10182a704: d00f46c8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10182a708: f9461d01    	ldr	x1, [x8, #0xc38] ; new
10182a70c: 958ff28c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a710: aa0003f4    	mov	x20, x0
10182a714: b00f4a5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10182a718: f945eb40    	ldr	x0, [x26, #0xbd0]
10182a71c: d00f46a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10182a720: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
10182a724: aa1503e1    	mov	x1, x21
10182a728: 958ff285    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a72c: aa1d03fd    	mov	x29, x29
10182a730: 958ff286    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a734: aa0003f8    	mov	x24, x0
10182a738: b00f4a5b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10182a73c: f9477360    	ldr	x0, [x27, #0xee0]
10182a740: b00f46a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10182a744: f947ad16    	ldr	x22, [x8, #0xf58] ; class
10182a748: aa1603e1    	mov	x1, x22
10182a74c: 958ff27c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a750: aa0003e2    	mov	x2, x0
10182a754: f00f3068    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10182a758: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
10182a75c: aa1803e0    	mov	x0, x24
10182a760: aa1703e1    	mov	x1, x23
10182a764: 958ff276    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a768: aa1d03fd    	mov	x29, x29
10182a76c: 958ff277    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a770: aa0003f9    	mov	x25, x0
10182a774: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a778: f9423501    	ldr	x1, [x8, #0x468] ; isOpenWeAppSearch
10182a77c: 958ff270    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a780: aa0003e2    	mov	x2, x0
10182a784: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a788: f945a901    	ldr	x1, [x8, #0xb50] ; setEnableWeAppSearch:
10182a78c: aa1403e0    	mov	x0, x20
10182a790: 958ff26b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a794: aa1903e0    	mov	x0, x25
10182a798: 958ff26f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a79c: aa1803e0    	mov	x0, x24
10182a7a0: 958ff26d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a7a4: d00f4a48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10182a7a8: f940e500    	ldr	x0, [x8, #0x1c8]
10182a7ac: d00f33e8    	adrp	x8, 0x11fea8000 <dyld_stub_binder+0x11fea8000>
10182a7b0: f947dd01    	ldr	x1, [x8, #0xfb8] ; FTSWebSearchEntryOn
10182a7b4: 958ff262    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a7b8: aa0003e2    	mov	x2, x0
10182a7bc: f00f33a8    	adrp	x8, 0x11fea1000 <dyld_stub_binder+0x11fea1000>
10182a7c0: f9449101    	ldr	x1, [x8, #0x920] ; setEnableWebSearch:
10182a7c4: aa1403e0    	mov	x0, x20
10182a7c8: 958ff25d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a7cc: 900f3208    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
10182a7d0: f940d501    	ldr	x1, [x8, #0x1a8] ; page
10182a7d4: aa1303e0    	mov	x0, x19
10182a7d8: 958ff259    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a7dc: aa1d03fd    	mov	x29, x29
10182a7e0: 958ff25a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a7e4: aa0003f8    	mov	x24, x0
10182a7e8: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a7ec: f945ad01    	ldr	x1, [x8, #0xb58] ; checkBoxSelected
10182a7f0: 958ff253    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a7f4: aa0003e2    	mov	x2, x0
10182a7f8: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a7fc: f945b101    	ldr	x1, [x8, #0xb60] ; setEnableOnlyWebSearch:
10182a800: aa1403e0    	mov	x0, x20
10182a804: 958ff24e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a808: aa1803e0    	mov	x0, x24
10182a80c: 958ff252    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a810: f945eb40    	ldr	x0, [x26, #0xbd0]
10182a814: aa1503e1    	mov	x1, x21
10182a818: 958ff249    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a81c: aa1d03fd    	mov	x29, x29
10182a820: 958ff24a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a824: aa0003f5    	mov	x21, x0
10182a828: f9477360    	ldr	x0, [x27, #0xee0]
10182a82c: aa1603e1    	mov	x1, x22
10182a830: 958ff243    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a834: aa0003e2    	mov	x2, x0
10182a838: aa1503e0    	mov	x0, x21
10182a83c: aa1703e1    	mov	x1, x23
10182a840: 958ff23f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a844: aa1d03fd    	mov	x29, x29
10182a848: 958ff240    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10182a84c: aa0003f6    	mov	x22, x0
10182a850: 900f3408    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
10182a854: f946f901    	ldr	x1, [x8, #0xdf0] ; isOpenSettingSearch
10182a858: 958ff239    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a85c: aa0003e2    	mov	x2, x0
10182a860: b00f3408    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
10182a864: f945b501    	ldr	x1, [x8, #0xb68] ; setEnableSetting:
10182a868: aa1403e0    	mov	x0, x20
10182a86c: 958ff234    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a870: aa1603e0    	mov	x0, x22
10182a874: 958ff238    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a878: aa1503e0    	mov	x0, x21
10182a87c: 958ff236    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a880: b00f4aa8    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
10182a884: f943f100    	ldr	x0, [x8, #0x7e0]
10182a888: 958ff236    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10182a88c: 900f3248    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
10182a890: f9467501    	ldr	x1, [x8, #0xce8] ; initWithDelegate:config:
10182a894: aa1303e2    	mov	x2, x19
10182a898: aa1403e3    	mov	x3, x20
10182a89c: 958ff228    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10182a8a0: f9406268    	ldr	x8, [x19, #0xc0]
10182a8a4: f9006260    	str	x0, [x19, #0xc0]
10182a8a8: aa0803e0    	mov	x0, x8
10182a8ac: 958ff22a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10182a8b0: aa1403e0    	mov	x0, x20
10182a8b4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10182a8b8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10182a8bc: a94357f6    	ldp	x22, x21, [sp, #0x30]
10182a8c0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10182a8c4: a94167fa    	ldp	x26, x25, [sp, #0x10]
10182a8c8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10182a8cc: 158ff222    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
