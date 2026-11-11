
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010b9df8:     	sub	sp, sp, #0x40
1010b9dfc:     	stp	x22, x21, [sp, #0x10]
1010b9e00:     	stp	x20, x19, [sp, #0x20]
1010b9e04:     	stp	x29, x30, [sp, #0x30]
1010b9e08:     	add	x29, sp, #0x30
1010b9e0c:     	mov	x19, x2
1010b9e10:     	mov	x20, x0
1010b9e14:     	mov	x0, x2
1010b9e18:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010b9e1c:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1010b9e20:     	ldr	x1, [x8, #0xce8] ; selector: length
1010b9e24:     	mov	x0, x19
1010b9e28:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b9e2c:     	cbz	x0, 0x1010b9e80 <__text+0x10b1e80>
1010b9e30:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010b9e34:     	ldr	x1, [x8, #0x150] ; selector: getContactByName:
1010b9e38:     	mov	x0, x20
1010b9e3c:     	mov	x2, x19
1010b9e40:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b9e44:     	mov	x29, x29
1010b9e48:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010b9e4c:     	mov	x20, x0
1010b9e50:     	cbz	x0, 0x1010b9e70 <__text+0x10b1e70>
1010b9e54:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010b9e58:     	ldr	x1, [x8, #0x158] ; selector: isMMContact
1010b9e5c:     	mov	x0, x20
1010b9e60:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b9e64:     	tbz	w0, #0x0, 0x1010b9e70 <__text+0x10b1e70>
1010b9e68:     	mov	w21, #0x1               ; =1
1010b9e6c:     	b	0x1010b9e74 <__text+0x10b1e74>
1010b9e70:     	mov	w21, #0x0               ; =0
1010b9e74:     	mov	x0, x20
1010b9e78:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b9e7c:     	b	0x1010b9ec8 <__text+0x10b1ec8>
1010b9e80:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1010b9e84:     	ldr	x0, [x8, #0x618]
1010b9e88:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1010b9e8c:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1010b9e90:     	adrp	x8, 0x11d052000 <dyld_stub_binder+0x11d052000>
1010b9e94:     	add	x8, x8, #0x38 ; CFString: return NO for nsUsrName is empty
1010b9e98:     	str	x8, [sp]
1010b9e9c:     	adrp	x3, 0x119b98000 <dyld_stub_binder+0x119b98000>
1010b9ea0:     	add	x3, x3, #0x3f4
1010b9ea4:     	adrp	x5, 0x119cfb000 <dyld_stub_binder+0x119cfb000>
1010b9ea8:     	add	x5, x5, #0xde4
1010b9eac:     	adrp	x7, 0x119cfc000 <dyld_stub_binder+0x119cfc000>
1010b9eb0:     	add	x7, x7, #0x7a1
1010b9eb4:     	mov	w2, #0x4                ; =4
1010b9eb8:     	mov	w4, #0x0                ; =0
1010b9ebc:     	mov	w6, #0x574              ; =1396
1010b9ec0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010b9ec4:     	mov	w21, #0x0               ; =0
1010b9ec8:     	mov	x0, x19
1010b9ecc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010b9ed0:     	mov	x0, x21
1010b9ed4:     	ldp	x29, x30, [sp, #0x30]
1010b9ed8:     	ldp	x20, x19, [sp, #0x20]
1010b9edc:     	ldp	x22, x21, [sp, #0x10]
1010b9ee0:     	add	sp, sp, #0x40
1010b9ee4:     	ret
