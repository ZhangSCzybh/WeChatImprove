
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
10204b0d8:     	stp	x22, x21, [sp, #-0x30]!
10204b0dc:     	stp	x20, x19, [sp, #0x10]
10204b0e0:     	stp	x29, x30, [sp, #0x20]
10204b0e4:     	add	x29, sp, #0x20
10204b0e8:     	mov	x21, x3
10204b0ec:     	mov	x19, x2
10204b0f0:     	mov	x20, x0
10204b0f4:     	adrp	x8, 0x11f747000 <dyld_stub_binder+0x11f747000>
10204b0f8:     	mov	w9, #0x1                ; =1
10204b0fc:     	strb	w9, [x8, #0x5c1]
10204b100:     	mov	x0, x2
10204b104:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10204b108:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10204b10c:     	ldr	x0, [x8, #0x840]
10204b110:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204b114:     	ldr	x1, [x8, #0xc30] ; selector: removePBEventObserverListItem:andValue:
10204b118:     	mov	x2, x21
10204b11c:     	mov	x3, x20
10204b120:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b124:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10204b128:     	ldr	x1, [x8, #0xc28] ; selector: m_uiCgi
10204b12c:     	mov	x0, x19
10204b130:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b134:     	cmp	w0, #0x305
10204b138:     	b.gt	0x10204b170 <_Flutter_Image_provideRelativePathByUrl+0x2d35fc>
10204b13c:     	cmp	w0, #0x102
10204b140:     	b.le	0x10204b1a4 <_Flutter_Image_provideRelativePathByUrl+0x2d3630>
10204b144:     	cmp	w0, #0x226
10204b148:     	b.gt	0x10204b1fc <_Flutter_Image_provideRelativePathByUrl+0x2d3688>
10204b14c:     	cmp	w0, #0x103
10204b150:     	b.eq	0x10204b308 <_Flutter_Image_provideRelativePathByUrl+0x2d3794>
10204b154:     	cmp	w0, #0x1e2
10204b158:     	b.eq	0x10204b2d8 <_Flutter_Image_provideRelativePathByUrl+0x2d3764>
10204b15c:     	cmp	w0, #0x207
10204b160:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b164:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b168:     	ldr	x1, [x8, #0x980] ; selector: onGetChatRoomUpgradeStatus:
10204b16c:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b170:     	cmp	w0, #0xdd9
10204b174:     	b.le	0x10204b1d0 <_Flutter_Image_provideRelativePathByUrl+0x2d365c>
10204b178:     	cmp	w0, #0xf56
10204b17c:     	b.gt	0x10204b220 <_Flutter_Image_provideRelativePathByUrl+0x2d36ac>
10204b180:     	cmp	w0, #0xdda
10204b184:     	b.eq	0x10204b314 <_Flutter_Image_provideRelativePathByUrl+0x2d37a0>
10204b188:     	cmp	w0, #0xde1
10204b18c:     	b.eq	0x10204b2e4 <_Flutter_Image_provideRelativePathByUrl+0x2d3770>
10204b190:     	cmp	w0, #0xe5d
10204b194:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b198:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b19c:     	ldr	x1, [x8, #0x9d8] ; selector: OnDeleteOpenIMGroupAdmin:
10204b1a0:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b1a4:     	cmp	w0, #0xb2
10204b1a8:     	b.le	0x10204b24c <_Flutter_Image_provideRelativePathByUrl+0x2d36d8>
10204b1ac:     	cmp	w0, #0xb3
10204b1b0:     	b.eq	0x10204b29c <_Flutter_Image_provideRelativePathByUrl+0x2d3728>
10204b1b4:     	cmp	w0, #0xb6
10204b1b8:     	b.eq	0x10204b284 <_Flutter_Image_provideRelativePathByUrl+0x2d3710>
10204b1bc:     	cmp	w0, #0xdf
10204b1c0:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b1c4:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b1c8:     	ldr	x1, [x8, #0x9a0] ; selector: OnGetChatRoomInfoResp:
10204b1cc:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b1d0:     	cmp	w0, #0x378
10204b1d4:     	b.le	0x10204b268 <_Flutter_Image_provideRelativePathByUrl+0x2d36f4>
10204b1d8:     	cmp	w0, #0x379
10204b1dc:     	b.eq	0x10204b2a8 <_Flutter_Image_provideRelativePathByUrl+0x2d3734>
10204b1e0:     	cmp	w0, #0x3de
10204b1e4:     	b.eq	0x10204b290 <_Flutter_Image_provideRelativePathByUrl+0x2d371c>
10204b1e8:     	cmp	w0, #0x3e1
10204b1ec:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b1f0:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b1f4:     	ldr	x1, [x8, #0x9a8] ; selector: OnSetChatRoomDescResp:
10204b1f8:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b1fc:     	cmp	w0, #0x227
10204b200:     	b.eq	0x10204b320 <_Flutter_Image_provideRelativePathByUrl+0x2d37ac>
10204b204:     	cmp	w0, #0x262
10204b208:     	b.eq	0x10204b2f0 <_Flutter_Image_provideRelativePathByUrl+0x2d377c>
10204b20c:     	cmp	w0, #0x2a9
10204b210:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b214:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b218:     	ldr	x1, [x8, #0x9b8] ; selector: OnOplogResp:
10204b21c:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b220:     	cmp	w0, #0xf57
10204b224:     	b.eq	0x10204b32c <_Flutter_Image_provideRelativePathByUrl+0x2d37b8>
10204b228:     	mov	w8, #0x1849             ; =6217
10204b22c:     	cmp	w0, w8
10204b230:     	b.eq	0x10204b2fc <_Flutter_Image_provideRelativePathByUrl+0x2d3788>
10204b234:     	mov	w8, #0x2ebd             ; =11965
10204b238:     	cmp	w0, w8
10204b23c:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b240:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b244:     	ldr	x1, [x8, #0xa00] ; selector: OnSetRoomTopMsg:
10204b248:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b24c:     	cmp	w0, #0x77
10204b250:     	b.eq	0x10204b2b4 <_Flutter_Image_provideRelativePathByUrl+0x2d3740>
10204b254:     	cmp	w0, #0x78
10204b258:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b25c:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b260:     	ldr	x1, [x8, #0x960] ; selector: OnAddChatRoomMember:
10204b264:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b268:     	cmp	w0, #0x306
10204b26c:     	b.eq	0x10204b2cc <_Flutter_Image_provideRelativePathByUrl+0x2d3758>
10204b270:     	cmp	w0, #0x308
10204b274:     	b.ne	0x10204b354 <_Flutter_Image_provideRelativePathByUrl+0x2d37e0>
10204b278:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b27c:     	ldr	x1, [x8, #0x9d0] ; selector: OnAddOpenIMGroupAdmin:
10204b280:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b284:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b288:     	ldr	x1, [x8, #0x978] ; selector: OnUpdateContact:
10204b28c:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b290:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b294:     	ldr	x1, [x8, #0x998] ; selector: OnChangeChatRoomOwnerResp:
10204b298:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b29c:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2a0:     	ldr	x1, [x8, #0x958] ; selector: OnDeleteChatRoomMemberResponse:
10204b2a4:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b2a8:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2ac:     	ldr	x1, [x8, #0x9c0] ; selector: OnAddGroupAdmin:
10204b2b0:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b2b4:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2b8:     	ldr	x1, [x8, #0x968] ; selector: OnCreateChatRoom:
10204b2bc:     	mov	x0, x20
10204b2c0:     	mov	x2, x19
10204b2c4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b2c8:     	b	0x10204b340 <_Flutter_Image_provideRelativePathByUrl+0x2d37cc>
10204b2cc:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2d0:     	ldr	x1, [x8, #0x9b0] ; selector: OnApproveGroupMember:
10204b2d4:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b2d8:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2dc:     	ldr	x1, [x8, #0x970] ; selector: OnUpgradeChatRoom:
10204b2e0:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b2e4:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2e8:     	ldr	x1, [x8, #0x9e0] ; selector: OnGetUpgradeAssociateAtRoomManageInfo:
10204b2ec:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b2f0:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b2f4:     	ldr	x1, [x8, #0x990] ; selector: OnInviteChatRoomMemberResp:
10204b2f8:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b2fc:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b300:     	ldr	x1, [x8, #0x9f8] ; selector: OnDismissChatRoomResp:
10204b304:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b308:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b30c:     	ldr	x1, [x8, #0x9c8] ; selector: OnDeleteGroupAdmin:
10204b310:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b314:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b318:     	ldr	x1, [x8, #0x9f0] ; selector: OnSetRoomtToolSalterWXapp:
10204b31c:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b320:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b324:     	ldr	x1, [x8, #0x988] ; selector: OnGetChatRoomMemberDetail:
10204b328:     	b	0x10204b334 <_Flutter_Image_provideRelativePathByUrl+0x2d37c0>
10204b32c:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b330:     	ldr	x1, [x8, #0x9e8] ; selector: OnUpgradeAssociateChatRoom:
10204b334:     	mov	x0, x20
10204b338:     	mov	x2, x19
10204b33c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b340:     	mov	x0, x19
10204b344:     	ldp	x29, x30, [sp, #0x20]
10204b348:     	ldp	x20, x19, [sp, #0x10]
10204b34c:     	ldp	x22, x21, [sp], #0x30
10204b350:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10204b354:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
10204b358:     	ldr	x1, [x8, #0xa08] ; selector: OpenIMMessageReturn:Event:
10204b35c:     	mov	x0, x20
10204b360:     	mov	x2, x19
10204b364:     	mov	x3, x21
10204b368:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10204b36c:     	b	0x10204b340 <_Flutter_Image_provideRelativePathByUrl+0x2d37cc>
