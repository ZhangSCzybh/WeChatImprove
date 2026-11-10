
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
11593d228: d10183ff    	sub	sp, sp, #0x60
11593d22c: a90167fa    	stp	x26, x25, [sp, #0x10]
11593d230: a9025ff8    	stp	x24, x23, [sp, #0x20]
11593d234: a90357f6    	stp	x22, x21, [sp, #0x30]
11593d238: a9044ff4    	stp	x20, x19, [sp, #0x40]
11593d23c: a9057bfd    	stp	x29, x30, [sp, #0x50]
11593d240: 910143fd    	add	x29, sp, #0x50
11593d244: aa0003f4    	mov	x20, x0
11593d248: d004a7a8    	adrp	x8, 0x11ee33000 <dyld_stub_binder+0x11ee33000>
11593d24c: b98f7d16    	ldrsw	x22, [x8, #0xf7c]
11593d250: 52800028    	mov	w8, #0x1                ; =1
11593d254: 38366808    	strb	w8, [x0, x22]
11593d258: d0048548    	adrp	x8, 0x11e9e7000 <dyld_stub_binder+0x11e9e7000>
11593d25c: f945e915    	ldr	x21, [x8, #0xbd0]
11593d260: aa1503e1    	mov	x1, x21
11593d264: 94547cb8    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d268: aa1d03fd    	mov	x29, x29
11593d26c: 94547ce3    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593d270: aa0003f3    	mov	x19, x0
11593d274: b004a1e8    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
11593d278: f9438108    	ldr	x8, [x8, #0x700]
11593d27c: a90023f4    	stp	x20, x8, [sp]
11593d280: f0048468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
11593d284: f9414901    	ldr	x1, [x8, #0x290]
11593d288: 910003e0    	mov	x0, sp
11593d28c: 94547cb1    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
11593d290: d0048468    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
11593d294: f9456501    	ldr	x1, [x8, #0xac8]
11593d298: aa1403e0    	mov	x0, x20
11593d29c: 94547caa    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d2a0: b0049ac8    	adrp	x8, 0x11ec96000 <dyld_stub_binder+0x11ec96000>
11593d2a4: f946c501    	ldr	x1, [x8, #0xd88]
11593d2a8: aa1403e0    	mov	x0, x20
11593d2ac: 94547ca6    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d2b0: b0049ac8    	adrp	x8, 0x11ec96000 <dyld_stub_binder+0x11ec96000>
11593d2b4: f946c901    	ldr	x1, [x8, #0xd90]
11593d2b8: aa1403e0    	mov	x0, x20
11593d2bc: 94547ca2    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d2c0: 38366a9f    	strb	wzr, [x20, x22]
11593d2c4: 90048468    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
11593d2c8: f9459516    	ldr	x22, [x8, #0xb28]
11593d2cc: aa1403e0    	mov	x0, x20
11593d2d0: aa1603e1    	mov	x1, x22
11593d2d4: 94547c9c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d2d8: aa1d03fd    	mov	x29, x29
11593d2dc: 94547cc7    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593d2e0: b40003e0    	cbz	x0, 0x11593d35c <_O266DecReleaseOutputPicture+0x382ddf0>
11593d2e4: aa0003f8    	mov	x24, x0
11593d2e8: aa1403e0    	mov	x0, x20
11593d2ec: aa1603e1    	mov	x1, x22
11593d2f0: 94547c95    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d2f4: aa1d03fd    	mov	x29, x29
11593d2f8: 94547cc0    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593d2fc: aa0003f9    	mov	x25, x0
11593d300: b0049ac8    	adrp	x8, 0x11ec96000 <dyld_stub_binder+0x11ec96000>
11593d304: f946cd17    	ldr	x23, [x8, #0xd98]
11593d308: b0049b68    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
11593d30c: f9440501    	ldr	x1, [x8, #0x808]
11593d310: aa1703e2    	mov	x2, x23
11593d314: 94547c8c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d318: aa0003fa    	mov	x26, x0
11593d31c: aa1903e0    	mov	x0, x25
11593d320: 94547ca7    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593d324: aa1803e0    	mov	x0, x24
11593d328: 94547ca5    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593d32c: 3400019a    	cbz	w26, 0x11593d35c <_O266DecReleaseOutputPicture+0x382ddf0>
11593d330: aa1403e0    	mov	x0, x20
11593d334: aa1603e1    	mov	x1, x22
11593d338: 94547c83    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d33c: aa1d03fd    	mov	x29, x29
11593d340: 94547cae    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593d344: aa0003f6    	mov	x22, x0
11593d348: aa1703e1    	mov	x1, x23
11593d34c: aa1403e2    	mov	x2, x20
11593d350: 94547c7d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d354: aa1603e0    	mov	x0, x22
11593d358: 94547c99    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593d35c: b40003f3    	cbz	x19, 0x11593d3d8 <_O266DecReleaseOutputPicture+0x382de6c>
11593d360: aa1403e0    	mov	x0, x20
11593d364: aa1503e1    	mov	x1, x21
11593d368: 94547c77    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d36c: aa1d03fd    	mov	x29, x29
11593d370: 94547ca2    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593d374: b4000060    	cbz	x0, 0x11593d380 <_O266DecReleaseOutputPicture+0x382de14>
11593d378: 94547c91    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593d37c: 14000017    	b	0x11593d3d8 <_O266DecReleaseOutputPicture+0x382de6c>
11593d380: d0049ec8    	adrp	x8, 0x11ed17000 <dyld_stub_binder+0x11ed17000>
11593d384: f9409d00    	ldr	x0, [x8, #0x138]
11593d388: 90048488    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
11593d38c: f9411101    	ldr	x1, [x8, #0x220]
11593d390: 94547c6d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d394: aa1d03fd    	mov	x29, x29
11593d398: 94547c98    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593d39c: aa0003f5    	mov	x21, x0
11593d3a0: b00484a8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
11593d3a4: f942d101    	ldr	x1, [x8, #0x5a0]
11593d3a8: 94547c67    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d3ac: aa0003f6    	mov	x22, x0
11593d3b0: aa1503e0    	mov	x0, x21
11593d3b4: 94547c82    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593d3b8: 34000116    	cbz	w22, 0x11593d3d8 <_O266DecReleaseOutputPicture+0x382de6c>
11593d3bc: 90048508    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
11593d3c0: f944c501    	ldr	x1, [x8, #0x988]
11593d3c4: aa1403e0    	mov	x0, x20
11593d3c8: aa1303e2    	mov	x2, x19
11593d3cc: 52800003    	mov	w3, #0x0                ; =0
11593d3d0: d2800004    	mov	x4, #0x0                ; =0
11593d3d4: 94547c5c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593d3d8: aa1303e0    	mov	x0, x19
11593d3dc: 94547c78    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593d3e0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
11593d3e4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
11593d3e8: a94357f6    	ldp	x22, x21, [sp, #0x30]
11593d3ec: a9425ff8    	ldp	x24, x23, [sp, #0x20]
11593d3f0: a94167fa    	ldp	x26, x25, [sp, #0x10]
11593d3f4: 910183ff    	add	sp, sp, #0x60
11593d3f8: d65f03c0    	ret
