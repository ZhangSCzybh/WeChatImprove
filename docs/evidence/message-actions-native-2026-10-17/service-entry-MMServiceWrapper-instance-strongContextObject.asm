
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
11758d43c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
11758d440: a9017bfd    	stp	x29, x30, [sp, #0x10]
11758d444: 910043fd    	add	x29, sp, #0x10
11758d448: aa0003f3    	mov	x19, x0
11758d44c: d0045f28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
11758d450: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
11758d454: f0045b88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
11758d458: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
11758d45c: 94367224    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11758d460: aa0003e2    	mov	x2, x0
11758d464: 90045b68    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
11758d468: f9430501    	ldr	x1, [x8, #0x608] ; strongContextObjectWithContext:
11758d46c: aa1303e0    	mov	x0, x19
11758d470: a9417bfd    	ldp	x29, x30, [sp, #0x10]
11758d474: a8c24ff4    	ldp	x20, x19, [sp], #0x20
11758d478: 1436721d    	b	0x118329cec <dyld_stub_binder+0x118329cec>