
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10616a730: d101c3ff    	sub	sp, sp, #0x70
10616a734: a9016ffc    	stp	x28, x27, [sp, #0x10]
10616a738: a90267fa    	stp	x26, x25, [sp, #0x20]
10616a73c: a9035ff8    	stp	x24, x23, [sp, #0x30]
10616a740: a90457f6    	stp	x22, x21, [sp, #0x40]
10616a744: a9054ff4    	stp	x20, x19, [sp, #0x50]
10616a748: a9067bfd    	stp	x29, x30, [sp, #0x60]
10616a74c: 910183fd    	add	x29, sp, #0x60
10616a750: aa0003f3    	mov	x19, x0
10616a754: b00d56c8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
10616a758: 52800029    	mov	w9, #0x1                ; =1
10616a75c: 391bbd09    	strb	w9, [x8, #0x6ef]
10616a760: 52800040    	mov	w0, #0x2                ; =2
10616a764: 946a8ab7    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a768: 360006e0    	tbz	w0, #0x0, 0x10616a844 <_Flutter_MMFoundation_BindContext+0x2646428>
10616a76c: 946af28d    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a770: aa0003f5    	mov	x21, x0
10616a774: b00d0054    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10616a778: f9454680    	ldr	x0, [x20, #0xa88]
10616a77c: 946af279    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a780: aa0003f6    	mov	x22, x0
10616a784: f9454697    	ldr	x23, [x20, #0xa88]
10616a788: f00ce688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10616a78c: f9474d14    	ldr	x20, [x8, #0xe98] ; selector=cache
10616a790: aa1303e0    	mov	x0, x19
10616a794: aa1403e1    	mov	x1, x20
10616a798: 946af269    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a79c: aa1d03fd    	mov	x29, x29
10616a7a0: 946af26a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a7a4: aa0003f8    	mov	x24, x0
10616a7a8: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a7ac: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a7b0: a9007fe0    	stp	x0, xzr, [sp]
10616a7b4: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a7b8: 913ea042    	add	x2, x2, #0xfa8 ; cfstring='Prepare to reject call ...(%@)'
10616a7bc: aa1703e0    	mov	x0, x23
10616a7c0: 946af25f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a7c4: aa1d03fd    	mov	x29, x29
10616a7c8: 946af260    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a7cc: aa0003f7    	mov	x23, x0
10616a7d0: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a7d4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a7d8: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a7dc: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616a7e0: a90003e8    	stp	x8, x0, [sp]
10616a7e4: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a7e8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a7ec: aa1603e0    	mov	x0, x22
10616a7f0: 946af253    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a7f4: aa0003f6    	mov	x22, x0
10616a7f8: aa1703e0    	mov	x0, x23
10616a7fc: 946af256    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a800: aa1803e0    	mov	x0, x24
10616a804: 946af254    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a808: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a80c: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a810: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a814: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a818: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a81c: 913cc884    	add	x4, x4, #0xf32 ; cstring='-[VoIPMPSubCallService reject]'
10616a820: 52800040    	mov	w0, #0x2                ; =2
10616a824: 52803243    	mov	w3, #0x192              ; =402
10616a828: aa1603e5    	mov	x5, x22
10616a82c: 946a8a86    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a830: aa1603e0    	mov	x0, x22
10616a834: 946af248    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a838: aa1503e0    	mov	x0, x21
10616a83c: 946af25c    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a840: 14000003    	b	0x10616a84c <_Flutter_MMFoundation_BindContext+0x2646430>
10616a844: f00ce688    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
10616a848: f9474d14    	ldr	x20, [x8, #0xe98] ; selector=cache
10616a84c: aa1303e0    	mov	x0, x19
10616a850: aa1403e1    	mov	x1, x20
10616a854: 946af23a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a858: aa1d03fd    	mov	x29, x29
10616a85c: 946af23b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a860: aa0003f5    	mov	x21, x0
10616a864: 946af23c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a868: b4000555    	cbz	x21, 0x10616a910 <_Flutter_MMFoundation_BindContext+0x26464f4>
10616a86c: b00d005c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10616a870: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10616a874: d00cfca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10616a878: f944e917    	ldr	x23, [x8, #0x9d0] ; selector=currentContext
10616a87c: aa1703e1    	mov	x1, x23
10616a880: 946af22f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a884: aa1d03fd    	mov	x29, x29
10616a888: 946af230    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a88c: aa0003f8    	mov	x24, x0
10616a890: b00d009b    	adrp	x27, 0x12017b000 <dyld_stub_binder+0x12017b000>
10616a894: f945cb60    	ldr	x0, [x27, #0xb90] ; class=VoIPConfSDKService
10616a898: b00cfca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10616a89c: f947ad16    	ldr	x22, [x8, #0xf58] ; selector=class
10616a8a0: aa1603e1    	mov	x1, x22
10616a8a4: 946af226    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a8a8: aa0003e2    	mov	x2, x0
10616a8ac: f00ce668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10616a8b0: f9464115    	ldr	x21, [x8, #0xc80] ; selector=getService:
10616a8b4: aa1803e0    	mov	x0, x24
10616a8b8: aa1503e1    	mov	x1, x21
10616a8bc: 946af220    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a8c0: aa1d03fd    	mov	x29, x29
10616a8c4: 946af221    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a8c8: aa0003f9    	mov	x25, x0
10616a8cc: d00ce768    	adrp	x8, 0x11fe58000 <dyld_stub_binder+0x11fe58000>
10616a8d0: f9474101    	ldr	x1, [x8, #0xe80] ; selector=currentStatus
10616a8d4: 946af21a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a8d8: aa0003fa    	mov	x26, x0
10616a8dc: aa1903e0    	mov	x0, x25
10616a8e0: 946af21d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a8e4: aa1803e0    	mov	x0, x24
10616a8e8: 946af21b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a8ec: f100075f    	cmp	x26, #0x1
10616a8f0: 54000781    	b.ne	0x10616a9e0 <_Flutter_MMFoundation_BindContext+0x26465c4>
10616a8f4: 52800040    	mov	w0, #0x2                ; =2
10616a8f8: 946a8a52    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a8fc: 360010c0    	tbz	w0, #0x0, 0x10616ab14 <_Flutter_MMFoundation_BindContext+0x26466f8>
10616a900: 52803378    	mov	w24, #0x19b             ; =411
10616a904: b00c3859    	adrp	x25, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a908: 913fa339    	add	x25, x25, #0xfe8 ; cfstring='VoIP Main call is actived!'
10616a90c: 14000055    	b	0x10616aa60 <_Flutter_MMFoundation_BindContext+0x2646644>
10616a910: 52800040    	mov	w0, #0x2                ; =2
10616a914: 946a8a4b    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a918: 34001020    	cbz	w0, 0x10616ab1c <_Flutter_MMFoundation_BindContext+0x2646700>
10616a91c: 946af221    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a920: aa0003f3    	mov	x19, x0
10616a924: b00d0055    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10616a928: f94546a0    	ldr	x0, [x21, #0xa88]
10616a92c: 946af20d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a930: aa0003f4    	mov	x20, x0
10616a934: f94546a0    	ldr	x0, [x21, #0xa88]
10616a938: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a93c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a940: f90003ff    	str	xzr, [sp]
10616a944: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a948: 913f2042    	add	x2, x2, #0xfc8 ; cfstring='It have no sub call!'
10616a94c: 946af1fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a950: aa1d03fd    	mov	x29, x29
10616a954: 946af1fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a958: aa0003f5    	mov	x21, x0
10616a95c: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a960: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a964: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a968: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616a96c: a90003e8    	stp	x8, x0, [sp]
10616a970: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a974: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a978: aa1403e0    	mov	x0, x20
10616a97c: 946af1f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a980: aa0003f4    	mov	x20, x0
10616a984: aa1503e0    	mov	x0, x21
10616a988: 946af1f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a98c: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a990: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a994: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a998: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a99c: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a9a0: 913cc884    	add	x4, x4, #0xf32 ; cstring='-[VoIPMPSubCallService reject]'
10616a9a4: 52800040    	mov	w0, #0x2                ; =2
10616a9a8: 528032a3    	mov	w3, #0x195              ; =405
10616a9ac: aa1403e5    	mov	x5, x20
10616a9b0: 946a8a25    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a9b4: aa1403e0    	mov	x0, x20
10616a9b8: 946af1e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a9bc: aa1303e0    	mov	x0, x19
10616a9c0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10616a9c4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10616a9c8: a94457f6    	ldp	x22, x21, [sp, #0x40]
10616a9cc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10616a9d0: a94267fa    	ldp	x26, x25, [sp, #0x20]
10616a9d4: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10616a9d8: 9101c3ff    	add	sp, sp, #0x70
10616a9dc: 146af1f4    	b	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a9e0: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10616a9e4: aa1703e1    	mov	x1, x23
10616a9e8: 946af1d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a9ec: aa1d03fd    	mov	x29, x29
10616a9f0: 946af1d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a9f4: aa0003f8    	mov	x24, x0
10616a9f8: b00d0048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616a9fc: f9468100    	ldr	x0, [x8, #0xd00] ; class=MultiTalkMgr
10616aa00: aa1603e1    	mov	x1, x22
10616aa04: 946af1ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616aa08: aa0003e2    	mov	x2, x0
10616aa0c: aa1803e0    	mov	x0, x24
10616aa10: aa1503e1    	mov	x1, x21
10616aa14: 946af1ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616aa18: aa1d03fd    	mov	x29, x29
10616aa1c: 946af1cb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616aa20: aa0003f9    	mov	x25, x0
10616aa24: 900ce688    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10616aa28: f940cd01    	ldr	x1, [x8, #0x198] ; selector=isMultiTalkConnected
10616aa2c: 946af1c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616aa30: aa0003fa    	mov	x26, x0
10616aa34: aa1903e0    	mov	x0, x25
10616aa38: 946af1c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616aa3c: aa1803e0    	mov	x0, x24
10616aa40: 946af1c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616aa44: 340007da    	cbz	w26, 0x10616ab3c <_Flutter_MMFoundation_BindContext+0x2646720>
10616aa48: 52800040    	mov	w0, #0x2                ; =2
10616aa4c: 946a89fd    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616aa50: 34000620    	cbz	w0, 0x10616ab14 <_Flutter_MMFoundation_BindContext+0x26466f8>
10616aa54: 528033d8    	mov	w24, #0x19e             ; =414
10616aa58: d00c3859    	adrp	x25, 0x11e874000 <dyld_stub_binder+0x11e874000>
10616aa5c: 91002339    	add	x25, x25, #0x8 ; cfstring='MultiTalk Main call is actived!'
10616aa60: 946af1d0    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616aa64: aa0003fa    	mov	x26, x0
10616aa68: b00d005c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10616aa6c: f9454780    	ldr	x0, [x28, #0xa88]
10616aa70: 946af1bc    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616aa74: aa0003fb    	mov	x27, x0
10616aa78: f9454780    	ldr	x0, [x28, #0xa88]
10616aa7c: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616aa80: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616aa84: f90003ff    	str	xzr, [sp]
10616aa88: aa1903e2    	mov	x2, x25
10616aa8c: 946af1ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616aa90: aa1d03fd    	mov	x29, x29
10616aa94: 946af1ad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616aa98: aa0003f9    	mov	x25, x0
10616aa9c: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616aaa0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616aaa4: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616aaa8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616aaac: a90003e8    	stp	x8, x0, [sp]
10616aab0: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616aab4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616aab8: aa1b03e0    	mov	x0, x27
10616aabc: 946af1a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616aac0: aa0003fb    	mov	x27, x0
10616aac4: aa1903e0    	mov	x0, x25
10616aac8: 946af1a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616aacc: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616aad0: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616aad4: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616aad8: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616aadc: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616aae0: 913cc884    	add	x4, x4, #0xf32 ; cstring='-[VoIPMPSubCallService reject]'
10616aae4: 52800040    	mov	w0, #0x2                ; =2
10616aae8: aa1803e3    	mov	x3, x24
10616aaec: aa1b03e5    	mov	x5, x27
10616aaf0: 946a89d5    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616aaf4: aa1b03e0    	mov	x0, x27
10616aaf8: 946af197    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616aafc: aa1a03e0    	mov	x0, x26
10616ab00: 946af1ab    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616ab04: 52800038    	mov	w24, #0x1               ; =1
10616ab08: b00d009b    	adrp	x27, 0x12017b000 <dyld_stub_binder+0x12017b000>
10616ab0c: b00d005c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10616ab10: 1400000c    	b	0x10616ab40 <_Flutter_MMFoundation_BindContext+0x2646724>
10616ab14: 52800038    	mov	w24, #0x1               ; =1
10616ab18: 1400000a    	b	0x10616ab40 <_Flutter_MMFoundation_BindContext+0x2646724>
10616ab1c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10616ab20: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10616ab24: a94457f6    	ldp	x22, x21, [sp, #0x40]
10616ab28: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10616ab2c: a94267fa    	ldp	x26, x25, [sp, #0x20]
10616ab30: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10616ab34: 9101c3ff    	add	sp, sp, #0x70
10616ab38: d65f03c0    	ret
10616ab3c: 52800018    	mov	w24, #0x0               ; =0
10616ab40: b00ce688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10616ab44: f940e101    	ldr	x1, [x8, #0x1c0] ; selector=clear
10616ab48: aa1303e0    	mov	x0, x19
10616ab4c: 946af17c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ab50: aa1303e0    	mov	x0, x19
10616ab54: aa1403e1    	mov	x1, x20
10616ab58: 946af179    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ab5c: aa1d03fd    	mov	x29, x29
10616ab60: 946af17a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ab64: aa0003f3    	mov	x19, x0
10616ab68: 900cf308    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10616ab6c: f941d101    	ldr	x1, [x8, #0x3a0] ; selector=inviteType
10616ab70: 946af173    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ab74: aa0003f4    	mov	x20, x0
10616ab78: aa1303e0    	mov	x0, x19
10616ab7c: 946af176    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616ab80: f945eb80    	ldr	x0, [x28, #0xbd0] ; class=MMContext
10616ab84: aa1703e1    	mov	x1, x23
10616ab88: 946af16d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616ab8c: aa1d03fd    	mov	x29, x29
10616ab90: 946af16e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616ab94: aa0003f3    	mov	x19, x0
10616ab98: f1000e9f    	cmp	x20, #0x3
10616ab9c: 54000061    	b.ne	0x10616aba8 <_Flutter_MMFoundation_BindContext+0x264678c>
10616aba0: f945cb60    	ldr	x0, [x27, #0xb90] ; class=VoIPConfSDKService
10616aba4: 14000003    	b	0x10616abb0 <_Flutter_MMFoundation_BindContext+0x2646794>
10616aba8: 900d0068    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10616abac: f945ed00    	ldr	x0, [x8, #0xbd8] ; class=MMConfSDKService
10616abb0: aa1603e1    	mov	x1, x22
10616abb4: 946af162    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616abb8: aa0003e2    	mov	x2, x0
10616abbc: aa1303e0    	mov	x0, x19
10616abc0: aa1503e1    	mov	x1, x21
10616abc4: 946af15e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616abc8: aa1d03fd    	mov	x29, x29
10616abcc: 946af15f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616abd0: aa0003f4    	mov	x20, x0
10616abd4: 900cec68    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
10616abd8: f941c101    	ldr	x1, [x8, #0x380] ; selector=hangup:isSubCall:
10616abdc: 52800022    	mov	w2, #0x1                ; =1
10616abe0: aa1803e3    	mov	x3, x24
10616abe4: 946af156    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616abe8: aa1403e0    	mov	x0, x20
10616abec: 946af15a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616abf0: aa1303e0    	mov	x0, x19
10616abf4: a9467bfd    	ldp	x29, x30, [sp, #0x60]
10616abf8: a9454ff4    	ldp	x20, x19, [sp, #0x50]
10616abfc: a94457f6    	ldp	x22, x21, [sp, #0x40]
10616ac00: a9435ff8    	ldp	x24, x23, [sp, #0x30]
10616ac04: a94267fa    	ldp	x26, x25, [sp, #0x20]
10616ac08: a9416ffc    	ldp	x28, x27, [sp, #0x10]
10616ac0c: 9101c3ff    	add	sp, sp, #0x70
10616ac10: 146af151    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
