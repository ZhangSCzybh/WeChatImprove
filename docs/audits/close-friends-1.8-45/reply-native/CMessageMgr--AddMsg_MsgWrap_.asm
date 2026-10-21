
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b2dc1c: d101c3ff    	sub	sp, sp, #0x70
104b2dc20: a9016ffc    	stp	x28, x27, [sp, #0x10]
104b2dc24: a90267fa    	stp	x26, x25, [sp, #0x20]
104b2dc28: a9035ff8    	stp	x24, x23, [sp, #0x30]
104b2dc2c: a90457f6    	stp	x22, x21, [sp, #0x40]
104b2dc30: a9054ff4    	stp	x20, x19, [sp, #0x50]
104b2dc34: a9067bfd    	stp	x29, x30, [sp, #0x60]
104b2dc38: 910183fd    	add	x29, sp, #0x60
104b2dc3c: aa0303f4    	mov	x20, x3
104b2dc40: aa0203f3    	mov	x19, x2
104b2dc44: aa0003f5    	mov	x21, x0
104b2dc48: b00e0888    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b2dc4c: 52800029    	mov	w9, #0x1                ; =1
104b2dc50: 39154109    	strb	w9, [x8, #0x550]
104b2dc54: aa0203e0    	mov	x0, x2
104b2dc58: 94c3e538    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b2dc5c: aa1403e0    	mov	x0, x20
104b2dc60: 94c3e536    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b2dc64: b40001f4    	cbz	x20, 0x104b2dca0 <_Flutter_MMFoundation_BindContext+0x1009884>
104b2dc68: b00d9908    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
104b2dc6c: f9401501    	ldr	x1, [x8, #0x28] ; isReferMsgType
104b2dc70: aa1403e0    	mov	x0, x20
104b2dc74: 94c3e532    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dc78: 34000380    	cbz	w0, 0x104b2dce8 <_Flutter_MMFoundation_BindContext+0x10098cc>
104b2dc7c: b00d98e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b2dc80: f9465101    	ldr	x1, [x8, #0xca0] ; AddAppMsg:MsgWrap:Data:Scene:
104b2dc84: aa1503e0    	mov	x0, x21
104b2dc88: aa1303e2    	mov	x2, x19
104b2dc8c: aa1403e3    	mov	x3, x20
104b2dc90: d2800004    	mov	x4, #0x0                ; =0
104b2dc94: 52800025    	mov	w5, #0x1                ; =1
104b2dc98: 94c3e529    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dc9c: 14000139    	b	0x104b2e180 <_Flutter_MMFoundation_BindContext+0x1009d64>
104b2dca0: d00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2dca4: f9453500    	ldr	x0, [x8, #0xa68]
104b2dca8: 900d9868    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b2dcac: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b2dcb0: f00ce3a8    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b2dcb4: 911c2108    	add	x8, x8, #0x708
104b2dcb8: f90003e8    	str	x8, [sp]
104b2dcbc: 900b37c3    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b2dcc0: 9107f063    	add	x3, x3, #0x1fc
104b2dcc4: f00b6665    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b2dcc8: 910cb4a5    	add	x5, x5, #0x32d
104b2dccc: f00b6667    	adrp	x7, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b2dcd0: 912e6ce7    	add	x7, x7, #0xb9b
104b2dcd4: 52800082    	mov	w2, #0x4                ; =4
104b2dcd8: 52800004    	mov	w4, #0x0                ; =0
104b2dcdc: 52808426    	mov	w6, #0x421              ; =1057
104b2dce0: 94c3e517    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dce4: 14000127    	b	0x104b2e180 <_Flutter_MMFoundation_BindContext+0x1009d64>
104b2dce8: b00d98e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b2dcec: f941e501    	ldr	x1, [x8, #0x3c8] ; IsImgMsg
104b2dcf0: aa1403e0    	mov	x0, x20
104b2dcf4: 94c3e512    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dcf8: 340000c0    	cbz	w0, 0x104b2dd10 <_Flutter_MMFoundation_BindContext+0x10098f4>
104b2dcfc: d00d9888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b2dd00: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b2dd04: aa1403e0    	mov	x0, x20
104b2dd08: d2800002    	mov	x2, #0x0                ; =0
104b2dd0c: 94c3e50c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd10: b00d98e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b2dd14: f941d501    	ldr	x1, [x8, #0x3a8] ; IsTextMsg
104b2dd18: aa1403e0    	mov	x0, x20
104b2dd1c: 94c3e508    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd20: 34000200    	cbz	w0, 0x104b2dd60 <_Flutter_MMFoundation_BindContext+0x1009944>
104b2dd24: 900d9e68    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
104b2dd28: f945a501    	ldr	x1, [x8, #0xb48] ; m_easterEggIncludedType
104b2dd2c: aa1403e0    	mov	x0, x20
104b2dd30: 94c3e503    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd34: b5000160    	cbnz	x0, 0x104b2dd60 <_Flutter_MMFoundation_BindContext+0x1009944>
104b2dd38: d00d9868    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104b2dd3c: f9450101    	ldr	x1, [x8, #0xa00] ; m_uiStatus
104b2dd40: aa1403e0    	mov	x0, x20
104b2dd44: 94c3e4fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd48: 7100041f    	cmp	w0, #0x1
104b2dd4c: 540000a1    	b.ne	0x104b2dd60 <_Flutter_MMFoundation_BindContext+0x1009944>
104b2dd50: 900d9e68    	adrp	x8, 0x11fef9000 <dyld_stub_binder+0x11fef9000>
104b2dd54: f9479101    	ldr	x1, [x8, #0xf20] ; updateEasterEggRandomSeedIfNeeded
104b2dd58: aa1403e0    	mov	x0, x20
104b2dd5c: 94c3e4f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd60: d00db7a8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b2dd64: b9895508    	ldrsw	x8, [x8, #0x954]
104b2dd68: f8686aa0    	ldr	x0, [x21, x8]
104b2dd6c: d00d98a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b2dd70: f945a501    	ldr	x1, [x8, #0xb48] ; AddMsg:MsgWrap:
104b2dd74: aa1303e2    	mov	x2, x19
104b2dd78: aa1403e3    	mov	x3, x20
104b2dd7c: 94c3e4f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd80: f00d9868    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b2dd84: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b2dd88: aa1403e0    	mov	x0, x20
104b2dd8c: 94c3e4ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dd90: 34001620    	cbz	w0, 0x104b2e054 <_Flutter_MMFoundation_BindContext+0x1009c38>
104b2dd94: d00d98e8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b2dd98: f9406916    	ldr	x22, [x8, #0xd0] ; revokeBatchId
104b2dd9c: aa1403e0    	mov	x0, x20
104b2dda0: aa1603e1    	mov	x1, x22
104b2dda4: 94c3e4e6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dda8: aa1d03fd    	mov	x29, x29
104b2ddac: 94c3e4e7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2ddb0: aa0003f8    	mov	x24, x0
104b2ddb4: d00daea8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b2ddb8: f946e917    	ldr	x23, [x8, #0xdd0] ; length
104b2ddbc: aa1703e1    	mov	x1, x23
104b2ddc0: 94c3e4df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2ddc4: aa0003f9    	mov	x25, x0
104b2ddc8: aa1803e0    	mov	x0, x24
104b2ddcc: 94c3e4e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2ddd0: b4000539    	cbz	x25, 0x104b2de74 <_Flutter_MMFoundation_BindContext+0x1009a58>
104b2ddd4: d00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2ddd8: f945e900    	ldr	x0, [x8, #0xbd0]
104b2dddc: f00dae88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b2dde0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b2dde4: 94c3e4d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dde8: aa1d03fd    	mov	x29, x29
104b2ddec: 94c3e4d7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2ddf0: aa0003f8    	mov	x24, x0
104b2ddf4: b00db248    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b2ddf8: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7
104b2ddfc: d00dae88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b2de00: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b2de04: 94c3e4ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2de08: aa0003e2    	mov	x2, x0
104b2de0c: 900d9868    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b2de10: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b2de14: aa1803e0    	mov	x0, x24
104b2de18: 94c3e4c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2de1c: aa1d03fd    	mov	x29, x29
104b2de20: 94c3e4ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2de24: aa0003f9    	mov	x25, x0
104b2de28: aa1403e0    	mov	x0, x20
104b2de2c: aa1603e1    	mov	x1, x22
104b2de30: 94c3e4c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2de34: aa1d03fd    	mov	x29, x29
104b2de38: 94c3e4c4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2de3c: aa0003f6    	mov	x22, x0
104b2de40: b00da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2de44: f943dd01    	ldr	x1, [x8, #0x7b8] ; addBatchSendForUser:record:identifier:
104b2de48: aa1903e0    	mov	x0, x25
104b2de4c: aa1303e2    	mov	x2, x19
104b2de50: aa1403e3    	mov	x3, x20
104b2de54: aa1603e4    	mov	x4, x22
104b2de58: 94c3e4b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2de5c: aa1603e0    	mov	x0, x22
104b2de60: 94c3e4bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2de64: aa1903e0    	mov	x0, x25
104b2de68: 94c3e4bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2de6c: aa1803e0    	mov	x0, x24
104b2de70: 94c3e4b9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2de74: d00db23a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104b2de78: f9467b40    	ldr	x0, [x26, #0xcf0]
104b2de7c: f00d9868    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b2de80: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
104b2de84: 94c3e4ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2de88: aa0003e2    	mov	x2, x0
104b2de8c: 900d99a8    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b2de90: f943a501    	ldr	x1, [x8, #0x748] ; setM_uiSendTime:
104b2de94: aa1403e0    	mov	x0, x20
104b2de98: 94c3e4a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2de9c: b00d9888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b2dea0: f9413d16    	ldr	x22, [x8, #0x278] ; m_uiMessageType
104b2dea4: aa1403e0    	mov	x0, x20
104b2dea8: aa1603e1    	mov	x1, x22
104b2deac: 94c3e4a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2deb0: 7100881f    	cmp	w0, #0x22
104b2deb4: 540011e1    	b.ne	0x104b2e0f0 <_Flutter_MMFoundation_BindContext+0x1009cd4>
104b2deb8: aa1403e0    	mov	x0, x20
104b2debc: aa1603e1    	mov	x1, x22
104b2dec0: 94c3e49f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dec4: 7100041f    	cmp	w0, #0x1
104b2dec8: 54000421    	b.ne	0x104b2df4c <_Flutter_MMFoundation_BindContext+0x1009b30>
104b2decc: f00db239    	adrp	x25, 0x120174000 <dyld_stub_binder+0x120174000>
104b2ded0: f9418b20    	ldr	x0, [x25, #0x310]
104b2ded4: b00da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2ded8: f943f901    	ldr	x1, [x8, #0x7f0] ; needParserAddress
104b2dedc: 94c3e498    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dee0: 34000360    	cbz	w0, 0x104b2df4c <_Flutter_MMFoundation_BindContext+0x1009b30>
104b2dee4: b00d9888    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b2dee8: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
104b2deec: aa1403e0    	mov	x0, x20
104b2def0: 94c3e493    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2def4: aa1d03fd    	mov	x29, x29
104b2def8: 94c3e494    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2defc: aa0003f8    	mov	x24, x0
104b2df00: f9418b39    	ldr	x25, [x25, #0x310]
104b2df04: aa1703e1    	mov	x1, x23
104b2df08: 94c3e48d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2df0c: aa0003e4    	mov	x4, x0
104b2df10: 900d9888    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b2df14: f940b901    	ldr	x1, [x8, #0x170] ; RangeOfObjectInString:withRange:
104b2df18: aa1903e0    	mov	x0, x25
104b2df1c: aa1803e2    	mov	x2, x24
104b2df20: d2800003    	mov	x3, #0x0                ; =0
104b2df24: 94c3e486    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2df28: b40000e1    	cbz	x1, 0x104b2df44 <_Flutter_MMFoundation_BindContext+0x1009b28>
104b2df2c: b00ccc81    	adrp	x1, 0x11e4be000 <dyld_stub_binder+0x11e4be000>
104b2df30: 91342021    	add	x1, x1, #0xd08
104b2df34: 52864120    	mov	w0, #0x3209             ; =12809
104b2df38: 52800002    	mov	w2, #0x0                ; =0
104b2df3c: 52800003    	mov	w3, #0x0                ; =0
104b2df40: 975cfb68    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
104b2df44: aa1803e0    	mov	x0, x24
104b2df48: 94c3e483    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2df4c: d00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2df50: f9455500    	ldr	x0, [x8, #0xaa8]
104b2df54: d00dae88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b2df58: f941bd01    	ldr	x1, [x8, #0x378] ; arrayWithObject:
104b2df5c: aa1403e2    	mov	x2, x20
104b2df60: 94c3e477    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2df64: aa1d03fd    	mov	x29, x29
104b2df68: 94c3e478    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2df6c: aa0003f7    	mov	x23, x0
104b2df70: b00da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2df74: f943fd01    	ldr	x1, [x8, #0x7f8] ; HandleMsgList:MsgList:
104b2df78: aa1503e0    	mov	x0, x21
104b2df7c: aa1303e2    	mov	x2, x19
104b2df80: aa1703e3    	mov	x3, x23
104b2df84: 94c3e46e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2df88: aa1703e0    	mov	x0, x23
104b2df8c: 94c3e472    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2df90: b00da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2df94: f9440101    	ldr	x1, [x8, #0x800] ; AsyncOnPreAddMsg:MsgWrap:
104b2df98: aa1503e0    	mov	x0, x21
104b2df9c: aa1303e2    	mov	x2, x19
104b2dfa0: aa1403e3    	mov	x3, x20
104b2dfa4: 94c3e466    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dfa8: b00da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2dfac: f9440501    	ldr	x1, [x8, #0x808] ; AsyncOnAddMsg:MsgWrap:
104b2dfb0: aa1503e0    	mov	x0, x21
104b2dfb4: aa1303e2    	mov	x2, x19
104b2dfb8: aa1403e3    	mov	x3, x20
104b2dfbc: 94c3e460    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dfc0: d00d9988    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
104b2dfc4: f944ed01    	ldr	x1, [x8, #0x9d8] ; AsyncOnAddMsgForSession:MsgWrap:
104b2dfc8: aa1503e0    	mov	x0, x21
104b2dfcc: aa1303e2    	mov	x2, x19
104b2dfd0: aa1403e3    	mov	x3, x20
104b2dfd4: 94c3e45a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dfd8: 900db248    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104b2dfdc: f940d500    	ldr	x0, [x8, #0x1a8]
104b2dfe0: b00d98a8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104b2dfe4: f9434501    	ldr	x1, [x8, #0x688] ; getPluginUserNameType:
104b2dfe8: aa1303e2    	mov	x2, x19
104b2dfec: 94c3e454    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2dff0: f100141f    	cmp	x0, #0x5
104b2dff4: 54000c61    	b.ne	0x104b2e180 <_Flutter_MMFoundation_BindContext+0x1009d64>
104b2dff8: aa1403e0    	mov	x0, x20
104b2dffc: aa1603e1    	mov	x1, x22
104b2e000: 94c3e44f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e004: 7100881f    	cmp	w0, #0x22
104b2e008: 54000bc0    	b.eq	0x104b2e180 <_Flutter_MMFoundation_BindContext+0x1009d64>
104b2e00c: f9467b40    	ldr	x0, [x26, #0xcf0]
104b2e010: b00d98a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b2e014: f9465901    	ldr	x1, [x8, #0xcb0] ; CheckSyncMediaNote:
104b2e018: aa1303e2    	mov	x2, x19
104b2e01c: 94c3e448    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e020: 37000b00    	tbnz	w0, #0x0, 0x104b2e180 <_Flutter_MMFoundation_BindContext+0x1009d64>
104b2e024: d00d9868    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b2e028: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
104b2e02c: aa1403e0    	mov	x0, x20
104b2e030: 52800042    	mov	w2, #0x2                ; =2
104b2e034: 94c3e442    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e038: 900d98e8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b2e03c: f9464901    	ldr	x1, [x8, #0xc90] ; ModMsg:MsgWrap:
104b2e040: aa1503e0    	mov	x0, x21
104b2e044: aa1303e2    	mov	x2, x19
104b2e048: aa1403e3    	mov	x3, x20
104b2e04c: 94c3e43c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e050: 1400004c    	b	0x104b2e180 <_Flutter_MMFoundation_BindContext+0x1009d64>
104b2e054: b00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2e058: f9453515    	ldr	x21, [x8, #0xa68]
104b2e05c: b00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2e060: f9454516    	ldr	x22, [x8, #0xa88]
104b2e064: b00d9888    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b2e068: f940d901    	ldr	x1, [x8, #0x1b0] ; m_nsToUsr
104b2e06c: aa1403e0    	mov	x0, x20
104b2e070: 94c3e433    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e074: aa1d03fd    	mov	x29, x29
104b2e078: 94c3e434    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e07c: aa0003f7    	mov	x23, x0
104b2e080: d00d9868    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b2e084: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b2e088: aa1603e0    	mov	x0, x22
104b2e08c: aa1703e2    	mov	x2, x23
104b2e090: 94c3e42b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e094: aa1d03fd    	mov	x29, x29
104b2e098: 94c3e42c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e09c: aa0003f6    	mov	x22, x0
104b2e0a0: f00d9848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b2e0a4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b2e0a8: d00cd288    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b2e0ac: 9109a108    	add	x8, x8, #0x268
104b2e0b0: a90003e8    	stp	x8, x0, [sp]
104b2e0b4: f00b37a3    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b2e0b8: 9107f063    	add	x3, x3, #0x1fc
104b2e0bc: d00b6665    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b2e0c0: 910cb4a5    	add	x5, x5, #0x32d
104b2e0c4: d00b6667    	adrp	x7, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b2e0c8: 912e6ce7    	add	x7, x7, #0xb9b
104b2e0cc: aa1503e0    	mov	x0, x21
104b2e0d0: 52800082    	mov	w2, #0x4                ; =4
104b2e0d4: 52800004    	mov	w4, #0x0                ; =0
104b2e0d8: 52808726    	mov	w6, #0x439              ; =1081
104b2e0dc: 94c3e418    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e0e0: aa1603e0    	mov	x0, x22
104b2e0e4: 94c3e41c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e0e8: aa1703e0    	mov	x0, x23
104b2e0ec: 14000024    	b	0x104b2e17c <_Flutter_MMFoundation_BindContext+0x1009d60>
104b2e0f0: d00d9ba8    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b2e0f4: f9422501    	ldr	x1, [x8, #0x448] ; m_uiImgStatus
104b2e0f8: aa1403e0    	mov	x0, x20
104b2e0fc: 94c3e410    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e100: 7100081f    	cmp	w0, #0x2
104b2e104: 54000541    	b.ne	0x104b2e1ac <_Flutter_MMFoundation_BindContext+0x1009d90>
104b2e108: d00db228    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b2e10c: f9411d00    	ldr	x0, [x8, #0x238]
104b2e110: d00d9ba8    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b2e114: f9423d01    	ldr	x1, [x8, #0x478] ; clearLocalImage:
104b2e118: aa1403e2    	mov	x2, x20
104b2e11c: 94c3e408    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e120: b00d98e8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b2e124: f9418901    	ldr	x1, [x8, #0x310] ; m_asset
104b2e128: aa1403e0    	mov	x0, x20
104b2e12c: 94c3e404    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e130: aa1d03fd    	mov	x29, x29
104b2e134: 94c3e405    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e138: aa0003f8    	mov	x24, x0
104b2e13c: 94c3e406    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e140: b4000e58    	cbz	x24, 0x104b2e308 <_Flutter_MMFoundation_BindContext+0x1009eec>
104b2e144: 900da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2e148: f943e101    	ldr	x1, [x8, #0x7c0] ; assetThreshold
104b2e14c: aa1503e0    	mov	x0, x21
104b2e150: 94c3e3fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e154: aa1d03fd    	mov	x29, x29
104b2e158: 94c3e3fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e15c: aa0003f6    	mov	x22, x0
104b2e160: 900da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2e164: f943e501    	ldr	x1, [x8, #0x7c8] ; genImageFromMMAssetAndNotify:threshold:
104b2e168: aa1403e0    	mov	x0, x20
104b2e16c: aa1503e2    	mov	x2, x21
104b2e170: aa1603e3    	mov	x3, x22
104b2e174: 94c3e3f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e178: aa1603e0    	mov	x0, x22
104b2e17c: 94c3e3f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e180: aa1403e0    	mov	x0, x20
104b2e184: 94c3e3f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e188: aa1303e0    	mov	x0, x19
104b2e18c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104b2e190: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104b2e194: a94457f6    	ldp	x22, x21, [sp, #0x40]
104b2e198: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104b2e19c: a94267fa    	ldp	x26, x25, [sp, #0x20]
104b2e1a0: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104b2e1a4: 9101c3ff    	add	sp, sp, #0x70
104b2e1a8: 14c3e3eb    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e1ac: f00d9988    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b2e1b0: f9452d01    	ldr	x1, [x8, #0xa58] ; IsBypassMessage
104b2e1b4: aa1403e0    	mov	x0, x20
104b2e1b8: 94c3e3e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e1bc: 34000120    	cbz	w0, 0x104b2e1e0 <_Flutter_MMFoundation_BindContext+0x1009dc4>
104b2e1c0: b00db7a8    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b2e1c4: b9895908    	ldrsw	x8, [x8, #0x958]
104b2e1c8: f8686aa0    	ldr	x0, [x21, x8]
104b2e1cc: 900da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2e1d0: f943ed01    	ldr	x1, [x8, #0x7d8] ; StartSendMsg:
104b2e1d4: aa1403e2    	mov	x2, x20
104b2e1d8: 94c3e3d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e1dc: 17ffff37    	b	0x104b2deb8 <_Flutter_MMFoundation_BindContext+0x1009a9c>
104b2e1e0: f00db228    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104b2e1e4: f940d500    	ldr	x0, [x8, #0x1a8]
104b2e1e8: 900d98a8    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104b2e1ec: f9434501    	ldr	x1, [x8, #0x688] ; getPluginUserNameType:
104b2e1f0: aa1303e2    	mov	x2, x19
104b2e1f4: 94c3e3d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e1f8: f100141f    	cmp	x0, #0x5
104b2e1fc: 540000e1    	b.ne	0x104b2e218 <_Flutter_MMFoundation_BindContext+0x1009dfc>
104b2e200: f9467b40    	ldr	x0, [x26, #0xcf0]
104b2e204: b00d98a8    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b2e208: f9465901    	ldr	x1, [x8, #0xcb0] ; CheckSyncMediaNote:
104b2e20c: aa1303e2    	mov	x2, x19
104b2e210: 94c3e3cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e214: 34ffe520    	cbz	w0, 0x104b2deb8 <_Flutter_MMFoundation_BindContext+0x1009a9c>
104b2e218: b00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2e21c: f945e900    	ldr	x0, [x8, #0xbd0]
104b2e220: d00dae88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b2e224: f944e918    	ldr	x24, [x8, #0x9d0] ; currentContext
104b2e228: aa1803e1    	mov	x1, x24
104b2e22c: 94c3e3c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e230: aa1d03fd    	mov	x29, x29
104b2e234: 94c3e3c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e238: aa0003f9    	mov	x25, x0
104b2e23c: 900db328    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104b2e240: f945dd00    	ldr	x0, [x8, #0xbb8]
104b2e244: b00dae88    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b2e248: f947ad1a    	ldr	x26, [x8, #0xf58] ; class
104b2e24c: aa1a03e1    	mov	x1, x26
104b2e250: 94c3e3bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e254: aa0003e2    	mov	x2, x0
104b2e258: f00d9848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b2e25c: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
104b2e260: aa1903e0    	mov	x0, x25
104b2e264: aa1b03e1    	mov	x1, x27
104b2e268: 94c3e3b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e26c: aa1d03fd    	mov	x29, x29
104b2e270: 94c3e3b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e274: aa0003fc    	mov	x28, x0
104b2e278: 900da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2e27c: f943f101    	ldr	x1, [x8, #0x7e0] ; AddMsgToSendTable:MsgWrap:
104b2e280: aa1303e2    	mov	x2, x19
104b2e284: aa1403e3    	mov	x3, x20
104b2e288: 94c3e3ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e28c: aa1c03e0    	mov	x0, x28
104b2e290: 94c3e3b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e294: aa1903e0    	mov	x0, x25
104b2e298: 94c3e3af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e29c: b00db228    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b2e2a0: f945e900    	ldr	x0, [x8, #0xbd0]
104b2e2a4: aa1803e1    	mov	x1, x24
104b2e2a8: 94c3e3a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e2ac: aa1d03fd    	mov	x29, x29
104b2e2b0: 94c3e3a6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e2b4: aa0003f8    	mov	x24, x0
104b2e2b8: 900db328    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104b2e2bc: f945dd00    	ldr	x0, [x8, #0xbb8]
104b2e2c0: aa1a03e1    	mov	x1, x26
104b2e2c4: b00db23a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104b2e2c8: 94c3e39d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e2cc: aa0003e2    	mov	x2, x0
104b2e2d0: aa1803e0    	mov	x0, x24
104b2e2d4: aa1b03e1    	mov	x1, x27
104b2e2d8: 94c3e399    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e2dc: aa1d03fd    	mov	x29, x29
104b2e2e0: 94c3e39a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b2e2e4: aa0003f9    	mov	x25, x0
104b2e2e8: 900da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2e2ec: f943f501    	ldr	x1, [x8, #0x7e8] ; SendMsg
104b2e2f0: 94c3e393    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e2f4: aa1903e0    	mov	x0, x25
104b2e2f8: 94c3e397    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e2fc: aa1803e0    	mov	x0, x24
104b2e300: 94c3e395    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b2e304: 17fffeed    	b	0x104b2deb8 <_Flutter_MMFoundation_BindContext+0x1009a9c>
104b2e308: 900da2c8    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b2e30c: f943e901    	ldr	x1, [x8, #0x7d0] ; StartUploadImageMsg:MsgWrap:
104b2e310: aa1503e0    	mov	x0, x21
104b2e314: aa1303e2    	mov	x2, x19
104b2e318: aa1403e3    	mov	x3, x20
104b2e31c: 94c3e388    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b2e320: 17fffee6    	b	0x104b2deb8 <_Flutter_MMFoundation_BindContext+0x1009a9c>
