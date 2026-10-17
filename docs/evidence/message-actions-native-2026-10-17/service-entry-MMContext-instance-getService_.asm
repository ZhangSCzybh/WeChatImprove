
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
117609d44: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
117609d48: a9017bfd    	stp	x29, x30, [sp, #0x10]
117609d4c: 910043fd    	add	x29, sp, #0x10
117609d50: aa0203f3    	mov	x19, x2
117609d54: aa0003f4    	mov	x20, x0
117609d58: b0045d68    	adrp	x8, 0x1201b6000 <dyld_stub_binder+0x1201b6000>
117609d5c: f9424900    	ldr	x0, [x8, #0x490] ; ��d 
117609d60: d00457a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
117609d64: f947ad01    	ldr	x1, [x8, #0xf58] ; class
117609d68: 94347fe1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
117609d6c: aa0003e2    	mov	x2, x0
117609d70: d00457c8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
117609d74: f9451101    	ldr	x1, [x8, #0xa20] ; isSubclassOfClass:
117609d78: aa1303e0    	mov	x0, x19
117609d7c: 94347fdc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
117609d80: 90052f68    	adrp	x8, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
117609d84: 9114e108    	add	x8, x8, #0x538
117609d88: f9400108    	ldr	x8, [x8]
117609d8c: 340000c0    	cbz	w0, 0x117609da4 <_O266DecReleaseOutputPicture+0x437d2ec>
117609d90: b0046469    	adrp	x9, 0x120296000 <dyld_stub_binder+0x120296000>
117609d94: 911c0129    	add	x9, x9, #0x700
117609d98: b9800129    	ldrsw	x9, [x9]
117609d9c: f8696900    	ldr	x0, [x8, x9]
117609da0: 1400000c    	b	0x117609dd0 <_O266DecReleaseOutputPicture+0x437d318>
117609da4: eb14011f    	cmp	x8, x20
117609da8: 54000240    	b.eq	0x117609df0 <_O266DecReleaseOutputPicture+0x437d338>
117609dac: 90052f68    	adrp	x8, 0x121bf5000 <dyld_stub_binder+0x121bf5000>
117609db0: 91150108    	add	x8, x8, #0x540
117609db4: f9400108    	ldr	x8, [x8]
117609db8: eb14011f    	cmp	x8, x20
117609dbc: 540001a0    	b.eq	0x117609df0 <_O266DecReleaseOutputPicture+0x437d338>
117609dc0: b0046468    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
117609dc4: 911c0108    	add	x8, x8, #0x700
117609dc8: b9800108    	ldrsw	x8, [x8]
117609dcc: f8686a80    	ldr	x0, [x20, x8]
117609dd0: 90044188    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
117609dd4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
117609dd8: aa1303e2    	mov	x2, x19
117609ddc: 94347fc4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
117609de0: aa1d03fd    	mov	x29, x29
117609de4: 94347fec    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
117609de8: aa0003f3    	mov	x19, x0
117609dec: 14000012    	b	0x117609e34 <_O266DecReleaseOutputPicture+0x437d37c>
117609df0: d0045b48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
117609df4: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
117609df8: 90044188    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
117609dfc: f9469901    	ldr	x1, [x8, #0xd30] ; activeUserContext
117609e00: 94347fbb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
117609e04: aa1d03fd    	mov	x29, x29
117609e08: 94347fe3    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
117609e0c: aa0003f4    	mov	x20, x0
117609e10: 90044188    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
117609e14: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
117609e18: aa1303e2    	mov	x2, x19
117609e1c: 94347fb4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
117609e20: aa1d03fd    	mov	x29, x29
117609e24: 94347fdc    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
117609e28: aa0003f3    	mov	x19, x0
117609e2c: aa1403e0    	mov	x0, x20
117609e30: 94347fca    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
117609e34: aa1303e0    	mov	x0, x19
117609e38: a9417bfd    	ldp	x29, x30, [sp, #0x10]
117609e3c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
117609e40: 14347f66    	b	0x118329bd8 <dyld_stub_binder+0x118329bd8>