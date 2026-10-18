
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109afa86c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
109afa870: a9015ff8    	stp	x24, x23, [sp, #0x10]
109afa874: a90257f6    	stp	x22, x21, [sp, #0x20]
109afa878: a9034ff4    	stp	x20, x19, [sp, #0x30]
109afa87c: a9047bfd    	stp	x29, x30, [sp, #0x40]
109afa880: 910103fd    	add	x29, sp, #0x40
109afa884: aa0203f3    	mov	x19, x2
109afa888: aa0003f4    	mov	x20, x0
109afa88c: aa0203e0    	mov	x0, x2
109afa890: 957582ec    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109afa894: aa1303e0    	mov	x0, x19
109afa898: 957582ea    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109afa89c: b00b3ba8    	adrp	x8, 0x12026f000 <dyld_stub_binder+0x12026f000>
109afa8a0: b9827d19    	ldrsw	x25, [x8, #0x27c]
109afa8a4: 8b190280    	add	x0, x20, x25
109afa8a8: 957582fb    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
109afa8ac: b4000320    	cbz	x0, 0x109afa910 <_Flutter_MMFoundation_BindContext+0x5fd64f4>
109afa8b0: aa0003f6    	mov	x22, x0
109afa8b4: 8b190280    	add	x0, x20, x25
109afa8b8: 957582f7    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
109afa8bc: aa0003f7    	mov	x23, x0
109afa8c0: 900b2c88    	adrp	x8, 0x12008a000 <dyld_stub_binder+0x12008a000>
109afa8c4: f9451d15    	ldr	x21, [x8, #0xa38] ; onWCPayUnionTransferConfirmCgiResponseOK:
109afa8c8: 900b3068    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
109afa8cc: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
109afa8d0: aa1503e2    	mov	x2, x21
109afa8d4: 957582dc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109afa8d8: aa0003f8    	mov	x24, x0
109afa8dc: aa1703e0    	mov	x0, x23
109afa8e0: 957582df    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109afa8e4: aa1603e0    	mov	x0, x22
109afa8e8: 957582dd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109afa8ec: 34000138    	cbz	w24, 0x109afa910 <_Flutter_MMFoundation_BindContext+0x5fd64f4>
109afa8f0: 8b190280    	add	x0, x20, x25
109afa8f4: 957582e8    	bl	0x10f85b494 <_UR_96F1_B25D+0x3a64104>
109afa8f8: aa0003f4    	mov	x20, x0
109afa8fc: aa1503e1    	mov	x1, x21
109afa900: aa1303e2    	mov	x2, x19
109afa904: 957582d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109afa908: aa1403e0    	mov	x0, x20
109afa90c: 957582d4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109afa910: aa1303e0    	mov	x0, x19
109afa914: 957582d2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109afa918: aa1303e0    	mov	x0, x19
109afa91c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109afa920: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109afa924: a94257f6    	ldp	x22, x21, [sp, #0x20]
109afa928: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109afa92c: a8c567fa    	ldp	x26, x25, [sp], #0x50
109afa930: 157582cb    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>