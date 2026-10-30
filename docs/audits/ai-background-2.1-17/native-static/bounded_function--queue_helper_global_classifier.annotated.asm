
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175b7694: d004e769    	adrp	x9, 0x1212a5000 <dyld_stub_binder+0x1212a5000>
1175b7698: f9432929    	ldr	x9, [x9, #0x650]
1175b769c: b4000049    	cbz	x9, 0x1175b76a4 <_O266DecReleaseOutputPicture+0x432abec>
1175b76a0: d61f0120    	br	x9
1175b76a4: aa0003e8    	mov	x8, x0
1175b76a8: 52800000    	mov	w0, #0x0                ; =0
1175b76ac: b40001e8    	cbz	x8, 0x1175b76e8 <_O266DecReleaseOutputPicture+0x432ac30>
1175b76b0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1175b76b4: a9017bfd    	stp	x29, x30, [sp, #0x10]
1175b76b8: 910043fd    	add	x29, sp, #0x10
1175b76bc: d004e773    	adrp	x19, 0x1212a5000 <dyld_stub_binder+0x1212a5000>
1175b76c0: f942fe69    	ldr	x9, [x19, #0x5f8]
1175b76c4: b40000e9    	cbz	x9, 0x1175b76e0 <_O266DecReleaseOutputPicture+0x432ac28>
1175b76c8: 91000501    	add	x1, x8, #0x1
1175b76cc: aa0803e0    	mov	x0, x8
1175b76d0: 9435c963    	bl	0x118329c5c <dyld_stub_binder+0x118329c5c>
1175b76d4: f942fe68    	ldr	x8, [x19, #0x5f8]
1175b76d8: eb08001f    	cmp	x0, x8
1175b76dc: 1a9f17e0    	cset	w0, eq
1175b76e0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1175b76e4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1175b76e8: d65f03c0    	ret
