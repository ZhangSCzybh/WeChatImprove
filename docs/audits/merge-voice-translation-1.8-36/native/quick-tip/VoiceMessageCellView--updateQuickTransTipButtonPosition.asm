
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062790ec: 6dba2beb    	stp	d11, d10, [sp, #-0x60]!
1062790f0: 6d0123e9    	stp	d9, d8, [sp, #0x10]
1062790f4: a9025ff8    	stp	x24, x23, [sp, #0x20]
1062790f8: a90357f6    	stp	x22, x21, [sp, #0x30]
1062790fc: a9044ff4    	stp	x20, x19, [sp, #0x40]
106279100: a9057bfd    	stp	x29, x30, [sp, #0x50]
106279104: 910143fd    	add	x29, sp, #0x50
106279108: aa0003f3    	mov	x19, x0
10627910c: d00d4e48    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106279110: 52800029    	mov	w9, #0x1                ; =1
106279114: 3927c509    	strb	w9, [x8, #0x9f1]
106279118: f00cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10627911c: b98d6d08    	ldrsw	x8, [x8, #0xd6c]
106279120: f8686800    	ldr	x0, [x0, x8]
106279124: 900cf448    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
106279128: f945a101    	ldr	x1, [x8, #0xb40] ; frame
10627912c: 9466b804    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279130: 1e622800    	fadd	d0, d0, d2
106279134: 1e641001    	fmov	d1, #8.00000000
106279138: 1e612808    	fadd	d8, d0, d1
10627913c: f00cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106279140: b98d5518    	ldrsw	x24, [x8, #0xd54]
106279144: f8786a60    	ldr	x0, [x19, x24]
106279148: d00cf488    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10627914c: f947a501    	ldr	x1, [x8, #0xf48] ; width
106279150: 9466b7fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279154: 1e6c100a    	fmov	d10, #0.50000000
106279158: 1e6a0800    	fmul	d0, d0, d10
10627915c: 1e602908    	fadd	d8, d8, d0
106279160: f00cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
106279164: f9403d15    	ldr	x21, [x8, #0x78] ; 8�6 
106279168: d00cf7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10627916c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
106279170: f00cf428    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106279174: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106279178: 9466b7f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627917c: aa1d03fd    	mov	x29, x29
106279180: 9466b7f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106279184: aa0003f4    	mov	x20, x0
106279188: f00cf7c8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10627918c: f9404100    	ldr	x0, [x8, #0x80]
106279190: d00cf428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106279194: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106279198: 9466b7e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10627919c: aa0003e2    	mov	x2, x0
1062791a0: 900cde08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062791a4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1062791a8: aa1403e0    	mov	x0, x20
1062791ac: 9466b7e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062791b0: aa1d03fd    	mov	x29, x29
1062791b4: 9466b7e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062791b8: aa0003f6    	mov	x22, x0
1062791bc: d00cde08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1062791c0: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
1062791c4: 900c1182    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
1062791c8: 912ca042    	add	x2, x2, #0xb28
1062791cc: b00c1163    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
1062791d0: 9124a063    	add	x3, x3, #0x928
1062791d4: 9466b7da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062791d8: aa1d03fd    	mov	x29, x29
1062791dc: 9466b7db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062791e0: aa0003f7    	mov	x23, x0
1062791e4: f00cde08    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1062791e8: f9400101    	ldr	x1, [x8]
1062791ec: aa1503e0    	mov	x0, x21
1062791f0: aa1703e2    	mov	x2, x23
1062791f4: 9466b7d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062791f8: 1e604009    	fmov	d9, d0
1062791fc: d00cf7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106279200: f9461900    	ldr	x0, [x8, #0xc30]
106279204: 900cde28    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106279208: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
10627920c: 9466b7cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279210: aa1d03fd    	mov	x29, x29
106279214: 9466b7cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106279218: aa0003f5    	mov	x21, x0
10627921c: d00cde08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106279220: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
106279224: 9466b7c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279228: 1e64c000    	frintp	d0, d0
10627922c: 1e601001    	fmov	d1, #2.00000000
106279230: 1f410120    	fmadd	d0, d9, d1, d0
106279234: 1e6a0809    	fmul	d9, d0, d10
106279238: aa1503e0    	mov	x0, x21
10627923c: 9466b7c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279240: aa1703e0    	mov	x0, x23
106279244: 9466b7c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279248: aa1603e0    	mov	x0, x22
10627924c: 9466b7c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279250: aa1403e0    	mov	x0, x20
106279254: 9466b7c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279258: d00cfb28    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
10627925c: 910a8108    	add	x8, x8, #0x2a0
106279260: b9800108    	ldrsw	x8, [x8]
106279264: f8686a60    	ldr	x0, [x19, x8]
106279268: f00cf428    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10627926c: f942d101    	ldr	x1, [x8, #0x5a0] ; convertPoint:toView:
106279270: 1e604100    	fmov	d0, d8
106279274: 1e604121    	fmov	d1, d9
106279278: aa1303e2    	mov	x2, x19
10627927c: 9466b7b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279280: f8786a60    	ldr	x0, [x19, x24]
106279284: d00cf468    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106279288: f9425101    	ldr	x1, [x8, #0x4a0] ; setCenter:
10627928c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106279290: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106279294: a94357f6    	ldp	x22, x21, [sp, #0x30]
106279298: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10627929c: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
1062792a0: 6cc62beb    	ldp	d11, d10, [sp], #0x60
1062792a4: 1466b7a6    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>