
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a7568c: d10143ff    	sub	sp, sp, #0x50
101a75690: a9015ff8    	stp	x24, x23, [sp, #0x10]
101a75694: a90257f6    	stp	x22, x21, [sp, #0x20]
101a75698: a9034ff4    	stp	x20, x19, [sp, #0x30]
101a7569c: a9047bfd    	stp	x29, x30, [sp, #0x40]
101a756a0: 910103fd    	add	x29, sp, #0x40
101a756a4: aa0503f6    	mov	x22, x5
101a756a8: aa0403f5    	mov	x21, x4
101a756ac: aa0303f4    	mov	x20, x3
101a756b0: aa0203f3    	mov	x19, x2
101a756b4: aa0003f7    	mov	x23, x0
101a756b8: b00ee688    	adrp	x8, 0x11f746000 <dyld_stub_binder+0x11f746000>
101a756bc: 52800029    	mov	w9, #0x1                ; =1
101a756c0: 3900f509    	strb	w9, [x8, #0x3d]
101a756c4: aa0203e0    	mov	x0, x2
101a756c8: 9586c96b    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a756cc: aa1403e0    	mov	x0, x20
101a756d0: 9586c969    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a756d4: aa1503e0    	mov	x0, x21
101a756d8: 9586c967    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a756dc: d00e9728    	adrp	x8, 0x11ed5b000 <dyld_stub_binder+0x11ed5b000>
101a756e0: f9463508    	ldr	x8, [x8, #0xc68]
101a756e4: a90023f7    	stp	x23, x8, [sp]
101a756e8: f00e9188    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101a756ec: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
101a756f0: 910003e0    	mov	x0, sp
101a756f4: 9586c95d    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
101a756f8: aa0003f7    	mov	x23, x0
101a756fc: b40002a0    	cbz	x0, 0x101a75750 <__text+0x1a6d750>
101a75700: d00e7e88    	adrp	x8, 0x11ea47000 <dyld_stub_binder+0x11ea47000>
101a75704: f943f501    	ldr	x1, [x8, #0x7e8] ; selector: setParent:
101a75708: aa1703e0    	mov	x0, x23
101a7570c: aa1303e2    	mov	x2, x19
101a75710: 9586c955    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a75714: d00e98e8    	adrp	x8, 0x11ed93000 <dyld_stub_binder+0x11ed93000>
101a75718: b982b508    	ldrsw	x8, [x8, #0x2b4] ; ivar: FavDataItemWrap.m_dataItem offset=8
101a7571c: 8b0802e0    	add	x0, x23, x8
101a75720: aa1403e1    	mov	x1, x20
101a75724: 9586c95e    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
101a75728: d00e98e8    	adrp	x8, 0x11ed93000 <dyld_stub_binder+0x11ed93000>
101a7572c: b982b908    	ldrsw	x8, [x8, #0x2b8] ; ivar: FavDataItemWrap.m_dataList offset=32
101a75730: 8b0802e0    	add	x0, x23, x8
101a75734: aa1503e1    	mov	x1, x21
101a75738: 9586c959    	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
101a7573c: f00e7b08    	adrp	x8, 0x11e9d8000 <dyld_stub_binder+0x11e9d8000>
101a75740: f9438501    	ldr	x1, [x8, #0x708] ; selector: setIndex:
101a75744: aa1703e0    	mov	x0, x23
101a75748: aa1603e2    	mov	x2, x22
101a7574c: 9586c946    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a75750: aa1503e0    	mov	x0, x21
101a75754: 9586c947    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a75758: aa1403e0    	mov	x0, x20
101a7575c: 9586c945    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a75760: aa1303e0    	mov	x0, x19
101a75764: 9586c943    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a75768: aa1703e0    	mov	x0, x23
101a7576c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101a75770: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101a75774: a94257f6    	ldp	x22, x21, [sp, #0x20]
101a75778: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101a7577c: 910143ff    	add	sp, sp, #0x50
101a75780: d65f03c0    	ret
