
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157d7d6c: d10143ff    	sub	sp, sp, #0x50
1157d7d70: a9015ff8    	stp	x24, x23, [sp, #0x10]
1157d7d74: a90257f6    	stp	x22, x21, [sp, #0x20]
1157d7d78: a9034ff4    	stp	x20, x19, [sp, #0x30]
1157d7d7c: a9047bfd    	stp	x29, x30, [sp, #0x40]
1157d7d80: 910103fd    	add	x29, sp, #0x40
1157d7d84: aa0403f4    	mov	x20, x4
1157d7d88: aa0303f3    	mov	x19, x3
1157d7d8c: aa0203f6    	mov	x22, x2
1157d7d90: aa0003f5    	mov	x21, x0
1157d7d94: aa0303e0    	mov	x0, x3
1157d7d98: 945a120f    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157d7d9c: f004ad08    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
1157d7da0: f940e508    	ldr	x8, [x8, #0x1c8]
1157d7da4: a90023f5    	stp	x21, x8, [sp]
1157d7da8: d0049e88    	adrp	x8, 0x11eba9000 <dyld_stub_binder+0x11eba9000>
1157d7dac: f9422517    	ldr	x23, [x8, #0x448]
1157d7db0: aa1603e0    	mov	x0, x22
1157d7db4: 945a1208    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157d7db8: 910003e0    	mov	x0, sp
1157d7dbc: aa1703e1    	mov	x1, x23
1157d7dc0: aa1603e2    	mov	x2, x22
1157d7dc4: aa1303e3    	mov	x3, x19
1157d7dc8: aa1403e4    	mov	x4, x20
1157d7dcc: 945a11e1    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
1157d7dd0: aa1603e0    	mov	x0, x22
1157d7dd4: 945a11fa    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7dd8: eb1502df    	cmp	x22, x21
1157d7ddc: 54000361    	b.ne	0x1157d7e48 <_O266DecReleaseOutputPicture+0x36c88dc>
1157d7de0: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7de4: f941d501    	ldr	x1, [x8, #0x3a8]
1157d7de8: aa1503e0    	mov	x0, x21
1157d7dec: 945a11d6    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7df0: 340002c0    	cbz	w0, 0x1157d7e48 <_O266DecReleaseOutputPicture+0x36c88dc>
1157d7df4: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7df8: f941e501    	ldr	x1, [x8, #0x3c8]
1157d7dfc: aa1503e0    	mov	x0, x21
1157d7e00: aa1303e2    	mov	x2, x19
1157d7e04: aa1403e3    	mov	x3, x20
1157d7e08: 945a11cf    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7e0c: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7e10: f941dd01    	ldr	x1, [x8, #0x3b8]
1157d7e14: aa1503e0    	mov	x0, x21
1157d7e18: 945a11cb    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7e1c: aa1d03fd    	mov	x29, x29
1157d7e20: 945a11f6    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157d7e24: aa0003f6    	mov	x22, x0
1157d7e28: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7e2c: f941e901    	ldr	x1, [x8, #0x3d0]
1157d7e30: aa1503e2    	mov	x2, x21
1157d7e34: aa1303e3    	mov	x3, x19
1157d7e38: aa1403e4    	mov	x4, x20
1157d7e3c: 945a11c2    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7e40: aa1603e0    	mov	x0, x22
1157d7e44: 945a11de    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7e48: aa1303e0    	mov	x0, x19
1157d7e4c: 945a11dc    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7e50: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1157d7e54: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1157d7e58: a94257f6    	ldp	x22, x21, [sp, #0x20]
1157d7e5c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1157d7e60: 910143ff    	add	sp, sp, #0x50
1157d7e64: d65f03c0    	ret
