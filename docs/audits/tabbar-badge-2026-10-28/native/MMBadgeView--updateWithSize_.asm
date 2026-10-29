
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167152d4: 6dbc2beb    	stp	d11, d10, [sp, #-0x40]!
1167152d8: 6d0123e9    	stp	d9, d8, [sp, #0x10]
1167152dc: a9024ff4    	stp	x20, x19, [sp, #0x20]
1167152e0: a9037bfd    	stp	x29, x30, [sp, #0x30]
1167152e4: 9100c3fd    	add	x29, sp, #0x30
1167152e8: 1e604028    	fmov	d8, d1
1167152ec: 1e604009    	fmov	d9, d0
1167152f0: aa0003f3    	mov	x19, x0
1167152f4: d004cf48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1167152f8: f9467901    	ldr	x1, [x8, #0xcf0] ; selector center
1167152fc: 9470527c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715300: 1e60400a    	fmov	d10, d0
116715304: 1e60402b    	fmov	d11, d1
116715308: 9004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
11671530c: f9453d01    	ldr	x1, [x8, #0xa78] ; selector setSize:
116715310: aa1303e0    	mov	x0, x19
116715314: 1e604120    	fmov	d0, d9
116715318: 1e604101    	fmov	d1, d8
11671531c: 94705274    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715320: d004cf88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
116715324: f9425114    	ldr	x20, [x8, #0x4a0] ; selector setCenter:
116715328: aa1303e0    	mov	x0, x19
11671532c: aa1403e1    	mov	x1, x20
116715330: 1e604140    	fmov	d0, d10
116715334: 1e604161    	fmov	d1, d11
116715338: 9470526d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671533c: d004cfa8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116715340: f947a501    	ldr	x1, [x8, #0xf48] ; selector width
116715344: aa1303e0    	mov	x0, x19
116715348: 94705269    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671534c: 1e6c1009    	fmov	d9, #0.50000000
116715350: 1e690808    	fmul	d8, d0, d9
116715354: b004cf68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
116715358: f9449d01    	ldr	x1, [x8, #0x938] ; selector height
11671535c: aa1303e0    	mov	x0, x19
116715360: 94705263    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715364: 1e690809    	fmul	d9, d0, d9
116715368: f004c1e8    	adrp	x8, 0x11ff54000 <dyld_stub_binder+0x11ff54000>
11671536c: f940fd01    	ldr	x1, [x8, #0x1f8] ; selector badgeLabel
116715370: aa1303e0    	mov	x0, x19
116715374: 9470525e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715378: aa1d03fd    	mov	x29, x29
11671537c: 94705286    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116715380: aa0003f3    	mov	x19, x0
116715384: aa1403e1    	mov	x1, x20
116715388: 1e604100    	fmov	d0, d8
11671538c: 1e604121    	fmov	d1, d9
116715390: 94705257    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715394: aa1303e0    	mov	x0, x19
116715398: a9437bfd    	ldp	x29, x30, [sp, #0x30]
11671539c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1167153a0: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
1167153a4: 6cc42beb    	ldp	d11, d10, [sp], #0x40
1167153a8: 1470526c    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
