
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047a90ac: d10203ff    	sub	sp, sp, #0x80
1047a90b0: a9026ffc    	stp	x28, x27, [sp, #0x20]
1047a90b4: a90367fa    	stp	x26, x25, [sp, #0x30]
1047a90b8: a9045ff8    	stp	x24, x23, [sp, #0x40]
1047a90bc: a90557f6    	stp	x22, x21, [sp, #0x50]
1047a90c0: a9064ff4    	stp	x20, x19, [sp, #0x60]
1047a90c4: a9077bfd    	stp	x29, x30, [sp, #0x70]
1047a90c8: 9101c3fd    	add	x29, sp, #0x70
1047a90cc: aa0203f5    	mov	x21, x2
1047a90d0: aa0003f3    	mov	x19, x0
1047a90d4: 900e24a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047a90d8: 52800029    	mov	w9, #0x1                ; =1
1047a90dc: 39207d09    	strb	w9, [x8, #0x81f]
1047a90e0: 900db848    	adrp	x8, 0x11feb1000 <dyld_stub_binder+0x11feb1000>
1047a90e4: f9462d14    	ldr	x20, [x8, #0xc58] ; selector setM_url:
1047a90e8: aa0203e0    	mov	x0, x2
1047a90ec: 94d1f813    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047a90f0: aa1303e0    	mov	x0, x19
1047a90f4: aa1403e1    	mov	x1, x20
1047a90f8: aa1503e2    	mov	x2, x21
1047a90fc: 94d1f810    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9100: f00dce48    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1047a9104: f9427100    	ldr	x0, [x8, #0x4e0] ; class NSURL
1047a9108: b00dcaa8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1047a910c: f944d101    	ldr	x1, [x8, #0x9a0] ; selector URLWithString:
1047a9110: aa1503e2    	mov	x2, x21
1047a9114: 94d1f80a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9118: aa1d03fd    	mov	x29, x29
1047a911c: 94d1f80b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a9120: aa0003f4    	mov	x20, x0
1047a9124: aa1503e0    	mov	x0, x21
1047a9128: 94d1f80b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a912c: d00db5e8    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
1047a9130: f9415117    	ldr	x23, [x8, #0x2a0] ; selector pathComponents
1047a9134: aa1403e0    	mov	x0, x20
1047a9138: aa1703e1    	mov	x1, x23
1047a913c: 94d1f800    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9140: aa1d03fd    	mov	x29, x29
1047a9144: 94d1f801    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a9148: aa0003f5    	mov	x21, x0
1047a914c: f00dcaa8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1047a9150: f9435101    	ldr	x1, [x8, #0x6a0] ; selector count
1047a9154: 94d1f7fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9158: aa0003f6    	mov	x22, x0
1047a915c: aa1503e0    	mov	x0, x21
1047a9160: 94d1f7fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9164: f1000adf    	cmp	x22, #0x2
1047a9168: 54000903    	b.lo	0x1047a9288 <_Flutter_MMFoundation_BindContext+0xc84e6c>
1047a916c: d00dce48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047a9170: f9454518    	ldr	x24, [x8, #0xa88] ; class NSString
1047a9174: b00dcac8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1047a9178: f944d901    	ldr	x1, [x8, #0x9b0] ; selector host
1047a917c: aa1403e0    	mov	x0, x20
1047a9180: 94d1f7ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9184: aa1d03fd    	mov	x29, x29
1047a9188: 94d1f7f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a918c: aa0003f5    	mov	x21, x0
1047a9190: aa1403e0    	mov	x0, x20
1047a9194: aa1703e1    	mov	x1, x23
1047a9198: 94d1f7e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a919c: aa1d03fd    	mov	x29, x29
1047a91a0: 94d1f7ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a91a4: aa0003f6    	mov	x22, x0
1047a91a8: f00dcac8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1047a91ac: f947e119    	ldr	x25, [x8, #0xfc0] ; selector objectAtIndexedSubscript:
1047a91b0: aa1903e1    	mov	x1, x25
1047a91b4: d2800002    	mov	x2, #0x0                ; =0
1047a91b8: 94d1f7e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a91bc: aa1d03fd    	mov	x29, x29
1047a91c0: 94d1f7e2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a91c4: aa0003fa    	mov	x26, x0
1047a91c8: aa1403e0    	mov	x0, x20
1047a91cc: aa1703e1    	mov	x1, x23
1047a91d0: 94d1f7db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a91d4: aa1d03fd    	mov	x29, x29
1047a91d8: 94d1f7dc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a91dc: aa0003f7    	mov	x23, x0
1047a91e0: aa1903e1    	mov	x1, x25
1047a91e4: 52800022    	mov	w2, #0x1                ; =1
1047a91e8: 94d1f7d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a91ec: aa1d03fd    	mov	x29, x29
1047a91f0: 94d1f7d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a91f4: aa0003f9    	mov	x25, x0
1047a91f8: b00dcb08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1047a91fc: f946a501    	ldr	x1, [x8, #0xd48] ; selector stringWithFormat:
1047a9200: a90083fa    	stp	x26, x0, [sp, #0x8]
1047a9204: f90003f5    	str	x21, [sp]
1047a9208: b00cfe42    	adrp	x2, 0x11e772000 <dyld_stub_binder+0x11e772000>
1047a920c: 910d2042    	add	x2, x2, #0x348 ; CFString 'weixin://%@%@%@'
1047a9210: aa1803e0    	mov	x0, x24
1047a9214: 94d1f7ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9218: aa1d03fd    	mov	x29, x29
1047a921c: 94d1f7cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a9220: aa0003f8    	mov	x24, x0
1047a9224: f00dcac8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1047a9228: f940cd01    	ldr	x1, [x8, #0x198] ; selector lowercaseString
1047a922c: 94d1f7c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9230: aa1d03fd    	mov	x29, x29
1047a9234: 94d1f7c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a9238: aa0003fb    	mov	x27, x0
1047a923c: aa1803e0    	mov	x0, x24
1047a9240: 94d1f7c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9244: aa1903e0    	mov	x0, x25
1047a9248: 94d1f7c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a924c: aa1703e0    	mov	x0, x23
1047a9250: 94d1f7c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9254: aa1a03e0    	mov	x0, x26
1047a9258: 94d1f7bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a925c: aa1603e0    	mov	x0, x22
1047a9260: 94d1f7bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9264: aa1503e0    	mov	x0, x21
1047a9268: 94d1f7bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a926c: d00dbe68    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
1047a9270: f947b501    	ldr	x1, [x8, #0xf68] ; selector handleInnerJumpURL:
1047a9274: aa1303e0    	mov	x0, x19
1047a9278: aa1b03e2    	mov	x2, x27
1047a927c: 94d1f7b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9280: aa1b03e0    	mov	x0, x27
1047a9284: 94d1f7b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9288: aa1403e0    	mov	x0, x20
1047a928c: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1047a9290: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1047a9294: a94557f6    	ldp	x22, x21, [sp, #0x50]
1047a9298: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1047a929c: a94367fa    	ldp	x26, x25, [sp, #0x30]
1047a92a0: a9426ffc    	ldp	x28, x27, [sp, #0x20]
1047a92a4: 910203ff    	add	sp, sp, #0x80
1047a92a8: 14d1f7ab    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
