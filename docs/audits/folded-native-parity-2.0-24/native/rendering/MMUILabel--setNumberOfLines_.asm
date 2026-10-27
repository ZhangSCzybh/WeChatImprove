
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1166bcb44: d10103ff    	sub	sp, sp, #0x40
1166bcb48: a90157f6    	stp	x22, x21, [sp, #0x10]
1166bcb4c: a9024ff4    	stp	x20, x19, [sp, #0x20]
1166bcb50: a9037bfd    	stp	x29, x30, [sp, #0x30]
1166bcb54: 9100c3fd    	add	x29, sp, #0x30
1166bcb58: aa0003f3    	mov	x19, x0
1166bcb5c: d004d8e8    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1166bcb60: f944e908    	ldr	x8, [x8, #0x9d0] ; MMUILabel
1166bcb64: a90023e0    	stp	x0, x8, [sp]
1166bcb68: 9004d268    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1166bcb6c: f947f901    	ldr	x1, [x8, #0xff0] ; setNumberOfLines:
1166bcb70: 910003e0    	mov	x0, sp
1166bcb74: 9471b461    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1166bcb78: f004d268    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1166bcb7c: f9401515    	ldr	x21, [x8, #0x28] ; text
1166bcb80: aa1303e0    	mov	x0, x19
1166bcb84: aa1503e1    	mov	x1, x21
1166bcb88: 9471b459    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bcb8c: aa1d03fd    	mov	x29, x29
1166bcb90: 9471b481    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166bcb94: aa0003f4    	mov	x20, x0
1166bcb98: f004d228    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1166bcb9c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1166bcba0: 9471b453    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bcba4: b40002a0    	cbz	x0, 0x1166bcbf8 <_O266DecReleaseOutputPicture+0x3430140>
1166bcba8: 9004bda8    	adrp	x8, 0x11fe70000 <dyld_stub_binder+0x11fe70000>
1166bcbac: f9433901    	ldr	x1, [x8, #0x670] ; numberOfLines
1166bcbb0: aa1303e0    	mov	x0, x19
1166bcbb4: 9471b44e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bcbb8: aa0003f6    	mov	x22, x0
1166bcbbc: aa1403e0    	mov	x0, x20
1166bcbc0: 9471b466    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166bcbc4: f10006df    	cmp	x22, #0x1
1166bcbc8: 540001c0    	b.eq	0x1166bcc00 <_O266DecReleaseOutputPicture+0x3430148>
1166bcbcc: aa1303e0    	mov	x0, x19
1166bcbd0: aa1503e1    	mov	x1, x21
1166bcbd4: 9471b446    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bcbd8: aa1d03fd    	mov	x29, x29
1166bcbdc: 9471b46e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166bcbe0: aa0003f4    	mov	x20, x0
1166bcbe4: b004d268    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1166bcbe8: f9468d01    	ldr	x1, [x8, #0xd18] ; setText:
1166bcbec: aa1303e0    	mov	x0, x19
1166bcbf0: aa1403e2    	mov	x2, x20
1166bcbf4: 9471b43e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bcbf8: aa1403e0    	mov	x0, x20
1166bcbfc: 9471b457    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166bcc00: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1166bcc04: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1166bcc08: a94157f6    	ldp	x22, x21, [sp, #0x10]
1166bcc0c: 910103ff    	add	sp, sp, #0x40
1166bcc10: d65f03c0    	ret
