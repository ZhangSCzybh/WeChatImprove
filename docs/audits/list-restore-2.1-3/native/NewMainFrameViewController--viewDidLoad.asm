
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511a05c: d10303ff    	sub	sp, sp, #0xc0
10511a060: a9085ff8    	stp	x24, x23, [sp, #0x80]
10511a064: a90957f6    	stp	x22, x21, [sp, #0x90]
10511a068: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
10511a06c: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
10511a070: 9102c3fd    	add	x29, sp, #0xb0
10511a074: aa0003f3    	mov	x19, x0
10511a078: b00dd928    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10511a07c: 52800029    	mov	w9, #0x1                ; =1
10511a080: 392dbd09    	strb	w9, [x8, #0xb6f]
10511a084: d00d8868    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511a088: b9836d08    	ldrsw	x8, [x8, #0x36c]
10511a08c: 38686808    	ldrb	w8, [x0, x8]
10511a090: 370000a8    	tbnz	w8, #0x0, 0x10511a0a4 <_Flutter_MMFoundation_BindContext+0x15f5c88>
10511a094: 52800040    	mov	w0, #0x2                ; =2
10511a098: 528000e1    	mov	w1, #0x7                ; =7
10511a09c: d2800002    	mov	x2, #0x0                ; =0
10511a0a0: 97d30e7e    	bl	0x1045dda98 <_Flutter_MMFoundation_BindContext+0xab967c>
10511a0a4: 900d8568    	adrp	x8, 0x1201c6000 <dyld_stub_binder+0x1201c6000>
10511a0a8: f9406108    	ldr	x8, [x8, #0xc0] ; NewMainFrameViewController
10511a0ac: a93c23b3    	stp	x19, x8, [x29, #-0x40]
10511a0b0: d00d6908    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511a0b4: f941a901    	ldr	x1, [x8, #0x350] ; viewDidLoad
10511a0b8: d10103a0    	sub	x0, x29, #0x40
10511a0bc: 94ac3422    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10511a0c0: f00b39f4    	adrp	x20, 0x11b859000 <dyld_stub_binder+0x11b859000>
10511a0c4: 911a2694    	add	x20, x20, #0x689
10511a0c8: b00b09a2    	adrp	x2, 0x11b24f000 <dyld_stub_binder+0x11b24f000>
10511a0cc: 911c9442    	add	x2, x2, #0x725
10511a0d0: 910103e0    	add	x0, sp, #0x40
10511a0d4: aa1403e1    	mov	x1, x20
10511a0d8: d2800003    	mov	x3, #0x0                ; =0
10511a0dc: 94abcc5f    	bl	0x107c0d258 <_Flutter_MMFoundation_BindContext+0x40e8e3c>
10511a0e0: 900d7f48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10511a0e4: f9468101    	ldr	x1, [x8, #0xd00] ; initData
10511a0e8: aa1303e0    	mov	x0, x19
10511a0ec: 94ac3414    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a0f0: 910103e0    	add	x0, sp, #0x40
10511a0f4: 94abcc5a    	bl	0x107c0d25c <_Flutter_MMFoundation_BindContext+0x40e8e40>
10511a0f8: b00b09a2    	adrp	x2, 0x11b24f000 <dyld_stub_binder+0x11b24f000>
10511a0fc: 911cb842    	add	x2, x2, #0x72e
10511a100: 910043e0    	add	x0, sp, #0x10
10511a104: aa1403e1    	mov	x1, x20
10511a108: d2800003    	mov	x3, #0x0                ; =0
10511a10c: 94abcc53    	bl	0x107c0d258 <_Flutter_MMFoundation_BindContext+0x40e8e3c>
10511a110: d00d6908    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10511a114: f941b101    	ldr	x1, [x8, #0x360] ; initView
10511a118: aa1303e0    	mov	x0, x19
10511a11c: 94ac3408    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a120: 910043e0    	add	x0, sp, #0x10
10511a124: 94abcc4e    	bl	0x107c0d25c <_Flutter_MMFoundation_BindContext+0x40e8e40>
10511a128: 900d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511a12c: f9478501    	ldr	x1, [x8, #0xf08] ; tryDoLazyInitThing
10511a130: aa1303e0    	mov	x0, x19
10511a134: 94ac3402    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a138: b00d82d7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10511a13c: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a140: d00d7f28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10511a144: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
10511a148: aa1403e1    	mov	x1, x20
10511a14c: 94ac33fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a150: aa1d03fd    	mov	x29, x29
10511a154: 94ac33fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a158: aa0003f6    	mov	x22, x0
10511a15c: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a160: f9473902    	ldr	x2, [x8, #0xe70]
10511a164: 900d6908    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10511a168: f940a115    	ldr	x21, [x8, #0x140] ; registerExtension:withTarget:
10511a16c: aa1503e1    	mov	x1, x21
10511a170: aa1303e3    	mov	x3, x19
10511a174: 94ac33f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a178: aa1603e0    	mov	x0, x22
10511a17c: 94ac33f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a180: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a184: aa1403e1    	mov	x1, x20
10511a188: 94ac33ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a18c: aa1d03fd    	mov	x29, x29
10511a190: 94ac33ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a194: aa0003f6    	mov	x22, x0
10511a198: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a19c: f9456102    	ldr	x2, [x8, #0xac0]
10511a1a0: aa1503e1    	mov	x1, x21
10511a1a4: aa1303e3    	mov	x3, x19
10511a1a8: 94ac33e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a1ac: aa1603e0    	mov	x0, x22
10511a1b0: 94ac33e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a1b4: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a1b8: aa1403e1    	mov	x1, x20
10511a1bc: 94ac33e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a1c0: aa1d03fd    	mov	x29, x29
10511a1c4: 94ac33e1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a1c8: aa0003f6    	mov	x22, x0
10511a1cc: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a1d0: f9465902    	ldr	x2, [x8, #0xcb0]
10511a1d4: aa1503e1    	mov	x1, x21
10511a1d8: aa1303e3    	mov	x3, x19
10511a1dc: 94ac33d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a1e0: aa1603e0    	mov	x0, x22
10511a1e4: 94ac33dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a1e8: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a1ec: aa1403e1    	mov	x1, x20
10511a1f0: 94ac33d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a1f4: aa1d03fd    	mov	x29, x29
10511a1f8: 94ac33d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a1fc: aa0003f6    	mov	x22, x0
10511a200: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a204: f9458d02    	ldr	x2, [x8, #0xb18]
10511a208: aa1503e1    	mov	x1, x21
10511a20c: aa1303e3    	mov	x3, x19
10511a210: 94ac33cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a214: aa1603e0    	mov	x0, x22
10511a218: 94ac33cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a21c: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a220: aa1403e1    	mov	x1, x20
10511a224: 94ac33c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a228: aa1d03fd    	mov	x29, x29
10511a22c: 94ac33c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a230: aa0003f6    	mov	x22, x0
10511a234: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a238: f945c102    	ldr	x2, [x8, #0xb80]
10511a23c: aa1503e1    	mov	x1, x21
10511a240: aa1303e3    	mov	x3, x19
10511a244: 94ac33be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a248: aa1603e0    	mov	x0, x22
10511a24c: 94ac33c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a250: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a254: aa1403e1    	mov	x1, x20
10511a258: 94ac33b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a25c: aa1d03fd    	mov	x29, x29
10511a260: 94ac33ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a264: aa0003f6    	mov	x22, x0
10511a268: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a26c: f9460502    	ldr	x2, [x8, #0xc08]
10511a270: aa1503e1    	mov	x1, x21
10511a274: aa1303e3    	mov	x3, x19
10511a278: 94ac33b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a27c: aa1603e0    	mov	x0, x22
10511a280: 94ac33b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a284: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a288: aa1403e1    	mov	x1, x20
10511a28c: 94ac33ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a290: aa1d03fd    	mov	x29, x29
10511a294: 94ac33ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a298: aa0003f6    	mov	x22, x0
10511a29c: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a2a0: f945f102    	ldr	x2, [x8, #0xbe0]
10511a2a4: aa1503e1    	mov	x1, x21
10511a2a8: aa1303e3    	mov	x3, x19
10511a2ac: 94ac33a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a2b0: aa1603e0    	mov	x0, x22
10511a2b4: 94ac33a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a2b8: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a2bc: aa1403e1    	mov	x1, x20
10511a2c0: 94ac339f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a2c4: aa1d03fd    	mov	x29, x29
10511a2c8: 94ac33a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a2cc: aa0003f6    	mov	x22, x0
10511a2d0: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a2d4: f946f502    	ldr	x2, [x8, #0xde8]
10511a2d8: aa1503e1    	mov	x1, x21
10511a2dc: aa1303e3    	mov	x3, x19
10511a2e0: 94ac3397    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a2e4: aa1603e0    	mov	x0, x22
10511a2e8: 94ac339b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a2ec: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a2f0: aa1403e1    	mov	x1, x20
10511a2f4: 94ac3392    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a2f8: aa1d03fd    	mov	x29, x29
10511a2fc: 94ac3393    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a300: aa0003f6    	mov	x22, x0
10511a304: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a308: f945dd02    	ldr	x2, [x8, #0xbb8]
10511a30c: aa1503e1    	mov	x1, x21
10511a310: aa1303e3    	mov	x3, x19
10511a314: 94ac338a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a318: aa1603e0    	mov	x0, x22
10511a31c: 94ac338e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a320: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a324: aa1403e1    	mov	x1, x20
10511a328: 94ac3385    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a32c: aa1d03fd    	mov	x29, x29
10511a330: 94ac3386    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a334: aa0003f6    	mov	x22, x0
10511a338: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a33c: f9469902    	ldr	x2, [x8, #0xd30]
10511a340: aa1503e1    	mov	x1, x21
10511a344: aa1303e3    	mov	x3, x19
10511a348: 94ac337d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a34c: aa1603e0    	mov	x0, x22
10511a350: 94ac3381    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a354: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a358: aa1403e1    	mov	x1, x20
10511a35c: 94ac3378    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a360: aa1d03fd    	mov	x29, x29
10511a364: 94ac3379    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a368: aa0003f6    	mov	x22, x0
10511a36c: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a370: f9471d02    	ldr	x2, [x8, #0xe38]
10511a374: aa1503e1    	mov	x1, x21
10511a378: aa1303e3    	mov	x3, x19
10511a37c: 94ac3370    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a380: aa1603e0    	mov	x0, x22
10511a384: 94ac3374    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a388: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a38c: aa1403e1    	mov	x1, x20
10511a390: 94ac336b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a394: aa1d03fd    	mov	x29, x29
10511a398: 94ac336c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a39c: aa0003f6    	mov	x22, x0
10511a3a0: d00d82a8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10511a3a4: f946dd02    	ldr	x2, [x8, #0xdb8]
10511a3a8: aa1503e1    	mov	x1, x21
10511a3ac: aa1303e3    	mov	x3, x19
10511a3b0: 94ac3363    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a3b4: aa1603e0    	mov	x0, x22
10511a3b8: 94ac3367    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a3bc: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a3c0: aa1403e1    	mov	x1, x20
10511a3c4: 94ac335e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a3c8: aa1d03fd    	mov	x29, x29
10511a3cc: 94ac335f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a3d0: aa0003f6    	mov	x22, x0
10511a3d4: 900d82c8    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10511a3d8: f9403502    	ldr	x2, [x8, #0x68]
10511a3dc: aa1503e1    	mov	x1, x21
10511a3e0: aa1303e3    	mov	x3, x19
10511a3e4: 94ac3356    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a3e8: aa1603e0    	mov	x0, x22
10511a3ec: 94ac335a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a3f0: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a3f4: aa1403e1    	mov	x1, x20
10511a3f8: 94ac3351    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a3fc: aa1d03fd    	mov	x29, x29
10511a400: 94ac3352    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a404: aa0003f6    	mov	x22, x0
10511a408: f00d82a8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
10511a40c: f9407902    	ldr	x2, [x8, #0xf0]
10511a410: aa1503e1    	mov	x1, x21
10511a414: aa1303e3    	mov	x3, x19
10511a418: 94ac3349    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a41c: aa1603e0    	mov	x0, x22
10511a420: 94ac334d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a424: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a428: aa1403e1    	mov	x1, x20
10511a42c: 94ac3344    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a430: aa1d03fd    	mov	x29, x29
10511a434: 94ac3345    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a438: aa0003f6    	mov	x22, x0
10511a43c: 900d82c8    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10511a440: f9415502    	ldr	x2, [x8, #0x2a8]
10511a444: aa1503e1    	mov	x1, x21
10511a448: aa1303e3    	mov	x3, x19
10511a44c: 94ac333c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a450: aa1603e0    	mov	x0, x22
10511a454: 94ac3340    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a458: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a45c: aa1403e1    	mov	x1, x20
10511a460: 94ac3337    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a464: aa1d03fd    	mov	x29, x29
10511a468: 94ac3338    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a46c: aa0003f6    	mov	x22, x0
10511a470: 900d82c8    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10511a474: f9417902    	ldr	x2, [x8, #0x2f0]
10511a478: aa1503e1    	mov	x1, x21
10511a47c: aa1303e3    	mov	x3, x19
10511a480: 94ac332f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a484: aa1603e0    	mov	x0, x22
10511a488: 94ac3333    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a48c: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
10511a490: aa1403e1    	mov	x1, x20
10511a494: 94ac332a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a498: aa1d03fd    	mov	x29, x29
10511a49c: 94ac332b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a4a0: aa0003f4    	mov	x20, x0
10511a4a4: f00d82c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10511a4a8: f942b900    	ldr	x0, [x8, #0x570] ; PushLoginURLMgr
10511a4ac: b00d7f28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10511a4b0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10511a4b4: 94ac3322    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a4b8: aa0003e2    	mov	x2, x0
10511a4bc: f00d68e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511a4c0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10511a4c4: aa1403e0    	mov	x0, x20
10511a4c8: 94ac331d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a4cc: aa1d03fd    	mov	x29, x29
10511a4d0: 94ac331e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a4d4: 94ac3320    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a4d8: aa1403e0    	mov	x0, x20
10511a4dc: 94ac331e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a4e0: d00d6948    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10511a4e4: f944e502    	ldr	x2, [x8, #0x9c8] ; didReceiveMemoryWarning
10511a4e8: 900d6908    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10511a4ec: f9408101    	ldr	x1, [x8, #0x100] ; safePerformSelector:withObject:afterDelay:
10511a4f0: 1e67d000    	fmov	d0, #30.00000000
10511a4f4: aa1303e0    	mov	x0, x19
10511a4f8: d2800003    	mov	x3, #0x0                ; =0
10511a4fc: 94ac3310    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a500: b00d82c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511a504: f9468d00    	ldr	x0, [x8, #0xd18] ; DeviceInfo
10511a508: 900d69a8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10511a50c: f947c901    	ldr	x1, [x8, #0xf90] ; hasForceTouchCapability:
10511a510: aa1303e2    	mov	x2, x19
10511a514: 94ac330a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a518: 340006e0    	cbz	w0, 0x10511a5f4 <_Flutter_MMFoundation_BindContext+0x15f61d8>
10511a51c: d00d8868    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511a520: b9837115    	ldrsw	x21, [x8, #0x370]
10511a524: f8756a68    	ldr	x8, [x19, x21]
10511a528: f00d68e9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511a52c: f942a934    	ldr	x20, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10511a530: b00d82d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10511a534: b4000288    	cbz	x8, 0x10511a584 <_Flutter_MMFoundation_BindContext+0x15f6168>
10511a538: f94536c0    	ldr	x0, [x22, #0xa68] ; iConsole
10511a53c: f00c9d28    	adrp	x8, 0x11e4c1000 <dyld_stub_binder+0x11e4c1000>
10511a540: 9131a108    	add	x8, x8, #0xc68 ; CFString '3D Touch already register but need to unregisterForPreviewing'
10511a544: f90003e8    	str	x8, [sp]
10511a548: d00b39e5    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
10511a54c: 9122e0a5    	add	x5, x5, #0x8b8
10511a550: f00b39e7    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
10511a554: 911a24e7    	add	x7, x7, #0x689
10511a558: aa1403e1    	mov	x1, x20
10511a55c: 52800022    	mov	w2, #0x1                ; =1
10511a560: d2800003    	mov	x3, #0x0                ; =0
10511a564: 52800004    	mov	w4, #0x0                ; =0
10511a568: 5280d3c6    	mov	w6, #0x69e              ; =1694
10511a56c: 94ac32f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a570: f8756a62    	ldr	x2, [x19, x21]
10511a574: 900d69a8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10511a578: f947cd01    	ldr	x1, [x8, #0xf98] ; unregisterForPreviewingWithContext:
10511a57c: aa1303e0    	mov	x0, x19
10511a580: 94ac32ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a584: f94536c0    	ldr	x0, [x22, #0xa68] ; iConsole
10511a588: f00c9d28    	adrp	x8, 0x11e4c1000 <dyld_stub_binder+0x11e4c1000>
10511a58c: 91322108    	add	x8, x8, #0xc88 ; CFString '3D Touch registerForPreviewing'
10511a590: f90003e8    	str	x8, [sp]
10511a594: d00b39e5    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
10511a598: 9122e0a5    	add	x5, x5, #0x8b8
10511a59c: f00b39e7    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
10511a5a0: 911a24e7    	add	x7, x7, #0x689
10511a5a4: aa1403e1    	mov	x1, x20
10511a5a8: 52800022    	mov	w2, #0x1                ; =1
10511a5ac: d2800003    	mov	x3, #0x0                ; =0
10511a5b0: 52800004    	mov	w4, #0x0                ; =0
10511a5b4: 5280d426    	mov	w6, #0x6a1              ; =1697
10511a5b8: 94ac32e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a5bc: d00d8868    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511a5c0: b9831908    	ldrsw	x8, [x8, #0x318]
10511a5c4: f8686a63    	ldr	x3, [x19, x8]
10511a5c8: 900d69a8    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10511a5cc: f947d101    	ldr	x1, [x8, #0xfa0] ; registerForPreviewingWithDelegate:sourceView:
10511a5d0: aa1303e0    	mov	x0, x19
10511a5d4: aa1303e2    	mov	x2, x19
10511a5d8: 94ac32d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a5dc: aa1d03fd    	mov	x29, x29
10511a5e0: 94ac32da    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511a5e4: f8756a68    	ldr	x8, [x19, x21]
10511a5e8: f8356a60    	str	x0, [x19, x21]
10511a5ec: aa0803e0    	mov	x0, x8
10511a5f0: 94ac32d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511a5f4: d00d83c8    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
10511a5f8: f9433900    	ldr	x0, [x8, #0x670] ; ImageAndSightSettingDataReporter
10511a5fc: 900d7408    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
10511a600: f9478901    	ldr	x1, [x8, #0xf10] ; reportDataAtLaunchSuccess
10511a604: 94ac32ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511a608: 910043e0    	add	x0, sp, #0x10
10511a60c: 94abcb15    	bl	0x107c0d260 <_Flutter_MMFoundation_BindContext+0x40e8e44>
10511a610: 910103e0    	add	x0, sp, #0x40
10511a614: 94abcb13    	bl	0x107c0d260 <_Flutter_MMFoundation_BindContext+0x40e8e44>
10511a618: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
10511a61c: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
10511a620: a94957f6    	ldp	x22, x21, [sp, #0x90]
10511a624: a9485ff8    	ldp	x24, x23, [sp, #0x80]
10511a628: 910303ff    	add	sp, sp, #0xc0
10511a62c: d65f03c0    	ret
