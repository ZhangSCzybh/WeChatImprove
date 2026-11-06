
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157dc26c: d101c3ff    	sub	sp, sp, #0x70
1157dc270: a9035ff8    	stp	x24, x23, [sp, #0x30]
1157dc274: a90457f6    	stp	x22, x21, [sp, #0x40]
1157dc278: a9054ff4    	stp	x20, x19, [sp, #0x50]
1157dc27c: a9067bfd    	stp	x29, x30, [sp, #0x60]
1157dc280: 910183fd    	add	x29, sp, #0x60
1157dc284: aa0303f4    	mov	x20, x3
1157dc288: aa0203f3    	mov	x19, x2
1157dc28c: aa0003f5    	mov	x21, x0
1157dc290: aa0203e0    	mov	x0, x2
1157dc294: 945a00d0    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dc298: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dc29c: 9114e108    	add	x8, x8, #0x538
1157dc2a0: f004a5a9    	adrp	x9, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dc2a4: 91152129    	add	x9, x9, #0x548
1157dc2a8: 7100029f    	cmp	w20, #0x0
1157dc2ac: 9a891108    	csel	x8, x8, x9, ne
1157dc2b0: f9400101    	ldr	x1, [x8]
1157dc2b4: aa1303e0    	mov	x0, x19
1157dc2b8: 945a00a3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc2bc: aa0003f6    	mov	x22, x0
1157dc2c0: 90049168    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
1157dc2c4: f9412101    	ldr	x1, [x8, #0x240]
1157dc2c8: aa1303e0    	mov	x0, x19
1157dc2cc: 945a009e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc2d0: aa1d03fd    	mov	x29, x29
1157dc2d4: 945a00c9    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc2d8: aa0003f4    	mov	x20, x0
1157dc2dc: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dc2e0: f9423101    	ldr	x1, [x8, #0x460]
1157dc2e4: aa1503e0    	mov	x0, x21
1157dc2e8: 945a0097    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc2ec: aa1d03fd    	mov	x29, x29
1157dc2f0: 945a00c2    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc2f4: aa0003f7    	mov	x23, x0
1157dc2f8: 945a00b1    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc2fc: eb1302ff    	cmp	x23, x19
1157dc300: 540000c1    	b.ne	0x1157dc318 <_O266DecReleaseOutputPicture+0x36ccdac>
1157dc304: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dc308: f9428d01    	ldr	x1, [x8, #0x518]
1157dc30c: aa1503e0    	mov	x0, x21
1157dc310: d2800002    	mov	x2, #0x0                ; =0
1157dc314: 945a008c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc318: b0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dc31c: f9443917    	ldr	x23, [x8, #0x870]
1157dc320: aa1503e0    	mov	x0, x21
1157dc324: aa1703e1    	mov	x1, x23
1157dc328: 945a0087    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc32c: aa1d03fd    	mov	x29, x29
1157dc330: 945a00b2    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc334: aa0003f8    	mov	x24, x0
1157dc338: d004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dc33c: f946f501    	ldr	x1, [x8, #0xde8]
1157dc340: 1e6e1000    	fmov	d0, #1.00000000
1157dc344: 945a0080    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc348: aa1803e0    	mov	x0, x24
1157dc34c: 945a009c    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc350: d003fb68    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1157dc354: f942bd08    	ldr	x8, [x8, #0x578]
1157dc358: ad400500    	ldp	q0, q1, [x8]
1157dc35c: ad0007e0    	stp	q0, q1, [sp]
1157dc360: 3dc00900    	ldr	q0, [x8, #0x20]
1157dc364: 3d800be0    	str	q0, [sp, #0x20]
1157dc368: aa1503e0    	mov	x0, x21
1157dc36c: aa1703e1    	mov	x1, x23
1157dc370: 945a0075    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc374: aa1d03fd    	mov	x29, x29
1157dc378: 945a00a0    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc37c: aa0003f8    	mov	x24, x0
1157dc380: 9004a688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1157dc384: f9460501    	ldr	x1, [x8, #0xc08]
1157dc388: 910003e2    	mov	x2, sp
1157dc38c: 945a006e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc390: aa1803e0    	mov	x0, x24
1157dc394: 945a008a    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc398: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dc39c: f942b101    	ldr	x1, [x8, #0x560]
1157dc3a0: aa1303e0    	mov	x0, x19
1157dc3a4: 945a0068    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc3a8: aa0003f8    	mov	x24, x0
1157dc3ac: aa1503e0    	mov	x0, x21
1157dc3b0: aa1703e1    	mov	x1, x23
1157dc3b4: 945a0064    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc3b8: aa1d03fd    	mov	x29, x29
1157dc3bc: 945a008f    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc3c0: aa0003f7    	mov	x23, x0
1157dc3c4: 9004a688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1157dc3c8: f9469d01    	ldr	x1, [x8, #0xd38]
1157dc3cc: aa1803e2    	mov	x2, x24
1157dc3d0: 945a005d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc3d4: aa1703e0    	mov	x0, x23
1157dc3d8: 945a0079    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc3dc: b0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dc3e0: f9443d01    	ldr	x1, [x8, #0x878]
1157dc3e4: aa1503e0    	mov	x0, x21
1157dc3e8: aa1603e2    	mov	x2, x22
1157dc3ec: 52800003    	mov	w3, #0x0                ; =0
1157dc3f0: 945a0055    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc3f4: d004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dc3f8: f9424901    	ldr	x1, [x8, #0x490]
1157dc3fc: aa1403e0    	mov	x0, x20
1157dc400: 945a0051    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc404: 90049168    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
1157dc408: f9412901    	ldr	x1, [x8, #0x250]
1157dc40c: aa1303e0    	mov	x0, x19
1157dc410: d2800002    	mov	x2, #0x0                ; =0
1157dc414: 945a004c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc418: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dc41c: f942a901    	ldr	x1, [x8, #0x550]
1157dc420: aa1303e0    	mov	x0, x19
1157dc424: d2800002    	mov	x2, #0x0                ; =0
1157dc428: 945a0047    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc42c: aa1403e0    	mov	x0, x20
1157dc430: 945a0063    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc434: aa1303e0    	mov	x0, x19
1157dc438: 945a0061    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc43c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1157dc440: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1157dc444: a94457f6    	ldp	x22, x21, [sp, #0x40]
1157dc448: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1157dc44c: 9101c3ff    	add	sp, sp, #0x70
1157dc450: d65f03c0    	ret
