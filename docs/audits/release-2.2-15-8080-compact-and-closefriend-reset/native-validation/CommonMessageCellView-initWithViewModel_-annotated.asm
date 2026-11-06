
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101034d20: d100c3ff    	sub	sp, sp, #0x30
101034d24: a9014ff4    	stp	x20, x19, [sp, #0x10]
101034d28: a9027bfd    	stp	x29, x30, [sp, #0x20]
101034d2c: 910083fd    	add	x29, sp, #0x20
101034d30: b00ee928    	adrp	x8, 0x11ed59000 <dyld_stub_binder+0x11ed59000>
101034d34: f947e108    	ldr	x8, [x8, #0xfc0]
101034d38: a90023e0    	stp	x0, x8, [sp]
101034d3c: f00eccc8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
101034d40: f9410d01    	ldr	x1, [x8, #0x218] ; selector: initWithViewModel:
101034d44: 910003e0    	mov	x0, sp
101034d48: 95afcbc8    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
101034d4c: aa0003f3    	mov	x19, x0
101034d50: b40000c0    	cbz	x0, 0x101034d68 <__text+0x102cd68>
101034d54: 900eccc8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101034d58: f9431901    	ldr	x1, [x8, #0x630] ; selector: setIsAccessibilityElement:
101034d5c: aa1303e0    	mov	x0, x19
101034d60: 52800022    	mov	w2, #0x1                ; =1
101034d64: 95afcbc0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101034d68: aa1303e0    	mov	x0, x19
101034d6c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101034d70: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101034d74: 9100c3ff    	add	sp, sp, #0x30
101034d78: d65f03c0    	ret
