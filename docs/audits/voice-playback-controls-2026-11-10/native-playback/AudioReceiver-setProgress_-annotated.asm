
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1001772f4: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
1001772f8: b98b0108    	ldrsw	x8, [x8, #0xb00] ; ivar: AudioReceiver.m_audioPlayer offset=8
1001772fc: f8686800    	ldr	x0, [x0, x8]
100177300: b00f59a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
100177304: f9428901    	ldr	x1, [x8, #0x510] ; selector: setProgress:
100177308: 15eac257    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
