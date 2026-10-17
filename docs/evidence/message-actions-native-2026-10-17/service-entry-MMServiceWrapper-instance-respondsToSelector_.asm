
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175fc188: d00464c8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175fc18c: b987a508    	ldrsw	x8, [x8, #0x7a4]
1175fc190: f8686800    	ldr	x0, [x0, x8]
1175fc194: d0045848    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1175fc198: f9436101    	ldr	x1, [x8, #0x6c0] ; respondsToSelector:
1175fc19c: 1434b6d4    	b	0x118329cec <dyld_stub_binder+0x118329cec>