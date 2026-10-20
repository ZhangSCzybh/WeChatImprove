
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10629047c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106290480: a9014ff4    	stp	x20, x19, [sp, #0x10]
106290484: a9027bfd    	stp	x29, x30, [sp, #0x20]
106290488: 910083fd    	add	x29, sp, #0x20
10629048c: aa0003f3    	mov	x19, x0
106290490: f00d4d88    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106290494: 52800029    	mov	w9, #0x1                ; =1
106290498: 39292509    	strb	w9, [x8, #0xa49]
10629049c: f00cea08    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
1062904a0: f9464501    	ldr	x1, [x8, #0xc88] ; canShowTextTranslateView
1062904a4: 94665b26    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062904a8: 34000700    	cbz	w0, 0x106290588 <_Flutter_MMFoundation_BindContext+0x276c16c>
1062904ac: f00cf708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1062904b0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1062904b4: 900cf388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1062904b8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1062904bc: 94665b20    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062904c0: aa1d03fd    	mov	x29, x29
1062904c4: 94665b21    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062904c8: aa0003f4    	mov	x20, x0
1062904cc: b00cf728    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1062904d0: f942fd00    	ldr	x0, [x8, #0x5f8] ; ��: 
1062904d4: f00cf368    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1062904d8: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1062904dc: 94665b18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062904e0: aa0003e2    	mov	x2, x0
1062904e4: b00cdd48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062904e8: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1062904ec: aa1403e0    	mov	x0, x20
1062904f0: 94665b13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062904f4: aa1d03fd    	mov	x29, x29
1062904f8: 94665b14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062904fc: aa0003f5    	mov	x21, x0
106290500: f00cfa68    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
106290504: 910b0108    	add	x8, x8, #0x2c0
106290508: b9800108    	ldrsw	x8, [x8]
10629050c: f8686a62    	ldr	x2, [x19, x8]
106290510: 900cdda8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
106290514: f942a501    	ldr	x1, [x8, #0x548] ; getTranslateInfo:
106290518: 94665b09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10629051c: aa1d03fd    	mov	x29, x29
106290520: 94665b0a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106290524: aa0003f3    	mov	x19, x0
106290528: aa1503e0    	mov	x0, x21
10629052c: 94665b0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106290530: aa1403e0    	mov	x0, x20
106290534: 94665b08    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106290538: 900cdda8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10629053c: f942b101    	ldr	x1, [x8, #0x560] ; translatedText
106290540: aa1303e0    	mov	x0, x19
106290544: 94665afe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290548: aa1d03fd    	mov	x29, x29
10629054c: 94665aff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106290550: aa0003f4    	mov	x20, x0
106290554: f00cf388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106290558: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10629055c: 94665af8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290560: aa0003f5    	mov	x21, x0
106290564: aa1403e0    	mov	x0, x20
106290568: 94665afb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10629056c: b4000135    	cbz	x21, 0x106290590 <_Flutter_MMFoundation_BindContext+0x276c174>
106290570: d00ce968    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
106290574: f9419d01    	ldr	x1, [x8, #0x338] ; isTranslating
106290578: aa1303e0    	mov	x0, x19
10629057c: 94665af0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106290580: 52000014    	eor	w20, w0, #0x1
106290584: 14000004    	b	0x106290594 <_Flutter_MMFoundation_BindContext+0x276c178>
106290588: 52800014    	mov	w20, #0x0               ; =0
10629058c: 14000004    	b	0x10629059c <_Flutter_MMFoundation_BindContext+0x276c180>
106290590: 52800014    	mov	w20, #0x0               ; =0
106290594: aa1303e0    	mov	x0, x19
106290598: 94665aef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10629059c: aa1403e0    	mov	x0, x20
1062905a0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1062905a4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1062905a8: a8c357f6    	ldp	x22, x21, [sp], #0x30
1062905ac: d65f03c0    	ret