
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f99c74: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100f99c78: a9014ff4    	stp	x20, x19, [sp, #0x10]
100f99c7c: a9027bfd    	stp	x29, x30, [sp, #0x20]
100f99c80: 910083fd    	add	x29, sp, #0x20
100f99c84: aa0203f3    	mov	x19, x2
100f99c88: aa0003f4    	mov	x20, x0
100f99c8c: aa0203e0    	mov	x0, x2
100f99c90: 95b237f9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100f99c94: 52801920    	mov	w0, #0xc9               ; =201
100f99c98: 52800161    	mov	w1, #0xb                ; =11
100f99c9c: 52800022    	mov	w2, #0x1                ; =1
100f99ca0: 52800003    	mov	w3, #0x0                ; =0
100f99ca4: 52800004    	mov	w4, #0x0                ; =0
100f99ca8: 94454159    	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
100f99cac: b00eebc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f99cb0: f945c515    	ldr	x21, [x8, #0xb88] ; class ChatRoomUtils
100f99cb4: f00eef68    	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f99cb8: b98fb908    	ldrsw	x8, [x8, #0xfb8]
100f99cbc: f8686a96    	ldr	x22, [x20, x8]
100f99cc0: b00ed288    	adrp	x8, 0x11e9ea000 <dyld_stub_binder+0x11e9ea000>
100f99cc4: f9458901    	ldr	x1, [x8, #0xb10] ; selector m_searchScene
100f99cc8: aa1403e0    	mov	x0, x20
100f99ccc: 95b237e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99cd0: aa0003e6    	mov	x6, x0
100f99cd4: b00ed3e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f99cd8: f943d501    	ldr	x1, [x8, #0x7a8] ; selector openContactProfile:ofChatRoomContact:inViewController:delegate:searchScene:
100f99cdc: aa1503e0    	mov	x0, x21
100f99ce0: aa1303e2    	mov	x2, x19
100f99ce4: aa1603e3    	mov	x3, x22
100f99ce8: aa1403e4    	mov	x4, x20
100f99cec: aa1403e5    	mov	x5, x20
100f99cf0: 95b237dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f99cf4: aa1303e0    	mov	x0, x19
100f99cf8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100f99cfc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100f99d00: a8c357f6    	ldp	x22, x21, [sp], #0x30
100f99d04: 15b237db    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
