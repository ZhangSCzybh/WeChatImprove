
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175fbff8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1175fbffc: a9017bfd    	stp	x29, x30, [sp, #0x10]
1175fc000: 910043fd    	add	x29, sp, #0x10
1175fc004: aa0003f3    	mov	x19, x0
1175fc008: 97ff2554    	bl	0x1175c5558 <_O266DecReleaseOutputPicture+0x4338aa0>
1175fc00c: d00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc010: b987a508    	ldrsw	x8, [x8, #0x7a4] ; ivar MMServiceWrapper.m_service offset=8 type=@"MMBaseService"
1175fc014: f8686a68    	ldr	x8, [x19, x8]
1175fc018: d00464c9    	adrp	x9, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc01c: 9119d129    	add	x9, x9, #0x674
1175fc020: b9800129    	ldrsw	x9, [x9]
1175fc024: f8696909    	ldr	x9, [x8, x9]
1175fc028: eb09001f    	cmp	x0, x9
1175fc02c: 9a9f0100    	csel	x0, x8, xzr, eq
1175fc030: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1175fc034: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1175fc038: d65f03c0    	ret
