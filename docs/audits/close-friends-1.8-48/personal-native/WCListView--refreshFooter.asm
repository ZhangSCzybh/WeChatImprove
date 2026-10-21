
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10900e324: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10900e328: a9017bfd    	stp	x29, x30, [sp, #0x10]
10900e32c: 910043fd    	add	x29, sp, #0x10
10900e330: d00b92a8    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10900e334: b9857908    	ldrsw	x8, [x8, #0x578]
10900e338: 8b080000    	add	x0, x0, x8
10900e33c: 95a13456    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
10900e340: aa0003f3    	mov	x19, x0
10900e344: b00b82c8    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
10900e348: f9429d01    	ldr	x1, [x8, #0x538] ; refreshFooter
10900e34c: 95a1343e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10900e350: aa1303e0    	mov	x0, x19
10900e354: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10900e358: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10900e35c: 15a13440    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
