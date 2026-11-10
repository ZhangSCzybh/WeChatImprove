
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a7fbc: d10183ff    	sub	sp, sp, #0x60
1002a7fc0: a90357f6    	stp	x22, x21, [sp, #0x30]
1002a7fc4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1002a7fc8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1002a7fcc: 910143fd    	add	x29, sp, #0x50
1002a7fd0: aa0003f3    	mov	x19, x0
1002a7fd4: b00fa4c9    	adrp	x9, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002a7fd8: 52800028    	mov	w8, #0x1                ; =1
1002a7fdc: 3923a528    	strb	w8, [x9, #0x8e9]
1002a7fe0: f9400409    	ldr	x9, [x0, #0x8]
1002a7fe4: f9401d20    	ldr	x0, [x9, #0x38]
1002a7fe8: b4000bc0    	cbz	x0, 0x1002a8160 <__text+0x2a0160>
1002a7fec: 528dacb5    	mov	w21, #0x6d65            ; =28005
1002a7ff0: 72ac2e35    	movk	w21, #0x6171, lsl #16
1002a7ff4: b81dc3a8    	stur	w8, [x29, #-0x24]
1002a7ff8: d10093a2    	sub	x2, x29, #0x24
1002a7ffc: 528daca1    	mov	w1, #0x6d65             ; =28005
1002a8000: 72ac2e21    	movk	w1, #0x6171, lsl #16
1002a8004: 52800083    	mov	w3, #0x4                ; =4
1002a8008: 95e5f8cf    	bl	0x107c26344 <_Flutter_MMFoundation_BindContext+0x3ead010>
1002a800c: 340002e0    	cbz	w0, 0x1002a8068 <__text+0x2a0068>
1002a8010: aa0003f4    	mov	x20, x0
1002a8014: d00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a8018: f9430d13    	ldr	x19, [x8, #0x618]
1002a801c: 95e592ab    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a8020: b00f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a8024: f9418901    	ldr	x1, [x8, #0x310]
1002a8028: d00cc728    	adrp	x8, 0x119b8e000 <dyld_stub_binder+0x119b8e000>
1002a802c: 9104d508    	add	x8, x8, #0x135
1002a8030: a90123f4    	stp	x20, x8, [sp, #0x10]
1002a8034: 900e67a8    	adrp	x8, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a8038: 910ce108    	add	x8, x8, #0x338
1002a803c: a90003e8    	stp	x8, x0, [sp]
1002a8040: b00cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8044: 9120a4a5    	add	x5, x5, #0x829
1002a8048: b00cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a804c: 912408e7    	add	x7, x7, #0x902
1002a8050: aa1303e0    	mov	x0, x19
1002a8054: 52800082    	mov	w2, #0x4                ; =4
1002a8058: d2800003    	mov	x3, #0x0                ; =0
1002a805c: 52800004    	mov	w4, #0x0                ; =0
1002a8060: 52801b46    	mov	w6, #0xda               ; =218
1002a8064: 1400003d    	b	0x1002a8158 <__text+0x2a0158>
1002a8068: 52800028    	mov	w8, #0x1                ; =1
1002a806c: b9002be8    	str	w8, [sp, #0x28]
1002a8070: f9400668    	ldr	x8, [x19, #0x8]
1002a8074: f9401d00    	ldr	x0, [x8, #0x38]
1002a8078: 9100a3e2    	add	x2, sp, #0x28
1002a807c: 528e8e01    	mov	w1, #0x7470             ; =29808
1002a8080: 72ae2be1    	movk	w1, #0x715f, lsl #16
1002a8084: 52800083    	mov	w3, #0x4                ; =4
1002a8088: 95e5f8af    	bl	0x107c26344 <_Flutter_MMFoundation_BindContext+0x3ead010>
1002a808c: 340002e0    	cbz	w0, 0x1002a80e8 <__text+0x2a00e8>
1002a8090: aa0003f4    	mov	x20, x0
1002a8094: d00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a8098: f9430d13    	ldr	x19, [x8, #0x618]
1002a809c: 95e5928b    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a80a0: b00f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a80a4: f9418901    	ldr	x1, [x8, #0x310]
1002a80a8: b00cc8c8    	adrp	x8, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a80ac: 91247d08    	add	x8, x8, #0x91f
1002a80b0: a90123f4    	stp	x20, x8, [sp, #0x10]
1002a80b4: 900e67a8    	adrp	x8, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a80b8: 910ce108    	add	x8, x8, #0x338
1002a80bc: a90003e8    	stp	x8, x0, [sp]
1002a80c0: b00cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a80c4: 9120a4a5    	add	x5, x5, #0x829
1002a80c8: b00cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a80cc: 912408e7    	add	x7, x7, #0x902
1002a80d0: aa1303e0    	mov	x0, x19
1002a80d4: 52800082    	mov	w2, #0x4                ; =4
1002a80d8: d2800003    	mov	x3, #0x0                ; =0
1002a80dc: 52800004    	mov	w4, #0x0                ; =0
1002a80e0: 52801ba6    	mov	w6, #0xdd               ; =221
1002a80e4: 1400001d    	b	0x1002a8158 <__text+0x2a0158>
1002a80e8: f9400663    	ldr	x3, [x19, #0x8]
1002a80ec: f9401c60    	ldr	x0, [x3, #0x38]
1002a80f0: 90000002    	adrp	x2, 0x1002a8000 <__text+0x2a0000>
1002a80f4: 9105f042    	add	x2, x2, #0x17c
1002a80f8: 111426a1    	add	w1, w21, #0x509
1002a80fc: 95e5f883    	bl	0x107c26308 <_Flutter_MMFoundation_BindContext+0x3eacfd4>
1002a8100: 340003a0    	cbz	w0, 0x1002a8174 <__text+0x2a0174>
1002a8104: aa0003f3    	mov	x19, x0
1002a8108: d00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a810c: f9430d14    	ldr	x20, [x8, #0x618]
1002a8110: 95e5926e    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a8114: b00f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a8118: f9418901    	ldr	x1, [x8, #0x310]
1002a811c: b00cc8c8    	adrp	x8, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8120: 9124d908    	add	x8, x8, #0x936
1002a8124: a90123f3    	stp	x19, x8, [sp, #0x10]
1002a8128: 900e67a8    	adrp	x8, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a812c: 910ce108    	add	x8, x8, #0x338
1002a8130: a90003e8    	stp	x8, x0, [sp]
1002a8134: b00cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8138: 9120a4a5    	add	x5, x5, #0x829
1002a813c: b00cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8140: 912408e7    	add	x7, x7, #0x902
1002a8144: aa1403e0    	mov	x0, x20
1002a8148: 52800082    	mov	w2, #0x4                ; =4
1002a814c: d2800003    	mov	x3, #0x0                ; =0
1002a8150: 52800004    	mov	w4, #0x0                ; =0
1002a8154: 52801c06    	mov	w6, #0xe0               ; =224
1002a8158: 95e5fec3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a815c: 52800000    	mov	w0, #0x0                ; =0
1002a8160: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1002a8164: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1002a8168: a94357f6    	ldp	x22, x21, [sp, #0x30]
1002a816c: 910183ff    	add	sp, sp, #0x60
1002a8170: d65f03c0    	ret
1002a8174: 52800020    	mov	w0, #0x1                ; =1
1002a8178: 17fffffa    	b	0x1002a8160 <__text+0x2a0160>
1002a817c: 900fa649    	adrp	x9, 0x11f770000 <dyld_stub_binder+0x11f770000>
1002a8180: f941d129    	ldr	x9, [x9, #0x3a0]
1002a8184: b4000049    	cbz	x9, 0x1002a818c <__text+0x2a018c>
1002a8188: d61f0120    	br	x9
1002a818c: d102c3ff    	sub	sp, sp, #0xb0
1002a8190: a9075ff8    	stp	x24, x23, [sp, #0x70]
1002a8194: a90857f6    	stp	x22, x21, [sp, #0x80]
1002a8198: a9094ff4    	stp	x20, x19, [sp, #0x90]
1002a819c: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
1002a81a0: 910283fd    	add	x29, sp, #0xa0
1002a81a4: aa0203f5    	mov	x21, x2
1002a81a8: aa0003f4    	mov	x20, x0
1002a81ac: 528e4dd7    	mov	w23, #0x726e            ; =29294
1002a81b0: 72ac2e37    	movk	w23, #0x6171, lsl #16
1002a81b4: 900fa4c8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002a81b8: 52800029    	mov	w9, #0x1                ; =1
1002a81bc: 3923a909    	strb	w9, [x8, #0x8ea]
1002a81c0: 95e5fea7    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1002a81c4: aa0003f3    	mov	x19, x0
1002a81c8: d00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a81cc: f943c100    	ldr	x0, [x8, #0x780]
1002a81d0: b00f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a81d4: f9457d01    	ldr	x1, [x8, #0xaf8]
1002a81d8: 95e5fea3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a81dc: aa1d03fd    	mov	x29, x29
1002a81e0: 95e5fea8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a81e4: aa0003f6    	mov	x22, x0
1002a81e8: d10123a0    	sub	x0, x29, #0x48
1002a81ec: aa1603e1    	mov	x1, x22
1002a81f0: 52800002    	mov	w2, #0x0                ; =0
1002a81f4: 95e5928b    	bl	0x107c0cc20 <_Flutter_MMFoundation_BindContext+0x3e938ec>
1002a81f8: aa1603e0    	mov	x0, x22
1002a81fc: 95e5fe9d    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a8200: 6b1702bf    	cmp	w21, w23
1002a8204: 54000bc1    	b.ne	0x1002a837c <__text+0x2a037c>
1002a8208: f9401e80    	ldr	x0, [x20, #0x38]
1002a820c: b4000b80    	cbz	x0, 0x1002a837c <__text+0x2a037c>
1002a8210: b81b43bf    	stur	wzr, [x29, #-0x4c]
1002a8214: 52800088    	mov	w8, #0x4                ; =4
1002a8218: b90053e8    	str	w8, [sp, #0x50]
1002a821c: d10133a2    	sub	x2, x29, #0x4c
1002a8220: 910143e3    	add	x3, sp, #0x50
1002a8224: 528e4dc1    	mov	w1, #0x726e             ; =29294
1002a8228: 72ac2e21    	movk	w1, #0x6171, lsl #16
1002a822c: 95e5f83e    	bl	0x107c26324 <_Flutter_MMFoundation_BindContext+0x3eacff0>
1002a8230: d00f5358    	adrp	x24, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a8234: b00f3917    	adrp	x23, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a8238: 340002a0    	cbz	w0, 0x1002a828c <__text+0x2a028c>
1002a823c: aa0003f5    	mov	x21, x0
1002a8240: f9430f16    	ldr	x22, [x24, #0x618]
1002a8244: 95e59221    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a8248: f9418ae1    	ldr	x1, [x23, #0x310]
1002a824c: b00cc8c8    	adrp	x8, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8250: 913c2508    	add	x8, x8, #0xf09
1002a8254: a90123f5    	stp	x21, x8, [sp, #0x10]
1002a8258: 900e67a8    	adrp	x8, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a825c: 910ce108    	add	x8, x8, #0x338
1002a8260: a90003e8    	stp	x8, x0, [sp]
1002a8264: b00cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8268: 9120a4a5    	add	x5, x5, #0x829
1002a826c: b00cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a8270: 913c98e7    	add	x7, x7, #0xf26
1002a8274: aa1603e0    	mov	x0, x22
1002a8278: 52800082    	mov	w2, #0x4                ; =4
1002a827c: d2800003    	mov	x3, #0x0                ; =0
1002a8280: 52800004    	mov	w4, #0x0                ; =0
1002a8284: 528005c6    	mov	w6, #0x2e               ; =46
1002a8288: 95e5fe77    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a828c: b85b43a8    	ldur	w8, [x29, #-0x4c]
1002a8290: f9430f00    	ldr	x0, [x24, #0x618]
1002a8294: 340001e8    	cbz	w8, 0x1002a82d0 <__text+0x2a02d0>
1002a8298: f9418ae1    	ldr	x1, [x23, #0x310]
1002a829c: b00e68a8    	adrp	x8, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a82a0: 91276108    	add	x8, x8, #0x9d8
1002a82a4: f90003e8    	str	x8, [sp]
1002a82a8: b00cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a82ac: 9120a4a5    	add	x5, x5, #0x829
1002a82b0: b00cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a82b4: 913c98e7    	add	x7, x7, #0xf26
1002a82b8: 52800042    	mov	w2, #0x2                ; =2
1002a82bc: d2800003    	mov	x3, #0x0                ; =0
1002a82c0: 52800004    	mov	w4, #0x0                ; =0
1002a82c4: 52800606    	mov	w6, #0x30               ; =48
1002a82c8: 95e5fe67    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a82cc: 1400002c    	b	0x1002a837c <__text+0x2a037c>
1002a82d0: 3941b688    	ldrb	w8, [x20, #0x6d]
1002a82d4: 52000108    	eor	w8, w8, #0x1
1002a82d8: 3941ba89    	ldrb	w9, [x20, #0x6e]
1002a82dc: f9418ae1    	ldr	x1, [x23, #0x310]
1002a82e0: a900a7e8    	stp	x8, x9, [sp, #0x8]
1002a82e4: b00e68a9    	adrp	x9, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a82e8: 9127e129    	add	x9, x9, #0x9f8
1002a82ec: f90003e9    	str	x9, [sp]
1002a82f0: b00cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a82f4: 9120a4a5    	add	x5, x5, #0x829
1002a82f8: b00cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a82fc: 913c98e7    	add	x7, x7, #0xf26
1002a8300: 52800042    	mov	w2, #0x2                ; =2
1002a8304: d2800003    	mov	x3, #0x0                ; =0
1002a8308: 52800004    	mov	w4, #0x0                ; =0
1002a830c: 52800686    	mov	w6, #0x34               ; =52
1002a8310: 95e5fe55    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a8314: 3941b688    	ldrb	w8, [x20, #0x6d]
1002a8318: 37000328    	tbnz	w8, #0x0, 0x1002a837c <__text+0x2a037c>
1002a831c: 3941ba88    	ldrb	w8, [x20, #0x6e]
1002a8320: 7100051f    	cmp	w8, #0x1
1002a8324: 540002c1    	b.ne	0x1002a837c <__text+0x2a037c>
1002a8328: 900ea528    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a832c: f9449908    	ldr	x8, [x8, #0x930]
1002a8330: f90013e8    	str	x8, [sp, #0x20]
1002a8334: f00bb0e8    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1002a8338: fd434100    	ldr	d0, [x8, #0x680]
1002a833c: f0000008    	adrp	x8, 0x1002ab000 <__text+0x2a3000>
1002a8340: 91174108    	add	x8, x8, #0x5d0
1002a8344: fd0017e0    	str	d0, [sp, #0x28]
1002a8348: b00dfec9    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
1002a834c: 91256129    	add	x9, x9, #0x958
1002a8350: a90327e8    	stp	x8, x9, [sp, #0x30]
1002a8354: f90027f4    	str	x20, [sp, #0x48]
1002a8358: aa1303e0    	mov	x0, x19
1002a835c: 95e5fe46    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002a8360: f90023f3    	str	x19, [sp, #0x40]
1002a8364: 900ea520    	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002a8368: f9454c00    	ldr	x0, [x0, #0xa98]
1002a836c: 910083e1    	add	x1, sp, #0x20
1002a8370: 95e5920b    	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
1002a8374: f94023e0    	ldr	x0, [sp, #0x40]
1002a8378: 95e5fe3e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a837c: d10123a0    	sub	x0, x29, #0x48
1002a8380: 95e59229    	bl	0x107c0cc24 <_Flutter_MMFoundation_BindContext+0x3e938f0>
1002a8384: aa1303e0    	mov	x0, x19
1002a8388: 95e5fe3a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a838c: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
1002a8390: a9494ff4    	ldp	x20, x19, [sp, #0x90]
1002a8394: a94857f6    	ldp	x22, x21, [sp, #0x80]
1002a8398: a9475ff8    	ldp	x24, x23, [sp, #0x70]
1002a839c: 9102c3ff    	add	sp, sp, #0xb0
1002a83a0: d65f03c0    	ret
