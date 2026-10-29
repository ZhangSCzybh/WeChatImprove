
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047a8f5c: d101c3ff    	sub	sp, sp, #0x70
1047a8f60: a9016ffc    	stp	x28, x27, [sp, #0x10]
1047a8f64: a90267fa    	stp	x26, x25, [sp, #0x20]
1047a8f68: a9035ff8    	stp	x24, x23, [sp, #0x30]
1047a8f6c: a90457f6    	stp	x22, x21, [sp, #0x40]
1047a8f70: a9054ff4    	stp	x20, x19, [sp, #0x50]
1047a8f74: a9067bfd    	stp	x29, x30, [sp, #0x60]
1047a8f78: 910183fd    	add	x29, sp, #0x60
1047a8f7c: aa0203f3    	mov	x19, x2
1047a8f80: b00e24a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047a8f84: 52800029    	mov	w9, #0x1                ; =1
1047a8f88: 39207909    	strb	w9, [x8, #0x81e]
1047a8f8c: aa0203e0    	mov	x0, x2
1047a8f90: 94d1f86a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047a8f94: b9000fff    	str	wzr, [sp, #0xc]
1047a8f98: 910033e0    	add	x0, sp, #0xc
1047a8f9c: 97ffeb37    	bl	0x1047a3c78 <_Flutter_MMFoundation_BindContext+0xc7f85c>
1047a8fa0: b9400ffa    	ldr	w26, [sp, #0xc]
1047a8fa4: 7100075f    	cmp	w26, #0x1
1047a8fa8: 5400034b    	b.lt	0x1047a9010 <_Flutter_MMFoundation_BindContext+0xc84bf4>
1047a8fac: aa0003f6    	mov	x22, x0
1047a8fb0: 900dcae8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1047a8fb4: f940cd14    	ldr	x20, [x8, #0x198] ; selector lowercaseString
1047a8fb8: d00dcac8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1047a8fbc: f9444915    	ldr	x21, [x8, #0x890] ; selector hasPrefix:
1047a8fc0: f9400017    	ldr	x23, [x0]
1047a8fc4: aa1703e0    	mov	x0, x23
1047a8fc8: 94d1f85c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047a8fcc: aa1303e0    	mov	x0, x19
1047a8fd0: aa1403e1    	mov	x1, x20
1047a8fd4: 94d1f85a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a8fd8: aa1d03fd    	mov	x29, x29
1047a8fdc: 94d1f85b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a8fe0: aa0003f8    	mov	x24, x0
1047a8fe4: aa1503e1    	mov	x1, x21
1047a8fe8: aa1703e2    	mov	x2, x23
1047a8fec: 94d1f854    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a8ff0: aa0003f9    	mov	x25, x0
1047a8ff4: aa1703e0    	mov	x0, x23
1047a8ff8: 94d1f857    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a8ffc: aa1803e0    	mov	x0, x24
1047a9000: 94d1f855    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9004: 360000b9    	tbz	w25, #0x0, 0x1047a9018 <_Flutter_MMFoundation_BindContext+0xc84bfc>
1047a9008: 52800034    	mov	w20, #0x1               ; =1
1047a900c: 1400001d    	b	0x1047a9080 <_Flutter_MMFoundation_BindContext+0xc84c64>
1047a9010: 52800014    	mov	w20, #0x0               ; =0
1047a9014: 1400001b    	b	0x1047a9080 <_Flutter_MMFoundation_BindContext+0xc84c64>
1047a9018: 910062d9    	add	x25, x22, #0x18
1047a901c: 52800028    	mov	w8, #0x1                ; =1
1047a9020: aa0803fb    	mov	x27, x8
1047a9024: eb08035f    	cmp	x26, x8
1047a9028: 54000280    	b.eq	0x1047a9078 <_Flutter_MMFoundation_BindContext+0xc84c5c>
1047a902c: f8418736    	ldr	x22, [x25], #0x18
1047a9030: aa1603e0    	mov	x0, x22
1047a9034: 94d1f841    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047a9038: aa1303e0    	mov	x0, x19
1047a903c: aa1403e1    	mov	x1, x20
1047a9040: 94d1f83f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a9044: aa1d03fd    	mov	x29, x29
1047a9048: 94d1f840    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a904c: aa0003f7    	mov	x23, x0
1047a9050: aa1503e1    	mov	x1, x21
1047a9054: aa1603e2    	mov	x2, x22
1047a9058: 94d1f839    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a905c: aa0003f8    	mov	x24, x0
1047a9060: aa1603e0    	mov	x0, x22
1047a9064: 94d1f83c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9068: aa1703e0    	mov	x0, x23
1047a906c: 94d1f83a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9070: 91000768    	add	x8, x27, #0x1
1047a9074: 34fffd78    	cbz	w24, 0x1047a9020 <_Flutter_MMFoundation_BindContext+0xc84c04>
1047a9078: eb1a037f    	cmp	x27, x26
1047a907c: 1a9f27f4    	cset	w20, lo
1047a9080: aa1303e0    	mov	x0, x19
1047a9084: 94d1f834    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a9088: aa1403e0    	mov	x0, x20
1047a908c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1047a9090: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1047a9094: a94457f6    	ldp	x22, x21, [sp, #0x40]
1047a9098: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1047a909c: a94267fa    	ldp	x26, x25, [sp, #0x20]
1047a90a0: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1047a90a4: 9101c3ff    	add	sp, sp, #0x70
1047a90a8: d65f03c0    	ret
