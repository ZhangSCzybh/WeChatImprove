
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b3af4: d10203ff    	sub	sp, sp, #0x80
1029b3af8: a9026ffc    	stp	x28, x27, [sp, #0x20]
1029b3afc: a90367fa    	stp	x26, x25, [sp, #0x30]
1029b3b00: a9045ff8    	stp	x24, x23, [sp, #0x40]
1029b3b04: a90557f6    	stp	x22, x21, [sp, #0x50]
1029b3b08: a9064ff4    	stp	x20, x19, [sp, #0x60]
1029b3b0c: a9077bfd    	stp	x29, x30, [sp, #0x70]
1029b3b10: 9101c3fd    	add	x29, sp, #0x70
1029b3b14: aa0403f3    	mov	x19, x4
1029b3b18: 29030be3    	stp	w3, w2, [sp, #0x18]
1029b3b1c: f9000be0    	str	x0, [sp, #0x10]
1029b3b20: f00f1408    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029b3b24: 52800029    	mov	w9, #0x1                ; =1
1029b3b28: 39347109    	strb	w9, [x8, #0xd1c]
1029b3b2c: aa0403e0    	mov	x0, x4
1029b3b30: 9549cd82    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029b3b34: 900ebe1c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3b38: f945eb80    	ldr	x0, [x28, #0xbd0]
1029b3b3c: b00eba68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1029b3b40: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
1029b3b44: aa1503e1    	mov	x1, x21
1029b3b48: 9549cd7d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3b4c: aa1d03fd    	mov	x29, x29
1029b3b50: 9549cd7e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3b54: aa0003f8    	mov	x24, x0
1029b3b58: 900ebe1b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3b5c: f9467360    	ldr	x0, [x27, #0xce0]
1029b3b60: 900eba68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1029b3b64: f947ad16    	ldr	x22, [x8, #0xf58] ; class
1029b3b68: aa1603e1    	mov	x1, x22
1029b3b6c: 9549cd74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3b70: aa0003e2    	mov	x2, x0
1029b3b74: d00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b3b78: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
1029b3b7c: aa1803e0    	mov	x0, x24
1029b3b80: aa1703e1    	mov	x1, x23
1029b3b84: 9549cd6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3b88: aa1d03fd    	mov	x29, x29
1029b3b8c: 9549cd6f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3b90: aa0003f9    	mov	x25, x0
1029b3b94: f00ea428    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1029b3b98: f940411a    	ldr	x26, [x8, #0x80] ; getExpt:withBoolDef:
1029b3b9c: f00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3ba0: 9110a042    	add	x2, x2, #0x428
1029b3ba4: aa1a03e1    	mov	x1, x26
1029b3ba8: 52800003    	mov	w3, #0x0                ; =0
1029b3bac: 9549cd64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3bb0: aa0003f4    	mov	x20, x0
1029b3bb4: aa1903e0    	mov	x0, x25
1029b3bb8: 9549cd67    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3bbc: aa1803e0    	mov	x0, x24
1029b3bc0: 9549cd65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3bc4: f945eb80    	ldr	x0, [x28, #0xbd0]
1029b3bc8: aa1503e1    	mov	x1, x21
1029b3bcc: 9549cd5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3bd0: aa1d03fd    	mov	x29, x29
1029b3bd4: 9549cd5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3bd8: aa0003f8    	mov	x24, x0
1029b3bdc: f9467360    	ldr	x0, [x27, #0xce0]
1029b3be0: aa1603e1    	mov	x1, x22
1029b3be4: 9549cd56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3be8: aa0003e2    	mov	x2, x0
1029b3bec: aa1803e0    	mov	x0, x24
1029b3bf0: aa1703e1    	mov	x1, x23
1029b3bf4: 9549cd52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3bf8: aa1d03fd    	mov	x29, x29
1029b3bfc: 9549cd53    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3c00: aa0003f9    	mov	x25, x0
1029b3c04: f00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3c08: 91112042    	add	x2, x2, #0x448
1029b3c0c: aa1a03e1    	mov	x1, x26
1029b3c10: 52800003    	mov	w3, #0x0                ; =0
1029b3c14: 9549cd4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3c18: aa0003fc    	mov	x28, x0
1029b3c1c: aa1903e0    	mov	x0, x25
1029b3c20: 9549cd4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3c24: aa1803e0    	mov	x0, x24
1029b3c28: 9549cd4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3c2c: 900ebe08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3c30: f9453500    	ldr	x0, [x8, #0xa68]
1029b3c34: d00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b3c38: f942a919    	ldr	x25, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b3c3c: f00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3c40: 9111a108    	add	x8, x8, #0x468
1029b3c44: a90053e8    	stp	x8, x20, [sp]
1029b3c48: b00c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b3c4c: 9125d063    	add	x3, x3, #0x974
1029b3c50: 900c5e85    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b3c54: 9134f8a5    	add	x5, x5, #0xd3e
1029b3c58: b00c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b3c5c: 9105f4e7    	add	x7, x7, #0x17d
1029b3c60: aa1903e1    	mov	x1, x25
1029b3c64: 52800042    	mov	w2, #0x2                ; =2
1029b3c68: 52800004    	mov	w4, #0x0                ; =0
1029b3c6c: 52803746    	mov	w6, #0x1ba              ; =442
1029b3c70: 9549cd33    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3c74: 900ebea8    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1029b3c78: f9458100    	ldr	x0, [x8, #0xb00]
1029b3c7c: 9549cd39    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1029b3c80: d00ea428    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b3c84: f945a901    	ldr	x1, [x8, #0xb50] ; initWithName:
1029b3c88: f00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3c8c: 91122042    	add	x2, x2, #0x488
1029b3c90: 9549cd2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3c94: aa0003f8    	mov	x24, x0
1029b3c98: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3c9c: f9445501    	ldr	x1, [x8, #0x8a8] ; setWillScanWholeWechat:
1029b3ca0: 52800022    	mov	w2, #0x1                ; =1
1029b3ca4: 9549cd26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3ca8: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3cac: f9445901    	ldr	x1, [x8, #0x8b0] ; setWillConvertMidImgWxam:
1029b3cb0: aa1803e0    	mov	x0, x24
1029b3cb4: aa1403e2    	mov	x2, x20
1029b3cb8: 9549cd21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3cbc: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3cc0: f9445d01    	ldr	x1, [x8, #0x8b8] ; setIsIgnoreCowFile:
1029b3cc4: aa1803e0    	mov	x0, x24
1029b3cc8: 52800022    	mov	w2, #0x1                ; =1
1029b3ccc: 9549cd1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3cd0: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3cd4: f9446101    	ldr	x1, [x8, #0x8c0] ; setUseFolderCache:
1029b3cd8: aa1803e0    	mov	x0, x24
1029b3cdc: 52800022    	mov	w2, #0x1                ; =1
1029b3ce0: 9549cd17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3ce4: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3ce8: f9446501    	ldr	x1, [x8, #0x8c8] ; setM_bSuspendable:
1029b3cec: aa1803e0    	mov	x0, x24
1029b3cf0: 52800022    	mov	w2, #0x1                ; =1
1029b3cf4: 9549cd12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3cf8: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3cfc: f944691a    	ldr	x26, [x8, #0x8d0] ; setM_isQuickScan:
1029b3d00: aa1803e0    	mov	x0, x24
1029b3d04: aa1a03e1    	mov	x1, x26
1029b3d08: b9401be2    	ldr	w2, [sp, #0x18]
1029b3d0c: f9400bfb    	ldr	x27, [sp, #0x10]
1029b3d10: 9549cd0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d14: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3d18: f9446d14    	ldr	x20, [x8, #0x8d8] ; setWillReportExistC2CFile:
1029b3d1c: aa1803e0    	mov	x0, x24
1029b3d20: aa1403e1    	mov	x1, x20
1029b3d24: aa1c03e2    	mov	x2, x28
1029b3d28: 9549cd05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d2c: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3d30: f9447101    	ldr	x1, [x8, #0x8e0] ; ifStoreToFileIndexService
1029b3d34: aa1b03e0    	mov	x0, x27
1029b3d38: 9549cd01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d3c: aa0003e2    	mov	x2, x0
1029b3d40: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3d44: f9447501    	ldr	x1, [x8, #0x8e8] ; setWillStoreToFileIndex:
1029b3d48: aa1803e0    	mov	x0, x24
1029b3d4c: 9549ccfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d50: b9401fe8    	ldr	w8, [sp, #0x1c]
1029b3d54: 340007c8    	cbz	w8, 0x1029b3e4c <_Flutter_Image_provideRelativePathByUrl+0xdc0cfc>
1029b3d58: aa1803e0    	mov	x0, x24
1029b3d5c: aa1a03e1    	mov	x1, x26
1029b3d60: 52800022    	mov	w2, #0x1                ; =1
1029b3d64: 9549ccf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d68: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3d6c: f9424901    	ldr	x1, [x8, #0x490] ; setM_isDelete:
1029b3d70: aa1803e0    	mov	x0, x24
1029b3d74: 52800022    	mov	w2, #0x1                ; =1
1029b3d78: 9549ccf1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d7c: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3d80: f9447901    	ldr	x1, [x8, #0x8f0] ; setM_isDeleteExpireFileForDebug:
1029b3d84: aa1803e0    	mov	x0, x24
1029b3d88: 52800022    	mov	w2, #0x1                ; =1
1029b3d8c: 9549ccec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3d90: aa1803e0    	mov	x0, x24
1029b3d94: aa1403e1    	mov	x1, x20
1029b3d98: 52800022    	mov	w2, #0x1                ; =1
1029b3d9c: 9549cce8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3da0: 900ebe08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3da4: f945e900    	ldr	x0, [x8, #0xbd0]
1029b3da8: aa1503e1    	mov	x1, x21
1029b3dac: 9549cce4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3db0: aa1d03fd    	mov	x29, x29
1029b3db4: 9549cce5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3db8: aa0003f4    	mov	x20, x0
1029b3dbc: 900ebe08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3dc0: f9467100    	ldr	x0, [x8, #0xce0]
1029b3dc4: aa1603e1    	mov	x1, x22
1029b3dc8: 9549ccdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3dcc: aa0003e2    	mov	x2, x0
1029b3dd0: aa1403e0    	mov	x0, x20
1029b3dd4: aa1703e1    	mov	x1, x23
1029b3dd8: 9549ccd9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3ddc: aa1d03fd    	mov	x29, x29
1029b3de0: 9549ccda    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3de4: aa0003f5    	mov	x21, x0
1029b3de8: f00ea428    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1029b3dec: f9422d01    	ldr	x1, [x8, #0x458] ; getExpt:withDef:
1029b3df0: f00de602    	adrp	x2, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3df4: 9112a042    	add	x2, x2, #0x4a8
1029b3df8: f00dd843    	adrp	x3, 0x11e4be000 <dyld_stub_binder+0x11e4be000>
1029b3dfc: 9132a063    	add	x3, x3, #0xca8
1029b3e00: 9549cccf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3e04: aa1d03fd    	mov	x29, x29
1029b3e08: 9549ccd0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3e0c: aa0003f6    	mov	x22, x0
1029b3e10: aa1503e0    	mov	x0, x21
1029b3e14: 9549ccd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3e18: aa1403e0    	mov	x0, x20
1029b3e1c: 9549ccce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3e20: 900eba88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029b3e24: f9424901    	ldr	x1, [x8, #0x490] ; intValue
1029b3e28: aa1603e0    	mov	x0, x22
1029b3e2c: 9549ccc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3e30: aa0003e2    	mov	x2, x0
1029b3e34: b00ea748    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
1029b3e38: f943d901    	ldr	x1, [x8, #0x7b0] ; setConcurrentCount:
1029b3e3c: aa1803e0    	mov	x0, x24
1029b3e40: 9549ccbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3e44: aa1603e0    	mov	x0, x22
1029b3e48: 9549ccc3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3e4c: 900ebe08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b3e50: f9453500    	ldr	x0, [x8, #0xa68]
1029b3e54: f00de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b3e58: 91132108    	add	x8, x8, #0x4c8
1029b3e5c: f90003e8    	str	x8, [sp]
1029b3e60: b00c5e43    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b3e64: 9125d063    	add	x3, x3, #0x974
1029b3e68: 900c5e85    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b3e6c: 9134f8a5    	add	x5, x5, #0xd3e
1029b3e70: b00c5e87    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b3e74: 9105f4e7    	add	x7, x7, #0x17d
1029b3e78: aa1903e1    	mov	x1, x25
1029b3e7c: 52800042    	mov	w2, #0x2                ; =2
1029b3e80: 52800004    	mov	w4, #0x0                ; =0
1029b3e84: 528039e6    	mov	w6, #0x1cf              ; =463
1029b3e88: 9549ccad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3e8c: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3e90: f943ed01    	ldr	x1, [x8, #0x7d8] ; scanner
1029b3e94: aa1b03e0    	mov	x0, x27
1029b3e98: 9549cca9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3e9c: aa1d03fd    	mov	x29, x29
1029b3ea0: 9549ccaa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b3ea4: aa0003f4    	mov	x20, x0
1029b3ea8: b4000113    	cbz	x19, 0x1029b3ec8 <_Flutter_Image_provideRelativePathByUrl+0xdc0d78>
1029b3eac: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3eb0: f9447d01    	ldr	x1, [x8, #0x8f8] ; startWithScanConfig:completion:
1029b3eb4: aa1403e0    	mov	x0, x20
1029b3eb8: aa1803e2    	mov	x2, x24
1029b3ebc: aa1303e3    	mov	x3, x19
1029b3ec0: 9549cc9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3ec4: 14000006    	b	0x1029b3edc <_Flutter_Image_provideRelativePathByUrl+0xdc0d8c>
1029b3ec8: b00eaa28    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b3ecc: f9448101    	ldr	x1, [x8, #0x900] ; startWithScanConfig:
1029b3ed0: aa1403e0    	mov	x0, x20
1029b3ed4: aa1803e2    	mov	x2, x24
1029b3ed8: 9549cc99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b3edc: aa1403e0    	mov	x0, x20
1029b3ee0: 9549cc9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3ee4: aa1803e0    	mov	x0, x24
1029b3ee8: 9549cc9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b3eec: aa1303e0    	mov	x0, x19
1029b3ef0: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1029b3ef4: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1029b3ef8: a94557f6    	ldp	x22, x21, [sp, #0x50]
1029b3efc: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1029b3f00: a94367fa    	ldp	x26, x25, [sp, #0x30]
1029b3f04: a9426ffc    	ldp	x28, x27, [sp, #0x20]
1029b3f08: 910203ff    	add	sp, sp, #0x80
1029b3f0c: 1549cc92    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
