
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ccaf30: d10503ff    	sub	sp, sp, #0x140
104ccaf34: a90e6ffc    	stp	x28, x27, [sp, #0xe0]
104ccaf38: a90f67fa    	stp	x26, x25, [sp, #0xf0]
104ccaf3c: a9105ff8    	stp	x24, x23, [sp, #0x100]
104ccaf40: a91157f6    	stp	x22, x21, [sp, #0x110]
104ccaf44: a9124ff4    	stp	x20, x19, [sp, #0x120]
104ccaf48: a9137bfd    	stp	x29, x30, [sp, #0x130]
104ccaf4c: 9104c3fd    	add	x29, sp, #0x130
104ccaf50: b00c4928    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ccaf54: f9405908    	ldr	x8, [x8, #0xb0]
104ccaf58: f9400108    	ldr	x8, [x8]
104ccaf5c: f81a03a8    	stur	x8, [x29, #-0x60]
104ccaf60: 900dfba8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104ccaf64: 52800029    	mov	w9, #0x1                ; =1
104ccaf68: 392c6909    	strb	w9, [x8, #0xb1a]
104ccaf6c: 4f00e400    	movi.16b	v0, #0x0
104ccaf70: ad0083e0    	stp	q0, q0, [sp, #0x10]
104ccaf74: ad0183e0    	stp	q0, q0, [sp, #0x30]
104ccaf78: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104ccaf7c: f9449101    	ldr	x1, [x8, #0x920] ; m_logicArray
104ccaf80: 94bd706f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccaf84: aa1d03fd    	mov	x29, x29
104ccaf88: 94bd7070    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ccaf8c: aa0003f3    	mov	x19, x0
104ccaf90: d00da1a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104ccaf94: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104ccaf98: 910043e2    	add	x2, sp, #0x10
104ccaf9c: 910143e3    	add	x3, sp, #0x50
104ccafa0: f90007e1    	str	x1, [sp, #0x8]
104ccafa4: 52800204    	mov	w4, #0x10               ; =16
104ccafa8: 94bd7065    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccafac: b40006a0    	cbz	x0, 0x104ccb080 <_Flutter_MMFoundation_BindContext+0x11a6c64>
104ccafb0: aa0003f5    	mov	x21, x0
104ccafb4: f94013e8    	ldr	x8, [sp, #0x20]
104ccafb8: f940011c    	ldr	x28, [x8]
104ccafbc: d2800014    	mov	x20, #0x0               ; =0
104ccafc0: f00d8b68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ccafc4: f946b116    	ldr	x22, [x8, #0xd60] ; m_delegate
104ccafc8: d00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104ccafcc: f9456117    	ldr	x23, [x8, #0xac0] ; didMonoServiceRejectMsg
104ccafd0: 900da1e8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104ccafd4: f9436118    	ldr	x24, [x8, #0x6c0] ; respondsToSelector:
104ccafd8: f94013e8    	ldr	x8, [sp, #0x20]
104ccafdc: f9400108    	ldr	x8, [x8]
104ccafe0: eb1c011f    	cmp	x8, x28
104ccafe4: 54000060    	b.eq	0x104ccaff0 <_Flutter_MMFoundation_BindContext+0x11a6bd4>
104ccafe8: aa1303e0    	mov	x0, x19
104ccafec: 94bd7059    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
104ccaff0: f9400fe8    	ldr	x8, [sp, #0x18]
104ccaff4: f8747919    	ldr	x25, [x8, x20, lsl #3]
104ccaff8: aa1903e0    	mov	x0, x25
104ccaffc: aa1603e1    	mov	x1, x22
104ccb000: 94bd704f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccb004: aa1d03fd    	mov	x29, x29
104ccb008: 94bd7050    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ccb00c: aa0003fa    	mov	x26, x0
104ccb010: aa1803e1    	mov	x1, x24
104ccb014: aa1703e2    	mov	x2, x23
104ccb018: 94bd7049    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccb01c: aa0003fb    	mov	x27, x0
104ccb020: aa1a03e0    	mov	x0, x26
104ccb024: 94bd704c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ccb028: 3400017b    	cbz	w27, 0x104ccb054 <_Flutter_MMFoundation_BindContext+0x11a6c38>
104ccb02c: aa1903e0    	mov	x0, x25
104ccb030: aa1603e1    	mov	x1, x22
104ccb034: 94bd7042    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccb038: aa1d03fd    	mov	x29, x29
104ccb03c: 94bd7043    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ccb040: aa0003f9    	mov	x25, x0
104ccb044: aa1703e1    	mov	x1, x23
104ccb048: 94bd703d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccb04c: aa1903e0    	mov	x0, x25
104ccb050: 94bd7041    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ccb054: 91000694    	add	x20, x20, #0x1
104ccb058: eb1402bf    	cmp	x21, x20
104ccb05c: 54fffbe1    	b.ne	0x104ccafd8 <_Flutter_MMFoundation_BindContext+0x11a6bbc>
104ccb060: 910043e2    	add	x2, sp, #0x10
104ccb064: 910143e3    	add	x3, sp, #0x50
104ccb068: aa1303e0    	mov	x0, x19
104ccb06c: f94007e1    	ldr	x1, [sp, #0x8]
104ccb070: 52800204    	mov	w4, #0x10               ; =16
104ccb074: 94bd7032    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ccb078: aa0003f5    	mov	x21, x0
104ccb07c: b5fffa00    	cbnz	x0, 0x104ccafbc <_Flutter_MMFoundation_BindContext+0x11a6ba0>
104ccb080: aa1303e0    	mov	x0, x19
104ccb084: 94bd7034    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ccb088: f85a03a8    	ldur	x8, [x29, #-0x60]
104ccb08c: 900c4929    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ccb090: f9405929    	ldr	x9, [x9, #0xb0]
104ccb094: f9400129    	ldr	x9, [x9]
104ccb098: eb08013f    	cmp	x9, x8
104ccb09c: 54000121    	b.ne	0x104ccb0c0 <_Flutter_MMFoundation_BindContext+0x11a6ca4>
104ccb0a0: a9537bfd    	ldp	x29, x30, [sp, #0x130]
104ccb0a4: a9524ff4    	ldp	x20, x19, [sp, #0x120]
104ccb0a8: a95157f6    	ldp	x22, x21, [sp, #0x110]
104ccb0ac: a9505ff8    	ldp	x24, x23, [sp, #0x100]
104ccb0b0: a94f67fa    	ldp	x26, x25, [sp, #0xf0]
104ccb0b4: a94e6ffc    	ldp	x28, x27, [sp, #0xe0]
104ccb0b8: 910503ff    	add	sp, sp, #0x140
104ccb0bc: d65f03c0    	ret
104ccb0c0: 94bd702d    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
