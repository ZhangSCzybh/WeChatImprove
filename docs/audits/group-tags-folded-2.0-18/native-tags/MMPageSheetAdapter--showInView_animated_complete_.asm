
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116790244: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
116790248: a90167fa    	stp	x26, x25, [sp, #0x10]
11679024c: a9025ff8    	stp	x24, x23, [sp, #0x20]
116790250: a90357f6    	stp	x22, x21, [sp, #0x30]
116790254: a9044ff4    	stp	x20, x19, [sp, #0x40]
116790258: a9057bfd    	stp	x29, x30, [sp, #0x50]
11679025c: 910143fd    	add	x29, sp, #0x50
116790260: aa0403f4    	mov	x20, x4
116790264: aa0303f5    	mov	x21, x3
116790268: aa0203f3    	mov	x19, x2
11679026c: aa0003f6    	mov	x22, x0
116790270: aa0203e0    	mov	x0, x2
116790274: 946e66bf    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116790278: aa1403e0    	mov	x0, x20
11679027c: 946e66bd    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116790280: f004cae8    	adrp	x8, 0x1200ef000 <dyld_stub_binder+0x1200ef000>
116790284: f943e501    	ldr	x1, [x8, #0x7c8] ; callbackPresentWillBegin
116790288: aa1603e0    	mov	x0, x22
11679028c: 946e6698    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790290: f9400ec8    	ldr	x8, [x22, #0x18]
116790294: b50001a8    	cbnz	x8, 0x1167902c8 <_O266DecReleaseOutputPicture+0x3503810>
116790298: b004d128    	adrp	x8, 0x1201b5000 <dyld_stub_binder+0x1201b5000>
11679029c: f940c900    	ldr	x0, [x8, #0x190]
1167902a0: 946e663c    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
1167902a4: f9400ec8    	ldr	x8, [x22, #0x18]
1167902a8: f9000ec0    	str	x0, [x22, #0x18]
1167902ac: aa0803e0    	mov	x0, x8
1167902b0: 946e66aa    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167902b4: f9400ec0    	ldr	x0, [x22, #0x18]
1167902b8: d004cae8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167902bc: f9406901    	ldr	x1, [x8, #0xd0] ; setupWithProvider:
1167902c0: aa1603e2    	mov	x2, x22
1167902c4: 946e668a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167902c8: d004b668    	adrp	x8, 0x11fe5e000 <dyld_stub_binder+0x11fe5e000>
1167902cc: f9408101    	ldr	x1, [x8, #0x100] ; findViewController
1167902d0: aa1303e0    	mov	x0, x19
1167902d4: 946e6686    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167902d8: aa1d03fd    	mov	x29, x29
1167902dc: 946e66ae    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167902e0: aa0003f7    	mov	x23, x0
1167902e4: 9004cb88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1167902e8: f946f118    	ldr	x24, [x8, #0xde0] ; delegate
1167902ec: aa1603e0    	mov	x0, x22
1167902f0: aa1803e1    	mov	x1, x24
1167902f4: 946e667e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167902f8: aa1d03fd    	mov	x29, x29
1167902fc: 946e66a6    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116790300: b4000400    	cbz	x0, 0x116790380 <_O266DecReleaseOutputPicture+0x35038c8>
116790304: aa0003fa    	mov	x26, x0
116790308: aa1603e0    	mov	x0, x22
11679030c: aa1803e1    	mov	x1, x24
116790310: 946e6677    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790314: aa1d03fd    	mov	x29, x29
116790318: 946e669f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11679031c: aa0003fb    	mov	x27, x0
116790320: f004cae8    	adrp	x8, 0x1200ef000 <dyld_stub_binder+0x1200ef000>
116790324: f943e919    	ldr	x25, [x8, #0x7d0] ; pageSheetWillBePresentFrom:inContainer:
116790328: d004cba8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
11679032c: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
116790330: aa1903e2    	mov	x2, x25
116790334: 946e666e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790338: aa0003fc    	mov	x28, x0
11679033c: aa1b03e0    	mov	x0, x27
116790340: 946e6686    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790344: aa1a03e0    	mov	x0, x26
116790348: 946e6684    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11679034c: 340001bc    	cbz	w28, 0x116790380 <_O266DecReleaseOutputPicture+0x35038c8>
116790350: aa1603e0    	mov	x0, x22
116790354: aa1803e1    	mov	x1, x24
116790358: 946e6665    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11679035c: aa1d03fd    	mov	x29, x29
116790360: 946e668d    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116790364: aa0003f8    	mov	x24, x0
116790368: f9400ec3    	ldr	x3, [x22, #0x18]
11679036c: aa1903e1    	mov	x1, x25
116790370: aa1703e2    	mov	x2, x23
116790374: 946e665e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790378: aa1803e0    	mov	x0, x24
11679037c: 946e6677    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790380: f9400ec0    	ldr	x0, [x22, #0x18]
116790384: d004cae8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116790388: f9406d01    	ldr	x1, [x8, #0xd8] ; showPageSheetAnimated:parentView:parentViewController:complete:
11679038c: aa1503e2    	mov	x2, x21
116790390: aa1303e3    	mov	x3, x19
116790394: d2800004    	mov	x4, #0x0                ; =0
116790398: aa1403e5    	mov	x5, x20
11679039c: 946e6654    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167903a0: aa1703e0    	mov	x0, x23
1167903a4: 946e666d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167903a8: aa1403e0    	mov	x0, x20
1167903ac: 946e666b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167903b0: aa1303e0    	mov	x0, x19
1167903b4: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1167903b8: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1167903bc: a94357f6    	ldp	x22, x21, [sp, #0x30]
1167903c0: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1167903c4: a94167fa    	ldp	x26, x25, [sp, #0x10]
1167903c8: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1167903cc: 146e6663    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
