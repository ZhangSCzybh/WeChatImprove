
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029c9610: d10243ff    	sub	sp, sp, #0x90
1029c9614: a9036ffc    	stp	x28, x27, [sp, #0x30]
1029c9618: a90467fa    	stp	x26, x25, [sp, #0x40]
1029c961c: a9055ff8    	stp	x24, x23, [sp, #0x50]
1029c9620: a90657f6    	stp	x22, x21, [sp, #0x60]
1029c9624: a9074ff4    	stp	x20, x19, [sp, #0x70]
1029c9628: a9087bfd    	stp	x29, x30, [sp, #0x80]
1029c962c: 910203fd    	add	x29, sp, #0x80
1029c9630: aa0303f4    	mov	x20, x3
1029c9634: aa0203f3    	mov	x19, x2
1029c9638: aa0003f8    	mov	x24, x0
1029c963c: b00f1368    	adrp	x8, 0x120c36000 <dyld_stub_binder+0x120c36000>
1029c9640: 52800029    	mov	w9, #0x1                ; =1
1029c9644: 39351509    	strb	w9, [x8, #0xd45]
1029c9648: aa0203e0    	mov	x0, x2
1029c964c: 954976bb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c9650: aa1403e0    	mov	x0, x20
1029c9654: 954976b9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c9658: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c965c: f941c901    	ldr	x1, [x8, #0x390] ; pathOfTrashFile
1029c9660: aa1803e0    	mov	x0, x24
1029c9664: 954976b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9668: aa1d03fd    	mov	x29, x29
1029c966c: 954976b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c9670: aa0003f5    	mov	x21, x0
1029c9674: d00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c9678: f946e917    	ldr	x23, [x8, #0xdd0] ; length
1029c967c: aa1703e1    	mov	x1, x23
1029c9680: 954976af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9684: b4000ae0    	cbz	x0, 0x1029c97e0 <_Flutter_Image_provideRelativePathByUrl+0xdd6690>
1029c9688: d00eb9c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1029c968c: f9466501    	ldr	x1, [x8, #0xcc8] ; lastPathComponent
1029c9690: aa1303e0    	mov	x0, x19
1029c9694: 954976aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9698: aa1d03fd    	mov	x29, x29
1029c969c: 954976ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c96a0: aa0003f6    	mov	x22, x0
1029c96a4: aa1703e1    	mov	x1, x23
1029c96a8: 954976a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c96ac: b4000c00    	cbz	x0, 0x1029c982c <_Flutter_Image_provideRelativePathByUrl+0xdd66dc>
1029c96b0: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c96b4: f9454517    	ldr	x23, [x8, #0xa88]
1029c96b8: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c96bc: f941cd01    	ldr	x1, [x8, #0x398] ; randomInt
1029c96c0: aa1803e0    	mov	x0, x24
1029c96c4: 9549769e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c96c8: b00eba08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1029c96cc: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
1029c96d0: a900dbe0    	stp	x0, x22, [sp, #0x8]
1029c96d4: f90003f5    	str	x21, [sp]
1029c96d8: 900de582    	adrp	x2, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c96dc: 91012042    	add	x2, x2, #0x48
1029c96e0: aa1703e0    	mov	x0, x23
1029c96e4: 95497696    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c96e8: aa1d03fd    	mov	x29, x29
1029c96ec: 95497697    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1029c96f0: aa0003f7    	mov	x23, x0
1029c96f4: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c96f8: f941d101    	ldr	x1, [x8, #0x3a0] ; pathExist:
1029c96fc: aa1803e0    	mov	x0, x24
1029c9700: aa1703e2    	mov	x2, x23
1029c9704: 9549768e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9708: 900ea99b    	adrp	x27, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c970c: d00ebd5a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9710: 900ea399    	adrp	x25, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c9714: 340002c0    	cbz	w0, 0x1029c976c <_Flutter_Image_provideRelativePathByUrl+0xdd661c>
1029c9718: f941d761    	ldr	x1, [x27, #0x3a8] ; removePath:
1029c971c: aa1803e0    	mov	x0, x24
1029c9720: aa1703e2    	mov	x2, x23
1029c9724: 95497686    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9728: f9453748    	ldr	x8, [x26, #0xa68]
1029c972c: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c9730: a90083f7    	stp	x23, x0, [sp, #0x8]
1029c9734: 900de589    	adrp	x9, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9738: 9101a129    	add	x9, x9, #0x68
1029c973c: f90003e9    	str	x9, [sp]
1029c9740: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9744: 9125d063    	add	x3, x3, #0x974
1029c9748: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c974c: 911554a5    	add	x5, x5, #0x555
1029c9750: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9754: 91221ce7    	add	x7, x7, #0x887
1029c9758: aa0803e0    	mov	x0, x8
1029c975c: 52800062    	mov	w2, #0x3                ; =3
1029c9760: 52800004    	mov	w4, #0x0                ; =0
1029c9764: 52801c26    	mov	w6, #0xe1               ; =225
1029c9768: 95497675    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c976c: 900ea988    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
1029c9770: f941d901    	ldr	x1, [x8, #0x3b0] ; movePath:to:
1029c9774: aa1803e0    	mov	x0, x24
1029c9778: aa1303e2    	mov	x2, x19
1029c977c: aa1703e3    	mov	x3, x23
1029c9780: 9549766f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9784: 340007a0    	cbz	w0, 0x1029c9878 <_Flutter_Image_provideRelativePathByUrl+0xdd6728>
1029c9788: f941d761    	ldr	x1, [x27, #0x3a8] ; removePath:
1029c978c: aa1803e0    	mov	x0, x24
1029c9790: aa1703e2    	mov	x2, x23
1029c9794: 9549766a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9798: aa0003e8    	mov	x8, x0
1029c979c: f9453740    	ldr	x0, [x26, #0xa68]
1029c97a0: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c97a4: 34000908    	cbz	w8, 0x1029c98c4 <_Flutter_Image_provideRelativePathByUrl+0xdd6774>
1029c97a8: a9015ff3    	stp	x19, x23, [sp, #0x10]
1029c97ac: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c97b0: 91022108    	add	x8, x8, #0x88
1029c97b4: a90053e8    	stp	x8, x20, [sp]
1029c97b8: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c97bc: 9125d063    	add	x3, x3, #0x974
1029c97c0: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c97c4: 911554a5    	add	x5, x5, #0x555
1029c97c8: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c97cc: 91221ce7    	add	x7, x7, #0x887
1029c97d0: 52800042    	mov	w2, #0x2                ; =2
1029c97d4: 52800004    	mov	w4, #0x0                ; =0
1029c97d8: 52801d26    	mov	w6, #0xe9               ; =233
1029c97dc: 14000047    	b	0x1029c98f8 <_Flutter_Image_provideRelativePathByUrl+0xdd67a8>
1029c97e0: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c97e4: f9453500    	ldr	x0, [x8, #0xa68]
1029c97e8: 900ea388    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c97ec: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c97f0: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c97f4: 91002108    	add	x8, x8, #0x8
1029c97f8: f90003e8    	str	x8, [sp]
1029c97fc: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9800: 9125d063    	add	x3, x3, #0x974
1029c9804: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9808: 911554a5    	add	x5, x5, #0x555
1029c980c: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9810: 91221ce7    	add	x7, x7, #0x887
1029c9814: 52800022    	mov	w2, #0x1                ; =1
1029c9818: 52800004    	mov	w4, #0x0                ; =0
1029c981c: 52801a86    	mov	w6, #0xd4               ; =212
1029c9820: 95497647    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9824: d2800018    	mov	x24, #0x0               ; =0
1029c9828: 1400003c    	b	0x1029c9918 <_Flutter_Image_provideRelativePathByUrl+0xdd67c8>
1029c982c: d00ebd48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1029c9830: f9453500    	ldr	x0, [x8, #0xa68]
1029c9834: 900ea388    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1029c9838: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c983c: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c9840: 9100a108    	add	x8, x8, #0x28
1029c9844: a9004fe8    	stp	x8, x19, [sp]
1029c9848: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c984c: 9125d063    	add	x3, x3, #0x974
1029c9850: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c9854: 911554a5    	add	x5, x5, #0x555
1029c9858: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c985c: 91221ce7    	add	x7, x7, #0x887
1029c9860: 52800022    	mov	w2, #0x1                ; =1
1029c9864: 52800004    	mov	w4, #0x0                ; =0
1029c9868: 52801b46    	mov	w6, #0xda               ; =218
1029c986c: 95497634    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c9870: d2800018    	mov	x24, #0x0               ; =0
1029c9874: 14000027    	b	0x1029c9910 <_Flutter_Image_provideRelativePathByUrl+0xdd67c0>
1029c9878: f9453740    	ldr	x0, [x26, #0xa68]
1029c987c: f942ab21    	ldr	x1, [x25, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1029c9880: a901fff7    	stp	x23, xzr, [sp, #0x18]
1029c9884: a900cff4    	stp	x20, x19, [sp, #0x8]
1029c9888: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c988c: 91032108    	add	x8, x8, #0xc8
1029c9890: f90003e8    	str	x8, [sp]
1029c9894: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c9898: 9125d063    	add	x3, x3, #0x974
1029c989c: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c98a0: 911554a5    	add	x5, x5, #0x555
1029c98a4: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c98a8: 91221ce7    	add	x7, x7, #0x887
1029c98ac: 52800082    	mov	w2, #0x4                ; =4
1029c98b0: 52800004    	mov	w4, #0x0                ; =0
1029c98b4: 52801de6    	mov	w6, #0xef               ; =239
1029c98b8: 95497621    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c98bc: d2800018    	mov	x24, #0x0               ; =0
1029c98c0: 14000012    	b	0x1029c9908 <_Flutter_Image_provideRelativePathByUrl+0xdd67b8>
1029c98c4: a9015ff3    	stp	x19, x23, [sp, #0x10]
1029c98c8: 900de588    	adrp	x8, 0x11e679000 <dyld_stub_binder+0x11e679000>
1029c98cc: 9102a108    	add	x8, x8, #0xa8
1029c98d0: a90053e8    	stp	x8, x20, [sp]
1029c98d4: f00c5d83    	adrp	x3, 0x11b57c000 <dyld_stub_binder+0x11b57c000>
1029c98d8: 9125d063    	add	x3, x3, #0x974
1029c98dc: d00c5de5    	adrp	x5, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c98e0: 911554a5    	add	x5, x5, #0x555
1029c98e4: d00c5de7    	adrp	x7, 0x11b587000 <dyld_stub_binder+0x11b587000>
1029c98e8: 91221ce7    	add	x7, x7, #0x887
1029c98ec: 52800082    	mov	w2, #0x4                ; =4
1029c98f0: 52800004    	mov	w4, #0x0                ; =0
1029c98f4: 52801d86    	mov	w6, #0xec               ; =236
1029c98f8: 95497611    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029c98fc: aa1703e0    	mov	x0, x23
1029c9900: 9549760e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1029c9904: aa1703f8    	mov	x24, x23
1029c9908: aa1703e0    	mov	x0, x23
1029c990c: 95497612    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9910: aa1603e0    	mov	x0, x22
1029c9914: 95497610    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9918: aa1503e0    	mov	x0, x21
1029c991c: 9549760e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9920: aa1403e0    	mov	x0, x20
1029c9924: 9549760c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9928: aa1303e0    	mov	x0, x19
1029c992c: 9549760a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1029c9930: aa1803e0    	mov	x0, x24
1029c9934: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1029c9938: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1029c993c: a94657f6    	ldp	x22, x21, [sp, #0x60]
1029c9940: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1029c9944: a94467fa    	ldp	x26, x25, [sp, #0x40]
1029c9948: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1029c994c: 910243ff    	add	sp, sp, #0x90
1029c9950: 15497608    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
