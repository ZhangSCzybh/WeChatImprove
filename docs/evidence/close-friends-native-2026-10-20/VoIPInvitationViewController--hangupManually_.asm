
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106127f60: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106127f64: a9014ff4    	stp	x20, x19, [sp, #0x10]
106127f68: a9027bfd    	stp	x29, x30, [sp, #0x20]
106127f6c: 910083fd    	add	x29, sp, #0x20
106127f70: aa0203f3    	mov	x19, x2
106127f74: aa0003f4    	mov	x20, x0
106127f78: d00cf408    	adrp	x8, 0x11ffa9000 <dyld_stub_binder+0x11ffa9000>
106127f7c: f9475d01    	ldr	x1, [x8, #0xeb8] ; stopRing
106127f80: 946bfc6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127f84: 900cf548    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106127f88: f9467501    	ldr	x1, [x8, #0xce8] ; clearInviteBreadthTimeoutBlock
106127f8c: aa1403e0    	mov	x0, x20
106127f90: 946bfc6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127f94: b00cfec8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106127f98: f946f115    	ldr	x21, [x8, #0xde0] ; delegate
106127f9c: aa1403e0    	mov	x0, x20
106127fa0: aa1503e1    	mov	x1, x21
106127fa4: 946bfc66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127fa8: aa1d03fd    	mov	x29, x29
106127fac: 946bfc67    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106127fb0: aa0003f6    	mov	x22, x0
106127fb4: 946bfc68    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106127fb8: b4000396    	cbz	x22, 0x106128028 <_Flutter_MMFoundation_BindContext+0x2603c0c>
106127fbc: aa1403e0    	mov	x0, x20
106127fc0: aa1503e1    	mov	x1, x21
106127fc4: 946bfc5e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127fc8: aa1d03fd    	mov	x29, x29
106127fcc: 946bfc5f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106127fd0: aa0003f5    	mov	x21, x0
106127fd4: 900ce8e8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
106127fd8: f9422d01    	ldr	x1, [x8, #0x458] ; info
106127fdc: aa1403e0    	mov	x0, x20
106127fe0: 946bfc57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106127fe4: aa1d03fd    	mov	x29, x29
106127fe8: 946bfc58    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106127fec: aa0003f6    	mov	x22, x0
106127ff0: 900cf548    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106127ff4: f9468501    	ldr	x1, [x8, #0xd08] ; voIPInvitationViewController:didHangupWithInfo:manually:
106127ff8: aa1503e0    	mov	x0, x21
106127ffc: aa1403e2    	mov	x2, x20
106128000: aa1603e3    	mov	x3, x22
106128004: aa1303e4    	mov	x4, x19
106128008: 946bfc4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10612800c: aa1603e0    	mov	x0, x22
106128010: 946bfc51    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106128014: aa1503e0    	mov	x0, x21
106128018: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10612801c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106128020: a8c357f6    	ldp	x22, x21, [sp], #0x30
106128024: 146bfc4c    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106128028: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10612802c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106128030: a8c357f6    	ldp	x22, x21, [sp], #0x30
106128034: d65f03c0    	ret
