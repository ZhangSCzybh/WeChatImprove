
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10121f91c:     	sub	sp, sp, #0x70
10121f920:     	stp	x28, x27, [sp, #0x10]
10121f924:     	stp	x26, x25, [sp, #0x20]
10121f928:     	stp	x24, x23, [sp, #0x30]
10121f92c:     	stp	x22, x21, [sp, #0x40]
10121f930:     	stp	x20, x19, [sp, #0x50]
10121f934:     	stp	x29, x30, [sp, #0x60]
10121f938:     	add	x29, sp, #0x60
10121f93c:     	mov	x24, x7
10121f940:     	mov	x23, x6
10121f944:     	mov	x22, x5
10121f948:     	mov	x21, x4
10121f94c:     	mov	x20, x3
10121f950:     	mov	x19, x2
10121f954:     	mov	x25, x0
10121f958:     	adrp	x8, 0x11f744000 <dyld_stub_binder+0x11f744000>
10121f95c:     	mov	w9, #0x1                ; =1
10121f960:     	strb	w9, [x8, #0x160]
10121f964:     	mov	x0, x2
10121f968:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121f96c:     	mov	x0, x20
10121f970:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121f974:     	mov	x0, x21
10121f978:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121f97c:     	mov	x0, x22
10121f980:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121f984:     	mov	x0, x23
10121f988:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10121f98c:     	adrp	x8, 0x11ed5a000 <dyld_stub_binder+0x11ed5a000>
10121f990:     	ldr	x8, [x8, #0x430]
10121f994:     	stp	x25, x8, [sp]
10121f998:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10121f99c:     	ldr	x1, [x8, #0x98]
10121f9a0:     	mov	x0, sp
10121f9a4:     	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
10121f9a8:     	mov	x25, x0
10121f9ac:     	cbz	x0, 0x10121fa88 <__text+0x1217a88>
10121f9b0:     	ldrb	w27, [x29, #0x10]
10121f9b4:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121f9b8:     	ldrsw	x8, [x8, #0x2f4]
10121f9bc:     	add	x0, x25, x8
10121f9c0:     	mov	x1, x19
10121f9c4:     	bl	0x107c27c9c <_Flutter_MMFoundation_BindContext+0x3eae968>
10121f9c8:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121f9cc:     	ldr	x26, [x8, #0x818]
10121f9d0:     	mov	x0, x20
10121f9d4:     	mov	x1, x26
10121f9d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121f9dc:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121f9e0:     	ldrsw	x9, [x8, #0x2f8]
10121f9e4:     	ldr	x8, [x25, x9]
10121f9e8:     	str	x0, [x25, x9]
10121f9ec:     	mov	x0, x8
10121f9f0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121f9f4:     	mov	x0, x21
10121f9f8:     	mov	x1, x26
10121f9fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121fa00:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121fa04:     	ldrsw	x9, [x8, #0x2fc]
10121fa08:     	ldr	x8, [x25, x9]
10121fa0c:     	str	x0, [x25, x9]
10121fa10:     	mov	x0, x8
10121fa14:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121fa18:     	mov	x0, x22
10121fa1c:     	mov	x1, x26
10121fa20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121fa24:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121fa28:     	ldrsw	x9, [x8, #0x300]
10121fa2c:     	ldr	x8, [x25, x9]
10121fa30:     	str	x0, [x25, x9]
10121fa34:     	mov	x0, x8
10121fa38:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121fa3c:     	mov	x0, x23
10121fa40:     	mov	x1, x26
10121fa44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121fa48:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121fa4c:     	ldrsw	x9, [x8, #0x304]
10121fa50:     	ldr	x8, [x25, x9]
10121fa54:     	str	x0, [x25, x9]
10121fa58:     	mov	x0, x8
10121fa5c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121fa60:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121fa64:     	ldrsw	x8, [x8, #0x308]
10121fa68:     	strb	w24, [x25, x8]
10121fa6c:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121fa70:     	ldrsw	x8, [x8, #0x30c]
10121fa74:     	strb	w27, [x25, x8]
10121fa78:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10121fa7c:     	ldr	x1, [x8, #0x358]
10121fa80:     	mov	x0, x25
10121fa84:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121fa88:     	mov	x0, x23
10121fa8c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121fa90:     	mov	x0, x22
10121fa94:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121fa98:     	mov	x0, x21
10121fa9c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121faa0:     	mov	x0, x20
10121faa4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121faa8:     	mov	x0, x19
10121faac:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121fab0:     	mov	x0, x25
10121fab4:     	ldp	x29, x30, [sp, #0x60]
10121fab8:     	ldp	x20, x19, [sp, #0x50]
10121fabc:     	ldp	x22, x21, [sp, #0x40]
10121fac0:     	ldp	x24, x23, [sp, #0x30]
10121fac4:     	ldp	x26, x25, [sp, #0x20]
10121fac8:     	ldp	x28, x27, [sp, #0x10]
10121facc:     	add	sp, sp, #0x70
10121fad0:     	ret
