
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175791a4: d004e929    	adrp	x9, 0x12129f000 <dyld_stub_binder+0x12129f000>
1175791a8: f940a529    	ldr	x9, [x9, #0x148]
1175791ac: b4000049    	cbz	x9, 0x1175791b4 <_O266DecReleaseOutputPicture+0x42ec6fc>
1175791b0: d61f0120    	br	x9
1175791b4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1175791b8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1175791bc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1175791c0: 910083fd    	add	x29, sp, #0x20
1175791c4: aa0103f4    	mov	x20, x1
1175791c8: aa0003f3    	mov	x19, x0
1175791cc: 900533f6    	adrp	x22, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
1175791d0: f94262c8    	ldr	x8, [x22, #0x4c0]
1175791d4: b50000c8    	cbnz	x8, 0x1175791ec <_O266DecReleaseOutputPicture+0x42ec734>
1175791d8: 9002a0e1    	adrp	x1, 0x11c995000 <dyld_stub_binder+0x11c995000>
1175791dc: 9132d021    	add	x1, x1, #0xcb4 ; string 'dispatch_async'
1175791e0: 92800000    	mov	x0, #-0x1               ; =-1
1175791e4: 9436bc4a    	bl	0x11832830c <dyld_stub_binder+0x11832830c>
1175791e8: f90262c0    	str	x0, [x22, #0x4c0]
1175791ec: aa1303e0    	mov	x0, x19
1175791f0: 9400f929    	bl	0x1175b7694 <_O266DecReleaseOutputPicture+0x432abdc>
1175791f4: aa0003f5    	mov	x21, x0
1175791f8: aa1403e0    	mov	x0, x20
1175791fc: 94000017    	bl	0x117579258 <_O266DecReleaseOutputPicture+0x42ec7a0>
117579200: aa0003f4    	mov	x20, x0
117579204: 34000195    	cbz	w21, 0x117579234 <_O266DecReleaseOutputPicture+0x42ec77c>
117579208: 900460a8    	adrp	x8, 0x12018d000 <dyld_stub_binder+0x12018d000>
11757920c: f944bd00    	ldr	x0, [x8, #0x978] ; class MMGlobalQueue
117579210: b0045c88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
117579214: f9437d01    	ldr	x1, [x8, #0x6f8] ; selector/string sharedInstance
117579218: 9436c2b5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11757921c: 90045c08    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
117579220: f9421101    	ldr	x1, [x8, #0x420] ; selector/string addOperationFromGlobalDispatchQueue:block:
117579224: aa1303e2    	mov	x2, x19
117579228: aa1403e3    	mov	x3, x20
11757922c: 9436c2b0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
117579230: 14000005    	b	0x117579244 <_O266DecReleaseOutputPicture+0x42ec78c>
117579234: f94262c8    	ldr	x8, [x22, #0x4c0]
117579238: aa1303e0    	mov	x0, x19
11757923c: aa1403e1    	mov	x1, x20
117579240: d63f0100    	blr	x8
117579244: aa1403e0    	mov	x0, x20
117579248: a9427bfd    	ldp	x29, x30, [sp, #0x20]
11757924c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
117579250: a8c357f6    	ldp	x22, x21, [sp], #0x30
117579254: 1436c2c1    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
