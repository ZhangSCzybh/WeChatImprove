
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105f8bc0c: d10203ff    	sub	sp, sp, #0x80
105f8bc10: a9026ffc    	stp	x28, x27, [sp, #0x20]
105f8bc14: a90367fa    	stp	x26, x25, [sp, #0x30]
105f8bc18: a9045ff8    	stp	x24, x23, [sp, #0x40]
105f8bc1c: a90557f6    	stp	x22, x21, [sp, #0x50]
105f8bc20: a9064ff4    	stp	x20, x19, [sp, #0x60]
105f8bc24: a9077bfd    	stp	x29, x30, [sp, #0x70]
105f8bc28: 9101c3fd    	add	x29, sp, #0x70
105f8bc2c: aa0203f3    	mov	x19, x2
105f8bc30: aa0003f4    	mov	x20, x0
105f8bc34: 900d65c8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
105f8bc38: 52800029    	mov	w9, #0x1                ; =1
105f8bc3c: 39054909    	strb	w9, [x8, #0x152]
105f8bc40: aa0203e0    	mov	x0, x2
105f8bc44: 94726d3d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105f8bc48: f00d01e8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8bc4c: f940f501    	ldr	x1, [x8, #0x1e8] ; selector=isFromIlink
105f8bc50: aa1303e0    	mov	x0, x19
105f8bc54: 94726d3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bc58: 340005e0    	cbz	w0, 0x105f8bd14 <_Flutter_MMFoundation_BindContext+0x24678f8>
105f8bc5c: 52800040    	mov	w0, #0x2                ; =2
105f8bc60: 94720578    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
105f8bc64: 34001080    	cbz	w0, 0x105f8be74 <_Flutter_MMFoundation_BindContext+0x2467a58>
105f8bc68: 94726d4e    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
105f8bc6c: aa0003f4    	mov	x20, x0
105f8bc70: 900d0f56    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
105f8bc74: f94546c0    	ldr	x0, [x22, #0xa88]
105f8bc78: 94726d3a    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
105f8bc7c: aa0003f5    	mov	x21, x0
105f8bc80: f94546c0    	ldr	x0, [x22, #0xa88]
105f8bc84: f00d0be8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105f8bc88: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
105f8bc8c: f90003ff    	str	xzr, [sp]
105f8bc90: 900c46a2    	adrp	x2, 0x11e85f000 <dyld_stub_binder+0x11e85f000>
105f8bc94: 9125a042    	add	x2, x2, #0x968 ; cfstring='Failed to reject because it is ilink mode.'
105f8bc98: 94726d29    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bc9c: aa1d03fd    	mov	x29, x29
105f8bca0: 94726d2a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8bca4: aa0003f6    	mov	x22, x0
105f8bca8: f00d0ba8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
105f8bcac: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
105f8bcb0: 900c2888    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8bcb4: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
105f8bcb8: a90003e8    	stp	x8, x0, [sp]
105f8bcbc: 900c2882    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
105f8bcc0: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
105f8bcc4: aa1503e0    	mov	x0, x21
105f8bcc8: 94726d1d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bccc: aa0003f5    	mov	x21, x0
105f8bcd0: aa1603e0    	mov	x0, x22
105f8bcd4: 94726d20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8bcd8: d00a9441    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
105f8bcdc: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
105f8bce0: f00acea2    	adrp	x2, 0x11b962000 <dyld_stub_binder+0x11b962000>
105f8bce4: 9135dc42    	add	x2, x2, #0xd77 ; cstring='VOIPMessageMgr.mm'
105f8bce8: b00acec4    	adrp	x4, 0x11b964000 <dyld_stub_binder+0x11b964000>
105f8bcec: 91132084    	add	x4, x4, #0x4c8 ; cstring='-[VOIPMessageMgr voIPInvitationServiceDidRejectWithInfo:]'
105f8bcf0: 52800040    	mov	w0, #0x2                ; =2
105f8bcf4: 5280d503    	mov	w3, #0x6a8              ; =1704
105f8bcf8: aa1503e5    	mov	x5, x21
105f8bcfc: 94720552    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
105f8bd00: aa1503e0    	mov	x0, x21
105f8bd04: 94726d14    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8bd08: aa1403e0    	mov	x0, x20
105f8bd0c: 94726d28    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
105f8bd10: 14000059    	b	0x105f8be74 <_Flutter_MMFoundation_BindContext+0x2467a58>
105f8bd14: 900d0f48    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f8bd18: f9464917    	ldr	x23, [x8, #0xc90] ; class=CAppUtil
105f8bd1c: f00cf568    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105f8bd20: f9406115    	ldr	x21, [x8, #0xc0] ; selector=roomID
105f8bd24: aa1303e0    	mov	x0, x19
105f8bd28: aa1503e1    	mov	x1, x21
105f8bd2c: 94726d04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bd30: aa0003f8    	mov	x24, x0
105f8bd34: f00cf568    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105f8bd38: f9406516    	ldr	x22, [x8, #0xc8] ; selector=roomKey
105f8bd3c: aa1303e0    	mov	x0, x19
105f8bd40: aa1603e1    	mov	x1, x22
105f8bd44: 94726cfe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bd48: aa0003f9    	mov	x25, x0
105f8bd4c: d00cf568    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f8bd50: f946391a    	ldr	x26, [x8, #0xc70] ; selector=contact
105f8bd54: aa1303e0    	mov	x0, x19
105f8bd58: aa1a03e1    	mov	x1, x26
105f8bd5c: 94726cf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bd60: aa1d03fd    	mov	x29, x29
105f8bd64: 94726cf9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8bd68: aa0003fb    	mov	x27, x0
105f8bd6c: f00d01e8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8bd70: f9428901    	ldr	x1, [x8, #0x510] ; selector=voIPRequestAnswerAboutRejectWithDelegate:roomID:roomKey:contact:forceToVoice:
105f8bd74: aa1703e0    	mov	x0, x23
105f8bd78: aa1403e2    	mov	x2, x20
105f8bd7c: aa1803e3    	mov	x3, x24
105f8bd80: aa1903e4    	mov	x4, x25
105f8bd84: aa1b03e5    	mov	x5, x27
105f8bd88: 52800006    	mov	w6, #0x0                ; =0
105f8bd8c: 94726cec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bd90: aa1b03e0    	mov	x0, x27
105f8bd94: 94726cf0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8bd98: f00d0f68    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
105f8bd9c: f941ed17    	ldr	x23, [x8, #0x3d8] ; class=VoIPMessageUtils
105f8bda0: aa1303e0    	mov	x0, x19
105f8bda4: aa1a03e1    	mov	x1, x26
105f8bda8: 94726ce5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bdac: aa1d03fd    	mov	x29, x29
105f8bdb0: 94726ce6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8bdb4: aa0003f4    	mov	x20, x0
105f8bdb8: 900cf588    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105f8bdbc: f9434d01    	ldr	x1, [x8, #0x698] ; selector=m_nsUsrName
105f8bdc0: 94726cdf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bdc4: aa1d03fd    	mov	x29, x29
105f8bdc8: 94726ce0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f8bdcc: aa0003f8    	mov	x24, x0
105f8bdd0: d00cf748    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
105f8bdd4: f9429101    	ldr	x1, [x8, #0x520] ; selector=roomType
105f8bdd8: aa1303e0    	mov	x0, x19
105f8bddc: 94726cd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bde0: f100081f    	cmp	x0, #0x2
105f8bde4: 1a9f17f9    	cset	w25, eq
105f8bde8: aa1303e0    	mov	x0, x19
105f8bdec: aa1503e1    	mov	x1, x21
105f8bdf0: 94726cd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8bdf4: aa0003f5    	mov	x21, x0
105f8bdf8: aa1303e0    	mov	x0, x19
105f8bdfc: aa1603e1    	mov	x1, x22
105f8be00: 94726ccf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8be04: aa0003f6    	mov	x22, x0
105f8be08: f00cf6a8    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
105f8be0c: f9444901    	ldr	x1, [x8, #0x890] ; selector=receiveTime
105f8be10: aa1303e0    	mov	x0, x19
105f8be14: 94726cca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8be18: f00d01e8    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
105f8be1c: f9428d01    	ldr	x1, [x8, #0x518] ; selector=supplementLocalBubbleMessageWrapToUsername:withWordingType:isVideo:roomID:roomKey:inviteID:duration:isCaller:needRedDot:needFixTime:createTime:exceptionType:status:isIlink:
105f8be20: 390073ff    	strb	wzr, [sp, #0x1c]
105f8be24: 52800128    	mov	w8, #0x9                ; =9
105f8be28: b9001be8    	str	w8, [sp, #0x18]
105f8be2c: f9000bff    	str	xzr, [sp, #0x10]
105f8be30: b9000be0    	str	w0, [sp, #0x8]
105f8be34: 52802008    	mov	w8, #0x100              ; =256
105f8be38: 39001bff    	strb	wzr, [sp, #0x6]
105f8be3c: 79000be8    	strh	w8, [sp, #0x4]
105f8be40: b90003ff    	str	wzr, [sp]
105f8be44: aa1703e0    	mov	x0, x23
105f8be48: aa1803e2    	mov	x2, x24
105f8be4c: 52800103    	mov	w3, #0x8                ; =8
105f8be50: aa1903e4    	mov	x4, x25
105f8be54: aa1503e5    	mov	x5, x21
105f8be58: aa1603e6    	mov	x6, x22
105f8be5c: 52800007    	mov	w7, #0x0                ; =0
105f8be60: 94726cb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f8be64: aa1803e0    	mov	x0, x24
105f8be68: 94726cbb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8be6c: aa1403e0    	mov	x0, x20
105f8be70: 94726cb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f8be74: aa1303e0    	mov	x0, x19
105f8be78: a9477bfd    	ldp	x29, x30, [sp, #0x70]
105f8be7c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
105f8be80: a94557f6    	ldp	x22, x21, [sp, #0x50]
105f8be84: a9445ff8    	ldp	x24, x23, [sp, #0x40]
105f8be88: a94367fa    	ldp	x26, x25, [sp, #0x30]
105f8be8c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
105f8be90: 910203ff    	add	sp, sp, #0x80
105f8be94: 14726cb0    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
