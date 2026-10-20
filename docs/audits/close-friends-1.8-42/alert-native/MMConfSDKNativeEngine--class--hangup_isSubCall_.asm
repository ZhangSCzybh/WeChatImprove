
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029201f4: d10143ff    	sub	sp, sp, #0x50
1029201f8: a90257f6    	stp	x22, x21, [sp, #0x20]
1029201fc: a9034ff4    	stp	x20, x19, [sp, #0x30]
102920200: a9047bfd    	stp	x29, x30, [sp, #0x40]
102920204: 910103fd    	add	x29, sp, #0x40
102920208: aa0303f4    	mov	x20, x3
10292020c: aa0203f3    	mov	x19, x2
102920210: f00ec2d6    	adrp	x22, 0x12017b000 <dyld_stub_binder+0x12017b000>
102920214: f94136c0    	ldr	x0, [x22, #0x268] ; class=MMConfSDKNativeEngine
102920218: d00eaea8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10292021c: f941b915    	ldr	x21, [x8, #0x370] ; selector=getConfInst
102920220: aa1503e1    	mov	x1, x21
102920224: 954c1bc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
102920228: b40003a0    	cbz	x0, 0x10292029c <_Flutter_Image_provideRelativePathByUrl+0xd2d14c>
10292022c: f94136c0    	ldr	x0, [x22, #0x268] ; class=MMConfSDKNativeEngine
102920230: aa1503e1    	mov	x1, x21
102920234: 954c1bc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
102920238: f9400008    	ldr	x8, [x0]
10292023c: f9403108    	ldr	x8, [x8, #0x60] ; selector=isiOS17plus
102920240: aa1303e1    	mov	x1, x19
102920244: aa1403e2    	mov	x2, x20
102920248: d63f0100    	blr	x8
10292024c: aa0003f4    	mov	x20, x0
102920250: f00ec288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
102920254: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
102920258: b00ea8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10292025c: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
102920260: a900d3f3    	stp	x19, x20, [sp, #0x8]
102920264: d00dea28    	adrp	x8, 0x11e666000 <dyld_stub_binder+0x11e666000>
102920268: 91312108    	add	x8, x8, #0xc48 ; cfstring='hangup reason:%d result: %d'
10292026c: f90003e8    	str	x8, [sp]
102920270: b00c5b03    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
102920274: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
102920278: b00c6285    	adrp	x5, 0x11b571000 <dyld_stub_binder+0x11b571000>
10292027c: 910618a5    	add	x5, x5, #0x186 ; cstring='MMConfSDKNativeEngine.mm'
102920280: b00c6287    	adrp	x7, 0x11b571000 <dyld_stub_binder+0x11b571000>
102920284: 91143ce7    	add	x7, x7, #0x50f ; cstring='+[MMConfSDKNativeEngine hangup:isSubCall:]'
102920288: 52800042    	mov	w2, #0x2                ; =2
10292028c: 52800004    	mov	w4, #0x0                ; =0
102920290: 52802206    	mov	w6, #0x110              ; =272
102920294: 954c1baa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
102920298: 14000013    	b	0x1029202e4 <_Flutter_Image_provideRelativePathByUrl+0xd2d194>
10292029c: f00ec288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029202a0: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
1029202a4: b00ea8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029202a8: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
1029202ac: d00dea28    	adrp	x8, 0x11e666000 <dyld_stub_binder+0x11e666000>
1029202b0: 912e2108    	add	x8, x8, #0xb88 ; cfstring='sdk is nil'
1029202b4: f90003e8    	str	x8, [sp]
1029202b8: b00c5b03    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1029202bc: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
1029202c0: b00c6285    	adrp	x5, 0x11b571000 <dyld_stub_binder+0x11b571000>
1029202c4: 910618a5    	add	x5, x5, #0x186 ; cstring='MMConfSDKNativeEngine.mm'
1029202c8: b00c6287    	adrp	x7, 0x11b571000 <dyld_stub_binder+0x11b571000>
1029202cc: 91143ce7    	add	x7, x7, #0x50f ; cstring='+[MMConfSDKNativeEngine hangup:isSubCall:]'
1029202d0: 52800042    	mov	w2, #0x2                ; =2
1029202d4: 52800004    	mov	w4, #0x0                ; =0
1029202d8: 52802166    	mov	w6, #0x10b              ; =267
1029202dc: 954c1b98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029202e0: 12800014    	mov	w20, #-0x1              ; =-1
1029202e4: aa1403e0    	mov	x0, x20
1029202e8: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1029202ec: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1029202f0: a94257f6    	ldp	x22, x21, [sp, #0x20]
1029202f4: 910143ff    	add	sp, sp, #0x50
1029202f8: d65f03c0    	ret
