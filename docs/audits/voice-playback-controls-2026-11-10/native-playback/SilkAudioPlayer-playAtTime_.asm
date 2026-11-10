
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105cf4b6c: d101c3ff    	sub	sp, sp, #0x70
105cf4b70: a9035ff8    	stp	x24, x23, [sp, #0x30]
105cf4b74: a90457f6    	stp	x22, x21, [sp, #0x40]
105cf4b78: a9054ff4    	stp	x20, x19, [sp, #0x50]
105cf4b7c: a9067bfd    	stp	x29, x30, [sp, #0x60]
105cf4b80: 910183fd    	add	x29, sp, #0x60
105cf4b84: aa0203f6    	mov	x22, x2
105cf4b88: aa0003f3    	mov	x19, x0
105cf4b8c: b00cd308    	adrp	x8, 0x11f755000 <dyld_stub_binder+0x11f755000>
105cf4b90: 52800029    	mov	w9, #0x1                ; =1
105cf4b94: 39103d09    	strb	w9, [x8, #0x40f]
105cf4b98: d00c7248    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105cf4b9c: f9444514    	ldr	x20, [x8, #0x888]
105cf4ba0: aa1403e1    	mov	x1, x20
105cf4ba4: d2800002    	mov	x2, #0x0                ; =0
105cf4ba8: 947ccc2f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4bac: d00c7248    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105cf4bb0: f9444901    	ldr	x1, [x8, #0x890]
105cf4bb4: aa1303e0    	mov	x0, x19
105cf4bb8: d2800002    	mov	x2, #0x0                ; =0
105cf4bbc: 947ccc2a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4bc0: d00c80f7    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105cf4bc4: f94452e0    	ldr	x0, [x23, #0x8a0]
105cf4bc8: b00c66a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105cf4bcc: f9479115    	ldr	x21, [x8, #0xf20]
105cf4bd0: aa1503e1    	mov	x1, x21
105cf4bd4: 947ccc24    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4bd8: aa0003e2    	mov	x2, x0
105cf4bdc: f00c7da8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
105cf4be0: f9473901    	ldr	x1, [x8, #0xe70]
105cf4be4: aa1303e0    	mov	x0, x19
105cf4be8: 947ccc1f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4bec: d00c8448    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105cf4bf0: 912ab108    	add	x8, x8, #0xaac
105cf4bf4: b9800118    	ldrsw	x24, [x8]
105cf4bf8: f8786a68    	ldr	x8, [x19, x24]
105cf4bfc: f9401d09    	ldr	x9, [x8, #0x38]
105cf4c00: b40002e9    	cbz	x9, 0x105cf4c5c <_Flutter_MMFoundation_BindContext+0x1f7b928>
105cf4c04: 3941b508    	ldrb	w8, [x8, #0x6d]
105cf4c08: 370002a8    	tbnz	w8, #0x0, 0x105cf4c5c <_Flutter_MMFoundation_BindContext+0x1f7b928>
105cf4c0c: d00c7248    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105cf4c10: f9444d01    	ldr	x1, [x8, #0x898]
105cf4c14: aa1303e0    	mov	x0, x19
105cf4c18: aa1603e2    	mov	x2, x22
105cf4c1c: 947ccc12    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4c20: f00c8388    	adrp	x8, 0x11ed67000 <dyld_stub_binder+0x11ed67000>
105cf4c24: f9435d08    	ldr	x8, [x8, #0x6b8]
105cf4c28: a90223f3    	stp	x19, x8, [sp, #0x20]
105cf4c2c: b00c7da8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105cf4c30: f9473501    	ldr	x1, [x8, #0xe68]
105cf4c34: 910083e0    	add	x0, sp, #0x20
105cf4c38: 947ccc0c    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
105cf4c3c: 52800816    	mov	w22, #0x40              ; =64
105cf4c40: f8786a60    	ldr	x0, [x19, x24]
105cf4c44: f9401c01    	ldr	x1, [x0, #0x38]
105cf4c48: f8766802    	ldr	x2, [x0, x22]
105cf4c4c: 97fffd47    	bl	0x105cf4168 <_Flutter_MMFoundation_BindContext+0x1f7ae34>
105cf4c50: 910022d6    	add	x22, x22, #0x8
105cf4c54: f10162df    	cmp	x22, #0x58
105cf4c58: 54ffff41    	b.ne	0x105cf4c40 <_Flutter_MMFoundation_BindContext+0x1f7b90c>
105cf4c5c: f94452e0    	ldr	x0, [x23, #0x8a0]
105cf4c60: aa1503e1    	mov	x1, x21
105cf4c64: 947ccc00    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4c68: aa0003f5    	mov	x21, x0
105cf4c6c: 900c7da8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105cf4c70: f9464d01    	ldr	x1, [x8, #0xc98]
105cf4c74: aa1303e0    	mov	x0, x19
105cf4c78: 947ccbfb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4c7c: cb0002a2    	sub	x2, x21, x0
105cf4c80: aa1303e0    	mov	x0, x19
105cf4c84: aa1403e1    	mov	x1, x20
105cf4c88: 947ccbf7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4c8c: d00c80e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105cf4c90: f9430d14    	ldr	x20, [x8, #0x618]
105cf4c94: d00c7248    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105cf4c98: f9445101    	ldr	x1, [x8, #0x8a0]
105cf4c9c: aa1303e0    	mov	x0, x19
105cf4ca0: 947ccbf1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4ca4: aa0003f5    	mov	x21, x0
105cf4ca8: d00c7248    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105cf4cac: f9445501    	ldr	x1, [x8, #0x8a8]
105cf4cb0: aa1303e0    	mov	x0, x19
105cf4cb4: 947ccbec    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4cb8: b00c66a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105cf4cbc: f9418901    	ldr	x1, [x8, #0x310]
105cf4cc0: a90083f5    	stp	x21, x0, [sp, #0x8]
105cf4cc4: f00bb288    	adrp	x8, 0x11d347000 <dyld_stub_binder+0x11d347000>
105cf4cc8: 91376108    	add	x8, x8, #0xdd8
105cf4ccc: f90003e8    	str	x8, [sp]
105cf4cd0: d00a2ea5    	adrp	x5, 0x11a2ca000 <dyld_stub_binder+0x11a2ca000>
105cf4cd4: 912ee0a5    	add	x5, x5, #0xbb8
105cf4cd8: d00a2ea7    	adrp	x7, 0x11a2ca000 <dyld_stub_binder+0x11a2ca000>
105cf4cdc: 9131d4e7    	add	x7, x7, #0xc75
105cf4ce0: aa1403e0    	mov	x0, x20
105cf4ce4: 52800042    	mov	w2, #0x2                ; =2
105cf4ce8: d2800003    	mov	x3, #0x0                ; =0
105cf4cec: 52800004    	mov	w4, #0x0                ; =0
105cf4cf0: 52802b86    	mov	w6, #0x15c              ; =348
105cf4cf4: 947ccbdc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf4cf8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105cf4cfc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105cf4d00: a94457f6    	ldp	x22, x21, [sp, #0x40]
105cf4d04: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105cf4d08: 9101c3ff    	add	sp, sp, #0x70
105cf4d0c: d65f03c0    	ret
