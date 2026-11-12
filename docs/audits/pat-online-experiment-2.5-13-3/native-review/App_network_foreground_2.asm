
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1130e6870: 90065189    	adrp	x9, 0x11fb16000 <dyld_stub_binder+0x11fb16000>
1130e6874: f9452529    	ldr	x9, [x9, #0xa48] ; 0x11fb16a48 __bss
1130e6878: b4000049    	cbz	x9, 0x1130e6880 <_O266DecReleaseOutputPicture+0xfd7314>
1130e687c: d61f0120    	br	x9
1130e6880: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1130e6884: a9017bfd    	stp	x29, x30, [sp, #0x10]
1130e6888: 910043fd    	add	x29, sp, #0x10
1130e688c: aa0103f3    	mov	x19, x1
1130e6890: aa0003f4    	mov	x20, x0
1130e6894: 940000f5    	bl	0x1130e6c68 <_O266DecReleaseOutputPicture+0xfd76fc>
1130e6898: f9400400    	ldr	x0, [x0, #0x8]
1130e689c: aa1403e1    	mov	x1, x20
1130e68a0: aa1303e2    	mov	x2, x19
1130e68a4: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1130e68a8: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1130e68ac: 16153b3b    	b	0x10b635598 <_mmkv_importFrom+0x7727f4>
