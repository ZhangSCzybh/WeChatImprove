
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0be854: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
10a0be858: a90167fa    	stp	x26, x25, [sp, #0x10]
10a0be85c: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a0be860: a90357f6    	stp	x22, x21, [sp, #0x30]
10a0be864: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a0be868: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a0be86c: 910143fd    	add	x29, sp, #0x50
10a0be870: aa0203f3    	mov	x19, x2
10a0be874: aa0003f4    	mov	x20, x0
10a0be878: f00b5c88    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0be87c: 52800029    	mov	w9, #0x1                ; =1
10a0be880: 39122509    	strb	w9, [x8, #0x489]
10a0be884: b00b05a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0be888: f945e900    	ldr	x0, [x8, #0xbd0]
10a0be88c: d00b0208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0be890: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10a0be894: 955e72ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be898: aa1d03fd    	mov	x29, x29
10a0be89c: 955e72ed    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0be8a0: aa0003f5    	mov	x21, x0
10a0be8a4: d00b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0be8a8: f9428500    	ldr	x0, [x8, #0x508]
10a0be8ac: b00b0208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0be8b0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10a0be8b4: 955e72e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be8b8: aa0003e2    	mov	x2, x0
10a0be8bc: f00aebc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0be8c0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a0be8c4: aa1503e0    	mov	x0, x21
10a0be8c8: 955e72df    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be8cc: aa1d03fd    	mov	x29, x29
10a0be8d0: 955e72e0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0be8d4: aa0003f6    	mov	x22, x0
10a0be8d8: 900afa48    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10a0be8dc: f940d501    	ldr	x1, [x8, #0x1a8] ; isTimeLineJumpState
10a0be8e0: 955e72d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be8e4: aa0003f7    	mov	x23, x0
10a0be8e8: aa1603e0    	mov	x0, x22
10a0be8ec: 955e72dc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0be8f0: aa1503e0    	mov	x0, x21
10a0be8f4: 955e72da    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0be8f8: 37000857    	tbnz	w23, #0x0, 0x10a0bea00 <_Flutter_MMFoundation_BindContext+0x659a5e4>
10a0be8fc: f00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0be900: f9428101    	ldr	x1, [x8, #0x500] ; shouldShowFinderLiveHeaderCell
10a0be904: aa1403e0    	mov	x0, x20
10a0be908: 955e72cf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be90c: aa0003f5    	mov	x21, x0
10a0be910: f00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0be914: f9428501    	ldr	x1, [x8, #0x508] ; shouldShowStoryCell
10a0be918: aa1403e0    	mov	x0, x20
10a0be91c: 955e72ca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be920: aa0003f6    	mov	x22, x0
10a0be924: f00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0be928: f9428901    	ldr	x1, [x8, #0x510] ; hasUnReadMessage
10a0be92c: aa1403e0    	mov	x0, x20
10a0be930: 955e72c5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be934: aa0003f8    	mov	x24, x0
10a0be938: f00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0be93c: f9428d01    	ldr	x1, [x8, #0x518] ; getUploadFailItemsFroView
10a0be940: aa1403e0    	mov	x0, x20
10a0be944: 955e72c0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be948: aa1d03fd    	mov	x29, x29
10a0be94c: 955e72c1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0be950: aa0003f7    	mov	x23, x0
10a0be954: d00b0208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0be958: f9435119    	ldr	x25, [x8, #0x6a0] ; count
10a0be95c: aa1903e1    	mov	x1, x25
10a0be960: 955e72b9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be964: aa0003fa    	mov	x26, x0
10a0be968: d00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0be96c: b9826508    	ldrsw	x8, [x8, #0x264]
10a0be970: f8686a80    	ldr	x0, [x20, x8]
10a0be974: aa1903e1    	mov	x1, x25
10a0be978: 955e72b3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be97c: aa0003fb    	mov	x27, x0
10a0be980: d00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0be984: b9826908    	ldrsw	x8, [x8, #0x268]
10a0be988: f8686a80    	ldr	x0, [x20, x8]
10a0be98c: aa1903e1    	mov	x1, x25
10a0be990: 955e72ad    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be994: aa0003fc    	mov	x28, x0
10a0be998: d00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0be99c: b9826d08    	ldrsw	x8, [x8, #0x26c]
10a0be9a0: f8686a80    	ldr	x0, [x20, x8]
10a0be9a4: aa1903e1    	mov	x1, x25
10a0be9a8: 955e72a7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0be9ac: d00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0be9b0: b9827108    	ldrsw	x8, [x8, #0x270]
10a0be9b4: f8686a88    	ldr	x8, [x20, x8]
10a0be9b8: f100011f    	cmp	x8, #0x0
10a0be9bc: d00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0be9c0: b9827508    	ldrsw	x8, [x8, #0x274]
10a0be9c4: f8686a88    	ldr	x8, [x20, x8]
10a0be9c8: 1a9f07e9    	cset	w9, ne
10a0be9cc: f100011f    	cmp	x8, #0x0
10a0be9d0: 1a9f07e8    	cset	w8, ne
10a0be9d4: cb35426a    	sub	x10, x19, w21, uxtw
10a0be9d8: cb36414a    	sub	x10, x10, w22, uxtw
10a0be9dc: cb38414a    	sub	x10, x10, w24, uxtw
10a0be9e0: 8b1b034b    	add	x11, x26, x27
10a0be9e4: 8b00038c    	add	x12, x28, x0
10a0be9e8: 8b0c016b    	add	x11, x11, x12
10a0be9ec: cb0b014a    	sub	x10, x10, x11
10a0be9f0: cb090149    	sub	x9, x10, x9
10a0be9f4: cb080133    	sub	x19, x9, x8
10a0be9f8: aa1703e0    	mov	x0, x23
10a0be9fc: 955e7298    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bea00: aa1303e0    	mov	x0, x19
10a0bea04: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a0bea08: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a0bea0c: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a0bea10: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a0bea14: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a0bea18: a8c66ffc    	ldp	x28, x27, [sp], #0x60
10a0bea1c: d65f03c0    	ret
