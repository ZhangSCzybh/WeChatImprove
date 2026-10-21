
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104cc859c: d10103ff    	sub	sp, sp, #0x40
104cc85a0: a90157f6    	stp	x22, x21, [sp, #0x10]
104cc85a4: a9024ff4    	stp	x20, x19, [sp, #0x20]
104cc85a8: a9037bfd    	stp	x29, x30, [sp, #0x30]
104cc85ac: 9100c3fd    	add	x29, sp, #0x30
104cc85b0: aa0203f4    	mov	x20, x2
104cc85b4: aa0003f3    	mov	x19, x0
104cc85b8: f00da548    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104cc85bc: f9453515    	ldr	x21, [x8, #0xa68]
104cc85c0: b00d8b88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104cc85c4: f942a916    	ldr	x22, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104cc85c8: aa0203e0    	mov	x0, x2
104cc85cc: 94bd7adb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104cc85d0: b00cd768    	adrp	x8, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
104cc85d4: 91102108    	add	x8, x8, #0x408
104cc85d8: a90053e8    	stp	x8, x20, [sp]
104cc85dc: f00b5aa3    	adrp	x3, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc85e0: 911a5863    	add	x3, x3, #0x696
104cc85e4: f00b5aa5    	adrp	x5, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc85e8: 9129b4a5    	add	x5, x5, #0xa6d
104cc85ec: f00b5aa7    	adrp	x7, 0x11b81f000 <dyld_stub_binder+0x11b81f000>
104cc85f0: 912a08e7    	add	x7, x7, #0xa82
104cc85f4: aa1503e0    	mov	x0, x21
104cc85f8: aa1603e1    	mov	x1, x22
104cc85fc: 52800042    	mov	w2, #0x2                ; =2
104cc8600: 52800004    	mov	w4, #0x0                ; =0
104cc8604: 528008e6    	mov	w6, #0x47               ; =71
104cc8608: 94bd7acd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc860c: 900d9628    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc8610: f9448501    	ldr	x1, [x8, #0x908] ; m_queue
104cc8614: aa1303e0    	mov	x0, x19
104cc8618: 94bd7ac9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc861c: aa1d03fd    	mov	x29, x29
104cc8620: 94bd7aca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104cc8624: aa0003f5    	mov	x21, x0
104cc8628: d00d8b88    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104cc862c: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
104cc8630: aa1403e2    	mov	x2, x20
104cc8634: 94bd7ac2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc8638: aa1403e0    	mov	x0, x20
104cc863c: 94bd7ac6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cc8640: aa1503e0    	mov	x0, x21
104cc8644: 94bd7ac4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104cc8648: f00da648    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104cc864c: f9434100    	ldr	x0, [x8, #0x680]
104cc8650: 900d9628    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc8654: f9448901    	ldr	x1, [x8, #0x910] ; msgInQueue
104cc8658: 94bd7ab9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104cc865c: 900d9628    	adrp	x8, 0x11ff8c000 <dyld_stub_binder+0x11ff8c000>
104cc8660: f9448d01    	ldr	x1, [x8, #0x918] ; checkMsgQueue
104cc8664: aa1303e0    	mov	x0, x19
104cc8668: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104cc866c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104cc8670: a94157f6    	ldp	x22, x21, [sp, #0x10]
104cc8674: 910103ff    	add	sp, sp, #0x40
104cc8678: 14bd7ab1    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
