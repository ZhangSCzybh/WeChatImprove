
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a09b444: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a09b448: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a09b44c: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a09b450: 910083fd    	add	x29, sp, #0x20
10a09b454: aa0203f3    	mov	x19, x2
10a09b458: aa0203e0    	mov	x0, x2
10a09b45c: 955efff9    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09b460: f00aedc8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a09b464: f9447501    	ldr	x1, [x8, #0x8e8] ; likeCount
10a09b468: aa1303e0    	mov	x0, x19
10a09b46c: 955efff6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b470: 7100001f    	cmp	w0, #0x0
10a09b474: 1a9fd7f4    	cset	w20, gt
10a09b478: f00aede8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a09b47c: f9465515    	ldr	x21, [x8, #0xca8] ; commentCount
10a09b480: aa1303e0    	mov	x0, x19
10a09b484: aa1503e1    	mov	x1, x21
10a09b488: 955effef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b48c: 7100041f    	cmp	w0, #0x1
10a09b490: 540000ab    	b.lt	0x10a09b4a4 <_Flutter_MMFoundation_BindContext+0x6577088>
10a09b494: aa1303e0    	mov	x0, x19
10a09b498: aa1503e1    	mov	x1, x21
10a09b49c: 955effea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b4a0: 8b20c294    	add	x20, x20, w0, sxtw
10a09b4a4: aa1303e0    	mov	x0, x19
10a09b4a8: 955effed    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09b4ac: aa1403e0    	mov	x0, x20
10a09b4b0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a09b4b4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a09b4b8: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a09b4bc: d65f03c0    	ret
