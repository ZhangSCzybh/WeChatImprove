
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10658c814: d10143ff    	sub	sp, sp, #0x50
10658c818: a90257f6    	stp	x22, x21, [sp, #0x20]
10658c81c: a9034ff4    	stp	x20, x19, [sp, #0x30]
10658c820: a9047bfd    	stp	x29, x30, [sp, #0x40]
10658c824: 910103fd    	add	x29, sp, #0x40
10658c828: aa0003f3    	mov	x19, x0
10658c82c: f00c8e48    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
10658c830: 52800029    	mov	w9, #0x1                ; =1
10658c834: 39090109    	strb	w9, [x8, #0x240]
10658c838: d00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658c83c: f9430d14    	ldr	x20, [x8, #0x618]
10658c840: d00c2208    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10658c844: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
10658c848: 945a6d07    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c84c: aa1d03fd    	mov	x29, x29
10658c850: 945a6d0c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658c854: aa0003f5    	mov	x21, x0
10658c858: 900c2208    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10658c85c: f947e501    	ldr	x1, [x8, #0xfc8] ; selector: m_uiMesLocalID
10658c860: 945a6d01    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c864: d00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658c868: b98d1516    	ldrsw	x22, [x8, #0xd14] ; ivar: VoiceMessageViewModel.m_startPlayCount offset=116
10658c86c: b00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658c870: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10658c874: b8766a68    	ldr	w8, [x19, x22]
10658c878: a900a3e0    	stp	x0, x8, [sp, #0x8]
10658c87c: f00b7068    	adrp	x8, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
10658c880: 913c6108    	add	x8, x8, #0xf18 ; CFString: start playing %u %u
10658c884: f90003e8    	str	x8, [sp]
10658c888: b009eee5    	adrp	x5, 0x11a369000 <dyld_stub_binder+0x11a369000>
10658c88c: 911fb4a5    	add	x5, x5, #0x7ed
10658c890: b009eee7    	adrp	x7, 0x11a369000 <dyld_stub_binder+0x11a369000>
10658c894: 9126b8e7    	add	x7, x7, #0x9ae
10658c898: aa1403e0    	mov	x0, x20
10658c89c: 52800042    	mov	w2, #0x2                ; =2
10658c8a0: d2800003    	mov	x3, #0x0                ; =0
10658c8a4: 52800004    	mov	w4, #0x0                ; =0
10658c8a8: 528050e6    	mov	w6, #0x287              ; =647
10658c8ac: 945a6cee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c8b0: aa1503e0    	mov	x0, x21
10658c8b4: 945a6cef    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658c8b8: b8766a68    	ldr	w8, [x19, x22]
10658c8bc: 11000508    	add	w8, w8, #0x1
10658c8c0: b8366a68    	str	w8, [x19, x22]
10658c8c4: f00c2328    	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
10658c8c8: f942c101    	ldr	x1, [x8, #0x580] ; selector: setIsPlaying:
10658c8cc: aa1303e0    	mov	x0, x19
10658c8d0: 52800022    	mov	w2, #0x1                ; =1
10658c8d4: 945a6ce4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c8d8: f00c2208    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
10658c8dc: f9410101    	ldr	x1, [x8, #0x200] ; selector: cellView
10658c8e0: aa1303e0    	mov	x0, x19
10658c8e4: 945a6ce0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c8e8: aa1d03fd    	mov	x29, x29
10658c8ec: 945a6ce5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658c8f0: aa0003f4    	mov	x20, x0
10658c8f4: d00c26c8    	adrp	x8, 0x11ea66000 <dyld_stub_binder+0x11ea66000>
10658c8f8: f9418501    	ldr	x1, [x8, #0x308] ; selector: startPlaying
10658c8fc: 945a6cda    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c900: aa1403e0    	mov	x0, x20
10658c904: 945a6cdb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658c908: d00c3c28    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658c90c: f9447500    	ldr	x0, [x8, #0x8e8]
10658c910: b00c2b68    	adrp	x8, 0x11eaf9000 <dyld_stub_binder+0x11eaf9000>
10658c914: f9467903    	ldr	x3, [x8, #0xcf0] ; selector: timerEvent
10658c918: d00c21e8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10658c91c: f9416101    	ldr	x1, [x8, #0x2c0] ; selector: scheduledNoRetainTimerWithTimeInterval:target:selector:userInfo:repeats:
10658c920: f00899c8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10658c924: fd444900    	ldr	d0, [x8, #0x890] ; constant double=0.3
10658c928: aa1303e2    	mov	x2, x19
10658c92c: d2800004    	mov	x4, #0x0                ; =0
10658c930: 52800025    	mov	w5, #0x1                ; =1
10658c934: 945a6ccc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c938: aa1d03fd    	mov	x29, x29
10658c93c: 945a6cd1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658c940: d00c4268    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658c944: b98d3114    	ldrsw	x20, [x8, #0xd30] ; ivar: VoiceMessageViewModel.m_playingTimer offset=120
10658c948: f8746a68    	ldr	x8, [x19, x20]
10658c94c: f8346a60    	str	x0, [x19, x20]
10658c950: aa0803e0    	mov	x0, x8
10658c954: 945a6cc7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658c958: f8746a60    	ldr	x0, [x19, x20]
10658c95c: d00c2248    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
10658c960: f944a501    	ldr	x1, [x8, #0x948] ; selector: m_timer
10658c964: 945a6cc0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c968: aa1d03fd    	mov	x29, x29
10658c96c: 945a6cc5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658c970: aa0003f3    	mov	x19, x0
10658c974: b00c26e8    	adrp	x8, 0x11ea69000 <dyld_stub_binder+0x11ea69000>
10658c978: f9431d01    	ldr	x1, [x8, #0x638] ; selector: fire
10658c97c: 945a6cba    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658c980: aa1303e0    	mov	x0, x19
10658c984: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10658c988: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10658c98c: a94257f6    	ldp	x22, x21, [sp, #0x20]
10658c990: 910143ff    	add	sp, sp, #0x50
10658c994: 145a6cb7    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
