
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157d7ca4: d10103ff    	sub	sp, sp, #0x40
1157d7ca8: a90157f6    	stp	x22, x21, [sp, #0x10]
1157d7cac: a9024ff4    	stp	x20, x19, [sp, #0x20]
1157d7cb0: a9037bfd    	stp	x29, x30, [sp, #0x30]
1157d7cb4: 9100c3fd    	add	x29, sp, #0x30
1157d7cb8: aa0303f5    	mov	x21, x3
1157d7cbc: aa0203f3    	mov	x19, x2
1157d7cc0: aa0003f4    	mov	x20, x0
1157d7cc4: aa0203e0    	mov	x0, x2
1157d7cc8: 945a1243    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157d7ccc: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7cd0: f941d501    	ldr	x1, [x8, #0x3a8] ; selector: isSelectedTabBarNavigationController
1157d7cd4: aa1403e0    	mov	x0, x20
1157d7cd8: 945a121b    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7cdc: 34000200    	cbz	w0, 0x1157d7d1c <_O266DecReleaseOutputPicture+0x36c87b0>
1157d7ce0: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7ce4: f941dd01    	ldr	x1, [x8, #0x3b8] ; selector: tabNavigationTransitionDelegate
1157d7ce8: aa1403e0    	mov	x0, x20
1157d7cec: 945a1216    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7cf0: aa1d03fd    	mov	x29, x29
1157d7cf4: 945a1241    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157d7cf8: aa0003f6    	mov	x22, x0
1157d7cfc: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7d00: f941e101    	ldr	x1, [x8, #0x3c0] ; selector: tabBarNavigationController:willPushViewController:animated:
1157d7d04: aa1403e2    	mov	x2, x20
1157d7d08: aa1303e3    	mov	x3, x19
1157d7d0c: aa1503e4    	mov	x4, x21
1157d7d10: 945a120d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7d14: aa1603e0    	mov	x0, x22
1157d7d18: 945a1229    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7d1c: f004ad08    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
1157d7d20: f940e508    	ldr	x8, [x8, #0x1c8]
1157d7d24: a90023f4    	stp	x20, x8, [sp]
1157d7d28: f004a688    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157d7d2c: f9407d01    	ldr	x1, [x8, #0xf8] ; selector: pushViewController:animated:
1157d7d30: 910003e0    	mov	x0, sp
1157d7d34: aa1303e2    	mov	x2, x19
1157d7d38: aa1503e3    	mov	x3, x21
1157d7d3c: 945a1205    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
1157d7d40: 9004a5e8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157d7d44: f941d901    	ldr	x1, [x8, #0x3b0] ; selector: layoutNavigationContent
1157d7d48: aa1403e0    	mov	x0, x20
1157d7d4c: 945a11fe    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157d7d50: aa1303e0    	mov	x0, x19
1157d7d54: 945a121a    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157d7d58: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1157d7d5c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1157d7d60: a94157f6    	ldp	x22, x21, [sp, #0x10]
1157d7d64: 910103ff    	add	sp, sp, #0x40
1157d7d68: d65f03c0    	ret
