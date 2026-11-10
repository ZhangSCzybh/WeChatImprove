
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10529ad14: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10529ad18: a90167fa    	stp	x26, x25, [sp, #0x10]
10529ad1c: a9025ff8    	stp	x24, x23, [sp, #0x20]
10529ad20: a90357f6    	stp	x22, x21, [sp, #0x30]
10529ad24: a9044ff4    	stp	x20, x19, [sp, #0x40]
10529ad28: a9057bfd    	stp	x29, x30, [sp, #0x50]
10529ad2c: 910143fd    	add	x29, sp, #0x50
10529ad30: d10cc3ff    	sub	sp, sp, #0x330
10529ad34: aa0203fb    	mov	x27, x2
10529ad38: aa0003f4    	mov	x20, x0
10529ad3c: d00c2588    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10529ad40: f9451908    	ldr	x8, [x8, #0xa30]
10529ad44: f9400108    	ldr	x8, [x8]
10529ad48: f81a03a8    	stur	x8, [x29, #-0x60]
10529ad4c: 900d25c8    	adrp	x8, 0x11f752000 <dyld_stub_binder+0x11f752000>
10529ad50: 52800029    	mov	w9, #0x1                ; =1
10529ad54: 39358d09    	strb	w9, [x8, #0xd63]
10529ad58: aa0203e0    	mov	x0, x2
10529ad5c: 94a633c6    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529ad60: 900cd3c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529ad64: f9431900    	ldr	x0, [x8, #0x630]
10529ad68: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529ad6c: f947b901    	ldr	x1, [x8, #0xf70] ; selector: dictionary
10529ad70: 94a633bd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529ad74: aa1d03fd    	mov	x29, x29
10529ad78: 94a633c2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529ad7c: f9003fe0    	str	x0, [sp, #0x78]
10529ad80: 4f00e400    	movi.16b	v0, #0x0
10529ad84: ad0b03e0    	stp	q0, q0, [sp, #0x160]
10529ad88: ad0c03e0    	stp	q0, q0, [sp, #0x180]
10529ad8c: aa1b03e0    	mov	x0, x27
10529ad90: 94a633b9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529ad94: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529ad98: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10529ad9c: 910583e2    	add	x2, sp, #0x160
10529ada0: d10383a3    	sub	x3, x29, #0xe0
10529ada4: f90017e1    	str	x1, [sp, #0x28]
10529ada8: 52800204    	mov	w4, #0x10               ; =16
10529adac: 94a633ae    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529adb0: b00cd3dc    	adrp	x28, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529adb4: f00cb96b    	adrp	x11, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10529adb8: 900cd06a    	adrp	x10, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529adbc: f00cb969    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10529adc0: f90043f4    	str	x20, [sp, #0x80]
10529adc4: f90063fb    	str	x27, [sp, #0xc0]
10529adc8: b40028a0    	cbz	x0, 0x10529b2dc <_Flutter_MMFoundation_BindContext+0x1521fa8>
10529adcc: aa0003f3    	mov	x19, x0
10529add0: f940bbe8    	ldr	x8, [sp, #0x170]
10529add4: f9400115    	ldr	x21, [x8]
10529add8: f9003bf5    	str	x21, [sp, #0x70]
10529addc: d280001a    	mov	x26, #0x0               ; =0
10529ade0: f9428556    	ldr	x22, [x10, #0x508] ; selector: class
10529ade4: d00cd068    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10529ade8: f9444918    	ldr	x24, [x8, #0x890] ; selector: isKindOfClass:
10529adec: d00cba08    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10529adf0: f942cd0a    	ldr	x10, [x8, #0x598] ; selector: parent
10529adf4: f00cbd48    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
10529adf8: f9467908    	ldr	x8, [x8, #0xcf0] ; selector: isOnSearch
10529adfc: f9005fe8    	str	x8, [sp, #0xb8]
10529ae00: f00cbd48    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
10529ae04: f946c908    	ldr	x8, [x8, #0xd90] ; selector: selectedType
10529ae08: a90623ea    	stp	x10, x8, [sp, #0x60]
10529ae0c: f00cbd48    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
10529ae10: f947550a    	ldr	x10, [x8, #0xea8] ; selector: arrFavItem
10529ae14: 900cd068    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529ae18: f9442908    	ldr	x8, [x8, #0x850] ; selector: count
10529ae1c: f9002fe8    	str	x8, [sp, #0x58]
10529ae20: d00cd068    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10529ae24: f9402d08    	ldr	x8, [x8, #0x58] ; selector: indexOfObject:
10529ae28: f90013e8    	str	x8, [sp, #0x20]
10529ae2c: f00cbd48    	adrp	x8, 0x11ea45000 <dyld_stub_binder+0x11ea45000>
10529ae30: f9466d08    	ldr	x8, [x8, #0xcd8] ; selector: arrFavDataWrap
10529ae34: f9000fe8    	str	x8, [sp, #0x18]
10529ae38: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529ae3c: f944c508    	ldr	x8, [x8, #0x988] ; selector: getSearchListIndexForFinderItem:
10529ae40: a9032be8    	stp	x8, x10, [sp, #0x30]
10529ae44: d00cc4c8    	adrp	x8, 0x11eb34000 <dyld_stub_binder+0x11eb34000>
10529ae48: f944c108    	ldr	x8, [x8, #0x980] ; selector: getSearchListIndexForImageDataWrap:
10529ae4c: f9002be8    	str	x8, [sp, #0x50]
10529ae50: f944017b    	ldr	x27, [x11, #0x800] ; selector: currentContext
10529ae54: f9452139    	ldr	x25, [x9, #0xa40] ; selector: getService:
10529ae58: b00cba48    	adrp	x8, 0x11e9e3000 <dyld_stub_binder+0x11e9e3000>
10529ae5c: f9451109    	ldr	x9, [x8, #0xa20] ; selector: updateTime
10529ae60: 900cbd68    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
10529ae64: f942dd08    	ldr	x8, [x8, #0x5b8] ; selector: getFavIndexByUpdateTime:
10529ae68: a90aa7e8    	stp	x8, x9, [sp, #0xa8]
10529ae6c: d00cbd68    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
10529ae70: f9449109    	ldr	x9, [x8, #0x920] ; selector: paramWithIsSearchResult:searchListIndex:favListIndex:
10529ae74: f00cb9c8    	adrp	x8, 0x11e9d5000 <dyld_stub_binder+0x11e9d5000>
10529ae78: f946e108    	ldr	x8, [x8, #0xdc0] ; selector: localId
10529ae7c: a909a7e8    	stp	x8, x9, [sp, #0x98]
10529ae80: f00cd068    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10529ae84: f942ed09    	ldr	x9, [x8, #0x5d8] ; selector: numberWithUnsignedInt:
10529ae88: d00cd088    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
10529ae8c: f9414d08    	ldr	x8, [x8, #0x298] ; selector: setObject:forKeyedSubscript:
10529ae90: a908a7e8    	stp	x8, x9, [sp, #0x88]
10529ae94: a90ce3fb    	stp	x27, x24, [sp, #0xc8]
10529ae98: f9006ff3    	str	x19, [sp, #0xd8]
10529ae9c: f940bbe8    	ldr	x8, [sp, #0x170]
10529aea0: f9400108    	ldr	x8, [x8]
10529aea4: eb15011f    	cmp	x8, x21
10529aea8: 54000060    	b.eq	0x10529aeb4 <_Flutter_MMFoundation_BindContext+0x1521b80>
10529aeac: f94063e0    	ldr	x0, [sp, #0xc0]
10529aeb0: 94a63363    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10529aeb4: f940b7e8    	ldr	x8, [sp, #0x168]
10529aeb8: f87a7917    	ldr	x23, [x8, x26, lsl #3]
10529aebc: f944df80    	ldr	x0, [x28, #0x9b8]
10529aec0: aa1603e1    	mov	x1, x22
10529aec4: 94a63368    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aec8: aa0003e2    	mov	x2, x0
10529aecc: aa1703e0    	mov	x0, x23
10529aed0: aa1803e1    	mov	x1, x24
10529aed4: 94a63364    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aed8: 340000c0    	cbz	w0, 0x10529aef0 <_Flutter_MMFoundation_BindContext+0x1521bbc>
10529aedc: aa1703e0    	mov	x0, x23
10529aee0: 94a63365    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529aee4: d280001c    	mov	x28, #0x0               ; =0
10529aee8: b5000297    	cbnz	x23, 0x10529af38 <_Flutter_MMFoundation_BindContext+0x1521c04>
10529aeec: 14000075    	b	0x10529b0c0 <_Flutter_MMFoundation_BindContext+0x1521d8c>
10529aef0: b00cd428    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
10529aef4: f9407900    	ldr	x0, [x8, #0xf0]
10529aef8: aa1603e1    	mov	x1, x22
10529aefc: 94a6335a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529af00: aa0003e2    	mov	x2, x0
10529af04: aa1703e0    	mov	x0, x23
10529af08: aa1803e1    	mov	x1, x24
10529af0c: 94a63356    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529af10: 34000340    	cbz	w0, 0x10529af78 <_Flutter_MMFoundation_BindContext+0x1521c44>
10529af14: aa1703e0    	mov	x0, x23
10529af18: 94a63357    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529af1c: f94033e1    	ldr	x1, [sp, #0x60]
10529af20: 94a63351    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529af24: aa1d03fd    	mov	x29, x29
10529af28: 94a63356    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529af2c: aa1703fc    	mov	x28, x23
10529af30: aa0003f7    	mov	x23, x0
10529af34: b4000c77    	cbz	x23, 0x10529b0c0 <_Flutter_MMFoundation_BindContext+0x1521d8c>
10529af38: aa1403e0    	mov	x0, x20
10529af3c: f9405fe1    	ldr	x1, [sp, #0xb8]
10529af40: 94a63349    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529af44: aa0003f8    	mov	x24, x0
10529af48: 340001e0    	cbz	w0, 0x10529af84 <_Flutter_MMFoundation_BindContext+0x1521c50>
10529af4c: aa1403e0    	mov	x0, x20
10529af50: f94037e1    	ldr	x1, [sp, #0x68]
10529af54: 94a63344    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529af58: 52880148    	mov	w8, #0x400a             ; =16394
10529af5c: eb08001f    	cmp	x0, x8
10529af60: 54000161    	b.ne	0x10529af8c <_Flutter_MMFoundation_BindContext+0x1521c58>
10529af64: b400015c    	cbz	x28, 0x10529af8c <_Flutter_MMFoundation_BindContext+0x1521c58>
10529af68: aa1403e0    	mov	x0, x20
10529af6c: f9402be1    	ldr	x1, [sp, #0x50]
10529af70: aa1c03e2    	mov	x2, x28
10529af74: 1400000e    	b	0x10529afac <_Flutter_MMFoundation_BindContext+0x1521c78>
10529af78: d2800017    	mov	x23, #0x0               ; =0
10529af7c: d280001c    	mov	x28, #0x0               ; =0
10529af80: 14000050    	b	0x10529b0c0 <_Flutter_MMFoundation_BindContext+0x1521d8c>
10529af84: 52800014    	mov	w20, #0x0               ; =0
10529af88: 1400000b    	b	0x10529afb4 <_Flutter_MMFoundation_BindContext+0x1521c80>
10529af8c: aa1403e0    	mov	x0, x20
10529af90: f94037e1    	ldr	x1, [sp, #0x68]
10529af94: 94a63334    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529af98: f148001f    	cmp	x0, #0x200, lsl #12     ; =0x200000
10529af9c: 54000a41    	b.ne	0x10529b0e4 <_Flutter_MMFoundation_BindContext+0x1521db0>
10529afa0: aa1403e0    	mov	x0, x20
10529afa4: f9401be1    	ldr	x1, [sp, #0x30]
10529afa8: aa1703e2    	mov	x2, x23
10529afac: 94a6332e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529afb0: 11000414    	add	w20, w0, #0x1
10529afb4: 900cd3c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529afb8: f943c100    	ldr	x0, [x8, #0x780]
10529afbc: aa1b03e1    	mov	x1, x27
10529afc0: 94a63329    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529afc4: aa1d03fd    	mov	x29, x29
10529afc8: 94a6332e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529afcc: aa0003f3    	mov	x19, x0
10529afd0: b00cd3c8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529afd4: f9448500    	ldr	x0, [x8, #0x908]
10529afd8: aa1603e1    	mov	x1, x22
10529afdc: 94a63322    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529afe0: aa0003e2    	mov	x2, x0
10529afe4: aa1303e0    	mov	x0, x19
10529afe8: aa1903e1    	mov	x1, x25
10529afec: 94a6331e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529aff0: aa1d03fd    	mov	x29, x29
10529aff4: 94a63323    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529aff8: aa0003f5    	mov	x21, x0
10529affc: aa1703e0    	mov	x0, x23
10529b000: f9405be1    	ldr	x1, [sp, #0xb0]
10529b004: 94a63318    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b008: aa0003e2    	mov	x2, x0
10529b00c: aa1503e0    	mov	x0, x21
10529b010: f94057e1    	ldr	x1, [sp, #0xa8]
10529b014: 94a63314    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b018: aa1903fb    	mov	x27, x25
10529b01c: aa0003f9    	mov	x25, x0
10529b020: aa1503e0    	mov	x0, x21
10529b024: 94a63313    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b028: aa1303e0    	mov	x0, x19
10529b02c: 94a63311    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b030: 900cd428    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
10529b034: f9414900    	ldr	x0, [x8, #0x290]
10529b038: 11000724    	add	w4, w25, #0x1
10529b03c: aa1b03f9    	mov	x25, x27
10529b040: f94067fb    	ldr	x27, [sp, #0xc8]
10529b044: f94053e1    	ldr	x1, [sp, #0xa0]
10529b048: aa1803e2    	mov	x2, x24
10529b04c: aa1403e3    	mov	x3, x20
10529b050: 94a63305    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b054: aa1d03fd    	mov	x29, x29
10529b058: 94a6330a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b05c: aa0003f3    	mov	x19, x0
10529b060: f00cd3a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b064: f9436114    	ldr	x20, [x8, #0x6c0]
10529b068: aa1703e0    	mov	x0, x23
10529b06c: f9404fe1    	ldr	x1, [sp, #0x98]
10529b070: 94a632fd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b074: aa0003e2    	mov	x2, x0
10529b078: aa1403e0    	mov	x0, x20
10529b07c: f9404be1    	ldr	x1, [sp, #0x90]
10529b080: 94a632f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b084: aa1d03fd    	mov	x29, x29
10529b088: 94a632fe    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b08c: aa0003f4    	mov	x20, x0
10529b090: f9403fe0    	ldr	x0, [sp, #0x78]
10529b094: f94047e1    	ldr	x1, [sp, #0x88]
10529b098: aa1303e2    	mov	x2, x19
10529b09c: aa1403e3    	mov	x3, x20
10529b0a0: 94a632f1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b0a4: aa1403e0    	mov	x0, x20
10529b0a8: 94a632f2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b0ac: aa1303e0    	mov	x0, x19
10529b0b0: 94a632f0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b0b4: f94043f4    	ldr	x20, [sp, #0x80]
10529b0b8: a94d4ff8    	ldp	x24, x19, [sp, #0xd0]
10529b0bc: f9403bf5    	ldr	x21, [sp, #0x70]
10529b0c0: aa1c03e0    	mov	x0, x28
10529b0c4: 94a632eb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b0c8: aa1703e0    	mov	x0, x23
10529b0cc: 94a632e9    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b0d0: 9100075a    	add	x26, x26, #0x1
10529b0d4: eb13035f    	cmp	x26, x19
10529b0d8: 900cd3dc    	adrp	x28, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529b0dc: 54ffee01    	b.ne	0x10529ae9c <_Flutter_MMFoundation_BindContext+0x1521b68>
10529b0e0: 14000072    	b	0x10529b2a8 <_Flutter_MMFoundation_BindContext+0x1521f74>
10529b0e4: f00cd7a8    	adrp	x8, 0x11ed92000 <dyld_stub_binder+0x11ed92000>
10529b0e8: 9135f108    	add	x8, x8, #0xd7c
10529b0ec: b980011b    	ldrsw	x27, [x8] ; ivar: FavBaseListViewController.m_dataController offset=200
10529b0f0: f87b6a80    	ldr	x0, [x20, x27]
10529b0f4: f9401fe1    	ldr	x1, [sp, #0x38]
10529b0f8: 94a632db    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b0fc: aa1d03fd    	mov	x29, x29
10529b100: 94a632e0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b104: aa0003f3    	mov	x19, x0
10529b108: f9402fe1    	ldr	x1, [sp, #0x58]
10529b10c: 94a632d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b110: aa1403f5    	mov	x21, x20
10529b114: aa0003f4    	mov	x20, x0
10529b118: aa1303e0    	mov	x0, x19
10529b11c: 94a632d5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b120: f87b6aa0    	ldr	x0, [x21, x27]
10529b124: b40001f4    	cbz	x20, 0x10529b160 <_Flutter_MMFoundation_BindContext+0x1521e2c>
10529b128: f9401fe1    	ldr	x1, [sp, #0x38]
10529b12c: 94a632ce    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b130: aa1d03fd    	mov	x29, x29
10529b134: 94a632d3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b138: aa0003f3    	mov	x19, x0
10529b13c: f94013e1    	ldr	x1, [sp, #0x20]
10529b140: aa1703e2    	mov	x2, x23
10529b144: 94a632c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b148: aa0003f4    	mov	x20, x0
10529b14c: aa1303e0    	mov	x0, x19
10529b150: 94a632c8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b154: 11000694    	add	w20, w20, #0x1
10529b158: f94067fb    	ldr	x27, [sp, #0xc8]
10529b15c: 17ffff96    	b	0x10529afb4 <_Flutter_MMFoundation_BindContext+0x1521c80>
10529b160: f9000bf6    	str	x22, [sp, #0x10]
10529b164: f9400ff6    	ldr	x22, [sp, #0x18]
10529b168: aa1603e1    	mov	x1, x22
10529b16c: 94a632be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b170: aa1d03fd    	mov	x29, x29
10529b174: 94a632c3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b178: aa0003f3    	mov	x19, x0
10529b17c: f9402ff5    	ldr	x21, [sp, #0x58]
10529b180: aa1503e1    	mov	x1, x21
10529b184: 94a632b8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b188: aa0003f4    	mov	x20, x0
10529b18c: aa1303e0    	mov	x0, x19
10529b190: 94a632b8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b194: b4000854    	cbz	x20, 0x10529b29c <_Flutter_MMFoundation_BindContext+0x1521f68>
10529b198: f94043e8    	ldr	x8, [sp, #0x80]
10529b19c: f87b6900    	ldr	x0, [x8, x27]
10529b1a0: aa1603e1    	mov	x1, x22
10529b1a4: 94a632b0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b1a8: aa1d03fd    	mov	x29, x29
10529b1ac: 94a632b5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b1b0: aa0003f3    	mov	x19, x0
10529b1b4: aa1503e1    	mov	x1, x21
10529b1b8: 94a632ab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b1bc: aa0003f4    	mov	x20, x0
10529b1c0: aa1303e0    	mov	x0, x19
10529b1c4: 94a632ab    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b1c8: b40006b4    	cbz	x20, 0x10529b29c <_Flutter_MMFoundation_BindContext+0x1521f68>
10529b1cc: f90007f9    	str	x25, [sp, #0x8]
10529b1d0: d2800014    	mov	x20, #0x0               ; =0
10529b1d4: f00cb968    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
10529b1d8: f941b109    	ldr	x9, [x8, #0x360] ; selector: safeObjectAtIndex:
10529b1dc: b00cba08    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10529b1e0: f942cd08    	ldr	x8, [x8, #0x598] ; selector: parent
10529b1e4: a90427e8    	stp	x8, x9, [sp, #0x40]
10529b1e8: f94043f9    	ldr	x25, [sp, #0x80]
10529b1ec: f9400ff6    	ldr	x22, [sp, #0x18]
10529b1f0: f87b6b20    	ldr	x0, [x25, x27]
10529b1f4: aa1603e1    	mov	x1, x22
10529b1f8: 94a6329b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b1fc: aa1d03fd    	mov	x29, x29
10529b200: 94a632a0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b204: aa0003f5    	mov	x21, x0
10529b208: f94027e1    	ldr	x1, [sp, #0x48]
10529b20c: aa1403e2    	mov	x2, x20
10529b210: 94a63295    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b214: aa1d03fd    	mov	x29, x29
10529b218: 94a6329a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b21c: aa0003f3    	mov	x19, x0
10529b220: aa1503e0    	mov	x0, x21
10529b224: 94a63293    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b228: aa1303e0    	mov	x0, x19
10529b22c: f94023e1    	ldr	x1, [sp, #0x40]
10529b230: 94a6328d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b234: aa1d03fd    	mov	x29, x29
10529b238: 94a63292    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b23c: aa0003f5    	mov	x21, x0
10529b240: 94a6328c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b244: aa1303e0    	mov	x0, x19
10529b248: 94a6328a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b24c: eb1702bf    	cmp	x21, x23
10529b250: 54000220    	b.eq	0x10529b294 <_Flutter_MMFoundation_BindContext+0x1521f60>
10529b254: 91000694    	add	x20, x20, #0x1
10529b258: f87b6b20    	ldr	x0, [x25, x27]
10529b25c: aa1603e1    	mov	x1, x22
10529b260: 94a63281    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b264: aa1d03fd    	mov	x29, x29
10529b268: 94a63286    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b26c: aa0003f3    	mov	x19, x0
10529b270: f9402fe1    	ldr	x1, [sp, #0x58]
10529b274: 94a6327c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b278: aa0003f5    	mov	x21, x0
10529b27c: aa1303e0    	mov	x0, x19
10529b280: 94a6327c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b284: eb15029f    	cmp	x20, x21
10529b288: 54fffb43    	b.lo	0x10529b1f0 <_Flutter_MMFoundation_BindContext+0x1521ebc>
10529b28c: 52800014    	mov	w20, #0x0               ; =0
10529b290: 14000002    	b	0x10529b298 <_Flutter_MMFoundation_BindContext+0x1521f64>
10529b294: 11000694    	add	w20, w20, #0x1
10529b298: f94007f9    	ldr	x25, [sp, #0x8]
10529b29c: f94067fb    	ldr	x27, [sp, #0xc8]
10529b2a0: f9400bf6    	ldr	x22, [sp, #0x10]
10529b2a4: 17ffff44    	b	0x10529afb4 <_Flutter_MMFoundation_BindContext+0x1521c80>
10529b2a8: 910583e2    	add	x2, sp, #0x160
10529b2ac: d10383a3    	sub	x3, x29, #0xe0
10529b2b0: f94063fb    	ldr	x27, [sp, #0xc0]
10529b2b4: aa1b03e0    	mov	x0, x27
10529b2b8: f94017e1    	ldr	x1, [sp, #0x28]
10529b2bc: 52800204    	mov	w4, #0x10               ; =16
10529b2c0: 94a63269    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b2c4: aa0003f3    	mov	x19, x0
10529b2c8: d00cb969    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10529b2cc: f00cd04a    	adrp	x10, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529b2d0: d00cb96b    	adrp	x11, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10529b2d4: b5ffd840    	cbnz	x0, 0x10529addc <_Flutter_MMFoundation_BindContext+0x1521aa8>
10529b2d8: 14000005    	b	0x10529b2ec <_Flutter_MMFoundation_BindContext+0x1521fb8>
10529b2dc: f9440168    	ldr	x8, [x11, #0x800] ; selector: currentContext
10529b2e0: f90067e8    	str	x8, [sp, #0xc8]
10529b2e4: f9428556    	ldr	x22, [x10, #0x508] ; selector: class
10529b2e8: f9452139    	ldr	x25, [x9, #0xa40] ; selector: getService:
10529b2ec: aa1b03e0    	mov	x0, x27
10529b2f0: 94a63260    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b2f4: f00cd3a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b2f8: f943c100    	ldr	x0, [x8, #0x780]
10529b2fc: f94067e1    	ldr	x1, [sp, #0xc8]
10529b300: 94a63259    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b304: aa1d03fd    	mov	x29, x29
10529b308: 94a6325e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b30c: aa0003f3    	mov	x19, x0
10529b310: 900cd3c8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529b314: f9448500    	ldr	x0, [x8, #0x908]
10529b318: aa1603e1    	mov	x1, x22
10529b31c: 94a63252    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b320: aa0003e2    	mov	x2, x0
10529b324: aa1303e0    	mov	x0, x19
10529b328: f90007f9    	str	x25, [sp, #0x8]
10529b32c: aa1903e1    	mov	x1, x25
10529b330: 94a6324d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b334: aa1d03fd    	mov	x29, x29
10529b338: 94a63252    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b33c: aa0003f4    	mov	x20, x0
10529b340: b00cba08    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10529b344: f942bd01    	ldr	x1, [x8, #0x578] ; selector: forwardLogic
10529b348: f9005be1    	str	x1, [sp, #0xb0]
10529b34c: 94a63246    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b350: aa1d03fd    	mov	x29, x29
10529b354: 94a6324b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b358: aa0003f5    	mov	x21, x0
10529b35c: b00cba08    	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
10529b360: f942b101    	ldr	x1, [x8, #0x560] ; selector: setFileSource:
10529b364: f90057e1    	str	x1, [sp, #0xa8]
10529b368: 528025a2    	mov	w2, #0x12d              ; =301
10529b36c: 94a6323e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b370: aa1503e0    	mov	x0, x21
10529b374: 94a6323f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b378: aa1403e0    	mov	x0, x20
10529b37c: 94a6323d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b380: aa1303e0    	mov	x0, x19
10529b384: 94a6323b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b388: f00cd3b4    	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b38c: f9432e80    	ldr	x0, [x20, #0x658]
10529b390: d00cd048    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529b394: f946c513    	ldr	x19, [x8, #0xd88] ; selector: array
10529b398: aa1303e1    	mov	x1, x19
10529b39c: 94a63232    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b3a0: aa1d03fd    	mov	x29, x29
10529b3a4: 94a63237    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b3a8: f9006fe0    	str	x0, [sp, #0xd8]
10529b3ac: f9432e80    	ldr	x0, [x20, #0x658]
10529b3b0: aa1303e1    	mov	x1, x19
10529b3b4: 94a6322c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b3b8: aa1d03fd    	mov	x29, x29
10529b3bc: 94a63231    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b3c0: f9006be0    	str	x0, [sp, #0xd0]
10529b3c4: 4f00e400    	movi.16b	v0, #0x0
10529b3c8: ad0903e0    	stp	q0, q0, [sp, #0x120]
10529b3cc: ad0a03e0    	stp	q0, q0, [sp, #0x140]
10529b3d0: aa1b03e0    	mov	x0, x27
10529b3d4: 94a63228    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529b3d8: 910483e2    	add	x2, sp, #0x120
10529b3dc: 910883e3    	add	x3, sp, #0x220
10529b3e0: f94017e1    	ldr	x1, [sp, #0x28]
10529b3e4: 52800204    	mov	w4, #0x10               ; =16
10529b3e8: 94a6321f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b3ec: b4000680    	cbz	x0, 0x10529b4bc <_Flutter_MMFoundation_BindContext+0x1522188>
10529b3f0: aa0003f3    	mov	x19, x0
10529b3f4: f9409be8    	ldr	x8, [sp, #0x130]
10529b3f8: f9400115    	ldr	x21, [x8]
10529b3fc: d00cd059    	adrp	x25, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529b400: d280001a    	mov	x26, #0x0               ; =0
10529b404: b00cd068    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10529b408: f9444914    	ldr	x20, [x8, #0x890] ; selector: isKindOfClass:
10529b40c: f9451f37    	ldr	x23, [x25, #0xa38] ; selector: addObject:
10529b410: f9409be8    	ldr	x8, [sp, #0x130]
10529b414: f9400108    	ldr	x8, [x8]
10529b418: eb15011f    	cmp	x8, x21
10529b41c: 54000060    	b.eq	0x10529b428 <_Flutter_MMFoundation_BindContext+0x15220f4>
10529b420: aa1b03e0    	mov	x0, x27
10529b424: 94a63206    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10529b428: f94097e8    	ldr	x8, [sp, #0x128]
10529b42c: f87a7918    	ldr	x24, [x8, x26, lsl #3]
10529b430: f944df80    	ldr	x0, [x28, #0x9b8]
10529b434: aa1603e1    	mov	x1, x22
10529b438: 94a6320b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b43c: aa0003e2    	mov	x2, x0
10529b440: aa1803e0    	mov	x0, x24
10529b444: aa1403e1    	mov	x1, x20
10529b448: 94a63207    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b44c: aa0003e8    	mov	x8, x0
10529b450: f9406fe0    	ldr	x0, [sp, #0xd8]
10529b454: 37000188    	tbnz	w8, #0x0, 0x10529b484 <_Flutter_MMFoundation_BindContext+0x1522150>
10529b458: 900cd428    	adrp	x8, 0x11ed1f000 <dyld_stub_binder+0x11ed1f000>
10529b45c: f9407900    	ldr	x0, [x8, #0xf0]
10529b460: aa1603e1    	mov	x1, x22
10529b464: 94a63200    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b468: aa0003e2    	mov	x2, x0
10529b46c: aa1803e0    	mov	x0, x24
10529b470: aa1403e1    	mov	x1, x20
10529b474: 94a631fc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b478: aa0003e8    	mov	x8, x0
10529b47c: f9406be0    	ldr	x0, [sp, #0xd0]
10529b480: 34000088    	cbz	w8, 0x10529b490 <_Flutter_MMFoundation_BindContext+0x152215c>
10529b484: aa1703e1    	mov	x1, x23
10529b488: aa1803e2    	mov	x2, x24
10529b48c: 94a631f6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b490: 9100075a    	add	x26, x26, #0x1
10529b494: eb1a027f    	cmp	x19, x26
10529b498: 54fffbc1    	b.ne	0x10529b410 <_Flutter_MMFoundation_BindContext+0x15220dc>
10529b49c: 910483e2    	add	x2, sp, #0x120
10529b4a0: 910883e3    	add	x3, sp, #0x220
10529b4a4: aa1b03e0    	mov	x0, x27
10529b4a8: f94017e1    	ldr	x1, [sp, #0x28]
10529b4ac: 52800204    	mov	w4, #0x10               ; =16
10529b4b0: 94a631ed    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b4b4: aa0003f3    	mov	x19, x0
10529b4b8: b5fffa40    	cbnz	x0, 0x10529b400 <_Flutter_MMFoundation_BindContext+0x15220cc>
10529b4bc: aa1b03e0    	mov	x0, x27
10529b4c0: 94a631ec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b4c4: f00cd048    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10529b4c8: f9442913    	ldr	x19, [x8, #0x850] ; selector: count
10529b4cc: f9406bf8    	ldr	x24, [sp, #0xd0]
10529b4d0: aa1803e0    	mov	x0, x24
10529b4d4: aa1303e1    	mov	x1, x19
10529b4d8: 94a631e3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b4dc: b4000e80    	cbz	x0, 0x10529b6ac <_Flutter_MMFoundation_BindContext+0x1522378>
10529b4e0: f9406ffc    	ldr	x28, [sp, #0xd8]
10529b4e4: aa1c03e0    	mov	x0, x28
10529b4e8: aa1303e1    	mov	x1, x19
10529b4ec: 94a631de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b4f0: f9405bf3    	ldr	x19, [sp, #0xb0]
10529b4f4: b4001180    	cbz	x0, 0x10529b724 <_Flutter_MMFoundation_BindContext+0x15223f0>
10529b4f8: d00cd068    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10529b4fc: f9418d01    	ldr	x1, [x8, #0x318] ; selector: mutableCopy
10529b500: aa1c03e0    	mov	x0, x28
10529b504: 94a631d8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b508: f9005fe0    	str	x0, [sp, #0xb8]
10529b50c: 4f00e400    	movi.16b	v0, #0x0
10529b510: ad0703e0    	stp	q0, q0, [sp, #0xe0]
10529b514: ad0803e0    	stp	q0, q0, [sp, #0x100]
10529b518: aa1803e0    	mov	x0, x24
10529b51c: 94a631d6    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10529b520: 910383e2    	add	x2, sp, #0xe0
10529b524: 910683e3    	add	x3, sp, #0x1a0
10529b528: f94017e1    	ldr	x1, [sp, #0x28]
10529b52c: 52800204    	mov	w4, #0x10               ; =16
10529b530: 94a631cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b534: b40006c0    	cbz	x0, 0x10529b60c <_Flutter_MMFoundation_BindContext+0x15222d8>
10529b538: aa0003f4    	mov	x20, x0
10529b53c: f9407be8    	ldr	x8, [sp, #0xf0]
10529b540: f940011b    	ldr	x27, [x8]
10529b544: d280001c    	mov	x28, #0x0               ; =0
10529b548: d00cb988    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
10529b54c: f9440d17    	ldr	x23, [x8, #0x818] ; selector: dataItem
10529b550: f00cbce8    	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
10529b554: f9478518    	ldr	x24, [x8, #0xf08] ; selector: ConvertFavData2FavItem:
10529b558: d00cd048    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10529b55c: f9451d19    	ldr	x25, [x8, #0xa38] ; selector: addObject:
10529b560: f9407be8    	ldr	x8, [sp, #0xf0]
10529b564: f9400108    	ldr	x8, [x8]
10529b568: eb1b011f    	cmp	x8, x27
10529b56c: 54000060    	b.eq	0x10529b578 <_Flutter_MMFoundation_BindContext+0x1522244>
10529b570: f9406be0    	ldr	x0, [sp, #0xd0]
10529b574: 94a631b2    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10529b578: f94077e8    	ldr	x8, [sp, #0xe8]
10529b57c: f87c7900    	ldr	x0, [x8, x28, lsl #3]
10529b580: 900cd3c8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529b584: f9448115    	ldr	x21, [x8, #0x900]
10529b588: aa1703e1    	mov	x1, x23
10529b58c: 94a631b6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b590: aa1d03fd    	mov	x29, x29
10529b594: 94a631bb    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b598: aa0003f3    	mov	x19, x0
10529b59c: aa1503e0    	mov	x0, x21
10529b5a0: aa1803e1    	mov	x1, x24
10529b5a4: aa1303e2    	mov	x2, x19
10529b5a8: 94a631af    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b5ac: aa1d03fd    	mov	x29, x29
10529b5b0: 94a631b4    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b5b4: aa0003fa    	mov	x26, x0
10529b5b8: aa1303e0    	mov	x0, x19
10529b5bc: 94a631ad    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b5c0: f9405fe0    	ldr	x0, [sp, #0xb8]
10529b5c4: b400009a    	cbz	x26, 0x10529b5d4 <_Flutter_MMFoundation_BindContext+0x15222a0>
10529b5c8: aa1903e1    	mov	x1, x25
10529b5cc: aa1a03e2    	mov	x2, x26
10529b5d0: 94a631a5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b5d4: aa1a03e0    	mov	x0, x26
10529b5d8: 94a631a6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b5dc: 9100079c    	add	x28, x28, #0x1
10529b5e0: eb1c029f    	cmp	x20, x28
10529b5e4: 54fffbe1    	b.ne	0x10529b560 <_Flutter_MMFoundation_BindContext+0x152222c>
10529b5e8: 910383e2    	add	x2, sp, #0xe0
10529b5ec: 910683e3    	add	x3, sp, #0x1a0
10529b5f0: f9406bf8    	ldr	x24, [sp, #0xd0]
10529b5f4: aa1803e0    	mov	x0, x24
10529b5f8: f94017e1    	ldr	x1, [sp, #0x28]
10529b5fc: 52800204    	mov	w4, #0x10               ; =16
10529b600: 94a63199    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b604: aa0003f4    	mov	x20, x0
10529b608: b5fff9e0    	cbnz	x0, 0x10529b544 <_Flutter_MMFoundation_BindContext+0x1522210>
10529b60c: aa1803e0    	mov	x0, x24
10529b610: 94a63198    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b614: f00cd3b9    	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b618: f943c320    	ldr	x0, [x25, #0x780]
10529b61c: f94067e1    	ldr	x1, [sp, #0xc8]
10529b620: 94a63191    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b624: aa1d03fd    	mov	x29, x29
10529b628: 94a63196    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b62c: aa0003f4    	mov	x20, x0
10529b630: 900cd3d5    	adrp	x21, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529b634: f94486a0    	ldr	x0, [x21, #0x908]
10529b638: aa1603e1    	mov	x1, x22
10529b63c: 94a6318a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b640: aa0003e2    	mov	x2, x0
10529b644: aa1403e0    	mov	x0, x20
10529b648: f94007fa    	ldr	x26, [sp, #0x8]
10529b64c: aa1a03e1    	mov	x1, x26
10529b650: 94a63185    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b654: aa1d03fd    	mov	x29, x29
10529b658: 94a6318a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b65c: aa0003f7    	mov	x23, x0
10529b660: f9405bf9    	ldr	x25, [sp, #0xb0]
10529b664: aa1903e1    	mov	x1, x25
10529b668: 94a6317f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b66c: aa1d03fd    	mov	x29, x29
10529b670: 94a63184    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b674: aa0003f3    	mov	x19, x0
10529b678: 900cbd68    	adrp	x8, 0x11ea47000 <dyld_stub_binder+0x11ea47000>
10529b67c: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector: ForwardFavItemList:toUser:delegate:reportParamMap:
10529b680: f9405fe2    	ldr	x2, [sp, #0xb8]
10529b684: d2800003    	mov	x3, #0x0                ; =0
10529b688: a94793f8    	ldp	x24, x4, [sp, #0x78]
10529b68c: aa1803e5    	mov	x5, x24
10529b690: 94a63175    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b694: aa1303e0    	mov	x0, x19
10529b698: f9405ff3    	ldr	x19, [sp, #0xb8]
10529b69c: 94a63175    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b6a0: f94063fb    	ldr	x27, [sp, #0xc0]
10529b6a4: f9406ffc    	ldr	x28, [sp, #0xd8]
10529b6a8: 14000040    	b	0x10529b7a8 <_Flutter_MMFoundation_BindContext+0x1522474>
10529b6ac: f00cd3b9    	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b6b0: f943c320    	ldr	x0, [x25, #0x780]
10529b6b4: f94067e1    	ldr	x1, [sp, #0xc8]
10529b6b8: 94a6316b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b6bc: aa1d03fd    	mov	x29, x29
10529b6c0: 94a63170    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b6c4: aa0003f3    	mov	x19, x0
10529b6c8: 900cd3d5    	adrp	x21, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529b6cc: f94486a0    	ldr	x0, [x21, #0x908]
10529b6d0: aa1603e1    	mov	x1, x22
10529b6d4: 94a63164    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b6d8: aa0003e2    	mov	x2, x0
10529b6dc: aa1303e0    	mov	x0, x19
10529b6e0: f94007fa    	ldr	x26, [sp, #0x8]
10529b6e4: aa1a03e1    	mov	x1, x26
10529b6e8: 94a6315f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b6ec: aa1d03fd    	mov	x29, x29
10529b6f0: 94a63164    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b6f4: aa0003f4    	mov	x20, x0
10529b6f8: f9405bf9    	ldr	x25, [sp, #0xb0]
10529b6fc: aa1903e1    	mov	x1, x25
10529b700: 94a63159    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b704: aa1d03fd    	mov	x29, x29
10529b708: 94a6315e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b70c: aa0003f7    	mov	x23, x0
10529b710: 900cbd68    	adrp	x8, 0x11ea47000 <dyld_stub_binder+0x11ea47000>
10529b714: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector: ForwardFavItemList:toUser:delegate:reportParamMap:
10529b718: f9406ffc    	ldr	x28, [sp, #0xd8]
10529b71c: aa1c03e2    	mov	x2, x28
10529b720: 1400001e    	b	0x10529b798 <_Flutter_MMFoundation_BindContext+0x1522464>
10529b724: f00cd3b9    	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b728: f943c320    	ldr	x0, [x25, #0x780]
10529b72c: f94067e1    	ldr	x1, [sp, #0xc8]
10529b730: 94a6314d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b734: aa1d03fd    	mov	x29, x29
10529b738: 94a63152    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b73c: aa0003f7    	mov	x23, x0
10529b740: 900cd3d5    	adrp	x21, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10529b744: f94486a0    	ldr	x0, [x21, #0x908]
10529b748: aa1603e1    	mov	x1, x22
10529b74c: 94a63146    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b750: aa0003e2    	mov	x2, x0
10529b754: aa1703e0    	mov	x0, x23
10529b758: f94007fa    	ldr	x26, [sp, #0x8]
10529b75c: aa1a03e1    	mov	x1, x26
10529b760: 94a63141    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b764: aa1d03fd    	mov	x29, x29
10529b768: 94a63146    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b76c: aa0003f4    	mov	x20, x0
10529b770: aa1303e1    	mov	x1, x19
10529b774: 94a6313c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b778: aa1d03fd    	mov	x29, x29
10529b77c: 94a63141    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b780: aa1303f9    	mov	x25, x19
10529b784: aa1703f3    	mov	x19, x23
10529b788: aa0003f7    	mov	x23, x0
10529b78c: b00cbd68    	adrp	x8, 0x11ea48000 <dyld_stub_binder+0x11ea48000>
10529b790: f9442d01    	ldr	x1, [x8, #0x858] ; selector: forwardFavDataItemWraps:ToUser:delegate:reportParamMap:
10529b794: aa1803e2    	mov	x2, x24
10529b798: d2800003    	mov	x3, #0x0                ; =0
10529b79c: a94793f8    	ldp	x24, x4, [sp, #0x78]
10529b7a0: aa1803e5    	mov	x5, x24
10529b7a4: 94a63130    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b7a8: aa1703e0    	mov	x0, x23
10529b7ac: 94a63131    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b7b0: aa1403e0    	mov	x0, x20
10529b7b4: 94a6312f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b7b8: aa1303e0    	mov	x0, x19
10529b7bc: 94a6312d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b7c0: f00cd3a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10529b7c4: f943c100    	ldr	x0, [x8, #0x780]
10529b7c8: f94067e1    	ldr	x1, [sp, #0xc8]
10529b7cc: 94a63126    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b7d0: aa1d03fd    	mov	x29, x29
10529b7d4: 94a6312b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b7d8: aa0003f3    	mov	x19, x0
10529b7dc: f94486a0    	ldr	x0, [x21, #0x908]
10529b7e0: aa1603e1    	mov	x1, x22
10529b7e4: 94a63120    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b7e8: aa0003e2    	mov	x2, x0
10529b7ec: aa1303e0    	mov	x0, x19
10529b7f0: aa1a03e1    	mov	x1, x26
10529b7f4: 94a6311c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b7f8: aa1d03fd    	mov	x29, x29
10529b7fc: 94a63121    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b800: aa0003f4    	mov	x20, x0
10529b804: aa1903e1    	mov	x1, x25
10529b808: 94a63117    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b80c: aa1d03fd    	mov	x29, x29
10529b810: 94a6311c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10529b814: aa0003f5    	mov	x21, x0
10529b818: f94057e1    	ldr	x1, [sp, #0xa8]
10529b81c: 52800002    	mov	w2, #0x0                ; =0
10529b820: 94a63111    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10529b824: aa1503e0    	mov	x0, x21
10529b828: 94a63112    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b82c: aa1403e0    	mov	x0, x20
10529b830: 94a63110    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b834: aa1303e0    	mov	x0, x19
10529b838: 94a6310e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b83c: f9406be0    	ldr	x0, [sp, #0xd0]
10529b840: 94a6310c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b844: aa1c03e0    	mov	x0, x28
10529b848: 94a6310a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b84c: aa1803e0    	mov	x0, x24
10529b850: 94a63108    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b854: aa1b03e0    	mov	x0, x27
10529b858: 94a63106    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10529b85c: f85a03a8    	ldur	x8, [x29, #-0x60]
10529b860: b00c2589    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10529b864: f9451929    	ldr	x9, [x9, #0xa30]
10529b868: f9400129    	ldr	x9, [x9]
10529b86c: eb08013f    	cmp	x9, x8
10529b870: 54000121    	b.ne	0x10529b894 <_Flutter_MMFoundation_BindContext+0x1522560>
10529b874: 910cc3ff    	add	sp, sp, #0x330
10529b878: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10529b87c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10529b880: a94357f6    	ldp	x22, x21, [sp, #0x30]
10529b884: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10529b888: a94167fa    	ldp	x26, x25, [sp, #0x10]
10529b88c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10529b890: d65f03c0    	ret
10529b894: 94a62fa7    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
