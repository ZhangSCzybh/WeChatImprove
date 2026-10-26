
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1042b9e88: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1042b9e8c: a90167fa    	stp	x26, x25, [sp, #0x10]
1042b9e90: a9025ff8    	stp	x24, x23, [sp, #0x20]
1042b9e94: a90357f6    	stp	x22, x21, [sp, #0x30]
1042b9e98: a9044ff4    	stp	x20, x19, [sp, #0x40]
1042b9e9c: a9057bfd    	stp	x29, x30, [sp, #0x50]
1042b9ea0: 910143fd    	add	x29, sp, #0x50
1042b9ea4: d10983ff    	sub	sp, sp, #0x260
1042b9ea8: aa0503f4    	mov	x20, x5
1042b9eac: aa0403f3    	mov	x19, x4
1042b9eb0: f90067e3    	str	x3, [sp, #0xc8]
1042b9eb4: aa0203f5    	mov	x21, x2
1042b9eb8: f9005be0    	str	x0, [sp, #0xb0]
1042b9ebc: d00c99a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1042b9ec0: f9405908    	ldr	x8, [x8, #0xb0]
1042b9ec4: f9400108    	ldr	x8, [x8]
1042b9ec8: f81a03a8    	stur	x8, [x29, #-0x60]
1042b9ecc: f00e4c08    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
1042b9ed0: 52800029    	mov	w9, #0x1                ; =1
1042b9ed4: 3915a109    	strb	w9, [x8, #0x568]
1042b9ed8: aa0203e0    	mov	x0, x2
1042b9edc: 94e5b497    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1042b9ee0: f9005ff3    	str	x19, [sp, #0xb8]
1042b9ee4: aa1303e0    	mov	x0, x19
1042b9ee8: 94e5b494    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1042b9eec: b900c7f4    	str	w20, [sp, #0xc4]
1042b9ef0: 340003d4    	cbz	w20, 0x1042b9f68 <_Flutter_MMFoundation_BindContext+0x795b4c>
1042b9ef4: d00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b9ef8: f9453513    	ldr	x19, [x8, #0xa68]
1042b9efc: b00de008    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1042b9f00: f946b501    	ldr	x1, [x8, #0xd68] ; fullPath
1042b9f04: aa1503e0    	mov	x0, x21
1042b9f08: 94e5b48d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9f0c: aa1d03fd    	mov	x29, x29
1042b9f10: 94e5b48e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9f14: aa0003f4    	mov	x20, x0
1042b9f18: 900ddc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042b9f1c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042b9f20: f94067e8    	ldr	x8, [sp, #0xc8]
1042b9f24: a900a3e0    	stp	x0, x8, [sp, #0x8]
1042b9f28: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b9f2c: 9107a108    	add	x8, x8, #0x1e8
1042b9f30: f90003e8    	str	x8, [sp]
1042b9f34: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9f38: 913aa063    	add	x3, x3, #0xea8
1042b9f3c: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9f40: 910a3ca5    	add	x5, x5, #0x28f
1042b9f44: d00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9f48: 911f74e7    	add	x7, x7, #0x7dd
1042b9f4c: aa1303e0    	mov	x0, x19
1042b9f50: 52800042    	mov	w2, #0x2                ; =2
1042b9f54: 52800004    	mov	w4, #0x0                ; =0
1042b9f58: 528015a6    	mov	w6, #0xad               ; =173
1042b9f5c: 94e5b478    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9f60: aa1403e0    	mov	x0, x20
1042b9f64: 94e5b47c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9f68: 4f00e400    	movi.16b	v0, #0x0
1042b9f6c: ad0983e0    	stp	q0, q0, [sp, #0x130]
1042b9f70: ad0883e0    	stp	q0, q0, [sp, #0x110]
1042b9f74: d00de0e8    	adrp	x8, 0x11fed7000 <dyld_stub_binder+0x11fed7000>
1042b9f78: f941e101    	ldr	x1, [x8, #0x3c0] ; files
1042b9f7c: f9001bf5    	str	x21, [sp, #0x30]
1042b9f80: aa1503e0    	mov	x0, x21
1042b9f84: 94e5b46e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9f88: aa1d03fd    	mov	x29, x29
1042b9f8c: 94e5b46f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9f90: aa0003f7    	mov	x23, x0
1042b9f94: f00df228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1042b9f98: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1042b9f9c: 910443e2    	add	x2, sp, #0x110
1042b9fa0: d10383a3    	sub	x3, x29, #0xe0
1042b9fa4: f9001fe1    	str	x1, [sp, #0x38]
1042b9fa8: 52800204    	mov	w4, #0x10               ; =16
1042b9fac: 94e5b464    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9fb0: b4002b20    	cbz	x0, 0x1042ba514 <_Flutter_MMFoundation_BindContext+0x7960f8>
1042b9fb4: aa0003fb    	mov	x27, x0
1042b9fb8: d2800018    	mov	x24, #0x0               ; =0
1042b9fbc: f94093e8    	ldr	x8, [sp, #0x120]
1042b9fc0: f9400119    	ldr	x25, [x8]
1042b9fc4: b00ba456    	adrp	x22, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9fc8: 913aa2d6    	add	x22, x22, #0xea8
1042b9fcc: f90027f7    	str	x23, [sp, #0x48]
1042b9fd0: f90033f9    	str	x25, [sp, #0x60]
1042b9fd4: d2800013    	mov	x19, #0x0               ; =0
1042b9fd8: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9fdc: f947451c    	ldr	x28, [x8, #0xe88] ; markedForPreservation
1042b9fe0: b00de008    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1042b9fe4: f946b509    	ldr	x9, [x8, #0xd68] ; fullPath
1042b9fe8: 900ddc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042b9fec: f946f10a    	ldr	x10, [x8, #0xde0] ; RemoveFile:
1042b9ff0: 900ddc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042b9ff4: f942a908    	ldr	x8, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042b9ff8: a90a27e8    	stp	x8, x9, [sp, #0xa0]
1042b9ffc: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042ba000: f9474909    	ldr	x9, [x8, #0xe90] ; fileContentIdAvailable
1042ba004: d00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042ba008: f9474d0b    	ldr	x11, [x8, #0xe98] ; sizeOnDisk
1042ba00c: d00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042ba010: f9475108    	ldr	x8, [x8, #0xea0] ; fileContentId
1042ba014: a90927e8    	stp	x8, x9, [sp, #0x90]
1042ba018: d00df248    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1042ba01c: f947a908    	ldr	x8, [x8, #0xf50] ; numberWithInteger:
1042ba020: a9072be8    	stp	x8, x10, [sp, #0x70]
1042ba024: d00df248    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1042ba028: f947f108    	ldr	x8, [x8, #0xfe0] ; objectForKey:
1042ba02c: f90037e8    	str	x8, [sp, #0x68]
1042ba030: d00df228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1042ba034: f9435108    	ldr	x8, [x8, #0x6a0] ; count
1042ba038: a9082fe8    	stp	x8, x11, [sp, #0x80]
1042ba03c: 900df288    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1042ba040: f9442509    	ldr	x9, [x8, #0x848] ; size
1042ba044: b00ddc08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1042ba048: f9462108    	ldr	x8, [x8, #0xc40] ; safeRemoveObjectForKey:
1042ba04c: f90023e8    	str	x8, [sp, #0x40]
1042ba050: b00df268    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1042ba054: f943f108    	ldr	x8, [x8, #0x7e0] ; setCount:
1042ba058: a90527e8    	stp	x8, x9, [sp, #0x50]
1042ba05c: f94093e8    	ldr	x8, [sp, #0x120]
1042ba060: f9400108    	ldr	x8, [x8]
1042ba064: eb19011f    	cmp	x8, x25
1042ba068: 54000060    	b.eq	0x1042ba074 <_Flutter_MMFoundation_BindContext+0x795c58>
1042ba06c: aa1703e0    	mov	x0, x23
1042ba070: 94e5b438    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1042ba074: f9408fe8    	ldr	x8, [sp, #0x118]
1042ba078: f873791a    	ldr	x26, [x8, x19, lsl #3]
1042ba07c: aa1a03e0    	mov	x0, x26
1042ba080: aa1c03e1    	mov	x1, x28
1042ba084: 94e5b42e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba088: 340002e0    	cbz	w0, 0x1042ba0e4 <_Flutter_MMFoundation_BindContext+0x795cc8>
1042ba08c: b940c7e8    	ldr	w8, [sp, #0xc4]
1042ba090: 340022a8    	cbz	w8, 0x1042ba4e4 <_Flutter_MMFoundation_BindContext+0x7960c8>
1042ba094: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba098: f9453514    	ldr	x20, [x8, #0xa68]
1042ba09c: aa1a03e0    	mov	x0, x26
1042ba0a0: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba0a4: 94e5b426    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba0a8: aa1d03fd    	mov	x29, x29
1042ba0ac: 94e5b427    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba0b0: aa0003f5    	mov	x21, x0
1042ba0b4: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba0b8: 91082108    	add	x8, x8, #0x208
1042ba0bc: a90003e8    	stp	x8, x0, [sp]
1042ba0c0: aa1403e0    	mov	x0, x20
1042ba0c4: f94053e1    	ldr	x1, [sp, #0xa0]
1042ba0c8: 52800042    	mov	w2, #0x2                ; =2
1042ba0cc: aa1603e3    	mov	x3, x22
1042ba0d0: 52800004    	mov	w4, #0x0                ; =0
1042ba0d4: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba0d8: 910a3ca5    	add	x5, x5, #0x28f
1042ba0dc: 52801626    	mov	w6, #0xb1               ; =177
1042ba0e0: 14000098    	b	0x1042ba340 <_Flutter_MMFoundation_BindContext+0x795f24>
1042ba0e4: f94067e8    	ldr	x8, [sp, #0xc8]
1042ba0e8: f100051f    	cmp	x8, #0x1
1042ba0ec: 54000221    	b.ne	0x1042ba130 <_Flutter_MMFoundation_BindContext+0x795d14>
1042ba0f0: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba0f4: f9463514    	ldr	x20, [x8, #0xc68]
1042ba0f8: aa1a03e0    	mov	x0, x26
1042ba0fc: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba100: 94e5b40f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba104: aa1d03fd    	mov	x29, x29
1042ba108: 94e5b410    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba10c: aa0003f5    	mov	x21, x0
1042ba110: aa1403e0    	mov	x0, x20
1042ba114: f9403fe1    	ldr	x1, [sp, #0x78]
1042ba118: aa1503e2    	mov	x2, x21
1042ba11c: 94e5b408    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba120: aa0003f4    	mov	x20, x0
1042ba124: aa1503e0    	mov	x0, x21
1042ba128: 94e5b40b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba12c: 36000e54    	tbz	w20, #0x0, 0x1042ba2f4 <_Flutter_MMFoundation_BindContext+0x795ed8>
1042ba130: aa1a03e0    	mov	x0, x26
1042ba134: f9404fe1    	ldr	x1, [sp, #0x98]
1042ba138: 94e5b401    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba13c: 36000960    	tbz	w0, #0x0, 0x1042ba268 <_Flutter_MMFoundation_BindContext+0x795e4c>
1042ba140: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba144: f9458914    	ldr	x20, [x8, #0xb10]
1042ba148: aa1a03e0    	mov	x0, x26
1042ba14c: f9404be1    	ldr	x1, [sp, #0x90]
1042ba150: 94e5b3fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba154: aa0003e2    	mov	x2, x0
1042ba158: aa1403e0    	mov	x0, x20
1042ba15c: f9403be1    	ldr	x1, [sp, #0x70]
1042ba160: 94e5b3f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba164: aa1d03fd    	mov	x29, x29
1042ba168: 94e5b3f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba16c: aa0003f4    	mov	x20, x0
1042ba170: f9405fe0    	ldr	x0, [sp, #0xb8]
1042ba174: f94037e1    	ldr	x1, [sp, #0x68]
1042ba178: aa1403e2    	mov	x2, x20
1042ba17c: 94e5b3f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba180: aa1d03fd    	mov	x29, x29
1042ba184: 94e5b3f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba188: aa0003f9    	mov	x25, x0
1042ba18c: aa1403e0    	mov	x0, x20
1042ba190: 94e5b3f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba194: aa1903e0    	mov	x0, x25
1042ba198: f94043e1    	ldr	x1, [sp, #0x80]
1042ba19c: 94e5b3e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba1a0: f100081f    	cmp	x0, #0x2
1042ba1a4: 54000da3    	b.lo	0x1042ba358 <_Flutter_MMFoundation_BindContext+0x795f3c>
1042ba1a8: b940c7e8    	ldr	w8, [sp, #0xc4]
1042ba1ac: 340004e8    	cbz	w8, 0x1042ba248 <_Flutter_MMFoundation_BindContext+0x795e2c>
1042ba1b0: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba1b4: f9453514    	ldr	x20, [x8, #0xa68]
1042ba1b8: aa1a03e0    	mov	x0, x26
1042ba1bc: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba1c0: 94e5b3df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba1c4: aa1d03fd    	mov	x29, x29
1042ba1c8: 94e5b3e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba1cc: aa0003f5    	mov	x21, x0
1042ba1d0: aa1a03e0    	mov	x0, x26
1042ba1d4: f9404be1    	ldr	x1, [sp, #0x90]
1042ba1d8: 94e5b3d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba1dc: aa0003f7    	mov	x23, x0
1042ba1e0: aa1903e0    	mov	x0, x25
1042ba1e4: f9402fe1    	ldr	x1, [sp, #0x58]
1042ba1e8: 94e5b3d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba1ec: aa0003fa    	mov	x26, x0
1042ba1f0: aa1903e0    	mov	x0, x25
1042ba1f4: f94043e1    	ldr	x1, [sp, #0x80]
1042ba1f8: 94e5b3d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba1fc: a90183fa    	stp	x26, x0, [sp, #0x18]
1042ba200: a900dff5    	stp	x21, x23, [sp, #0x8]
1042ba204: f94027f7    	ldr	x23, [sp, #0x48]
1042ba208: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba20c: 9109a108    	add	x8, x8, #0x268
1042ba210: f90003e8    	str	x8, [sp]
1042ba214: aa1403e0    	mov	x0, x20
1042ba218: f94053e1    	ldr	x1, [sp, #0xa0]
1042ba21c: 52800042    	mov	w2, #0x2                ; =2
1042ba220: aa1603e3    	mov	x3, x22
1042ba224: 52800004    	mov	w4, #0x0                ; =0
1042ba228: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba22c: 910a3ca5    	add	x5, x5, #0x28f
1042ba230: 52801906    	mov	w6, #0xc8               ; =200
1042ba234: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba238: 911f74e7    	add	x7, x7, #0x7dd
1042ba23c: 94e5b3c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba240: aa1503e0    	mov	x0, x21
1042ba244: 94e5b3c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba248: aa1903e0    	mov	x0, x25
1042ba24c: f94043e1    	ldr	x1, [sp, #0x80]
1042ba250: 94e5b3bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba254: d1000402    	sub	x2, x0, #0x1
1042ba258: aa1903e0    	mov	x0, x25
1042ba25c: f9402be1    	ldr	x1, [sp, #0x50]
1042ba260: 94e5b3b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba264: 1400009d    	b	0x1042ba4d8 <_Flutter_MMFoundation_BindContext+0x7960bc>
1042ba268: b940c7e8    	ldr	w8, [sp, #0xc4]
1042ba26c: 340003a8    	cbz	w8, 0x1042ba2e0 <_Flutter_MMFoundation_BindContext+0x795ec4>
1042ba270: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba274: f9453514    	ldr	x20, [x8, #0xa68]
1042ba278: aa1a03e0    	mov	x0, x26
1042ba27c: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba280: 94e5b3af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba284: aa1d03fd    	mov	x29, x29
1042ba288: 94e5b3b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba28c: aa0003f5    	mov	x21, x0
1042ba290: aa1a03e0    	mov	x0, x26
1042ba294: f94047e1    	ldr	x1, [sp, #0x88]
1042ba298: 94e5b3a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba29c: a90083f5    	stp	x21, x0, [sp, #0x8]
1042ba2a0: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba2a4: 91092108    	add	x8, x8, #0x248
1042ba2a8: f90003e8    	str	x8, [sp]
1042ba2ac: aa1403e0    	mov	x0, x20
1042ba2b0: f94053e1    	ldr	x1, [sp, #0xa0]
1042ba2b4: 52800042    	mov	w2, #0x2                ; =2
1042ba2b8: aa1603e3    	mov	x3, x22
1042ba2bc: 52800004    	mov	w4, #0x0                ; =0
1042ba2c0: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba2c4: 910a3ca5    	add	x5, x5, #0x28f
1042ba2c8: 528017a6    	mov	w6, #0xbd               ; =189
1042ba2cc: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba2d0: 911f74e7    	add	x7, x7, #0x7dd
1042ba2d4: 94e5b39a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba2d8: aa1503e0    	mov	x0, x21
1042ba2dc: 94e5b39e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba2e0: aa1a03e0    	mov	x0, x26
1042ba2e4: f94047e1    	ldr	x1, [sp, #0x88]
1042ba2e8: 94e5b395    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba2ec: 8b180018    	add	x24, x0, x24
1042ba2f0: 1400007d    	b	0x1042ba4e4 <_Flutter_MMFoundation_BindContext+0x7960c8>
1042ba2f4: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba2f8: f9453514    	ldr	x20, [x8, #0xa68]
1042ba2fc: aa1a03e0    	mov	x0, x26
1042ba300: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba304: 94e5b38e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba308: aa1d03fd    	mov	x29, x29
1042ba30c: 94e5b38f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba310: aa0003f5    	mov	x21, x0
1042ba314: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba318: 9108a108    	add	x8, x8, #0x228
1042ba31c: a90003e8    	stp	x8, x0, [sp]
1042ba320: aa1403e0    	mov	x0, x20
1042ba324: f94053e1    	ldr	x1, [sp, #0xa0]
1042ba328: 52800082    	mov	w2, #0x4                ; =4
1042ba32c: aa1603e3    	mov	x3, x22
1042ba330: 52800004    	mov	w4, #0x0                ; =0
1042ba334: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba338: 910a3ca5    	add	x5, x5, #0x28f
1042ba33c: 528016c6    	mov	w6, #0xb6               ; =182
1042ba340: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba344: 911f74e7    	add	x7, x7, #0x7dd
1042ba348: 94e5b37d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba34c: aa1503e0    	mov	x0, x21
1042ba350: 94e5b381    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba354: 14000064    	b	0x1042ba4e4 <_Flutter_MMFoundation_BindContext+0x7960c8>
1042ba358: b4000739    	cbz	x25, 0x1042ba43c <_Flutter_MMFoundation_BindContext+0x796020>
1042ba35c: b940c7e8    	ldr	w8, [sp, #0xc4]
1042ba360: 34000448    	cbz	w8, 0x1042ba3e8 <_Flutter_MMFoundation_BindContext+0x795fcc>
1042ba364: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba368: f9453514    	ldr	x20, [x8, #0xa68]
1042ba36c: aa1a03e0    	mov	x0, x26
1042ba370: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba374: 94e5b372    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba378: aa1d03fd    	mov	x29, x29
1042ba37c: 94e5b373    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba380: aa0003f5    	mov	x21, x0
1042ba384: aa1a03e0    	mov	x0, x26
1042ba388: f9404be1    	ldr	x1, [sp, #0x90]
1042ba38c: 94e5b36c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba390: aa0003f7    	mov	x23, x0
1042ba394: aa1903e0    	mov	x0, x25
1042ba398: f9402fe1    	ldr	x1, [sp, #0x58]
1042ba39c: 94e5b368    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba3a0: a90103f7    	stp	x23, x0, [sp, #0x10]
1042ba3a4: f94027f7    	ldr	x23, [sp, #0x48]
1042ba3a8: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba3ac: 910a2108    	add	x8, x8, #0x288
1042ba3b0: a90057e8    	stp	x8, x21, [sp]
1042ba3b4: aa1403e0    	mov	x0, x20
1042ba3b8: f94053e1    	ldr	x1, [sp, #0xa0]
1042ba3bc: 52800042    	mov	w2, #0x2                ; =2
1042ba3c0: aa1603e3    	mov	x3, x22
1042ba3c4: 52800004    	mov	w4, #0x0                ; =0
1042ba3c8: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba3cc: 910a3ca5    	add	x5, x5, #0x28f
1042ba3d0: 528019e6    	mov	w6, #0xcf               ; =207
1042ba3d4: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba3d8: 911f74e7    	add	x7, x7, #0x7dd
1042ba3dc: 94e5b358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba3e0: aa1503e0    	mov	x0, x21
1042ba3e4: 94e5b35c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba3e8: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba3ec: f9458914    	ldr	x20, [x8, #0xb10]
1042ba3f0: aa1a03e0    	mov	x0, x26
1042ba3f4: f9404be1    	ldr	x1, [sp, #0x90]
1042ba3f8: 94e5b351    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba3fc: aa0003e2    	mov	x2, x0
1042ba400: aa1403e0    	mov	x0, x20
1042ba404: f9403be1    	ldr	x1, [sp, #0x70]
1042ba408: 94e5b34d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba40c: aa1d03fd    	mov	x29, x29
1042ba410: 94e5b34e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba414: aa0003f4    	mov	x20, x0
1042ba418: f9405fe0    	ldr	x0, [sp, #0xb8]
1042ba41c: f94023e1    	ldr	x1, [sp, #0x40]
1042ba420: aa1403e2    	mov	x2, x20
1042ba424: 94e5b346    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba428: aa1403e0    	mov	x0, x20
1042ba42c: 94e5b34a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba430: aa1903e0    	mov	x0, x25
1042ba434: f9402fe1    	ldr	x1, [sp, #0x58]
1042ba438: 14000026    	b	0x1042ba4d0 <_Flutter_MMFoundation_BindContext+0x7960b4>
1042ba43c: b940c7e8    	ldr	w8, [sp, #0xc4]
1042ba440: 34000448    	cbz	w8, 0x1042ba4c8 <_Flutter_MMFoundation_BindContext+0x7960ac>
1042ba444: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba448: f9453514    	ldr	x20, [x8, #0xa68]
1042ba44c: aa1a03e0    	mov	x0, x26
1042ba450: f94057e1    	ldr	x1, [sp, #0xa8]
1042ba454: 94e5b33a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba458: aa1d03fd    	mov	x29, x29
1042ba45c: 94e5b33b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba460: aa0003f5    	mov	x21, x0
1042ba464: aa1a03e0    	mov	x0, x26
1042ba468: f9404be1    	ldr	x1, [sp, #0x90]
1042ba46c: 94e5b334    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba470: aa0003f7    	mov	x23, x0
1042ba474: aa1a03e0    	mov	x0, x26
1042ba478: f94047e1    	ldr	x1, [sp, #0x88]
1042ba47c: 94e5b330    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba480: a90103f7    	stp	x23, x0, [sp, #0x10]
1042ba484: f94027f7    	ldr	x23, [sp, #0x48]
1042ba488: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba48c: 910aa108    	add	x8, x8, #0x2a8
1042ba490: a90057e8    	stp	x8, x21, [sp]
1042ba494: aa1403e0    	mov	x0, x20
1042ba498: f94053e1    	ldr	x1, [sp, #0xa0]
1042ba49c: 52800042    	mov	w2, #0x2                ; =2
1042ba4a0: aa1603e3    	mov	x3, x22
1042ba4a4: 52800004    	mov	w4, #0x0                ; =0
1042ba4a8: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba4ac: 910a3ca5    	add	x5, x5, #0x28f
1042ba4b0: 52801ae6    	mov	w6, #0xd7               ; =215
1042ba4b4: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba4b8: 911f74e7    	add	x7, x7, #0x7dd
1042ba4bc: 94e5b320    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba4c0: aa1503e0    	mov	x0, x21
1042ba4c4: 94e5b324    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba4c8: aa1a03e0    	mov	x0, x26
1042ba4cc: f94047e1    	ldr	x1, [sp, #0x88]
1042ba4d0: 94e5b31b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba4d4: 8b180018    	add	x24, x0, x24
1042ba4d8: aa1903e0    	mov	x0, x25
1042ba4dc: 94e5b31e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba4e0: f94033f9    	ldr	x25, [sp, #0x60]
1042ba4e4: 91000673    	add	x19, x19, #0x1
1042ba4e8: eb13037f    	cmp	x27, x19
1042ba4ec: 54ffdb81    	b.ne	0x1042ba05c <_Flutter_MMFoundation_BindContext+0x795c40>
1042ba4f0: 910443e2    	add	x2, sp, #0x110
1042ba4f4: d10383a3    	sub	x3, x29, #0xe0
1042ba4f8: aa1703e0    	mov	x0, x23
1042ba4fc: f9401fe1    	ldr	x1, [sp, #0x38]
1042ba500: 52800204    	mov	w4, #0x10               ; =16
1042ba504: 94e5b30e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba508: aa0003fb    	mov	x27, x0
1042ba50c: b5ffd640    	cbnz	x0, 0x1042b9fd4 <_Flutter_MMFoundation_BindContext+0x795bb8>
1042ba510: 14000002    	b	0x1042ba518 <_Flutter_MMFoundation_BindContext+0x7960fc>
1042ba514: d2800018    	mov	x24, #0x0               ; =0
1042ba518: aa1703e0    	mov	x0, x23
1042ba51c: 94e5b30e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba520: 4f00e400    	movi.16b	v0, #0x0
1042ba524: ad0783e0    	stp	q0, q0, [sp, #0xf0]
1042ba528: ad0683e0    	stp	q0, q0, [sp, #0xd0]
1042ba52c: d00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042ba530: f9474101    	ldr	x1, [x8, #0xe80] ; directories
1042ba534: f9401be0    	ldr	x0, [sp, #0x30]
1042ba538: 94e5b301    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba53c: aa1d03fd    	mov	x29, x29
1042ba540: 94e5b302    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba544: 910343e2    	add	x2, sp, #0xd0
1042ba548: 910543e3    	add	x3, sp, #0x150
1042ba54c: f90057e0    	str	x0, [sp, #0xa8]
1042ba550: f9401fe1    	ldr	x1, [sp, #0x38]
1042ba554: 52800204    	mov	w4, #0x10               ; =16
1042ba558: 94e5b2f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba55c: b4000840    	cbz	x0, 0x1042ba664 <_Flutter_MMFoundation_BindContext+0x796248>
1042ba560: aa0003fc    	mov	x28, x0
1042ba564: f94073e8    	ldr	x8, [sp, #0xe0]
1042ba568: f9400113    	ldr	x19, [x8]
1042ba56c: b940c7fa    	ldr	w26, [sp, #0xc4]
1042ba570: d2800016    	mov	x22, #0x0               ; =0
1042ba574: 900de008    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1042ba578: f946b517    	ldr	x23, [x8, #0xd68] ; fullPath
1042ba57c: f00ddbe8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042ba580: f942a914    	ldr	x20, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042ba584: d00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042ba588: f9472115    	ldr	x21, [x8, #0xe40] ; cleanupFilesInDirectory:forScenario:withFileReferences:enableVerboseLogging:
1042ba58c: f94073e8    	ldr	x8, [sp, #0xe0]
1042ba590: f9400108    	ldr	x8, [x8]
1042ba594: eb13011f    	cmp	x8, x19
1042ba598: 54000060    	b.eq	0x1042ba5a4 <_Flutter_MMFoundation_BindContext+0x796188>
1042ba59c: f94057e0    	ldr	x0, [sp, #0xa8]
1042ba5a0: 94e5b2ec    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1042ba5a4: f9406fe8    	ldr	x8, [sp, #0xd8]
1042ba5a8: f8767919    	ldr	x25, [x8, x22, lsl #3]
1042ba5ac: 3400037a    	cbz	w26, 0x1042ba618 <_Flutter_MMFoundation_BindContext+0x7961fc>
1042ba5b0: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba5b4: f945351a    	ldr	x26, [x8, #0xa68]
1042ba5b8: aa1903e0    	mov	x0, x25
1042ba5bc: aa1703e1    	mov	x1, x23
1042ba5c0: 94e5b2df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba5c4: aa1d03fd    	mov	x29, x29
1042ba5c8: 94e5b2e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba5cc: aa0003fb    	mov	x27, x0
1042ba5d0: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba5d4: 910b2108    	add	x8, x8, #0x2c8
1042ba5d8: a90003e8    	stp	x8, x0, [sp]
1042ba5dc: aa1a03e0    	mov	x0, x26
1042ba5e0: aa1403e1    	mov	x1, x20
1042ba5e4: 52800042    	mov	w2, #0x2                ; =2
1042ba5e8: 900ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042ba5ec: 913aa063    	add	x3, x3, #0xea8
1042ba5f0: 52800004    	mov	w4, #0x0                ; =0
1042ba5f4: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba5f8: 910a3ca5    	add	x5, x5, #0x28f
1042ba5fc: 52801b86    	mov	w6, #0xdc               ; =220
1042ba600: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba604: 911f74e7    	add	x7, x7, #0x7dd
1042ba608: 94e5b2cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba60c: aa1b03e0    	mov	x0, x27
1042ba610: b940c7fa    	ldr	w26, [sp, #0xc4]
1042ba614: 94e5b2d0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba618: a94b13e0    	ldp	x0, x4, [sp, #0xb0]
1042ba61c: aa1503e1    	mov	x1, x21
1042ba620: aa1903e2    	mov	x2, x25
1042ba624: f94067e3    	ldr	x3, [sp, #0xc8]
1042ba628: aa1a03e5    	mov	x5, x26
1042ba62c: 94e5b2c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba630: 8b180018    	add	x24, x0, x24
1042ba634: 910006d6    	add	x22, x22, #0x1
1042ba638: eb16039f    	cmp	x28, x22
1042ba63c: 54fffa81    	b.ne	0x1042ba58c <_Flutter_MMFoundation_BindContext+0x796170>
1042ba640: 910343e2    	add	x2, sp, #0xd0
1042ba644: 910543e3    	add	x3, sp, #0x150
1042ba648: f94057e0    	ldr	x0, [sp, #0xa8]
1042ba64c: f9401fe1    	ldr	x1, [sp, #0x38]
1042ba650: 52800204    	mov	w4, #0x10               ; =16
1042ba654: 94e5b2ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba658: aa0003fc    	mov	x28, x0
1042ba65c: b5fff8a0    	cbnz	x0, 0x1042ba570 <_Flutter_MMFoundation_BindContext+0x796154>
1042ba660: 14000002    	b	0x1042ba668 <_Flutter_MMFoundation_BindContext+0x79624c>
1042ba664: b940c7fa    	ldr	w26, [sp, #0xc4]
1042ba668: f94057e0    	ldr	x0, [sp, #0xa8]
1042ba66c: 94e5b2ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba670: f9401bf5    	ldr	x21, [sp, #0x30]
1042ba674: 340003da    	cbz	w26, 0x1042ba6ec <_Flutter_MMFoundation_BindContext+0x7962d0>
1042ba678: b00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042ba67c: f9453513    	ldr	x19, [x8, #0xa68]
1042ba680: 900de008    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1042ba684: f946b501    	ldr	x1, [x8, #0xd68] ; fullPath
1042ba688: aa1503e0    	mov	x0, x21
1042ba68c: 94e5b2ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba690: aa1d03fd    	mov	x29, x29
1042ba694: 94e5b2ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042ba698: aa0003f4    	mov	x20, x0
1042ba69c: f00ddbe8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042ba6a0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042ba6a4: f94067e8    	ldr	x8, [sp, #0xc8]
1042ba6a8: a90163e8    	stp	x8, x24, [sp, #0x10]
1042ba6ac: b00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042ba6b0: 910ba108    	add	x8, x8, #0x2e8
1042ba6b4: a90003e8    	stp	x8, x0, [sp]
1042ba6b8: 900ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042ba6bc: 913aa063    	add	x3, x3, #0xea8
1042ba6c0: b00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba6c4: 910a3ca5    	add	x5, x5, #0x28f
1042ba6c8: b00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042ba6cc: 911f74e7    	add	x7, x7, #0x7dd
1042ba6d0: aa1303e0    	mov	x0, x19
1042ba6d4: 52800042    	mov	w2, #0x2                ; =2
1042ba6d8: 52800004    	mov	w4, #0x0                ; =0
1042ba6dc: 52801c46    	mov	w6, #0xe2               ; =226
1042ba6e0: 94e5b297    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042ba6e4: aa1403e0    	mov	x0, x20
1042ba6e8: 94e5b29b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba6ec: f9405fe0    	ldr	x0, [sp, #0xb8]
1042ba6f0: 94e5b299    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba6f4: aa1503e0    	mov	x0, x21
1042ba6f8: 94e5b297    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042ba6fc: f85a03a8    	ldur	x8, [x29, #-0x60]
1042ba700: b00c99a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1042ba704: f9405929    	ldr	x9, [x9, #0xb0]
1042ba708: f9400129    	ldr	x9, [x9]
1042ba70c: eb08013f    	cmp	x9, x8
1042ba710: 54000141    	b.ne	0x1042ba738 <_Flutter_MMFoundation_BindContext+0x79631c>
1042ba714: aa1803e0    	mov	x0, x24
1042ba718: 910983ff    	add	sp, sp, #0x260
1042ba71c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1042ba720: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1042ba724: a94357f6    	ldp	x22, x21, [sp, #0x30]
1042ba728: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1042ba72c: a94167fa    	ldp	x26, x25, [sp, #0x10]
1042ba730: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1042ba734: d65f03c0    	ret
1042ba738: 94e5b28f    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
