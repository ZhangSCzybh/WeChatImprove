
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1166bc76c: d100c3ff    	sub	sp, sp, #0x30
1166bc770: a9014ff4    	stp	x20, x19, [sp, #0x10]
1166bc774: a9027bfd    	stp	x29, x30, [sp, #0x20]
1166bc778: 910083fd    	add	x29, sp, #0x20
1166bc77c: d004d8e8    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1166bc780: f944e908    	ldr	x8, [x8, #0x9d0] ; MMUILabel
1166bc784: a90023e0    	stp	x0, x8, [sp]
1166bc788: d004d228    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1166bc78c: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
1166bc790: 910003e0    	mov	x0, sp
1166bc794: 9471b559    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1166bc798: aa0003f3    	mov	x19, x0
1166bc79c: b40003e0    	cbz	x0, 0x1166bc818 <_O266DecReleaseOutputPicture+0x342fd60>
1166bc7a0: f004d5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166bc7a4: f9463100    	ldr	x0, [x8, #0xc60]
1166bc7a8: f004d208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1166bc7ac: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
1166bc7b0: 9471b54f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc7b4: aa1d03fd    	mov	x29, x29
1166bc7b8: 9471b577    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166bc7bc: aa0003f4    	mov	x20, x0
1166bc7c0: f004d248    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1166bc7c4: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
1166bc7c8: aa1303e0    	mov	x0, x19
1166bc7cc: aa1403e2    	mov	x2, x20
1166bc7d0: 9471b547    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc7d4: aa1403e0    	mov	x0, x20
1166bc7d8: 9471b560    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166bc7dc: f004d5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166bc7e0: f9462d00    	ldr	x0, [x8, #0xc58] ; WCColor
1166bc7e4: f004d228    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1166bc7e8: f9462901    	ldr	x1, [x8, #0xc50] ; labelColor
1166bc7ec: 9471b540    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc7f0: aa1d03fd    	mov	x29, x29
1166bc7f4: 9471b568    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166bc7f8: aa0003f4    	mov	x20, x0
1166bc7fc: b004d268    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1166bc800: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
1166bc804: aa1303e0    	mov	x0, x19
1166bc808: aa1403e2    	mov	x2, x20
1166bc80c: 9471b538    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc810: aa1403e0    	mov	x0, x20
1166bc814: 9471b551    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166bc818: aa1303e0    	mov	x0, x19
1166bc81c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1166bc820: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1166bc824: 9100c3ff    	add	sp, sp, #0x30
1166bc828: d65f03c0    	ret
