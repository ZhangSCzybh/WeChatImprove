
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1048c1828: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
1048c182c: 910003fd    	mov	x29, sp
1048c1830: aa0203e0    	mov	x0, x2
1048c1834: 900dc228    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
1048c1838: f9466101    	ldr	x1, [x8, #0xcc0] ; selector rangeOfString:
1048c183c: b00cf602    	adrp	x2, 0x11e782000 <dyld_stub_binder+0x11e782000>
1048c1840: 91312042    	add	x2, x2, #0xc48 ; CFString 'weixin://profile/'
1048c1844: 94cd963e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1048c1848: f100001f    	cmp	x0, #0x0
1048c184c: 1a9f17e0    	cset	w0, eq
1048c1850: a8c17bfd    	ldp	x29, x30, [sp], #0x10
1048c1854: d65f03c0    	ret
