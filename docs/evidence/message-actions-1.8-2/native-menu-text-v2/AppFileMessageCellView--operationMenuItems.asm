
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1000cee70: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1000cee74: a9014ff4    	stp	x20, x19, [sp, #0x10]
1000cee78: a9027bfd    	stp	x29, x30, [sp, #0x20]
1000cee7c: 910083fd    	add	x29, sp, #0x20
1000cee80: aa0003f4    	mov	x20, x0
1000cee84: f0105ae8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
1000cee88: 52800029    	mov	w9, #0x1                ; =1
1000cee8c: 39150d09    	strb	w9, [x8, #0x543]
1000cee90: b0100528    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1000cee94: f9455500    	ldr	x0, [x8, #0xaa8]
1000cee98: 95ed60b0    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1000cee9c: aa0003f3    	mov	x19, x0
1000ceea0: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000ceea4: f9433101    	ldr	x1, [x8, #0x660] ; canShowForwardMenu
1000ceea8: aa1403e0    	mov	x0, x20
1000ceeac: 95ed60a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000ceeb0: 34000280    	cbz	w0, 0x1000cef00 <__text+0xc6f00>
1000ceeb4: 900feb88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000ceeb8: f9414d01    	ldr	x1, [x8, #0x298] ; canShowForwardMenuItem
1000ceebc: aa1403e0    	mov	x0, x20
1000ceec0: 95ed609f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000ceec4: 340001e0    	cbz	w0, 0x1000cef00 <__text+0xc6f00>
1000ceec8: 900feb88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000ceecc: f9415101    	ldr	x1, [x8, #0x2a0] ; forwardMenuItem
1000ceed0: aa1403e0    	mov	x0, x20
1000ceed4: 95ed609a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000ceed8: aa1d03fd    	mov	x29, x29
1000ceedc: 95ed609b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000ceee0: aa0003f5    	mov	x21, x0
1000ceee4: 900feb68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1000ceee8: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1000ceeec: aa1303e0    	mov	x0, x19
1000ceef0: aa1503e2    	mov	x2, x21
1000ceef4: 95ed6092    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000ceef8: aa1503e0    	mov	x0, x21
1000ceefc: 95ed6096    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000cef00: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cef04: f9433501    	ldr	x1, [x8, #0x668] ; canShowFavoriteMenu
1000cef08: aa1403e0    	mov	x0, x20
1000cef0c: 95ed608c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cef10: 340001e0    	cbz	w0, 0x1000cef4c <__text+0xc6f4c>
1000cef14: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cef18: f9433901    	ldr	x1, [x8, #0x670] ; favoriteMenuItem
1000cef1c: aa1403e0    	mov	x0, x20
1000cef20: 95ed6087    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cef24: aa1d03fd    	mov	x29, x29
1000cef28: 95ed6088    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000cef2c: aa0003f5    	mov	x21, x0
1000cef30: 900feb68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1000cef34: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1000cef38: aa1303e0    	mov	x0, x19
1000cef3c: aa1503e2    	mov	x2, x21
1000cef40: 95ed607f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cef44: aa1503e0    	mov	x0, x21
1000cef48: 95ed6083    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000cef4c: 900feb88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1000cef50: f9415501    	ldr	x1, [x8, #0x2a8] ; addRevokeOrDeleteMenuItem:
1000cef54: aa1403e0    	mov	x0, x20
1000cef58: aa1303e2    	mov	x2, x19
1000cef5c: 95ed6078    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cef60: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cef64: f9433d01    	ldr	x1, [x8, #0x678] ; canShowShareMsgToThirdPartyServiceMenuItem
1000cef68: aa1403e0    	mov	x0, x20
1000cef6c: 95ed6074    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cef70: 340001e0    	cbz	w0, 0x1000cefac <__text+0xc6fac>
1000cef74: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cef78: f9434101    	ldr	x1, [x8, #0x680] ; shareMsgToThirdPartyServiceMenuItem
1000cef7c: aa1403e0    	mov	x0, x20
1000cef80: 95ed606f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cef84: aa1d03fd    	mov	x29, x29
1000cef88: 95ed6070    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000cef8c: aa0003f5    	mov	x21, x0
1000cef90: 900feb68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1000cef94: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1000cef98: aa1303e0    	mov	x0, x19
1000cef9c: aa1503e2    	mov	x2, x21
1000cefa0: 95ed6067    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cefa4: aa1503e0    	mov	x0, x21
1000cefa8: 95ed606b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000cefac: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cefb0: f9434501    	ldr	x1, [x8, #0x688] ; messageFileSummaryMenuMode
1000cefb4: aa1403e0    	mov	x0, x20
1000cefb8: 95ed6061    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cefbc: b40001c0    	cbz	x0, 0x1000ceff4 <__text+0xc6ff4>
1000cefc0: f100041f    	cmp	x0, #0x1
1000cefc4: 540004a1    	b.ne	0x1000cf058 <__text+0xc7058>
1000cefc8: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cefcc: f9434901    	ldr	x1, [x8, #0x690] ; canShowXiaoWeiSummaryMenuItem
1000cefd0: aa1403e0    	mov	x0, x20
1000cefd4: 95ed605a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cefd8: 36000400    	tbz	w0, #0x0, 0x1000cf058 <__text+0xc7058>
1000cefdc: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cefe0: 911a8108    	add	x8, x8, #0x6a0
1000cefe4: 52800722    	mov	w2, #0x39               ; =57
1000cefe8: b00feb89    	adrp	x9, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cefec: 911a6129    	add	x9, x9, #0x698
1000ceff0: 1400000b    	b	0x1000cf01c <__text+0xc701c>
1000ceff4: b00feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000ceff8: f9435501    	ldr	x1, [x8, #0x6a8] ; canShowYuanBaoSummaryMenuItem
1000ceffc: aa1403e0    	mov	x0, x20
1000cf000: 95ed604f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cf004: 340002a0    	cbz	w0, 0x1000cf058 <__text+0xc7058>
1000cf008: 900feb88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cf00c: 911ae108    	add	x8, x8, #0x6b8
1000cf010: 528005c2    	mov	w2, #0x2e               ; =46
1000cf014: 900feb89    	adrp	x9, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
1000cf018: 911ac129    	add	x9, x9, #0x6b0
1000cf01c: f9400124    	ldr	x4, [x9]
1000cf020: f9400101    	ldr	x1, [x8]
1000cf024: aa1403e0    	mov	x0, x20
1000cf028: d2800003    	mov	x3, #0x0                ; =0
1000cf02c: 95ed6044    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cf030: aa1d03fd    	mov	x29, x29
1000cf034: 95ed6045    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1000cf038: aa0003f4    	mov	x20, x0
1000cf03c: f00feb48    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1000cf040: f943c501    	ldr	x1, [x8, #0x788] ; safeAddObject:
1000cf044: aa1303e0    	mov	x0, x19
1000cf048: aa1403e2    	mov	x2, x20
1000cf04c: 95ed603c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1000cf050: aa1403e0    	mov	x0, x20
1000cf054: 95ed6040    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1000cf058: aa1303e0    	mov	x0, x19
1000cf05c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1000cf060: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1000cf064: a8c357f6    	ldp	x22, x21, [sp], #0x30
1000cf068: 15ed6042    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>