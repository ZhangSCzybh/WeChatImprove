
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b12d0: d100c3ff    	sub	sp, sp, #0x30
1002b12d4: a9014ff4    	stp	x20, x19, [sp, #0x10]
1002b12d8: a9027bfd    	stp	x29, x30, [sp, #0x20]
1002b12dc: 910083fd    	add	x29, sp, #0x20
1002b12e0: aa0003f3    	mov	x19, x0
1002b12e4: f00ff828    	adrp	x8, 0x1201b8000 <dyld_stub_binder+0x1201b8000>
1002b12e8: f943a508    	ldr	x8, [x8, #0x748] ; �+* 
1002b12ec: a90023e0    	stp	x0, x8, [sp]
1002b12f0: b00fdcc8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1002b12f4: f9409d01    	ldr	x1, [x8, #0x138] ; resetLayoutCache
1002b12f8: 910003e0    	mov	x0, sp
1002b12fc: 95e5d792    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1002b1300: d00ff968    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002b1304: b982dd08    	ldrsw	x8, [x8, #0x2dc]
1002b1308: 900e99e9    	adrp	x9, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
1002b130c: f9417929    	ldr	x9, [x9, #0x2f0]
1002b1310: 3dc00120    	ldr	q0, [x9]
1002b1314: 3ca86a60    	str	q0, [x19, x8]
1002b1318: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1002b131c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1002b1320: 9100c3ff    	add	sp, sp, #0x30
1002b1324: d65f03c0    	ret