
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1165e1c24: d101c3ff    	sub	sp, sp, #0x70
1165e1c28: a9016ffc    	stp	x28, x27, [sp, #0x10]
1165e1c2c: a90267fa    	stp	x26, x25, [sp, #0x20]
1165e1c30: a9035ff8    	stp	x24, x23, [sp, #0x30]
1165e1c34: a90457f6    	stp	x22, x21, [sp, #0x40]
1165e1c38: a9054ff4    	stp	x20, x19, [sp, #0x50]
1165e1c3c: a9067bfd    	stp	x29, x30, [sp, #0x60]
1165e1c40: 910183fd    	add	x29, sp, #0x60
1165e1c44: aa0303f4    	mov	x20, x3
1165e1c48: aa0203f3    	mov	x19, x2
1165e1c4c: aa0003f5    	mov	x21, x0
1165e1c50: aa0203e0    	mov	x0, x2
1165e1c54: 94752047    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e1c58: aa1403e0    	mov	x0, x20
1165e1c5c: 94752045    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e1c60: d004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e1c64: b98ab91a    	ldrsw	x26, [x8, #0xab8]
1165e1c68: 52800028    	mov	w8, #0x1                ; =1
1165e1c6c: 383a6aa8    	strb	w8, [x21, x26]
1165e1c70: 9004c2c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1165e1c74: f9452516    	ldr	x22, [x8, #0xa48] ; target
1165e1c78: aa1303e0    	mov	x0, x19
1165e1c7c: aa1603e1    	mov	x1, x22
1165e1c80: 9475201b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1c84: aa1d03fd    	mov	x29, x29
1165e1c88: 94752043    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1c8c: aa0003f7    	mov	x23, x0
1165e1c90: 94752032    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1c94: b004c35b    	adrp	x27, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1165e1c98: b40004d7    	cbz	x23, 0x1165e1d30 <_O266DecReleaseOutputPicture+0x3355278>
1165e1c9c: aa1303e0    	mov	x0, x19
1165e1ca0: aa1603e1    	mov	x1, x22
1165e1ca4: 94752012    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1ca8: aa1d03fd    	mov	x29, x29
1165e1cac: 9475203a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1cb0: aa0003f6    	mov	x22, x0
1165e1cb4: f9429761    	ldr	x1, [x27, #0x528] ; action
1165e1cb8: aa1303e0    	mov	x0, x19
1165e1cbc: 9475200c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1cc0: aa0003e2    	mov	x2, x0
1165e1cc4: b004c2c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1165e1cc8: f9408101    	ldr	x1, [x8, #0x100] ; safePerformSelector:withObject:afterDelay:
1165e1ccc: 9e6703e0    	fmov	d0, xzr
1165e1cd0: aa1603e0    	mov	x0, x22
1165e1cd4: aa1403e3    	mov	x3, x20
1165e1cd8: 94752005    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1cdc: aa1603e0    	mov	x0, x22
1165e1ce0: 9475201e    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1ce4: f004c368    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
1165e1ce8: f9419d16    	ldr	x22, [x8, #0x338] ; actionBlock
1165e1cec: aa1303e0    	mov	x0, x19
1165e1cf0: aa1603e1    	mov	x1, x22
1165e1cf4: 94751ffe    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1cf8: aa1d03fd    	mov	x29, x29
1165e1cfc: 94752026    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1d00: aa0003f7    	mov	x23, x0
1165e1d04: 94752015    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1d08: b4000617    	cbz	x23, 0x1165e1dc8 <_O266DecReleaseOutputPicture+0x3355310>
1165e1d0c: aa1303e0    	mov	x0, x19
1165e1d10: aa1603e1    	mov	x1, x22
1165e1d14: 94751ff6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1d18: aa1d03fd    	mov	x29, x29
1165e1d1c: 9475201e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1d20: aa0003f6    	mov	x22, x0
1165e1d24: f9400808    	ldr	x8, [x0, #0x10]
1165e1d28: d63f0100    	blr	x8
1165e1d2c: 14000043    	b	0x1165e1e38 <_O266DecReleaseOutputPicture+0x3355380>
1165e1d30: d004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e1d34: b98ac91c    	ldrsw	x28, [x8, #0xac8]
1165e1d38: 8b1c02a0    	add	x0, x21, x28
1165e1d3c: 94751fe0    	bl	0x118329cbc <dyld_stub_binder+0x118329cbc>
1165e1d40: b4fffd20    	cbz	x0, 0x1165e1ce4 <_O266DecReleaseOutputPicture+0x335522c>
1165e1d44: aa0003f6    	mov	x22, x0
1165e1d48: 8b1c02a0    	add	x0, x21, x28
1165e1d4c: 94751fdc    	bl	0x118329cbc <dyld_stub_binder+0x118329cbc>
1165e1d50: aa0003f8    	mov	x24, x0
1165e1d54: f9429777    	ldr	x23, [x27, #0x528] ; action
1165e1d58: aa1303e0    	mov	x0, x19
1165e1d5c: aa1703e1    	mov	x1, x23
1165e1d60: 94751fe3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1d64: aa0003e2    	mov	x2, x0
1165e1d68: b004c408    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
1165e1d6c: f9463501    	ldr	x1, [x8, #0xc68] ; canPerformAction:withSender:
1165e1d70: aa1803e0    	mov	x0, x24
1165e1d74: aa1403e3    	mov	x3, x20
1165e1d78: 94751fdd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1d7c: aa0003f9    	mov	x25, x0
1165e1d80: aa1803e0    	mov	x0, x24
1165e1d84: 94751ff5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1d88: aa1603e0    	mov	x0, x22
1165e1d8c: 94751ff3    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1d90: 34fffab9    	cbz	w25, 0x1165e1ce4 <_O266DecReleaseOutputPicture+0x335522c>
1165e1d94: 8b1c02a0    	add	x0, x21, x28
1165e1d98: 94751fc9    	bl	0x118329cbc <dyld_stub_binder+0x118329cbc>
1165e1d9c: aa0003f6    	mov	x22, x0
1165e1da0: aa1303e0    	mov	x0, x19
1165e1da4: aa1703e1    	mov	x1, x23
1165e1da8: 94751fd1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1dac: aa0003e2    	mov	x2, x0
1165e1db0: 9004d928    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
1165e1db4: f943e101    	ldr	x1, [x8, #0x7c0] ; performSelector:withObject:
1165e1db8: aa1603e0    	mov	x0, x22
1165e1dbc: aa1403e3    	mov	x3, x20
1165e1dc0: 94751fcb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1dc4: 17ffffc6    	b	0x1165e1cdc <_O266DecReleaseOutputPicture+0x3355224>
1165e1dc8: b004de48    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1165e1dcc: f9448500    	ldr	x0, [x8, #0x908] ; @�b 
1165e1dd0: 9004c2e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1165e1dd4: f940f501    	ldr	x1, [x8, #0x1e8] ; externalIMP
1165e1dd8: 94751fc5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1ddc: aa0003f7    	mov	x23, x0
1165e1de0: f9429761    	ldr	x1, [x27, #0x528] ; action
1165e1de4: aa1303e0    	mov	x0, x19
1165e1de8: 94751fc1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1dec: 947504ed    	bl	0x1183231a0 <dyld_stub_binder+0x1183231a0>
1165e1df0: aa1d03fd    	mov	x29, x29
1165e1df4: 94751fe8    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e1df8: aa0003f6    	mov	x22, x0
1165e1dfc: 9004c2c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1165e1e00: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1165e1e04: 90042c28    	adrp	x8, 0x11eb65000 <dyld_stub_binder+0x11eb65000>
1165e1e08: 91362108    	add	x8, x8, #0xd88
1165e1e0c: a90003e8    	stp	x8, x0, [sp]
1165e1e10: f00316c5    	adrp	x5, 0x11c8bc000 <dyld_stub_binder+0x11c8bc000>
1165e1e14: 910848a5    	add	x5, x5, #0x212
1165e1e18: f00316c7    	adrp	x7, 0x11c8bc000 <dyld_stub_binder+0x11c8bc000>
1165e1e1c: 910f4ce7    	add	x7, x7, #0x3d3
1165e1e20: aa1703e0    	mov	x0, x23
1165e1e24: 52800042    	mov	w2, #0x2                ; =2
1165e1e28: d2800003    	mov	x3, #0x0                ; =0
1165e1e2c: 52800004    	mov	w4, #0x0                ; =0
1165e1e30: 52803686    	mov	w6, #0x1b4              ; =436
1165e1e34: 94751fae    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1e38: aa1603e0    	mov	x0, x22
1165e1e3c: 94751fc7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1e40: d004d848    	adrp	x8, 0x1200eb000 <dyld_stub_binder+0x1200eb000>
1165e1e44: f9425d01    	ldr	x1, [x8, #0x4b8] ; notifyMenuItemSelected:
1165e1e48: aa1503e0    	mov	x0, x21
1165e1e4c: aa1303e2    	mov	x2, x19
1165e1e50: 94751fa7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1e54: 387a6aa8    	ldrb	w8, [x21, x26]
1165e1e58: 7100051f    	cmp	w8, #0x1
1165e1e5c: 54000101    	b.ne	0x1165e1e7c <_O266DecReleaseOutputPicture+0x33553c4>
1165e1e60: b004c348    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
1165e1e64: f9428501    	ldr	x1, [x8, #0x508] ; setMenuVisible:responder:animated:
1165e1e68: aa1503e0    	mov	x0, x21
1165e1e6c: 52800002    	mov	w2, #0x0                ; =0
1165e1e70: d2800003    	mov	x3, #0x0                ; =0
1165e1e74: 52800024    	mov	w4, #0x1                ; =1
1165e1e78: 94751f9d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e1e7c: aa1403e0    	mov	x0, x20
1165e1e80: 94751fb6    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e1e84: aa1303e0    	mov	x0, x19
1165e1e88: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1165e1e8c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1165e1e90: a94457f6    	ldp	x22, x21, [sp, #0x40]
1165e1e94: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1165e1e98: a94267fa    	ldp	x26, x25, [sp, #0x20]
1165e1e9c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
1165e1ea0: 9101c3ff    	add	sp, sp, #0x70
1165e1ea4: 14751fad    	b	0x118329d58 <dyld_stub_binder+0x118329d58>