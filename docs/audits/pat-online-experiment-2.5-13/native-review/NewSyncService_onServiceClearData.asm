
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461708: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10546170c: a9017bfd    	stp	x29, x30, [sp, #0x10]
105461710: 910043fd    	add	x29, sp, #0x10
105461714: aa0003f3    	mov	x19, x0
105461718: 949f1957    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10546171c: 949f1962    	bl	0x107c27ca4 <_Flutter_MMFoundation_BindContext+0x3eae970>
105461720: b00ccb48    	adrp	x8, 0x11edca000 <dyld_stub_binder+0x11edca000>
105461724: b988d908    	ldrsw	x8, [x8, #0x8d8]
105461728: 38286a7f    	strb	wzr, [x19, x8]
10546172c: aa1303e0    	mov	x0, x19
105461730: 949f195e    	bl	0x107c27ca8 <_Flutter_MMFoundation_BindContext+0x3eae974>
105461734: aa1303e0    	mov	x0, x19
105461738: 949f194e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10546173c: b00cb6c8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105461740: f945c502    	ldr	x2, [x8, #0xb88] ; selector cancelBgFgEvent
105461744: 900cc248    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105461748: f946f901    	ldr	x1, [x8, #0xdf0] ; selector performSelectorOnMainThread:withObject:waitUntilDone:
10546174c: aa1303e0    	mov	x0, x19
105461750: d2800003    	mov	x3, #0x0                ; =0
105461754: 52800004    	mov	w4, #0x0                ; =0
105461758: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10546175c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
105461760: 149f1941    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
