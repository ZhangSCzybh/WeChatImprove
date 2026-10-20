
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fdb048: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
100fdb04c: a90157f6    	stp	x22, x21, [sp, #0x10]
100fdb050: a9024ff4    	stp	x20, x19, [sp, #0x20]
100fdb054: a9037bfd    	stp	x29, x30, [sp, #0x30]
100fdb058: 9100c3fd    	add	x29, sp, #0x30
100fdb05c: aa0403f4    	mov	x20, x4
100fdb060: aa0303f5    	mov	x21, x3
100fdb064: aa0203f3    	mov	x19, x2
100fdb068: aa0003f6    	mov	x22, x0
100fdb06c: b00fe2a8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100fdb070: 52800029    	mov	w9, #0x1                ; =1
100fdb074: 39307909    	strb	w9, [x8, #0xc1e]
100fdb078: aa0203e0    	mov	x0, x2
100fdb07c: 95b1302f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100fdb080: 900f7568    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fdb084: f941e101    	ldr	x1, [x8, #0x3c0] ; ModifyNotifyStatus:withStatus:
100fdb088: 520002a3    	eor	w3, w21, #0x1
100fdb08c: aa1603e0    	mov	x0, x22
100fdb090: aa1303e2    	mov	x2, x19
100fdb094: 95b1302a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb098: b00f8cc8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100fdb09c: f9400100    	ldr	x0, [x8]
100fdb0a0: b00f7308    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100fdb0a4: f944e101    	ldr	x1, [x8, #0x9c0] ; IsOpenIMChatRoom:
100fdb0a8: aa1303e2    	mov	x2, x19
100fdb0ac: 95b13024    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb0b0: 34000420    	cbz	w0, 0x100fdb134 <__text+0xfd3134>
100fdb0b4: 900f8cc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fdb0b8: f945e900    	ldr	x0, [x8, #0xbd0]
100fdb0bc: b00f8928    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100fdb0c0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100fdb0c4: 95b1301e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb0c8: aa1d03fd    	mov	x29, x29
100fdb0cc: 95b1301f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fdb0d0: aa0003f6    	mov	x22, x0
100fdb0d4: 900f8cc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100fdb0d8: f947dd00    	ldr	x0, [x8, #0xfb8]
100fdb0dc: 900f8928    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100fdb0e0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100fdb0e4: 95b13016    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb0e8: aa0003e2    	mov	x2, x0
100fdb0ec: d00f72e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100fdb0f0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
100fdb0f4: aa1603e0    	mov	x0, x22
100fdb0f8: 95b13011    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb0fc: aa1d03fd    	mov	x29, x29
100fdb100: 95b13012    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100fdb104: aa0003f7    	mov	x23, x0
100fdb108: 900f7568    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fdb10c: f941e501    	ldr	x1, [x8, #0x3c8] ; setOpenImChatRoom:mute:sync:
100fdb110: 520002a3    	eor	w3, w21, #0x1
100fdb114: aa1303e2    	mov	x2, x19
100fdb118: aa1403e4    	mov	x4, x20
100fdb11c: 95b13008    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb120: aa1703e0    	mov	x0, x23
100fdb124: 95b1300c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb128: aa1603e0    	mov	x0, x22
100fdb12c: 95b1300a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb130: 1400000a    	b	0x100fdb158 <__text+0xfd3158>
100fdb134: d00f9068    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100fdb138: b98d2908    	ldrsw	x8, [x8, #0xd28]
100fdb13c: f8686ac0    	ldr	x0, [x22, x8]
100fdb140: 900f7568    	adrp	x8, 0x11fe87000 <dyld_stub_binder+0x11fe87000>
100fdb144: f941e901    	ldr	x1, [x8, #0x3d0] ; add_ModifyNotifyStatus:withStatus:NeedSync:
100fdb148: 520002a3    	eor	w3, w21, #0x1
100fdb14c: aa1303e2    	mov	x2, x19
100fdb150: aa1403e4    	mov	x4, x20
100fdb154: 95b12ffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100fdb158: aa1303e0    	mov	x0, x19
100fdb15c: 95b12ffe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100fdb160: 52800020    	mov	w0, #0x1                ; =1
100fdb164: a9437bfd    	ldp	x29, x30, [sp, #0x30]
100fdb168: a9424ff4    	ldp	x20, x19, [sp, #0x20]
100fdb16c: a94157f6    	ldp	x22, x21, [sp, #0x10]
100fdb170: a8c45ff8    	ldp	x24, x23, [sp], #0x40
100fdb174: d65f03c0    	ret
