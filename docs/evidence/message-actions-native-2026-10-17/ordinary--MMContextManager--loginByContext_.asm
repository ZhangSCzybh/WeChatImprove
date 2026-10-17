
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175dff4c: d10643ff    	sub	sp, sp, #0x190
1175dff50: 6d1223e9    	stp	d9, d8, [sp, #0x120]
1175dff54: a9136ffc    	stp	x28, x27, [sp, #0x130]
1175dff58: a91467fa    	stp	x26, x25, [sp, #0x140]
1175dff5c: a9155ff8    	stp	x24, x23, [sp, #0x150]
1175dff60: a91657f6    	stp	x22, x21, [sp, #0x160]
1175dff64: a9174ff4    	stp	x20, x19, [sp, #0x170]
1175dff68: a9187bfd    	stp	x29, x30, [sp, #0x180]
1175dff6c: 910603fd    	add	x29, sp, #0x180
1175dff70: aa0203f4    	mov	x20, x2
1175dff74: aa0003f3    	mov	x19, x0
1175dff78: 90030088    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1175dff7c: f9405908    	ldr	x8, [x8, #0xb0]
1175dff80: f9400108    	ldr	x8, [x8]
1175dff84: f81903a8    	stur	x8, [x29, #-0x70]
1175dff88: aa0203e0    	mov	x0, x2
1175dff8c: 94352779    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175dff90: f9400a61    	ldr	x1, [x19, #0x10]
1175dff94: 910203e0    	add	x0, sp, #0x80
1175dff98: 940011d4    	bl	0x1175e46e8 <_O266DecReleaseOutputPicture+0x4357c30>
1175dff9c: 4f00e400    	movi.16b	v0, #0x0
1175dffa0: ad0303e0    	stp	q0, q0, [sp, #0x60]
1175dffa4: ad0203e0    	stp	q0, q0, [sp, #0x40]
1175dffa8: f90007f3    	str	x19, [sp, #0x8]
1175dffac: f9400675    	ldr	x21, [x19, #0x8]
1175dffb0: aa1503e0    	mov	x0, x21
1175dffb4: 9435276f    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175dffb8: b0045908    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175dffbc: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
1175dffc0: 910103e2    	add	x2, sp, #0x40
1175dffc4: 910243e3    	add	x3, sp, #0x90
1175dffc8: f9000be1    	str	x1, [sp, #0x10]
1175dffcc: 52800204    	mov	w4, #0x10               ; =16
1175dffd0: 94352747    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175dffd4: f00465bc    	adrp	x28, 0x120296000 <dyld_stub_binder+0x120296000>
1175dffd8: 911b839c    	add	x28, x28, #0x6e0
1175dffdc: f00465bb    	adrp	x27, 0x120296000 <dyld_stub_binder+0x120296000>
1175dffe0: 911b437b    	add	x27, x27, #0x6d0
1175dffe4: b40007a0    	cbz	x0, 0x1175e00d8 <_O266DecReleaseOutputPicture+0x4353620>
1175dffe8: aa0003f7    	mov	x23, x0
1175dffec: f9402be8    	ldr	x8, [sp, #0x50]
1175dfff0: f9400113    	ldr	x19, [x8]
1175dfff4: 52800056    	mov	w22, #0x2               ; =2
1175dfff8: d000bd08    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1175dfffc: fd41c108    	ldr	d8, [x8, #0x380]
1175e0000: d2800018    	mov	x24, #0x0               ; =0
1175e0004: b00442e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1175e0008: f941c919    	ldr	x25, [x8, #0x390] ; isUserContext
1175e000c: f9402be8    	ldr	x8, [sp, #0x50]
1175e0010: f9400108    	ldr	x8, [x8]
1175e0014: eb13011f    	cmp	x8, x19
1175e0018: 54000060    	b.eq	0x1175e0024 <_O266DecReleaseOutputPicture+0x435356c>
1175e001c: aa1503e0    	mov	x0, x21
1175e0020: 94352706    	bl	0x118329c38 <dyld_stub_binder+0x118329c38>
1175e0024: f94027e8    	ldr	x8, [sp, #0x48]
1175e0028: f878791a    	ldr	x26, [x8, x24, lsl #3]
1175e002c: aa1a03e0    	mov	x0, x26
1175e0030: aa1903e1    	mov	x1, x25
1175e0034: 9435272e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e0038: 340000c0    	cbz	w0, 0x1175e0050 <_O266DecReleaseOutputPicture+0x4353598>
1175e003c: b9800388    	ldrsw	x8, [x28]
1175e0040: f8686b49    	ldr	x9, [x26, x8]
1175e0044: f100053f    	cmp	x9, #0x1
1175e0048: 54000041    	b.ne	0x1175e0050 <_O266DecReleaseOutputPicture+0x4353598>
1175e004c: f8286b56    	str	x22, [x26, x8]
1175e0050: b9800368    	ldrsw	x8, [x27]
1175e0054: f8686b49    	ldr	x9, [x26, x8]
1175e0058: b40002a9    	cbz	x9, 0x1175e00ac <_O266DecReleaseOutputPicture+0x43535f4>
1175e005c: f8686a88    	ldr	x8, [x20, x8]
1175e0060: b4000268    	cbz	x8, 0x1175e00ac <_O266DecReleaseOutputPicture+0x43535f4>
1175e0064: b9800388    	ldrsw	x8, [x28]
1175e0068: f8686b48    	ldr	x8, [x26, x8]
1175e006c: f1000d1f    	cmp	x8, #0x3
1175e0070: 540001e1    	b.ne	0x1175e00ac <_O266DecReleaseOutputPicture+0x43535f4>
1175e0074: d0030068    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1175e0078: f947e108    	ldr	x8, [x8, #0xfc0]
1175e007c: f9000fe8    	str	x8, [sp, #0x18]
1175e0080: fd0013e8    	str	d8, [sp, #0x20]
1175e0084: 90000008    	adrp	x8, 0x1175e0000 <_O266DecReleaseOutputPicture+0x4353548>
1175e0088: 9106d109    	add	x9, x8, #0x1b4
1175e008c: d00300a8    	adrp	x8, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1175e0090: 9115c108    	add	x8, x8, #0x570
1175e0094: a902a3e9    	stp	x9, x8, [sp, #0x28]
1175e0098: f9001ffa    	str	x26, [sp, #0x38]
1175e009c: 910063e1    	add	x1, sp, #0x18
1175e00a0: f0030060    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1175e00a4: f9408c00    	ldr	x0, [x0, #0x118]
1175e00a8: 97fe643f    	bl	0x1175791a4 <_O266DecReleaseOutputPicture+0x42ec6ec>
1175e00ac: 91000718    	add	x24, x24, #0x1
1175e00b0: eb1802ff    	cmp	x23, x24
1175e00b4: 54fffac1    	b.ne	0x1175e000c <_O266DecReleaseOutputPicture+0x4353554>
1175e00b8: 910103e2    	add	x2, sp, #0x40
1175e00bc: 910243e3    	add	x3, sp, #0x90
1175e00c0: aa1503e0    	mov	x0, x21
1175e00c4: f9400be1    	ldr	x1, [sp, #0x10]
1175e00c8: 52800204    	mov	w4, #0x10               ; =16
1175e00cc: 94352708    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e00d0: aa0003f7    	mov	x23, x0
1175e00d4: b5fff960    	cbnz	x0, 0x1175e0000 <_O266DecReleaseOutputPicture+0x4353548>
1175e00d8: aa1503e0    	mov	x0, x21
1175e00dc: 9435271f    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175e00e0: b9800388    	ldrsw	x8, [x28]
1175e00e4: 52800029    	mov	w9, #0x1                ; =1
1175e00e8: f8286a89    	str	x9, [x20, x8]
1175e00ec: d00465a8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175e00f0: 911c0108    	add	x8, x8, #0x700
1175e00f4: b9800108    	ldrsw	x8, [x8]
1175e00f8: f8686a80    	ldr	x0, [x20, x8]
1175e00fc: b00458c8    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
1175e0100: f9468d01    	ldr	x1, [x8, #0xd18] ; userWillLogin
1175e0104: 943526fa    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e0108: f94007f6    	ldr	x22, [sp, #0x8]
1175e010c: f9400ed5    	ldr	x21, [x22, #0x18]
1175e0110: f9000ed4    	str	x20, [x22, #0x18]
1175e0114: aa1403e0    	mov	x0, x20
1175e0118: 94352716    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175e011c: aa1503e0    	mov	x0, x21
1175e0120: 9435270e    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175e0124: f0045c88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1175e0128: f945e900    	ldr	x0, [x8, #0xbd0]
1175e012c: b00458c8    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
1175e0130: f945bd01    	ldr	x1, [x8, #0xb78] ; setContext:atIndex:
1175e0134: aa1403e2    	mov	x2, x20
1175e0138: 52800023    	mov	w3, #0x1                ; =1
1175e013c: 943526ec    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e0140: b94022c8    	ldr	w8, [x22, #0x20]
1175e0144: 11000508    	add	w8, w8, #0x1
1175e0148: b90022c8    	str	w8, [x22, #0x20]
1175e014c: b9800368    	ldrsw	x8, [x27]
1175e0150: f8686a93    	ldr	x19, [x20, x8]
1175e0154: aa1403e0    	mov	x0, x20
1175e0158: 94352700    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175e015c: b4000093    	cbz	x19, 0x1175e016c <_O266DecReleaseOutputPicture+0x43536b4>
1175e0160: b94026c8    	ldr	w8, [x22, #0x24]
1175e0164: 11000508    	add	w8, w8, #0x1
1175e0168: b90026c8    	str	w8, [x22, #0x24]
1175e016c: 910203e0    	add	x0, sp, #0x80
1175e0170: 9400117f    	bl	0x1175e476c <_O266DecReleaseOutputPicture+0x4357cb4>
1175e0174: f85903a8    	ldur	x8, [x29, #-0x70]
1175e0178: f0030069    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1175e017c: f9405929    	ldr	x9, [x9, #0xb0]
1175e0180: f9400129    	ldr	x9, [x9]
1175e0184: eb08013f    	cmp	x9, x8
1175e0188: 54000141    	b.ne	0x1175e01b0 <_O266DecReleaseOutputPicture+0x43536f8>
1175e018c: a9587bfd    	ldp	x29, x30, [sp, #0x180]
1175e0190: a9574ff4    	ldp	x20, x19, [sp, #0x170]
1175e0194: a95657f6    	ldp	x22, x21, [sp, #0x160]
1175e0198: a9555ff8    	ldp	x24, x23, [sp, #0x150]
1175e019c: a95467fa    	ldp	x26, x25, [sp, #0x140]
1175e01a0: a9536ffc    	ldp	x28, x27, [sp, #0x130]
1175e01a4: 6d5223e9    	ldp	d9, d8, [sp, #0x120]
1175e01a8: 910643ff    	add	sp, sp, #0x190
1175e01ac: d65f03c0    	ret
1175e01b0: 943519d3    	bl	0x1183268fc <dyld_stub_binder+0x1183268fc>