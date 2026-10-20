
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100139a10: d100c3ff    	sub	sp, sp, #0x30
100139a14: a9027bfd    	stp	x29, x30, [sp, #0x20]
100139a18: 910083fd    	add	x29, sp, #0x20
100139a1c: 900fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100139a20: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector=voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:
100139a24: a9007fff    	stp	xzr, xzr, [sp]
100139a28: f9000bff    	str	xzr, [sp, #0x10]
100139a2c: 52800047    	mov	w7, #0x2                ; =2
100139a30: 95ebb5c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139a34: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100139a38: 9100c3ff    	add	sp, sp, #0x30
100139a3c: d65f03c0    	ret
