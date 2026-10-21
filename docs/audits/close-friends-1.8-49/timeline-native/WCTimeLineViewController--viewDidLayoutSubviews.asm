
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0bae80: d102c3ff    	sub	sp, sp, #0xb0
10a0bae84: 6d032beb    	stp	d11, d10, [sp, #0x30]
10a0bae88: 6d0423e9    	stp	d9, d8, [sp, #0x40]
10a0bae8c: a9056ffc    	stp	x28, x27, [sp, #0x50]
10a0bae90: a90667fa    	stp	x26, x25, [sp, #0x60]
10a0bae94: a9075ff8    	stp	x24, x23, [sp, #0x70]
10a0bae98: a90857f6    	stp	x22, x21, [sp, #0x80]
10a0bae9c: a9094ff4    	stp	x20, x19, [sp, #0x90]
10a0baea0: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
10a0baea4: 910283fd    	add	x29, sp, #0xa0
10a0baea8: aa0003f3    	mov	x19, x0
10a0baeac: f00b5ca8    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0baeb0: 52800029    	mov	w9, #0x1                ; =1
10a0baeb4: 3911e909    	strb	w9, [x8, #0x47a]
10a0baeb8: d00b08c8    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a0baebc: f9406908    	ldr	x8, [x8, #0xd0]
10a0baec0: a90223e0    	stp	x0, x8, [sp, #0x20]
10a0baec4: d00aec08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0baec8: f941a101    	ldr	x1, [x8, #0x340] ; viewDidLayoutSubviews
10a0baecc: 910083e0    	add	x0, sp, #0x20
10a0baed0: 955e815f    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a0baed4: 900b0288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0baed8: f947bd14    	ldr	x20, [x8, #0xf78] ; tableView
10a0baedc: aa1303e0    	mov	x0, x19
10a0baee0: aa1403e1    	mov	x1, x20
10a0baee4: 955e8158    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baee8: aa1d03fd    	mov	x29, x29
10a0baeec: 955e8159    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0baef0: aa0003f6    	mov	x22, x0
10a0baef4: 900b0288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0baef8: f9475d15    	ldr	x21, [x8, #0xeb8] ; superview
10a0baefc: aa1503e1    	mov	x1, x21
10a0baf00: 955e8151    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baf04: aa1d03fd    	mov	x29, x29
10a0baf08: 955e8152    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0baf0c: aa0003f7    	mov	x23, x0
10a0baf10: 955e8153    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0baf14: aa1603e0    	mov	x0, x22
10a0baf18: 955e8151    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0baf1c: b00b029b    	adrp	x27, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0baf20: b00b029a    	adrp	x26, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0baf24: b40007d7    	cbz	x23, 0x10a0bb01c <_Flutter_MMFoundation_BindContext+0x6596c00>
10a0baf28: aa1303e0    	mov	x0, x19
10a0baf2c: aa1403e1    	mov	x1, x20
10a0baf30: 955e8145    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baf34: aa1d03fd    	mov	x29, x29
10a0baf38: 955e8146    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0baf3c: aa0003f6    	mov	x22, x0
10a0baf40: b00aec28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10a0baf44: f946a518    	ldr	x24, [x8, #0xd48] ; top
10a0baf48: aa1803e1    	mov	x1, x24
10a0baf4c: 955e813e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baf50: 1e604008    	fmov	d8, d0
10a0baf54: 1e602008    	fcmp	d0, #0.0
10a0baf58: 54000160    	b.eq	0x10a0baf84 <_Flutter_MMFoundation_BindContext+0x6596b68>
10a0baf5c: aa1303e0    	mov	x0, x19
10a0baf60: aa1403e1    	mov	x1, x20
10a0baf64: 955e8138    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baf68: aa1d03fd    	mov	x29, x29
10a0baf6c: 955e8139    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0baf70: aa0003f7    	mov	x23, x0
10a0baf74: aa1803e1    	mov	x1, x24
10a0baf78: 955e8133    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baf7c: 1e604009    	fmov	d9, d0
10a0baf80: 14000002    	b	0x10a0baf88 <_Flutter_MMFoundation_BindContext+0x6596b6c>
10a0baf84: 9e6703e9    	fmov	d9, xzr
10a0baf88: f946d761    	ldr	x1, [x27, #0xda8] ; view
10a0baf8c: aa1303e0    	mov	x0, x19
10a0baf90: 955e812d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baf94: aa1d03fd    	mov	x29, x29
10a0baf98: 955e812e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0baf9c: aa0003f8    	mov	x24, x0
10a0bafa0: f947a741    	ldr	x1, [x26, #0xf48] ; width
10a0bafa4: 955e8128    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bafa8: 1e60400a    	fmov	d10, d0
10a0bafac: d00aec08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0bafb0: f9419501    	ldr	x1, [x8, #0x328] ; getVisibleHeight
10a0bafb4: aa1303e0    	mov	x0, x19
10a0bafb8: 955e8123    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bafbc: 1e60400b    	fmov	d11, d0
10a0bafc0: aa1303e0    	mov	x0, x19
10a0bafc4: aa1403e1    	mov	x1, x20
10a0bafc8: 955e811f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bafcc: aa1d03fd    	mov	x29, x29
10a0bafd0: 955e8120    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bafd4: aa0003f9    	mov	x25, x0
10a0bafd8: d00b0268    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0bafdc: f9403501    	ldr	x1, [x8, #0x68] ; setFrame:
10a0bafe0: 9e6703e0    	fmov	d0, xzr
10a0bafe4: 1e604121    	fmov	d1, d9
10a0bafe8: 1e604142    	fmov	d2, d10
10a0bafec: 1e604163    	fmov	d3, d11
10a0baff0: 955e8115    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0baff4: aa1903e0    	mov	x0, x25
10a0baff8: 955e8119    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0baffc: aa1803e0    	mov	x0, x24
10a0bb000: 955e8117    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb004: 1e602108    	fcmp	d8, #0.0
10a0bb008: 54000060    	b.eq	0x10a0bb014 <_Flutter_MMFoundation_BindContext+0x6596bf8>
10a0bb00c: aa1703e0    	mov	x0, x23
10a0bb010: 955e8113    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb014: aa1603e0    	mov	x0, x22
10a0bb018: 955e8111    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb01c: d00afee8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bb020: f941b916    	ldr	x22, [x8, #0x370] ; plainTextFullScreenView
10a0bb024: aa1303e0    	mov	x0, x19
10a0bb028: aa1603e1    	mov	x1, x22
10a0bb02c: 955e8106    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb030: aa1d03fd    	mov	x29, x29
10a0bb034: 955e8107    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb038: aa0003f7    	mov	x23, x0
10a0bb03c: aa1503e1    	mov	x1, x21
10a0bb040: 955e8101    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb044: aa1d03fd    	mov	x29, x29
10a0bb048: 955e8102    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb04c: aa0003f5    	mov	x21, x0
10a0bb050: 955e8103    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb054: aa1703e0    	mov	x0, x23
10a0bb058: 955e8101    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb05c: b4000195    	cbz	x21, 0x10a0bb08c <_Flutter_MMFoundation_BindContext+0x6596c70>
10a0bb060: aa1303e0    	mov	x0, x19
10a0bb064: aa1603e1    	mov	x1, x22
10a0bb068: 955e80f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb06c: aa1d03fd    	mov	x29, x29
10a0bb070: 955e80f8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb074: aa0003f5    	mov	x21, x0
10a0bb078: b00b0268    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0bb07c: f947a101    	ldr	x1, [x8, #0xf40] ; setNeedsLayout
10a0bb080: 955e80f1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb084: aa1503e0    	mov	x0, x21
10a0bb088: 955e80f5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb08c: 900b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bb090: f9468d00    	ldr	x0, [x8, #0xd18]
10a0bb094: 900b0248    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a0bb098: f9457d01    	ldr	x1, [x8, #0xaf8] ; isiPad
10a0bb09c: 955e80ea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb0a0: 36000de0    	tbz	w0, #0x0, 0x10a0bb25c <_Flutter_MMFoundation_BindContext+0x6596e40>
10a0bb0a4: f946d761    	ldr	x1, [x27, #0xda8] ; view
10a0bb0a8: aa1303e0    	mov	x0, x19
10a0bb0ac: 955e80e6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb0b0: aa1d03fd    	mov	x29, x29
10a0bb0b4: 955e80e7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb0b8: aa0003f5    	mov	x21, x0
10a0bb0bc: f947a741    	ldr	x1, [x26, #0xf48] ; width
10a0bb0c0: 955e80e1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb0c4: 1e604008    	fmov	d8, d0
10a0bb0c8: aa1303e0    	mov	x0, x19
10a0bb0cc: aa1403e1    	mov	x1, x20
10a0bb0d0: 955e80dd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb0d4: aa1d03fd    	mov	x29, x29
10a0bb0d8: 955e80de    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb0dc: aa0003f4    	mov	x20, x0
10a0bb0e0: f00b0268    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0bb0e4: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
10a0bb0e8: 1e604100    	fmov	d0, d8
10a0bb0ec: 955e80d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb0f0: aa1403e0    	mov	x0, x20
10a0bb0f4: 955e80da    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb0f8: aa1503e0    	mov	x0, x21
10a0bb0fc: 955e80d8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb100: 900b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bb104: f9470100    	ldr	x0, [x8, #0xe00]
10a0bb108: b00aee88    	adrp	x8, 0x11fe8c000 <dyld_stub_binder+0x11fe8c000>
10a0bb10c: f9423501    	ldr	x1, [x8, #0x468] ; mainWindow
10a0bb110: 955e80cd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb114: aa1d03fd    	mov	x29, x29
10a0bb118: 955e80ce    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb11c: aa0003f5    	mov	x21, x0
10a0bb120: f00aec28    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10a0bb124: f9442501    	ldr	x1, [x8, #0x848] ; isKeyWindow
10a0bb128: 955e80c7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb12c: aa0003f4    	mov	x20, x0
10a0bb130: aa1503e0    	mov	x0, x21
10a0bb134: 955e80ca    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb138: f00b05c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a0bb13c: f940a500    	ldr	x0, [x8, #0x148]
10a0bb140: 900aefe8    	adrp	x8, 0x11feb7000 <dyld_stub_binder+0x11feb7000>
10a0bb144: f945e501    	ldr	x1, [x8, #0xbc8] ; isSubSceneActive
10a0bb148: 955e80bf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb14c: 37000054    	tbnz	w20, #0x0, 0x10a0bb154 <_Flutter_MMFoundation_BindContext+0x6596d38>
10a0bb150: 34000300    	cbz	w0, 0x10a0bb1b0 <_Flutter_MMFoundation_BindContext+0x6596d94>
10a0bb154: 900b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bb158: f9453508    	ldr	x8, [x8, #0xa68]
10a0bb15c: d00aebe9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bb160: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0bb164: a90083f4    	stp	x20, x0, [sp, #0x8]
10a0bb168: 900a4c29    	adrp	x9, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a0bb16c: 9136a129    	add	x9, x9, #0xda8
10a0bb170: f90003e9    	str	x9, [sp]
10a0bb174: b0088b03    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0bb178: 912b2863    	add	x3, x3, #0xaca
10a0bb17c: d008e245    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0bb180: 912850a5    	add	x5, x5, #0xa14
10a0bb184: d008e247    	adrp	x7, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0bb188: 91362ce7    	add	x7, x7, #0xd8b
10a0bb18c: aa0803e0    	mov	x0, x8
10a0bb190: 52800042    	mov	w2, #0x2                ; =2
10a0bb194: 52800004    	mov	w4, #0x0                ; =0
10a0bb198: 5280af06    	mov	w6, #0x578              ; =1400
10a0bb19c: 955e80aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb1a0: 900aec08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a0bb1a4: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
10a0bb1a8: aa1303e0    	mov	x0, x19
10a0bb1ac: 955e80a6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb1b0: 900b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bb1b4: f945e900    	ldr	x0, [x8, #0xbd0]
10a0bb1b8: b00b0228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0bb1bc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a0bb1c0: 955e80a1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb1c4: aa1d03fd    	mov	x29, x29
10a0bb1c8: 955e80a2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb1cc: aa0003f4    	mov	x20, x0
10a0bb1d0: f00b05c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a0bb1d4: f946d100    	ldr	x0, [x8, #0xda0] ;  h>
10a0bb1d8: 900b0228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0bb1dc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a0bb1e0: 955e8099    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb1e4: aa0003e2    	mov	x2, x0
10a0bb1e8: d00aebe8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bb1ec: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a0bb1f0: aa1403e0    	mov	x0, x20
10a0bb1f4: 955e8094    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb1f8: aa1d03fd    	mov	x29, x29
10a0bb1fc: 955e8095    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb200: aa0003f5    	mov	x21, x0
10a0bb204: b00af808    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
10a0bb208: f945ed01    	ldr	x1, [x8, #0xbd8] ; Timeline_IPad_Rotation_Fix
10a0bb20c: 955e808e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb210: aa0003f6    	mov	x22, x0
10a0bb214: aa1503e0    	mov	x0, x21
10a0bb218: 955e8091    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb21c: aa1403e0    	mov	x0, x20
10a0bb220: 955e808f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb224: 34000476    	cbz	w22, 0x10a0bb2b0 <_Flutter_MMFoundation_BindContext+0x6596e94>
10a0bb228: b00af808    	adrp	x8, 0x11ffbc000 <dyld_stub_binder+0x11ffbc000>
10a0bb22c: f9467101    	ldr	x1, [x8, #0xce0] ; animateHelper
10a0bb230: aa1303e0    	mov	x0, x19
10a0bb234: 955e8084    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb238: aa1d03fd    	mov	x29, x29
10a0bb23c: 955e8085    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bb240: aa0003f4    	mov	x20, x0
10a0bb244: b00aeca8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
10a0bb248: f946d501    	ldr	x1, [x8, #0xda8] ; refreshLayout
10a0bb24c: 955e807e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb250: aa1403e0    	mov	x0, x20
10a0bb254: 955e8082    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bb258: 14000016    	b	0x10a0bb2b0 <_Flutter_MMFoundation_BindContext+0x6596e94>
10a0bb25c: 900b05c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bb260: f9453500    	ldr	x0, [x8, #0xa68]
10a0bb264: d00aebe8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bb268: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0bb26c: 900a2a08    	adrp	x8, 0x11e5fb000 <dyld_stub_binder+0x11e5fb000>
10a0bb270: 9134a108    	add	x8, x8, #0xd28
10a0bb274: f90003e8    	str	x8, [sp]
10a0bb278: b0088b03    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0bb27c: 912b2863    	add	x3, x3, #0xaca
10a0bb280: d008e245    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0bb284: 912850a5    	add	x5, x5, #0xa14
10a0bb288: d008e247    	adrp	x7, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0bb28c: 91362ce7    	add	x7, x7, #0xd8b
10a0bb290: 52800042    	mov	w2, #0x2                ; =2
10a0bb294: 52800004    	mov	w4, #0x0                ; =0
10a0bb298: 5280ad66    	mov	w6, #0x56b              ; =1387
10a0bb29c: 955e806a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb2a0: 900aec08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a0bb2a4: f9458901    	ldr	x1, [x8, #0xb10] ; reloadTableView
10a0bb2a8: aa1303e0    	mov	x0, x19
10a0bb2ac: 955e8066    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb2b0: f00af1a8    	adrp	x8, 0x11fef2000 <dyld_stub_binder+0x11fef2000>
10a0bb2b4: f9425101    	ldr	x1, [x8, #0x4a0] ; layoutTableFooterView
10a0bb2b8: aa1303e0    	mov	x0, x19
10a0bb2bc: 955e8062    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bb2c0: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
10a0bb2c4: a9494ff4    	ldp	x20, x19, [sp, #0x90]
10a0bb2c8: a94857f6    	ldp	x22, x21, [sp, #0x80]
10a0bb2cc: a9475ff8    	ldp	x24, x23, [sp, #0x70]
10a0bb2d0: a94667fa    	ldp	x26, x25, [sp, #0x60]
10a0bb2d4: a9456ffc    	ldp	x28, x27, [sp, #0x50]
10a0bb2d8: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
10a0bb2dc: 6d432beb    	ldp	d11, d10, [sp, #0x30]
10a0bb2e0: 9102c3ff    	add	sp, sp, #0xb0
10a0bb2e4: d65f03c0    	ret
