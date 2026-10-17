
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b35dc4: d10483ff    	sub	sp, sp, #0x120
104b35dc8: a90c6ffc    	stp	x28, x27, [sp, #0xc0]
104b35dcc: a90d67fa    	stp	x26, x25, [sp, #0xd0]
104b35dd0: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
104b35dd4: a90f57f6    	stp	x22, x21, [sp, #0xf0]
104b35dd8: a9104ff4    	stp	x20, x19, [sp, #0x100]
104b35ddc: a9117bfd    	stp	x29, x30, [sp, #0x110]
104b35de0: 910443fd    	add	x29, sp, #0x110
104b35de4: aa0503f8    	mov	x24, x5
104b35de8: aa0403f5    	mov	x21, x4
104b35dec: aa0303fc    	mov	x28, x3
104b35df0: aa0203f9    	mov	x25, x2
104b35df4: aa0003fa    	mov	x26, x0
104b35df8: b00e0848    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b35dfc: 52800029    	mov	w9, #0x1                ; =1
104b35e00: 39158909    	strb	w9, [x8, #0x562]
104b35e04: aa0203e0    	mov	x0, x2
104b35e08: 94c3c4cc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35e0c: aa1c03e0    	mov	x0, x28
104b35e10: 94c3c4ca    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35e14: aa1503e0    	mov	x0, x21
104b35e18: 94c3c4c8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35e1c: aa1c03e0    	mov	x0, x28
104b35e20: 94c3c4c6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35e24: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35e28: f9433913    	ldr	x19, [x8, #0x670] ; m_nsSpecifiedChatName
104b35e2c: aa1503e0    	mov	x0, x21
104b35e30: aa1303e1    	mov	x1, x19
104b35e34: 94c3c4c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35e38: aa1d03fd    	mov	x29, x29
104b35e3c: 94c3c4c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35e40: aa0003f6    	mov	x22, x0
104b35e44: d00dae68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b35e48: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104b35e4c: f81903a1    	stur	x1, [x29, #-0x70]
104b35e50: 94c3c4bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35e54: aa0003f7    	mov	x23, x0
104b35e58: aa1603e0    	mov	x0, x22
104b35e5c: 94c3c4be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35e60: f81983bc    	stur	x28, [x29, #-0x68]
104b35e64: b4000137    	cbz	x23, 0x104b35e88 <_Flutter_MMFoundation_BindContext+0x1011a6c>
104b35e68: aa1503e0    	mov	x0, x21
104b35e6c: aa1303e1    	mov	x1, x19
104b35e70: 94c3c4b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35e74: aa1d03fd    	mov	x29, x29
104b35e78: 94c3c4b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35e7c: aa0003fc    	mov	x28, x0
104b35e80: f85983a0    	ldur	x0, [x29, #-0x68]
104b35e84: 94c3c4b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35e88: f00db1e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b35e8c: f9451500    	ldr	x0, [x8, #0xa28]
104b35e90: b00daea8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b35e94: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b35e98: 94c3c4a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35e9c: aa1d03fd    	mov	x29, x29
104b35ea0: 94c3c4aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35ea4: aa0003f7    	mov	x23, x0
104b35ea8: f00db1c8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b35eac: f9464513    	ldr	x19, [x8, #0xc88]
104b35eb0: d00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b35eb4: f9454500    	ldr	x0, [x8, #0xa88]
104b35eb8: b00daea8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b35ebc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104b35ec0: f90003f8    	str	x24, [sp]
104b35ec4: b00ccc42    	adrp	x2, 0x11e4be000 <dyld_stub_binder+0x11e4be000>
104b35ec8: 91232042    	add	x2, x2, #0x8c8
104b35ecc: f81883a1    	stur	x1, [x29, #-0x78]
104b35ed0: 94c3c49b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35ed4: aa1d03fd    	mov	x29, x29
104b35ed8: 94c3c49c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35edc: aa0003fb    	mov	x27, x0
104b35ee0: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35ee4: f947a101    	ldr	x1, [x8, #0xf40] ; getClsMethodKeyObserver:withKey:
104b35ee8: aa1703e0    	mov	x0, x23
104b35eec: aa1303e2    	mov	x2, x19
104b35ef0: aa1b03e3    	mov	x3, x27
104b35ef4: 94c3c492    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35ef8: aa0003f3    	mov	x19, x0
104b35efc: aa1b03e0    	mov	x0, x27
104b35f00: 94c3c495    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35f04: aa1703e0    	mov	x0, x23
104b35f08: 94c3c493    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35f0c: d00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b35f10: f947a517    	ldr	x23, [x8, #0xf48] ; CreateVideoMsg:ToUsr:VideoInfo:MsgType:retMessageWrap:
104b35f14: aa1303e0    	mov	x0, x19
104b35f18: aa1703e1    	mov	x1, x23
104b35f1c: 94c3c59f    	bl	0x107c27598 <_Flutter_MMFoundation_BindContext+0x410317c>
104b35f20: d00db1fb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
104b35f24: 900d9836    	adrp	x22, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b35f28: b4003500    	cbz	x0, 0x104b365c8 <_Flutter_MMFoundation_BindContext+0x10121ac>
104b35f2c: f81a03bf    	stur	xzr, [x29, #-0x60]
104b35f30: d10183a6    	sub	x6, x29, #0x60
104b35f34: aa1303e0    	mov	x0, x19
104b35f38: aa1703e1    	mov	x1, x23
104b35f3c: aa1903e2    	mov	x2, x25
104b35f40: f85983a3    	ldur	x3, [x29, #-0x68]
104b35f44: aa1503e4    	mov	x4, x21
104b35f48: aa1803e5    	mov	x5, x24
104b35f4c: 94c3c47c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35f50: f85a03b8    	ldur	x24, [x29, #-0x60]
104b35f54: aa1803e0    	mov	x0, x24
104b35f58: 94c3c478    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b35f5c: b4003378    	cbz	x24, 0x104b365c8 <_Flutter_MMFoundation_BindContext+0x10121ac>
104b35f60: 900d9888    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104b35f64: f942b101    	ldr	x1, [x8, #0x560] ; m_nsAppId
104b35f68: aa1503e0    	mov	x0, x21
104b35f6c: 94c3c474    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35f70: aa1d03fd    	mov	x29, x29
104b35f74: 94c3c475    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35f78: aa0003f3    	mov	x19, x0
104b35f7c: b00d9908    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104b35f80: f947fd01    	ldr	x1, [x8, #0xff8] ; setM_nsAppID:
104b35f84: aa1803e0    	mov	x0, x24
104b35f88: aa1303e2    	mov	x2, x19
104b35f8c: 94c3c46c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35f90: aa1303e0    	mov	x0, x19
104b35f94: 94c3c470    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35f98: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35f9c: f944cd01    	ldr	x1, [x8, #0x998] ; m_nsMessageAction
104b35fa0: aa1503e0    	mov	x0, x21
104b35fa4: 94c3c466    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35fa8: aa1d03fd    	mov	x29, x29
104b35fac: 94c3c467    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35fb0: aa0003f3    	mov	x19, x0
104b35fb4: 900d9c48    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b35fb8: f942bd01    	ldr	x1, [x8, #0x578] ; setM_nsAppMessageAction:
104b35fbc: aa1803e0    	mov	x0, x24
104b35fc0: aa1303e2    	mov	x2, x19
104b35fc4: 94c3c45e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35fc8: aa1303e0    	mov	x0, x19
104b35fcc: 94c3c462    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b35fd0: b00da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b35fd4: f944d101    	ldr	x1, [x8, #0x9a0] ; m_nsMessageExt
104b35fd8: aa1503e0    	mov	x0, x21
104b35fdc: 94c3c458    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b35fe0: aa1d03fd    	mov	x29, x29
104b35fe4: 94c3c459    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b35fe8: aa0003f3    	mov	x19, x0
104b35fec: 900d9c48    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b35ff0: f942b901    	ldr	x1, [x8, #0x570] ; setM_nsAppMessageExt:
104b35ff4: aa1803e0    	mov	x0, x24
104b35ff8: aa1303e2    	mov	x2, x19
104b35ffc: 94c3c450    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36000: aa1303e0    	mov	x0, x19
104b36004: 94c3c454    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36008: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3600c: f944d501    	ldr	x1, [x8, #0x9a8] ; m_nsMediaTagName
104b36010: aa1503e0    	mov	x0, x21
104b36014: 94c3c44a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36018: aa1d03fd    	mov	x29, x29
104b3601c: 94c3c44b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36020: aa0003f3    	mov	x19, x0
104b36024: f00d9c28    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b36028: f942b501    	ldr	x1, [x8, #0x568] ; setM_nsAppMediaTagName:
104b3602c: aa1803e0    	mov	x0, x24
104b36030: aa1303e2    	mov	x2, x19
104b36034: 94c3c442    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36038: aa1303e0    	mov	x0, x19
104b3603c: 94c3c446    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36040: b00d9848    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b36044: f9416101    	ldr	x1, [x8, #0x2c0] ; m_sourceWeappInfo
104b36048: aa1503e0    	mov	x0, x21
104b3604c: 94c3c43c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36050: aa1d03fd    	mov	x29, x29
104b36054: 94c3c43d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36058: aa0003f3    	mov	x19, x0
104b3605c: f00d9c28    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b36060: f941b101    	ldr	x1, [x8, #0x360] ; setM_sourceWeappInfo:
104b36064: aa1803e0    	mov	x0, x24
104b36068: aa1303e2    	mov	x2, x19
104b3606c: 94c3c434    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36070: aa1303e0    	mov	x0, x19
104b36074: 94c3c438    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36078: 900d98a8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b3607c: f947fd01    	ldr	x1, [x8, #0xff8] ; m_weappSourceUsername
104b36080: aa1503e0    	mov	x0, x21
104b36084: 94c3c42e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36088: aa1d03fd    	mov	x29, x29
104b3608c: 94c3c42f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36090: aa0003f3    	mov	x19, x0
104b36094: f00d9c28    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
104b36098: f941b501    	ldr	x1, [x8, #0x368] ; setM_weappSourceUsername:
104b3609c: aa1803e0    	mov	x0, x24
104b360a0: aa1303e2    	mov	x2, x19
104b360a4: 94c3c426    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b360a8: aa1303e0    	mov	x0, x19
104b360ac: 94c3c42a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b360b0: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b360b4: f947fd01    	ldr	x1, [x8, #0xff8] ; cameraEnterSessionID
104b360b8: aa1503e0    	mov	x0, x21
104b360bc: 94c3c420    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b360c0: aa0003e2    	mov	x2, x0
104b360c4: d00d98a8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
104b360c8: f9400101    	ldr	x1, [x8]
104b360cc: aa1803e0    	mov	x0, x24
104b360d0: 94c3c41b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b360d4: 900d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b360d8: f944d113    	ldr	x19, [x8, #0x9a0] ; m_nsAttachFileKey
104b360dc: aa1503e0    	mov	x0, x21
104b360e0: aa1303e1    	mov	x1, x19
104b360e4: 94c3c416    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b360e8: aa1d03fd    	mov	x29, x29
104b360ec: 94c3c417    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b360f0: aa0003f7    	mov	x23, x0
104b360f4: f85903a1    	ldur	x1, [x29, #-0x70]
104b360f8: 94c3c411    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b360fc: aa0003fb    	mov	x27, x0
104b36100: aa1703e0    	mov	x0, x23
104b36104: 94c3c414    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36108: b40004bb    	cbz	x27, 0x104b3619c <_Flutter_MMFoundation_BindContext+0x1011d80>
104b3610c: aa1503e0    	mov	x0, x21
104b36110: aa1303e1    	mov	x1, x19
104b36114: 94c3c40a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36118: aa1d03fd    	mov	x29, x29
104b3611c: 94c3c40b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36120: aa0003f3    	mov	x19, x0
104b36124: d00d9be8    	adrp	x8, 0x11feb4000 <dyld_stub_binder+0x11feb4000>
104b36128: f9474d01    	ldr	x1, [x8, #0xe98] ; setM_nsAttachFileKey:
104b3612c: aa1803e0    	mov	x0, x24
104b36130: aa1303e2    	mov	x2, x19
104b36134: 94c3c402    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36138: aa1303e0    	mov	x0, x19
104b3613c: 94c3c406    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36140: d00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b36144: f945a901    	ldr	x1, [x8, #0xb50] ; m_nsAesKey
104b36148: aa1503e0    	mov	x0, x21
104b3614c: 94c3c3fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36150: aa1d03fd    	mov	x29, x29
104b36154: 94c3c3fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36158: aa0003f3    	mov	x19, x0
104b3615c: f00d9968    	adrp	x8, 0x11fe65000 <dyld_stub_binder+0x11fe65000>
104b36160: f9410901    	ldr	x1, [x8, #0x210] ; setM_nsAesKey:
104b36164: aa1803e0    	mov	x0, x24
104b36168: aa1303e2    	mov	x2, x19
104b3616c: 94c3c3f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36170: aa1303e0    	mov	x0, x19
104b36174: 94c3c3f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36178: 900d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b3617c: f944d501    	ldr	x1, [x8, #0x9a8] ; m_uiContinueUploadCount
104b36180: aa1503e0    	mov	x0, x21
104b36184: 94c3c3ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36188: aa0003e2    	mov	x2, x0
104b3618c: 900d9cc8    	adrp	x8, 0x11fece000 <dyld_stub_binder+0x11fece000>
104b36190: f941b101    	ldr	x1, [x8, #0x360] ; setM_uiContinueUploadCount:
104b36194: aa1803e0    	mov	x0, x24
104b36198: 94c3c3e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3619c: b00dae48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b361a0: f941e901    	ldr	x1, [x8, #0x3d0] ; asset
104b361a4: aa1503e0    	mov	x0, x21
104b361a8: 94c3c3e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b361ac: aa1d03fd    	mov	x29, x29
104b361b0: 94c3c3e6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b361b4: aa0003f3    	mov	x19, x0
104b361b8: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b361bc: f941c11b    	ldr	x27, [x8, #0x380] ; groupInfo
104b361c0: aa1b03e1    	mov	x1, x27
104b361c4: 94c3c3de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b361c8: aa1d03fd    	mov	x29, x29
104b361cc: 94c3c3df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b361d0: aa0003f7    	mov	x23, x0
104b361d4: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b361d8: f941c501    	ldr	x1, [x8, #0x388] ; setGroupInfo:
104b361dc: aa1803e0    	mov	x0, x24
104b361e0: aa1703e2    	mov	x2, x23
104b361e4: 94c3c3d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b361e8: aa1703e0    	mov	x0, x23
104b361ec: 94c3c3da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b361f0: aa1303e0    	mov	x0, x19
104b361f4: 94c3c3d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b361f8: aa1803e0    	mov	x0, x24
104b361fc: aa1b03e1    	mov	x1, x27
104b36200: 94c3c3cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36204: aa1d03fd    	mov	x29, x29
104b36208: 94c3c3d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3620c: aa0003f3    	mov	x19, x0
104b36210: 94c3c3d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36214: f81803b9    	stur	x25, [x29, #-0x80]
104b36218: f90047fc    	str	x28, [sp, #0x88]
104b3621c: b4000c73    	cbz	x19, 0x104b363a8 <_Flutter_MMFoundation_BindContext+0x1011f8c>
104b36220: aa1803e0    	mov	x0, x24
104b36224: aa1b03e1    	mov	x1, x27
104b36228: 94c3c3c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3622c: aa1d03fd    	mov	x29, x29
104b36230: 94c3c3c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36234: aa0003f3    	mov	x19, x0
104b36238: d00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b3623c: f943811c    	ldr	x28, [x8, #0x700] ; createTime
104b36240: aa1c03e1    	mov	x1, x28
104b36244: 94c3c3be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36248: aa0003e2    	mov	x2, x0
104b3624c: d00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b36250: f9454901    	ldr	x1, [x8, #0xa90] ; setM_uiCreateTime:
104b36254: aa1803e0    	mov	x0, x24
104b36258: 94c3c3b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3625c: aa1303e0    	mov	x0, x19
104b36260: 94c3c3bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36264: aa1803e0    	mov	x0, x24
104b36268: aa1b03e1    	mov	x1, x27
104b3626c: 94c3c3b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36270: aa1d03fd    	mov	x29, x29
104b36274: 94c3c3b5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36278: aa0003f3    	mov	x19, x0
104b3627c: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36280: f941c901    	ldr	x1, [x8, #0x390] ; sequence
104b36284: 94c3c3ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36288: aa0003e2    	mov	x2, x0
104b3628c: f00d9888    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
104b36290: f9467501    	ldr	x1, [x8, #0xce8] ; setM_sequenceId:
104b36294: aa1803e0    	mov	x0, x24
104b36298: 94c3c3a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3629c: aa1303e0    	mov	x0, x19
104b362a0: 94c3c3ad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b362a4: b00d9848    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b362a8: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b362ac: aa1803e0    	mov	x0, x24
104b362b0: d2800002    	mov	x2, #0x0                ; =0
104b362b4: 94c3c3a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b362b8: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b362bc: f9453519    	ldr	x25, [x8, #0xa68]
104b362c0: aa1803e0    	mov	x0, x24
104b362c4: aa1b03e1    	mov	x1, x27
104b362c8: 94c3c39d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b362cc: aa1d03fd    	mov	x29, x29
104b362d0: 94c3c39e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b362d4: aa0003f7    	mov	x23, x0
104b362d8: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b362dc: f941cd01    	ldr	x1, [x8, #0x398] ; groupId
104b362e0: 94c3c397    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b362e4: aa1d03fd    	mov	x29, x29
104b362e8: 94c3c398    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b362ec: aa0003f3    	mov	x19, x0
104b362f0: aa1803e0    	mov	x0, x24
104b362f4: aa1b03e1    	mov	x1, x27
104b362f8: 94c3c391    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b362fc: aa1d03fd    	mov	x29, x29
104b36300: 94c3c392    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36304: aa1a03f4    	mov	x20, x26
104b36308: aa0003fa    	mov	x26, x0
104b3630c: d00dae48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b36310: f9435101    	ldr	x1, [x8, #0x6a0] ; count
104b36314: 94c3c38a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36318: aa0003f6    	mov	x22, x0
104b3631c: aa1803e0    	mov	x0, x24
104b36320: aa1b03e1    	mov	x1, x27
104b36324: 94c3c386    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36328: aa1d03fd    	mov	x29, x29
104b3632c: 94c3c387    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36330: aa0003fb    	mov	x27, x0
104b36334: aa1c03e1    	mov	x1, x28
104b36338: f94047fc    	ldr	x28, [sp, #0x88]
104b3633c: 94c3c380    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36340: f00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b36344: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b36348: a90103f6    	stp	x22, x0, [sp, #0x10]
104b3634c: d00ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b36350: 91332108    	add	x8, x8, #0xcc8
104b36354: a9004fe8    	stp	x8, x19, [sp]
104b36358: d00b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3635c: 910cb4a5    	add	x5, x5, #0x32d
104b36360: f00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b36364: 9127bce7    	add	x7, x7, #0x9ef
104b36368: aa1903e0    	mov	x0, x25
104b3636c: f85803b9    	ldur	x25, [x29, #-0x80]
104b36370: 52800042    	mov	w2, #0x2                ; =2
104b36374: d2800003    	mov	x3, #0x0                ; =0
104b36378: 52800004    	mov	w4, #0x0                ; =0
104b3637c: 52815946    	mov	w6, #0xaca              ; =2762
104b36380: 94c3c36f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36384: aa1b03e0    	mov	x0, x27
104b36388: 94c3c373    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3638c: aa1a03e0    	mov	x0, x26
104b36390: aa1403fa    	mov	x26, x20
104b36394: 94c3c370    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36398: aa1303e0    	mov	x0, x19
104b3639c: 94c3c36e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b363a0: aa1703e0    	mov	x0, x23
104b363a4: 94c3c36c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b363a8: b00db768    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b363ac: b9895508    	ldrsw	x8, [x8, #0x954]
104b363b0: f8686b40    	ldr	x0, [x26, x8]
104b363b4: b00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b363b8: f945a501    	ldr	x1, [x8, #0xb48] ; AddMsg:MsgWrap:
104b363bc: aa1c03e2    	mov	x2, x28
104b363c0: aa1803e3    	mov	x3, x24
104b363c4: 94c3c35e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b363c8: d00d9bc8    	adrp	x8, 0x11feb0000 <dyld_stub_binder+0x11feb0000>
104b363cc: f942e901    	ldr	x1, [x8, #0x5d0] ; m_statInfo
104b363d0: aa1503e0    	mov	x0, x21
104b363d4: f9002be1    	str	x1, [sp, #0x50]
104b363d8: 94c3c359    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b363dc: aa1d03fd    	mov	x29, x29
104b363e0: 94c3c35a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b363e4: aa0003f3    	mov	x19, x0
104b363e8: d00d98c8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
104b363ec: f9441501    	ldr	x1, [x8, #0x828] ; sendScene
104b363f0: f90027e1    	str	x1, [sp, #0x48]
104b363f4: 94c3c352    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b363f8: aa0003f6    	mov	x22, x0
104b363fc: aa1303e0    	mov	x0, x19
104b36400: 94c3c355    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36404: 510006c8    	sub	w8, w22, #0x1
104b36408: 7100051f    	cmp	w8, #0x1
104b3640c: 540002e8    	b.hi	0x104b36468 <_Flutter_MMFoundation_BindContext+0x101204c>
104b36410: f00db1f6    	adrp	x22, 0x120175000 <dyld_stub_binder+0x120175000>
104b36414: f9429ac0    	ldr	x0, [x22, #0x530] ; 0Q6 
104b36418: b00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3641c: f9456901    	ldr	x1, [x8, #0xad0] ; getReplyMsg:
104b36420: f85983b4    	ldur	x20, [x29, #-0x68]
104b36424: aa1403e2    	mov	x2, x20
104b36428: 94c3c345    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3642c: aa1d03fd    	mov	x29, x29
104b36430: 94c3c346    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36434: aa0003f3    	mov	x19, x0
104b36438: b00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3643c: f9456d01    	ldr	x1, [x8, #0xad8] ; setReferingMessageWrap:
104b36440: aa1803e0    	mov	x0, x24
104b36444: aa1303e2    	mov	x2, x19
104b36448: 94c3c33d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3644c: aa1303e0    	mov	x0, x19
104b36450: 94c3c341    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36454: f9429ac0    	ldr	x0, [x22, #0x530] ; 0Q6 
104b36458: b00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3645c: f9457101    	ldr	x1, [x8, #0xae0] ; resetReplyMsg:
104b36460: aa1403e2    	mov	x2, x20
104b36464: 94c3c336    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36468: d00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3646c: f947d11b    	ldr	x27, [x8, #0xfa0] ; m_uiMesLocalID
104b36470: aa1803e0    	mov	x0, x24
104b36474: aa1b03e1    	mov	x1, x27
104b36478: 94c3c331    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3647c: 34000f60    	cbz	w0, 0x104b36668 <_Flutter_MMFoundation_BindContext+0x101224c>
104b36480: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36484: f9406913    	ldr	x19, [x8, #0xd0] ; revokeBatchId
104b36488: aa1503e0    	mov	x0, x21
104b3648c: aa1303e1    	mov	x1, x19
104b36490: 94c3c32b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36494: aa1d03fd    	mov	x29, x29
104b36498: 94c3c32c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3649c: aa0003f6    	mov	x22, x0
104b364a0: f85903a1    	ldur	x1, [x29, #-0x70]
104b364a4: 94c3c326    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b364a8: aa0003f7    	mov	x23, x0
104b364ac: aa1603e0    	mov	x0, x22
104b364b0: 94c3c329    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b364b4: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b364b8: d00dae49    	adrp	x9, 0x120100000 <dyld_stub_binder+0x120100000>
104b364bc: b00dae59    	adrp	x25, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b364c0: f00d9814    	adrp	x20, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b364c4: b40004b7    	cbz	x23, 0x104b36558 <_Flutter_MMFoundation_BindContext+0x101213c>
104b364c8: f945e900    	ldr	x0, [x8, #0xbd0]
104b364cc: f944e921    	ldr	x1, [x9, #0x9d0] ; currentContext
104b364d0: 94c3c31b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b364d4: aa1d03fd    	mov	x29, x29
104b364d8: 94c3c31c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b364dc: aa0003f6    	mov	x22, x0
104b364e0: 900db208    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b364e4: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7 
104b364e8: f947af21    	ldr	x1, [x25, #0xf58] ; class
104b364ec: 94c3c314    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b364f0: aa0003e2    	mov	x2, x0
104b364f4: f9464281    	ldr	x1, [x20, #0xc80] ; getService:
104b364f8: aa1603e0    	mov	x0, x22
104b364fc: 94c3c310    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36500: aa1d03fd    	mov	x29, x29
104b36504: 94c3c311    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36508: aa0003f7    	mov	x23, x0
104b3650c: aa1503e0    	mov	x0, x21
104b36510: aa1303e1    	mov	x1, x19
104b36514: 94c3c30a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36518: aa1d03fd    	mov	x29, x29
104b3651c: 94c3c30b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36520: aa0003f3    	mov	x19, x0
104b36524: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36528: f943dd01    	ldr	x1, [x8, #0x7b8] ; addBatchSendForUser:record:identifier:
104b3652c: aa1703e0    	mov	x0, x23
104b36530: f85983a2    	ldur	x2, [x29, #-0x68]
104b36534: aa1803e3    	mov	x3, x24
104b36538: aa1303e4    	mov	x4, x19
104b3653c: 94c3c300    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36540: aa1303e0    	mov	x0, x19
104b36544: 94c3c304    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36548: aa1703e0    	mov	x0, x23
104b3654c: 94c3c302    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36550: aa1603e0    	mov	x0, x22
104b36554: 94c3c300    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36558: d00db1e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3655c: f9411d00    	ldr	x0, [x8, #0x238]
104b36560: d00d9b68    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b36564: f9423d01    	ldr	x1, [x8, #0x478] ; clearLocalImage:
104b36568: aa1803e2    	mov	x2, x24
104b3656c: 94c3c2f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36570: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36574: f941d901    	ldr	x1, [x8, #0x3b0] ; exifLogInfo
104b36578: aa1503e0    	mov	x0, x21
104b3657c: 94c3c2f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36580: aa1d03fd    	mov	x29, x29
104b36584: 94c3c2f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36588: aa0003f7    	mov	x23, x0
104b3658c: f00dae88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
104b36590: f943fd13    	ldr	x19, [x8, #0x7f8] ; setScene:
104b36594: aa1303e1    	mov	x1, x19
104b36598: 52800042    	mov	w2, #0x2                ; =2
104b3659c: 94c3c2e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b365a0: d00db1e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b365a4: f9400100    	ldr	x0, [x8]
104b365a8: d00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b365ac: f946c901    	ldr	x1, [x8, #0xd90] ; IsChatRoom:
104b365b0: aa1c03e2    	mov	x2, x28
104b365b4: 94c3c2e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b365b8: f9003ffa    	str	x26, [sp, #0x78]
104b365bc: 360007a0    	tbz	w0, #0x0, 0x104b366b0 <_Flutter_MMFoundation_BindContext+0x1012294>
104b365c0: 528000a2    	mov	w2, #0x5                ; =5
104b365c4: 14000044    	b	0x104b366d4 <_Flutter_MMFoundation_BindContext+0x10122b8>
104b365c8: f9453773    	ldr	x19, [x27, #0xa68]
104b365cc: b00db1f4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104b365d0: f9454680    	ldr	x0, [x20, #0xa88]
104b365d4: d00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b365d8: f947c917    	ldr	x23, [x8, #0xf90] ; generatePrivacyString:
104b365dc: aa1703e1    	mov	x1, x23
104b365e0: aa1903e2    	mov	x2, x25
104b365e4: 94c3c2d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b365e8: aa1d03fd    	mov	x29, x29
104b365ec: 94c3c2d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b365f0: aa0003f8    	mov	x24, x0
104b365f4: f9454680    	ldr	x0, [x20, #0xa88]
104b365f8: aa1703e1    	mov	x1, x23
104b365fc: f85983a2    	ldur	x2, [x29, #-0x68]
104b36600: 94c3c2cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36604: aa1d03fd    	mov	x29, x29
104b36608: 94c3c2d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3660c: aa0003f7    	mov	x23, x0
104b36610: f942aac1    	ldr	x1, [x22, #0x550]
104b36614: a90083f8    	stp	x24, x0, [sp, #0x8]
104b36618: d00ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3661c: 9132a108    	add	x8, x8, #0xca8
104b36620: f90003e8    	str	x8, [sp]
104b36624: f00b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b36628: 9107f063    	add	x3, x3, #0x1fc
104b3662c: d00b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b36630: 910cb4a5    	add	x5, x5, #0x32d
104b36634: f00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b36638: 9127bce7    	add	x7, x7, #0x9ef
104b3663c: aa1303e0    	mov	x0, x19
104b36640: 52800022    	mov	w2, #0x1                ; =1
104b36644: 52800004    	mov	w4, #0x0                ; =0
104b36648: 52815586    	mov	w6, #0xaac              ; =2732
104b3664c: 94c3c2bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36650: aa1703e0    	mov	x0, x23
104b36654: 94c3c2c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36658: aa1803e0    	mov	x0, x24
104b3665c: 94c3c2be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36660: d2800018    	mov	x24, #0x0               ; =0
104b36664: 14000228    	b	0x104b36f04 <_Flutter_MMFoundation_BindContext+0x1012ae8>
104b36668: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3666c: f9453500    	ldr	x0, [x8, #0xa68]
104b36670: f00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b36674: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b36678: d00ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b3667c: 91342108    	add	x8, x8, #0xd08
104b36680: f90003e8    	str	x8, [sp]
104b36684: f00b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b36688: 9107f063    	add	x3, x3, #0x1fc
104b3668c: d00b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b36690: 910cb4a5    	add	x5, x5, #0x32d
104b36694: f00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b36698: 9127bce7    	add	x7, x7, #0x9ef
104b3669c: 52800082    	mov	w2, #0x4                ; =4
104b366a0: 52800004    	mov	w4, #0x0                ; =0
104b366a4: 52816486    	mov	w6, #0xb24              ; =2852
104b366a8: 94c3c2a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b366ac: 14000216    	b	0x104b36f04 <_Flutter_MMFoundation_BindContext+0x1012ae8>
104b366b0: 900dae68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104b366b4: f9445901    	ldr	x1, [x8, #0x8b0] ; hasSuffix:
104b366b8: f00cd042    	adrp	x2, 0x11e541000 <dyld_stub_binder+0x11e541000>
104b366bc: 910c2042    	add	x2, x2, #0x308
104b366c0: aa1c03e0    	mov	x0, x28
104b366c4: 94c3c29e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b366c8: 7100001f    	cmp	w0, #0x0
104b366cc: 52800088    	mov	w8, #0x4                ; =4
104b366d0: 9a880502    	cinc	x2, x8, ne
104b366d4: aa1703e0    	mov	x0, x23
104b366d8: aa1303e1    	mov	x1, x19
104b366dc: 94c3c298    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b366e0: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b366e4: f9454513    	ldr	x19, [x8, #0xa88]
104b366e8: aa1803e0    	mov	x0, x24
104b366ec: aa1b03e1    	mov	x1, x27
104b366f0: 94c3c293    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b366f4: aa0003f6    	mov	x22, x0
104b366f8: d00d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b366fc: f947d901    	ldr	x1, [x8, #0xfb0] ; m_uiCreateTime
104b36700: aa1803e0    	mov	x0, x24
104b36704: 94c3c28e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36708: a90003f6    	stp	x22, x0, [sp]
104b3670c: f00ccc22    	adrp	x2, 0x11e4bd000 <dyld_stub_binder+0x11e4bd000>
104b36710: 9131a042    	add	x2, x2, #0xc68
104b36714: aa1303e0    	mov	x0, x19
104b36718: f85883a1    	ldur	x1, [x29, #-0x78]
104b3671c: 94c3c288    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36720: aa1d03fd    	mov	x29, x29
104b36724: 94c3c289    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36728: aa0003f3    	mov	x19, x0
104b3672c: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36730: f941fd01    	ldr	x1, [x8, #0x3f8] ; setLocalID:
104b36734: aa1703e0    	mov	x0, x23
104b36738: aa1303e2    	mov	x2, x19
104b3673c: 94c3c280    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36740: aa1303e0    	mov	x0, x19
104b36744: 94c3c284    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36748: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3674c: f9420101    	ldr	x1, [x8, #0x400] ; report
104b36750: f9003bf7    	str	x23, [sp, #0x70]
104b36754: aa1703e0    	mov	x0, x23
104b36758: 94c3c279    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3675c: b00db1f4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104b36760: f9467a93    	ldr	x19, [x20, #0xcf0]
104b36764: b00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b36768: f943a51a    	ldr	x26, [x8, #0x748] ; GetDocPath
104b3676c: aa1303e0    	mov	x0, x19
104b36770: aa1a03e1    	mov	x1, x26
104b36774: 94c3c272    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36778: aa1d03fd    	mov	x29, x29
104b3677c: 94c3c273    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36780: aa0003f6    	mov	x22, x0
104b36784: f00d9a48    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
104b36788: f9416501    	ldr	x1, [x8, #0x2c8] ; GetPathOfMesVideoDir:DocPath:
104b3678c: aa1303e0    	mov	x0, x19
104b36790: aa1c03e2    	mov	x2, x28
104b36794: aa1603e3    	mov	x3, x22
104b36798: 94c3c269    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3679c: aa1d03fd    	mov	x29, x29
104b367a0: 94c3c26a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b367a4: aa0003f3    	mov	x19, x0
104b367a8: aa1603e0    	mov	x0, x22
104b367ac: 94c3c26a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b367b0: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b367b4: f9463500    	ldr	x0, [x8, #0xc68]
104b367b8: f00d9888    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
104b367bc: f9470501    	ldr	x1, [x8, #0xe08] ; CreatePath:
104b367c0: f90037f3    	str	x19, [sp, #0x68]
104b367c4: aa1303e2    	mov	x2, x19
104b367c8: 94c3c25d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b367cc: f9467a93    	ldr	x19, [x20, #0xcf0]
104b367d0: aa1803e0    	mov	x0, x24
104b367d4: aa1b03e1    	mov	x1, x27
104b367d8: 94c3c259    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b367dc: aa0003f6    	mov	x22, x0
104b367e0: f9467a80    	ldr	x0, [x20, #0xcf0]
104b367e4: aa1a03e1    	mov	x1, x26
104b367e8: 94c3c255    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b367ec: aa1d03fd    	mov	x29, x29
104b367f0: 94c3c256    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b367f4: aa0003f7    	mov	x23, x0
104b367f8: d00d98c8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
104b367fc: f944b101    	ldr	x1, [x8, #0x960] ; GetPathOfMesVideo:LocalID:DocPath:
104b36800: aa1303e0    	mov	x0, x19
104b36804: aa1c03e2    	mov	x2, x28
104b36808: aa1603e3    	mov	x3, x22
104b3680c: aa1703e4    	mov	x4, x23
104b36810: 94c3c24b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36814: aa1d03fd    	mov	x29, x29
104b36818: 94c3c24c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3681c: aa0003f9    	mov	x25, x0
104b36820: aa1703e0    	mov	x0, x23
104b36824: 94c3c24c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36828: d00db1e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b3682c: f9411d00    	ldr	x0, [x8, #0x238]
104b36830: d00d9a48    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104b36834: f9456501    	ldr	x1, [x8, #0xac8] ; GetPathOfRawVideoWithMessageWrap:
104b36838: aa1803e2    	mov	x2, x24
104b3683c: 94c3c240    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36840: aa1d03fd    	mov	x29, x29
104b36844: 94c3c241    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36848: f90033e0    	str	x0, [sp, #0x60]
104b3684c: f9467a93    	ldr	x19, [x20, #0xcf0]
104b36850: aa1803e0    	mov	x0, x24
104b36854: aa1b03e1    	mov	x1, x27
104b36858: 94c3c239    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3685c: aa0003f6    	mov	x22, x0
104b36860: f9467a80    	ldr	x0, [x20, #0xcf0]
104b36864: aa1a03e1    	mov	x1, x26
104b36868: 94c3c235    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3686c: aa1d03fd    	mov	x29, x29
104b36870: 94c3c236    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36874: aa0003f7    	mov	x23, x0
104b36878: f00d9a68    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104b3687c: f943f501    	ldr	x1, [x8, #0x7e8] ; GetPathOfMes3rdVideo:LocalID:DocPath:
104b36880: aa1303e0    	mov	x0, x19
104b36884: aa1c03e2    	mov	x2, x28
104b36888: aa1603e3    	mov	x3, x22
104b3688c: aa1703e4    	mov	x4, x23
104b36890: 94c3c22b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36894: aa1d03fd    	mov	x29, x29
104b36898: 94c3c22c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3689c: f90043e0    	str	x0, [sp, #0x80]
104b368a0: aa1703e0    	mov	x0, x23
104b368a4: 94c3c22c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b368a8: f9467a93    	ldr	x19, [x20, #0xcf0]
104b368ac: aa1803e0    	mov	x0, x24
104b368b0: aa1b03e1    	mov	x1, x27
104b368b4: 94c3c222    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b368b8: aa0003f6    	mov	x22, x0
104b368bc: f9467a80    	ldr	x0, [x20, #0xcf0]
104b368c0: aa1a03e1    	mov	x1, x26
104b368c4: 94c3c21e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b368c8: aa1d03fd    	mov	x29, x29
104b368cc: 94c3c21f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b368d0: aa0003f7    	mov	x23, x0
104b368d4: 900d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b368d8: f9451901    	ldr	x1, [x8, #0xa30] ; GetPathOfMesVideoThumb:LocalID:DocPath:
104b368dc: aa1303e0    	mov	x0, x19
104b368e0: aa1c03e2    	mov	x2, x28
104b368e4: aa1603e3    	mov	x3, x22
104b368e8: aa1703e4    	mov	x4, x23
104b368ec: 94c3c214    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b368f0: aa1d03fd    	mov	x29, x29
104b368f4: 94c3c215    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b368f8: f9002fe0    	str	x0, [sp, #0x58]
104b368fc: aa1703e0    	mov	x0, x23
104b36900: 94c3c215    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36904: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b36908: f945e900    	ldr	x0, [x8, #0xbd0]
104b3690c: d00dae48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b36910: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b36914: f90023e1    	str	x1, [sp, #0x40]
104b36918: 94c3c209    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3691c: aa1d03fd    	mov	x29, x29
104b36920: 94c3c20a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36924: aa0003f3    	mov	x19, x0
104b36928: b00db268    	adrp	x8, 0x120183000 <dyld_stub_binder+0x120183000>
104b3692c: f9417100    	ldr	x0, [x8, #0x2e0]
104b36930: b00dae48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b36934: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b36938: f9001fe1    	str	x1, [sp, #0x38]
104b3693c: 94c3c200    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36940: aa0003e2    	mov	x2, x0
104b36944: f00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b36948: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b3694c: aa1303e0    	mov	x0, x19
104b36950: f9001be1    	str	x1, [sp, #0x30]
104b36954: 94c3c1fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36958: aa1d03fd    	mov	x29, x29
104b3695c: 94c3c1fb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36960: aa0003f6    	mov	x22, x0
104b36964: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36968: f944d901    	ldr	x1, [x8, #0x9b0] ; m_videoCreateTime
104b3696c: aa1503e0    	mov	x0, x21
104b36970: 94c3c1f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36974: 2a0003e3    	mov	w3, w0
104b36978: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3697c: f944dd01    	ldr	x1, [x8, #0x9b8] ; cacheWithVideo:createTime:
104b36980: aa1603e0    	mov	x0, x22
104b36984: f81883b9    	stur	x25, [x29, #-0x78]
104b36988: aa1903e2    	mov	x2, x25
104b3698c: 94c3c1ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36990: aa1603e0    	mov	x0, x22
104b36994: 94c3c1f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36998: aa1303e0    	mov	x0, x19
104b3699c: 94c3c1ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b369a0: f00d9a68    	adrp	x8, 0x11fe85000 <dyld_stub_binder+0x11fe85000>
104b369a4: f943f101    	ldr	x1, [x8, #0x7e0] ; m_uiVideoSource
104b369a8: aa1503e0    	mov	x0, x21
104b369ac: 94c3c1e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b369b0: aa0003fb    	mov	x27, x0
104b369b4: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b369b8: f944e113    	ldr	x19, [x8, #0x9c0] ; video_assetId
104b369bc: aa1503e0    	mov	x0, x21
104b369c0: aa1303e1    	mov	x1, x19
104b369c4: 94c3c1de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b369c8: aa1d03fd    	mov	x29, x29
104b369cc: 94c3c1df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b369d0: aa0003f7    	mov	x23, x0
104b369d4: f85903a1    	ldur	x1, [x29, #-0x70]
104b369d8: 94c3c1d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b369dc: f00d981a    	adrp	x26, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b369e0: b4000260    	cbz	x0, 0x104b36a2c <_Flutter_MMFoundation_BindContext+0x1012610>
104b369e4: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b369e8: aa0803f4    	mov	x20, x8
104b369ec: f9463516    	ldr	x22, [x8, #0xc68]
104b369f0: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b369f4: f947d101    	ldr	x1, [x8, #0xfa0] ; video_path
104b369f8: aa1503e0    	mov	x0, x21
104b369fc: 94c3c1d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36a00: aa1d03fd    	mov	x29, x29
104b36a04: 94c3c1d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36a08: aa0003f9    	mov	x25, x0
104b36a0c: f9467b41    	ldr	x1, [x26, #0xcf0] ; FileExist:
104b36a10: aa1603e0    	mov	x0, x22
104b36a14: aa1903e2    	mov	x2, x25
104b36a18: 94c3c1c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36a1c: 5200001c    	eor	w28, w0, #0x1
104b36a20: aa1903e0    	mov	x0, x25
104b36a24: 94c3c1cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36a28: 14000003    	b	0x104b36a34 <_Flutter_MMFoundation_BindContext+0x1012618>
104b36a2c: b00db1f4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104b36a30: 5280001c    	mov	w28, #0x0               ; =0
104b36a34: aa1703e0    	mov	x0, x23
104b36a38: 94c3c1c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36a3c: aa1503e0    	mov	x0, x21
104b36a40: aa1303e1    	mov	x1, x19
104b36a44: 94c3c1be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36a48: aa1d03fd    	mov	x29, x29
104b36a4c: 94c3c1bf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36a50: aa0003f3    	mov	x19, x0
104b36a54: f85903a1    	ldur	x1, [x29, #-0x70]
104b36a58: 94c3c1b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36a5c: b4000220    	cbz	x0, 0x104b36aa0 <_Flutter_MMFoundation_BindContext+0x1012684>
104b36a60: f9463696    	ldr	x22, [x20, #0xc68]
104b36a64: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36a68: f944e501    	ldr	x1, [x8, #0x9c8] ; nsRawVidePath
104b36a6c: aa1503e0    	mov	x0, x21
104b36a70: 94c3c1b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36a74: aa1d03fd    	mov	x29, x29
104b36a78: 94c3c1b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36a7c: aa0003f7    	mov	x23, x0
104b36a80: f9467b41    	ldr	x1, [x26, #0xcf0] ; FileExist:
104b36a84: aa1603e0    	mov	x0, x22
104b36a88: aa1703e2    	mov	x2, x23
104b36a8c: 94c3c1ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36a90: aa0003fa    	mov	x26, x0
104b36a94: aa1703e0    	mov	x0, x23
104b36a98: 94c3c1af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36a9c: 14000002    	b	0x104b36aa4 <_Flutter_MMFoundation_BindContext+0x1012688>
104b36aa0: 5280001a    	mov	w26, #0x0               ; =0
104b36aa4: f85883b7    	ldur	x23, [x29, #-0x78]
104b36aa8: 7100137f    	cmp	w27, #0x4
104b36aac: 1a9f17f6    	cset	w22, eq
104b36ab0: aa1303e0    	mov	x0, x19
104b36ab4: 94c3c1a8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ab8: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b36abc: f9453500    	ldr	x0, [x8, #0xa68]
104b36ac0: f00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b36ac4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b36ac8: a901dffa    	stp	x26, x23, [sp, #0x18]
104b36acc: a900f3f6    	stp	x22, x28, [sp, #0x8]
104b36ad0: d00ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b36ad4: 9133a108    	add	x8, x8, #0xce8
104b36ad8: f90003e8    	str	x8, [sp]
104b36adc: f00b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b36ae0: 9107f063    	add	x3, x3, #0x1fc
104b36ae4: d00b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b36ae8: 910cb4a5    	add	x5, x5, #0x32d
104b36aec: f00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b36af0: 9127bce7    	add	x7, x7, #0x9ef
104b36af4: 52800042    	mov	w2, #0x2                ; =2
104b36af8: 52800004    	mov	w4, #0x0                ; =0
104b36afc: 52815ec6    	mov	w6, #0xaf6              ; =2806
104b36b00: 94c3c18f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36b04: 900d9b08    	adrp	x8, 0x11fe96000 <dyld_stub_binder+0x11fe96000>
104b36b08: f9426919    	ldr	x25, [x8, #0x4d0] ; m_bForward
104b36b0c: aa1503e0    	mov	x0, x21
104b36b10: aa1903e1    	mov	x1, x25
104b36b14: 94c3c18a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36b18: 7100137f    	cmp	w27, #0x4
104b36b1c: 340001a0    	cbz	w0, 0x104b36b50 <_Flutter_MMFoundation_BindContext+0x1012734>
104b36b20: 54000421    	b.ne	0x104b36ba4 <_Flutter_MMFoundation_BindContext+0x1012788>
104b36b24: f9463693    	ldr	x19, [x20, #0xc68]
104b36b28: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36b2c: f947d101    	ldr	x1, [x8, #0xfa0] ; video_path
104b36b30: aa1503e0    	mov	x0, x21
104b36b34: 94c3c182    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36b38: aa1d03fd    	mov	x29, x29
104b36b3c: 94c3c183    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36b40: aa0003f6    	mov	x22, x0
104b36b44: d00d9988    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
104b36b48: f944351a    	ldr	x26, [x8, #0x868] ; HardLinkFile:To:
104b36b4c: 1400000c    	b	0x104b36b7c <_Flutter_MMFoundation_BindContext+0x1012760>
104b36b50: 54000561    	b.ne	0x104b36bfc <_Flutter_MMFoundation_BindContext+0x10127e0>
104b36b54: f9463693    	ldr	x19, [x20, #0xc68]
104b36b58: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36b5c: f947d101    	ldr	x1, [x8, #0xfa0] ; video_path
104b36b60: aa1503e0    	mov	x0, x21
104b36b64: 94c3c176    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36b68: aa1d03fd    	mov	x29, x29
104b36b6c: 94c3c177    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36b70: aa0003f6    	mov	x22, x0
104b36b74: d00d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b36b78: f944211a    	ldr	x26, [x8, #0x840] ; RenameFile:To:
104b36b7c: aa1303e0    	mov	x0, x19
104b36b80: aa1a03e1    	mov	x1, x26
104b36b84: aa1603e2    	mov	x2, x22
104b36b88: f94043e3    	ldr	x3, [sp, #0x80]
104b36b8c: 94c3c16c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36b90: aa1603e0    	mov	x0, x22
104b36b94: 94c3c170    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36b98: f94047fc    	ldr	x28, [sp, #0x88]
104b36b9c: f94033fb    	ldr	x27, [sp, #0x60]
104b36ba0: 14000047    	b	0x104b36cbc <_Flutter_MMFoundation_BindContext+0x10128a0>
104b36ba4: d00d9997    	adrp	x23, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
104b36ba8: f94033fb    	ldr	x27, [sp, #0x60]
104b36bac: 3700021c    	tbnz	w28, #0x0, 0x104b36bec <_Flutter_MMFoundation_BindContext+0x10127d0>
104b36bb0: f9463693    	ldr	x19, [x20, #0xc68]
104b36bb4: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36bb8: f947d101    	ldr	x1, [x8, #0xfa0] ; video_path
104b36bbc: aa1503e0    	mov	x0, x21
104b36bc0: 94c3c15f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36bc4: aa1d03fd    	mov	x29, x29
104b36bc8: 94c3c160    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36bcc: aa0003f6    	mov	x22, x0
104b36bd0: f94436e1    	ldr	x1, [x23, #0x868] ; HardLinkFile:To:
104b36bd4: aa1303e0    	mov	x0, x19
104b36bd8: aa1603e2    	mov	x2, x22
104b36bdc: f85883a3    	ldur	x3, [x29, #-0x78]
104b36be0: 94c3c157    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36be4: aa1603e0    	mov	x0, x22
104b36be8: 94c3c15b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36bec: f94047fc    	ldr	x28, [sp, #0x88]
104b36bf0: 3400033a    	cbz	w26, 0x104b36c54 <_Flutter_MMFoundation_BindContext+0x1012838>
104b36bf4: f94436fa    	ldr	x26, [x23, #0x868] ; HardLinkFile:To:
104b36bf8: 14000031    	b	0x104b36cbc <_Flutter_MMFoundation_BindContext+0x10128a0>
104b36bfc: d00d9857    	adrp	x23, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b36c00: f94033fb    	ldr	x27, [sp, #0x60]
104b36c04: 3700021c    	tbnz	w28, #0x0, 0x104b36c44 <_Flutter_MMFoundation_BindContext+0x1012828>
104b36c08: f9463693    	ldr	x19, [x20, #0xc68]
104b36c0c: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36c10: f947d101    	ldr	x1, [x8, #0xfa0] ; video_path
104b36c14: aa1503e0    	mov	x0, x21
104b36c18: 94c3c149    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36c1c: aa1d03fd    	mov	x29, x29
104b36c20: 94c3c14a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36c24: aa0003f6    	mov	x22, x0
104b36c28: f94422e1    	ldr	x1, [x23, #0x840] ; RenameFile:To:
104b36c2c: aa1303e0    	mov	x0, x19
104b36c30: aa1603e2    	mov	x2, x22
104b36c34: f85883a3    	ldur	x3, [x29, #-0x78]
104b36c38: 94c3c141    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36c3c: aa1603e0    	mov	x0, x22
104b36c40: 94c3c145    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36c44: f94047fc    	ldr	x28, [sp, #0x88]
104b36c48: 340001ba    	cbz	w26, 0x104b36c7c <_Flutter_MMFoundation_BindContext+0x1012860>
104b36c4c: f94422fa    	ldr	x26, [x23, #0x840] ; RenameFile:To:
104b36c50: 1400001b    	b	0x104b36cbc <_Flutter_MMFoundation_BindContext+0x10128a0>
104b36c54: f9463693    	ldr	x19, [x20, #0xc68]
104b36c58: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36c5c: f944e501    	ldr	x1, [x8, #0x9c8] ; nsRawVidePath
104b36c60: aa1503e0    	mov	x0, x21
104b36c64: 94c3c136    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36c68: aa1d03fd    	mov	x29, x29
104b36c6c: 94c3c137    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36c70: aa0003f6    	mov	x22, x0
104b36c74: f94436fa    	ldr	x26, [x23, #0x868] ; OverWriteDataToPath:Data:
104b36c78: 1400000a    	b	0x104b36ca0 <_Flutter_MMFoundation_BindContext+0x1012884>
104b36c7c: f9463693    	ldr	x19, [x20, #0xc68]
104b36c80: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36c84: f944e501    	ldr	x1, [x8, #0x9c8] ; nsRawVidePath
104b36c88: aa1503e0    	mov	x0, x21
104b36c8c: 94c3c12c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36c90: aa1d03fd    	mov	x29, x29
104b36c94: 94c3c12d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36c98: aa0003f6    	mov	x22, x0
104b36c9c: f94422fa    	ldr	x26, [x23, #0x840] ; RenameFile:To:
104b36ca0: aa1303e0    	mov	x0, x19
104b36ca4: aa1a03e1    	mov	x1, x26
104b36ca8: aa1603e2    	mov	x2, x22
104b36cac: aa1b03e3    	mov	x3, x27
104b36cb0: 94c3c123    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36cb4: aa1603e0    	mov	x0, x22
104b36cb8: 94c3c127    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36cbc: f9463693    	ldr	x19, [x20, #0xc68]
104b36cc0: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36cc4: f947cd01    	ldr	x1, [x8, #0xf98] ; thumb_path
104b36cc8: aa1503e0    	mov	x0, x21
104b36ccc: 94c3c11c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36cd0: aa1d03fd    	mov	x29, x29
104b36cd4: 94c3c11d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36cd8: aa0003f6    	mov	x22, x0
104b36cdc: aa1303e0    	mov	x0, x19
104b36ce0: aa1a03e1    	mov	x1, x26
104b36ce4: aa1603e2    	mov	x2, x22
104b36ce8: f9402ffa    	ldr	x26, [sp, #0x58]
104b36cec: aa1a03e3    	mov	x3, x26
104b36cf0: 94c3c113    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36cf4: aa1603e0    	mov	x0, x22
104b36cf8: 94c3c117    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36cfc: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36d00: f9440101    	ldr	x1, [x8, #0x800] ; AsyncOnPreAddMsg:MsgWrap:
104b36d04: f9403ff7    	ldr	x23, [sp, #0x78]
104b36d08: aa1703e0    	mov	x0, x23
104b36d0c: aa1c03e2    	mov	x2, x28
104b36d10: aa1803e3    	mov	x3, x24
104b36d14: 94c3c10a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36d18: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36d1c: f9440501    	ldr	x1, [x8, #0x808] ; AsyncOnAddMsg:MsgWrap:
104b36d20: aa1703e0    	mov	x0, x23
104b36d24: aa1c03e2    	mov	x2, x28
104b36d28: aa1803e3    	mov	x3, x24
104b36d2c: 94c3c104    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36d30: b00d9948    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
104b36d34: f944ed01    	ldr	x1, [x8, #0x9d8] ; AsyncOnAddMsgForSession:MsgWrap:
104b36d38: aa1703e0    	mov	x0, x23
104b36d3c: aa1c03e2    	mov	x2, x28
104b36d40: aa1803e3    	mov	x3, x24
104b36d44: 94c3c0fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36d48: f00db1e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104b36d4c: f940d500    	ldr	x0, [x8, #0x1a8]
104b36d50: 900d9868    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104b36d54: f9434501    	ldr	x1, [x8, #0x688] ; getPluginUserNameType:
104b36d58: aa1c03e2    	mov	x2, x28
104b36d5c: 94c3c0f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36d60: f100141f    	cmp	x0, #0x5
104b36d64: 54000101    	b.ne	0x104b36d84 <_Flutter_MMFoundation_BindContext+0x1012968>
104b36d68: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b36d6c: f9467900    	ldr	x0, [x8, #0xcf0]
104b36d70: b00d9868    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b36d74: f9465901    	ldr	x1, [x8, #0xcb0] ; CheckSyncMediaNote:
104b36d78: aa1c03e2    	mov	x2, x28
104b36d7c: 94c3c0f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36d80: 34000a80    	cbz	w0, 0x104b36ed0 <_Flutter_MMFoundation_BindContext+0x1012ab4>
104b36d84: 900d9a28    	adrp	x8, 0x11fe7a000 <dyld_stub_binder+0x11fe7a000>
104b36d88: f9448501    	ldr	x1, [x8, #0x908] ; m_forwardType
104b36d8c: aa1503e0    	mov	x0, x21
104b36d90: 94c3c0eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36d94: aa0003e2    	mov	x2, x0
104b36d98: b00d98a8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b36d9c: f941bd01    	ldr	x1, [x8, #0x378] ; setM_forwardType:
104b36da0: aa1803e0    	mov	x0, x24
104b36da4: 94c3c0e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36da8: aa1503e0    	mov	x0, x21
104b36dac: aa1903e1    	mov	x1, x25
104b36db0: 94c3c0e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36db4: 340002c0    	cbz	w0, 0x104b36e0c <_Flutter_MMFoundation_BindContext+0x10129f0>
104b36db8: aa1503e0    	mov	x0, x21
104b36dbc: f9402be1    	ldr	x1, [sp, #0x50]
104b36dc0: 94c3c0df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36dc4: aa1d03fd    	mov	x29, x29
104b36dc8: 94c3c0e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36dcc: aa0003f3    	mov	x19, x0
104b36dd0: f94027e1    	ldr	x1, [sp, #0x48]
104b36dd4: 94c3c0da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36dd8: aa0003f6    	mov	x22, x0
104b36ddc: aa1303e0    	mov	x0, x19
104b36de0: 94c3c0dd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36de4: 71000edf    	cmp	w22, #0x3
104b36de8: 54000121    	b.ne	0x104b36e0c <_Flutter_MMFoundation_BindContext+0x10129f0>
104b36dec: 52800039    	mov	w25, #0x1               ; =1
104b36df0: 5280e4e0    	mov	w0, #0x727              ; =1831
104b36df4: 52800021    	mov	w1, #0x1                ; =1
104b36df8: 52800022    	mov	w2, #0x1                ; =1
104b36dfc: 52800003    	mov	w3, #0x0                ; =0
104b36e00: 52800004    	mov	w4, #0x0                ; =0
104b36e04: 975064de    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
104b36e08: 14000002    	b	0x104b36e10 <_Flutter_MMFoundation_BindContext+0x10129f4>
104b36e0c: 52800019    	mov	w25, #0x0               ; =0
104b36e10: 900da288    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b36e14: f9439d01    	ldr	x1, [x8, #0x738] ; uploadVideoUnifyMgr
104b36e18: aa1703e0    	mov	x0, x23
104b36e1c: 94c3c0c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36e20: aa1d03fd    	mov	x29, x29
104b36e24: 94c3c0c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36e28: aa0003f3    	mov	x19, x0
104b36e2c: 900d9ca8    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
104b36e30: f946ad01    	ldr	x1, [x8, #0xd58] ; StartUpload:
104b36e34: aa1803e2    	mov	x2, x24
104b36e38: 94c3c0c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36e3c: aa1303e0    	mov	x0, x19
104b36e40: 94c3c0c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36e44: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b36e48: f945e900    	ldr	x0, [x8, #0xbd0]
104b36e4c: f94023e1    	ldr	x1, [sp, #0x40]
104b36e50: 94c3c0bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36e54: aa1d03fd    	mov	x29, x29
104b36e58: 94c3c0bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36e5c: aa0003f6    	mov	x22, x0
104b36e60: b00db1e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b36e64: f947f500    	ldr	x0, [x8, #0xfe8]
104b36e68: f9401fe1    	ldr	x1, [sp, #0x38]
104b36e6c: 94c3c0b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36e70: aa0003e2    	mov	x2, x0
104b36e74: aa1603e0    	mov	x0, x22
104b36e78: f9401be1    	ldr	x1, [sp, #0x30]
104b36e7c: 94c3c0b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36e80: aa1d03fd    	mov	x29, x29
104b36e84: 94c3c0b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b36e88: aa0003f7    	mov	x23, x0
104b36e8c: d00d9b68    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b36e90: f9438501    	ldr	x1, [x8, #0x708] ; IsMessageCanUseCdnUpload:
104b36e94: aa1803e2    	mov	x2, x24
104b36e98: 94c3c0a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b36e9c: aa0003f3    	mov	x19, x0
104b36ea0: aa1703e0    	mov	x0, x23
104b36ea4: 94c3c0ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ea8: aa1603e0    	mov	x0, x22
104b36eac: 94c3c0aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36eb0: 34000119    	cbz	w25, 0x104b36ed0 <_Flutter_MMFoundation_BindContext+0x1012ab4>
104b36eb4: 340000f3    	cbz	w19, 0x104b36ed0 <_Flutter_MMFoundation_BindContext+0x1012ab4>
104b36eb8: 5280e4e0    	mov	w0, #0x727              ; =1831
104b36ebc: 52800041    	mov	w1, #0x2                ; =2
104b36ec0: 52800022    	mov	w2, #0x1                ; =1
104b36ec4: 52800003    	mov	w3, #0x0                ; =0
104b36ec8: 52800004    	mov	w4, #0x0                ; =0
104b36ecc: 975064ac    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
104b36ed0: aa1a03e0    	mov	x0, x26
104b36ed4: 94c3c0a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ed8: f94043e0    	ldr	x0, [sp, #0x80]
104b36edc: 94c3c09e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ee0: aa1b03e0    	mov	x0, x27
104b36ee4: 94c3c09c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ee8: f85883a0    	ldur	x0, [x29, #-0x78]
104b36eec: 94c3c09a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ef0: f94037e0    	ldr	x0, [sp, #0x68]
104b36ef4: 94c3c098    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36ef8: f9403be0    	ldr	x0, [sp, #0x70]
104b36efc: 94c3c096    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36f00: f85803b9    	ldur	x25, [x29, #-0x80]
104b36f04: aa1c03e0    	mov	x0, x28
104b36f08: 94c3c093    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36f0c: aa1503e0    	mov	x0, x21
104b36f10: 94c3c091    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36f14: f85983a0    	ldur	x0, [x29, #-0x68]
104b36f18: 94c3c08f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36f1c: aa1903e0    	mov	x0, x25
104b36f20: 94c3c08d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b36f24: aa1803e0    	mov	x0, x24
104b36f28: a9517bfd    	ldp	x29, x30, [sp, #0x110]
104b36f2c: a9504ff4    	ldp	x20, x19, [sp, #0x100]
104b36f30: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
104b36f34: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
104b36f38: a94d67fa    	ldp	x26, x25, [sp, #0xd0]
104b36f3c: a94c6ffc    	ldp	x28, x27, [sp, #0xc0]
104b36f40: 910483ff    	add	sp, sp, #0x120
104b36f44: 14c3c08b    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>