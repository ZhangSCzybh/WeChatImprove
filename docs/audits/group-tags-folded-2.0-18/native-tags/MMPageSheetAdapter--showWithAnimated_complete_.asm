
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116790068: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
11679006c: a90167fa    	stp	x26, x25, [sp, #0x10]
116790070: a9025ff8    	stp	x24, x23, [sp, #0x20]
116790074: a90357f6    	stp	x22, x21, [sp, #0x30]
116790078: a9044ff4    	stp	x20, x19, [sp, #0x40]
11679007c: a9057bfd    	stp	x29, x30, [sp, #0x50]
116790080: 910143fd    	add	x29, sp, #0x50
116790084: aa0303f3    	mov	x19, x3
116790088: aa0203f4    	mov	x20, x2
11679008c: aa0003f5    	mov	x21, x0
116790090: aa0303e0    	mov	x0, x3
116790094: 946e6737    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116790098: f004cae8    	adrp	x8, 0x1200ef000 <dyld_stub_binder+0x1200ef000>
11679009c: f943e501    	ldr	x1, [x8, #0x7c8] ; callbackPresentWillBegin
1167900a0: aa1503e0    	mov	x0, x21
1167900a4: 946e6712    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167900a8: f9400ea8    	ldr	x8, [x21, #0x18]
1167900ac: b50001a8    	cbnz	x8, 0x1167900e0 <_O266DecReleaseOutputPicture+0x3503628>
1167900b0: 9004cf68    	adrp	x8, 0x12017c000 <dyld_stub_binder+0x12017c000>
1167900b4: f9420900    	ldr	x0, [x8, #0x410]
1167900b8: 946e66b6    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
1167900bc: f9400ea8    	ldr	x8, [x21, #0x18]
1167900c0: f9000ea0    	str	x0, [x21, #0x18]
1167900c4: aa0803e0    	mov	x0, x8
1167900c8: 946e6724    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167900cc: f9400ea0    	ldr	x0, [x21, #0x18]
1167900d0: d004cae8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167900d4: f9406901    	ldr	x1, [x8, #0xd0] ; setupWithProvider:
1167900d8: aa1503e2    	mov	x2, x21
1167900dc: 946e6704    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167900e0: 9004cf48    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
1167900e4: f9420d00    	ldr	x0, [x8, #0x418] ; Ўc
1167900e8: b004b568    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1167900ec: f940f501    	ldr	x1, [x8, #0x1e8] ; externalIMP
1167900f0: 946e66ff    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167900f4: aa1d03fd    	mov	x29, x29
1167900f8: 946e6727    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167900fc: aa0003f7    	mov	x23, x0
116790100: d004cf28    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
116790104: f940a500    	ldr	x0, [x8, #0x148]
116790108: 9004b608    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
11679010c: f941b101    	ldr	x1, [x8, #0x360] ; lastActiveSceneRootWindow
116790110: 946e66f7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790114: aa1d03fd    	mov	x29, x29
116790118: 946e671f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11679011c: aa0003f8    	mov	x24, x0
116790120: b004b588    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
116790124: f943a501    	ldr	x1, [x8, #0x748] ; topViewControllerOfWindow:
116790128: aa1703e0    	mov	x0, x23
11679012c: aa1803e2    	mov	x2, x24
116790130: 946e66ef    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790134: aa1d03fd    	mov	x29, x29
116790138: 946e6717    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11679013c: aa0003f6    	mov	x22, x0
116790140: aa1803e0    	mov	x0, x24
116790144: 946e6705    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790148: aa1703e0    	mov	x0, x23
11679014c: 946e6703    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790150: 9004cb88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116790154: f946f117    	ldr	x23, [x8, #0xde0] ; delegate
116790158: aa1503e0    	mov	x0, x21
11679015c: aa1703e1    	mov	x1, x23
116790160: 946e66e3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790164: aa1d03fd    	mov	x29, x29
116790168: 946e670b    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11679016c: b4000400    	cbz	x0, 0x1167901ec <_O266DecReleaseOutputPicture+0x3503734>
116790170: aa0003f9    	mov	x25, x0
116790174: aa1503e0    	mov	x0, x21
116790178: aa1703e1    	mov	x1, x23
11679017c: 946e66dc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116790180: aa1d03fd    	mov	x29, x29
116790184: 946e6704    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116790188: aa0003fa    	mov	x26, x0
11679018c: f004cae8    	adrp	x8, 0x1200ef000 <dyld_stub_binder+0x1200ef000>
116790190: f943e918    	ldr	x24, [x8, #0x7d0] ; pageSheetWillBePresentFrom:inContainer:
116790194: d004cba8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
116790198: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
11679019c: aa1803e2    	mov	x2, x24
1167901a0: 946e66d3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167901a4: aa0003fb    	mov	x27, x0
1167901a8: aa1a03e0    	mov	x0, x26
1167901ac: 946e66eb    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167901b0: aa1903e0    	mov	x0, x25
1167901b4: 946e66e9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167901b8: 340001bb    	cbz	w27, 0x1167901ec <_O266DecReleaseOutputPicture+0x3503734>
1167901bc: aa1503e0    	mov	x0, x21
1167901c0: aa1703e1    	mov	x1, x23
1167901c4: 946e66ca    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167901c8: aa1d03fd    	mov	x29, x29
1167901cc: 946e66f2    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167901d0: aa0003f7    	mov	x23, x0
1167901d4: f9400ea3    	ldr	x3, [x21, #0x18]
1167901d8: aa1803e1    	mov	x1, x24
1167901dc: aa1603e2    	mov	x2, x22
1167901e0: 946e66c3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167901e4: aa1703e0    	mov	x0, x23
1167901e8: 946e66dc    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167901ec: f9400ea0    	ldr	x0, [x21, #0x18]
1167901f0: d004cae8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167901f4: f9406d01    	ldr	x1, [x8, #0xd8] ; showPageSheetAnimated:parentView:parentViewController:complete:
1167901f8: aa1403e2    	mov	x2, x20
1167901fc: d2800003    	mov	x3, #0x0                ; =0
116790200: d2800004    	mov	x4, #0x0                ; =0
116790204: aa1303e5    	mov	x5, x19
116790208: 946e66b9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11679020c: aa1603e0    	mov	x0, x22
116790210: 946e66d2    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116790214: aa1303e0    	mov	x0, x19
116790218: a9457bfd    	ldp	x29, x30, [sp, #0x50]
11679021c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
116790220: a94357f6    	ldp	x22, x21, [sp, #0x30]
116790224: a9425ff8    	ldp	x24, x23, [sp, #0x20]
116790228: a94167fa    	ldp	x26, x25, [sp, #0x10]
11679022c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
116790230: 146e66ca    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
