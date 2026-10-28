
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105180d40: d10183ff    	sub	sp, sp, #0x60
105180d44: a90167fa    	stp	x26, x25, [sp, #0x10]
105180d48: a9025ff8    	stp	x24, x23, [sp, #0x20]
105180d4c: a90357f6    	stp	x22, x21, [sp, #0x30]
105180d50: a9044ff4    	stp	x20, x19, [sp, #0x40]
105180d54: a9057bfd    	stp	x29, x30, [sp, #0x50]
105180d58: 910143fd    	add	x29, sp, #0x50
105180d5c: aa0003f3    	mov	x19, x0
105180d60: f00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105180d64: 52800034    	mov	w20, #0x1               ; =1
105180d68: 39335d14    	strb	w20, [x8, #0xcd7]
105180d6c: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180d70: f9464900    	ldr	x0, [x8, #0xc90] ; class CAppUtil @ 0x120173c90
105180d74: d00d65e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105180d78: f9405101    	ldr	x1, [x8, #0xa0] ; selector isLogin @ 0x11fe3e0a0
105180d7c: 94aa98f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180d80: 340012e0    	cbz	w0, 0x105180fdc <_Flutter_MMFoundation_BindContext+0x165cbc0>
105180d84: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180d88: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole @ 0x120173a68
105180d8c: b00d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105180d90: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format: @ 0x11fe39550
105180d94: f00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105180d98: 91342108    	add	x8, x8, #0xd08 ; CFString 'BgFgRequest enter foreground' @ 0x11e7d7d08
105180d9c: f90003e8    	str	x8, [sp]
105180da0: 900b0f03    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105180da4: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync' @ 0x11b3609c0
105180da8: d00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105180dac: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm' @ 0x11b85eac0
105180db0: d00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105180db4: 912c68e7    	add	x7, x7, #0xb1a ; string '-[NewSyncService onServiceEnterForeground]' @ 0x11b85eb1a
105180db8: 52800042    	mov	w2, #0x2                ; =2
105180dbc: 52800004    	mov	w4, #0x0                ; =0
105180dc0: 52801786    	mov	w6, #0xbc               ; =188
105180dc4: 94aa98de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180dc8: 900d8548    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105180dcc: b9894508    	ldrsw	x8, [x8, #0x944] ; ivar m_bFirstSyncAfterBgfgChange offset 86 @ 0x120228944
105180dd0: 38286a74    	strb	w20, [x19, x8]
105180dd4: 900d80a8    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
105180dd8: f9440500    	ldr	x0, [x8, #0x808] ; class BgFgRequest @ 0x120194808
105180ddc: 94aa98df    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105180de0: aa0003f3    	mov	x19, x0
105180de4: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180de8: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility @ 0x120173cf0
105180dec: d00d7be8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105180df0: f9439901    	ldr	x1, [x8, #0x730] ; selector GetVersion @ 0x1200fe730
105180df4: 94aa98d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180df8: aa0003e2    	mov	x2, x0
105180dfc: f00d7c28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105180e00: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector setClientVersion: @ 0x1201075b8
105180e04: aa1303e0    	mov	x0, x19
105180e08: 94aa98cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180e0c: 900d8088    	adrp	x8, 0x120190000 <dyld_stub_binder+0x120190000>
105180e10: f9477100    	ldr	x0, [x8, #0xee0] ; class DeviceUtility @ 0x120190ee0
105180e14: 900d6fa8    	adrp	x8, 0x11ff74000 <dyld_stub_binder+0x11ff74000>
105180e18: f9408101    	ldr	x1, [x8, #0x100] ; selector HeadDeviceType @ 0x11ff74100
105180e1c: 94aa98c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180e20: aa0003e2    	mov	x2, x0
105180e24: d00d6608    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105180e28: f9473501    	ldr	x1, [x8, #0xe68] ; selector setDeviceTypeId: @ 0x11fe42e68
105180e2c: aa1303e0    	mov	x0, x19
105180e30: 94aa98c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180e34: f00d7f9a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
105180e38: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext @ 0x120173bd0
105180e3c: 900d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105180e40: f944e914    	ldr	x20, [x8, #0x9d0] ; selector currentContext @ 0x1201009d0
105180e44: aa1403e1    	mov	x1, x20
105180e48: 94aa98bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180e4c: aa1d03fd    	mov	x29, x29
105180e50: 94aa98be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180e54: aa0003f7    	mov	x23, x0
105180e58: 900d7fa8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105180e5c: f9420900    	ldr	x0, [x8, #0x410] ; class CNetworkStatus @ 0x120174410
105180e60: f00d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105180e64: f947ad15    	ldr	x21, [x8, #0xf58] ; selector class @ 0x1200fff58
105180e68: aa1503e1    	mov	x1, x21
105180e6c: 94aa98b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180e70: aa0003e2    	mov	x2, x0
105180e74: b00d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105180e78: f9464116    	ldr	x22, [x8, #0xc80] ; selector getService: @ 0x11fe39c80
105180e7c: aa1703e0    	mov	x0, x23
105180e80: aa1603e1    	mov	x1, x22
105180e84: 94aa98ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180e88: aa1d03fd    	mov	x29, x29
105180e8c: 94aa98af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180e90: aa0003f8    	mov	x24, x0
105180e94: f00d6608    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105180e98: f9400d01    	ldr	x1, [x8, #0x18] ; selector getNewNetType @ 0x11fe43018
105180e9c: 94aa98a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180ea0: aa0003e2    	mov	x2, x0
105180ea4: 900d7c48    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
105180ea8: f947a901    	ldr	x1, [x8, #0xf50] ; selector setNetworkMode: @ 0x120108f50
105180eac: aa1303e0    	mov	x0, x19
105180eb0: 94aa98a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180eb4: aa1803e0    	mov	x0, x24
105180eb8: 94aa98a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180ebc: aa1703e0    	mov	x0, x23
105180ec0: 94aa98a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180ec4: 900d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105180ec8: f942a501    	ldr	x1, [x8, #0x548] ; selector setOnlineMode: @ 0x11ff9c548
105180ecc: aa1303e0    	mov	x0, x19
105180ed0: 52800022    	mov	w2, #0x1                ; =1
105180ed4: 94aa989a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180ed8: 52800300    	mov	w0, #0x18               ; =24
105180edc: d2800001    	mov	x1, #0x0                ; =0
105180ee0: 94aa2e41    	bl	0x107c0c7e4 <_Flutter_MMFoundation_BindContext+0x40e83c8>
105180ee4: d00d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105180ee8: f9439d01    	ldr	x1, [x8, #0x738] ; selector serializedData @ 0x11fe3a738
105180eec: aa1303e0    	mov	x0, x19
105180ef0: 94aa9893    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180ef4: aa1d03fd    	mov	x29, x29
105180ef8: 94aa9894    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180efc: aa0003f7    	mov	x23, x0
105180f00: d00d7fe8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
105180f04: f9469100    	ldr	x0, [x8, #0xd20] ; class NetCmdSendOnlyEvent @ 0x12017ed20
105180f08: 94aa9894    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105180f0c: aa0003f8    	mov	x24, x0
105180f10: 52800300    	mov	w0, #0x18               ; =24
105180f14: 94aa989a    	bl	0x107c2717c <_Flutter_MMFoundation_BindContext+0x4102d60>
105180f18: aa0003f9    	mov	x25, x0
105180f1c: aa1703e1    	mov	x1, x23
105180f20: 52802702    	mov	w2, #0x138              ; =312
105180f24: 97fb26d8    	bl	0x10504aa84 <_Flutter_MMFoundation_BindContext+0x1526668>
105180f28: 900d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105180f2c: f942a901    	ldr	x1, [x8, #0x550] ; selector setM_netcmd: @ 0x11ff9c550
105180f30: aa1803e0    	mov	x0, x24
105180f34: aa1903e2    	mov	x2, x25
105180f38: 94aa9881    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180f3c: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext @ 0x120173bd0
105180f40: aa1403e1    	mov	x1, x20
105180f44: 94aa987e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180f48: aa1d03fd    	mov	x29, x29
105180f4c: 94aa987f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180f50: aa0003f4    	mov	x20, x0
105180f54: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180f58: f9479d00    	ldr	x0, [x8, #0xf38] ; class EventService @ 0x120173f38
105180f5c: aa1503e1    	mov	x1, x21
105180f60: 94aa9877    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180f64: aa0003e2    	mov	x2, x0
105180f68: aa1403e0    	mov	x0, x20
105180f6c: aa1603e1    	mov	x1, x22
105180f70: 94aa9873    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180f74: aa1d03fd    	mov	x29, x29
105180f78: 94aa9874    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180f7c: aa0003f5    	mov	x21, x0
105180f80: 900d6928    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
105180f84: f946d502    	ldr	x2, [x8, #0xda8] ; selector AddEvent: @ 0x11fea4da8
105180f88: b00d7c28    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
105180f8c: f943e901    	ldr	x1, [x8, #0x7d0] ; selector performSelectorOnMainThread:withObject:waitUntilDone: @ 0x1201057d0
105180f90: aa1803e3    	mov	x3, x24
105180f94: 52800004    	mov	w4, #0x0                ; =0
105180f98: 94aa9869    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180f9c: aa1503e0    	mov	x0, x21
105180fa0: 94aa986d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180fa4: aa1403e0    	mov	x0, x20
105180fa8: 94aa986b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180fac: aa1803e0    	mov	x0, x24
105180fb0: 94aa9869    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180fb4: aa1303e0    	mov	x0, x19
105180fb8: 94aa9867    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180fbc: aa1703e0    	mov	x0, x23
105180fc0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105180fc4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105180fc8: a94357f6    	ldp	x22, x21, [sp, #0x30]
105180fcc: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105180fd0: a94167fa    	ldp	x26, x25, [sp, #0x10]
105180fd4: 910183ff    	add	sp, sp, #0x60
105180fd8: 14aa985f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180fdc: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105180fe0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105180fe4: a94357f6    	ldp	x22, x21, [sp, #0x30]
105180fe8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105180fec: a94167fa    	ldp	x26, x25, [sp, #0x10]
105180ff0: 910183ff    	add	sp, sp, #0x60
105180ff4: d65f03c0    	ret
