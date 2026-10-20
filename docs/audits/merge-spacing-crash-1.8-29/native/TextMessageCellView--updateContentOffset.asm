
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105bf89e0: d10283ff    	sub	sp, sp, #0xa0
105bf89e4: 6d0133ed    	stp	d13, d12, [sp, #0x10]
105bf89e8: 6d022beb    	stp	d11, d10, [sp, #0x20]
105bf89ec: 6d0323e9    	stp	d9, d8, [sp, #0x30]
105bf89f0: a9046ffc    	stp	x28, x27, [sp, #0x40]
105bf89f4: a90567fa    	stp	x26, x25, [sp, #0x50]
105bf89f8: a9065ff8    	stp	x24, x23, [sp, #0x60]
105bf89fc: a90757f6    	stp	x22, x21, [sp, #0x70]
105bf8a00: a9084ff4    	stp	x20, x19, [sp, #0x80]
105bf8a04: a9097bfd    	stp	x29, x30, [sp, #0x90]
105bf8a08: 910243fd    	add	x29, sp, #0x90
105bf8a0c: aa0003f4    	mov	x20, x0
105bf8a10: d00d8248    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105bf8a14: 52800029    	mov	w9, #0x1                ; =1
105bf8a18: 390e9109    	strb	w9, [x8, #0x3a4]
105bf8a1c: d00d1e28    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105bf8a20: f9400d01    	ldr	x1, [x8, #0x18] ; shouldAutoScrollUp
105bf8a24: 9480b9c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8a28: 34001720    	cbz	w0, 0x105bf8d0c <_Flutter_MMFoundation_BindContext+0x20d48f0>
105bf8a2c: d00d1228    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105bf8a30: f9410915    	ldr	x21, [x8, #0x210] ; viewModel
105bf8a34: aa1403e0    	mov	x0, x20
105bf8a38: aa1503e1    	mov	x1, x21
105bf8a3c: 9480b9c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8a40: aa1d03fd    	mov	x29, x29
105bf8a44: 9480b9c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8a48: aa0003f6    	mov	x22, x0
105bf8a4c: 900d2848    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105bf8a50: f946f101    	ldr	x1, [x8, #0xde0] ; delegate
105bf8a54: 9480b9ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8a58: aa1d03fd    	mov	x29, x29
105bf8a5c: 9480b9bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8a60: aa0003f3    	mov	x19, x0
105bf8a64: aa1603e0    	mov	x0, x22
105bf8a68: 9480b9bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8a6c: f00d2f28    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
105bf8a70: 910a8108    	add	x8, x8, #0x2a0
105bf8a74: b9800117    	ldrsw	x23, [x8]
105bf8a78: f8776a80    	ldr	x0, [x20, x23]
105bf8a7c: d00d2888    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105bf8a80: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
105bf8a84: 9480b9ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8a88: aa1d03fd    	mov	x29, x29
105bf8a8c: 9480b9af    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8a90: aa0003f6    	mov	x22, x0
105bf8a94: f8776a80    	ldr	x0, [x20, x23]
105bf8a98: b00d2848    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105bf8a9c: f945a101    	ldr	x1, [x8, #0xb40] ; frame
105bf8aa0: 9480b9a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8aa4: 1e604008    	fmov	d8, d0
105bf8aa8: 1e604029    	fmov	d9, d1
105bf8aac: 1e60404a    	fmov	d10, d2
105bf8ab0: 1e60406b    	fmov	d11, d3
105bf8ab4: f00d2888    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105bf8ab8: f946d501    	ldr	x1, [x8, #0xda8] ; view
105bf8abc: aa1303e0    	mov	x0, x19
105bf8ac0: 9480b99f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8ac4: aa1d03fd    	mov	x29, x29
105bf8ac8: 9480b9a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8acc: aa0003f7    	mov	x23, x0
105bf8ad0: 900d2848    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105bf8ad4: f942e501    	ldr	x1, [x8, #0x5c8] ; convertRect:toView:
105bf8ad8: aa1603e0    	mov	x0, x22
105bf8adc: 1e604100    	fmov	d0, d8
105bf8ae0: 1e604121    	fmov	d1, d9
105bf8ae4: 1e604142    	fmov	d2, d10
105bf8ae8: 1e604163    	fmov	d3, d11
105bf8aec: aa1703e2    	mov	x2, x23
105bf8af0: 9480b993    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8af4: 1e604008    	fmov	d8, d0
105bf8af8: 1e604029    	fmov	d9, d1
105bf8afc: 1e60404a    	fmov	d10, d2
105bf8b00: 1e60406b    	fmov	d11, d3
105bf8b04: aa1703e0    	mov	x0, x23
105bf8b08: 9480b993    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8b0c: aa1603e0    	mov	x0, x22
105bf8b10: 9480b991    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8b14: aa1403e0    	mov	x0, x20
105bf8b18: aa1503e1    	mov	x1, x21
105bf8b1c: 9480b988    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8b20: aa1d03fd    	mov	x29, x29
105bf8b24: 9480b989    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8b28: aa0003f7    	mov	x23, x0
105bf8b2c: d00d15c8    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
105bf8b30: f942c918    	ldr	x24, [x8, #0x590] ; translateInfo
105bf8b34: aa1803e1    	mov	x1, x24
105bf8b38: 9480b981    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8b3c: aa1d03fd    	mov	x29, x29
105bf8b40: 9480b982    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8b44: aa0003f6    	mov	x22, x0
105bf8b48: aa1703e0    	mov	x0, x23
105bf8b4c: 9480b982    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8b50: 1e602148    	fcmp	d10, #0.0
105bf8b54: 54000f20    	b.eq	0x105bf8d38 <_Flutter_MMFoundation_BindContext+0x20d491c>
105bf8b58: 1e602168    	fcmp	d11, #0.0
105bf8b5c: 54000ee0    	b.eq	0x105bf8d38 <_Flutter_MMFoundation_BindContext+0x20d491c>
105bf8b60: aa1403e0    	mov	x0, x20
105bf8b64: aa1503e1    	mov	x1, x21
105bf8b68: 9480b975    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8b6c: aa1d03fd    	mov	x29, x29
105bf8b70: 9480b976    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8b74: aa0003f7    	mov	x23, x0
105bf8b78: aa1803e1    	mov	x1, x24
105bf8b7c: 9480b970    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8b80: aa1d03fd    	mov	x29, x29
105bf8b84: 9480b971    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8b88: aa0003f8    	mov	x24, x0
105bf8b8c: d00d1e28    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105bf8b90: f9401101    	ldr	x1, [x8, #0x20] ; autoScrollUpCount
105bf8b94: 9480b96a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8b98: 7100001f    	cmp	w0, #0x0
105bf8b9c: 54000f6d    	b.le	0x105bf8d88 <_Flutter_MMFoundation_BindContext+0x20d496c>
105bf8ba0: d00d31c8    	adrp	x8, 0x120232000 <dyld_stub_binder+0x120232000>
105bf8ba4: b98fc108    	ldrsw	x8, [x8, #0xfc0]
105bf8ba8: f8686a80    	ldr	x0, [x20, x8]
105bf8bac: d00d2848    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105bf8bb0: f9449d01    	ldr	x1, [x8, #0x938] ; height
105bf8bb4: 9480b962    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8bb8: 1e60400c    	fmov	d12, d0
105bf8bbc: 900d2be8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105bf8bc0: f9403d1a    	ldr	x26, [x8, #0x78] ; 8�6 
105bf8bc4: f00d2bc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105bf8bc8: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105bf8bcc: 900d2848    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105bf8bd0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105bf8bd4: 9480b95a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8bd8: aa1d03fd    	mov	x29, x29
105bf8bdc: 9480b95b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8be0: aa0003f9    	mov	x25, x0
105bf8be4: 900d2be8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105bf8be8: f9404100    	ldr	x0, [x8, #0x80]
105bf8bec: f00d2828    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105bf8bf0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105bf8bf4: 9480b952    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8bf8: aa0003e2    	mov	x2, x0
105bf8bfc: b00d1208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105bf8c00: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105bf8c04: aa1903e0    	mov	x0, x25
105bf8c08: 9480b94d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8c0c: aa1d03fd    	mov	x29, x29
105bf8c10: 9480b94e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8c14: aa0003fb    	mov	x27, x0
105bf8c18: f00d1208    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105bf8c1c: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
105bf8c20: b00c4582    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
105bf8c24: 912ca042    	add	x2, x2, #0xb28
105bf8c28: d00c4563    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
105bf8c2c: 9124a063    	add	x3, x3, #0x928
105bf8c30: 9480b943    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8c34: aa1d03fd    	mov	x29, x29
105bf8c38: 9480b944    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8c3c: aa0003fc    	mov	x28, x0
105bf8c40: 900d1228    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105bf8c44: f9400101    	ldr	x1, [x8]
105bf8c48: aa1a03e0    	mov	x0, x26
105bf8c4c: aa1c03e2    	mov	x2, x28
105bf8c50: 9480b93b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8c54: 1e60400d    	fmov	d13, d0
105bf8c58: f00d2bc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105bf8c5c: f9461900    	ldr	x0, [x8, #0xc30]
105bf8c60: b00d1228    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105bf8c64: f9473101    	ldr	x1, [x8, #0xe60] ; systemFont
105bf8c68: 9480b935    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8c6c: aa1d03fd    	mov	x29, x29
105bf8c70: 9480b936    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8c74: aa0003fa    	mov	x26, x0
105bf8c78: f00d1208    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105bf8c7c: f947ed01    	ldr	x1, [x8, #0xfd8] ; lineHeight
105bf8c80: 9480b92f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8c84: 1e64c000    	frintp	d0, d0
105bf8c88: 1e601001    	fmov	d1, #2.00000000
105bf8c8c: 1f4101ad    	fmadd	d13, d13, d1, d0
105bf8c90: aa1a03e0    	mov	x0, x26
105bf8c94: 9480b930    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8c98: aa1c03e0    	mov	x0, x28
105bf8c9c: 9480b92e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8ca0: aa1b03e0    	mov	x0, x27
105bf8ca4: 9480b92c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8ca8: aa1903e0    	mov	x0, x25
105bf8cac: 9480b92a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8cb0: aa1803e0    	mov	x0, x24
105bf8cb4: 9480b928    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8cb8: aa1703e0    	mov	x0, x23
105bf8cbc: 9480b926    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8cc0: 1e6d2180    	fcmp	d12, d13
105bf8cc4: 540006a1    	b.ne	0x105bf8d98 <_Flutter_MMFoundation_BindContext+0x20d497c>
105bf8cc8: f00d2bc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105bf8ccc: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
105bf8cd0: b00d1208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105bf8cd4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105bf8cd8: f00c6228    	adrp	x8, 0x11e83f000 <dyld_stub_binder+0x11e83f000>
105bf8cdc: 910a2108    	add	x8, x8, #0x288
105bf8ce0: f90003e8    	str	x8, [sp]
105bf8ce4: d00ae965    	adrp	x5, 0x11b926000 <dyld_stub_binder+0x11b926000>
105bf8ce8: 910c74a5    	add	x5, x5, #0x31d
105bf8cec: d00ae967    	adrp	x7, 0x11b926000 <dyld_stub_binder+0x11b926000>
105bf8cf0: 910e78e7    	add	x7, x7, #0x39e
105bf8cf4: 52800042    	mov	w2, #0x2                ; =2
105bf8cf8: d2800003    	mov	x3, #0x0                ; =0
105bf8cfc: 52800004    	mov	w4, #0x0                ; =0
105bf8d00: 528056e6    	mov	w6, #0x2b7              ; =695
105bf8d04: 9480b90e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8d08: 14000034    	b	0x105bf8dd8 <_Flutter_MMFoundation_BindContext+0x20d49bc>
105bf8d0c: a9497bfd    	ldp	x29, x30, [sp, #0x90]
105bf8d10: a9484ff4    	ldp	x20, x19, [sp, #0x80]
105bf8d14: a94757f6    	ldp	x22, x21, [sp, #0x70]
105bf8d18: a9465ff8    	ldp	x24, x23, [sp, #0x60]
105bf8d1c: a94567fa    	ldp	x26, x25, [sp, #0x50]
105bf8d20: a9446ffc    	ldp	x28, x27, [sp, #0x40]
105bf8d24: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
105bf8d28: 6d422beb    	ldp	d11, d10, [sp, #0x20]
105bf8d2c: 6d4133ed    	ldp	d13, d12, [sp, #0x10]
105bf8d30: 910283ff    	add	sp, sp, #0xa0
105bf8d34: d65f03c0    	ret
105bf8d38: f00d2bc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105bf8d3c: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
105bf8d40: b00d1208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105bf8d44: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
105bf8d48: f00c6228    	adrp	x8, 0x11e83f000 <dyld_stub_binder+0x11e83f000>
105bf8d4c: 9109a108    	add	x8, x8, #0x268
105bf8d50: f90003e8    	str	x8, [sp]
105bf8d54: d00ae965    	adrp	x5, 0x11b926000 <dyld_stub_binder+0x11b926000>
105bf8d58: 910c74a5    	add	x5, x5, #0x31d
105bf8d5c: d00ae967    	adrp	x7, 0x11b926000 <dyld_stub_binder+0x11b926000>
105bf8d60: 910e78e7    	add	x7, x7, #0x39e
105bf8d64: 52800042    	mov	w2, #0x2                ; =2
105bf8d68: d2800003    	mov	x3, #0x0                ; =0
105bf8d6c: 52800004    	mov	w4, #0x0                ; =0
105bf8d70: 52805626    	mov	w6, #0x2b1              ; =689
105bf8d74: 9480b8f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8d78: d00d15c8    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
105bf8d7c: f943c501    	ldr	x1, [x8, #0x788] ; setBAutoScrollUp:
105bf8d80: aa1603e0    	mov	x0, x22
105bf8d84: 14000018    	b	0x105bf8de4 <_Flutter_MMFoundation_BindContext+0x20d49c8>
105bf8d88: aa1803e0    	mov	x0, x24
105bf8d8c: 9480b8f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8d90: aa1703e0    	mov	x0, x23
105bf8d94: 9480b8f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8d98: aa1403e0    	mov	x0, x20
105bf8d9c: aa1503e1    	mov	x1, x21
105bf8da0: 9480b8e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8da4: aa1d03fd    	mov	x29, x29
105bf8da8: 9480b8e8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105bf8dac: aa0003f5    	mov	x21, x0
105bf8db0: d00d1e28    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105bf8db4: f9401501    	ldr	x1, [x8, #0x28] ; adjustTableOffset:delayForReloadTable:
105bf8db8: 1e604100    	fmov	d0, d8
105bf8dbc: 1e604121    	fmov	d1, d9
105bf8dc0: 1e604142    	fmov	d2, d10
105bf8dc4: 1e604163    	fmov	d3, d11
105bf8dc8: 52800022    	mov	w2, #0x1                ; =1
105bf8dcc: 9480b8dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8dd0: aa1503e0    	mov	x0, x21
105bf8dd4: 9480b8e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8dd8: d00d1e28    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105bf8ddc: f9401901    	ldr	x1, [x8, #0x30] ; setShouldAutoScrollUp:
105bf8de0: aa1403e0    	mov	x0, x20
105bf8de4: 52800002    	mov	w2, #0x0                ; =0
105bf8de8: 9480b8d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105bf8dec: aa1603e0    	mov	x0, x22
105bf8df0: 9480b8d9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105bf8df4: aa1303e0    	mov	x0, x19
105bf8df8: a9497bfd    	ldp	x29, x30, [sp, #0x90]
105bf8dfc: a9484ff4    	ldp	x20, x19, [sp, #0x80]
105bf8e00: a94757f6    	ldp	x22, x21, [sp, #0x70]
105bf8e04: a9465ff8    	ldp	x24, x23, [sp, #0x60]
105bf8e08: a94567fa    	ldp	x26, x25, [sp, #0x50]
105bf8e0c: a9446ffc    	ldp	x28, x27, [sp, #0x40]
105bf8e10: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
105bf8e14: 6d422beb    	ldp	d11, d10, [sp, #0x20]
105bf8e18: 6d4133ed    	ldp	d13, d12, [sp, #0x10]
105bf8e1c: 910283ff    	add	sp, sp, #0xa0
105bf8e20: 1480b8cd    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>