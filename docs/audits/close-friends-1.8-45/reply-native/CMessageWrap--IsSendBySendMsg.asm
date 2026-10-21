
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ba4b64: 900db408    	adrp	x8, 0x120224000 <dyld_stub_binder+0x120224000>
104ba4b68: b982a108    	ldrsw	x8, [x8, #0x2a0]
104ba4b6c: b8686808    	ldr	w8, [x0, x8]
104ba4b70: 51002d09    	sub	w9, w8, #0xb
104ba4b74: 7100e13f    	cmp	w9, #0x38
104ba4b78: 5280002a    	mov	w10, #0x1               ; =1
104ba4b7c: 9ac92149    	lsl	x9, x10, x9
104ba4b80: b26187ea    	mov	x10, #-0x7fffffff       ; =-2147483647
104ba4b84: f2c0040a    	movk	x10, #0x20, lsl #32
104ba4b88: f2e0300a    	movk	x10, #0x180, lsl #48
104ba4b8c: 8a0a0129    	and	x9, x9, x10
104ba4b90: fa409924    	ccmp	x9, #0x0, #0x4, ls
104ba4b94: 7a410904    	ccmp	w8, #0x1, #0x4, eq
104ba4b98: 54000061    	b.ne	0x104ba4ba4 <_Flutter_MMFoundation_BindContext+0x1080788>
104ba4b9c: 52800020    	mov	w0, #0x1                ; =1
104ba4ba0: d65f03c0    	ret
104ba4ba4: 52800000    	mov	w0, #0x0                ; =0
104ba4ba8: d65f03c0    	ret
