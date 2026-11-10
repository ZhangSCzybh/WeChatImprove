
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002abf8c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1002abf90: a9017bfd    	stp	x29, x30, [sp, #0x10]
1002abf94: 910043fd    	add	x29, sp, #0x10
1002abf98: aa0003f3    	mov	x19, x0
1002abf9c: d00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002abfa0: f9409d01    	ldr	x1, [x8, #0x138]
1002abfa4: 95e5ef30    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abfa8: 34000300    	cbz	w0, 0x1002ac008 <__text+0x2a4008>
1002abfac: fd400a60    	ldr	d0, [x19, #0x10]
1002abfb0: 1e602008    	fcmp	d0, #0.0
1002abfb4: 540000a0    	b.eq	0x1002abfc8 <__text+0x2a3fc8>
1002abfb8: d00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002abfbc: f9436d01    	ldr	x1, [x8, #0x6d8]
1002abfc0: aa1303e0    	mov	x0, x19
1002abfc4: 95e5ef28    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abfc8: f00ea4e8    	adrp	x8, 0x11d74a000 <dyld_stub_binder+0x11d74a000>
1002abfcc: f9466108    	ldr	x8, [x8, #0xcc0]
1002abfd0: 6d400500    	ldp	d0, d1, [x8]
1002abfd4: d00f3928    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1002abfd8: f944d501    	ldr	x1, [x8, #0x9a8]
1002abfdc: aa1303e0    	mov	x0, x19
1002abfe0: 95e5ef21    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002abfe4: 1e64c020    	frintp	d0, d1
1002abfe8: fd000e60    	str	d0, [x19, #0x18]
1002abfec: f00f5328    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002abff0: f944d900    	ldr	x0, [x8, #0x9b0]
1002abff4: d00f3908    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1002abff8: f946f501    	ldr	x1, [x8, #0xde8]
1002abffc: aa1303e2    	mov	x2, x19
1002ac000: 95e5ef19    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002ac004: fd000a60    	str	d0, [x19, #0x10]
1002ac008: fd400e60    	ldr	d0, [x19, #0x18]
1002ac00c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1002ac010: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1002ac014: d65f03c0    	ret
