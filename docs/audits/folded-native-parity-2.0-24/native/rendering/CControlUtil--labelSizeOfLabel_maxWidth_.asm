
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167ec0c4: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
1167ec0c8: a90157f6    	stp	x22, x21, [sp, #0x10]
1167ec0cc: a9024ff4    	stp	x20, x19, [sp, #0x20]
1167ec0d0: a9037bfd    	stp	x29, x30, [sp, #0x30]
1167ec0d4: 9100c3fd    	add	x29, sp, #0x30
1167ec0d8: 1e604008    	fmov	d8, d0
1167ec0dc: aa0203f3    	mov	x19, x2
1167ec0e0: f004c8e8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1167ec0e4: f9401514    	ldr	x20, [x8, #0x28] ; text
1167ec0e8: aa0203e0    	mov	x0, x2
1167ec0ec: 946cf721    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167ec0f0: aa1303e0    	mov	x0, x19
1167ec0f4: aa1403e1    	mov	x1, x20
1167ec0f8: 946cf6fd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec0fc: aa1d03fd    	mov	x29, x29
1167ec100: 946cf725    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167ec104: aa0003f4    	mov	x20, x0
1167ec108: b004c8a8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1167ec10c: f9456d01    	ldr	x1, [x8, #0xad8] ; font
1167ec110: aa1303e0    	mov	x0, x19
1167ec114: 946cf6f6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec118: aa1d03fd    	mov	x29, x29
1167ec11c: 946cf71e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167ec120: aa0003f5    	mov	x21, x0
1167ec124: aa1303e0    	mov	x0, x19
1167ec128: 946cf70c    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec12c: 9004b388    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
1167ec130: f9461501    	ldr	x1, [x8, #0xc28] ; stringSizeWithFont:forWidth:lineBreakMode:
1167ec134: aa1403e0    	mov	x0, x20
1167ec138: aa1503e2    	mov	x2, x21
1167ec13c: 1e604100    	fmov	d0, d8
1167ec140: 52800083    	mov	w3, #0x4                ; =4
1167ec144: 946cf6ea    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167ec148: 1e604008    	fmov	d8, d0
1167ec14c: 1e604029    	fmov	d9, d1
1167ec150: aa1503e0    	mov	x0, x21
1167ec154: 946cf701    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec158: aa1403e0    	mov	x0, x20
1167ec15c: 946cf6ff    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167ec160: 1e604100    	fmov	d0, d8
1167ec164: 1e604121    	fmov	d1, d9
1167ec168: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1167ec16c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1167ec170: a94157f6    	ldp	x22, x21, [sp, #0x10]
1167ec174: 6cc423e9    	ldp	d9, d8, [sp], #0x40
1167ec178: d65f03c0    	ret
