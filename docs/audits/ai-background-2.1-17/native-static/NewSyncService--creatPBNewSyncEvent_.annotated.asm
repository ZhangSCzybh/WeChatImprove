
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105181b34: d10243ff    	sub	sp, sp, #0x90
105181b38: a9036ffc    	stp	x28, x27, [sp, #0x30]
105181b3c: a90467fa    	stp	x26, x25, [sp, #0x40]
105181b40: a9055ff8    	stp	x24, x23, [sp, #0x50]
105181b44: a90657f6    	stp	x22, x21, [sp, #0x60]
105181b48: a9074ff4    	stp	x20, x19, [sp, #0x70]
105181b4c: a9087bfd    	stp	x29, x30, [sp, #0x80]
105181b50: 910203fd    	add	x29, sp, #0x80
105181b54: aa0203f4    	mov	x20, x2
105181b58: f90017e0    	str	x0, [sp, #0x28]
105181b5c: d00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105181b60: 52800029    	mov	w9, #0x1                ; =1
105181b64: 39336d09    	strb	w9, [x8, #0xcdb]
105181b68: f00d8088    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
105181b6c: f9440d00    	ldr	x0, [x8, #0x818] ; class NewSyncRequest
105181b70: 94aa957a    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105181b74: aa0003f3    	mov	x19, x0
105181b78: 900d7c48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105181b7c: f9446501    	ldr	x1, [x8, #0x8c8] ; selector/string setSelector:
105181b80: 528000e2    	mov	w2, #0x7                ; =7
105181b84: 72a00082    	movk	w2, #0x4, lsl #16
105181b88: 94aa956d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181b8c: b00d8008    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
105181b90: f9461500    	ldr	x0, [x8, #0xc28] ; class CmdList
105181b94: 94aa9571    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105181b98: aa0003f6    	mov	x22, x0
105181b9c: b00d6a48    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
105181ba0: f9406101    	ldr	x1, [x8, #0xc0] ; selector/string setOplog:
105181ba4: aa1303e0    	mov	x0, x19
105181ba8: aa1603e2    	mov	x2, x22
105181bac: 94aa9564    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181bb0: aa1603e0    	mov	x0, x22
105181bb4: 94aa9568    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181bb8: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181bbc: f9455500    	ldr	x0, [x8, #0xaa8] ; bind _OBJC_CLASS_$_NSMutableArray
105181bc0: d00d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105181bc4: f941a101    	ldr	x1, [x8, #0x340] ; selector/string array
105181bc8: 94aa955d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181bcc: aa1d03fd    	mov	x29, x29
105181bd0: 94aa955e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181bd4: aa0003f6    	mov	x22, x0
105181bd8: f00d6828    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
105181bdc: f9442517    	ldr	x23, [x8, #0x848] ; selector/string oplog
105181be0: aa1303e0    	mov	x0, x19
105181be4: aa1703e1    	mov	x1, x23
105181be8: 94aa9555    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181bec: aa1d03fd    	mov	x29, x29
105181bf0: 94aa9556    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181bf4: aa0003f8    	mov	x24, x0
105181bf8: f00d6668    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
105181bfc: f9436901    	ldr	x1, [x8, #0x6d0] ; selector/string setList:
105181c00: aa1603e2    	mov	x2, x22
105181c04: 94aa954e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181c08: aa1803e0    	mov	x0, x24
105181c0c: 94aa9552    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181c10: aa1603e0    	mov	x0, x22
105181c14: 94aa9550    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181c18: aa1303e0    	mov	x0, x19
105181c1c: aa1703e1    	mov	x1, x23
105181c20: 94aa9547    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181c24: aa1d03fd    	mov	x29, x29
105181c28: 94aa9548    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181c2c: aa0003f6    	mov	x22, x0
105181c30: d00d7c28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105181c34: f943f101    	ldr	x1, [x8, #0x7e0] ; selector/string setCount:
105181c38: 52800002    	mov	w2, #0x0                ; =0
105181c3c: 94aa9540    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181c40: aa1603e0    	mov	x0, x22
105181c44: 94aa9544    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181c48: 900d7c48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105181c4c: f943fd01    	ldr	x1, [x8, #0x7f8] ; selector/string setScene:
105181c50: aa1303e0    	mov	x0, x19
105181c54: f90013f4    	str	x20, [sp, #0x20]
105181c58: aa1403e2    	mov	x2, x20
105181c5c: 94aa9538    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181c60: f00d7f88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105181c64: f944fd1a    	ldr	x26, [x8, #0x9f8] ; class SKBuiltinBuffer_t
105181c68: d00d7f97    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105181c6c: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
105181c70: f00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105181c74: f944e916    	ldr	x22, [x8, #0x9d0] ; selector/string currentContext
105181c78: aa1603e1    	mov	x1, x22
105181c7c: 94aa9530    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181c80: aa1d03fd    	mov	x29, x29
105181c84: 94aa9531    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181c88: aa0003fb    	mov	x27, x0
105181c8c: 900d7fa8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105181c90: f9414d00    	ldr	x0, [x8, #0x298] ; class AccountStorageMgr
105181c94: d00d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105181c98: f947ad18    	ldr	x24, [x8, #0xf58] ; selector/string class
105181c9c: aa1803e1    	mov	x1, x24
105181ca0: 94aa9527    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181ca4: aa0003e2    	mov	x2, x0
105181ca8: 900d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105181cac: f9464114    	ldr	x20, [x8, #0xc80] ; selector/string getService:
105181cb0: aa1b03e0    	mov	x0, x27
105181cb4: aa1403e1    	mov	x1, x20
105181cb8: 94aa9521    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181cbc: aa1d03fd    	mov	x29, x29
105181cc0: 94aa9522    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181cc4: aa0003fc    	mov	x28, x0
105181cc8: 900d6828    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
105181ccc: f9428501    	ldr	x1, [x8, #0x508] ; selector/string GetSyncBuffer
105181cd0: 94aa951b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181cd4: aa1d03fd    	mov	x29, x29
105181cd8: 94aa951c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181cdc: aa0003f5    	mov	x21, x0
105181ce0: 900d6688    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
105181ce4: f9418519    	ldr	x25, [x8, #0x308] ; selector/string skBufferWithData:
105181ce8: aa1a03e0    	mov	x0, x26
105181cec: aa1903e1    	mov	x1, x25
105181cf0: aa1503e2    	mov	x2, x21
105181cf4: 94aa9512    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181cf8: aa1d03fd    	mov	x29, x29
105181cfc: 94aa9513    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181d00: aa0003fa    	mov	x26, x0
105181d04: 900d69a8    	adrp	x8, 0x11feb5000 <dyld_stub_binder+0x11feb5000>
105181d08: f943e901    	ldr	x1, [x8, #0x7d0] ; selector/string setKeyBuf:
105181d0c: aa1303e0    	mov	x0, x19
105181d10: aa1a03e2    	mov	x2, x26
105181d14: 94aa950a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181d18: aa1a03e0    	mov	x0, x26
105181d1c: 94aa950e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181d20: aa1503e0    	mov	x0, x21
105181d24: 94aa950c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181d28: aa1c03e0    	mov	x0, x28
105181d2c: 94aa950a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181d30: aa1b03e0    	mov	x0, x27
105181d34: 94aa9508    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181d38: f00d7f88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105181d3c: f944fd15    	ldr	x21, [x8, #0x9f8] ; class SKBuiltinBuffer_t
105181d40: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
105181d44: aa1603e1    	mov	x1, x22
105181d48: 94aa94fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181d4c: aa1d03fd    	mov	x29, x29
105181d50: 94aa94fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181d54: aa0003fa    	mov	x26, x0
105181d58: 900d7fa8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105181d5c: f9414d00    	ldr	x0, [x8, #0x298] ; class AccountStorageMgr
105181d60: aa1803e1    	mov	x1, x24
105181d64: 94aa94f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181d68: aa0003e2    	mov	x2, x0
105181d6c: aa1a03e0    	mov	x0, x26
105181d70: aa1403e1    	mov	x1, x20
105181d74: 94aa94f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181d78: aa1d03fd    	mov	x29, x29
105181d7c: 94aa94f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181d80: aa0003fb    	mov	x27, x0
105181d84: d00d70a8    	adrp	x8, 0x11ff97000 <dyld_stub_binder+0x11ff97000>
105181d88: f9429901    	ldr	x1, [x8, #0x530] ; selector/string loadSvrSyncBufferKey
105181d8c: 94aa94ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181d90: aa1d03fd    	mov	x29, x29
105181d94: 94aa94ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181d98: aa0003fc    	mov	x28, x0
105181d9c: aa1503e0    	mov	x0, x21
105181da0: aa1903e1    	mov	x1, x25
105181da4: aa1c03e2    	mov	x2, x28
105181da8: 94aa94e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181dac: aa1d03fd    	mov	x29, x29
105181db0: 94aa94e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181db4: aa0003f5    	mov	x21, x0
105181db8: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181dbc: f942c101    	ldr	x1, [x8, #0x580] ; selector/string setSyncUniqKeyBuf:
105181dc0: aa1303e0    	mov	x0, x19
105181dc4: aa1503e2    	mov	x2, x21
105181dc8: 94aa94dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181dcc: aa1503e0    	mov	x0, x21
105181dd0: 94aa94e1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181dd4: aa1c03e0    	mov	x0, x28
105181dd8: 94aa94df    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181ddc: aa1b03e0    	mov	x0, x27
105181de0: 94aa94dd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181de4: aa1a03e0    	mov	x0, x26
105181de8: 94aa94db    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181dec: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181df0: f9464900    	ldr	x0, [x8, #0xc90] ; class CAppUtil
105181df4: 900d7c08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105181df8: f947b101    	ldr	x1, [x8, #0xf60] ; selector/string getDeviceType
105181dfc: 94aa94d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181e00: aa1d03fd    	mov	x29, x29
105181e04: 94aa94d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181e08: aa0003f5    	mov	x21, x0
105181e0c: b00d6608    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105181e10: f9475d01    	ldr	x1, [x8, #0xeb8] ; selector/string setDeviceType:
105181e14: aa1303e0    	mov	x0, x19
105181e18: aa1503e2    	mov	x2, x21
105181e1c: 94aa94c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181e20: aa1503e0    	mov	x0, x21
105181e24: 94aa94cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181e28: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
105181e2c: aa1603e1    	mov	x1, x22
105181e30: 94aa94c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181e34: aa1d03fd    	mov	x29, x29
105181e38: 94aa94c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181e3c: aa0003f5    	mov	x21, x0
105181e40: f00d7f88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105181e44: f9420900    	ldr	x0, [x8, #0x410] ; class CNetworkStatus
105181e48: aa1803e1    	mov	x1, x24
105181e4c: 94aa94bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181e50: aa0003e2    	mov	x2, x0
105181e54: aa1503e0    	mov	x0, x21
105181e58: aa1403fc    	mov	x28, x20
105181e5c: aa1403e1    	mov	x1, x20
105181e60: 94aa94b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181e64: aa1d03fd    	mov	x29, x29
105181e68: 94aa94b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181e6c: aa0003f9    	mov	x25, x0
105181e70: 900d65e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105181e74: f9431d01    	ldr	x1, [x8, #0x638] ; selector/string isOnWifi
105181e78: 94aa94b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181e7c: aa0003fa    	mov	x26, x0
105181e80: aa1903e0    	mov	x0, x25
105181e84: 94aa94b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181e88: aa1503e0    	mov	x0, x21
105181e8c: 94aa94b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181e90: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181e94: f942c501    	ldr	x1, [x8, #0x588] ; selector/string setPrevDownloadFlag:
105181e98: 2a1a03e2    	mov	w2, w26
105181e9c: aa1303e0    	mov	x0, x19
105181ea0: 94aa94a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181ea4: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105181ea8: b9894508    	ldrsw	x8, [x8, #0x944] ; ivar NewSyncService.m_bFirstSyncAfterBgfgChange offset=86 type=B
105181eac: f94017e9    	ldr	x9, [sp, #0x28]
105181eb0: aa0903fb    	mov	x27, x9
105181eb4: 38686928    	ldrb	w8, [x9, x8]
105181eb8: d00d7f94    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
105181ebc: 900d65d5    	adrp	x21, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105181ec0: 7100051f    	cmp	w8, #0x1
105181ec4: 540002a1    	b.ne	0x105181f18 <_Flutter_MMFoundation_BindContext+0x165dafc>
105181ec8: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181ecc: f942c901    	ldr	x1, [x8, #0x590] ; selector/string setSyncMsgDigest:
105181ed0: aa1303e0    	mov	x0, x19
105181ed4: 52800022    	mov	w2, #0x1                ; =1
105181ed8: 94aa9499    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181edc: f9453680    	ldr	x0, [x20, #0xa68] ; class iConsole
105181ee0: f942aaa1    	ldr	x1, [x21, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
105181ee4: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105181ee8: 91382108    	add	x8, x8, #0xe08 ; CFString 'sync bg2fg==1'
105181eec: f90003e8    	str	x8, [sp]
105181ef0: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105181ef4: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
105181ef8: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181efc: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105181f00: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181f04: 9131f8e7    	add	x7, x7, #0xc7e ; string '-[NewSyncService creatPBNewSyncEvent:]'
105181f08: 52800042    	mov	w2, #0x2                ; =2
105181f0c: 52800004    	mov	w4, #0x0                ; =0
105181f10: 528029a6    	mov	w6, #0x14d              ; =333
105181f14: 14000019    	b	0x105181f78 <_Flutter_MMFoundation_BindContext+0x165db5c>
105181f18: d00dcb08    	adrp	x8, 0x120ae3000 <dyld_stub_binder+0x120ae3000>
105181f1c: 91094108    	add	x8, x8, #0x250
105181f20: f9400108    	ldr	x8, [x8]
105181f24: d63f0100    	blr	x8
105181f28: 370002a0    	tbnz	w0, #0x0, 0x105181f7c <_Flutter_MMFoundation_BindContext+0x165db60>
105181f2c: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181f30: f942c901    	ldr	x1, [x8, #0x590] ; selector/string setSyncMsgDigest:
105181f34: aa1303e0    	mov	x0, x19
105181f38: 52800022    	mov	w2, #0x1                ; =1
105181f3c: 94aa9480    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181f40: f9453680    	ldr	x0, [x20, #0xa68] ; class iConsole
105181f44: f942aaa1    	ldr	x1, [x21, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
105181f48: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105181f4c: 9138a108    	add	x8, x8, #0xe28 ; CFString 'sync long link is NOT connected'
105181f50: f90003e8    	str	x8, [sp]
105181f54: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105181f58: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
105181f5c: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181f60: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105181f64: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181f68: 9131f8e7    	add	x7, x7, #0xc7e ; string '-[NewSyncService creatPBNewSyncEvent:]'
105181f6c: 52800042    	mov	w2, #0x2                ; =2
105181f70: 52800004    	mov	w4, #0x0                ; =0
105181f74: 52802a26    	mov	w6, #0x151              ; =337
105181f78: 94aa9471    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181f7c: 900d8028    	adrp	x8, 0x120185000 <dyld_stub_binder+0x120185000>
105181f80: f9402500    	ldr	x0, [x8, #0x48] ; class LoginAgreeSyncMsgLogic
105181f84: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181f88: f942b501    	ldr	x1, [x8, #0x568] ; selector/string getAuthSyncFlag
105181f8c: 94aa946c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181f90: 34000100    	cbz	w0, 0x105181fb0 <_Flutter_MMFoundation_BindContext+0x165db94>
105181f94: 93407c19    	sxtw	x25, w0
105181f98: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181f9c: f942b901    	ldr	x1, [x8, #0x570] ; selector/string setSyncFlag:
105181fa0: aa1303e0    	mov	x0, x19
105181fa4: aa1903e2    	mov	x2, x25
105181fa8: 94aa9465    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181fac: 14000002    	b	0x105181fb4 <_Flutter_MMFoundation_BindContext+0x165db98>
105181fb0: d2800019    	mov	x25, #0x0               ; =0
105181fb4: f9453680    	ldr	x0, [x20, #0xa68] ; class iConsole
105181fb8: f942aaba    	ldr	x26, [x21, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
105181fbc: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105181fc0: 91392108    	add	x8, x8, #0xe48 ; CFString 'creatPBNewSyncEvent, syncFlag: %ld'
105181fc4: a90067e8    	stp	x8, x25, [sp]
105181fc8: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105181fcc: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
105181fd0: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181fd4: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105181fd8: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181fdc: 9131f8e7    	add	x7, x7, #0xc7e ; string '-[NewSyncService creatPBNewSyncEvent:]'
105181fe0: aa1a03e1    	mov	x1, x26
105181fe4: 52800022    	mov	w2, #0x1                ; =1
105181fe8: 52800004    	mov	w4, #0x0                ; =0
105181fec: 52802b46    	mov	w6, #0x15a              ; =346
105181ff0: 94aa9453    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181ff4: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181ff8: f9479900    	ldr	x0, [x8, #0xf30] ; class ProtobufCGIWrap
105181ffc: 94aa9457    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105182000: aa0003f9    	mov	x25, x0
105182004: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182008: f9446501    	ldr	x1, [x8, #0x8c8] ; selector/string setM_pbRequest:
10518200c: aa1303e2    	mov	x2, x19
105182010: 94aa944b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182014: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182018: f9446901    	ldr	x1, [x8, #0x8d0] ; selector/string setM_uiCgi:
10518201c: aa1903e0    	mov	x0, x25
105182020: 52801142    	mov	w2, #0x8a               ; =138
105182024: 94aa9446    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182028: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
10518202c: aa1603e1    	mov	x1, x22
105182030: 94aa9443    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182034: aa1d03fd    	mov	x29, x29
105182038: 94aa9444    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10518203c: aa0003f5    	mov	x21, x0
105182040: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105182044: f9479d00    	ldr	x0, [x8, #0xf38] ; class EventService
105182048: aa1803e1    	mov	x1, x24
10518204c: 94aa943c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182050: aa0003e2    	mov	x2, x0
105182054: aa1503e0    	mov	x0, x21
105182058: aa1c03e1    	mov	x1, x28
10518205c: 94aa9438    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182060: aa1d03fd    	mov	x29, x29
105182064: 94aa9439    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182068: aa0003f6    	mov	x22, x0
10518206c: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182070: f9446d01    	ldr	x1, [x8, #0x8d8] ; selector/string CreateProtobufEvent:Flag:
105182074: aa1903e2    	mov	x2, x25
105182078: 528000a3    	mov	w3, #0x5                ; =5
10518207c: 94aa9430    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182080: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105182084: b9891d17    	ldrsw	x23, [x8, #0x91c] ; ivar NewSyncService.m_syncEventID offset=80 type=I
105182088: b8376b60    	str	w0, [x27, x23]
10518208c: aa1603e0    	mov	x0, x22
105182090: 94aa9431    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182094: aa1503e0    	mov	x0, x21
105182098: 94aa942f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518209c: b8776b76    	ldr	w22, [x27, x23]
1051820a0: f9453680    	ldr	x0, [x20, #0xa68] ; class iConsole
1051820a4: 340005b6    	cbz	w22, 0x105182158 <_Flutter_MMFoundation_BindContext+0x165dd3c>
1051820a8: f94013f8    	ldr	x24, [sp, #0x20]
1051820ac: a900e3f6    	stp	x22, x24, [sp, #0x8]
1051820b0: b00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
1051820b4: 9139a108    	add	x8, x8, #0xe68 ; CFString 'm_syncEventID:%u scene:%d'
1051820b8: f90003e8    	str	x8, [sp]
1051820bc: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
1051820c0: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
1051820c4: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051820c8: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
1051820cc: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051820d0: 9131f8e7    	add	x7, x7, #0xc7e ; string '-[NewSyncService creatPBNewSyncEvent:]'
1051820d4: aa1a03e1    	mov	x1, x26
1051820d8: 52800042    	mov	w2, #0x2                ; =2
1051820dc: 52800004    	mov	w4, #0x0                ; =0
1051820e0: 52802c86    	mov	w6, #0x164              ; =356
1051820e4: 94aa9416    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051820e8: b00d8088    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
1051820ec: f9409100    	ldr	x0, [x8, #0x120] ; class WCAppLaunchTimeRecorder
1051820f0: 900d7c48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1051820f4: f9437d01    	ldr	x1, [x8, #0x6f8] ; selector/string sharedInstance
1051820f8: 94aa9411    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051820fc: aa1d03fd    	mov	x29, x29
105182100: 94aa9412    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105182104: aa0003f5    	mov	x21, x0
105182108: d00d7028    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
10518210c: f941b101    	ldr	x1, [x8, #0x360] ; selector/string record:
105182110: 52800682    	mov	w2, #0x34               ; =52
105182114: 94aa940a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182118: aa1503e0    	mov	x0, x21
10518211c: 94aa940e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182120: 52800100    	mov	w0, #0x8                ; =8
105182124: 92800001    	mov	x1, #-0x1               ; =-1
105182128: 94aa29af    	bl	0x107c0c7e4 <_Flutter_MMFoundation_BindContext+0x40e83c8>
10518212c: 2a1803e1    	mov	w1, w24
105182130: 52800140    	mov	w0, #0xa                ; =10
105182134: 94aa29ac    	bl	0x107c0c7e4 <_Flutter_MMFoundation_BindContext+0x40e83c8>
105182138: b00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10518213c: f9464900    	ldr	x0, [x8, #0xc90] ; class CAppUtil
105182140: b8776b62    	ldr	w2, [x27, x23]
105182144: b00d65c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105182148: f9447101    	ldr	x1, [x8, #0x8e0] ; selector/string addPBEventObserverListItem:andValue:
10518214c: aa1b03e3    	mov	x3, x27
105182150: 94aa93fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182154: 1400000f    	b	0x105182190 <_Flutter_MMFoundation_BindContext+0x165dd74>
105182158: 900c9a48    	adrp	x8, 0x11e4ca000 <dyld_stub_binder+0x11e4ca000>
10518215c: 9134a108    	add	x8, x8, #0xd28 ; CFString 'CreateProtobufEvent failed!'
105182160: f90003e8    	str	x8, [sp]
105182164: d00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105182168: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
10518216c: 900b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182170: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm'
105182174: 900b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105182178: 9131f8e7    	add	x7, x7, #0xc7e ; string '-[NewSyncService creatPBNewSyncEvent:]'
10518217c: aa1a03e1    	mov	x1, x26
105182180: 52800062    	mov	w2, #0x3                ; =3
105182184: 52800004    	mov	w4, #0x0                ; =0
105182188: 52802c26    	mov	w6, #0x161              ; =353
10518218c: 94aa93ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105182190: 710002df    	cmp	w22, #0x0
105182194: 1a9f07f4    	cset	w20, ne
105182198: aa1903e0    	mov	x0, x25
10518219c: 94aa93ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051821a0: aa1303e0    	mov	x0, x19
1051821a4: 94aa93ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051821a8: aa1403e0    	mov	x0, x20
1051821ac: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1051821b0: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1051821b4: a94657f6    	ldp	x22, x21, [sp, #0x60]
1051821b8: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1051821bc: a94467fa    	ldp	x26, x25, [sp, #0x40]
1051821c0: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1051821c4: 910243ff    	add	sp, sp, #0x90
1051821c8: d65f03c0    	ret
