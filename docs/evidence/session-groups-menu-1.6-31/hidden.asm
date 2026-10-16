
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116752c24: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
116752c28: a9017bfd    	stp	x29, x30, [sp, #0x10]
116752c2c: 910043fd    	add	x29, sp, #0x10
116752c30: aa0003f3    	mov	x19, x0
116752c34: b004b9c8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
116752c38: f9447d01    	ldr	x1, [x8, #0x8f8]
116752c3c: 946f5c2c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116752c40: 340000a0    	cbz	w0, 0x116752c54 <_O266DecReleaseOutputPicture+0x34c619c>
116752c44: f004d9e8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116752c48: b9875108    	ldrsw	x8, [x8, #0x750]
116752c4c: 38686a68    	ldrb	w8, [x19, x8]
116752c50: 14000002    	b	0x116752c58 <_O266DecReleaseOutputPicture+0x34c61a0>
116752c54: 52800028    	mov	w8, #0x1                ; =1
116752c58: 12000100    	and	w0, w8, #0x1
116752c5c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
116752c60: a8c24ff4    	ldp	x20, x19, [sp], #0x20
116752c64: d65f03c0    	ret
