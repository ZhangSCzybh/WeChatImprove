
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104df0cf8: d102c3ff    	sub	sp, sp, #0xb0
104df0cfc: a9056ffc    	stp	x28, x27, [sp, #0x50]
104df0d00: a90667fa    	stp	x26, x25, [sp, #0x60]
104df0d04: a9075ff8    	stp	x24, x23, [sp, #0x70]
104df0d08: a90857f6    	stp	x22, x21, [sp, #0x80]
104df0d0c: a9094ff4    	stp	x20, x19, [sp, #0x90]
104df0d10: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
104df0d14: 910283fd    	add	x29, sp, #0xa0
104df0d18: aa0203f3    	mov	x19, x2
104df0d1c: aa0003f4    	mov	x20, x0
104df0d20: 900c4ae8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
104df0d24: f9451908    	ldr	x8, [x8, #0xa30]
104df0d28: f9400108    	ldr	x8, [x8]
104df0d2c: f90027e8    	str	x8, [sp, #0x48]
104df0d30: b00d4b08    	adrp	x8, 0x11f751000 <dyld_stub_binder+0x11f751000>
104df0d34: 52800029    	mov	w9, #0x1                ; =1
104df0d38: 39315109    	strb	w9, [x8, #0xc54]
104df0d3c: aa0203e0    	mov	x0, x2
104df0d40: 94b8dbcd    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104df0d44: d00cdee8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104df0d48: f9403916    	ldr	x22, [x8, #0x70] ; selector: GetChatName
104df0d4c: aa1303e0    	mov	x0, x19
104df0d50: aa1603e1    	mov	x1, x22
104df0d54: 94b8dbc4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0d58: aa1d03fd    	mov	x29, x29
104df0d5c: 94b8dbc9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0d60: aa0003f5    	mov	x21, x0
104df0d64: b40037d3    	cbz	x19, 0x104df145c <_Flutter_MMFoundation_BindContext+0x1078128>
104df0d68: d00ce8c8    	adrp	x8, 0x11eb0a000 <dyld_stub_binder+0x11eb0a000>
104df0d6c: f9458101    	ldr	x1, [x8, #0xb00] ; selector: m_bNew
104df0d70: aa1303e0    	mov	x0, x19
104df0d74: 94b8dbbc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0d78: 34003720    	cbz	w0, 0x104df145c <_Flutter_MMFoundation_BindContext+0x1078128>
104df0d7c: f00cdee8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
104df0d80: f9435501    	ldr	x1, [x8, #0x6a8] ; selector: IsFileUploadingMsg
104df0d84: aa1303e0    	mov	x0, x19
104df0d88: 94b8dbb7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0d8c: d00cdef9    	adrp	x25, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104df0d90: 340003a0    	cbz	w0, 0x104df0e04 <_Flutter_MMFoundation_BindContext+0x1077ad0>
104df0d94: d00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df0d98: f943c100    	ldr	x0, [x8, #0x780]
104df0d9c: b00cdec8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104df0da0: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
104df0da4: 94b8dbb0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0da8: aa1d03fd    	mov	x29, x29
104df0dac: 94b8dbb5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0db0: aa0003f7    	mov	x23, x0
104df0db4: f00cf928    	adrp	x8, 0x11ed17000 <dyld_stub_binder+0x11ed17000>
104df0db8: f9465100    	ldr	x0, [x8, #0xca0]
104df0dbc: d00cf5a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104df0dc0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
104df0dc4: 94b8dba8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0dc8: aa0003e2    	mov	x2, x0
104df0dcc: b00cdec8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104df0dd0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
104df0dd4: aa1703e0    	mov	x0, x23
104df0dd8: 94b8dba3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0ddc: aa1d03fd    	mov	x29, x29
104df0de0: 94b8dba8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0de4: aa0003f8    	mov	x24, x0
104df0de8: 900ce9a8    	adrp	x8, 0x11eb24000 <dyld_stub_binder+0x11eb24000>
104df0dec: f941c901    	ldr	x1, [x8, #0x390] ; selector: appMsgStartUpload:
104df0df0: aa1303e2    	mov	x2, x19
104df0df4: 94b8db9c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0df8: aa1803e0    	mov	x0, x24
104df0dfc: 94b8db9d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df0e00: 14000028    	b	0x104df0ea0 <_Flutter_MMFoundation_BindContext+0x1077b6c>
104df0e04: d00cdee8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104df0e08: f945ed01    	ldr	x1, [x8, #0xbd8] ; selector: IsFileMsg
104df0e0c: aa1303e0    	mov	x0, x19
104df0e10: 94b8db95    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0e14: 34000160    	cbz	w0, 0x104df0e40 <_Flutter_MMFoundation_BindContext+0x1077b0c>
104df0e18: b00cdee8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
104df0e1c: f942bd01    	ldr	x1, [x8, #0x578] ; selector: m_nsFromUsr
104df0e20: aa1303e0    	mov	x0, x19
104df0e24: 94b8db90    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0e28: aa1d03fd    	mov	x29, x29
104df0e2c: 94b8db95    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0e30: aa0003f7    	mov	x23, x0
104df0e34: 900ce9a8    	adrp	x8, 0x11eb24000 <dyld_stub_binder+0x11eb24000>
104df0e38: f941cd01    	ldr	x1, [x8, #0x398] ; selector: HandleAppMsg:MsgWrap:
104df0e3c: 14000015    	b	0x104df0e90 <_Flutter_MMFoundation_BindContext+0x1077b5c>
104df0e40: f941fb21    	ldr	x1, [x25, #0x3f0] ; selector: m_uiMessageType
104df0e44: aa1303e0    	mov	x0, x19
104df0e48: 94b8db87    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0e4c: 7100ac1f    	cmp	w0, #0x2b
104df0e50: 540002c1    	b.ne	0x104df0ea8 <_Flutter_MMFoundation_BindContext+0x1077b74>
104df0e54: 900ce9a8    	adrp	x8, 0x11eb24000 <dyld_stub_binder+0x11eb24000>
104df0e58: f9401101    	ldr	x1, [x8, #0x20] ; selector: m_n64OverWriteMsgSvrID
104df0e5c: aa1303e0    	mov	x0, x19
104df0e60: 94b8db81    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0e64: f100041f    	cmp	x0, #0x1
104df0e68: 5400020b    	b.lt	0x104df0ea8 <_Flutter_MMFoundation_BindContext+0x1077b74>
104df0e6c: b00cdee8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
104df0e70: f942bd01    	ldr	x1, [x8, #0x578] ; selector: m_nsFromUsr
104df0e74: aa1303e0    	mov	x0, x19
104df0e78: 94b8db7b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0e7c: aa1d03fd    	mov	x29, x29
104df0e80: 94b8db80    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0e84: aa0003f7    	mov	x23, x0
104df0e88: 900ce9a8    	adrp	x8, 0x11eb24000 <dyld_stub_binder+0x11eb24000>
104df0e8c: f941d101    	ldr	x1, [x8, #0x3a0] ; selector: HandleVideoMsg:MsgWrap:
104df0e90: aa1403e0    	mov	x0, x20
104df0e94: aa1703e2    	mov	x2, x23
104df0e98: aa1303e3    	mov	x3, x19
104df0e9c: 94b8db72    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0ea0: aa1703e0    	mov	x0, x23
104df0ea4: 94b8db73    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df0ea8: f941fb37    	ldr	x23, [x25, #0x3f0] ; selector: m_uiMessageType
104df0eac: aa1303e0    	mov	x0, x19
104df0eb0: aa1703e1    	mov	x1, x23
104df0eb4: 94b8db6c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0eb8: 7100bc1f    	cmp	w0, #0x2f
104df0ebc: 54000581    	b.ne	0x104df0f6c <_Flutter_MMFoundation_BindContext+0x1077c38>
104df0ec0: f00cdee8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
104df0ec4: f9417901    	ldr	x1, [x8, #0x2f0] ; selector: m_nsEmoticonMD5
104df0ec8: aa1303e0    	mov	x0, x19
104df0ecc: 94b8db66    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0ed0: aa1d03fd    	mov	x29, x29
104df0ed4: 94b8db6b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0ed8: aa0003f6    	mov	x22, x0
104df0edc: 900cf5c8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
104df0ee0: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
104df0ee4: 94b8db60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0ee8: aa0003f7    	mov	x23, x0
104df0eec: aa1603e0    	mov	x0, x22
104df0ef0: 94b8db60    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df0ef4: b40029d7    	cbz	x23, 0x104df142c <_Flutter_MMFoundation_BindContext+0x10780f8>
104df0ef8: d00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df0efc: f943c100    	ldr	x0, [x8, #0x780]
104df0f00: b00cdec8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104df0f04: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
104df0f08: 94b8db57    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0f0c: aa1d03fd    	mov	x29, x29
104df0f10: 94b8db5c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0f14: aa0003f6    	mov	x22, x0
104df0f18: d00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df0f1c: f9446100    	ldr	x0, [x8, #0x8c0]
104df0f20: d00cf5a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104df0f24: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
104df0f28: 94b8db4f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0f2c: aa0003e2    	mov	x2, x0
104df0f30: b00cdec8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104df0f34: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
104df0f38: aa1603e0    	mov	x0, x22
104df0f3c: 94b8db4a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0f40: aa1d03fd    	mov	x29, x29
104df0f44: 94b8db4f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0f48: aa0003f7    	mov	x23, x0
104df0f4c: b00ce3a8    	adrp	x8, 0x11ea65000 <dyld_stub_binder+0x11ea65000>
104df0f50: f9448901    	ldr	x1, [x8, #0x910] ; selector: isAutoDownloadCloseForKey:
104df0f54: d00c2682    	adrp	x2, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104df0f58: 913ae042    	add	x2, x2, #0xeb8 ; CFString: C2CEmojiNotAutoDownloadTimeRange
104df0f5c: 94b8db42    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0f60: 36001340    	tbz	w0, #0x0, 0x104df11c8 <_Flutter_MMFoundation_BindContext+0x1077e94>
104df0f64: aa1703e0    	mov	x0, x23
104df0f68: 1400012e    	b	0x104df1420 <_Flutter_MMFoundation_BindContext+0x10780ec>
104df0f6c: aa1303e0    	mov	x0, x19
104df0f70: aa1703e1    	mov	x1, x23
104df0f74: 94b8db3c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0f78: 7100041f    	cmp	w0, #0x1
104df0f7c: 54000521    	b.ne	0x104df1020 <_Flutter_MMFoundation_BindContext+0x1077cec>
104df0f80: b00cfea8    	adrp	x8, 0x11edc5000 <dyld_stub_binder+0x11edc5000>
104df0f84: b986f508    	ldrsw	x8, [x8, #0x6f4] ; ivar: CMessageMgr.m_oMessagePatternMgr offset=80
104df0f88: f8686a80    	ldr	x0, [x20, x8]
104df0f8c: d00ce248    	adrp	x8, 0x11ea3a000 <dyld_stub_binder+0x11ea3a000>
104df0f90: f946a501    	ldr	x1, [x8, #0xd48] ; selector: SetMsgPattern:MsgWrap:
104df0f94: aa1503e2    	mov	x2, x21
104df0f98: aa1303e3    	mov	x3, x19
104df0f9c: 94b8db32    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0fa0: d00cf917    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df0fa4: f94776e0    	ldr	x0, [x23, #0xee8]
104df0fa8: f00ce988    	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104df0fac: f947e901    	ldr	x1, [x8, #0xfd0] ; selector: needParserAddress
104df0fb0: 94b8db2d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0fb4: 340023c0    	cbz	w0, 0x104df142c <_Flutter_MMFoundation_BindContext+0x10780f8>
104df0fb8: d00cdee8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104df0fbc: f9423101    	ldr	x1, [x8, #0x460] ; selector: m_nsContent
104df0fc0: aa1303e0    	mov	x0, x19
104df0fc4: 94b8db28    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0fc8: aa1d03fd    	mov	x29, x29
104df0fcc: 94b8db2d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df0fd0: aa0003f6    	mov	x22, x0
104df0fd4: f94776f7    	ldr	x23, [x23, #0xee8]
104df0fd8: 900cf5c8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
104df0fdc: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
104df0fe0: 94b8db21    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df0fe4: aa0003e4    	mov	x4, x0
104df0fe8: b00cdee8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
104df0fec: f940d101    	ldr	x1, [x8, #0x1a0] ; selector: RangeOfObjectInString:withRange:
104df0ff0: aa1703e0    	mov	x0, x23
104df0ff4: aa1603e2    	mov	x2, x22
104df0ff8: d2800003    	mov	x3, #0x0                ; =0
104df0ffc: 94b8db1a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1000: b4002121    	cbz	x1, 0x104df1424 <_Flutter_MMFoundation_BindContext+0x10780f0>
104df1004: 900c0e81    	adrp	x1, 0x11cfc1000 <dyld_stub_binder+0x11cfc1000>
104df1008: 9102e021    	add	x1, x1, #0xb8 ; CFString: 7
104df100c: 52864120    	mov	w0, #0x3209             ; =12809
104df1010: 52800002    	mov	w2, #0x0                ; =0
104df1014: 52800003    	mov	w3, #0x0                ; =0
104df1018: 9758a42d    	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
104df101c: 14000102    	b	0x104df1424 <_Flutter_MMFoundation_BindContext+0x10780f0>
104df1020: aa1303e0    	mov	x0, x19
104df1024: aa1703e1    	mov	x1, x23
104df1028: 94b8db0f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df102c: 7100c41f    	cmp	w0, #0x31
104df1030: 54000721    	b.ne	0x104df1114 <_Flutter_MMFoundation_BindContext+0x1077de0>
104df1034: b00cdee8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
104df1038: f941fd01    	ldr	x1, [x8, #0x3f8] ; selector: m_uiAppMsgInnerType
104df103c: aa1303e0    	mov	x0, x19
104df1040: 94b8db09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1044: 7100a01f    	cmp	w0, #0x28
104df1048: 54000661    	b.ne	0x104df1114 <_Flutter_MMFoundation_BindContext+0x1077de0>
104df104c: 900cfea8    	adrp	x8, 0x11edc5000 <dyld_stub_binder+0x11edc5000>
104df1050: b986f108    	ldrsw	x8, [x8, #0x6f0] ; ivar: CMessageMgr.m_oOpenDownloadMgr offset=72
104df1054: f8686a97    	ldr	x23, [x20, x8]
104df1058: aa1303e0    	mov	x0, x19
104df105c: aa1603e1    	mov	x1, x22
104df1060: 94b8db01    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1064: aa1d03fd    	mov	x29, x29
104df1068: 94b8db06    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df106c: aa0003f6    	mov	x22, x0
104df1070: b00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df1074: f9431d18    	ldr	x24, [x8, #0x638]
104df1078: f00cdec8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104df107c: f947e901    	ldr	x1, [x8, #0xfd0] ; selector: m_n64MesSvrID
104df1080: aa1303e0    	mov	x0, x19
104df1084: 94b8daf8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1088: 900cf5e8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
104df108c: f942e501    	ldr	x1, [x8, #0x5c8] ; selector: stringWithFormat:
104df1090: f90003e0    	str	x0, [sp]
104df1094: d00c0da2    	adrp	x2, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
104df1098: 912f6042    	add	x2, x2, #0xbd8 ; CFString: %llu
104df109c: aa1803e0    	mov	x0, x24
104df10a0: 94b8daf1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df10a4: aa1d03fd    	mov	x29, x29
104df10a8: 94b8daf6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df10ac: aa0003f8    	mov	x24, x0
104df10b0: d00cdee8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
104df10b4: f9409d01    	ldr	x1, [x8, #0x138] ; selector: m_fullXmlLength
104df10b8: aa1303e0    	mov	x0, x19
104df10bc: 94b8daea    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df10c0: 2a0003e5    	mov	w5, w0
104df10c4: f00ce988    	adrp	x8, 0x11eb24000 <dyld_stub_binder+0x11eb24000>
104df10c8: f941d901    	ldr	x1, [x8, #0x3b0] ; selector: StartDownload:MsgWrap:AttachId:AttachDataSize:AttachFileExt:
104df10cc: d00c0da6    	adrp	x6, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
104df10d0: 912fe0c6    	add	x6, x6, #0xbf8 ; CFString: xml
104df10d4: aa1703e0    	mov	x0, x23
104df10d8: aa1603e2    	mov	x2, x22
104df10dc: aa1303e3    	mov	x3, x19
104df10e0: aa1803e4    	mov	x4, x24
104df10e4: 94b8dae0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df10e8: aa1803e0    	mov	x0, x24
104df10ec: 94b8dae1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df10f0: aa1603e0    	mov	x0, x22
104df10f4: 94b8dadf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df10f8: 52803420    	mov	w0, #0x1a1              ; =417
104df10fc: 52800a01    	mov	w1, #0x50               ; =80
104df1100: 52800022    	mov	w2, #0x1                ; =1
104df1104: 52800003    	mov	w3, #0x0                ; =0
104df1108: 52800004    	mov	w4, #0x0                ; =0
104df110c: 974be440    	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
104df1110: 140000c7    	b	0x104df142c <_Flutter_MMFoundation_BindContext+0x10780f8>
104df1114: f00cdee8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
104df1118: f9412901    	ldr	x1, [x8, #0x250] ; selector: GetDownloadThumbStatus:
104df111c: aa1403e0    	mov	x0, x20
104df1120: aa1303e2    	mov	x2, x19
104df1124: 94b8dad0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1128: 71000c1f    	cmp	w0, #0x3
104df112c: 54000121    	b.ne	0x104df1150 <_Flutter_MMFoundation_BindContext+0x1077e1c>
104df1130: 900cfea8    	adrp	x8, 0x11edc5000 <dyld_stub_binder+0x11edc5000>
104df1134: b9870908    	ldrsw	x8, [x8, #0x708] ; ivar: CMessageMgr.m_oThumbDownloadMgr offset=128
104df1138: f8686a80    	ldr	x0, [x20, x8]
104df113c: b00ce148    	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
104df1140: f941f901    	ldr	x1, [x8, #0x3f0] ; selector: StartDownloadThumb:isPrior:
104df1144: aa1303e2    	mov	x2, x19
104df1148: 52800003    	mov	w3, #0x0                ; =0
104df114c: 94b8dac6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1150: b00cdf48    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
104df1154: f9470901    	ldr	x1, [x8, #0xe10] ; selector: IsImgMsg
104df1158: aa1303e0    	mov	x0, x19
104df115c: 94b8dac2    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1160: 34000580    	cbz	w0, 0x104df1210 <_Flutter_MMFoundation_BindContext+0x1077edc>
104df1164: d00ce008    	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
104df1168: f9400901    	ldr	x1, [x8, #0x10] ; selector: m_uiHDImgSize
104df116c: aa1303e0    	mov	x0, x19
104df1170: 94b8dabd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1174: 2a0003f7    	mov	w23, w0
104df1178: d00ce008    	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
104df117c: f9401d16    	ldr	x22, [x8, #0x38] ; selector: m_uiHevcNormalImgSize
104df1180: aa1303e0    	mov	x0, x19
104df1184: aa1603e1    	mov	x1, x22
104df1188: 94b8dab7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df118c: d00ce008    	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
104df1190: f9401108    	ldr	x8, [x8, #0x20] ; selector: m_uiNormalImgSize
104df1194: 7100001f    	cmp	w0, #0x0
104df1198: 9a960101    	csel	x1, x8, x22, eq
104df119c: aa1303e0    	mov	x0, x19
104df11a0: 94b8dab1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df11a4: aa0003f6    	mov	x22, x0
104df11a8: b00ce008    	adrp	x8, 0x11e9f2000 <dyld_stub_binder+0x11e9f2000>
104df11ac: f947fd01    	ldr	x1, [x8, #0xff8] ; selector: IsHDImg
104df11b0: aa1303e0    	mov	x0, x19
104df11b4: 94b8daac    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df11b8: 7100001f    	cmp	w0, #0x0
104df11bc: 52800028    	mov	w8, #0x1                ; =1
104df11c0: 1a881519    	cinc	w25, w8, eq
104df11c4: 1400002a    	b	0x104df126c <_Flutter_MMFoundation_BindContext+0x1077f38>
104df11c8: f00ce988    	adrp	x8, 0x11eb24000 <dyld_stub_binder+0x11eb24000>
104df11cc: f941d501    	ldr	x1, [x8, #0x3a8] ; selector: isChatStatusNotifyOpenForMsgWrap:
104df11d0: aa1403e0    	mov	x0, x20
104df11d4: aa1303e2    	mov	x2, x19
104df11d8: 94b8daa3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df11dc: aa0003f8    	mov	x24, x0
104df11e0: aa1703e0    	mov	x0, x23
104df11e4: 94b8daa3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df11e8: aa1603e0    	mov	x0, x22
104df11ec: 94b8daa1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df11f0: 340011f8    	cbz	w24, 0x104df142c <_Flutter_MMFoundation_BindContext+0x10780f8>
104df11f4: d00ce1e8    	adrp	x8, 0x11ea2f000 <dyld_stub_binder+0x11ea2f000>
104df11f8: f941d501    	ldr	x1, [x8, #0x3a8] ; selector: StartDownloadEmoticonMsgWrap:HighPriority:
104df11fc: aa1403e0    	mov	x0, x20
104df1200: aa1303e2    	mov	x2, x19
104df1204: 52800003    	mov	w3, #0x0                ; =0
104df1208: 94b8da97    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df120c: 14000088    	b	0x104df142c <_Flutter_MMFoundation_BindContext+0x10780f8>
104df1210: f00cdf88    	adrp	x8, 0x11e9e4000 <dyld_stub_binder+0x11e9e4000>
104df1214: f941ad01    	ldr	x1, [x8, #0x358] ; selector: IsVideoMsg
104df1218: aa1303e0    	mov	x0, x19
104df121c: 94b8da92    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1220: 34001060    	cbz	w0, 0x104df142c <_Flutter_MMFoundation_BindContext+0x10780f8>
104df1224: d00cdf68    	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
104df1228: f944e501    	ldr	x1, [x8, #0x9c8] ; selector: m_uiRawFileLength
104df122c: aa1303e0    	mov	x0, x19
104df1230: 94b8da8d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1234: aa0003f7    	mov	x23, x0
104df1238: d00cdf68    	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
104df123c: f944d501    	ldr	x1, [x8, #0x9a8] ; selector: m_uiVideoLen
104df1240: aa1303e0    	mov	x0, x19
104df1244: 94b8da88    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1248: aa0003f6    	mov	x22, x0
104df124c: 900cdf88    	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
104df1250: f9410501    	ldr	x1, [x8, #0x208] ; selector: isRawVideo
104df1254: aa1303e0    	mov	x0, x19
104df1258: 94b8da83    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df125c: 7100001f    	cmp	w0, #0x0
104df1260: 52800088    	mov	w8, #0x4                ; =4
104df1264: 528001c9    	mov	w9, #0xe                ; =14
104df1268: 1a881139    	csel	w25, w9, w8, ne
104df126c: 2a1603fa    	mov	w26, w22
104df1270: b00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df1274: f943c100    	ldr	x0, [x8, #0x780]
104df1278: 900cdec8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104df127c: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
104df1280: 94b8da79    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1284: aa1d03fd    	mov	x29, x29
104df1288: 94b8da7e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df128c: aa0003f6    	mov	x22, x0
104df1290: b00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df1294: f9460900    	ldr	x0, [x8, #0xc10]
104df1298: b00cf5a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104df129c: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
104df12a0: 94b8da71    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df12a4: aa0003e2    	mov	x2, x0
104df12a8: 900cdec8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104df12ac: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
104df12b0: aa1603e0    	mov	x0, x22
104df12b4: 94b8da6c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df12b8: aa1d03fd    	mov	x29, x29
104df12bc: 94b8da71    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df12c0: aa0003f8    	mov	x24, x0
104df12c4: b00c2688    	adrp	x8, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104df12c8: 913be108    	add	x8, x8, #0xef8 ; CFString: img_video_src_type
104df12cc: f90007e8    	str	x8, [sp, #0x8]
104df12d0: b00cf91c    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df12d4: f9436380    	ldr	x0, [x28, #0x6c0]
104df12d8: 900cf5c8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
104df12dc: f942d501    	ldr	x1, [x8, #0x5a8] ; selector: numberWithInt:
104df12e0: aa1903e2    	mov	x2, x25
104df12e4: 94b8da60    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df12e8: aa1d03fd    	mov	x29, x29
104df12ec: 94b8da65    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df12f0: aa0003f9    	mov	x25, x0
104df12f4: f90017e0    	str	x0, [sp, #0x28]
104df12f8: b00c2688    	adrp	x8, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104df12fc: 913c6108    	add	x8, x8, #0xf18 ; CFString: media_source_size_byte
104df1300: f9000be8    	str	x8, [sp, #0x10]
104df1304: f9436380    	ldr	x0, [x28, #0x6c0]
104df1308: 900cf5c8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
104df130c: f942f91b    	ldr	x27, [x8, #0x5f0] ; selector: numberWithUnsignedLongLong:
104df1310: aa1b03e1    	mov	x1, x27
104df1314: aa1703e2    	mov	x2, x23
104df1318: 94b8da53    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df131c: aa1d03fd    	mov	x29, x29
104df1320: 94b8da58    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df1324: aa0003f7    	mov	x23, x0
104df1328: f9001be0    	str	x0, [sp, #0x30]
104df132c: b00c2688    	adrp	x8, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104df1330: 913ce108    	add	x8, x8, #0xf38 ; CFString: media_compressed_size_byte
104df1334: f9000fe8    	str	x8, [sp, #0x18]
104df1338: f9436380    	ldr	x0, [x28, #0x6c0]
104df133c: aa1b03e1    	mov	x1, x27
104df1340: aa1a03e2    	mov	x2, x26
104df1344: 94b8da48    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1348: aa1d03fd    	mov	x29, x29
104df134c: 94b8da4d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df1350: aa0003fa    	mov	x26, x0
104df1354: b00c2688    	adrp	x8, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104df1358: 913d6108    	add	x8, x8, #0xf58 ; CFString: recv_msg_svr_id
104df135c: f9001fe0    	str	x0, [sp, #0x38]
104df1360: f90013e8    	str	x8, [sp, #0x20]
104df1364: b00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df1368: f9431d1b    	ldr	x27, [x8, #0x638]
104df136c: f00cdec8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104df1370: f947e901    	ldr	x1, [x8, #0xfd0] ; selector: m_n64MesSvrID
104df1374: aa1303e0    	mov	x0, x19
104df1378: 94b8da3b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df137c: 900cf5e8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
104df1380: f942e501    	ldr	x1, [x8, #0x5c8] ; selector: stringWithFormat:
104df1384: f90003e0    	str	x0, [sp]
104df1388: d00c0d62    	adrp	x2, 0x11cf9f000 <dyld_stub_binder+0x11cf9f000>
104df138c: 91096042    	add	x2, x2, #0x258 ; CFString: %lld
104df1390: aa1b03e0    	mov	x0, x27
104df1394: 94b8da34    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1398: aa1d03fd    	mov	x29, x29
104df139c: 94b8da39    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df13a0: aa0003fb    	mov	x27, x0
104df13a4: f90023e0    	str	x0, [sp, #0x40]
104df13a8: b00cf908    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104df13ac: f9434d00    	ldr	x0, [x8, #0x698]
104df13b0: b00cf5a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104df13b4: f947e101    	ldr	x1, [x8, #0xfc0] ; selector: dictionaryWithObjects:forKeys:count:
104df13b8: 9100a3e2    	add	x2, sp, #0x28
104df13bc: 910023e3    	add	x3, sp, #0x8
104df13c0: 52800084    	mov	w4, #0x4                ; =4
104df13c4: 94b8da28    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df13c8: aa1d03fd    	mov	x29, x29
104df13cc: 94b8da2d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104df13d0: aa0003fc    	mov	x28, x0
104df13d4: f00cdec8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
104df13d8: f9428d01    	ldr	x1, [x8, #0x518] ; selector: reportCustomEvent:params:routeRule:
104df13dc: b00c2682    	adrp	x2, 0x11d2c2000 <dyld_stub_binder+0x11d2c2000>
104df13e0: 913b6042    	add	x2, x2, #0xed8 ; CFString: media_receive
104df13e4: aa1803e0    	mov	x0, x24
104df13e8: aa1c03e3    	mov	x3, x28
104df13ec: 52908724    	mov	w4, #0x8439             ; =33849
104df13f0: 94b8da1d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df13f4: aa1c03e0    	mov	x0, x28
104df13f8: 94b8da1e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df13fc: aa1b03e0    	mov	x0, x27
104df1400: 94b8da1c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df1404: aa1a03e0    	mov	x0, x26
104df1408: 94b8da1a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df140c: aa1703e0    	mov	x0, x23
104df1410: 94b8da18    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df1414: aa1903e0    	mov	x0, x25
104df1418: 94b8da16    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df141c: aa1803e0    	mov	x0, x24
104df1420: 94b8da14    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df1424: aa1603e0    	mov	x0, x22
104df1428: 94b8da12    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df142c: d00ce988    	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104df1430: f947f101    	ldr	x1, [x8, #0xfe0] ; selector: AsyncOnPreAddMsg:MsgWrap:
104df1434: aa1403e0    	mov	x0, x20
104df1438: aa1503e2    	mov	x2, x21
104df143c: aa1303e3    	mov	x3, x19
104df1440: 94b8da09    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df1444: d00ce988    	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104df1448: f947f501    	ldr	x1, [x8, #0xfe8] ; selector: AsyncOnAddMsg:MsgWrap:
104df144c: aa1403e0    	mov	x0, x20
104df1450: aa1503e2    	mov	x2, x21
104df1454: aa1303e3    	mov	x3, x19
104df1458: 94b8da03    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104df145c: aa1503e0    	mov	x0, x21
104df1460: 94b8da04    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df1464: aa1303e0    	mov	x0, x19
104df1468: 94b8da02    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104df146c: f94027e8    	ldr	x8, [sp, #0x48]
104df1470: f00c4ac9    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
104df1474: f9451929    	ldr	x9, [x9, #0xa30]
104df1478: f9400129    	ldr	x9, [x9]
104df147c: eb08013f    	cmp	x9, x8
104df1480: 54000121    	b.ne	0x104df14a4 <_Flutter_MMFoundation_BindContext+0x1078170>
104df1484: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
104df1488: a9494ff4    	ldp	x20, x19, [sp, #0x90]
104df148c: a94857f6    	ldp	x22, x21, [sp, #0x80]
104df1490: a9475ff8    	ldp	x24, x23, [sp, #0x70]
104df1494: a94667fa    	ldp	x26, x25, [sp, #0x60]
104df1498: a9456ffc    	ldp	x28, x27, [sp, #0x50]
104df149c: 9102c3ff    	add	sp, sp, #0xb0
104df14a0: d65f03c0    	ret
104df14a4: 94b8d8a3    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
