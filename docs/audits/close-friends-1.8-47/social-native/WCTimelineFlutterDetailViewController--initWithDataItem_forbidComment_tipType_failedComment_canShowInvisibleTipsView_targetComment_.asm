
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a120d58: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10a120d5c: a90167fa    	stp	x26, x25, [sp, #0x10]
10a120d60: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a120d64: a90357f6    	stp	x22, x21, [sp, #0x30]
10a120d68: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a120d6c: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a120d70: 910143fd    	add	x29, sp, #0x50
10a120d74: d106c3ff    	sub	sp, sp, #0x1b0
10a120d78: aa0703f5    	mov	x21, x7
10a120d7c: aa0603fa    	mov	x26, x6
10a120d80: aa0503f3    	mov	x19, x5
10a120d84: aa0403f7    	mov	x23, x4
10a120d88: aa0303fc    	mov	x28, x3
10a120d8c: aa0203f6    	mov	x22, x2
10a120d90: f90043e0    	str	x0, [sp, #0x80]
10a120d94: f009a668    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a120d98: f9405908    	ldr	x8, [x8, #0xb0]
10a120d9c: f9400108    	ldr	x8, [x8]
10a120da0: f81a03a8    	stur	x8, [x29, #-0x60]
10a120da4: b00b5988    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a120da8: 52800029    	mov	w9, #0x1                ; =1
10a120dac: 39177109    	strb	w9, [x8, #0x5dc]
10a120db0: aa0203e0    	mov	x0, x2
10a120db4: 955ce9a3    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a120db8: f90057f3    	str	x19, [sp, #0xa8]
10a120dbc: aa1303e0    	mov	x0, x19
10a120dc0: 955ce9a0    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a120dc4: b00b02a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a120dc8: f9434d13    	ldr	x19, [x8, #0x698]
10a120dcc: aa1503e0    	mov	x0, x21
10a120dd0: 955ce99c    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a120dd4: aa1303e0    	mov	x0, x19
10a120dd8: 955ce9a4    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a120ddc: aa0003f3    	mov	x19, x0
10a120de0: b00b02a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a120de4: f9435100    	ldr	x0, [x8, #0x6a0]
10a120de8: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120dec: f944b901    	ldr	x1, [x8, #0x970] ; defaultGroup
10a120df0: 955ce995    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120df4: aa1d03fd    	mov	x29, x29
10a120df8: 955ce996    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120dfc: aa0003f4    	mov	x20, x0
10a120e00: 900ae928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a120e04: f944bd01    	ldr	x1, [x8, #0x978] ; initWithEngineGroup:plugin:
10a120e08: f00a1c43    	adrp	x3, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
10a120e0c: 9109a063    	add	x3, x3, #0x268
10a120e10: aa1303e0    	mov	x0, x19
10a120e14: aa1403e2    	mov	x2, x20
10a120e18: 955ce98b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120e1c: aa0003f3    	mov	x19, x0
10a120e20: aa1403e0    	mov	x0, x20
10a120e24: 955ce98e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120e28: aa1603e0    	mov	x0, x22
10a120e2c: 940001af    	bl	0x10a1214e8 <_Flutter_MMFoundation_BindContext+0x65fd0cc>
10a120e30: aa0003f4    	mov	x20, x0
10a120e34: f00a1bd8    	adrp	x24, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10a120e38: 91032318    	add	x24, x24, #0xc8
10a120e3c: f90053f3    	str	x19, [sp, #0xa0]
10a120e40: f90047f7    	str	x23, [sp, #0x88]
10a120e44: b4000080    	cbz	x0, 0x10a120e54 <_Flutter_MMFoundation_BindContext+0x65fca38>
10a120e48: d00a1bf7    	adrp	x23, 0x11e49e000 <dyld_stub_binder+0x11e49e000>
10a120e4c: 910f22f7    	add	x23, x23, #0x3c8
10a120e50: 1400000e    	b	0x10a120e88 <_Flutter_MMFoundation_BindContext+0x65fca6c>
10a120e54: b00ae928    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10a120e58: f940cd01    	ldr	x1, [x8, #0x198] ; tid
10a120e5c: aa1603e0    	mov	x0, x22
10a120e60: 955ce979    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120e64: aa1d03fd    	mov	x29, x29
10a120e68: 955ce97a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120e6c: aa0003f3    	mov	x19, x0
10a120e70: f100001f    	cmp	x0, #0x0
10a120e74: 9a800317    	csel	x23, x24, x0, eq
10a120e78: aa1703e0    	mov	x0, x23
10a120e7c: 955ce971    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a120e80: aa1303e0    	mov	x0, x19
10a120e84: 955ce976    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120e88: 900a2548    	adrp	x8, 0x11e5c8000 <dyld_stub_binder+0x11e5c8000>
10a120e8c: 9126a108    	add	x8, x8, #0x9a8
10a120e90: f9004ff7    	str	x23, [sp, #0x98]
10a120e94: f81703b7    	stur	x23, [x29, #-0x90]
10a120e98: f00a4909    	adrp	x9, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a120e9c: 91002129    	add	x9, x9, #0x8
10a120ea0: a93427a8    	stp	x8, x9, [x29, #-0xc0]
10a120ea4: 900ae8e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a120ea8: f9471101    	ldr	x1, [x8, #0xe20] ; username
10a120eac: f9005bf6    	str	x22, [sp, #0xb0]
10a120eb0: aa1603e0    	mov	x0, x22
10a120eb4: 955ce964    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120eb8: aa1d03fd    	mov	x29, x29
10a120ebc: 955ce965    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120ec0: aa0003f3    	mov	x19, x0
10a120ec4: f100001f    	cmp	x0, #0x0
10a120ec8: 9a800316    	csel	x22, x24, x0, eq
10a120ecc: d00a4908    	adrp	x8, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a120ed0: 913ea108    	add	x8, x8, #0xfa8
10a120ed4: f81783b6    	stur	x22, [x29, #-0x88]
10a120ed8: f81503a8    	stur	x8, [x29, #-0xb0]
10a120edc: f00b029b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10a120ee0: f9458b77    	ldr	x23, [x27, #0xb10]
10a120ee4: 900aff28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a120ee8: f9479519    	ldr	x25, [x8, #0xf28] ; numberWithBool:
10a120eec: aa1603e0    	mov	x0, x22
10a120ef0: 955ce954    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a120ef4: aa1703e0    	mov	x0, x23
10a120ef8: aa1903e1    	mov	x1, x25
10a120efc: 52800002    	mov	w2, #0x0                ; =0
10a120f00: 955ce951    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120f04: aa1d03fd    	mov	x29, x29
10a120f08: 955ce952    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120f0c: aa0003f7    	mov	x23, x0
10a120f10: f00a1d28    	adrp	x8, 0x11e4c7000 <dyld_stub_binder+0x11e4c7000>
10a120f14: 910ba108    	add	x8, x8, #0x2e8
10a120f18: f81803a0    	stur	x0, [x29, #-0x80]
10a120f1c: f81583a8    	stur	x8, [x29, #-0xa8]
10a120f20: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120f24: f9471100    	ldr	x0, [x8, #0xe20]
10a120f28: b00ae8e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a120f2c: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
10a120f30: 955ce945    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120f34: aa1d03fd    	mov	x29, x29
10a120f38: 955ce946    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120f3c: aa0003f8    	mov	x24, x0
10a120f40: f81883a0    	stur	x0, [x29, #-0x78]
10a120f44: f00a4908    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a120f48: 9100a108    	add	x8, x8, #0x28
10a120f4c: f81603a8    	stur	x8, [x29, #-0xa0]
10a120f50: f9458b60    	ldr	x0, [x27, #0xb10]
10a120f54: aa1903e1    	mov	x1, x25
10a120f58: b90033fc    	str	w28, [sp, #0x30]
10a120f5c: aa1c03e2    	mov	x2, x28
10a120f60: 955ce939    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120f64: aa1d03fd    	mov	x29, x29
10a120f68: 955ce93a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120f6c: aa0003fc    	mov	x28, x0
10a120f70: f81903a0    	stur	x0, [x29, #-0x70]
10a120f74: f00a4908    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a120f78: 91012108    	add	x8, x8, #0x48
10a120f7c: f81683a8    	stur	x8, [x29, #-0x98]
10a120f80: f9458b60    	ldr	x0, [x27, #0xb10]
10a120f84: aa1903e1    	mov	x1, x25
10a120f88: b90037fa    	str	w26, [sp, #0x34]
10a120f8c: aa1a03e2    	mov	x2, x26
10a120f90: 955ce92d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120f94: aa1d03fd    	mov	x29, x29
10a120f98: 955ce92e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120f9c: aa0003fb    	mov	x27, x0
10a120fa0: f81983a0    	stur	x0, [x29, #-0x68]
10a120fa4: f00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a120fa8: f9457500    	ldr	x0, [x8, #0xae8]
10a120fac: b00aff08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a120fb0: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
10a120fb4: d10243a2    	sub	x2, x29, #0x90
10a120fb8: d10303a3    	sub	x3, x29, #0xc0
10a120fbc: 528000c4    	mov	w4, #0x6                ; =6
10a120fc0: 955ce921    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120fc4: aa1d03fd    	mov	x29, x29
10a120fc8: 955ce922    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a120fcc: aa0003fa    	mov	x26, x0
10a120fd0: 900aff28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a120fd4: f9450901    	ldr	x1, [x8, #0xa10] ; mutableCopy
10a120fd8: 955ce91b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a120fdc: aa0003f9    	mov	x25, x0
10a120fe0: aa1603e0    	mov	x0, x22
10a120fe4: 955ce91e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120fe8: aa1a03e0    	mov	x0, x26
10a120fec: 955ce91c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120ff0: aa1b03e0    	mov	x0, x27
10a120ff4: 955ce91a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a120ff8: aa1c03e0    	mov	x0, x28
10a120ffc: 955ce918    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121000: aa1803e0    	mov	x0, x24
10a121004: 955ce916    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121008: aa1703e0    	mov	x0, x23
10a12100c: 955ce914    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121010: aa1303e0    	mov	x0, x19
10a121014: 955ce912    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121018: b4000274    	cbz	x20, 0x10a121064 <_Flutter_MMFoundation_BindContext+0x65fcc48>
10a12101c: d00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a121020: f9458900    	ldr	x0, [x8, #0xb10]
10a121024: f00aff08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a121028: f947c901    	ldr	x1, [x8, #0xf90] ; numberWithUnsignedLongLong:
10a12102c: aa1403e2    	mov	x2, x20
10a121030: 955ce905    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121034: aa1d03fd    	mov	x29, x29
10a121038: 955ce906    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a12103c: aa0003f3    	mov	x19, x0
10a121040: 900aff48    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
10a121044: f9401101    	ldr	x1, [x8, #0x20] ; setObject:forKeyedSubscript:
10a121048: f00a2523    	adrp	x3, 0x11e5c8000 <dyld_stub_binder+0x11e5c8000>
10a12104c: 91292063    	add	x3, x3, #0xa48
10a121050: aa1903e0    	mov	x0, x25
10a121054: aa1303e2    	mov	x2, x19
10a121058: 955ce8fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12105c: aa1303e0    	mov	x0, x19
10a121060: 955ce8ff    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121064: aa1903e0    	mov	x0, x25
10a121068: a94a87e3    	ldp	x3, x1, [sp, #0xa8]
10a12106c: f94047e2    	ldr	x2, [sp, #0x88]
10a121070: 940001e8    	bl	0x10a121810 <_Flutter_MMFoundation_BindContext+0x65fd3f4>
10a121074: aa1903e0    	mov	x0, x25
10a121078: aa1503e1    	mov	x1, x21
10a12107c: 94000370    	bl	0x10a121e3c <_Flutter_MMFoundation_BindContext+0x65fda20>
10a121080: aa1503e0    	mov	x0, x21
10a121084: 955ce8f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121088: d00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a12108c: f9453513    	ldr	x19, [x8, #0xa68]
10a121090: f10002bf    	cmp	x21, #0x0
10a121094: 1a9f07f7    	cset	w23, ne
10a121098: f00aff08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10a12109c: f947f915    	ldr	x21, [x8, #0xff0] ; objectForKeyedSubscript:
10a1210a0: d00a4902    	adrp	x2, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a1210a4: 91022042    	add	x2, x2, #0x88
10a1210a8: aa1903e0    	mov	x0, x25
10a1210ac: aa1503e1    	mov	x1, x21
10a1210b0: 955ce8e5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1210b4: aa1d03fd    	mov	x29, x29
10a1210b8: 955ce8e6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1210bc: aa0003f6    	mov	x22, x0
10a1210c0: f100001f    	cmp	x0, #0x0
10a1210c4: d00a1bda    	adrp	x26, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10a1210c8: 9103235a    	add	x26, x26, #0xc8
10a1210cc: 9a800358    	csel	x24, x26, x0, eq
10a1210d0: d00a4902    	adrp	x2, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a1210d4: 9102a042    	add	x2, x2, #0xa8
10a1210d8: aa1903e0    	mov	x0, x25
10a1210dc: aa1503e1    	mov	x1, x21
10a1210e0: 955ce8d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1210e4: aa1d03fd    	mov	x29, x29
10a1210e8: 955ce8da    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a1210ec: aa0003f5    	mov	x21, x0
10a1210f0: f100001f    	cmp	x0, #0x0
10a1210f4: 9a800348    	csel	x8, x26, x0, eq
10a1210f8: 900ae8c9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a1210fc: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a121100: a90223f8    	stp	x24, x8, [sp, #0x20]
10a121104: a9015ff4    	stp	x20, x23, [sp, #0x10]
10a121108: d00a4908    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a12110c: 9101a108    	add	x8, x8, #0x68
10a121110: f9404fe9    	ldr	x9, [sp, #0x98]
10a121114: a90027e8    	stp	x8, x9, [sp]
10a121118: f00887c3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a12111c: 912b2863    	add	x3, x3, #0xaca
10a121120: 9008df65    	adrp	x5, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a121124: 9111c4a5    	add	x5, x5, #0x471
10a121128: 9008df67    	adrp	x7, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a12112c: 911268e7    	add	x7, x7, #0x49a
10a121130: aa1303e0    	mov	x0, x19
10a121134: 52800042    	mov	w2, #0x2                ; =2
10a121138: 52800004    	mov	w4, #0x0                ; =0
10a12113c: 528016a6    	mov	w6, #0xb5               ; =181
10a121140: 955ce8c1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121144: aa1503e0    	mov	x0, x21
10a121148: 955ce8c5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12114c: aa1603e0    	mov	x0, x22
10a121150: 955ce8c3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121154: f00ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a121158: f944c101    	ldr	x1, [x8, #0x980] ; push:arguments:
10a12115c: b00a1e42    	adrp	x2, 0x11e4ea000 <dyld_stub_binder+0x11e4ea000>
10a121160: 91252042    	add	x2, x2, #0x948
10a121164: f94053e0    	ldr	x0, [sp, #0xa0]
10a121168: f9003ff9    	str	x25, [sp, #0x78]
10a12116c: aa1903e3    	mov	x3, x25
10a121170: 955ce8b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121174: d00b0388    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a121178: f9432900    	ldr	x0, [x8, #0x650]
10a12117c: 955ce8b9    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121180: aa0003f4    	mov	x20, x0
10a121184: d00aff28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a121188: f9451513    	ldr	x19, [x8, #0xa28] ; setDelegate:
10a12118c: aa1303e1    	mov	x1, x19
10a121190: f94043f6    	ldr	x22, [sp, #0x80]
10a121194: aa1603e2    	mov	x2, x22
10a121198: 955ce8ab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12119c: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1211a0: f942b100    	ldr	x0, [x8, #0x560]
10a1211a4: 955ce8af    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1211a8: f9004be0    	str	x0, [sp, #0x90]
10a1211ac: aa1303e1    	mov	x1, x19
10a1211b0: aa1603e2    	mov	x2, x22
10a1211b4: 955ce8a4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1211b8: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1211bc: f942b500    	ldr	x0, [x8, #0x568]
10a1211c0: 955ce8a8    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1211c4: aa0003fa    	mov	x26, x0
10a1211c8: aa1303e1    	mov	x1, x19
10a1211cc: aa1603e2    	mov	x2, x22
10a1211d0: 955ce89d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1211d4: b00b0448    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
10a1211d8: f9429500    	ldr	x0, [x8, #0x528]
10a1211dc: 955ce8a1    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1211e0: aa0003fc    	mov	x28, x0
10a1211e4: aa1303e1    	mov	x1, x19
10a1211e8: aa1603e2    	mov	x2, x22
10a1211ec: 955ce896    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1211f0: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1211f4: f942b900    	ldr	x0, [x8, #0x570]
10a1211f8: 955ce89a    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1211fc: aa0003fb    	mov	x27, x0
10a121200: aa1303e1    	mov	x1, x19
10a121204: aa1603e2    	mov	x2, x22
10a121208: 955ce88f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12120c: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a121210: f942bd00    	ldr	x0, [x8, #0x578]
10a121214: 955ce893    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121218: aa0003f5    	mov	x21, x0
10a12121c: aa1303e1    	mov	x1, x19
10a121220: aa1603e2    	mov	x2, x22
10a121224: 955ce888    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121228: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a12122c: f942c100    	ldr	x0, [x8, #0x580] ; Hx.
10a121230: 955ce88c    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121234: aa0003f9    	mov	x25, x0
10a121238: aa1303e1    	mov	x1, x19
10a12123c: aa1603e2    	mov	x2, x22
10a121240: 955ce881    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121244: b00b02a8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a121248: f946fd00    	ldr	x0, [x8, #0xdf8]
10a12124c: 955ce885    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121250: f90023e0    	str	x0, [sp, #0x40]
10a121254: f90067e0    	str	x0, [sp, #0xc8]
10a121258: d00b0388    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a12125c: f9431100    	ldr	x0, [x8, #0x620]
10a121260: 955ce880    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121264: f9001fe0    	str	x0, [sp, #0x38]
10a121268: f9006be0    	str	x0, [sp, #0xd0]
10a12126c: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a121270: f9429900    	ldr	x0, [x8, #0x530] ; Xw.
10a121274: 955ce87b    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121278: aa0003f3    	mov	x19, x0
10a12127c: a90dd3e0    	stp	x0, x20, [sp, #0xd8]
10a121280: f9003bf4    	str	x20, [sp, #0x70]
10a121284: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a121288: f9429d00    	ldr	x0, [x8, #0x538]
10a12128c: 955ce875    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a121290: aa0003f7    	mov	x23, x0
10a121294: f90077e0    	str	x0, [sp, #0xe8]
10a121298: 900b02c8    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
10a12129c: f940d500    	ldr	x0, [x8, #0x1a8]
10a1212a0: 955ce870    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1212a4: aa0003f8    	mov	x24, x0
10a1212a8: f9007be0    	str	x0, [sp, #0xf0]
10a1212ac: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1212b0: f942a100    	ldr	x0, [x8, #0x540]
10a1212b4: 955ce86b    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1212b8: aa0003f4    	mov	x20, x0
10a1212bc: a90fd7e0    	stp	x0, x21, [sp, #0xf8]
10a1212c0: a904d7f9    	stp	x25, x21, [sp, #0x48]
10a1212c4: f9404be8    	ldr	x8, [sp, #0x90]
10a1212c8: a910ebe8    	stp	x8, x26, [sp, #0x108]
10a1212cc: f90037fa    	str	x26, [sp, #0x68]
10a1212d0: f9008ff9    	str	x25, [sp, #0x118]
10a1212d4: d00b0448    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a1212d8: f942a500    	ldr	x0, [x8, #0x548]
10a1212dc: 955ce861    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a1212e0: aa0003fa    	mov	x26, x0
10a1212e4: a9126fe0    	stp	x0, x27, [sp, #0x120]
10a1212e8: f9002ffb    	str	x27, [sp, #0x58]
10a1212ec: d00b02a8    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
10a1212f0: f940e900    	ldr	x0, [x8, #0x1d0]
10a1212f4: b00ae988    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a1212f8: f9413101    	ldr	x1, [x8, #0x260] ; plugin
10a1212fc: 955ce852    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121300: aa1d03fd    	mov	x29, x29
10a121304: 955ce853    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a121308: aa0003fb    	mov	x27, x0
10a12130c: a91373e0    	stp	x0, x28, [sp, #0x130]
10a121310: f90033fc    	str	x28, [sp, #0x60]
10a121314: d00b0288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a121318: f9456d00    	ldr	x0, [x8, #0xad8]
10a12131c: d00afee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a121320: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
10a121324: 910323e2    	add	x2, sp, #0xc8
10a121328: 528001e3    	mov	w3, #0xf                ; =15
10a12132c: 955ce846    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121330: aa1d03fd    	mov	x29, x29
10a121334: 955ce847    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a121338: aa0003f9    	mov	x25, x0
10a12133c: f00ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a121340: f944c901    	ldr	x1, [x8, #0x990] ; addPlugins:
10a121344: f94053f5    	ldr	x21, [sp, #0xa0]
10a121348: aa1503e0    	mov	x0, x21
10a12134c: aa1903e2    	mov	x2, x25
10a121350: 955ce83d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121354: aa1903e0    	mov	x0, x25
10a121358: 955ce841    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12135c: aa1b03e0    	mov	x0, x27
10a121360: 955ce83f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121364: aa1a03e0    	mov	x0, x26
10a121368: 955ce83d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12136c: aa1403e0    	mov	x0, x20
10a121370: 955ce83b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121374: aa1803e0    	mov	x0, x24
10a121378: 955ce839    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12137c: aa1703e0    	mov	x0, x23
10a121380: aa1503f7    	mov	x23, x21
10a121384: f9405bf4    	ldr	x20, [sp, #0xb0]
10a121388: 955ce835    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a12138c: aa1303e0    	mov	x0, x19
10a121390: f94057f5    	ldr	x21, [sp, #0xa8]
10a121394: 955ce832    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121398: f9401fe0    	ldr	x0, [sp, #0x38]
10a12139c: 955ce830    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1213a0: f94023e0    	ldr	x0, [sp, #0x40]
10a1213a4: 955ce82e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1213a8: f00b0588    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a1213ac: f940a908    	ldr	x8, [x8, #0x150]
10a1213b0: a90ba3f6    	stp	x22, x8, [sp, #0xb8]
10a1213b4: f00ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a1213b8: f944c501    	ldr	x1, [x8, #0x988] ; initWithFlutterInstance:
10a1213bc: 9102e3e0    	add	x0, sp, #0xb8
10a1213c0: aa1703e2    	mov	x2, x23
10a1213c4: 955ce822    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a1213c8: aa0003f3    	mov	x19, x0
10a1213cc: b40003e0    	cbz	x0, 0x10a121448 <_Flutter_MMFoundation_BindContext+0x65fd02c>
10a1213d0: f00af348    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10a1213d4: f942ad01    	ldr	x1, [x8, #0x558] ; setInstance:
10a1213d8: aa1303e0    	mov	x0, x19
10a1213dc: aa1703e2    	mov	x2, x23
10a1213e0: 955ce819    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1213e4: d00ae928    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10a1213e8: f9449d01    	ldr	x1, [x8, #0x938] ; setDataItem:
10a1213ec: aa1303e0    	mov	x0, x19
10a1213f0: aa1403e2    	mov	x2, x20
10a1213f4: 955ce814    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a1213f8: b00afbc8    	adrp	x8, 0x12009a000 <dyld_stub_binder+0x12009a000>
10a1213fc: f9430d01    	ldr	x1, [x8, #0x618] ; setForbidComment:
10a121400: aa1303e0    	mov	x0, x19
10a121404: b94033e2    	ldr	w2, [sp, #0x30]
10a121408: 955ce80f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a12140c: d00aea68    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
10a121410: f943f501    	ldr	x1, [x8, #0x7e8] ; setTipType:
10a121414: aa1303e0    	mov	x0, x19
10a121418: f94047e2    	ldr	x2, [sp, #0x88]
10a12141c: 955ce80a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121420: b00afbc8    	adrp	x8, 0x12009a000 <dyld_stub_binder+0x12009a000>
10a121424: f9431101    	ldr	x1, [x8, #0x620] ; setFailedComment:
10a121428: aa1303e0    	mov	x0, x19
10a12142c: aa1503e2    	mov	x2, x21
10a121430: 955ce805    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121434: d00aea68    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
10a121438: f943f901    	ldr	x1, [x8, #0x7f0] ; setCanShowInvisibleTipsView:
10a12143c: aa1303e0    	mov	x0, x19
10a121440: b94037e2    	ldr	w2, [sp, #0x34]
10a121444: 955ce800    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a121448: f94027e0    	ldr	x0, [sp, #0x48]
10a12144c: 955ce804    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121450: f9402be0    	ldr	x0, [sp, #0x50]
10a121454: 955ce802    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121458: f9402fe0    	ldr	x0, [sp, #0x58]
10a12145c: 955ce800    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121460: f94033e0    	ldr	x0, [sp, #0x60]
10a121464: 955ce7fe    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121468: f94037e0    	ldr	x0, [sp, #0x68]
10a12146c: 955ce7fc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121470: f9404be0    	ldr	x0, [sp, #0x90]
10a121474: 955ce7fa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121478: f9403be0    	ldr	x0, [sp, #0x70]
10a12147c: 955ce7f8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121480: f9403fe0    	ldr	x0, [sp, #0x78]
10a121484: 955ce7f6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121488: f9404fe0    	ldr	x0, [sp, #0x98]
10a12148c: 955ce7f4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121490: aa1703e0    	mov	x0, x23
10a121494: 955ce7f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a121498: aa1503e0    	mov	x0, x21
10a12149c: 955ce7f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1214a0: aa1403e0    	mov	x0, x20
10a1214a4: 955ce7ee    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1214a8: f85a03a8    	ldur	x8, [x29, #-0x60]
10a1214ac: d009a669    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a1214b0: f9405929    	ldr	x9, [x9, #0xb0]
10a1214b4: f9400129    	ldr	x9, [x9]
10a1214b8: eb08013f    	cmp	x9, x8
10a1214bc: 54000141    	b.ne	0x10a1214e4 <_Flutter_MMFoundation_BindContext+0x65fd0c8>
10a1214c0: aa1303e0    	mov	x0, x19
10a1214c4: 9106c3ff    	add	sp, sp, #0x1b0
10a1214c8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a1214cc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a1214d0: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a1214d4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a1214d8: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a1214dc: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10a1214e0: d65f03c0    	ret
10a1214e4: 955ce7e6    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
