
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105753e94: d100c3ff    	sub	sp, sp, #0x30
105753e98: a9014ff4    	stp	x20, x19, [sp, #0x10]
105753e9c: a9027bfd    	stp	x29, x30, [sp, #0x20]
105753ea0: 910083fd    	add	x29, sp, #0x20
105753ea4: d00da768    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
105753ea8: 52800029    	mov	w9, #0x1                ; =1
105753eac: 390a2509    	strb	w9, [x8, #0x289]
105753eb0: 900d53a8    	adrp	x8, 0x1201c7000 <dyld_stub_binder+0x1201c7000>
105753eb4: f9412908    	ldr	x8, [x8, #0x250] ; @u9
105753eb8: a90023e0    	stp	x0, x8, [sp]
105753ebc: f00d4d68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105753ec0: f9466901    	ldr	x1, [x8, #0xcd0] ; init
105753ec4: 910003e0    	mov	x0, sp
105753ec8: 94934c9f    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105753ecc: aa0003f3    	mov	x19, x0
105753ed0: b40004c0    	cbz	x0, 0x105753f68 <_Flutter_MMFoundation_BindContext+0x1c2fb4c>
105753ed4: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753ed8: b98b4108    	ldrsw	x8, [x8, #0xb40]
105753edc: f8686a60    	ldr	x0, [x19, x8]
105753ee0: f8286a7f    	str	xzr, [x19, x8]
105753ee4: 94934c9c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105753ee8: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753eec: b98b4508    	ldrsw	x8, [x8, #0xb44]
105753ef0: f8686a60    	ldr	x0, [x19, x8]
105753ef4: f8286a7f    	str	xzr, [x19, x8]
105753ef8: 94934c97    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105753efc: 900d5108    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105753f00: f9454100    	ldr	x0, [x8, #0xa80]
105753f04: 94934c95    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105753f08: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753f0c: b98b4909    	ldrsw	x9, [x8, #0xb48]
105753f10: f8696a68    	ldr	x8, [x19, x9]
105753f14: f8296a60    	str	x0, [x19, x9]
105753f18: aa0803e0    	mov	x0, x8
105753f1c: 94934c8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105753f20: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753f24: b98b4d08    	ldrsw	x8, [x8, #0xb4c]
105753f28: 52800069    	mov	w9, #0x3                ; =3
105753f2c: b8286a69    	str	w9, [x19, x8]
105753f30: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753f34: b98b5108    	ldrsw	x8, [x8, #0xb50]
105753f38: f8686a60    	ldr	x0, [x19, x8]
105753f3c: f8286a7f    	str	xzr, [x19, x8]
105753f40: 94934c85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105753f44: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753f48: b98b5508    	ldrsw	x8, [x8, #0xb54]
105753f4c: 38286a7f    	strb	wzr, [x19, x8]
105753f50: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753f54: b98b5908    	ldrsw	x8, [x8, #0xb58]
105753f58: 38286a7f    	strb	wzr, [x19, x8]
105753f5c: f00d56c8    	adrp	x8, 0x12022e000 <dyld_stub_binder+0x12022e000>
105753f60: b98b5d08    	ldrsw	x8, [x8, #0xb5c]
105753f64: f8286a7f    	str	xzr, [x19, x8]
105753f68: aa1303e0    	mov	x0, x19
105753f6c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105753f70: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105753f74: 9100c3ff    	add	sp, sp, #0x30
105753f78: d65f03c0    	ret
