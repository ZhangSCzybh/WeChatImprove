
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a1207d0: d105c3ff    	sub	sp, sp, #0x170
10a1207d4: a9116ffc    	stp	x28, x27, [sp, #0x110]
10a1207d8: a91267fa    	stp	x26, x25, [sp, #0x120]
10a1207dc: a9135ff8    	stp	x24, x23, [sp, #0x130]
10a1207e0: a91457f6    	stp	x22, x21, [sp, #0x140]
10a1207e4: a9154ff4    	stp	x20, x19, [sp, #0x150]
10a1207e8: a9167bfd    	stp	x29, x30, [sp, #0x160]
10a1207ec: 910583fd    	add	x29, sp, #0x160
10a1207f0: aa0203f4    	mov	x20, x2
10a1207f4: aa0003f7    	mov	x23, x0
10a1207f8: f009a668    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a1207fc: f9405908    	ldr	x8, [x8, #0xb0]
10a120800: f9400108    	ldr	x8, [x8]
10a120804: f81a03a8    	stur	x8, [x29, #-0x60]
10a120808: b00b5988    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a12080c: 52800029    	mov	w9, #0x1                ; =1
10a120810: 39176d09    	strb	w9, [x8, #0x5db]
10a120814: aa0203e0    	mov	x0, x2
10a120818: 955ceb0a    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a12081c: b00b02a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a120820: f9434d00    	ldr	x0, [x8, #0x698]
10a120824: 955ceb11    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a120828: aa0003f3    	mov	x19, x0
10a12082c: b00b02a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a120830: f9435100    	ldr	x0, [x8, #0x6a0]
10a120834: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120838: f944b901    	ldr	x1, [x8, #0x970] ; defaultGroup
10a12083c: 955ceb02    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120840: aa1d03fd    	mov	x29, x29
10a120844: 955ceb03    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120848: aa0003f5    	mov	x21, x0
10a12084c: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120850: f944bd01    	ldr	x1, [x8, #0x978] ; initWithEngineGroup:plugin:
10a120854: f00a1c43    	adrp	x3, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
10a120858: 9109a063    	add	x3, x3, #0x268
10a12085c: aa1303e0    	mov	x0, x19
10a120860: aa1503e2    	mov	x2, x21
10a120864: 955ceaf8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120868: aa0003fa    	mov	x26, x0
10a12086c: aa1503e0    	mov	x0, x21
10a120870: 955ceafb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120874: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120878: f945e900    	ldr	x0, [x8, #0xbd0]
10a12087c: 900aff08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a120880: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a120884: 955ceaf0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120888: aa1d03fd    	mov	x29, x29
10a12088c: 955ceaf1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120890: aa0003f3    	mov	x19, x0
10a120894: b00b0308    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a120898: f9418d00    	ldr	x0, [x8, #0x318]
10a12089c: f00afee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a1208a0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a1208a4: 955ceae8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1208a8: aa0003e2    	mov	x2, x0
10a1208ac: b00ae8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a1208b0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a1208b4: aa1303e0    	mov	x0, x19
10a1208b8: 955ceae3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1208bc: aa1d03fd    	mov	x29, x29
10a1208c0: 955ceae4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1208c4: aa0003f5    	mov	x21, x0
10a1208c8: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1208cc: f9437501    	ldr	x1, [x8, #0x6e8] ; getSessionId
10a1208d0: 955ceadd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1208d4: aa1d03fd    	mov	x29, x29
10a1208d8: 955ceade    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1208dc: aa0003f8    	mov	x24, x0
10a1208e0: aa1503e0    	mov	x0, x21
10a1208e4: 955ceade    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1208e8: aa1303e0    	mov	x0, x19
10a1208ec: 955ceadc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1208f0: f00aff08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a1208f4: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a1208f8: aa1803e0    	mov	x0, x24
10a1208fc: 955cead2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120900: b50002a0    	cbnz	x0, 0x10a120954 <_Flutter_MMFoundation_BindContext+0x65fc538>
10a120904: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120908: f9454513    	ldr	x19, [x8, #0xa88]
10a12090c: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120910: f9467900    	ldr	x0, [x8, #0xcf0]
10a120914: 900ae908    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10a120918: f942c501    	ldr	x1, [x8, #0x588] ; genCurrentTimeInMsFrom1970
10a12091c: 955ceaca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120920: d00aff48    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a120924: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10a120928: f90003e0    	str	x0, [sp]
10a12092c: d00a4902    	adrp	x2, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a120930: 913e2042    	add	x2, x2, #0xf88
10a120934: aa1303e0    	mov	x0, x19
10a120938: 955ceac3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12093c: aa1d03fd    	mov	x29, x29
10a120940: 955ceac4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120944: aa0003f3    	mov	x19, x0
10a120948: aa1803e0    	mov	x0, x24
10a12094c: 955ceac4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120950: aa1303f8    	mov	x24, x19
10a120954: f00a1d28    	adrp	x8, 0x11e4c7000 <dyld_stub_binder+0x11e4c7000>
10a120958: 910ba108    	add	x8, x8, #0x2e8
10a12095c: f81603a8    	stur	x8, [x29, #-0xa0]
10a120960: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120964: f9471100    	ldr	x0, [x8, #0xe20]
10a120968: b00ae8e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a12096c: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
10a120970: 955ceab5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120974: aa1d03fd    	mov	x29, x29
10a120978: 955ceab6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a12097c: aa0003f3    	mov	x19, x0
10a120980: b00a2548    	adrp	x8, 0x11e5c9000 <dyld_stub_binder+0x11e5c9000>
10a120984: 9126a108    	add	x8, x8, #0x9a8
10a120988: f00a1bc9    	adrp	x9, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10a12098c: 91032129    	add	x9, x9, #0xc8
10a120990: f100029f    	cmp	x20, #0x0
10a120994: 9a940129    	csel	x9, x9, x20, eq
10a120998: a93827a0    	stp	x0, x9, [x29, #-0x80]
10a12099c: d00a4909    	adrp	x9, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a1209a0: 913ea129    	add	x9, x9, #0xfa8
10a1209a4: a936a7a8    	stp	x8, x9, [x29, #-0x98]
10a1209a8: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a1209ac: f9458900    	ldr	x0, [x8, #0xb10]
10a1209b0: 900aff28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a1209b4: f9479501    	ldr	x1, [x8, #0xf28] ; numberWithBool:
10a1209b8: 52800002    	mov	w2, #0x0                ; =0
10a1209bc: 955ceaa2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1209c0: aa1d03fd    	mov	x29, x29
10a1209c4: 955ceaa3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1209c8: aa0003f5    	mov	x21, x0
10a1209cc: d00a4908    	adrp	x8, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a1209d0: 913f2108    	add	x8, x8, #0xfc8
10a1209d4: f81783a8    	stur	x8, [x29, #-0x88]
10a1209d8: a93963a0    	stp	x0, x24, [x29, #-0x70]
10a1209dc: f90023f8    	str	x24, [sp, #0x40]
10a1209e0: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a1209e4: f9457500    	ldr	x0, [x8, #0xae8]
10a1209e8: b00aff08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a1209ec: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
10a1209f0: d10203a2    	sub	x2, x29, #0x80
10a1209f4: d10283a3    	sub	x3, x29, #0xa0
10a1209f8: 52800084    	mov	w4, #0x4                ; =4
10a1209fc: 955cea92    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120a00: aa1d03fd    	mov	x29, x29
10a120a04: 955cea93    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120a08: aa0003f8    	mov	x24, x0
10a120a0c: aa1503e0    	mov	x0, x21
10a120a10: 955cea93    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120a14: aa1303e0    	mov	x0, x19
10a120a18: 955cea91    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120a1c: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120a20: f944c101    	ldr	x1, [x8, #0x980] ; push:arguments:
10a120a24: d00a4902    	adrp	x2, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a120a28: 910da042    	add	x2, x2, #0x368
10a120a2c: aa1a03e0    	mov	x0, x26
10a120a30: f9001ff8    	str	x24, [sp, #0x38]
10a120a34: aa1803e3    	mov	x3, x24
10a120a38: 955cea83    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120a3c: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120a40: f9453500    	ldr	x0, [x8, #0xa68]
10a120a44: b00ae8c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a120a48: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a120a4c: d00a4908    	adrp	x8, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a120a50: 913fa108    	add	x8, x8, #0xfe8
10a120a54: f90027f4    	str	x20, [sp, #0x48]
10a120a58: a90053e8    	stp	x8, x20, [sp]
10a120a5c: b008df65    	adrp	x5, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a120a60: 9102e8a5    	add	x5, x5, #0xba
10a120a64: b008df67    	adrp	x7, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a120a68: 910f7ce7    	add	x7, x7, #0x3df
10a120a6c: 52800042    	mov	w2, #0x2                ; =2
10a120a70: d2800003    	mov	x3, #0x0                ; =0
10a120a74: 52800004    	mov	w4, #0x0                ; =0
10a120a78: 52800ea6    	mov	w6, #0x75               ; =117
10a120a7c: 955cea72    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120a80: f00b0388    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a120a84: f9432900    	ldr	x0, [x8, #0x650]
10a120a88: 955cea76    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120a8c: aa0003f4    	mov	x20, x0
10a120a90: f00aff28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a120a94: f9451513    	ldr	x19, [x8, #0xa28] ; setDelegate:
10a120a98: aa1303e1    	mov	x1, x19
10a120a9c: aa1703e2    	mov	x2, x23
10a120aa0: 955cea69    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120aa4: d00b0448    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
10a120aa8: f9429500    	ldr	x0, [x8, #0x528]
10a120aac: 955cea6d    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120ab0: aa0003f8    	mov	x24, x0
10a120ab4: aa1303e1    	mov	x1, x19
10a120ab8: aa1703e2    	mov	x2, x23
10a120abc: 955cea62    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120ac0: b00b02c8    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
10a120ac4: f940d500    	ldr	x0, [x8, #0x1a8]
10a120ac8: 955cea66    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120acc: aa0003f9    	mov	x25, x0
10a120ad0: aa1303e1    	mov	x1, x19
10a120ad4: aa1703e2    	mov	x2, x23
10a120ad8: 955cea5b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120adc: d00b02a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a120ae0: f946fd00    	ldr	x0, [x8, #0xdf8]
10a120ae4: 955cea5f    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120ae8: f9000fe0    	str	x0, [sp, #0x18]
10a120aec: f90033e0    	str	x0, [sp, #0x60]
10a120af0: f00b0388    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a120af4: f9431100    	ldr	x0, [x8, #0x620]
10a120af8: 955cea5a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120afc: aa0003fc    	mov	x28, x0
10a120b00: f90037e0    	str	x0, [sp, #0x68]
10a120b04: f00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a120b08: f9429900    	ldr	x0, [x8, #0x530] ; Xw.
10a120b0c: 955cea55    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b10: f9000bf7    	str	x23, [sp, #0x10]
10a120b14: aa0003f7    	mov	x23, x0
10a120b18: a90753e0    	stp	x0, x20, [sp, #0x70]
10a120b1c: f9001bf4    	str	x20, [sp, #0x30]
10a120b20: f00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a120b24: f9429d00    	ldr	x0, [x8, #0x538]
10a120b28: 955cea4e    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b2c: aa0003f5    	mov	x21, x0
10a120b30: a90867e0    	stp	x0, x25, [sp, #0x80]
10a120b34: f90013f9    	str	x25, [sp, #0x20]
10a120b38: f00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a120b3c: f942a100    	ldr	x0, [x8, #0x540]
10a120b40: 955cea48    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b44: aa0003f6    	mov	x22, x0
10a120b48: f9004be0    	str	x0, [sp, #0x90]
10a120b4c: f00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a120b50: f942a500    	ldr	x0, [x8, #0x548]
10a120b54: 955cea43    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b58: aa0003f3    	mov	x19, x0
10a120b5c: a909e3e0    	stp	x0, x24, [sp, #0x98]
10a120b60: f90017f8    	str	x24, [sp, #0x28]
10a120b64: f00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a120b68: f942a900    	ldr	x0, [x8, #0x550] ; 8y.
10a120b6c: 955cea3d    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b70: aa0003f4    	mov	x20, x0
10a120b74: f90057e0    	str	x0, [sp, #0xa8]
10a120b78: d00b02e8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
10a120b7c: f947d100    	ldr	x0, [x8, #0xfa0]
10a120b80: 955cea38    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b84: aa0003f8    	mov	x24, x0
10a120b88: f9005be0    	str	x0, [sp, #0xb0]
10a120b8c: f00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a120b90: f942ad00    	ldr	x0, [x8, #0x558]
10a120b94: 955cea33    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a120b98: aa0003f9    	mov	x25, x0
10a120b9c: f9005fe0    	str	x0, [sp, #0xb8]
10a120ba0: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120ba4: f9456d00    	ldr	x0, [x8, #0xad8]
10a120ba8: f00afee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a120bac: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
10a120bb0: 910183e2    	add	x2, sp, #0x60
10a120bb4: 52800183    	mov	w3, #0xc                ; =12
10a120bb8: 955cea23    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120bbc: aa1d03fd    	mov	x29, x29
10a120bc0: 955cea24    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120bc4: aa0003fb    	mov	x27, x0
10a120bc8: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120bcc: f944c901    	ldr	x1, [x8, #0x990] ; addPlugins:
10a120bd0: aa1a03e0    	mov	x0, x26
10a120bd4: aa1b03e2    	mov	x2, x27
10a120bd8: 955cea1b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120bdc: aa1b03e0    	mov	x0, x27
10a120be0: 955cea1f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120be4: aa1903e0    	mov	x0, x25
10a120be8: 955cea1d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120bec: aa1803e0    	mov	x0, x24
10a120bf0: 955cea1b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120bf4: aa1403e0    	mov	x0, x20
10a120bf8: 955cea19    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120bfc: aa1303e0    	mov	x0, x19
10a120c00: 955cea17    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c04: aa1603e0    	mov	x0, x22
10a120c08: 955cea15    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c0c: aa1503e0    	mov	x0, x21
10a120c10: 955cea13    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c14: aa1703e0    	mov	x0, x23
10a120c18: 955cea11    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c1c: aa1c03e0    	mov	x0, x28
10a120c20: 955cea0f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c24: f9400fe0    	ldr	x0, [sp, #0x18]
10a120c28: 955cea0d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c2c: 900b05a8    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a120c30: f940a508    	ldr	x8, [x8, #0x148]
10a120c34: f9400be9    	ldr	x9, [sp, #0x10]
10a120c38: a90523e9    	stp	x9, x8, [sp, #0x50]
10a120c3c: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120c40: f944c501    	ldr	x1, [x8, #0x988] ; initWithFlutterInstance:
10a120c44: 910143e0    	add	x0, sp, #0x50
10a120c48: aa1a03e2    	mov	x2, x26
10a120c4c: 955cea00    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a120c50: aa0003f3    	mov	x19, x0
10a120c54: b40000c0    	cbz	x0, 0x10a120c6c <_Flutter_MMFoundation_BindContext+0x65fc850>
10a120c58: 900af368    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10a120c5c: f942ad01    	ldr	x1, [x8, #0x558] ; setInstance:
10a120c60: aa1303e0    	mov	x0, x19
10a120c64: aa1a03e2    	mov	x2, x26
10a120c68: 955ce9f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120c6c: f94013e0    	ldr	x0, [sp, #0x20]
10a120c70: 955ce9fb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c74: f94017e0    	ldr	x0, [sp, #0x28]
10a120c78: 955ce9f9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c7c: f9401be0    	ldr	x0, [sp, #0x30]
10a120c80: 955ce9f7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c84: f9401fe0    	ldr	x0, [sp, #0x38]
10a120c88: 955ce9f5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c8c: f94023e0    	ldr	x0, [sp, #0x40]
10a120c90: 955ce9f3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c94: aa1a03e0    	mov	x0, x26
10a120c98: 955ce9f1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120c9c: f94027e0    	ldr	x0, [sp, #0x48]
10a120ca0: 955ce9ef    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120ca4: f85a03a8    	ldur	x8, [x29, #-0x60]
10a120ca8: f009a669    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a120cac: f9405929    	ldr	x9, [x9, #0xb0]
10a120cb0: f9400129    	ldr	x9, [x9]
10a120cb4: eb08013f    	cmp	x9, x8
10a120cb8: 54000141    	b.ne	0x10a120ce0 <_Flutter_MMFoundation_BindContext+0x65fc8c4>
10a120cbc: aa1303e0    	mov	x0, x19
10a120cc0: a9567bfd    	ldp	x29, x30, [sp, #0x160]
10a120cc4: a9554ff4    	ldp	x20, x19, [sp, #0x150]
10a120cc8: a95457f6    	ldp	x22, x21, [sp, #0x140]
10a120ccc: a9535ff8    	ldp	x24, x23, [sp, #0x130]
10a120cd0: a95267fa    	ldp	x26, x25, [sp, #0x120]
10a120cd4: a9516ffc    	ldp	x28, x27, [sp, #0x110]
10a120cd8: 9105c3ff    	add	sp, sp, #0x170
10a120cdc: d65f03c0    	ret
10a120ce0: 955ce9e7    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
