
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106120fd4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106120fd8: a9014ff4    	stp	x20, x19, [sp, #0x10]
106120fdc: a9027bfd    	stp	x29, x30, [sp, #0x20]
106120fe0: 910083fd    	add	x29, sp, #0x20
106120fe4: aa0403f3    	mov	x19, x4
106120fe8: aa0303f4    	mov	x20, x3
106120fec: aa0003f6    	mov	x22, x0
106120ff0: f00d0388    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
106120ff4: f9467d00    	ldr	x0, [x8, #0xcf8]
106120ff8: f00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106120ffc: f945c901    	ldr	x1, [x8, #0xb90] ; infoWithVoipMonoMsg:scene:
106121000: 52800023    	mov	w3, #0x1                ; =1
106121004: 946c184e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106121008: aa1d03fd    	mov	x29, x29
10612100c: 946c184f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106121010: aa0003f5    	mov	x21, x0
106121014: b4000140    	cbz	x0, 0x10612103c <_Flutter_MMFoundation_BindContext+0x25fcc20>
106121018: d00cf568    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10612101c: f945cd01    	ldr	x1, [x8, #0xb98] ; handleInvitationInfo:withTalkingRoomID:talkingRoomKey:
106121020: aa1603e0    	mov	x0, x22
106121024: aa1503e2    	mov	x2, x21
106121028: aa1403e3    	mov	x3, x20
10612102c: aa1303e4    	mov	x4, x19
106121030: 946c1843    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106121034: aa0003f3    	mov	x19, x0
106121038: 14000002    	b	0x106121040 <_Flutter_MMFoundation_BindContext+0x25fcc24>
10612103c: 52800013    	mov	w19, #0x0               ; =0
106121040: aa1503e0    	mov	x0, x21
106121044: 946c1844    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106121048: aa1303e0    	mov	x0, x19
10612104c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106121050: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106121054: a8c357f6    	ldp	x22, x21, [sp], #0x30
106121058: d65f03c0    	ret
