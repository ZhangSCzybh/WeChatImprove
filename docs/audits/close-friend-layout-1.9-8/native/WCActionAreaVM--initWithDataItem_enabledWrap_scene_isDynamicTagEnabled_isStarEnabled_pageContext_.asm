
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1067f8cdc: d10183ff    	sub	sp, sp, #0x60
1067f8ce0: a90167fa    	stp	x26, x25, [sp, #0x10]
1067f8ce4: a9025ff8    	stp	x24, x23, [sp, #0x20]
1067f8ce8: a90357f6    	stp	x22, x21, [sp, #0x30]
1067f8cec: a9044ff4    	stp	x20, x19, [sp, #0x40]
1067f8cf0: a9057bfd    	stp	x29, x30, [sp, #0x50]
1067f8cf4: 910143fd    	add	x29, sp, #0x50
1067f8cf8: aa0703f3    	mov	x19, x7
1067f8cfc: aa0603f5    	mov	x21, x6
1067f8d00: aa0503f6    	mov	x22, x5
1067f8d04: aa0403f7    	mov	x23, x4
1067f8d08: aa0303f8    	mov	x24, x3
1067f8d0c: aa0203f4    	mov	x20, x2
1067f8d10: aa0003f9    	mov	x25, x0
1067f8d14: 900d2268    	adrp	x8, 0x120c44000 <dyld_stub_binder+0x120c44000>
1067f8d18: 52800029    	mov	w9, #0x1                ; =1
1067f8d1c: 3934d509    	strb	w9, [x8, #0xd35]
1067f8d20: aa0203e0    	mov	x0, x2
1067f8d24: 9450b905    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1067f8d28: aa1303e0    	mov	x0, x19
1067f8d2c: 9450b903    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1067f8d30: b00cce88    	adrp	x8, 0x1201c9000 <dyld_stub_binder+0x1201c9000>
1067f8d34: f947cd08    	ldr	x8, [x8, #0xf98]
1067f8d38: a90023f9    	stp	x25, x8, [sp]
1067f8d3c: d00cc848    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1067f8d40: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1067f8d44: 910003e0    	mov	x0, sp
1067f8d48: 9450b8ff    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1067f8d4c: aa0003f9    	mov	x25, x0
1067f8d50: b40001e0    	cbz	x0, 0x1067f8d8c <_Flutter_MMFoundation_BindContext+0x2cd4970>
1067f8d54: 91004320    	add	x0, x25, #0x10
1067f8d58: aa1403e1    	mov	x1, x20
1067f8d5c: 9450b8f9    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1067f8d60: 39002338    	strb	w24, [x25, #0x8]
1067f8d64: f9002737    	str	x23, [x25, #0x48]
1067f8d68: 39002736    	strb	w22, [x25, #0x9]
1067f8d6c: 39002b35    	strb	w21, [x25, #0xa]
1067f8d70: 9100a320    	add	x0, x25, #0x28
1067f8d74: aa1303e1    	mov	x1, x19
1067f8d78: 9450b8f2    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1067f8d7c: b00cbf68    	adrp	x8, 0x11ffe5000 <dyld_stub_binder+0x11ffe5000>
1067f8d80: f9421501    	ldr	x1, [x8, #0x428] ; prepareDisplayElements
1067f8d84: aa1903e0    	mov	x0, x25
1067f8d88: 9450b8ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1067f8d8c: aa1303e0    	mov	x0, x19
1067f8d90: 9450b8f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067f8d94: aa1403e0    	mov	x0, x20
1067f8d98: 9450b8ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1067f8d9c: aa1903e0    	mov	x0, x25
1067f8da0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1067f8da4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1067f8da8: a94357f6    	ldp	x22, x21, [sp, #0x30]
1067f8dac: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1067f8db0: a94167fa    	ldp	x26, x25, [sp, #0x10]
1067f8db4: 910183ff    	add	sp, sp, #0x60
1067f8db8: d65f03c0    	ret
