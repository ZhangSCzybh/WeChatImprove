
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105592ec0: 900cbf68    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105592ec4: 912ab108    	add	x8, x8, #0xaac
105592ec8: b9800108    	ldrsw	x8, [x8]
105592ecc: f8686808    	ldr	x8, [x0, x8]
105592ed0: 3941b508    	ldrb	w8, [x8, #0x6d]
105592ed4: 34000088    	cbz	w8, 0x105592ee4 <_Flutter_MMFoundation_BindContext+0x1819bb0>
105592ed8: 900cad68    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105592edc: f9444d01    	ldr	x1, [x8, #0x898]
105592ee0: 149a5361    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592ee4: d65f03c0    	ret
