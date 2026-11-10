
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
11610d8c8: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
11610d8cc: a9017bfd    	stp	x29, x30, [sp, #0x10]
11610d8d0: 910043fd    	add	x29, sp, #0x10
11610d8d4: aa0003f3    	mov	x19, x0
11610d8d8: f0046948    	adrp	x8, 0x11ee38000 <dyld_stub_binder+0x11ee38000>
11610d8dc: b9848108    	ldrsw	x8, [x8, #0x480] ; ivar: OrderedDictionary.array offset=16
11610d8e0: f8686800    	ldr	x0, [x0, x8]
11610d8e4: 90045ce8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
11610d8e8: f9431501    	ldr	x1, [x8, #0x628] ; selector: objectEnumerator
11610d8ec: 94353b16    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11610d8f0: aa1d03fd    	mov	x29, x29
11610d8f4: 94353b41    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11610d8f8: aa0003f4    	mov	x20, x0
11610d8fc: f0045c88    	adrp	x8, 0x11eca0000 <dyld_stub_binder+0x11eca0000>
11610d900: f9453501    	ldr	x1, [x8, #0xa68] ; selector: allValuesForKeyEnumerator:
11610d904: aa1303e0    	mov	x0, x19
11610d908: aa1403e2    	mov	x2, x20
11610d90c: 94353b0e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11610d910: aa1d03fd    	mov	x29, x29
11610d914: 94353b39    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11610d918: aa0003f3    	mov	x19, x0
11610d91c: aa1403e0    	mov	x0, x20
11610d920: 94353b27    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11610d924: aa1303e0    	mov	x0, x19
11610d928: a9417bfd    	ldp	x29, x30, [sp, #0x10]
11610d92c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
11610d930: 14353ac0    	b	0x116e5c430 <dyld_stub_binder+0x116e5c430>
