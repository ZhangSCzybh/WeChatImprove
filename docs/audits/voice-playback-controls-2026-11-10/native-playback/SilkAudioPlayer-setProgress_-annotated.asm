
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105cf4d10: d00c8448    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105cf4d14: 912ab108    	add	x8, x8, #0xaac
105cf4d18: b9800108    	ldrsw	x8, [x8] ; ivar: BaseAudioPlayer.mAqData offset=8
105cf4d1c: f8686808    	ldr	x8, [x0, x8]
105cf4d20: 3941b508    	ldrb	w8, [x8, #0x6d]
105cf4d24: 34000088    	cbz	w8, 0x105cf4d34 <_Flutter_MMFoundation_BindContext+0x1f7ba00>
105cf4d28: d00c7248    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105cf4d2c: f9444d01    	ldr	x1, [x8, #0x898] ; selector: setCurrentPacketWithTime:
105cf4d30: 147ccbcd    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4d34: d65f03c0    	ret
