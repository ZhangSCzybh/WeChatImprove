
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116756a10: d100c3ff    	sub	sp, sp, #0x30
116756a14: a9014ff4    	stp	x20, x19, [sp, #0x10]
116756a18: a9027bfd    	stp	x29, x30, [sp, #0x20]
116756a1c: 910083fd    	add	x29, sp, #0x20
116756a20: aa0003f3    	mov	x19, x0
116756a24: b004b9a8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
116756a28: f9447d01    	ldr	x1, [x8, #0x8f8] ; selector contextMenuEnabled
116756a2c: 946f4cb0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756a30: 360000c0    	tbz	w0, #0x0, 0x116756a48 <_O266DecReleaseOutputPicture+0x34c9f90>
116756a34: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756a38: b9875508    	ldrsw	x8, [x8, #0x754] ; ivar-offset MMBaseMultiMenuTableViewCell._actualContentView
116756a3c: f8686a60    	ldr	x0, [x19, x8]
116756a40: 946f4ccc    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116756a44: 1400000a    	b	0x116756a6c <_O266DecReleaseOutputPicture+0x34c9fb4>
116756a48: 9004d428    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
116756a4c: f9462508    	ldr	x8, [x8, #0xc48]
116756a50: a90023f3    	stp	x19, x8, [sp]
116756a54: d004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116756a58: f9427501    	ldr	x1, [x8, #0x4e8] ; selector contentView
116756a5c: 910003e0    	mov	x0, sp
116756a60: 946f4ca6    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116756a64: aa1d03fd    	mov	x29, x29
116756a68: 946f4ccb    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756a6c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
116756a70: a9414ff4    	ldp	x20, x19, [sp, #0x10]
116756a74: 9100c3ff    	add	sp, sp, #0x30
116756a78: 146f4c58    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>
