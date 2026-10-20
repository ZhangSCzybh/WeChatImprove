
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a09b4c0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10a09b4c4: a9014ff4    	stp	x20, x19, [sp, #0x10]
10a09b4c8: a9027bfd    	stp	x29, x30, [sp, #0x20]
10a09b4cc: 910083fd    	add	x29, sp, #0x20
10a09b4d0: aa0303f4    	mov	x20, x3
10a09b4d4: aa0203f3    	mov	x19, x2
10a09b4d8: aa0203e0    	mov	x0, x2
10a09b4dc: 955effd9    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a09b4e0: f100069f    	cmp	x20, #0x1
10a09b4e4: 5400024b    	b.lt	0x10a09b52c <_Flutter_MMFoundation_BindContext+0x6577110>
10a09b4e8: f00aedc8    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a09b4ec: f9447501    	ldr	x1, [x8, #0x8e8] ; likeCount
10a09b4f0: aa1303e0    	mov	x0, x19
10a09b4f4: 955effd4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b4f8: aa0003f5    	mov	x21, x0
10a09b4fc: f00aede8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a09b500: f9465501    	ldr	x1, [x8, #0xca8] ; commentCount
10a09b504: aa1303e0    	mov	x0, x19
10a09b508: 955effcf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a09b50c: 710006bf    	cmp	w21, #0x1
10a09b510: 5400008b    	b.lt	0x10a09b520 <_Flutter_MMFoundation_BindContext+0x6577104>
10a09b514: 11000408    	add	w8, w0, #0x1
10a09b518: 93407d08    	sxtw	x8, w8
10a09b51c: 14000002    	b	0x10a09b524 <_Flutter_MMFoundation_BindContext+0x6577108>
10a09b520: 93407c08    	sxtw	x8, w0
10a09b524: eb14011f    	cmp	x8, x20
10a09b528: 5400006a    	b.ge	0x10a09b534 <_Flutter_MMFoundation_BindContext+0x6577118>
10a09b52c: 52800014    	mov	w20, #0x0               ; =0
10a09b530: 14000002    	b	0x10a09b538 <_Flutter_MMFoundation_BindContext+0x657711c>
10a09b534: 52800034    	mov	w20, #0x1               ; =1
10a09b538: aa1303e0    	mov	x0, x19
10a09b53c: 955effc8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a09b540: aa1403e0    	mov	x0, x20
10a09b544: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10a09b548: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10a09b54c: a8c357f6    	ldp	x22, x21, [sp], #0x30
10a09b550: d65f03c0    	ret
