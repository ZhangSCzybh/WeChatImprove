
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105cf5e6c: d10143ff    	sub	sp, sp, #0x50
105cf5e70: a9015ff8    	stp	x24, x23, [sp, #0x10]
105cf5e74: a90257f6    	stp	x22, x21, [sp, #0x20]
105cf5e78: a9034ff4    	stp	x20, x19, [sp, #0x30]
105cf5e7c: a9047bfd    	stp	x29, x30, [sp, #0x40]
105cf5e80: 910103fd    	add	x29, sp, #0x40
105cf5e84: aa0203f3    	mov	x19, x2
105cf5e88: 900cd308    	adrp	x8, 0x11f755000 <dyld_stub_binder+0x11f755000>
105cf5e8c: 52800029    	mov	w9, #0x1                ; =1
105cf5e90: 39105909    	strb	w9, [x8, #0x416]
105cf5e94: aa0203e0    	mov	x0, x2
105cf5e98: 947cc777    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105cf5e9c: aa1303e0    	mov	x0, x19
105cf5ea0: 947cc776    	bl	0x107c27c78 <_Flutter_MMFoundation_BindContext+0x3eae944>
105cf5ea4: b00c7d88    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105cf5ea8: f940f116    	ldr	x22, [x8, #0x1e0] ; selector: bytes
105cf5eac: aa1603e1    	mov	x1, x22
105cf5eb0: 947cc76d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf5eb4: 947c5859    	bl	0x107c0c018 <_Flutter_MMFoundation_BindContext+0x3e92ce4>
105cf5eb8: aa0003f5    	mov	x21, x0
105cf5ebc: 340006c0    	cbz	w0, 0x105cf5f94 <_Flutter_MMFoundation_BindContext+0x1f7cc60>
105cf5ec0: 52810000    	mov	w0, #0x800              ; =2048
105cf5ec4: 947cc60d    	bl	0x107c276f8 <_Flutter_MMFoundation_BindContext+0x3eae3c4>
105cf5ec8: aa0003f4    	mov	x20, x0
105cf5ecc: 947c5851    	bl	0x107c0c010 <_Flutter_MMFoundation_BindContext+0x3e92cdc>
105cf5ed0: aa1303e0    	mov	x0, x19
105cf5ed4: 947cc769    	bl	0x107c27c78 <_Flutter_MMFoundation_BindContext+0x3eae944>
105cf5ed8: aa1603e1    	mov	x1, x22
105cf5edc: 947cc762    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf5ee0: aa0003f6    	mov	x22, x0
105cf5ee4: f00c7d88    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105cf5ee8: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
105cf5eec: aa1303e0    	mov	x0, x19
105cf5ef0: 947cc75d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf5ef4: aa0003e3    	mov	x3, x0
105cf5ef8: aa1403e0    	mov	x0, x20
105cf5efc: aa1503e1    	mov	x1, x21
105cf5f00: aa1603e2    	mov	x2, x22
105cf5f04: 947c5846    	bl	0x107c0c01c <_Flutter_MMFoundation_BindContext+0x3e92ce8>
105cf5f08: 1e6202a0    	scvtf	d0, w21
105cf5f0c: d008de88    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
105cf5f10: fd472101    	ldr	d1, [x8, #0xe40] ; constant double=0.02
105cf5f14: 1e610800    	fmul	d0, d0, d1
105cf5f18: 1e780016    	fcvtzs	w22, d0
105cf5f1c: 528bb808    	mov	w8, #0x5dc0             ; =24000
105cf5f20: 6b0802bf    	cmp	w21, w8
105cf5f24: 1a88c2a8    	csel	w8, w21, w8, gt
105cf5f28: 1e630100    	ucvtf	d0, w8
105cf5f2c: d008de88    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
105cf5f30: fd445d01    	ldr	d1, [x8, #0x8b8] ; constant double=0.1
105cf5f34: 1e610800    	fmul	d0, d0, d1
105cf5f38: 1e780008    	fcvtzs	w8, d0
105cf5f3c: 937f7d09    	sbfiz	x9, x8, #1, #32
105cf5f40: 7100011f    	cmp	w8, #0x0
105cf5f44: da9fa120    	csinv	x0, x9, xzr, ge
105cf5f48: 947cc5eb    	bl	0x107c276f4 <_Flutter_MMFoundation_BindContext+0x3eae3c0>
105cf5f4c: aa0003f7    	mov	x23, x0
105cf5f50: 52800015    	mov	w21, #0x0               ; =0
105cf5f54: aa1403e0    	mov	x0, x20
105cf5f58: aa1703e1    	mov	x1, x23
105cf5f5c: aa1603e2    	mov	x2, x22
105cf5f60: 947c5831    	bl	0x107c0c024 <_Flutter_MMFoundation_BindContext+0x3e92cf0>
105cf5f64: 110052b5    	add	w21, w21, #0x14
105cf5f68: 7100041f    	cmp	w0, #0x1
105cf5f6c: 54ffff40    	b.eq	0x105cf5f54 <_Flutter_MMFoundation_BindContext+0x1f7cc20>
105cf5f70: aa1703e0    	mov	x0, x23
105cf5f74: 947cc5dc    	bl	0x107c276e4 <_Flutter_MMFoundation_BindContext+0x3eae3b0>
105cf5f78: aa1403e0    	mov	x0, x20
105cf5f7c: 947c5829    	bl	0x107c0c020 <_Flutter_MMFoundation_BindContext+0x3e92cec>
105cf5f80: aa1403e0    	mov	x0, x20
105cf5f84: 947c5824    	bl	0x107c0c014 <_Flutter_MMFoundation_BindContext+0x3e92ce0>
105cf5f88: 52810001    	mov	w1, #0x800              ; =2048
105cf5f8c: 947cc5d9    	bl	0x107c276f0 <_Flutter_MMFoundation_BindContext+0x3eae3bc>
105cf5f90: 14000011    	b	0x105cf5fd4 <_Flutter_MMFoundation_BindContext+0x1f7cca0>
105cf5f94: b00c80e8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105cf5f98: f9430d00    	ldr	x0, [x8, #0x618]
105cf5f9c: 900c66a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105cf5fa0: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
105cf5fa4: d00bb288    	adrp	x8, 0x11d347000 <dyld_stub_binder+0x11d347000>
105cf5fa8: 913f6108    	add	x8, x8, #0xfd8 ; CFString: invalid sampleRate
105cf5fac: f90003e8    	str	x8, [sp]
105cf5fb0: b00a2ea5    	adrp	x5, 0x11a2ca000 <dyld_stub_binder+0x11a2ca000>
105cf5fb4: 912ee0a5    	add	x5, x5, #0xbb8
105cf5fb8: d00a2ea7    	adrp	x7, 0x11a2cb000 <dyld_stub_binder+0x11a2cb000>
105cf5fbc: 9100f0e7    	add	x7, x7, #0x3c
105cf5fc0: 52800082    	mov	w2, #0x4                ; =4
105cf5fc4: d2800003    	mov	x3, #0x0                ; =0
105cf5fc8: 52800004    	mov	w4, #0x0                ; =0
105cf5fcc: 52805306    	mov	w6, #0x298              ; =664
105cf5fd0: 947cc725    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105cf5fd4: aa1303e0    	mov	x0, x19
105cf5fd8: 947cc726    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105cf5fdc: aa1503e0    	mov	x0, x21
105cf5fe0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
105cf5fe4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
105cf5fe8: a94257f6    	ldp	x22, x21, [sp, #0x20]
105cf5fec: a9415ff8    	ldp	x24, x23, [sp, #0x10]
105cf5ff0: 910143ff    	add	sp, sp, #0x50
105cf5ff4: d65f03c0    	ret
