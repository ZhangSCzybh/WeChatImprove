
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
103dd8100: 900d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd8104: b98f7908    	ldrsw	x8, [x8, #0xf78]
103dd8108: 38286802    	strb	w2, [x0, x8]
103dd810c: 900d7ee8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd8110: b98f8908    	ldrsw	x8, [x8, #0xf88]
103dd8114: f8686800    	ldr	x0, [x0, x8]
103dd8118: f00d7688    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
103dd811c: f9458d01    	ldr	x1, [x8, #0xb18]
103dd8120: 52000042    	eor	w2, w2, #0x1
103dd8124: 14f93ed0    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
