
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aee0fc: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
104aee100: a9017bfd    	stp	x29, x30, [sp, #0x10]
104aee104: 910043fd    	add	x29, sp, #0x10
104aee108: aa0203f3    	mov	x19, x2
104aee10c: aa0003f4    	mov	x20, x0
104aee110: b00db428    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aee114: f9470100    	ldr	x0, [x8, #0xe00] ; �*c 
104aee118: b00db0a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104aee11c: f9438501    	ldr	x1, [x8, #0x708] ; isDarkMode
104aee120: 94c4e407    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aee124: aa0003e3    	mov	x3, x0
104aee128: f00da4a8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104aee12c: f947b501    	ldr	x1, [x8, #0xf68] ; getBubbleImage:isDarkMode:useCache:
104aee130: aa1403e0    	mov	x0, x20
104aee134: aa1303e2    	mov	x2, x19
104aee138: 52800004    	mov	w4, #0x0                ; =0
104aee13c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
104aee140: a8c24ff4    	ldp	x20, x19, [sp], #0x20
104aee144: 14c4e3fe    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>