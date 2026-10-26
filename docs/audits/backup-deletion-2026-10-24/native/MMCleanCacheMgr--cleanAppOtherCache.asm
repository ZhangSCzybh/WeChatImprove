
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1028fddd4: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1028fddd8: a90167fa    	stp	x26, x25, [sp, #0x10]
1028fdddc: a9025ff8    	stp	x24, x23, [sp, #0x20]
1028fdde0: a90357f6    	stp	x22, x21, [sp, #0x30]
1028fdde4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1028fdde8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1028fddec: 910143fd    	add	x29, sp, #0x50
1028fddf0: b00f19c8    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1028fddf4: 52800029    	mov	w9, #0x1                ; =1
1028fddf8: 3928c909    	strb	w9, [x8, #0xa32]
1028fddfc: b00ec3c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1028fde00: f943bd00    	ldr	x0, [x8, #0x778]
1028fde04: b00ead88    	adrp	x8, 0x11feae000 <dyld_stub_binder+0x11feae000>
1028fde08: f942ad13    	ldr	x19, [x8, #0x558] ; cleanCacheMgrMakeToClean
1028fde0c: aa1303e1    	mov	x1, x19
1028fde10: 954ca4cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde14: aa0003f4    	mov	x20, x0
1028fde18: 900ec3c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1028fde1c: f941d100    	ldr	x0, [x8, #0x3a0]
1028fde20: aa1303e1    	mov	x1, x19
1028fde24: 954ca4c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde28: 8b140015    	add	x21, x0, x20
1028fde2c: b00ec3c8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1028fde30: f943d900    	ldr	x0, [x8, #0x7b0]
1028fde34: aa1303e1    	mov	x1, x19
1028fde38: 954ca4c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde3c: aa0003f4    	mov	x20, x0
1028fde40: d00ec3a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1028fde44: f9462900    	ldr	x0, [x8, #0xc50]
1028fde48: aa1303e1    	mov	x1, x19
1028fde4c: 954ca4bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde50: 8b000288    	add	x8, x20, x0
1028fde54: 8b0802b5    	add	x21, x21, x8
1028fde58: f00ec3a8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1028fde5c: f9403100    	ldr	x0, [x8, #0x60]
1028fde60: aa1303e1    	mov	x1, x19
1028fde64: 954ca4b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde68: aa0003f4    	mov	x20, x0
1028fde6c: d00ec448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1028fde70: f9436100    	ldr	x0, [x8, #0x6c0]
1028fde74: aa1303e1    	mov	x1, x19
1028fde78: 954ca4b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde7c: 8b000294    	add	x20, x20, x0
1028fde80: f00ec428    	adrp	x8, 0x120184000 <dyld_stub_binder+0x120184000>
1028fde84: f941e500    	ldr	x0, [x8, #0x3c8]
1028fde88: aa1303e1    	mov	x1, x19
1028fde8c: 954ca4ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fde90: 8b000288    	add	x8, x20, x0
1028fde94: 8b0802b5    	add	x21, x21, x8
1028fde98: d00ec448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1028fde9c: f9436500    	ldr	x0, [x8, #0x6c8]
1028fdea0: aa1303e1    	mov	x1, x19
1028fdea4: 954ca4a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdea8: aa0003f4    	mov	x20, x0
1028fdeac: f00ec428    	adrp	x8, 0x120184000 <dyld_stub_binder+0x120184000>
1028fdeb0: f941a500    	ldr	x0, [x8, #0x348]
1028fdeb4: aa1303e1    	mov	x1, x19
1028fdeb8: 954ca4a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdebc: 8b000294    	add	x20, x20, x0
1028fdec0: f00ec408    	adrp	x8, 0x120180000 <dyld_stub_binder+0x120180000>
1028fdec4: f9470500    	ldr	x0, [x8, #0xe08]
1028fdec8: aa1303e1    	mov	x1, x19
1028fdecc: 954ca49c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fded0: 8b000294    	add	x20, x20, x0
1028fded4: d00ec408    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
1028fded8: f9460500    	ldr	x0, [x8, #0xc08]
1028fdedc: aa1303e1    	mov	x1, x19
1028fdee0: 954ca497    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdee4: 8b000288    	add	x8, x20, x0
1028fdee8: 8b0802b5    	add	x21, x21, x8
1028fdeec: d00ec448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1028fdef0: f9436900    	ldr	x0, [x8, #0x6d0]
1028fdef4: aa1303e1    	mov	x1, x19
1028fdef8: 954ca491    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdefc: aa0003f4    	mov	x20, x0
1028fdf00: d00ec456    	adrp	x22, 0x120187000 <dyld_stub_binder+0x120187000>
1028fdf04: f942b2c0    	ldr	x0, [x22, #0x560]
1028fdf08: 900eafc8    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
1028fdf0c: f9454101    	ldr	x1, [x8, #0xa80] ; p_cleanCacheAudio
1028fdf10: 954ca48b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdf14: 8b000294    	add	x20, x20, x0
1028fdf18: 900ec3c8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1028fdf1c: f9410100    	ldr	x0, [x8, #0x200] ; п6
1028fdf20: aa1303e1    	mov	x1, x19
1028fdf24: 954ca486    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdf28: 8b000294    	add	x20, x20, x0
1028fdf2c: f942b2c0    	ldr	x0, [x22, #0x560]
1028fdf30: 900eafc8    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
1028fdf34: f9454501    	ldr	x1, [x8, #0xa88] ; p_cleanAppGroupTmpPath
1028fdf38: 954ca481    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdf3c: 8b000294    	add	x20, x20, x0
1028fdf40: b00ec408    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
1028fdf44: f944f100    	ldr	x0, [x8, #0x9e0]
1028fdf48: aa1303e1    	mov	x1, x19
1028fdf4c: 954ca47c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdf50: 8b000288    	add	x8, x20, x0
1028fdf54: 8b0802ba    	add	x26, x21, x8
1028fdf58: d00ec3bb    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1028fdf5c: f945eb60    	ldr	x0, [x27, #0xbd0]
1028fdf60: f00ec008    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1028fdf64: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
1028fdf68: aa1403e1    	mov	x1, x20
1028fdf6c: 954ca474    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdf70: aa1d03fd    	mov	x29, x29
1028fdf74: 954ca475    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fdf78: aa0003f5    	mov	x21, x0
1028fdf7c: d00ec448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1028fdf80: f9436d00    	ldr	x0, [x8, #0x6d8]
1028fdf84: d00ec008    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1028fdf88: f947ad16    	ldr	x22, [x8, #0xf58] ; class
1028fdf8c: aa1603e1    	mov	x1, x22
1028fdf90: 954ca46b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdf94: aa0003e2    	mov	x2, x0
1028fdf98: 900ea9e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1028fdf9c: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
1028fdfa0: aa1503e0    	mov	x0, x21
1028fdfa4: aa1703e1    	mov	x1, x23
1028fdfa8: 954ca465    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdfac: aa1d03fd    	mov	x29, x29
1028fdfb0: 954ca466    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fdfb4: aa0003f8    	mov	x24, x0
1028fdfb8: b00eade8    	adrp	x8, 0x11feba000 <dyld_stub_binder+0x11feba000>
1028fdfbc: f9443d01    	ldr	x1, [x8, #0x878] ; cleanDSMCache
1028fdfc0: 954ca45f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdfc4: aa0003f9    	mov	x25, x0
1028fdfc8: aa1803e0    	mov	x0, x24
1028fdfcc: 954ca462    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fdfd0: aa1503e0    	mov	x0, x21
1028fdfd4: 954ca460    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fdfd8: d00ec448    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
1028fdfdc: f9437100    	ldr	x0, [x8, #0x6e0]
1028fdfe0: 900eafc8    	adrp	x8, 0x11fef5000 <dyld_stub_binder+0x11fef5000>
1028fdfe4: f9454901    	ldr	x1, [x8, #0xa90] ; cleanAttachmentCache
1028fdfe8: 954ca455    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdfec: 8b000338    	add	x24, x25, x0
1028fdff0: f945eb60    	ldr	x0, [x27, #0xbd0]
1028fdff4: aa1403e1    	mov	x1, x20
1028fdff8: 954ca451    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fdffc: aa1d03fd    	mov	x29, x29
1028fe000: 954ca452    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe004: aa0003f4    	mov	x20, x0
1028fe008: d00ec408    	adrp	x8, 0x120180000 <dyld_stub_binder+0x120180000>
1028fe00c: f943dd00    	ldr	x0, [x8, #0x7b8]
1028fe010: aa1603e1    	mov	x1, x22
1028fe014: 954ca44a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe018: aa0003e2    	mov	x2, x0
1028fe01c: aa1403e0    	mov	x0, x20
1028fe020: aa1703e1    	mov	x1, x23
1028fe024: 954ca446    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe028: aa1d03fd    	mov	x29, x29
1028fe02c: 954ca447    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1028fe030: aa0003f5    	mov	x21, x0
1028fe034: aa1303e1    	mov	x1, x19
1028fe038: 954ca441    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1028fe03c: 8b000313    	add	x19, x24, x0
1028fe040: aa1503e0    	mov	x0, x21
1028fe044: 954ca444    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe048: aa1403e0    	mov	x0, x20
1028fe04c: 954ca442    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1028fe050: 8b130340    	add	x0, x26, x19
1028fe054: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1028fe058: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1028fe05c: a94357f6    	ldp	x22, x21, [sp, #0x30]
1028fe060: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1028fe064: a94167fa    	ldp	x26, x25, [sp, #0x10]
1028fe068: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1028fe06c: d65f03c0    	ret
