
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b494c: d100c3ff    	sub	sp, sp, #0x30
1002b4950: a9014ff4    	stp	x20, x19, [sp, #0x10]
1002b4954: a9027bfd    	stp	x29, x30, [sp, #0x20]
1002b4958: 910083fd    	add	x29, sp, #0x20
1002b495c: 900ea4c8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002b4960: f9451908    	ldr	x8, [x8, #0xa30]
1002b4964: f9400108    	ldr	x8, [x8]
1002b4968: f90007e8    	str	x8, [sp, #0x8]
1002b496c: 900f38e8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
1002b4970: f946b101    	ldr	x1, [x8, #0xd60]
1002b4974: 95e5ccbc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b4978: aa1d03fd    	mov	x29, x29
1002b497c: 95e5ccc1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002b4980: aa0003f4    	mov	x20, x0
1002b4984: f90003e0    	str	x0, [sp]
1002b4988: d00f52e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002b498c: f9434500    	ldr	x0, [x8, #0x688]
1002b4990: b00f4f88    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1002b4994: f946e101    	ldr	x1, [x8, #0xdc0]
1002b4998: 910003e2    	mov	x2, sp
1002b499c: 52800023    	mov	w3, #0x1                ; =1
1002b49a0: 95e5ccb1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002b49a4: aa1d03fd    	mov	x29, x29
1002b49a8: 95e5ccb6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002b49ac: aa0003f3    	mov	x19, x0
1002b49b0: aa1403e0    	mov	x0, x20
1002b49b4: 95e5ccaf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002b49b8: f94007e8    	ldr	x8, [sp, #0x8]
1002b49bc: 900ea4c9    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1002b49c0: f9451929    	ldr	x9, [x9, #0xa30]
1002b49c4: f9400129    	ldr	x9, [x9]
1002b49c8: eb08013f    	cmp	x9, x8
1002b49cc: 540000c1    	b.ne	0x1002b49e4 <__text+0x2ac9e4>
1002b49d0: aa1303e0    	mov	x0, x19
1002b49d4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1002b49d8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1002b49dc: 9100c3ff    	add	sp, sp, #0x30
1002b49e0: 15e5cc90    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
1002b49e4: 95e5cb53    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
