
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1166dac14: d103c3ff    	sub	sp, sp, #0xf0
1166dac18: 6d053bef    	stp	d15, d14, [sp, #0x50]
1166dac1c: 6d0633ed    	stp	d13, d12, [sp, #0x60]
1166dac20: 6d072beb    	stp	d11, d10, [sp, #0x70]
1166dac24: 6d0823e9    	stp	d9, d8, [sp, #0x80]
1166dac28: a9096ffc    	stp	x28, x27, [sp, #0x90]
1166dac2c: a90a67fa    	stp	x26, x25, [sp, #0xa0]
1166dac30: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
1166dac34: a90c57f6    	stp	x22, x21, [sp, #0xc0]
1166dac38: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
1166dac3c: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
1166dac40: 910383fd    	add	x29, sp, #0xe0
1166dac44: aa0003f3    	mov	x19, x0
1166dac48: f004d088    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
1166dac4c: f946c101    	ldr	x1, [x8, #0xd80] ; caculateMenuItemWidth
1166dac50: 94713c27    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dac54: f9400e68    	ldr	x8, [x19, #0x18]
1166dac58: f100091f    	cmp	x8, #0x2
1166dac5c: 54000081    	b.ne	0x1166dac6c <_O266DecReleaseOutputPicture+0x344e1b4>
1166dac60: fd402a68    	ldr	d8, [x19, #0x50]
1166dac64: 9e6703e0    	fmov	d0, xzr
1166dac68: 14000003    	b	0x1166dac74 <_O266DecReleaseOutputPicture+0x344e1bc>
1166dac6c: 1e604008    	fmov	d8, d0
1166dac70: 1e641000    	fmov	d0, #8.00000000
1166dac74: fd0023e0    	str	d0, [sp, #0x40]
1166dac78: b004bc68    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
1166dac7c: f9411d01    	ldr	x1, [x8, #0x238] ; rowCount
1166dac80: aa1303e0    	mov	x0, x19
1166dac84: f9000be1    	str	x1, [sp, #0x10]
1166dac88: 94713c19    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dac8c: f100041f    	cmp	x0, #0x1
1166dac90: 5400168b    	b.lt	0x1166daf60 <_O266DecReleaseOutputPicture+0x344e4a8>
1166dac94: d2800014    	mov	x20, #0x0               ; =0
1166dac98: f004d088    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
1166dac9c: f946c508    	ldr	x8, [x8, #0xd88] ; itemsAtRow:
1166daca0: f90007e8    	str	x8, [sp, #0x8]
1166daca4: d004d128    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1166daca8: f9435108    	ldr	x8, [x8, #0x6a0] ; count
1166dacac: f90027e8    	str	x8, [sp, #0x48]
1166dacb0: d004d148    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1166dacb4: f947e108    	ldr	x8, [x8, #0xfc0] ; objectAtIndexedSubscript:
1166dacb8: f90017e8    	str	x8, [sp, #0x28]
1166dacbc: 9e6703ee    	fmov	d14, xzr
1166dacc0: 9e6703ef    	fmov	d15, xzr
1166dacc4: 9e6703e9    	fmov	d9, xzr
1166dacc8: aa1303e0    	mov	x0, x19
1166daccc: f94007e1    	ldr	x1, [sp, #0x8]
1166dacd0: f9000ff4    	str	x20, [sp, #0x18]
1166dacd4: aa1403e2    	mov	x2, x20
1166dacd8: 94713c05    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dacdc: aa1d03fd    	mov	x29, x29
1166dace0: 94713c2d    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166dace4: aa0003f9    	mov	x25, x0
1166dace8: f94027f5    	ldr	x21, [sp, #0x48]
1166dacec: aa1503e1    	mov	x1, x21
1166dacf0: 94713bff    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dacf4: aa0003f4    	mov	x20, x0
1166dacf8: fd40166a    	ldr	d10, [x19, #0x28]
1166dacfc: aa1903e0    	mov	x0, x25
1166dad00: aa1503e1    	mov	x1, x21
1166dad04: 94713bfa    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dad08: b4001160    	cbz	x0, 0x1166daf34 <_O266DecReleaseOutputPicture+0x344e47c>
1166dad0c: d280001c    	mov	x28, #0x0               ; =0
1166dad10: d280001a    	mov	x26, #0x0               ; =0
1166dad14: 9e630280    	ucvtf	d0, x20
1166dad18: 5e61d941    	scvtf	d1, d10
1166dad1c: 1e611800    	fdiv	d0, d0, d1
1166dad20: 9e700008    	fcvtms	x8, d0
1166dad24: f90013e8    	str	x8, [sp, #0x20]
1166dad28: f004cf48    	adrp	x8, 0x1200c5000 <dyld_stub_binder+0x1200c5000>
1166dad2c: f941a509    	ldr	x9, [x8, #0x348] ; setLinePosition:
1166dad30: f004d088    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
1166dad34: f946c908    	ldr	x8, [x8, #0xd90] ; itemSizeWithWidth:
1166dad38: a90327e8    	stp	x8, x9, [sp, #0x30]
1166dad3c: f004d088    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
1166dad40: f946cd14    	ldr	x20, [x8, #0xd98] ; setItemFrame:
1166dad44: f004d088    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
1166dad48: f946d115    	ldr	x21, [x8, #0xda0] ; itemFrame
1166dad4c: 9004bb08    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1166dad50: f942c118    	ldr	x24, [x8, #0x580] ; safeObjectAtIndex:
1166dad54: 9e6703ea    	fmov	d10, xzr
1166dad58: 52800037    	mov	w23, #0x1               ; =1
1166dad5c: fd4023ec    	ldr	d12, [sp, #0x40]
1166dad60: 9e6703eb    	fmov	d11, xzr
1166dad64: fd40166d    	ldr	d13, [x19, #0x28]
1166dad68: aa1903e0    	mov	x0, x25
1166dad6c: f94017e1    	ldr	x1, [sp, #0x28]
1166dad70: aa1a03e2    	mov	x2, x26
1166dad74: 94713bde    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dad78: aa1d03fd    	mov	x29, x29
1166dad7c: 94713c06    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166dad80: aa0003fb    	mov	x27, x0
1166dad84: f9400e62    	ldr	x2, [x19, #0x18]
1166dad88: b4000302    	cbz	x2, 0x1166dade8 <_O266DecReleaseOutputPicture+0x344e330>
1166dad8c: f100085f    	cmp	x2, #0x2
1166dad90: 54000061    	b.ne	0x1166dad9c <_O266DecReleaseOutputPicture+0x344e2e4>
1166dad94: 52800082    	mov	w2, #0x4                ; =4
1166dad98: 14000014    	b	0x1166dade8 <_O266DecReleaseOutputPicture+0x344e330>
1166dad9c: aa1903e0    	mov	x0, x25
1166dada0: f94027e1    	ldr	x1, [sp, #0x48]
1166dada4: 94713bd2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dada8: f9401668    	ldr	x8, [x19, #0x28]
1166dadac: eb08001f    	cmp	x0, x8
1166dadb0: 54000169    	b.ls	0x1166daddc <_O266DecReleaseOutputPicture+0x344e324>
1166dadb4: 9e630340    	ucvtf	d0, x26
1166dadb8: 5e61d9a1    	scvtf	d1, d13
1166dadbc: 1e611800    	fdiv	d0, d0, d1
1166dadc0: 9e700008    	fcvtms	x8, d0
1166dadc4: b4000108    	cbz	x8, 0x1166dade4 <_O266DecReleaseOutputPicture+0x344e32c>
1166dadc8: f94013e9    	ldr	x9, [sp, #0x20]
1166dadcc: eb09011f    	cmp	x8, x9
1166dadd0: 52800048    	mov	w8, #0x2                ; =2
1166dadd4: 9a881502    	cinc	x2, x8, eq
1166dadd8: 14000004    	b	0x1166dade8 <_O266DecReleaseOutputPicture+0x344e330>
1166daddc: d2800002    	mov	x2, #0x0                ; =0
1166dade0: 14000002    	b	0x1166dade8 <_O266DecReleaseOutputPicture+0x344e330>
1166dade4: 52800022    	mov	w2, #0x1                ; =1
1166dade8: aa1b03e0    	mov	x0, x27
1166dadec: f9401fe1    	ldr	x1, [sp, #0x38]
1166dadf0: 94713bbf    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dadf4: aa1b03e0    	mov	x0, x27
1166dadf8: f9401be1    	ldr	x1, [sp, #0x30]
1166dadfc: 1e604100    	fmov	d0, d8
1166dae00: 94713bbb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dae04: 1e604002    	fmov	d2, d0
1166dae08: 1e612140    	fcmp	d10, d1
1166dae0c: 1e6a4c2a    	fcsel	d10, d1, d10, mi
1166dae10: 1e612160    	fcmp	d11, d1
1166dae14: 1e6b4c2b    	fcsel	d11, d1, d11, mi
1166dae18: aa1b03e0    	mov	x0, x27
1166dae1c: aa1403e1    	mov	x1, x20
1166dae20: 1e604180    	fmov	d0, d12
1166dae24: 1e604121    	fmov	d1, d9
1166dae28: 1e604143    	fmov	d3, d10
1166dae2c: 94713bb0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dae30: aa1b03e0    	mov	x0, x27
1166dae34: aa1503e1    	mov	x1, x21
1166dae38: 94713bad    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dae3c: 94711941    	bl	0x118321340 <dyld_stub_binder+0x118321340>
1166dae40: fd4023e1    	ldr	d1, [sp, #0x40]
1166dae44: 1e602820    	fadd	d0, d1, d0
1166dae48: 1e6021c0    	fcmp	d14, d0
1166dae4c: 1e6e4c0e    	fcsel	d14, d0, d14, mi
1166dae50: aa1b03e0    	mov	x0, x27
1166dae54: aa1503e1    	mov	x1, x21
1166dae58: 94713ba5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dae5c: 9471193c    	bl	0x11832134c <dyld_stub_binder+0x11832134c>
1166dae60: 1e6021e0    	fcmp	d15, d0
1166dae64: 1e6f4c0f    	fcsel	d15, d0, d15, mi
1166dae68: f9401668    	ldr	x8, [x19, #0x28]
1166dae6c: 9ac80f49    	sdiv	x9, x26, x8
1166dae70: 9b08e929    	msub	x9, x9, x8, x26
1166dae74: 91000536    	add	x22, x9, #0x1
1166dae78: eb0802df    	cmp	x22, x8
1166dae7c: 540000cb    	b.lt	0x1166dae94 <_O266DecReleaseOutputPicture+0x344e3dc>
1166dae80: aa1903e0    	mov	x0, x25
1166dae84: f94027e1    	ldr	x1, [sp, #0x48]
1166dae88: 94713b99    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166dae8c: eb0002df    	cmp	x22, x0
1166dae90: 540000c1    	b.ne	0x1166daea8 <_O266DecReleaseOutputPicture+0x344e3f0>
1166dae94: 1e6c2900    	fadd	d0, d8, d12
1166dae98: fd402661    	ldr	d1, [x19, #0x48]
1166dae9c: 1e61280c    	fadd	d12, d0, d1
1166daea0: 9100075a    	add	x26, x26, #0x1
1166daea4: 1400001b    	b	0x1166daf10 <_O266DecReleaseOutputPicture+0x344e458>
1166daea8: eb1a039f    	cmp	x28, x26
1166daeac: 5400026c    	b.gt	0x1166daef8 <_O266DecReleaseOutputPicture+0x344e440>
1166daeb0: aa1903e0    	mov	x0, x25
1166daeb4: aa1803e1    	mov	x1, x24
1166daeb8: aa1c03e2    	mov	x2, x28
1166daebc: 94713b8c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166daec0: aa1d03fd    	mov	x29, x29
1166daec4: 94713bb4    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166daec8: aa0003f6    	mov	x22, x0
1166daecc: aa1503e1    	mov	x1, x21
1166daed0: 94713b87    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166daed4: aa1603e0    	mov	x0, x22
1166daed8: aa1403e1    	mov	x1, x20
1166daedc: 1e604163    	fmov	d3, d11
1166daee0: 94713b83    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166daee4: aa1603e0    	mov	x0, x22
1166daee8: 94713b9c    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166daeec: 9100079c    	add	x28, x28, #0x1
1166daef0: eb1c02ff    	cmp	x23, x28
1166daef4: 54fffde1    	b.ne	0x1166daeb0 <_O266DecReleaseOutputPicture+0x344e3f8>
1166daef8: 1e6a2929    	fadd	d9, d9, d10
1166daefc: 9100075a    	add	x26, x26, #0x1
1166daf00: 9e6703eb    	fmov	d11, xzr
1166daf04: aa1a03fc    	mov	x28, x26
1166daf08: fd4023ec    	ldr	d12, [sp, #0x40]
1166daf0c: 9e6703ea    	fmov	d10, xzr
1166daf10: aa1b03e0    	mov	x0, x27
1166daf14: 94713b91    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166daf18: aa1903e0    	mov	x0, x25
1166daf1c: f94027e1    	ldr	x1, [sp, #0x48]
1166daf20: 94713b73    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166daf24: 910006f7    	add	x23, x23, #0x1
1166daf28: eb00035f    	cmp	x26, x0
1166daf2c: 54fff1c3    	b.lo	0x1166dad64 <_O266DecReleaseOutputPicture+0x344e2ac>
1166daf30: 14000002    	b	0x1166daf38 <_O266DecReleaseOutputPicture+0x344e480>
1166daf34: 9e6703ea    	fmov	d10, xzr
1166daf38: 1e6a2929    	fadd	d9, d9, d10
1166daf3c: aa1903e0    	mov	x0, x25
1166daf40: 94713b86    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166daf44: a94153e1    	ldp	x1, x20, [sp, #0x10]
1166daf48: 91000694    	add	x20, x20, #0x1
1166daf4c: aa1303e0    	mov	x0, x19
1166daf50: 94713b67    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166daf54: eb00029f    	cmp	x20, x0
1166daf58: 54ffeb8b    	b.lt	0x1166dacc8 <_O266DecReleaseOutputPicture+0x344e210>
1166daf5c: 14000003    	b	0x1166daf68 <_O266DecReleaseOutputPicture+0x344e4b0>
1166daf60: 9e6703ef    	fmov	d15, xzr
1166daf64: 9e6703ee    	fmov	d14, xzr
1166daf68: fd402260    	ldr	d0, [x19, #0x40]
1166daf6c: 1e6021c0    	fcmp	d14, d0
1166daf70: 1e6e4c00    	fcsel	d0, d0, d14, mi
1166daf74: 6d06be60    	stp	d0, d15, [x19, #0x68]
1166daf78: 1e6c1000    	fmov	d0, #0.50000000
1166daf7c: 1e6009c0    	fmul	d0, d14, d0
1166daf80: fd000a60    	str	d0, [x19, #0x10]
1166daf84: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
1166daf88: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
1166daf8c: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
1166daf90: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
1166daf94: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
1166daf98: a9496ffc    	ldp	x28, x27, [sp, #0x90]
1166daf9c: 6d4823e9    	ldp	d9, d8, [sp, #0x80]
1166dafa0: 6d472beb    	ldp	d11, d10, [sp, #0x70]
1166dafa4: 6d4633ed    	ldp	d13, d12, [sp, #0x60]
1166dafa8: 6d453bef    	ldp	d15, d14, [sp, #0x50]
1166dafac: 9103c3ff    	add	sp, sp, #0xf0
1166dafb0: d65f03c0    	ret