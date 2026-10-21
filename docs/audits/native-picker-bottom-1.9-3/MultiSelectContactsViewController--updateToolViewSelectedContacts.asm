
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ea0f9c: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104ea0fa0: a9014ff4    	stp	x20, x19, [sp, #0x10]
104ea0fa4: a9027bfd    	stp	x29, x30, [sp, #0x20]
104ea0fa8: 910083fd    	add	x29, sp, #0x20
104ea0fac: aa0003f3    	mov	x19, x0
104ea0fb0: d00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea0fb4: b9886108    	ldrsw	x8, [x8, #0x860]
104ea0fb8: f8686814    	ldr	x20, [x0, x8]
104ea0fbc: d00d9c28    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104ea0fc0: b9885108    	ldrsw	x8, [x8, #0x850]
104ea0fc4: f8686800    	ldr	x0, [x0, x8]
104ea0fc8: b00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea0fcc: f9415501    	ldr	x1, [x8, #0x2a8] ; m_dicMultiSelect
104ea0fd0: 94b6185b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0fd4: aa1d03fd    	mov	x29, x29
104ea0fd8: 94b6185c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0fdc: aa0003f5    	mov	x21, x0
104ea0fe0: f00d92e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104ea0fe4: f9401101    	ldr	x1, [x8, #0x20] ; allValues
104ea0fe8: 94b61855    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea0fec: aa1d03fd    	mov	x29, x29
104ea0ff0: 94b61856    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ea0ff4: aa0003f6    	mov	x22, x0
104ea0ff8: b00d7e48    	adrp	x8, 0x11fe69000 <dyld_stub_binder+0x11fe69000>
104ea0ffc: f9416101    	ldr	x1, [x8, #0x2c0] ; updateSelectedContacts:
104ea1000: aa1403e0    	mov	x0, x20
104ea1004: aa1603e2    	mov	x2, x22
104ea1008: 94b6184d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea100c: aa1603e0    	mov	x0, x22
104ea1010: 94b61851    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea1014: aa1503e0    	mov	x0, x21
104ea1018: 94b6184f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ea101c: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea1020: f946c901    	ldr	x1, [x8, #0xd90] ; shouldShowSelectContactViewInBottomToolView
104ea1024: aa1303e0    	mov	x0, x19
104ea1028: 94b61845    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea102c: 340001a0    	cbz	w0, 0x104ea1060 <_Flutter_MMFoundation_BindContext+0x137cc44>
104ea1030: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea1034: f946cd01    	ldr	x1, [x8, #0xd98] ; canSelectMsgHistory
104ea1038: aa1303e0    	mov	x0, x19
104ea103c: 94b61840    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1040: 34000100    	cbz	w0, 0x104ea1060 <_Flutter_MMFoundation_BindContext+0x137cc44>
104ea1044: 900d8788    	adrp	x8, 0x11ff91000 <dyld_stub_binder+0x11ff91000>
104ea1048: f946d101    	ldr	x1, [x8, #0xda0] ; resetSelectContactViewAndHistoryButton
104ea104c: aa1303e0    	mov	x0, x19
104ea1050: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ea1054: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ea1058: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ea105c: 14b61838    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ea1060: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104ea1064: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104ea1068: a8c357f6    	ldp	x22, x21, [sp], #0x30
104ea106c: d65f03c0    	ret
