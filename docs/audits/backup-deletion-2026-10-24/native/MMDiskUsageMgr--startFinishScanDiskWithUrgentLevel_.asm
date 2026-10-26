
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b49f4: d10283ff    	sub	sp, sp, #0xa0
1029b49f8: a90567fa    	stp	x26, x25, [sp, #0x50]
1029b49fc: a9065ff8    	stp	x24, x23, [sp, #0x60]
1029b4a00: a90757f6    	stp	x22, x21, [sp, #0x70]
1029b4a04: a9084ff4    	stp	x20, x19, [sp, #0x80]
1029b4a08: a9097bfd    	stp	x29, x30, [sp, #0x90]
1029b4a0c: 910243fd    	add	x29, sp, #0x90
1029b4a10: aa0203f7    	mov	x23, x2
1029b4a14: aa0003f4    	mov	x20, x0
1029b4a18: d00f1408    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029b4a1c: 52800029    	mov	w9, #0x1                ; =1
1029b4a20: 39347d09    	strb	w9, [x8, #0xd1f]
1029b4a24: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4a28: f943ed15    	ldr	x21, [x8, #0x7d8] ; scanner
1029b4a2c: aa1503e1    	mov	x1, x21
1029b4a30: 9549c9c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4a34: aa1d03fd    	mov	x29, x29
1029b4a38: 9549c9c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4a3c: aa0003f3    	mov	x19, x0
1029b4a40: 9549c9c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4a44: b5000313    	cbnz	x19, 0x1029b4aa4 <_Flutter_Image_provideRelativePathByUrl+0xdc1954>
1029b4a48: f00ebe28    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029b4a4c: f9427d00    	ldr	x0, [x8, #0x4f8]
1029b4a50: 9549c9c2    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1029b4a54: aa0003f3    	mov	x19, x0
1029b4a58: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4a5c: f9444d01    	ldr	x1, [x8, #0x898] ; setScanner:
1029b4a60: aa1403e0    	mov	x0, x20
1029b4a64: aa1303e2    	mov	x2, x19
1029b4a68: 9549c9b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4a6c: aa1303e0    	mov	x0, x19
1029b4a70: 9549c9b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4a74: aa1403e0    	mov	x0, x20
1029b4a78: aa1503e1    	mov	x1, x21
1029b4a7c: 9549c9b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4a80: aa1d03fd    	mov	x29, x29
1029b4a84: 9549c9b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4a88: aa0003f3    	mov	x19, x0
1029b4a8c: f00eba88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1029b4a90: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
1029b4a94: aa1403e2    	mov	x2, x20
1029b4a98: 9549c9a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4a9c: aa1303e0    	mov	x0, x19
1029b4aa0: 9549c9ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4aa4: f00ebe88    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029b4aa8: f9458100    	ldr	x0, [x8, #0xb00]
1029b4aac: 9549c9ad    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1029b4ab0: b00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b4ab4: f945a901    	ldr	x1, [x8, #0xb50] ; initWithName:
1029b4ab8: d00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4abc: 91192042    	add	x2, x2, #0x648
1029b4ac0: 9549c99f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4ac4: aa0003f3    	mov	x19, x0
1029b4ac8: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4acc: f9444116    	ldr	x22, [x8, #0x880] ; configHandler
1029b4ad0: aa1403e0    	mov	x0, x20
1029b4ad4: aa1603e1    	mov	x1, x22
1029b4ad8: 9549c999    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4adc: aa1d03fd    	mov	x29, x29
1029b4ae0: 9549c99a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4ae4: aa0003f8    	mov	x24, x0
1029b4ae8: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4aec: f9429101    	ldr	x1, [x8, #0x520] ; m_isDelete
1029b4af0: 9549c993    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4af4: aa0003e2    	mov	x2, x0
1029b4af8: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4afc: f9424901    	ldr	x1, [x8, #0x490] ; setM_isDelete:
1029b4b00: aa1303e0    	mov	x0, x19
1029b4b04: 9549c98e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b08: aa1803e0    	mov	x0, x24
1029b4b0c: 9549c992    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4b10: aa1403e0    	mov	x0, x20
1029b4b14: aa1603e1    	mov	x1, x22
1029b4b18: 9549c989    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b1c: aa1d03fd    	mov	x29, x29
1029b4b20: 9549c98a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4b24: aa0003f8    	mov	x24, x0
1029b4b28: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4b2c: f9429501    	ldr	x1, [x8, #0x528] ; m_isDeleteUnknow
1029b4b30: 9549c983    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b34: aa0003e2    	mov	x2, x0
1029b4b38: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4b3c: f9424d01    	ldr	x1, [x8, #0x498] ; setM_isDeleteUnknow:
1029b4b40: aa1303e0    	mov	x0, x19
1029b4b44: 9549c97e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b48: aa1803e0    	mov	x0, x24
1029b4b4c: 9549c982    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4b50: aa1403e0    	mov	x0, x20
1029b4b54: aa1603e1    	mov	x1, x22
1029b4b58: 9549c979    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b5c: aa1d03fd    	mov	x29, x29
1029b4b60: 9549c97a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4b64: aa0003f8    	mov	x24, x0
1029b4b68: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4b6c: f9429901    	ldr	x1, [x8, #0x530] ; m_isReportDelUnknow
1029b4b70: 9549c973    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b74: aa0003e2    	mov	x2, x0
1029b4b78: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4b7c: f9425101    	ldr	x1, [x8, #0x4a0] ; setM_isReportDelUnknow:
1029b4b80: aa1303e0    	mov	x0, x19
1029b4b84: 9549c96e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4b88: aa1803e0    	mov	x0, x24
1029b4b8c: 9549c972    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4b90: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4b94: f9446901    	ldr	x1, [x8, #0x8d0] ; setM_isQuickScan:
1029b4b98: aa1303e0    	mov	x0, x19
1029b4b9c: 52800002    	mov	w2, #0x0                ; =0
1029b4ba0: 9549c967    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4ba4: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4ba8: f9446101    	ldr	x1, [x8, #0x8c0] ; setUseFolderCache:
1029b4bac: aa1303e0    	mov	x0, x19
1029b4bb0: 52800022    	mov	w2, #0x1                ; =1
1029b4bb4: 9549c962    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4bb8: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4bbc: f944a901    	ldr	x1, [x8, #0x950] ; setM_urgentLevel:
1029b4bc0: aa1303e0    	mov	x0, x19
1029b4bc4: aa1703e2    	mov	x2, x23
1029b4bc8: 9549c95d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4bcc: aa1403e0    	mov	x0, x20
1029b4bd0: aa1603e1    	mov	x1, x22
1029b4bd4: 9549c95a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4bd8: aa1d03fd    	mov	x29, x29
1029b4bdc: 9549c95b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4be0: aa0003f7    	mov	x23, x0
1029b4be4: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4be8: f942a101    	ldr	x1, [x8, #0x540] ; m_isEnableDeleteEmptyFolder
1029b4bec: 9549c954    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4bf0: aa0003e2    	mov	x2, x0
1029b4bf4: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4bf8: f944ad01    	ldr	x1, [x8, #0x958] ; setIsDeleteEmptyFolder:
1029b4bfc: aa1303e0    	mov	x0, x19
1029b4c00: 9549c94f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4c04: aa1703e0    	mov	x0, x23
1029b4c08: 9549c953    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4c0c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4c10: f9446501    	ldr	x1, [x8, #0x8c8] ; setM_bSuspendable:
1029b4c14: aa1303e0    	mov	x0, x19
1029b4c18: 52800022    	mov	w2, #0x1                ; =1
1029b4c1c: 9549c948    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4c20: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4c24: f9445d01    	ldr	x1, [x8, #0x8b8] ; setIsIgnoreCowFile:
1029b4c28: aa1303e0    	mov	x0, x19
1029b4c2c: 52800022    	mov	w2, #0x1                ; =1
1029b4c30: 9549c943    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4c34: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b4c38: f945e900    	ldr	x0, [x8, #0xbd0]
1029b4c3c: 900eba68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029b4c40: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1029b4c44: 9549c93e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4c48: aa1d03fd    	mov	x29, x29
1029b4c4c: 9549c93f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4c50: aa0003f8    	mov	x24, x0
1029b4c54: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b4c58: f9467100    	ldr	x0, [x8, #0xce0]
1029b4c5c: f00eba48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1029b4c60: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1029b4c64: 9549c936    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4c68: aa0003e2    	mov	x2, x0
1029b4c6c: b00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b4c70: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1029b4c74: aa1803e0    	mov	x0, x24
1029b4c78: 9549c931    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4c7c: aa1d03fd    	mov	x29, x29
1029b4c80: 9549c932    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4c84: aa0003f9    	mov	x25, x0
1029b4c88: d00ea428    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1029b4c8c: f9422501    	ldr	x1, [x8, #0x448] ; getIntegerExpt:withDef:
1029b4c90: d00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4c94: 9119a042    	add	x2, x2, #0x668
1029b4c98: d2800003    	mov	x3, #0x0                ; =0
1029b4c9c: 9549c928    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4ca0: aa0003f7    	mov	x23, x0
1029b4ca4: aa1903e0    	mov	x0, x25
1029b4ca8: 9549c92b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4cac: aa1803e0    	mov	x0, x24
1029b4cb0: 9549c929    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4cb4: f10006ff    	cmp	x23, #0x1
1029b4cb8: 540007cb    	b.lt	0x1029b4db0 <_Flutter_Image_provideRelativePathByUrl+0xdc1c60>
1029b4cbc: f00ebe28    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029b4cc0: f9425500    	ldr	x0, [x8, #0x4a8]
1029b4cc4: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4cc8: f9440101    	ldr	x1, [x8, #0x800] ; useFastList
1029b4ccc: 9549c91c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4cd0: 37000700    	tbnz	w0, #0x0, 0x1029b4db0 <_Flutter_Image_provideRelativePathByUrl+0xdc1c60>
1029b4cd4: 528a3008    	mov	w8, #0x5180             ; =20864
1029b4cd8: 72a00028    	movk	w8, #0x1, lsl #16
1029b4cdc: 9b087ef9    	mul	x25, x23, x8
1029b4ce0: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b4ce4: f9457100    	ldr	x0, [x8, #0xae0]
1029b4ce8: 900eba68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029b4cec: f9460d01    	ldr	x1, [x8, #0xc18] ; date
1029b4cf0: 9549c913    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4cf4: aa1d03fd    	mov	x29, x29
1029b4cf8: 9549c914    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4cfc: aa0003f7    	mov	x23, x0
1029b4d00: f00ebaa8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1029b4d04: f940a901    	ldr	x1, [x8, #0x150] ; timeIntervalSince1970
1029b4d08: 9549c90d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4d0c: 9e79001a    	fcvtzu	x26, d0
1029b4d10: aa1703e0    	mov	x0, x23
1029b4d14: 9549c910    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4d18: aa1403e0    	mov	x0, x20
1029b4d1c: aa1503e1    	mov	x1, x21
1029b4d20: 9549c907    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4d24: aa1d03fd    	mov	x29, x29
1029b4d28: 9549c908    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4d2c: aa0003f7    	mov	x23, x0
1029b4d30: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4d34: f944b101    	ldr	x1, [x8, #0x960] ; getLastReportCacheAndOtherDataFastTime
1029b4d38: 9549c901    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4d3c: aa0003f8    	mov	x24, x0
1029b4d40: aa1703e0    	mov	x0, x23
1029b4d44: 9549c904    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4d48: cb180357    	sub	x23, x26, x24
1029b4d4c: f00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b4d50: f9453500    	ldr	x0, [x8, #0xa68]
1029b4d54: b00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b4d58: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b4d5c: a900e7f7    	stp	x23, x25, [sp, #0x8]
1029b4d60: d00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b4d64: 911a2108    	add	x8, x8, #0x688
1029b4d68: f90003e8    	str	x8, [sp]
1029b4d6c: 900c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b4d70: 9125d063    	add	x3, x3, #0x974
1029b4d74: f00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b4d78: 9134f8a5    	add	x5, x5, #0xd3e
1029b4d7c: 900c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b4d80: 9111d4e7    	add	x7, x7, #0x475
1029b4d84: 52800042    	mov	w2, #0x2                ; =2
1029b4d88: 52800004    	mov	w4, #0x0                ; =0
1029b4d8c: 52804c26    	mov	w6, #0x261              ; =609
1029b4d90: 9549c8eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4d94: eb1902ff    	cmp	x23, x25
1029b4d98: 540000c9    	b.ls	0x1029b4db0 <_Flutter_Image_provideRelativePathByUrl+0xdc1c60>
1029b4d9c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4da0: f944b501    	ldr	x1, [x8, #0x968] ; setWillSaveCacheAndOtherData:
1029b4da4: aa1303e0    	mov	x0, x19
1029b4da8: 52800022    	mov	w2, #0x1                ; =1
1029b4dac: 9549c8e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4db0: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4db4: f944b901    	ldr	x1, [x8, #0x970] ; shouldDiskUsageReport
1029b4db8: aa1403e0    	mov	x0, x20
1029b4dbc: 9549c8e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4dc0: aa0003e2    	mov	x2, x0
1029b4dc4: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4dc8: f944bd01    	ldr	x1, [x8, #0x978] ; setShouldReport:
1029b4dcc: aa1403e0    	mov	x0, x20
1029b4dd0: 9549c8db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4dd4: 900ea588    	adrp	x8, 0x11fe64000 <dyld_stub_binder+0x11fe64000>
1029b4dd8: f9421901    	ldr	x1, [x8, #0x430] ; shouldReport
1029b4ddc: aa1403e0    	mov	x0, x20
1029b4de0: 9549c8d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4de4: 340002a0    	cbz	w0, 0x1029b4e38 <_Flutter_Image_provideRelativePathByUrl+0xdc1ce8>
1029b4de8: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4dec: f944c101    	ldr	x1, [x8, #0x980] ; setM_bSaveReportData:
1029b4df0: aa1303e0    	mov	x0, x19
1029b4df4: 52800022    	mov	w2, #0x1                ; =1
1029b4df8: 9549c8d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4dfc: f00ebe88    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029b4e00: f9457d00    	ldr	x0, [x8, #0xaf8]
1029b4e04: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4e08: f944c501    	ldr	x1, [x8, #0x988] ; regularExpressionsThatLogFilesToKV
1029b4e0c: 9549c8cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4e10: aa1d03fd    	mov	x29, x29
1029b4e14: 9549c8cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4e18: aa0003f7    	mov	x23, x0
1029b4e1c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4e20: f944c901    	ldr	x1, [x8, #0x990] ; setRegularExpressionsThatLogFilesToKV:
1029b4e24: aa1303e0    	mov	x0, x19
1029b4e28: aa1703e2    	mov	x2, x23
1029b4e2c: 9549c8c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4e30: aa1703e0    	mov	x0, x23
1029b4e34: 9549c8c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4e38: aa1403e0    	mov	x0, x20
1029b4e3c: aa1603e1    	mov	x1, x22
1029b4e40: 9549c8bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4e44: aa1d03fd    	mov	x29, x29
1029b4e48: 9549c8c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4e4c: aa0003f6    	mov	x22, x0
1029b4e50: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4e54: f942a501    	ldr	x1, [x8, #0x548] ; m_isEnablePreForceCleanTmp
1029b4e58: 9549c8b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4e5c: 34000600    	cbz	w0, 0x1029b4f1c <_Flutter_Image_provideRelativePathByUrl+0xdc1dcc>
1029b4e60: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4e64: f944cd01    	ldr	x1, [x8, #0x998] ; p_shouldForceCleanTmp
1029b4e68: aa1403e0    	mov	x0, x20
1029b4e6c: 9549c8b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4e70: aa0003f7    	mov	x23, x0
1029b4e74: aa1603e0    	mov	x0, x22
1029b4e78: 9549c8b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4e7c: 34000557    	cbz	w23, 0x1029b4f24 <_Flutter_Image_provideRelativePathByUrl+0xdc1dd4>
1029b4e80: 910123e0    	add	x0, sp, #0x48
1029b4e84: aa1403e1    	mov	x1, x20
1029b4e88: 9549c8b9    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
1029b4e8c: 52800040    	mov	w0, #0x2                ; =2
1029b4e90: d2800001    	mov	x1, #0x0                ; =0
1029b4e94: 9549c8c1    	bl	0x107c27198 <_Flutter_MMFoundation_BindContext+0x4102d7c>
1029b4e98: aa1d03fd    	mov	x29, x29
1029b4e9c: 9549c8ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4ea0: aa0003f4    	mov	x20, x0
1029b4ea4: d00d61c8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1029b4ea8: f947e108    	ldr	x8, [x8, #0xfc0]
1029b4eac: f9000fe8    	str	x8, [sp, #0x18]
1029b4eb0: b00b1e68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1029b4eb4: fd41c100    	ldr	d0, [x8, #0x380]
1029b4eb8: 90000008    	adrp	x8, 0x1029b4000 <_Flutter_Image_provideRelativePathByUrl+0xdc0eb0>
1029b4ebc: 913de108    	add	x8, x8, #0xf78
1029b4ec0: fd0013e0    	str	d0, [sp, #0x20]
1029b4ec4: f00d6209    	adrp	x9, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
1029b4ec8: 912fa129    	add	x9, x9, #0xbe8
1029b4ecc: a902a7e8    	stp	x8, x9, [sp, #0x28]
1029b4ed0: 910063f5    	add	x21, sp, #0x18
1029b4ed4: 9100a2a0    	add	x0, x21, #0x28
1029b4ed8: 910123e1    	add	x1, sp, #0x48
1029b4edc: 9549c8a7    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1029b4ee0: aa1303e0    	mov	x0, x19
1029b4ee4: 9549c895    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029b4ee8: f9001ff3    	str	x19, [sp, #0x38]
1029b4eec: 910063e1    	add	x1, sp, #0x18
1029b4ef0: aa1403e0    	mov	x0, x20
1029b4ef4: 954960cb    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
1029b4ef8: aa1403e0    	mov	x0, x20
1029b4efc: 9549c896    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4f00: f9401fe0    	ldr	x0, [sp, #0x38]
1029b4f04: 9549c894    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4f08: 9100a2a0    	add	x0, x21, #0x28
1029b4f0c: 9549c8a1    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1029b4f10: 910123e0    	add	x0, sp, #0x48
1029b4f14: 9549c89f    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1029b4f18: 1400000f    	b	0x1029b4f54 <_Flutter_Image_provideRelativePathByUrl+0xdc1e04>
1029b4f1c: aa1603e0    	mov	x0, x22
1029b4f20: 9549c88d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4f24: aa1403e0    	mov	x0, x20
1029b4f28: aa1503e1    	mov	x1, x21
1029b4f2c: 9549c884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4f30: aa1d03fd    	mov	x29, x29
1029b4f34: 9549c885    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b4f38: aa0003f4    	mov	x20, x0
1029b4f3c: 900eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b4f40: f9448101    	ldr	x1, [x8, #0x900] ; startWithScanConfig:
1029b4f44: aa1303e2    	mov	x2, x19
1029b4f48: 9549c87d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b4f4c: aa1403e0    	mov	x0, x20
1029b4f50: 9549c881    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4f54: aa1303e0    	mov	x0, x19
1029b4f58: 9549c87f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b4f5c: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1029b4f60: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1029b4f64: a94757f6    	ldp	x22, x21, [sp, #0x70]
1029b4f68: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1029b4f6c: a94567fa    	ldp	x26, x25, [sp, #0x50]
1029b4f70: 910283ff    	add	sp, sp, #0xa0
1029b4f74: d65f03c0    	ret
