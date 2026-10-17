
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175c5558: 9004e709    	adrp	x9, 0x1212a5000 <dyld_stub_binder+0x1212a5000>
1175c555c: f9442129    	ldr	x9, [x9, #0x840]
1175c5560: b4000049    	cbz	x9, 0x1175c5568 <_O266DecReleaseOutputPicture+0x4338ab0>
1175c5564: d61f0120    	br	x9
1175c5568: 9004e708    	adrp	x8, 0x1212a5000 <dyld_stub_binder+0x1212a5000>
1175c556c: f9441900    	ldr	x0, [x8, #0x830]
1175c5570: 1435931d    	b	0x11832a1e4 <dyld_stub_binder+0x11832a1e4>
