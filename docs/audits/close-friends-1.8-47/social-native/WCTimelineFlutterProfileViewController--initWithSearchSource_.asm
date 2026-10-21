
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a124b40: d10783ff    	sub	sp, sp, #0x1e0
10a124b44: a9186ffc    	stp	x28, x27, [sp, #0x180]
10a124b48: a91967fa    	stp	x26, x25, [sp, #0x190]
10a124b4c: a91a5ff8    	stp	x24, x23, [sp, #0x1a0]
10a124b50: a91b57f6    	stp	x22, x21, [sp, #0x1b0]
10a124b54: a91c4ff4    	stp	x20, x19, [sp, #0x1c0]
10a124b58: a91d7bfd    	stp	x29, x30, [sp, #0x1d0]
10a124b5c: 910743fd    	add	x29, sp, #0x1d0
10a124b60: aa0203f6    	mov	x22, x2
10a124b64: aa0003f5    	mov	x21, x0
10a124b68: f009a648    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a124b6c: f9405908    	ldr	x8, [x8, #0xb0]
10a124b70: f9400108    	ldr	x8, [x8]
10a124b74: f81a03a8    	stur	x8, [x29, #-0x60]
10a124b78: b00b5968    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a124b7c: 52800029    	mov	w9, #0x1                ; =1
10a124b80: 3917b509    	strb	w9, [x8, #0x5ed]
10a124b84: aa0203e0    	mov	x0, x2
10a124b88: 955cda2e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a124b8c: b00b0288    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a124b90: f9434d00    	ldr	x0, [x8, #0x698]
10a124b94: 955cda35    	bl	0x10f85b468 <_UR_96F1_B25D+0x3a640d8>
10a124b98: aa0003f3    	mov	x19, x0
10a124b9c: b00b0288    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10a124ba0: f9435100    	ldr	x0, [x8, #0x6a0]
10a124ba4: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124ba8: f944b901    	ldr	x1, [x8, #0x970] ; defaultGroup
10a124bac: 955cda26    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124bb0: aa1d03fd    	mov	x29, x29
10a124bb4: 955cda27    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124bb8: aa0003f4    	mov	x20, x0
10a124bbc: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124bc0: f944bd01    	ldr	x1, [x8, #0x978] ; initWithEngineGroup:plugin:
10a124bc4: f00a1c23    	adrp	x3, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
10a124bc8: 9109a063    	add	x3, x3, #0x268
10a124bcc: aa1303e0    	mov	x0, x19
10a124bd0: aa1403e2    	mov	x2, x20
10a124bd4: 955cda1c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124bd8: aa0003f7    	mov	x23, x0
10a124bdc: aa1403e0    	mov	x0, x20
10a124be0: 955cda1f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124be4: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124be8: f945e900    	ldr	x0, [x8, #0xbd0]
10a124bec: 900afee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a124bf0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a124bf4: 955cda14    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124bf8: aa1d03fd    	mov	x29, x29
10a124bfc: 955cda15    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124c00: aa0003f3    	mov	x19, x0
10a124c04: b00b02e8    	adrp	x8, 0x120181000 <dyld_stub_binder+0x120181000>
10a124c08: f9418d00    	ldr	x0, [x8, #0x318]
10a124c0c: f00afec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a124c10: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a124c14: 955cda0c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124c18: aa0003e2    	mov	x2, x0
10a124c1c: b00ae8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a124c20: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a124c24: aa1303e0    	mov	x0, x19
10a124c28: 955cda07    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124c2c: aa1d03fd    	mov	x29, x29
10a124c30: 955cda08    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124c34: aa0003f4    	mov	x20, x0
10a124c38: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124c3c: f9437501    	ldr	x1, [x8, #0x6e8] ; getSessionId
10a124c40: 955cda01    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124c44: aa1d03fd    	mov	x29, x29
10a124c48: 955cda02    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124c4c: aa0003f8    	mov	x24, x0
10a124c50: aa1403e0    	mov	x0, x20
10a124c54: 955cda02    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124c58: aa1303e0    	mov	x0, x19
10a124c5c: 955cda00    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124c60: f00afee8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a124c64: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a124c68: aa1803e0    	mov	x0, x24
10a124c6c: 955cd9f6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124c70: b50002a0    	cbnz	x0, 0x10a124cc4 <_Flutter_MMFoundation_BindContext+0x66008a8>
10a124c74: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124c78: f9454513    	ldr	x19, [x8, #0xa88]
10a124c7c: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124c80: f9467900    	ldr	x0, [x8, #0xcf0]
10a124c84: 900ae8e8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10a124c88: f942c501    	ldr	x1, [x8, #0x588] ; genCurrentTimeInMsFrom1970
10a124c8c: 955cd9ee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124c90: d00aff28    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a124c94: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
10a124c98: f90003e0    	str	x0, [sp]
10a124c9c: d00a48e2    	adrp	x2, 0x11ea42000 <dyld_stub_binder+0x11ea42000>
10a124ca0: 913e2042    	add	x2, x2, #0xf88
10a124ca4: aa1303e0    	mov	x0, x19
10a124ca8: 955cd9e7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124cac: aa1d03fd    	mov	x29, x29
10a124cb0: 955cd9e8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124cb4: aa0003f3    	mov	x19, x0
10a124cb8: aa1803e0    	mov	x0, x24
10a124cbc: 955cd9e8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124cc0: aa1303f8    	mov	x24, x19
10a124cc4: f00a1d08    	adrp	x8, 0x11e4c7000 <dyld_stub_binder+0x11e4c7000>
10a124cc8: 910ba108    	add	x8, x8, #0x2e8
10a124ccc: f81703a8    	stur	x8, [x29, #-0x90]
10a124cd0: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124cd4: f9471100    	ldr	x0, [x8, #0xe20]
10a124cd8: b00ae8c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10a124cdc: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
10a124ce0: 955cd9d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124ce4: aa1d03fd    	mov	x29, x29
10a124ce8: 955cd9da    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124cec: aa0003f3    	mov	x19, x0
10a124cf0: f00a48e8    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a124cf4: 9108a108    	add	x8, x8, #0x228
10a124cf8: b00a2529    	adrp	x9, 0x11e5c9000 <dyld_stub_binder+0x11e5c9000>
10a124cfc: 9126a129    	add	x9, x9, #0x9a8
10a124d00: a938e3a0    	stp	x0, x24, [x29, #-0x78]
10a124d04: f9003ff8    	str	x24, [sp, #0x78]
10a124d08: a937a7a8    	stp	x8, x9, [x29, #-0x88]
10a124d0c: f00a1ba8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10a124d10: 91032108    	add	x8, x8, #0xc8
10a124d14: f10002df    	cmp	x22, #0x0
10a124d18: 9a960108    	csel	x8, x8, x22, eq
10a124d1c: f81983a8    	stur	x8, [x29, #-0x68]
10a124d20: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124d24: f9457500    	ldr	x0, [x8, #0xae8]
10a124d28: b00afee8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a124d2c: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
10a124d30: d101e3a2    	sub	x2, x29, #0x78
10a124d34: d10243a3    	sub	x3, x29, #0x90
10a124d38: 52800064    	mov	w4, #0x3                ; =3
10a124d3c: 955cd9c2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124d40: aa1d03fd    	mov	x29, x29
10a124d44: 955cd9c3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124d48: aa0003f4    	mov	x20, x0
10a124d4c: aa1303e0    	mov	x0, x19
10a124d50: 955cd9c3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124d54: 9009ad48    	adrp	x8, 0x11d6cc000 <dyld_stub_binder+0x11d6cc000>
10a124d58: 912a0108    	add	x8, x8, #0xa80
10a124d5c: f9400102    	ldr	x2, [x8]
10a124d60: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124d64: f944c101    	ldr	x1, [x8, #0x980] ; push:arguments:
10a124d68: aa1703e0    	mov	x0, x23
10a124d6c: f9003bf4    	str	x20, [sp, #0x70]
10a124d70: aa1403e3    	mov	x3, x20
10a124d74: 955cd9b4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124d78: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124d7c: f9453500    	ldr	x0, [x8, #0xa68]
10a124d80: b00ae8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a124d84: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a124d88: f00a48e8    	adrp	x8, 0x11ea43000 <dyld_stub_binder+0x11ea43000>
10a124d8c: 91092108    	add	x8, x8, #0x248
10a124d90: f90043f6    	str	x22, [sp, #0x80]
10a124d94: a9005be8    	stp	x8, x22, [sp]
10a124d98: b008df45    	adrp	x5, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a124d9c: 911b9ca5    	add	x5, x5, #0x6e7
10a124da0: b008df47    	adrp	x7, 0x11bd0d000 <dyld_stub_binder+0x11bd0d000>
10a124da4: 911dd8e7    	add	x7, x7, #0x776
10a124da8: 52800042    	mov	w2, #0x2                ; =2
10a124dac: d2800003    	mov	x3, #0x0                ; =0
10a124db0: 52800004    	mov	w4, #0x0                ; =0
10a124db4: 52803d26    	mov	w6, #0x1e9              ; =489
10a124db8: 955cd9a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124dbc: f00b0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a124dc0: f9432900    	ldr	x0, [x8, #0x650]
10a124dc4: 955cd9a7    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124dc8: aa0003f6    	mov	x22, x0
10a124dcc: f00aff08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
10a124dd0: f9451514    	ldr	x20, [x8, #0xa28] ; setDelegate:
10a124dd4: aa1403e1    	mov	x1, x20
10a124dd8: aa1503e2    	mov	x2, x21
10a124ddc: 955cd99a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124de0: d00b0428    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
10a124de4: f9429500    	ldr	x0, [x8, #0x528]
10a124de8: 955cd99e    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124dec: aa0003f8    	mov	x24, x0
10a124df0: aa1403e1    	mov	x1, x20
10a124df4: aa1503e2    	mov	x2, x21
10a124df8: 955cd993    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124dfc: b00b02a8    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
10a124e00: f940d500    	ldr	x0, [x8, #0x1a8]
10a124e04: 955cd997    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124e08: aa0003f9    	mov	x25, x0
10a124e0c: aa1403e1    	mov	x1, x20
10a124e10: aa1503e2    	mov	x2, x21
10a124e14: 955cd98c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124e18: f00b0433    	adrp	x19, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124e1c: f942b260    	ldr	x0, [x19, #0x560]
10a124e20: 955cd990    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124e24: f9004be0    	str	x0, [sp, #0x90]
10a124e28: aa1403e1    	mov	x1, x20
10a124e2c: aa1503e2    	mov	x2, x21
10a124e30: 955cd985    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124e34: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124e38: f942b500    	ldr	x0, [x8, #0x568]
10a124e3c: 955cd989    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124e40: f90047e0    	str	x0, [sp, #0x88]
10a124e44: aa1403e1    	mov	x1, x20
10a124e48: aa1503e2    	mov	x2, x21
10a124e4c: 955cd97e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124e50: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124e54: f942b900    	ldr	x0, [x8, #0x570]
10a124e58: 955cd982    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124e5c: aa0003fb    	mov	x27, x0
10a124e60: aa1403e1    	mov	x1, x20
10a124e64: aa1503e2    	mov	x2, x21
10a124e68: 955cd977    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124e6c: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124e70: f942bd00    	ldr	x0, [x8, #0x578]
10a124e74: 955cd97b    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124e78: f9000be0    	str	x0, [sp, #0x10]
10a124e7c: aa1403e1    	mov	x1, x20
10a124e80: aa1503e2    	mov	x2, x21
10a124e84: 955cd970    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124e88: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124e8c: f942c100    	ldr	x0, [x8, #0x580] ; Hx.
10a124e90: 955cd974    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124e94: aa0003fa    	mov	x26, x0
10a124e98: aa1403e1    	mov	x1, x20
10a124e9c: aa1503e2    	mov	x2, x21
10a124ea0: 955cd969    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124ea4: d00b0288    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a124ea8: f946fd00    	ldr	x0, [x8, #0xdf8]
10a124eac: 955cd96d    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124eb0: f90023e0    	str	x0, [sp, #0x40]
10a124eb4: f90057e0    	str	x0, [sp, #0xa8]
10a124eb8: f00b0368    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
10a124ebc: f9431100    	ldr	x0, [x8, #0x620]
10a124ec0: 955cd968    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124ec4: f9001fe0    	str	x0, [sp, #0x38]
10a124ec8: f9005be0    	str	x0, [sp, #0xb0]
10a124ecc: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124ed0: f9429900    	ldr	x0, [x8, #0x530] ; Xw.
10a124ed4: 955cd963    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124ed8: f9001be0    	str	x0, [sp, #0x30]
10a124edc: a90bdbe0    	stp	x0, x22, [sp, #0xb8]
10a124ee0: f90037f6    	str	x22, [sp, #0x68]
10a124ee4: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124ee8: f9429d00    	ldr	x0, [x8, #0x538]
10a124eec: 955cd95d    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124ef0: f90017e0    	str	x0, [sp, #0x28]
10a124ef4: a90ce7e0    	stp	x0, x25, [sp, #0xc8]
10a124ef8: f9002ff9    	str	x25, [sp, #0x58]
10a124efc: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124f00: f942a100    	ldr	x0, [x8, #0x540]
10a124f04: 955cd957    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124f08: f9000fe0    	str	x0, [sp, #0x18]
10a124f0c: f9006fe0    	str	x0, [sp, #0xd8]
10a124f10: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124f14: f942a500    	ldr	x0, [x8, #0x548]
10a124f18: 955cd952    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124f1c: aa0003fc    	mov	x28, x0
10a124f20: a90e63e0    	stp	x0, x24, [sp, #0xe0]
10a124f24: f90033f8    	str	x24, [sp, #0x60]
10a124f28: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124f2c: f942a900    	ldr	x0, [x8, #0x550] ; 8y.
10a124f30: 955cd94c    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124f34: f90013f5    	str	x21, [sp, #0x20]
10a124f38: aa1703f5    	mov	x21, x23
10a124f3c: aa0003f7    	mov	x23, x0
10a124f40: f9007be0    	str	x0, [sp, #0xf0]
10a124f44: d00b02c8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
10a124f48: f947d100    	ldr	x0, [x8, #0xfa0]
10a124f4c: 955cd945    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124f50: aa0003f6    	mov	x22, x0
10a124f54: f9007fe0    	str	x0, [sp, #0xf8]
10a124f58: f942b260    	ldr	x0, [x19, #0x560]
10a124f5c: 955cd941    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124f60: aa0003f4    	mov	x20, x0
10a124f64: f90083e0    	str	x0, [sp, #0x100]
10a124f68: f00b0288    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
10a124f6c: f940e900    	ldr	x0, [x8, #0x1d0]
10a124f70: d00ae968    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a124f74: f9413101    	ldr	x1, [x8, #0x260] ; plugin
10a124f78: 955cd933    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124f7c: aa1d03fd    	mov	x29, x29
10a124f80: 955cd934    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124f84: aa0003f3    	mov	x19, x0
10a124f88: a948a7e8    	ldp	x8, x9, [sp, #0x88]
10a124f8c: a910a7e0    	stp	x0, x9, [sp, #0x108]
10a124f90: a911efe8    	stp	x8, x27, [sp, #0x118]
10a124f94: a904effa    	stp	x26, x27, [sp, #0x48]
10a124f98: f9400bfb    	ldr	x27, [sp, #0x10]
10a124f9c: a912ebfb    	stp	x27, x26, [sp, #0x128]
10a124fa0: f00b0428    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a124fa4: f942ad00    	ldr	x0, [x8, #0x558]
10a124fa8: 955cd92e    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
10a124fac: aa0003f8    	mov	x24, x0
10a124fb0: f9009fe0    	str	x0, [sp, #0x138]
10a124fb4: f00b0268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a124fb8: f9456d00    	ldr	x0, [x8, #0xad8]
10a124fbc: f00afec8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a124fc0: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
10a124fc4: 9102a3e2    	add	x2, sp, #0xa8
10a124fc8: 52800263    	mov	w3, #0x13               ; =19
10a124fcc: 955cd91e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124fd0: aa1d03fd    	mov	x29, x29
10a124fd4: 955cd91f    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a124fd8: aa0003f9    	mov	x25, x0
10a124fdc: 900ae908    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a124fe0: f944c901    	ldr	x1, [x8, #0x990] ; addPlugins:
10a124fe4: aa1503e0    	mov	x0, x21
10a124fe8: aa1903e2    	mov	x2, x25
10a124fec: 955cd916    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a124ff0: aa1903e0    	mov	x0, x25
10a124ff4: 955cd91a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a124ff8: aa1803e0    	mov	x0, x24
10a124ffc: 955cd918    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125000: aa1303e0    	mov	x0, x19
10a125004: 955cd916    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125008: aa1403e0    	mov	x0, x20
10a12500c: 955cd914    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125010: aa1603e0    	mov	x0, x22
10a125014: 955cd912    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125018: aa1703e0    	mov	x0, x23
10a12501c: 955cd910    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125020: aa1c03e0    	mov	x0, x28
10a125024: 955cd90e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125028: f9400fe0    	ldr	x0, [sp, #0x18]
10a12502c: 955cd90c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125030: f94017e0    	ldr	x0, [sp, #0x28]
10a125034: 955cd90a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125038: f9401be0    	ldr	x0, [sp, #0x30]
10a12503c: 955cd908    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125040: f9401fe0    	ldr	x0, [sp, #0x38]
10a125044: 955cd906    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125048: f94023e0    	ldr	x0, [sp, #0x40]
10a12504c: 955cd904    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125050: f00b0568    	adrp	x8, 0x1201d4000 <dyld_stub_binder+0x1201d4000>
10a125054: f940b108    	ldr	x8, [x8, #0x160]
10a125058: f94013e9    	ldr	x9, [sp, #0x20]
10a12505c: a909a3e9    	stp	x9, x8, [sp, #0x98]
10a125060: f00ae8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10a125064: f944c501    	ldr	x1, [x8, #0x988] ; initWithFlutterInstance:
10a125068: 910263e0    	add	x0, sp, #0x98
10a12506c: aa1503e2    	mov	x2, x21
10a125070: 955cd8f7    	bl	0x10f85b44c <_UR_96F1_B25D+0x3a640bc>
10a125074: aa0003f4    	mov	x20, x0
10a125078: b40000c0    	cbz	x0, 0x10a125090 <_Flutter_MMFoundation_BindContext+0x6600c74>
10a12507c: f00af328    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
10a125080: f942ad01    	ldr	x1, [x8, #0x558] ; setInstance:
10a125084: aa1403e0    	mov	x0, x20
10a125088: aa1503e2    	mov	x2, x21
10a12508c: 955cd8ee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a125090: f94027e0    	ldr	x0, [sp, #0x48]
10a125094: 955cd8f2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a125098: aa1b03e0    	mov	x0, x27
10a12509c: 955cd8f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250a0: f9402be0    	ldr	x0, [sp, #0x50]
10a1250a4: 955cd8ee    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250a8: f94047e0    	ldr	x0, [sp, #0x88]
10a1250ac: 955cd8ec    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250b0: f9404be0    	ldr	x0, [sp, #0x90]
10a1250b4: 955cd8ea    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250b8: f9402fe0    	ldr	x0, [sp, #0x58]
10a1250bc: 955cd8e8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250c0: f94033e0    	ldr	x0, [sp, #0x60]
10a1250c4: 955cd8e6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250c8: f94037e0    	ldr	x0, [sp, #0x68]
10a1250cc: 955cd8e4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250d0: f9403be0    	ldr	x0, [sp, #0x70]
10a1250d4: 955cd8e2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250d8: f9403fe0    	ldr	x0, [sp, #0x78]
10a1250dc: 955cd8e0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250e0: aa1503e0    	mov	x0, x21
10a1250e4: 955cd8de    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250e8: f94043e0    	ldr	x0, [sp, #0x80]
10a1250ec: 955cd8dc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a1250f0: f85a03a8    	ldur	x8, [x29, #-0x60]
10a1250f4: d009a649    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10a1250f8: f9405929    	ldr	x9, [x9, #0xb0]
10a1250fc: f9400129    	ldr	x9, [x9]
10a125100: eb08013f    	cmp	x9, x8
10a125104: 54000141    	b.ne	0x10a12512c <_Flutter_MMFoundation_BindContext+0x6600d10>
10a125108: aa1403e0    	mov	x0, x20
10a12510c: a95d7bfd    	ldp	x29, x30, [sp, #0x1d0]
10a125110: a95c4ff4    	ldp	x20, x19, [sp, #0x1c0]
10a125114: a95b57f6    	ldp	x22, x21, [sp, #0x1b0]
10a125118: a95a5ff8    	ldp	x24, x23, [sp, #0x1a0]
10a12511c: a95967fa    	ldp	x26, x25, [sp, #0x190]
10a125120: a9586ffc    	ldp	x28, x27, [sp, #0x180]
10a125124: 910783ff    	add	sp, sp, #0x1e0
10a125128: d65f03c0    	ret
10a12512c: 955cd8d4    	bl	0x10f85b47c <_UR_96F1_B25D+0x3a640ec>
