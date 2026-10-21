
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104e9dc84: d10143ff    	sub	sp, sp, #0x50
104e9dc88: a9015ff8    	stp	x24, x23, [sp, #0x10]
104e9dc8c: a90257f6    	stp	x22, x21, [sp, #0x20]
104e9dc90: a9034ff4    	stp	x20, x19, [sp, #0x30]
104e9dc94: a9047bfd    	stp	x29, x30, [sp, #0x40]
104e9dc98: 910103fd    	add	x29, sp, #0x40
104e9dc9c: d00ded08    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104e9dca0: 52800037    	mov	w23, #0x1               ; =1
104e9dca4: 39076917    	strb	w23, [x8, #0x1da]
104e9dca8: 900d9948    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104e9dcac: f9465d08    	ldr	x8, [x8, #0xcb8]
104e9dcb0: a90023e0    	stp	x0, x8, [sp]
104e9dcb4: b00d9328    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104e9dcb8: f9466901    	ldr	x1, [x8, #0xcd0] ; init
104e9dcbc: 910003e0    	mov	x0, sp
104e9dcc0: 94b62521    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104e9dcc4: aa0003f3    	mov	x19, x0
104e9dcc8: b4001600    	cbz	x0, 0x104e9df88 <_Flutter_MMFoundation_BindContext+0x1379b6c>
104e9dccc: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dcd0: b9880908    	ldrsw	x8, [x8, #0x808]
104e9dcd4: 38286a7f    	strb	wzr, [x19, x8]
104e9dcd8: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dcdc: b9880d08    	ldrsw	x8, [x8, #0x80c]
104e9dce0: 38286a7f    	strb	wzr, [x19, x8]
104e9dce4: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dce8: b9881108    	ldrsw	x8, [x8, #0x810]
104e9dcec: 38286a7f    	strb	wzr, [x19, x8]
104e9dcf0: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dcf4: b9881508    	ldrsw	x8, [x8, #0x814]
104e9dcf8: f8686a60    	ldr	x0, [x19, x8]
104e9dcfc: f8286a7f    	str	xzr, [x19, x8]
104e9dd00: 94b62515    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dd04: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dd08: b9881908    	ldrsw	x8, [x8, #0x818]
104e9dd0c: f8686a60    	ldr	x0, [x19, x8]
104e9dd10: f8286a7f    	str	xzr, [x19, x8]
104e9dd14: 94b62510    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dd18: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dd1c: b9881d08    	ldrsw	x8, [x8, #0x81c]
104e9dd20: f8686a60    	ldr	x0, [x19, x8]
104e9dd24: f8286a7f    	str	xzr, [x19, x8]
104e9dd28: 94b6250b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dd2c: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dd30: b9882108    	ldrsw	x8, [x8, #0x820]
104e9dd34: f8686a60    	ldr	x0, [x19, x8]
104e9dd38: f8286a7f    	str	xzr, [x19, x8]
104e9dd3c: 94b62506    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dd40: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dd44: b9882508    	ldrsw	x8, [x8, #0x824]
104e9dd48: f8286a7f    	str	xzr, [x19, x8]
104e9dd4c: d00d7f68    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
104e9dd50: f9460901    	ldr	x1, [x8, #0xc10] ; setM_bKeepCurViewAfterSelect:
104e9dd54: aa1303e0    	mov	x0, x19
104e9dd58: 52800002    	mov	w2, #0x0                ; =0
104e9dd5c: 94b624f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9dd60: d00d96b4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104e9dd64: f9454280    	ldr	x0, [x20, #0xa80]
104e9dd68: 94b624fc    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104e9dd6c: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dd70: b9882909    	ldrsw	x9, [x8, #0x828]
104e9dd74: f8696a68    	ldr	x8, [x19, x9]
104e9dd78: f8296a60    	str	x0, [x19, x9]
104e9dd7c: aa0803e0    	mov	x0, x8
104e9dd80: 94b624f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dd84: f9454280    	ldr	x0, [x20, #0xa80]
104e9dd88: 94b624f4    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104e9dd8c: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dd90: b9882d09    	ldrsw	x9, [x8, #0x82c]
104e9dd94: f8696a68    	ldr	x8, [x19, x9]
104e9dd98: f8296a60    	str	x0, [x19, x9]
104e9dd9c: aa0803e0    	mov	x0, x8
104e9dda0: 94b624ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dda4: f9454280    	ldr	x0, [x20, #0xa80]
104e9dda8: 94b624ec    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104e9ddac: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9ddb0: b9883109    	ldrsw	x9, [x8, #0x830]
104e9ddb4: f8696a68    	ldr	x8, [x19, x9]
104e9ddb8: f8296a60    	str	x0, [x19, x9]
104e9ddbc: aa0803e0    	mov	x0, x8
104e9ddc0: 94b624e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9ddc4: d00d7ce8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104e9ddc8: f945d101    	ldr	x1, [x8, #0xba0] ; setM_scene:
104e9ddcc: aa1303e0    	mov	x0, x19
104e9ddd0: 52800382    	mov	w2, #0x1c               ; =28
104e9ddd4: 94b624da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ddd8: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9dddc: b9883508    	ldrsw	x8, [x8, #0x834]
104e9dde0: f8286a77    	str	x23, [x19, x8]
104e9dde4: d00d7f28    	adrp	x8, 0x11fe83000 <dyld_stub_binder+0x11fe83000>
104e9dde8: f9436101    	ldr	x1, [x8, #0x6c0] ; setUseNewSearchControllerAndBottomBar:
104e9ddec: aa1303e0    	mov	x0, x19
104e9ddf0: 52800022    	mov	w2, #0x1                ; =1
104e9ddf4: 94b624d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ddf8: d00d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9ddfc: f9468d00    	ldr	x0, [x8, #0xd18]
104e9de00: f00d7ce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104e9de04: f9412501    	ldr	x1, [x8, #0x248] ; isVisionPro
104e9de08: 94b624cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9de0c: 7100001f    	cmp	w0, #0x0
104e9de10: d2e80988    	mov	x8, #0x404c000000000000 ; =4633078116657397760
104e9de14: 9e670100    	fmov	d0, x8
104e9de18: d2e80ae8    	mov	x8, #0x4057000000000000 ; =4636174341401214976
104e9de1c: 9e670101    	fmov	d1, x8
104e9de20: 1e601c20    	fcsel	d0, d1, d0, ne
104e9de24: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9de28: b9883908    	ldrsw	x8, [x8, #0x838]
104e9de2c: fc286a60    	str	d0, [x19, x8]
104e9de30: d00d96a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104e9de34: f9455500    	ldr	x0, [x8, #0xaa8]
104e9de38: d00d9308    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104e9de3c: f941a101    	ldr	x1, [x8, #0x340] ; array
104e9de40: 94b624bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9de44: aa1d03fd    	mov	x29, x29
104e9de48: 94b624c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9de4c: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9de50: b9883d09    	ldrsw	x9, [x8, #0x83c]
104e9de54: f8696a68    	ldr	x8, [x19, x9]
104e9de58: f8296a60    	str	x0, [x19, x9]
104e9de5c: aa0803e0    	mov	x0, x8
104e9de60: 94b624bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9de64: d00d96b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104e9de68: f945eb00    	ldr	x0, [x24, #0xbd0]
104e9de6c: f00d9308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104e9de70: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
104e9de74: aa1403e1    	mov	x1, x20
104e9de78: 94b624b1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9de7c: aa1d03fd    	mov	x29, x29
104e9de80: 94b624b2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9de84: aa0003f5    	mov	x21, x0
104e9de88: f00d9688    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104e9de8c: f9453502    	ldr	x2, [x8, #0xa68]
104e9de90: b00d7ce8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104e9de94: f940a116    	ldr	x22, [x8, #0x140] ; registerExtension:withTarget:
104e9de98: aa1603e1    	mov	x1, x22
104e9de9c: aa1303e3    	mov	x3, x19
104e9dea0: 94b624a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9dea4: aa1503e0    	mov	x0, x21
104e9dea8: 94b624ab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9deac: f945eb00    	ldr	x0, [x24, #0xbd0]
104e9deb0: aa1403e1    	mov	x1, x20
104e9deb4: 94b624a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9deb8: aa1d03fd    	mov	x29, x29
104e9debc: 94b624a3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9dec0: aa0003f4    	mov	x20, x0
104e9dec4: f00d9688    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104e9dec8: f9453902    	ldr	x2, [x8, #0xa70]
104e9decc: aa1603e1    	mov	x1, x22
104e9ded0: aa1303e3    	mov	x3, x19
104e9ded4: 94b6249a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9ded8: aa1403e0    	mov	x0, x20
104e9dedc: 94b6249e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9dee0: d00d96b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104e9dee4: f9458f00    	ldr	x0, [x24, #0xb18]
104e9dee8: f00d9308    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104e9deec: f946b114    	ldr	x20, [x8, #0xd60] ; defaultCenter
104e9def0: aa1403e1    	mov	x1, x20
104e9def4: 94b62492    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9def8: aa1d03fd    	mov	x29, x29
104e9defc: 94b62493    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9df00: aa0003f5    	mov	x21, x0
104e9df04: 900d7d08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104e9df08: f9469903    	ldr	x3, [x8, #0xd30] ; keyboardWillShow:
104e9df0c: f00c3a68    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
104e9df10: f941b508    	ldr	x8, [x8, #0x368]
104e9df14: f9400104    	ldr	x4, [x8]
104e9df18: b00d9308    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104e9df1c: f9470116    	ldr	x22, [x8, #0xe00] ; addObserver:selector:name:object:
104e9df20: aa1603e1    	mov	x1, x22
104e9df24: aa1303e2    	mov	x2, x19
104e9df28: d2800005    	mov	x5, #0x0                ; =0
104e9df2c: 94b62484    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9df30: aa1503e0    	mov	x0, x21
104e9df34: 94b62488    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9df38: f9458f00    	ldr	x0, [x24, #0xb18]
104e9df3c: aa1403e1    	mov	x1, x20
104e9df40: 94b6247f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9df44: aa1d03fd    	mov	x29, x29
104e9df48: 94b62480    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104e9df4c: aa0003f4    	mov	x20, x0
104e9df50: 900d7d08    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104e9df54: f9469d03    	ldr	x3, [x8, #0xd38] ; keyboardWillHide:
104e9df58: f00c3a68    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
104e9df5c: f941b108    	ldr	x8, [x8, #0x360]
104e9df60: f9400104    	ldr	x4, [x8]
104e9df64: aa1603e1    	mov	x1, x22
104e9df68: aa1303e2    	mov	x2, x19
104e9df6c: d2800005    	mov	x5, #0x0                ; =0
104e9df70: 94b62473    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104e9df74: aa1403e0    	mov	x0, x20
104e9df78: 94b62477    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104e9df7c: b00d9c48    	adrp	x8, 0x120226000 <dyld_stub_binder+0x120226000>
104e9df80: b9884108    	ldrsw	x8, [x8, #0x840]
104e9df84: 38286a77    	strb	w23, [x19, x8]
104e9df88: aa1303e0    	mov	x0, x19
104e9df8c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104e9df90: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104e9df94: a94257f6    	ldp	x22, x21, [sp, #0x20]
104e9df98: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104e9df9c: 910143ff    	add	sp, sp, #0x50
104e9dfa0: d65f03c0    	ret
