
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175e4294: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1175e4298: a9017bfd    	stp	x29, x30, [sp, #0x10]
1175e429c: 910043fd    	add	x29, sp, #0x10
1175e42a0: f0045c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1175e42a4: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1175e42a8: 900458e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175e42ac: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
1175e42b0: 9435168f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e42b4: aa1d03fd    	mov	x29, x29
1175e42b8: 943516b7    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175e42bc: aa0003f3    	mov	x19, x0
1175e42c0: 900442c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1175e42c4: f9453501    	ldr	x1, [x8, #0xa68] ; userName
1175e42c8: 94351689    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e42cc: aa1d03fd    	mov	x29, x29
1175e42d0: 943516b1    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175e42d4: aa0003f4    	mov	x20, x0
1175e42d8: aa1303e0    	mov	x0, x19
1175e42dc: 9435169f    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175e42e0: aa1403e0    	mov	x0, x20
1175e42e4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1175e42e8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1175e42ec: 1435163b    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>