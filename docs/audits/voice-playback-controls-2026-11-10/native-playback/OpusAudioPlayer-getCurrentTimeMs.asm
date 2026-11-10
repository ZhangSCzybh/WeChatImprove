
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105592f68: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105592f6c: a9017bfd    	stp	x29, x30, [sp, #0x10]
105592f70: 910043fd    	add	x29, sp, #0x10
105592f74: aa0003f3    	mov	x19, x0
105592f78: f00cb8c8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
105592f7c: f941ad14    	ldr	x20, [x8, #0x358]
105592f80: aa1403e1    	mov	x1, x20
105592f84: 949a5338    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592f88: f100041f    	cmp	x0, #0x1
105592f8c: 540000c0    	b.eq	0x105592fa4 <_Flutter_MMFoundation_BindContext+0x1819c70>
105592f90: aa1303e0    	mov	x0, x19
105592f94: aa1403e1    	mov	x1, x20
105592f98: 949a5333    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592f9c: f100081f    	cmp	x0, #0x2
105592fa0: 54000121    	b.ne	0x105592fc4 <_Flutter_MMFoundation_BindContext+0x1819c90>
105592fa4: 900cbf68    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105592fa8: 912ab108    	add	x8, x8, #0xaac
105592fac: b9800108    	ldrsw	x8, [x8]
105592fb0: f8686a68    	ldr	x8, [x19, x8]
105592fb4: b9400908    	ldr	w8, [x8, #0x8]
105592fb8: 52800c89    	mov	w9, #0x64               ; =100
105592fbc: 1b097d00    	mul	w0, w8, w9
105592fc0: 14000002    	b	0x105592fc8 <_Flutter_MMFoundation_BindContext+0x1819c94>
105592fc4: 52800000    	mov	w0, #0x0                ; =0
105592fc8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105592fcc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105592fd0: d65f03c0    	ret
