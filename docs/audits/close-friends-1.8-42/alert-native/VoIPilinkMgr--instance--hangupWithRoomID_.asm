
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062552a0: d10183ff    	sub	sp, sp, #0x60
1062552a4: a90167fa    	stp	x26, x25, [sp, #0x10]
1062552a8: a9025ff8    	stp	x24, x23, [sp, #0x20]
1062552ac: a90357f6    	stp	x22, x21, [sp, #0x30]
1062552b0: a9044ff4    	stp	x20, x19, [sp, #0x40]
1062552b4: a9057bfd    	stp	x29, x30, [sp, #0x50]
1062552b8: 910143fd    	add	x29, sp, #0x50
1062552bc: aa0203f4    	mov	x20, x2
1062552c0: aa0003f3    	mov	x19, x0
1062552c4: d00d4f68    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062552c8: 52800029    	mov	w9, #0x1                ; =1
1062552cc: 3925bd09    	strb	w9, [x8, #0x96f]
1062552d0: d00cf8e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1062552d4: f9453500    	ldr	x0, [x8, #0xa68] ; class=iConsole
1062552d8: 900cdf28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062552dc: f942a901    	ldr	x1, [x8, #0x550] ; selector=logWithLevel:module:errorCode:file:line:func:format:
1062552e0: f00c3108    	adrp	x8, 0x11e878000 <dyld_stub_binder+0x11e878000>
1062552e4: 9139a108    	add	x8, x8, #0xe68 ; cfstring='[voip-ilink] hangup'
1062552e8: f90003e8    	str	x8, [sp]
1062552ec: 900a9163    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
1062552f0: 91056463    	add	x3, x3, #0x159 ; cstring='MMConfSDK'
1062552f4: b00aba45    	adrp	x5, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
1062552f8: 911120a5    	add	x5, x5, #0x448 ; cstring='VoIPilinkMgr.mm'
1062552fc: d00aba47    	adrp	x7, 0x11b99f000 <dyld_stub_binder+0x11b99f000>
106255300: 910ea0e7    	add	x7, x7, #0x3a8 ; cstring='-[VoIPilinkMgr hangupWithRoomID:]'
106255304: 52800042    	mov	w2, #0x2                ; =2
106255308: 52800004    	mov	w4, #0x0                ; =0
10625530c: 5280a1c6    	mov	w6, #0x50e              ; =1294
106255310: 9467478b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255314: d00cebe8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106255318: f942fd01    	ldr	x1, [x8, #0x5f8] ; selector=setIsAlreadyHangup:
10625531c: aa1303e0    	mov	x0, x19
106255320: 52800022    	mov	w2, #0x1                ; =1
106255324: 94674786    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255328: d00cf8fa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10625532c: f945eb40    	ldr	x0, [x26, #0xbd0] ; class=MMContext
106255330: f00cf548    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106255334: f944e915    	ldr	x21, [x8, #0x9d0] ; selector=currentContext
106255338: aa1503e1    	mov	x1, x21
10625533c: 94674780    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255340: aa1d03fd    	mov	x29, x29
106255344: 94674781    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106255348: aa0003f8    	mov	x24, x0
10625534c: d00cf928    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
106255350: f945c900    	ldr	x0, [x8, #0xb90] ; class=VoIPConfSDKService
106255354: d00cf548    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106255358: f947ad16    	ldr	x22, [x8, #0xf58] ; selector=class
10625535c: aa1603e1    	mov	x1, x22
106255360: 94674777    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255364: aa0003e2    	mov	x2, x0
106255368: 900cdf28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10625536c: f9464117    	ldr	x23, [x8, #0xc80] ; selector=getService:
106255370: aa1803e0    	mov	x0, x24
106255374: aa1703e1    	mov	x1, x23
106255378: 94674771    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625537c: aa1d03fd    	mov	x29, x29
106255380: 94674772    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106255384: aa0003f9    	mov	x25, x0
106255388: b00ce508    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10625538c: f9431d01    	ldr	x1, [x8, #0x638] ; selector=hangup:roomID:
106255390: 52800022    	mov	w2, #0x1                ; =1
106255394: aa1403e3    	mov	x3, x20
106255398: 94674769    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10625539c: aa1903e0    	mov	x0, x25
1062553a0: 9467476d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062553a4: aa1803e0    	mov	x0, x24
1062553a8: 9467476b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062553ac: b00ce508    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1062553b0: f9402d01    	ldr	x1, [x8, #0x58] ; selector=changeToMultiTalk
1062553b4: aa1303e0    	mov	x0, x19
1062553b8: 94674761    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062553bc: 340003e0    	cbz	w0, 0x106255438 <_Flutter_MMFoundation_BindContext+0x273101c>
1062553c0: f945eb40    	ldr	x0, [x26, #0xbd0] ; class=MMContext
1062553c4: aa1503e1    	mov	x1, x21
1062553c8: 9467475d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062553cc: aa1d03fd    	mov	x29, x29
1062553d0: 9467475e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062553d4: aa0003f3    	mov	x19, x0
1062553d8: d00cf928    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1062553dc: f940fd00    	ldr	x0, [x8, #0x1f8] ; class=VoIPilinkMgr
1062553e0: aa1603e1    	mov	x1, x22
1062553e4: 94674756    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062553e8: aa0003e2    	mov	x2, x0
1062553ec: aa1303e0    	mov	x0, x19
1062553f0: aa1703e1    	mov	x1, x23
1062553f4: 94674752    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062553f8: aa1d03fd    	mov	x29, x29
1062553fc: 94674753    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106255400: aa0003f4    	mov	x20, x0
106255404: f00cea48    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
106255408: f946f501    	ldr	x1, [x8, #0xde8] ; selector=StopSession
10625540c: 9467474c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255410: aa1403e0    	mov	x0, x20
106255414: 94674750    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106255418: aa1303e0    	mov	x0, x19
10625541c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106255420: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106255424: a94357f6    	ldp	x22, x21, [sp, #0x30]
106255428: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10625542c: a94167fa    	ldp	x26, x25, [sp, #0x10]
106255430: 910183ff    	add	sp, sp, #0x60
106255434: 14674748    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106255438: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10625543c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106255440: a94357f6    	ldp	x22, x21, [sp, #0x30]
106255444: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106255448: a94167fa    	ldp	x26, x25, [sp, #0x10]
10625544c: 910183ff    	add	sp, sp, #0x60
106255450: d65f03c0    	ret
