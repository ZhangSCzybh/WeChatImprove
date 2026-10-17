
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b384f4: b00d99e8    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
104b384f8: f9427501    	ldr	x1, [x8, #0x4e8] ; AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:
104b384fc: 52800024    	mov	w4, #0x1                ; =1
104b38500: 52800005    	mov	w5, #0x0                ; =0
104b38504: 52800006    	mov	w6, #0x0                ; =0
104b38508: 14c3bb0d    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>