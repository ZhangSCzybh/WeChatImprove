
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101ae06b4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101ae06b8: a9014ff4    	stp	x20, x19, [sp, #0x10]
101ae06bc: a9027bfd    	stp	x29, x30, [sp, #0x20]
101ae06c0: 910083fd    	add	x29, sp, #0x20
101ae06c4: aa0003f3    	mov	x19, x0
101ae06c8: d00e8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101ae06cc: f9469d01    	ldr	x1, [x8, #0xd38] ; selector: delegate
101ae06d0: 95851d65    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101ae06d4: aa1d03fd    	mov	x29, x29
101ae06d8: 95851d6a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101ae06dc: aa0003f4    	mov	x20, x0
101ae06e0: d00e7b28    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101ae06e4: f943dd15    	ldr	x21, [x8, #0x7b8] ; selector: forwardAction:
101ae06e8: 900e7a88    	adrp	x8, 0x11ea30000 <dyld_stub_binder+0x11ea30000>
101ae06ec: f9439101    	ldr	x1, [x8, #0x720] ; selector: indexPath
101ae06f0: aa1303e0    	mov	x0, x19
101ae06f4: 95851d5c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101ae06f8: aa1d03fd    	mov	x29, x29
101ae06fc: 95851d61    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101ae0700: aa0003f3    	mov	x19, x0
101ae0704: d00e7b28    	adrp	x8, 0x11ea46000 <dyld_stub_binder+0x11ea46000>
101ae0708: f9453101    	ldr	x1, [x8, #0xa60] ; selector: performAction:forRowAtIndexPath:
101ae070c: aa1403e0    	mov	x0, x20
101ae0710: aa1503e2    	mov	x2, x21
101ae0714: aa1303e3    	mov	x3, x19
101ae0718: 95851d53    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101ae071c: aa1303e0    	mov	x0, x19
101ae0720: 95851d54    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101ae0724: aa1403e0    	mov	x0, x20
101ae0728: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101ae072c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101ae0730: a8c357f6    	ldp	x22, x21, [sp], #0x30
101ae0734: 15851d4f    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
