
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a9f00: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1002a9f04: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002a9f08: 910043fd    	add	x29, sp, #0x10
1002a9f0c: aa0003f3    	mov	x19, x0
1002a9f10: 900f5028    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1002a9f14: f941ad14    	ldr	x20, [x8, #0x358]
1002a9f18: aa1403e1    	mov	x1, x20
1002a9f1c: 95e5f752    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9f20: f100041f    	cmp	x0, #0x1
1002a9f24: 540000c0    	b.eq	0x1002a9f3c <__text+0x2a1f3c>
1002a9f28: aa1303e0    	mov	x0, x19
1002a9f2c: aa1403e1    	mov	x1, x20
1002a9f30: 95e5f74d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9f34: f100081f    	cmp	x0, #0x2
1002a9f38: 540000c1    	b.ne	0x1002a9f50 <__text+0x2a1f50>
1002a9f3c: f9400668    	ldr	x8, [x19, #0x8]
1002a9f40: b9400908    	ldr	w8, [x8, #0x8]
1002a9f44: 52807d09    	mov	w9, #0x3e8              ; =1000
1002a9f48: 1b097d00    	mul	w0, w8, w9
1002a9f4c: 14000002    	b	0x1002a9f54 <__text+0x2a1f54>
1002a9f50: 52800000    	mov	w0, #0x0                ; =0
1002a9f54: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002a9f58: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1002a9f5c: d65f03c0    	ret
