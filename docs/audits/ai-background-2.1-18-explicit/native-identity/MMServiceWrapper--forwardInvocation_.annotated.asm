
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175fc100: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1175fc104: a90157f6    	stp	x22, x21, [sp, #0x10]
1175fc108: a9024ff4    	stp	x20, x19, [sp, #0x20]
1175fc10c: a9037bfd    	stp	x29, x30, [sp, #0x30]
1175fc110: 9100c3fd    	add	x29, sp, #0x30
1175fc114: aa0203f3    	mov	x19, x2
1175fc118: aa0003f4    	mov	x20, x0
1175fc11c: d00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc120: b987a516    	ldrsw	x22, [x8, #0x7a4] ; ivar MMServiceWrapper.m_service offset=8 type=@"MMBaseService"
1175fc124: f8766808    	ldr	x8, [x0, x22]
1175fc128: d00464c9    	adrp	x9, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc12c: 9119d129    	add	x9, x9, #0x674
1175fc130: b9800129    	ldrsw	x9, [x9]
1175fc134: f8696915    	ldr	x21, [x8, x9]
1175fc138: f0045bb7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
1175fc13c: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
1175fc140: b0044208    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1175fc144: f941d901    	ldr	x1, [x8, #0x3b0] ; selector/string push:
1175fc148: aa1503e2    	mov	x2, x21
1175fc14c: 9434b6e8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175fc150: f8766a82    	ldr	x2, [x20, x22]
1175fc154: 90044388    	adrp	x8, 0x11fe6c000 <dyld_stub_binder+0x11fe6c000>
1175fc158: f9418d01    	ldr	x1, [x8, #0x318] ; selector/string invokeWithTarget:
1175fc15c: aa1303e0    	mov	x0, x19
1175fc160: 9434b6e3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175fc164: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
1175fc168: b0044208    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1175fc16c: f941dd01    	ldr	x1, [x8, #0x3b8] ; selector/string pop:
1175fc170: aa1503e2    	mov	x2, x21
1175fc174: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1175fc178: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1175fc17c: a94157f6    	ldp	x22, x21, [sp, #0x10]
1175fc180: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1175fc184: 1434b6da    	b	0x118329cec <dyld_stub_binder+0x118329cec>
