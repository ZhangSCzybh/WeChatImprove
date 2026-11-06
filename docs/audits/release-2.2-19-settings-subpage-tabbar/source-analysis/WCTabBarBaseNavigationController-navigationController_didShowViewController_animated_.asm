
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157d7e68: d10143ff    	sub	sp, sp, #0x50
1157d7e6c: a9015ff8    	stp	x24, x23, [sp, #0x10]
1157d7e70: a90257f6    	stp	x22, x21, [sp, #0x20]
1157d7e74: a9034ff4    	stp	x20, x19, [sp, #0x30]
1157d7e78: a9047bfd    	stp	x29, x30, [sp, #0x40]
1157d7e7c: 910103fd    	add	x29, sp, #0x40
1157d7e80: aa0403f4    	mov	x20, x4
1157d7e84: aa0303f3    	mov	x19, x3
1157d7e88: aa0203f6    	mov	x22, x2
1157d7e8c: aa0003f5    	mov	x21, x0
1157d7e90: aa0303e0    	mov	x0, x3
1157d7e94: 945a11d0    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157d7e98: f004ad08    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
1157d7e9c: f940e508    	ldr	x8, [x8, #0x1c8]
1157d7ea0: a90023f5    	stp	x21, x8, [sp]
1157d7ea4: d0049e88    	adrp	x8, 0x11eba9000 <dyld_stub_binder+0x11eba9000>
1157d7ea8: f9422d17    	ldr	x23, [x8, #0x458]
1157d7eac: aa1603e0    	mov	x0, x22
1157d7eb0: 945a11c9    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157d7eb4: 910003e0    	mov	x0, sp
1157d7eb8: aa1703e1    	mov	x1, x23
1157d7ebc: aa1603e2    	mov	x2, x22
1157d7ec0: aa1303e3    	mov	x3, x19
1157d7ec4: aa1403e4    	mov	x4, x20
1157d7ec8: 945a11a2    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
1157d7ecc: aa1603e0    	mov	x0, x22
1157d7ed0: 945a11bb    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7ed4: eb1502df    	cmp	x22, x21
1157d7ed8: 540002a1    	b.ne	0x1157d7f2c <_O266DecReleaseOutputPicture+0x36c89c0>
1157d7edc: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7ee0: f941d501    	ldr	x1, [x8, #0x3a8]
1157d7ee4: aa1503e0    	mov	x0, x21
1157d7ee8: 945a1197    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7eec: 34000200    	cbz	w0, 0x1157d7f2c <_O266DecReleaseOutputPicture+0x36c89c0>
1157d7ef0: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7ef4: f941dd01    	ldr	x1, [x8, #0x3b8]
1157d7ef8: aa1503e0    	mov	x0, x21
1157d7efc: 945a1192    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7f00: aa1d03fd    	mov	x29, x29
1157d7f04: 945a11bd    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157d7f08: aa0003f6    	mov	x22, x0
1157d7f0c: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7f10: f941ed01    	ldr	x1, [x8, #0x3d8]
1157d7f14: aa1503e2    	mov	x2, x21
1157d7f18: aa1303e3    	mov	x3, x19
1157d7f1c: aa1403e4    	mov	x4, x20
1157d7f20: 945a1189    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7f24: aa1603e0    	mov	x0, x22
1157d7f28: 945a11a5    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7f2c: aa1303e0    	mov	x0, x19
1157d7f30: 945a11a3    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7f34: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1157d7f38: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1157d7f3c: a94257f6    	ldp	x22, x21, [sp, #0x20]
1157d7f40: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1157d7f44: 910143ff    	add	sp, sp, #0x50
1157d7f48: d65f03c0    	ret
