
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a97d44: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
104a97d48: a9015ff8    	stp	x24, x23, [sp, #0x10]
104a97d4c: a90257f6    	stp	x22, x21, [sp, #0x20]
104a97d50: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a97d54: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a97d58: 910103fd    	add	x29, sp, #0x40
104a97d5c: aa0203f3    	mov	x19, x2
104a97d60: aa0003f4    	mov	x20, x0
104a97d64: f00e0d28    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a97d68: 52800029    	mov	w9, #0x1                ; =1
104a97d6c: 390cb109    	strb	w9, [x8, #0x32c]
104a97d70: aa0203e0    	mov	x0, x2
104a97d74: 94c63cf1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a97d78: b00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a97d7c: f9447501    	ldr	x1, [x8, #0x8e8] ; highlightPatDigestForSessionInfo:
104a97d80: aa1403e0    	mov	x0, x20
104a97d84: aa1303e2    	mov	x2, x19
104a97d88: 94c63ced    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97d8c: aa1d03fd    	mov	x29, x29
104a97d90: 94c63cee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97d94: aa0003f4    	mov	x20, x0
104a97d98: b40000a0    	cbz	x0, 0x104a97dac <_Flutter_MMFoundation_BindContext+0xf73990>
104a97d9c: aa1403e0    	mov	x0, x20
104a97da0: 94c63ce6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a97da4: aa1403f6    	mov	x22, x20
104a97da8: 140000a7    	b	0x104a98044 <_Flutter_MMFoundation_BindContext+0xf73c28>
104a97dac: 900d9d28    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a97db0: f947d916    	ldr	x22, [x8, #0xfb0] ; m_contact
104a97db4: aa1303e0    	mov	x0, x19
104a97db8: aa1603e1    	mov	x1, x22
104a97dbc: 94c63ce0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97dc0: aa1d03fd    	mov	x29, x29
104a97dc4: 94c63ce1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97dc8: aa0003f5    	mov	x21, x0
104a97dcc: b00d9d68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a97dd0: f9449917    	ldr	x23, [x8, #0x930] ; isEqualToName:
104a97dd4: f00cd042    	adrp	x2, 0x11e4a2000 <dyld_stub_binder+0x11e4a2000>
104a97dd8: 91162042    	add	x2, x2, #0x588 ; CFString 'brandsessionholder'
104a97ddc: aa1703e1    	mov	x1, x23
104a97de0: 94c63cd7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97de4: 34000d80    	cbz	w0, 0x104a97f94 <_Flutter_MMFoundation_BindContext+0xf73b78>
104a97de8: b00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a97dec: f941c100    	ldr	x0, [x8, #0x380] ; BrandTimelineMsgMgr
104a97df0: b00d9d68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a97df4: f9453d01    	ldr	x1, [x8, #0xa78] ; isBrandTimelineOpen
104a97df8: 94c63cd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97dfc: aa0003f8    	mov	x24, x0
104a97e00: aa1503e0    	mov	x0, x21
104a97e04: 94c63cd4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97e08: 34000cb8    	cbz	w24, 0x104a97f9c <_Flutter_MMFoundation_BindContext+0xf73b80>
104a97e0c: d00d9d68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a97e10: f944c501    	ldr	x1, [x8, #0x988] ; m_msgWrap
104a97e14: aa1303e0    	mov	x0, x19
104a97e18: 94c63cc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97e1c: aa1d03fd    	mov	x29, x29
104a97e20: 94c63cca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97e24: aa0003f5    	mov	x21, x0
104a97e28: d00db6f8    	adrp	x24, 0x120175000 <dyld_stub_binder+0x120175000>
104a97e2c: f9458f00    	ldr	x0, [x24, #0xb18] ; BrandNotificationMsgMgr
104a97e30: f00d9d68    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a97e34: f943ed01    	ldr	x1, [x8, #0x7d8] ; canHandleBrandAttributedNotifyMsg:
104a97e38: aa1503e2    	mov	x2, x21
104a97e3c: 94c63cc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97e40: 34000420    	cbz	w0, 0x104a97ec4 <_Flutter_MMFoundation_BindContext+0xf73aa8>
104a97e44: 900db6e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a97e48: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a97e4c: b00db348    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a97e50: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a97e54: 94c63cba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97e58: aa1d03fd    	mov	x29, x29
104a97e5c: 94c63cbb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97e60: aa0003f7    	mov	x23, x0
104a97e64: f9458f00    	ldr	x0, [x24, #0xb18] ; BrandNotificationMsgMgr
104a97e68: 900db348    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a97e6c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104a97e70: 94c63cb3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97e74: aa0003e2    	mov	x2, x0
104a97e78: d00d9d08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a97e7c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a97e80: aa1703e0    	mov	x0, x23
104a97e84: 94c63cae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97e88: aa1d03fd    	mov	x29, x29
104a97e8c: 94c63caf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97e90: aa0003f8    	mov	x24, x0
104a97e94: b00da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a97e98: f9447901    	ldr	x1, [x8, #0x8f0] ; genBrandAttributedNotifyMsgBoxDigest:
104a97e9c: aa1503e2    	mov	x2, x21
104a97ea0: 94c63ca7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97ea4: aa1d03fd    	mov	x29, x29
104a97ea8: 94c63ca8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97eac: aa0003f6    	mov	x22, x0
104a97eb0: aa1803e0    	mov	x0, x24
104a97eb4: 94c63ca8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97eb8: aa1703e0    	mov	x0, x23
104a97ebc: 94c63ca6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97ec0: 1400005b    	b	0x104a9802c <_Flutter_MMFoundation_BindContext+0xf73c10>
104a97ec4: b00d9e28    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
104a97ec8: f9477501    	ldr	x1, [x8, #0xee8] ; showBrandFusionSummary
104a97ecc: aa1503e0    	mov	x0, x21
104a97ed0: 94c63c9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97ed4: aa0003e8    	mov	x8, x0
104a97ed8: 900db718    	adrp	x24, 0x120177000 <dyld_stub_binder+0x120177000>
104a97edc: f942d300    	ldr	x0, [x24, #0x5a0] ; BrandTimelineResortDigestUtil
104a97ee0: 35000988    	cbnz	w8, 0x104a98010 <_Flutter_MMFoundation_BindContext+0xf73bf4>
104a97ee4: b00d9de8    	adrp	x8, 0x11fe54000 <dyld_stub_binder+0x11fe54000>
104a97ee8: f941a501    	ldr	x1, [x8, #0x348] ; shouldUseResortAttrDigest:
104a97eec: aa1503e2    	mov	x2, x21
104a97ef0: 94c63c93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97ef4: 34000500    	cbz	w0, 0x104a97f94 <_Flutter_MMFoundation_BindContext+0xf73b78>
104a97ef8: f942d316    	ldr	x22, [x24, #0x5a0] ; BrandTimelineResortDigestUtil
104a97efc: f00d9d68    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a97f00: f942dd17    	ldr	x23, [x8, #0x5b8] ; m_brandDigestInfo
104a97f04: aa1503e0    	mov	x0, x21
104a97f08: aa1703e1    	mov	x1, x23
104a97f0c: 94c63c8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97f10: aa1d03fd    	mov	x29, x29
104a97f14: 94c63c8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97f18: aa0003f8    	mov	x24, x0
104a97f1c: b00d9de8    	adrp	x8, 0x11fe54000 <dyld_stub_binder+0x11fe54000>
104a97f20: f941a901    	ldr	x1, [x8, #0x350] ; m_brandResortNewDigestJson
104a97f24: 94c63c86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97f28: aa1d03fd    	mov	x29, x29
104a97f2c: 94c63c87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97f30: aa0003f9    	mov	x25, x0
104a97f34: aa1503e0    	mov	x0, x21
104a97f38: aa1703e1    	mov	x1, x23
104a97f3c: 94c63c80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97f40: aa1d03fd    	mov	x29, x29
104a97f44: 94c63c81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97f48: aa0003f7    	mov	x23, x0
104a97f4c: f00d9d68    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
104a97f50: f942e101    	ldr	x1, [x8, #0x5c0] ; m_bIsBrandResortNewDigestBold
104a97f54: 94c63c7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97f58: aa0003e3    	mov	x3, x0
104a97f5c: b00d9de8    	adrp	x8, 0x11fe54000 <dyld_stub_binder+0x11fe54000>
104a97f60: f941ad01    	ldr	x1, [x8, #0x358] ; genAttrDigestWithBrandTimelineMsgDBDigestInfo:shouldBold:
104a97f64: aa1603e0    	mov	x0, x22
104a97f68: aa1903e2    	mov	x2, x25
104a97f6c: 94c63c74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97f70: aa1d03fd    	mov	x29, x29
104a97f74: 94c63c75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97f78: aa0003f6    	mov	x22, x0
104a97f7c: aa1703e0    	mov	x0, x23
104a97f80: 94c63c75    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97f84: aa1903e0    	mov	x0, x25
104a97f88: 94c63c73    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97f8c: aa1803e0    	mov	x0, x24
104a97f90: 17ffffcb    	b	0x104a97ebc <_Flutter_MMFoundation_BindContext+0xf73aa0>
104a97f94: aa1503e0    	mov	x0, x21
104a97f98: 94c63c6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97f9c: aa1303e0    	mov	x0, x19
104a97fa0: aa1603e1    	mov	x1, x22
104a97fa4: 94c63c66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97fa8: aa1d03fd    	mov	x29, x29
104a97fac: 94c63c67    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a97fb0: aa0003f5    	mov	x21, x0
104a97fb4: f00cd042    	adrp	x2, 0x11e4a2000 <dyld_stub_binder+0x11e4a2000>
104a97fb8: 9100a042    	add	x2, x2, #0x28 ; CFString 'brandservicesessionholder'
104a97fbc: aa1703e1    	mov	x1, x23
104a97fc0: 94c63c5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97fc4: 340003a0    	cbz	w0, 0x104a98038 <_Flutter_MMFoundation_BindContext+0xf73c1c>
104a97fc8: b00db6e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a97fcc: f9419d00    	ldr	x0, [x8, #0x338] ; BSTimelineMsgMgr
104a97fd0: b00d9d68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a97fd4: f9453d01    	ldr	x1, [x8, #0xa78] ; isBrandTimelineOpen
104a97fd8: 94c63c59    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97fdc: aa0003f6    	mov	x22, x0
104a97fe0: aa1503e0    	mov	x0, x21
104a97fe4: 94c63c5c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a97fe8: 340002d6    	cbz	w22, 0x104a98040 <_Flutter_MMFoundation_BindContext+0xf73c24>
104a97fec: d00d9d68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a97ff0: f944c501    	ldr	x1, [x8, #0x988] ; m_msgWrap
104a97ff4: aa1303e0    	mov	x0, x19
104a97ff8: 94c63c51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a97ffc: aa1d03fd    	mov	x29, x29
104a98000: 94c63c52    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a98004: aa0003f5    	mov	x21, x0
104a98008: b00db6e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104a9800c: f943d100    	ldr	x0, [x8, #0x7a0] ; BrandServiceDigestUtil
104a98010: 900da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a98014: f9447d01    	ldr	x1, [x8, #0x8f8] ; genFusionDigestInfo:
104a98018: aa1503e2    	mov	x2, x21
104a9801c: 94c63c48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a98020: aa1d03fd    	mov	x29, x29
104a98024: 94c63c49    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a98028: aa0003f6    	mov	x22, x0
104a9802c: aa1503e0    	mov	x0, x21
104a98030: 94c63c49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a98034: 14000004    	b	0x104a98044 <_Flutter_MMFoundation_BindContext+0xf73c28>
104a98038: aa1503e0    	mov	x0, x21
104a9803c: 94c63c46    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a98040: d2800016    	mov	x22, #0x0               ; =0
104a98044: aa1403e0    	mov	x0, x20
104a98048: 94c63c43    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a9804c: aa1303e0    	mov	x0, x19
104a98050: 94c63c41    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a98054: aa1603e0    	mov	x0, x22
104a98058: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a9805c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a98060: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a98064: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a98068: a8c567fa    	ldp	x26, x25, [sp], #0x50
104a9806c: 14c63c41    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
