
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051829f4: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1051829f8: a9017bfd    	stp	x29, x30, [sp, #0x10]
1051829fc: 910043fd    	add	x29, sp, #0x10
105182a00: aa0003f3    	mov	x19, x0
105182a04: 94aa91cd    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105182a08: 94aa91ed    	bl	0x107c271bc <_Flutter_MMFoundation_BindContext+0x4102da0>
105182a0c: d00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105182a10: b9892508    	ldrsw	x8, [x8, #0x924] ; ivar NewSyncService.m_uiSelector offset=12 type=I
105182a14: b8686a74    	ldr	w20, [x19, x8]
105182a18: aa1303e0    	mov	x0, x19
105182a1c: 94aa91f6    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
105182a20: aa1303e0    	mov	x0, x19
105182a24: 94aa91cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105182a28: aa1403e0    	mov	x0, x20
105182a2c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105182a30: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105182a34: d65f03c0    	ret
