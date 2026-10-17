
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1059fb524: 900d44a8    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1059fb528: 9115c108    	add	x8, x8, #0x570
1059fb52c: b9800108    	ldrsw	x8, [x8]
1059fb530: f8686808    	ldr	x8, [x0, x8]
1059fb534: b4000068    	cbz	x8, 0x1059fb540 <_Flutter_MMFoundation_BindContext+0x1ed7124>
1059fb538: b940c500    	ldr	w0, [x8, #0xc4]
1059fb53c: d65f03c0    	ret
1059fb540: 52800000    	mov	w0, #0x0                ; =0
1059fb544: d65f03c0    	ret
