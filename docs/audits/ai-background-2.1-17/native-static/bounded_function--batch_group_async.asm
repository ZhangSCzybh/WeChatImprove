
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175798b8: d004e929    	adrp	x9, 0x12129f000 <dyld_stub_binder+0x12129f000>
1175798bc: f940c929    	ldr	x9, [x9, #0x190]
1175798c0: b4000049    	cbz	x9, 0x1175798c8 <_O266DecReleaseOutputPicture+0x42ece10>
1175798c4: d61f0120    	br	x9
1175798c8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1175798cc: a9014ff4    	stp	x20, x19, [sp, #0x10]
1175798d0: a9027bfd    	stp	x29, x30, [sp, #0x20]
1175798d4: 910083fd    	add	x29, sp, #0x20
1175798d8: aa0203f5    	mov	x21, x2
1175798dc: aa0103f3    	mov	x19, x1
1175798e0: aa0003f4    	mov	x20, x0
1175798e4: 900533f6    	adrp	x22, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
1175798e8: f9427ac8    	ldr	x8, [x22, #0x4f0]
1175798ec: b50000c8    	cbnz	x8, 0x117579904 <_O266DecReleaseOutputPicture+0x42ece4c>
1175798f0: 9002a0e1    	adrp	x1, 0x11c995000 <dyld_stub_binder+0x11c995000>
1175798f4: 91346821    	add	x1, x1, #0xd1a
1175798f8: 92800000    	mov	x0, #-0x1               ; =-1
1175798fc: 9436ba84    	bl	0x11832830c <dyld_stub_binder+0x11832830c>
117579900: f9027ac0    	str	x0, [x22, #0x4f0]
117579904: aa1503e0    	mov	x0, x21
117579908: 97fffe54    	bl	0x117579258 <_O266DecReleaseOutputPicture+0x42ec7a0>
11757990c: aa0003f5    	mov	x21, x0
117579910: f9427ac8    	ldr	x8, [x22, #0x4f0]
117579914: aa1403e0    	mov	x0, x20
117579918: aa1303e1    	mov	x1, x19
11757991c: aa1503e2    	mov	x2, x21
117579920: d63f0100    	blr	x8
117579924: aa1503e0    	mov	x0, x21
117579928: a9427bfd    	ldp	x29, x30, [sp, #0x20]
11757992c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
117579930: a8c357f6    	ldp	x22, x21, [sp], #0x30
117579934: 1436c109    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
