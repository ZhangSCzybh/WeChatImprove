
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175e4054: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1175e4058: a9017bfd    	stp	x29, x30, [sp, #0x10]
1175e405c: 910043fd    	add	x29, sp, #0x10
1175e4060: b0053088    	adrp	x8, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
1175e4064: 9114e108    	add	x8, x8, #0x538
1175e4068: f9400108    	ldr	x8, [x8]
1175e406c: b0053089    	adrp	x9, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
1175e4070: 91150129    	add	x9, x9, #0x540
1175e4074: f9400129    	ldr	x9, [x9]
1175e4078: eb00011f    	cmp	x8, x0
1175e407c: fa401124    	ccmp	x9, x0, #0x4, ne
1175e4080: 54000241    	b.ne	0x1175e40c8 <_O266DecReleaseOutputPicture+0x4357610>
1175e4084: f0045c68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1175e4088: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
1175e408c: b00442a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1175e4090: f9469901    	ldr	x1, [x8, #0xd30] ; activeUserContext
1175e4094: 94351716    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e4098: aa1d03fd    	mov	x29, x29
1175e409c: 9435173e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175e40a0: aa0003f4    	mov	x20, x0
1175e40a4: 900442c8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1175e40a8: f9453501    	ldr	x1, [x8, #0xa68] ; userName
1175e40ac: 94351710    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e40b0: aa1d03fd    	mov	x29, x29
1175e40b4: 94351738    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1175e40b8: aa0003f3    	mov	x19, x0
1175e40bc: aa1403e0    	mov	x0, x20
1175e40c0: 94351726    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175e40c4: 14000004    	b	0x1175e40d4 <_O266DecReleaseOutputPicture+0x435761c>
1175e40c8: f9402813    	ldr	x19, [x0, #0x50]
1175e40cc: aa1303e0    	mov	x0, x19
1175e40d0: 94351728    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175e40d4: aa1303e0    	mov	x0, x19
1175e40d8: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1175e40dc: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1175e40e0: 143516be    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>