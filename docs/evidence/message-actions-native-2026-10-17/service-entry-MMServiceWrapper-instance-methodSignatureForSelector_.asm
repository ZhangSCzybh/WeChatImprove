
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175fc03c: d10183ff    	sub	sp, sp, #0x60
1175fc040: a9025ff8    	stp	x24, x23, [sp, #0x20]
1175fc044: a90357f6    	stp	x22, x21, [sp, #0x30]
1175fc048: a9044ff4    	stp	x20, x19, [sp, #0x40]
1175fc04c: a9057bfd    	stp	x29, x30, [sp, #0x50]
1175fc050: 910143fd    	add	x29, sp, #0x50
1175fc054: aa0003f3    	mov	x19, x0
1175fc058: f90007e2    	str	x2, [sp, #0x8]
1175fc05c: d00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc060: b987a916    	ldrsw	x22, [x8, #0x7a8]
1175fc064: 8b160000    	add	x0, x0, x22
1175fc068: 9434b7a2    	bl	0x118329ef0 <dyld_stub_binder+0x118329ef0>
1175fc06c: d00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc070: b987ad17    	ldrsw	x23, [x8, #0x7ac]
1175fc074: 910023f8    	add	x24, sp, #0x8
1175fc078: 8b170260    	add	x0, x19, x23
1175fc07c: 910023e1    	add	x1, sp, #0x8
1175fc080: 97f9c94d    	bl	0x11746e5b4 <_O266DecReleaseOutputPicture+0x41e1afc>
1175fc084: b4000060    	cbz	x0, 0x1175fc090 <_O266DecReleaseOutputPicture+0x436f5d8>
1175fc088: f9400c14    	ldr	x20, [x0, #0x18]
1175fc08c: 14000014    	b	0x1175fc0dc <_O266DecReleaseOutputPicture+0x436f624>
1175fc090: d00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc094: b987a508    	ldrsw	x8, [x8, #0x7a4]
1175fc098: f8686a60    	ldr	x0, [x19, x8]
1175fc09c: f94007e2    	ldr	x2, [sp, #0x8]
1175fc0a0: 90045848    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1175fc0a4: f9442101    	ldr	x1, [x8, #0x840] ; methodSignatureForSelector:
1175fc0a8: 9434b711    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175fc0ac: aa0003f4    	mov	x20, x0
1175fc0b0: 9434b730    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175fc0b4: aa0003f5    	mov	x21, x0
1175fc0b8: f9000ff8    	str	x24, [sp, #0x18]
1175fc0bc: 90016382    	adrp	x2, 0x11a26c000 <dyld_stub_binder+0x11a26c000>
1175fc0c0: 91282842    	add	x2, x2, #0xa0a
1175fc0c4: 8b170260    	add	x0, x19, x23
1175fc0c8: 910023e1    	add	x1, sp, #0x8
1175fc0cc: 910063e3    	add	x3, sp, #0x18
1175fc0d0: 91005fe4    	add	x4, sp, #0x17
1175fc0d4: 97f9d21c    	bl	0x117470944 <_O266DecReleaseOutputPicture+0x41e3e8c>
1175fc0d8: f9000c15    	str	x21, [x0, #0x18]
1175fc0dc: 8b160260    	add	x0, x19, x22
1175fc0e0: 9434b78a    	bl	0x118329f08 <dyld_stub_binder+0x118329f08>
1175fc0e4: aa1403e0    	mov	x0, x20
1175fc0e8: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1175fc0ec: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1175fc0f0: a94357f6    	ldp	x22, x21, [sp, #0x30]
1175fc0f4: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1175fc0f8: 910183ff    	add	sp, sp, #0x60
1175fc0fc: d65f03c0    	ret