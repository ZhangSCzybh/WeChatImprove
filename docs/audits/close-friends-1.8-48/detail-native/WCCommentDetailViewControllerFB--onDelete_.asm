
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ea8108: b00c9ce8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106ea810c: b9846d08    	ldrsw	x8, [x8, #0x46c]
106ea8110: f8686802    	ldr	x2, [x0, x8]
106ea8114: d00c8aa8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106ea8118: f9472501    	ldr	x1, [x8, #0xe48] ; onClickContent:way:
106ea811c: 52800023    	mov	w3, #0x1                ; =1
106ea8120: 1435fc07    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
