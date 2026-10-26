
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1042b8ad8: 6db923e9    	stp	d9, d8, [sp, #-0x70]!
1042b8adc: a9016ffc    	stp	x28, x27, [sp, #0x10]
1042b8ae0: a90267fa    	stp	x26, x25, [sp, #0x20]
1042b8ae4: a9035ff8    	stp	x24, x23, [sp, #0x30]
1042b8ae8: a90457f6    	stp	x22, x21, [sp, #0x40]
1042b8aec: a9054ff4    	stp	x20, x19, [sp, #0x50]
1042b8af0: a9067bfd    	stp	x29, x30, [sp, #0x60]
1042b8af4: 910183fd    	add	x29, sp, #0x60
1042b8af8: d10ac3ff    	sub	sp, sp, #0x2b0
1042b8afc: aa0203fa    	mov	x26, x2
1042b8b00: f90037e0    	str	x0, [sp, #0x68]
1042b8b04: f00c99a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1042b8b08: f9405908    	ldr	x8, [x8, #0xb0]
1042b8b0c: f9400108    	ldr	x8, [x8]
1042b8b10: f81903a8    	stur	x8, [x29, #-0x70]
1042b8b14: 900e4c28    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
1042b8b18: 52800029    	mov	w9, #0x1                ; =1
1042b8b1c: 39159509    	strb	w9, [x8, #0x565]
1042b8b20: f00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b8b24: f9467900    	ldr	x0, [x8, #0xcf0]
1042b8b28: f00ddc28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1042b8b2c: f9438101    	ldr	x1, [x8, #0x700] ; GetRandomUUID
1042b8b30: 94e5b983    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8b34: aa1d03fd    	mov	x29, x29
1042b8b38: 94e5b984    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8b3c: aa0003fb    	mov	x27, x0
1042b8b40: f00df5d7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1042b8b44: f94536e0    	ldr	x0, [x23, #0xa68]
1042b8b48: b00ddc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042b8b4c: f942a916    	ldr	x22, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042b8b50: a900ebfb    	stp	x27, x26, [sp, #0x8]
1042b8b54: d00d2428    	adrp	x8, 0x11e73e000 <dyld_stub_binder+0x11e73e000>
1042b8b58: 913e2108    	add	x8, x8, #0xf88
1042b8b5c: f90003e8    	str	x8, [sp]
1042b8b60: d00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b8b64: 913aa063    	add	x3, x3, #0xea8
1042b8b68: f00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b8b6c: 910a3ca5    	add	x5, x5, #0x28f
1042b8b70: f00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b8b74: 910ab0e7    	add	x7, x7, #0x2ac
1042b8b78: aa1603e1    	mov	x1, x22
1042b8b7c: 52800042    	mov	w2, #0x2                ; =2
1042b8b80: 52800004    	mov	w4, #0x0                ; =0
1042b8b84: 52800526    	mov	w6, #0x29               ; =41
1042b8b88: 94e5b96d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8b8c: f00df628    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
1042b8b90: f945f900    	ldr	x0, [x8, #0xbf0]
1042b8b94: 94e5b971    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1042b8b98: aa0003f8    	mov	x24, x0
1042b8b9c: f00df5d9    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
1042b8ba0: f9455720    	ldr	x0, [x25, #0xaa8]
1042b8ba4: f00df228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1042b8ba8: f941a11c    	ldr	x28, [x8, #0x340] ; array
1042b8bac: aa1c03e1    	mov	x1, x28
1042b8bb0: 94e5b963    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8bb4: aa1d03fd    	mov	x29, x29
1042b8bb8: 94e5b964    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8bbc: aa0003f3    	mov	x19, x0
1042b8bc0: d00ddfa8    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
1042b8bc4: f942b101    	ldr	x1, [x8, #0x560] ; setDeviationDirectives:
1042b8bc8: aa1803e0    	mov	x0, x24
1042b8bcc: aa1303e2    	mov	x2, x19
1042b8bd0: 94e5b95b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8bd4: aa1303e0    	mov	x0, x19
1042b8bd8: 94e5b95f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8bdc: f00df628    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
1042b8be0: f945fd00    	ldr	x0, [x8, #0xbf8]
1042b8be4: 94e5b95d    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1042b8be8: f9001fe0    	str	x0, [sp, #0x38]
1042b8bec: f00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b8bf0: f945e900    	ldr	x0, [x8, #0xbd0]
1042b8bf4: 900df248    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1042b8bf8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1042b8bfc: f9001be1    	str	x1, [sp, #0x30]
1042b8c00: 94e5b94f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8c04: aa1d03fd    	mov	x29, x29
1042b8c08: 94e5b950    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8c0c: aa0003f3    	mov	x19, x0
1042b8c10: b00df5c8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
1042b8c14: f9428914    	ldr	x20, [x8, #0x510]
1042b8c18: d00ddfa8    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
1042b8c1c: d00c99a9    	adrp	x9, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1042b8c20: f947e129    	ldr	x9, [x9, #0xfc0]
1042b8c24: f942b515    	ldr	x21, [x8, #0x568] ; willBeginStorageCleanupInScenario:withContext:
1042b8c28: f900abe9    	str	x9, [sp, #0x150]
1042b8c2c: b00a5648    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1042b8c30: fd41c108    	ldr	d8, [x8, #0x380]
1042b8c34: b0000008    	adrp	x8, 0x1042b9000 <_Flutter_MMFoundation_BindContext+0x794be4>
1042b8c38: 9115f108    	add	x8, x8, #0x57c
1042b8c3c: fd00afe8    	str	d8, [sp, #0x158]
1042b8c40: f00c9a29    	adrp	x9, 0x11d5ff000 <dyld_stub_binder+0x11d5ff000>
1042b8c44: 911e6129    	add	x9, x9, #0x798
1042b8c48: a91627e8    	stp	x8, x9, [sp, #0x160]
1042b8c4c: f90047fa    	str	x26, [sp, #0x88]
1042b8c50: f900bffa    	str	x26, [sp, #0x178]
1042b8c54: aa1803e0    	mov	x0, x24
1042b8c58: 94e5b938    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1042b8c5c: f900bbf8    	str	x24, [sp, #0x170]
1042b8c60: d00ddc08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1042b8c64: f940d501    	ldr	x1, [x8, #0x1a8] ; callExtensionOnMainThread:selector:sync:block:
1042b8c68: 910543e5    	add	x5, sp, #0x150
1042b8c6c: aa1303e0    	mov	x0, x19
1042b8c70: f90017e1    	str	x1, [sp, #0x28]
1042b8c74: aa1403e2    	mov	x2, x20
1042b8c78: aa1503e3    	mov	x3, x21
1042b8c7c: 52800024    	mov	w4, #0x1                ; =1
1042b8c80: 94e5b92f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8c84: aa1303e0    	mov	x0, x19
1042b8c88: 94e5b933    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8c8c: f940bbe0    	ldr	x0, [sp, #0x170]
1042b8c90: 94e5b931    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8c94: f94536f3    	ldr	x19, [x23, #0xa68]
1042b8c98: d00ddfa8    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
1042b8c9c: f942b91a    	ldr	x26, [x8, #0x570] ; deviationDirectives
1042b8ca0: aa1803e0    	mov	x0, x24
1042b8ca4: aa1a03e1    	mov	x1, x26
1042b8ca8: 94e5b925    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8cac: aa1d03fd    	mov	x29, x29
1042b8cb0: 94e5b926    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8cb4: aa0003f4    	mov	x20, x0
1042b8cb8: 900df248    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1042b8cbc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1042b8cc0: f9004fe1    	str	x1, [sp, #0x98]
1042b8cc4: 94e5b91e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8cc8: a90083fb    	stp	x27, x0, [sp, #0x8]
1042b8ccc: d00d2428    	adrp	x8, 0x11e73e000 <dyld_stub_binder+0x11e73e000>
1042b8cd0: 913ea108    	add	x8, x8, #0xfa8
1042b8cd4: a907eff6    	stp	x22, x27, [sp, #0x78]
1042b8cd8: f90003e8    	str	x8, [sp]
1042b8cdc: aa1303e0    	mov	x0, x19
1042b8ce0: aa1603e1    	mov	x1, x22
1042b8ce4: 52800042    	mov	w2, #0x2                ; =2
1042b8ce8: d00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b8cec: 913aa063    	add	x3, x3, #0xea8
1042b8cf0: 52800004    	mov	w4, #0x0                ; =0
1042b8cf4: f00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b8cf8: 910a3ca5    	add	x5, x5, #0x28f
1042b8cfc: 52800606    	mov	w6, #0x30               ; =48
1042b8d00: f00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b8d04: 910ab0e7    	add	x7, x7, #0x2ac
1042b8d08: 94e5b90d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8d0c: aa1403e0    	mov	x0, x20
1042b8d10: 94e5b911    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8d14: f9455720    	ldr	x0, [x25, #0xaa8]
1042b8d18: aa1c03e1    	mov	x1, x28
1042b8d1c: 94e5b908    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8d20: aa1d03fd    	mov	x29, x29
1042b8d24: 94e5b909    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8d28: aa0003f9    	mov	x25, x0
1042b8d2c: 900df676    	adrp	x22, 0x120184000 <dyld_stub_binder+0x120184000>
1042b8d30: f942eac0    	ldr	x0, [x22, #0x5d0]
1042b8d34: b00de528    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042b8d38: f9475501    	ldr	x1, [x8, #0xea8] ; localUsrDirPath
1042b8d3c: 94e5b900    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8d40: aa1d03fd    	mov	x29, x29
1042b8d44: 94e5b901    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8d48: aa0003f3    	mov	x19, x0
1042b8d4c: f81703a0    	stur	x0, [x29, #-0x90]
1042b8d50: f942eac0    	ldr	x0, [x22, #0x5d0]
1042b8d54: b00de528    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042b8d58: f9475d01    	ldr	x1, [x8, #0xeb8] ; localUsrDirExtendedTempPath
1042b8d5c: 94e5b8f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8d60: aa1d03fd    	mov	x29, x29
1042b8d64: 94e5b8f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8d68: aa0003f4    	mov	x20, x0
1042b8d6c: f81783a0    	stur	x0, [x29, #-0x88]
1042b8d70: f942eac0    	ldr	x0, [x22, #0x5d0]
1042b8d74: b00de528    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042b8d78: f9478501    	ldr	x1, [x8, #0xf08] ; localUsrDirTempPath
1042b8d7c: 94e5b8f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8d80: aa1d03fd    	mov	x29, x29
1042b8d84: 94e5b8f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8d88: aa0003f5    	mov	x21, x0
1042b8d8c: f81803a0    	stur	x0, [x29, #-0x80]
1042b8d90: f942eac0    	ldr	x0, [x22, #0x5d0]
1042b8d94: b00de528    	adrp	x8, 0x11ff5d000 <dyld_stub_binder+0x11ff5d000>
1042b8d98: f9479101    	ldr	x1, [x8, #0xf20] ; localUsrDirBriefTempPath
1042b8d9c: 94e5b8e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8da0: aa1d03fd    	mov	x29, x29
1042b8da4: 94e5b8e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8da8: aa0003f6    	mov	x22, x0
1042b8dac: f81883a0    	stur	x0, [x29, #-0x78]
1042b8db0: f00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b8db4: f9456d00    	ldr	x0, [x8, #0xad8]
1042b8db8: f00df228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1042b8dbc: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1042b8dc0: d10243a2    	sub	x2, x29, #0x90
1042b8dc4: 52800083    	mov	w3, #0x4                ; =4
1042b8dc8: 94e5b8dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8dcc: aa1d03fd    	mov	x29, x29
1042b8dd0: 94e5b8de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8dd4: aa0003f7    	mov	x23, x0
1042b8dd8: d00ddc48    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1042b8ddc: f943bd01    	ldr	x1, [x8, #0x778] ; safeAddObjectsFromArray:
1042b8de0: f9002bf9    	str	x25, [sp, #0x50]
1042b8de4: aa1903e0    	mov	x0, x25
1042b8de8: aa1703e2    	mov	x2, x23
1042b8dec: 94e5b8d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8df0: aa1703e0    	mov	x0, x23
1042b8df4: 94e5b8d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8df8: aa1603e0    	mov	x0, x22
1042b8dfc: 94e5b8d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8e00: aa1503e0    	mov	x0, x21
1042b8e04: 94e5b8d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8e08: aa1403e0    	mov	x0, x20
1042b8e0c: 94e5b8d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8e10: aa1303e0    	mov	x0, x19
1042b8e14: 94e5b8d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8e18: 4f00e400    	movi.16b	v0, #0x0
1042b8e1c: ad0983e0    	stp	q0, q0, [sp, #0x130]
1042b8e20: ad0883e0    	stp	q0, q0, [sp, #0x110]
1042b8e24: f90023f8    	str	x24, [sp, #0x40]
1042b8e28: aa1803e0    	mov	x0, x24
1042b8e2c: f9004bfa    	str	x26, [sp, #0x90]
1042b8e30: aa1a03e1    	mov	x1, x26
1042b8e34: 94e5b8c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8e38: aa1d03fd    	mov	x29, x29
1042b8e3c: 94e5b8c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8e40: aa0003f3    	mov	x19, x0
1042b8e44: 900df248    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1042b8e48: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1042b8e4c: 910443e2    	add	x2, sp, #0x110
1042b8e50: 910803e3    	add	x3, sp, #0x200
1042b8e54: f90027e1    	str	x1, [sp, #0x48]
1042b8e58: 52800204    	mov	w4, #0x10               ; =16
1042b8e5c: 94e5b8b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8e60: b40005c0    	cbz	x0, 0x1042b8f18 <_Flutter_MMFoundation_BindContext+0x794afc>
1042b8e64: aa0003f4    	mov	x20, x0
1042b8e68: f94093e8    	ldr	x8, [sp, #0x120]
1042b8e6c: f9400119    	ldr	x25, [x8]
1042b8e70: d00ddc1c    	adrp	x28, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1042b8e74: d280001b    	mov	x27, #0x0               ; =0
1042b8e78: f00df288    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1042b8e7c: f941c915    	ldr	x21, [x8, #0x390] ; type
1042b8e80: b00df268    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
1042b8e84: f9438d16    	ldr	x22, [x8, #0x718] ; path
1042b8e88: f943c797    	ldr	x23, [x28, #0x788] ; safeAddObject:
1042b8e8c: f94093e8    	ldr	x8, [sp, #0x120]
1042b8e90: f9400108    	ldr	x8, [x8]
1042b8e94: eb19011f    	cmp	x8, x25
1042b8e98: 54000060    	b.eq	0x1042b8ea4 <_Flutter_MMFoundation_BindContext+0x794a88>
1042b8e9c: aa1303e0    	mov	x0, x19
1042b8ea0: 94e5b8ac    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1042b8ea4: f9408fe8    	ldr	x8, [sp, #0x118]
1042b8ea8: f87b7918    	ldr	x24, [x8, x27, lsl #3]
1042b8eac: aa1803e0    	mov	x0, x24
1042b8eb0: aa1503e1    	mov	x1, x21
1042b8eb4: 94e5b8a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8eb8: b50001a0    	cbnz	x0, 0x1042b8eec <_Flutter_MMFoundation_BindContext+0x794ad0>
1042b8ebc: aa1803e0    	mov	x0, x24
1042b8ec0: aa1603e1    	mov	x1, x22
1042b8ec4: 94e5b89e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8ec8: aa1d03fd    	mov	x29, x29
1042b8ecc: 94e5b89f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8ed0: aa0003f8    	mov	x24, x0
1042b8ed4: f9402be0    	ldr	x0, [sp, #0x50]
1042b8ed8: aa1703e1    	mov	x1, x23
1042b8edc: aa1803e2    	mov	x2, x24
1042b8ee0: 94e5b897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8ee4: aa1803e0    	mov	x0, x24
1042b8ee8: 94e5b89b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8eec: 9100077b    	add	x27, x27, #0x1
1042b8ef0: eb1b029f    	cmp	x20, x27
1042b8ef4: 54fffcc1    	b.ne	0x1042b8e8c <_Flutter_MMFoundation_BindContext+0x794a70>
1042b8ef8: 910443e2    	add	x2, sp, #0x110
1042b8efc: 910803e3    	add	x3, sp, #0x200
1042b8f00: aa1303e0    	mov	x0, x19
1042b8f04: f94027e1    	ldr	x1, [sp, #0x48]
1042b8f08: 52800204    	mov	w4, #0x10               ; =16
1042b8f0c: 94e5b88c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8f10: aa0003f4    	mov	x20, x0
1042b8f14: b5fffb00    	cbnz	x0, 0x1042b8e74 <_Flutter_MMFoundation_BindContext+0x794a58>
1042b8f18: f94047e8    	ldr	x8, [sp, #0x88]
1042b8f1c: f100051f    	cmp	x8, #0x1
1042b8f20: 1a9f17f4    	cset	w20, eq
1042b8f24: aa1303e0    	mov	x0, x19
1042b8f28: 94e5b88b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b8f2c: f00df5db    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1042b8f30: f9453773    	ldr	x19, [x27, #0xa68]
1042b8f34: f9402bfc    	ldr	x28, [sp, #0x50]
1042b8f38: aa1c03e0    	mov	x0, x28
1042b8f3c: f9404ffa    	ldr	x26, [sp, #0x98]
1042b8f40: aa1a03e1    	mov	x1, x26
1042b8f44: 94e5b87e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8f48: d00d2428    	adrp	x8, 0x11e73e000 <dyld_stub_binder+0x11e73e000>
1042b8f4c: 913f2108    	add	x8, x8, #0xfc8
1042b8f50: a947e3f9    	ldp	x25, x24, [sp, #0x78]
1042b8f54: a90083f8    	stp	x24, x0, [sp, #0x8]
1042b8f58: f90003e8    	str	x8, [sp]
1042b8f5c: d00ba455    	adrp	x21, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b8f60: 913aa2b5    	add	x21, x21, #0xea8
1042b8f64: f00ba456    	adrp	x22, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b8f68: 910a3ed6    	add	x22, x22, #0x28f
1042b8f6c: f00ba457    	adrp	x23, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b8f70: 910ab2f7    	add	x23, x23, #0x2ac
1042b8f74: aa1303e0    	mov	x0, x19
1042b8f78: aa1903e1    	mov	x1, x25
1042b8f7c: 52800042    	mov	w2, #0x2                ; =2
1042b8f80: aa1503e3    	mov	x3, x21
1042b8f84: 52800004    	mov	w4, #0x0                ; =0
1042b8f88: aa1603e5    	mov	x5, x22
1042b8f8c: 528007c6    	mov	w6, #0x3e               ; =62
1042b8f90: aa1703e7    	mov	x7, x23
1042b8f94: 94e5b86a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8f98: f00df6a8    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
1042b8f9c: f945e100    	ldr	x0, [x8, #0xbc0]
1042b8fa0: 900de568    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b8fa4: f9471501    	ldr	x1, [x8, #0xe28] ; scanPaths:enableVerboseLogging:
1042b8fa8: aa1c03e2    	mov	x2, x28
1042b8fac: aa1403e3    	mov	x3, x20
1042b8fb0: 94e5b863    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8fb4: aa1d03fd    	mov	x29, x29
1042b8fb8: 94e5b864    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8fbc: f9003be0    	str	x0, [sp, #0x70]
1042b8fc0: f9453773    	ldr	x19, [x27, #0xa68]
1042b8fc4: f94023fb    	ldr	x27, [sp, #0x40]
1042b8fc8: aa1b03e0    	mov	x0, x27
1042b8fcc: f9404bfc    	ldr	x28, [sp, #0x90]
1042b8fd0: aa1c03e1    	mov	x1, x28
1042b8fd4: 94e5b85a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8fd8: aa1d03fd    	mov	x29, x29
1042b8fdc: 94e5b85b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b8fe0: aa0003f4    	mov	x20, x0
1042b8fe4: aa1a03e1    	mov	x1, x26
1042b8fe8: 94e5b855    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b8fec: a90083f8    	stp	x24, x0, [sp, #0x8]
1042b8ff0: d00d2428    	adrp	x8, 0x11e73e000 <dyld_stub_binder+0x11e73e000>
1042b8ff4: 913fa108    	add	x8, x8, #0xfe8
1042b8ff8: f90003e8    	str	x8, [sp]
1042b8ffc: aa1303e0    	mov	x0, x19
1042b9000: aa1903e1    	mov	x1, x25
1042b9004: 52800042    	mov	w2, #0x2                ; =2
1042b9008: aa1503e3    	mov	x3, x21
1042b900c: 52800004    	mov	w4, #0x0                ; =0
1042b9010: aa1603e5    	mov	x5, x22
1042b9014: 52800826    	mov	w6, #0x41               ; =65
1042b9018: aa1703e7    	mov	x7, x23
1042b901c: 94e5b848    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9020: aa1403e0    	mov	x0, x20
1042b9024: 94e5b84c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9028: 4f00e400    	movi.16b	v0, #0x0
1042b902c: ad0783e0    	stp	q0, q0, [sp, #0xf0]
1042b9030: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1042b9034: aa1b03e0    	mov	x0, x27
1042b9038: aa1c03e1    	mov	x1, x28
1042b903c: 94e5b840    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9040: aa1d03fd    	mov	x29, x29
1042b9044: 94e5b841    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9048: 910343e2    	add	x2, sp, #0xd0
1042b904c: 910603e3    	add	x3, sp, #0x180
1042b9050: f9002fe0    	str	x0, [sp, #0x58]
1042b9054: f94027e1    	ldr	x1, [sp, #0x48]
1042b9058: 52800204    	mov	w4, #0x10               ; =16
1042b905c: 94e5b838    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9060: f9004fe0    	str	x0, [sp, #0x98]
1042b9064: b4000ce0    	cbz	x0, 0x1042b9200 <_Flutter_MMFoundation_BindContext+0x794de4>
1042b9068: f94073e8    	ldr	x8, [sp, #0xe0]
1042b906c: f9400108    	ldr	x8, [x8]
1042b9070: f90033e8    	str	x8, [sp, #0x60]
1042b9074: d2800015    	mov	x21, #0x0               ; =0
1042b9078: 900df268    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
1042b907c: f9438d13    	ldr	x19, [x8, #0x718] ; path
1042b9080: d00df288    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1042b9084: f941c914    	ldr	x20, [x8, #0x390] ; type
1042b9088: d00ddd68    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
1042b908c: f9415108    	ldr	x8, [x8, #0x2a0] ; pathComponents
1042b9090: f9004be8    	str	x8, [sp, #0x90]
1042b9094: b00df248    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1042b9098: f9448119    	ldr	x25, [x8, #0x900] ; head
1042b909c: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b90a0: f947191c    	ldr	x28, [x8, #0xe30] ; markFilesWithPathComponents:relativeToDirectory:forDeviationDirectiveType:atLevel:enableVerboseLogging:
1042b90a4: f94073e8    	ldr	x8, [sp, #0xe0]
1042b90a8: f9400108    	ldr	x8, [x8]
1042b90ac: f94033e9    	ldr	x9, [sp, #0x60]
1042b90b0: eb09011f    	cmp	x8, x9
1042b90b4: 54000060    	b.eq	0x1042b90c0 <_Flutter_MMFoundation_BindContext+0x794ca4>
1042b90b8: f9402fe0    	ldr	x0, [sp, #0x58]
1042b90bc: 94e5b825    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1042b90c0: f94047e8    	ldr	x8, [sp, #0x88]
1042b90c4: f100051f    	cmp	x8, #0x1
1042b90c8: 1a9f17fa    	cset	w26, eq
1042b90cc: f9406fe8    	ldr	x8, [sp, #0xd8]
1042b90d0: f8757916    	ldr	x22, [x8, x21, lsl #3]
1042b90d4: d00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b90d8: f9453517    	ldr	x23, [x8, #0xa68]
1042b90dc: aa1603e0    	mov	x0, x22
1042b90e0: aa1303e1    	mov	x1, x19
1042b90e4: 94e5b816    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b90e8: aa1d03fd    	mov	x29, x29
1042b90ec: 94e5b817    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b90f0: aa0003f8    	mov	x24, x0
1042b90f4: aa1603e0    	mov	x0, x22
1042b90f8: aa1403e1    	mov	x1, x20
1042b90fc: 94e5b810    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9100: a90103f8    	stp	x24, x0, [sp, #0x10]
1042b9104: a947a7e1    	ldp	x1, x9, [sp, #0x78]
1042b9108: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b910c: 91002108    	add	x8, x8, #0x8
1042b9110: a90027e8    	stp	x8, x9, [sp]
1042b9114: aa1703e0    	mov	x0, x23
1042b9118: 52800042    	mov	w2, #0x2                ; =2
1042b911c: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9120: 913aa063    	add	x3, x3, #0xea8
1042b9124: 52800004    	mov	w4, #0x0                ; =0
1042b9128: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b912c: 910a3ca5    	add	x5, x5, #0x28f
1042b9130: 52800866    	mov	w6, #0x43               ; =67
1042b9134: d00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9138: 910ab0e7    	add	x7, x7, #0x2ac
1042b913c: 94e5b800    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9140: aa1803e0    	mov	x0, x24
1042b9144: 94e5b804    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9148: aa1603e0    	mov	x0, x22
1042b914c: aa1303e1    	mov	x1, x19
1042b9150: 94e5b7fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9154: aa1d03fd    	mov	x29, x29
1042b9158: 94e5b7fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b915c: aa0003f7    	mov	x23, x0
1042b9160: f9404be1    	ldr	x1, [sp, #0x90]
1042b9164: 94e5b7f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9168: aa1d03fd    	mov	x29, x29
1042b916c: 94e5b7f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9170: aa0003f8    	mov	x24, x0
1042b9174: f9403be0    	ldr	x0, [sp, #0x70]
1042b9178: aa1903e1    	mov	x1, x25
1042b917c: 94e5b7f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9180: aa1d03fd    	mov	x29, x29
1042b9184: 94e5b7f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9188: aa0003fb    	mov	x27, x0
1042b918c: aa1603e0    	mov	x0, x22
1042b9190: aa1403e1    	mov	x1, x20
1042b9194: 94e5b7ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9198: aa0003e4    	mov	x4, x0
1042b919c: f94037e0    	ldr	x0, [sp, #0x68]
1042b91a0: aa1c03e1    	mov	x1, x28
1042b91a4: aa1803e2    	mov	x2, x24
1042b91a8: aa1b03e3    	mov	x3, x27
1042b91ac: d2800005    	mov	x5, #0x0                ; =0
1042b91b0: aa1a03e6    	mov	x6, x26
1042b91b4: 94e5b7e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b91b8: aa1b03e0    	mov	x0, x27
1042b91bc: 94e5b7e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b91c0: aa1803e0    	mov	x0, x24
1042b91c4: 94e5b7e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b91c8: aa1703e0    	mov	x0, x23
1042b91cc: 94e5b7e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b91d0: 910006b5    	add	x21, x21, #0x1
1042b91d4: f9404fe8    	ldr	x8, [sp, #0x98]
1042b91d8: eb15011f    	cmp	x8, x21
1042b91dc: 54fff641    	b.ne	0x1042b90a4 <_Flutter_MMFoundation_BindContext+0x794c88>
1042b91e0: 910343e2    	add	x2, sp, #0xd0
1042b91e4: 910603e3    	add	x3, sp, #0x180
1042b91e8: f9402fe0    	ldr	x0, [sp, #0x58]
1042b91ec: f94027e1    	ldr	x1, [sp, #0x48]
1042b91f0: 52800204    	mov	w4, #0x10               ; =16
1042b91f4: 94e5b7d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b91f8: f9004fe0    	str	x0, [sp, #0x98]
1042b91fc: b5fff3c0    	cbnz	x0, 0x1042b9074 <_Flutter_MMFoundation_BindContext+0x794c58>
1042b9200: f94047f8    	ldr	x24, [sp, #0x88]
1042b9204: f100071f    	cmp	x24, #0x1
1042b9208: 1a9f17f3    	cset	w19, eq
1042b920c: f9402fe0    	ldr	x0, [sp, #0x58]
1042b9210: 94e5b7d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9214: d00df5d7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1042b9218: f94536e0    	ldr	x0, [x23, #0xa68]
1042b921c: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b9220: 9100a108    	add	x8, x8, #0x28
1042b9224: a947dbf9    	ldp	x25, x22, [sp, #0x78]
1042b9228: a9005be8    	stp	x8, x22, [sp]
1042b922c: b00ba45b    	adrp	x27, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9230: 913aa37b    	add	x27, x27, #0xea8
1042b9234: d00ba45a    	adrp	x26, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9238: 910a3f5a    	add	x26, x26, #0x28f
1042b923c: d00ba45c    	adrp	x28, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9240: 910ab39c    	add	x28, x28, #0x2ac
1042b9244: aa1903e1    	mov	x1, x25
1042b9248: 52800042    	mov	w2, #0x2                ; =2
1042b924c: aa1b03e3    	mov	x3, x27
1042b9250: 52800004    	mov	w4, #0x0                ; =0
1042b9254: aa1a03e5    	mov	x5, x26
1042b9258: 52800966    	mov	w6, #0x4b               ; =75
1042b925c: aa1c03e7    	mov	x7, x28
1042b9260: 94e5b7b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9264: b00df268    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1042b9268: f943d901    	ldr	x1, [x8, #0x7b0] ; root
1042b926c: f9403bf5    	ldr	x21, [sp, #0x70]
1042b9270: aa1503e0    	mov	x0, x21
1042b9274: 94e5b7b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9278: aa1d03fd    	mov	x29, x29
1042b927c: 94e5b7b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9280: aa0003f4    	mov	x20, x0
1042b9284: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9288: f9471d01    	ldr	x1, [x8, #0xe38] ; fileReferences
1042b928c: aa1503e0    	mov	x0, x21
1042b9290: 94e5b7ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9294: aa1d03fd    	mov	x29, x29
1042b9298: 94e5b7ac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b929c: aa0003f5    	mov	x21, x0
1042b92a0: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b92a4: f9472101    	ldr	x1, [x8, #0xe40] ; cleanupFilesInDirectory:forScenario:withFileReferences:enableVerboseLogging:
1042b92a8: f94037e0    	ldr	x0, [sp, #0x68]
1042b92ac: aa1403e2    	mov	x2, x20
1042b92b0: aa1803e3    	mov	x3, x24
1042b92b4: aa1503e4    	mov	x4, x21
1042b92b8: aa1303e5    	mov	x5, x19
1042b92bc: 94e5b7a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b92c0: aa0003f3    	mov	x19, x0
1042b92c4: aa1503e0    	mov	x0, x21
1042b92c8: 94e5b7a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b92cc: aa1403e0    	mov	x0, x20
1042b92d0: 94e5b7a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b92d4: f94536e0    	ldr	x0, [x23, #0xa68]
1042b92d8: aa1303f7    	mov	x23, x19
1042b92dc: a900cff6    	stp	x22, x19, [sp, #0x8]
1042b92e0: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b92e4: 91012108    	add	x8, x8, #0x48
1042b92e8: f90003e8    	str	x8, [sp]
1042b92ec: aa1903e1    	mov	x1, x25
1042b92f0: 52800042    	mov	w2, #0x2                ; =2
1042b92f4: aa1b03e3    	mov	x3, x27
1042b92f8: 52800004    	mov	w4, #0x0                ; =0
1042b92fc: aa1a03e5    	mov	x5, x26
1042b9300: 52800a26    	mov	w6, #0x51               ; =81
1042b9304: aa1c03e7    	mov	x7, x28
1042b9308: aa1c03fa    	mov	x26, x28
1042b930c: 94e5b78c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9310: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9314: f9472501    	ldr	x1, [x8, #0xe48] ; setContributionStage:
1042b9318: f94023fc    	ldr	x28, [sp, #0x40]
1042b931c: aa1c03e0    	mov	x0, x28
1042b9320: 52800022    	mov	w2, #0x1                ; =1
1042b9324: 94e5b786    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9328: 94e5b7f9    	bl	0x107c2730c <_Flutter_MMFoundation_BindContext+0x4102ef0>
1042b932c: aa0003f3    	mov	x19, x0
1042b9330: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9334: f9472901    	ldr	x1, [x8, #0xe50] ; setExternalCleanupTasksGroup:
1042b9338: aa1c03e0    	mov	x0, x28
1042b933c: aa1303e2    	mov	x2, x19
1042b9340: 94e5b77f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9344: aa1303e0    	mov	x0, x19
1042b9348: 94e5b783    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b934c: d00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b9350: f945e900    	ldr	x0, [x8, #0xbd0]
1042b9354: f9401be1    	ldr	x1, [sp, #0x30]
1042b9358: 94e5b779    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b935c: aa1d03fd    	mov	x29, x29
1042b9360: 94e5b77a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9364: aa0003f3    	mov	x19, x0
1042b9368: 900df5c8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
1042b936c: f9428914    	ldr	x20, [x8, #0x510]
1042b9370: b00ddfa8    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
1042b9374: f942bd15    	ldr	x21, [x8, #0x578] ; willFinishStorageCleanupInScenario:withContext:
1042b9378: b00c99a8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1042b937c: f947e108    	ldr	x8, [x8, #0xfc0]
1042b9380: f90053e8    	str	x8, [sp, #0xa0]
1042b9384: fd0057e8    	str	d8, [sp, #0xa8]
1042b9388: 90000008    	adrp	x8, 0x1042b9000 <_Flutter_MMFoundation_BindContext+0x794be4>
1042b938c: 91165109    	add	x9, x8, #0x594
1042b9390: d00c9a28    	adrp	x8, 0x11d5ff000 <dyld_stub_binder+0x11d5ff000>
1042b9394: 911e6108    	add	x8, x8, #0x798
1042b9398: a90b23e9    	stp	x9, x8, [sp, #0xb0]
1042b939c: f90067f8    	str	x24, [sp, #0xc8]
1042b93a0: aa1c03e0    	mov	x0, x28
1042b93a4: 94e5b765    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1042b93a8: f90063fc    	str	x28, [sp, #0xc0]
1042b93ac: 910283e5    	add	x5, sp, #0xa0
1042b93b0: aa1303e0    	mov	x0, x19
1042b93b4: f94017e1    	ldr	x1, [sp, #0x28]
1042b93b8: aa1403e2    	mov	x2, x20
1042b93bc: aa1503e3    	mov	x3, x21
1042b93c0: 52800024    	mov	w4, #0x1                ; =1
1042b93c4: 94e5b75e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b93c8: aa1303e0    	mov	x0, x19
1042b93cc: 94e5b762    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b93d0: f94063e0    	ldr	x0, [sp, #0xc0]
1042b93d4: 94e5b760    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b93d8: d00df5db    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1042b93dc: f9453760    	ldr	x0, [x27, #0xa68]
1042b93e0: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b93e4: 9101a108    	add	x8, x8, #0x68
1042b93e8: a9005be8    	stp	x8, x22, [sp]
1042b93ec: aa1903e1    	mov	x1, x25
1042b93f0: 52800042    	mov	w2, #0x2                ; =2
1042b93f4: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b93f8: 913aa063    	add	x3, x3, #0xea8
1042b93fc: 52800004    	mov	w4, #0x0                ; =0
1042b9400: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9404: 910a3ca5    	add	x5, x5, #0x28f
1042b9408: 52800ac6    	mov	w6, #0x56               ; =86
1042b940c: aa1a03e7    	mov	x7, x26
1042b9410: 94e5b74b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9414: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9418: f946f901    	ldr	x1, [x8, #0xdf0] ; externalCleanupTasksGroup
1042b941c: aa1c03e0    	mov	x0, x28
1042b9420: 94e5b747    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9424: aa1d03fd    	mov	x29, x29
1042b9428: 94e5b748    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b942c: aa0003f3    	mov	x19, x0
1042b9430: d2958001    	mov	x1, #0xac00             ; =44032
1042b9434: f2bf8461    	movk	x1, #0xfc23, lsl #16
1042b9438: f2c000c1    	movk	x1, #0x6, lsl #32
1042b943c: d2800000    	mov	x0, #0x0                ; =0
1042b9440: 94e5b760    	bl	0x107c271c0 <_Flutter_MMFoundation_BindContext+0x4102da4>
1042b9444: aa0003e1    	mov	x1, x0
1042b9448: aa1303e0    	mov	x0, x19
1042b944c: 94e5b7b6    	bl	0x107c27324 <_Flutter_MMFoundation_BindContext+0x4102f08>
1042b9450: aa0003f4    	mov	x20, x0
1042b9454: aa1303e0    	mov	x0, x19
1042b9458: 94e5b73f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b945c: b4000214    	cbz	x20, 0x1042b949c <_Flutter_MMFoundation_BindContext+0x795080>
1042b9460: f9453760    	ldr	x0, [x27, #0xa68]
1042b9464: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b9468: 91022108    	add	x8, x8, #0x88
1042b946c: a9005be8    	stp	x8, x22, [sp]
1042b9470: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9474: 913aa063    	add	x3, x3, #0xea8
1042b9478: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b947c: 910a3ca5    	add	x5, x5, #0x28f
1042b9480: d00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9484: 910ab0e7    	add	x7, x7, #0x2ac
1042b9488: aa1903e1    	mov	x1, x25
1042b948c: 52800082    	mov	w2, #0x4                ; =4
1042b9490: 52800004    	mov	w4, #0x0                ; =0
1042b9494: 52800b46    	mov	w6, #0x5a               ; =90
1042b9498: 94e5b729    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b949c: f9453773    	ldr	x19, [x27, #0xa68]
1042b94a0: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b94a4: f946fd14    	ldr	x20, [x8, #0xdf8] ; externalCleanupContribution
1042b94a8: f94023f5    	ldr	x21, [sp, #0x40]
1042b94ac: aa1503e0    	mov	x0, x21
1042b94b0: aa1403e1    	mov	x1, x20
1042b94b4: 94e5b722    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b94b8: a90183f7    	stp	x23, x0, [sp, #0x18]
1042b94bc: f94047e8    	ldr	x8, [sp, #0x88]
1042b94c0: a900a3f6    	stp	x22, x8, [sp, #0x8]
1042b94c4: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b94c8: 9102a108    	add	x8, x8, #0xa8
1042b94cc: f90003e8    	str	x8, [sp]
1042b94d0: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b94d4: 913aa063    	add	x3, x3, #0xea8
1042b94d8: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b94dc: 910a3ca5    	add	x5, x5, #0x28f
1042b94e0: d00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b94e4: 910ab0e7    	add	x7, x7, #0x2ac
1042b94e8: aa1303e0    	mov	x0, x19
1042b94ec: aa1903e1    	mov	x1, x25
1042b94f0: 52800042    	mov	w2, #0x2                ; =2
1042b94f4: 52800004    	mov	w4, #0x0                ; =0
1042b94f8: 52800c26    	mov	w6, #0x61               ; =97
1042b94fc: 94e5b710    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9500: aa1503e0    	mov	x0, x21
1042b9504: aa1403e1    	mov	x1, x20
1042b9508: 94e5b70d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b950c: aa0003f3    	mov	x19, x0
1042b9510: f9403be0    	ldr	x0, [sp, #0x70]
1042b9514: 94e5b710    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9518: f9402be0    	ldr	x0, [sp, #0x50]
1042b951c: 94e5b70e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9520: f9401fe0    	ldr	x0, [sp, #0x38]
1042b9524: 94e5b70c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9528: aa1503e0    	mov	x0, x21
1042b952c: 94e5b70a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9530: aa1603e0    	mov	x0, x22
1042b9534: 94e5b708    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9538: f85903a8    	ldur	x8, [x29, #-0x70]
1042b953c: d00c99a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1042b9540: f9405929    	ldr	x9, [x9, #0xb0]
1042b9544: f9400129    	ldr	x9, [x9]
1042b9548: eb08013f    	cmp	x9, x8
1042b954c: 54000161    	b.ne	0x1042b9578 <_Flutter_MMFoundation_BindContext+0x79515c>
1042b9550: 8b170260    	add	x0, x19, x23
1042b9554: 910ac3ff    	add	sp, sp, #0x2b0
1042b9558: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1042b955c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1042b9560: a94457f6    	ldp	x22, x21, [sp, #0x40]
1042b9564: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1042b9568: a94267fa    	ldp	x26, x25, [sp, #0x20]
1042b956c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1042b9570: 6cc723e9    	ldp	d9, d8, [sp], #0x70
1042b9574: d65f03c0    	ret
1042b9578: 94e5b6ff    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
