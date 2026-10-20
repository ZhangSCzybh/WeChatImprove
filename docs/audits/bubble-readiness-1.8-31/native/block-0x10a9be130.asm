
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a9be130: d10183ff    	sub	sp, sp, #0x60
10a9be134: a90167fa    	stp	x26, x25, [sp, #0x10]
10a9be138: a9025ff8    	stp	x24, x23, [sp, #0x20]
10a9be13c: a90357f6    	stp	x22, x21, [sp, #0x30]
10a9be140: a9044ff4    	stp	x20, x19, [sp, #0x40]
10a9be144: a9057bfd    	stp	x29, x30, [sp, #0x50]
10a9be148: 910143fd    	add	x29, sp, #0x50
10a9be14c: aa0003f3    	mov	x19, x0
10a9be150: f9401001    	ldr	x1, [x0, #0x20]
10a9be154: 910023e0    	add	x0, sp, #0x8
10a9be158: 94001144    	bl	0x10a9c2668 <_Flutter_MMFoundation_BindContext+0x6e9e24c>
10a9be15c: f9401660    	ldr	x0, [x19, #0x28]
10a9be160: f9400808    	ldr	x8, [x0, #0x10]
10a9be164: d63f0100    	blr	x8
10a9be168: 37001360    	tbnz	w0, #0x0, 0x10a9be3d4 <_Flutter_MMFoundation_BindContext+0x6e99fb8>
10a9be16c: 9100c260    	add	x0, x19, #0x30
10a9be170: 953a74c9    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be174: aa0003f5    	mov	x21, x0
10a9be178: d00aa4c8    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
10a9be17c: f940cd14    	ldr	x20, [x8, #0x198] ; originImage
10a9be180: aa1403e1    	mov	x1, x20
10a9be184: 953a74b0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be188: aa1d03fd    	mov	x29, x29
10a9be18c: 953a74b1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be190: aa0003f6    	mov	x22, x0
10a9be194: 953a74b2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be198: aa1503e0    	mov	x0, x21
10a9be19c: 953a74b0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be1a0: b40011b6    	cbz	x22, 0x10a9be3d4 <_Flutter_MMFoundation_BindContext+0x6e99fb8>
10a9be1a4: 9100c260    	add	x0, x19, #0x30
10a9be1a8: 953a74bb    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be1ac: aa0003f5    	mov	x21, x0
10a9be1b0: f00ab788    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9be1b4: f945e901    	ldr	x1, [x8, #0xbd0] ; isDynamicImg
10a9be1b8: 953a74a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be1bc: aa0003f6    	mov	x22, x0
10a9be1c0: aa1503e0    	mov	x0, x21
10a9be1c4: 953a74a6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be1c8: 9100c260    	add	x0, x19, #0x30
10a9be1cc: 953a74b2    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be1d0: aa0003f5    	mov	x21, x0
10a9be1d4: aa1403e1    	mov	x1, x20
10a9be1d8: 953a749b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be1dc: aa1d03fd    	mov	x29, x29
10a9be1e0: 953a749c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be1e4: aa0003f8    	mov	x24, x0
10a9be1e8: d00aa6e8    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9be1ec: f941dd01    	ldr	x1, [x8, #0x3b8] ; imageInLightMode
10a9be1f0: 953a7495    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be1f4: aa1d03fd    	mov	x29, x29
10a9be1f8: 953a7496    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be1fc: aa0003f7    	mov	x23, x0
10a9be200: aa1803e0    	mov	x0, x24
10a9be204: 953a7496    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be208: aa1503e0    	mov	x0, x21
10a9be20c: 953a7494    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be210: 34000296    	cbz	w22, 0x10a9be260 <_Flutter_MMFoundation_BindContext+0x6e99e44>
10a9be214: 9100c260    	add	x0, x19, #0x30
10a9be218: 953a749f    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be21c: aa0003f5    	mov	x21, x0
10a9be220: aa1403e1    	mov	x1, x20
10a9be224: 953a7488    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be228: aa1d03fd    	mov	x29, x29
10a9be22c: 953a7489    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be230: aa0003f8    	mov	x24, x0
10a9be234: d00aa6e8    	adrp	x8, 0x11fe9c000 <dyld_stub_binder+0x11fe9c000>
10a9be238: f941e501    	ldr	x1, [x8, #0x3c8] ; imageInDarkMode
10a9be23c: 953a7482    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be240: aa1d03fd    	mov	x29, x29
10a9be244: 953a7483    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be248: aa0003f4    	mov	x20, x0
10a9be24c: aa1803e0    	mov	x0, x24
10a9be250: 953a7483    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be254: aa1503e0    	mov	x0, x21
10a9be258: 953a7481    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be25c: 14000002    	b	0x10a9be264 <_Flutter_MMFoundation_BindContext+0x6e99e48>
10a9be260: d2800014    	mov	x20, #0x0               ; =0
10a9be264: f9401660    	ldr	x0, [x19, #0x28]
10a9be268: f9400808    	ldr	x8, [x0, #0x10]
10a9be26c: d63f0100    	blr	x8
10a9be270: b4000a97    	cbz	x23, 0x10a9be3c0 <_Flutter_MMFoundation_BindContext+0x6e99fa4>
10a9be274: 37000a60    	tbnz	w0, #0x0, 0x10a9be3c0 <_Flutter_MMFoundation_BindContext+0x6e99fa4>
10a9be278: 9100c260    	add	x0, x19, #0x30
10a9be27c: 953a7486    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be280: aa0003fa    	mov	x26, x0
10a9be284: f00ab788    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9be288: f9460118    	ldr	x24, [x8, #0xc00] ; prefertSize
10a9be28c: 953a746d    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a9be290: aa1803e1    	mov	x1, x24
10a9be294: 953a746c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be298: f9401663    	ldr	x3, [x19, #0x28]
10a9be29c: f00ab788    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9be2a0: f9460519    	ldr	x25, [x8, #0xc08] ; _fourceDecodeImage:prefertSize:isCancelled:
10a9be2a4: aa1a03e0    	mov	x0, x26
10a9be2a8: aa1903e1    	mov	x1, x25
10a9be2ac: aa1703e2    	mov	x2, x23
10a9be2b0: 953a7465    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be2b4: aa1d03fd    	mov	x29, x29
10a9be2b8: 953a7466    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be2bc: aa0003f5    	mov	x21, x0
10a9be2c0: aa1a03e0    	mov	x0, x26
10a9be2c4: 953a7466    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be2c8: aa1703e0    	mov	x0, x23
10a9be2cc: 953a7464    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be2d0: aa1a03e0    	mov	x0, x26
10a9be2d4: 953a7462    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be2d8: 9100c260    	add	x0, x19, #0x30
10a9be2dc: 953a746e    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be2e0: aa0003f7    	mov	x23, x0
10a9be2e4: f00ab788    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9be2e8: f9460d01    	ldr	x1, [x8, #0xc18] ; setDecodeImageLM:
10a9be2ec: aa1503e2    	mov	x2, x21
10a9be2f0: 953a7455    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be2f4: aa1703e0    	mov	x0, x23
10a9be2f8: 953a7459    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be2fc: f100029f    	cmp	x20, #0x0
10a9be300: 520002c8    	eor	w8, w22, #0x1
10a9be304: 1a9f1508    	csinc	w8, w8, wzr, ne
10a9be308: 37000488    	tbnz	w8, #0x0, 0x10a9be398 <_Flutter_MMFoundation_BindContext+0x6e99f7c>
10a9be30c: f9401660    	ldr	x0, [x19, #0x28]
10a9be310: f9400808    	ldr	x8, [x0, #0x10]
10a9be314: d63f0100    	blr	x8
10a9be318: 37000560    	tbnz	w0, #0x0, 0x10a9be3c4 <_Flutter_MMFoundation_BindContext+0x6e99fa8>
10a9be31c: 9100c260    	add	x0, x19, #0x30
10a9be320: 953a745d    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be324: aa1d03fd    	mov	x29, x29
10a9be328: 953a744a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be32c: aa0003f6    	mov	x22, x0
10a9be330: aa1803e1    	mov	x1, x24
10a9be334: 953a7444    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be338: f9401663    	ldr	x3, [x19, #0x28]
10a9be33c: aa1603e0    	mov	x0, x22
10a9be340: aa1903e1    	mov	x1, x25
10a9be344: aa1403e2    	mov	x2, x20
10a9be348: 953a743f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be34c: aa1d03fd    	mov	x29, x29
10a9be350: 953a7440    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a9be354: aa0003f7    	mov	x23, x0
10a9be358: aa1603e0    	mov	x0, x22
10a9be35c: 953a7440    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be360: aa1403e0    	mov	x0, x20
10a9be364: 953a743e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be368: aa1603e0    	mov	x0, x22
10a9be36c: 953a743c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be370: 9100c260    	add	x0, x19, #0x30
10a9be374: 953a7448    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be378: aa0003f4    	mov	x20, x0
10a9be37c: f00ab788    	adrp	x8, 0x1200b1000 <dyld_stub_binder+0x1200b1000>
10a9be380: f9460901    	ldr	x1, [x8, #0xc10] ; setDecodeImageDM:
10a9be384: aa1703e2    	mov	x2, x23
10a9be388: 953a742f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be38c: aa1403e0    	mov	x0, x20
10a9be390: 953a7433    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be394: aa1703f4    	mov	x20, x23
10a9be398: 9100c260    	add	x0, x19, #0x30
10a9be39c: 953a743e    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10a9be3a0: aa0003f3    	mov	x19, x0
10a9be3a4: d00aa628    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
10a9be3a8: f943bd01    	ldr	x1, [x8, #0x778] ; setOriginImage:
10a9be3ac: d2800002    	mov	x2, #0x0                ; =0
10a9be3b0: 953a7425    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a9be3b4: aa1303e0    	mov	x0, x19
10a9be3b8: 953a7429    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be3bc: 14000002    	b	0x10a9be3c4 <_Flutter_MMFoundation_BindContext+0x6e99fa8>
10a9be3c0: aa1703f5    	mov	x21, x23
10a9be3c4: aa1403e0    	mov	x0, x20
10a9be3c8: 953a7425    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be3cc: aa1503e0    	mov	x0, x21
10a9be3d0: 953a7423    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a9be3d4: 910023e0    	add	x0, sp, #0x8
10a9be3d8: 940010ba    	bl	0x10a9c26c0 <_Flutter_MMFoundation_BindContext+0x6e9e2a4>
10a9be3dc: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10a9be3e0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10a9be3e4: a94357f6    	ldp	x22, x21, [sp, #0x30]
10a9be3e8: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10a9be3ec: a94167fa    	ldp	x26, x25, [sp, #0x10]
10a9be3f0: 910183ff    	add	sp, sp, #0x60
10a9be3f4: d65f03c0    	ret