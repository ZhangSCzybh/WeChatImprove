
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105592d1c: d101c3ff    	sub	sp, sp, #0x70
105592d20: a9035ff8    	stp	x24, x23, [sp, #0x30]
105592d24: a90457f6    	stp	x22, x21, [sp, #0x40]
105592d28: a9054ff4    	stp	x20, x19, [sp, #0x50]
105592d2c: a9067bfd    	stp	x29, x30, [sp, #0x60]
105592d30: 910183fd    	add	x29, sp, #0x60
105592d34: aa0203f6    	mov	x22, x2
105592d38: aa0003f3    	mov	x19, x0
105592d3c: b00d0e08    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
105592d40: 52800029    	mov	w9, #0x1                ; =1
105592d44: 3923c909    	strb	w9, [x8, #0x8f2]
105592d48: 900cad68    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105592d4c: f9444514    	ldr	x20, [x8, #0x888]
105592d50: aa1403e1    	mov	x1, x20
105592d54: d2800002    	mov	x2, #0x0                ; =0
105592d58: 949a53c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592d5c: 900cad68    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105592d60: f9444901    	ldr	x1, [x8, #0x890]
105592d64: aa1303e0    	mov	x0, x19
105592d68: d2800002    	mov	x2, #0x0                ; =0
105592d6c: 949a53be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592d70: 900cbc17    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105592d74: f94452e0    	ldr	x0, [x23, #0x8a0]
105592d78: f00ca1a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105592d7c: f9479115    	ldr	x21, [x8, #0xf20]
105592d80: aa1503e1    	mov	x1, x21
105592d84: 949a53b8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592d88: aa0003e2    	mov	x2, x0
105592d8c: b00cb8c8    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
105592d90: f9473901    	ldr	x1, [x8, #0xe70]
105592d94: aa1303e0    	mov	x0, x19
105592d98: 949a53b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592d9c: 900cbf68    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105592da0: 912ab108    	add	x8, x8, #0xaac
105592da4: b9800118    	ldrsw	x24, [x8]
105592da8: f8786a68    	ldr	x8, [x19, x24]
105592dac: f9401d09    	ldr	x9, [x8, #0x38]
105592db0: b40002e9    	cbz	x9, 0x105592e0c <_Flutter_MMFoundation_BindContext+0x1819ad8>
105592db4: 3941b508    	ldrb	w8, [x8, #0x6d]
105592db8: 370002a8    	tbnz	w8, #0x0, 0x105592e0c <_Flutter_MMFoundation_BindContext+0x1819ad8>
105592dbc: 900cad68    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105592dc0: f9444d01    	ldr	x1, [x8, #0x898]
105592dc4: aa1303e0    	mov	x0, x19
105592dc8: aa1603e2    	mov	x2, x22
105592dcc: 949a53a6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592dd0: 900cbea8    	adrp	x8, 0x11ed66000 <dyld_stub_binder+0x11ed66000>
105592dd4: f9412d08    	ldr	x8, [x8, #0x258]
105592dd8: a90223f3    	stp	x19, x8, [sp, #0x20]
105592ddc: f00cb8a8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
105592de0: f9473501    	ldr	x1, [x8, #0xe68]
105592de4: 910083e0    	add	x0, sp, #0x20
105592de8: 949a53a0    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
105592dec: 52800816    	mov	w22, #0x40              ; =64
105592df0: f8786a60    	ldr	x0, [x19, x24]
105592df4: f9401c01    	ldr	x1, [x0, #0x38]
105592df8: f8766802    	ldr	x2, [x0, x22]
105592dfc: 97fffc68    	bl	0x105591f9c <_Flutter_MMFoundation_BindContext+0x1818c68>
105592e00: 910022d6    	add	x22, x22, #0x8
105592e04: f10162df    	cmp	x22, #0x58
105592e08: 54ffff41    	b.ne	0x105592df0 <_Flutter_MMFoundation_BindContext+0x1819abc>
105592e0c: f94452e0    	ldr	x0, [x23, #0x8a0]
105592e10: aa1503e1    	mov	x1, x21
105592e14: 949a5394    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592e18: aa0003f5    	mov	x21, x0
105592e1c: d00cb8a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105592e20: f9464d01    	ldr	x1, [x8, #0xc98]
105592e24: aa1303e0    	mov	x0, x19
105592e28: 949a538f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592e2c: cb0002a2    	sub	x2, x21, x0
105592e30: aa1303e0    	mov	x0, x19
105592e34: aa1403e1    	mov	x1, x20
105592e38: 949a538b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592e3c: 900cbc08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105592e40: f9430d14    	ldr	x20, [x8, #0x618]
105592e44: 900cad68    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105592e48: f9445101    	ldr	x1, [x8, #0x8a0]
105592e4c: aa1303e0    	mov	x0, x19
105592e50: 949a5385    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592e54: aa0003f5    	mov	x21, x0
105592e58: 900cad68    	adrp	x8, 0x11eb3e000 <dyld_stub_binder+0x11eb3e000>
105592e5c: f9445501    	ldr	x1, [x8, #0x8a8]
105592e60: aa1303e0    	mov	x0, x19
105592e64: 949a5380    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592e68: f00ca1a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105592e6c: f9418901    	ldr	x1, [x8, #0x310]
105592e70: a90083f5    	stp	x21, x0, [sp, #0x8]
105592e74: d00beb88    	adrp	x8, 0x11d304000 <dyld_stub_binder+0x11d304000>
105592e78: 911ce108    	add	x8, x8, #0x738
105592e7c: f90003e8    	str	x8, [sp]
105592e80: d00a6525    	adrp	x5, 0x11a238000 <dyld_stub_binder+0x11a238000>
105592e84: 910f50a5    	add	x5, x5, #0x3d4
105592e88: d00a6527    	adrp	x7, 0x11a238000 <dyld_stub_binder+0x11a238000>
105592e8c: 911880e7    	add	x7, x7, #0x620
105592e90: aa1403e0    	mov	x0, x20
105592e94: 52800042    	mov	w2, #0x2                ; =2
105592e98: d2800003    	mov	x3, #0x0                ; =0
105592e9c: 52800004    	mov	w4, #0x0                ; =0
105592ea0: 52803106    	mov	w6, #0x188              ; =392
105592ea4: 949a5370    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105592ea8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105592eac: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105592eb0: a94457f6    	ldp	x22, x21, [sp, #0x40]
105592eb4: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105592eb8: 9101c3ff    	add	sp, sp, #0x70
105592ebc: d65f03c0    	ret
