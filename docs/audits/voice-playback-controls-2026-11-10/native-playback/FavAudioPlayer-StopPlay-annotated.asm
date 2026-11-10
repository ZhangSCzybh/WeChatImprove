
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a1880c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101a18810: a90157f6    	stp	x22, x21, [sp, #0x10]
101a18814: a9024ff4    	stp	x20, x19, [sp, #0x20]
101a18818: a9037bfd    	stp	x29, x30, [sp, #0x30]
101a1881c: 9100c3fd    	add	x29, sp, #0x30
101a18820: aa0003f3    	mov	x19, x0
101a18824: b00ee968    	adrp	x8, 0x11f745000 <dyld_stub_binder+0x11f745000>
101a18828: 52800029    	mov	w9, #0x1                ; =1
101a1882c: 393b0d09    	strb	w9, [x8, #0xec3]
101a18830: d00e7f28    	adrp	x8, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
101a18834: f9444d15    	ldr	x21, [x8, #0x898] ; selector: audioPlayer
101a18838: aa1503e1    	mov	x1, x21
101a1883c: 95883d0a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18840: aa1d03fd    	mov	x29, x29
101a18844: 95883d0f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18848: aa0003f4    	mov	x20, x0
101a1884c: 95883d09    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18850: b40008f4    	cbz	x20, 0x101a1896c <__text+0x1a1096c>
101a18854: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18858: f9449116    	ldr	x22, [x8, #0x920] ; selector: audioModuleScene
101a1885c: aa1303e0    	mov	x0, x19
101a18860: aa1603e1    	mov	x1, x22
101a18864: 95883d00    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18868: 7100341f    	cmp	w0, #0xd
101a1886c: 54000480    	b.eq	0x101a188fc <__text+0x1a108fc>
101a18870: d00e97c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101a18874: f943c100    	ldr	x0, [x8, #0x780]
101a18878: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a1887c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
101a18880: 95883cf9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18884: aa1d03fd    	mov	x29, x29
101a18888: 95883cfe    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a1888c: aa0003f7    	mov	x23, x0
101a18890: 900e97e8    	adrp	x8, 0x11ed14000 <dyld_stub_binder+0x11ed14000>
101a18894: f9401d00    	ldr	x0, [x8, #0x38]
101a18898: d00e9468    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101a1889c: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
101a188a0: 95883cf1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a188a4: aa0003e2    	mov	x2, x0
101a188a8: b00e7d88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101a188ac: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
101a188b0: aa1703e0    	mov	x0, x23
101a188b4: 95883cec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a188b8: aa1d03fd    	mov	x29, x29
101a188bc: 95883cf1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a188c0: aa0003f8    	mov	x24, x0
101a188c4: aa1303e0    	mov	x0, x19
101a188c8: aa1603e1    	mov	x1, x22
101a188cc: 95883ce6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a188d0: aa0003e3    	mov	x3, x0
101a188d4: f00e7dc8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
101a188d8: f9440101    	ldr	x1, [x8, #0x800] ; selector: setActive:scene:listener:
101a188dc: aa1803e0    	mov	x0, x24
101a188e0: 52800002    	mov	w2, #0x0                ; =0
101a188e4: aa1303e4    	mov	x4, x19
101a188e8: 95883cdf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a188ec: aa1803e0    	mov	x0, x24
101a188f0: 95883ce0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a188f4: aa1703e0    	mov	x0, x23
101a188f8: 95883cde    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a188fc: aa1303e0    	mov	x0, x19
101a18900: aa1503e1    	mov	x1, x21
101a18904: 95883cd8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18908: aa1d03fd    	mov	x29, x29
101a1890c: 95883cdd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a18910: aa0003f5    	mov	x21, x0
101a18914: b00e94a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
101a18918: f941d901    	ldr	x1, [x8, #0x3b0] ; selector: stop
101a1891c: 95883cd2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18920: aa1503e0    	mov	x0, x21
101a18924: 95883cd3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a18928: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a1892c: f9449901    	ldr	x1, [x8, #0x930] ; selector: stopTimer
101a18930: aa1303e0    	mov	x0, x19
101a18934: 95883ccc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18938: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a1893c: b98cdd08    	ldrsw	x8, [x8, #0xcdc] ; ivar: FavAudioPlayer.m_playStat offset=28
101a18940: 52800069    	mov	w9, #0x3                ; =3
101a18944: 72a01fe9    	movk	w9, #0xff, lsl #16
101a18948: b8286a69    	str	w9, [x19, x8]
101a1894c: b00e8168    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
101a18950: f9446901    	ldr	x1, [x8, #0x8d0] ; selector: setM_curAudioInfo:
101a18954: aa1303e0    	mov	x0, x19
101a18958: d2800002    	mov	x2, #0x0                ; =0
101a1895c: 95883cc2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a18960: d00e9bc8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
101a18964: b98cf108    	ldrsw	x8, [x8, #0xcf0] ; ivar: FavAudioPlayer.m_uiAudioOffset offset=24
101a18968: b8286a7f    	str	wzr, [x19, x8]
101a1896c: f100029f    	cmp	x20, #0x0
101a18970: 1a9f07e0    	cset	w0, ne
101a18974: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101a18978: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101a1897c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101a18980: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101a18984: d65f03c0    	ret
