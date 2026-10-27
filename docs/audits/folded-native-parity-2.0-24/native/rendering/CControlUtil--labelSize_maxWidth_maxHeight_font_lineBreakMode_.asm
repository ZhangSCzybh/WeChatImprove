
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167ec17c: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1167ec180: a90157f6    	stp	x22, x21, [sp, #0x10]
1167ec184: a9024ff4    	stp	x20, x19, [sp, #0x20]
1167ec188: a9037bfd    	stp	x29, x30, [sp, #0x30]
1167ec18c: 9100c3fd    	add	x29, sp, #0x30
1167ec190: aa0403f5    	mov	x21, x4
1167ec194: aa0303f4    	mov	x20, x3
1167ec198: 1e604029    	fmov	d9, d1
1167ec19c: 1e604008    	fmov	d8, d0
1167ec1a0: aa0203f3    	mov	x19, x2
1167ec1a4: aa0203e0    	mov	x0, x2
1167ec1a8: 946cf6f2    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167ec1ac: aa1403e0    	mov	x0, x20
1167ec1b0: 946cf6f0    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167ec1b4: f004c8a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1167ec1b8: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1167ec1bc: aa1303e0    	mov	x0, x19
1167ec1c0: 946cf6cb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec1c4: b4000180    	cbz	x0, 0x1167ec1f4 <_O266DecReleaseOutputPicture+0x355f73c>
1167ec1c8: 1e64c121    	frintp	d1, d9
1167ec1cc: f004b8e8    	adrp	x8, 0x11ff0b000 <dyld_stub_binder+0x11ff0b000>
1167ec1d0: f9461901    	ldr	x1, [x8, #0xc30] ; stringSizeWithFont:constrainedToSize:lineBreakMode:
1167ec1d4: aa1303e0    	mov	x0, x19
1167ec1d8: aa1403e2    	mov	x2, x20
1167ec1dc: 1e604100    	fmov	d0, d8
1167ec1e0: aa1503e3    	mov	x3, x21
1167ec1e4: 946cf6c2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec1e8: 1e604008    	fmov	d8, d0
1167ec1ec: 1e64c029    	frintp	d9, d1
1167ec1f0: 14000004    	b	0x1167ec200 <_O266DecReleaseOutputPicture+0x355f748>
1167ec1f4: b0037008    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
1167ec1f8: f9417908    	ldr	x8, [x8, #0x2f0]
1167ec1fc: 6d402508    	ldp	d8, d9, [x8]
1167ec200: aa1403e0    	mov	x0, x20
1167ec204: 946cf6d5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec208: aa1303e0    	mov	x0, x19
1167ec20c: 946cf6d3    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec210: 1e604100    	fmov	d0, d8
1167ec214: 1e604121    	fmov	d1, d9
1167ec218: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1167ec21c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1167ec220: a94157f6    	ldp	x22, x21, [sp, #0x10]
1167ec224: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1167ec228: d65f03c0    	ret
