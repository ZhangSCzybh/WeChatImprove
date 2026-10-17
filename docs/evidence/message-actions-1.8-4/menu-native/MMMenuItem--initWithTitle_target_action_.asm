
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167a519c: d10103ff    	sub	sp, sp, #0x40
1167a51a0: a90157f6    	stp	x22, x21, [sp, #0x10]
1167a51a4: a9024ff4    	stp	x20, x19, [sp, #0x20]
1167a51a8: a9037bfd    	stp	x29, x30, [sp, #0x30]
1167a51ac: 9100c3fd    	add	x29, sp, #0x30
1167a51b0: aa0403f5    	mov	x21, x4
1167a51b4: aa0303f4    	mov	x20, x3
1167a51b8: aa0203f3    	mov	x19, x2
1167a51bc: aa0003f6    	mov	x22, x0
1167a51c0: aa0203e0    	mov	x0, x2
1167a51c4: 946e12eb    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167a51c8: aa1403e0    	mov	x0, x20
1167a51cc: 946e12e9    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167a51d0: b004d1a8    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1167a51d4: f946e908    	ldr	x8, [x8, #0xdd0]
1167a51d8: a90023f6    	stp	x22, x8, [sp]
1167a51dc: b004cae8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1167a51e0: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1167a51e4: 910003e0    	mov	x0, sp
1167a51e8: 946e12c4    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1167a51ec: aa0003f6    	mov	x22, x0
1167a51f0: b4000200    	cbz	x0, 0x1167a5230 <_O266DecReleaseOutputPicture+0x3518778>
1167a51f4: 9004cb28    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1167a51f8: f9472101    	ldr	x1, [x8, #0xe40] ; setTitle:
1167a51fc: aa1603e0    	mov	x0, x22
1167a5200: aa1303e2    	mov	x2, x19
1167a5204: 946e12ba    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167a5208: 9004cb28    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1167a520c: f9467501    	ldr	x1, [x8, #0xce8] ; setTarget:
1167a5210: aa1603e0    	mov	x0, x22
1167a5214: aa1403e2    	mov	x2, x20
1167a5218: 946e12b5    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167a521c: f004b4c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1167a5220: f9459d01    	ldr	x1, [x8, #0xb38] ; setAction:
1167a5224: aa1603e0    	mov	x0, x22
1167a5228: aa1503e2    	mov	x2, x21
1167a522c: 946e12b0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167a5230: aa1403e0    	mov	x0, x20
1167a5234: 946e12c9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167a5238: aa1303e0    	mov	x0, x19
1167a523c: 946e12c7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167a5240: aa1603e0    	mov	x0, x22
1167a5244: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1167a5248: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1167a524c: a94157f6    	ldp	x22, x21, [sp, #0x10]
1167a5250: 910103ff    	add	sp, sp, #0x40
1167a5254: d65f03c0    	ret