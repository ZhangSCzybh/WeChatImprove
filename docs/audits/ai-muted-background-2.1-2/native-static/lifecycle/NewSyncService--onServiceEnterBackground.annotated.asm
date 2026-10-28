
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105180aa4: d10183ff    	sub	sp, sp, #0x60
105180aa8: a90167fa    	stp	x26, x25, [sp, #0x10]
105180aac: a9025ff8    	stp	x24, x23, [sp, #0x20]
105180ab0: a90357f6    	stp	x22, x21, [sp, #0x30]
105180ab4: a9044ff4    	stp	x20, x19, [sp, #0x40]
105180ab8: a9057bfd    	stp	x29, x30, [sp, #0x50]
105180abc: 910143fd    	add	x29, sp, #0x50
105180ac0: f00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105180ac4: 52800029    	mov	w9, #0x1                ; =1
105180ac8: 39335909    	strb	w9, [x8, #0xcd6]
105180acc: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180ad0: f9464900    	ldr	x0, [x8, #0xc90] ; class CAppUtil @ 0x120173c90
105180ad4: d00d65e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105180ad8: f9405101    	ldr	x1, [x8, #0xa0] ; selector isLogin @ 0x11fe3e0a0
105180adc: 94aa9998    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180ae0: 34001220    	cbz	w0, 0x105180d24 <_Flutter_MMFoundation_BindContext+0x165c908>
105180ae4: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180ae8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole @ 0x120173a68
105180aec: b00d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105180af0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format: @ 0x11fe39550
105180af4: f00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105180af8: 9133a108    	add	x8, x8, #0xce8 ; CFString 'BgFgRequest enter background' @ 0x11e7d7ce8
105180afc: f90003e8    	str	x8, [sp]
105180b00: 900b0f03    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105180b04: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync' @ 0x11b3609c0
105180b08: d00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105180b0c: 912b00a5    	add	x5, x5, #0xac0 ; string 'NewSyncService.mm' @ 0x11b85eac0
105180b10: d00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105180b14: 912b48e7    	add	x7, x7, #0xad2 ; string '-[NewSyncService onServiceEnterBackground]' @ 0x11b85ead2
105180b18: 52800042    	mov	w2, #0x2                ; =2
105180b1c: 52800004    	mov	w4, #0x0                ; =0
105180b20: 52801526    	mov	w6, #0xa9               ; =169
105180b24: 94aa9986    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180b28: 900d80a8    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
105180b2c: f9440500    	ldr	x0, [x8, #0x808] ; class BgFgRequest @ 0x120194808
105180b30: 94aa998a    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105180b34: aa0003f3    	mov	x19, x0
105180b38: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180b3c: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility @ 0x120173cf0
105180b40: d00d7be8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105180b44: f9439901    	ldr	x1, [x8, #0x730] ; selector GetVersion @ 0x1200fe730
105180b48: 94aa997d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180b4c: aa0003e2    	mov	x2, x0
105180b50: f00d7c28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105180b54: f942dd01    	ldr	x1, [x8, #0x5b8] ; selector setClientVersion: @ 0x1201075b8
105180b58: aa1303e0    	mov	x0, x19
105180b5c: 94aa9978    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180b60: 900d8088    	adrp	x8, 0x120190000 <dyld_stub_binder+0x120190000>
105180b64: f9477100    	ldr	x0, [x8, #0xee0] ; class DeviceUtility @ 0x120190ee0
105180b68: 900d6fa8    	adrp	x8, 0x11ff74000 <dyld_stub_binder+0x11ff74000>
105180b6c: f9408101    	ldr	x1, [x8, #0x100] ; selector HeadDeviceType @ 0x11ff74100
105180b70: 94aa9973    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180b74: aa0003e2    	mov	x2, x0
105180b78: d00d6608    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
105180b7c: f9473501    	ldr	x1, [x8, #0xe68] ; selector setDeviceTypeId: @ 0x11fe42e68
105180b80: aa1303e0    	mov	x0, x19
105180b84: 94aa996e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180b88: f00d7f9a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
105180b8c: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext @ 0x120173bd0
105180b90: 900d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105180b94: f944e914    	ldr	x20, [x8, #0x9d0] ; selector currentContext @ 0x1201009d0
105180b98: aa1403e1    	mov	x1, x20
105180b9c: 94aa9968    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180ba0: aa1d03fd    	mov	x29, x29
105180ba4: 94aa9969    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180ba8: aa0003f7    	mov	x23, x0
105180bac: 900d7fa8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105180bb0: f9420900    	ldr	x0, [x8, #0x410] ; class CNetworkStatus @ 0x120174410
105180bb4: f00d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105180bb8: f947ad15    	ldr	x21, [x8, #0xf58] ; selector class @ 0x1200fff58
105180bbc: aa1503e1    	mov	x1, x21
105180bc0: 94aa995f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180bc4: aa0003e2    	mov	x2, x0
105180bc8: b00d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105180bcc: f9464116    	ldr	x22, [x8, #0xc80] ; selector getService: @ 0x11fe39c80
105180bd0: aa1703e0    	mov	x0, x23
105180bd4: aa1603e1    	mov	x1, x22
105180bd8: 94aa9959    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180bdc: aa1d03fd    	mov	x29, x29
105180be0: 94aa995a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180be4: aa0003f8    	mov	x24, x0
105180be8: f00d6608    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105180bec: f9400d01    	ldr	x1, [x8, #0x18] ; selector getNewNetType @ 0x11fe43018
105180bf0: 94aa9953    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180bf4: aa0003e2    	mov	x2, x0
105180bf8: 900d7c48    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
105180bfc: f947a901    	ldr	x1, [x8, #0xf50] ; selector setNetworkMode: @ 0x120108f50
105180c00: aa1303e0    	mov	x0, x19
105180c04: 94aa994e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180c08: aa1803e0    	mov	x0, x24
105180c0c: 94aa9952    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180c10: aa1703e0    	mov	x0, x23
105180c14: 94aa9950    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180c18: 900d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105180c1c: f942a501    	ldr	x1, [x8, #0x548] ; selector setOnlineMode: @ 0x11ff9c548
105180c20: aa1303e0    	mov	x0, x19
105180c24: 52800042    	mov	w2, #0x2                ; =2
105180c28: 94aa9945    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180c2c: d00d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105180c30: f9439d01    	ldr	x1, [x8, #0x738] ; selector serializedData @ 0x11fe3a738
105180c34: aa1303e0    	mov	x0, x19
105180c38: 94aa9941    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180c3c: aa1d03fd    	mov	x29, x29
105180c40: 94aa9942    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180c44: aa0003f7    	mov	x23, x0
105180c48: d00d7fe8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
105180c4c: f9469100    	ldr	x0, [x8, #0xd20] ; class NetCmdSendOnlyEvent @ 0x12017ed20
105180c50: 94aa9942    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105180c54: aa0003f8    	mov	x24, x0
105180c58: 52800300    	mov	w0, #0x18               ; =24
105180c5c: 94aa9948    	bl	0x107c2717c <_Flutter_MMFoundation_BindContext+0x4102d60>
105180c60: aa0003f9    	mov	x25, x0
105180c64: aa1703e1    	mov	x1, x23
105180c68: 52802702    	mov	w2, #0x138              ; =312
105180c6c: 97fb2786    	bl	0x10504aa84 <_Flutter_MMFoundation_BindContext+0x1526668>
105180c70: 900d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105180c74: f942a901    	ldr	x1, [x8, #0x550] ; selector setM_netcmd: @ 0x11ff9c550
105180c78: aa1803e0    	mov	x0, x24
105180c7c: aa1903e2    	mov	x2, x25
105180c80: 94aa992f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180c84: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext @ 0x120173bd0
105180c88: aa1403e1    	mov	x1, x20
105180c8c: 94aa992c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180c90: aa1d03fd    	mov	x29, x29
105180c94: 94aa992d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180c98: aa0003f4    	mov	x20, x0
105180c9c: f00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105180ca0: f9479d00    	ldr	x0, [x8, #0xf38] ; class EventService @ 0x120173f38
105180ca4: aa1503e1    	mov	x1, x21
105180ca8: 94aa9925    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180cac: aa0003e2    	mov	x2, x0
105180cb0: aa1403e0    	mov	x0, x20
105180cb4: aa1603e1    	mov	x1, x22
105180cb8: 94aa9921    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180cbc: aa1d03fd    	mov	x29, x29
105180cc0: 94aa9922    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105180cc4: aa0003f5    	mov	x21, x0
105180cc8: 900d6928    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
105180ccc: f946d502    	ldr	x2, [x8, #0xda8] ; selector AddEvent: @ 0x11fea4da8
105180cd0: b00d7c28    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
105180cd4: f943e901    	ldr	x1, [x8, #0x7d0] ; selector performSelectorOnMainThread:withObject:waitUntilDone: @ 0x1201057d0
105180cd8: aa1803e3    	mov	x3, x24
105180cdc: 52800004    	mov	w4, #0x0                ; =0
105180ce0: 94aa9917    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105180ce4: aa1503e0    	mov	x0, x21
105180ce8: 94aa991b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180cec: aa1403e0    	mov	x0, x20
105180cf0: 94aa9919    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180cf4: aa1803e0    	mov	x0, x24
105180cf8: 94aa9917    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180cfc: aa1303e0    	mov	x0, x19
105180d00: 94aa9915    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180d04: aa1703e0    	mov	x0, x23
105180d08: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105180d0c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105180d10: a94357f6    	ldp	x22, x21, [sp, #0x30]
105180d14: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105180d18: a94167fa    	ldp	x26, x25, [sp, #0x10]
105180d1c: 910183ff    	add	sp, sp, #0x60
105180d20: 14aa990d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105180d24: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105180d28: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105180d2c: a94357f6    	ldp	x22, x21, [sp, #0x30]
105180d30: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105180d34: a94167fa    	ldp	x26, x25, [sp, #0x10]
105180d38: 910183ff    	add	sp, sp, #0x60
105180d3c: d65f03c0    	ret
