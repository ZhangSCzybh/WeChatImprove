
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1003356b4: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1003356b8: a90157f6    	stp	x22, x21, [sp, #0x10]
1003356bc: a9024ff4    	stp	x20, x19, [sp, #0x20]
1003356c0: a9037bfd    	stp	x29, x30, [sp, #0x30]
1003356c4: 9100c3fd    	add	x29, sp, #0x30
1003356c8: aa0003f3    	mov	x19, x0
1003356cc: d00ff548    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1003356d0: b9842518    	ldrsw	x24, [x8, #0x424]
1003356d4: 8b180000    	add	x0, x0, x24
1003356d8: 95e3c6ad    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1003356dc: b4000380    	cbz	x0, 0x10033574c <__text+0x32d74c>
1003356e0: aa0003f5    	mov	x21, x0
1003356e4: 8b180260    	add	x0, x19, x24
1003356e8: 95e3c6a9    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
1003356ec: aa0003f6    	mov	x22, x0
1003356f0: f00fd868    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1003356f4: f944fd14    	ldr	x20, [x8, #0x9f8] ; GetContact
1003356f8: b00fee88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1003356fc: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
100335700: aa1403e2    	mov	x2, x20
100335704: 95e3c68e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100335708: aa0003f7    	mov	x23, x0
10033570c: aa1603e0    	mov	x0, x22
100335710: 95e3c691    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100335714: aa1503e0    	mov	x0, x21
100335718: 95e3c68f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10033571c: 34000197    	cbz	w23, 0x10033574c <__text+0x32d74c>
100335720: 8b180260    	add	x0, x19, x24
100335724: 95e3c69a    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
100335728: aa0003f5    	mov	x21, x0
10033572c: aa1403e1    	mov	x1, x20
100335730: 95e3c683    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100335734: aa1d03fd    	mov	x29, x29
100335738: 95e3c684    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10033573c: aa0003f3    	mov	x19, x0
100335740: aa1503e0    	mov	x0, x21
100335744: 95e3c684    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100335748: 14000002    	b	0x100335750 <__text+0x32d750>
10033574c: d2800013    	mov	x19, #0x0               ; =0
100335750: aa1303e0    	mov	x0, x19
100335754: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100335758: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10033575c: a94157f6    	ldp	x22, x21, [sp, #0x10]
100335760: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100335764: 15e3c683    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
