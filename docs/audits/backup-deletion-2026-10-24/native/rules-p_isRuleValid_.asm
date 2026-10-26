
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10299ff1c: d100c3ff    	sub	sp, sp, #0x30
10299ff20: a9014ff4    	stp	x20, x19, [sp, #0x10]
10299ff24: a9027bfd    	stp	x29, x30, [sp, #0x20]
10299ff28: 910083fd    	add	x29, sp, #0x20
10299ff2c: aa0203f3    	mov	x19, x2
10299ff30: f00f14a8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
10299ff34: 52800029    	mov	w9, #0x1                ; =1
10299ff38: 3933bd09    	strb	w9, [x8, #0xcef]
10299ff3c: f9400048    	ldr	x8, [x2]
10299ff40: f100091f    	cmp	x8, #0x2
10299ff44: 5400038c    	b.gt	0x10299ffb4 <_Flutter_Image_provideRelativePathByUrl+0xdace64>
10299ff48: 900ebea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10299ff4c: f9453514    	ldr	x20, [x8, #0xa68]
10299ff50: b00ebee8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
10299ff54: f943c500    	ldr	x0, [x8, #0x788]
10299ff58: b00eaac8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
10299ff5c: f941bd01    	ldr	x1, [x8, #0x378] ; ruleDescription:
10299ff60: aa1303e2    	mov	x2, x19
10299ff64: 954a1c76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299ff68: aa1d03fd    	mov	x29, x29
10299ff6c: 954a1c77    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10299ff70: aa0003f3    	mov	x19, x0
10299ff74: d00ea4c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10299ff78: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10299ff7c: d00de668    	adrp	x8, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299ff80: 912f2108    	add	x8, x8, #0xbc8
10299ff84: a90003e8    	stp	x8, x0, [sp]
10299ff88: b00c5ee3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
10299ff8c: 9125d063    	add	x3, x3, #0x974
10299ff90: b00c5ee5    	adrp	x5, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
10299ff94: 91200ca5    	add	x5, x5, #0x803
10299ff98: b00c5ee7    	adrp	x7, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
10299ff9c: 912e78e7    	add	x7, x7, #0xb9e
10299ffa0: aa1403e0    	mov	x0, x20
10299ffa4: 52800082    	mov	w2, #0x4                ; =4
10299ffa8: 52800004    	mov	w4, #0x0                ; =0
10299ffac: 528042c6    	mov	w6, #0x216              ; =534
10299ffb0: 1400002c    	b	0x1029a0060 <_Flutter_Image_provideRelativePathByUrl+0xdacf10>
10299ffb4: f9400a60    	ldr	x0, [x19, #0x10]
10299ffb8: 900ebb28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10299ffbc: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10299ffc0: 954a1c5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299ffc4: b40001a0    	cbz	x0, 0x10299fff8 <_Flutter_Image_provideRelativePathByUrl+0xdacea8>
10299ffc8: f9400a60    	ldr	x0, [x19, #0x10]
10299ffcc: 900ebb28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10299ffd0: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10299ffd4: d00de662    	adrp	x2, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
10299ffd8: 91302042    	add	x2, x2, #0xc08
10299ffdc: 954a1c58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10299ffe0: f9400e68    	ldr	x8, [x19, #0x18]
10299ffe4: 7100001f    	cmp	w0, #0x0
10299ffe8: fa411904    	ccmp	x8, #0x1, #0x4, ne
10299ffec: 540004a1    	b.ne	0x1029a0080 <_Flutter_Image_provideRelativePathByUrl+0xdacf30>
10299fff0: 52800020    	mov	w0, #0x1                ; =1
10299fff4: 1400001f    	b	0x1029a0070 <_Flutter_Image_provideRelativePathByUrl+0xdacf20>
10299fff8: 900ebea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10299fffc: f9453514    	ldr	x20, [x8, #0xa68]
1029a0000: 900ebee8    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1029a0004: f943c500    	ldr	x0, [x8, #0x788]
1029a0008: 900eaac8    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029a000c: f941bd01    	ldr	x1, [x8, #0x378] ; ruleDescription:
1029a0010: aa1303e2    	mov	x2, x19
1029a0014: 954a1c4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0018: aa1d03fd    	mov	x29, x29
1029a001c: 954a1c4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029a0020: aa0003f3    	mov	x19, x0
1029a0024: b00ea4c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029a0028: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029a002c: b00de668    	adrp	x8, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
1029a0030: 912fa108    	add	x8, x8, #0xbe8
1029a0034: a90003e8    	stp	x8, x0, [sp]
1029a0038: 900c5ee3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a003c: 9125d063    	add	x3, x3, #0x974
1029a0040: 900c5ee5    	adrp	x5, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a0044: 91200ca5    	add	x5, x5, #0x803
1029a0048: 900c5ee7    	adrp	x7, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a004c: 912e78e7    	add	x7, x7, #0xb9e
1029a0050: aa1403e0    	mov	x0, x20
1029a0054: 52800082    	mov	w2, #0x4                ; =4
1029a0058: 52800004    	mov	w4, #0x0                ; =0
1029a005c: 52804386    	mov	w6, #0x21c              ; =540
1029a0060: 954a1c37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a0064: aa1303e0    	mov	x0, x19
1029a0068: 954a1c3b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029a006c: 52800000    	mov	w0, #0x0                ; =0
1029a0070: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1029a0074: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1029a0078: 9100c3ff    	add	sp, sp, #0x30
1029a007c: d65f03c0    	ret
1029a0080: f00ebe88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029a0084: f9453500    	ldr	x0, [x8, #0xa68]
1029a0088: b00ea4c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029a008c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029a0090: b00de668    	adrp	x8, 0x11e66d000 <dyld_stub_binder+0x11e66d000>
1029a0094: 9130a108    	add	x8, x8, #0xc28
1029a0098: f90003e8    	str	x8, [sp]
1029a009c: 900c5ee3    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a00a0: 9125d063    	add	x3, x3, #0x974
1029a00a4: 900c5ee5    	adrp	x5, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a00a8: 91200ca5    	add	x5, x5, #0x803
1029a00ac: 900c5ee7    	adrp	x7, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029a00b0: 912e78e7    	add	x7, x7, #0xb9e
1029a00b4: 52800082    	mov	w2, #0x4                ; =4
1029a00b8: 52800004    	mov	w4, #0x0                ; =0
1029a00bc: 52804446    	mov	w6, #0x222              ; =546
1029a00c0: 954a1c1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029a00c4: 17ffffea    	b	0x1029a006c <_Flutter_Image_provideRelativePathByUrl+0xdacf1c>
