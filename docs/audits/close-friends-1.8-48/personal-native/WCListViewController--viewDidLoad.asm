
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109015df4: d10203ff    	sub	sp, sp, #0x80
109015df8: a9026ffc    	stp	x28, x27, [sp, #0x20]
109015dfc: a90367fa    	stp	x26, x25, [sp, #0x30]
109015e00: a9045ff8    	stp	x24, x23, [sp, #0x40]
109015e04: a90557f6    	stp	x22, x21, [sp, #0x50]
109015e08: a9064ff4    	stp	x20, x19, [sp, #0x60]
109015e0c: a9077bfd    	stp	x29, x30, [sp, #0x70]
109015e10: 9101c3fd    	add	x29, sp, #0x70
109015e14: aa0003f3    	mov	x19, x0
109015e18: 900be1c8    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
109015e1c: 52800029    	mov	w9, #0x1                ; =1
109015e20: 393b9909    	strb	w9, [x8, #0xee6]
109015e24: 900b8de8    	adrp	x8, 0x1201d1000 <dyld_stub_binder+0x1201d1000>
109015e28: f9414d08    	ldr	x8, [x8, #0x298]
109015e2c: a90123e0    	stp	x0, x8, [sp, #0x10]
109015e30: f00b7128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109015e34: f941a901    	ldr	x1, [x8, #0x350] ; viewDidLoad
109015e38: 910043e0    	add	x0, sp, #0x10
109015e3c: 95a11584    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
109015e40: d00b8ae8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109015e44: f9453500    	ldr	x0, [x8, #0xa68]
109015e48: 900b7128    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109015e4c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109015e50: d00ab728    	adrp	x8, 0x11e6fb000 <dyld_stub_binder+0x11e6fb000>
109015e54: 91322108    	add	x8, x8, #0xc88
109015e58: f90003e8    	str	x8, [sp]
109015e5c: f0091023    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
109015e60: 912b2863    	add	x3, x3, #0xaca
109015e64: f0096065    	adrp	x5, 0x11bc24000 <dyld_stub_binder+0x11bc24000>
109015e68: 910028a5    	add	x5, x5, #0xa
109015e6c: f0096067    	adrp	x7, 0x11bc24000 <dyld_stub_binder+0x11bc24000>
109015e70: 910088e7    	add	x7, x7, #0x22
109015e74: 52800042    	mov	w2, #0x2                ; =2
109015e78: 52800004    	mov	w4, #0x0                ; =0
109015e7c: 52800d86    	mov	w6, #0x6c               ; =108
109015e80: 95a11571    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015e84: f00b93c8    	adrp	x8, 0x120290000 <dyld_stub_binder+0x120290000>
109015e88: 910e4108    	add	x8, x8, #0x390
109015e8c: b9800108    	ldrsw	x8, [x8]
109015e90: 52800069    	mov	w9, #0x3                ; =3
109015e94: b8286a69    	str	w9, [x19, x8]
109015e98: b00b7ee8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
109015e9c: f9440914    	ldr	x20, [x8, #0x810] ; homepageType
109015ea0: aa1303e0    	mov	x0, x19
109015ea4: aa1403e1    	mov	x1, x20
109015ea8: 95a11567    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015eac: f00b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109015eb0: d00b8afc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
109015eb4: f00b8759    	adrp	x25, 0x120100000 <dyld_stub_binder+0x120100000>
109015eb8: d00b875a    	adrp	x26, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
109015ebc: 900b7138    	adrp	x24, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109015ec0: f100041f    	cmp	x0, #0x1
109015ec4: 54000521    	b.ne	0x109015f68 <_Flutter_MMFoundation_BindContext+0x54f1b4c>
109015ec8: b9863908    	ldrsw	x8, [x8, #0x638]
109015ecc: 38686a77    	ldrb	w23, [x19, x8]
109015ed0: f945eb80    	ldr	x0, [x28, #0xbd0]
109015ed4: f944eb21    	ldr	x1, [x25, #0x9d0] ; currentContext
109015ed8: 95a1155b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015edc: aa1d03fd    	mov	x29, x29
109015ee0: 95a1155c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109015ee4: aa0003f5    	mov	x21, x0
109015ee8: d00b8ae8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109015eec: f9462900    	ldr	x0, [x8, #0xc50]
109015ef0: f947af41    	ldr	x1, [x26, #0xf58] ; class
109015ef4: 95a11554    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015ef8: aa0003e2    	mov	x2, x0
109015efc: f9464301    	ldr	x1, [x24, #0xc80] ; getService:
109015f00: aa1503e0    	mov	x0, x21
109015f04: 95a11550    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015f08: aa1d03fd    	mov	x29, x29
109015f0c: 95a11551    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109015f10: aa0003f6    	mov	x22, x0
109015f14: 900b7128    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109015f18: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
109015f1c: 710006ff    	cmp	w23, #0x1
109015f20: 540003e1    	b.ne	0x109015f9c <_Flutter_MMFoundation_BindContext+0x54f1b80>
109015f24: b00acd22    	adrp	x2, 0x11e9ba000 <dyld_stub_binder+0x11e9ba000>
109015f28: 91392042    	add	x2, x2, #0xe48
109015f2c: aa1603e0    	mov	x0, x22
109015f30: 95a11545    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015f34: aa1d03fd    	mov	x29, x29
109015f38: 95a11546    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109015f3c: aa0003f7    	mov	x23, x0
109015f40: 900b87a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109015f44: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
109015f48: aa1303e0    	mov	x0, x19
109015f4c: aa1703e2    	mov	x2, x23
109015f50: 95a1153d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015f54: aa1703e0    	mov	x0, x23
109015f58: 95a11541    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109015f5c: aa1603e0    	mov	x0, x22
109015f60: 95a1153f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109015f64: 1400003d    	b	0x109016058 <_Flutter_MMFoundation_BindContext+0x54f1c3c>
109015f68: 900b8768    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
109015f6c: f940e901    	ldr	x1, [x8, #0x1d0] ; displayTitle
109015f70: aa1303e0    	mov	x0, x19
109015f74: 95a11534    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015f78: aa1d03fd    	mov	x29, x29
109015f7c: 95a11535    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109015f80: aa0003f5    	mov	x21, x0
109015f84: 900b87a8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
109015f88: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
109015f8c: aa1303e0    	mov	x0, x19
109015f90: aa1503e2    	mov	x2, x21
109015f94: 95a1152c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015f98: 14000030    	b	0x109016058 <_Flutter_MMFoundation_BindContext+0x54f1c3c>
109015f9c: b00acd22    	adrp	x2, 0x11e9ba000 <dyld_stub_binder+0x11e9ba000>
109015fa0: 9139a042    	add	x2, x2, #0xe68
109015fa4: aa1603e0    	mov	x0, x22
109015fa8: 95a11527    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015fac: aa1d03fd    	mov	x29, x29
109015fb0: 95a11528    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109015fb4: aa0003f7    	mov	x23, x0
109015fb8: d00b8288    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109015fbc: f9438901    	ldr	x1, [x8, #0x710] ; rightTitleLabelWithTitle:
109015fc0: aa1303e0    	mov	x0, x19
109015fc4: aa1703e2    	mov	x2, x23
109015fc8: 95a1151f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109015fcc: aa1d03fd    	mov	x29, x29
109015fd0: 95a11520    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109015fd4: aa1803fb    	mov	x27, x24
109015fd8: aa0003f8    	mov	x24, x0
109015fdc: aa1703e0    	mov	x0, x23
109015fe0: 95a1151f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109015fe4: aa1603e0    	mov	x0, x22
109015fe8: 95a1151d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109015fec: aa1503e0    	mov	x0, x21
109015ff0: 95a1151b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109015ff4: d00b8288    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
109015ff8: f9438d01    	ldr	x1, [x8, #0x718] ; contactDisplayname
109015ffc: aa1303e0    	mov	x0, x19
109016000: 95a11511    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016004: aa1d03fd    	mov	x29, x29
109016008: 95a11512    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901600c: aa0003f5    	mov	x21, x0
109016010: b00b87a8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
109016014: f947a501    	ldr	x1, [x8, #0xf48] ; width
109016018: aa1803e0    	mov	x0, x24
10901601c: 95a1150a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016020: 1e7c1001    	fmov	d1, #-0.50000000
109016024: 1e610800    	fmul	d0, d0, d1
109016028: b00b8288    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10901602c: f9439101    	ldr	x1, [x8, #0x720] ; setTitle:subTitle:leftLoading:rightView:titleOffset:
109016030: aa1303e0    	mov	x0, x19
109016034: aa1503e2    	mov	x2, x21
109016038: d2800003    	mov	x3, #0x0                ; =0
10901603c: 52800004    	mov	w4, #0x0                ; =0
109016040: aa1803e5    	mov	x5, x24
109016044: 95a11500    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016048: aa1503e0    	mov	x0, x21
10901604c: 95a11504    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109016050: aa1803f5    	mov	x21, x24
109016054: aa1b03f8    	mov	x24, x27
109016058: aa1503e0    	mov	x0, x21
10901605c: 95a11500    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109016060: d00b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109016064: b9863d15    	ldrsw	x21, [x8, #0x63c]
109016068: f8756a60    	ldr	x0, [x19, x21]
10901606c: b00b7128    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
109016070: f9434d1b    	ldr	x27, [x8, #0x698] ; m_nsUsrName
109016074: aa1b03e1    	mov	x1, x27
109016078: 95a114f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901607c: aa1d03fd    	mov	x29, x29
109016080: 95a114f4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109016084: aa0003f6    	mov	x22, x0
109016088: 95a114f5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901608c: b50000f6    	cbnz	x22, 0x1090160a8 <_Flutter_MMFoundation_BindContext+0x54f1c8c>
109016090: f8756a60    	ldr	x0, [x19, x21]
109016094: d00b7128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
109016098: f945fd01    	ldr	x1, [x8, #0xbf8] ; setM_nsUsrName:
10901609c: b00aa422    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1090160a0: 91032042    	add	x2, x2, #0xc8
1090160a4: 95a114e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090160a8: f945eb80    	ldr	x0, [x28, #0xbd0]
1090160ac: f944eb36    	ldr	x22, [x25, #0x9d0] ; currentContext
1090160b0: aa1603e1    	mov	x1, x22
1090160b4: 95a114e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090160b8: aa1d03fd    	mov	x29, x29
1090160bc: 95a114e5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1090160c0: aa0003f9    	mov	x25, x0
1090160c4: d00b8ae8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1090160c8: f9428500    	ldr	x0, [x8, #0x508]
1090160cc: f947af57    	ldr	x23, [x26, #0xf58] ; class
1090160d0: aa1703e1    	mov	x1, x23
1090160d4: 95a114dc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090160d8: aa0003e2    	mov	x2, x0
1090160dc: f9464318    	ldr	x24, [x24, #0xc80] ; getService:
1090160e0: aa1903e0    	mov	x0, x25
1090160e4: aa1803e1    	mov	x1, x24
1090160e8: 95a114d7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090160ec: aa1d03fd    	mov	x29, x29
1090160f0: 95a114d8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1090160f4: aa0003fa    	mov	x26, x0
1090160f8: f8756a60    	ldr	x0, [x19, x21]
1090160fc: f90007fb    	str	x27, [sp, #0x8]
109016100: aa1b03e1    	mov	x1, x27
109016104: 95a114d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016108: aa1d03fd    	mov	x29, x29
10901610c: 95a114d1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109016110: aa0003fb    	mov	x27, x0
109016114: aa1303e0    	mov	x0, x19
109016118: aa1403e1    	mov	x1, x20
10901611c: 95a114ca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016120: aa0003e3    	mov	x3, x0
109016124: 900b7f88    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
109016128: f9400901    	ldr	x1, [x8, #0x10] ; beginHomepage:type:
10901612c: aa1a03e0    	mov	x0, x26
109016130: aa1b03e2    	mov	x2, x27
109016134: 95a114c4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016138: aa1b03e0    	mov	x0, x27
10901613c: 95a114c8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109016140: aa1a03e0    	mov	x0, x26
109016144: 95a114c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109016148: aa1903e0    	mov	x0, x25
10901614c: 95a114c4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109016150: f00b7288    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
109016154: f940a101    	ldr	x1, [x8, #0x140] ; initData:
109016158: aa1303e0    	mov	x0, x19
10901615c: 52800022    	mov	w2, #0x1                ; =1
109016160: 95a114b9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016164: d00b9268    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
109016168: b9863908    	ldrsw	x8, [x8, #0x638]
10901616c: 38686a68    	ldrb	w8, [x19, x8]
109016170: 7100051f    	cmp	w8, #0x1
109016174: 54000421    	b.ne	0x1090161f8 <_Flutter_MMFoundation_BindContext+0x54f1ddc>
109016178: f945eb80    	ldr	x0, [x28, #0xbd0]
10901617c: aa1603e1    	mov	x1, x22
109016180: 95a114b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016184: aa1d03fd    	mov	x29, x29
109016188: 95a114b2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901618c: aa0003f4    	mov	x20, x0
109016190: 900b8b08    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
109016194: f946d100    	ldr	x0, [x8, #0xda0] ;  h>
109016198: aa1703e1    	mov	x1, x23
10901619c: 95a114aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090161a0: aa0003e2    	mov	x2, x0
1090161a4: aa1403e0    	mov	x0, x20
1090161a8: aa1803e1    	mov	x1, x24
1090161ac: 95a114a6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090161b0: aa1d03fd    	mov	x29, x29
1090161b4: 95a114a7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1090161b8: aa0003f7    	mov	x23, x0
1090161bc: d00b7ba8    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
1090161c0: f946d501    	ldr	x1, [x8, #0xda8] ; Moments_newAlbumAndNewPreview
1090161c4: 95a114a0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090161c8: aa0003f8    	mov	x24, x0
1090161cc: aa1703e0    	mov	x0, x23
1090161d0: 95a114a3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1090161d4: aa1403e0    	mov	x0, x20
1090161d8: 95a114a1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1090161dc: 340000f8    	cbz	w24, 0x1090161f8 <_Flutter_MMFoundation_BindContext+0x54f1ddc>
1090161e0: f00b8b48    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
1090161e4: f9415d00    	ldr	x0, [x8, #0x2b8]
1090161e8: b00b8288    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
1090161ec: f9439501    	ldr	x1, [x8, #0x728] ; prefetchUserPageInfoWithCompletion:
1090161f0: d2800002    	mov	x2, #0x0                ; =0
1090161f4: 95a11494    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090161f8: b00b73a8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
1090161fc: f943d901    	ldr	x1, [x8, #0x7b0] ; initBarItem
109016200: aa1303e0    	mov	x0, x19
109016204: 95a11490    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016208: b00b8288    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10901620c: f9439901    	ldr	x1, [x8, #0x730] ; reloadStyle
109016210: aa1303e0    	mov	x0, x19
109016214: 95a1148c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016218: f945eb80    	ldr	x0, [x28, #0xbd0]
10901621c: aa1603e1    	mov	x1, x22
109016220: 95a11489    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016224: aa1d03fd    	mov	x29, x29
109016228: 95a1148a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901622c: aa0003f4    	mov	x20, x0
109016230: d00b8ad8    	adrp	x24, 0x120170000 <dyld_stub_binder+0x120170000>
109016234: f947e702    	ldr	x2, [x24, #0xfc8]
109016238: 900b7128    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10901623c: f940a117    	ldr	x23, [x8, #0x140] ; registerExtension:withTarget:
109016240: aa1703e1    	mov	x1, x23
109016244: aa1303e3    	mov	x3, x19
109016248: 95a1147f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901624c: aa1403e0    	mov	x0, x20
109016250: 95a11483    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109016254: f945eb80    	ldr	x0, [x28, #0xbd0]
109016258: aa1603e1    	mov	x1, x22
10901625c: 95a1147a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109016260: aa1d03fd    	mov	x29, x29
109016264: 95a1147b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109016268: aa0003f4    	mov	x20, x0
10901626c: f947e718    	ldr	x24, [x24, #0xfc8]
109016270: f8756a60    	ldr	x0, [x19, x21]
109016274: f94007e1    	ldr	x1, [sp, #0x8]
109016278: 95a11473    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901627c: aa1d03fd    	mov	x29, x29
109016280: 95a11474    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109016284: aa0003f5    	mov	x21, x0
109016288: d00b7128    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10901628c: f943c501    	ldr	x1, [x8, #0x788] ; registerExtension:withKey:withTarget:
109016290: aa1403e0    	mov	x0, x20
109016294: aa1803e2    	mov	x2, x24
109016298: aa1503e3    	mov	x3, x21
10901629c: aa1303e4    	mov	x4, x19
1090162a0: 95a11469    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090162a4: aa1503e0    	mov	x0, x21
1090162a8: 95a1146d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1090162ac: aa1403e0    	mov	x0, x20
1090162b0: 95a1146b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1090162b4: f945eb80    	ldr	x0, [x28, #0xbd0]
1090162b8: aa1603e1    	mov	x1, x22
1090162bc: 95a11462    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090162c0: aa1d03fd    	mov	x29, x29
1090162c4: 95a11463    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1090162c8: aa0003f4    	mov	x20, x0
1090162cc: f00b8ac8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
1090162d0: f9465502    	ldr	x2, [x8, #0xca8]
1090162d4: aa1703e1    	mov	x1, x23
1090162d8: aa1303e3    	mov	x3, x19
1090162dc: 95a1145a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090162e0: aa1403e0    	mov	x0, x20
1090162e4: 95a1145e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1090162e8: b00b8288    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
1090162ec: f9439d01    	ldr	x1, [x8, #0x738] ; reportOnBeign
1090162f0: aa1303e0    	mov	x0, x19
1090162f4: 95a11454    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1090162f8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1090162fc: a9464ff4    	ldp	x20, x19, [sp, #0x60]
109016300: a94557f6    	ldp	x22, x21, [sp, #0x50]
109016304: a9445ff8    	ldp	x24, x23, [sp, #0x40]
109016308: a94367fa    	ldp	x26, x25, [sp, #0x30]
10901630c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
109016310: 910203ff    	add	sp, sp, #0x80
109016314: d65f03c0    	ret
