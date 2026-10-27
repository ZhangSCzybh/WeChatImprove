
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a7657c: d10083ff    	sub	sp, sp, #0x20
104a76580: a9017bfd    	stp	x29, x30, [sp, #0x10]
104a76584: 910043fd    	add	x29, sp, #0x10
104a76588: f00dba68    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a7658c: f942a108    	ldr	x8, [x8, #0x540] ; MainFrameCellData
104a76590: a90023e0    	stp	x0, x8, [sp]
104a76594: 900db468    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a76598: f9466901    	ldr	x1, [x8, #0xcd0] ; init
104a7659c: 910003e0    	mov	x0, sp
104a765a0: 94c6c2e9    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a765a4: b40000c0    	cbz	x0, 0x104a765bc <_Flutter_MMFoundation_BindContext+0xf521a0>
104a765a8: 3900cc1f    	strb	wzr, [x0, #0x33]
104a765ac: 7803501f    	sturh	wzr, [x0, #0x35]
104a765b0: 7801101f    	sturh	wzr, [x0, #0x11]
104a765b4: 92800008    	mov	x8, #-0x1               ; =-1
104a765b8: f9000c08    	str	x8, [x0, #0x18]
104a765bc: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104a765c0: 910083ff    	add	sp, sp, #0x20
104a765c4: d65f03c0    	ret
