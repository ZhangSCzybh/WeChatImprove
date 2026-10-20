
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10292030c: d10143ff    	sub	sp, sp, #0x50
102920310: a90257f6    	stp	x22, x21, [sp, #0x20]
102920314: a9034ff4    	stp	x20, x19, [sp, #0x30]
102920318: a9047bfd    	stp	x29, x30, [sp, #0x40]
10292031c: 910103fd    	add	x29, sp, #0x40
102920320: aa0303f4    	mov	x20, x3
102920324: aa0203f3    	mov	x19, x2
102920328: f00ec2d6    	adrp	x22, 0x12017b000 <dyld_stub_binder+0x12017b000>
10292032c: f94136c0    	ldr	x0, [x22, #0x268] ; class=MMConfSDKNativeEngine
102920330: d00eaea8    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
102920334: f941b915    	ldr	x21, [x8, #0x370] ; selector=getConfInst
102920338: aa1503e1    	mov	x1, x21
10292033c: 954c1b80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
102920340: b40003a0    	cbz	x0, 0x1029203b4 <_Flutter_Image_provideRelativePathByUrl+0xd2d264>
102920344: f94136c0    	ldr	x0, [x22, #0x268] ; class=MMConfSDKNativeEngine
102920348: aa1503e1    	mov	x1, x21
10292034c: 954c1b7c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
102920350: f9400008    	ldr	x8, [x0]
102920354: f9403508    	ldr	x8, [x8, #0x68] ; selector=startAudioOnCallLock
102920358: aa1303e1    	mov	x1, x19
10292035c: aa1403e2    	mov	x2, x20
102920360: d63f0100    	blr	x8
102920364: aa0003f4    	mov	x20, x0
102920368: f00ec288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10292036c: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
102920370: b00ea8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
102920374: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
102920378: a900d3f3    	stp	x19, x20, [sp, #0x8]
10292037c: d00dea28    	adrp	x8, 0x11e666000 <dyld_stub_binder+0x11e666000>
102920380: 91312108    	add	x8, x8, #0xc48 ; cfstring='hangup reason:%d result: %d'
102920384: f90003e8    	str	x8, [sp]
102920388: b00c5b03    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
10292038c: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
102920390: b00c6285    	adrp	x5, 0x11b571000 <dyld_stub_binder+0x11b571000>
102920394: 910618a5    	add	x5, x5, #0x186 ; cstring='MMConfSDKNativeEngine.mm'
102920398: b00c6287    	adrp	x7, 0x11b571000 <dyld_stub_binder+0x11b571000>
10292039c: 911558e7    	add	x7, x7, #0x556 ; cstring='+[MMConfSDKNativeEngine hangup:roomID:]'
1029203a0: 52800042    	mov	w2, #0x2                ; =2
1029203a4: 52800004    	mov	w4, #0x0                ; =0
1029203a8: 52802406    	mov	w6, #0x120              ; =288
1029203ac: 954c1b64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029203b0: 14000013    	b	0x1029203fc <_Flutter_Image_provideRelativePathByUrl+0xd2d2ac>
1029203b4: f00ec288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029203b8: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
1029203bc: b00ea8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029203c0: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
1029203c4: d00dea28    	adrp	x8, 0x11e666000 <dyld_stub_binder+0x11e666000>
1029203c8: 912e2108    	add	x8, x8, #0xb88 ; cfstring='sdk is nil'
1029203cc: f90003e8    	str	x8, [sp]
1029203d0: b00c5b03    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1029203d4: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
1029203d8: b00c6285    	adrp	x5, 0x11b571000 <dyld_stub_binder+0x11b571000>
1029203dc: 910618a5    	add	x5, x5, #0x186 ; cstring='MMConfSDKNativeEngine.mm'
1029203e0: b00c6287    	adrp	x7, 0x11b571000 <dyld_stub_binder+0x11b571000>
1029203e4: 911558e7    	add	x7, x7, #0x556 ; cstring='+[MMConfSDKNativeEngine hangup:roomID:]'
1029203e8: 52800042    	mov	w2, #0x2                ; =2
1029203ec: 52800004    	mov	w4, #0x0                ; =0
1029203f0: 52802366    	mov	w6, #0x11b              ; =283
1029203f4: 954c1b52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029203f8: 12800014    	mov	w20, #-0x1              ; =-1
1029203fc: aa1403e0    	mov	x0, x20
102920400: a9447bfd    	ldp	x29, x30, [sp, #0x40]
102920404: a9434ff4    	ldp	x20, x19, [sp, #0x30]
102920408: a94257f6    	ldp	x22, x21, [sp, #0x20]
10292040c: 910143ff    	add	sp, sp, #0x50
102920410: d65f03c0    	ret
