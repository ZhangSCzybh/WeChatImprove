
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a720d0: d100c3ff    	sub	sp, sp, #0x30
104a720d4: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a720d8: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a720dc: 910083fd    	add	x29, sp, #0x20
104a720e0: aa0003f3    	mov	x19, x0
104a720e4: f00dba88    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a720e8: f9429d08    	ldr	x8, [x8, #0x538]
104a720ec: a90023e0    	stp	x0, x8, [sp]
104a720f0: d00d9e48    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a720f4: f941a901    	ldr	x1, [x8, #0x350] ; selector viewDidLoad
104a720f8: 910003e0    	mov	x0, sp
104a720fc: 94c6d412    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a72100: b00db848    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104a72104: f9420900    	ldr	x0, [x8, #0x410] ; class MainFrameFoldReporter
104a72108: 94c6d414    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104a7210c: b00dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a72110: b980dd14    	ldrsw	x20, [x8, #0xdc]
104a72114: f8746a68    	ldr	x8, [x19, x20]
104a72118: f8346a60    	str	x0, [x19, x20]
104a7211c: aa0803e0    	mov	x0, x8
104a72120: 94c6d40d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a72124: b00dbd88    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104a72128: b980d908    	ldrsw	x8, [x8, #0xd8]
104a7212c: f8686a60    	ldr	x0, [x19, x8]
104a72130: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72134: f9407501    	ldr	x1, [x8, #0xe8] ; selector enterPageTime
104a72138: 94c6d401    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a7213c: aa0003e2    	mov	x2, x0
104a72140: f8746a60    	ldr	x0, [x19, x20]
104a72144: d00da888    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a72148: f940e901    	ldr	x1, [x8, #0x1d0] ; selector setEnterUnreadAggregationTime:
104a7214c: 94c6d3fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72150: d00da068    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104a72154: f943cd01    	ldr	x1, [x8, #0x798] ; selector initUI
104a72158: aa1303e0    	mov	x0, x19
104a7215c: 94c6d3f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72160: f00da3e8    	adrp	x8, 0x11fef1000 <dyld_stub_binder+0x11fef1000>
104a72164: f9406501    	ldr	x1, [x8, #0xc8] ; selector updateContent
104a72168: aa1303e0    	mov	x0, x19
104a7216c: 94c6d3f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a72170: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a72174: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a72178: 9100c3ff    	add	sp, sp, #0x30
104a7217c: d65f03c0    	ret
