
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
107122fb8: d10203ff    	sub	sp, sp, #0x80
107122fbc: 6d0223e9    	stp	d9, d8, [sp, #0x20]
107122fc0: a90367fa    	stp	x26, x25, [sp, #0x30]
107122fc4: a9045ff8    	stp	x24, x23, [sp, #0x40]
107122fc8: a90557f6    	stp	x22, x21, [sp, #0x50]
107122fcc: a9064ff4    	stp	x20, x19, [sp, #0x60]
107122fd0: a9077bfd    	stp	x29, x30, [sp, #0x70]
107122fd4: 9101c3fd    	add	x29, sp, #0x70
107122fd8: aa0403f6    	mov	x22, x4
107122fdc: 1e604008    	fmov	d8, d0
107122fe0: aa0303f4    	mov	x20, x3
107122fe4: aa0203f3    	mov	x19, x2
107122fe8: aa0003f7    	mov	x23, x0
107122fec: 900cd928    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
107122ff0: 52800029    	mov	w9, #0x1                ; =1
107122ff4: 393ff909    	strb	w9, [x8, #0xffe]
107122ff8: aa0203e0    	mov	x0, x2
107122ffc: 942c104f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
107123000: aa1403e0    	mov	x0, x20
107123004: 942c104d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
107123008: fd0007e8    	str	d8, [sp, #0x8]
10712300c: 900c6a68    	adrp	x8, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
107123010: f9425118    	ldr	x24, [x8, #0x4a0] ; itemID
107123014: aa1803e1    	mov	x1, x24
107123018: 942c1049    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10712301c: aa1d03fd    	mov	x29, x29
107123020: 942c104a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107123024: aa0003f5    	mov	x21, x0
107123028: 942c104b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10712302c: b4000b75    	cbz	x21, 0x107123198 <_Flutter_MMFoundation_BindContext+0x35fed7c>
107123030: 900c8928    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107123034: 9124e108    	add	x8, x8, #0x938
107123038: b980011a    	ldrsw	x26, [x8]
10712303c: f87a6af5    	ldr	x21, [x23, x26]
107123040: aa1403e0    	mov	x0, x20
107123044: aa1803e1    	mov	x1, x24
107123048: 942c103d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10712304c: aa1d03fd    	mov	x29, x29
107123050: 942c103e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107123054: aa0003f9    	mov	x25, x0
107123058: b00c7f08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10712305c: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
107123060: aa1503e0    	mov	x0, x21
107123064: aa1903e2    	mov	x2, x25
107123068: 942c1035    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10712306c: aa1d03fd    	mov	x29, x29
107123070: 942c1036    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107123074: aa0003f5    	mov	x21, x0
107123078: aa1903e0    	mov	x0, x25
10712307c: 942c1036    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107123080: b5000295    	cbnz	x21, 0x1071230d0 <_Flutter_MMFoundation_BindContext+0x35fecb4>
107123084: f00c83c8    	adrp	x8, 0x12019e000 <dyld_stub_binder+0x12019e000>
107123088: f9407100    	ldr	x0, [x8, #0xe0] ; 0g>
10712308c: 942c1033    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
107123090: aa0003f5    	mov	x21, x0
107123094: f87a6af7    	ldr	x23, [x23, x26]
107123098: aa1403e0    	mov	x0, x20
10712309c: aa1803e1    	mov	x1, x24
1071230a0: 942c1027    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071230a4: aa1d03fd    	mov	x29, x29
1071230a8: 942c1028    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1071230ac: aa0003f8    	mov	x24, x0
1071230b0: d00c68a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1071230b4: f942c901    	ldr	x1, [x8, #0x590] ; safeSetObject:forKey:
1071230b8: aa1703e0    	mov	x0, x23
1071230bc: aa1503e2    	mov	x2, x21
1071230c0: aa1803e3    	mov	x3, x24
1071230c4: 942c101e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071230c8: aa1803e0    	mov	x0, x24
1071230cc: 942c1022    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1071230d0: 900c6928    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
1071230d4: f9449d01    	ldr	x1, [x8, #0x938] ; setDataItem:
1071230d8: aa1503e0    	mov	x0, x21
1071230dc: aa1403e2    	mov	x2, x20
1071230e0: 942c1017    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071230e4: 34000096    	cbz	w22, 0x1071230f4 <_Flutter_MMFoundation_BindContext+0x35fecd8>
1071230e8: d00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
1071230ec: f946c916    	ldr	x22, [x8, #0xd90] ; springLikeUserLayoutStyles
1071230f0: 14000003    	b	0x1071230fc <_Flutter_MMFoundation_BindContext+0x35fece0>
1071230f4: d00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
1071230f8: f946cd16    	ldr	x22, [x8, #0xd98] ; likeUserLayoutStyles
1071230fc: aa1503e0    	mov	x0, x21
107123100: aa1603e1    	mov	x1, x22
107123104: 942c100e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123108: 910023f9    	add	x25, sp, #0x8
10712310c: f9000ff9    	str	x25, [sp, #0x18]
107123110: b0098a57    	adrp	x23, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
107123114: 91282af7    	add	x23, x23, #0xa0a
107123118: 910023e1    	add	x1, sp, #0x8
10712311c: 910063e3    	add	x3, sp, #0x18
107123120: 91005fe4    	add	x4, sp, #0x17
107123124: aa1703e2    	mov	x2, x23
107123128: 9400098e    	bl	0x107125760 <_Flutter_MMFoundation_BindContext+0x3601344>
10712312c: f9400c08    	ldr	x8, [x0, #0x18]
107123130: f9000c1f    	str	xzr, [x0, #0x18]
107123134: aa0803e0    	mov	x0, x8
107123138: 942c1007    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10712313c: 900c8288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
107123140: f9455500    	ldr	x0, [x8, #0xaa8]
107123144: 942c1007    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
107123148: f00c7ee8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10712314c: f946d901    	ldr	x1, [x8, #0xdb0] ; initWithArray:
107123150: aa1303e2    	mov	x2, x19
107123154: 942c0ffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123158: aa0003f8    	mov	x24, x0
10712315c: aa1503e0    	mov	x0, x21
107123160: aa1603e1    	mov	x1, x22
107123164: 942c0ff6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123168: f9000ff9    	str	x25, [sp, #0x18]
10712316c: 910023e1    	add	x1, sp, #0x8
107123170: 910063e3    	add	x3, sp, #0x18
107123174: 91005fe4    	add	x4, sp, #0x17
107123178: aa1703e2    	mov	x2, x23
10712317c: 94000979    	bl	0x107125760 <_Flutter_MMFoundation_BindContext+0x3601344>
107123180: aa0003e8    	mov	x8, x0
107123184: f9400c00    	ldr	x0, [x0, #0x18]
107123188: f9000d18    	str	x24, [x8, #0x18]
10712318c: 942c0ff2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107123190: aa1503e0    	mov	x0, x21
107123194: 942c0ff0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107123198: aa1403e0    	mov	x0, x20
10712319c: 942c0fee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1071231a0: aa1303e0    	mov	x0, x19
1071231a4: 942c0fec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1071231a8: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1071231ac: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1071231b0: a94557f6    	ldp	x22, x21, [sp, #0x50]
1071231b4: a9445ff8    	ldp	x24, x23, [sp, #0x40]
1071231b8: a94367fa    	ldp	x26, x25, [sp, #0x30]
1071231bc: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
1071231c0: 910203ff    	add	sp, sp, #0x80
1071231c4: d65f03c0    	ret
