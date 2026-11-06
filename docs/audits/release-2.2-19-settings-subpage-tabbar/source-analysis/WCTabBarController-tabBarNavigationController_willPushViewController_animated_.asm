
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157db1b0: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1157db1b4: a90157f6    	stp	x22, x21, [sp, #0x10]
1157db1b8: a9024ff4    	stp	x20, x19, [sp, #0x20]
1157db1bc: a9037bfd    	stp	x29, x30, [sp, #0x30]
1157db1c0: 9100c3fd    	add	x29, sp, #0x30
1157db1c4: aa0403f6    	mov	x22, x4
1157db1c8: aa0303f4    	mov	x20, x3
1157db1cc: aa0203f3    	mov	x19, x2
1157db1d0: aa0003f5    	mov	x21, x0
1157db1d4: aa0203e0    	mov	x0, x2
1157db1d8: 945a04ff    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db1dc: aa1403e0    	mov	x0, x20
1157db1e0: 945a04fd    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db1e4: f004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157db1e8: f945b901    	ldr	x1, [x8, #0xb70]
1157db1ec: aa1503e0    	mov	x0, x21
1157db1f0: 945a04d5    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db1f4: aa1d03fd    	mov	x29, x29
1157db1f8: 945a0500    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db1fc: aa0003f7    	mov	x23, x0
1157db200: 945a04ef    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db204: eb17027f    	cmp	x19, x23
1157db208: 54000981    	b.ne	0x1157db338 <_O266DecReleaseOutputPicture+0x36cbdcc>
1157db20c: d004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157db210: f9473501    	ldr	x1, [x8, #0xe68]
1157db214: aa1303e0    	mov	x0, x19
1157db218: 945a04cb    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db21c: aa1d03fd    	mov	x29, x29
1157db220: 945a04f6    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db224: aa0003f7    	mov	x23, x0
1157db228: f004a648    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1157db22c: f9442901    	ldr	x1, [x8, #0x850]
1157db230: 945a04c5    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db234: b40007e0    	cbz	x0, 0x1157db330 <_O266DecReleaseOutputPicture+0x36cbdc4>
1157db238: d004a4e8    	adrp	x8, 0x11ec79000 <dyld_stub_binder+0x11ec79000>
1157db23c: f940d501    	ldr	x1, [x8, #0x1a8]
1157db240: aa1403e0    	mov	x0, x20
1157db244: 945a04c0    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db248: aa0003f8    	mov	x24, x0
1157db24c: aa1703e0    	mov	x0, x23
1157db250: 945a04db    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db254: 34000738    	cbz	w24, 0x1157db338 <_O266DecReleaseOutputPicture+0x36cbdcc>
1157db258: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db25c: f9422517    	ldr	x23, [x8, #0x448]
1157db260: aa1503e0    	mov	x0, x21
1157db264: aa1703e1    	mov	x1, x23
1157db268: 945a04b7    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db26c: 37000660    	tbnz	w0, #0x0, 0x1157db338 <_O266DecReleaseOutputPicture+0x36cbdcc>
1157db270: 36000756    	tbz	w22, #0x0, 0x1157db358 <_O266DecReleaseOutputPicture+0x36cbdec>
1157db274: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db278: f9423116    	ldr	x22, [x8, #0x460]
1157db27c: aa1503e0    	mov	x0, x21
1157db280: aa1603e1    	mov	x1, x22
1157db284: 945a04b0    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db288: aa1d03fd    	mov	x29, x29
1157db28c: 945a04db    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db290: aa0003f8    	mov	x24, x0
1157db294: 945a04ca    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db298: b40001f8    	cbz	x24, 0x1157db2d4 <_O266DecReleaseOutputPicture+0x36cbd68>
1157db29c: aa1503e0    	mov	x0, x21
1157db2a0: aa1603e1    	mov	x1, x22
1157db2a4: 945a04a8    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db2a8: aa1d03fd    	mov	x29, x29
1157db2ac: 945a04d3    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db2b0: aa0003f6    	mov	x22, x0
1157db2b4: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db2b8: f9428101    	ldr	x1, [x8, #0x500]
1157db2bc: aa1503e0    	mov	x0, x21
1157db2c0: aa1603e2    	mov	x2, x22
1157db2c4: 52800023    	mov	w3, #0x1                ; =1
1157db2c8: 945a049f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db2cc: aa1603e0    	mov	x0, x22
1157db2d0: 945a04bb    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db2d4: b004abc8    	adrp	x8, 0x11ed54000 <dyld_stub_binder+0x11ed54000>
1157db2d8: f944c900    	ldr	x0, [x8, #0x990]
1157db2dc: 945a0443    	bl	0x116e5c3e8 <dyld_stub_binder+0x116e5c3e8>
1157db2e0: aa0003f6    	mov	x22, x0
1157db2e4: d0048fa8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1157db2e8: f9405501    	ldr	x1, [x8, #0xa8]
1157db2ec: aa1303e2    	mov	x2, x19
1157db2f0: 945a0495    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db2f4: f0049588    	adrp	x8, 0x11ea8e000 <dyld_stub_binder+0x11ea8e000>
1157db2f8: f9442d01    	ldr	x1, [x8, #0x858]
1157db2fc: aa1603e0    	mov	x0, x22
1157db300: aa1403e2    	mov	x2, x20
1157db304: 945a0490    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db308: aa1503e0    	mov	x0, x21
1157db30c: aa1703e1    	mov	x1, x23
1157db310: 945a048d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db314: 34000300    	cbz	w0, 0x1157db374 <_O266DecReleaseOutputPicture+0x36cbe08>
1157db318: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db31c: f9428501    	ldr	x1, [x8, #0x508]
1157db320: aa1603e0    	mov	x0, x22
1157db324: 52800022    	mov	w2, #0x1                ; =1
1157db328: 945a0487    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db32c: 14000023    	b	0x1157db3b8 <_O266DecReleaseOutputPicture+0x36cbe4c>
1157db330: aa1703e0    	mov	x0, x23
1157db334: 945a04a2    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db338: aa1403e0    	mov	x0, x20
1157db33c: 945a04a0    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db340: aa1303e0    	mov	x0, x19
1157db344: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1157db348: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1157db34c: a94157f6    	ldp	x22, x21, [sp, #0x10]
1157db350: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1157db354: 145a049a    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db358: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157db35c: f9443d01    	ldr	x1, [x8, #0x878]
1157db360: aa1503e0    	mov	x0, x21
1157db364: 52800022    	mov	w2, #0x1                ; =1
1157db368: 52800003    	mov	w3, #0x0                ; =0
1157db36c: 945a0476    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db370: 17fffff2    	b	0x1157db338 <_O266DecReleaseOutputPicture+0x36cbdcc>
1157db374: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157db378: f9443901    	ldr	x1, [x8, #0x870]
1157db37c: aa1503e0    	mov	x0, x21
1157db380: 945a0471    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db384: aa1d03fd    	mov	x29, x29
1157db388: 945a049c    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db38c: aa0003f7    	mov	x23, x0
1157db390: b004a668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1157db394: f9441501    	ldr	x1, [x8, #0x828]
1157db398: 945a046b    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db39c: aa0003e2    	mov	x2, x0
1157db3a0: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db3a4: f9428501    	ldr	x1, [x8, #0x508]
1157db3a8: aa1603e0    	mov	x0, x22
1157db3ac: 945a0466    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db3b0: aa1703e0    	mov	x0, x23
1157db3b4: 945a0482    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db3b8: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db3bc: f9428901    	ldr	x1, [x8, #0x510]
1157db3c0: aa1603e0    	mov	x0, x22
1157db3c4: 52800022    	mov	w2, #0x1                ; =1
1157db3c8: 945a045f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db3cc: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db3d0: f9428d01    	ldr	x1, [x8, #0x518]
1157db3d4: aa1503e0    	mov	x0, x21
1157db3d8: aa1603e2    	mov	x2, x22
1157db3dc: 945a045a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db3e0: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db3e4: f9429101    	ldr	x1, [x8, #0x520]
1157db3e8: aa1503e0    	mov	x0, x21
1157db3ec: aa1603e2    	mov	x2, x22
1157db3f0: 945a0455    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db3f4: aa1603e0    	mov	x0, x22
1157db3f8: 17ffffcf    	b	0x1157db334 <_O266DecReleaseOutputPicture+0x36cbdc8>
