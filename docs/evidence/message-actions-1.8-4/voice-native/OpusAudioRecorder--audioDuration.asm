
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1052afe70: 900d7f08    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1052afe74: 9115c108    	add	x8, x8, #0x570
1052afe78: b9800108    	ldrsw	x8, [x8]
1052afe7c: f8686808    	ldr	x8, [x0, x8]
1052afe80: b4000068    	cbz	x8, 0x1052afe8c <_Flutter_MMFoundation_BindContext+0x178ba70>
1052afe84: b945e100    	ldr	w0, [x8, #0x5e0]
1052afe88: d65f03c0    	ret
1052afe8c: 52800000    	mov	w0, #0x0                ; =0
1052afe90: d65f03c0    	ret
