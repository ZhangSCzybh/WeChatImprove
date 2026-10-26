
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9954: d101c3ff    	sub	sp, sp, #0x70
1029c9958: a90267fa    	stp	x26, x25, [sp, #0x20]
1029c995c: a9035ff8    	stp	x24, x23, [sp, #0x30]
1029c9960: a90457f6    	stp	x22, x21, [sp, #0x40]
1029c9964: a9054ff4    	stp	x20, x19, [sp, #0x50]
1029c9968: a9067bfd    	stp	x29, x30, [sp, #0x60]
1029c996c: 910183fd    	add	x29, sp, #0x60
1029c9970: aa0303f4    	mov	x20, x3
1029c9974: aa0203f3    	mov	x19, x2
1029c9978: aa0003f7    	mov	x23, x0
1029c997c: b00f1368    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029c9980: 52800029    	mov	w9, #0x1                ; =1
1029c9984: 39351909    	strb	w9, [x8, #0xd46]
1029c9988: aa0203e0    	mov	x0, x2
1029c998c: 954975eb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c9990: aa1403e0    	mov	x0, x20
1029c9994: 954975e9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c9998: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c999c: f941dd01    	ldr	x1, [x8, #0x3b8] ; pathOfTrashFolder
1029c99a0: aa1703e0    	mov	x0, x23
1029c99a4: 954975e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c99a8: aa1d03fd    	mov	x29, x29
1029c99ac: 954975e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c99b0: aa0003f5    	mov	x21, x0
1029c99b4: d00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c99b8: f946e918    	ldr	x24, [x8, #0xdd0] ; length
1029c99bc: aa1803e1    	mov	x1, x24
1029c99c0: 954975df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c99c4: b4000ac0    	cbz	x0, 0x1029c9b1c <_Flutter_Image_provideRelativePathByUrl+0xdd69cc>
1029c99c8: d00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c99cc: f9466501    	ldr	x1, [x8, #0xcc8] ; lastPathComponent
1029c99d0: aa1303e0    	mov	x0, x19
1029c99d4: 954975da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c99d8: aa1d03fd    	mov	x29, x29
1029c99dc: 954975db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c99e0: aa0003f6    	mov	x22, x0
1029c99e4: aa1803e1    	mov	x1, x24
1029c99e8: 954975d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c99ec: b4000be0    	cbz	x0, 0x1029c9b68 <_Flutter_Image_provideRelativePathByUrl+0xdd6a18>
1029c99f0: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c99f4: f9454518    	ldr	x24, [x8, #0xa88]
1029c99f8: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c99fc: f941cd01    	ldr	x1, [x8, #0x398] ; randomInt
1029c9a00: aa1703e0    	mov	x0, x23
1029c9a04: 954975ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9a08: b00eba08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c9a0c: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1029c9a10: a900dbe0    	stp	x0, x22, [sp, #0x8]
1029c9a14: f90003f5    	str	x21, [sp]
1029c9a18: 900de582    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9a1c: 91012042    	add	x2, x2, #0x48
1029c9a20: aa1803e0    	mov	x0, x24
1029c9a24: 954975c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9a28: aa1d03fd    	mov	x29, x29
1029c9a2c: 954975c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9a30: aa0003f8    	mov	x24, x0
1029c9a34: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9a38: f941d101    	ldr	x1, [x8, #0x3a0] ; pathExist:
1029c9a3c: aa1703e0    	mov	x0, x23
1029c9a40: aa1803e2    	mov	x2, x24
1029c9a44: 954975be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9a48: d00ebd5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9a4c: 900ea399    	adrp	x25, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c9a50: 340002e0    	cbz	w0, 0x1029c9aac <_Flutter_Image_provideRelativePathByUrl+0xdd695c>
1029c9a54: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9a58: f941d501    	ldr	x1, [x8, #0x3a8] ; removePath:
1029c9a5c: aa1703e0    	mov	x0, x23
1029c9a60: aa1803e2    	mov	x2, x24
1029c9a64: 954975b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9a68: f9453748    	ldr	x8, [x26, #0xa68]
1029c9a6c: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c9a70: a90083f8    	stp	x24, x0, [sp, #0x8]
1029c9a74: 900de589    	adrp	x9, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9a78: 9104a129    	add	x9, x9, #0x128
1029c9a7c: f90003e9    	str	x9, [sp]
1029c9a80: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9a84: 9125d063    	add	x3, x3, #0x974
1029c9a88: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9a8c: 911554a5    	add	x5, x5, #0x555
1029c9a90: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9a94: 9127c4e7    	add	x7, x7, #0x9f1
1029c9a98: aa0803e0    	mov	x0, x8
1029c9a9c: 52800062    	mov	w2, #0x3                ; =3
1029c9aa0: 52800004    	mov	w4, #0x0                ; =0
1029c9aa4: 52802086    	mov	w6, #0x104              ; =260
1029c9aa8: 954975a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9aac: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9ab0: f941d901    	ldr	x1, [x8, #0x3b0] ; movePath:to:
1029c9ab4: aa1703e0    	mov	x0, x23
1029c9ab8: aa1303e2    	mov	x2, x19
1029c9abc: aa1803e3    	mov	x3, x24
1029c9ac0: 9549759f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9ac4: aa0003e8    	mov	x8, x0
1029c9ac8: f9453740    	ldr	x0, [x26, #0xa68]
1029c9acc: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c9ad0: 34000728    	cbz	w8, 0x1029c9bb4 <_Flutter_Image_provideRelativePathByUrl+0xdd6a64>
1029c9ad4: a90163f3    	stp	x19, x24, [sp, #0x10]
1029c9ad8: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9adc: 91052108    	add	x8, x8, #0x148
1029c9ae0: a90053e8    	stp	x8, x20, [sp]
1029c9ae4: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9ae8: 9125d063    	add	x3, x3, #0x974
1029c9aec: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9af0: 911554a5    	add	x5, x5, #0x555
1029c9af4: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9af8: 9127c4e7    	add	x7, x7, #0x9f1
1029c9afc: 52800042    	mov	w2, #0x2                ; =2
1029c9b00: 52800004    	mov	w4, #0x0                ; =0
1029c9b04: 52802126    	mov	w6, #0x109              ; =265
1029c9b08: 9549758d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9b0c: aa1803e0    	mov	x0, x24
1029c9b10: 9549758a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c9b14: aa1803f7    	mov	x23, x24
1029c9b18: 14000036    	b	0x1029c9bf0 <_Flutter_Image_provideRelativePathByUrl+0xdd6aa0>
1029c9b1c: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9b20: f9453500    	ldr	x0, [x8, #0xa68]
1029c9b24: 900ea388    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c9b28: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c9b2c: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9b30: 9103a108    	add	x8, x8, #0xe8
1029c9b34: f90003e8    	str	x8, [sp]
1029c9b38: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9b3c: 9125d063    	add	x3, x3, #0x974
1029c9b40: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9b44: 911554a5    	add	x5, x5, #0x555
1029c9b48: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9b4c: 9127c4e7    	add	x7, x7, #0x9f1
1029c9b50: 52800022    	mov	w2, #0x1                ; =1
1029c9b54: 52800004    	mov	w4, #0x0                ; =0
1029c9b58: 52801ec6    	mov	w6, #0xf6               ; =246
1029c9b5c: 95497578    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9b60: d2800017    	mov	x23, #0x0               ; =0
1029c9b64: 14000027    	b	0x1029c9c00 <_Flutter_Image_provideRelativePathByUrl+0xdd6ab0>
1029c9b68: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9b6c: f9453500    	ldr	x0, [x8, #0xa68]
1029c9b70: 900ea388    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c9b74: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c9b78: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9b7c: 91042108    	add	x8, x8, #0x108
1029c9b80: a9004fe8    	stp	x8, x19, [sp]
1029c9b84: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9b88: 9125d063    	add	x3, x3, #0x974
1029c9b8c: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9b90: 911554a5    	add	x5, x5, #0x555
1029c9b94: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9b98: 9127c4e7    	add	x7, x7, #0x9f1
1029c9b9c: 52800022    	mov	w2, #0x1                ; =1
1029c9ba0: 52800004    	mov	w4, #0x0                ; =0
1029c9ba4: 52801f86    	mov	w6, #0xfc               ; =252
1029c9ba8: 95497565    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9bac: d2800017    	mov	x23, #0x0               ; =0
1029c9bb0: 14000012    	b	0x1029c9bf8 <_Flutter_Image_provideRelativePathByUrl+0xdd6aa8>
1029c9bb4: a90163f3    	stp	x19, x24, [sp, #0x10]
1029c9bb8: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9bbc: 9105a108    	add	x8, x8, #0x168
1029c9bc0: a90053e8    	stp	x8, x20, [sp]
1029c9bc4: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9bc8: 9125d063    	add	x3, x3, #0x974
1029c9bcc: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9bd0: 911554a5    	add	x5, x5, #0x555
1029c9bd4: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9bd8: 9127c4e7    	add	x7, x7, #0x9f1
1029c9bdc: 52800082    	mov	w2, #0x4                ; =4
1029c9be0: 52800004    	mov	w4, #0x0                ; =0
1029c9be4: 528021a6    	mov	w6, #0x10d              ; =269
1029c9be8: 95497555    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9bec: d2800017    	mov	x23, #0x0               ; =0
1029c9bf0: aa1803e0    	mov	x0, x24
1029c9bf4: 95497558    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9bf8: aa1603e0    	mov	x0, x22
1029c9bfc: 95497556    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9c00: aa1503e0    	mov	x0, x21
1029c9c04: 95497554    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9c08: aa1403e0    	mov	x0, x20
1029c9c0c: 95497552    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9c10: aa1303e0    	mov	x0, x19
1029c9c14: 95497550    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9c18: aa1703e0    	mov	x0, x23
1029c9c1c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1029c9c20: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1029c9c24: a94457f6    	ldp	x22, x21, [sp, #0x40]
1029c9c28: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1029c9c2c: a94267fa    	ldp	x26, x25, [sp, #0x20]
1029c9c30: 9101c3ff    	add	sp, sp, #0x70
1029c9c34: 1549754f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
