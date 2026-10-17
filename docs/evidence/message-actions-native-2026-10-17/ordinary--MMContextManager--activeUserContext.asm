
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175e0330: d100c3ff    	sub	sp, sp, #0x30
1175e0334: a9014ff4    	stp	x20, x19, [sp, #0x10]
1175e0338: a9027bfd    	stp	x29, x30, [sp, #0x20]
1175e033c: 910083fd    	add	x29, sp, #0x20
1175e0340: aa0003f3    	mov	x19, x0
1175e0344: f9400801    	ldr	x1, [x0, #0x10]
1175e0348: 910003e0    	mov	x0, sp
1175e034c: 940010e7    	bl	0x1175e46e8 <_O266DecReleaseOutputPicture+0x4357c30>
1175e0350: f9400e73    	ldr	x19, [x19, #0x18]
1175e0354: aa1303e0    	mov	x0, x19
1175e0358: 94352686    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175e035c: 910003e0    	mov	x0, sp
1175e0360: 94001103    	bl	0x1175e476c <_O266DecReleaseOutputPicture+0x4357cb4>
1175e0364: aa1303e0    	mov	x0, x19
1175e0368: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1175e036c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1175e0370: 9100c3ff    	add	sp, sp, #0x30
1175e0374: 14352619    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>