
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ffd92c: 6db92beb    	stp	d11, d10, [sp, #-0x70]!
108ffd930: 6d0123e9    	stp	d9, d8, [sp, #0x10]
108ffd934: a90267fa    	stp	x26, x25, [sp, #0x20]
108ffd938: a9035ff8    	stp	x24, x23, [sp, #0x30]
108ffd93c: a90457f6    	stp	x22, x21, [sp, #0x40]
108ffd940: a9054ff4    	stp	x20, x19, [sp, #0x50]
108ffd944: a9067bfd    	stp	x29, x30, [sp, #0x60]
108ffd948: 910183fd    	add	x29, sp, #0x60
108ffd94c: 900be288    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108ffd950: 52800029    	mov	w9, #0x1                ; =1
108ffd954: 393a2509    	strb	w9, [x8, #0xe89]
108ffd958: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd95c: b9859d08    	ldrsw	x8, [x8, #0x59c]
108ffd960: 38686808    	ldrb	w8, [x0, x8]
108ffd964: 7100051f    	cmp	w8, #0x1
108ffd968: 54000ee1    	b.ne	0x108ffdb44 <_Flutter_MMFoundation_BindContext+0x54d9728>
108ffd96c: aa0203f4    	mov	x20, x2
108ffd970: aa0003f3    	mov	x19, x0
108ffd974: b00b8048    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
108ffd978: f9412515    	ldr	x21, [x8, #0x248] ; isJumpState
108ffd97c: aa1503e1    	mov	x1, x21
108ffd980: 95a176b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd984: 6b14001f    	cmp	w0, w20
108ffd988: 54000de0    	b.eq	0x108ffdb44 <_Flutter_MMFoundation_BindContext+0x54d9728>
108ffd98c: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd990: b9859108    	ldrsw	x8, [x8, #0x590]
108ffd994: f8686a60    	ldr	x0, [x19, x8]
108ffd998: f00b72e8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
108ffd99c: f9472d01    	ldr	x1, [x8, #0xe58] ; resetStatus:
108ffd9a0: d2800002    	mov	x2, #0x0                ; =0
108ffd9a4: 95a176a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd9a8: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd9ac: f9410d01    	ldr	x1, [x8, #0x218] ; setIsJumpState:
108ffd9b0: aa1303e0    	mov	x0, x19
108ffd9b4: aa1403e2    	mov	x2, x20
108ffd9b8: 95a176a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd9bc: aa1303e0    	mov	x0, x19
108ffd9c0: aa1503e1    	mov	x1, x21
108ffd9c4: 95a176a0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd9c8: 34000ce0    	cbz	w0, 0x108ffdb64 <_Flutter_MMFoundation_BindContext+0x54d9748>
108ffd9cc: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffd9d0: f940e501    	ldr	x1, [x8, #0x1c8] ; listHeaderViewInJumpState
108ffd9d4: aa1303e0    	mov	x0, x19
108ffd9d8: 95a1769b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffd9dc: aa1d03fd    	mov	x29, x29
108ffd9e0: 95a1769c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffd9e4: aa0003f4    	mov	x20, x0
108ffd9e8: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffd9ec: b9857d17    	ldrsw	x23, [x8, #0x57c]
108ffd9f0: f8776a60    	ldr	x0, [x19, x23]
108ffd9f4: f00b71e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108ffd9f8: f940d901    	ldr	x1, [x8, #0x1b0] ; setTableHeaderView:
108ffd9fc: aa1403e2    	mov	x2, x20
108ffda00: 95a17691    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda04: aa1403e0    	mov	x0, x20
108ffda08: 95a17695    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffda0c: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffda10: f940c114    	ldr	x20, [x8, #0x180] ; yearFlowView
108ffda14: aa1303e0    	mov	x0, x19
108ffda18: aa1403e1    	mov	x1, x20
108ffda1c: 95a1768a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda20: aa1d03fd    	mov	x29, x29
108ffda24: 95a1768b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffda28: aa0003f5    	mov	x21, x0
108ffda2c: b00b8828    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
108ffda30: f9449d16    	ldr	x22, [x8, #0x938] ; height
108ffda34: aa1603e1    	mov	x1, x22
108ffda38: 95a17683    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda3c: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffda40: b9859908    	ldrsw	x8, [x8, #0x598]
108ffda44: fc686a61    	ldr	d1, [x19, x8]
108ffda48: 1e612800    	fadd	d0, d0, d1
108ffda4c: f8776a60    	ldr	x0, [x19, x23]
108ffda50: b00b7ce8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
108ffda54: f944e901    	ldr	x1, [x8, #0x9d0] ; setTopInsetUnderContentViewY:
108ffda58: 95a1767b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda5c: aa1503e0    	mov	x0, x21
108ffda60: 95a1767f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffda64: d00b8bb5    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
108ffda68: f94702a0    	ldr	x0, [x21, #0xe00]
108ffda6c: f00b7228    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
108ffda70: f940f101    	ldr	x1, [x8, #0x1e0] ; navigationBarHeightCurOri
108ffda74: 95a17674    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda78: 1e604008    	fmov	d8, d0
108ffda7c: f94702a0    	ldr	x0, [x21, #0xe00]
108ffda80: d00b71e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ffda84: f9479101    	ldr	x1, [x8, #0xf20] ; normalStatusBarHeight
108ffda88: 95a1766f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda8c: 1e602908    	fadd	d8, d8, d0
108ffda90: aa1303e0    	mov	x0, x19
108ffda94: aa1403e1    	mov	x1, x20
108ffda98: 95a1766b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffda9c: aa1d03fd    	mov	x29, x29
108ffdaa0: 95a1766c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdaa4: aa0003f4    	mov	x20, x0
108ffdaa8: aa1603e1    	mov	x1, x22
108ffdaac: 95a17666    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdab0: 1e602908    	fadd	d8, d8, d0
108ffdab4: aa1403e0    	mov	x0, x20
108ffdab8: 95a17669    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffdabc: f8776a60    	ldr	x0, [x19, x23]
108ffdac0: d00b71e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ffdac4: f945b914    	ldr	x20, [x8, #0xb70] ; contentInset
108ffdac8: aa1403e1    	mov	x1, x20
108ffdacc: 95a1765e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdad0: 1e604029    	fmov	d9, d1
108ffdad4: f8776a60    	ldr	x0, [x19, x23]
108ffdad8: aa1403e1    	mov	x1, x20
108ffdadc: 95a1765a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdae0: 1e60404a    	fmov	d10, d2
108ffdae4: f8776a60    	ldr	x0, [x19, x23]
108ffdae8: aa1403e1    	mov	x1, x20
108ffdaec: 95a17656    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdaf0: f8776a60    	ldr	x0, [x19, x23]
108ffdaf4: d00b8848    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
108ffdaf8: f9439501    	ldr	x1, [x8, #0x728] ; setContentInset:
108ffdafc: 1e604100    	fmov	d0, d8
108ffdb00: 1e604121    	fmov	d1, d9
108ffdb04: 1e604142    	fmov	d2, d10
108ffdb08: 95a1764f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdb0c: d00b8ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108ffdb10: f9462d00    	ldr	x0, [x8, #0xc58]
108ffdb14: f00b71e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108ffdb18: f940a101    	ldr	x1, [x8, #0x140] ; cellBackgroundColor
108ffdb1c: 95a1764a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdb20: aa1d03fd    	mov	x29, x29
108ffdb24: 95a1764b    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdb28: aa0003f4    	mov	x20, x0
108ffdb2c: f8776a60    	ldr	x0, [x19, x23]
108ffdb30: d00b8848    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
108ffdb34: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
108ffdb38: aa1403e2    	mov	x2, x20
108ffdb3c: 95a17642    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdb40: 1400007e    	b	0x108ffdd38 <_Flutter_MMFoundation_BindContext+0x54d991c>
108ffdb44: a9467bfd    	ldp	x29, x30, [sp, #0x60]
108ffdb48: a9454ff4    	ldp	x20, x19, [sp, #0x50]
108ffdb4c: a94457f6    	ldp	x22, x21, [sp, #0x40]
108ffdb50: a9435ff8    	ldp	x24, x23, [sp, #0x30]
108ffdb54: a94267fa    	ldp	x26, x25, [sp, #0x20]
108ffdb58: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
108ffdb5c: 6cc72beb    	ldp	d11, d10, [sp], #0x70
108ffdb60: d65f03c0    	ret
108ffdb64: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffdb68: f940d501    	ldr	x1, [x8, #0x1a8] ; useExpandableHeader
108ffdb6c: aa1303e0    	mov	x0, x19
108ffdb70: 95a17635    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdb74: d00b8348    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ffdb78: 9106c108    	add	x8, x8, #0x1b0
108ffdb7c: d00b8349    	adrp	x9, 0x120067000 <dyld_stub_binder+0x120067000>
108ffdb80: 91076129    	add	x9, x9, #0x1d8
108ffdb84: 7100001f    	cmp	w0, #0x0
108ffdb88: 9a891108    	csel	x8, x8, x9, ne
108ffdb8c: f9400101    	ldr	x1, [x8]
108ffdb90: aa1303e0    	mov	x0, x19
108ffdb94: 95a1762c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdb98: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffdb9c: b9859908    	ldrsw	x8, [x8, #0x598]
108ffdba0: fc686a60    	ldr	d0, [x19, x8]
108ffdba4: f00b9328    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
108ffdba8: b9857d19    	ldrsw	x25, [x8, #0x57c]
108ffdbac: f8796a60    	ldr	x0, [x19, x25]
108ffdbb0: b00b7ce8    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
108ffdbb4: f944e901    	ldr	x1, [x8, #0x9d0] ; setTopInsetUnderContentViewY:
108ffdbb8: 95a17623    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdbbc: d00b8bb4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
108ffdbc0: f9470280    	ldr	x0, [x20, #0xe00]
108ffdbc4: f00b7228    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
108ffdbc8: f940f101    	ldr	x1, [x8, #0x1e0] ; navigationBarHeightCurOri
108ffdbcc: 95a1761e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdbd0: 1e604008    	fmov	d8, d0
108ffdbd4: f9470280    	ldr	x0, [x20, #0xe00]
108ffdbd8: d00b71e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ffdbdc: f9479101    	ldr	x1, [x8, #0xf20] ; normalStatusBarHeight
108ffdbe0: 95a17619    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdbe4: 1e602908    	fadd	d8, d8, d0
108ffdbe8: f8796a60    	ldr	x0, [x19, x25]
108ffdbec: d00b71e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
108ffdbf0: f945b914    	ldr	x20, [x8, #0xb70] ; contentInset
108ffdbf4: aa1403e1    	mov	x1, x20
108ffdbf8: 95a17613    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdbfc: 1e604029    	fmov	d9, d1
108ffdc00: f8796a60    	ldr	x0, [x19, x25]
108ffdc04: aa1403e1    	mov	x1, x20
108ffdc08: 95a1760f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc0c: 1e60404a    	fmov	d10, d2
108ffdc10: f8796a60    	ldr	x0, [x19, x25]
108ffdc14: aa1403e1    	mov	x1, x20
108ffdc18: 95a1760b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc1c: f8796a60    	ldr	x0, [x19, x25]
108ffdc20: d00b8848    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
108ffdc24: f9439501    	ldr	x1, [x8, #0x728] ; setContentInset:
108ffdc28: 1e604100    	fmov	d0, d8
108ffdc2c: 1e604121    	fmov	d1, d9
108ffdc30: 1e604142    	fmov	d2, d10
108ffdc34: 95a17604    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc38: d00b8ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108ffdc3c: f945e900    	ldr	x0, [x8, #0xbd0]
108ffdc40: f00b8808    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
108ffdc44: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
108ffdc48: 95a175ff    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc4c: aa1d03fd    	mov	x29, x29
108ffdc50: 95a17600    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdc54: aa0003f4    	mov	x20, x0
108ffdc58: f00b8ba8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
108ffdc5c: f9404100    	ldr	x0, [x8, #0x80]
108ffdc60: d00b8808    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108ffdc64: f947ad01    	ldr	x1, [x8, #0xf58] ; class
108ffdc68: 95a175f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc6c: aa0003e2    	mov	x2, x0
108ffdc70: 900b71e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
108ffdc74: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
108ffdc78: aa1403e0    	mov	x0, x20
108ffdc7c: 95a175f2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc80: aa1d03fd    	mov	x29, x29
108ffdc84: 95a175f3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdc88: aa0003f5    	mov	x21, x0
108ffdc8c: f00b71e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108ffdc90: f9400501    	ldr	x1, [x8, #0x8] ; colorList
108ffdc94: 95a175ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdc98: aa1d03fd    	mov	x29, x29
108ffdc9c: 95a175ed    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdca0: aa0003f6    	mov	x22, x0
108ffdca4: f00b71e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
108ffdca8: f9400901    	ldr	x1, [x8, #0x10] ; getColorByName:
108ffdcac: d00aa7c2    	adrp	x2, 0x11e4f7000 <dyld_stub_binder+0x11e4f7000>
108ffdcb0: 912a2042    	add	x2, x2, #0xa88
108ffdcb4: 95a175e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdcb8: aa1d03fd    	mov	x29, x29
108ffdcbc: 95a175e5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdcc0: aa0003f7    	mov	x23, x0
108ffdcc4: 95a175df    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffdcc8: b40000a0    	cbz	x0, 0x108ffdcdc <_Flutter_MMFoundation_BindContext+0x54d98c0>
108ffdccc: aa1703e0    	mov	x0, x23
108ffdcd0: 95a175dc    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ffdcd4: aa1703f8    	mov	x24, x23
108ffdcd8: 14000009    	b	0x108ffdcfc <_Flutter_MMFoundation_BindContext+0x54d98e0>
108ffdcdc: d00b8ba8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
108ffdce0: f9463100    	ldr	x0, [x8, #0xc60]
108ffdce4: d00b8808    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108ffdce8: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
108ffdcec: 95a175d6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdcf0: aa1d03fd    	mov	x29, x29
108ffdcf4: 95a175d7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108ffdcf8: aa0003f8    	mov	x24, x0
108ffdcfc: aa1703e0    	mov	x0, x23
108ffdd00: 95a175d7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffdd04: f8796a60    	ldr	x0, [x19, x25]
108ffdd08: d00b8848    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
108ffdd0c: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
108ffdd10: aa1803e2    	mov	x2, x24
108ffdd14: 95a175cc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ffdd18: aa1803e0    	mov	x0, x24
108ffdd1c: 95a175d0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffdd20: aa1703e0    	mov	x0, x23
108ffdd24: 95a175ce    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffdd28: aa1603e0    	mov	x0, x22
108ffdd2c: 95a175cc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffdd30: aa1503e0    	mov	x0, x21
108ffdd34: 95a175ca    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ffdd38: aa1403e0    	mov	x0, x20
108ffdd3c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
108ffdd40: a9454ff4    	ldp	x20, x19, [sp, #0x50]
108ffdd44: a94457f6    	ldp	x22, x21, [sp, #0x40]
108ffdd48: a9435ff8    	ldp	x24, x23, [sp, #0x30]
108ffdd4c: a94267fa    	ldp	x26, x25, [sp, #0x20]
108ffdd50: 6d4123e9    	ldp	d9, d8, [sp, #0x10]
108ffdd54: 6cc72beb    	ldp	d11, d10, [sp], #0x70
108ffdd58: 15a175c1    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
