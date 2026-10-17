
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10629233c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106292340: a9014ff4    	stp	x20, x19, [sp, #0x10]
106292344: a9027bfd    	stp	x29, x30, [sp, #0x20]
106292348: 910083fd    	add	x29, sp, #0x20
10629234c: aa0003f3    	mov	x19, x0
106292350: b00d4d88    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106292354: 52800029    	mov	w9, #0x1                ; =1
106292358: 39294509    	strb	w9, [x8, #0xa51]
10629235c: f00cf828    	adrp	x8, 0x120199000 <dyld_stub_binder+0x120199000>
106292360: f941f100    	ldr	x0, [x8, #0x3e0]
106292364: 9466537d    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
106292368: d00cfd28    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10629236c: b98e1d14    	ldrsw	x20, [x8, #0xe1c]
106292370: f8746a68    	ldr	x8, [x19, x20]
106292374: f8346a60    	str	x0, [x19, x20]
106292378: aa0803e0    	mov	x0, x8
10629237c: 94665376    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106292380: f8746a60    	ldr	x0, [x19, x20]
106292384: d00cea08    	adrp	x8, 0x11ffd4000 <dyld_stub_binder+0x11ffd4000>
106292388: f9402d01    	ldr	x1, [x8, #0x58] ; setM_delNotifyToReceiver:
10629238c: aa1303e2    	mov	x2, x19
106292390: 9466536b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292394: f8746a60    	ldr	x0, [x19, x20]
106292398: b00cdd88    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10629239c: f9447d14    	ldr	x20, [x8, #0x8f8] ; Start
1062923a0: aa1403e1    	mov	x1, x20
1062923a4: 94665366    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062923a8: f00cf828    	adrp	x8, 0x120199000 <dyld_stub_binder+0x120199000>
1062923ac: f941f500    	ldr	x0, [x8, #0x3e8]
1062923b0: 9466536a    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1062923b4: d00cfd28    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062923b8: b98e2115    	ldrsw	x21, [x8, #0xe20]
1062923bc: f8756a68    	ldr	x8, [x19, x21]
1062923c0: f8356a60    	str	x0, [x19, x21]
1062923c4: aa0803e0    	mov	x0, x8
1062923c8: 94665363    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062923cc: f8756a60    	ldr	x0, [x19, x21]
1062923d0: b00cf3a8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1062923d4: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
1062923d8: aa1303e2    	mov	x2, x19
1062923dc: 94665358    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062923e0: f8756a60    	ldr	x0, [x19, x21]
1062923e4: aa1403e1    	mov	x1, x20
1062923e8: 94665355    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062923ec: d00cf708    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1062923f0: f9434100    	ldr	x0, [x8, #0x680]
1062923f4: 900cf3a8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1062923f8: f9469d01    	ldr	x1, [x8, #0xd38] ; set
1062923fc: 94665350    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292400: aa1d03fd    	mov	x29, x29
106292404: 94665351    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106292408: d00cfd28    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
10629240c: b98e2509    	ldrsw	x9, [x8, #0xe24]
106292410: f8696a68    	ldr	x8, [x19, x9]
106292414: f8296a60    	str	x0, [x19, x9]
106292418: aa0803e0    	mov	x0, x8
10629241c: 9466534e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106292420: b00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106292424: f945e900    	ldr	x0, [x8, #0xbd0]
106292428: d00cf368    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10629242c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106292430: 94665343    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292434: aa1d03fd    	mov	x29, x29
106292438: 94665344    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10629243c: aa0003f4    	mov	x20, x0
106292440: d00cf6e8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
106292444: f9462502    	ldr	x2, [x8, #0xc48]
106292448: 900cdd48    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10629244c: f940a101    	ldr	x1, [x8, #0x140] ; registerExtension:withTarget:
106292450: aa1303e3    	mov	x3, x19
106292454: 9466533a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106292458: aa1403e0    	mov	x0, x20
10629245c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106292460: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106292464: a8c357f6    	ldp	x22, x21, [sp], #0x30
106292468: 1466533b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
