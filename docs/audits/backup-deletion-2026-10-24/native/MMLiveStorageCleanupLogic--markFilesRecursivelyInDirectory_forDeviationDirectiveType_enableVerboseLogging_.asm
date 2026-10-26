
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1042b9b60: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1042b9b64: a90167fa    	stp	x26, x25, [sp, #0x10]
1042b9b68: a9025ff8    	stp	x24, x23, [sp, #0x20]
1042b9b6c: a90357f6    	stp	x22, x21, [sp, #0x30]
1042b9b70: a9044ff4    	stp	x20, x19, [sp, #0x40]
1042b9b74: a9057bfd    	stp	x29, x30, [sp, #0x50]
1042b9b78: 910143fd    	add	x29, sp, #0x50
1042b9b7c: d10743ff    	sub	sp, sp, #0x1d0
1042b9b80: aa0403f4    	mov	x20, x4
1042b9b84: aa0303f5    	mov	x21, x3
1042b9b88: aa0203f3    	mov	x19, x2
1042b9b8c: f9001fe0    	str	x0, [sp, #0x38]
1042b9b90: d00c99a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1042b9b94: f9405908    	ldr	x8, [x8, #0xb0]
1042b9b98: f9400108    	ldr	x8, [x8]
1042b9b9c: f81a03a8    	stur	x8, [x29, #-0x60]
1042b9ba0: f00e4c08    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
1042b9ba4: 52800029    	mov	w9, #0x1                ; =1
1042b9ba8: 39159d09    	strb	w9, [x8, #0x567]
1042b9bac: aa0203e0    	mov	x0, x2
1042b9bb0: 94e5b562    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1042b9bb4: 4f00e400    	movi.16b	v0, #0x0
1042b9bb8: ad0503e0    	stp	q0, q0, [sp, #0xa0]
1042b9bbc: ad0403e0    	stp	q0, q0, [sp, #0x80]
1042b9bc0: d00de0e8    	adrp	x8, 0x11fed7000 <dyld_stub_binder+0x11fed7000>
1042b9bc4: f941e101    	ldr	x1, [x8, #0x3c0] ; files
1042b9bc8: f9000ff3    	str	x19, [sp, #0x18]
1042b9bcc: aa1303e0    	mov	x0, x19
1042b9bd0: 94e5b55b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9bd4: aa1d03fd    	mov	x29, x29
1042b9bd8: 94e5b55c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9bdc: f00df228    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1042b9be0: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1042b9be4: 910203e2    	add	x2, sp, #0x80
1042b9be8: d10383a3    	sub	x3, x29, #0xe0
1042b9bec: f9001be0    	str	x0, [sp, #0x30]
1042b9bf0: f90013e1    	str	x1, [sp, #0x20]
1042b9bf4: 52800204    	mov	w4, #0x10               ; =16
1042b9bf8: 94e5b551    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9bfc: b40007e0    	cbz	x0, 0x1042b9cf8 <_Flutter_MMFoundation_BindContext+0x7958dc>
1042b9c00: aa0003f9    	mov	x25, x0
1042b9c04: f9404be8    	ldr	x8, [sp, #0x90]
1042b9c08: f9400118    	ldr	x24, [x8]
1042b9c0c: d2800013    	mov	x19, #0x0               ; =0
1042b9c10: b00de008    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1042b9c14: f946b508    	ldr	x8, [x8, #0xd68] ; fullPath
1042b9c18: f90017e8    	str	x8, [sp, #0x28]
1042b9c1c: 900ddc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042b9c20: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042b9c24: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9c28: f947391a    	ldr	x26, [x8, #0xe70] ; setMarkedForPreservation:
1042b9c2c: f9404be8    	ldr	x8, [sp, #0x90]
1042b9c30: f9400108    	ldr	x8, [x8]
1042b9c34: eb18011f    	cmp	x8, x24
1042b9c38: 54000060    	b.eq	0x1042b9c44 <_Flutter_MMFoundation_BindContext+0x795828>
1042b9c3c: f9401be0    	ldr	x0, [sp, #0x30]
1042b9c40: 94e5b544    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1042b9c44: f94047e8    	ldr	x8, [sp, #0x88]
1042b9c48: f873791b    	ldr	x27, [x8, x19, lsl #3]
1042b9c4c: 34000374    	cbz	w20, 0x1042b9cb8 <_Flutter_MMFoundation_BindContext+0x79589c>
1042b9c50: d00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b9c54: f945351c    	ldr	x28, [x8, #0xa68]
1042b9c58: aa1b03e0    	mov	x0, x27
1042b9c5c: f94017e1    	ldr	x1, [sp, #0x28]
1042b9c60: 94e5b537    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9c64: aa1d03fd    	mov	x29, x29
1042b9c68: 94e5b538    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9c6c: aa0003f6    	mov	x22, x0
1042b9c70: a900d7e0    	stp	x0, x21, [sp, #0x8]
1042b9c74: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b9c78: 9106a108    	add	x8, x8, #0x1a8
1042b9c7c: f90003e8    	str	x8, [sp]
1042b9c80: aa1c03e0    	mov	x0, x28
1042b9c84: aa1703e1    	mov	x1, x23
1042b9c88: 52800042    	mov	w2, #0x2                ; =2
1042b9c8c: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9c90: 913aa063    	add	x3, x3, #0xea8
1042b9c94: 52800004    	mov	w4, #0x0                ; =0
1042b9c98: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9c9c: 910a3ca5    	add	x5, x5, #0x28f
1042b9ca0: 52801406    	mov	w6, #0xa0               ; =160
1042b9ca4: d00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9ca8: 911c64e7    	add	x7, x7, #0x719
1042b9cac: 94e5b524    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9cb0: aa1603e0    	mov	x0, x22
1042b9cb4: 94e5b528    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9cb8: f10006bf    	cmp	x21, #0x1
1042b9cbc: 1a9f17e2    	cset	w2, eq
1042b9cc0: aa1b03e0    	mov	x0, x27
1042b9cc4: aa1a03e1    	mov	x1, x26
1042b9cc8: 94e5b51d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9ccc: 91000673    	add	x19, x19, #0x1
1042b9cd0: eb13033f    	cmp	x25, x19
1042b9cd4: 54fffac1    	b.ne	0x1042b9c2c <_Flutter_MMFoundation_BindContext+0x795810>
1042b9cd8: 910203e2    	add	x2, sp, #0x80
1042b9cdc: d10383a3    	sub	x3, x29, #0xe0
1042b9ce0: f9401be0    	ldr	x0, [sp, #0x30]
1042b9ce4: f94013e1    	ldr	x1, [sp, #0x20]
1042b9ce8: 52800204    	mov	w4, #0x10               ; =16
1042b9cec: 94e5b514    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9cf0: aa0003f9    	mov	x25, x0
1042b9cf4: b5fff8c0    	cbnz	x0, 0x1042b9c0c <_Flutter_MMFoundation_BindContext+0x7957f0>
1042b9cf8: f9401be0    	ldr	x0, [sp, #0x30]
1042b9cfc: 94e5b516    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9d00: 4f00e400    	movi.16b	v0, #0x0
1042b9d04: ad0303e0    	stp	q0, q0, [sp, #0x60]
1042b9d08: ad0203e0    	stp	q0, q0, [sp, #0x40]
1042b9d0c: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9d10: f9474101    	ldr	x1, [x8, #0xe80] ; directories
1042b9d14: f9400fe0    	ldr	x0, [sp, #0x18]
1042b9d18: 94e5b509    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9d1c: aa1d03fd    	mov	x29, x29
1042b9d20: 94e5b50a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9d24: 910103e2    	add	x2, sp, #0x40
1042b9d28: 910303e3    	add	x3, sp, #0xc0
1042b9d2c: f9001be0    	str	x0, [sp, #0x30]
1042b9d30: f94013e1    	ldr	x1, [sp, #0x20]
1042b9d34: 52800204    	mov	w4, #0x10               ; =16
1042b9d38: 94e5b501    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9d3c: b4000800    	cbz	x0, 0x1042b9e3c <_Flutter_MMFoundation_BindContext+0x795a20>
1042b9d40: aa0003fb    	mov	x27, x0
1042b9d44: f9402be8    	ldr	x8, [sp, #0x50]
1042b9d48: f9400118    	ldr	x24, [x8]
1042b9d4c: d2800013    	mov	x19, #0x0               ; =0
1042b9d50: b00de008    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1042b9d54: f946b508    	ldr	x8, [x8, #0xd68] ; fullPath
1042b9d58: f90017e8    	str	x8, [sp, #0x28]
1042b9d5c: 900ddc08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1042b9d60: f942a917    	ldr	x23, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1042b9d64: f00de548    	adrp	x8, 0x11ff64000 <dyld_stub_binder+0x11ff64000>
1042b9d68: f9473d19    	ldr	x25, [x8, #0xe78] ; markFilesRecursivelyInDirectory:forDeviationDirectiveType:enableVerboseLogging:
1042b9d6c: f9402be8    	ldr	x8, [sp, #0x50]
1042b9d70: f9400108    	ldr	x8, [x8]
1042b9d74: eb18011f    	cmp	x8, x24
1042b9d78: 54000060    	b.eq	0x1042b9d84 <_Flutter_MMFoundation_BindContext+0x795968>
1042b9d7c: f9401be0    	ldr	x0, [sp, #0x30]
1042b9d80: 94e5b4f4    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
1042b9d84: f94027e8    	ldr	x8, [sp, #0x48]
1042b9d88: f873791a    	ldr	x26, [x8, x19, lsl #3]
1042b9d8c: 34000374    	cbz	w20, 0x1042b9df8 <_Flutter_MMFoundation_BindContext+0x7959dc>
1042b9d90: d00df5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1042b9d94: f9453516    	ldr	x22, [x8, #0xa68]
1042b9d98: aa1a03e0    	mov	x0, x26
1042b9d9c: f94017e1    	ldr	x1, [sp, #0x28]
1042b9da0: 94e5b4e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9da4: aa1d03fd    	mov	x29, x29
1042b9da8: 94e5b4e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1042b9dac: aa0003fc    	mov	x28, x0
1042b9db0: a900d7e0    	stp	x0, x21, [sp, #0x8]
1042b9db4: d00d2428    	adrp	x8, 0x11e73f000 <dyld_stub_binder+0x11e73f000>
1042b9db8: 91072108    	add	x8, x8, #0x1c8
1042b9dbc: f90003e8    	str	x8, [sp]
1042b9dc0: aa1603e0    	mov	x0, x22
1042b9dc4: aa1703e1    	mov	x1, x23
1042b9dc8: 52800042    	mov	w2, #0x2                ; =2
1042b9dcc: b00ba443    	adrp	x3, 0x11b742000 <dyld_stub_binder+0x11b742000>
1042b9dd0: 913aa063    	add	x3, x3, #0xea8
1042b9dd4: 52800004    	mov	w4, #0x0                ; =0
1042b9dd8: d00ba445    	adrp	x5, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9ddc: 910a3ca5    	add	x5, x5, #0x28f
1042b9de0: 52801486    	mov	w6, #0xa4               ; =164
1042b9de4: d00ba447    	adrp	x7, 0x11b743000 <dyld_stub_binder+0x11b743000>
1042b9de8: 911c64e7    	add	x7, x7, #0x719
1042b9dec: 94e5b4d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9df0: aa1c03e0    	mov	x0, x28
1042b9df4: 94e5b4d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9df8: f9401fe0    	ldr	x0, [sp, #0x38]
1042b9dfc: aa1903e1    	mov	x1, x25
1042b9e00: aa1a03e2    	mov	x2, x26
1042b9e04: aa1503e3    	mov	x3, x21
1042b9e08: aa1403e4    	mov	x4, x20
1042b9e0c: 94e5b4cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9e10: 91000673    	add	x19, x19, #0x1
1042b9e14: eb13037f    	cmp	x27, x19
1042b9e18: 54fffaa1    	b.ne	0x1042b9d6c <_Flutter_MMFoundation_BindContext+0x795950>
1042b9e1c: 910103e2    	add	x2, sp, #0x40
1042b9e20: 910303e3    	add	x3, sp, #0xc0
1042b9e24: f9401be0    	ldr	x0, [sp, #0x30]
1042b9e28: f94013e1    	ldr	x1, [sp, #0x20]
1042b9e2c: 52800204    	mov	w4, #0x10               ; =16
1042b9e30: 94e5b4c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1042b9e34: aa0003fb    	mov	x27, x0
1042b9e38: b5fff8a0    	cbnz	x0, 0x1042b9d4c <_Flutter_MMFoundation_BindContext+0x795930>
1042b9e3c: f9401be0    	ldr	x0, [sp, #0x30]
1042b9e40: 94e5b4c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9e44: f9400fe0    	ldr	x0, [sp, #0x18]
1042b9e48: 94e5b4c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1042b9e4c: f85a03a8    	ldur	x8, [x29, #-0x60]
1042b9e50: d00c99a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1042b9e54: f9405929    	ldr	x9, [x9, #0xb0]
1042b9e58: f9400129    	ldr	x9, [x9]
1042b9e5c: eb08013f    	cmp	x9, x8
1042b9e60: 54000121    	b.ne	0x1042b9e84 <_Flutter_MMFoundation_BindContext+0x795a68>
1042b9e64: 910743ff    	add	sp, sp, #0x1d0
1042b9e68: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1042b9e6c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1042b9e70: a94357f6    	ldp	x22, x21, [sp, #0x30]
1042b9e74: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1042b9e78: a94167fa    	ldp	x26, x25, [sp, #0x10]
1042b9e7c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1042b9e80: d65f03c0    	ret
1042b9e84: 94e5b4bc    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
