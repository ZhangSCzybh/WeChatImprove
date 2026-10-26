
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029be7c0: d10343ff    	sub	sp, sp, #0xd0
1029be7c4: a9076ffc    	stp	x28, x27, [sp, #0x70]
1029be7c8: a90867fa    	stp	x26, x25, [sp, #0x80]
1029be7cc: a9095ff8    	stp	x24, x23, [sp, #0x90]
1029be7d0: a90a57f6    	stp	x22, x21, [sp, #0xa0]
1029be7d4: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
1029be7d8: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
1029be7dc: 910303fd    	add	x29, sp, #0xc0
1029be7e0: aa0603f9    	mov	x25, x6
1029be7e4: aa0503f6    	mov	x22, x5
1029be7e8: aa0403f5    	mov	x21, x4
1029be7ec: aa0303f4    	mov	x20, x3
1029be7f0: aa0203f3    	mov	x19, x2
1029be7f4: aa0003f8    	mov	x24, x0
1029be7f8: 900f13c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029be7fc: 52800029    	mov	w9, #0x1                ; =1
1029be800: 3934d109    	strb	w9, [x8, #0xd34]
1029be804: aa0203e0    	mov	x0, x2
1029be808: 9549a24c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be80c: aa1403e0    	mov	x0, x20
1029be810: 9549a24a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be814: aa1503e0    	mov	x0, x21
1029be818: 9549a248    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be81c: aa1603e0    	mov	x0, x22
1029be820: 9549a246    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029be824: 900ea6e8    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
1029be828: f9461d01    	ldr	x1, [x8, #0xc38] ; m_name
1029be82c: aa1303e0    	mov	x0, x19
1029be830: 9549a243    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be834: aa1d03fd    	mov	x29, x29
1029be838: 9549a244    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029be83c: aa0003fa    	mov	x26, x0
1029be840: 900eba68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029be844: f9465101    	ldr	x1, [x8, #0xca0] ; stringByAppendingPathComponent:
1029be848: aa1403e0    	mov	x0, x20
1029be84c: aa1a03e2    	mov	x2, x26
1029be850: 9549a23b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be854: aa1d03fd    	mov	x29, x29
1029be858: 9549a23c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029be85c: aa0003f7    	mov	x23, x0
1029be860: aa1a03e0    	mov	x0, x26
1029be864: 9549a23c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029be868: 7101073f    	cmp	w25, #0x41
1029be86c: 54000343    	b.lo	0x1029be8d4 <_Flutter_Image_provideRelativePathByUrl+0xdcb784>
1029be870: 93407f28    	sxtw	x8, w25
1029be874: b00ebda9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1029be878: f9453520    	ldr	x0, [x9, #0xa68]
1029be87c: f00ea3c9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029be880: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029be884: 52800809    	mov	w9, #0x40               ; =64
1029be888: a9015fe9    	stp	x9, x23, [sp, #0x10]
1029be88c: b00de5c9    	adrp	x9, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029be890: 9128a129    	add	x9, x9, #0xa28
1029be894: a90023e9    	stp	x9, x8, [sp]
1029be898: d00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029be89c: 9125d063    	add	x3, x3, #0x974
1029be8a0: f00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be8a4: 9112f8a5    	add	x5, x5, #0x4be
1029be8a8: f00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be8ac: 9139b4e7    	add	x7, x7, #0xe6d
1029be8b0: 52800082    	mov	w2, #0x4                ; =4
1029be8b4: 52800004    	mov	w4, #0x0                ; =0
1029be8b8: 52806226    	mov	w6, #0x311              ; =785
1029be8bc: 9549a220    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be8c0: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be8c4: f945ed01    	ldr	x1, [x8, #0xbd8] ; m_isQuickScan
1029be8c8: aa1503e0    	mov	x0, x21
1029be8cc: 9549a21c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be8d0: 34001980    	cbz	w0, 0x1029bec00 <_Flutter_Image_provideRelativePathByUrl+0xdcbab0>
1029be8d4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be8d8: f9461501    	ldr	x1, [x8, #0xc28] ; scannerStatus
1029be8dc: aa1803e0    	mov	x0, x24
1029be8e0: 9549a217    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be8e4: 7100081f    	cmp	w0, #0x2
1029be8e8: 540018c0    	b.eq	0x1029bec00 <_Flutter_Image_provideRelativePathByUrl+0xdcbab0>
1029be8ec: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be8f0: f945ed01    	ldr	x1, [x8, #0xbd8] ; m_isQuickScan
1029be8f4: aa1503e0    	mov	x0, x21
1029be8f8: 9549a211    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be8fc: 37000480    	tbnz	w0, #0x0, 0x1029be98c <_Flutter_Image_provideRelativePathByUrl+0xdcb83c>
1029be900: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be904: f9462501    	ldr	x1, [x8, #0xc48] ; willScanWholeWechat
1029be908: aa1503e0    	mov	x0, x21
1029be90c: 9549a20c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be910: 370003e0    	tbnz	w0, #0x0, 0x1029be98c <_Flutter_Image_provideRelativePathByUrl+0xdcb83c>
1029be914: f00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029be918: f947b501    	ldr	x1, [x8, #0xf68] ; m_storeTimeType
1029be91c: aa1303e0    	mov	x0, x19
1029be920: 9549a207    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be924: f100041f    	cmp	x0, #0x1
1029be928: 54000321    	b.ne	0x1029be98c <_Flutter_Image_provideRelativePathByUrl+0xdcb83c>
1029be92c: f00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029be930: f947b101    	ldr	x1, [x8, #0xf60] ; m_onlyWeChatFileClass
1029be934: aa1303e0    	mov	x0, x19
1029be938: 9549a201    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be93c: 7100081f    	cmp	w0, #0x2
1029be940: 54000261    	b.ne	0x1029be98c <_Flutter_Image_provideRelativePathByUrl+0xdcb83c>
1029be944: b00ebda8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029be948: f9453500    	ldr	x0, [x8, #0xa68]
1029be94c: f00ea3c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029be950: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029be954: b00de5c8    	adrp	x8, 0x11e677000 <dyld_stub_binder+0x11e677000>
1029be958: 91292108    	add	x8, x8, #0xa48
1029be95c: a9005fe8    	stp	x8, x23, [sp]
1029be960: d00c5de3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029be964: 9125d063    	add	x3, x3, #0x974
1029be968: f00c5e25    	adrp	x5, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be96c: 9112f8a5    	add	x5, x5, #0x4be
1029be970: f00c5e27    	adrp	x7, 0x11b585000 <dyld_stub_binder+0x11b585000>
1029be974: 9139b4e7    	add	x7, x7, #0xe6d
1029be978: 52800042    	mov	w2, #0x2                ; =2
1029be97c: 52800004    	mov	w4, #0x0                ; =0
1029be980: 528063c6    	mov	w6, #0x31e              ; =798
1029be984: 9549a1ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be988: 1400009e    	b	0x1029bec00 <_Flutter_Image_provideRelativePathByUrl+0xdcbab0>
1029be98c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be990: f9475101    	ldr	x1, [x8, #0xea0] ; getChildFolderAndFileWithParentPath:
1029be994: aa1303e0    	mov	x0, x19
1029be998: aa1403e2    	mov	x2, x20
1029be99c: 9549a1e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be9a0: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be9a4: f9475501    	ldr	x1, [x8, #0xea8] ; isEmptyFolder
1029be9a8: aa1303e0    	mov	x0, x19
1029be9ac: 9549a1e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be9b0: 34000280    	cbz	w0, 0x1029bea00 <_Flutter_Image_provideRelativePathByUrl+0xdcb8b0>
1029be9b4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be9b8: f945fd01    	ldr	x1, [x8, #0xbf8] ; isDeleteEmptyFolder
1029be9bc: aa1503e0    	mov	x0, x21
1029be9c0: 9549a1df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be9c4: 34000100    	cbz	w0, 0x1029be9e4 <_Flutter_Image_provideRelativePathByUrl+0xdcb894>
1029be9c8: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be9cc: f9475901    	ldr	x1, [x8, #0xeb0] ; handleDeleteFolder:withFolderPath:withScanStat:
1029be9d0: aa1803e0    	mov	x0, x24
1029be9d4: aa1303e2    	mov	x2, x19
1029be9d8: aa1703e3    	mov	x3, x23
1029be9dc: aa1603e4    	mov	x4, x22
1029be9e0: 9549a1d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be9e4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029be9e8: f9475d01    	ldr	x1, [x8, #0xeb8] ; onScanFileInFolderFinish:withScanStat:
1029be9ec: aa1803e0    	mov	x0, x24
1029be9f0: aa1303e2    	mov	x2, x19
1029be9f4: aa1603e3    	mov	x3, x22
1029be9f8: 9549a1d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029be9fc: 14000081    	b	0x1029bec00 <_Flutter_Image_provideRelativePathByUrl+0xdcbab0>
1029bea00: f00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029bea04: f947bd01    	ldr	x1, [x8, #0xf78] ; m_bizMatchNode
1029bea08: aa1303e0    	mov	x0, x19
1029bea0c: 9549a1cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea10: aa1d03fd    	mov	x29, x29
1029bea14: 9549a1cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bea18: aa0003fa    	mov	x26, x0
1029bea1c: f00ea668    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
1029bea20: f947c101    	ldr	x1, [x8, #0xf80] ; sortBizMatchNode
1029bea24: 9549a1c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea28: aa1a03e0    	mov	x0, x26
1029bea2c: 9549a1ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bea30: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bea34: f942f501    	ldr	x1, [x8, #0x5e8] ; m_arrChildFolder
1029bea38: aa1303e0    	mov	x0, x19
1029bea3c: 9549a1c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea40: aa1d03fd    	mov	x29, x29
1029bea44: 9549a1c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029bea48: aa0003fa    	mov	x26, x0
1029bea4c: d00eba08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029bea50: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1029bea54: 9549a1ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea58: aa0003fb    	mov	x27, x0
1029bea5c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bea60: f9476101    	ldr	x1, [x8, #0xec0] ; m_curAddFolderNum
1029bea64: aa1603e0    	mov	x0, x22
1029bea68: 9549a1b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea6c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bea70: f9476501    	ldr	x1, [x8, #0xec8] ; setM_curAddFolderNum:
1029bea74: 0b1b0002    	add	w2, w0, w27
1029bea78: aa1603e0    	mov	x0, x22
1029bea7c: 9549a1b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea80: aa1a03e0    	mov	x0, x26
1029bea84: 9549a1b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bea88: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bea8c: f9474101    	ldr	x1, [x8, #0xe80] ; m_curStartTime
1029bea90: aa1603e0    	mov	x0, x22
1029bea94: 9549a1aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bea98: aa0003e2    	mov	x2, x0
1029bea9c: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029beaa0: f9433101    	ldr	x1, [x8, #0x660] ; setM_curStartTime:
1029beaa4: aa1303e0    	mov	x0, x19
1029beaa8: 9549a1a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beaac: d00ea6e8    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
1029beab0: f943fd01    	ldr	x1, [x8, #0x7f8] ; concurrentCount
1029beab4: aa1503e0    	mov	x0, x21
1029beab8: 9549a1a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beabc: 7100041f    	cmp	w0, #0x1
1029beac0: 5400020c    	b.gt	0x1029beb00 <_Flutter_Image_provideRelativePathByUrl+0xdcb9b0>
1029beac4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029beac8: f9476901    	ldr	x1, [x8, #0xed0] ; scanFileInFolder:withFolderPath:withScanConfig:
1029beacc: aa1803e0    	mov	x0, x24
1029bead0: aa1303e2    	mov	x2, x19
1029bead4: aa1703e3    	mov	x3, x23
1029bead8: aa1503e4    	mov	x4, x21
1029beadc: 9549a198    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beae0: 340007e0    	cbz	w0, 0x1029bebdc <_Flutter_Image_provideRelativePathByUrl+0xdcba8c>
1029beae4: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029beae8: f9475d01    	ldr	x1, [x8, #0xeb8] ; onScanFileInFolderFinish:withScanStat:
1029beaec: aa1803e0    	mov	x0, x24
1029beaf0: aa1303e2    	mov	x2, x19
1029beaf4: aa1603e3    	mov	x3, x22
1029beaf8: 9549a191    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beafc: 14000038    	b	0x1029bebdc <_Flutter_Image_provideRelativePathByUrl+0xdcba8c>
1029beb00: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029beb04: f9473d01    	ldr	x1, [x8, #0xe78] ; concurrentSemaphore
1029beb08: aa1803e0    	mov	x0, x24
1029beb0c: 9549a18c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beb10: aa1d03fd    	mov	x29, x29
1029beb14: 9549a18d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029beb18: aa0003fa    	mov	x26, x0
1029beb1c: 92800001    	mov	x1, #-0x1               ; =-1
1029beb20: 9549a212    	bl	0x107c27368 <_Flutter_MMFoundation_BindContext+0x4102f4c>
1029beb24: aa1a03e0    	mov	x0, x26
1029beb28: 9549a18b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029beb2c: d00ea9a8    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1029beb30: f945b901    	ldr	x1, [x8, #0xb70] ; workQueue
1029beb34: aa1803e0    	mov	x0, x24
1029beb38: 9549a181    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029beb3c: aa1d03fd    	mov	x29, x29
1029beb40: 9549a182    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029beb44: aa0003fa    	mov	x26, x0
1029beb48: 900d6188    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029beb4c: f947e108    	ldr	x8, [x8, #0xfc0]
1029beb50: f90017e8    	str	x8, [sp, #0x28]
1029beb54: f00b1e08    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029beb58: fd41c100    	ldr	d0, [x8, #0x380]
1029beb5c: 90000008    	adrp	x8, 0x1029be000 <_Flutter_Image_provideRelativePathByUrl+0xdcaeb0>
1029beb60: 91312108    	add	x8, x8, #0xc48
1029beb64: fd001be0    	str	d0, [sp, #0x30]
1029beb68: b00d6209    	adrp	x9, 0x11d5ff000 <dyld_stub_binder+0x11d5ff000>
1029beb6c: 9123a129    	add	x9, x9, #0x8e8
1029beb70: a903a7e8    	stp	x8, x9, [sp, #0x38]
1029beb74: f90027f8    	str	x24, [sp, #0x48]
1029beb78: aa1303e0    	mov	x0, x19
1029beb7c: 9549a16f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029beb80: f9002bf3    	str	x19, [sp, #0x50]
1029beb84: aa1703e0    	mov	x0, x23
1029beb88: 9549a16c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029beb8c: f9002ff7    	str	x23, [sp, #0x58]
1029beb90: aa1503e0    	mov	x0, x21
1029beb94: 9549a169    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029beb98: f90033f5    	str	x21, [sp, #0x60]
1029beb9c: aa1603e0    	mov	x0, x22
1029beba0: 9549a166    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029beba4: f90037f6    	str	x22, [sp, #0x68]
1029beba8: 9100a3e1    	add	x1, sp, #0x28
1029bebac: aa1a03e0    	mov	x0, x26
1029bebb0: 9549399c    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1029bebb4: aa1a03e0    	mov	x0, x26
1029bebb8: 9549a167    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bebbc: f94037e0    	ldr	x0, [sp, #0x68]
1029bebc0: 9549a165    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bebc4: f94033e0    	ldr	x0, [sp, #0x60]
1029bebc8: 9549a163    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bebcc: f9402fe0    	ldr	x0, [sp, #0x58]
1029bebd0: 9549a161    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bebd4: f9402be0    	ldr	x0, [sp, #0x50]
1029bebd8: 9549a15f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bebdc: d00ea9c8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029bebe0: f9476d01    	ldr	x1, [x8, #0xed8] ; scanSubFolder:withFolderPath:withScanConfig:withScanStat:depth:
1029bebe4: aa1803e0    	mov	x0, x24
1029bebe8: aa1303e2    	mov	x2, x19
1029bebec: aa1703e3    	mov	x3, x23
1029bebf0: aa1503e4    	mov	x4, x21
1029bebf4: aa1603e5    	mov	x5, x22
1029bebf8: aa1903e6    	mov	x6, x25
1029bebfc: 9549a150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029bec00: aa1703e0    	mov	x0, x23
1029bec04: 9549a154    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bec08: aa1603e0    	mov	x0, x22
1029bec0c: 9549a152    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bec10: aa1503e0    	mov	x0, x21
1029bec14: 9549a150    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bec18: aa1403e0    	mov	x0, x20
1029bec1c: 9549a14e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bec20: aa1303e0    	mov	x0, x19
1029bec24: 9549a14c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029bec28: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
1029bec2c: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
1029bec30: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
1029bec34: a9495ff8    	ldp	x24, x23, [sp, #0x90]
1029bec38: a94867fa    	ldp	x26, x25, [sp, #0x80]
1029bec3c: a9476ffc    	ldp	x28, x27, [sp, #0x70]
1029bec40: 910343ff    	add	sp, sp, #0xd0
1029bec44: d65f03c0    	ret
