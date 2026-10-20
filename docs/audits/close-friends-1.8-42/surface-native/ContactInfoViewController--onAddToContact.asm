
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fbecc4: d10203ff    	sub	sp, sp, #0x80
100fbecc8: a90367fa    	stp	x26, x25, [sp, #0x30]
100fbeccc: a9045ff8    	stp	x24, x23, [sp, #0x40]
100fbecd0: a90557f6    	stp	x22, x21, [sp, #0x50]
100fbecd4: a9064ff4    	stp	x20, x19, [sp, #0x60]
100fbecd8: a9077bfd    	stp	x29, x30, [sp, #0x70]
100fbecdc: 9101c3fd    	add	x29, sp, #0x70
100fbece0: aa0003f3    	mov	x19, x0
100fbece4: b00e3188    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100fbece8: f9405908    	ldr	x8, [x8, #0xb0]
100fbecec: f9400108    	ldr	x8, [x8]
100fbecf0: f90017e8    	str	x8, [sp, #0x28]
100fbecf4: d00fe388    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100fbecf8: 52800029    	mov	w9, #0x1                ; =1
100fbecfc: 392ecd09    	strb	w9, [x8, #0xbb3]
100fbed00: 900f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbed04: f945f501    	ldr	x1, [x8, #0xbe8] ; statBanner
100fbed08: 95b1a10d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbed0c: 900f8de8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
100fbed10: f9473100    	ldr	x0, [x8, #0xe60]
100fbed14: 900f7488    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
100fbed18: f943c101    	ldr	x1, [x8, #0x780] ; Instance
100fbed1c: 95b1a108    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbed20: aa1d03fd    	mov	x29, x29
100fbed24: 95b1a109    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbed28: aa0003f6    	mov	x22, x0
100fbed2c: b00f73e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fbed30: f947d914    	ldr	x20, [x8, #0xfb0] ; m_contact
100fbed34: aa1303e0    	mov	x0, x19
100fbed38: aa1403e1    	mov	x1, x20
100fbed3c: 95b1a100    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbed40: aa1d03fd    	mov	x29, x29
100fbed44: 95b1a101    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbed48: aa0003f7    	mov	x23, x0
100fbed4c: b00f73e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100fbed50: f9434d15    	ldr	x21, [x8, #0x698] ; m_nsUsrName
100fbed54: aa1503e1    	mov	x1, x21
100fbed58: 95b1a0f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbed5c: aa1d03fd    	mov	x29, x29
100fbed60: 95b1a0fa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbed64: aa0003f8    	mov	x24, x0
100fbed68: d00ea708    	adrp	x8, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
100fbed6c: 91132108    	add	x8, x8, #0x4c8
100fbed70: d00eac29    	adrp	x9, 0x11e544000 <dyld_stub_binder+0x11e544000>
100fbed74: 911ba129    	add	x9, x9, #0x6e8
100fbed78: a901a7e8    	stp	x8, x9, [sp, #0x18]
100fbed7c: b00f8da8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fbed80: f9457500    	ldr	x0, [x8, #0xae8]
100fbed84: f00f8a08    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
100fbed88: f9402901    	ldr	x1, [x8, #0x50] ; dictionaryWithObjects:forKeys:count:
100fbed8c: 910083e2    	add	x2, sp, #0x20
100fbed90: 910063e3    	add	x3, sp, #0x18
100fbed94: 52800024    	mov	w4, #0x1                ; =1
100fbed98: 95b1a0e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbed9c: aa1d03fd    	mov	x29, x29
100fbeda0: 95b1a0ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbeda4: aa0003f9    	mov	x25, x0
100fbeda8: 900f7608    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
100fbedac: f9429101    	ldr	x1, [x8, #0x520] ; tryReportChatBotEventWithUserName:eventId:target:params:logId:
100fbedb0: d00ea703    	adrp	x3, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
100fbedb4: 9112a063    	add	x3, x3, #0x4a8
100fbedb8: aa1603e0    	mov	x0, x22
100fbedbc: aa1803e2    	mov	x2, x24
100fbedc0: aa1303e4    	mov	x4, x19
100fbedc4: aa1903e5    	mov	x5, x25
100fbedc8: 52909a86    	mov	w6, #0x84d4             ; =34004
100fbedcc: 95b1a0dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbedd0: aa1903e0    	mov	x0, x25
100fbedd4: 95b1a0e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbedd8: aa1803e0    	mov	x0, x24
100fbeddc: 95b1a0de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbede0: aa1703e0    	mov	x0, x23
100fbede4: 95b1a0dc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbede8: aa1603e0    	mov	x0, x22
100fbedec: 95b1a0da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbedf0: 900f7648    	adrp	x8, 0x11fe86000 <dyld_stub_binder+0x11fe86000>
100fbedf4: f945d916    	ldr	x22, [x8, #0xbb0] ; m_uiAddFriendStatScene
100fbedf8: aa1303e0    	mov	x0, x19
100fbedfc: aa1603e1    	mov	x1, x22
100fbee00: 95b1a0cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbee04: b40004e0    	cbz	x0, 0x100fbeea0 <__text+0xfb6ea0>
100fbee08: b00f8da8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fbee0c: f9454517    	ldr	x23, [x8, #0xa88]
100fbee10: aa1303e0    	mov	x0, x19
100fbee14: aa1603e1    	mov	x1, x22
100fbee18: 95b1a0c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbee1c: aa0003f6    	mov	x22, x0
100fbee20: aa1303e0    	mov	x0, x19
100fbee24: aa1403e1    	mov	x1, x20
100fbee28: 95b1a0c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbee2c: aa1d03fd    	mov	x29, x29
100fbee30: 95b1a0c6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbee34: aa0003f3    	mov	x19, x0
100fbee38: aa1503e1    	mov	x1, x21
100fbee3c: 95b1a0c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbee40: aa1d03fd    	mov	x29, x29
100fbee44: 95b1a0c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbee48: aa0003f4    	mov	x20, x0
100fbee4c: 900f8a68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100fbee50: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
100fbee54: a90003f6    	stp	x22, x0, [sp]
100fbee58: d00eac22    	adrp	x2, 0x11e544000 <dyld_stub_binder+0x11e544000>
100fbee5c: 911c2042    	add	x2, x2, #0x708
100fbee60: aa1703e0    	mov	x0, x23
100fbee64: 95b1a0b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fbee68: aa1d03fd    	mov	x29, x29
100fbee6c: 95b1a0b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fbee70: aa0003f5    	mov	x21, x0
100fbee74: aa1403e0    	mov	x0, x20
100fbee78: 95b1a0b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbee7c: aa1303e0    	mov	x0, x19
100fbee80: 95b1a0b5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbee84: 52857fe0    	mov	w0, #0x2bff             ; =11263
100fbee88: aa1503e1    	mov	x1, x21
100fbee8c: 52800002    	mov	w2, #0x0                ; =0
100fbee90: 52800003    	mov	w3, #0x0                ; =0
100fbee94: 944ab793    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
100fbee98: aa1503e0    	mov	x0, x21
100fbee9c: 95b1a0ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fbeea0: f94017e8    	ldr	x8, [sp, #0x28]
100fbeea4: b00e3189    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100fbeea8: f9405929    	ldr	x9, [x9, #0xb0]
100fbeeac: f9400129    	ldr	x9, [x9]
100fbeeb0: eb08013f    	cmp	x9, x8
100fbeeb4: 54000101    	b.ne	0x100fbeed4 <__text+0xfb6ed4>
100fbeeb8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100fbeebc: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100fbeec0: a94557f6    	ldp	x22, x21, [sp, #0x50]
100fbeec4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100fbeec8: a94367fa    	ldp	x26, x25, [sp, #0x30]
100fbeecc: 910203ff    	add	sp, sp, #0x80
100fbeed0: d65f03c0    	ret
100fbeed4: 95b1a0a8    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
