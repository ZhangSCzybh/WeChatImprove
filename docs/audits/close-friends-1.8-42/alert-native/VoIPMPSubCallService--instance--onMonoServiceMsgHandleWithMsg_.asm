
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10616e9a0: d101c3ff    	sub	sp, sp, #0x70
10616e9a4: a9035ff8    	stp	x24, x23, [sp, #0x30]
10616e9a8: a90457f6    	stp	x22, x21, [sp, #0x40]
10616e9ac: a9054ff4    	stp	x20, x19, [sp, #0x50]
10616e9b0: a9067bfd    	stp	x29, x30, [sp, #0x60]
10616e9b4: 910183fd    	add	x29, sp, #0x60
10616e9b8: aa0203f3    	mov	x19, x2
10616e9bc: aa0003f4    	mov	x20, x0
10616e9c0: b00d56a8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10616e9c4: 52800029    	mov	w9, #0x1                ; =1
10616e9c8: 391be509    	strb	w9, [x8, #0x6f9]
10616e9cc: aa0203e0    	mov	x0, x2
10616e9d0: 946ae1da    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10616e9d4: 52800040    	mov	w0, #0x2                ; =2
10616e9d8: 946a7a1a    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616e9dc: 34000560    	cbz	w0, 0x10616ea88 <_Flutter_MMFoundation_BindContext+0x264a66c>
10616e9e0: 946ae1f0    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616e9e4: aa0003f5    	mov	x21, x0
10616e9e8: b00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616e9ec: f94546e0    	ldr	x0, [x23, #0xa88]
10616e9f0: 946ae1dc    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616e9f4: aa0003f6    	mov	x22, x0
10616e9f8: f94546e0    	ldr	x0, [x23, #0xa88]
10616e9fc: 900cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616ea00: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616ea04: a9007ff3    	stp	x19, xzr, [sp]
10616ea08: d00c3822    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616ea0c: 910e2042    	add	x2, x2, #0x388 ; cfstring='Prepare to handle subcall ... (%@)'
10616ea10: 946ae1cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ea14: aa1d03fd    	mov	x29, x29
10616ea18: 946ae1cc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ea1c: aa0003f7    	mov	x23, x0
10616ea20: 900cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616ea24: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616ea28: b00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ea2c: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616ea30: a90003e8    	stp	x8, x0, [sp]
10616ea34: b00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ea38: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616ea3c: aa1603e0    	mov	x0, x22
10616ea40: 946ae1bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ea44: aa0003f6    	mov	x22, x0
10616ea48: aa1703e0    	mov	x0, x23
10616ea4c: 946ae1c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ea50: b00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616ea54: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616ea58: b00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616ea5c: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616ea60: d00ac124    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616ea64: 9112bc84    	add	x4, x4, #0x4af ; cstring='-[VoIPMPSubCallService onMonoServiceMsgHandleWithMsg:]'
10616ea68: 52800040    	mov	w0, #0x2                ; =2
10616ea6c: 528060e3    	mov	w3, #0x307              ; =775
10616ea70: aa1603e5    	mov	x5, x22
10616ea74: 946a79f4    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616ea78: aa1603e0    	mov	x0, x22
10616ea7c: 946ae1b6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ea80: aa1503e0    	mov	x0, x21
10616ea84: 946ae1ca    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616ea88: b00d0028    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616ea8c: f9468d00    	ldr	x0, [x8, #0xd18] ; class=DeviceInfo
10616ea90: b00cfca8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10616ea94: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector=isiPad
10616ea98: 946ae1a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ea9c: 34000600    	cbz	w0, 0x10616eb5c <_Flutter_MMFoundation_BindContext+0x264a740>
10616eaa0: 52800040    	mov	w0, #0x2                ; =2
10616eaa4: 946a79e7    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616eaa8: 34000560    	cbz	w0, 0x10616eb54 <_Flutter_MMFoundation_BindContext+0x264a738>
10616eaac: 946ae1bd    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616eab0: aa0003f4    	mov	x20, x0
10616eab4: b00d0036    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10616eab8: f94546c0    	ldr	x0, [x22, #0xa88]
10616eabc: 946ae1a9    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616eac0: aa0003f5    	mov	x21, x0
10616eac4: f94546c0    	ldr	x0, [x22, #0xa88]
10616eac8: 900cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616eacc: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616ead0: f90003ff    	str	xzr, [sp]
10616ead4: d00c3822    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616ead8: 910ea042    	add	x2, x2, #0x3a8 ; cfstring='Just support iPhone!'
10616eadc: 946ae198    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616eae0: aa1d03fd    	mov	x29, x29
10616eae4: 946ae199    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616eae8: aa0003f6    	mov	x22, x0
10616eaec: 900cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616eaf0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616eaf4: b00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616eaf8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616eafc: a90003e8    	stp	x8, x0, [sp]
10616eb00: b00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616eb04: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616eb08: aa1503e0    	mov	x0, x21
10616eb0c: 946ae18c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616eb10: aa0003f5    	mov	x21, x0
10616eb14: aa1603e0    	mov	x0, x22
10616eb18: 946ae18f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616eb1c: b00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616eb20: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616eb24: b00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616eb28: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616eb2c: d00ac124    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616eb30: 9112bc84    	add	x4, x4, #0x4af ; cstring='-[VoIPMPSubCallService onMonoServiceMsgHandleWithMsg:]'
10616eb34: 52800040    	mov	w0, #0x2                ; =2
10616eb38: 52806163    	mov	w3, #0x30b              ; =779
10616eb3c: aa1503e5    	mov	x5, x21
10616eb40: 946a79c1    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616eb44: aa1503e0    	mov	x0, x21
10616eb48: 946ae183    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616eb4c: aa1403e0    	mov	x0, x20
10616eb50: 946ae197    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616eb54: 52800017    	mov	w23, #0x0               ; =0
10616eb58: 140000b3    	b	0x10616ee24 <_Flutter_MMFoundation_BindContext+0x264aa08>
10616eb5c: f00cf308    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10616eb60: f940ed01    	ldr	x1, [x8, #0x1d8] ; selector=fetchAndFillCurrentRoomInfoWithRoomIdPtr:RoomKeyPtr:ScenePtr:
10616eb64: 9100a3e2    	add	x2, sp, #0x28
10616eb68: 910083e3    	add	x3, sp, #0x20
10616eb6c: 910063e4    	add	x4, sp, #0x18
10616eb70: aa1403e0    	mov	x0, x20
10616eb74: 946ae172    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616eb78: f9400fe3    	ldr	x3, [sp, #0x18]
10616eb7c: f00cf308    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10616eb80: f940e501    	ldr	x1, [x8, #0x1c8] ; selector=genVoIPInvitationInfoWithMsg:Scene:NeedReport:
10616eb84: aa1403e0    	mov	x0, x20
10616eb88: aa1303e2    	mov	x2, x19
10616eb8c: 52800024    	mov	w4, #0x1                ; =1
10616eb90: 946ae16b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616eb94: aa1d03fd    	mov	x29, x29
10616eb98: 946ae16c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616eb9c: aa0003f4    	mov	x20, x0
10616eba0: b4000de0    	cbz	x0, 0x10616ed5c <_Flutter_MMFoundation_BindContext+0x264a940>
10616eba4: b00d0137    	adrp	x23, 0x120193000 <dyld_stub_binder+0x120193000>
10616eba8: f9471ae0    	ldr	x0, [x23, #0xe30] ; class=VoIPInvitationService
10616ebac: f00cf128    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
10616ebb0: f941a916    	ldr	x22, [x8, #0x350] ; selector=defaultService
10616ebb4: aa1603e1    	mov	x1, x22
10616ebb8: 946ae161    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ebbc: aa1d03fd    	mov	x29, x29
10616ebc0: 946ae162    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ebc4: b40007c0    	cbz	x0, 0x10616ecbc <_Flutter_MMFoundation_BindContext+0x264a8a0>
10616ebc8: aa0003f5    	mov	x21, x0
10616ebcc: f9471ae0    	ldr	x0, [x23, #0xe30] ; class=VoIPInvitationService
10616ebd0: aa1603e1    	mov	x1, x22
10616ebd4: 946ae15a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ebd8: aa1d03fd    	mov	x29, x29
10616ebdc: 946ae15b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ebe0: aa0003f6    	mov	x22, x0
10616ebe4: a9420fe4    	ldp	x4, x3, [sp, #0x20]
10616ebe8: b00cf308    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10616ebec: f945cd01    	ldr	x1, [x8, #0xb98] ; selector=handleInvitationInfo:withTalkingRoomID:talkingRoomKey:
10616ebf0: aa1403e2    	mov	x2, x20
10616ebf4: 946ae152    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ebf8: aa0003f7    	mov	x23, x0
10616ebfc: aa1603e0    	mov	x0, x22
10616ec00: 946ae155    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ec04: aa1503e0    	mov	x0, x21
10616ec08: 946ae153    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ec0c: 36000597    	tbz	w23, #0x0, 0x10616ecbc <_Flutter_MMFoundation_BindContext+0x264a8a0>
10616ec10: 52800040    	mov	w0, #0x2                ; =2
10616ec14: 946a798b    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616ec18: 34001180    	cbz	w0, 0x10616ee48 <_Flutter_MMFoundation_BindContext+0x264aa2c>
10616ec1c: 946ae161    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616ec20: aa0003f5    	mov	x21, x0
10616ec24: b00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616ec28: f94546e0    	ldr	x0, [x23, #0xa88]
10616ec2c: 946ae14d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616ec30: aa0003f6    	mov	x22, x0
10616ec34: f94546e0    	ldr	x0, [x23, #0xa88]
10616ec38: 900cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616ec3c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616ec40: f90003ff    	str	xzr, [sp]
10616ec44: f00c3222    	adrp	x2, 0x11e7b5000 <dyld_stub_binder+0x11e7b5000>
10616ec48: 911f2042    	add	x2, x2, #0x7c8 ; cfstring='Service handle invitation!'
10616ec4c: 946ae13c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ec50: aa1d03fd    	mov	x29, x29
10616ec54: 946ae13d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ec58: aa0003f7    	mov	x23, x0
10616ec5c: 900cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616ec60: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616ec64: b00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ec68: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616ec6c: a90003e8    	stp	x8, x0, [sp]
10616ec70: b00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ec74: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616ec78: aa1603e0    	mov	x0, x22
10616ec7c: 946ae130    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ec80: aa0003f6    	mov	x22, x0
10616ec84: aa1703e0    	mov	x0, x23
10616ec88: 946ae133    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ec8c: b00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616ec90: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616ec94: b00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616ec98: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616ec9c: d00ac124    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616eca0: 9112bc84    	add	x4, x4, #0x4af ; cstring='-[VoIPMPSubCallService onMonoServiceMsgHandleWithMsg:]'
10616eca4: 52800040    	mov	w0, #0x2                ; =2
10616eca8: 52806463    	mov	w3, #0x323              ; =803
10616ecac: aa1603e5    	mov	x5, x22
10616ecb0: 946a7965    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616ecb4: 52800037    	mov	w23, #0x1               ; =1
10616ecb8: 14000053    	b	0x10616ee04 <_Flutter_MMFoundation_BindContext+0x264a9e8>
10616ecbc: 52800080    	mov	w0, #0x4                ; =4
10616ecc0: 946a7960    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616ecc4: 34000aa0    	cbz	w0, 0x10616ee18 <_Flutter_MMFoundation_BindContext+0x264a9fc>
10616ecc8: 946ae136    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616eccc: aa0003f5    	mov	x21, x0
10616ecd0: b00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616ecd4: f94546e0    	ldr	x0, [x23, #0xa88]
10616ecd8: 946ae122    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616ecdc: aa0003f6    	mov	x22, x0
10616ece0: f94546e0    	ldr	x0, [x23, #0xa88]
10616ece4: 900cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616ece8: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616ecec: f90003ff    	str	xzr, [sp]
10616ecf0: d00c3822    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616ecf4: 910f2042    	add	x2, x2, #0x3c8 ; cfstring='Failed to handle invited mono msg!'
10616ecf8: 946ae111    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ecfc: aa1d03fd    	mov	x29, x29
10616ed00: 946ae112    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ed04: aa0003f7    	mov	x23, x0
10616ed08: 900cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616ed0c: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616ed10: b00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ed14: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616ed18: a90003e8    	stp	x8, x0, [sp]
10616ed1c: b00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616ed20: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616ed24: aa1603e0    	mov	x0, x22
10616ed28: 946ae105    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ed2c: aa0003f6    	mov	x22, x0
10616ed30: aa1703e0    	mov	x0, x23
10616ed34: 946ae108    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ed38: b00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616ed3c: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616ed40: b00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616ed44: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616ed48: d00ac124    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616ed4c: 9112bc84    	add	x4, x4, #0x4af ; cstring='-[VoIPMPSubCallService onMonoServiceMsgHandleWithMsg:]'
10616ed50: 52800080    	mov	w0, #0x4                ; =4
10616ed54: 528063e3    	mov	w3, #0x31f              ; =799
10616ed58: 14000028    	b	0x10616edf8 <_Flutter_MMFoundation_BindContext+0x264a9dc>
10616ed5c: 52800080    	mov	w0, #0x4                ; =4
10616ed60: 946a7938    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616ed64: 340005a0    	cbz	w0, 0x10616ee18 <_Flutter_MMFoundation_BindContext+0x264a9fc>
10616ed68: 946ae10e    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616ed6c: aa0003f5    	mov	x21, x0
10616ed70: b00d0037    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10616ed74: f94546e0    	ldr	x0, [x23, #0xa88]
10616ed78: 946ae0fa    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616ed7c: aa0003f6    	mov	x22, x0
10616ed80: f94546e0    	ldr	x0, [x23, #0xa88]
10616ed84: 900cfce8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616ed88: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616ed8c: f90003ff    	str	xzr, [sp]
10616ed90: d00c3822    	adrp	x2, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616ed94: 91072042    	add	x2, x2, #0x1c8 ; cfstring='It is multitalkmonomsg'
10616ed98: 946ae0e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ed9c: aa1d03fd    	mov	x29, x29
10616eda0: 946ae0ea    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616eda4: aa0003f7    	mov	x23, x0
10616eda8: 900cfca8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616edac: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616edb0: b00c1968    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616edb4: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616edb8: a90003e8    	stp	x8, x0, [sp]
10616edbc: b00c1962    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616edc0: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616edc4: aa1603e0    	mov	x0, x22
10616edc8: 946ae0dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616edcc: aa0003f6    	mov	x22, x0
10616edd0: aa1703e0    	mov	x0, x23
10616edd4: 946ae0e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616edd8: b00ac0e1    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616eddc: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616ede0: b00ac122    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616ede4: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616ede8: d00ac124    	adrp	x4, 0x11b994000 <dyld_stub_binder+0x11b994000>
10616edec: 9112bc84    	add	x4, x4, #0x4af ; cstring='-[VoIPMPSubCallService onMonoServiceMsgHandleWithMsg:]'
10616edf0: 52800080    	mov	w0, #0x4                ; =4
10616edf4: 528062e3    	mov	w3, #0x317              ; =791
10616edf8: aa1603e5    	mov	x5, x22
10616edfc: 946a7912    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616ee00: 52800017    	mov	w23, #0x0               ; =0
10616ee04: aa1603e0    	mov	x0, x22
10616ee08: 946ae0d3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ee0c: aa1503e0    	mov	x0, x21
10616ee10: 946ae0e7    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616ee14: 14000002    	b	0x10616ee1c <_Flutter_MMFoundation_BindContext+0x264aa00>
10616ee18: 52800017    	mov	w23, #0x0               ; =0
10616ee1c: aa1403e0    	mov	x0, x20
10616ee20: 946ae0cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ee24: aa1303e0    	mov	x0, x19
10616ee28: 946ae0cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ee2c: aa1703e0    	mov	x0, x23
10616ee30: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10616ee34: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10616ee38: a94457f6    	ldp	x22, x21, [sp, #0x40]
10616ee3c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10616ee40: 9101c3ff    	add	sp, sp, #0x70
10616ee44: d65f03c0    	ret
10616ee48: 52800037    	mov	w23, #0x1               ; =1
10616ee4c: 17fffff4    	b	0x10616ee1c <_Flutter_MMFoundation_BindContext+0x264aa00>
