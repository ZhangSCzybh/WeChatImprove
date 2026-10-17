
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c3d8ec: d10183ff    	sub	sp, sp, #0x60
101c3d8f0: a9025ff8    	stp	x24, x23, [sp, #0x20]
101c3d8f4: a90357f6    	stp	x22, x21, [sp, #0x30]
101c3d8f8: a9044ff4    	stp	x20, x19, [sp, #0x40]
101c3d8fc: a9057bfd    	stp	x29, x30, [sp, #0x50]
101c3d900: 910143fd    	add	x29, sp, #0x50
101c3d904: aa0503f6    	mov	x22, x5
101c3d908: aa0403f4    	mov	x20, x4
101c3d90c: aa0303f7    	mov	x23, x3
101c3d910: aa0203f3    	mov	x19, x2
101c3d914: aa0003f8    	mov	x24, x0
101c3d918: d00dcd88    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c3d91c: f9405908    	ldr	x8, [x8, #0xb0]
101c3d920: f9400108    	ldr	x8, [x8]
101c3d924: f9000fe8    	str	x8, [sp, #0x18]
101c3d928: d00f7fa8    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c3d92c: 52800029    	mov	w9, #0x1                ; =1
101c3d930: 39268d09    	strb	w9, [x8, #0x9a3]
101c3d934: aa0203e0    	mov	x0, x2
101c3d938: 957fa600    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3d93c: aa1403e0    	mov	x0, x20
101c3d940: 957fa5fe    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3d944: b4000a53    	cbz	x19, 0x101c3da8c <_Flutter_Image_provideRelativePathByUrl+0x4a93c>
101c3d948: f00f2da8    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c3d94c: b989e915    	ldrsw	x21, [x8, #0x9e8]
101c3d950: aa1703e0    	mov	x0, x23
101c3d954: 957fa5f9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c3d958: 8b150300    	add	x0, x24, x21
101c3d95c: aa1703e1    	mov	x1, x23
101c3d960: 957fa60d    	bl	0x107c27194 <_Flutter_MMFoundation_BindContext+0x4102d78>
101c3d964: f00f1388    	adrp	x8, 0x11feb0000 <dyld_stub_binder+0x11feb0000>
101c3d968: f942dd01    	ldr	x1, [x8, #0x5b8] ; currentLogicController
101c3d96c: aa1803e0    	mov	x0, x24
101c3d970: 957fa5f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d974: aa1d03fd    	mov	x29, x29
101c3d978: 957fa5f4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d97c: aa0003f5    	mov	x21, x0
101c3d980: 900f1408    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c3d984: f940d501    	ldr	x1, [x8, #0x1a8] ; configureForwardSuccessToastIfNeededForLogic:fromViewController:
101c3d988: aa1803e0    	mov	x0, x24
101c3d98c: aa1503e2    	mov	x2, x21
101c3d990: aa1703e3    	mov	x3, x23
101c3d994: 957fa5ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d998: aa1703e0    	mov	x0, x23
101c3d99c: 957fa5ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d9a0: 900f1008    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
101c3d9a4: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
101c3d9a8: aa1303e0    	mov	x0, x19
101c3d9ac: 957fa5e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d9b0: aa1d03fd    	mov	x29, x29
101c3d9b4: 957fa5e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3d9b8: aa0003f7    	mov	x23, x0
101c3d9bc: d00f1248    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
101c3d9c0: f9479d01    	ldr	x1, [x8, #0xf38] ; setFromContactUserName:
101c3d9c4: aa1503e0    	mov	x0, x21
101c3d9c8: aa1703e2    	mov	x2, x23
101c3d9cc: 957fa5dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d9d0: aa1703e0    	mov	x0, x23
101c3d9d4: 957fa5e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3d9d8: d00f1068    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c3d9dc: f941bd01    	ldr	x1, [x8, #0x378] ; setM_forwardType:
101c3d9e0: aa1503e0    	mov	x0, x21
101c3d9e4: aa1603e2    	mov	x2, x22
101c3d9e8: 957fa5d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3d9ec: b4000434    	cbz	x20, 0x101c3da70 <_Flutter_Image_provideRelativePathByUrl+0x4a920>
101c3d9f0: f9000bf3    	str	x19, [sp, #0x10]
101c3d9f4: d00f29b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
101c3d9f8: f9456f00    	ldr	x0, [x24, #0xad8]
101c3d9fc: d00f2608    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c3da00: f941c516    	ldr	x22, [x8, #0x388] ; arrayWithObjects:count:
101c3da04: 910043e2    	add	x2, sp, #0x10
101c3da08: aa1603e1    	mov	x1, x22
101c3da0c: 52800023    	mov	w3, #0x1                ; =1
101c3da10: 957fa5cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3da14: aa1d03fd    	mov	x29, x29
101c3da18: 957fa5cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3da1c: aa0003f7    	mov	x23, x0
101c3da20: f90007f4    	str	x20, [sp, #0x8]
101c3da24: f9456f00    	ldr	x0, [x24, #0xad8]
101c3da28: 910023e2    	add	x2, sp, #0x8
101c3da2c: aa1603e1    	mov	x1, x22
101c3da30: 52800023    	mov	w3, #0x1                ; =1
101c3da34: 957fa5c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3da38: aa1d03fd    	mov	x29, x29
101c3da3c: 957fa5c3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c3da40: aa0003f6    	mov	x22, x0
101c3da44: d00f12a8    	adrp	x8, 0x11fe93000 <dyld_stub_binder+0x11fe93000>
101c3da48: f9434101    	ldr	x1, [x8, #0x680] ; forwardMsgList:toContacts:
101c3da4c: aa1503e0    	mov	x0, x21
101c3da50: aa1703e2    	mov	x2, x23
101c3da54: aa1603e3    	mov	x3, x22
101c3da58: 957fa5b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3da5c: aa1603e0    	mov	x0, x22
101c3da60: 957fa5bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3da64: aa1703e0    	mov	x0, x23
101c3da68: 957fa5bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3da6c: 14000006    	b	0x101c3da84 <_Flutter_Image_provideRelativePathByUrl+0x4a934>
101c3da70: b00f10c8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
101c3da74: f946ad01    	ldr	x1, [x8, #0xd58] ; forwardMessage:
101c3da78: aa1503e0    	mov	x0, x21
101c3da7c: aa1303e2    	mov	x2, x19
101c3da80: 957fa5af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c3da84: aa1503e0    	mov	x0, x21
101c3da88: 957fa5b3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3da8c: aa1403e0    	mov	x0, x20
101c3da90: 957fa5b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3da94: aa1303e0    	mov	x0, x19
101c3da98: 957fa5af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c3da9c: f9400fe8    	ldr	x8, [sp, #0x18]
101c3daa0: d00dcd89    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
101c3daa4: f9405929    	ldr	x9, [x9, #0xb0]
101c3daa8: f9400129    	ldr	x9, [x9]
101c3daac: eb08013f    	cmp	x9, x8
101c3dab0: 540000e1    	b.ne	0x101c3dacc <_Flutter_Image_provideRelativePathByUrl+0x4a97c>
101c3dab4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101c3dab8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101c3dabc: a94357f6    	ldp	x22, x21, [sp, #0x30]
101c3dac0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
101c3dac4: 910183ff    	add	sp, sp, #0x60
101c3dac8: d65f03c0    	ret
101c3dacc: 957fa5aa    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>