
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e4c3e8: aa0203e0    	mov	x0, x2
100e4c3ec: f00f95a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100e4c3f0: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
100e4c3f4: 900eb322    	adrp	x2, 0x11e4b0000 <dyld_stub_binder+0x11e4b0000>
100e4c3f8: 913aa042    	add	x2, x2, #0xea8 ; CFString 'chatroom_session_box'
100e4c3fc: 15b76b50    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
