
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105cf4db8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
105cf4dbc: a9017bfd    	stp	x29, x30, [sp, #0x10]
105cf4dc0: 910043fd    	add	x29, sp, #0x10
105cf4dc4: aa0003f3    	mov	x19, x0
105cf4dc8: b00c7dc8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
105cf4dcc: f941ad14    	ldr	x20, [x8, #0x358] ; selector: state
105cf4dd0: aa1403e1    	mov	x1, x20
105cf4dd4: 947ccba4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4dd8: f100041f    	cmp	x0, #0x1
105cf4ddc: 540000c0    	b.eq	0x105cf4df4 <_Flutter_MMFoundation_BindContext+0x1f7bac0>
105cf4de0: aa1303e0    	mov	x0, x19
105cf4de4: aa1403e1    	mov	x1, x20
105cf4de8: 947ccb9f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4dec: f100081f    	cmp	x0, #0x2
105cf4df0: 54000121    	b.ne	0x105cf4e14 <_Flutter_MMFoundation_BindContext+0x1f7bae0>
105cf4df4: d00c8448    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105cf4df8: 912ab108    	add	x8, x8, #0xaac
105cf4dfc: b9800108    	ldrsw	x8, [x8] ; ivar: BaseAudioPlayer.mAqData offset=8
105cf4e00: f8686a68    	ldr	x8, [x19, x8]
105cf4e04: b9400908    	ldr	w8, [x8, #0x8]
105cf4e08: 52800c89    	mov	w9, #0x64               ; =100
105cf4e0c: 1b097d00    	mul	w0, w8, w9
105cf4e10: 14000002    	b	0x105cf4e18 <_Flutter_MMFoundation_BindContext+0x1f7bae4>
105cf4e14: 52800000    	mov	w0, #0x0                ; =0
105cf4e18: a9417bfd    	ldp	x29, x30, [sp, #0x10]
105cf4e1c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105cf4e20: d65f03c0    	ret
