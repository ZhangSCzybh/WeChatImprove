
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167a4d08: d10143ff    	sub	sp, sp, #0x50
1167a4d0c: a9015ff8    	stp	x24, x23, [sp, #0x10]
1167a4d10: a90257f6    	stp	x22, x21, [sp, #0x20]
1167a4d14: a9034ff4    	stp	x20, x19, [sp, #0x30]
1167a4d18: a9047bfd    	stp	x29, x30, [sp, #0x40]
1167a4d1c: 910103fd    	add	x29, sp, #0x40
1167a4d20: aa0503f6    	mov	x22, x5
1167a4d24: aa0403f5    	mov	x21, x4
1167a4d28: aa0303f4    	mov	x20, x3
1167a4d2c: aa0203f3    	mov	x19, x2
1167a4d30: aa0003f7    	mov	x23, x0
1167a4d34: aa0203e0    	mov	x0, x2
1167a4d38: 946e140e    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167a4d3c: aa1403e0    	mov	x0, x20
1167a4d40: 946e140c    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167a4d44: aa1503e0    	mov	x0, x21
1167a4d48: 946e140a    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167a4d4c: d004d1a8    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1167a4d50: f946e908    	ldr	x8, [x8, #0xdd0]
1167a4d54: a90023f7    	stp	x23, x8, [sp]
1167a4d58: d004cae8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1167a4d5c: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1167a4d60: 910003e0    	mov	x0, sp
1167a4d64: 946e13e5    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1167a4d68: aa0003f7    	mov	x23, x0
1167a4d6c: b40002a0    	cbz	x0, 0x1167a4dc0 <_O266DecReleaseOutputPicture+0x3518308>
1167a4d70: b004cb28    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1167a4d74: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
1167a4d78: aa1703e0    	mov	x0, x23
1167a4d7c: aa1303e2    	mov	x2, x19
1167a4d80: 946e13db    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167a4d84: b004d768    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167a4d88: b98db108    	ldrsw	x8, [x8, #0xdb0]
1167a4d8c: 8b0802e0    	add	x0, x23, x8
1167a4d90: aa1403e1    	mov	x1, x20
1167a4d94: 946e1418    	bl	0x118329df4 <dyld_stub_binder+0x118329df4>
1167a4d98: b004d768    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167a4d9c: b98db508    	ldrsw	x8, [x8, #0xdb4]
1167a4da0: 8b0802e0    	add	x0, x23, x8
1167a4da4: aa1503e1    	mov	x1, x21
1167a4da8: 946e1416    	bl	0x118329e00 <dyld_stub_binder+0x118329e00>
1167a4dac: 9004b4e8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1167a4db0: f9459d01    	ldr	x1, [x8, #0xb38] ; setAction:
1167a4db4: aa1703e0    	mov	x0, x23
1167a4db8: aa1603e2    	mov	x2, x22
1167a4dbc: 946e13cc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167a4dc0: aa1503e0    	mov	x0, x21
1167a4dc4: 946e13e5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167a4dc8: aa1403e0    	mov	x0, x20
1167a4dcc: 946e13e3    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167a4dd0: aa1303e0    	mov	x0, x19
1167a4dd4: 946e13e1    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167a4dd8: aa1703e0    	mov	x0, x23
1167a4ddc: a9447bfd    	ldp	x29, x30, [sp, #0x40]
1167a4de0: a9434ff4    	ldp	x20, x19, [sp, #0x30]
1167a4de4: a94257f6    	ldp	x22, x21, [sp, #0x20]
1167a4de8: a9415ff8    	ldp	x24, x23, [sp, #0x10]
1167a4dec: 910143ff    	add	sp, sp, #0x50
1167a4df0: d65f03c0    	ret