
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0bfc38: d10283ff    	sub	sp, sp, #0xa0
10a0bfc3c: 6d0323e9    	stp	d9, d8, [sp, #0x30]
10a0bfc40: a9046ffc    	stp	x28, x27, [sp, #0x40]
10a0bfc44: a90567fa    	stp	x26, x25, [sp, #0x50]
10a0bfc48: a9065ff8    	stp	x24, x23, [sp, #0x60]
10a0bfc4c: a90757f6    	stp	x22, x21, [sp, #0x70]
10a0bfc50: a9084ff4    	stp	x20, x19, [sp, #0x80]
10a0bfc54: a9097bfd    	stp	x29, x30, [sp, #0x90]
10a0bfc58: 910243fd    	add	x29, sp, #0x90
10a0bfc5c: aa0303f4    	mov	x20, x3
10a0bfc60: aa0203f3    	mov	x19, x2
10a0bfc64: aa0003f6    	mov	x22, x0
10a0bfc68: d00b5c88    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0bfc6c: 52800029    	mov	w9, #0x1                ; =1
10a0bfc70: 39123509    	strb	w9, [x8, #0x48d]
10a0bfc74: aa0203e0    	mov	x0, x2
10a0bfc78: 955e6df2    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0bfc7c: aa1403e0    	mov	x0, x20
10a0bfc80: 955e6df0    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0bfc84: b00b0da8    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0bfc88: b9827917    	ldrsw	x23, [x8, #0x278]
10a0bfc8c: b00aebe8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0bfc90: f9427d15    	ldr	x21, [x8, #0x4f8] ; section
10a0bfc94: aa1503e1    	mov	x1, x21
10a0bfc98: 955e6deb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfc9c: f9000fe0    	str	x0, [sp, #0x18]
10a0bfca0: 910063e8    	add	x8, sp, #0x18
10a0bfca4: f90017e8    	str	x8, [sp, #0x28]
10a0bfca8: b0080d62    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
10a0bfcac: 91282842    	add	x2, x2, #0xa0a
10a0bfcb0: 8b1702c0    	add	x0, x22, x23
10a0bfcb4: 910063e1    	add	x1, sp, #0x18
10a0bfcb8: 9100a3e3    	add	x3, sp, #0x28
10a0bfcbc: 91009fe4    	add	x4, sp, #0x27
10a0bfcc0: 973239af    	bl	0x106d4e37c <_Flutter_MMFoundation_BindContext+0x3229f60>
10a0bfcc4: b9402808    	ldr	w8, [x0, #0x28]
10a0bfcc8: 51000509    	sub	w9, w8, #0x1
10a0bfccc: 71000d3f    	cmp	w9, #0x3
10a0bfcd0: 540006e2    	b.hs	0x10a0bfdac <_Flutter_MMFoundation_BindContext+0x659b990>
10a0bfcd4: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bfcd8: f9428501    	ldr	x1, [x8, #0x508] ; shouldShowStoryCell
10a0bfcdc: aa1603e0    	mov	x0, x22
10a0bfce0: 955e6dd9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfce4: 52000019    	eor	w25, w0, #0x1
10a0bfce8: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bfcec: f9428101    	ldr	x1, [x8, #0x500] ; shouldShowFinderLiveHeaderCell
10a0bfcf0: aa1603e0    	mov	x0, x22
10a0bfcf4: 955e6dd4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfcf8: aa0003f8    	mov	x24, x0
10a0bfcfc: aa1403e0    	mov	x0, x20
10a0bfd00: aa1503e1    	mov	x1, x21
10a0bfd04: 955e6dd0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd08: 8b190008    	add	x8, x0, x25
10a0bfd0c: cb38411a    	sub	x26, x8, w24, uxtw
10a0bfd10: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bfd14: f9428917    	ldr	x23, [x8, #0x510] ; hasUnReadMessage
10a0bfd18: aa1603e0    	mov	x0, x22
10a0bfd1c: aa1703e1    	mov	x1, x23
10a0bfd20: 955e6dc9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd24: eb20435f    	cmp	x26, w0, uxtw
10a0bfd28: 1e601000    	fmov	d0, #2.00000000
10a0bfd2c: 1e65d008    	fmov	d8, #15.00000000
10a0bfd30: 1e600d09    	fcsel	d9, d8, d0, eq
10a0bfd34: 900b05a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bfd38: f9461900    	ldr	x0, [x8, #0xc30]
10a0bfd3c: d00aebc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bfd40: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
10a0bfd44: d2e80888    	mov	x8, #0x4044000000000000 ; =4630826316843712512
10a0bfd48: 9e670100    	fmov	d0, x8
10a0bfd4c: 955e6dbe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd50: 1e602929    	fadd	d9, d9, d0
10a0bfd54: aa1403e0    	mov	x0, x20
10a0bfd58: aa1503e1    	mov	x1, x21
10a0bfd5c: 955e6dba    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd60: f00afea8    	adrp	x8, 0x120096000 <dyld_stub_binder+0x120096000>
10a0bfd64: f944e501    	ldr	x1, [x8, #0x9c8] ; calcDataItemIndex:
10a0bfd68: 91000402    	add	x2, x0, #0x1
10a0bfd6c: aa1603e0    	mov	x0, x22
10a0bfd70: 955e6db5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd74: b4000180    	cbz	x0, 0x10a0bfda4 <_Flutter_MMFoundation_BindContext+0x659b988>
10a0bfd78: 93400318    	sbfx	x24, x24, #0, #1
10a0bfd7c: aa1403e0    	mov	x0, x20
10a0bfd80: aa1503e1    	mov	x1, x21
10a0bfd84: 955e6db0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd88: 8b190308    	add	x8, x24, x25
10a0bfd8c: 8b000115    	add	x21, x8, x0
10a0bfd90: aa1603e0    	mov	x0, x22
10a0bfd94: aa1703e1    	mov	x1, x23
10a0bfd98: 955e6dab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfd9c: eb2042bf    	cmp	x21, w0, uxtw
10a0bfda0: 54000da1    	b.ne	0x10a0bff54 <_Flutter_MMFoundation_BindContext+0x659bb38>
10a0bfda4: 1e682928    	fadd	d8, d9, d8
10a0bfda8: 140000a8    	b	0x10a0c0048 <_Flutter_MMFoundation_BindContext+0x659bc2c>
10a0bfdac: 7100191f    	cmp	w8, #0x6
10a0bfdb0: 54000140    	b.eq	0x10a0bfdd8 <_Flutter_MMFoundation_BindContext+0x659b9bc>
10a0bfdb4: 7100151f    	cmp	w8, #0x5
10a0bfdb8: 54000361    	b.ne	0x10a0bfe24 <_Flutter_MMFoundation_BindContext+0x659ba08>
10a0bfdbc: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bfdc0: f942ad01    	ldr	x1, [x8, #0x558] ; heightForStoryAtIndexPath:
10a0bfdc4: aa1603e0    	mov	x0, x22
10a0bfdc8: aa1403e2    	mov	x2, x20
10a0bfdcc: 955e6d9e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfdd0: 1e604008    	fmov	d8, d0
10a0bfdd4: 1400009d    	b	0x10a0c0048 <_Flutter_MMFoundation_BindContext+0x659bc2c>
10a0bfdd8: 900b0768    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0bfddc: f9420515    	ldr	x21, [x8, #0x408]
10a0bfde0: 900b0268    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0bfde4: f946d501    	ldr	x1, [x8, #0xda8] ; view
10a0bfde8: aa1603e0    	mov	x0, x22
10a0bfdec: 955e6d96    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfdf0: aa1d03fd    	mov	x29, x29
10a0bfdf4: 955e6d97    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfdf8: aa0003f6    	mov	x22, x0
10a0bfdfc: 900b0268    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0bfe00: f947a501    	ldr	x1, [x8, #0xf48] ; width
10a0bfe04: 955e6d90    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe08: f00aed88    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
10a0bfe0c: f943d901    	ldr	x1, [x8, #0x7b0] ; cellHeightWithWidth:
10a0bfe10: aa1503e0    	mov	x0, x21
10a0bfe14: 955e6d8c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe18: 1e604008    	fmov	d8, d0
10a0bfe1c: aa1603e0    	mov	x0, x22
10a0bfe20: 14000089    	b	0x10a0c0044 <_Flutter_MMFoundation_BindContext+0x659bc28>
10a0bfe24: aa1403e0    	mov	x0, x20
10a0bfe28: aa1503e1    	mov	x1, x21
10a0bfe2c: 955e6d86    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe30: aa0003e2    	mov	x2, x0
10a0bfe34: f00afea8    	adrp	x8, 0x120096000 <dyld_stub_binder+0x120096000>
10a0bfe38: f944e501    	ldr	x1, [x8, #0x9c8] ; calcDataItemIndex:
10a0bfe3c: aa1603e0    	mov	x0, x22
10a0bfe40: 955e6d81    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe44: aa0003fa    	mov	x26, x0
10a0bfe48: 900b05a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bfe4c: f945e900    	ldr	x0, [x8, #0xbd0]
10a0bfe50: b00b0208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0bfe54: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
10a0bfe58: aa1903e1    	mov	x1, x25
10a0bfe5c: 955e6d7a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe60: aa1d03fd    	mov	x29, x29
10a0bfe64: 955e6d7b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfe68: aa0003fb    	mov	x27, x0
10a0bfe6c: b00b05b7    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
10a0bfe70: f94286e0    	ldr	x0, [x23, #0x508]
10a0bfe74: 900b0208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0bfe78: f947ad18    	ldr	x24, [x8, #0xf58] ; class
10a0bfe7c: aa1803e1    	mov	x1, x24
10a0bfe80: 955e6d71    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe84: aa0003e2    	mov	x2, x0
10a0bfe88: d00aebc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bfe8c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10a0bfe90: aa1b03e0    	mov	x0, x27
10a0bfe94: f9000be1    	str	x1, [sp, #0x10]
10a0bfe98: 955e6d6b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfe9c: aa1d03fd    	mov	x29, x29
10a0bfea0: 955e6d6c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfea4: aa0003fc    	mov	x28, x0
10a0bfea8: d00afa28    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
10a0bfeac: f944c501    	ldr	x1, [x8, #0x988] ; getTimelineDataItemOfIndex:
10a0bfeb0: aa1a03e2    	mov	x2, x26
10a0bfeb4: 955e6d64    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfeb8: aa1d03fd    	mov	x29, x29
10a0bfebc: 955e6d65    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bfec0: aa0003f5    	mov	x21, x0
10a0bfec4: aa1c03e0    	mov	x0, x28
10a0bfec8: 955e6d65    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bfecc: aa1b03e0    	mov	x0, x27
10a0bfed0: 955e6d63    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0bfed4: f00afa08    	adrp	x8, 0x120002000 <dyld_stub_binder+0x120002000>
10a0bfed8: f942c501    	ldr	x1, [x8, #0x588] ; isEarlierContentTipsItem
10a0bfedc: aa1503e0    	mov	x0, x21
10a0bfee0: 955e6d59    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfee4: 340003e0    	cbz	w0, 0x10a0bff60 <_Flutter_MMFoundation_BindContext+0x659bb44>
10a0bfee8: 900b05a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0bfeec: f9453500    	ldr	x0, [x8, #0xa68]
10a0bfef0: d00aebc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0bfef4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0bfef8: 900a4c08    	adrp	x8, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a0bfefc: 913a2108    	add	x8, x8, #0xe88
10a0bff00: f90003e8    	str	x8, [sp]
10a0bff04: b0088ae3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0bff08: 912b2863    	add	x3, x3, #0xaca
10a0bff0c: d008e225    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0bff10: 912850a5    	add	x5, x5, #0xa14
10a0bff14: d008e227    	adrp	x7, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0bff18: 913d68e7    	add	x7, x7, #0xf5a
10a0bff1c: 52800042    	mov	w2, #0x2                ; =2
10a0bff20: 52800004    	mov	w4, #0x0                ; =0
10a0bff24: 5280fca6    	mov	w6, #0x7e5              ; =2021
10a0bff28: 955e6d47    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bff2c: f00b0228    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0bff30: f9440901    	ldr	x1, [x8, #0x810] ; row
10a0bff34: aa1403e0    	mov	x0, x20
10a0bff38: 955e6d43    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bff3c: b5000760    	cbnz	x0, 0x10a0c0028 <_Flutter_MMFoundation_BindContext+0x659bc0c>
10a0bff40: 900b0768    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0bff44: f9420900    	ldr	x0, [x8, #0x410] ; P:F
10a0bff48: d00aec08    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
10a0bff4c: f9444101    	ldr	x1, [x8, #0x880] ; cellHeight
10a0bff50: 1400003a    	b	0x10a0c0038 <_Flutter_MMFoundation_BindContext+0x659bc1c>
10a0bff54: 1e601000    	fmov	d0, #2.00000000
10a0bff58: 1e602928    	fadd	d8, d9, d0
10a0bff5c: 1400003b    	b	0x10a0c0048 <_Flutter_MMFoundation_BindContext+0x659bc2c>
10a0bff60: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bff64: f942b101    	ldr	x1, [x8, #0x560] ; isNewDataSeparator
10a0bff68: aa1503e0    	mov	x0, x21
10a0bff6c: 955e6d36    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bff70: 34000480    	cbz	w0, 0x10a0c0000 <_Flutter_MMFoundation_BindContext+0x659bbe4>
10a0bff74: f00b0228    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0bff78: f9440901    	ldr	x1, [x8, #0x810] ; row
10a0bff7c: aa1403e0    	mov	x0, x20
10a0bff80: 955e6d31    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bff84: b5000520    	cbnz	x0, 0x10a0c0028 <_Flutter_MMFoundation_BindContext+0x659bc0c>
10a0bff88: 900b0768    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0bff8c: f9421100    	ldr	x0, [x8, #0x420] ; вC
10a0bff90: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bff94: f942b501    	ldr	x1, [x8, #0x568] ; viewModelWithDataItem:
10a0bff98: aa1503e2    	mov	x2, x21
10a0bff9c: 955e6d2a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bffa0: aa1d03fd    	mov	x29, x29
10a0bffa4: 955e6d2b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0bffa8: aa0003f6    	mov	x22, x0
10a0bffac: 900b0268    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0bffb0: f947a517    	ldr	x23, [x8, #0xf48] ; width
10a0bffb4: aa1303e0    	mov	x0, x19
10a0bffb8: aa1703e1    	mov	x1, x23
10a0bffbc: 955e6d22    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bffc0: f00b0248    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0bffc4: f9418d01    	ldr	x1, [x8, #0x318] ; setWidth:
10a0bffc8: aa1603e0    	mov	x0, x22
10a0bffcc: 955e6d1e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bffd0: 900b0768    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0bffd4: f9421518    	ldr	x24, [x8, #0x428]
10a0bffd8: aa1303e0    	mov	x0, x19
10a0bffdc: aa1703e1    	mov	x1, x23
10a0bffe0: 955e6d19    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bffe4: d00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0bffe8: f942b901    	ldr	x1, [x8, #0x570] ; heightForWidth:viewModel:
10a0bffec: aa1803e0    	mov	x0, x24
10a0bfff0: aa1603e2    	mov	x2, x22
10a0bfff4: 955e6d14    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0bfff8: 1e604008    	fmov	d8, d0
10a0bfffc: 140000e2    	b	0x10a0c0384 <_Flutter_MMFoundation_BindContext+0x659bf68>
10a0c0000: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c0004: f942bd01    	ldr	x1, [x8, #0x578] ; canEditAfterDeleted
10a0c0008: aa1503e0    	mov	x0, x21
10a0c000c: 955e6d0e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0010: 34000380    	cbz	w0, 0x10a0c0080 <_Flutter_MMFoundation_BindContext+0x659bc64>
10a0c0014: d00b0228    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0c0018: f9440901    	ldr	x1, [x8, #0x810] ; row
10a0c001c: aa1403e0    	mov	x0, x20
10a0c0020: 955e6d09    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0024: b40016e0    	cbz	x0, 0x10a0c0300 <_Flutter_MMFoundation_BindContext+0x659bee4>
10a0c0028: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c002c: f9420d00    	ldr	x0, [x8, #0x418]
10a0c0030: b00afc48    	adrp	x8, 0x120049000 <dyld_stub_binder+0x120049000>
10a0c0034: f9428901    	ldr	x1, [x8, #0x510] ; separatorHeight
10a0c0038: 955e6d03    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c003c: 1e604008    	fmov	d8, d0
10a0c0040: aa1503e0    	mov	x0, x21
10a0c0044: 955e6d06    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0048: aa1403e0    	mov	x0, x20
10a0c004c: 955e6d04    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0050: aa1303e0    	mov	x0, x19
10a0c0054: 955e6d02    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0058: 1e604100    	fmov	d0, d8
10a0c005c: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10a0c0060: a9484ff4    	ldp	x20, x19, [sp, #0x80]
10a0c0064: a94757f6    	ldp	x22, x21, [sp, #0x70]
10a0c0068: a9465ff8    	ldp	x24, x23, [sp, #0x60]
10a0c006c: a94567fa    	ldp	x26, x25, [sp, #0x50]
10a0c0070: a9446ffc    	ldp	x28, x27, [sp, #0x40]
10a0c0074: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
10a0c0078: 910283ff    	add	sp, sp, #0xa0
10a0c007c: d65f03c0    	ret
10a0c0080: b00af008    	adrp	x8, 0x11fec1000 <dyld_stub_binder+0x11fec1000>
10a0c0084: f946b901    	ldr	x1, [x8, #0xd70] ; extData
10a0c0088: aa1503e0    	mov	x0, x21
10a0c008c: 955e6cee    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0090: aa1d03fd    	mov	x29, x29
10a0c0094: 955e6cef    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0098: aa0003fb    	mov	x27, x0
10a0c009c: 955e6cf0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c00a0: b500035b    	cbnz	x27, 0x10a0c0108 <_Flutter_MMFoundation_BindContext+0x659bcec>
10a0c00a4: f00b0588    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c00a8: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c00ac: aa1903e1    	mov	x1, x25
10a0c00b0: 955e6ce5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c00b4: aa1d03fd    	mov	x29, x29
10a0c00b8: 955e6ce6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c00bc: aa0003fb    	mov	x27, x0
10a0c00c0: f94286e0    	ldr	x0, [x23, #0x508]
10a0c00c4: aa1803e1    	mov	x1, x24
10a0c00c8: 955e6cdf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c00cc: aa0003e2    	mov	x2, x0
10a0c00d0: aa1b03e0    	mov	x0, x27
10a0c00d4: f9400be1    	ldr	x1, [sp, #0x10]
10a0c00d8: 955e6cdb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c00dc: aa1d03fd    	mov	x29, x29
10a0c00e0: 955e6cdc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c00e4: aa0003fc    	mov	x28, x0
10a0c00e8: 900af648    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
10a0c00ec: f9409901    	ldr	x1, [x8, #0x130] ; tryGetWCDataItemPattern:
10a0c00f0: aa1503e2    	mov	x2, x21
10a0c00f4: 955e6cd4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c00f8: aa1c03e0    	mov	x0, x28
10a0c00fc: 955e6cd8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0100: aa1b03e0    	mov	x0, x27
10a0c0104: 955e6cd6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0108: b00afa08    	adrp	x8, 0x120001000 <dyld_stub_binder+0x120001000>
10a0c010c: f943a501    	ldr	x1, [x8, #0x748] ; wsGroup
10a0c0110: aa1503e0    	mov	x0, x21
10a0c0114: 955e6ccc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0118: aa1d03fd    	mov	x29, x29
10a0c011c: 955e6ccd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0120: aa0003fb    	mov	x27, x0
10a0c0124: 955e6cce    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0128: b400043b    	cbz	x27, 0x10a0c01ac <_Flutter_MMFoundation_BindContext+0x659bd90>
10a0c012c: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c0130: f941f117    	ldr	x23, [x8, #0x3e0]
10a0c0134: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c0138: f941e100    	ldr	x0, [x8, #0x3c0]
10a0c013c: aa1803e1    	mov	x1, x24
10a0c0140: 955e6cc1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0144: aa0003fc    	mov	x28, x0
10a0c0148: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c014c: f940fd01    	ldr	x1, [x8, #0x1f8] ; dataControllers
10a0c0150: aa1603e0    	mov	x0, x22
10a0c0154: 955e6cbc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0158: aa1d03fd    	mov	x29, x29
10a0c015c: 955e6cbd    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0160: aa0003fb    	mov	x27, x0
10a0c0164: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c0168: f9411501    	ldr	x1, [x8, #0x228] ; GetImpl:InHolder:
10a0c016c: aa1703e0    	mov	x0, x23
10a0c0170: aa1c03e2    	mov	x2, x28
10a0c0174: aa1b03e3    	mov	x3, x27
10a0c0178: 955e6cb3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c017c: aa1d03fd    	mov	x29, x29
10a0c0180: 955e6cb4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0184: aa0003fc    	mov	x28, x0
10a0c0188: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c018c: f942c101    	ldr	x1, [x8, #0x580] ; recordMicroMerchantFoldItemGenerate:index:
10a0c0190: aa1503e2    	mov	x2, x21
10a0c0194: aa1a03e3    	mov	x3, x26
10a0c0198: 955e6cab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c019c: aa1c03e0    	mov	x0, x28
10a0c01a0: 955e6caf    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c01a4: aa1b03e0    	mov	x0, x27
10a0c01a8: 955e6cad    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c01ac: f00b06d7    	adrp	x23, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a0c01b0: f9467ae0    	ldr	x0, [x23, #0xcf0]
10a0c01b4: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c01b8: f942a901    	ldr	x1, [x8, #0x550] ; getCommentViewCountForDataItem:
10a0c01bc: aa1503e2    	mov	x2, x21
10a0c01c0: 955e6ca1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c01c4: aa0003fc    	mov	x28, x0
10a0c01c8: f00b06c8    	adrp	x8, 0x12019b000 <dyld_stub_binder+0x12019b000>
10a0c01cc: f940dd00    	ldr	x0, [x8, #0x1b8] ; 0r=
10a0c01d0: d00af9e8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0c01d4: f9460901    	ldr	x1, [x8, #0xc10] ; isAdFireworkCheerCommentStyle:
10a0c01d8: aa1503e2    	mov	x2, x21
10a0c01dc: 955e6c9a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c01e0: aa0003fb    	mov	x27, x0
10a0c01e4: d00b0228    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0c01e8: f944091a    	ldr	x26, [x8, #0x810] ; row
10a0c01ec: aa1403e0    	mov	x0, x20
10a0c01f0: aa1a03e1    	mov	x1, x26
10a0c01f4: 955e6c94    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c01f8: b40008c0    	cbz	x0, 0x10a0c0310 <_Flutter_MMFoundation_BindContext+0x659bef4>
10a0c01fc: aa1403e0    	mov	x0, x20
10a0c0200: aa1a03e1    	mov	x1, x26
10a0c0204: 955e6c90    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0208: eb1c001f    	cmp	x0, x28
10a0c020c: 54000c29    	b.ls	0x10a0c0390 <_Flutter_MMFoundation_BindContext+0x659bf74>
10a0c0210: 340016bb    	cbz	w27, 0x10a0c04e4 <_Flutter_MMFoundation_BindContext+0x659c0c8>
10a0c0214: aa1403e0    	mov	x0, x20
10a0c0218: aa1a03e1    	mov	x1, x26
10a0c021c: 955e6c8a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0220: 91000788    	add	x8, x28, #0x1
10a0c0224: eb08001f    	cmp	x0, x8
10a0c0228: 54001621    	b.ne	0x10a0c04ec <_Flutter_MMFoundation_BindContext+0x659c0d0>
10a0c022c: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c0230: f9421900    	ldr	x0, [x8, #0x430]
10a0c0234: d00aeec8    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
10a0c0238: f9421916    	ldr	x22, [x8, #0x430] ; defaultHeight
10a0c023c: aa1603e1    	mov	x1, x22
10a0c0240: 955e6c81    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0244: 1e604008    	fmov	d8, d0
10a0c0248: 900b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c024c: f9403d1a    	ldr	x26, [x8, #0x78]
10a0c0250: f00b0588    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c0254: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c0258: aa1903e1    	mov	x1, x25
10a0c025c: 955e6c7a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0260: aa1d03fd    	mov	x29, x29
10a0c0264: 955e6c7b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0268: aa0003f9    	mov	x25, x0
10a0c026c: 900b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c0270: f9404100    	ldr	x0, [x8, #0x80]
10a0c0274: aa1803e1    	mov	x1, x24
10a0c0278: 955e6c73    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c027c: aa0003e2    	mov	x2, x0
10a0c0280: aa1903e0    	mov	x0, x25
10a0c0284: f9400be1    	ldr	x1, [sp, #0x10]
10a0c0288: 955e6c6f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c028c: aa1d03fd    	mov	x29, x29
10a0c0290: 955e6c70    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0294: aa0003f7    	mov	x23, x0
10a0c0298: f00aebc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a0c029c: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10a0c02a0: 900a4822    	adrp	x2, 0x11e9c4000 <dyld_stub_binder+0x11e9c4000>
10a0c02a4: 91182042    	add	x2, x2, #0x608
10a0c02a8: 900a3643    	adrp	x3, 0x11e788000 <dyld_stub_binder+0x11e788000>
10a0c02ac: 910f2063    	add	x3, x3, #0x3c8
10a0c02b0: 955e6c65    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c02b4: aa1d03fd    	mov	x29, x29
10a0c02b8: 955e6c66    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c02bc: aa0003f8    	mov	x24, x0
10a0c02c0: 900aebe8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0c02c4: f9400101    	ldr	x1, [x8]
10a0c02c8: aa1a03e0    	mov	x0, x26
10a0c02cc: aa1803e2    	mov	x2, x24
10a0c02d0: 955e6c5d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c02d4: 1e602908    	fadd	d8, d8, d0
10a0c02d8: aa1803e0    	mov	x0, x24
10a0c02dc: 955e6c60    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c02e0: aa1703e0    	mov	x0, x23
10a0c02e4: 955e6c5e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c02e8: aa1903e0    	mov	x0, x25
10a0c02ec: 955e6c5c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c02f0: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c02f4: f9420d00    	ldr	x0, [x8, #0x418]
10a0c02f8: aa1603e1    	mov	x1, x22
10a0c02fc: 14000077    	b	0x10a0c04d8 <_Flutter_MMFoundation_BindContext+0x659c0bc>
10a0c0300: f00b31e8    	adrp	x8, 0x1206ff000 <dyld_stub_binder+0x1206ff000>
10a0c0304: 912b6108    	add	x8, x8, #0xad8
10a0c0308: fd400108    	ldr	d8, [x8]
10a0c030c: 17ffff4d    	b	0x10a0c0040 <_Flutter_MMFoundation_BindContext+0x659bc24>
10a0c0310: 900af9a8    	adrp	x8, 0x11fff4000 <dyld_stub_binder+0x11fff4000>
10a0c0314: f9429101    	ldr	x1, [x8, #0x520] ; heightOfTimelineCellInCache:
10a0c0318: aa1603e0    	mov	x0, x22
10a0c031c: aa1503e2    	mov	x2, x21
10a0c0320: 955e6c49    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0324: aa1d03fd    	mov	x29, x29
10a0c0328: 955e6c4a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c032c: aa0003f6    	mov	x22, x0
10a0c0330: d00aeca8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a0c0334: f9447501    	ldr	x1, [x8, #0x8e8] ; likeCount
10a0c0338: aa1503e0    	mov	x0, x21
10a0c033c: 955e6c42    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0340: 7100001f    	cmp	w0, #0x0
10a0c0344: 540000ec    	b.gt	0x10a0c0360 <_Flutter_MMFoundation_BindContext+0x659bf44>
10a0c0348: d00aecc8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a0c034c: f9465501    	ldr	x1, [x8, #0xca8] ; commentCount
10a0c0350: aa1503e0    	mov	x0, x21
10a0c0354: 955e6c3c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0358: 7100001f    	cmp	w0, #0x0
10a0c035c: 54000f8d    	b.le	0x10a0c054c <_Flutter_MMFoundation_BindContext+0x659c130>
10a0c0360: b00b0208    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a0c0364: f9454d01    	ldr	x1, [x8, #0xa98] ; floatValue
10a0c0368: aa1603e0    	mov	x0, x22
10a0c036c: 955e6c36    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0370: 1e22c000    	fcvt	d0, s0
10a0c0374: b00766a8    	adrp	x8, 0x118d95000 <dyld_stub_binder+0x118d95000>
10a0c0378: 91236108    	add	x8, x8, #0x8d8
10a0c037c: fd400101    	ldr	d1, [x8]
10a0c0380: 1e602828    	fadd	d8, d1, d0
10a0c0384: aa1603e0    	mov	x0, x22
10a0c0388: 955e6c35    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c038c: 17ffff2d    	b	0x10a0c0040 <_Flutter_MMFoundation_BindContext+0x659bc24>
10a0c0390: f9467ae8    	ldr	x8, [x23, #0xcf0]
10a0c0394: f90007e8    	str	x8, [sp, #0x8]
10a0c0398: aa1403e0    	mov	x0, x20
10a0c039c: aa1a03e1    	mov	x1, x26
10a0c03a0: 955e6c29    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c03a4: aa0003fc    	mov	x28, x0
10a0c03a8: b00af928    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
10a0c03ac: f9426d01    	ldr	x1, [x8, #0x4d8] ; pageContext
10a0c03b0: aa1603e0    	mov	x0, x22
10a0c03b4: 955e6c24    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c03b8: aa1d03fd    	mov	x29, x29
10a0c03bc: 955e6c25    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c03c0: aa0003f6    	mov	x22, x0
10a0c03c4: d00afd48    	adrp	x8, 0x12006a000 <dyld_stub_binder+0x12006a000>
10a0c03c8: f946d901    	ldr	x1, [x8, #0xdb0] ; getCellHeightForDataItem:RowIndex:pageContext:
10a0c03cc: f94007e0    	ldr	x0, [sp, #0x8]
10a0c03d0: aa1503e2    	mov	x2, x21
10a0c03d4: aa1c03e3    	mov	x3, x28
10a0c03d8: aa1603e4    	mov	x4, x22
10a0c03dc: 955e6c1a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c03e0: 1e604008    	fmov	d8, d0
10a0c03e4: aa1603e0    	mov	x0, x22
10a0c03e8: 955e6c1d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c03ec: f9467af6    	ldr	x22, [x23, #0xcf0]
10a0c03f0: aa1403e0    	mov	x0, x20
10a0c03f4: aa1a03e1    	mov	x1, x26
10a0c03f8: 955e6c13    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c03fc: aa0003e3    	mov	x3, x0
10a0c0400: d00afd48    	adrp	x8, 0x12006a000 <dyld_stub_binder+0x12006a000>
10a0c0404: f946dd01    	ldr	x1, [x8, #0xdb8] ; GetIsLastCommentOrLikeCell:RowIndex:
10a0c0408: aa1603e0    	mov	x0, x22
10a0c040c: aa1503e2    	mov	x2, x21
10a0c0410: 955e6c0d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0414: 52000008    	eor	w8, w0, #0x1
10a0c0418: 2a080368    	orr	w8, w27, w8
10a0c041c: 3707e128    	tbnz	w8, #0x0, 0x10a0c0040 <_Flutter_MMFoundation_BindContext+0x659bc24>
10a0c0420: 900b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c0424: f9403d16    	ldr	x22, [x8, #0x78]
10a0c0428: f00b0588    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c042c: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c0430: aa1903e1    	mov	x1, x25
10a0c0434: 955e6c04    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0438: aa1d03fd    	mov	x29, x29
10a0c043c: 955e6c05    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0440: aa0003f9    	mov	x25, x0
10a0c0444: 900b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c0448: f9404100    	ldr	x0, [x8, #0x80]
10a0c044c: aa1803e1    	mov	x1, x24
10a0c0450: 955e6bfd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0454: aa0003e2    	mov	x2, x0
10a0c0458: aa1903e0    	mov	x0, x25
10a0c045c: f9400be1    	ldr	x1, [sp, #0x10]
10a0c0460: 955e6bf9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0464: aa1d03fd    	mov	x29, x29
10a0c0468: 955e6bfa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c046c: aa0003f7    	mov	x23, x0
10a0c0470: f00aebc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a0c0474: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10a0c0478: 900a4822    	adrp	x2, 0x11e9c4000 <dyld_stub_binder+0x11e9c4000>
10a0c047c: 91182042    	add	x2, x2, #0x608
10a0c0480: 900a3643    	adrp	x3, 0x11e788000 <dyld_stub_binder+0x11e788000>
10a0c0484: 910f2063    	add	x3, x3, #0x3c8
10a0c0488: 955e6bef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c048c: aa1d03fd    	mov	x29, x29
10a0c0490: 955e6bf0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0494: aa0003f8    	mov	x24, x0
10a0c0498: 900aebe8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0c049c: f9400101    	ldr	x1, [x8]
10a0c04a0: aa1603e0    	mov	x0, x22
10a0c04a4: aa1803e2    	mov	x2, x24
10a0c04a8: 955e6be7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c04ac: 1e602908    	fadd	d8, d8, d0
10a0c04b0: aa1803e0    	mov	x0, x24
10a0c04b4: 955e6bea    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c04b8: aa1703e0    	mov	x0, x23
10a0c04bc: 955e6be8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c04c0: aa1903e0    	mov	x0, x25
10a0c04c4: 955e6be6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c04c8: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c04cc: f9420d00    	ldr	x0, [x8, #0x418]
10a0c04d0: d00aeec8    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
10a0c04d4: f9421901    	ldr	x1, [x8, #0x430] ; defaultHeight
10a0c04d8: 955e6bdb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c04dc: 1e603908    	fsub	d8, d8, d0
10a0c04e0: 17fffed8    	b	0x10a0c0040 <_Flutter_MMFoundation_BindContext+0x659bc24>
10a0c04e4: 52800037    	mov	w23, #0x1               ; =1
10a0c04e8: 14000002    	b	0x10a0c04f0 <_Flutter_MMFoundation_BindContext+0x659c0d4>
10a0c04ec: 52800057    	mov	w23, #0x2               ; =2
10a0c04f0: aa1403e0    	mov	x0, x20
10a0c04f4: aa1a03e1    	mov	x1, x26
10a0c04f8: 955e6bd3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c04fc: 8b1c02e8    	add	x8, x23, x28
10a0c0500: 9e6703e8    	fmov	d8, xzr
10a0c0504: eb08001f    	cmp	x0, x8
10a0c0508: 54ffd9c1    	b.ne	0x10a0c0040 <_Flutter_MMFoundation_BindContext+0x659bc24>
10a0c050c: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c0510: f942c501    	ldr	x1, [x8, #0x588] ; footerViewModelForDataItem:
10a0c0514: aa1603e0    	mov	x0, x22
10a0c0518: aa1503e2    	mov	x2, x21
10a0c051c: 955e6bca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0520: aa1d03fd    	mov	x29, x29
10a0c0524: 955e6bcb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0528: aa0003f6    	mov	x22, x0
10a0c052c: f00b0748    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c0530: f9420d00    	ldr	x0, [x8, #0x418]
10a0c0534: b00afec8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c0538: f942c901    	ldr	x1, [x8, #0x590] ; heightForViewModel:inTableView:
10a0c053c: aa1603e2    	mov	x2, x22
10a0c0540: aa1303e3    	mov	x3, x19
10a0c0544: 955e6bc0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0548: 17fffeac    	b	0x10a0bfff8 <_Flutter_MMFoundation_BindContext+0x659bbdc>
10a0c054c: b00b0208    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
10a0c0550: f9454d01    	ldr	x1, [x8, #0xa98] ; floatValue
10a0c0554: aa1603e0    	mov	x0, x22
10a0c0558: 955e6bbb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c055c: 1e22c008    	fcvt	d8, s0
10a0c0560: 900b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c0564: f9403d1a    	ldr	x26, [x8, #0x78]
10a0c0568: f00b0588    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c056c: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c0570: aa1903e1    	mov	x1, x25
10a0c0574: 955e6bb4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0578: aa1d03fd    	mov	x29, x29
10a0c057c: 955e6bb5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c0580: aa0003f9    	mov	x25, x0
10a0c0584: 900b05a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c0588: f9404100    	ldr	x0, [x8, #0x80]
10a0c058c: aa1803e1    	mov	x1, x24
10a0c0590: 955e6bad    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c0594: aa0003e2    	mov	x2, x0
10a0c0598: aa1903e0    	mov	x0, x25
10a0c059c: f9400be1    	ldr	x1, [sp, #0x10]
10a0c05a0: 955e6ba9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c05a4: aa1d03fd    	mov	x29, x29
10a0c05a8: 955e6baa    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c05ac: aa0003f7    	mov	x23, x0
10a0c05b0: f00aebc8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10a0c05b4: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10a0c05b8: 900a4822    	adrp	x2, 0x11e9c4000 <dyld_stub_binder+0x11e9c4000>
10a0c05bc: 9117a042    	add	x2, x2, #0x5e8
10a0c05c0: 900a3643    	adrp	x3, 0x11e788000 <dyld_stub_binder+0x11e788000>
10a0c05c4: 910f2063    	add	x3, x3, #0x3c8
10a0c05c8: 955e6b9f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c05cc: aa1d03fd    	mov	x29, x29
10a0c05d0: 955e6ba0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c05d4: aa0003f8    	mov	x24, x0
10a0c05d8: 900aebe8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0c05dc: f9400101    	ldr	x1, [x8]
10a0c05e0: aa1a03e0    	mov	x0, x26
10a0c05e4: aa1803e2    	mov	x2, x24
10a0c05e8: 955e6b97    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c05ec: 1e682808    	fadd	d8, d0, d8
10a0c05f0: aa1803e0    	mov	x0, x24
10a0c05f4: 955e6b9a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c05f8: aa1703e0    	mov	x0, x23
10a0c05fc: 955e6b98    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0600: aa1903e0    	mov	x0, x25
10a0c0604: 955e6b96    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c0608: 17ffff5f    	b	0x10a0c0384 <_Flutter_MMFoundation_BindContext+0x659bf68>
