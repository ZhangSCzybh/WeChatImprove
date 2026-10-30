
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105183d7c: d10483ff    	sub	sp, sp, #0x120
105183d80: a90c6ffc    	stp	x28, x27, [sp, #0xc0]
105183d84: a90d67fa    	stp	x26, x25, [sp, #0xd0]
105183d88: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
105183d8c: a90f57f6    	stp	x22, x21, [sp, #0xf0]
105183d90: a9104ff4    	stp	x20, x19, [sp, #0x100]
105183d94: a9117bfd    	stp	x29, x30, [sp, #0x110]
105183d98: 910443fd    	add	x29, sp, #0x110
105183d9c: aa0403fc    	mov	x28, x4
105183da0: aa0303fa    	mov	x26, x3
105183da4: aa0203f3    	mov	x19, x2
105183da8: aa0003f7    	mov	x23, x0
105183dac: 900c2368    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105183db0: f9405908    	ldr	x8, [x8, #0xb0] ; bind ___stack_chk_guard
105183db4: f9400108    	ldr	x8, [x8]
105183db8: f81a03a8    	stur	x8, [x29, #-0x60]
105183dbc: 900dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105183dc0: 52800029    	mov	w9, #0x1                ; =1
105183dc4: 39338909    	strb	w9, [x8, #0xce2]
105183dc8: aa0203e0    	mov	x0, x2
105183dcc: 94aa8cdb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105183dd0: 721f035f    	tst	w26, #0x2
105183dd4: 1a9f17f9    	cset	w25, eq
105183dd8: 900d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105183ddc: f9468d00    	ldr	x0, [x8, #0xd18] ; class DeviceInfo
105183de0: 900d7c08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105183de4: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector/string isiPad
105183de8: 94aa8cd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183dec: aa0003f5    	mov	x21, x0
105183df0: 900d7f9b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
105183df4: f9471360    	ldr	x0, [x27, #0xe20] ; class SettingUtil
105183df8: f00d65a8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105183dfc: f946f114    	ldr	x20, [x8, #0xde0] ; selector/string getMainSetting
105183e00: aa1403e1    	mov	x1, x20
105183e04: 94aa8cce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183e08: aa1d03fd    	mov	x29, x29
105183e0c: 94aa8ccf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183e10: aa0003f6    	mov	x22, x0
105183e14: b00d65c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105183e18: f942d501    	ldr	x1, [x8, #0x5a8] ; selector/string m_uiExtStatus
105183e1c: 94aa8cc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183e20: aa0003f8    	mov	x24, x0
105183e24: aa1603e0    	mov	x0, x22
105183e28: 94aa8ccb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183e2c: 710002bf    	cmp	w21, #0x0
105183e30: 52800808    	mov	w8, #0x40               ; =64
105183e34: 52801009    	mov	w9, #0x80               ; =128
105183e38: 9a881128    	csel	x8, x9, x8, ne
105183e3c: ea08031f    	tst	x24, x8
105183e40: 1a9913f8    	csel	w24, wzr, w25, ne
105183e44: d00d6988    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
105183e48: f9441115    	ldr	x21, [x8, #0x820] ; selector/string keyBuf
105183e4c: aa1303e0    	mov	x0, x19
105183e50: aa1503e1    	mov	x1, x21
105183e54: 94aa8cba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183e58: aa1d03fd    	mov	x29, x29
105183e5c: 94aa8cbb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183e60: aa0003f6    	mov	x22, x0
105183e64: 900d6608    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105183e68: f946f901    	ldr	x1, [x8, #0xdf0] ; selector/string iLen
105183e6c: 94aa8cb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183e70: 340009e0    	cbz	w0, 0x105183fac <_Flutter_MMFoundation_BindContext+0x165fb90>
105183e74: b9002ff8    	str	w24, [sp, #0x2c]
105183e78: f90013fc    	str	x28, [sp, #0x20]
105183e7c: aa1303e0    	mov	x0, x19
105183e80: aa1503e1    	mov	x1, x21
105183e84: 94aa8cae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183e88: aa1d03fd    	mov	x29, x29
105183e8c: 94aa8caf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183e90: aa0003fc    	mov	x28, x0
105183e94: d00d65c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105183e98: f941a918    	ldr	x24, [x8, #0x350] ; selector/string buffer
105183e9c: aa1803e1    	mov	x1, x24
105183ea0: 94aa8ca7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183ea4: aa1d03fd    	mov	x29, x29
105183ea8: 94aa8ca8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183eac: aa0003f9    	mov	x25, x0
105183eb0: 94aa8ca9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183eb4: aa1c03e0    	mov	x0, x28
105183eb8: 94aa8ca7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183ebc: aa1603e0    	mov	x0, x22
105183ec0: 94aa8ca5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183ec4: b4000799    	cbz	x25, 0x105183fb4 <_Flutter_MMFoundation_BindContext+0x165fb98>
105183ec8: aa1303e0    	mov	x0, x19
105183ecc: aa1503e1    	mov	x1, x21
105183ed0: 94aa8c9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183ed4: aa1d03fd    	mov	x29, x29
105183ed8: 94aa8c9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183edc: aa0003f5    	mov	x21, x0
105183ee0: aa1803e1    	mov	x1, x24
105183ee4: 94aa8c96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183ee8: aa1d03fd    	mov	x29, x29
105183eec: 94aa8c97    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183ef0: aa0003f9    	mov	x25, x0
105183ef4: aa1503e0    	mov	x0, x21
105183ef8: 94aa8c97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183efc: b00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105183f00: b9893d08    	ldrsw	x8, [x8, #0x93c] ; ivar NewSyncService.m_oLock offset=56 type=@"NSRecursiveLock"
105183f04: f8686ae1    	ldr	x1, [x23, x8]
105183f08: d101e3a0    	sub	x0, x29, #0x78
105183f0c: 94aa2509    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
105183f10: f9471360    	ldr	x0, [x27, #0xe20] ; class SettingUtil
105183f14: aa1403e1    	mov	x1, x20
105183f18: 94aa8c89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183f1c: aa1d03fd    	mov	x29, x29
105183f20: 94aa8c8a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183f24: aa0003f4    	mov	x20, x0
105183f28: b4000800    	cbz	x0, 0x105184028 <_Flutter_MMFoundation_BindContext+0x165fc0c>
105183f2c: 900d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105183f30: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
105183f34: b00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105183f38: f944e901    	ldr	x1, [x8, #0x9d0] ; selector/string currentContext
105183f3c: 94aa8c80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183f40: aa1d03fd    	mov	x29, x29
105183f44: 94aa8c81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183f48: aa0003f6    	mov	x22, x0
105183f4c: d00d7f88    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105183f50: f9414d00    	ldr	x0, [x8, #0x298] ; class AccountStorageMgr
105183f54: 900d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105183f58: f947ad01    	ldr	x1, [x8, #0xf58] ; selector/string class
105183f5c: 94aa8c78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183f60: aa0003e2    	mov	x2, x0
105183f64: d00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105183f68: f9464101    	ldr	x1, [x8, #0xc80] ; selector/string getService:
105183f6c: aa1603e0    	mov	x0, x22
105183f70: 94aa8c73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183f74: aa1d03fd    	mov	x29, x29
105183f78: 94aa8c74    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183f7c: aa0003f8    	mov	x24, x0
105183f80: d00d6808    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
105183f84: f9428501    	ldr	x1, [x8, #0x508] ; selector/string GetSyncBuffer
105183f88: 94aa8c6d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183f8c: aa1d03fd    	mov	x29, x29
105183f90: 94aa8c6e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105183f94: aa0003f5    	mov	x21, x0
105183f98: aa1803e0    	mov	x0, x24
105183f9c: 94aa8c6e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183fa0: aa1603e0    	mov	x0, x22
105183fa4: 94aa8c6c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183fa8: 14000021    	b	0x10518402c <_Flutter_MMFoundation_BindContext+0x165fc10>
105183fac: aa1603e0    	mov	x0, x22
105183fb0: 94aa8c69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105183fb4: 900d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105183fb8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
105183fbc: d00d65a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105183fc0: f942a901    	ldr	x1, [x8, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
105183fc4: b00cb2a8    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
105183fc8: 910aa108    	add	x8, x8, #0x2a8 ; CFString 'oNewSyncResp.tKeyBuf error'
105183fcc: f90003e8    	str	x8, [sp]
105183fd0: f00b36c5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105183fd4: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105183fd8: 900b36e7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
105183fdc: 91091ce7    	add	x7, x7, #0x247 ; string '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
105183fe0: 52800082    	mov	w2, #0x4                ; =4
105183fe4: d2800003    	mov	x3, #0x0                ; =0
105183fe8: 52800004    	mov	w4, #0x0                ; =0
105183fec: 52805b26    	mov	w6, #0x2d9              ; =729
105183ff0: 94aa8c53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105183ff4: 52801200    	mov	w0, #0x90               ; =144
105183ff8: 52800181    	mov	w1, #0xc                ; =12
105183ffc: 52800022    	mov	w2, #0x1                ; =1
105184000: 52800003    	mov	w3, #0x0                ; =0
105184004: 52800004    	mov	w4, #0x0                ; =0
105184008: 9737305d    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10518400c: 900cb2a1    	adrp	x1, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
105184010: 910b2021    	add	x1, x1, #0x2c8 ; CFString '12,0'
105184014: 52915720    	mov	w0, #0x8ab9             ; =35513
105184018: 52800002    	mov	w2, #0x0                ; =0
10518401c: 52800003    	mov	w3, #0x0                ; =0
105184020: 9743a330    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
105184024: 140000a4    	b	0x1051842b4 <_Flutter_MMFoundation_BindContext+0x165fe98>
105184028: d2800015    	mov	x21, #0x0               ; =0
10518402c: aa1403e0    	mov	x0, x20
105184030: 94aa8c49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184034: d101e3a0    	sub	x0, x29, #0x78
105184038: 94aa24bf    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
10518403c: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105184040: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
105184044: b00d65c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105184048: f945cd01    	ldr	x1, [x8, #0xb98] ; selector/string MergeSyncBuffer:NewBuffer:
10518404c: a90367f5    	stp	x21, x25, [sp, #0x30]
105184050: aa1503e2    	mov	x2, x21
105184054: aa1903e3    	mov	x3, x25
105184058: 94aa8c39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518405c: aa1d03fd    	mov	x29, x29
105184060: 94aa8c3a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105184064: aa0003f6    	mov	x22, x0
105184068: a938ffbf    	stp	xzr, xzr, [x29, #-0x78]
10518406c: f81983bf    	stur	xzr, [x29, #-0x68]
105184070: 94aa8c4e    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
105184074: f00d7bc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105184078: f9447501    	ldr	x1, [x8, #0x8e8] ; selector/string bytes
10518407c: 94aa8c30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184080: aa0003f4    	mov	x20, x0
105184084: f00d7be8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105184088: f946e91c    	ldr	x28, [x8, #0xdd0] ; selector/string length
10518408c: aa1603e0    	mov	x0, x22
105184090: aa1c03e1    	mov	x1, x28
105184094: 94aa8c2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184098: aa0003e2    	mov	x2, x0
10518409c: d101e3a0    	sub	x0, x29, #0x78
1051840a0: aa1403e1    	mov	x1, x20
1051840a4: 94aa24b0    	bl	0x107c0d364 <_Flutter_MMFoundation_BindContext+0x40e8f48>
1051840a8: 900d7fe8    	adrp	x8, 0x120180000 <dyld_stub_binder+0x120180000>
1051840ac: f942b500    	ldr	x0, [x8, #0x568] ; class SyncKey
1051840b0: b00d65c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1051840b4: f9435101    	ldr	x1, [x8, #0x6a0] ; selector/string parseFromData:
1051840b8: aa1603e2    	mov	x2, x22
1051840bc: 94aa8c20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051840c0: aa1d03fd    	mov	x29, x29
1051840c4: 94aa8c21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051840c8: aa0003f8    	mov	x24, x0
1051840cc: f100001f    	cmp	x0, #0x0
1051840d0: 1a9f07fb    	cset	w27, ne
1051840d4: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051840d8: f9453519    	ldr	x25, [x8, #0xa68] ; class iConsole
1051840dc: aa1603e0    	mov	x0, x22
1051840e0: aa1c03e1    	mov	x1, x28
1051840e4: 94aa8c16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051840e8: aa0003f5    	mov	x21, x0
1051840ec: 9101c3f4    	add	x20, sp, #0x70
1051840f0: 9101c3e8    	add	x8, sp, #0x70
1051840f4: d101e3a0    	sub	x0, x29, #0x78
1051840f8: 94aa2499    	bl	0x107c0d35c <_Flutter_MMFoundation_BindContext+0x40e8f40>
1051840fc: 39c21fe8    	ldrsb	w8, [sp, #0x87]
105184100: f9403be9    	ldr	x9, [sp, #0x70]
105184104: 7100011f    	cmp	w8, #0x0
105184108: 9a94b128    	csel	x8, x9, x20, lt
10518410c: b00d65a9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105184110: f942a934    	ldr	x20, [x9, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
105184114: a90123fb    	stp	x27, x8, [sp, #0x10]
105184118: 900cb2a8    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
10518411c: 910ba108    	add	x8, x8, #0x2e8 ; CFString 'new sync push merge len %lu ret %d md5 %s'
105184120: a90057e8    	stp	x8, x21, [sp]
105184124: 900b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105184128: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
10518412c: d00b36c5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105184130: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105184134: f00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
105184138: 91091ce7    	add	x7, x7, #0x247 ; string '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
10518413c: aa1903e0    	mov	x0, x25
105184140: aa1403e1    	mov	x1, x20
105184144: 52800042    	mov	w2, #0x2                ; =2
105184148: 52800004    	mov	w4, #0x0                ; =0
10518414c: 52805de6    	mov	w6, #0x2ef              ; =751
105184150: 94aa8bfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184154: 39c21fe8    	ldrsb	w8, [sp, #0x87]
105184158: 36f800a8    	tbz	w8, #0x1f, 0x10518416c <_Flutter_MMFoundation_BindContext+0x165fd50>
10518415c: f9403be0    	ldr	x0, [sp, #0x70]
105184160: f94043e8    	ldr	x8, [sp, #0x80]
105184164: 9240f901    	and	x1, x8, #0x7fffffffffffffff
105184168: 94aa8c19    	bl	0x107c271cc <_Flutter_MMFoundation_BindContext+0x4102db0>
10518416c: 900d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105184170: b9894119    	ldrsw	x25, [x8, #0x940] ; ivar NewSyncService.m_bSyncOpError offset=74 type=B
105184174: 38796ae8    	ldrb	w8, [x23, x25]
105184178: 900d8529    	adrp	x9, 0x120228000 <dyld_stub_binder+0x120228000>
10518417c: b9891935    	ldrsw	x21, [x9, #0x918] ; ivar NewSyncService.m_bIsSyncPause offset=84 type=B
105184180: 38756ae9    	ldrb	w9, [x23, x21]
105184184: 900d852a    	adrp	x10, 0x120228000 <dyld_stub_binder+0x120228000>
105184188: 7100051f    	cmp	w8, #0x1
10518418c: 54000061    	b.ne	0x105184198 <_Flutter_MMFoundation_BindContext+0x165fd7c>
105184190: b949515b    	ldr	w27, [x10, #0x950] ; ivar NewSyncService.m_bSyncOperating offset=75 type=B
105184194: 14000006    	b	0x1051841ac <_Flutter_MMFoundation_BindContext+0x165fd90>
105184198: b949515b    	ldr	w27, [x10, #0x950] ; ivar NewSyncService.m_bSyncOperating offset=75 type=B
10518419c: 37000089    	tbnz	w9, #0x0, 0x1051841ac <_Flutter_MMFoundation_BindContext+0x165fd90>
1051841a0: 387bcaea    	ldrb	w10, [x23, w27, sxtw]
1051841a4: 7100055f    	cmp	w10, #0x1
1051841a8: 54000bc1    	b.ne	0x105184320 <_Flutter_MMFoundation_BindContext+0x165ff04>
1051841ac: f00d7f6a    	adrp	x10, 0x120173000 <dyld_stub_binder+0x120173000>
1051841b0: f9453540    	ldr	x0, [x10, #0xa68] ; class iConsole
1051841b4: 387bcaea    	ldrb	w10, [x23, w27, sxtw]
1051841b8: a9012be9    	stp	x9, x10, [sp, #0x10]
1051841bc: 900cb2a9    	adrp	x9, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
1051841c0: 910c2129    	add	x9, x9, #0x308 ; CFString 'push data ignore, syncOpError %d, syncPause %d operating %d'
1051841c4: a90023e9    	stp	x9, x8, [sp]
1051841c8: 900b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
1051841cc: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
1051841d0: d00b36c5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051841d4: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
1051841d8: f00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
1051841dc: 91091ce7    	add	x7, x7, #0x247 ; string '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
1051841e0: aa1403e1    	mov	x1, x20
1051841e4: 52800082    	mov	w2, #0x4                ; =4
1051841e8: 52800004    	mov	w4, #0x0                ; =0
1051841ec: 52805e66    	mov	w6, #0x2f3              ; =755
1051841f0: 94aa8bd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051841f4: 52801200    	mov	w0, #0x90               ; =144
1051841f8: 528000e1    	mov	w1, #0x7                ; =7
1051841fc: 52800022    	mov	w2, #0x1                ; =1
105184200: 52800003    	mov	w3, #0x0                ; =0
105184204: 52800004    	mov	w4, #0x0                ; =0
105184208: 97372fdd    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10518420c: 900cb2a1    	adrp	x1, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
105184210: 910ca021    	add	x1, x1, #0x328 ; CFString '7,0'
105184214: 52915720    	mov	w0, #0x8ab9             ; =35513
105184218: 52800002    	mov	w2, #0x0                ; =0
10518421c: 52800003    	mov	w3, #0x0                ; =0
105184220: 9743a2b0    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
105184224: 38796ae8    	ldrb	w8, [x23, x25]
105184228: 7100051f    	cmp	w8, #0x1
10518422c: 540001c1    	b.ne	0x105184264 <_Flutter_MMFoundation_BindContext+0x165fe48>
105184230: 52801200    	mov	w0, #0x90               ; =144
105184234: 528003c1    	mov	w1, #0x1e               ; =30
105184238: 52800022    	mov	w2, #0x1                ; =1
10518423c: 52800003    	mov	w3, #0x0                ; =0
105184240: 52800004    	mov	w4, #0x0                ; =0
105184244: 97372fce    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
105184248: 900cb2a1    	adrp	x1, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
10518424c: 910d2021    	add	x1, x1, #0x348 ; CFString '30,0'
105184250: 52915720    	mov	w0, #0x8ab9             ; =35513
105184254: 52800002    	mov	w2, #0x0                ; =0
105184258: 52800003    	mov	w3, #0x0                ; =0
10518425c: 9743a2a1    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
105184260: 1400000a    	b	0x105184288 <_Flutter_MMFoundation_BindContext+0x165fe6c>
105184264: 38756ae8    	ldrb	w8, [x23, x21]
105184268: 7100051f    	cmp	w8, #0x1
10518426c: 54000441    	b.ne	0x1051842f4 <_Flutter_MMFoundation_BindContext+0x165fed8>
105184270: 52801200    	mov	w0, #0x90               ; =144
105184274: 528003e1    	mov	w1, #0x1f               ; =31
105184278: 52800022    	mov	w2, #0x1                ; =1
10518427c: 52800003    	mov	w3, #0x0                ; =0
105184280: 52800004    	mov	w4, #0x0                ; =0
105184284: 97372fbe    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
105184288: f9401bfb    	ldr	x27, [sp, #0x30]
10518428c: aa1803e0    	mov	x0, x24
105184290: 94aa8bb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184294: d101e3a0    	sub	x0, x29, #0x78
105184298: 94aa2430    	bl	0x107c0d358 <_Flutter_MMFoundation_BindContext+0x40e8f3c>
10518429c: aa1603e0    	mov	x0, x22
1051842a0: 94aa8bad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051842a4: aa1b03e0    	mov	x0, x27
1051842a8: 94aa8bab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051842ac: f9401fe0    	ldr	x0, [sp, #0x38]
1051842b0: 94aa8ba9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051842b4: aa1303e0    	mov	x0, x19
1051842b8: 94aa8ba7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051842bc: f85a03a8    	ldur	x8, [x29, #-0x60]
1051842c0: f00c2349    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1051842c4: f9405929    	ldr	x9, [x9, #0xb0] ; bind ___stack_chk_guard
1051842c8: f9400129    	ldr	x9, [x9]
1051842cc: eb08013f    	cmp	x9, x8
1051842d0: 54001c81    	b.ne	0x105184660 <_Flutter_MMFoundation_BindContext+0x1660244>
1051842d4: a9517bfd    	ldp	x29, x30, [sp, #0x110]
1051842d8: a9504ff4    	ldp	x20, x19, [sp, #0x100]
1051842dc: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
1051842e0: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
1051842e4: a94d67fa    	ldp	x26, x25, [sp, #0xd0]
1051842e8: a94c6ffc    	ldp	x28, x27, [sp, #0xc0]
1051842ec: 910483ff    	add	sp, sp, #0x120
1051842f0: d65f03c0    	ret
1051842f4: 387bcae8    	ldrb	w8, [x23, w27, sxtw]
1051842f8: 7100051f    	cmp	w8, #0x1
1051842fc: f9401bfb    	ldr	x27, [sp, #0x30]
105184300: 54fffc61    	b.ne	0x10518428c <_Flutter_MMFoundation_BindContext+0x165fe70>
105184304: 52801200    	mov	w0, #0x90               ; =144
105184308: 52800421    	mov	w1, #0x21               ; =33
10518430c: 52800022    	mov	w2, #0x1                ; =1
105184310: 52800003    	mov	w3, #0x0                ; =0
105184314: 52800004    	mov	w4, #0x0                ; =0
105184318: 97372f99    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10518431c: 17ffffdc    	b	0x10518428c <_Flutter_MMFoundation_BindContext+0x165fe70>
105184320: 900d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105184324: b9892108    	ldrsw	x8, [x8, #0x920] ; ivar NewSyncService.m_lastSyncFinishCallingExtension offset=76 type=B
105184328: 38286aff    	strb	wzr, [x23, x8]
10518432c: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105184330: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
105184334: 900d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105184338: f944e901    	ldr	x1, [x8, #0x9d0] ; selector/string currentContext
10518433c: 94aa8b80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184340: aa1d03fd    	mov	x29, x29
105184344: 94aa8b81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105184348: aa0003f5    	mov	x21, x0
10518434c: 900d7f68    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
105184350: f9462502    	ldr	x2, [x8, #0xc48]
105184354: 900d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105184358: f9420903    	ldr	x3, [x8, #0x410] ; selector/string onNewSyncBegin
10518435c: d00d65a8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105184360: f940d501    	ldr	x1, [x8, #0x1a8] ; selector/string callExtensionOnMainThread:selector:sync:block:
105184364: d00c2745    	adrp	x5, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
105184368: 911b80a5    	add	x5, x5, #0x6e0
10518436c: 52800004    	mov	w4, #0x0                ; =0
105184370: 94aa8b73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184374: aa1503e0    	mov	x0, x21
105184378: 94aa8b77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518437c: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105184380: f9458d00    	ldr	x0, [x8, #0xb18] ; bind _OBJC_CLASS_$_NSNotificationCenter
105184384: 900d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105184388: f946b101    	ldr	x1, [x8, #0xd60] ; selector/string defaultCenter
10518438c: 94aa8b6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184390: aa1d03fd    	mov	x29, x29
105184394: 94aa8b6d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105184398: aa0003fb    	mov	x27, x0
10518439c: d00cb228    	adrp	x8, 0x11e7ca000 <dyld_stub_binder+0x11e7ca000>
1051843a0: 91162108    	add	x8, x8, #0x588 ; CFString 'isFromPush'
1051843a4: f90047e8    	str	x8, [sp, #0x88]
1051843a8: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051843ac: f9458900    	ldr	x0, [x8, #0xb10] ; bind _OBJC_CLASS_$_NSNumber
1051843b0: 900d7c08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1051843b4: f9479501    	ldr	x1, [x8, #0xf28] ; selector/string numberWithBool:
1051843b8: 52800022    	mov	w2, #0x1                ; =1
1051843bc: 94aa8b60    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051843c0: aa1d03fd    	mov	x29, x29
1051843c4: 94aa8b61    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051843c8: aa0003f9    	mov	x25, x0
1051843cc: f81803a0    	stur	x0, [x29, #-0x80]
1051843d0: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051843d4: f9457500    	ldr	x0, [x8, #0xae8] ; bind _OBJC_CLASS_$_NSDictionary
1051843d8: b00d7be8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1051843dc: f9402901    	ldr	x1, [x8, #0x50] ; selector/string dictionaryWithObjects:forKeys:count:
1051843e0: d10203a2    	sub	x2, x29, #0x80
1051843e4: 910223e3    	add	x3, sp, #0x88
1051843e8: 52800024    	mov	w4, #0x1                ; =1
1051843ec: 94aa8b54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051843f0: aa1d03fd    	mov	x29, x29
1051843f4: 94aa8b55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051843f8: aa0003f5    	mov	x21, x0
1051843fc: b00d7c08    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
105184400: f944d901    	ldr	x1, [x8, #0x9b0] ; selector/string postNotificationName:object:userInfo:
105184404: d00cb222    	adrp	x2, 0x11e7ca000 <dyld_stub_binder+0x11e7ca000>
105184408: 9103a042    	add	x2, x2, #0xe8 ; CFString 'NewSyncBeginNotifyEvent'
10518440c: aa1b03e0    	mov	x0, x27
105184410: d2800003    	mov	x3, #0x0                ; =0
105184414: aa1503e4    	mov	x4, x21
105184418: 94aa8b49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518441c: aa1503e0    	mov	x0, x21
105184420: 94aa8b4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184424: aa1903e0    	mov	x0, x25
105184428: 94aa8b4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518442c: aa1b03e0    	mov	x0, x27
105184430: 94aa8b49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184434: aa1303e0    	mov	x0, x19
105184438: 52800021    	mov	w1, #0x1                ; =1
10518443c: b9402fe2    	ldr	w2, [sp, #0x2c]
105184440: 97ffe43a    	bl	0x10517d528 <_Flutter_MMFoundation_BindContext+0x165910c>
105184444: aa0003f5    	mov	x21, x0
105184448: 900d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10518444c: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector/string HandleSyncResp:handleResult:
105184450: aa1703e0    	mov	x0, x23
105184454: aa1303e2    	mov	x2, x19
105184458: aa1503e3    	mov	x3, x21
10518445c: 94aa8b38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184460: f9401bfb    	ldr	x27, [sp, #0x30]
105184464: 36000dd5    	tbz	w21, #0x0, 0x10518461c <_Flutter_MMFoundation_BindContext+0x1660200>
105184468: 3607f13a    	tbz	w26, #0x0, 0x10518428c <_Flutter_MMFoundation_BindContext+0x165fe70>
10518446c: f00d7f79    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
105184470: f9453720    	ldr	x0, [x25, #0xa68] ; class iConsole
105184474: 900cb2a8    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
105184478: 910e2108    	add	x8, x8, #0x388 ; CFString 'send new sync push ack'
10518447c: f90003e8    	str	x8, [sp]
105184480: 900b0ef5    	adrp	x21, 0x11b360000 <dyld_stub_binder+0x11b360000>
105184484: 912702b5    	add	x21, x21, #0x9c0 ; string 'Sync'
105184488: d00b36d7    	adrp	x23, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10518448c: 912b02f7    	add	x23, x23, #0xac0 ; string 'NewSyncService.mm'
105184490: f00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
105184494: 91091ce7    	add	x7, x7, #0x247 ; string '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
105184498: aa1403e1    	mov	x1, x20
10518449c: 52800042    	mov	w2, #0x2                ; =2
1051844a0: aa1503e3    	mov	x3, x21
1051844a4: 52800004    	mov	w4, #0x0                ; =0
1051844a8: aa1703e5    	mov	x5, x23
1051844ac: 528062a6    	mov	w6, #0x315              ; =789
1051844b0: 94aa8b23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051844b4: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051844b8: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
1051844bc: d00d65a8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1051844c0: f940ad01    	ldr	x1, [x8, #0x158] ; selector/string genCurrentTimeInMs
1051844c4: 94aa8b1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051844c8: f94013e8    	ldr	x8, [sp, #0x20]
1051844cc: cb08001a    	sub	x26, x0, x8
1051844d0: f9453720    	ldr	x0, [x25, #0xa68] ; class iConsole
1051844d4: 900cb2a8    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
1051844d8: 910ea108    	add	x8, x8, #0x3a8 ; CFString 'send new sync push ack cost %u'
1051844dc: a9006be8    	stp	x8, x26, [sp]
1051844e0: aa1403e1    	mov	x1, x20
1051844e4: 52800042    	mov	w2, #0x2                ; =2
1051844e8: aa1503e3    	mov	x3, x21
1051844ec: 52800004    	mov	w4, #0x0                ; =0
1051844f0: aa1703e5    	mov	x5, x23
1051844f4: 52806346    	mov	w6, #0x31a              ; =794
1051844f8: f00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
1051844fc: 91091ce7    	add	x7, x7, #0x247 ; string '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
105184500: 94aa8b0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184504: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105184508: f946b100    	ldr	x0, [x8, #0xd60] ; bind _OBJC_CLASS_$_NSMutableData
10518450c: 900d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105184510: f9459501    	ldr	x1, [x8, #0xb28] ; selector/string data
105184514: 94aa8b0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184518: aa1d03fd    	mov	x29, x29
10518451c: 94aa8b0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105184520: aa0003f4    	mov	x20, x0
105184524: 5ac00b48    	rev	w8, w26
105184528: b90073e8    	str	w8, [sp, #0x70]
10518452c: f00d7bc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105184530: f9413515    	ldr	x21, [x8, #0x268] ; selector/string appendBytes:length:
105184534: 9101c3e2    	add	x2, sp, #0x70
105184538: aa1503e1    	mov	x1, x21
10518453c: 52800083    	mov	w3, #0x4                ; =4
105184540: 94aa8aff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184544: aa1603e0    	mov	x0, x22
105184548: aa1c03e1    	mov	x1, x28
10518454c: 94aa8afc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184550: 5ac00808    	rev	w8, w0
105184554: b9006fe8    	str	w8, [sp, #0x6c]
105184558: 9101b3e2    	add	x2, sp, #0x6c
10518455c: aa1403e0    	mov	x0, x20
105184560: aa1503e1    	mov	x1, x21
105184564: 52800083    	mov	w3, #0x4                ; =4
105184568: 94aa8af5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518456c: f00d7bc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105184570: f9414101    	ldr	x1, [x8, #0x280] ; selector/string appendData:
105184574: aa1403e0    	mov	x0, x20
105184578: aa1603e2    	mov	x2, x22
10518457c: 94aa8af0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105184580: d00d7fc8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
105184584: f9469100    	ldr	x0, [x8, #0xd20] ; class NetCmdSendOnlyEvent
105184588: 94aa8af4    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10518458c: aa0003f5    	mov	x21, x0
105184590: 52800200    	mov	w0, #0x10               ; =16
105184594: 94aa8afa    	bl	0x107c2717c <_Flutter_MMFoundation_BindContext+0x4102d60>
105184598: aa0003f7    	mov	x23, x0
10518459c: aa1403e1    	mov	x1, x20
1051845a0: 97fb1996    	bl	0x10504abf8 <_Flutter_MMFoundation_BindContext+0x15267dc>
1051845a4: 900d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
1051845a8: f942a901    	ldr	x1, [x8, #0x550] ; selector/string setM_netcmd:
1051845ac: aa1503e0    	mov	x0, x21
1051845b0: aa1703e2    	mov	x2, x23
1051845b4: 94aa8ae2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051845b8: d00c2348    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1051845bc: f947e108    	ldr	x8, [x8, #0xfc0] ; bind __NSConcreteStackBlock
1051845c0: f90023e8    	str	x8, [sp, #0x40]
1051845c4: b009dfe8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1051845c8: fd41c100    	ldr	d0, [x8, #0x380]
1051845cc: 90000008    	adrp	x8, 0x105184000 <_Flutter_MMFoundation_BindContext+0x165fbe4>
1051845d0: 9119d108    	add	x8, x8, #0x674
1051845d4: fd0027e0    	str	d0, [sp, #0x48]
1051845d8: d00c2389    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1051845dc: 9115c129    	add	x9, x9, #0x570
1051845e0: a90527e8    	stp	x8, x9, [sp, #0x50]
1051845e4: f90033f5    	str	x21, [sp, #0x60]
1051845e8: aa1503e0    	mov	x0, x21
1051845ec: 94aa8ad3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1051845f0: f00c2340    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1051845f4: f9408c00    	ldr	x0, [x0, #0x118] ; bind __dispatch_main_q
1051845f8: 910103e1    	add	x1, sp, #0x40
1051845fc: 94aa2309    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
105184600: f94033e0    	ldr	x0, [sp, #0x60]
105184604: 94aa8ad4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184608: aa1503e0    	mov	x0, x21
10518460c: 94aa8ad2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184610: aa1403e0    	mov	x0, x20
105184614: 94aa8ad0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105184618: 17ffff1d    	b	0x10518428c <_Flutter_MMFoundation_BindContext+0x165fe70>
10518461c: f00d7f68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105184620: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
105184624: 900cb2a8    	adrp	x8, 0x11e7d8000 <dyld_stub_binder+0x11e7d8000>
105184628: 910da108    	add	x8, x8, #0x368 ; CFString 'do not send ack'
10518462c: f90003e8    	str	x8, [sp]
105184630: 900b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105184634: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
105184638: d00b36c5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10518463c: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105184640: f00b36c7    	adrp	x7, 0x11b85f000 <dyld_stub_binder+0x11b85f000>
105184644: 91091ce7    	add	x7, x7, #0x247 ; string '-[NewSyncService __handleNewSyncResponse:flag:beginTime:]'
105184648: aa1403e1    	mov	x1, x20
10518464c: 52800042    	mov	w2, #0x2                ; =2
105184650: 52800004    	mov	w4, #0x0                ; =0
105184654: 528061e6    	mov	w6, #0x30f              ; =783
105184658: 94aa8ab9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518465c: 17ffff0c    	b	0x10518428c <_Flutter_MMFoundation_BindContext+0x165fe70>
105184660: 94aa8ac5    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
