
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a765c8: d10103ff    	sub	sp, sp, #0x40
104a765cc: a90157f6    	stp	x22, x21, [sp, #0x10]
104a765d0: a9024ff4    	stp	x20, x19, [sp, #0x20]
104a765d4: a9037bfd    	stp	x29, x30, [sp, #0x30]
104a765d8: 9100c3fd    	add	x29, sp, #0x30
104a765dc: aa0203f3    	mov	x19, x2
104a765e0: aa0003f4    	mov	x20, x0
104a765e4: 900e0e48    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a765e8: 52800036    	mov	w22, #0x1               ; =1
104a765ec: 390b2d16    	strb	w22, [x8, #0x2cb]
104a765f0: aa0203e0    	mov	x0, x2
104a765f4: 94c6c2d1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a765f8: f00dba68    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a765fc: f942a108    	ldr	x8, [x8, #0x540] ; MainFrameCellData
104a76600: a90023f4    	stp	x20, x8, [sp]
104a76604: 900db468    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a76608: f9466901    	ldr	x1, [x8, #0xcd0] ; init
104a7660c: 910003e0    	mov	x0, sp
104a76610: 94c6c2cd    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a76614: aa0003f4    	mov	x20, x0
104a76618: b4000580    	cbz	x0, 0x104a766c8 <_Flutter_MMFoundation_BindContext+0xf522ac>
104a7661c: 3900ce96    	strb	w22, [x20, #0x33]
104a76620: 3900429f    	strb	wzr, [x20, #0x10]
104a76624: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76628: f9417501    	ldr	x1, [x8, #0x2e8] ; updateExtensionRegister:
104a7662c: aa1403e0    	mov	x0, x20
104a76630: aa1303e2    	mov	x2, x19
104a76634: 94c6c2c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76638: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a7663c: f9417901    	ldr	x1, [x8, #0x2f0] ; setM_sessionInfo:
104a76640: aa1403e0    	mov	x0, x20
104a76644: aa1303e2    	mov	x2, x19
104a76648: 94c6c2bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7664c: f00d9e68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a76650: f944c501    	ldr	x1, [x8, #0x988] ; m_msgWrap
104a76654: aa1303e0    	mov	x0, x19
104a76658: 94c6c2b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7665c: aa1d03fd    	mov	x29, x29
104a76660: 94c6c2ba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a76664: aa0003f5    	mov	x21, x0
104a76668: d00d9e28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a7666c: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
104a76670: 94c6c2b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76674: aa0003e2    	mov	x2, x0
104a76678: d00d9e48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a7667c: f9436501    	ldr	x1, [x8, #0x6c8] ; setM_n64MesSvrID:
104a76680: aa1403e0    	mov	x0, x20
104a76684: 94c6c2ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a76688: aa1503e0    	mov	x0, x21
104a7668c: 94c6c2b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a76690: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a76694: f9417d01    	ldr	x1, [x8, #0x2f8] ; updateDataFieldForUI
104a76698: aa1403e0    	mov	x0, x20
104a7669c: 94c6c2a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a766a0: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a766a4: f9418101    	ldr	x1, [x8, #0x300] ; updateTimeField:
104a766a8: aa1403e0    	mov	x0, x20
104a766ac: 52800002    	mov	w2, #0x0                ; =0
104a766b0: 94c6c2a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a766b4: d00da868    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a766b8: f9418501    	ldr	x1, [x8, #0x308] ; updateRedTips
104a766bc: aa1403e0    	mov	x0, x20
104a766c0: 94c6c29f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a766c4: 3900ca96    	strb	w22, [x20, #0x32]
104a766c8: aa1303e0    	mov	x0, x19
104a766cc: 94c6c2a2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a766d0: aa1403e0    	mov	x0, x20
104a766d4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104a766d8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104a766dc: a94157f6    	ldp	x22, x21, [sp, #0x10]
104a766e0: 910103ff    	add	sp, sp, #0x40
104a766e4: d65f03c0    	ret
