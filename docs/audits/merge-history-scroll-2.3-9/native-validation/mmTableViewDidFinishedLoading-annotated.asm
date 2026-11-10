
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1003353cc: d10083ff    	sub	sp, sp, #0x20
1003353d0: a9017bfd    	stp	x29, x30, [sp, #0x10]
1003353d4: 910043fd    	add	x29, sp, #0x10
1003353d8: b00f4ee8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1003353dc: f9430d00    	ldr	x0, [x8, #0x618]
1003353e0: 900f34a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1003353e4: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1003353e8: d00e6468    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
1003353ec: 9131e108    	add	x8, x8, #0xc78 ; CFString: didFinishedLoading
1003353f0: f90003e8    	str	x8, [sp]
1003353f4: f00cc485    	adrp	x5, 0x119bc8000 <dyld_stub_binder+0x119bc8000>
1003353f8: 9100f4a5    	add	x5, x5, #0x3d
1003353fc: b00cc4a7    	adrp	x7, 0x119bca000 <dyld_stub_binder+0x119bca000>
100335400: 912ff8e7    	add	x7, x7, #0xbfe
100335404: 52800042    	mov	w2, #0x2                ; =2
100335408: d2800003    	mov	x3, #0x0                ; =0
10033540c: 52800004    	mov	w4, #0x0                ; =0
100335410: 5283fb86    	mov	w6, #0x1fdc             ; =8156
100335414: 95e3ca14    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100335418: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10033541c: 910083ff    	add	sp, sp, #0x20
100335420: d65f03c0    	ret
