
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628edc8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10628edcc: a9014ff4    	stp	x20, x19, [sp, #0x10]
10628edd0: a9027bfd    	stp	x29, x30, [sp, #0x20]
10628edd4: 910083fd    	add	x29, sp, #0x20
10628edd8: aa0003f3    	mov	x19, x0
10628eddc: b00d4da8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10628ede0: 52800029    	mov	w9, #0x1                ; =1
10628ede4: 39290109    	strb	w9, [x8, #0xa40]
10628ede8: f00cdfe8    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
10628edec: f944a114    	ldr	x20, [x8, #0x940] ; voiceTranslateInfo
10628edf0: aa1403e1    	mov	x1, x20
10628edf4: 946660d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628edf8: aa1d03fd    	mov	x29, x29
10628edfc: 946660d3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ee00: aa0003f5    	mov	x21, x0
10628ee04: 946660d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628ee08: b4000415    	cbz	x21, 0x10628ee88 <_Flutter_MMFoundation_BindContext+0x276aa6c>
10628ee0c: aa1303e0    	mov	x0, x19
10628ee10: aa1403e1    	mov	x1, x20
10628ee14: 946660ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ee18: aa1d03fd    	mov	x29, x29
10628ee1c: 946660cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ee20: aa0003f5    	mov	x21, x0
10628ee24: b00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628ee28: f946f101    	ldr	x1, [x8, #0xde0] ; showTransResult
10628ee2c: 946660c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ee30: aa0003f6    	mov	x22, x0
10628ee34: aa1503e0    	mov	x0, x21
10628ee38: 946660c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628ee3c: 34000276    	cbz	w22, 0x10628ee88 <_Flutter_MMFoundation_BindContext+0x276aa6c>
10628ee40: aa1303e0    	mov	x0, x19
10628ee44: aa1403e1    	mov	x1, x20
10628ee48: 946660bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ee4c: aa1d03fd    	mov	x29, x29
10628ee50: 946660be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ee54: aa0003f5    	mov	x21, x0
10628ee58: b00cde48    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
10628ee5c: f940e101    	ldr	x1, [x8, #0x1c0] ; displayText
10628ee60: 946660b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ee64: aa1d03fd    	mov	x29, x29
10628ee68: 946660b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ee6c: aa0003f6    	mov	x22, x0
10628ee70: b00cf3a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10628ee74: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10628ee78: 946660b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ee7c: b40000a0    	cbz	x0, 0x10628ee90 <_Flutter_MMFoundation_BindContext+0x276aa74>
10628ee80: 52800033    	mov	w19, #0x1               ; =1
10628ee84: 14000010    	b	0x10628eec4 <_Flutter_MMFoundation_BindContext+0x276aaa8>
10628ee88: 52800013    	mov	w19, #0x0               ; =0
10628ee8c: 14000012    	b	0x10628eed4 <_Flutter_MMFoundation_BindContext+0x276aab8>
10628ee90: aa1303e0    	mov	x0, x19
10628ee94: aa1403e1    	mov	x1, x20
10628ee98: 946660a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ee9c: aa1d03fd    	mov	x29, x29
10628eea0: 946660aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628eea4: aa0003f4    	mov	x20, x0
10628eea8: 900cf3e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10628eeac: f945b101    	ldr	x1, [x8, #0xb60] ; status
10628eeb0: 946660a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628eeb4: f100001f    	cmp	x0, #0x0
10628eeb8: 1a9f07f3    	cset	w19, ne
10628eebc: aa1403e0    	mov	x0, x20
10628eec0: 946660a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628eec4: aa1603e0    	mov	x0, x22
10628eec8: 946660a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628eecc: aa1503e0    	mov	x0, x21
10628eed0: 946660a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628eed4: aa1303e0    	mov	x0, x19
10628eed8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10628eedc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10628eee0: a8c357f6    	ldp	x22, x21, [sp], #0x30
10628eee4: d65f03c0    	ret