
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1130e3cfc: f0065189    	adrp	x9, 0x11fb16000 <dyld_stub_binder+0x11fb16000>
1130e3d00: f9442129    	ldr	x9, [x9, #0x840] ; 0x11fb16840 __bss
1130e3d04: b4000049    	cbz	x9, 0x1130e3d0c <_O266DecReleaseOutputPicture+0xfd47a0>
1130e3d08: d61f0120    	br	x9
1130e3d0c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1130e3d10: a9014ff4    	stp	x20, x19, [sp, #0x10]
1130e3d14: a9027bfd    	stp	x29, x30, [sp, #0x20]
1130e3d18: 910083fd    	add	x29, sp, #0x20
1130e3d1c: d109c3ff    	sub	sp, sp, #0x270
1130e3d20: aa0003f3    	mov	x19, x0
1130e3d24: b0053348    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1130e3d28: f9451908    	ldr	x8, [x8, #0xa30] ; 0x11d74ca30 __got
1130e3d2c: f9400108    	ldr	x8, [x8]
1130e3d30: f81d83a8    	stur	x8, [x29, #-0x28]
1130e3d34: f003f3c2    	adrp	x2, 0x11af5e000 <dyld_stub_binder+0x11af5e000>
1130e3d38: 91340442    	add	x2, x2, #0xd01 ; 'mars::baseevent'
1130e3d3c: f003bcc4    	adrp	x4, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e3d40: 9137d084    	add	x4, x4, #0xdf4 ; 'active_logic.cc'
1130e3d44: f003bcc3    	adrp	x3, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e3d48: 9139bc63    	add	x3, x3, #0xe6f ; '__OnInActive'
1130e3d4c: 910383e0    	add	x0, sp, #0xe0
1130e3d50: 52800021    	mov	w1, #0x1                ; =1
1130e3d54: aa0303e5    	mov	x5, x3
1130e3d58: 52801326    	mov	w6, #0x99               ; =153
1130e3d5c: d2800007    	mov	x7, #0x0                ; =0
1130e3d60: 9404d642    	bl	0x113219668 <_O266DecReleaseOutputPicture+0x110a0fc>
1130e3d64: 3940e268    	ldrb	w8, [x19, #0x38]
1130e3d68: 7100051f    	cmp	w8, #0x1
1130e3d6c: 54000061    	b.ne	0x1130e3d78 <_O266DecReleaseOutputPicture+0xfd480c>
1130e3d70: 3940e674    	ldrb	w20, [x19, #0x39]
1130e3d74: 14000003    	b	0x1130e3d80 <_O266DecReleaseOutputPicture+0xfd4814>
1130e3d78: 52800014    	mov	w20, #0x0               ; =0
1130e3d7c: 3900e67f    	strb	wzr, [x19, #0x39]
1130e3d80: 52800040    	mov	w0, #0x2                ; =2
1130e3d84: 9404d830    	bl	0x113219e44 <_O266DecReleaseOutputPicture+0x110a8d8>
1130e3d88: 34000520    	cbz	w0, 0x1130e3e2c <_O266DecReleaseOutputPicture+0xfd48c0>
1130e3d8c: d102a3b5    	sub	x21, x29, #0xa8
1130e3d90: f003f3c2    	adrp	x2, 0x11af5e000 <dyld_stub_binder+0x11af5e000>
1130e3d94: 91340442    	add	x2, x2, #0xd01 ; 'mars::baseevent'
1130e3d98: f003bcc3    	adrp	x3, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e3d9c: 9137d063    	add	x3, x3, #0xdf4 ; 'active_logic.cc'
1130e3da0: f003bcc4    	adrp	x4, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e3da4: 9139bc84    	add	x4, x4, #0xe6f ; '__OnInActive'
1130e3da8: 910003e0    	mov	x0, sp
1130e3dac: 52800041    	mov	w1, #0x2                ; =2
1130e3db0: 528013c5    	mov	w5, #0x9e               ; =158
1130e3db4: 52800006    	mov	w6, #0x0                ; =0
1130e3db8: d2800007    	mov	x7, #0x0                ; =0
1130e3dbc: 9404d487    	bl	0x113218fd8 <_O266DecReleaseOutputPicture+0x1109a6c>
1130e3dc0: 390263ff    	strb	wzr, [sp, #0x98]
1130e3dc4: 3940e668    	ldrb	w8, [x19, #0x39]
1130e3dc8: 9003f4e9    	adrp	x9, 0x11af7f000 <dyld_stub_binder+0x11af7f000>
1130e3dcc: 912d6929    	add	x9, x9, #0xb5a ; 'false'
1130e3dd0: 9004070a    	adrp	x10, 0x11b1c3000 <dyld_stub_binder+0x11b1c3000>
1130e3dd4: 9125e14a    	add	x10, x10, #0x978 ; 'true'
1130e3dd8: 7100011f    	cmp	w8, #0x0
1130e3ddc: 9a891148    	csel	x8, x10, x9, ne
1130e3de0: f9004be8    	str	x8, [sp, #0x90]
1130e3de4: 4f00e400    	movi.16b	v0, #0x0
1130e3de8: 3c8082a0    	stur	q0, [x21, #0x8]
1130e3dec: 910243e8    	add	x8, sp, #0x90
1130e3df0: 3c8182a0    	stur	q0, [x21, #0x18]
1130e3df4: 3c8282a0    	stur	q0, [x21, #0x28]
1130e3df8: 3c8382a0    	stur	q0, [x21, #0x38]
1130e3dfc: 3c8482a0    	stur	q0, [x21, #0x48]
1130e3e00: 3c8582a0    	stur	q0, [x21, #0x58]
1130e3e04: 3c8682a0    	stur	q0, [x21, #0x68]
1130e3e08: f81583a8    	stur	x8, [x29, #-0xa8]
1130e3e0c: f81d03bf    	stur	xzr, [x29, #-0x30]
1130e3e10: f003bcc1    	adrp	x1, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e3e14: 91397821    	add	x1, x1, #0xe5e ; 'active change:%0'
1130e3e18: 910003e0    	mov	x0, sp
1130e3e1c: d102a3a2    	sub	x2, x29, #0xa8
1130e3e20: 9404d53c    	bl	0x113219310 <_O266DecReleaseOutputPicture+0x1109da4>
1130e3e24: 910003e0    	mov	x0, sp
1130e3e28: 9404d4b4    	bl	0x1132190f8 <_O266DecReleaseOutputPicture+0x1109b8c>
1130e3e2c: f9401660    	ldr	x0, [x19, #0x28]
1130e3e30: 12000281    	and	w1, w20, #0x1
1130e3e34: 96197d73    	bl	0x10b743400 <_mmkv_importFrom+0x88065c>
1130e3e38: 910383e0    	add	x0, sp, #0xe0
1130e3e3c: 9404d667    	bl	0x1132197d8 <_O266DecReleaseOutputPicture+0x110a26c>
1130e3e40: f85d83a8    	ldur	x8, [x29, #-0x28]
1130e3e44: b0053349    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1130e3e48: f9451929    	ldr	x9, [x9, #0xa30] ; 0x11d74ca30 __got
1130e3e4c: f9400129    	ldr	x9, [x9]
1130e3e50: eb08013f    	cmp	x9, x8
1130e3e54: 540000c1    	b.ne	0x1130e3e6c <_O266DecReleaseOutputPicture+0xfd4900>
1130e3e58: 9109c3ff    	add	sp, sp, #0x270
1130e3e5c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1130e3e60: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1130e3e64: a8c357f6    	ldp	x22, x21, [sp], #0x30
1130e3e68: d65f03c0    	ret
1130e3e6c: 94f5d3a3    	bl	0x116e58cf8 <dyld_stub_binder+0x116e58cf8>
