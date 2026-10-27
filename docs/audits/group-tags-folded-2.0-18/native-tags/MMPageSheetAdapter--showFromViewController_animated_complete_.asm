
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167903e0: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1167903e4: a90167fa    	stp	x26, x25, [sp, #0x10]
1167903e8: a9025ff8    	stp	x24, x23, [sp, #0x20]
1167903ec: a90357f6    	stp	x22, x21, [sp, #0x30]
1167903f0: a9044ff4    	stp	x20, x19, [sp, #0x40]
1167903f4: a9057bfd    	stp	x29, x30, [sp, #0x50]
1167903f8: 910143fd    	add	x29, sp, #0x50
1167903fc: aa0403f4    	mov	x20, x4
116790400: aa0303f5    	mov	x21, x3
116790404: aa0203f3    	mov	x19, x2
116790408: aa0003f6    	mov	x22, x0
11679040c: aa0203e0    	mov	x0, x2
116790410: 946e6658    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116790414: aa1403e0    	mov	x0, x20
116790418: 946e6656    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
11679041c: f004cae8    	adrp	x8, 0x1200ef000 <dyld_stub_binder+0x1200ef000>
116790420: f943e501    	ldr	x1, [x8, #0x7c8] ; callbackPresentWillBegin
116790424: aa1603e0    	mov	x0, x22
116790428: 946e6631    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11679042c: f9400ec8    	ldr	x8, [x22, #0x18]
116790430: b50001a8    	cbnz	x8, 0x116790464 <_O266DecReleaseOutputPicture+0x35039ac>
116790434: b004cf28    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
116790438: f940f500    	ldr	x0, [x8, #0x1e8]
11679043c: 946e65d5    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
116790440: f9400ec8    	ldr	x8, [x22, #0x18]
116790444: f9000ec0    	str	x0, [x22, #0x18]
116790448: aa0803e0    	mov	x0, x8
11679044c: 946e6643    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790450: f9400ec0    	ldr	x0, [x22, #0x18]
116790454: d004cae8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116790458: f9406901    	ldr	x1, [x8, #0xd0] ; setupWithProvider:
11679045c: aa1603e2    	mov	x2, x22
116790460: 946e6623    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790464: 9004cb88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116790468: f946f117    	ldr	x23, [x8, #0xde0] ; delegate
11679046c: aa1603e0    	mov	x0, x22
116790470: aa1703e1    	mov	x1, x23
116790474: 946e661e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790478: aa1d03fd    	mov	x29, x29
11679047c: 946e6646    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116790480: b4000400    	cbz	x0, 0x116790500 <_O266DecReleaseOutputPicture+0x3503a48>
116790484: aa0003f9    	mov	x25, x0
116790488: aa1603e0    	mov	x0, x22
11679048c: aa1703e1    	mov	x1, x23
116790490: 946e6617    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790494: aa1d03fd    	mov	x29, x29
116790498: 946e663f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11679049c: aa0003fa    	mov	x26, x0
1167904a0: f004cae8    	adrp	x8, 0x1200ef000 <dyld_stub_binder+0x1200ef000>
1167904a4: f943e918    	ldr	x24, [x8, #0x7d0] ; pageSheetWillBePresentFrom:inContainer:
1167904a8: d004cba8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1167904ac: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1167904b0: aa1803e2    	mov	x2, x24
1167904b4: 946e660e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167904b8: aa0003fb    	mov	x27, x0
1167904bc: aa1a03e0    	mov	x0, x26
1167904c0: 946e6626    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167904c4: aa1903e0    	mov	x0, x25
1167904c8: 946e6624    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167904cc: 340001bb    	cbz	w27, 0x116790500 <_O266DecReleaseOutputPicture+0x3503a48>
1167904d0: aa1603e0    	mov	x0, x22
1167904d4: aa1703e1    	mov	x1, x23
1167904d8: 946e6605    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167904dc: aa1d03fd    	mov	x29, x29
1167904e0: 946e662d    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167904e4: aa0003f7    	mov	x23, x0
1167904e8: f9400ec3    	ldr	x3, [x22, #0x18]
1167904ec: aa1803e1    	mov	x1, x24
1167904f0: aa1303e2    	mov	x2, x19
1167904f4: 946e65fe    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167904f8: aa1703e0    	mov	x0, x23
1167904fc: 946e6617    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790500: f9400ec0    	ldr	x0, [x22, #0x18]
116790504: d004cae8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116790508: f9406d01    	ldr	x1, [x8, #0xd8] ; showPageSheetAnimated:parentView:parentViewController:complete:
11679050c: aa1503e2    	mov	x2, x21
116790510: d2800003    	mov	x3, #0x0                ; =0
116790514: aa1303e4    	mov	x4, x19
116790518: aa1403e5    	mov	x5, x20
11679051c: 946e65f4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790520: aa1403e0    	mov	x0, x20
116790524: 946e660d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790528: aa1303e0    	mov	x0, x19
11679052c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
116790530: a9444ff4    	ldp	x20, x19, [sp, #0x40]
116790534: a94357f6    	ldp	x22, x21, [sp, #0x30]
116790538: a9425ff8    	ldp	x24, x23, [sp, #0x20]
11679053c: a94167fa    	ldp	x26, x25, [sp, #0x10]
116790540: a8c66ffc    	ldp	x28, x27, [sp], #0x60
116790544: 146e6605    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
