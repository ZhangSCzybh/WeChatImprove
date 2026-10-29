
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aa64fc: b00dbbe8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104aa6500: b9833108    	ldrsw	x8, [x8, #0x330]
104aa6504: 38686808    	ldrb	w8, [x0, x8]
104aa6508: 7100051f    	cmp	w8, #0x1
104aa650c: 540004e1    	b.ne	0x104aa65a8 <_Flutter_MMFoundation_BindContext+0xf8218c>
104aa6510: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104aa6514: a9014ff4    	stp	x20, x19, [sp, #0x10]
104aa6518: a9027bfd    	stp	x29, x30, [sp, #0x20]
104aa651c: 910083fd    	add	x29, sp, #0x20
104aa6520: b00db668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa6524: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104aa6528: d00db2c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104aa652c: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104aa6530: 94c60303    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa6534: aa1d03fd    	mov	x29, x29
104aa6538: 94c60304    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa653c: aa0003f3    	mov	x19, x0
104aa6540: d00db668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aa6544: f9401d00    	ldr	x0, [x8, #0x38] ; class MMNewSessionMgr
104aa6548: b00db2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aa654c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104aa6550: 94c602fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa6554: aa0003e2    	mov	x2, x0
104aa6558: f00d9c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aa655c: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104aa6560: aa1303e0    	mov	x0, x19
104aa6564: 94c602f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa6568: aa1d03fd    	mov	x29, x29
104aa656c: 94c602f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa6570: aa0003f4    	mov	x20, x0
104aa6574: d00da6e8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104aa6578: f9415d01    	ldr	x1, [x8, #0x2b8] ; selector GetTotalUnreadCount
104aa657c: 94c602f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa6580: aa0003f5    	mov	x21, x0
104aa6584: aa1403e0    	mov	x0, x20
104aa6588: 94c602f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa658c: aa1303e0    	mov	x0, x19
104aa6590: 94c602f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa6594: aa1503e0    	mov	x0, x21
104aa6598: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104aa659c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104aa65a0: a8c357f6    	ldp	x22, x21, [sp], #0x30
104aa65a4: d65f03c0    	ret
104aa65a8: 52800000    	mov	w0, #0x0                ; =0
104aa65ac: d65f03c0    	ret
