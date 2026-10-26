
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029b6b20: d10183ff    	sub	sp, sp, #0x60
1029b6b24: a9025ff8    	stp	x24, x23, [sp, #0x20]
1029b6b28: a90357f6    	stp	x22, x21, [sp, #0x30]
1029b6b2c: a9044ff4    	stp	x20, x19, [sp, #0x40]
1029b6b30: a9057bfd    	stp	x29, x30, [sp, #0x50]
1029b6b34: 910143fd    	add	x29, sp, #0x50
1029b6b38: aa0203f3    	mov	x19, x2
1029b6b3c: aa0003f5    	mov	x21, x0
1029b6b40: 900f1408    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029b6b44: 52800029    	mov	w9, #0x1                ; =1
1029b6b48: 39348909    	strb	w9, [x8, #0xd22]
1029b6b4c: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6b50: f9441101    	ldr	x1, [x8, #0x820] ; ifForceWholeWechatScanForDebug
1029b6b54: 9549c17a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6b58: 34000280    	cbz	w0, 0x1029b6ba8 <_Flutter_Image_provideRelativePathByUrl+0xdc3a58>
1029b6b5c: b00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b6b60: f9453500    	ldr	x0, [x8, #0xa68]
1029b6b64: f00ea408    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b6b68: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b6b6c: 900de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b6b70: 9130a108    	add	x8, x8, #0xc28
1029b6b74: f90003e8    	str	x8, [sp]
1029b6b78: d00c5e23    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b6b7c: 9125d063    	add	x3, x3, #0x974
1029b6b80: b00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b6b84: 9134f8a5    	add	x5, x5, #0xd3e
1029b6b88: d00c5e67    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b6b8c: 9131f8e7    	add	x7, x7, #0xc7e
1029b6b90: 52800042    	mov	w2, #0x2                ; =2
1029b6b94: 52800004    	mov	w4, #0x0                ; =0
1029b6b98: 528070a6    	mov	w6, #0x385              ; =901
1029b6b9c: 9549c168    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6ba0: 52800000    	mov	w0, #0x0                ; =0
1029b6ba4: 14000055    	b	0x1029b6cf8 <_Flutter_Image_provideRelativePathByUrl+0xdc3ba8>
1029b6ba8: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6bac: f9452d01    	ldr	x1, [x8, #0xa58] ; shouldToScan
1029b6bb0: aa1503e0    	mov	x0, x21
1029b6bb4: 9549c162    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6bb8: 340002e0    	cbz	w0, 0x1029b6c14 <_Flutter_Image_provideRelativePathByUrl+0xdc3ac4>
1029b6bbc: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6bc0: f943dd01    	ldr	x1, [x8, #0x7b8] ; setShouldToScan:
1029b6bc4: aa1503e0    	mov	x0, x21
1029b6bc8: 52800002    	mov	w2, #0x0                ; =0
1029b6bcc: 9549c15c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6bd0: b00ebde8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029b6bd4: f9453500    	ldr	x0, [x8, #0xa68]
1029b6bd8: f00ea408    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b6bdc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b6be0: 900de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b6be4: 91312108    	add	x8, x8, #0xc48
1029b6be8: f90003e8    	str	x8, [sp]
1029b6bec: d00c5e23    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b6bf0: 9125d063    	add	x3, x3, #0x974
1029b6bf4: b00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b6bf8: 9134f8a5    	add	x5, x5, #0xd3e
1029b6bfc: d00c5e67    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b6c00: 9131f8e7    	add	x7, x7, #0xc7e
1029b6c04: 52800042    	mov	w2, #0x2                ; =2
1029b6c08: 52800004    	mov	w4, #0x0                ; =0
1029b6c0c: 52807166    	mov	w6, #0x38b              ; =907
1029b6c10: 14000038    	b	0x1029b6cf0 <_Flutter_Image_provideRelativePathByUrl+0xdc3ba0>
1029b6c14: b00ebe28    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1029b6c18: f9425500    	ldr	x0, [x8, #0x4a8]
1029b6c1c: d00ea9e8    	adrp	x8, 0x11fef4000 <dyld_stub_binder+0x11fef4000>
1029b6c20: f944f901    	ldr	x1, [x8, #0x9f0] ; secondsSince1970
1029b6c24: 9549c146    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6c28: aa0003f4    	mov	x20, x0
1029b6c2c: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6c30: f9444501    	ldr	x1, [x8, #0x888] ; diskUsageStatus
1029b6c34: aa1503e0    	mov	x0, x21
1029b6c38: 9549c141    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6c3c: aa1d03fd    	mov	x29, x29
1029b6c40: 9549c142    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b6c44: aa0003f6    	mov	x22, x0
1029b6c48: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6c4c: f9453101    	ldr	x1, [x8, #0xa60] ; m_lastScanFinishTime
1029b6c50: 9549c13b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6c54: aa0003f7    	mov	x23, x0
1029b6c58: 2a0003f8    	mov	w24, w0
1029b6c5c: aa1603e0    	mov	x0, x22
1029b6c60: 9549c13d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b6c64: eb37429f    	cmp	x20, w23, uxtw
1029b6c68: 9a9833f6    	csel	x22, xzr, x24, lo
1029b6c6c: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6c70: f9444101    	ldr	x1, [x8, #0x880] ; configHandler
1029b6c74: aa1503e0    	mov	x0, x21
1029b6c78: 9549c131    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6c7c: aa1d03fd    	mov	x29, x29
1029b6c80: 9549c132    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029b6c84: aa0003f5    	mov	x21, x0
1029b6c88: d00eaa08    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029b6c8c: f9429d01    	ldr	x1, [x8, #0x538] ; m_timeIntervalBetweenEachScanFinish
1029b6c90: 9549c12b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6c94: 1ad30813    	udiv	w19, w0, w19
1029b6c98: aa1503e0    	mov	x0, x21
1029b6c9c: 9549c12e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029b6ca0: cb160288    	sub	x8, x20, x22
1029b6ca4: b00ebde9    	adrp	x9, 0x120173000 <dyld_stub_binder+0x120173000>
1029b6ca8: f9453520    	ldr	x0, [x9, #0xa68]
1029b6cac: f00ea409    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029b6cb0: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029b6cb4: eb13011f    	cmp	x8, x19
1029b6cb8: 540002c9    	b.ls	0x1029b6d10 <_Flutter_Image_provideRelativePathByUrl+0xdc3bc0>
1029b6cbc: a9014ff6    	stp	x22, x19, [sp, #0x10]
1029b6cc0: 900de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b6cc4: 9131a108    	add	x8, x8, #0xc68
1029b6cc8: a90053e8    	stp	x8, x20, [sp]
1029b6ccc: d00c5e23    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b6cd0: 9125d063    	add	x3, x3, #0x974
1029b6cd4: b00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b6cd8: 9134f8a5    	add	x5, x5, #0xd3e
1029b6cdc: d00c5e67    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b6ce0: 9131f8e7    	add	x7, x7, #0xc7e
1029b6ce4: 52800042    	mov	w2, #0x2                ; =2
1029b6ce8: 52800004    	mov	w4, #0x0                ; =0
1029b6cec: 528073a6    	mov	w6, #0x39d              ; =925
1029b6cf0: 9549c113    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029b6cf4: 52800020    	mov	w0, #0x1                ; =1
1029b6cf8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1029b6cfc: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1029b6d00: a94357f6    	ldp	x22, x21, [sp, #0x30]
1029b6d04: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1029b6d08: 910183ff    	add	sp, sp, #0x60
1029b6d0c: d65f03c0    	ret
1029b6d10: a9014ff6    	stp	x22, x19, [sp, #0x10]
1029b6d14: 900de608    	adrp	x8, 0x11e676000 <dyld_stub_binder+0x11e676000>
1029b6d18: 91322108    	add	x8, x8, #0xc88
1029b6d1c: a90053e8    	stp	x8, x20, [sp]
1029b6d20: d00c5e23    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029b6d24: 9125d063    	add	x3, x3, #0x974
1029b6d28: b00c5e65    	adrp	x5, 0x11b583000 <dyld_stub_binder+0x11b583000>
1029b6d2c: 9134f8a5    	add	x5, x5, #0xd3e
1029b6d30: d00c5e67    	adrp	x7, 0x11b584000 <dyld_stub_binder+0x11b584000>
1029b6d34: 9131f8e7    	add	x7, x7, #0xc7e
1029b6d38: 52800042    	mov	w2, #0x2                ; =2
1029b6d3c: 52800004    	mov	w4, #0x0                ; =0
1029b6d40: 52807486    	mov	w6, #0x3a4              ; =932
1029b6d44: 17ffff96    	b	0x1029b6b9c <_Flutter_Image_provideRelativePathByUrl+0xdc3a4c>
