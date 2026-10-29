
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a72050: d100c3ff    	sub	sp, sp, #0x30
104a72054: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a72058: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a7205c: 910083fd    	add	x29, sp, #0x20
104a72060: f00dba88    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a72064: f9429d08    	ldr	x8, [x8, #0x538]
104a72068: a90023e0    	stp	x0, x8, [sp]
104a7206c: 900db488    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a72070: f9466901    	ldr	x1, [x8, #0xcd0] ; selector init
104a72074: 910003e0    	mov	x0, sp
104a72078: 94c6d433    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a7207c: aa0003f3    	mov	x19, x0
104a72080: b40001e0    	cbz	x0, 0x104a720bc <_Flutter_MMFoundation_BindContext+0xf4dca0>
104a72084: 900db908    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104a72088: f944c100    	ldr	x0, [x8, #0x980] ; class MainFrameAggregationLogic
104a7208c: 94c6d433    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104a72090: b00dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a72094: b980d914    	ldrsw	x20, [x8, #0xd8]
104a72098: f8746a68    	ldr	x8, [x19, x20]
104a7209c: f8346a60    	str	x0, [x19, x20]
104a720a0: aa0803e0    	mov	x0, x8
104a720a4: 94c6d42c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a720a8: f8746a60    	ldr	x0, [x19, x20]
104a720ac: b00db4a8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104a720b0: f9451501    	ldr	x1, [x8, #0xa28] ; selector setDelegate:
104a720b4: aa1303e2    	mov	x2, x19
104a720b8: 94c6d421    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a720bc: aa1303e0    	mov	x0, x19
104a720c0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a720c4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a720c8: 9100c3ff    	add	sp, sp, #0x30
104a720cc: d65f03c0    	ret
