
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1000c6d34: d10203ff    	sub	sp, sp, #0x80
1000c6d38: a9026ffc    	stp	x28, x27, [sp, #0x20]
1000c6d3c: a90367fa    	stp	x26, x25, [sp, #0x30]
1000c6d40: a9045ff8    	stp	x24, x23, [sp, #0x40]
1000c6d44: a90557f6    	stp	x22, x21, [sp, #0x50]
1000c6d48: a9064ff4    	stp	x20, x19, [sp, #0x60]
1000c6d4c: a9077bfd    	stp	x29, x30, [sp, #0x70]
1000c6d50: 9101c3fd    	add	x29, sp, #0x70
1000c6d54: aa0003f4    	mov	x20, x0
1000c6d58: f0105b28    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1000c6d5c: 52800029    	mov	w9, #0x1                ; =1
1000c6d60: 39146109    	strb	w9, [x8, #0x518]
1000c6d64: d0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c6d68: f9452113    	ldr	x19, [x8, #0xa40] ; �o- 
1000c6d6c: 900febc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000c6d70: f9410915    	ldr	x21, [x8, #0x210] ; viewModel
1000c6d74: aa1503e1    	mov	x1, x21
1000c6d78: 95ed80f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6d7c: aa1d03fd    	mov	x29, x29
1000c6d80: 95ed80f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6d84: aa0003f6    	mov	x22, x0
1000c6d88: 900febc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000c6d8c: f9410517    	ldr	x23, [x8, #0x208] ; messageWrap
1000c6d90: aa1703e1    	mov	x1, x23
1000c6d94: 95ed80ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6d98: aa1d03fd    	mov	x29, x29
1000c6d9c: 95ed80eb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6da0: aa0003f8    	mov	x24, x0
1000c6da4: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6da8: f940ad01    	ldr	x1, [x8, #0x158] ; ReportEmoticonAction:scene:messageWrap:
1000c6dac: aa1303e0    	mov	x0, x19
1000c6db0: d2800002    	mov	x2, #0x0                ; =0
1000c6db4: d2800003    	mov	x3, #0x0                ; =0
1000c6db8: aa1803e4    	mov	x4, x24
1000c6dbc: 95ed80e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6dc0: aa1803e0    	mov	x0, x24
1000c6dc4: 95ed80e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6dc8: aa1603e0    	mov	x0, x22
1000c6dcc: 95ed80e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6dd0: b0100568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1000c6dd4: f9455500    	ldr	x0, [x8, #0xaa8]
1000c6dd8: b01001c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1000c6ddc: f941a101    	ldr	x1, [x8, #0x340] ; array
1000c6de0: 95ed80d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6de4: aa1d03fd    	mov	x29, x29
1000c6de8: 95ed80d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6dec: aa0003fa    	mov	x26, x0
1000c6df0: aa1403e0    	mov	x0, x20
1000c6df4: aa1503e1    	mov	x1, x21
1000c6df8: 95ed80d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6dfc: aa1d03fd    	mov	x29, x29
1000c6e00: 95ed80d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6e04: aa0003f8    	mov	x24, x0
1000c6e08: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6e0c: f9405d1b    	ldr	x27, [x8, #0xb8] ; isDownloaded
1000c6e10: aa1b03e1    	mov	x1, x27
1000c6e14: 95ed80ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6e18: aa0003f9    	mov	x25, x0
1000c6e1c: aa1803e0    	mov	x0, x24
1000c6e20: 95ed80cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6e24: 900febb8    	adrp	x24, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1000c6e28: 34000cf9    	cbz	w25, 0x1000c6fc4 <__text+0xbefc4>
1000c6e2c: b0100568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1000c6e30: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1000c6e34: d01001c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1000c6e38: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1000c6e3c: 95ed80c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6e40: aa1d03fd    	mov	x29, x29
1000c6e44: 95ed80c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6e48: aa0003f3    	mov	x19, x0
1000c6e4c: f90007e0    	str	x0, [sp, #0x8]
1000c6e50: d0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c6e54: f9452500    	ldr	x0, [x8, #0xa48] ; �d- 
1000c6e58: b01001c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1000c6e5c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1000c6e60: 95ed80b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6e64: aa0003e2    	mov	x2, x0
1000c6e68: f00feb88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1000c6e6c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1000c6e70: aa1303e0    	mov	x0, x19
1000c6e74: 95ed80b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6e78: aa1d03fd    	mov	x29, x29
1000c6e7c: 95ed80b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6e80: aa0003f9    	mov	x25, x0
1000c6e84: aa1403e0    	mov	x0, x20
1000c6e88: aa1503e1    	mov	x1, x21
1000c6e8c: 95ed80ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6e90: aa1d03fd    	mov	x29, x29
1000c6e94: 95ed80ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6e98: f9000ffa    	str	x26, [sp, #0x18]
1000c6e9c: aa0003fa    	mov	x26, x0
1000c6ea0: aa1703e1    	mov	x1, x23
1000c6ea4: 95ed80a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6ea8: aa1d03fd    	mov	x29, x29
1000c6eac: 95ed80a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6eb0: f9000bfb    	str	x27, [sp, #0x10]
1000c6eb4: aa0003fb    	mov	x27, x0
1000c6eb8: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6ebc: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
1000c6ec0: 95ed809f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6ec4: aa1d03fd    	mov	x29, x29
1000c6ec8: 95ed80a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6ecc: aa0003fc    	mov	x28, x0
1000c6ed0: aa1403e0    	mov	x0, x20
1000c6ed4: aa1503e1    	mov	x1, x21
1000c6ed8: 95ed8099    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6edc: aa1d03fd    	mov	x29, x29
1000c6ee0: 95ed809a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6ee4: aa0003f8    	mov	x24, x0
1000c6ee8: aa1703e1    	mov	x1, x23
1000c6eec: 95ed8094    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6ef0: aa1d03fd    	mov	x29, x29
1000c6ef4: 95ed8095    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6ef8: aa0003f7    	mov	x23, x0
1000c6efc: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6f00: f940b501    	ldr	x1, [x8, #0x168] ; m_nsEmoticonBelongToProductID
1000c6f04: 95ed808e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6f08: aa1d03fd    	mov	x29, x29
1000c6f0c: 95ed808f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6f10: aa0003f3    	mov	x19, x0
1000c6f14: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6f18: f940b901    	ldr	x1, [x8, #0x170] ; checkEmoticonCanAddStrictWay:Md5:pid:
1000c6f1c: aa1903e0    	mov	x0, x25
1000c6f20: 52800002    	mov	w2, #0x0                ; =0
1000c6f24: aa1c03e3    	mov	x3, x28
1000c6f28: aa1303e4    	mov	x4, x19
1000c6f2c: 95ed8084    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6f30: aa0003f6    	mov	x22, x0
1000c6f34: aa1303e0    	mov	x0, x19
1000c6f38: 95ed8087    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f3c: aa1703e0    	mov	x0, x23
1000c6f40: 95ed8085    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f44: aa1803e0    	mov	x0, x24
1000c6f48: 900febb8    	adrp	x24, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1000c6f4c: 95ed8082    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f50: aa1c03e0    	mov	x0, x28
1000c6f54: 95ed8080    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f58: aa1b03e0    	mov	x0, x27
1000c6f5c: f9400bfb    	ldr	x27, [sp, #0x10]
1000c6f60: 95ed807d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f64: aa1a03e0    	mov	x0, x26
1000c6f68: f9400ffa    	ldr	x26, [sp, #0x18]
1000c6f6c: 95ed807a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f70: aa1903e0    	mov	x0, x25
1000c6f74: 95ed8078    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f78: f94007e0    	ldr	x0, [sp, #0x8]
1000c6f7c: 95ed8076    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6f80: 34000236    	cbz	w22, 0x1000c6fc4 <__text+0xbefc4>
1000c6f84: d0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c6f88: f9452900    	ldr	x0, [x8, #0xa50]
1000c6f8c: 95ed8075    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1000c6f90: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6f94: f940bd03    	ldr	x3, [x8, #0x178] ; onSaveEmoticon:
1000c6f98: b00febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c6f9c: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
1000c6fa0: 52800162    	mov	w2, #0xb                ; =11
1000c6fa4: 95ed8066    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6fa8: aa0003f3    	mov	x19, x0
1000c6fac: f943c701    	ldr	x1, [x24, #0x788] ; safeAddObject:
1000c6fb0: aa1a03e0    	mov	x0, x26
1000c6fb4: aa1303e2    	mov	x2, x19
1000c6fb8: 95ed8061    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6fbc: aa1303e0    	mov	x0, x19
1000c6fc0: 95ed8065    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6fc4: 900febc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000c6fc8: f9415101    	ldr	x1, [x8, #0x2a0] ; forwardMenuItem
1000c6fcc: aa1403e0    	mov	x0, x20
1000c6fd0: 95ed805b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6fd4: aa1d03fd    	mov	x29, x29
1000c6fd8: 95ed805c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c6fdc: aa0003f3    	mov	x19, x0
1000c6fe0: f943c717    	ldr	x23, [x24, #0x788] ; safeAddObject:
1000c6fe4: aa1a03e0    	mov	x0, x26
1000c6fe8: aa1703e1    	mov	x1, x23
1000c6fec: aa1303e2    	mov	x2, x19
1000c6ff0: 95ed8053    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c6ff4: aa1303e0    	mov	x0, x19
1000c6ff8: 95ed8057    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c6ffc: aa1403e0    	mov	x0, x20
1000c7000: aa1503e1    	mov	x1, x21
1000c7004: 95ed804e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7008: aa1d03fd    	mov	x29, x29
1000c700c: 95ed804f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c7010: aa0003f8    	mov	x24, x0
1000c7014: aa1b03e1    	mov	x1, x27
1000c7018: 95ed8049    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c701c: 34000300    	cbz	w0, 0x1000c707c <__text+0xbf07c>
1000c7020: b0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c7024: f9452d00    	ldr	x0, [x8, #0xa58] ; ��- 
1000c7028: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c702c: f940c501    	ldr	x1, [x8, #0x188] ; isEmoticonAllow
1000c7030: 95ed8043    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7034: aa0003f3    	mov	x19, x0
1000c7038: aa1803e0    	mov	x0, x24
1000c703c: 95ed8046    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c7040: 34000233    	cbz	w19, 0x1000c7084 <__text+0xbf084>
1000c7044: b0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c7048: f9452900    	ldr	x0, [x8, #0xa50]
1000c704c: 95ed8045    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1000c7050: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c7054: f940c903    	ldr	x3, [x8, #0x190] ; onShowRelatedEmoticon:
1000c7058: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c705c: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
1000c7060: 52800182    	mov	w2, #0xc                ; =12
1000c7064: 95ed8036    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7068: aa0003f8    	mov	x24, x0
1000c706c: aa1a03e0    	mov	x0, x26
1000c7070: aa1703e1    	mov	x1, x23
1000c7074: aa1803e2    	mov	x2, x24
1000c7078: 95ed8031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c707c: aa1803e0    	mov	x0, x24
1000c7080: 95ed8035    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c7084: f00feba8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000c7088: f9415501    	ldr	x1, [x8, #0x2a8] ; addRevokeOrDeleteMenuItem:
1000c708c: aa1403e0    	mov	x0, x20
1000c7090: aa1a03e2    	mov	x2, x26
1000c7094: 95ed802a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7098: aa1403e0    	mov	x0, x20
1000c709c: aa1503e1    	mov	x1, x21
1000c70a0: 95ed8027    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c70a4: aa1d03fd    	mov	x29, x29
1000c70a8: 95ed8028    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000c70ac: aa0003f3    	mov	x19, x0
1000c70b0: aa1b03e1    	mov	x1, x27
1000c70b4: 95ed8022    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c70b8: aa0003f4    	mov	x20, x0
1000c70bc: aa1303e0    	mov	x0, x19
1000c70c0: 95ed8025    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c70c4: 340002f4    	cbz	w20, 0x1000c7120 <__text+0xbf120>
1000c70c8: b0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c70cc: f9451900    	ldr	x0, [x8, #0xa30] ; �;- 
1000c70d0: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c70d4: f940cd01    	ldr	x1, [x8, #0x198] ; shouldShowEmoticonCameraFollow
1000c70d8: 95ed8019    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c70dc: 34000220    	cbz	w0, 0x1000c7120 <__text+0xbf120>
1000c70e0: b0100568    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1000c70e4: f9452900    	ldr	x0, [x8, #0xa50]
1000c70e8: 95ed801e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1000c70ec: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c70f0: f940d103    	ldr	x3, [x8, #0x1a0] ; onTakeCameraFollow:
1000c70f4: 900febc8    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000c70f8: f940c101    	ldr	x1, [x8, #0x180] ; initWithType:action:
1000c70fc: 528001a2    	mov	w2, #0xd                ; =13
1000c7100: 95ed800f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7104: aa0003f3    	mov	x19, x0
1000c7108: aa1a03e0    	mov	x0, x26
1000c710c: aa1703e1    	mov	x1, x23
1000c7110: aa1303e2    	mov	x2, x19
1000c7114: 95ed800a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000c7118: aa1303e0    	mov	x0, x19
1000c711c: 95ed800e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000c7120: aa1a03e0    	mov	x0, x26
1000c7124: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1000c7128: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1000c712c: a94557f6    	ldp	x22, x21, [sp, #0x50]
1000c7130: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1000c7134: a94367fa    	ldp	x26, x25, [sp, #0x30]
1000c7138: a9426ffc    	ldp	x28, x27, [sp, #0x20]
1000c713c: 910203ff    	add	sp, sp, #0x80
1000c7140: 15ed800c    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>