
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105fe30b8: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
105fe30bc: a9015ff8    	stp	x24, x23, [sp, #0x10]
105fe30c0: a90257f6    	stp	x22, x21, [sp, #0x20]
105fe30c4: a9034ff4    	stp	x20, x19, [sp, #0x30]
105fe30c8: a9047bfd    	stp	x29, x30, [sp, #0x40]
105fe30cc: 910103fd    	add	x29, sp, #0x40
105fe30d0: aa0403f3    	mov	x19, x4
105fe30d4: aa0303f4    	mov	x20, x3
105fe30d8: aa0203f5    	mov	x21, x2
105fe30dc: aa0003f6    	mov	x22, x0
105fe30e0: f00d1288    	adrp	x8, 0x120236000 <dyld_stub_binder+0x120236000>
105fe30e4: b9890119    	ldrsw	x25, [x8, #0x900]
105fe30e8: f8796817    	ldr	x23, [x0, x25]
105fe30ec: b00cfde8    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
105fe30f0: f9474918    	ldr	x24, [x8, #0xe90] ; selector=SetRoomId:
105fe30f4: aa0203e0    	mov	x0, x2
105fe30f8: 94711010    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105fe30fc: aa1703e0    	mov	x0, x23
105fe3100: aa1803e1    	mov	x1, x24
105fe3104: aa1403e2    	mov	x2, x20
105fe3108: 9471100d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105fe310c: f8796ac0    	ldr	x0, [x22, x25]
105fe3110: b00cfde8    	adrp	x8, 0x11ffa0000 <dyld_stub_binder+0x11ffa0000>
105fe3114: f9474d01    	ldr	x1, [x8, #0xe98] ; selector=SetRoomKey:
105fe3118: aa1303e2    	mov	x2, x19
105fe311c: 94711008    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105fe3120: f00cff28    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105fe3124: f9462501    	ldr	x1, [x8, #0xc48] ; selector=SendAnswerRequestBy:AnswerType:forceToVoice:
105fe3128: aa1603e0    	mov	x0, x22
105fe312c: aa1503e2    	mov	x2, x21
105fe3130: 52800043    	mov	w3, #0x2                ; =2
105fe3134: 52800004    	mov	w4, #0x0                ; =0
105fe3138: 94711001    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105fe313c: aa1503e0    	mov	x0, x21
105fe3140: a9447bfd    	ldp	x29, x30, [sp, #0x40]
105fe3144: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105fe3148: a94257f6    	ldp	x22, x21, [sp, #0x20]
105fe314c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
105fe3150: a8c567fa    	ldp	x26, x25, [sp], #0x50
105fe3154: 14711000    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
