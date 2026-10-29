
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1048c1858: d101c3ff    	sub	sp, sp, #0x70
1048c185c: a9035ff8    	stp	x24, x23, [sp, #0x30]
1048c1860: a90457f6    	stp	x22, x21, [sp, #0x40]
1048c1864: a9054ff4    	stp	x20, x19, [sp, #0x50]
1048c1868: a9067bfd    	stp	x29, x30, [sp, #0x60]
1048c186c: 910183fd    	add	x29, sp, #0x60
1048c1870: aa0203f3    	mov	x19, x2
1048c1874: aa0003f4    	mov	x20, x0
1048c1878: d00c6968    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1048c187c: f9405908    	ldr	x8, [x8, #0xb0]
1048c1880: f9400108    	ldr	x8, [x8]
1048c1884: f90017e8    	str	x8, [sp, #0x28]
1048c1888: 900e1be8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1048c188c: 52800029    	mov	w9, #0x1                ; =1
1048c1890: 3930e109    	strb	w9, [x8, #0xc38]
1048c1894: aa0203e0    	mov	x0, x2
1048c1898: 94cd9628    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1048c189c: 900dc228    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
1048c18a0: f9466101    	ldr	x1, [x8, #0xcc0] ; selector rangeOfString:
1048c18a4: b00cf602    	adrp	x2, 0x11e782000 <dyld_stub_binder+0x11e782000>
1048c18a8: 91312042    	add	x2, x2, #0xc48 ; CFString 'weixin://profile/'
1048c18ac: aa1303e0    	mov	x0, x19
1048c18b0: 94cd9623    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c18b4: b5000a80    	cbnz	x0, 0x1048c1a04 <_Flutter_MMFoundation_BindContext+0xd9d5e8>
1048c18b8: aa0103e2    	mov	x2, x1
1048c18bc: b00dc248    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1048c18c0: f9472d01    	ldr	x1, [x8, #0xe58] ; selector substringFromIndex:
1048c18c4: aa1303e0    	mov	x0, x19
1048c18c8: 94cd961d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c18cc: aa1d03fd    	mov	x29, x29
1048c18d0: 94cd961e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1048c18d4: aa0003f5    	mov	x21, x0
1048c18d8: f00dcae8    	adrp	x8, 0x120220000 <dyld_stub_binder+0x120220000>
1048c18dc: 913bb108    	add	x8, x8, #0xeec
1048c18e0: b9800108    	ldrsw	x8, [x8]
1048c18e4: f8686a80    	ldr	x0, [x20, x8]
1048c18e8: f00db5c8    	adrp	x8, 0x11ff7c000 <dyld_stub_binder+0x11ff7c000>
1048c18ec: f9472501    	ldr	x1, [x8, #0xe48] ; selector funcDefByName:
1048c18f0: d00cdf42    	adrp	x2, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
1048c18f4: 910aa042    	add	x2, x2, #0x2a8 ; CFString 'profile'
1048c18f8: 94cd9611    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c18fc: aa1d03fd    	mov	x29, x29
1048c1900: 94cd9612    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1048c1904: aa0003f6    	mov	x22, x0
1048c1908: f00db5c8    	adrp	x8, 0x11ff7c000 <dyld_stub_binder+0x11ff7c000>
1048c190c: f9472901    	ldr	x1, [x8, #0xe50] ; selector getJSApiPermission:
1048c1910: aa1403e0    	mov	x0, x20
1048c1914: aa1603e2    	mov	x2, x22
1048c1918: 94cd9609    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c191c: aa0003f7    	mov	x23, x0
1048c1920: aa1603e0    	mov	x0, x22
1048c1924: 94cd960c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1048c1928: 710006ff    	cmp	w23, #0x1
1048c192c: 54000681    	b.ne	0x1048c19fc <_Flutter_MMFoundation_BindContext+0xd9d5e0>
1048c1930: 900dc5a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1048c1934: f9441516    	ldr	x22, [x8, #0x828] ; class MMUIUtil
1048c1938: b00cdf48    	adrp	x8, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
1048c193c: 910b2108    	add	x8, x8, #0x2c8 ; CFString 'username'
1048c1940: d00cdec9    	adrp	x9, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1048c1944: 91032129    	add	x9, x9, #0xc8 ; CFString ''
1048c1948: f10002bf    	cmp	x21, #0x0
1048c194c: 9a950129    	csel	x9, x9, x21, eq
1048c1950: 900cdf4a    	adrp	x10, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
1048c1954: 9135214a    	add	x10, x10, #0xd48 ; CFString 'nickname'
1048c1958: a900abe8    	stp	x8, x10, [sp, #0x8]
1048c195c: a901a7e9    	stp	x9, x9, [sp, #0x18]
1048c1960: d00dc598    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
1048c1964: f9457700    	ldr	x0, [x24, #0xae8] ; class NSDictionary
1048c1968: 900dc208    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1048c196c: f9402901    	ldr	x1, [x8, #0x50] ; selector dictionaryWithObjects:forKeys:count:
1048c1970: 910063e2    	add	x2, sp, #0x18
1048c1974: 910023e3    	add	x3, sp, #0x8
1048c1978: 52800044    	mov	w4, #0x2                ; =2
1048c197c: 94cd95f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c1980: aa1d03fd    	mov	x29, x29
1048c1984: 94cd95f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1048c1988: aa0003f7    	mov	x23, x0
1048c198c: 900dac48    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
1048c1990: f9428901    	ldr	x1, [x8, #0x510] ; selector headImageJumpToProfile:withViewController:Scence:
1048c1994: aa1603e0    	mov	x0, x22
1048c1998: aa1703e2    	mov	x2, x23
1048c199c: aa1403e3    	mov	x3, x20
1048c19a0: 52800544    	mov	w4, #0x2a               ; =42
1048c19a4: 94cd95e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c19a8: aa1703e0    	mov	x0, x23
1048c19ac: 94cd95ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1048c19b0: f9457700    	ldr	x0, [x24, #0xae8] ; class NSDictionary
1048c19b4: 900dc208    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1048c19b8: f9402101    	ldr	x1, [x8, #0x40] ; selector dictionaryWithObject:forKey:
1048c19bc: 900cf5e3    	adrp	x3, 0x11e77d000 <dyld_stub_binder+0x11e77d000>
1048c19c0: 91152063    	add	x3, x3, #0x548 ; CFString 'keyParam'
1048c19c4: aa1503e2    	mov	x2, x21
1048c19c8: 94cd95dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c19cc: aa1d03fd    	mov	x29, x29
1048c19d0: 94cd95de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1048c19d4: aa0003f6    	mov	x22, x0
1048c19d8: b00db468    	adrp	x8, 0x11ff4e000 <dyld_stub_binder+0x11ff4e000>
1048c19dc: f9412501    	ldr	x1, [x8, #0x248] ; selector kvReportJSCall:withParam:
1048c19e0: d00cdf42    	adrp	x2, 0x11e4ab000 <dyld_stub_binder+0x11e4ab000>
1048c19e4: 910aa042    	add	x2, x2, #0x2a8 ; CFString 'profile'
1048c19e8: aa1403e0    	mov	x0, x20
1048c19ec: aa1603e3    	mov	x3, x22
1048c19f0: 94cd95d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c19f4: aa1603e0    	mov	x0, x22
1048c19f8: 94cd95d7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1048c19fc: aa1503e0    	mov	x0, x21
1048c1a00: 94cd95d5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1048c1a04: aa1303e0    	mov	x0, x19
1048c1a08: 94cd95d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1048c1a0c: f94017e8    	ldr	x8, [sp, #0x28]
1048c1a10: d00c6969    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1048c1a14: f9405929    	ldr	x9, [x9, #0xb0]
1048c1a18: f9400129    	ldr	x9, [x9]
1048c1a1c: eb08013f    	cmp	x9, x8
1048c1a20: 540000e1    	b.ne	0x1048c1a3c <_Flutter_MMFoundation_BindContext+0xd9d620>
1048c1a24: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1048c1a28: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1048c1a2c: a94457f6    	ldp	x22, x21, [sp, #0x40]
1048c1a30: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1048c1a34: 9101c3ff    	add	sp, sp, #0x70
1048c1a38: d65f03c0    	ret
1048c1a3c: 94cd95ce    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
