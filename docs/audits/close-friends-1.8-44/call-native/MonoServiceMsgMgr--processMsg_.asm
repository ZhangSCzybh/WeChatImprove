
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104cc98d0: d10103ff    	sub	sp, sp, #0x40
104cc98d4: a90157f6    	stp	x22, x21, [sp, #0x10]
104cc98d8: a9024ff4    	stp	x20, x19, [sp, #0x20]
104cc98dc: a9037bfd    	stp	x29, x30, [sp, #0x30]
104cc98e0: 9100c3fd    	add	x29, sp, #0x30
104cc98e4: aa0203f3    	mov	x19, x2
104cc98e8: aa0003f4    	mov	x20, x0
104cc98ec: d00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cc98f0: f9453515    	ldr	x21, [x8, #0xa68]
104cc98f4: 900d8b88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cc98f8: f942a916    	ldr	x22, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cc98fc: aa0203e0    	mov	x0, x2
104cc9900: 94bd760e    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104cc9904: f00cbe88    	adrp	x8, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
104cc9908: 9122a108    	add	x8, x8, #0x8a8
104cc990c: a9004fe8    	stp	x8, x19, [sp]
104cc9910: d00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc9914: 911a5863    	add	x3, x3, #0x696
104cc9918: d00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc991c: 9129b4a5    	add	x5, x5, #0xa6d
104cc9920: d00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc9924: 913930e7    	add	x7, x7, #0xe4c
104cc9928: aa1503e0    	mov	x0, x21
104cc992c: aa1603e1    	mov	x1, x22
104cc9930: 52800042    	mov	w2, #0x2                ; =2
104cc9934: 52800004    	mov	w4, #0x0                ; =0
104cc9938: 52802246    	mov	w6, #0x112              ; =274
104cc993c: 94bd7600    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9940: f00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc9944: f9446101    	ldr	x1, [x8, #0x8c0] ; isCancelMsg
104cc9948: aa1303e0    	mov	x0, x19
104cc994c: 94bd75fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9950: f00d9608    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc9954: 91276108    	add	x8, x8, #0x9d8
104cc9958: f00d9609    	adrp	x9, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc995c: 91278129    	add	x9, x9, #0x9e0
104cc9960: 7100001f    	cmp	w0, #0x0
104cc9964: 9a891108    	csel	x8, x8, x9, ne
104cc9968: f9400101    	ldr	x1, [x8]
104cc996c: aa1403e0    	mov	x0, x20
104cc9970: aa1303e2    	mov	x2, x19
104cc9974: 94bd75f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc9978: aa1303e0    	mov	x0, x19
104cc997c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104cc9980: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104cc9984: a94157f6    	ldp	x22, x21, [sp, #0x10]
104cc9988: 910103ff    	add	sp, sp, #0x40
104cc998c: 14bd75f2    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
