
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10639dc0c: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
10639dc10: a90157f6    	stp	x22, x21, [sp, #0x10]
10639dc14: a9024ff4    	stp	x20, x19, [sp, #0x20]
10639dc18: a9037bfd    	stp	x29, x30, [sp, #0x30]
10639dc1c: 9100c3fd    	add	x29, sp, #0x30
10639dc20: aa0503f7    	mov	x23, x5
10639dc24: aa0403f6    	mov	x22, x4
10639dc28: aa0303f5    	mov	x21, x3
10639dc2c: aa0203f3    	mov	x19, x2
10639dc30: aa0203e0    	mov	x0, x2
10639dc34: 94622541    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10639dc38: d00ceea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10639dc3c: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10639dc40: f00ceb08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10639dc44: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
10639dc48: 9462253d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dc4c: aa1d03fd    	mov	x29, x29
10639dc50: 9462253e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639dc54: aa0003f4    	mov	x20, x0
10639dc58: d00ceb08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10639dc5c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector=class
10639dc60: 34000237    	cbz	w23, 0x10639dca4 <_Flutter_MMFoundation_BindContext+0x2879888>
10639dc64: d00ceee8    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
10639dc68: f940fd00    	ldr	x0, [x8, #0x1f8] ; class=VoIPilinkMgr
10639dc6c: 94622534    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dc70: aa0003e2    	mov	x2, x0
10639dc74: 900cd4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10639dc78: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
10639dc7c: aa1403e0    	mov	x0, x20
10639dc80: 9462252f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dc84: aa1d03fd    	mov	x29, x29
10639dc88: 94622530    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639dc8c: aa0003f7    	mov	x23, x0
10639dc90: d00ce1a8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10639dc94: f943b501    	ldr	x1, [x8, #0x768] ; selector=rejectWithRoomID:
10639dc98: aa1503e2    	mov	x2, x21
10639dc9c: 94622528    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dca0: 14000012    	b	0x10639dce8 <_Flutter_MMFoundation_BindContext+0x28798cc>
10639dca4: d00ceea8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10639dca8: f9472d00    	ldr	x0, [x8, #0xe58] ; class=VOIPMgr
10639dcac: 94622524    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dcb0: aa0003e2    	mov	x2, x0
10639dcb4: 900cd4e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10639dcb8: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
10639dcbc: aa1403e0    	mov	x0, x20
10639dcc0: 9462251f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dcc4: aa1d03fd    	mov	x29, x29
10639dcc8: 94622520    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10639dccc: aa0003f7    	mov	x23, x0
10639dcd0: b00ce1c8    	adrp	x8, 0x11ffd6000 <dyld_stub_binder+0x11ffd6000>
10639dcd4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=Reject:withRoomId:andKey:
10639dcd8: aa1303e2    	mov	x2, x19
10639dcdc: aa1503e3    	mov	x3, x21
10639dce0: aa1603e4    	mov	x4, x22
10639dce4: 94622516    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10639dce8: aa1703e0    	mov	x0, x23
10639dcec: 9462251a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639dcf0: aa1403e0    	mov	x0, x20
10639dcf4: 94622518    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10639dcf8: aa1303e0    	mov	x0, x19
10639dcfc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10639dd00: a9424ff4    	ldp	x20, x19, [sp, #0x20]
10639dd04: a94157f6    	ldp	x22, x21, [sp, #0x10]
10639dd08: a8c45ff8    	ldp	x24, x23, [sp], #0x40
10639dd0c: 14622512    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
