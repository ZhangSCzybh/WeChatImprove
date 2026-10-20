
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f568c8: d10343ff    	sub	sp, sp, #0xd0
100f568cc: 6d052beb    	stp	d11, d10, [sp, #0x50]
100f568d0: 6d0623e9    	stp	d9, d8, [sp, #0x60]
100f568d4: a9076ffc    	stp	x28, x27, [sp, #0x70]
100f568d8: a90867fa    	stp	x26, x25, [sp, #0x80]
100f568dc: a9095ff8    	stp	x24, x23, [sp, #0x90]
100f568e0: a90a57f6    	stp	x22, x21, [sp, #0xa0]
100f568e4: a90b4ff4    	stp	x20, x19, [sp, #0xb0]
100f568e8: a90c7bfd    	stp	x29, x30, [sp, #0xc0]
100f568ec: 910303fd    	add	x29, sp, #0xc0
100f568f0: aa0003f3    	mov	x19, x0
100f568f4: d00fe6c8    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100f568f8: 52800029    	mov	w9, #0x1                ; =1
100f568fc: 39285d09    	strb	w9, [x8, #0xa17]
100f56900: b00f9128    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
100f56904: f9450900    	ldr	x0, [x8, #0xa10]
100f56908: 95b34214    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100f5690c: f00f9488    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
100f56910: b984a109    	ldrsw	x9, [x8, #0x4a0]
100f56914: f8696a68    	ldr	x8, [x19, x9]
100f56918: f90027e9    	str	x9, [sp, #0x48]
100f5691c: f8296a60    	str	x0, [x19, x9]
100f56920: aa0803e0    	mov	x0, x8
100f56924: 95b3420c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56928: b00f90fa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
100f5692c: f9463348    	ldr	x8, [x26, #0xc60]
100f56930: f90013e8    	str	x8, [sp, #0x20]
100f56934: b00f90f5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
100f56938: f945eaa0    	ldr	x0, [x21, #0xbd0] ; ��d 
100f5693c: d00f8d48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100f56940: f944e91b    	ldr	x27, [x8, #0x9d0] ; currentContext
100f56944: aa1b03e1    	mov	x1, x27
100f56948: 95b341fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5694c: aa1d03fd    	mov	x29, x29
100f56950: 95b341fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56954: aa0003f6    	mov	x22, x0
100f56958: d00f90f4    	adrp	x20, 0x120174000 <dyld_stub_binder+0x120174000>
100f5695c: f9404280    	ldr	x0, [x20, #0x80]
100f56960: b00f8d48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f56964: f947ad01    	ldr	x1, [x8, #0xf58] ; class
100f56968: f90023e1    	str	x1, [sp, #0x40]
100f5696c: 95b341f4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56970: aa0003e2    	mov	x2, x0
100f56974: f00f7708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f56978: f946411c    	ldr	x28, [x8, #0xc80] ; getService:
100f5697c: f9001ff6    	str	x22, [sp, #0x38]
100f56980: aa1603e0    	mov	x0, x22
100f56984: aa1c03e1    	mov	x1, x28
100f56988: 95b341ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5698c: aa1d03fd    	mov	x29, x29
100f56990: 95b341ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56994: d00f7728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f56998: f9400516    	ldr	x22, [x8, #0x8] ; colorList
100f5699c: f9001be0    	str	x0, [sp, #0x30]
100f569a0: aa1603e1    	mov	x1, x22
100f569a4: 95b341e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f569a8: aa1d03fd    	mov	x29, x29
100f569ac: 95b341e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f569b0: d00f7728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f569b4: f9400918    	ldr	x24, [x8, #0x10] ; getColorByName:
100f569b8: d00eaf42    	adrp	x2, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f569bc: 912b2042    	add	x2, x2, #0xac8
100f569c0: f90017e0    	str	x0, [sp, #0x28]
100f569c4: aa1803e1    	mov	x1, x24
100f569c8: 95b341dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f569cc: aa1d03fd    	mov	x29, x29
100f569d0: 95b341de    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f569d4: aa0003f9    	mov	x25, x0
100f569d8: 95b341d8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f569dc: b40000c0    	cbz	x0, 0x100f569f4 <__text+0xf4e9f4>
100f569e0: aa1a03f7    	mov	x23, x26
100f569e4: aa1903e0    	mov	x0, x25
100f569e8: 95b341d4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f569ec: aa1903fa    	mov	x26, x25
100f569f0: 14000009    	b	0x100f56a14 <__text+0xf4ea14>
100f569f4: aa1a03f7    	mov	x23, x26
100f569f8: f9463340    	ldr	x0, [x26, #0xc60]
100f569fc: b00f8d48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f56a00: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
100f56a04: 95b341ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56a08: aa1d03fd    	mov	x29, x29
100f56a0c: 95b341cf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56a10: aa0003fa    	mov	x26, x0
100f56a14: aa1903e0    	mov	x0, x25
100f56a18: 95b341cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56a1c: f945eaa0    	ldr	x0, [x21, #0xbd0] ; ��d 
100f56a20: aa1b03e1    	mov	x1, x27
100f56a24: 95b341c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56a28: aa1d03fd    	mov	x29, x29
100f56a2c: 95b341c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56a30: aa0003fb    	mov	x27, x0
100f56a34: f9404280    	ldr	x0, [x20, #0x80]
100f56a38: f94023e1    	ldr	x1, [sp, #0x40]
100f56a3c: 95b341c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56a40: aa0003e2    	mov	x2, x0
100f56a44: aa1b03e0    	mov	x0, x27
100f56a48: aa1c03e1    	mov	x1, x28
100f56a4c: 95b341bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56a50: aa1d03fd    	mov	x29, x29
100f56a54: 95b341bd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56a58: aa0003fc    	mov	x28, x0
100f56a5c: aa1603e1    	mov	x1, x22
100f56a60: 95b341b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56a64: aa1d03fd    	mov	x29, x29
100f56a68: 95b341b8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56a6c: aa0003f6    	mov	x22, x0
100f56a70: d00eaf42    	adrp	x2, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f56a74: 912ba042    	add	x2, x2, #0xae8
100f56a78: aa1803e1    	mov	x1, x24
100f56a7c: 95b341b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56a80: aa1d03fd    	mov	x29, x29
100f56a84: 95b341b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56a88: aa0003f8    	mov	x24, x0
100f56a8c: 95b341ab    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f56a90: b40000a0    	cbz	x0, 0x100f56aa4 <__text+0xf4eaa4>
100f56a94: aa1803e0    	mov	x0, x24
100f56a98: 95b341a8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f56a9c: aa1803f4    	mov	x20, x24
100f56aa0: 14000008    	b	0x100f56ac0 <__text+0xf4eac0>
100f56aa4: f94632e0    	ldr	x0, [x23, #0xc60]
100f56aa8: b00f8d48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100f56aac: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
100f56ab0: 95b341a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ab4: aa1d03fd    	mov	x29, x29
100f56ab8: 95b341a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56abc: aa0003f4    	mov	x20, x0
100f56ac0: aa1803e0    	mov	x0, x24
100f56ac4: 95b341a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56ac8: b00f7748    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f56acc: f946bd01    	ldr	x1, [x8, #0xd78] ; colorInLightMode:DarkMode:
100f56ad0: f94013e0    	ldr	x0, [sp, #0x20]
100f56ad4: aa1a03e2    	mov	x2, x26
100f56ad8: aa1403e3    	mov	x3, x20
100f56adc: 95b34198    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ae0: aa1d03fd    	mov	x29, x29
100f56ae4: 95b34199    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56ae8: aa0003f5    	mov	x21, x0
100f56aec: f94027f7    	ldr	x23, [sp, #0x48]
100f56af0: f8776a60    	ldr	x0, [x19, x23]
100f56af4: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56af8: f9466901    	ldr	x1, [x8, #0xcd0] ; setReferTextBlurColor:
100f56afc: aa1503e2    	mov	x2, x21
100f56b00: 95b3418f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56b04: aa1503e0    	mov	x0, x21
100f56b08: 95b34193    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b0c: aa1403e0    	mov	x0, x20
100f56b10: 95b34191    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b14: aa1803e0    	mov	x0, x24
100f56b18: 95b3418f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b1c: aa1603e0    	mov	x0, x22
100f56b20: 95b3418d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b24: aa1c03e0    	mov	x0, x28
100f56b28: 95b3418b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b2c: aa1b03e0    	mov	x0, x27
100f56b30: 95b34189    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b34: aa1a03e0    	mov	x0, x26
100f56b38: 95b34187    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b3c: aa1903e0    	mov	x0, x25
100f56b40: 95b34185    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b44: f94017e0    	ldr	x0, [sp, #0x28]
100f56b48: 95b34183    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b4c: f9401be0    	ldr	x0, [sp, #0x30]
100f56b50: 95b34181    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b54: f9401fe0    	ldr	x0, [sp, #0x38]
100f56b58: 95b3417f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56b5c: d00f90e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f56b60: f9414500    	ldr	x0, [x8, #0x288]
100f56b64: 95b3417f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100f56b68: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56b6c: f9466d03    	ldr	x3, [x8, #0xcd8] ; onTapMsgReplyView:
100f56b70: b00f8d68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f56b74: f9413519    	ldr	x25, [x8, #0x268] ; initWithTarget:action:
100f56b78: aa1903e1    	mov	x1, x25
100f56b7c: aa1303e2    	mov	x2, x19
100f56b80: 95b3416f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56b84: aa0003f4    	mov	x20, x0
100f56b88: b00f8d88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
100f56b8c: f9422d01    	ldr	x1, [x8, #0x458] ; setCancelsTouchesInView:
100f56b90: 52800002    	mov	w2, #0x0                ; =0
100f56b94: 95b3416a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56b98: f8776a60    	ldr	x0, [x19, x23]
100f56b9c: 900f8d48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
100f56ba0: f946b516    	ldr	x22, [x8, #0xd68] ; addGestureRecognizer:
100f56ba4: aa1603e1    	mov	x1, x22
100f56ba8: f9001ff4    	str	x20, [sp, #0x38]
100f56bac: aa1403e2    	mov	x2, x20
100f56bb0: 95b34163    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56bb4: 900f7748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f56bb8: f9410917    	ldr	x23, [x8, #0x210] ; viewModel
100f56bbc: aa1303e0    	mov	x0, x19
100f56bc0: aa1703e1    	mov	x1, x23
100f56bc4: 95b3415e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56bc8: aa1d03fd    	mov	x29, x29
100f56bcc: 95b3415f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56bd0: aa0003f4    	mov	x20, x0
100f56bd4: 900f7748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f56bd8: f941051c    	ldr	x28, [x8, #0x208] ; messageWrap
100f56bdc: aa1c03e1    	mov	x1, x28
100f56be0: 95b34157    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56be4: aa1d03fd    	mov	x29, x29
100f56be8: 95b34158    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56bec: aa0003f8    	mov	x24, x0
100f56bf0: b00f7768    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
100f56bf4: f9464501    	ldr	x1, [x8, #0xc88] ; referingMessageWrap
100f56bf8: f9001be1    	str	x1, [sp, #0x30]
100f56bfc: 95b34150    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56c00: aa1d03fd    	mov	x29, x29
100f56c04: 95b34151    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56c08: aa0003fa    	mov	x26, x0
100f56c0c: 900f7748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
100f56c10: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
100f56c14: 95b3414a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56c18: aa0003fb    	mov	x27, x0
100f56c1c: aa1a03e0    	mov	x0, x26
100f56c20: 95b3414d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56c24: aa1803e0    	mov	x0, x24
100f56c28: 95b3414b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56c2c: aa1403e0    	mov	x0, x20
100f56c30: 95b34149    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56c34: 5284e208    	mov	w8, #0x2710             ; =10000
100f56c38: 6b08037f    	cmp	w27, w8
100f56c3c: 54000220    	b.eq	0x100f56c80 <__text+0xf4ec80>
100f56c40: f00f90e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100f56c44: f945c500    	ldr	x0, [x8, #0xb88]
100f56c48: 95b34146    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100f56c4c: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56c50: f9467103    	ldr	x3, [x8, #0xce0] ; onLongPressMsgReplyView:
100f56c54: aa1903e1    	mov	x1, x25
100f56c58: aa1303e2    	mov	x2, x19
100f56c5c: 95b34138    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56c60: aa0003f4    	mov	x20, x0
100f56c64: f94027e8    	ldr	x8, [sp, #0x48]
100f56c68: f8686a60    	ldr	x0, [x19, x8]
100f56c6c: aa1603e1    	mov	x1, x22
100f56c70: aa1403e2    	mov	x2, x20
100f56c74: 95b34132    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56c78: aa1403e0    	mov	x0, x20
100f56c7c: 95b34136    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56c80: b00f90f5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
100f56c84: f94536b4    	ldr	x20, [x21, #0xa68] ; �gH 
100f56c88: aa1303e0    	mov	x0, x19
100f56c8c: aa1703e1    	mov	x1, x23
100f56c90: 95b3412b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56c94: aa1d03fd    	mov	x29, x29
100f56c98: 95b3412c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56c9c: aa0003f6    	mov	x22, x0
100f56ca0: aa1c03e1    	mov	x1, x28
100f56ca4: 95b34126    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ca8: aa1d03fd    	mov	x29, x29
100f56cac: 95b34127    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56cb0: aa0003f8    	mov	x24, x0
100f56cb4: b00f7748    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f56cb8: f944f101    	ldr	x1, [x8, #0x9e0] ; m_nsMsgSource
100f56cbc: 95b34120    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56cc0: aa1d03fd    	mov	x29, x29
100f56cc4: 95b34121    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56cc8: aa1c03fb    	mov	x27, x28
100f56ccc: aa0003fc    	mov	x28, x0
100f56cd0: f00f7708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f56cd4: f942a919    	ldr	x25, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
100f56cd8: a90083f3    	stp	x19, x0, [sp, #0x8]
100f56cdc: d00eaf48    	adrp	x8, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f56ce0: 912c2108    	add	x8, x8, #0xb08
100f56ce4: f90003e8    	str	x8, [sp]
100f56ce8: b00d2045    	adrp	x5, 0x11b35f000 <dyld_stub_binder+0x11b35f000>
100f56cec: 911b4ca5    	add	x5, x5, #0x6d3
100f56cf0: b00d2047    	adrp	x7, 0x11b35f000 <dyld_stub_binder+0x11b35f000>
100f56cf4: 911e4ce7    	add	x7, x7, #0x793
100f56cf8: aa1403e0    	mov	x0, x20
100f56cfc: aa1903e1    	mov	x1, x25
100f56d00: 52800022    	mov	w2, #0x1                ; =1
100f56d04: d2800003    	mov	x3, #0x0                ; =0
100f56d08: 52800004    	mov	w4, #0x0                ; =0
100f56d0c: 52805206    	mov	w6, #0x290              ; =656
100f56d10: 95b3410b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56d14: aa1c03e0    	mov	x0, x28
100f56d18: 95b3410f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56d1c: aa1803e0    	mov	x0, x24
100f56d20: 95b3410d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56d24: aa1603e0    	mov	x0, x22
100f56d28: 95b3410b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56d2c: f94536b8    	ldr	x24, [x21, #0xa68] ; �gH 
100f56d30: b00f90e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f56d34: f945451a    	ldr	x26, [x8, #0xa88]
100f56d38: aa1303e0    	mov	x0, x19
100f56d3c: aa1703e1    	mov	x1, x23
100f56d40: 95b340ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56d44: aa1d03fd    	mov	x29, x29
100f56d48: 95b34100    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56d4c: aa0003fc    	mov	x28, x0
100f56d50: aa1b03f5    	mov	x21, x27
100f56d54: f90017fb    	str	x27, [sp, #0x28]
100f56d58: aa1b03e1    	mov	x1, x27
100f56d5c: 95b340f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56d60: aa1d03fd    	mov	x29, x29
100f56d64: 95b340f9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56d68: aa0003f6    	mov	x22, x0
100f56d6c: f00f7728    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100f56d70: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
100f56d74: 95b340f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56d78: aa1d03fd    	mov	x29, x29
100f56d7c: 95b340f3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56d80: aa0003f4    	mov	x20, x0
100f56d84: d00f7728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f56d88: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
100f56d8c: aa1a03e0    	mov	x0, x26
100f56d90: aa1403e2    	mov	x2, x20
100f56d94: 95b340ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56d98: aa1d03fd    	mov	x29, x29
100f56d9c: 95b340eb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56da0: aa0003fa    	mov	x26, x0
100f56da4: aa1303e0    	mov	x0, x19
100f56da8: aa1703e1    	mov	x1, x23
100f56dac: 95b340e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56db0: aa1d03fd    	mov	x29, x29
100f56db4: 95b340e5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56db8: aa0003fb    	mov	x27, x0
100f56dbc: aa1503e1    	mov	x1, x21
100f56dc0: 95b340df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56dc4: aa1d03fd    	mov	x29, x29
100f56dc8: 95b340e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56dcc: aa0003f5    	mov	x21, x0
100f56dd0: d00f7728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f56dd4: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
100f56dd8: 95b340d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ddc: a90103fa    	stp	x26, x0, [sp, #0x10]
100f56de0: d00eaf48    	adrp	x8, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f56de4: 912ca108    	add	x8, x8, #0xb28
100f56de8: a9004fe8    	stp	x8, x19, [sp]
100f56dec: aa1803e0    	mov	x0, x24
100f56df0: aa1903e1    	mov	x1, x25
100f56df4: 52800042    	mov	w2, #0x2                ; =2
100f56df8: d2800003    	mov	x3, #0x0                ; =0
100f56dfc: 52800004    	mov	w4, #0x0                ; =0
100f56e00: b00d2045    	adrp	x5, 0x11b35f000 <dyld_stub_binder+0x11b35f000>
100f56e04: 911b4ca5    	add	x5, x5, #0x6d3
100f56e08: 52805286    	mov	w6, #0x294              ; =660
100f56e0c: b00d2047    	adrp	x7, 0x11b35f000 <dyld_stub_binder+0x11b35f000>
100f56e10: 911e4ce7    	add	x7, x7, #0x793
100f56e14: 95b340ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56e18: aa1503e0    	mov	x0, x21
100f56e1c: 95b340ce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e20: aa1b03e0    	mov	x0, x27
100f56e24: 95b340cc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e28: aa1a03e0    	mov	x0, x26
100f56e2c: 95b340ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e30: aa1403e0    	mov	x0, x20
100f56e34: 95b340c8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e38: aa1603e0    	mov	x0, x22
100f56e3c: 95b340c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e40: aa1c03e0    	mov	x0, x28
100f56e44: aa1703fc    	mov	x28, x23
100f56e48: 95b340c3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e4c: aa1303e0    	mov	x0, x19
100f56e50: aa1703e1    	mov	x1, x23
100f56e54: 95b340ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56e58: aa1d03fd    	mov	x29, x29
100f56e5c: 95b340bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56e60: aa0003f4    	mov	x20, x0
100f56e64: d00f7748    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100f56e68: f9461501    	ldr	x1, [x8, #0xc28] ; isUseLightStyle
100f56e6c: 95b340b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56e70: aa0003e2    	mov	x2, x0
100f56e74: f94027fb    	ldr	x27, [sp, #0x48]
100f56e78: f87b6a60    	ldr	x0, [x19, x27]
100f56e7c: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56e80: f9467501    	ldr	x1, [x8, #0xce8] ; setUseCustomBackgroundView:
100f56e84: 95b340ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56e88: aa1403e0    	mov	x0, x20
100f56e8c: 95b340b2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56e90: aa1303e0    	mov	x0, x19
100f56e94: aa1703e1    	mov	x1, x23
100f56e98: 95b340a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56e9c: aa1d03fd    	mov	x29, x29
100f56ea0: 95b340aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56ea4: aa0003f4    	mov	x20, x0
100f56ea8: f94017e1    	ldr	x1, [sp, #0x28]
100f56eac: 95b340a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56eb0: aa1d03fd    	mov	x29, x29
100f56eb4: 95b340a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56eb8: aa0003f5    	mov	x21, x0
100f56ebc: f9401be1    	ldr	x1, [sp, #0x30]
100f56ec0: 95b3409f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ec4: aa1d03fd    	mov	x29, x29
100f56ec8: 95b340a0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56ecc: aa0003f7    	mov	x23, x0
100f56ed0: aa1503e0    	mov	x0, x21
100f56ed4: 95b340a0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56ed8: aa1403e0    	mov	x0, x20
100f56edc: 95b3409e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56ee0: 900f9108    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100f56ee4: f9418114    	ldr	x20, [x8, #0x300] ; �+* 
100f56ee8: aa1303e0    	mov	x0, x19
100f56eec: aa1c03e1    	mov	x1, x28
100f56ef0: 95b34093    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ef4: aa1d03fd    	mov	x29, x29
100f56ef8: 95b34094    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56efc: aa0003f5    	mov	x21, x0
100f56f00: b00f7748    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100f56f04: f9437901    	ldr	x1, [x8, #0x6f0] ; chatContact
100f56f08: 95b3408d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56f0c: aa1d03fd    	mov	x29, x29
100f56f10: 95b3408e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56f14: aa0003f6    	mov	x22, x0
100f56f18: f00f77a8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
100f56f1c: f9476901    	ldr	x1, [x8, #0xed0] ; createMessageViewModelWithMessageWrap:contact:chatContact:
100f56f20: aa1403e0    	mov	x0, x20
100f56f24: aa1703e2    	mov	x2, x23
100f56f28: d2800003    	mov	x3, #0x0                ; =0
100f56f2c: aa1603e4    	mov	x4, x22
100f56f30: 95b34083    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56f34: aa1d03fd    	mov	x29, x29
100f56f38: 95b34084    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f56f3c: aa0003f8    	mov	x24, x0
100f56f40: aa1603e0    	mov	x0, x22
100f56f44: 95b34084    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56f48: aa1503e0    	mov	x0, x21
100f56f4c: 95b34082    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f56f50: 900f9108    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
100f56f54: f9437900    	ldr	x0, [x8, #0x6f0] ; �&, 
100f56f58: f94023e1    	ldr	x1, [sp, #0x40]
100f56f5c: 95b34078    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56f60: aa0003e2    	mov	x2, x0
100f56f64: b00f8d68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f56f68: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100f56f6c: aa1803e0    	mov	x0, x24
100f56f70: 95b34073    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56f74: 34001140    	cbz	w0, 0x100f5719c <__text+0xf4f19c>
100f56f78: aa1803e0    	mov	x0, x24
100f56f7c: 95b3406f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100f56f80: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56f84: f9467901    	ldr	x1, [x8, #0xcf0] ; hasReferImage
100f56f88: 95b3406d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56f8c: aa0003e8    	mov	x8, x0
100f56f90: f87b6a60    	ldr	x0, [x19, x27]
100f56f94: 34000ea8    	cbz	w8, 0x100f57168 <__text+0xf4f168>
100f56f98: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56f9c: f9467d01    	ldr	x1, [x8, #0xcf8] ; setCanShowThumbImage:
100f56fa0: 52800022    	mov	w2, #0x1                ; =1
100f56fa4: 95b34066    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56fa8: d00f7728    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100f56fac: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
100f56fb0: aa1703e0    	mov	x0, x23
100f56fb4: 95b34062    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56fb8: 350000c0    	cbnz	w0, 0x100f56fd0 <__text+0xf4efd0>
100f56fbc: d00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f56fc0: f9468101    	ldr	x1, [x8, #0xd00] ; isFakeReferMsg
100f56fc4: aa1703e0    	mov	x0, x23
100f56fc8: 95b3405d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56fcc: 34001f40    	cbz	w0, 0x100f573b4 <__text+0xf4f3b4>
100f56fd0: b00f90fa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
100f56fd4: f9461b40    	ldr	x0, [x26, #0xc30]
100f56fd8: f00f7708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100f56fdc: f9463119    	ldr	x25, [x8, #0xc60] ; dynamicLength:
100f56fe0: d2e80808    	mov	x8, #0x4040000000000000 ; =4629700416936869888
100f56fe4: 9e670108    	fmov	d8, x8
100f56fe8: aa1903e1    	mov	x1, x25
100f56fec: 1e604100    	fmov	d0, d8
100f56ff0: 95b34053    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f56ff4: 1e604009    	fmov	d9, d0
100f56ff8: f9461b40    	ldr	x0, [x26, #0xc30]
100f56ffc: aa1903e1    	mov	x1, x25
100f57000: 1e604100    	fmov	d0, d8
100f57004: 95b3404e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57008: 1e604001    	fmov	d1, d0
100f5700c: b00f77c8    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
100f57010: f9461901    	ldr	x1, [x8, #0xc30] ; getReferImageViewWithSize:
100f57014: aa1803e0    	mov	x0, x24
100f57018: 1e604120    	fmov	d0, d9
100f5701c: 95b34048    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57020: aa1d03fd    	mov	x29, x29
100f57024: 95b34049    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f57028: aa0003f6    	mov	x22, x0
100f5702c: b5000500    	cbnz	x0, 0x100f570cc <__text+0xf4f0cc>
100f57030: b00f90e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100f57034: f940b900    	ldr	x0, [x8, #0x170]
100f57038: 95b3404a    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100f5703c: aa0003f4    	mov	x20, x0
100f57040: 900f90e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f57044: f946d500    	ldr	x0, [x8, #0xda8]
100f57048: f00f8d48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100f5704c: f9455d01    	ldr	x1, [x8, #0xab8] ; imageNamed:
100f57050: b00eaf42    	adrp	x2, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f57054: 912d2042    	add	x2, x2, #0xb48
100f57058: 95b34039    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5705c: aa1d03fd    	mov	x29, x29
100f57060: 95b3403a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f57064: aa0003f5    	mov	x21, x0
100f57068: 900f8d68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100f5706c: f9400101    	ldr	x1, [x8]
100f57070: aa1403e0    	mov	x0, x20
100f57074: aa1503e2    	mov	x2, x21
100f57078: 95b34031    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5707c: aa0003f6    	mov	x22, x0
100f57080: aa1503e0    	mov	x0, x21
100f57084: 95b34034    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57088: f9461b40    	ldr	x0, [x26, #0xc30]
100f5708c: d2e80808    	mov	x8, #0x4040000000000000 ; =4629700416936869888
100f57090: 9e670108    	fmov	d8, x8
100f57094: aa1903e1    	mov	x1, x25
100f57098: 1e604100    	fmov	d0, d8
100f5709c: 95b34028    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f570a0: 1e604009    	fmov	d9, d0
100f570a4: f9461b40    	ldr	x0, [x26, #0xc30]
100f570a8: aa1903e1    	mov	x1, x25
100f570ac: 1e604100    	fmov	d0, d8
100f570b0: 95b34023    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f570b4: 1e604001    	fmov	d1, d0
100f570b8: d00f8d88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
100f570bc: f9453d01    	ldr	x1, [x8, #0xa78] ; setSize:
100f570c0: aa1603e0    	mov	x0, x22
100f570c4: 1e604120    	fmov	d0, d9
100f570c8: 95b3401d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f570cc: 900f8d88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
100f570d0: f9439d01    	ldr	x1, [x8, #0x738] ; setContentMode:
100f570d4: aa1603e0    	mov	x0, x22
100f570d8: 52800042    	mov	w2, #0x2                ; =2
100f570dc: 95b34018    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f570e0: 900f8d88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
100f570e4: f942e101    	ldr	x1, [x8, #0x5c0] ; setClipsToBounds:
100f570e8: aa1603e0    	mov	x0, x22
100f570ec: 52800022    	mov	w2, #0x1                ; =1
100f570f0: 95b34013    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f570f4: f87b6a60    	ldr	x0, [x19, x27]
100f570f8: f00f7928    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
100f570fc: f947bd19    	ldr	x25, [x8, #0xf78] ; thumbImageView
100f57100: aa1903e1    	mov	x1, x25
100f57104: 95b3400e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57108: aa1d03fd    	mov	x29, x29
100f5710c: 95b3400f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f57110: aa0003f5    	mov	x21, x0
100f57114: f00f8d28    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
100f57118: f9476d14    	ldr	x20, [x8, #0xed8] ; addSubview:
100f5711c: aa1403e1    	mov	x1, x20
100f57120: aa1603e2    	mov	x2, x22
100f57124: 95b34006    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57128: aa1503e0    	mov	x0, x21
100f5712c: 95b3400a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57130: aa1603e0    	mov	x0, x22
100f57134: 95b34008    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57138: f87b6a75    	ldr	x21, [x19, x27]
100f5713c: aa1503e0    	mov	x0, x21
100f57140: aa1903e1    	mov	x1, x25
100f57144: 95b33ffe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57148: aa1d03fd    	mov	x29, x29
100f5714c: 95b33fff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f57150: aa0003f6    	mov	x22, x0
100f57154: aa1503e0    	mov	x0, x21
100f57158: aa1403e1    	mov	x1, x20
100f5715c: aa1603e2    	mov	x2, x22
100f57160: 95b33ff7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57164: 1400000a    	b	0x100f5718c <__text+0xf4f18c>
100f57168: f00f7928    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
100f5716c: f947bd01    	ldr	x1, [x8, #0xf78] ; thumbImageView
100f57170: 95b33ff3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57174: aa1d03fd    	mov	x29, x29
100f57178: 95b33ff4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5717c: aa0003f6    	mov	x22, x0
100f57180: f00f8d68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
100f57184: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
100f57188: 95b33fed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5718c: aa1603e0    	mov	x0, x22
100f57190: 95b33ff1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57194: aa1803e0    	mov	x0, x24
100f57198: 95b33fef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5719c: aa1303e0    	mov	x0, x19
100f571a0: aa1c03e1    	mov	x1, x28
100f571a4: 95b33fe6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f571a8: aa1d03fd    	mov	x29, x29
100f571ac: 95b33fe7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f571b0: aa0003f4    	mov	x20, x0
100f571b4: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f571b8: f9468501    	ldr	x1, [x8, #0xd08] ; canReplyMessageJump
100f571bc: 95b33fe0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f571c0: aa0003e2    	mov	x2, x0
100f571c4: f87b6a60    	ldr	x0, [x19, x27]
100f571c8: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f571cc: f9468901    	ldr	x1, [x8, #0xd10] ; setIsJumpable:
100f571d0: 95b33fdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f571d4: aa1403e0    	mov	x0, x20
100f571d8: 95b33fdf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f571dc: aa1303e0    	mov	x0, x19
100f571e0: aa1c03e1    	mov	x1, x28
100f571e4: 95b33fd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f571e8: aa1d03fd    	mov	x29, x29
100f571ec: 95b33fd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f571f0: aa0003f4    	mov	x20, x0
100f571f4: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f571f8: f9468d01    	ldr	x1, [x8, #0xd18] ; replyTextInset
100f571fc: 95b33fd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57200: 1e604008    	fmov	d8, d0
100f57204: 1e604029    	fmov	d9, d1
100f57208: 1e60404a    	fmov	d10, d2
100f5720c: 1e60406b    	fmov	d11, d3
100f57210: aa1403e0    	mov	x0, x20
100f57214: 95b33fd0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57218: f87b6a60    	ldr	x0, [x19, x27]
100f5721c: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f57220: f9469101    	ldr	x1, [x8, #0xd20] ; setContainerInset:
100f57224: 1e604100    	fmov	d0, d8
100f57228: 1e604121    	fmov	d1, d9
100f5722c: 1e604142    	fmov	d2, d10
100f57230: 1e604163    	fmov	d3, d11
100f57234: 95b33fc2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57238: aa1303e0    	mov	x0, x19
100f5723c: aa1c03e1    	mov	x1, x28
100f57240: 95b33fbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57244: aa1d03fd    	mov	x29, x29
100f57248: 95b33fc0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f5724c: aa0003f4    	mov	x20, x0
100f57250: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f57254: f9469515    	ldr	x21, [x8, #0xd28] ; replyTextSize
100f57258: aa1503e1    	mov	x1, x21
100f5725c: 95b33fb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57260: 1e602920    	fadd	d0, d9, d0
100f57264: 1e602960    	fadd	d0, d11, d0
100f57268: f87b6a60    	ldr	x0, [x19, x27]
100f5726c: 900f7868    	adrp	x8, 0x11fe63000 <dyld_stub_binder+0x11fe63000>
100f57270: f9444901    	ldr	x1, [x8, #0x890] ; setMaxWidth:
100f57274: 95b33fb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57278: aa1403e0    	mov	x0, x20
100f5727c: 95b33fb6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57280: f87b6a60    	ldr	x0, [x19, x27]
100f57284: d00f77c8    	adrp	x8, 0x11fe51000 <dyld_stub_binder+0x11fe51000>
100f57288: f9474101    	ldr	x1, [x8, #0xe80] ; maxWidth
100f5728c: 95b33fac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57290: 1e604009    	fmov	d9, d0
100f57294: aa1303e0    	mov	x0, x19
100f57298: aa1c03e1    	mov	x1, x28
100f5729c: 95b33fa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f572a0: aa1d03fd    	mov	x29, x29
100f572a4: 95b33fa9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f572a8: aa0003f4    	mov	x20, x0
100f572ac: aa1503e1    	mov	x1, x21
100f572b0: 95b33fa3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f572b4: 1e612900    	fadd	d0, d8, d1
100f572b8: 1e602948    	fadd	d8, d10, d0
100f572bc: aa1403e0    	mov	x0, x20
100f572c0: 95b33fa5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f572c4: aa1303e0    	mov	x0, x19
100f572c8: aa1c03e1    	mov	x1, x28
100f572cc: 95b33f9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f572d0: aa1d03fd    	mov	x29, x29
100f572d4: 95b33f9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f572d8: aa0003f4    	mov	x20, x0
100f572dc: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f572e0: f9469901    	ldr	x1, [x8, #0xd30] ; referPartInfo
100f572e4: 95b33f96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f572e8: aa1d03fd    	mov	x29, x29
100f572ec: 95b33f97    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f572f0: aa0003f5    	mov	x21, x0
100f572f4: f87b6a60    	ldr	x0, [x19, x27]
100f572f8: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f572fc: f9469d01    	ldr	x1, [x8, #0xd38] ; setReplyingPartialInfo:
100f57300: aa1503e2    	mov	x2, x21
100f57304: 95b33f8e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57308: aa1503e0    	mov	x0, x21
100f5730c: 95b33f92    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57310: aa1403e0    	mov	x0, x20
100f57314: 95b33f90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57318: f87b6a74    	ldr	x20, [x19, x27]
100f5731c: aa1303e0    	mov	x0, x19
100f57320: aa1c03e1    	mov	x1, x28
100f57324: 95b33f86    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57328: aa1d03fd    	mov	x29, x29
100f5732c: 95b33f87    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f57330: aa0003f3    	mov	x19, x0
100f57334: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f57338: f946a101    	ldr	x1, [x8, #0xd40] ; replyTextStyles
100f5733c: 95b33f80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57340: aa1d03fd    	mov	x29, x29
100f57344: 95b33f81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f57348: aa0003f5    	mov	x21, x0
100f5734c: b00f7968    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
100f57350: f946a501    	ldr	x1, [x8, #0xd48] ; updateWithSize:arrStyles:
100f57354: aa1403e0    	mov	x0, x20
100f57358: 1e604120    	fmov	d0, d9
100f5735c: 1e604101    	fmov	d1, d8
100f57360: aa1503e2    	mov	x2, x21
100f57364: 95b33f76    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f57368: aa1503e0    	mov	x0, x21
100f5736c: 95b33f7a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57370: aa1303e0    	mov	x0, x19
100f57374: 95b33f78    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57378: aa1803e0    	mov	x0, x24
100f5737c: 95b33f76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57380: aa1703e0    	mov	x0, x23
100f57384: 95b33f74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57388: f9401fe0    	ldr	x0, [sp, #0x38]
100f5738c: a94c7bfd    	ldp	x29, x30, [sp, #0xc0]
100f57390: a94b4ff4    	ldp	x20, x19, [sp, #0xb0]
100f57394: a94a57f6    	ldp	x22, x21, [sp, #0xa0]
100f57398: a9495ff8    	ldp	x24, x23, [sp, #0x90]
100f5739c: a94867fa    	ldp	x26, x25, [sp, #0x80]
100f573a0: a9476ffc    	ldp	x28, x27, [sp, #0x70]
100f573a4: 6d4623e9    	ldp	d9, d8, [sp, #0x60]
100f573a8: 6d452beb    	ldp	d11, d10, [sp, #0x50]
100f573ac: 910343ff    	add	sp, sp, #0xd0
100f573b0: 15b33f69    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f573b4: 900f90e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100f573b8: f946d500    	ldr	x0, [x8, #0xda8]
100f573bc: f00f8d48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100f573c0: f9455d01    	ldr	x1, [x8, #0xab8] ; imageNamed:
100f573c4: b00eaf42    	adrp	x2, 0x11e540000 <dyld_stub_binder+0x11e540000>
100f573c8: 912d2042    	add	x2, x2, #0xb48
100f573cc: 95b33f5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f573d0: aa1d03fd    	mov	x29, x29
100f573d4: 95b33f5d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f573d8: aa0003f4    	mov	x20, x0
100f573dc: f87b6a60    	ldr	x0, [x19, x27]
100f573e0: f00f7928    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
100f573e4: f947bd19    	ldr	x25, [x8, #0xf78] ; thumbImageView
100f573e8: aa1903e1    	mov	x1, x25
100f573ec: 95b33f54    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f573f0: aa1d03fd    	mov	x29, x29
100f573f4: 95b33f55    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100f573f8: aa0003f5    	mov	x21, x0
100f573fc: b00f8d88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
100f57400: f9417901    	ldr	x1, [x8, #0x2f0] ; setImage:
100f57404: aa1403e2    	mov	x2, x20
100f57408: 95b33f4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100f5740c: aa1503e0    	mov	x0, x21
100f57410: 95b33f51    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f57414: aa1403e0    	mov	x0, x20
100f57418: 95b33f4f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100f5741c: f00f8d28    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
100f57420: f9476d14    	ldr	x20, [x8, #0xed8] ; addSubview:
100f57424: 17ffff45    	b	0x100f57138 <__text+0xf4f138>