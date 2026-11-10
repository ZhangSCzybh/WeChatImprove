
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
109e737ec: d10143ff    	sub	sp, sp, #0x50
109e737f0: a9015ff8    	stp	x24, x23, [sp, #0x10]
109e737f4: a90257f6    	stp	x22, x21, [sp, #0x20]
109e737f8: a9034ff4    	stp	x20, x19, [sp, #0x30]
109e737fc: a9047bfd    	stp	x29, x30, [sp, #0x40]
109e73800: 910103fd    	add	x29, sp, #0x40
109e73804: aa0003f3    	mov	x19, x0
109e73808: 900ac788    	adrp	x8, 0x11f763000 <dyld_stub_binder+0x11f763000>
109e7380c: 52800029    	mov	w9, #0x1                ; =1
109e73810: 392f5d09    	strb	w9, [x8, #0xbd7]
109e73814: 900a7808    	adrp	x8, 0x11ed73000 <dyld_stub_binder+0x11ed73000>
109e73818: f9410908    	ldr	x8, [x8, #0x210]
109e7381c: a90023e0    	stp	x0, x8, [sp]
109e73820: d00a5b28    	adrp	x8, 0x11e9d9000 <dyld_stub_binder+0x11e9d9000>
109e73824: f9401101    	ldr	x1, [x8, #0x20]
109e73828: 910003e0    	mov	x0, sp
109e7382c: 9567b0f0    	bl	0x10f85fbec <_GetBoxIamBizTLRecFeedsDataUtil+0xdecd0>
109e73830: f00a74e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
109e73834: f943f115    	ldr	x21, [x8, #0x7e0]
109e73838: f00a74e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
109e7383c: f9461d16    	ldr	x22, [x8, #0xc38]
109e73840: f00a74e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
109e73844: f943c100    	ldr	x0, [x8, #0x780]
109e73848: d00a5aa8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
109e7384c: f9440101    	ldr	x1, [x8, #0x800]
109e73850: 9567b0e6    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e73854: aa1d03fd    	mov	x29, x29
109e73858: 9567b0ed    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e7385c: aa0003f4    	mov	x20, x0
109e73860: f00a74e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
109e73864: f9462100    	ldr	x0, [x8, #0xc40]
109e73868: f00a7188    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
109e7386c: f9428501    	ldr	x1, [x8, #0x508]
109e73870: 9567b0de    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e73874: aa0003e2    	mov	x2, x0
109e73878: d00a5aa8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
109e7387c: f9452101    	ldr	x1, [x8, #0xa40]
109e73880: aa1403e0    	mov	x0, x20
109e73884: 9567b0d9    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e73888: aa1d03fd    	mov	x29, x29
109e7388c: 9567b0e0    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e73890: aa0003f7    	mov	x23, x0
109e73894: 900a5ac8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
109e73898: f9477501    	ldr	x1, [x8, #0xee8]
109e7389c: 900989a2    	adrp	x2, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
109e738a0: 9132e042    	add	x2, x2, #0xcb8
109e738a4: 900989a3    	adrp	x3, 0x11cfa7000 <dyld_stub_binder+0x11cfa7000>
109e738a8: 9130e063    	add	x3, x3, #0xc38
109e738ac: 9567b0cf    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e738b0: aa1d03fd    	mov	x29, x29
109e738b4: 9567b0d6    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e738b8: aa0003f8    	mov	x24, x0
109e738bc: 900a5ac8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
109e738c0: f9477901    	ldr	x1, [x8, #0xef0]
109e738c4: aa1603e0    	mov	x0, x22
109e738c8: aa1803e2    	mov	x2, x24
109e738cc: 9567b0c7    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e738d0: b00a5be8    	adrp	x8, 0x11e9f0000 <dyld_stub_binder+0x11e9f0000>
109e738d4: f944a101    	ldr	x1, [x8, #0x940]
109e738d8: aa1503e0    	mov	x0, x21
109e738dc: 9567b0c3    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e738e0: aa1d03fd    	mov	x29, x29
109e738e4: 9567b0ca    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e738e8: aa0003f5    	mov	x21, x0
109e738ec: f00a7ca8    	adrp	x8, 0x11ee0a000 <dyld_stub_binder+0x11ee0a000>
109e738f0: 912be108    	add	x8, x8, #0xaf8
109e738f4: b9800108    	ldrsw	x8, [x8]
109e738f8: f8686a60    	ldr	x0, [x19, x8]
109e738fc: 900a71c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
109e73900: f9450501    	ldr	x1, [x8, #0xa08]
109e73904: aa1503e2    	mov	x2, x21
109e73908: 9567b0b8    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e7390c: aa1503e0    	mov	x0, x21
109e73910: 9567b0ba    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e73914: aa1803e0    	mov	x0, x24
109e73918: 9567b0b8    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e7391c: aa1703e0    	mov	x0, x23
109e73920: 9567b0b6    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e73924: aa1403e0    	mov	x0, x20
109e73928: 9567b0b4    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e7392c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109e73930: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109e73934: a94257f6    	ldp	x22, x21, [sp, #0x20]
109e73938: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109e7393c: 910143ff    	add	sp, sp, #0x50
109e73940: d65f03c0    	ret
