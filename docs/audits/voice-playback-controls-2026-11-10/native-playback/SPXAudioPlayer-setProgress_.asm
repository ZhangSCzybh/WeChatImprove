
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1059774bc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1059774c0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1059774c4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1059774c8: 910083fd    	add	x29, sp, #0x20
1059774cc: aa0203f4    	mov	x20, x2
1059774d0: aa0003f3    	mov	x19, x0
1059774d4: b00ceee8    	adrp	x8, 0x11f754000 <dyld_stub_binder+0x11f754000>
1059774d8: 52800036    	mov	w22, #0x1               ; =1
1059774dc: 391c8116    	strb	w22, [x8, #0x720]
1059774e0: f00ca028    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1059774e4: 912ab108    	add	x8, x8, #0xaac
1059774e8: b9800115    	ldrsw	x21, [x8]
1059774ec: f8756808    	ldr	x8, [x0, x21]
1059774f0: f9401d00    	ldr	x0, [x8, #0x38]
1059774f4: 948abb92    	bl	0x107c2633c <_Flutter_MMFoundation_BindContext+0x3ead008>
1059774f8: f8756a68    	ldr	x8, [x19, x21]
1059774fc: 3941b509    	ldrb	w9, [x8, #0x6d]
105977500: 7100053f    	cmp	w9, #0x1
105977504: 540002c1    	b.ne	0x10597755c <_Flutter_MMFoundation_BindContext+0x1bfe228>
105977508: 5289ba69    	mov	w9, #0x4dd3             ; =19923
10597750c: 72a20c49    	movk	w9, #0x1062, lsl #16
105977510: 9ba97e89    	umull	x9, w20, w9
105977514: d366fd29    	lsr	x9, x9, #38
105977518: b9000909    	str	w9, [x8, #0x8]
10597751c: 529d4c0a    	mov	w10, #0xea60            ; =60000
105977520: 1b0a7d29    	mul	w9, w9, w10
105977524: 529999aa    	mov	w10, #0xcccd            ; =52429
105977528: 72b9998a    	movk	w10, #0xcccc, lsl #16
10597752c: 9baa7d29    	umull	x9, w9, w10
105977530: d364fd29    	lsr	x9, x9, #36
105977534: f9003109    	str	x9, [x8, #0x60]
105977538: 7806d116    	sturh	w22, [x8, #0x6d]
10597753c: 52800814    	mov	w20, #0x40              ; =64
105977540: f8756a60    	ldr	x0, [x19, x21]
105977544: f9401c01    	ldr	x1, [x0, #0x38]
105977548: f8746802    	ldr	x2, [x0, x20]
10597754c: 97fffe26    	bl	0x105976de4 <_Flutter_MMFoundation_BindContext+0x1bfdab0>
105977550: 91002294    	add	x20, x20, #0x8
105977554: f101629f    	cmp	x20, #0x58
105977558: 54ffff41    	b.ne	0x105977540 <_Flutter_MMFoundation_BindContext+0x1bfe20c>
10597755c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105977560: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105977564: a8c357f6    	ldp	x22, x21, [sp], #0x30
105977568: d65f03c0    	ret
