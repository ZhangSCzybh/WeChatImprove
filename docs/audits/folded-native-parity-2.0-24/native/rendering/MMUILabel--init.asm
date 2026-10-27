
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1166bc6ac: d100c3ff    	sub	sp, sp, #0x30
1166bc6b0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1166bc6b4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1166bc6b8: 910083fd    	add	x29, sp, #0x20
1166bc6bc: d004d8e8    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
1166bc6c0: f944e908    	ldr	x8, [x8, #0x9d0] ; MMUILabel
1166bc6c4: a90023e0    	stp	x0, x8, [sp]
1166bc6c8: d004d228    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1166bc6cc: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1166bc6d0: 910003e0    	mov	x0, sp
1166bc6d4: 9471b589    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1166bc6d8: aa0003f3    	mov	x19, x0
1166bc6dc: b40003e0    	cbz	x0, 0x1166bc758 <_O266DecReleaseOutputPicture+0x342fca0>
1166bc6e0: f004d5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166bc6e4: f9463100    	ldr	x0, [x8, #0xc60]
1166bc6e8: f004d208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1166bc6ec: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
1166bc6f0: 9471b57f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc6f4: aa1d03fd    	mov	x29, x29
1166bc6f8: 9471b5a7    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166bc6fc: aa0003f4    	mov	x20, x0
1166bc700: f004d248    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1166bc704: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
1166bc708: aa1303e0    	mov	x0, x19
1166bc70c: aa1403e2    	mov	x2, x20
1166bc710: 9471b577    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc714: aa1403e0    	mov	x0, x20
1166bc718: 9471b590    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166bc71c: f004d5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1166bc720: f9462d00    	ldr	x0, [x8, #0xc58] ; WCColor
1166bc724: f004d228    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1166bc728: f9462901    	ldr	x1, [x8, #0xc50] ; labelColor
1166bc72c: 9471b570    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc730: aa1d03fd    	mov	x29, x29
1166bc734: 9471b598    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1166bc738: aa0003f4    	mov	x20, x0
1166bc73c: b004d268    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1166bc740: f9469501    	ldr	x1, [x8, #0xd28] ; setTextColor:
1166bc744: aa1303e0    	mov	x0, x19
1166bc748: aa1403e2    	mov	x2, x20
1166bc74c: 9471b568    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1166bc750: aa1403e0    	mov	x0, x20
1166bc754: 9471b581    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1166bc758: aa1303e0    	mov	x0, x19
1166bc75c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1166bc760: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1166bc764: 9100c3ff    	add	sp, sp, #0x30
1166bc768: d65f03c0    	ret
