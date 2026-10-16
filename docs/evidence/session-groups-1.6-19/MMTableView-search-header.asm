
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
11672b110: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
11672b114: a9014ff4    	stp	x20, x19, [sp, #0x10]
11672b118: a9027bfd    	stp	x29, x30, [sp, #0x20]
11672b11c: 910083fd    	add	x29, sp, #0x20
11672b120: aa0003f4    	mov	x20, x0
11672b124: b004b908    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
11672b128: f9456d15    	ldr	x21, [x8, #0xad8]
11672b12c: aa1503e1    	mov	x1, x21
11672b130: 946ffaef    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672b134: aa1d03fd    	mov	x29, x29
11672b138: 946ffb17    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11672b13c: aa0003f3    	mov	x19, x0
11672b140: f004d2e8    	adrp	x8, 0x12018a000 <dyld_stub_binder+0x12018a000>
11672b144: f945e100    	ldr	x0, [x8, #0xbc0]
11672b148: 9004cea8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
11672b14c: f947ad01    	ldr	x1, [x8, #0xf58]
11672b150: 946ffae7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672b154: aa0003e2    	mov	x2, x0
11672b158: 9004cec8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
11672b15c: f9442d16    	ldr	x22, [x8, #0x858]
11672b160: aa1303e0    	mov	x0, x19
11672b164: aa1603e1    	mov	x1, x22
11672b168: 946ffae1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672b16c: 36000060    	tbz	w0, #0x0, 0x11672b178 <_O266DecReleaseOutputPicture+0x349e6c0>
11672b170: 52800034    	mov	w20, #0x1               ; =1
11672b174: 14000011    	b	0x11672b1b8 <_O266DecReleaseOutputPicture+0x349e700>
11672b178: aa1403e0    	mov	x0, x20
11672b17c: aa1503e1    	mov	x1, x21
11672b180: 946ffadb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672b184: aa1d03fd    	mov	x29, x29
11672b188: 946ffb03    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11672b18c: aa0003f5    	mov	x21, x0
11672b190: b00421e0    	adrp	x0, 0x11eb68000 <dyld_stub_binder+0x11eb68000>
11672b194: 9103a000    	add	x0, x0, #0xe8
11672b198: 946fdfc6    	bl	0x1183230b0 <dyld_stub_binder+0x1183230b0>
11672b19c: aa0003e2    	mov	x2, x0
11672b1a0: aa1503e0    	mov	x0, x21
11672b1a4: aa1603e1    	mov	x1, x22
11672b1a8: 946ffad1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672b1ac: aa0003f4    	mov	x20, x0
11672b1b0: aa1503e0    	mov	x0, x21
11672b1b4: 946ffae9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672b1b8: aa1303e0    	mov	x0, x19
11672b1bc: 946ffae7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672b1c0: aa1403e0    	mov	x0, x20
11672b1c4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
11672b1c8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
11672b1cc: a8c357f6    	ldp	x22, x21, [sp], #0x30
11672b1d0: d65f03c0    	ret
