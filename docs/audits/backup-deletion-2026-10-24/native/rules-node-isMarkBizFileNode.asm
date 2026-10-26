
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10299d500: f9401408    	ldr	x8, [x0, #0x28]
10299d504: f100051f    	cmp	x8, #0x1
10299d508: 5400010b    	b.lt	0x10299d528 <_Flutter_Image_provideRelativePathByUrl+0xdaa3d8>
10299d50c: b9400c08    	ldr	w8, [x0, #0xc]
10299d510: 7100051f    	cmp	w8, #0x1
10299d514: 540000ab    	b.lt	0x10299d528 <_Flutter_Image_provideRelativePathByUrl+0xdaa3d8>
10299d518: b9400808    	ldr	w8, [x0, #0x8]
10299d51c: 321f77e9    	mov	w9, #0x7ffffffe         ; =2147483646
10299d520: 6b09011f    	cmp	w8, w9
10299d524: 54000061    	b.ne	0x10299d530 <_Flutter_Image_provideRelativePathByUrl+0xdaa3e0>
10299d528: 52800000    	mov	w0, #0x0                ; =0
10299d52c: d65f03c0    	ret
10299d530: 52800020    	mov	w0, #0x1                ; =1
10299d534: d65f03c0    	ret
