
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105113a28: 6db92beb    	stp	d11, d10, [sp, #-0x70]!
105113a2c: 6d0123e9    	stp	d9, d8, [sp, #0x10]
105113a30: a90267fa    	stp	x26, x25, [sp, #0x20]
105113a34: a9035ff8    	stp	x24, x23, [sp, #0x30]
105113a38: a90457f6    	stp	x22, x21, [sp, #0x40]
105113a3c: a9054ff4    	stp	x20, x19, [sp, #0x50]
105113a40: a9067bfd    	stp	x29, x30, [sp, #0x60]
105113a44: 910183fd    	add	x29, sp, #0x60
105113a48: aa0003f3    	mov	x19, x0
105113a4c: 900dd968    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105113a50: 5280003a    	mov	w26, #0x1               ; =1
105113a54: 392d6d1a    	strb	w26, [x8, #0xb5b]
105113a58: 900d7fc8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105113a5c: f946d514    	ldr	x20, [x8, #0xda8] ; view
105113a60: aa1403e1    	mov	x1, x20
105113a64: 94ac4db6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113a68: aa1d03fd    	mov	x29, x29
105113a6c: 94ac4db7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113a70: aa0003f5    	mov	x21, x0
105113a74: 900d7fc8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105113a78: f947a501    	ldr	x1, [x8, #0xf48] ; width
105113a7c: 94ac4db0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113a80: 1e604008    	fmov	d8, d0
105113a84: aa1303e0    	mov	x0, x19
105113a88: aa1403e1    	mov	x1, x20
105113a8c: 94ac4dac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113a90: aa1d03fd    	mov	x29, x29
105113a94: 94ac4dad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113a98: aa0003f6    	mov	x22, x0
105113a9c: f00d7f68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105113aa0: f9449d01    	ldr	x1, [x8, #0x938] ; height
105113aa4: 94ac4da6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113aa8: 1e604009    	fmov	d9, d0
105113aac: aa1603e0    	mov	x0, x22
105113ab0: 94ac4da9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113ab4: aa1503e0    	mov	x0, x21
105113ab8: 94ac4da7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113abc: 900d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105113ac0: f9461916    	ldr	x22, [x8, #0xc30]
105113ac4: b00d8308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105113ac8: f9403d17    	ldr	x23, [x8, #0x78] ; MMThemeUtil
105113acc: 900d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105113ad0: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
105113ad4: b00d7f68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105113ad8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105113adc: 94ac4d98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113ae0: aa1d03fd    	mov	x29, x29
105113ae4: 94ac4d99    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113ae8: aa0003f5    	mov	x21, x0
105113aec: b00d8308    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105113af0: f9404100    	ldr	x0, [x8, #0x80] ; MMThemeManager
105113af4: 900d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105113af8: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105113afc: 94ac4d90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113b00: aa0003e2    	mov	x2, x0
105113b04: d00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105113b08: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105113b0c: aa1503e0    	mov	x0, x21
105113b10: 94ac4d8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113b14: aa1d03fd    	mov	x29, x29
105113b18: 94ac4d8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113b1c: aa0003f8    	mov	x24, x0
105113b20: 900d6948    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105113b24: f947fd01    	ldr	x1, [x8, #0xff8] ; getValueOfProperty:inRuleSet:
105113b28: 900c9e22    	adrp	x2, 0x11e4d7000 <dyld_stub_binder+0x11e4d7000>
105113b2c: 9120a042    	add	x2, x2, #0x828 ; CFString 'cell_height'
105113b30: d00c9d23    	adrp	x3, 0x11e4b9000 <dyld_stub_binder+0x11e4b9000>
105113b34: 9137a063    	add	x3, x3, #0xde8 ; CFString '#mainframe_table'
105113b38: 94ac4d81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113b3c: aa1d03fd    	mov	x29, x29
105113b40: 94ac4d82    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113b44: aa0003f9    	mov	x25, x0
105113b48: b00d6948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105113b4c: f9400101    	ldr	x1, [x8]
105113b50: aa1703e0    	mov	x0, x23
105113b54: aa1903e2    	mov	x2, x25
105113b58: 94ac4d79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113b5c: d00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105113b60: f9463101    	ldr	x1, [x8, #0xc60] ; dynamicLength:
105113b64: aa1603e0    	mov	x0, x22
105113b68: 94ac4d75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113b6c: b00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105113b70: b9833908    	ldrsw	x8, [x8, #0x338]
105113b74: fc286a60    	str	d0, [x19, x8]
105113b78: aa1903e0    	mov	x0, x25
105113b7c: 94ac4d76    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113b80: aa1803e0    	mov	x0, x24
105113b84: 94ac4d74    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113b88: aa1503e0    	mov	x0, x21
105113b8c: 94ac4d72    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113b90: b00d8408    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
105113b94: f9432500    	ldr	x0, [x8, #0x648] ; MainFrameTableView
105113b98: 94ac4d72    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105113b9c: f00d7f68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105113ba0: f947f101    	ldr	x1, [x8, #0xfe0] ; initWithFrame:style:
105113ba4: 9e6703e0    	fmov	d0, xzr
105113ba8: 9e6703e1    	fmov	d1, xzr
105113bac: 1e604102    	fmov	d2, d8
105113bb0: 1e604123    	fmov	d3, d9
105113bb4: d2800002    	mov	x2, #0x0                ; =0
105113bb8: 94ac4d61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113bbc: b00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105113bc0: b9831917    	ldrsw	x23, [x8, #0x318]
105113bc4: f8776a68    	ldr	x8, [x19, x23]
105113bc8: f8376a60    	str	x0, [x19, x23]
105113bcc: aa0803e0    	mov	x0, x8
105113bd0: 94ac4d61    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113bd4: f8776a60    	ldr	x0, [x19, x23]
105113bd8: 900d6bc8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
105113bdc: f9437101    	ldr	x1, [x8, #0x6e0] ; setM_mainTableDelegate:
105113be0: aa1303e2    	mov	x2, x19
105113be4: 94ac4d56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113be8: f8776a60    	ldr	x0, [x19, x23]
105113bec: d00d6928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105113bf0: f946d101    	ldr	x1, [x8, #0xda0] ; setM_delegate:
105113bf4: aa1303e2    	mov	x2, x19
105113bf8: 94ac4d51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113bfc: f8776a60    	ldr	x0, [x19, x23]
105113c00: 900d7fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105113c04: f9451501    	ldr	x1, [x8, #0xa28] ; setDelegate:
105113c08: aa1303e2    	mov	x2, x19
105113c0c: 94ac4d4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113c10: f8776a60    	ldr	x0, [x19, x23]
105113c14: 900d7fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105113c18: f944cd01    	ldr	x1, [x8, #0x998] ; setDataSource:
105113c1c: aa1303e2    	mov	x2, x19
105113c20: 94ac4d47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113c24: f8776a60    	ldr	x0, [x19, x23]
105113c28: 900d7fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105113c2c: f9406501    	ldr	x1, [x8, #0xc8] ; setAutoresizingMask:
105113c30: 52800242    	mov	w2, #0x12               ; =18
105113c34: 94ac4d42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113c38: f8776a60    	ldr	x0, [x19, x23]
105113c3c: d00d7fa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105113c40: f9441501    	ldr	x1, [x8, #0x828] ; setScrollEnabled:
105113c44: 52800022    	mov	w2, #0x1                ; =1
105113c48: 94ac4d3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113c4c: f8776a60    	ldr	x0, [x19, x23]
105113c50: d00d7fa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
105113c54: f9449101    	ldr	x1, [x8, #0x920] ; setSeparatorStyle:
105113c58: 52800022    	mov	w2, #0x1                ; =1
105113c5c: 94ac4d38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113c60: 9e6703e0    	fmov	d0, xzr
105113c64: 9e6703e1    	fmov	d1, xzr
105113c68: 1e604102    	fmov	d2, d8
105113c6c: 1e604123    	fmov	d3, d9
105113c70: 94ac4d6c    	bl	0x107c27220 <_Flutter_MMFoundation_BindContext+0x4102e04>
105113c74: 1e60400a    	fmov	d10, d0
105113c78: 9e6703e0    	fmov	d0, xzr
105113c7c: 9e6703e1    	fmov	d1, xzr
105113c80: 1e604102    	fmov	d2, d8
105113c84: 1e604123    	fmov	d3, d9
105113c88: 94ac4d57    	bl	0x107c271e4 <_Flutter_MMFoundation_BindContext+0x4102dc8>
105113c8c: 1e602140    	fcmp	d10, d0
105113c90: 1e6a4c01    	fcsel	d1, d0, d10, mi
105113c94: f8776a60    	ldr	x0, [x19, x23]
105113c98: f00d6a08    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105113c9c: f9431901    	ldr	x1, [x8, #0x630] ; setSeparatorInset:
105113ca0: 9e6703e0    	fmov	d0, xzr
105113ca4: 9e6703e2    	fmov	d2, xzr
105113ca8: 9e6703e3    	fmov	d3, xzr
105113cac: 94ac4d24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113cb0: 900d8318    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
105113cb4: f9462f00    	ldr	x0, [x24, #0xc58] ; WCColor
105113cb8: b00d6948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105113cbc: f940a501    	ldr	x1, [x8, #0x148] ; seperatorColor
105113cc0: 94ac4d1f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113cc4: aa1d03fd    	mov	x29, x29
105113cc8: 94ac4d20    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113ccc: aa0003f5    	mov	x21, x0
105113cd0: f8776a60    	ldr	x0, [x19, x23]
105113cd4: f00d6a08    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105113cd8: f9475901    	ldr	x1, [x8, #0xeb0] ; setSeparatorColor:
105113cdc: aa1503e2    	mov	x2, x21
105113ce0: 94ac4d17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113ce4: aa1503e0    	mov	x0, x21
105113ce8: 94ac4d1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113cec: 900d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105113cf0: f9463100    	ldr	x0, [x8, #0xc60]
105113cf4: 900d7f68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105113cf8: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
105113cfc: 94ac4d10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d00: aa1d03fd    	mov	x29, x29
105113d04: 94ac4d11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113d08: aa0003f6    	mov	x22, x0
105113d0c: f8776a60    	ldr	x0, [x19, x23]
105113d10: 900d7fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105113d14: f940e115    	ldr	x21, [x8, #0x1c0] ; setBackgroundColor:
105113d18: aa1503e1    	mov	x1, x21
105113d1c: aa1603e2    	mov	x2, x22
105113d20: 94ac4d07    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d24: aa1603e0    	mov	x0, x22
105113d28: 94ac4d0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113d2c: b00d6948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105113d30: f9416501    	ldr	x1, [x8, #0x2c8] ; getContentViewY
105113d34: aa1303e0    	mov	x0, x19
105113d38: 94ac4d01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d3c: 1e604008    	fmov	d8, d0
105113d40: f00d72a8    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
105113d44: f947fd01    	ldr	x1, [x8, #0xff8] ; getMainTableBottomInset
105113d48: aa1303e0    	mov	x0, x19
105113d4c: 94ac4cfc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d50: 1e604002    	fmov	d2, d0
105113d54: f8776a60    	ldr	x0, [x19, x23]
105113d58: 900d7fa8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105113d5c: f9439501    	ldr	x1, [x8, #0x728] ; setContentInset:
105113d60: 9e6703e1    	fmov	d1, xzr
105113d64: 9e6703e3    	fmov	d3, xzr
105113d68: 1e604100    	fmov	d0, d8
105113d6c: 94ac4cf4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d70: f8776a60    	ldr	x0, [x19, x23]
105113d74: d00d69a8    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
105113d78: f9433101    	ldr	x1, [x8, #0x660] ; setPrefetchingEnabled:
105113d7c: 52800002    	mov	w2, #0x0                ; =0
105113d80: 94ac4cef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d84: aa1303e0    	mov	x0, x19
105113d88: aa1403e1    	mov	x1, x20
105113d8c: 94ac4cec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113d90: aa1d03fd    	mov	x29, x29
105113d94: 94ac4ced    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113d98: aa0003f6    	mov	x22, x0
105113d9c: f8776a62    	ldr	x2, [x19, x23]
105113da0: f00d7f48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105113da4: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
105113da8: 94ac4ce5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113dac: aa1603e0    	mov	x0, x22
105113db0: 94ac4ce9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113db4: f8776a60    	ldr	x0, [x19, x23]
105113db8: f00d7f88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
105113dbc: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
105113dc0: 94ac4cdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113dc4: 900d8308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105113dc8: f9474d00    	ldr	x0, [x8, #0xe98]
105113dcc: 94ac4ce5    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105113dd0: aa0003f6    	mov	x22, x0
105113dd4: aa1303e0    	mov	x0, x19
105113dd8: aa1403e1    	mov	x1, x20
105113ddc: 94ac4cd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113de0: aa1d03fd    	mov	x29, x29
105113de4: 94ac4cd9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113de8: aa0003f4    	mov	x20, x0
105113dec: d00d7f68    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
105113df0: f945a101    	ldr	x1, [x8, #0xb40] ; frame
105113df4: 94ac4cd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113df8: f00d7f68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105113dfc: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
105113e00: aa1603e0    	mov	x0, x22
105113e04: 94ac4cce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113e08: aa0003f6    	mov	x22, x0
105113e0c: aa1403e0    	mov	x0, x20
105113e10: 94ac4cd1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113e14: f9462f00    	ldr	x0, [x24, #0xc58] ; WCColor
105113e18: b00d6948    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105113e1c: f943d501    	ldr	x1, [x8, #0x7a8] ; BG_2
105113e20: 94ac4cc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113e24: aa1d03fd    	mov	x29, x29
105113e28: 94ac4cc8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105113e2c: aa0003f4    	mov	x20, x0
105113e30: aa1603e0    	mov	x0, x22
105113e34: aa1503e1    	mov	x1, x21
105113e38: aa1403e2    	mov	x2, x20
105113e3c: 94ac4cc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113e40: aa1403e0    	mov	x0, x20
105113e44: 94ac4cc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105113e48: f8776a60    	ldr	x0, [x19, x23]
105113e4c: 900d6ac8    	adrp	x8, 0x11fe6b000 <dyld_stub_binder+0x11fe6b000>
105113e50: f9457d01    	ldr	x1, [x8, #0xaf8] ; setBackgroundView:
105113e54: aa1603e2    	mov	x2, x22
105113e58: 94ac4cb9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113e5c: b00d88a8    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105113e60: b9832d08    	ldrsw	x8, [x8, #0x32c]
105113e64: 38286a7a    	strb	w26, [x19, x8]
105113e68: f00d7428    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105113e6c: f9461101    	ldr	x1, [x8, #0xc20] ; notifyTaskBarOnMainTableViewInitReady
105113e70: aa1303e0    	mov	x0, x19
105113e74: 94ac4cb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105113e78: aa1603e0    	mov	x0, x22
105113e7c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105113e80: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105113e84: a94457f6    	ldp	x22, x21, [sp, #0x40]
105113e88: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105113e8c: a94267fa    	ldp	x26, x25, [sp, #0x20]
105113e90: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
105113e94: 6cc72beb    	ldp	d11, d10, [sp], #0x70
105113e98: 14ac4caf    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
