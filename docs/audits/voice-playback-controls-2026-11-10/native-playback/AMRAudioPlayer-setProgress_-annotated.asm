
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10001bbd0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10001bbd4: a9014ff4    	stp	x20, x19, [sp, #0x10]
10001bbd8: a9027bfd    	stp	x29, x30, [sp, #0x20]
10001bbdc: 910083fd    	add	x29, sp, #0x20
10001bbe0: aa0203f4    	mov	x20, x2
10001bbe4: aa0003f3    	mov	x19, x0
10001bbe8: 900fb928    	adrp	x8, 0x11f73f000 <dyld_stub_binder+0x11f73f000>
10001bbec: 52800036    	mov	w22, #0x1               ; =1
10001bbf0: 393d2916    	strb	w22, [x8, #0xf4a]
10001bbf4: f00f6b08    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
10001bbf8: 912ab108    	add	x8, x8, #0xaac
10001bbfc: b9800115    	ldrsw	x21, [x8] ; ivar: BaseAudioPlayer.mAqData offset=8
10001bc00: f8756808    	ldr	x8, [x0, x21]
10001bc04: f9401d00    	ldr	x0, [x8, #0x38]
10001bc08: 95f029cd    	bl	0x107c2633c <_Flutter_MMFoundation_BindContext+0x3ead008>
10001bc0c: f8756a68    	ldr	x8, [x19, x21]
10001bc10: 3941b509    	ldrb	w9, [x8, #0x6d]
10001bc14: 7100053f    	cmp	w9, #0x1
10001bc18: 540002c1    	b.ne	0x10001bc70 <__text+0x13c70>
10001bc1c: 5289ba69    	mov	w9, #0x4dd3             ; =19923
10001bc20: 72a20c49    	movk	w9, #0x1062, lsl #16
10001bc24: 9ba97e89    	umull	x9, w20, w9
10001bc28: d366fd29    	lsr	x9, x9, #38
10001bc2c: b9000909    	str	w9, [x8, #0x8]
10001bc30: 529d4c0a    	mov	w10, #0xea60            ; =60000
10001bc34: 1b0a7d29    	mul	w9, w9, w10
10001bc38: 529999aa    	mov	w10, #0xcccd            ; =52429
10001bc3c: 72b9998a    	movk	w10, #0xcccc, lsl #16
10001bc40: 9baa7d29    	umull	x9, w9, w10
10001bc44: d364fd29    	lsr	x9, x9, #36
10001bc48: f9003109    	str	x9, [x8, #0x60]
10001bc4c: 7806d116    	sturh	w22, [x8, #0x6d]
10001bc50: 52800814    	mov	w20, #0x40              ; =64
10001bc54: f8756a60    	ldr	x0, [x19, x21]
10001bc58: f9401c01    	ldr	x1, [x0, #0x38]
10001bc5c: f8746802    	ldr	x2, [x0, x20]
10001bc60: 97fffd4e    	bl	0x10001b198 <__text+0x13198>
10001bc64: 91002294    	add	x20, x20, #0x8
10001bc68: f101629f    	cmp	x20, #0x58
10001bc6c: 54ffff41    	b.ne	0x10001bc54 <__text+0x13c54>
10001bc70: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10001bc74: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10001bc78: a8c357f6    	ldp	x22, x21, [sp], #0x30
10001bc7c: d65f03c0    	ret
