
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a76808: b00e98e8    	adrp	x8, 0x11ed93000 <dyld_stub_binder+0x11ed93000>
101a7680c: b982b508    	ldrsw	x8, [x8, #0x2b4] ; ivar: FavDataItemWrap.m_dataItem offset=8
101a76810: f8686800    	ldr	x0, [x0, x8]
101a76814: d65f03c0    	ret
