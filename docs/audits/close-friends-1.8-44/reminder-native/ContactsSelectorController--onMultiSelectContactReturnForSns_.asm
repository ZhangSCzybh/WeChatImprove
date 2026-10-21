
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106f44cac: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106f44cb0: a9014ff4    	stp	x20, x19, [sp, #0x10]
106f44cb4: a9027bfd    	stp	x29, x30, [sp, #0x20]
106f44cb8: 910083fd    	add	x29, sp, #0x20
106f44cbc: aa0203f3    	mov	x19, x2
106f44cc0: aa0003f4    	mov	x20, x0
106f44cc4: f00c77a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f44cc8: f945d515    	ldr	x21, [x8, #0xba8] ; getViewController
106f44ccc: aa0203e0    	mov	x0, x2
106f44cd0: 9433891a    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106f44cd4: aa1403e0    	mov	x0, x20
106f44cd8: aa1503e1    	mov	x1, x21
106f44cdc: 94338918    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44ce0: aa1d03fd    	mov	x29, x29
106f44ce4: 94338919    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106f44ce8: aa0003f5    	mov	x21, x0
106f44cec: f00c77a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
106f44cf0: f945f501    	ldr	x1, [x8, #0xbe8] ; DismissModalViewControllerAnimated:
106f44cf4: 52800022    	mov	w2, #0x1                ; =1
106f44cf8: 94338911    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44cfc: aa1503e0    	mov	x0, x21
106f44d00: 94338915    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106f44d04: b00c7928    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
106f44d08: f9415901    	ldr	x1, [x8, #0x2b0] ; didSelectContacts:
106f44d0c: aa1403e0    	mov	x0, x20
106f44d10: aa1303e2    	mov	x2, x19
106f44d14: 9433890a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106f44d18: aa1303e0    	mov	x0, x19
106f44d1c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106f44d20: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106f44d24: a8c357f6    	ldp	x22, x21, [sp], #0x30
106f44d28: 1433890b    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
