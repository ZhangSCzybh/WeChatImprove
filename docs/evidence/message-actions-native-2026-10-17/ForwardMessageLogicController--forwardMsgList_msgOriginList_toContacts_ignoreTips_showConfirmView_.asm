
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c2d558: f00f1468    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c2d55c: f9455101    	ldr	x1, [x8, #0xaa0] ; forwardMsgList:msgOriginList:toContacts:ignoreTips:showConfirmView:batchRevokeScene:
101c2d560: 52800027    	mov	w7, #0x1                ; =1
101c2d564: 157fe6f6    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>