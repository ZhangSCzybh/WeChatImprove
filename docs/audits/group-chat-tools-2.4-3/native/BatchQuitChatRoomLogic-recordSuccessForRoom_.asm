
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100390f14:     	stp	x24, x23, [sp, #-0x40]!
100390f18:     	stp	x22, x21, [sp, #0x10]
100390f1c:     	stp	x20, x19, [sp, #0x20]
100390f20:     	stp	x29, x30, [sp, #0x30]
100390f24:     	add	x29, sp, #0x30
100390f28:     	mov	x19, x2
100390f2c:     	mov	x20, x0
100390f30:     	mov	x0, x2
100390f34:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390f38:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390f3c:     	ldr	x21, [x8, #0x450]
100390f40:     	mov	x0, x20
100390f44:     	mov	x1, x21
100390f48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390f4c:     	mov	x29, x29
100390f50:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390f54:     	mov	x22, x0
100390f58:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100390f5c:     	ldr	x1, [x8, #0x738]
100390f60:     	mov	x2, x19
100390f64:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390f68:     	mov	x23, x0
100390f6c:     	mov	x0, x22
100390f70:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390f74:     	tbnz	w23, #0x0, 0x100390fe0 <__text+0x388fe0>
100390f78:     	mov	x0, x20
100390f7c:     	mov	x1, x21
100390f80:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390f84:     	mov	x29, x29
100390f88:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390f8c:     	mov	x21, x0
100390f90:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
100390f94:     	ldr	x1, [x8, #0xa38]
100390f98:     	mov	x2, x19
100390f9c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390fa0:     	mov	x0, x21
100390fa4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390fa8:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100390fac:     	ldr	x1, [x8, #0xd38]
100390fb0:     	mov	x0, x20
100390fb4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390fb8:     	mov	x29, x29
100390fbc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390fc0:     	mov	x21, x0
100390fc4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390fc8:     	ldr	x1, [x8, #0x558]
100390fcc:     	mov	x2, x20
100390fd0:     	mov	x3, x19
100390fd4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390fd8:     	mov	x0, x21
100390fdc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390fe0:     	mov	x0, x19
100390fe4:     	ldp	x29, x30, [sp, #0x30]
100390fe8:     	ldp	x20, x19, [sp, #0x20]
100390fec:     	ldp	x22, x21, [sp, #0x10]
100390ff0:     	ldp	x24, x23, [sp], #0x40
100390ff4:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
