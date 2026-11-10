
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a18de4: d10183ff    	sub	sp, sp, #0x60
101a18de8: a90357f6    	stp	x22, x21, [sp, #0x30]
101a18dec: a9044ff4    	stp	x20, x19, [sp, #0x40]
101a18df0: a9057bfd    	stp	x29, x30, [sp, #0x50]
101a18df4: 910143fd    	add	x29, sp, #0x50
101a18df8: aa0003f3    	mov	x19, x0
101a18dfc: b00ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a18e00: 52800029    	mov	w9, #0x1                ; =1
101a18e04: 393b1909    	strb	w9, [x8, #0xec6]
101a18e08: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18e0c: b98cdd08    	ldrsw	x8, [x8, #0xcdc] ; ivar: FavAudioPlayer.m_playStat offset=28
101a18e10: 52800029    	mov	w9, #0x1                ; =1
101a18e14: 72a01fe9    	movk	w9, #0xff, lsl #16
101a18e18: b8286809    	str	w9, [x0, x8]
101a18e1c: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18e20: b98ce908    	ldrsw	x8, [x8, #0xce8] ; ivar: FavAudioPlayer.m_uiLastPlayedTime offset=48
101a18e24: b828681f    	str	wzr, [x0, x8]
101a18e28: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18e2c: f9434900    	ldr	x0, [x8, #0x690]
101a18e30: 95883b76    	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
101a18e34: d00e7dc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
101a18e38: f9405901    	ldr	x1, [x8, #0xb0] ; selector: initWithTimeIntervalSinceNow:
101a18e3c: 9e6703e0    	fmov	d0, xzr
101a18e40: 95883b89    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18e44: aa0003f4    	mov	x20, x0
101a18e48: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18e4c: f9447101    	ldr	x1, [x8, #0x8e0] ; selector: setM_lastStartTime:
101a18e50: aa1303e0    	mov	x0, x19
101a18e54: aa1403e2    	mov	x2, x20
101a18e58: 95883b83    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18e5c: 900e7de8    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
101a18e60: f9435d01    	ldr	x1, [x8, #0x6b8] ; selector: startTimer
101a18e64: aa1303e0    	mov	x0, x19
101a18e68: 95883b7f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18e6c: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18e70: f943c100    	ldr	x0, [x8, #0x780]
101a18e74: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a18e78: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a18e7c: 95883b7a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18e80: aa1d03fd    	mov	x29, x29
101a18e84: 95883b7f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18e88: aa0003f5    	mov	x21, x0
101a18e8c: 900e97c8    	adrp	x8, 0x11ed10000 <dyld_stub_binder+0x11ed10000>
101a18e90: f9402d02    	ldr	x2, [x8, #0x58]
101a18e94: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18e98: f944a903    	ldr	x3, [x8, #0x950] ; selector: OnBeginPlay:
101a18e9c: 900de9a8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
101a18ea0: f9449908    	ldr	x8, [x8, #0x930]
101a18ea4: f90007e8    	str	x8, [sp, #0x8]
101a18ea8: f00af568    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
101a18eac: fd434100    	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
101a18eb0: 90000008    	adrp	x8, 0x101a18000 <__text+0x1a10000>
101a18eb4: 913c0108    	add	x8, x8, #0xf00
101a18eb8: 900d4349    	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
101a18ebc: 911f8129    	add	x9, x9, #0x7e0
101a18ec0: fd000be0    	str	d0, [sp, #0x10]
101a18ec4: a901a7e8    	stp	x8, x9, [sp, #0x18]
101a18ec8: f90017f3    	str	x19, [sp, #0x28]
101a18ecc: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a18ed0: f9472d01    	ldr	x1, [x8, #0xe58] ; selector: callExtension:selector:block:
101a18ed4: 910023e4    	add	x4, sp, #0x8
101a18ed8: 95883b63    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18edc: aa1503e0    	mov	x0, x21
101a18ee0: 95883b64    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18ee4: aa1403e0    	mov	x0, x20
101a18ee8: 95883b62    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18eec: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101a18ef0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101a18ef4: a94357f6    	ldp	x22, x21, [sp, #0x30]
101a18ef8: 910183ff    	add	sp, sp, #0x60
101a18efc: d65f03c0    	ret
101a18f00: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101a18f04: a9014ff4    	stp	x20, x19, [sp, #0x10]
101a18f08: a9027bfd    	stp	x29, x30, [sp, #0x20]
101a18f0c: 910083fd    	add	x29, sp, #0x20
101a18f10: aa0103f3    	mov	x19, x1
101a18f14: f9401008    	ldr	x8, [x0, #0x20]
101a18f18: d00e9bc9    	adrp	x9, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18f1c: b98ced29    	ldrsw	x9, [x9, #0xcec] ; ivar: FavAudioPlayer.m_curAudioInfo offset=8
101a18f20: f8696914    	ldr	x20, [x8, x9]
101a18f24: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18f28: f944ad15    	ldr	x21, [x8, #0x958] ; selector: m_nsAudioID
101a18f2c: aa0103e0    	mov	x0, x1
101a18f30: 95883b51    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a18f34: aa1403e0    	mov	x0, x20
101a18f38: aa1503e1    	mov	x1, x21
101a18f3c: 95883b4a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18f40: aa1d03fd    	mov	x29, x29
101a18f44: 95883b4f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18f48: aa0003f4    	mov	x20, x0
101a18f4c: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18f50: f944a901    	ldr	x1, [x8, #0x950] ; selector: OnBeginPlay:
101a18f54: aa1303e0    	mov	x0, x19
101a18f58: aa1403e2    	mov	x2, x20
101a18f5c: 95883b42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18f60: aa1303e0    	mov	x0, x19
101a18f64: 95883b43    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18f68: aa1403e0    	mov	x0, x20
101a18f6c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101a18f70: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101a18f74: a8c357f6    	ldp	x22, x21, [sp], #0x30
101a18f78: 15883b3e    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
