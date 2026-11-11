
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10121b31c:     	sub	sp, sp, #0x70
10121b320:     	stp	x26, x25, [sp, #0x20]
10121b324:     	stp	x24, x23, [sp, #0x30]
10121b328:     	stp	x22, x21, [sp, #0x40]
10121b32c:     	stp	x20, x19, [sp, #0x50]
10121b330:     	stp	x29, x30, [sp, #0x60]
10121b334:     	add	x29, sp, #0x60
10121b338:     	mov	x20, x4
10121b33c:     	mov	x21, x3
10121b340:     	mov	x19, x2
10121b344:     	mov	x22, x0
10121b348:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b34c:     	ldr	x23, [x8, #0x618]
10121b350:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b354:     	ldr	x24, [x8, #0x638]
10121b358:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10121b35c:     	ldr	x25, [x8, #0xfb8] ; selector: generatePrivacyString:
10121b360:     	mov	x0, x2
10121b364:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121b368:     	mov	x0, x24
10121b36c:     	mov	x1, x25
10121b370:     	mov	x2, x19
10121b374:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b378:     	mov	x29, x29
10121b37c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b380:     	mov	x24, x0
10121b384:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b388:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10121b38c:     	stp	x21, x20, [sp, #0x10]
10121b390:     	adrp	x8, 0x11d05b000 <dyld_stub_binder+0x11d05b000>
10121b394:     	add	x8, x8, #0xf98 ; CFString: chatProfileSwitchSetting key:%@+%lu, switch:%d
10121b398:     	stp	x8, x0, [sp]
10121b39c:     	adrp	x5, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121b3a0:     	add	x5, x5, #0x5ef
10121b3a4:     	adrp	x7, 0x119d0c000 <dyld_stub_binder+0x119d0c000>
10121b3a8:     	add	x7, x7, #0x608
10121b3ac:     	mov	x0, x23
10121b3b0:     	mov	w2, #0x2                ; =2
10121b3b4:     	mov	x3, #0x0                ; =0
10121b3b8:     	mov	w4, #0x0                ; =0
10121b3bc:     	mov	w6, #0x80               ; =128
10121b3c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b3c4:     	mov	x0, x24
10121b3c8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121b3cc:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121b3d0:     	ldr	x1, [x8, #0x438] ; selector: processChatProfileSetting:withType:andValue:
10121b3d4:     	mov	x0, x22
10121b3d8:     	mov	x2, x19
10121b3dc:     	mov	x3, x21
10121b3e0:     	mov	x4, x20
10121b3e4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b3e8:     	mov	x0, x19
10121b3ec:     	ldp	x29, x30, [sp, #0x60]
10121b3f0:     	ldp	x20, x19, [sp, #0x50]
10121b3f4:     	ldp	x22, x21, [sp, #0x40]
10121b3f8:     	ldp	x24, x23, [sp, #0x30]
10121b3fc:     	ldp	x26, x25, [sp, #0x20]
10121b400:     	add	sp, sp, #0x70
10121b404:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
