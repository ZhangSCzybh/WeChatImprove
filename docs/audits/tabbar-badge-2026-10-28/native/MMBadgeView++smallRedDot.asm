
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116714554: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
116714558: a9017bfd    	stp	x29, x30, [sp, #0x10]
11671455c: 910043fd    	add	x29, sp, #0x10
116714560: d004d328    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
116714564: f9408500    	ldr	x0, [x8, #0x108] ; class MMBadgeView
116714568: 9470558a    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
11671456c: aa0003f3    	mov	x19, x0
116714570: 9004bd88    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
116714574: f9479901    	ldr	x1, [x8, #0xf30] ; selector setAsSmallDot
116714578: 947055dd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671457c: aa1303e0    	mov	x0, x19
116714580: a9417bfd    	ldp	x29, x30, [sp, #0x10]
116714584: a8c24ff4    	ldp	x20, x19, [sp], #0x20
116714588: 14705594    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>
