
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f8d638: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
100f8d63c: a9017bfd    	stp	x29, x30, [sp, #0x10]
100f8d640: 910043fd    	add	x29, sp, #0x10
100f8d644: aa0003f3    	mov	x19, x0
100f8d648: 900f75c8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
100f8d64c: f945b901    	ldr	x1, [x8, #0xb70] ; selector isWeixinCustomerHelperContact
100f8d650: 95b266bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f8d654: 34000120    	cbz	w0, 0x100f8d678 <__text+0xf85678>
100f8d658: 900f8f48    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100f8d65c: f940d500    	ldr	x0, [x8, #0x1a8] ; class PluginUtil
100f8d660: f00f7648    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
100f8d664: f9439101    	ldr	x1, [x8, #0x720] ; selector isWeCustomerHelperBrandMode
100f8d668: 95b266b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f8d66c: 36000060    	tbz	w0, #0x0, 0x100f8d678 <__text+0xf85678>
100f8d670: 52800020    	mov	w0, #0x1                ; =1
100f8d674: 14000005    	b	0x100f8d688 <__text+0xf85688>
100f8d678: 900f92e8    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f8d67c: b9878108    	ldrsw	x8, [x8, #0x780]
100f8d680: 38686a68    	ldrb	w8, [x19, x8]
100f8d684: 53030d00    	ubfx	w0, w8, #3, #1
100f8d688: a9417bfd    	ldp	x29, x30, [sp, #0x10]
100f8d68c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
100f8d690: d65f03c0    	ret
