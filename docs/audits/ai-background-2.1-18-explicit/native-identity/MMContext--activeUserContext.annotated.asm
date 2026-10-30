
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175c4dfc: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
1175c4e00: 910003fd    	mov	x29, sp
1175c4e04: b0045d88    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1175c4e08: f942c500    	ldr	x0, [x8, #0x588] ; class MMContextManager
1175c4e0c: 900459e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1175c4e10: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector/string defaultManager
1175c4e14: 943593b6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175c4e18: b00443a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1175c4e1c: f9469901    	ldr	x1, [x8, #0xd30] ; selector/string activeUserContext
1175c4e20: a8c17bfd    	ldp	x29, x30, [sp], #0x10
1175c4e24: 143593b2    	b	0x118329cec <dyld_stub_binder+0x118329cec>
