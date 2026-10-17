
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1165e0e4c: d10103ff    	sub	sp, sp, #0x40
1165e0e50: a90157f6    	stp	x22, x21, [sp, #0x10]
1165e0e54: a9024ff4    	stp	x20, x19, [sp, #0x20]
1165e0e58: a9037bfd    	stp	x29, x30, [sp, #0x30]
1165e0e5c: 9100c3fd    	add	x29, sp, #0x30
1165e0e60: aa0203f3    	mov	x19, x2
1165e0e64: aa0003f4    	mov	x20, x0
1165e0e68: f0038068    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1165e0e6c: f9405908    	ldr	x8, [x8, #0xb0]
1165e0e70: f9400108    	ldr	x8, [x8]
1165e0e74: f90007e8    	str	x8, [sp, #0x8]
1165e0e78: b4000322    	cbz	x2, 0x1165e0edc <_O266DecReleaseOutputPicture+0x3354424>
1165e0e7c: f90003f3    	str	x19, [sp]
1165e0e80: f004dc88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1165e0e84: f9456d15    	ldr	x21, [x8, #0xad8]
1165e0e88: f004d8e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1165e0e8c: f941c516    	ldr	x22, [x8, #0x388] ; arrayWithObjects:count:
1165e0e90: aa1303e0    	mov	x0, x19
1165e0e94: 947523b7    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e0e98: 910003e2    	mov	x2, sp
1165e0e9c: aa1503e0    	mov	x0, x21
1165e0ea0: aa1603e1    	mov	x1, x22
1165e0ea4: 52800023    	mov	w3, #0x1                ; =1
1165e0ea8: 94752391    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e0eac: aa1d03fd    	mov	x29, x29
1165e0eb0: 947523b9    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1165e0eb4: aa0003f5    	mov	x21, x0
1165e0eb8: d004c408    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
1165e0ebc: f9467d01    	ldr	x1, [x8, #0xcf8] ; setMenuItemRows:
1165e0ec0: aa1403e0    	mov	x0, x20
1165e0ec4: aa1503e2    	mov	x2, x21
1165e0ec8: 94752389    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1165e0ecc: aa1303e0    	mov	x0, x19
1165e0ed0: 947523a2    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e0ed4: aa1503f3    	mov	x19, x21
1165e0ed8: 14000009    	b	0x1165e0efc <_O266DecReleaseOutputPicture+0x3354444>
1165e0edc: f004e568    	adrp	x8, 0x12028f000 <dyld_stub_binder+0x12028f000>
1165e0ee0: b98aa108    	ldrsw	x8, [x8, #0xaa0]
1165e0ee4: f8686a95    	ldr	x21, [x20, x8]
1165e0ee8: f8286a9f    	str	xzr, [x20, x8]
1165e0eec: aa1303e0    	mov	x0, x19
1165e0ef0: 947523a0    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1165e0ef4: aa1503e0    	mov	x0, x21
1165e0ef8: 94752398    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e0efc: aa1303e0    	mov	x0, x19
1165e0f00: 94752396    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1165e0f04: f94007e8    	ldr	x8, [sp, #0x8]
1165e0f08: f0038069    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1165e0f0c: f9405929    	ldr	x9, [x9, #0xb0]
1165e0f10: f9400129    	ldr	x9, [x9]
1165e0f14: eb08013f    	cmp	x9, x8
1165e0f18: 540000c1    	b.ne	0x1165e0f30 <_O266DecReleaseOutputPicture+0x3354478>
1165e0f1c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1165e0f20: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1165e0f24: a94157f6    	ldp	x22, x21, [sp, #0x10]
1165e0f28: 910103ff    	add	sp, sp, #0x40
1165e0f2c: d65f03c0    	ret
1165e0f30: 94751673    	bl	0x1183268fc <dyld_stub_binder+0x1183268fc>