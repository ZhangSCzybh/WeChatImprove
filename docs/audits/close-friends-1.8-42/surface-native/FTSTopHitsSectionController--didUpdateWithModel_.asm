
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1017fa964: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1017fa968: a9017bfd    	stp	x29, x30, [sp, #0x10]
1017fa96c: 910043fd    	add	x29, sp, #0x10
1017fa970: aa0003f3    	mov	x19, x0
1017fa974: d00f4828    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1017fa978: f9459501    	ldr	x1, [x8, #0xb28] ; data
1017fa97c: aa0203e0    	mov	x0, x2
1017fa980: 9590b1ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017fa984: aa1d03fd    	mov	x29, x29
1017fa988: 9590b1f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017fa98c: f00f4fa8    	adrp	x8, 0x1201f1000 <dyld_stub_binder+0x1201f1000>
1017fa990: b9877109    	ldrsw	x9, [x8, #0x770] ; ivar FTSTopHitsSectionController._topHitItems
1017fa994: f8696a68    	ldr	x8, [x19, x9]
1017fa998: f8296a60    	str	x0, [x19, x9]
1017fa99c: aa0803e0    	mov	x0, x8
1017fa9a0: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1017fa9a4: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1017fa9a8: 1590b1eb    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
