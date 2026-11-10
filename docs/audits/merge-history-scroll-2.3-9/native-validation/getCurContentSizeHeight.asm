
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100302dc8: d104c3ff    	sub	sp, sp, #0x130
100302dcc: a90d6ffc    	stp	x28, x27, [sp, #0xd0]
100302dd0: a90e67fa    	stp	x26, x25, [sp, #0xe0]
100302dd4: a90f5ff8    	stp	x24, x23, [sp, #0xf0]
100302dd8: a91057f6    	stp	x22, x21, [sp, #0x100]
100302ddc: a9114ff4    	stp	x20, x19, [sp, #0x110]
100302de0: a9127bfd    	stp	x29, x30, [sp, #0x120]
100302de4: 910483fd    	add	x29, sp, #0x120
100302de8: aa0003f3    	mov	x19, x0
100302dec: d00ea248    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100302df0: f9451908    	ldr	x8, [x8, #0xa30]
100302df4: f9400108    	ldr	x8, [x8]
100302df8: f81a83a8    	stur	x8, [x29, #-0x58]
100302dfc: d00fa1e8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100302e00: 52800029    	mov	w9, #0x1                ; =1
100302e04: 3928fd09    	strb	w9, [x8, #0xa3f]
100302e08: 900f53e8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
100302e0c: b98cfd08    	ldrsw	x8, [x8, #0xcfc]
100302e10: f8686800    	ldr	x0, [x0, x8]
100302e14: f00f36c8    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
100302e18: f9439501    	ldr	x1, [x8, #0x728]
100302e1c: 95e49392    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100302e20: aa1d03fd    	mov	x29, x29
100302e24: 95e49397    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100302e28: aa0003f4    	mov	x20, x0
100302e2c: b00f4d28    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
100302e30: f9433501    	ldr	x1, [x8, #0x668]
100302e34: 95e4938c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100302e38: 1e790077    	fcvtzu	w23, d3
100302e3c: aa1403e0    	mov	x0, x20
100302e40: 95e4938c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100302e44: 4f00e400    	movi.16b	v0, #0x0
100302e48: ad0103e0    	stp	q0, q0, [sp, #0x20]
100302e4c: ad0003e0    	stp	q0, q0, [sp]
100302e50: 900f53e8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
100302e54: b98cf508    	ldrsw	x8, [x8, #0xcf4]
100302e58: f8686a73    	ldr	x19, [x19, x8]
100302e5c: aa1303e0    	mov	x0, x19
100302e60: 95e49385    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100302e64: 900f4d28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100302e68: f9442d14    	ldr	x20, [x8, #0x858]
100302e6c: 910003e2    	mov	x2, sp
100302e70: 910123e3    	add	x3, sp, #0x48
100302e74: aa1403e1    	mov	x1, x20
100302e78: 52800204    	mov	w4, #0x10               ; =16
100302e7c: 95e4937a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100302e80: b40003e0    	cbz	x0, 0x100302efc <__text+0x2faefc>
100302e84: aa0003f5    	mov	x21, x0
100302e88: f9400be8    	ldr	x8, [sp, #0x10]
100302e8c: f9400118    	ldr	x24, [x8]
100302e90: f00f36d9    	adrp	x25, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
100302e94: d280001a    	mov	x26, #0x0               ; =0
100302e98: f9439b36    	ldr	x22, [x25, #0x730]
100302e9c: f9400be8    	ldr	x8, [sp, #0x10]
100302ea0: f9400108    	ldr	x8, [x8]
100302ea4: eb18011f    	cmp	x8, x24
100302ea8: 54000060    	b.eq	0x100302eb4 <__text+0x2faeb4>
100302eac: aa1303e0    	mov	x0, x19
100302eb0: 95e49363    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
100302eb4: f94007e8    	ldr	x8, [sp, #0x8]
100302eb8: f87a7900    	ldr	x0, [x8, x26, lsl #3]
100302ebc: aa1603e1    	mov	x1, x22
100302ec0: 95e49369    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100302ec4: 1e6302e1    	ucvtf	d1, w23
100302ec8: 1e612800    	fadd	d0, d0, d1
100302ecc: 1e790017    	fcvtzu	w23, d0
100302ed0: 9100075a    	add	x26, x26, #0x1
100302ed4: eb1a02bf    	cmp	x21, x26
100302ed8: 54fffe21    	b.ne	0x100302e9c <__text+0x2fae9c>
100302edc: 910003e2    	mov	x2, sp
100302ee0: 910123e3    	add	x3, sp, #0x48
100302ee4: aa1303e0    	mov	x0, x19
100302ee8: aa1403e1    	mov	x1, x20
100302eec: 52800204    	mov	w4, #0x10               ; =16
100302ef0: 95e4935d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100302ef4: aa0003f5    	mov	x21, x0
100302ef8: b5fffce0    	cbnz	x0, 0x100302e94 <__text+0x2fae94>
100302efc: aa1303e0    	mov	x0, x19
100302f00: 95e4935c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100302f04: f85a83a8    	ldur	x8, [x29, #-0x58]
100302f08: d00ea249    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100302f0c: f9451929    	ldr	x9, [x9, #0xa30]
100302f10: f9400129    	ldr	x9, [x9]
100302f14: eb08013f    	cmp	x9, x8
100302f18: 54000141    	b.ne	0x100302f40 <__text+0x2faf40>
100302f1c: 2a1703e0    	mov	w0, w23
100302f20: a9527bfd    	ldp	x29, x30, [sp, #0x120]
100302f24: a9514ff4    	ldp	x20, x19, [sp, #0x110]
100302f28: a95057f6    	ldp	x22, x21, [sp, #0x100]
100302f2c: a94f5ff8    	ldp	x24, x23, [sp, #0xf0]
100302f30: a94e67fa    	ldp	x26, x25, [sp, #0xe0]
100302f34: a94d6ffc    	ldp	x28, x27, [sp, #0xd0]
100302f38: 9104c3ff    	add	sp, sp, #0x130
100302f3c: d65f03c0    	ret
100302f40: 95e491fc    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
