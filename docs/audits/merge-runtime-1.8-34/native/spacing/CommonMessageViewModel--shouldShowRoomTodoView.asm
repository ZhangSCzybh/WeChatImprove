
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f6b10c: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
100f6b110: a90167fa    	stp	x26, x25, [sp, #0x10]
100f6b114: a9025ff8    	stp	x24, x23, [sp, #0x20]
100f6b118: a90357f6    	stp	x22, x21, [sp, #0x30]
100f6b11c: a9044ff4    	stp	x20, x19, [sp, #0x40]
100f6b120: a9057bfd    	stp	x29, x30, [sp, #0x50]
100f6b124: 910143fd    	add	x29, sp, #0x50
100f6b128: aa0003f3    	mov	x19, x0
100f6b12c: b00fe628    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f6b130: 52800029    	mov	w9, #0x1                ; =1
100f6b134: 39298509    	strb	w9, [x8, #0xa61]
100f6b138: 900f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b13c: f9415d01    	ldr	x1, [x8, #0x2b8] ; isTailPart
100f6b140: 95b2efff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b144: 34000c40    	cbz	w0, 0x100f6b2cc <__text+0xf632cc>
100f6b148: 900f905a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b14c: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
100f6b150: b00f8ca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f6b154: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
100f6b158: aa1403e1    	mov	x1, x20
100f6b15c: 95b2eff8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b160: aa1d03fd    	mov	x29, x29
100f6b164: 95b2eff9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b168: aa0003f7    	mov	x23, x0
100f6b16c: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b170: f9467100    	ldr	x0, [x8, #0xce0] ; @�- 
100f6b174: 900f8ca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f6b178: f947ad15    	ldr	x21, [x8, #0xf58] ; class
100f6b17c: aa1503e1    	mov	x1, x21
100f6b180: 95b2efef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b184: aa0003e2    	mov	x2, x0
100f6b188: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b18c: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
100f6b190: aa1703e0    	mov	x0, x23
100f6b194: aa1603e1    	mov	x1, x22
100f6b198: 95b2efe9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b19c: aa1d03fd    	mov	x29, x29
100f6b1a0: 95b2efea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b1a4: aa0003f8    	mov	x24, x0
100f6b1a8: f00f7668    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100f6b1ac: f9404101    	ldr	x1, [x8, #0x80] ; getExpt:withBoolDef:
100f6b1b0: d00eaea2    	adrp	x2, 0x11e541000 <dyld_stub_binder+0x11e541000>
100f6b1b4: 910ea042    	add	x2, x2, #0x3a8
100f6b1b8: 52800023    	mov	w3, #0x1                ; =1
100f6b1bc: 95b2efe0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b1c0: aa0003f9    	mov	x25, x0
100f6b1c4: aa1803e0    	mov	x0, x24
100f6b1c8: 95b2efe3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b1cc: aa1703e0    	mov	x0, x23
100f6b1d0: 95b2efe1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b1d4: 340007d9    	cbz	w25, 0x100f6b2cc <__text+0xf632cc>
100f6b1d8: f00f7688    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f6b1dc: f9410517    	ldr	x23, [x8, #0x208] ; messageWrap
100f6b1e0: aa1303e0    	mov	x0, x19
100f6b1e4: aa1703e1    	mov	x1, x23
100f6b1e8: 95b2efd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b1ec: aa1d03fd    	mov	x29, x29
100f6b1f0: 95b2efd6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b1f4: aa0003f8    	mov	x24, x0
100f6b1f8: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6b1fc: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
100f6b200: 95b2efcf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b204: 11424c08    	add	w8, w0, #0x93, lsl #12  ; =0x93000
100f6b208: 112a011b    	add	w27, w8, #0xa80
100f6b20c: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b210: f9467900    	ldr	x0, [x8, #0xcf0] ; ��b 
100f6b214: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6b218: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
100f6b21c: 95b2efc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b220: aa0003f9    	mov	x25, x0
100f6b224: aa1803e0    	mov	x0, x24
100f6b228: 95b2efcb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b22c: 6b19037f    	cmp	w27, w25
100f6b230: 540004e3    	b.lo	0x100f6b2cc <__text+0xf632cc>
100f6b234: d00f93e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f6b238: b984fd08    	ldrsw	x8, [x8, #0x4fc]
100f6b23c: 38686a68    	ldrb	w8, [x19, x8]
100f6b240: 7100051f    	cmp	w8, #0x1
100f6b244: 54000441    	b.ne	0x100f6b2cc <__text+0xf632cc>
100f6b248: d00f7668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f6b24c: f9463901    	ldr	x1, [x8, #0xc70] ; contact
100f6b250: aa1303e0    	mov	x0, x19
100f6b254: 95b2efba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b258: aa1d03fd    	mov	x29, x29
100f6b25c: 95b2efbb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b260: aa0003f8    	mov	x24, x0
100f6b264: 900f9048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f6b268: f9478100    	ldr	x0, [x8, #0xf00] ;  /, 
100f6b26c: aa1503e1    	mov	x1, x21
100f6b270: 95b2efb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b274: aa0003e2    	mov	x2, x0
100f6b278: 900f8cc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f6b27c: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100f6b280: aa1803e0    	mov	x0, x24
100f6b284: 95b2efae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b288: aa0003f9    	mov	x25, x0
100f6b28c: aa1803e0    	mov	x0, x24
100f6b290: 95b2efb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b294: 340001d9    	cbz	w25, 0x100f6b2cc <__text+0xf632cc>
100f6b298: 900f76a8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f6b29c: f9437901    	ldr	x1, [x8, #0x6f0] ; chatContact
100f6b2a0: aa1303e0    	mov	x0, x19
100f6b2a4: 95b2efa6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b2a8: aa1d03fd    	mov	x29, x29
100f6b2ac: 95b2efa7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b2b0: aa0003f8    	mov	x24, x0
100f6b2b4: f00f7868    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
100f6b2b8: f940f901    	ldr	x1, [x8, #0x1f0] ; isOpenIMChatroom
100f6b2bc: 95b2efa0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b2c0: 36000180    	tbz	w0, #0x0, 0x100f6b2f0 <__text+0xf632f0>
100f6b2c4: 52800013    	mov	w19, #0x0               ; =0
100f6b2c8: 14000046    	b	0x100f6b3e0 <__text+0xf633e0>
100f6b2cc: 52800013    	mov	w19, #0x0               ; =0
100f6b2d0: aa1303e0    	mov	x0, x19
100f6b2d4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
100f6b2d8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
100f6b2dc: a94357f6    	ldp	x22, x21, [sp, #0x30]
100f6b2e0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
100f6b2e4: a94167fa    	ldp	x26, x25, [sp, #0x10]
100f6b2e8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
100f6b2ec: d65f03c0    	ret
100f6b2f0: aa1303e0    	mov	x0, x19
100f6b2f4: aa1703e1    	mov	x1, x23
100f6b2f8: 95b2ef91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b2fc: aa1d03fd    	mov	x29, x29
100f6b300: 95b2ef92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b304: aa0003f9    	mov	x25, x0
100f6b308: b00f7688    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f6b30c: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
100f6b310: 95b2ef8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b314: f100041f    	cmp	x0, #0x1
100f6b318: 540005eb    	b.lt	0x100f6b3d4 <__text+0xf633d4>
100f6b31c: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
100f6b320: aa1403e1    	mov	x1, x20
100f6b324: 95b2ef86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b328: aa1d03fd    	mov	x29, x29
100f6b32c: 95b2ef87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b330: aa0003f4    	mov	x20, x0
100f6b334: f00f9048    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100f6b338: f9417500    	ldr	x0, [x8, #0x2e8]
100f6b33c: aa1503e1    	mov	x1, x21
100f6b340: 95b2ef7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b344: aa0003e2    	mov	x2, x0
100f6b348: aa1403e0    	mov	x0, x20
100f6b34c: aa1603e1    	mov	x1, x22
100f6b350: 95b2ef7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b354: aa1d03fd    	mov	x29, x29
100f6b358: 95b2ef7c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b35c: aa0003f5    	mov	x21, x0
100f6b360: aa1303e0    	mov	x0, x19
100f6b364: aa1703e1    	mov	x1, x23
100f6b368: 95b2ef75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b36c: aa1d03fd    	mov	x29, x29
100f6b370: 95b2ef76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b374: aa0003f6    	mov	x22, x0
100f6b378: 900f7688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100f6b37c: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
100f6b380: aa1803e0    	mov	x0, x24
100f6b384: 95b2ef6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b388: aa1d03fd    	mov	x29, x29
100f6b38c: 95b2ef6f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f6b390: aa0003f7    	mov	x23, x0
100f6b394: d00f78a8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
100f6b398: f9430101    	ldr	x1, [x8, #0x600] ; isGroupUndoneMessage:usr:
100f6b39c: aa1503e0    	mov	x0, x21
100f6b3a0: aa1603e2    	mov	x2, x22
100f6b3a4: aa1703e3    	mov	x3, x23
100f6b3a8: 95b2ef65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f6b3ac: aa0003f3    	mov	x19, x0
100f6b3b0: aa1703e0    	mov	x0, x23
100f6b3b4: 95b2ef68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b3b8: aa1603e0    	mov	x0, x22
100f6b3bc: 95b2ef66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b3c0: aa1503e0    	mov	x0, x21
100f6b3c4: 95b2ef64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b3c8: aa1403e0    	mov	x0, x20
100f6b3cc: 95b2ef62    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b3d0: 14000002    	b	0x100f6b3d8 <__text+0xf633d8>
100f6b3d4: 52800013    	mov	w19, #0x0               ; =0
100f6b3d8: aa1903e0    	mov	x0, x25
100f6b3dc: 95b2ef5e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b3e0: aa1803e0    	mov	x0, x24
100f6b3e4: 95b2ef5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f6b3e8: 17ffffba    	b	0x100f6b2d0 <__text+0xf632d0>