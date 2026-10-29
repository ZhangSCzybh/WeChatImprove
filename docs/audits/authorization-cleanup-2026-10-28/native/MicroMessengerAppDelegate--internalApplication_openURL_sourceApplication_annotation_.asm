
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104bd3ce0: d101c3ff    	sub	sp, sp, #0x70
104bd3ce4: a90267fa    	stp	x26, x25, [sp, #0x20]
104bd3ce8: a9035ff8    	stp	x24, x23, [sp, #0x30]
104bd3cec: a90457f6    	stp	x22, x21, [sp, #0x40]
104bd3cf0: a9054ff4    	stp	x20, x19, [sp, #0x50]
104bd3cf4: a9067bfd    	stp	x29, x30, [sp, #0x60]
104bd3cf8: 910183fd    	add	x29, sp, #0x60
104bd3cfc: aa0503f6    	mov	x22, x5
104bd3d00: aa0403f5    	mov	x21, x4
104bd3d04: aa0303f4    	mov	x20, x3
104bd3d08: aa0203f3    	mov	x19, x2
104bd3d0c: aa0003f7    	mov	x23, x0
104bd3d10: f00e0348    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104bd3d14: 52800029    	mov	w9, #0x1                ; =1
104bd3d18: 391d1109    	strb	w9, [x8, #0x744]
104bd3d1c: f00da948    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104bd3d20: f945c918    	ldr	x24, [x8, #0xb90] ; selector absoluteString
104bd3d24: aa0503e0    	mov	x0, x5
104bd3d28: 94c14d04    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3d2c: aa1503e0    	mov	x0, x21
104bd3d30: 94c14d02    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3d34: aa1403e0    	mov	x0, x20
104bd3d38: 94c14d00    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3d3c: aa1303e0    	mov	x0, x19
104bd3d40: 94c14cfe    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3d44: aa1403e0    	mov	x0, x20
104bd3d48: aa1803e1    	mov	x1, x24
104bd3d4c: 94c14cfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3d50: aa1d03fd    	mov	x29, x29
104bd3d54: 94c14cfd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3d58: aa0003f8    	mov	x24, x0
104bd3d5c: 900da988    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104bd3d60: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
104bd3d64: 94c14cf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3d68: 900a0de8    	adrp	x8, 0x118d8f000 <dyld_stub_binder+0x118d8f000>
104bd3d6c: 912d0108    	add	x8, x8, #0xb40
104bd3d70: f9400102    	ldr	x2, [x8]
104bd3d74: eb02001f    	cmp	x0, x2
104bd3d78: 54000169    	b.ls	0x104bd3da4 <_Flutter_MMFoundation_BindContext+0x10af988>
104bd3d7c: f00da9a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104bd3d80: f9473101    	ldr	x1, [x8, #0xe60] ; selector substringToIndex:
104bd3d84: aa1803e0    	mov	x0, x24
104bd3d88: 94c14ced    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3d8c: aa1d03fd    	mov	x29, x29
104bd3d90: 94c14cee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3d94: aa0003f9    	mov	x25, x0
104bd3d98: aa1803e0    	mov	x0, x24
104bd3d9c: 94c14cee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3da0: aa1903f8    	mov	x24, x25
104bd3da4: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd3da8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104bd3dac: d00d9328    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bd3db0: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104bd3db4: a9015bf8    	stp	x24, x22, [sp, #0x10]
104bd3db8: b00cdec8    	adrp	x8, 0x11e7ac000 <dyld_stub_binder+0x11e7ac000>
104bd3dbc: 9127a108    	add	x8, x8, #0x9e8 ; CFString 'source app[%@], url[%@], annotation[%@]'
104bd3dc0: a90057e8    	stp	x8, x21, [sp]
104bd3dc4: d00b61a5    	adrp	x5, 0x11b809000 <dyld_stub_binder+0x11b809000>
104bd3dc8: 9114a0a5    	add	x5, x5, #0x528 ; string 'MicroMessengerAppDelegate.mm'
104bd3dcc: 900b61c7    	adrp	x7, 0x11b80b000 <dyld_stub_binder+0x11b80b000>
104bd3dd0: 910a04e7    	add	x7, x7, #0x281 ; string '-[MicroMessengerAppDelegate internalApplication:openURL:sourceApplication:annotation:]'
104bd3dd4: 52800042    	mov	w2, #0x2                ; =2
104bd3dd8: d2800003    	mov	x3, #0x0                ; =0
104bd3ddc: 52800004    	mov	w4, #0x0                ; =0
104bd3de0: 528145c6    	mov	w6, #0xa2e              ; =2606
104bd3de4: 94c14cd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3de8: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd3dec: f9458d00    	ldr	x0, [x8, #0xb18] ; class NSNotificationCenter
104bd3df0: b00da968    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bd3df4: f946b101    	ldr	x1, [x8, #0xd60] ; selector defaultCenter
104bd3df8: 94c14cd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3dfc: aa1d03fd    	mov	x29, x29
104bd3e00: 94c14cd2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3e04: aa0003f9    	mov	x25, x0
104bd3e08: b00c5448    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
104bd3e0c: 91392108    	add	x8, x8, #0xe48
104bd3e10: f9400102    	ldr	x2, [x8]
104bd3e14: d00da988    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
104bd3e18: f944d901    	ldr	x1, [x8, #0x9b0] ; selector postNotificationName:object:userInfo:
104bd3e1c: d2800003    	mov	x3, #0x0                ; =0
104bd3e20: d2800004    	mov	x4, #0x0                ; =0
104bd3e24: 94c14cc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3e28: aa1903e0    	mov	x0, x25
104bd3e2c: 94c14cca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3e30: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd3e34: f9448901    	ldr	x1, [x8, #0x910] ; selector application:handleOpenURL:bundleID:annotation:
104bd3e38: aa1703e0    	mov	x0, x23
104bd3e3c: aa1303e2    	mov	x2, x19
104bd3e40: aa1403e3    	mov	x3, x20
104bd3e44: aa1503e4    	mov	x4, x21
104bd3e48: aa1603e5    	mov	x5, x22
104bd3e4c: 94c14cbc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3e50: aa0003f7    	mov	x23, x0
104bd3e54: aa1603e0    	mov	x0, x22
104bd3e58: 94c14cbf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3e5c: aa1503e0    	mov	x0, x21
104bd3e60: 94c14cbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3e64: aa1403e0    	mov	x0, x20
104bd3e68: 94c14cbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3e6c: aa1303e0    	mov	x0, x19
104bd3e70: 94c14cb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3e74: aa1803e0    	mov	x0, x24
104bd3e78: 94c14cb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3e7c: aa1703e0    	mov	x0, x23
104bd3e80: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104bd3e84: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104bd3e88: a94457f6    	ldp	x22, x21, [sp, #0x40]
104bd3e8c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104bd3e90: a94267fa    	ldp	x26, x25, [sp, #0x20]
104bd3e94: 9101c3ff    	add	sp, sp, #0x70
104bd3e98: d65f03c0    	ret
