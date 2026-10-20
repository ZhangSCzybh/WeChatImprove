
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105f7dea8: d10143ff    	sub	sp, sp, #0x50
105f7deac: a9015ff8    	stp	x24, x23, [sp, #0x10]
105f7deb0: a90257f6    	stp	x22, x21, [sp, #0x20]
105f7deb4: a9034ff4    	stp	x20, x19, [sp, #0x30]
105f7deb8: a9047bfd    	stp	x29, x30, [sp, #0x40]
105f7debc: 910103fd    	add	x29, sp, #0x40
105f7dec0: d00d6628    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
105f7dec4: 52800029    	mov	w9, #0x1                ; =1
105f7dec8: 3904d109    	strb	w9, [x8, #0x134]
105f7decc: f00d1248    	adrp	x8, 0x1201c8000 <dyld_stub_binder+0x1201c8000>
105f7ded0: f945a908    	ldr	x8, [x8, #0xb50]
105f7ded4: a90023e0    	stp	x0, x8, [sp]
105f7ded8: b00d0c28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f7dedc: f9466901    	ldr	x1, [x8, #0xcd0] ; selector=init
105f7dee0: 910003e0    	mov	x0, sp
105f7dee4: 9472a498    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105f7dee8: aa0003f3    	mov	x19, x0
105f7deec: b40006a0    	cbz	x0, 0x105f7dfc0 <_Flutter_MMFoundation_BindContext+0x2459ba4>
105f7def0: d00d0fb7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105f7def4: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
105f7def8: f00d0c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105f7defc: f944e914    	ldr	x20, [x8, #0x9d0] ; selector=currentContext
105f7df00: aa1403e1    	mov	x1, x20
105f7df04: 9472a48e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7df08: aa1d03fd    	mov	x29, x29
105f7df0c: 9472a48f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f7df10: aa0003f5    	mov	x21, x0
105f7df14: f00d0f88    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
105f7df18: f9458502    	ldr	x2, [x8, #0xb08] ; protocol=IMsgExt
105f7df1c: b00cf5e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105f7df20: f940a116    	ldr	x22, [x8, #0x140] ; selector=registerExtension:withTarget:
105f7df24: aa1603e1    	mov	x1, x22
105f7df28: aa1303e3    	mov	x3, x19
105f7df2c: 9472a484    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7df30: aa1503e0    	mov	x0, x21
105f7df34: 9472a488    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f7df38: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
105f7df3c: aa1403e1    	mov	x1, x20
105f7df40: 9472a47f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7df44: aa1d03fd    	mov	x29, x29
105f7df48: 9472a480    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f7df4c: aa0003f5    	mov	x21, x0
105f7df50: 900d0fa8    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
105f7df54: f947b102    	ldr	x2, [x8, #0xf60] ; protocol=VoIPPushKitExt
105f7df58: f00cf5e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105f7df5c: f943c501    	ldr	x1, [x8, #0x788] ; selector=registerExtension:withKey:withTarget:
105f7df60: b00c3723    	adrp	x3, 0x11e662000 <dyld_stub_binder+0x11e662000>
105f7df64: 912c2063    	add	x3, x3, #0xb08 ; cfstring='200'
105f7df68: aa1303e4    	mov	x4, x19
105f7df6c: 9472a474    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7df70: aa1503e0    	mov	x0, x21
105f7df74: 9472a478    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f7df78: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
105f7df7c: aa1403e1    	mov	x1, x20
105f7df80: 9472a46f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7df84: aa1d03fd    	mov	x29, x29
105f7df88: 9472a470    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f7df8c: aa0003f4    	mov	x20, x0
105f7df90: b00d0fa8    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
105f7df94: f9414502    	ldr	x2, [x8, #0x288] ; protocol=VoIPInvitationServiceExtension
105f7df98: aa1603e1    	mov	x1, x22
105f7df9c: aa1303e3    	mov	x3, x19
105f7dfa0: 9472a467    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7dfa4: aa1403e0    	mov	x0, x20
105f7dfa8: 9472a46b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f7dfac: b00d0268    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f7dfb0: f940f101    	ldr	x1, [x8, #0x1e0] ; selector=setM_getRoomInfoCgi:
105f7dfb4: aa1303e0    	mov	x0, x19
105f7dfb8: d2800002    	mov	x2, #0x0                ; =0
105f7dfbc: 9472a460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7dfc0: aa1303e0    	mov	x0, x19
105f7dfc4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
105f7dfc8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105f7dfcc: a94257f6    	ldp	x22, x21, [sp, #0x20]
105f7dfd0: a9415ff8    	ldp	x24, x23, [sp, #0x10]
105f7dfd4: 910143ff    	add	sp, sp, #0x50
105f7dfd8: d65f03c0    	ret
