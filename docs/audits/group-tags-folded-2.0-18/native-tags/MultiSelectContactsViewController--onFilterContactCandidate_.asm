
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104eac018: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104eac01c: a9014ff4    	stp	x20, x19, [sp, #0x10]
104eac020: a9027bfd    	stp	x29, x30, [sp, #0x20]
104eac024: 910083fd    	add	x29, sp, #0x20
104eac028: aa0203f3    	mov	x19, x2
104eac02c: aa0003f4    	mov	x20, x0
104eac030: aa0203e0    	mov	x0, x2
104eac034: 94b5ec41    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104eac038: d00d7d48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104eac03c: f942c115    	ldr	x21, [x8, #0x580] ; m_uiGroupScene
104eac040: aa1403e0    	mov	x0, x20
104eac044: aa1503e1    	mov	x1, x21
104eac048: 94b5ec3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac04c: 7100a41f    	cmp	w0, #0x29
104eac050: 540000c0    	b.eq	0x104eac068 <_Flutter_MMFoundation_BindContext+0x1387c4c>
104eac054: aa1403e0    	mov	x0, x20
104eac058: aa1503e1    	mov	x1, x21
104eac05c: 94b5ec38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac060: 71003c1f    	cmp	w0, #0xf
104eac064: 540000c1    	b.ne	0x104eac07c <_Flutter_MMFoundation_BindContext+0x1387c60>
104eac068: 900d7c88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104eac06c: f944bd01    	ldr	x1, [x8, #0x978] ; isOpenImChatroomAndUpgradeOpenIMChatroom
104eac070: aa1303e0    	mov	x0, x19
104eac074: 94b5ec32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac078: 370000c0    	tbnz	w0, #0x0, 0x104eac090 <_Flutter_MMFoundation_BindContext+0x1387c74>
104eac07c: d00d7d48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104eac080: f942c501    	ldr	x1, [x8, #0x588] ; isAccountDeleted
104eac084: aa1303e0    	mov	x0, x19
104eac088: 94b5ec2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac08c: 36000060    	tbz	w0, #0x0, 0x104eac098 <_Flutter_MMFoundation_BindContext+0x1387c7c>
104eac090: 52800014    	mov	w20, #0x0               ; =0
104eac094: 14000007    	b	0x104eac0b0 <_Flutter_MMFoundation_BindContext+0x1387c94>
104eac098: d00d7d48    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
104eac09c: f9433901    	ldr	x1, [x8, #0x670] ; isIgnore:
104eac0a0: aa1403e0    	mov	x0, x20
104eac0a4: aa1303e2    	mov	x2, x19
104eac0a8: 94b5ec25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104eac0ac: 52000014    	eor	w20, w0, #0x1
104eac0b0: aa1303e0    	mov	x0, x19
104eac0b4: 94b5ec28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104eac0b8: aa1403e0    	mov	x0, x20
104eac0bc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104eac0c0: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104eac0c4: a8c357f6    	ldp	x22, x21, [sp], #0x30
104eac0c8: d65f03c0    	ret
