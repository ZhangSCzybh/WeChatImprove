
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10565bed4: b00cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565bed8: b9880508    	ldrsw	x8, [x8, #0x804]
10565bedc: 38686808    	ldrb	w8, [x0, x8]
10565bee0: 7100051f    	cmp	w8, #0x1
10565bee4: 540000a1    	b.ne	0x10565bef8 <_Flutter_MMFoundation_BindContext+0x18e2bc4>
10565bee8: b00cbb88    	adrp	x8, 0x11edcc000 <dyld_stub_binder+0x11edcc000>
10565beec: b9880908    	ldrsw	x8, [x8, #0x808]
10565bef0: f8686800    	ldr	x0, [x0, x8]
10565bef4: 14972f62    	b	0x107c27c7c <_Flutter_MMFoundation_BindContext+0x3eae948>
10565bef8: d2800000    	mov	x0, #0x0                ; =0
10565befc: 14972f60    	b	0x107c27c7c <_Flutter_MMFoundation_BindContext+0x3eae948>
