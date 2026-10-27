
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105110ef4: d10243ff    	sub	sp, sp, #0x90
105110ef8: 6d0223e9    	stp	d9, d8, [sp, #0x20]
105110efc: a9036ffc    	stp	x28, x27, [sp, #0x30]
105110f00: a90467fa    	stp	x26, x25, [sp, #0x40]
105110f04: a9055ff8    	stp	x24, x23, [sp, #0x50]
105110f08: a90657f6    	stp	x22, x21, [sp, #0x60]
105110f0c: a9074ff4    	stp	x20, x19, [sp, #0x70]
105110f10: a9087bfd    	stp	x29, x30, [sp, #0x80]
105110f14: 910203fd    	add	x29, sp, #0x80
105110f18: aa0003f6    	mov	x22, x0
105110f1c: f00dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105110f20: 52800029    	mov	w9, #0x1                ; =1
105110f24: 392d3109    	strb	w9, [x8, #0xb4c]
105110f28: d00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105110f2c: f945a501    	ldr	x1, [x8, #0xb48] ; maxSessionCountInOneScreen
105110f30: 94ac5883    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110f34: aa0003f7    	mov	x23, x0
105110f38: f00d831b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
105110f3c: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
105110f40: 900d7f88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105110f44: f944e913    	ldr	x19, [x8, #0x9d0] ; currentContext
105110f48: aa1303e1    	mov	x1, x19
105110f4c: 94ac587c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110f50: aa1d03fd    	mov	x29, x29
105110f54: 94ac587d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105110f58: aa0003f8    	mov	x24, x0
105110f5c: f00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105110f60: f9467100    	ldr	x0, [x8, #0xce0] ; ExptService
105110f64: f00d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105110f68: f947ad14    	ldr	x20, [x8, #0xf58] ; class
105110f6c: aa1403e1    	mov	x1, x20
105110f70: 94ac5873    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110f74: aa0003e2    	mov	x2, x0
105110f78: b00d6948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105110f7c: f9464115    	ldr	x21, [x8, #0xc80] ; getService:
105110f80: aa1803e0    	mov	x0, x24
105110f84: aa1503e1    	mov	x1, x21
105110f88: 94ac586d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110f8c: aa1d03fd    	mov	x29, x29
105110f90: 94ac586e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105110f94: aa0003f9    	mov	x25, x0
105110f98: d00d6948    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105110f9c: f9422d01    	ldr	x1, [x8, #0x458] ; getExpt:withDef:
105110fa0: 900cb622    	adrp	x2, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
105110fa4: 910fa042    	add	x2, x2, #0x3e8 ; CFString 'clicfg_main_frame_enable_fold_min_range'
105110fa8: f00ca2a3    	adrp	x3, 0x11e567000 <dyld_stub_binder+0x11e567000>
105110fac: 91222063    	add	x3, x3, #0x888 ; CFString '1.0'
105110fb0: 94ac5863    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110fb4: aa1d03fd    	mov	x29, x29
105110fb8: 94ac5864    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105110fbc: aa0003fa    	mov	x26, x0
105110fc0: b00d7f88    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105110fc4: f9454d01    	ldr	x1, [x8, #0xa98] ; floatValue
105110fc8: 94ac585d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110fcc: 1e22c008    	fcvt	d8, s0
105110fd0: aa1a03e0    	mov	x0, x26
105110fd4: 94ac5860    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105110fd8: aa1903e0    	mov	x0, x25
105110fdc: 94ac585e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105110fe0: aa1803e0    	mov	x0, x24
105110fe4: 94ac585c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105110fe8: f00d8348    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
105110fec: f9420900    	ldr	x0, [x8, #0x410] ; MainFrameFoldReporter
105110ff0: d00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105110ff4: f945a901    	ldr	x1, [x8, #0xb50] ; checkReportSessionInfoWithOneScreenCount:foldRate:
105110ff8: aa1703e2    	mov	x2, x23
105110ffc: 1e604100    	fmov	d0, d8
105111000: 94ac584f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111004: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105111008: b9831d08    	ldrsw	x8, [x8, #0x31c]
10511100c: f8686adc    	ldr	x28, [x22, x8]
105111010: eb17039f    	cmp	x28, x23
105111014: 540013a0    	b.eq	0x105111288 <_Flutter_MMFoundation_BindContext+0x15ece6c>
105111018: f8286ad7    	str	x23, [x22, x8]
10511101c: 9e6202e0    	scvtf	d0, x23
105111020: 1e680800    	fmul	d0, d0, d8
105111024: 9e780019    	fcvtzs	x25, d0
105111028: f945eb60    	ldr	x0, [x27, #0xbd0] ; MMContext
10511102c: aa1303e1    	mov	x1, x19
105111030: 94ac5843    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111034: aa1d03fd    	mov	x29, x29
105111038: 94ac5844    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511103c: aa0003f8    	mov	x24, x0
105111040: f00d831b    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
105111044: f941bf60    	ldr	x0, [x27, #0x378] ; MainSessionMgr
105111048: aa1403e1    	mov	x1, x20
10511104c: 94ac583c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111050: aa0003e2    	mov	x2, x0
105111054: aa1803e0    	mov	x0, x24
105111058: aa1503e1    	mov	x1, x21
10511105c: 94ac5838    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111060: aa1d03fd    	mov	x29, x29
105111064: 94ac5839    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105111068: aa0003fa    	mov	x26, x0
10511106c: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105111070: f945ad01    	ldr	x1, [x8, #0xb58] ; setMinTopCountToFold:
105111074: aa1903e2    	mov	x2, x25
105111078: 94ac5831    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511107c: aa1a03e0    	mov	x0, x26
105111080: 94ac5835    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111084: aa1803e0    	mov	x0, x24
105111088: 94ac5833    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511108c: d00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105111090: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
105111094: aa1303e1    	mov	x1, x19
105111098: 94ac5829    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511109c: aa1d03fd    	mov	x29, x29
1051110a0: 94ac582a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051110a4: aa0003f8    	mov	x24, x0
1051110a8: f941bf60    	ldr	x0, [x27, #0x378] ; MainSessionMgr
1051110ac: aa1403e1    	mov	x1, x20
1051110b0: 94ac5823    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051110b4: aa0003e2    	mov	x2, x0
1051110b8: aa1803e0    	mov	x0, x24
1051110bc: aa1503e1    	mov	x1, x21
1051110c0: 94ac581f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051110c4: aa1d03fd    	mov	x29, x29
1051110c8: 94ac5820    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051110cc: aa0003fb    	mov	x27, x0
1051110d0: 900d73a8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
1051110d4: f940191a    	ldr	x26, [x8, #0x30] ; updateChatBoxEntryMinIndex:
1051110d8: 910006e2    	add	x2, x23, #0x1
1051110dc: aa1a03e1    	mov	x1, x26
1051110e0: 94ac5817    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051110e4: aa1b03e0    	mov	x0, x27
1051110e8: 94ac581b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051110ec: aa1803e0    	mov	x0, x24
1051110f0: 94ac5819    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051110f4: d00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051110f8: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
1051110fc: 900d6948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105111100: f942a918    	ldr	x24, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105111104: fd000be8    	str	d8, [sp, #0x10]
105111108: f00cb608    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511110c: 91102108    	add	x8, x8, #0x408 ; CFString 'fold session count: %ld, rate: %f'
105111110: a90067e8    	stp	x8, x25, [sp]
105111114: f00b3a25    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
105111118: 9122e0a5    	add	x5, x5, #0x8b8
10511111c: f00b3a27    	adrp	x7, 0x11b858000 <dyld_stub_binder+0x11b858000>
105111120: 912818e7    	add	x7, x7, #0xa06
105111124: aa1803e1    	mov	x1, x24
105111128: 52800042    	mov	w2, #0x2                ; =2
10511112c: d2800003    	mov	x3, #0x0                ; =0
105111130: 52800004    	mov	w4, #0x0                ; =0
105111134: 52802f26    	mov	w6, #0x179              ; =377
105111138: 94ac5801    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511113c: d00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105111140: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
105111144: aa1303e1    	mov	x1, x19
105111148: 94ac57fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511114c: aa1d03fd    	mov	x29, x29
105111150: 94ac57fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105111154: aa0003f9    	mov	x25, x0
105111158: 900d8328    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10511115c: f9457100    	ldr	x0, [x8, #0xae0] ; MainSessionReporter
105111160: aa1403e1    	mov	x1, x20
105111164: 94ac57f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111168: aa0003e2    	mov	x2, x0
10511116c: aa1903e0    	mov	x0, x25
105111170: aa1503e1    	mov	x1, x21
105111174: 94ac57f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111178: aa1d03fd    	mov	x29, x29
10511117c: 94ac57f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105111180: aa0003fb    	mov	x27, x0
105111184: 910006e2    	add	x2, x23, #0x1
105111188: aa1a03e1    	mov	x1, x26
10511118c: 94ac57ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111190: aa1b03e0    	mov	x0, x27
105111194: d00d8317    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105111198: 94ac57ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511119c: aa1903e0    	mov	x0, x25
1051111a0: 94ac57ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051111a4: f100079f    	cmp	x28, #0x1
1051111a8: 5400070b    	b.lt	0x105111288 <_Flutter_MMFoundation_BindContext+0x15ece6c>
1051111ac: f00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051111b0: b9831508    	ldrsw	x8, [x8, #0x314]
1051111b4: f8686ac0    	ldr	x0, [x22, x8]
1051111b8: b00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
1051111bc: f9437501    	ldr	x1, [x8, #0x6e8] ; m_bReadyToLoadData
1051111c0: 94ac57df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051111c4: 34000620    	cbz	w0, 0x105111288 <_Flutter_MMFoundation_BindContext+0x15ece6c>
1051111c8: d00d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051111cc: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
1051111d0: f00cb608    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
1051111d4: 9110a108    	add	x8, x8, #0x428 ; CFString 'reload main list at fold change'
1051111d8: f90003e8    	str	x8, [sp]
1051111dc: f00b3a25    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
1051111e0: 9122e0a5    	add	x5, x5, #0x8b8
1051111e4: f00b3a27    	adrp	x7, 0x11b858000 <dyld_stub_binder+0x11b858000>
1051111e8: 912818e7    	add	x7, x7, #0xa06
1051111ec: aa1803e1    	mov	x1, x24
1051111f0: 52800042    	mov	w2, #0x2                ; =2
1051111f4: d2800003    	mov	x3, #0x0                ; =0
1051111f8: 52800004    	mov	w4, #0x0                ; =0
1051111fc: 52802fa6    	mov	w6, #0x17d              ; =381
105111200: 94ac57cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111204: f945eae0    	ldr	x0, [x23, #0xbd0] ; MMContext
105111208: aa1303e1    	mov	x1, x19
10511120c: 94ac57cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111210: aa1d03fd    	mov	x29, x29
105111214: 94ac57cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105111218: aa0003f3    	mov	x19, x0
10511121c: f00d8308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105111220: f941bd00    	ldr	x0, [x8, #0x378] ; MainSessionMgr
105111224: aa1403e1    	mov	x1, x20
105111228: 94ac57c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511122c: aa0003e2    	mov	x2, x0
105111230: aa1303e0    	mov	x0, x19
105111234: aa1503e1    	mov	x1, x21
105111238: 94ac57c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511123c: aa1d03fd    	mov	x29, x29
105111240: 94ac57c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105111244: aa0003f4    	mov	x20, x0
105111248: 900d73a8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
10511124c: f9403901    	ldr	x1, [x8, #0x70] ; updateMainSessionListNotify:
105111250: 52800022    	mov	w2, #0x1                ; =1
105111254: 94ac57ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105111258: aa1403e0    	mov	x0, x20
10511125c: 94ac57be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111260: aa1303e0    	mov	x0, x19
105111264: a9487bfd    	ldp	x29, x30, [sp, #0x80]
105111268: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10511126c: a94657f6    	ldp	x22, x21, [sp, #0x60]
105111270: a9455ff8    	ldp	x24, x23, [sp, #0x50]
105111274: a94467fa    	ldp	x26, x25, [sp, #0x40]
105111278: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10511127c: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
105111280: 910243ff    	add	sp, sp, #0x90
105111284: 14ac57b4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105111288: a9487bfd    	ldp	x29, x30, [sp, #0x80]
10511128c: a9474ff4    	ldp	x20, x19, [sp, #0x70]
105111290: a94657f6    	ldp	x22, x21, [sp, #0x60]
105111294: a9455ff8    	ldp	x24, x23, [sp, #0x50]
105111298: a94467fa    	ldp	x26, x25, [sp, #0x40]
10511129c: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1051112a0: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
1051112a4: 910243ff    	add	sp, sp, #0x90
1051112a8: d65f03c0    	ret
