
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abecf0: d10383ff    	sub	sp, sp, #0xe0
104abecf4: 6d0723e9    	stp	d9, d8, [sp, #0x70]
104abecf8: a9086ffc    	stp	x28, x27, [sp, #0x80]
104abecfc: a90967fa    	stp	x26, x25, [sp, #0x90]
104abed00: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
104abed04: a90b57f6    	stp	x22, x21, [sp, #0xb0]
104abed08: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
104abed0c: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
104abed10: 910343fd    	add	x29, sp, #0xd0
104abed14: f90033e0    	str	x0, [sp, #0x60]
104abed18: 900e0c08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104abed1c: 52800029    	mov	w9, #0x1                ; =1
104abed20: 390ef909    	strb	w9, [x8, #0x3be]
104abed24: b00db5b3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104abed28: f9461a60    	ldr	x0, [x19, #0xc30] ; class UIFont
104abed2c: f00d9bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104abed30: f9463114    	ldr	x20, [x8, #0xc60] ; selector dynamicLength:
104abed34: 1e679000    	fmov	d0, #28.00000000
104abed38: aa1403e1    	mov	x1, x20
104abed3c: 94c5a100    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abed40: 1e604008    	fmov	d8, d0
104abed44: f9461a60    	ldr	x0, [x19, #0xc30] ; class UIFont
104abed48: 1e679000    	fmov	d0, #28.00000000
104abed4c: aa1403e1    	mov	x1, x20
104abed50: 94c5a0fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abed54: 1e604009    	fmov	d9, d0
104abed58: b00db5b3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104abed5c: f9462e60    	ldr	x0, [x19, #0xc58] ; class WCColor
104abed60: b00db228    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104abed64: f9462901    	ldr	x1, [x8, #0xc50] ; selector labelColor
104abed68: 94c5a0f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abed6c: aa1d03fd    	mov	x29, x29
104abed70: 94c5a0f6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abed74: aa0003f4    	mov	x20, x0
104abed78: f90037e0    	str	x0, [sp, #0x68]
104abed7c: f9462e60    	ldr	x0, [x19, #0xc58] ; class WCColor
104abed80: d00d9be8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104abed84: f9405901    	ldr	x1, [x8, #0xb0] ; selector Brand_100
104abed88: 94c5a0ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abed8c: aa1d03fd    	mov	x29, x29
104abed90: 94c5a0ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abed94: aa0003f5    	mov	x21, x0
104abed98: f9002fe0    	str	x0, [sp, #0x58]
104abed9c: 900db628    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
104abeda0: f9434900    	ldr	x0, [x8, #0x690] ; class MMTabbarItem
104abeda4: 94c5a0ef    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104abeda8: f9000fe0    	str	x0, [sp, #0x18]
104abedac: b00db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abedb0: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104abedb4: aa0803f3    	mov	x19, x8
104abedb8: d00db208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104abedbc: f944e917    	ldr	x23, [x8, #0x9d0] ; selector currentContext
104abedc0: aa1703e1    	mov	x1, x23
104abedc4: 94c5a0de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abedc8: aa1d03fd    	mov	x29, x29
104abedcc: 94c5a0df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abedd0: aa0003f8    	mov	x24, x0
104abedd4: f90027e0    	str	x0, [sp, #0x48]
104abedd8: b00db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abeddc: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
104abede0: b00db208    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104abede4: f947ad16    	ldr	x22, [x8, #0xf58] ; selector class
104abede8: aa1603e1    	mov	x1, x22
104abedec: 94c5a0d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abedf0: aa0003e2    	mov	x2, x0
104abedf4: f00d9bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104abedf8: f9464119    	ldr	x25, [x8, #0xc80] ; selector getService:
104abedfc: aa1803e0    	mov	x0, x24
104abee00: aa1903e1    	mov	x1, x25
104abee04: 94c5a0ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abee08: aa1d03fd    	mov	x29, x29
104abee0c: 94c5a0cf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abee10: f00d9bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104abee14: f9464501    	ldr	x1, [x8, #0xc88] ; selector getStringForCurLanguage:
104abee18: a90383e1    	stp	x1, x0, [sp, #0x38]
104abee1c: b00ce702    	adrp	x2, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abee20: 910a2042    	add	x2, x2, #0x288 ; CFString 'TabBar_MainFrameTitle'
104abee24: 94c5a0c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abee28: aa1d03fd    	mov	x29, x29
104abee2c: 94c5a0c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abee30: f90007e0    	str	x0, [sp, #0x8]
104abee34: f945ea60    	ldr	x0, [x19, #0xbd0]
104abee38: aa1703e1    	mov	x1, x23
104abee3c: f90017f7    	str	x23, [sp, #0x28]
104abee40: 94c5a0bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abee44: aa1d03fd    	mov	x29, x29
104abee48: 94c5a0c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abee4c: aa0003fa    	mov	x26, x0
104abee50: f9000be0    	str	x0, [sp, #0x10]
104abee54: d00db5bb    	adrp	x27, 0x120174000 <dyld_stub_binder+0x120174000>
104abee58: f9404360    	ldr	x0, [x27, #0x80] ; class MMThemeManager
104abee5c: aa1603e1    	mov	x1, x22
104abee60: aa1603f8    	mov	x24, x22
104abee64: 94c5a0b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abee68: aa0003e2    	mov	x2, x0
104abee6c: aa1a03e0    	mov	x0, x26
104abee70: aa1903e1    	mov	x1, x25
104abee74: 94c5a0b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abee78: aa1d03fd    	mov	x29, x29
104abee7c: 94c5a0b3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abee80: aa0003fa    	mov	x26, x0
104abee84: d00d9be8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104abee88: f9437916    	ldr	x22, [x8, #0x6f0] ; selector svgImageNamed:size:color:
104abee8c: b00cd1e2    	adrp	x2, 0x11e4fb000 <dyld_stub_binder+0x11e4fb000>
104abee90: 9107a042    	add	x2, x2, #0x1e8 ; CFString 'bubble_circle_regular'
104abee94: aa1603e1    	mov	x1, x22
104abee98: f9001bf6    	str	x22, [sp, #0x30]
104abee9c: 1e604100    	fmov	d0, d8
104abeea0: 1e604121    	fmov	d1, d9
104abeea4: aa1403e3    	mov	x3, x20
104abeea8: 94c5a0a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeeac: aa1d03fd    	mov	x29, x29
104abeeb0: 94c5a0a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abeeb4: aa0003fc    	mov	x28, x0
104abeeb8: f945ea60    	ldr	x0, [x19, #0xbd0]
104abeebc: aa1703e1    	mov	x1, x23
104abeec0: 94c5a09f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeec4: aa1d03fd    	mov	x29, x29
104abeec8: 94c5a0a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abeecc: aa0003f3    	mov	x19, x0
104abeed0: f9404360    	ldr	x0, [x27, #0x80] ; class MMThemeManager
104abeed4: aa1803e1    	mov	x1, x24
104abeed8: 94c5a099    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeedc: aa0003e2    	mov	x2, x0
104abeee0: aa1303e0    	mov	x0, x19
104abeee4: aa1903e1    	mov	x1, x25
104abeee8: aa1903fb    	mov	x27, x25
104abeeec: 94c5a094    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeef0: aa1d03fd    	mov	x29, x29
104abeef4: 94c5a095    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abeef8: aa0003f4    	mov	x20, x0
104abeefc: 900cd162    	adrp	x2, 0x11e4ea000 <dyld_stub_binder+0x11e4ea000>
104abef00: 9119a042    	add	x2, x2, #0x668 ; CFString 'bubble_circle_filled'
104abef04: aa1603e1    	mov	x1, x22
104abef08: 1e604100    	fmov	d0, d8
104abef0c: 1e604121    	fmov	d1, d9
104abef10: aa1503e3    	mov	x3, x21
104abef14: 94c5a08a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abef18: aa1d03fd    	mov	x29, x29
104abef1c: 94c5a08b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abef20: aa0003f5    	mov	x21, x0
104abef24: f00da5a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104abef28: f946b901    	ldr	x1, [x8, #0xd70] ; selector initWithTitle:normalImage:selectedImage:
104abef2c: f9002be1    	str	x1, [sp, #0x50]
104abef30: f9400fe0    	ldr	x0, [sp, #0x18]
104abef34: f94007f9    	ldr	x25, [sp, #0x8]
104abef38: aa1903e2    	mov	x2, x25
104abef3c: aa1c03e3    	mov	x3, x28
104abef40: aa1503e4    	mov	x4, x21
104abef44: 94c5a07e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abef48: b00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abef4c: b9849116    	ldrsw	x22, [x8, #0x490]
104abef50: f94033e9    	ldr	x9, [sp, #0x60]
104abef54: f8766928    	ldr	x8, [x9, x22]
104abef58: f8366920    	str	x0, [x9, x22]
104abef5c: aa0903f7    	mov	x23, x9
104abef60: aa0803e0    	mov	x0, x8
104abef64: 94c5a07c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef68: aa1503e0    	mov	x0, x21
104abef6c: 94c5a07a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef70: aa1403e0    	mov	x0, x20
104abef74: 94c5a078    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef78: aa1303e0    	mov	x0, x19
104abef7c: 94c5a076    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef80: aa1c03e0    	mov	x0, x28
104abef84: 94c5a074    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef88: aa1a03e0    	mov	x0, x26
104abef8c: 94c5a072    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef90: f9400be0    	ldr	x0, [sp, #0x10]
104abef94: 94c5a070    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abef98: aa1903e0    	mov	x0, x25
104abef9c: 94c5a06e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abefa0: f94023e0    	ldr	x0, [sp, #0x40]
104abefa4: 94c5a06c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abefa8: f94027e0    	ldr	x0, [sp, #0x48]
104abefac: 94c5a06a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abefb0: b00db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abefb4: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104abefb8: f94017fc    	ldr	x28, [sp, #0x28]
104abefbc: aa1c03e1    	mov	x1, x28
104abefc0: 94c5a05f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abefc4: aa1d03fd    	mov	x29, x29
104abefc8: 94c5a060    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abefcc: aa0003f3    	mov	x19, x0
104abefd0: b00db5b9    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
104abefd4: f9462b20    	ldr	x0, [x25, #0xc50] ; class MMLanguageMgr
104abefd8: aa1803e1    	mov	x1, x24
104abefdc: 94c5a058    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abefe0: aa0003e2    	mov	x2, x0
104abefe4: aa1303e0    	mov	x0, x19
104abefe8: aa1b03e1    	mov	x1, x27
104abefec: 94c5a054    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeff0: aa1d03fd    	mov	x29, x29
104abeff4: 94c5a055    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abeff8: aa0003f4    	mov	x20, x0
104abeffc: b00ce702    	adrp	x2, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf000: 910aa042    	add	x2, x2, #0x2a8 ; CFString 'VoiceOver_Tabbar_Hint'
104abf004: f9401ffa    	ldr	x26, [sp, #0x38]
104abf008: aa1a03e1    	mov	x1, x26
104abf00c: 94c5a04c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf010: aa1d03fd    	mov	x29, x29
104abf014: 94c5a04d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf018: aa0003f5    	mov	x21, x0
104abf01c: f8766ae0    	ldr	x0, [x23, x22]
104abf020: f00d9cc8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
104abf024: f9420101    	ldr	x1, [x8, #0x400] ; selector setAccessibilityHint:
104abf028: aa1503e2    	mov	x2, x21
104abf02c: 94c5a044    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf030: aa1503e0    	mov	x0, x21
104abf034: 94c5a048    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf038: aa1403e0    	mov	x0, x20
104abf03c: 94c5a046    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf040: aa1303e0    	mov	x0, x19
104abf044: 94c5a044    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf048: f8766ae0    	ldr	x0, [x23, x22]
104abf04c: d00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abf050: f9417501    	ldr	x1, [x8, #0x2e8] ; selector setTabIndex:
104abf054: f90027e1    	str	x1, [sp, #0x48]
104abf058: d2800002    	mov	x2, #0x0                ; =0
104abf05c: 94c5a038    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf060: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf064: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104abf068: d00d9bc8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104abf06c: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104abf070: f90023e1    	str	x1, [sp, #0x40]
104abf074: 900ce708    	adrp	x8, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf078: 910b2108    	add	x8, x8, #0x2c8 ; CFString 'create m_mainFrameTabItem !!'
104abf07c: f90003e8    	str	x8, [sp]
104abf080: f00b3b43    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104abf084: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104abf088: 900b69a5    	adrp	x5, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf08c: 910370a5    	add	x5, x5, #0xdc ; string 'MainTabBarViewController.mm'
104abf090: 900b69a7    	adrp	x7, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf094: 910938e7    	add	x7, x7, #0x24e ; string '-[MainTabBarViewController p_createTabBarItems]'
104abf098: 52800022    	mov	w2, #0x1                ; =1
104abf09c: 52800004    	mov	w4, #0x0                ; =0
104abf0a0: 52802fc6    	mov	w6, #0x17e              ; =382
104abf0a4: 94c5a026    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf0a8: f00db608    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
104abf0ac: f9434900    	ldr	x0, [x8, #0x690] ; class MMTabbarItem
104abf0b0: 94c5a02c    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104abf0b4: f90007e0    	str	x0, [sp, #0x8]
104abf0b8: 900db5b3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104abf0bc: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf0c0: aa1c03f7    	mov	x23, x28
104abf0c4: aa1c03e1    	mov	x1, x28
104abf0c8: 94c5a01d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf0cc: aa1d03fd    	mov	x29, x29
104abf0d0: 94c5a01e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf0d4: aa0003f5    	mov	x21, x0
104abf0d8: f9000fe0    	str	x0, [sp, #0x18]
104abf0dc: f9462b20    	ldr	x0, [x25, #0xc50] ; class MMLanguageMgr
104abf0e0: aa1803f4    	mov	x20, x24
104abf0e4: aa1803e1    	mov	x1, x24
104abf0e8: 94c5a015    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf0ec: aa0003e2    	mov	x2, x0
104abf0f0: aa1503e0    	mov	x0, x21
104abf0f4: aa1b03e1    	mov	x1, x27
104abf0f8: 94c5a011    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf0fc: aa1d03fd    	mov	x29, x29
104abf100: 94c5a012    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf104: f9000be0    	str	x0, [sp, #0x10]
104abf108: b00cd462    	adrp	x2, 0x11e54c000 <dyld_stub_binder+0x11e54c000>
104abf10c: 91362042    	add	x2, x2, #0xd88 ; CFString 'TabBar_ContactsTitle'
104abf110: aa1a03e1    	mov	x1, x26
104abf114: 94c5a00a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf118: aa1d03fd    	mov	x29, x29
104abf11c: 94c5a00b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf120: aa0003fc    	mov	x28, x0
104abf124: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf128: aa1703e1    	mov	x1, x23
104abf12c: 94c5a004    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf130: aa1d03fd    	mov	x29, x29
104abf134: 94c5a005    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf138: aa0003fa    	mov	x26, x0
104abf13c: b00db5b5    	adrp	x21, 0x120174000 <dyld_stub_binder+0x120174000>
104abf140: f94042a0    	ldr	x0, [x21, #0x80] ; class MMThemeManager
104abf144: aa1803e1    	mov	x1, x24
104abf148: f90013f8    	str	x24, [sp, #0x20]
104abf14c: 94c59ffc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf150: aa0003e2    	mov	x2, x0
104abf154: aa1a03e0    	mov	x0, x26
104abf158: aa1b03e1    	mov	x1, x27
104abf15c: aa1b03f8    	mov	x24, x27
104abf160: 94c59ff7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf164: aa1d03fd    	mov	x29, x29
104abf168: 94c59ff8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf16c: aa0003f9    	mov	x25, x0
104abf170: f00cdb02    	adrp	x2, 0x11e622000 <dyld_stub_binder+0x11e622000>
104abf174: 910fa042    	add	x2, x2, #0x3e8 ; CFString 'person_list_regular'
104abf178: f9401bf6    	ldr	x22, [sp, #0x30]
104abf17c: aa1603e1    	mov	x1, x22
104abf180: 1e604100    	fmov	d0, d8
104abf184: 1e604121    	fmov	d1, d9
104abf188: f94037e3    	ldr	x3, [sp, #0x68]
104abf18c: 94c59fec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf190: aa1d03fd    	mov	x29, x29
104abf194: 94c59fed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf198: aa0003fb    	mov	x27, x0
104abf19c: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf1a0: aa1703e1    	mov	x1, x23
104abf1a4: 94c59fe6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf1a8: aa1d03fd    	mov	x29, x29
104abf1ac: 94c59fe7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf1b0: aa0003f3    	mov	x19, x0
104abf1b4: f94042a0    	ldr	x0, [x21, #0x80] ; class MMThemeManager
104abf1b8: aa1403e1    	mov	x1, x20
104abf1bc: 94c59fe0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf1c0: aa0003e2    	mov	x2, x0
104abf1c4: aa1303e0    	mov	x0, x19
104abf1c8: aa1803e1    	mov	x1, x24
104abf1cc: 94c59fdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf1d0: aa1d03fd    	mov	x29, x29
104abf1d4: 94c59fdd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf1d8: aa0003f5    	mov	x21, x0
104abf1dc: 900ce702    	adrp	x2, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf1e0: 910ba042    	add	x2, x2, #0x2e8 ; CFString 'person_list_filled'
104abf1e4: aa1603e1    	mov	x1, x22
104abf1e8: 1e604100    	fmov	d0, d8
104abf1ec: 1e604121    	fmov	d1, d9
104abf1f0: f9402fe3    	ldr	x3, [sp, #0x58]
104abf1f4: 94c59fd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf1f8: aa1d03fd    	mov	x29, x29
104abf1fc: 94c59fd3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf200: aa0003f6    	mov	x22, x0
104abf204: f94007e0    	ldr	x0, [sp, #0x8]
104abf208: f9402be1    	ldr	x1, [sp, #0x50]
104abf20c: aa1c03e2    	mov	x2, x28
104abf210: aa1b03e3    	mov	x3, x27
104abf214: aa1603e4    	mov	x4, x22
104abf218: 94c59fc9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf21c: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf220: b9849517    	ldrsw	x23, [x8, #0x494]
104abf224: f94033f4    	ldr	x20, [sp, #0x60]
104abf228: f8776a88    	ldr	x8, [x20, x23]
104abf22c: f8376a80    	str	x0, [x20, x23]
104abf230: aa0803e0    	mov	x0, x8
104abf234: 94c59fc8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf238: aa1603e0    	mov	x0, x22
104abf23c: 94c59fc6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf240: aa1503e0    	mov	x0, x21
104abf244: 94c59fc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf248: aa1303e0    	mov	x0, x19
104abf24c: 94c59fc2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf250: aa1b03e0    	mov	x0, x27
104abf254: 94c59fc0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf258: aa1903e0    	mov	x0, x25
104abf25c: 94c59fbe    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf260: aa1a03e0    	mov	x0, x26
104abf264: 94c59fbc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf268: aa1c03e0    	mov	x0, x28
104abf26c: 94c59fba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf270: f9400be0    	ldr	x0, [sp, #0x10]
104abf274: 94c59fb8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf278: f9400fe0    	ldr	x0, [sp, #0x18]
104abf27c: 94c59fb6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf280: f8776a80    	ldr	x0, [x20, x23]
104abf284: f94027e1    	ldr	x1, [sp, #0x48]
104abf288: 52800022    	mov	w2, #0x1                ; =1
104abf28c: 94c59fac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf290: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf294: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104abf298: 900ce708    	adrp	x8, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf29c: 910c2108    	add	x8, x8, #0x308 ; CFString 'create m_contacsTabItem !!'
104abf2a0: f90003e8    	str	x8, [sp]
104abf2a4: f94023e1    	ldr	x1, [sp, #0x40]
104abf2a8: 52800022    	mov	w2, #0x1                ; =1
104abf2ac: f00b3b43    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104abf2b0: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104abf2b4: 52800004    	mov	w4, #0x0                ; =0
104abf2b8: 900b69a5    	adrp	x5, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf2bc: 910370a5    	add	x5, x5, #0xdc ; string 'MainTabBarViewController.mm'
104abf2c0: 528030a6    	mov	w6, #0x185              ; =389
104abf2c4: 900b69a7    	adrp	x7, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf2c8: 910938e7    	add	x7, x7, #0x24e ; string '-[MainTabBarViewController p_createTabBarItems]'
104abf2cc: 94c59f9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf2d0: f00db608    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
104abf2d4: f9434900    	ldr	x0, [x8, #0x690] ; class MMTabbarItem
104abf2d8: 94c59fa2    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104abf2dc: f90007e0    	str	x0, [sp, #0x8]
104abf2e0: 900db5b3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104abf2e4: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf2e8: f94017f4    	ldr	x20, [sp, #0x28]
104abf2ec: aa1403e1    	mov	x1, x20
104abf2f0: 94c59f93    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf2f4: aa1d03fd    	mov	x29, x29
104abf2f8: 94c59f94    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf2fc: aa0003f5    	mov	x21, x0
104abf300: f9000fe0    	str	x0, [sp, #0x18]
104abf304: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf308: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
104abf30c: f94013f6    	ldr	x22, [sp, #0x20]
104abf310: aa1603e1    	mov	x1, x22
104abf314: 94c59f8a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf318: aa0003e2    	mov	x2, x0
104abf31c: aa1503e0    	mov	x0, x21
104abf320: aa1803e1    	mov	x1, x24
104abf324: 94c59f86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf328: aa1d03fd    	mov	x29, x29
104abf32c: 94c59f87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf330: f9000be0    	str	x0, [sp, #0x10]
104abf334: f00cd7e2    	adrp	x2, 0x11e5be000 <dyld_stub_binder+0x11e5be000>
104abf338: 9104a042    	add	x2, x2, #0x128 ; CFString 'TabBar_FindFriendTitle'
104abf33c: f9401fe1    	ldr	x1, [sp, #0x38]
104abf340: 94c59f7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf344: aa1d03fd    	mov	x29, x29
104abf348: 94c59f80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf34c: aa0003fc    	mov	x28, x0
104abf350: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf354: aa1403e1    	mov	x1, x20
104abf358: 94c59f79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf35c: aa1d03fd    	mov	x29, x29
104abf360: 94c59f7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf364: aa0003fa    	mov	x26, x0
104abf368: b00db5b5    	adrp	x21, 0x120174000 <dyld_stub_binder+0x120174000>
104abf36c: f94042a0    	ldr	x0, [x21, #0x80] ; class MMThemeManager
104abf370: aa1603e1    	mov	x1, x22
104abf374: 94c59f72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf378: aa0003e2    	mov	x2, x0
104abf37c: aa1a03e0    	mov	x0, x26
104abf380: aa1803e1    	mov	x1, x24
104abf384: 94c59f6e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf388: aa1d03fd    	mov	x29, x29
104abf38c: 94c59f6f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf390: aa0003f9    	mov	x25, x0
104abf394: 900ce702    	adrp	x2, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf398: 910ca042    	add	x2, x2, #0x328 ; CFString 'discover_regular'
104abf39c: f9401bf7    	ldr	x23, [sp, #0x30]
104abf3a0: aa1703e1    	mov	x1, x23
104abf3a4: 1e604100    	fmov	d0, d8
104abf3a8: 1e604121    	fmov	d1, d9
104abf3ac: f94037e3    	ldr	x3, [sp, #0x68]
104abf3b0: 94c59f63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf3b4: aa1d03fd    	mov	x29, x29
104abf3b8: 94c59f64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf3bc: aa0003fb    	mov	x27, x0
104abf3c0: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf3c4: aa1403e1    	mov	x1, x20
104abf3c8: 94c59f5d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf3cc: aa1d03fd    	mov	x29, x29
104abf3d0: 94c59f5e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf3d4: aa0003f3    	mov	x19, x0
104abf3d8: f94042a0    	ldr	x0, [x21, #0x80] ; class MMThemeManager
104abf3dc: aa1603e1    	mov	x1, x22
104abf3e0: 94c59f57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf3e4: aa0003e2    	mov	x2, x0
104abf3e8: aa1303e0    	mov	x0, x19
104abf3ec: aa1803e1    	mov	x1, x24
104abf3f0: 94c59f53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf3f4: aa1d03fd    	mov	x29, x29
104abf3f8: 94c59f54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf3fc: aa0003f6    	mov	x22, x0
104abf400: 900ce702    	adrp	x2, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf404: 910d2042    	add	x2, x2, #0x348 ; CFString 'discover_filled'
104abf408: aa1703e1    	mov	x1, x23
104abf40c: 1e604100    	fmov	d0, d8
104abf410: 1e604121    	fmov	d1, d9
104abf414: f9402fe3    	ldr	x3, [sp, #0x58]
104abf418: 94c59f49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf41c: aa1d03fd    	mov	x29, x29
104abf420: 94c59f4a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf424: aa0003f5    	mov	x21, x0
104abf428: f94007e0    	ldr	x0, [sp, #0x8]
104abf42c: f9402be1    	ldr	x1, [sp, #0x50]
104abf430: aa1c03e2    	mov	x2, x28
104abf434: aa1b03e3    	mov	x3, x27
104abf438: aa1503e4    	mov	x4, x21
104abf43c: 94c59f40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf440: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf444: b9849917    	ldrsw	x23, [x8, #0x498]
104abf448: f94033f4    	ldr	x20, [sp, #0x60]
104abf44c: f8776a88    	ldr	x8, [x20, x23]
104abf450: f8376a80    	str	x0, [x20, x23]
104abf454: aa0803e0    	mov	x0, x8
104abf458: 94c59f3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf45c: aa1503e0    	mov	x0, x21
104abf460: 94c59f3d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf464: aa1603e0    	mov	x0, x22
104abf468: 94c59f3b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf46c: aa1303e0    	mov	x0, x19
104abf470: 94c59f39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf474: aa1b03e0    	mov	x0, x27
104abf478: 94c59f37    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf47c: aa1903e0    	mov	x0, x25
104abf480: 94c59f35    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf484: aa1a03e0    	mov	x0, x26
104abf488: 94c59f33    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf48c: aa1c03e0    	mov	x0, x28
104abf490: 94c59f31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf494: f9400be0    	ldr	x0, [sp, #0x10]
104abf498: 94c59f2f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf49c: f9400fe0    	ldr	x0, [sp, #0x18]
104abf4a0: 94c59f2d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf4a4: f8776a80    	ldr	x0, [x20, x23]
104abf4a8: f94027e1    	ldr	x1, [sp, #0x48]
104abf4ac: 52800042    	mov	w2, #0x2                ; =2
104abf4b0: 94c59f23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf4b4: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf4b8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104abf4bc: 900ce708    	adrp	x8, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf4c0: 910da108    	add	x8, x8, #0x368 ; CFString 'create m_findFrientTabItem !!'
104abf4c4: f90003e8    	str	x8, [sp]
104abf4c8: f94023e1    	ldr	x1, [sp, #0x40]
104abf4cc: 52800022    	mov	w2, #0x1                ; =1
104abf4d0: f00b3b43    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104abf4d4: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104abf4d8: 52800004    	mov	w4, #0x0                ; =0
104abf4dc: 900b69a5    	adrp	x5, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf4e0: 910370a5    	add	x5, x5, #0xdc ; string 'MainTabBarViewController.mm'
104abf4e4: 528031a6    	mov	w6, #0x18d              ; =397
104abf4e8: 900b69a7    	adrp	x7, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf4ec: 910938e7    	add	x7, x7, #0x24e ; string '-[MainTabBarViewController p_createTabBarItems]'
104abf4f0: 94c59f13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf4f4: f00db608    	adrp	x8, 0x120182000 <dyld_stub_binder+0x120182000>
104abf4f8: f9434900    	ldr	x0, [x8, #0x690] ; class MMTabbarItem
104abf4fc: 94c59f19    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
104abf500: f90007e0    	str	x0, [sp, #0x8]
104abf504: 900db5b3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
104abf508: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf50c: f94017f4    	ldr	x20, [sp, #0x28]
104abf510: aa1403e1    	mov	x1, x20
104abf514: 94c59f0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf518: aa1d03fd    	mov	x29, x29
104abf51c: 94c59f0b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf520: aa0003f5    	mov	x21, x0
104abf524: f9000fe0    	str	x0, [sp, #0x18]
104abf528: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf52c: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
104abf530: f94013f6    	ldr	x22, [sp, #0x20]
104abf534: aa1603e1    	mov	x1, x22
104abf538: 94c59f01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf53c: aa0003e2    	mov	x2, x0
104abf540: aa1503e0    	mov	x0, x21
104abf544: aa1803f7    	mov	x23, x24
104abf548: aa1803e1    	mov	x1, x24
104abf54c: 94c59efc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf550: aa1d03fd    	mov	x29, x29
104abf554: 94c59efd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf558: f9000be0    	str	x0, [sp, #0x10]
104abf55c: 900ce482    	adrp	x2, 0x11e74f000 <dyld_stub_binder+0x11e74f000>
104abf560: 910ba042    	add	x2, x2, #0x2e8 ; CFString 'TabBar_MoreTitle'
104abf564: f9401fe1    	ldr	x1, [sp, #0x38]
104abf568: 94c59ef5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf56c: aa1d03fd    	mov	x29, x29
104abf570: 94c59ef6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf574: aa0003fa    	mov	x26, x0
104abf578: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf57c: aa1403e1    	mov	x1, x20
104abf580: aa1403f5    	mov	x21, x20
104abf584: 94c59eee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf588: aa1d03fd    	mov	x29, x29
104abf58c: 94c59eef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf590: aa0003fc    	mov	x28, x0
104abf594: b00db5b8    	adrp	x24, 0x120174000 <dyld_stub_binder+0x120174000>
104abf598: f9404300    	ldr	x0, [x24, #0x80] ; class MMThemeManager
104abf59c: aa1603e1    	mov	x1, x22
104abf5a0: 94c59ee7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf5a4: aa0003e2    	mov	x2, x0
104abf5a8: aa1c03e0    	mov	x0, x28
104abf5ac: aa1703e1    	mov	x1, x23
104abf5b0: 94c59ee3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf5b4: aa1d03fd    	mov	x29, x29
104abf5b8: 94c59ee4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf5bc: aa0003f9    	mov	x25, x0
104abf5c0: 900cd0c2    	adrp	x2, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
104abf5c4: 913d2042    	add	x2, x2, #0xf48 ; CFString 'person_regular'
104abf5c8: f9401bfb    	ldr	x27, [sp, #0x30]
104abf5cc: aa1b03e1    	mov	x1, x27
104abf5d0: 1e604100    	fmov	d0, d8
104abf5d4: 1e604121    	fmov	d1, d9
104abf5d8: f94037e3    	ldr	x3, [sp, #0x68]
104abf5dc: 94c59ed8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf5e0: aa1d03fd    	mov	x29, x29
104abf5e4: 94c59ed9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf5e8: aa0003f4    	mov	x20, x0
104abf5ec: f945ea60    	ldr	x0, [x19, #0xbd0] ; class MMContext
104abf5f0: aa1503e1    	mov	x1, x21
104abf5f4: 94c59ed2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf5f8: aa1d03fd    	mov	x29, x29
104abf5fc: 94c59ed3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf600: aa0003f3    	mov	x19, x0
104abf604: f9404300    	ldr	x0, [x24, #0x80] ; class MMThemeManager
104abf608: aa1603e1    	mov	x1, x22
104abf60c: 94c59ecc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf610: aa0003e2    	mov	x2, x0
104abf614: aa1303e0    	mov	x0, x19
104abf618: aa1703e1    	mov	x1, x23
104abf61c: 94c59ec8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf620: aa1d03fd    	mov	x29, x29
104abf624: 94c59ec9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf628: aa0003f6    	mov	x22, x0
104abf62c: b00cde42    	adrp	x2, 0x11e688000 <dyld_stub_binder+0x11e688000>
104abf630: 91312042    	add	x2, x2, #0xc48 ; CFString 'person_filled'
104abf634: aa1b03e1    	mov	x1, x27
104abf638: 1e604100    	fmov	d0, d8
104abf63c: 1e604121    	fmov	d1, d9
104abf640: f9402ffb    	ldr	x27, [sp, #0x58]
104abf644: aa1b03e3    	mov	x3, x27
104abf648: 94c59ebd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf64c: aa1d03fd    	mov	x29, x29
104abf650: 94c59ebe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abf654: aa0003f7    	mov	x23, x0
104abf658: f94007e0    	ldr	x0, [sp, #0x8]
104abf65c: f9402be1    	ldr	x1, [sp, #0x50]
104abf660: aa1a03e2    	mov	x2, x26
104abf664: aa1403e3    	mov	x3, x20
104abf668: aa1703e4    	mov	x4, x23
104abf66c: 94c59eb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf670: 900dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abf674: b9849d18    	ldrsw	x24, [x8, #0x49c]
104abf678: f94033f5    	ldr	x21, [sp, #0x60]
104abf67c: f8786aa8    	ldr	x8, [x21, x24]
104abf680: f8386aa0    	str	x0, [x21, x24]
104abf684: aa0803e0    	mov	x0, x8
104abf688: 94c59eb3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf68c: aa1703e0    	mov	x0, x23
104abf690: 94c59eb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf694: aa1603e0    	mov	x0, x22
104abf698: 94c59eaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf69c: aa1303e0    	mov	x0, x19
104abf6a0: 94c59ead    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6a4: aa1403e0    	mov	x0, x20
104abf6a8: 94c59eab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6ac: aa1903e0    	mov	x0, x25
104abf6b0: 94c59ea9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6b4: aa1c03e0    	mov	x0, x28
104abf6b8: 94c59ea7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6bc: aa1a03e0    	mov	x0, x26
104abf6c0: 94c59ea5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6c4: f9400be0    	ldr	x0, [sp, #0x10]
104abf6c8: 94c59ea3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6cc: f9400fe0    	ldr	x0, [sp, #0x18]
104abf6d0: 94c59ea1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf6d4: f8786aa0    	ldr	x0, [x21, x24]
104abf6d8: f94027e1    	ldr	x1, [sp, #0x48]
104abf6dc: 52800062    	mov	w2, #0x3                ; =3
104abf6e0: 94c59e97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf6e4: 900db5a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104abf6e8: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104abf6ec: 900ce708    	adrp	x8, 0x11e79f000 <dyld_stub_binder+0x11e79f000>
104abf6f0: 910e2108    	add	x8, x8, #0x388 ; CFString 'create m_moreTabItem !!'
104abf6f4: f90003e8    	str	x8, [sp]
104abf6f8: f94023e1    	ldr	x1, [sp, #0x40]
104abf6fc: 52800022    	mov	w2, #0x1                ; =1
104abf700: f00b3b43    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104abf704: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104abf708: 52800004    	mov	w4, #0x0                ; =0
104abf70c: 900b69a5    	adrp	x5, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf710: 910370a5    	add	x5, x5, #0xdc ; string 'MainTabBarViewController.mm'
104abf714: 528032a6    	mov	w6, #0x195              ; =405
104abf718: 900b69a7    	adrp	x7, 0x11b7f3000 <dyld_stub_binder+0x11b7f3000>
104abf71c: 910938e7    	add	x7, x7, #0x24e ; string '-[MainTabBarViewController p_createTabBarItems]'
104abf720: 94c59e87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abf724: aa1b03e0    	mov	x0, x27
104abf728: 94c59e8b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abf72c: f94037e0    	ldr	x0, [sp, #0x68]
104abf730: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
104abf734: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
104abf738: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
104abf73c: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
104abf740: a94967fa    	ldp	x26, x25, [sp, #0x90]
104abf744: a9486ffc    	ldp	x28, x27, [sp, #0x80]
104abf748: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
104abf74c: 910383ff    	add	sp, sp, #0xe0
104abf750: 14c59e81    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
