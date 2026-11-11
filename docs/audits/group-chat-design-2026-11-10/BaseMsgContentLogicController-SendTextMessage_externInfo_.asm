
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002d4bf4:     	sub	sp, sp, #0x90
1002d4bf8:     	stp	x28, x27, [sp, #0x30]
1002d4bfc:     	stp	x26, x25, [sp, #0x40]
1002d4c00:     	stp	x24, x23, [sp, #0x50]
1002d4c04:     	stp	x22, x21, [sp, #0x60]
1002d4c08:     	stp	x20, x19, [sp, #0x70]
1002d4c0c:     	stp	x29, x30, [sp, #0x80]
1002d4c10:     	add	x29, sp, #0x80
1002d4c14:     	mov	x20, x3
1002d4c18:     	mov	x19, x2
1002d4c1c:     	mov	x21, x0
1002d4c20:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002d4c24:     	mov	w9, #0x1                ; =1
1002d4c28:     	strb	w9, [x8, #0x997]
1002d4c2c:     	mov	x0, x2
1002d4c30:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002d4c34:     	mov	x0, x20
1002d4c38:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1002d4c3c:     	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1002d4c40:     	ldrsw	x8, [x8, #0xc0c]
1002d4c44:     	str	x8, [sp, #0x18]
1002d4c48:     	ldr	x0, [x21, x8]
1002d4c4c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1002d4c50:     	ldr	x1, [x8, #0x620]
1002d4c54:     	str	x1, [sp, #0x10]
1002d4c58:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4c5c:     	mov	x29, x29
1002d4c60:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4c64:     	mov	x23, x0
1002d4c68:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4c6c:     	ldr	x1, [x8, #0xed8]
1002d4c70:     	mov	x0, x21
1002d4c74:     	mov	x2, x23
1002d4c78:     	mov	x3, x19
1002d4c7c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4c80:     	mov	x29, x29
1002d4c84:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4c88:     	mov	x22, x0
1002d4c8c:     	mov	x0, x23
1002d4c90:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4c94:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1002d4c98:     	ldr	x1, [x8, #0x640]
1002d4c9c:     	adrp	x2, 0x11cfc0000 <dyld_stub_binder+0x11cfc0000>
1002d4ca0:     	add	x2, x2, #0x1b8
1002d4ca4:     	mov	x0, x20
1002d4ca8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4cac:     	mov	x29, x29
1002d4cb0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4cb4:     	mov	x24, x0
1002d4cb8:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002d4cbc:     	ldr	x23, [x8, #0xce8]
1002d4cc0:     	mov	x1, x23
1002d4cc4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4cc8:     	cbz	x0, 0x1002d4ce0 <__text+0x2ccce0>
1002d4ccc:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4cd0:     	ldr	x1, [x8, #0xfd0]
1002d4cd4:     	mov	x0, x22
1002d4cd8:     	mov	x2, x24
1002d4cdc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4ce0:     	str	x24, [sp, #0x8]
1002d4ce4:     	stp	x20, x19, [sp, #0x20]
1002d4ce8:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1002d4cec:     	ldr	x1, [x8, #0x588]
1002d4cf0:     	adrp	x2, 0x11cfc0000 <dyld_stub_binder+0x11cfc0000>
1002d4cf4:     	add	x2, x2, #0x1d8
1002d4cf8:     	mov	x0, x20
1002d4cfc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4d00:     	mov	x29, x29
1002d4d04:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4d08:     	mov	x19, x0
1002d4d0c:     	mov	x1, x23
1002d4d10:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4d14:     	cbz	x0, 0x1002d4d2c <__text+0x2ccd2c>
1002d4d18:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4d1c:     	ldr	x1, [x8, #0xfd8]
1002d4d20:     	mov	x0, x22
1002d4d24:     	mov	x2, x19
1002d4d28:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4d2c:     	str	x19, [sp]
1002d4d30:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002d4d34:     	ldr	x0, [x8, #0x780]
1002d4d38:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002d4d3c:     	ldr	x26, [x8, #0x800]
1002d4d40:     	mov	x1, x26
1002d4d44:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4d48:     	mov	x29, x29
1002d4d4c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4d50:     	mov	x24, x0
1002d4d54:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1002d4d58:     	ldr	x0, [x8, #0x2c0]
1002d4d5c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002d4d60:     	ldr	x27, [x8, #0x508]
1002d4d64:     	mov	x1, x27
1002d4d68:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4d6c:     	mov	x2, x0
1002d4d70:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002d4d74:     	ldr	x28, [x8, #0xa40]
1002d4d78:     	mov	x0, x24
1002d4d7c:     	mov	x1, x28
1002d4d80:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4d84:     	mov	x29, x29
1002d4d88:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4d8c:     	mov	x19, x0
1002d4d90:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1002d4d94:     	ldr	x20, [x8, #0x460]
1002d4d98:     	mov	x0, x22
1002d4d9c:     	mov	x1, x20
1002d4da0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4da4:     	mov	x29, x29
1002d4da8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4dac:     	mov	x25, x0
1002d4db0:     	mov	x0, x22
1002d4db4:     	mov	x1, x20
1002d4db8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4dbc:     	mov	x29, x29
1002d4dc0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4dc4:     	mov	x20, x0
1002d4dc8:     	mov	x1, x23
1002d4dcc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4dd0:     	mov	x4, x0
1002d4dd4:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4dd8:     	ldr	x1, [x8, #0xef8]
1002d4ddc:     	mov	x0, x19
1002d4de0:     	mov	x2, x25
1002d4de4:     	mov	x3, #0x0                ; =0
1002d4de8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4dec:     	mov	x23, x0
1002d4df0:     	mov	x0, x20
1002d4df4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4df8:     	mov	x0, x25
1002d4dfc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4e00:     	mov	x0, x19
1002d4e04:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4e08:     	mov	x0, x24
1002d4e0c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4e10:     	mov	x8, #0x7fffffffffffffff ; =9223372036854775807
1002d4e14:     	adrp	x25, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4e18:     	adrp	x24, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4e1c:     	cmp	x23, x8
1002d4e20:     	b.eq	0x1002d4e40 <__text+0x2cce40>
1002d4e24:     	ldr	x1, [x25, #0xf00]
1002d4e28:     	mov	x0, x22
1002d4e2c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4e30:     	ldr	x1, [x24, #0xf08]
1002d4e34:     	orr	w2, w0, #0x1
1002d4e38:     	mov	x0, x22
1002d4e3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4e40:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002d4e44:     	ldr	x0, [x8, #0x780]
1002d4e48:     	mov	x1, x26
1002d4e4c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4e50:     	mov	x29, x29
1002d4e54:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4e58:     	mov	x19, x0
1002d4e5c:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
1002d4e60:     	ldr	x0, [x8, #0x2c0]
1002d4e64:     	mov	x1, x27
1002d4e68:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4e6c:     	mov	x2, x0
1002d4e70:     	mov	x0, x19
1002d4e74:     	mov	x1, x28
1002d4e78:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4e7c:     	mov	x29, x29
1002d4e80:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4e84:     	mov	x20, x0
1002d4e88:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1002d4e8c:     	ldr	x1, [x8, #0xf10]
1002d4e90:     	ldr	x26, [sp, #0x28]
1002d4e94:     	mov	x2, x26
1002d4e98:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4e9c:     	mov	x23, x0
1002d4ea0:     	mov	x0, x20
1002d4ea4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4ea8:     	mov	x0, x19
1002d4eac:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4eb0:     	cbz	w23, 0x1002d4ed0 <__text+0x2cced0>
1002d4eb4:     	ldr	x1, [x25, #0xf00]
1002d4eb8:     	mov	x0, x22
1002d4ebc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4ec0:     	ldr	x1, [x24, #0xf08]
1002d4ec4:     	orr	w2, w0, #0x2
1002d4ec8:     	mov	x0, x22
1002d4ecc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4ed0:     	ldp	x1, x8, [sp, #0x10]
1002d4ed4:     	ldr	x0, [x21, x8]
1002d4ed8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4edc:     	mov	x29, x29
1002d4ee0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002d4ee4:     	mov	x19, x0
1002d4ee8:     	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1002d4eec:     	ldr	x1, [x8, #0xf10]
1002d4ef0:     	mov	x0, x21
1002d4ef4:     	mov	x2, x19
1002d4ef8:     	mov	x3, x22
1002d4efc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002d4f00:     	mov	x0, x19
1002d4f04:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4f08:     	ldr	x0, [sp]
1002d4f0c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4f10:     	ldr	x0, [sp, #0x8]
1002d4f14:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4f18:     	mov	x0, x22
1002d4f1c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4f20:     	ldr	x0, [sp, #0x20]
1002d4f24:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002d4f28:     	mov	x0, x26
1002d4f2c:     	ldp	x29, x30, [sp, #0x80]
1002d4f30:     	ldp	x20, x19, [sp, #0x70]
1002d4f34:     	ldp	x22, x21, [sp, #0x60]
1002d4f38:     	ldp	x24, x23, [sp, #0x50]
1002d4f3c:     	ldp	x26, x25, [sp, #0x40]
1002d4f40:     	ldp	x28, x27, [sp, #0x30]
1002d4f44:     	add	sp, sp, #0x90
1002d4f48:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
