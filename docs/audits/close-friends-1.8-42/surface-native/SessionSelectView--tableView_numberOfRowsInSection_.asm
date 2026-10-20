
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1057e7a68: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1057e7a6c: a9017bfd    	stp	x29, x30, [sp, #0x10]
1057e7a70: 910043fd    	add	x29, sp, #0x10
1057e7a74: aa0303e2    	mov	x2, x3
1057e7a78: aa0003f3    	mov	x19, x0
1057e7a7c: d00da2c8    	adrp	x8, 0x120c41000 <dyld_stub_binder+0x120c41000>
1057e7a80: 52800034    	mov	w20, #0x1               ; =1
1057e7a84: 39133d14    	strb	w20, [x8, #0x4cf]
1057e7a88: d00d3e48    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e7a8c: f9449d01    	ldr	x1, [x8, #0x938] ; sectionTypeFor:
1057e7a90: 9490fdab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e7a94: f100041f    	cmp	x0, #0x1
1057e7a98: 5400028d    	b.le	0x1057e7ae8 <_Flutter_MMFoundation_BindContext+0x1cc36cc>
1057e7a9c: f100081f    	cmp	x0, #0x2
1057e7aa0: 540004e0    	b.eq	0x1057e7b3c <_Flutter_MMFoundation_BindContext+0x1cc3720>
1057e7aa4: f1000c1f    	cmp	x0, #0x3
1057e7aa8: 540002c0    	b.eq	0x1057e7b00 <_Flutter_MMFoundation_BindContext+0x1cc36e4>
1057e7aac: f100101f    	cmp	x0, #0x4
1057e7ab0: 54000441    	b.ne	0x1057e7b38 <_Flutter_MMFoundation_BindContext+0x1cc371c>
1057e7ab4: 900d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e7ab8: b983c908    	ldrsw	x8, [x8, #0x3c8] ; ivar SessionSelectView.m_arrContacts
1057e7abc: f8686a60    	ldr	x0, [x19, x8]
1057e7ac0: b00d48c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057e7ac4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1057e7ac8: 9490fd9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e7acc: aa0003f4    	mov	x20, x0
1057e7ad0: d00d3ce8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
1057e7ad4: f940dd01    	ldr	x1, [x8, #0x1b8] ; topSessionCount
1057e7ad8: aa1303e0    	mov	x0, x19
1057e7adc: 9490fd98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e7ae0: cb000294    	sub	x20, x20, x0
1057e7ae4: 14000016    	b	0x1057e7b3c <_Flutter_MMFoundation_BindContext+0x1cc3720>
1057e7ae8: b40001c0    	cbz	x0, 0x1057e7b20 <_Flutter_MMFoundation_BindContext+0x1cc3704>
1057e7aec: f100041f    	cmp	x0, #0x1
1057e7af0: 54000241    	b.ne	0x1057e7b38 <_Flutter_MMFoundation_BindContext+0x1cc371c>
1057e7af4: d00d3e48    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e7af8: f944a101    	ldr	x1, [x8, #0x940] ; countOfRowForBizChatSession
1057e7afc: 14000016    	b	0x1057e7b54 <_Flutter_MMFoundation_BindContext+0x1cc3738>
1057e7b00: b00d35e8    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
1057e7b04: f9401d01    	ldr	x1, [x8, #0x38] ; isFoldTopSession
1057e7b08: aa1303e0    	mov	x0, x19
1057e7b0c: 9490fd8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1057e7b10: 340001e0    	cbz	w0, 0x1057e7b4c <_Flutter_MMFoundation_BindContext+0x1cc3730>
1057e7b14: d00d3e48    	adrp	x8, 0x11ffb1000 <dyld_stub_binder+0x11ffb1000>
1057e7b18: f9445901    	ldr	x1, [x8, #0x8b0] ; selectedTopSessionCount
1057e7b1c: 1400000e    	b	0x1057e7b54 <_Flutter_MMFoundation_BindContext+0x1cc3738>
1057e7b20: 900d5248    	adrp	x8, 0x12022f000 <dyld_stub_binder+0x12022f000>
1057e7b24: b983d908    	ldrsw	x8, [x8, #0x3d8] ; ivar SessionSelectView.m_specialCellList
1057e7b28: f8686a60    	ldr	x0, [x19, x8]
1057e7b2c: b00d48c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1057e7b30: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1057e7b34: 14000009    	b	0x1057e7b58 <_Flutter_MMFoundation_BindContext+0x1cc373c>
1057e7b38: d2800014    	mov	x20, #0x0               ; =0
1057e7b3c: aa1403e0    	mov	x0, x20
1057e7b40: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1057e7b44: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1057e7b48: d65f03c0    	ret
1057e7b4c: d00d3ce8    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
1057e7b50: f940dd01    	ldr	x1, [x8, #0x1b8] ; topSessionCount
1057e7b54: aa1303e0    	mov	x0, x19
1057e7b58: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1057e7b5c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1057e7b60: 1490fd77    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
