
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
1020413dc: d10583ff    	sub	sp, sp, #0x160
1020413e0: a9106ffc    	stp	x28, x27, [sp, #0x100]
1020413e4: a91167fa    	stp	x26, x25, [sp, #0x110]
1020413e8: a9125ff8    	stp	x24, x23, [sp, #0x120]
1020413ec: a91357f6    	stp	x22, x21, [sp, #0x130]
1020413f0: a9144ff4    	stp	x20, x19, [sp, #0x140]
1020413f4: a9157bfd    	stp	x29, x30, [sp, #0x150]
1020413f8: 910543fd    	add	x29, sp, #0x150
1020413fc: aa0203f3    	mov	x19, x2
102041400: aa0003f4    	mov	x20, x0
102041404: f00db848    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
102041408: f9451908    	ldr	x8, [x8, #0xa30]
10204140c: f9400108    	ldr	x8, [x8]
102041410: f81a03a8    	stur	x8, [x29, #-0x60]
102041414: d00eb828    	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
102041418: 52800029    	mov	w9, #0x1                ; =1
10204141c: 39168109    	strb	w9, [x8, #0x5a0]
102041420: aa0203e0    	mov	x0, x2
102041424: 956f9a14    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102041428: f00e6aa8    	adrp	x8, 0x11ed98000 <dyld_stub_binder+0x11ed98000>
10204142c: b9833d16    	ldrsw	x22, [x8, #0x33c]
102041430: f8766a95    	ldr	x21, [x20, x22]
102041434: b5000135    	cbnz	x21, 0x102041458 <_Flutter_Image_provideRelativePathByUrl+0x2c98e4>
102041438: b00e6688    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204143c: f9432d00    	ldr	x0, [x8, #0x658]
102041440: 956f99f3    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
102041444: f8766a88    	ldr	x8, [x20, x22]
102041448: f8366a80    	str	x0, [x20, x22]
10204144c: aa0803e0    	mov	x0, x8
102041450: 956f9a08    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102041454: f8766a95    	ldr	x21, [x20, x22]
102041458: a901d3f6    	stp	x22, x20, [sp, #0x18]
10204145c: 4f00e400    	movi.16b	v0, #0x0
102041460: ad0283e0    	stp	q0, q0, [sp, #0x50]
102041464: ad0183e0    	stp	q0, q0, [sp, #0x30]
102041468: aa1503e0    	mov	x0, x21
10204146c: 956f9a02    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102041470: b00e6328    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102041474: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
102041478: 9100c3e2    	add	x2, sp, #0x30
10204147c: 9101c3e3    	add	x3, sp, #0x70
102041480: f90017e1    	str	x1, [sp, #0x28]
102041484: 52800204    	mov	w4, #0x10               ; =16
102041488: 956f99f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204148c: b4000800    	cbz	x0, 0x10204158c <_Flutter_Image_provideRelativePathByUrl+0x2c9a18>
102041490: aa0003f8    	mov	x24, x0
102041494: f94023e8    	ldr	x8, [sp, #0x40]
102041498: f9400114    	ldr	x20, [x8]
10204149c: d00e4c48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1020414a0: f00e6329    	adrp	x9, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1020414a4: d2800017    	mov	x23, #0x0               ; =0
1020414a8: f9431116    	ldr	x22, [x8, #0x620] ; selector: m_nsUsrName
1020414ac: f943dd39    	ldr	x25, [x9, #0x7b8] ; selector: isEqualToString:
1020414b0: f94023e8    	ldr	x8, [sp, #0x40]
1020414b4: f9400108    	ldr	x8, [x8]
1020414b8: eb14011f    	cmp	x8, x20
1020414bc: 54000060    	b.eq	0x1020414c8 <_Flutter_Image_provideRelativePathByUrl+0x2c9954>
1020414c0: aa1503e0    	mov	x0, x21
1020414c4: 956f99de    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
1020414c8: f9401fe8    	ldr	x8, [sp, #0x38]
1020414cc: f877791a    	ldr	x26, [x8, x23, lsl #3]
1020414d0: aa1303e0    	mov	x0, x19
1020414d4: aa1603e1    	mov	x1, x22
1020414d8: 956f99e3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020414dc: aa1d03fd    	mov	x29, x29
1020414e0: 956f99e8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020414e4: aa0003fb    	mov	x27, x0
1020414e8: aa1a03e0    	mov	x0, x26
1020414ec: aa1903e1    	mov	x1, x25
1020414f0: aa1b03e2    	mov	x2, x27
1020414f4: 956f99dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020414f8: aa0003fc    	mov	x28, x0
1020414fc: aa1b03e0    	mov	x0, x27
102041500: 956f99dc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102041504: 350001fc    	cbnz	w28, 0x102041540 <_Flutter_Image_provideRelativePathByUrl+0x2c99cc>
102041508: 910006f7    	add	x23, x23, #0x1
10204150c: eb17031f    	cmp	x24, x23
102041510: 54fffd01    	b.ne	0x1020414b0 <_Flutter_Image_provideRelativePathByUrl+0x2c993c>
102041514: 9100c3e2    	add	x2, sp, #0x30
102041518: 9101c3e3    	add	x3, sp, #0x70
10204151c: aa1503e0    	mov	x0, x21
102041520: f94017e1    	ldr	x1, [sp, #0x28]
102041524: 52800204    	mov	w4, #0x10               ; =16
102041528: 956f99cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204152c: aa0003f8    	mov	x24, x0
102041530: d00e4c48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102041534: f00e6329    	adrp	x9, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
102041538: b5fffb60    	cbnz	x0, 0x1020414a4 <_Flutter_Image_provideRelativePathByUrl+0x2c9930>
10204153c: 14000016    	b	0x102041594 <_Flutter_Image_provideRelativePathByUrl+0x2c9a20>
102041540: b00e6688    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102041544: f9430d00    	ldr	x0, [x8, #0x618]
102041548: 900e4c48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204154c: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102041550: b00d85c8    	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
102041554: 910fe108    	add	x8, x8, #0x3f8 ; CFString: Group %@ 's Detail is getting, ignore request
102041558: a9006be8    	stp	x8, x26, [sp]
10204155c: d00be283    	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
102041560: 91160863    	add	x3, x3, #0x582
102041564: 900beec5    	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102041568: 910928a5    	add	x5, x5, #0x24a
10204156c: 900beec7    	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102041570: 913a30e7    	add	x7, x7, #0xe8c
102041574: 52800042    	mov	w2, #0x2                ; =2
102041578: 52800004    	mov	w4, #0x0                ; =0
10204157c: 5280ba66    	mov	w6, #0x5d3              ; =1491
102041580: 956f99b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041584: 52800014    	mov	w20, #0x0               ; =0
102041588: 14000039    	b	0x10204166c <_Flutter_Image_provideRelativePathByUrl+0x2c9af8>
10204158c: d00e4c48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
102041590: f9431116    	ldr	x22, [x8, #0x620] ; selector: m_nsUsrName
102041594: aa1503e0    	mov	x0, x21
102041598: 956f99b6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204159c: a941d3e8    	ldp	x8, x20, [sp, #0x18]
1020415a0: f8686a95    	ldr	x21, [x20, x8]
1020415a4: aa1303e0    	mov	x0, x19
1020415a8: aa1603e1    	mov	x1, x22
1020415ac: 956f99ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020415b0: aa1d03fd    	mov	x29, x29
1020415b4: 956f99b3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020415b8: aa0003f7    	mov	x23, x0
1020415bc: b00e4c48    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
1020415c0: f942c101    	ldr	x1, [x8, #0x580] ; selector: safeAddObject:
1020415c4: aa1503e0    	mov	x0, x21
1020415c8: aa1703e2    	mov	x2, x23
1020415cc: 956f99a6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020415d0: aa1703e0    	mov	x0, x23
1020415d4: 956f99a7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020415d8: b00e6708    	adrp	x8, 0x11ed22000 <dyld_stub_binder+0x11ed22000>
1020415dc: f940a100    	ldr	x0, [x8, #0x140]
1020415e0: 956f998b    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
1020415e4: aa0003f5    	mov	x21, x0
1020415e8: aa1303e0    	mov	x0, x19
1020415ec: aa1603e1    	mov	x1, x22
1020415f0: 956f999d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020415f4: aa1d03fd    	mov	x29, x29
1020415f8: 956f99a2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1020415fc: aa0003f6    	mov	x22, x0
102041600: b00e5108    	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102041604: f943c101    	ldr	x1, [x8, #0x780] ; selector: setChatroomUserName:
102041608: aa1503e0    	mov	x0, x21
10204160c: aa1603e2    	mov	x2, x22
102041610: 956f9995    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041614: aa1603e0    	mov	x0, x22
102041618: 956f9996    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204161c: d00e6348    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
102041620: f941b901    	ldr	x1, [x8, #0x370] ; selector: setClientVersion:
102041624: aa1503e0    	mov	x0, x21
102041628: 52800002    	mov	w2, #0x0                ; =0
10204162c: 956f998e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041630: b00e6708    	adrp	x8, 0x11ed22000 <dyld_stub_binder+0x11ed22000>
102041634: f940a500    	ldr	x0, [x8, #0x148]
102041638: b00e6328    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10204163c: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
102041640: 956f9989    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041644: aa0003e5    	mov	x5, x0
102041648: b00e5108    	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204164c: f943a901    	ldr	x1, [x8, #0x750] ; selector: createProtoBufEvent:forCgi:andUserData:eventHandler:
102041650: aa1403e0    	mov	x0, x20
102041654: aa1503e2    	mov	x2, x21
102041658: 528044e3    	mov	w3, #0x227              ; =551
10204165c: d2800004    	mov	x4, #0x0                ; =0
102041660: 956f9981    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102041664: 7100001f    	cmp	w0, #0x0
102041668: 1a9f07f4    	cset	w20, ne
10204166c: aa1503e0    	mov	x0, x21
102041670: 956f9980    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102041674: aa1303e0    	mov	x0, x19
102041678: 956f997e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204167c: f85a03a8    	ldur	x8, [x29, #-0x60]
102041680: f00db849    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
102041684: f9451929    	ldr	x9, [x9, #0xa30]
102041688: f9400129    	ldr	x9, [x9]
10204168c: eb08013f    	cmp	x9, x8
102041690: 54000141    	b.ne	0x1020416b8 <_Flutter_Image_provideRelativePathByUrl+0x2c9b44>
102041694: aa1403e0    	mov	x0, x20
102041698: a9557bfd    	ldp	x29, x30, [sp, #0x150]
10204169c: a9544ff4    	ldp	x20, x19, [sp, #0x140]
1020416a0: a95357f6    	ldp	x22, x21, [sp, #0x130]
1020416a4: a9525ff8    	ldp	x24, x23, [sp, #0x120]
1020416a8: a95167fa    	ldp	x26, x25, [sp, #0x110]
1020416ac: a9506ffc    	ldp	x28, x27, [sp, #0x100]
1020416b0: 910583ff    	add	sp, sp, #0x160
1020416b4: d65f03c0    	ret
1020416b8: 956f981e    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
