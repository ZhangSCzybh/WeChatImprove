
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102039cc4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
102039cc8: a9014ff4    	stp	x20, x19, [sp, #0x10]
102039ccc: a9027bfd    	stp	x29, x30, [sp, #0x20]
102039cd0: 910083fd    	add	x29, sp, #0x20
102039cd4: aa0203f3    	mov	x19, x2
102039cd8: aa0203e0    	mov	x0, x2
102039cdc: 956fb7e6    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102039ce0: f00e4e68    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
102039ce4: f943e914    	ldr	x20, [x8, #0x7d0] ; selector: m_nsChatRoomMemList
102039ce8: aa1303e0    	mov	x0, x19
102039cec: aa1403e1    	mov	x1, x20
102039cf0: 956fb7dd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039cf4: aa1d03fd    	mov	x29, x29
102039cf8: 956fb7e2    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039cfc: aa0003f5    	mov	x21, x0
102039d00: f00e6368    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
102039d04: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
102039d08: 956fb7d7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039d0c: aa0003f6    	mov	x22, x0
102039d10: aa1503e0    	mov	x0, x21
102039d14: 956fb7d7    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039d18: b4000256    	cbz	x22, 0x102039d60 <_Flutter_Image_provideRelativePathByUrl+0x2c21ec>
102039d1c: aa1303e0    	mov	x0, x19
102039d20: aa1403e1    	mov	x1, x20
102039d24: 956fb7d0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039d28: aa1d03fd    	mov	x29, x29
102039d2c: 956fb7d5    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039d30: aa0003f5    	mov	x21, x0
102039d34: b00e6368    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
102039d38: f9433d01    	ldr	x1, [x8, #0x678] ; selector: componentsSeparatedByString:
102039d3c: d00d7b42    	adrp	x2, 0x11cfa3000 <dyld_stub_binder+0x11cfa3000>
102039d40: 913be042    	add	x2, x2, #0xef8 ; CFString: ;
102039d44: 956fb7c8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102039d48: aa1d03fd    	mov	x29, x29
102039d4c: 956fb7cd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
102039d50: aa0003f4    	mov	x20, x0
102039d54: aa1503e0    	mov	x0, x21
102039d58: 956fb7c6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039d5c: 14000002    	b	0x102039d64 <_Flutter_Image_provideRelativePathByUrl+0x2c21f0>
102039d60: d2800014    	mov	x20, #0x0               ; =0
102039d64: aa1303e0    	mov	x0, x19
102039d68: 956fb7c2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102039d6c: aa1403e0    	mov	x0, x20
102039d70: a9427bfd    	ldp	x29, x30, [sp, #0x20]
102039d74: a9414ff4    	ldp	x20, x19, [sp, #0x10]
102039d78: a8c357f6    	ldp	x22, x21, [sp], #0x30
102039d7c: 156fb7a9    	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
