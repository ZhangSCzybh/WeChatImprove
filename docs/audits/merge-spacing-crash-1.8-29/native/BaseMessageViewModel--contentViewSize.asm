
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002b1b00: d00ff968    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
1002b1b04: b982dd08    	ldrsw	x8, [x8, #0x2dc]
1002b1b08: 8b080008    	add	x8, x0, x8
1002b1b0c: 6d400500    	ldp	d0, d1, [x8]
1002b1b10: d65f03c0    	ret