
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10700cdfc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10700ce00: a9017bfd    	stp	x29, x30, [sp, #0x10]
10700ce04: 910043fd    	add	x29, sp, #0x10
10700ce08: aa0203f3    	mov	x19, x2
10700ce0c: aa0203e0    	mov	x0, x2
10700ce10: 943068ca    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10700ce14: b00c87c8    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
10700ce18: f9466501    	ldr	x1, [x8, #0xcc8] ; selector rangeOfString:options:
10700ce1c: f00bc642    	adrp	x2, 0x11e8d7000 <dyld_stub_binder+0x11e8d7000>
10700ce20: 9133a042    	add	x2, x2, #0xce8 ; CFString 'weixin://dl/'
10700ce24: aa1303e0    	mov	x0, x19
10700ce28: 52800023    	mov	w3, #0x1                ; =1
10700ce2c: 943068c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700ce30: f100001f    	cmp	x0, #0x0
10700ce34: fa400824    	ccmp	x1, #0x0, #0x4, eq
10700ce38: 54000061    	b.ne	0x10700ce44 <_Flutter_MMFoundation_BindContext+0x34e8a28>
10700ce3c: d2800014    	mov	x20, #0x0               ; =0
10700ce40: 14000009    	b	0x10700ce64 <_Flutter_MMFoundation_BindContext+0x34e8a48>
10700ce44: aa0103e2    	mov	x2, x1
10700ce48: d00c87e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10700ce4c: f9472d01    	ldr	x1, [x8, #0xe58] ; selector substringFromIndex:
10700ce50: aa1303e0    	mov	x0, x19
10700ce54: 943068ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700ce58: aa1d03fd    	mov	x29, x29
10700ce5c: 943068bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700ce60: aa0003f4    	mov	x20, x0
10700ce64: aa1303e0    	mov	x0, x19
10700ce68: 943068bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700ce6c: aa1403e0    	mov	x0, x20
10700ce70: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10700ce74: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10700ce78: 143068be    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
