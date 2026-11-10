
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106581970: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
106581974: a9014ff4    	stp	x20, x19, [sp, #0x10]
106581978: a9027bfd    	stp	x29, x30, [sp, #0x20]
10658197c: 910083fd    	add	x29, sp, #0x20
106581980: aa0003f3    	mov	x19, x0
106581984: d00c8ea8    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106581988: 52800029    	mov	w9, #0x1                ; =1
10658198c: 39084909    	strb	w9, [x8, #0x212]
106581990: b00c3fe8    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
106581994: 912b9108    	add	x8, x8, #0xae4
106581998: b9800116    	ldrsw	x22, [x8]
10658199c: 8b160000    	add	x0, x0, x22
1065819a0: 945a98af    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1065819a4: aa0003f4    	mov	x20, x0
1065819a8: d00c22c8    	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
1065819ac: f945c915    	ldr	x21, [x8, #0xb90]
1065819b0: b00c3948    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1065819b4: f9440501    	ldr	x1, [x8, #0x808]
1065819b8: aa1503e2    	mov	x2, x21
1065819bc: 945a98aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065819c0: 360001a0    	tbz	w0, #0x0, 0x1065819f4 <_Flutter_MMFoundation_BindContext+0x28086c0>
1065819c4: 8b160260    	add	x0, x19, x22
1065819c8: 945a98a5    	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
1065819cc: aa0003f6    	mov	x22, x0
1065819d0: aa1503e1    	mov	x1, x21
1065819d4: 945a98a4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1065819d8: aa0003f5    	mov	x21, x0
1065819dc: aa1603e0    	mov	x0, x22
1065819e0: 945a98a4    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065819e4: aa1403e0    	mov	x0, x20
1065819e8: 945a98a2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065819ec: 36000095    	tbz	w21, #0x0, 0x1065819fc <_Flutter_MMFoundation_BindContext+0x28086c8>
1065819f0: 14000021    	b	0x106581a74 <_Flutter_MMFoundation_BindContext+0x2808740>
1065819f4: aa1403e0    	mov	x0, x20
1065819f8: 945a989e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1065819fc: b00c3c88    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106581a00: f943c100    	ldr	x0, [x8, #0x780]
106581a04: 900c2248    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106581a08: f9440101    	ldr	x1, [x8, #0x800]
106581a0c: 945a9896    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106581a10: aa1d03fd    	mov	x29, x29
106581a14: 945a989b    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106581a18: aa0003f4    	mov	x20, x0
106581a1c: 900c3ca8    	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
106581a20: f940fd00    	ldr	x0, [x8, #0x1f8]
106581a24: b00c3928    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106581a28: f9428501    	ldr	x1, [x8, #0x508]
106581a2c: 945a988e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106581a30: aa0003e2    	mov	x2, x0
106581a34: 900c2248    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106581a38: f9452101    	ldr	x1, [x8, #0xa40]
106581a3c: aa1403e0    	mov	x0, x20
106581a40: 945a9889    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106581a44: aa1d03fd    	mov	x29, x29
106581a48: 945a988e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106581a4c: aa0003f5    	mov	x21, x0
106581a50: 900c2d68    	adrp	x8, 0x11eb2d000 <dyld_stub_binder+0x11eb2d000>
106581a54: f9462501    	ldr	x1, [x8, #0xc48]
106581a58: 945a9883    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106581a5c: aa0003f6    	mov	x22, x0
106581a60: aa1503e0    	mov	x0, x21
106581a64: 945a9883    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106581a68: aa1403e0    	mov	x0, x20
106581a6c: 945a9881    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106581a70: 360000b6    	tbz	w22, #0x0, 0x106581a84 <_Flutter_MMFoundation_BindContext+0x2808750>
106581a74: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106581a78: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106581a7c: a8c357f6    	ldp	x22, x21, [sp], #0x30
106581a80: d65f03c0    	ret
106581a84: b00c42c8    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106581a88: b98c7d08    	ldrsw	x8, [x8, #0xc7c]
106581a8c: f8686a60    	ldr	x0, [x19, x8]
106581a90: 900c3968    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
106581a94: f940ed01    	ldr	x1, [x8, #0x1d8]
106581a98: a9427bfd    	ldp	x29, x30, [sp, #0x20]
106581a9c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
106581aa0: a8c357f6    	ldp	x22, x21, [sp], #0x30
106581aa4: 145a9870    	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
