
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105778e24: d10783ff    	sub	sp, sp, #0x1e0
105778e28: a9186ffc    	stp	x28, x27, [sp, #0x180]
105778e2c: a91967fa    	stp	x26, x25, [sp, #0x190]
105778e30: a91a5ff8    	stp	x24, x23, [sp, #0x1a0]
105778e34: a91b57f6    	stp	x22, x21, [sp, #0x1b0]
105778e38: a91c4ff4    	stp	x20, x19, [sp, #0x1c0]
105778e3c: a91d7bfd    	stp	x29, x30, [sp, #0x1d0]
105778e40: 910743fd    	add	x29, sp, #0x1d0
105778e44: aa0003f7    	mov	x23, x0
105778e48: f00bf3a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
105778e4c: f9405908    	ldr	x8, [x8, #0xb0]
105778e50: f9400108    	ldr	x8, [x8]
105778e54: f81a03a8    	stur	x8, [x29, #-0x60]
105778e58: b00da648    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
105778e5c: 52800029    	mov	w9, #0x1                ; =1
105778e60: 390c3d09    	strb	w9, [x8, #0x30f]
105778e64: f00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105778e68: f9471100    	ldr	x0, [x8, #0xe20]
105778e6c: b00d3628    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105778e70: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
105778e74: 9492b8b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778e78: aa1d03fd    	mov	x29, x29
105778e7c: 9492b8b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105778e80: f9004fe0    	str	x0, [sp, #0x98]
105778e84: f00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105778e88: f945e900    	ldr	x0, [x8, #0xbd0]
105778e8c: 900d4c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105778e90: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105778e94: 9492b8aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778e98: aa1d03fd    	mov	x29, x29
105778e9c: 9492b8ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105778ea0: aa0003f3    	mov	x19, x0
105778ea4: d00d50c8    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
105778ea8: f945dd00    	ldr	x0, [x8, #0xbb8]
105778eac: f00d4c28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105778eb0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105778eb4: 9492b8a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778eb8: aa0003e2    	mov	x2, x0
105778ebc: b00d3608    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105778ec0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105778ec4: aa1303e0    	mov	x0, x19
105778ec8: 9492b89d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778ecc: aa1d03fd    	mov	x29, x29
105778ed0: 9492b89e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105778ed4: aa0003f5    	mov	x21, x0
105778ed8: 900d41c8    	adrp	x8, 0x11ffb0000 <dyld_stub_binder+0x11ffb0000>
105778edc: f941f901    	ldr	x1, [x8, #0x3f0] ; getSendMessages
105778ee0: 9492b897    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778ee4: aa1d03fd    	mov	x29, x29
105778ee8: 9492b898    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105778eec: aa0003f6    	mov	x22, x0
105778ef0: aa1503e0    	mov	x0, x21
105778ef4: 9492b898    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105778ef8: aa1303e0    	mov	x0, x19
105778efc: 9492b896    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105778f00: 4f00e400    	movi.16b	v0, #0x0
105778f04: ad0683e0    	stp	q0, q0, [sp, #0xd0]
105778f08: ad0583e0    	stp	q0, q0, [sp, #0xb0]
105778f0c: aa1603e0    	mov	x0, x22
105778f10: 9492b88a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105778f14: 900d4c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105778f18: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
105778f1c: 9102c3e2    	add	x2, sp, #0xb0
105778f20: d10383a3    	sub	x3, x29, #0xe0
105778f24: f90027f6    	str	x22, [sp, #0x48]
105778f28: f90013e1    	str	x1, [sp, #0x20]
105778f2c: 52800204    	mov	w4, #0x10               ; =16
105778f30: 9492b883    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105778f34: f90047e0    	str	x0, [sp, #0x88]
105778f38: b4001e60    	cbz	x0, 0x105779304 <_Flutter_MMFoundation_BindContext+0x1c54ee8>
105778f3c: 52800016    	mov	w22, #0x0               ; =0
105778f40: f00d3629    	adrp	x9, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105778f44: f94063e8    	ldr	x8, [sp, #0xc0]
105778f48: 900d362a    	adrp	x10, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105778f4c: b00d360b    	adrp	x11, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105778f50: f9400108    	ldr	x8, [x8]
105778f54: f90043e8    	str	x8, [sp, #0x80]
105778f58: 900d3628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105778f5c: d00d362c    	adrp	x12, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105778f60: f00d4c4d    	adrp	x13, 0x120103000 <dyld_stub_binder+0x120103000>
105778f64: f00d362e    	adrp	x14, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105778f68: 900d364f    	adrp	x15, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
105778f6c: 900d4c70    	adrp	x16, 0x120104000 <dyld_stub_binder+0x120104000>
105778f70: 900d3631    	adrp	x17, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105778f74: d00d4061    	adrp	x1, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
105778f78: d00d4c82    	adrp	x2, 0x12010a000 <dyld_stub_binder+0x12010a000>
105778f7c: 900d4c63    	adrp	x3, 0x120104000 <dyld_stub_binder+0x120104000>
105778f80: b00d3604    	adrp	x4, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105778f84: d00d3605    	adrp	x5, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105778f88: d280001c    	mov	x28, #0x0               ; =0
105778f8c: f940d929    	ldr	x9, [x9, #0x1b0] ; m_nsToUsr
105778f90: f90057e9    	str	x9, [sp, #0xa8]
105778f94: f947d149    	ldr	x9, [x10, #0xfa0] ; m_uiMesLocalID
105778f98: f90053e9    	str	x9, [sp, #0xa0]
105778f9c: f942a978    	ldr	x24, [x11, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105778fa0: f9453108    	ldr	x8, [x8, #0xa60] ; setM_nsFromUsr:
105778fa4: f9004be8    	str	x8, [sp, #0x90]
105778fa8: f9417189    	ldr	x9, [x12, #0x2e0] ; m_nsContent
105778fac: f946e9b9    	ldr	x25, [x13, #0xdd0] ; length
105778fb0: f94655c8    	ldr	x8, [x14, #0xca8] ; ChangeForDisplay
105778fb4: a90727e8    	stp	x8, x9, [sp, #0x70]
105778fb8: f94325e9    	ldr	x9, [x15, #0x648] ; m_firstSendMsgId
105778fbc: f940aa0a    	ldr	x10, [x16, #0x150] ; longLongValue
105778fc0: f947da2b    	ldr	x11, [x17, #0xfb0] ; m_uiCreateTime
105778fc4: f9441828    	ldr	x8, [x1, #0x830] ; getCrc32ClientIDOfMsg:LocalID:Time:
105778fc8: a903afe8    	stp	x8, x11, [sp, #0x38]
105778fcc: f946a448    	ldr	x8, [x2, #0xd48] ; stringWithFormat:
105778fd0: a90627e8    	stp	x8, x9, [sp, #0x60]
105778fd4: f947f068    	ldr	x8, [x3, #0xfe0] ; objectForKey:
105778fd8: a90523ea    	stp	x10, x8, [sp, #0x50]
105778fdc: f942c889    	ldr	x9, [x4, #0x590] ; safeSetObject:forKey:
105778fe0: f943c4a8    	ldr	x8, [x5, #0x788] ; safeAddObject:
105778fe4: a902a7e8    	stp	x8, x9, [sp, #0x28]
105778fe8: f94063e8    	ldr	x8, [sp, #0xc0]
105778fec: f9400108    	ldr	x8, [x8]
105778ff0: f94043e9    	ldr	x9, [sp, #0x80]
105778ff4: eb09011f    	cmp	x8, x9
105778ff8: 54000060    	b.eq	0x105779004 <_Flutter_MMFoundation_BindContext+0x1c54be8>
105778ffc: f94027e0    	ldr	x0, [sp, #0x48]
105779000: 9492b854    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
105779004: f9405fe8    	ldr	x8, [sp, #0xb8]
105779008: f87c791a    	ldr	x26, [x8, x28, lsl #3]
10577900c: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105779010: f9453513    	ldr	x19, [x8, #0xa68]
105779014: aa1a03e0    	mov	x0, x26
105779018: f94057e1    	ldr	x1, [sp, #0xa8]
10577901c: 9492b848    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779020: aa1d03fd    	mov	x29, x29
105779024: 9492b849    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105779028: aa0003f5    	mov	x21, x0
10577902c: aa1a03e0    	mov	x0, x26
105779030: f94053e1    	ldr	x1, [sp, #0xa0]
105779034: 9492b842    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779038: a90083f5    	stp	x21, x0, [sp, #0x8]
10577903c: f00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
105779040: 91322108    	add	x8, x8, #0xc88
105779044: f90003e8    	str	x8, [sp]
105779048: aa1303e0    	mov	x0, x19
10577904c: aa1803e1    	mov	x1, x24
105779050: 52800022    	mov	w2, #0x1                ; =1
105779054: 900ad563    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
105779058: 9107f063    	add	x3, x3, #0x1fc
10577905c: 52800004    	mov	w4, #0x0                ; =0
105779060: f00b0b25    	adrp	x5, 0x11b8e0000 <dyld_stub_binder+0x11b8e0000>
105779064: 913f2ca5    	add	x5, x5, #0xfcb
105779068: 52802286    	mov	w6, #0x114              ; =276
10577906c: 900b0b47    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
105779070: 910a2ce7    	add	x7, x7, #0x28b
105779074: 9492b832    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779078: aa1503e0    	mov	x0, x21
10577907c: 9492b836    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779080: aa1a03e0    	mov	x0, x26
105779084: a9490be1    	ldp	x1, x2, [sp, #0x90]
105779088: 9492b82d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577908c: 71400adf    	cmp	w22, #0x2, lsl #12      ; =0x2000
105779090: 540013e8    	b.hi	0x10577930c <_Flutter_MMFoundation_BindContext+0x1c54ef0>
105779094: aa1a03e0    	mov	x0, x26
105779098: f9403fe1    	ldr	x1, [sp, #0x78]
10577909c: 9492b828    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057790a0: aa1d03fd    	mov	x29, x29
1057790a4: 9492b829    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057790a8: aa0003f3    	mov	x19, x0
1057790ac: aa1903e1    	mov	x1, x25
1057790b0: 9492b823    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057790b4: aa0003f5    	mov	x21, x0
1057790b8: aa1303e0    	mov	x0, x19
1057790bc: 9492b826    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057790c0: aa1a03e0    	mov	x0, x26
1057790c4: f9403be1    	ldr	x1, [sp, #0x70]
1057790c8: 9492b81d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057790cc: aa1a03e0    	mov	x0, x26
1057790d0: f94037f4    	ldr	x20, [sp, #0x68]
1057790d4: aa1403e1    	mov	x1, x20
1057790d8: 9492b819    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057790dc: aa1d03fd    	mov	x29, x29
1057790e0: 9492b81a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057790e4: aa0003f3    	mov	x19, x0
1057790e8: aa1903e1    	mov	x1, x25
1057790ec: 9492b814    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057790f0: aa0003fb    	mov	x27, x0
1057790f4: aa1303e0    	mov	x0, x19
1057790f8: 9492b817    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057790fc: b400035b    	cbz	x27, 0x105779164 <_Flutter_MMFoundation_BindContext+0x1c54d48>
105779100: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105779104: f9453500    	ldr	x0, [x8, #0xa68]
105779108: f00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577910c: 9132a108    	add	x8, x8, #0xca8
105779110: f90003e8    	str	x8, [sp]
105779114: aa1803e1    	mov	x1, x24
105779118: 52800042    	mov	w2, #0x2                ; =2
10577911c: d2800003    	mov	x3, #0x0                ; =0
105779120: 52800004    	mov	w4, #0x0                ; =0
105779124: f00b0b25    	adrp	x5, 0x11b8e0000 <dyld_stub_binder+0x11b8e0000>
105779128: 913f2ca5    	add	x5, x5, #0xfcb
10577912c: 52802426    	mov	w6, #0x121              ; =289
105779130: 900b0b47    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
105779134: 910a2ce7    	add	x7, x7, #0x28b
105779138: 9492b801    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577913c: aa1a03e0    	mov	x0, x26
105779140: aa1403e1    	mov	x1, x20
105779144: 9492b7fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779148: aa1d03fd    	mov	x29, x29
10577914c: 9492b7ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105779150: aa0003fb    	mov	x27, x0
105779154: f9402be1    	ldr	x1, [sp, #0x50]
105779158: 9492b7f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10577915c: aa0003f3    	mov	x19, x0
105779160: 14000017    	b	0x1057791bc <_Flutter_MMFoundation_BindContext+0x1c54da0>
105779164: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105779168: f9467913    	ldr	x19, [x8, #0xcf0]
10577916c: aa1a03e0    	mov	x0, x26
105779170: f94057e1    	ldr	x1, [sp, #0xa8]
105779174: 9492b7f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779178: aa1d03fd    	mov	x29, x29
10577917c: 9492b7f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105779180: aa0003fb    	mov	x27, x0
105779184: aa1a03e0    	mov	x0, x26
105779188: f94053e1    	ldr	x1, [sp, #0xa0]
10577918c: 9492b7ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779190: aa0003f4    	mov	x20, x0
105779194: aa1a03e0    	mov	x0, x26
105779198: f94023e1    	ldr	x1, [sp, #0x40]
10577919c: 9492b7e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057791a0: aa0003e4    	mov	x4, x0
1057791a4: aa1303e0    	mov	x0, x19
1057791a8: f9401fe1    	ldr	x1, [sp, #0x38]
1057791ac: aa1b03e2    	mov	x2, x27
1057791b0: aa1403e3    	mov	x3, x20
1057791b4: 9492b7e2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057791b8: aa0003f3    	mov	x19, x0
1057791bc: aa1b03e0    	mov	x0, x27
1057791c0: 9492b7e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1057791c4: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1057791c8: f9454500    	ldr	x0, [x8, #0xa88]
1057791cc: f90003f3    	str	x19, [sp]
1057791d0: f94033e1    	ldr	x1, [sp, #0x60]
1057791d4: 900c6942    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
1057791d8: 912a2042    	add	x2, x2, #0xa88
1057791dc: 9492b7d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057791e0: aa1d03fd    	mov	x29, x29
1057791e4: 9492b7d9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1057791e8: aa0003fb    	mov	x27, x0
1057791ec: b00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
1057791f0: b98cb514    	ldrsw	x20, [x8, #0xcb4]
1057791f4: f8746ae0    	ldr	x0, [x23, x20]
1057791f8: f9402fe1    	ldr	x1, [sp, #0x58]
1057791fc: aa1b03e2    	mov	x2, x27
105779200: 9492b7cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779204: aa1d03fd    	mov	x29, x29
105779208: 9492b7d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10577920c: aa0003f3    	mov	x19, x0
105779210: 9492b7d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779214: b4000253    	cbz	x19, 0x10577925c <_Flutter_MMFoundation_BindContext+0x1c54e40>
105779218: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577921c: f9453500    	ldr	x0, [x8, #0xa68]
105779220: f00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
105779224: 91332108    	add	x8, x8, #0xcc8
105779228: f90003e8    	str	x8, [sp]
10577922c: aa1803e1    	mov	x1, x24
105779230: 52800042    	mov	w2, #0x2                ; =2
105779234: 900ad563    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
105779238: 9107f063    	add	x3, x3, #0x1fc
10577923c: 52800004    	mov	w4, #0x0                ; =0
105779240: f00b0b25    	adrp	x5, 0x11b8e0000 <dyld_stub_binder+0x11b8e0000>
105779244: 913f2ca5    	add	x5, x5, #0xfcb
105779248: 52802506    	mov	w6, #0x128              ; =296
10577924c: 900b0b47    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
105779250: 910a2ce7    	add	x7, x7, #0x28b
105779254: 9492b7ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779258: 1400000c    	b	0x105779288 <_Flutter_MMFoundation_BindContext+0x1c54e6c>
10577925c: f8746ae0    	ldr	x0, [x23, x20]
105779260: f9401be1    	ldr	x1, [sp, #0x30]
105779264: aa1a03e2    	mov	x2, x26
105779268: aa1b03e3    	mov	x3, x27
10577926c: 9492b7b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779270: b00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105779274: b98cb908    	ldrsw	x8, [x8, #0xcb8]
105779278: f8686ae0    	ldr	x0, [x23, x8]
10577927c: f94017e1    	ldr	x1, [sp, #0x28]
105779280: aa1a03e2    	mov	x2, x26
105779284: 9492b7ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779288: 0b1502d6    	add	w22, w22, w21
10577928c: aa1b03e0    	mov	x0, x27
105779290: 9492b7b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779294: 9100079c    	add	x28, x28, #0x1
105779298: f94047e8    	ldr	x8, [sp, #0x88]
10577929c: eb1c011f    	cmp	x8, x28
1057792a0: 54ffea41    	b.ne	0x105778fe8 <_Flutter_MMFoundation_BindContext+0x1c54bcc>
1057792a4: 9102c3e2    	add	x2, sp, #0xb0
1057792a8: d10383a3    	sub	x3, x29, #0xe0
1057792ac: f94027e0    	ldr	x0, [sp, #0x48]
1057792b0: f94013e1    	ldr	x1, [sp, #0x20]
1057792b4: 52800204    	mov	w4, #0x10               ; =16
1057792b8: 9492b7a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057792bc: f90047e0    	str	x0, [sp, #0x88]
1057792c0: d00d3629    	adrp	x9, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1057792c4: f00d360a    	adrp	x10, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057792c8: 900d360b    	adrp	x11, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057792cc: f00d3608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057792d0: b00d362c    	adrp	x12, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1057792d4: d00d4c4d    	adrp	x13, 0x120103000 <dyld_stub_binder+0x120103000>
1057792d8: d00d362e    	adrp	x14, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1057792dc: f00d362f    	adrp	x15, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1057792e0: f00d4c50    	adrp	x16, 0x120104000 <dyld_stub_binder+0x120104000>
1057792e4: f00d3611    	adrp	x17, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1057792e8: b00d4061    	adrp	x1, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
1057792ec: b00d4c82    	adrp	x2, 0x12010a000 <dyld_stub_binder+0x12010a000>
1057792f0: f00d4c43    	adrp	x3, 0x120104000 <dyld_stub_binder+0x120104000>
1057792f4: 900d3604    	adrp	x4, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1057792f8: b00d3605    	adrp	x5, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1057792fc: b5ffe460    	cbnz	x0, 0x105778f88 <_Flutter_MMFoundation_BindContext+0x1c54b6c>
105779300: 14000003    	b	0x10577930c <_Flutter_MMFoundation_BindContext+0x1c54ef0>
105779304: 900d3608    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105779308: f942a918    	ldr	x24, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10577930c: f94027f5    	ldr	x21, [sp, #0x48]
105779310: aa1503e0    	mov	x0, x21
105779314: 9492b790    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779318: d00d4fc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10577931c: f9453513    	ldr	x19, [x8, #0xa68]
105779320: b00d55a8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105779324: b98cb908    	ldrsw	x8, [x8, #0xcb8]
105779328: f8686ae0    	ldr	x0, [x23, x8]
10577932c: f00d4c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105779330: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105779334: 9492b782    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779338: f00c84a8    	adrp	x8, 0x11e810000 <dyld_stub_binder+0x11e810000>
10577933c: 9133a108    	add	x8, x8, #0xce8
105779340: a90003e8    	stp	x8, x0, [sp]
105779344: 900ad563    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
105779348: 9107f063    	add	x3, x3, #0x1fc
10577934c: f00b0b25    	adrp	x5, 0x11b8e0000 <dyld_stub_binder+0x11b8e0000>
105779350: 913f2ca5    	add	x5, x5, #0xfcb
105779354: 900b0b47    	adrp	x7, 0x11b8e1000 <dyld_stub_binder+0x11b8e1000>
105779358: 910a2ce7    	add	x7, x7, #0x28b
10577935c: aa1303e0    	mov	x0, x19
105779360: aa1803e1    	mov	x1, x24
105779364: 52800042    	mov	w2, #0x2                ; =2
105779368: 52800004    	mov	w4, #0x0                ; =0
10577936c: 528025c6    	mov	w6, #0x12e              ; =302
105779370: 9492b773    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105779374: aa1503e0    	mov	x0, x21
105779378: 9492b777    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10577937c: f9404fe0    	ldr	x0, [sp, #0x98]
105779380: 9492b775    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105779384: f85a03a8    	ldur	x8, [x29, #-0x60]
105779388: d00bf3a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10577938c: f9405929    	ldr	x9, [x9, #0xb0]
105779390: f9400129    	ldr	x9, [x9]
105779394: eb08013f    	cmp	x9, x8
105779398: 54000121    	b.ne	0x1057793bc <_Flutter_MMFoundation_BindContext+0x1c54fa0>
10577939c: a95d7bfd    	ldp	x29, x30, [sp, #0x1d0]
1057793a0: a95c4ff4    	ldp	x20, x19, [sp, #0x1c0]
1057793a4: a95b57f6    	ldp	x22, x21, [sp, #0x1b0]
1057793a8: a95a5ff8    	ldp	x24, x23, [sp, #0x1a0]
1057793ac: a95967fa    	ldp	x26, x25, [sp, #0x190]
1057793b0: a9586ffc    	ldp	x28, x27, [sp, #0x180]
1057793b4: 910783ff    	add	sp, sp, #0x1e0
1057793b8: d65f03c0    	ret
1057793bc: 9492b76e    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
