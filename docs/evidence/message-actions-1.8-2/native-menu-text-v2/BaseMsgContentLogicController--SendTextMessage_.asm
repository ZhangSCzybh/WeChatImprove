
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002c38e4: 900fdc48    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1002c38e8: f9420501    	ldr	x1, [x8, #0x408] ; SendTextMessage:replyingMessage:isPasted:
1002c38ec: d2800003    	mov	x3, #0x0                ; =0
1002c38f0: 52800004    	mov	w4, #0x0                ; =0
1002c38f4: 15e58e12    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>