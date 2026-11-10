
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a9290: fd401400    	ldr	d0, [x0, #0x28]
1002a9294: 1e602008    	fcmp	d0, #0.0
1002a9298: 54000081    	b.ne	0x1002a92a8 <__text+0x2a12a8>
1002a929c: d2e7fe08    	mov	x8, #0x3ff0000000000000 ; =4607182418800017408
1002a92a0: f9001408    	str	x8, [x0, #0x28]
1002a92a4: 1e6e1000    	fmov	d0, #1.00000000
1002a92a8: d65f03c0    	ret
