
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1003229b4: d10683ff    	sub	sp, sp, #0x1a0
1003229b8: 6d1323e9    	stp	d9, d8, [sp, #0x130]
1003229bc: a9146ffc    	stp	x28, x27, [sp, #0x140]
1003229c0: a91567fa    	stp	x26, x25, [sp, #0x150]
1003229c4: a9165ff8    	stp	x24, x23, [sp, #0x160]
1003229c8: a91757f6    	stp	x22, x21, [sp, #0x170]
1003229cc: a9184ff4    	stp	x20, x19, [sp, #0x180]
1003229d0: a9197bfd    	stp	x29, x30, [sp, #0x190]
1003229d4: 910643fd    	add	x29, sp, #0x190
1003229d8: 4ea01c08    	mov.16b	v8, v0
1003229dc: d00ea148    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1003229e0: f9451908    	ldr	x8, [x8, #0xa30]
1003229e4: f9400108    	ldr	x8, [x8]
1003229e8: f81903a8    	stur	x8, [x29, #-0x70]
1003229ec: d00fa0e8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1003229f0: 52800029    	mov	w9, #0x1                ; =1
1003229f4: 3929f509    	strb	w9, [x8, #0xa7d]
1003229f8: 900f52e8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
1003229fc: b98d5509    	ldrsw	x9, [x8, #0xd54]
100322a00: 38696808    	ldrb	w8, [x0, x9]
100322a04: 52000108    	eor	w8, w8, #0x1
100322a08: a90083e9    	stp	x9, x0, [sp, #0x8]
100322a0c: 38296808    	strb	w8, [x0, x9]
100322a10: 4f00e400    	movi.16b	v0, #0x0
100322a14: ad0103e0    	stp	q0, q0, [sp, #0x20]
100322a18: ad0203e0    	stp	q0, q0, [sp, #0x40]
100322a1c: 900f52e8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
100322a20: b98cf508    	ldrsw	x8, [x8, #0xcf4]
100322a24: f8686814    	ldr	x20, [x0, x8]
100322a28: aa1403e0    	mov	x0, x20
100322a2c: 95e41492    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100322a30: 900f4c28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100322a34: f9442d01    	ldr	x1, [x8, #0x858]
100322a38: 910083e2    	add	x2, sp, #0x20
100322a3c: 910283e3    	add	x3, sp, #0xa0
100322a40: f9000fe1    	str	x1, [sp, #0x18]
100322a44: 52800204    	mov	w4, #0x10               ; =16
100322a48: 95e41487    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322a4c: b4000600    	cbz	x0, 0x100322b0c <__text+0x31ab0c>
100322a50: aa0003f7    	mov	x23, x0
100322a54: f9401be8    	ldr	x8, [sp, #0x30]
100322a58: f9400113    	ldr	x19, [x8]
100322a5c: f00f4f9c    	adrp	x28, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
100322a60: d2800015    	mov	x21, #0x0               ; =0
100322a64: 900f4c28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100322a68: f9428516    	ldr	x22, [x8, #0x508]
100322a6c: d00f4c28    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100322a70: f9444918    	ldr	x24, [x8, #0x890]
100322a74: f00f3568    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
100322a78: f9436d19    	ldr	x25, [x8, #0x6d8]
100322a7c: b00f3568    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
100322a80: f9421d1a    	ldr	x26, [x8, #0x438]
100322a84: f9401be8    	ldr	x8, [sp, #0x30]
100322a88: f9400108    	ldr	x8, [x8]
100322a8c: eb13011f    	cmp	x8, x19
100322a90: 54000060    	b.eq	0x100322a9c <__text+0x31aa9c>
100322a94: aa1403e0    	mov	x0, x20
100322a98: 95e41469    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
100322a9c: f94017e8    	ldr	x8, [sp, #0x28]
100322aa0: f875791b    	ldr	x27, [x8, x21, lsl #3]
100322aa4: f9432b80    	ldr	x0, [x28, #0x650]
100322aa8: aa1603e1    	mov	x1, x22
100322aac: 95e4146e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322ab0: aa0003e2    	mov	x2, x0
100322ab4: aa1b03e0    	mov	x0, x27
100322ab8: aa1803e1    	mov	x1, x24
100322abc: 95e4146a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322ac0: 340000e0    	cbz	w0, 0x100322adc <__text+0x31aadc>
100322ac4: aa1b03e0    	mov	x0, x27
100322ac8: aa1903e1    	mov	x1, x25
100322acc: 95e41466    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322ad0: aa1b03e0    	mov	x0, x27
100322ad4: aa1a03e1    	mov	x1, x26
100322ad8: 95e41463    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322adc: 910006b5    	add	x21, x21, #0x1
100322ae0: eb1502ff    	cmp	x23, x21
100322ae4: 54fffd01    	b.ne	0x100322a84 <__text+0x31aa84>
100322ae8: 910083e2    	add	x2, sp, #0x20
100322aec: 910283e3    	add	x3, sp, #0xa0
100322af0: aa1403e0    	mov	x0, x20
100322af4: f9400fe1    	ldr	x1, [sp, #0x18]
100322af8: 52800204    	mov	w4, #0x10               ; =16
100322afc: 95e4145a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322b00: aa0003f7    	mov	x23, x0
100322b04: b5fffae0    	cbnz	x0, 0x100322a60 <__text+0x31aa60>
100322b08: 14000003    	b	0x100322b14 <__text+0x31ab14>
100322b0c: 900f4c28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100322b10: f9428516    	ldr	x22, [x8, #0x508]
100322b14: aa1403e0    	mov	x0, x20
100322b18: 95e41456    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322b1c: 900f4f88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100322b20: f943c100    	ldr	x0, [x8, #0x780]
100322b24: f00f3528    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100322b28: f9440101    	ldr	x1, [x8, #0x800]
100322b2c: 95e4144e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322b30: aa1d03fd    	mov	x29, x29
100322b34: 95e41453    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322b38: aa0003f4    	mov	x20, x0
100322b3c: 900f4f88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100322b40: f9460900    	ldr	x0, [x8, #0xc10]
100322b44: aa1603e1    	mov	x1, x22
100322b48: 95e41447    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322b4c: aa0003e2    	mov	x2, x0
100322b50: f00f3528    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100322b54: f9452101    	ldr	x1, [x8, #0xa40]
100322b58: aa1403e0    	mov	x0, x20
100322b5c: 95e41442    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322b60: aa1d03fd    	mov	x29, x29
100322b64: 95e41447    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322b68: aa0003f5    	mov	x21, x0
100322b6c: f00e63e8    	adrp	x8, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
100322b70: 9112e108    	add	x8, x8, #0x4b8
100322b74: b00e6509    	adrp	x9, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
100322b78: 91096129    	add	x9, x9, #0x258
100322b7c: f90043e9    	str	x9, [sp, #0x80]
100322b80: f00e63e9    	adrp	x9, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
100322b84: 911a6129    	add	x9, x9, #0x698
100322b88: a90627e8    	stp	x8, x9, [sp, #0x60]
100322b8c: d00f3588    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
100322b90: f946f501    	ldr	x1, [x8, #0xde8]
100322b94: f9400bf3    	ldr	x19, [sp, #0x10]
100322b98: aa1303e0    	mov	x0, x19
100322b9c: 95e41432    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322ba0: aa1d03fd    	mov	x29, x29
100322ba4: 95e41437    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322ba8: aa0003f6    	mov	x22, x0
100322bac: b00f3548    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100322bb0: f9431101    	ldr	x1, [x8, #0x620]
100322bb4: 95e4142c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322bb8: aa1d03fd    	mov	x29, x29
100322bbc: 95e41431    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322bc0: aa0003f7    	mov	x23, x0
100322bc4: f90047e0    	str	x0, [sp, #0x88]
100322bc8: b00e6508    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
100322bcc: 9109e108    	add	x8, x8, #0x278
100322bd0: f9003be8    	str	x8, [sp, #0x70]
100322bd4: f94007e8    	ldr	x8, [sp, #0x8]
100322bd8: 38686a68    	ldrb	w8, [x19, x8]
100322bdc: 900f4f98    	adrp	x24, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100322be0: f9436300    	ldr	x0, [x24, #0x6c0]
100322be4: f00f4c29    	adrp	x9, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100322be8: f942d521    	ldr	x1, [x9, #0x5a8]
100322bec: 7100011f    	cmp	w8, #0x0
100322bf0: 52800028    	mov	w8, #0x1                ; =1
100322bf4: 1a881502    	cinc	w2, w8, eq
100322bf8: 95e4141b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322bfc: aa1d03fd    	mov	x29, x29
100322c00: 95e41420    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322c04: aa0003f3    	mov	x19, x0
100322c08: f9004be0    	str	x0, [sp, #0x90]
100322c0c: b00e6508    	adrp	x8, 0x11cfc3000 <dyld_stub_binder+0x11cfc3000>
100322c10: 910a6108    	add	x8, x8, #0x298
100322c14: f9003fe8    	str	x8, [sp, #0x78]
100322c18: f9436300    	ldr	x0, [x24, #0x6c0]
100322c1c: f00f4c28    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100322c20: f942cd01    	ldr	x1, [x8, #0x598]
100322c24: 4ea81d00    	mov.16b	v0, v8
100322c28: 95e4140f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322c2c: aa1d03fd    	mov	x29, x29
100322c30: 95e41414    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322c34: aa0003f8    	mov	x24, x0
100322c38: f9004fe0    	str	x0, [sp, #0x98]
100322c3c: 900f4f88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100322c40: f9434d00    	ldr	x0, [x8, #0x698]
100322c44: 900f4c28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100322c48: f947e101    	ldr	x1, [x8, #0xfc0]
100322c4c: 910203e2    	add	x2, sp, #0x80
100322c50: 910183e3    	add	x3, sp, #0x60
100322c54: 52800084    	mov	w4, #0x4                ; =4
100322c58: 95e41403    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322c5c: aa1d03fd    	mov	x29, x29
100322c60: 95e41408    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100322c64: aa0003f9    	mov	x25, x0
100322c68: b00f3548    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100322c6c: f9471d01    	ldr	x1, [x8, #0xe38]
100322c70: f00e63e2    	adrp	x2, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
100322c74: 91126042    	add	x2, x2, #0x498
100322c78: aa1503e0    	mov	x0, x21
100322c7c: d2800003    	mov	x3, #0x0                ; =0
100322c80: aa1903e4    	mov	x4, x25
100322c84: 52915305    	mov	w5, #0x8a98             ; =35480
100322c88: 95e413f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100322c8c: aa1903e0    	mov	x0, x25
100322c90: 95e413f8    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322c94: aa1803e0    	mov	x0, x24
100322c98: 95e413f6    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322c9c: aa1303e0    	mov	x0, x19
100322ca0: 95e413f4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322ca4: aa1703e0    	mov	x0, x23
100322ca8: 95e413f2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322cac: aa1603e0    	mov	x0, x22
100322cb0: 95e413f0    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322cb4: aa1503e0    	mov	x0, x21
100322cb8: 95e413ee    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322cbc: aa1403e0    	mov	x0, x20
100322cc0: 95e413ec    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100322cc4: f85903a8    	ldur	x8, [x29, #-0x70]
100322cc8: d00ea149    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100322ccc: f9451929    	ldr	x9, [x9, #0xa30]
100322cd0: f9400129    	ldr	x9, [x9]
100322cd4: eb08013f    	cmp	x9, x8
100322cd8: 54000141    	b.ne	0x100322d00 <__text+0x31ad00>
100322cdc: a9597bfd    	ldp	x29, x30, [sp, #0x190]
100322ce0: a9584ff4    	ldp	x20, x19, [sp, #0x180]
100322ce4: a95757f6    	ldp	x22, x21, [sp, #0x170]
100322ce8: a9565ff8    	ldp	x24, x23, [sp, #0x160]
100322cec: a95567fa    	ldp	x26, x25, [sp, #0x150]
100322cf0: a9546ffc    	ldp	x28, x27, [sp, #0x140]
100322cf4: 6d5323e9    	ldp	d9, d8, [sp, #0x130]
100322cf8: 910683ff    	add	sp, sp, #0x1a0
100322cfc: d65f03c0    	ret
100322d00: 95e4128c    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
