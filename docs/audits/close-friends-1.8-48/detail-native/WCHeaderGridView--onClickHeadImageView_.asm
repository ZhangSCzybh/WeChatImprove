
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108f47f20: d10143ff    	sub	sp, sp, #0x50
108f47f24: a90257f6    	stp	x22, x21, [sp, #0x20]
108f47f28: a9034ff4    	stp	x20, x19, [sp, #0x30]
108f47f2c: a9047bfd    	stp	x29, x30, [sp, #0x40]
108f47f30: 910103fd    	add	x29, sp, #0x40
108f47f34: aa0003f3    	mov	x19, x0
108f47f38: d00be828    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108f47f3c: 52800029    	mov	w9, #0x1                ; =1
108f47f40: 392e7109    	strb	w9, [x8, #0xb9c]
108f47f44: 900b8e28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
108f47f48: f9424d01    	ldr	x1, [x8, #0x498] ; unsignedIntegerValue
108f47f4c: aa0203e0    	mov	x0, x2
108f47f50: 95a44d3d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47f54: aa0003f5    	mov	x21, x0
108f47f58: 900b98e8    	adrp	x8, 0x120263000 <dyld_stub_binder+0x120263000>
108f47f5c: b989d914    	ldrsw	x20, [x8, #0x9d8]
108f47f60: f8746a60    	ldr	x0, [x19, x20]
108f47f64: b00b8dc8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108f47f68: f9435101    	ldr	x1, [x8, #0x6a0] ; count
108f47f6c: 95a44d36    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47f70: eb0002bf    	cmp	x21, x0
108f47f74: 540006c2    	b.hs	0x108f4804c <_Flutter_MMFoundation_BindContext+0x5423c30>
108f47f78: f8746a60    	ldr	x0, [x19, x20]
108f47f7c: f00b7788    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
108f47f80: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
108f47f84: aa1503e2    	mov	x2, x21
108f47f88: 95a44d2f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47f8c: aa1d03fd    	mov	x29, x29
108f47f90: 95a44d30    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f47f94: aa0003f4    	mov	x20, x0
108f47f98: 900b9168    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108f47f9c: f9453500    	ldr	x0, [x8, #0xa68]
108f47fa0: d00b7788    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108f47fa4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
108f47fa8: a900d3f5    	stp	x21, x20, [sp, #0x8]
108f47fac: f00ad368    	adrp	x8, 0x11e9b6000 <dyld_stub_binder+0x11e9b6000>
108f47fb0: 910c2108    	add	x8, x8, #0x308
108f47fb4: f90003e8    	str	x8, [sp]
108f47fb8: b00916a3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
108f47fbc: 912b2863    	add	x3, x3, #0xaca
108f47fc0: f0096685    	adrp	x5, 0x11bc1a000 <dyld_stub_binder+0x11bc1a000>
108f47fc4: 912088a5    	add	x5, x5, #0x822
108f47fc8: f0096687    	adrp	x7, 0x11bc1a000 <dyld_stub_binder+0x11bc1a000>
108f47fcc: 9120d8e7    	add	x7, x7, #0x836
108f47fd0: 52800022    	mov	w2, #0x1                ; =1
108f47fd4: 52800004    	mov	w4, #0x0                ; =0
108f47fd8: 528015a6    	mov	w6, #0xad               ; =173
108f47fdc: 95a44d1a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47fe0: b00b85c8    	adrp	x8, 0x120000000 <dyld_stub_binder+0x120000000>
108f47fe4: f9405115    	ldr	x21, [x8, #0xa0] ; onHedaImageClick
108f47fe8: aa1303e0    	mov	x0, x19
108f47fec: aa1503e1    	mov	x1, x21
108f47ff0: 95a44d15    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f47ff4: aa1d03fd    	mov	x29, x29
108f47ff8: 95a44d16    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f47ffc: aa0003f6    	mov	x22, x0
108f48000: 95a44d17    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f48004: b4000196    	cbz	x22, 0x108f48034 <_Flutter_MMFoundation_BindContext+0x5423c18>
108f48008: aa1303e0    	mov	x0, x19
108f4800c: aa1503e1    	mov	x1, x21
108f48010: 95a44d0d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108f48014: aa1d03fd    	mov	x29, x29
108f48018: 95a44d0e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108f4801c: aa0003f3    	mov	x19, x0
108f48020: f9400808    	ldr	x8, [x0, #0x10]
108f48024: aa1403e1    	mov	x1, x20
108f48028: d63f0100    	blr	x8
108f4802c: aa1303e0    	mov	x0, x19
108f48030: 95a44d0b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f48034: aa1403e0    	mov	x0, x20
108f48038: a9447bfd    	ldp	x29, x30, [sp, #0x40]
108f4803c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
108f48040: a94257f6    	ldp	x22, x21, [sp, #0x20]
108f48044: 910143ff    	add	sp, sp, #0x50
108f48048: 15a44d05    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108f4804c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
108f48050: a9434ff4    	ldp	x20, x19, [sp, #0x30]
108f48054: a94257f6    	ldp	x22, x21, [sp, #0x20]
108f48058: 910143ff    	add	sp, sp, #0x50
108f4805c: d65f03c0    	ret
