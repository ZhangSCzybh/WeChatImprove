
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175fbe48: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1175fbe4c: a9017bfd    	stp	x29, x30, [sp, #0x10]
1175fbe50: 910043fd    	add	x29, sp, #0x10
1175fbe54: aa0003f3    	mov	x19, x0
1175fbe58: aa0203e0    	mov	x0, x2
1175fbe5c: 9434b7c5    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175fbe60: f00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fbe64: b987a508    	ldrsw	x8, [x8, #0x7a4]
1175fbe68: f8286a60    	str	x0, [x19, x8]
1175fbe6c: f00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fbe70: b987a908    	ldrsw	x8, [x8, #0x7a8]
1175fbe74: b8286a7f    	str	wzr, [x19, x8]
1175fbe78: aa1303e0    	mov	x0, x19
1175fbe7c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1175fbe80: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1175fbe84: d65f03c0    	ret