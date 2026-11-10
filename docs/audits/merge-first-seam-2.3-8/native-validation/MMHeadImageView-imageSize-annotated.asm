
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
103dd954c: f00d7ec8    	adrp	x8, 0x11edb4000 <dyld_stub_binder+0x11edb4000>
103dd9550: b98f7508    	ldrsw	x8, [x8, #0xf74] ; ivar: MMHeadImageView._imageSize offset=160
103dd9554: 8b080008    	add	x8, x0, x8
103dd9558: 6d400500    	ldp	d0, d1, [x8]
103dd955c: d65f03c0    	ret
