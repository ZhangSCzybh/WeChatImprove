
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10628dbd4: d10343ff    	sub	sp, sp, #0xd0
10628dbd8: 6d0433ed    	stp	d13, d12, [sp, #0x40]
10628dbdc: 6d052beb    	stp	d11, d10, [sp, #0x50]
10628dbe0: 6d0623e9    	stp	d9, d8, [sp, #0x60]
10628dbe4: a9076ffc    	stp	x28, x27, [sp, #0x70]
10628dbe8: a90867fa    	stp	x26, x25, [sp, #0x80]
10628dbec: a9095ff8    	stp	x24, x23, [sp, #0x90]
10628dbf0: a90a57f6    	stp	x22, x21, [sp, #0xa0]
10628dbf4: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
10628dbf8: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
10628dbfc: 910303fd    	add	x29, sp, #0xc0
10628dc00: f9001be0    	str	x0, [sp, #0x30]
10628dc04: d00d4da8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10628dc08: 52800029    	mov	w9, #0x1                ; =1
10628dc0c: 3928f109    	strb	w9, [x8, #0xa3c]
10628dc10: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628dc14: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
10628dc18: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628dc1c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628dc20: f00cf388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10628dc24: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10628dc28: f9001fe1    	str	x1, [sp, #0x38]
10628dc2c: 94666544    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dc30: aa1d03fd    	mov	x29, x29
10628dc34: 94666545    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dc38: aa0003fb    	mov	x27, x0
10628dc3c: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628dc40: f9404100    	ldr	x0, [x8, #0x80]
10628dc44: d00cf388    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10628dc48: f947ad17    	ldr	x23, [x8, #0xf58] ; class
10628dc4c: aa1703e1    	mov	x1, x23
10628dc50: 9466653b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dc54: aa0003e2    	mov	x2, x0
10628dc58: 900cdd68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10628dc5c: f946411a    	ldr	x26, [x8, #0xc80] ; getService:
10628dc60: aa1b03e0    	mov	x0, x27
10628dc64: aa1a03e1    	mov	x1, x26
10628dc68: 94666535    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dc6c: aa1d03fd    	mov	x29, x29
10628dc70: 94666536    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dc74: aa0003fc    	mov	x28, x0
10628dc78: d00cdd68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10628dc7c: f947fd16    	ldr	x22, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
10628dc80: 900c10e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628dc84: 912ca042    	add	x2, x2, #0xb28
10628dc88: b00c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628dc8c: 9124a063    	add	x3, x3, #0x928
10628dc90: aa1603e1    	mov	x1, x22
10628dc94: 9466652a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dc98: aa1d03fd    	mov	x29, x29
10628dc9c: 9466652b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dca0: aa0003f4    	mov	x20, x0
10628dca4: f00cdd68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10628dca8: f9400119    	ldr	x25, [x8]
10628dcac: aa1303e0    	mov	x0, x19
10628dcb0: aa1903e1    	mov	x1, x25
10628dcb4: aa1403e2    	mov	x2, x20
10628dcb8: 94666521    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dcbc: 1e604008    	fmov	d8, d0
10628dcc0: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628dcc4: f9461900    	ldr	x0, [x8, #0xc30]
10628dcc8: 900cdd88    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10628dccc: f9473118    	ldr	x24, [x8, #0xe60] ; systemFont
10628dcd0: aa1803e1    	mov	x1, x24
10628dcd4: 9466651a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dcd8: aa1d03fd    	mov	x29, x29
10628dcdc: 9466651b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dce0: aa0003f3    	mov	x19, x0
10628dce4: d00cdd68    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10628dce8: f947ed15    	ldr	x21, [x8, #0xfd8] ; lineHeight
10628dcec: aa1503e1    	mov	x1, x21
10628dcf0: 94666513    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dcf4: 1e64c000    	frintp	d0, d0
10628dcf8: 1e60100a    	fmov	d10, #2.00000000
10628dcfc: 1f4a0108    	fmadd	d8, d8, d10, d0
10628dd00: aa1303e0    	mov	x0, x19
10628dd04: 94666514    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dd08: aa1403e0    	mov	x0, x20
10628dd0c: f9401bf4    	ldr	x20, [sp, #0x30]
10628dd10: 94666511    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dd14: aa1c03e0    	mov	x0, x28
10628dd18: 9466650f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dd1c: aa1b03e0    	mov	x0, x27
10628dd20: 9466650d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dd24: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628dd28: f947f101    	ldr	x1, [x8, #0xfe0] ; canShowTranslateLoadingView
10628dd2c: aa1403e0    	mov	x0, x20
10628dd30: 94666503    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dd34: 34000700    	cbz	w0, 0x10628de14 <_Flutter_MMFoundation_BindContext+0x27699f8>
10628dd38: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628dd3c: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
10628dd40: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628dd44: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628dd48: f9401fe1    	ldr	x1, [sp, #0x38]
10628dd4c: 946664fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dd50: aa1d03fd    	mov	x29, x29
10628dd54: 946664fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dd58: aa0003fb    	mov	x27, x0
10628dd5c: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628dd60: f9404100    	ldr	x0, [x8, #0x80]
10628dd64: aa1703e1    	mov	x1, x23
10628dd68: 946664f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dd6c: aa0003e2    	mov	x2, x0
10628dd70: aa1b03e0    	mov	x0, x27
10628dd74: aa1a03e1    	mov	x1, x26
10628dd78: 946664f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dd7c: aa1d03fd    	mov	x29, x29
10628dd80: 946664f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dd84: aa0003f7    	mov	x23, x0
10628dd88: 900c10e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628dd8c: 912ca042    	add	x2, x2, #0xb28
10628dd90: b00c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628dd94: 9124a063    	add	x3, x3, #0x928
10628dd98: aa1603e1    	mov	x1, x22
10628dd9c: 946664e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dda0: aa1d03fd    	mov	x29, x29
10628dda4: 946664e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dda8: aa0003f6    	mov	x22, x0
10628ddac: aa1303e0    	mov	x0, x19
10628ddb0: aa1903e1    	mov	x1, x25
10628ddb4: aa1603e2    	mov	x2, x22
10628ddb8: 946664e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ddbc: 1e604009    	fmov	d9, d0
10628ddc0: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628ddc4: f9461900    	ldr	x0, [x8, #0xc30]
10628ddc8: aa1803e1    	mov	x1, x24
10628ddcc: 946664dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ddd0: aa1d03fd    	mov	x29, x29
10628ddd4: 946664dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628ddd8: aa0003f4    	mov	x20, x0
10628dddc: aa1503e1    	mov	x1, x21
10628dde0: 946664d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dde4: 1e64c000    	frintp	d0, d0
10628dde8: 1f4a0120    	fmadd	d0, d9, d10, d0
10628ddec: 1e602908    	fadd	d8, d8, d0
10628ddf0: aa1403e0    	mov	x0, x20
10628ddf4: 946664d8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628ddf8: aa1603e0    	mov	x0, x22
10628ddfc: 946664d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628de00: aa1703e0    	mov	x0, x23
10628de04: 946664d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628de08: aa1b03e0    	mov	x0, x27
10628de0c: 946664d2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628de10: 1400018f    	b	0x10628e44c <_Flutter_MMFoundation_BindContext+0x276a030>
10628de14: a9025ff5    	stp	x21, x23, [sp, #0x20]
10628de18: f9000ff8    	str	x24, [sp, #0x18]
10628de1c: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628de20: f9462101    	ldr	x1, [x8, #0xc40] ; canShowTranslateText
10628de24: aa1403e0    	mov	x0, x20
10628de28: 946664c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628de2c: 34003100    	cbz	w0, 0x10628e44c <_Flutter_MMFoundation_BindContext+0x276a030>
10628de30: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628de34: f9462901    	ldr	x1, [x8, #0xc50] ; isTranslateEnd
10628de38: aa1403e0    	mov	x0, x20
10628de3c: 946664c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628de40: 900ce988    	adrp	x8, 0x11ffbd000 <dyld_stub_binder+0x11ffbd000>
10628de44: 913ec108    	add	x8, x8, #0xfb0
10628de48: d00cea29    	adrp	x9, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628de4c: 913f6129    	add	x9, x9, #0xfd8
10628de50: 7100001f    	cmp	w0, #0x0
10628de54: 9a891108    	csel	x8, x8, x9, ne
10628de58: f9400101    	ldr	x1, [x8]
10628de5c: aa1403e0    	mov	x0, x20
10628de60: 946664b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628de64: 1e612908    	fadd	d8, d8, d1
10628de68: f00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628de6c: f9403d13    	ldr	x19, [x8, #0x78] ; 8�6 
10628de70: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628de74: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628de78: f9401fe1    	ldr	x1, [sp, #0x38]
10628de7c: 946664b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628de80: aa1d03fd    	mov	x29, x29
10628de84: 946664b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628de88: aa1403f8    	mov	x24, x20
10628de8c: aa0003f4    	mov	x20, x0
10628de90: f00cf737    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
10628de94: f94042e0    	ldr	x0, [x23, #0x80]
10628de98: f94017e1    	ldr	x1, [sp, #0x28]
10628de9c: 946664a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dea0: aa0003e2    	mov	x2, x0
10628dea4: aa1403e0    	mov	x0, x20
10628dea8: aa1a03e1    	mov	x1, x26
10628deac: 946664a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628deb0: aa1d03fd    	mov	x29, x29
10628deb4: 946664a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628deb8: aa0003fb    	mov	x27, x0
10628debc: 900c10e2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628dec0: 912ca042    	add	x2, x2, #0xb28
10628dec4: b00c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628dec8: 9124a063    	add	x3, x3, #0x928
10628decc: f9000bf6    	str	x22, [sp, #0x10]
10628ded0: aa1603e1    	mov	x1, x22
10628ded4: 9466649a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628ded8: aa1d03fd    	mov	x29, x29
10628dedc: 9466649b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dee0: aa0003fc    	mov	x28, x0
10628dee4: aa1303e0    	mov	x0, x19
10628dee8: aa1903f5    	mov	x21, x25
10628deec: aa1903e1    	mov	x1, x25
10628def0: aa1c03e2    	mov	x2, x28
10628def4: 94666492    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628def8: 1e60100b    	fmov	d11, #2.00000000
10628defc: 1f4b2008    	fmadd	d8, d0, d11, d8
10628df00: aa1c03e0    	mov	x0, x28
10628df04: 94666494    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628df08: aa1b03e0    	mov	x0, x27
10628df0c: 94666492    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628df10: aa1403e0    	mov	x0, x20
10628df14: aa1803f3    	mov	x19, x24
10628df18: 9466648f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628df1c: 1e62100c    	fmov	d12, #4.00000000
10628df20: 1e6c2908    	fadd	d8, d8, d12
10628df24: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628df28: f9464501    	ldr	x1, [x8, #0xc88] ; canShowTextTranslateView
10628df2c: aa1803e0    	mov	x0, x24
10628df30: 94666483    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628df34: f90007fa    	str	x26, [sp, #0x8]
10628df38: 340008c0    	cbz	w0, 0x10628e050 <_Flutter_MMFoundation_BindContext+0x2769c34>
10628df3c: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628df40: f9464d01    	ldr	x1, [x8, #0xc98] ; canShowTextTranslateText
10628df44: aa1303e0    	mov	x0, x19
10628df48: 9466647d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628df4c: 340008e0    	cbz	w0, 0x10628e068 <_Flutter_MMFoundation_BindContext+0x2769c4c>
10628df50: d00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628df54: f945d101    	ldr	x1, [x8, #0xba0] ; textTranslateInfo
10628df58: aa1303e0    	mov	x0, x19
10628df5c: 94666478    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628df60: aa1d03fd    	mov	x29, x29
10628df64: 94666479    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628df68: aa0003fc    	mov	x28, x0
10628df6c: d00cf737    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10628df70: f945eae0    	ldr	x0, [x23, #0xbd0] ; ��d 
10628df74: f9401fe1    	ldr	x1, [sp, #0x38]
10628df78: 94666471    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628df7c: aa1d03fd    	mov	x29, x29
10628df80: 94666472    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628df84: aa0003f3    	mov	x19, x0
10628df88: d00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628df8c: f9462900    	ldr	x0, [x8, #0xc50]
10628df90: f94017f9    	ldr	x25, [sp, #0x28]
10628df94: aa1903e1    	mov	x1, x25
10628df98: 94666469    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628df9c: aa0003e2    	mov	x2, x0
10628dfa0: aa1303e0    	mov	x0, x19
10628dfa4: aa1a03e1    	mov	x1, x26
10628dfa8: 94666465    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dfac: aa1d03fd    	mov	x29, x29
10628dfb0: 94666466    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dfb4: aa0003f4    	mov	x20, x0
10628dfb8: 900cdd68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10628dfbc: f9464501    	ldr	x1, [x8, #0xc88] ; getStringForCurLanguage:
10628dfc0: 900c18e2    	adrp	x2, 0x11e5a9000 <dyld_stub_binder+0x11e5a9000>
10628dfc4: 910ba042    	add	x2, x2, #0x2e8
10628dfc8: 9466645d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dfcc: aa1d03fd    	mov	x29, x29
10628dfd0: 9466645e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628dfd4: aa0003f7    	mov	x23, x0
10628dfd8: aa1403e0    	mov	x0, x20
10628dfdc: 9466645e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dfe0: aa1303e0    	mov	x0, x19
10628dfe4: 9466645c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628dfe8: b00ce128    	adrp	x8, 0x11feb2000 <dyld_stub_binder+0x11feb2000>
10628dfec: f942cd1b    	ldr	x27, [x8, #0x598] ; brandWording
10628dff0: aa1c03e0    	mov	x0, x28
10628dff4: aa1b03e1    	mov	x1, x27
10628dff8: 94666451    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628dffc: aa1d03fd    	mov	x29, x29
10628e000: 94666452    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e004: aa0003f3    	mov	x19, x0
10628e008: b00cf3a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10628e00c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10628e010: 9466644b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e014: aa0003f4    	mov	x20, x0
10628e018: aa1303e0    	mov	x0, x19
10628e01c: 9466644e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e020: d00cf736    	adrp	x22, 0x120174000 <dyld_stub_binder+0x120174000>
10628e024: f90003fc    	str	x28, [sp]
10628e028: b4000854    	cbz	x20, 0x10628e130 <_Flutter_MMFoundation_BindContext+0x2769d14>
10628e02c: aa1c03e0    	mov	x0, x28
10628e030: aa1b03e1    	mov	x1, x27
10628e034: 94666442    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e038: aa1d03fd    	mov	x29, x29
10628e03c: 94666443    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e040: aa0003fb    	mov	x27, x0
10628e044: aa1703e0    	mov	x0, x23
10628e048: 94666443    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e04c: 1400003a    	b	0x10628e134 <_Flutter_MMFoundation_BindContext+0x2769d18>
10628e050: aa1a03f6    	mov	x22, x26
10628e054: f94017f9    	ldr	x25, [sp, #0x28]
10628e058: f9401ff4    	ldr	x20, [sp, #0x38]
10628e05c: d00cf737    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
10628e060: f9400bf8    	ldr	x24, [sp, #0x10]
10628e064: 1400008e    	b	0x10628e29c <_Flutter_MMFoundation_BindContext+0x2769e80>
10628e068: d00cf737    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
10628e06c: f9403ef3    	ldr	x19, [x23, #0x78] ; 8�6 
10628e070: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e074: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628e078: f9401ff4    	ldr	x20, [sp, #0x38]
10628e07c: aa1403e1    	mov	x1, x20
10628e080: 9466642f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e084: aa1d03fd    	mov	x29, x29
10628e088: 94666430    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e08c: aa0003fc    	mov	x28, x0
10628e090: d00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628e094: f9404100    	ldr	x0, [x8, #0x80]
10628e098: f94017f9    	ldr	x25, [sp, #0x28]
10628e09c: aa1903e1    	mov	x1, x25
10628e0a0: 94666427    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e0a4: aa0003e2    	mov	x2, x0
10628e0a8: aa1c03e0    	mov	x0, x28
10628e0ac: aa1a03e1    	mov	x1, x26
10628e0b0: 94666423    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e0b4: aa1d03fd    	mov	x29, x29
10628e0b8: 94666424    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e0bc: aa0003fa    	mov	x26, x0
10628e0c0: f00c10c2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628e0c4: 912ca042    	add	x2, x2, #0xb28
10628e0c8: 900c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628e0cc: 9124a063    	add	x3, x3, #0x928
10628e0d0: f9400bf8    	ldr	x24, [sp, #0x10]
10628e0d4: aa1803e1    	mov	x1, x24
10628e0d8: 94666419    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e0dc: aa1d03fd    	mov	x29, x29
10628e0e0: 9466641a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e0e4: aa0003f6    	mov	x22, x0
10628e0e8: aa1303e0    	mov	x0, x19
10628e0ec: aa1503e1    	mov	x1, x21
10628e0f0: aa1603e2    	mov	x2, x22
10628e0f4: 94666412    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e0f8: 1e604009    	fmov	d9, d0
10628e0fc: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e100: f9461900    	ldr	x0, [x8, #0xc30]
10628e104: f9400fe1    	ldr	x1, [sp, #0x18]
10628e108: 9466640d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e10c: aa1d03fd    	mov	x29, x29
10628e110: 9466640e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e114: aa0003fb    	mov	x27, x0
10628e118: f94013e1    	ldr	x1, [sp, #0x20]
10628e11c: 94666408    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e120: 1e64c000    	frintp	d0, d0
10628e124: 1e601001    	fmov	d1, #2.00000000
10628e128: 1f410129    	fmadd	d9, d9, d1, d0
10628e12c: 14000052    	b	0x10628e274 <_Flutter_MMFoundation_BindContext+0x2769e58>
10628e130: aa1703fb    	mov	x27, x23
10628e134: b00cea28    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
10628e138: f945d901    	ldr	x1, [x8, #0xbb0] ; textTranslateTextSize
10628e13c: aa1803e0    	mov	x0, x24
10628e140: 946663ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e144: 1e604029    	fmov	d9, d1
10628e148: d00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628e14c: f9404913    	ldr	x19, [x8, #0x90] ; ��c 
10628e150: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e154: f9470100    	ldr	x0, [x8, #0xe00] ; �*c 
10628e158: d00cdd68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10628e15c: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
10628e160: aa1803e2    	mov	x2, x24
10628e164: 946663f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e168: 1e60400a    	fmov	d10, d0
10628e16c: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e170: f9461900    	ldr	x0, [x8, #0xc30]
10628e174: 900cf3e8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10628e178: f9479101    	ldr	x1, [x8, #0xf20] ; systemFontOfSize:
10628e17c: 1e64d000    	fmov	d0, #11.00000000
10628e180: 946663ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e184: aa1d03fd    	mov	x29, x29
10628e188: 946663f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e18c: aa0003f4    	mov	x20, x0
10628e190: d00cdd68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10628e194: f9404901    	ldr	x1, [x8, #0x90] ; labelHeight:maxWidth:font:
10628e198: aa1303e0    	mov	x0, x19
10628e19c: aa1b03e2    	mov	x2, x27
10628e1a0: 1e604140    	fmov	d0, d10
10628e1a4: aa1403e3    	mov	x3, x20
10628e1a8: 946663e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e1ac: 1e60400a    	fmov	d10, d0
10628e1b0: aa1403e0    	mov	x0, x20
10628e1b4: 946663e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e1b8: f9403ed3    	ldr	x19, [x22, #0x78] ; 8�6 
10628e1bc: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e1c0: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628e1c4: f9401ff7    	ldr	x23, [sp, #0x38]
10628e1c8: aa1703e1    	mov	x1, x23
10628e1cc: 946663dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e1d0: aa1d03fd    	mov	x29, x29
10628e1d4: 946663dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e1d8: aa0003f6    	mov	x22, x0
10628e1dc: d00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628e1e0: f9404100    	ldr	x0, [x8, #0x80]
10628e1e4: aa1903e1    	mov	x1, x25
10628e1e8: 946663d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e1ec: aa0003e2    	mov	x2, x0
10628e1f0: aa1603e0    	mov	x0, x22
10628e1f4: aa1a03e1    	mov	x1, x26
10628e1f8: 946663d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e1fc: aa1d03fd    	mov	x29, x29
10628e200: 946663d2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e204: aa1b03fa    	mov	x26, x27
10628e208: aa0003fb    	mov	x27, x0
10628e20c: f00c10c2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628e210: 912ca042    	add	x2, x2, #0xb28
10628e214: 900c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628e218: 9124a063    	add	x3, x3, #0x928
10628e21c: f9400bf8    	ldr	x24, [sp, #0x10]
10628e220: aa1803e1    	mov	x1, x24
10628e224: 946663c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e228: aa1d03fd    	mov	x29, x29
10628e22c: 946663c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e230: aa0003f4    	mov	x20, x0
10628e234: aa1303e0    	mov	x0, x19
10628e238: aa1503e1    	mov	x1, x21
10628e23c: aa1403e2    	mov	x2, x20
10628e240: 946663bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e244: 1e601001    	fmov	d1, #2.00000000
10628e248: 1f412400    	fmadd	d0, d0, d1, d9
10628e24c: 1e631001    	fmov	d1, #6.00000000
10628e250: 1e612800    	fadd	d0, d0, d1
10628e254: 1e602940    	fadd	d0, d10, d0
10628e258: 1e621001    	fmov	d1, #4.00000000
10628e25c: 1e612809    	fadd	d9, d0, d1
10628e260: aa1403e0    	mov	x0, x20
10628e264: aa1703f4    	mov	x20, x23
10628e268: d00cf737    	adrp	x23, 0x120174000 <dyld_stub_binder+0x120174000>
10628e26c: 946663ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e270: f94003fc    	ldr	x28, [sp]
10628e274: 1e692908    	fadd	d8, d8, d9
10628e278: aa1b03e0    	mov	x0, x27
10628e27c: 946663b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e280: aa1603e0    	mov	x0, x22
10628e284: 946663b4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e288: aa1a03e0    	mov	x0, x26
10628e28c: 946663b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e290: aa1c03e0    	mov	x0, x28
10628e294: 946663b0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e298: f94007f6    	ldr	x22, [sp, #0x8]
10628e29c: f9403ef3    	ldr	x19, [x23, #0x78] ; 8�6 
10628e2a0: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e2a4: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628e2a8: aa1403e1    	mov	x1, x20
10628e2ac: 946663a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e2b0: aa1d03fd    	mov	x29, x29
10628e2b4: 946663a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e2b8: aa0003fa    	mov	x26, x0
10628e2bc: d00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628e2c0: f9404100    	ldr	x0, [x8, #0x80]
10628e2c4: aa1903e1    	mov	x1, x25
10628e2c8: 9466639d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e2cc: aa0003e2    	mov	x2, x0
10628e2d0: aa1a03e0    	mov	x0, x26
10628e2d4: aa1603e1    	mov	x1, x22
10628e2d8: 94666399    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e2dc: aa1d03fd    	mov	x29, x29
10628e2e0: 9466639a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e2e4: aa1403f6    	mov	x22, x20
10628e2e8: aa0003f4    	mov	x20, x0
10628e2ec: f00c10c2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628e2f0: 912ca042    	add	x2, x2, #0xb28
10628e2f4: 900c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628e2f8: 9124a063    	add	x3, x3, #0x928
10628e2fc: aa1803e1    	mov	x1, x24
10628e300: 9466638f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e304: aa1d03fd    	mov	x29, x29
10628e308: 94666390    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e30c: aa0003fb    	mov	x27, x0
10628e310: aa1303e0    	mov	x0, x19
10628e314: aa1503e1    	mov	x1, x21
10628e318: aa1b03e2    	mov	x2, x27
10628e31c: 94666388    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e320: 1e604009    	fmov	d9, d0
10628e324: b00cf73c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10628e328: f9461b80    	ldr	x0, [x28, #0xc30]
10628e32c: aa1803fc    	mov	x28, x24
10628e330: f9400ff8    	ldr	x24, [sp, #0x18]
10628e334: aa1803e1    	mov	x1, x24
10628e338: 94666381    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e33c: aa1d03fd    	mov	x29, x29
10628e340: 94666382    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e344: aa0003f3    	mov	x19, x0
10628e348: f9001ff5    	str	x21, [sp, #0x38]
10628e34c: f94013f5    	ldr	x21, [sp, #0x20]
10628e350: aa1503e1    	mov	x1, x21
10628e354: 9466637a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e358: 1e64c000    	frintp	d0, d0
10628e35c: 1f4b0120    	fmadd	d0, d9, d11, d0
10628e360: 1f4b3009    	fmadd	d9, d0, d11, d12
10628e364: aa1303e0    	mov	x0, x19
10628e368: 9466637b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e36c: aa1b03e0    	mov	x0, x27
10628e370: 94666379    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e374: aa1403e0    	mov	x0, x20
10628e378: 94666377    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e37c: aa1a03e0    	mov	x0, x26
10628e380: 94666375    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628e384: 1e692100    	fcmp	d8, d9
10628e388: 54000625    	b.pl	0x10628e44c <_Flutter_MMFoundation_BindContext+0x276a030>
10628e38c: f9403ef3    	ldr	x19, [x23, #0x78] ; 8�6 
10628e390: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e394: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
10628e398: aa1603e1    	mov	x1, x22
10628e39c: 94666368    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e3a0: aa1d03fd    	mov	x29, x29
10628e3a4: 94666369    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e3a8: aa0003fb    	mov	x27, x0
10628e3ac: d00cf728    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10628e3b0: f9404100    	ldr	x0, [x8, #0x80]
10628e3b4: aa1903e1    	mov	x1, x25
10628e3b8: 94666361    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e3bc: aa0003e2    	mov	x2, x0
10628e3c0: aa1b03e0    	mov	x0, x27
10628e3c4: f94007e1    	ldr	x1, [sp, #0x8]
10628e3c8: 9466635d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e3cc: aa1d03fd    	mov	x29, x29
10628e3d0: 9466635e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e3d4: aa0003f7    	mov	x23, x0
10628e3d8: f00c10c2    	adrp	x2, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
10628e3dc: 912ca042    	add	x2, x2, #0xb28
10628e3e0: 900c10c3    	adrp	x3, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
10628e3e4: 9124a063    	add	x3, x3, #0x928
10628e3e8: aa1c03e1    	mov	x1, x28
10628e3ec: 94666354    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e3f0: aa1d03fd    	mov	x29, x29
10628e3f4: 94666355    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e3f8: aa0003f6    	mov	x22, x0
10628e3fc: aa1303e0    	mov	x0, x19
10628e400: f9401fe1    	ldr	x1, [sp, #0x38]
10628e404: aa1603e2    	mov	x2, x22
10628e408: 9466634d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e40c: 1e604008    	fmov	d8, d0
10628e410: b00cf728    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628e414: f9461900    	ldr	x0, [x8, #0xc30]
10628e418: aa1803e1    	mov	x1, x24
10628e41c: 94666348    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e420: aa1d03fd    	mov	x29, x29
10628e424: 94666349    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10628e428: aa0003f4    	mov	x20, x0
10628e42c: aa1503e1    	mov	x1, x21
10628e430: 94666343    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628e434: 1e64c000    	frintp	d0, d0
10628e438: 1e601001    	fmov	d1, #2.00000000
10628e43c: 1f410100    	fmadd	d0, d8, d1, d0
10628e440: 1e621002    	fmov	d2, #4.00000000
10628e444: 1f410808    	fmadd	d8, d0, d1, d2
10628e448: 17fffe6a    	b	0x10628ddf0 <_Flutter_MMFoundation_BindContext+0x27699d4>
10628e44c: 1e604100    	fmov	d0, d8
10628e450: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
10628e454: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
10628e458: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
10628e45c: a9495ff8    	ldp	x24, x23, [sp, #0x90]
10628e460: a94867fa    	ldp	x26, x25, [sp, #0x80]
10628e464: a9476ffc    	ldp	x28, x27, [sp, #0x70]
10628e468: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
10628e46c: 6d452beb    	ldp	d11, d10, [sp, #0x50]
10628e470: 6d4433ed    	ldp	d13, d12, [sp, #0x40]
10628e474: 910343ff    	add	sp, sp, #0xd0
10628e478: d65f03c0    	ret