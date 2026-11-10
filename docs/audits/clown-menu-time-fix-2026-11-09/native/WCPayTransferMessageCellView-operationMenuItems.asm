
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
109e76780: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
109e76784: a9017bfd    	stp	x29, x30, [sp, #0x10]
109e76788: 910043fd    	add	x29, sp, #0x10
109e7678c: aa0003f3    	mov	x19, x0
109e76790: 900a74e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
109e76794: f9432d00    	ldr	x0, [x8, #0x658]
109e76798: 9567a4fc    	bl	0x10f85fb88 <_GetBoxIamBizTLRecFeedsDataUtil+0xdec6c>
109e7679c: aa0003f4    	mov	x20, x0
109e767a0: 900a5ac8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
109e767a4: f9421101    	ldr	x1, [x8, #0x420]
109e767a8: aa1303e0    	mov	x0, x19
109e767ac: aa1403e2    	mov	x2, x20
109e767b0: 9567a50e    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e767b4: aa1403e0    	mov	x0, x20
109e767b8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
109e767bc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
109e767c0: 1567a4f7    	b	0x10f85fb9c <_GetBoxIamBizTLRecFeedsDataUtil+0xdec80>
