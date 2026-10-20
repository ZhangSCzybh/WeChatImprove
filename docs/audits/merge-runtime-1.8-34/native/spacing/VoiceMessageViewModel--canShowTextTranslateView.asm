
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10629030c: d10103ff    	sub	sp, sp, #0x40
106290310: a90157f6    	stp	x22, x21, [sp, #0x10]
106290314: a9024ff4    	stp	x20, x19, [sp, #0x20]
106290318: a9037bfd    	stp	x29, x30, [sp, #0x30]
10629031c: 9100c3fd    	add	x29, sp, #0x30
106290320: aa0003f3    	mov	x19, x0
106290324: f00d4d88    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106290328: 52800029    	mov	w9, #0x1                ; =1
10629032c: 39292109    	strb	w9, [x8, #0xa48]
106290330: f00cea08    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106290334: f9462101    	ldr	x1, [x8, #0xc40] ; canShowTranslateText
106290338: 94665b81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10629033c: 340008a0    	cbz	w0, 0x106290450 <_Flutter_MMFoundation_BindContext+0x276c034>
106290340: f00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106290344: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
106290348: 900cf388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10629034c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
106290350: 94665b7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290354: aa1d03fd    	mov	x29, x29
106290358: 94665b7c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10629035c: aa0003f4    	mov	x20, x0
106290360: b00cf728    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
106290364: f942fd00    	ldr	x0, [x8, #0x5f8] ; ��: 
106290368: f00cf368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10629036c: f947ad01    	ldr	x1, [x8, #0xf58] ; class
106290370: 94665b73    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290374: aa0003e2    	mov	x2, x0
106290378: b00cdd48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10629037c: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
106290380: aa1403e0    	mov	x0, x20
106290384: 94665b6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290388: aa1d03fd    	mov	x29, x29
10629038c: 94665b6f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106290390: aa0003f5    	mov	x21, x0
106290394: f00cfa68    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
106290398: 910b0108    	add	x8, x8, #0x2c0
10629039c: b9800108    	ldrsw	x8, [x8]
1062903a0: f8686a62    	ldr	x2, [x19, x8]
1062903a4: 900cdda8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1062903a8: f942a501    	ldr	x1, [x8, #0x548] ; getTranslateInfo:
1062903ac: 94665b64    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062903b0: aa1d03fd    	mov	x29, x29
1062903b4: 94665b65    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062903b8: aa0003f3    	mov	x19, x0
1062903bc: aa1503e0    	mov	x0, x21
1062903c0: 94665b65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062903c4: aa1403e0    	mov	x0, x20
1062903c8: 94665b63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1062903cc: b4000473    	cbz	x19, 0x106290458 <_Flutter_MMFoundation_BindContext+0x276c03c>
1062903d0: d00ce968    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
1062903d4: f941a101    	ldr	x1, [x8, #0x340] ; isTranslateFailed
1062903d8: aa1303e0    	mov	x0, x19
1062903dc: 94665b58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062903e0: 370003c0    	tbnz	w0, #0x0, 0x106290458 <_Flutter_MMFoundation_BindContext+0x276c03c>
1062903e4: 900cdda8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1062903e8: f942c101    	ldr	x1, [x8, #0x580] ; translateStatus
1062903ec: aa1303e0    	mov	x0, x19
1062903f0: 94665b53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062903f4: 34000320    	cbz	w0, 0x106290458 <_Flutter_MMFoundation_BindContext+0x276c03c>
1062903f8: 900cdde8    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
1062903fc: f9436501    	ldr	x1, [x8, #0x6c8] ; showOriginTextNow
106290400: aa1303e0    	mov	x0, x19
106290404: 94665b4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290408: 52000014    	eor	w20, w0, #0x1
10629040c: f00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106290410: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
106290414: b00cdd48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106290418: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10629041c: f00c2d68    	adrp	x8, 0x11e83f000 <dyld_stub_binder+0x11e83f000>
106290420: 911aa108    	add	x8, x8, #0x6a8
106290424: a90053e8    	stp	x8, x20, [sp]
106290428: f00ab885    	adrp	x5, 0x11b9a3000 <dyld_stub_binder+0x11b9a3000>
10629042c: 910b8ca5    	add	x5, x5, #0x2e3
106290430: f00ab887    	adrp	x7, 0x11b9a3000 <dyld_stub_binder+0x11b9a3000>
106290434: 9111c8e7    	add	x7, x7, #0x472
106290438: 52800042    	mov	w2, #0x2                ; =2
10629043c: d2800003    	mov	x3, #0x0                ; =0
106290440: 52800004    	mov	w4, #0x0                ; =0
106290444: 52804406    	mov	w6, #0x220              ; =544
106290448: 94665b3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10629044c: 14000004    	b	0x10629045c <_Flutter_MMFoundation_BindContext+0x276c040>
106290450: 52800014    	mov	w20, #0x0               ; =0
106290454: 14000004    	b	0x106290464 <_Flutter_MMFoundation_BindContext+0x276c048>
106290458: 52800014    	mov	w20, #0x0               ; =0
10629045c: aa1303e0    	mov	x0, x19
106290460: 94665b3d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106290464: aa1403e0    	mov	x0, x20
106290468: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10629046c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
106290470: a94157f6    	ldp	x22, x21, [sp, #0x10]
106290474: 910103ff    	add	sp, sp, #0x40
106290478: d65f03c0    	ret