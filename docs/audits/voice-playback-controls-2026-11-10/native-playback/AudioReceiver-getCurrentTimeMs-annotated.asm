
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1001772dc: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
1001772e0: b98b0108    	ldrsw	x8, [x8, #0xb00] ; ivar: AudioReceiver.m_audioPlayer offset=8
1001772e4: f8686800    	ldr	x0, [x0, x8]
1001772e8: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1001772ec: f9452d01    	ldr	x1, [x8, #0xa58] ; selector: getCurrentTimeMs
1001772f0: 15eac25d    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
