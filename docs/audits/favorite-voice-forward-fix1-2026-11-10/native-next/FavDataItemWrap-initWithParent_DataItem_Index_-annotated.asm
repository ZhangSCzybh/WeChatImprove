
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101a755e8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101a755ec: a90157f6    	stp	x22, x21, [sp, #0x10]
101a755f0: a9024ff4    	stp	x20, x19, [sp, #0x20]
101a755f4: a9037bfd    	stp	x29, x30, [sp, #0x30]
101a755f8: 9100c3fd    	add	x29, sp, #0x30
101a755fc: aa0403f3    	mov	x19, x4
101a75600: aa0303f4    	mov	x20, x3
101a75604: aa0203f5    	mov	x21, x2
101a75608: aa0003f6    	mov	x22, x0
101a7560c: f00e7ac8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
101a75610: f942dd17    	ldr	x23, [x8, #0x5b8] ; selector: dataList
101a75614: aa0303e0    	mov	x0, x3
101a75618: 9586c997    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a7561c: aa1503e0    	mov	x0, x21
101a75620: 9586c995    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101a75624: aa1703e1    	mov	x1, x23
101a75628: 9586c98f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a7562c: aa1d03fd    	mov	x29, x29
101a75630: 9586c994    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101a75634: aa0003f7    	mov	x23, x0
101a75638: d00e7e88    	adrp	x8, 0x11ea47000 <dyld_stub_binder+0x11ea47000>
101a7563c: f943f101    	ldr	x1, [x8, #0x7e0] ; selector: initWithParent:DataItem:dataList:Index:
101a75640: aa1603e0    	mov	x0, x22
101a75644: aa1503e2    	mov	x2, x21
101a75648: aa1403e3    	mov	x3, x20
101a7564c: aa1703e4    	mov	x4, x23
101a75650: aa1303e5    	mov	x5, x19
101a75654: 9586c984    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101a75658: aa0003f3    	mov	x19, x0
101a7565c: aa1403e0    	mov	x0, x20
101a75660: 9586c984    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a75664: aa1503e0    	mov	x0, x21
101a75668: 9586c982    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a7566c: aa1703e0    	mov	x0, x23
101a75670: 9586c980    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101a75674: aa1303e0    	mov	x0, x19
101a75678: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101a7567c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101a75680: a94157f6    	ldp	x22, x21, [sp, #0x10]
101a75684: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101a75688: d65f03c0    	ret
