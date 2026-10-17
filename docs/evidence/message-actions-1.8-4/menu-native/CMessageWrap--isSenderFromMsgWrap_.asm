
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba814c: d10183ff    	sub	sp, sp, #0x60
104ba8150: a90167fa    	stp	x26, x25, [sp, #0x10]
104ba8154: a9025ff8    	stp	x24, x23, [sp, #0x20]
104ba8158: a90357f6    	stp	x22, x21, [sp, #0x30]
104ba815c: a9044ff4    	stp	x20, x19, [sp, #0x40]
104ba8160: a9057bfd    	stp	x29, x30, [sp, #0x50]
104ba8164: 910143fd    	add	x29, sp, #0x50
104ba8168: aa0203f3    	mov	x19, x2
104ba816c: d00e04a8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ba8170: 52800029    	mov	w9, #0x1                ; =1
104ba8174: 391ab109    	strb	w9, [x8, #0x6ac]
104ba8178: aa0203e0    	mov	x0, x2
104ba817c: 94c1fbef    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104ba8180: b40005d3    	cbz	x19, 0x104ba8238 <_Flutter_MMFoundation_BindContext+0x1083e1c>
104ba8184: b00d9588    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
104ba8188: f9442d14    	ldr	x20, [x8, #0x858] ; m_uiIsSenderStatus
104ba818c: aa1303e0    	mov	x0, x19
104ba8190: aa1403e1    	mov	x1, x20
104ba8194: 94c1fbea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8198: 7100041f    	cmp	w0, #0x1
104ba819c: 54000700    	b.eq	0x104ba827c <_Flutter_MMFoundation_BindContext+0x1083e60>
104ba81a0: aa1303e0    	mov	x0, x19
104ba81a4: aa1403e1    	mov	x1, x20
104ba81a8: 94c1fbe5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba81ac: 7100081f    	cmp	w0, #0x2
104ba81b0: 54000400    	b.eq	0x104ba8230 <_Flutter_MMFoundation_BindContext+0x1083e14>
104ba81b4: d00d94a8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104ba81b8: f9413d14    	ldr	x20, [x8, #0x278] ; m_uiMessageType
104ba81bc: aa1303e0    	mov	x0, x19
104ba81c0: aa1403e1    	mov	x1, x20
104ba81c4: 94c1fbde    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba81c8: 5284e208    	mov	w8, #0x2710             ; =10000
104ba81cc: 6b08001f    	cmp	w0, w8
104ba81d0: 540000e0    	b.eq	0x104ba81ec <_Flutter_MMFoundation_BindContext+0x1083dd0>
104ba81d4: aa1303e0    	mov	x0, x19
104ba81d8: aa1403e1    	mov	x1, x20
104ba81dc: 94c1fbd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba81e0: 5284e248    	mov	w8, #0x2712             ; =10002
104ba81e4: 6b08001f    	cmp	w0, w8
104ba81e8: 54000601    	b.ne	0x104ba82a8 <_Flutter_MMFoundation_BindContext+0x1083e8c>
104ba81ec: f00dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba81f0: f9453500    	ldr	x0, [x8, #0xa68] ; �gH
104ba81f4: b00d9488    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ba81f8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104ba81fc: d00ce008    	adrp	x8, 0x11e7aa000 <dyld_stub_binder+0x11e7aa000>
104ba8200: 911ba108    	add	x8, x8, #0x6e8
104ba8204: f90003e8    	str	x8, [sp]
104ba8208: b00b33e3    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104ba820c: 9107f063    	add	x3, x3, #0x1fc
104ba8210: d00b62e5    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104ba8214: 9123a0a5    	add	x5, x5, #0x8e8
104ba8218: f00b62e7    	adrp	x7, 0x11b807000 <dyld_stub_binder+0x11b807000>
104ba821c: 912da8e7    	add	x7, x7, #0xb6a
104ba8220: 52800022    	mov	w2, #0x1                ; =1
104ba8224: 52800004    	mov	w4, #0x0                ; =0
104ba8228: 52814546    	mov	w6, #0xa2a              ; =2602
104ba822c: 94c1fbc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8230: 52800015    	mov	w21, #0x0               ; =0
104ba8234: 14000013    	b	0x104ba8280 <_Flutter_MMFoundation_BindContext+0x1083e64>
104ba8238: f00dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba823c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH
104ba8240: b00d9488    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ba8244: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104ba8248: d00ce008    	adrp	x8, 0x11e7aa000 <dyld_stub_binder+0x11e7aa000>
104ba824c: 911b2108    	add	x8, x8, #0x6c8
104ba8250: f90003e8    	str	x8, [sp]
104ba8254: b00b33e3    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104ba8258: 9107f063    	add	x3, x3, #0x1fc
104ba825c: d00b62e5    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104ba8260: 9123a0a5    	add	x5, x5, #0x8e8
104ba8264: f00b62e7    	adrp	x7, 0x11b807000 <dyld_stub_binder+0x11b807000>
104ba8268: 912da8e7    	add	x7, x7, #0xb6a
104ba826c: 52800082    	mov	w2, #0x4                ; =4
104ba8270: 52800004    	mov	w4, #0x0                ; =0
104ba8274: 528143c6    	mov	w6, #0xa1e              ; =2590
104ba8278: 94c1fbb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba827c: 52800035    	mov	w21, #0x1               ; =1
104ba8280: aa1303e0    	mov	x0, x19
104ba8284: 94c1fbb4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba8288: aa1503e0    	mov	x0, x21
104ba828c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104ba8290: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104ba8294: a94357f6    	ldp	x22, x21, [sp, #0x30]
104ba8298: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104ba829c: a94167fa    	ldp	x26, x25, [sp, #0x10]
104ba82a0: 910183ff    	add	sp, sp, #0x60
104ba82a4: d65f03c0    	ret
104ba82a8: 900dae68    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104ba82ac: f946c900    	ldr	x0, [x8, #0xd90] ; �z9
104ba82b0: f00d9508    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104ba82b4: f9403d01    	ldr	x1, [x8, #0x78] ; isMessageWrapPatMessage:
104ba82b8: aa1303e2    	mov	x2, x19
104ba82bc: 94c1fba0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba82c0: 34000240    	cbz	w0, 0x104ba8308 <_Flutter_MMFoundation_BindContext+0x1083eec>
104ba82c4: f00dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba82c8: f9453500    	ldr	x0, [x8, #0xa68] ; �gH
104ba82cc: b00d9488    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ba82d0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104ba82d4: d00ce008    	adrp	x8, 0x11e7aa000 <dyld_stub_binder+0x11e7aa000>
104ba82d8: 911c2108    	add	x8, x8, #0x708
104ba82dc: f90003e8    	str	x8, [sp]
104ba82e0: b00b33e3    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104ba82e4: 9107f063    	add	x3, x3, #0x1fc
104ba82e8: d00b62e5    	adrp	x5, 0x11b806000 <dyld_stub_binder+0x11b806000>
104ba82ec: 9123a0a5    	add	x5, x5, #0x8e8
104ba82f0: f00b62e7    	adrp	x7, 0x11b807000 <dyld_stub_binder+0x11b807000>
104ba82f4: 912da8e7    	add	x7, x7, #0xb6a
104ba82f8: 52800022    	mov	w2, #0x1                ; =1
104ba82fc: 52800004    	mov	w4, #0x0                ; =0
104ba8300: 52814606    	mov	w6, #0xa30              ; =2608
104ba8304: 17ffffca    	b	0x104ba822c <_Flutter_MMFoundation_BindContext+0x1083e10>
104ba8308: f00dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba830c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d
104ba8310: b00d94a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba8314: f9447d01    	ldr	x1, [x8, #0x8f8] ; currentUserName
104ba8318: 94c1fb89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba831c: aa1d03fd    	mov	x29, x29
104ba8320: 94c1fb8a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8324: aa0003f4    	mov	x20, x0
104ba8328: b00d94a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ba832c: f9429d15    	ldr	x21, [x8, #0x538] ; m_nsFromUsr
104ba8330: aa1303e0    	mov	x0, x19
104ba8334: aa1503e1    	mov	x1, x21
104ba8338: 94c1fb81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba833c: aa1d03fd    	mov	x29, x29
104ba8340: 94c1fb82    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8344: aa0003f7    	mov	x23, x0
104ba8348: f00daac8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104ba834c: f943c916    	ldr	x22, [x8, #0x790] ; isEqualToString:
104ba8350: aa1603e1    	mov	x1, x22
104ba8354: aa1403e2    	mov	x2, x20
104ba8358: 94c1fb79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba835c: aa0003f8    	mov	x24, x0
104ba8360: aa1703e0    	mov	x0, x23
104ba8364: 94c1fb7c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba8368: 36000078    	tbz	w24, #0x0, 0x104ba8374 <_Flutter_MMFoundation_BindContext+0x1083f58>
104ba836c: 52800035    	mov	w21, #0x1               ; =1
104ba8370: 14000043    	b	0x104ba847c <_Flutter_MMFoundation_BindContext+0x1084060>
104ba8374: aa1303e0    	mov	x0, x19
104ba8378: aa1503e1    	mov	x1, x21
104ba837c: 94c1fb70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8380: aa1d03fd    	mov	x29, x29
104ba8384: 94c1fb71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8388: aa0003f7    	mov	x23, x0
104ba838c: d00daac8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104ba8390: f9445901    	ldr	x1, [x8, #0x8b0] ; hasSuffix:
104ba8394: d00ce002    	adrp	x2, 0x11e7aa000 <dyld_stub_binder+0x11e7aa000>
104ba8398: 911ca042    	add	x2, x2, #0x728
104ba839c: 94c1fb68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba83a0: aa0003f8    	mov	x24, x0
104ba83a4: aa1703e0    	mov	x0, x23
104ba83a8: 94c1fb6b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba83ac: 340005f8    	cbz	w24, 0x104ba8468 <_Flutter_MMFoundation_BindContext+0x108404c>
104ba83b0: f00dae58    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104ba83b4: f9471300    	ldr	x0, [x24, #0xe20] ; H�b
104ba83b8: d00d9488    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104ba83bc: f946f101    	ldr	x1, [x8, #0xde0] ; getMainSetting
104ba83c0: 94c1fb5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba83c4: aa1d03fd    	mov	x29, x29
104ba83c8: 94c1fb60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba83cc: aa0003f7    	mov	x23, x0
104ba83d0: f9471300    	ldr	x0, [x24, #0xe20] ; H�b
104ba83d4: f00d9ee8    	adrp	x8, 0x11ff87000 <dyld_stub_binder+0x11ff87000>
104ba83d8: f946f101    	ldr	x1, [x8, #0xde0] ; isBindQQ
104ba83dc: 94c1fb58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba83e0: 34000480    	cbz	w0, 0x104ba8470 <_Flutter_MMFoundation_BindContext+0x1084054>
104ba83e4: f00dae48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104ba83e8: f9454518    	ldr	x24, [x8, #0xa88]
104ba83ec: 900d94e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104ba83f0: f9401501    	ldr	x1, [x8, #0x28] ; m_uiBindQQUin
104ba83f4: aa1703e0    	mov	x0, x23
104ba83f8: 94c1fb51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba83fc: d00dab08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104ba8400: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104ba8404: 900b3e08    	adrp	x8, 0x11b368000 <dyld_stub_binder+0x11b368000>
104ba8408: 91073908    	add	x8, x8, #0x1ce
104ba840c: a90023e0    	stp	x0, x8, [sp]
104ba8410: b00ccce2    	adrp	x2, 0x11e545000 <dyld_stub_binder+0x11e545000>
104ba8414: 912fa042    	add	x2, x2, #0xbe8
104ba8418: aa1803e0    	mov	x0, x24
104ba841c: 94c1fb48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8420: aa1d03fd    	mov	x29, x29
104ba8424: 94c1fb49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8428: aa0003f8    	mov	x24, x0
104ba842c: aa1303e0    	mov	x0, x19
104ba8430: aa1503e1    	mov	x1, x21
104ba8434: 94c1fb42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8438: aa1d03fd    	mov	x29, x29
104ba843c: 94c1fb43    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ba8440: aa0003f9    	mov	x25, x0
104ba8444: aa1603e1    	mov	x1, x22
104ba8448: aa1803e2    	mov	x2, x24
104ba844c: 94c1fb3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ba8450: aa0003f5    	mov	x21, x0
104ba8454: aa1903e0    	mov	x0, x25
104ba8458: 94c1fb3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba845c: aa1803e0    	mov	x0, x24
104ba8460: 94c1fb3d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba8464: 14000004    	b	0x104ba8474 <_Flutter_MMFoundation_BindContext+0x1084058>
104ba8468: 52800015    	mov	w21, #0x0               ; =0
104ba846c: 14000004    	b	0x104ba847c <_Flutter_MMFoundation_BindContext+0x1084060>
104ba8470: 52800015    	mov	w21, #0x0               ; =0
104ba8474: aa1703e0    	mov	x0, x23
104ba8478: 94c1fb37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba847c: aa1403e0    	mov	x0, x20
104ba8480: 94c1fb35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ba8484: 17ffff7f    	b	0x104ba8280 <_Flutter_MMFoundation_BindContext+0x1083e64>