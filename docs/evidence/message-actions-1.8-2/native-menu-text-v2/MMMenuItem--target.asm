
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167a6f40: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
1167a6f44: 910003fd    	mov	x29, sp
1167a6f48: f004d748    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167a6f4c: b98db508    	ldrsw	x8, [x8, #0xdb4]
1167a6f50: 8b080000    	add	x0, x0, x8
1167a6f54: 946e0b5a    	bl	0x118329cbc <dyld_stub_binder+0x118329cbc>
1167a6f58: a8c17bfd    	ldp	x29, x30, [sp], #0x10
1167a6f5c: 146e0b1f    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>