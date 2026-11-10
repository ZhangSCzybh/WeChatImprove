
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10658a078: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10658a07c: a90157f6    	stp	x22, x21, [sp, #0x10]
10658a080: a9024ff4    	stp	x20, x19, [sp, #0x20]
10658a084: a9037bfd    	stp	x29, x30, [sp, #0x30]
10658a088: 9100c3fd    	add	x29, sp, #0x30
10658a08c: aa0003f3    	mov	x19, x0
10658a090: 900c3c48    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10658a094: f943c100    	ldr	x0, [x8, #0x780]
10658a098: f00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658a09c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
10658a0a0: 945a76f1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658a0a4: aa1d03fd    	mov	x29, x29
10658a0a8: 945a76f6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658a0ac: aa0003f4    	mov	x20, x0
10658a0b0: f00c3c48    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10658a0b4: f940fd00    	ldr	x0, [x8, #0x1f8]
10658a0b8: 900c38e8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10658a0bc: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
10658a0c0: 945a76e9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658a0c4: aa0003e2    	mov	x2, x0
10658a0c8: f00c21e8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10658a0cc: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
10658a0d0: aa1403e0    	mov	x0, x20
10658a0d4: 945a76e4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658a0d8: aa1d03fd    	mov	x29, x29
10658a0dc: 945a76e9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658a0e0: aa0003f5    	mov	x21, x0
10658a0e4: 900c2228    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
10658a0e8: f941bd01    	ldr	x1, [x8, #0x378] ; selector: messageWrap
10658a0ec: aa1303e0    	mov	x0, x19
10658a0f0: 945a76dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658a0f4: aa1d03fd    	mov	x29, x29
10658a0f8: 945a76e2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10658a0fc: aa0003f6    	mov	x22, x0
10658a100: 900c22a8    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
10658a104: f942d501    	ldr	x1, [x8, #0x5a8] ; selector: isMsgPlaying:
10658a108: aa1503e0    	mov	x0, x21
10658a10c: aa1603e2    	mov	x2, x22
10658a110: 945a76d5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10658a114: aa0003f7    	mov	x23, x0
10658a118: aa1603e0    	mov	x0, x22
10658a11c: 945a76d5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658a120: aa1503e0    	mov	x0, x21
10658a124: 945a76d3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658a128: aa1403e0    	mov	x0, x20
10658a12c: 945a76d1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10658a130: 36000077    	tbz	w23, #0x0, 0x10658a13c <_Flutter_MMFoundation_BindContext+0x2810e08>
10658a134: 52800028    	mov	w8, #0x1                ; =1
10658a138: 14000004    	b	0x10658a148 <_Flutter_MMFoundation_BindContext+0x2810e14>
10658a13c: 900c4288    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
10658a140: b98d2108    	ldrsw	x8, [x8, #0xd20] ; ivar: VoiceMessageViewModel._isPlaying offset=136
10658a144: 38686a68    	ldrb	w8, [x19, x8]
10658a148: 12000100    	and	w0, w8, #0x1
10658a14c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10658a150: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10658a154: a94157f6    	ldp	x22, x21, [sp, #0x10]
10658a158: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10658a15c: d65f03c0    	ret
