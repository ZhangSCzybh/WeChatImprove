
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104adc684: aa0303e2    	mov	x2, x3
104adc688: f00dba28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104adc68c: b9869508    	ldrsw	x8, [x8, #0x694]
104adc690: f8686800    	ldr	x0, [x0, x8]
104adc694: b00da548    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104adc698: f9451101    	ldr	x1, [x8, #0xa20] ; getSectionItemCount:
104adc69c: 14c52aa8    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
