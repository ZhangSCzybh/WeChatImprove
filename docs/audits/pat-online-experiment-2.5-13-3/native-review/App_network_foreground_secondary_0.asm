
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000010aec2da4 <_mmkv_importFrom>:
10b7439a0: f00a0609    	adrp	x9, 0x11f806000 <dyld_stub_binder+0x11f806000>
10b7439a4: f9474529    	ldr	x9, [x9, #0xe88] ; 0x11f806e88 __bss
10b7439a8: b4000049    	cbz	x9, 0x10b7439b0 <_mmkv_importFrom+0x880c0c>
10b7439ac: d61f0120    	br	x9
10b7439b0: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10b7439b4: a9017bfd    	stp	x29, x30, [sp, #0x10]
10b7439b8: 910043fd    	add	x29, sp, #0x10
10b7439bc: aa0103f3    	mov	x19, x1
10b7439c0: aa0003f4    	mov	x20, x0
10b7439c4: 9400028a    	bl	0x10b7443ec <_mmkv_importFrom+0x881648>
10b7439c8: f9400400    	ldr	x0, [x0, #0x8]
10b7439cc: aa1403e1    	mov	x1, x20
10b7439d0: aa1303e2    	mov	x2, x19
10b7439d4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10b7439d8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10b7439dc: 17fbc6ef    	b	0x10b635598 <_mmkv_importFrom+0x7727f4>
