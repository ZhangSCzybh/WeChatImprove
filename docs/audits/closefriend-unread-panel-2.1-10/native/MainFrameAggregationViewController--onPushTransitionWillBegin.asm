
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a74548: f00dbd68    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a7454c: b9810908    	ldrsw	x8, [x8, #0x108]
104a74550: 52800029    	mov	w9, #0x1                ; =1
104a74554: 38286809    	strb	w9, [x0, x8]
104a74558: d65f03c0    	ret
