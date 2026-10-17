
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
11758d150: d10203ff    	sub	sp, sp, #0x80
11758d154: a90367fa    	stp	x26, x25, [sp, #0x30]
11758d158: a9045ff8    	stp	x24, x23, [sp, #0x40]
11758d15c: a90557f6    	stp	x22, x21, [sp, #0x50]
11758d160: a9064ff4    	stp	x20, x19, [sp, #0x60]
11758d164: a9077bfd    	stp	x29, x30, [sp, #0x70]
11758d168: 9101c3fd    	add	x29, sp, #0x70
11758d16c: aa0203f4    	mov	x20, x2
11758d170: aa0003f5    	mov	x21, x0
11758d174: 90053348    	adrp	x8, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
11758d178: 91146108    	add	x8, x8, #0x518
11758d17c: f9400101    	ldr	x1, [x8]
11758d180: 910083e0    	add	x0, sp, #0x20
11758d184: 94015d59    	bl	0x1175e46e8 <_O266DecReleaseOutputPicture+0x4357c30>
11758d188: b002a041    	adrp	x1, 0x11c996000 <dyld_stub_binder+0x11c996000>
11758d18c: 911ba021    	add	x1, x1, #0x6e8
11758d190: aa1503e0    	mov	x0, x21
11758d194: 943672b2    	bl	0x118329c5c <dyld_stub_binder+0x118329c5c>
11758d198: aa0003f3    	mov	x19, x0
11758d19c: f0045b88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
11758d1a0: f9428d16    	ldr	x22, [x8, #0x518] ; context
11758d1a4: b5000280    	cbnz	x0, 0x11758d1f4 <_O266DecReleaseOutputPicture+0x430073c>
11758d1a8: b0046148    	adrp	x8, 0x1201b6000 <dyld_stub_binder+0x1201b6000>
11758d1ac: f9422913    	ldr	x19, [x8, #0x450] ; ��d 
11758d1b0: aa1503e0    	mov	x0, x21
11758d1b4: aa1603e1    	mov	x1, x22
11758d1b8: 943672cd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d1bc: aa0003e2    	mov	x2, x0
11758d1c0: 90045b68    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
11758d1c4: f9430101    	ldr	x1, [x8, #0x600] ; contextObjectWithContext:obj:store:
11758d1c8: aa1303e0    	mov	x0, x19
11758d1cc: aa1503e3    	mov	x3, x21
11758d1d0: 52800024    	mov	w4, #0x1                ; =1
11758d1d4: 943672c6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d1d8: aa0003f3    	mov	x19, x0
11758d1dc: b002a041    	adrp	x1, 0x11c996000 <dyld_stub_binder+0x11c996000>
11758d1e0: 911ba021    	add	x1, x1, #0x6e8
11758d1e4: aa1503e0    	mov	x0, x21
11758d1e8: aa1303e2    	mov	x2, x19
11758d1ec: d2800003    	mov	x3, #0x0                ; =0
11758d1f0: 943672ef    	bl	0x118329dac <dyld_stub_binder+0x118329dac>
11758d1f4: aa1503e0    	mov	x0, x21
11758d1f8: aa1603e1    	mov	x1, x22
11758d1fc: 943672bc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d200: eb14001f    	cmp	x0, x20
11758d204: 540005a0    	b.eq	0x11758d2b8 <_O266DecReleaseOutputPicture+0x4300800>
11758d208: 52800080    	mov	w0, #0x4                ; =4
11758d20c: 97ffc6b5    	bl	0x11757ece0 <_O266DecReleaseOutputPicture+0x42f2228>
11758d210: 34000540    	cbz	w0, 0x11758d2b8 <_O266DecReleaseOutputPicture+0x4300800>
11758d214: 9436726e    	bl	0x118329bcc <dyld_stub_binder+0x118329bcc>
11758d218: aa0003f7    	mov	x23, x0
11758d21c: d0045f39    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
11758d220: f9454720    	ldr	x0, [x25, #0xa88]
11758d224: 94367255    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
11758d228: aa0003f8    	mov	x24, x0
11758d22c: f9454739    	ldr	x25, [x25, #0xa88]
11758d230: aa1503e0    	mov	x0, x21
11758d234: aa1603e1    	mov	x1, x22
11758d238: 943672ad    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d23c: b0045be8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
11758d240: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
11758d244: a900fff4    	stp	x20, xzr, [sp, #0x8]
11758d248: f90003e0    	str	x0, [sp]
11758d24c: b003afc2    	adrp	x2, 0x11eb86000 <dyld_stub_binder+0x11eb86000>
11758d250: 912a2042    	add	x2, x2, #0xa88
11758d254: aa1903e0    	mov	x0, x25
11758d258: 943672a5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d25c: b0045ba8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
11758d260: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
11758d264: d0037868    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
11758d268: 91362108    	add	x8, x8, #0xd88
11758d26c: a90003e8    	stp	x8, x0, [sp]
11758d270: d0037862    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
11758d274: 9134a042    	add	x2, x2, #0xd28
11758d278: aa1803e0    	mov	x0, x24
11758d27c: 9436729c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d280: aa0003f4    	mov	x20, x0
11758d284: b002a042    	adrp	x2, 0x11c996000 <dyld_stub_binder+0x11c996000>
11758d288: 911cc042    	add	x2, x2, #0x730
11758d28c: b002a044    	adrp	x4, 0x11c996000 <dyld_stub_binder+0x11c996000>
11758d290: 911fe084    	add	x4, x4, #0x7f8
11758d294: 52800080    	mov	w0, #0x4                ; =4
11758d298: d2800001    	mov	x1, #0x0                ; =0
11758d29c: 52803743    	mov	w3, #0x1ba              ; =442
11758d2a0: aa1403e5    	mov	x5, x20
11758d2a4: 97ffc69c    	bl	0x11757ed14 <_O266DecReleaseOutputPicture+0x42f225c>
11758d2a8: aa1403e0    	mov	x0, x20
11758d2ac: 943672ab    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11758d2b0: aa1703e0    	mov	x0, x23
11758d2b4: 94367243    	bl	0x118329bc0 <dyld_stub_binder+0x118329bc0>
11758d2b8: 910083e0    	add	x0, sp, #0x20
11758d2bc: 94015d2c    	bl	0x1175e476c <_O266DecReleaseOutputPicture+0x4357cb4>
11758d2c0: aa1303e0    	mov	x0, x19
11758d2c4: a9477bfd    	ldp	x29, x30, [sp, #0x70]
11758d2c8: a9464ff4    	ldp	x20, x19, [sp, #0x60]
11758d2cc: a94557f6    	ldp	x22, x21, [sp, #0x50]
11758d2d0: a9445ff8    	ldp	x24, x23, [sp, #0x40]
11758d2d4: a94367fa    	ldp	x26, x25, [sp, #0x30]
11758d2d8: 910203ff    	add	sp, sp, #0x80
11758d2dc: d65f03c0    	ret