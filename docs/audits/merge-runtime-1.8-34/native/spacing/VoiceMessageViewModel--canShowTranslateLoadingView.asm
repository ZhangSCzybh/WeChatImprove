
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628eee8: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10628eeec: a9014ff4    	stp	x20, x19, [sp, #0x10]
10628eef0: a9027bfd    	stp	x29, x30, [sp, #0x20]
10628eef4: 910083fd    	add	x29, sp, #0x20
10628eef8: aa0003f4    	mov	x20, x0
10628eefc: b00d4da8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10628ef00: 52800029    	mov	w9, #0x1                ; =1
10628ef04: 39290509    	strb	w9, [x8, #0xa41]
10628ef08: f00cdfe8    	adrp	x8, 0x11fe8d000 <dyld_stub_binder+0x11fe8d000>
10628ef0c: f944a115    	ldr	x21, [x8, #0x940] ; voiceTranslateInfo
10628ef10: aa1503e1    	mov	x1, x21
10628ef14: 9466608a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ef18: aa1d03fd    	mov	x29, x29
10628ef1c: 9466608b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ef20: aa0003f3    	mov	x19, x0
10628ef24: b4000560    	cbz	x0, 0x10628efd0 <_Flutter_MMFoundation_BindContext+0x276abb4>
10628ef28: aa1403e0    	mov	x0, x20
10628ef2c: aa1503e1    	mov	x1, x21
10628ef30: 94666083    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ef34: aa1d03fd    	mov	x29, x29
10628ef38: 94666084    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ef3c: aa0003f4    	mov	x20, x0
10628ef40: b00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628ef44: f946f101    	ldr	x1, [x8, #0xde0] ; showTransResult
10628ef48: 9466607d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ef4c: aa0003f5    	mov	x21, x0
10628ef50: aa1403e0    	mov	x0, x20
10628ef54: 94666080    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628ef58: 34000475    	cbz	w21, 0x10628efe4 <_Flutter_MMFoundation_BindContext+0x276abc8>
10628ef5c: 900cf3e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10628ef60: f945b101    	ldr	x1, [x8, #0xb60] ; status
10628ef64: aa1303e0    	mov	x0, x19
10628ef68: 94666075    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ef6c: f100041f    	cmp	x0, #0x1
10628ef70: 54000301    	b.ne	0x10628efd0 <_Flutter_MMFoundation_BindContext+0x276abb4>
10628ef74: b00cde48    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
10628ef78: f940e115    	ldr	x21, [x8, #0x1c0] ; displayText
10628ef7c: aa1303e0    	mov	x0, x19
10628ef80: aa1503e1    	mov	x1, x21
10628ef84: 9466606e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ef88: aa1d03fd    	mov	x29, x29
10628ef8c: 9466606f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ef90: aa0003f4    	mov	x20, x0
10628ef94: b4000220    	cbz	x0, 0x10628efd8 <_Flutter_MMFoundation_BindContext+0x276abbc>
10628ef98: aa1303e0    	mov	x0, x19
10628ef9c: aa1503e1    	mov	x1, x21
10628efa0: 94666067    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628efa4: aa1d03fd    	mov	x29, x29
10628efa8: 94666068    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628efac: aa0003f6    	mov	x22, x0
10628efb0: b00cf3a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10628efb4: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10628efb8: 94666061    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628efbc: f100001f    	cmp	x0, #0x0
10628efc0: 1a9f17f5    	cset	w21, eq
10628efc4: aa1603e0    	mov	x0, x22
10628efc8: 94666063    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628efcc: 14000004    	b	0x10628efdc <_Flutter_MMFoundation_BindContext+0x276abc0>
10628efd0: 52800015    	mov	w21, #0x0               ; =0
10628efd4: 14000004    	b	0x10628efe4 <_Flutter_MMFoundation_BindContext+0x276abc8>
10628efd8: 52800035    	mov	w21, #0x1               ; =1
10628efdc: aa1403e0    	mov	x0, x20
10628efe0: 9466605d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628efe4: aa1303e0    	mov	x0, x19
10628efe8: 9466605b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628efec: aa1503e0    	mov	x0, x21
10628eff0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10628eff4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10628eff8: a8c357f6    	ldp	x22, x21, [sp], #0x30
10628effc: d65f03c0    	ret