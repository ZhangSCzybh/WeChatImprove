
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1071357d8: d10183ff    	sub	sp, sp, #0x60
1071357dc: a9025ff8    	stp	x24, x23, [sp, #0x20]
1071357e0: a90357f6    	stp	x22, x21, [sp, #0x30]
1071357e4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1071357e8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1071357ec: 910143fd    	add	x29, sp, #0x50
1071357f0: aa0203f3    	mov	x19, x2
1071357f4: aa0003f4    	mov	x20, x0
1071357f8: d00cd888    	adrp	x8, 0x120c47000 <dyld_stub_binder+0x120c47000>
1071357fc: 52800029    	mov	w9, #0x1                ; =1
107135800: 39012d09    	strb	w9, [x8, #0x4b]
107135804: d00c8888    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107135808: b989f517    	ldrsw	x23, [x8, #0x9f4]
10713580c: f8776800    	ldr	x0, [x0, x23]
107135810: f00c7e48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
107135814: f9435115    	ldr	x21, [x8, #0x6a0] ; count
107135818: aa1503e1    	mov	x1, x21
10713581c: 942bc648    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107135820: eb13001f    	cmp	x0, x19
107135824: 54000269    	b.ls	0x107135870 <_Flutter_MMFoundation_BindContext+0x3611454>
107135828: f8776a80    	ldr	x0, [x20, x23]
10713582c: b00c6828    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
107135830: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
107135834: aa1303e2    	mov	x2, x19
107135838: 942bc641    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10713583c: aa1d03fd    	mov	x29, x29
107135840: 942bc642    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107135844: aa0003f3    	mov	x19, x0
107135848: b00c7688    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10713584c: f9400501    	ldr	x1, [x8, #0x8] ; LL_onBeforeReturnDataItem:
107135850: aa1403e0    	mov	x0, x20
107135854: aa1303e2    	mov	x2, x19
107135858: 942bc639    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10713585c: 340003a0    	cbz	w0, 0x1071358d0 <_Flutter_MMFoundation_BindContext+0x36114b4>
107135860: aa1303e0    	mov	x0, x19
107135864: 942bc635    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
107135868: aa1303f4    	mov	x20, x19
10713586c: 1400001a    	b	0x1071358d4 <_Flutter_MMFoundation_BindContext+0x36114b8>
107135870: d00c81e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
107135874: f9453516    	ldr	x22, [x8, #0xa68]
107135878: f8776a80    	ldr	x0, [x20, x23]
10713587c: aa1503e1    	mov	x1, x21
107135880: 942bc62f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107135884: 900c6828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
107135888: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10713588c: a900cfe0    	stp	x0, x19, [sp, #0x8]
107135890: b00bbe68    	adrp	x8, 0x11e902000 <dyld_stub_binder+0x11e902000>
107135894: 912ba108    	add	x8, x8, #0xae8
107135898: f90003e8    	str	x8, [sp]
10713589c: f00a0723    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
1071358a0: 912b2863    	add	x3, x3, #0xaca
1071358a4: 900a4aa5    	adrp	x5, 0x11ba89000 <dyld_stub_binder+0x11ba89000>
1071358a8: 911134a5    	add	x5, x5, #0x44d
1071358ac: 900a4aa7    	adrp	x7, 0x11ba89000 <dyld_stub_binder+0x11ba89000>
1071358b0: 912054e7    	add	x7, x7, #0x815
1071358b4: aa1603e0    	mov	x0, x22
1071358b8: 52800042    	mov	w2, #0x2                ; =2
1071358bc: 52800004    	mov	w4, #0x0                ; =0
1071358c0: 5280d626    	mov	w6, #0x6b1              ; =1713
1071358c4: 942bc61e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071358c8: d2800014    	mov	x20, #0x0               ; =0
1071358cc: 14000004    	b	0x1071358dc <_Flutter_MMFoundation_BindContext+0x36114c0>
1071358d0: d2800014    	mov	x20, #0x0               ; =0
1071358d4: aa1303e0    	mov	x0, x19
1071358d8: 942bc61f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1071358dc: aa1403e0    	mov	x0, x20
1071358e0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1071358e4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1071358e8: a94357f6    	ldp	x22, x21, [sp, #0x30]
1071358ec: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1071358f0: 910183ff    	add	sp, sp, #0x60
1071358f4: 142bc61f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
