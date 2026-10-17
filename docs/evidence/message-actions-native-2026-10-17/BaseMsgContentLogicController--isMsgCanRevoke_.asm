
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b9040: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1002b9044: a90157f6    	stp	x22, x21, [sp, #0x10]
1002b9048: a9024ff4    	stp	x20, x19, [sp, #0x20]
1002b904c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1002b9050: 9100c3fd    	add	x29, sp, #0x30
1002b9054: 90104ba8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1002b9058: 52800029    	mov	w9, #0x1                ; =1
1002b905c: 39329509    	strb	w9, [x8, #0xca5]
1002b9060: f00fdc48    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1002b9064: f944fd01    	ldr	x1, [x8, #0x9f8] ; GetContact
1002b9068: 95e5b835    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b906c: aa1d03fd    	mov	x29, x29
1002b9070: 95e5b836    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b9074: aa0003f3    	mov	x19, x0
1002b9078: d00ff5c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1002b907c: f9478100    	ldr	x0, [x8, #0xf00] ;  /, 
1002b9080: d00ff228    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1002b9084: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1002b9088: 95e5b82d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b908c: aa0003e2    	mov	x2, x0
1002b9090: d00ff248    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1002b9094: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
1002b9098: aa1303e0    	mov	x0, x19
1002b909c: 95e5b828    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b90a0: 34000560    	cbz	w0, 0x1002b914c <__text+0x2b114c>
1002b90a4: d00fdc08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002b90a8: f947b501    	ldr	x1, [x8, #0xf68] ; isBrandContact
1002b90ac: aa1303e0    	mov	x0, x19
1002b90b0: 95e5b823    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b90b4: 370004c0    	tbnz	w0, #0x0, 0x1002b914c <__text+0x2b114c>
1002b90b8: 900ff5f7    	adrp	x23, 0x120175000 <dyld_stub_binder+0x120175000>
1002b90bc: f940d6f6    	ldr	x22, [x23, #0x1a8] ; �8 
1002b90c0: d00fdc08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1002b90c4: f9434d15    	ldr	x21, [x8, #0x698] ; m_nsUsrName
1002b90c8: aa1303e0    	mov	x0, x19
1002b90cc: aa1503e1    	mov	x1, x21
1002b90d0: 95e5b81b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b90d4: aa1d03fd    	mov	x29, x29
1002b90d8: 95e5b81c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b90dc: aa0003f4    	mov	x20, x0
1002b90e0: b00fdc48    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1002b90e4: f9434101    	ldr	x1, [x8, #0x680] ; isPluginUserName:
1002b90e8: aa1603e0    	mov	x0, x22
1002b90ec: aa1403e2    	mov	x2, x20
1002b90f0: 95e5b813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b90f4: 34000080    	cbz	w0, 0x1002b9104 <__text+0x2b1104>
1002b90f8: aa1403e0    	mov	x0, x20
1002b90fc: 95e5b816    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9100: 14000013    	b	0x1002b914c <__text+0x2b114c>
1002b9104: f940d6f6    	ldr	x22, [x23, #0x1a8] ; �8 
1002b9108: aa1303e0    	mov	x0, x19
1002b910c: aa1503e1    	mov	x1, x21
1002b9110: 95e5b80b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9114: aa1d03fd    	mov	x29, x29
1002b9118: 95e5b80c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1002b911c: aa0003f5    	mov	x21, x0
1002b9120: b00fdc88    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b9124: f942ad01    	ldr	x1, [x8, #0x558] ; isOfficialUserName:
1002b9128: aa1603e0    	mov	x0, x22
1002b912c: aa1503e2    	mov	x2, x21
1002b9130: 95e5b803    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1002b9134: aa0003f6    	mov	x22, x0
1002b9138: aa1503e0    	mov	x0, x21
1002b913c: 95e5b806    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9140: aa1403e0    	mov	x0, x20
1002b9144: 95e5b804    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9148: 34000156    	cbz	w22, 0x1002b9170 <__text+0x2b1170>
1002b914c: 52800014    	mov	w20, #0x0               ; =0
1002b9150: aa1303e0    	mov	x0, x19
1002b9154: 95e5b800    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1002b9158: aa1403e0    	mov	x0, x20
1002b915c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1002b9160: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1002b9164: a94157f6    	ldp	x22, x21, [sp, #0x10]
1002b9168: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1002b916c: d65f03c0    	ret
1002b9170: 52800034    	mov	w20, #0x1               ; =1
1002b9174: 17fffff7    	b	0x1002b9150 <__text+0x2b1150>