
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
11671553c: d10183ff    	sub	sp, sp, #0x60
116715540: 6d0133ed    	stp	d13, d12, [sp, #0x10]
116715544: 6d022beb    	stp	d11, d10, [sp, #0x20]
116715548: 6d0323e9    	stp	d9, d8, [sp, #0x30]
11671554c: a9044ff4    	stp	x20, x19, [sp, #0x40]
116715550: a9057bfd    	stp	x29, x30, [sp, #0x50]
116715554: 910143fd    	add	x29, sp, #0x50
116715558: 1e604068    	fmov	d8, d3
11671555c: 1e604049    	fmov	d9, d2
116715560: 1e60402a    	fmov	d10, d1
116715564: 1e60400b    	fmov	d11, d0
116715568: aa0003f3    	mov	x19, x0
11671556c: f004d2e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
116715570: f9406100    	ldr	x0, [x8, #0xc0] ; class UIScreen
116715574: f004cf68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
116715578: f9413101    	ldr	x1, [x8, #0x260] ; selector mainScreen
11671557c: 947051dc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715580: aa1d03fd    	mov	x29, x29
116715584: 94705204    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116715588: aa0003f4    	mov	x20, x0
11671558c: b004cf88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
116715590: f944d901    	ldr	x1, [x8, #0x9b0] ; selector scale
116715594: 947051d6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715598: 1e60400c    	fmov	d12, d0
11671559c: aa1403e0    	mov	x0, x20
1167155a0: 947051ee    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167155a4: 1e6c0960    	fmul	d0, d11, d12
1167155a8: 1e67c000    	frinti	d0, d0
1167155ac: 1e6c180b    	fdiv	d11, d0, d12
1167155b0: 1e6c0940    	fmul	d0, d10, d12
1167155b4: 1e67c000    	frinti	d0, d0
1167155b8: b004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167155bc: f942f914    	ldr	x20, [x8, #0x5f0] ; selector pixelAlignedCeil:
1167155c0: 1e6c180a    	fdiv	d10, d0, d12
1167155c4: aa1303e0    	mov	x0, x19
1167155c8: aa1403e1    	mov	x1, x20
1167155cc: 1e604120    	fmov	d0, d9
1167155d0: 947051c7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167155d4: 1e604009    	fmov	d9, d0
1167155d8: aa1303e0    	mov	x0, x19
1167155dc: aa1403e1    	mov	x1, x20
1167155e0: 1e604100    	fmov	d0, d8
1167155e4: 947051c2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167155e8: 1e604003    	fmov	d3, d0
1167155ec: b004d628    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1167155f0: f9459908    	ldr	x8, [x8, #0xb30]
1167155f4: a90023f3    	stp	x19, x8, [sp]
1167155f8: f004cf88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1167155fc: f9403501    	ldr	x1, [x8, #0x68] ; selector setFrame:
116715600: 910003e0    	mov	x0, sp
116715604: 1e604160    	fmov	d0, d11
116715608: 1e604141    	fmov	d1, d10
11671560c: 1e604122    	fmov	d2, d9
116715610: 947051ba    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116715614: a9457bfd    	ldp	x29, x30, [sp, #0x50]
116715618: a9444ff4    	ldp	x20, x19, [sp, #0x40]
11671561c: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
116715620: 6d422beb    	ldp	d11, d10, [sp, #0x20]
116715624: 6d4133ed    	ldp	d13, d12, [sp, #0x10]
116715628: 910183ff    	add	sp, sp, #0x60
11671562c: d65f03c0    	ret
