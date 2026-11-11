
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100c77820: d10203ff    	sub	sp, sp, #0x80
100c77824: a9045ff8    	stp	x24, x23, [sp, #0x40]
100c77828: a90557f6    	stp	x22, x21, [sp, #0x50]
100c7782c: a9064ff4    	stp	x20, x19, [sp, #0x60]
100c77830: a9077bfd    	stp	x29, x30, [sp, #0x70]
100c77834: 9101c3fd    	add	x29, sp, #0x70
100c77838: aa0403f5    	mov	x21, x4
100c7783c: aa0303f3    	mov	x19, x3
100c77840: aa0203f4    	mov	x20, x2
100c77844: aa0003f7    	mov	x23, x0
100c77848: f00f5648    	adrp	x8, 0x11f742000 <dyld_stub_binder+0x11f742000>
100c7784c: 52800029    	mov	w9, #0x1                ; =1
100c77850: 39333109    	strb	w9, [x8, #0xccc]
100c77854: aa0203e0    	mov	x0, x2
100c77858: 95bec107    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c7785c: aa1303e0    	mov	x0, x19
100c77860: 95bec105    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c77864: aa1503e0    	mov	x0, x21
100c77868: 95bec103    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c7786c: 900eeaa8    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100c77870: f9431101    	ldr	x1, [x8, #0x620]
100c77874: aa1403e0    	mov	x0, x20
100c77878: 95bec0fb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c7787c: aa1d03fd    	mov	x29, x29
100c77880: 95bec100    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100c77884: aa0003f6    	mov	x22, x0
100c77888: b00e56a8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100c7788c: f9449908    	ldr	x8, [x8, #0x930]
100c77890: f90007e8    	str	x8, [sp, #0x8]
100c77894: 900b6288    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100c77898: fd434100    	ldr	d0, [x8, #0x680]
100c7789c: fd000be0    	str	d0, [sp, #0x10]
100c778a0: 90000008    	adrp	x8, 0x100c77000 <__text+0xc6f000>
100c778a4: 91254108    	add	x8, x8, #0x950
100c778a8: 900db0e9    	adrp	x9, 0x11c293000 <dyld_stub_binder+0x11c293000>
100c778ac: 91300129    	add	x9, x9, #0xc00
100c778b0: a901a7e8    	stp	x8, x9, [sp, #0x18]
100c778b4: a902d3f3    	stp	x19, x20, [sp, #0x28]
100c778b8: f9001ff5    	str	x21, [sp, #0x38]
100c778bc: b00eec88    	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
100c778c0: f9462918    	ldr	x24, [x8, #0xc50]
100c778c4: aa1503e0    	mov	x0, x21
100c778c8: 95bec0eb    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c778cc: aa1403e0    	mov	x0, x20
100c778d0: 95bec0e9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c778d4: aa1303e0    	mov	x0, x19
100c778d8: 95bec0e7    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100c778dc: f00e1d43    	adrp	x3, 0x11d022000 <dyld_stub_binder+0x11d022000>
100c778e0: 911be063    	add	x3, x3, #0x6f8
100c778e4: 910023e4    	add	x4, sp, #0x8
100c778e8: aa1703e0    	mov	x0, x23
100c778ec: aa1803e1    	mov	x1, x24
100c778f0: aa1603e2    	mov	x2, x22
100c778f4: 95bec0dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100c778f8: aa0003f7    	mov	x23, x0
100c778fc: f9401fe0    	ldr	x0, [sp, #0x38]
100c77900: 95bec0dc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77904: f9401be0    	ldr	x0, [sp, #0x30]
100c77908: 95bec0da    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c7790c: f94017e0    	ldr	x0, [sp, #0x28]
100c77910: 95bec0d8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77914: aa1503e0    	mov	x0, x21
100c77918: 95bec0d6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c7791c: aa1403e0    	mov	x0, x20
100c77920: 95bec0d4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77924: aa1303e0    	mov	x0, x19
100c77928: 95bec0d2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c7792c: aa1603e0    	mov	x0, x22
100c77930: 95bec0d0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100c77934: aa1703e0    	mov	x0, x23
100c77938: a9477bfd    	ldp	x29, x30, [sp, #0x70]
100c7793c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
100c77940: a94557f6    	ldp	x22, x21, [sp, #0x50]
100c77944: a9445ff8    	ldp	x24, x23, [sp, #0x40]
100c77948: 910203ff    	add	sp, sp, #0x80
100c7794c: d65f03c0    	ret
