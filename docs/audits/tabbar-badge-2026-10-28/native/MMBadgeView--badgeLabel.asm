
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167157f8: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
1167157fc: a9015ff8    	stp	x24, x23, [sp, #0x10]
116715800: a90257f6    	stp	x22, x21, [sp, #0x20]
116715804: a9034ff4    	stp	x20, x19, [sp, #0x30]
116715808: a9047bfd    	stp	x29, x30, [sp, #0x40]
11671580c: 910103fd    	add	x29, sp, #0x40
116715810: aa0003f3    	mov	x19, x0
116715814: 9004dbe8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116715818: b9813918    	ldrsw	x24, [x8, #0x138]
11671581c: f8786800    	ldr	x0, [x0, x24]
116715820: b5000fc0    	cbnz	x0, 0x116715a18 <_O266DecReleaseOutputPicture+0x3488f60>
116715824: d004d2e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
116715828: f9462500    	ldr	x0, [x8, #0xc48] ; class MMUILabel
11671582c: 947050d9    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
116715830: f8786a68    	ldr	x8, [x19, x24]
116715834: f8386a60    	str	x0, [x19, x24]
116715838: aa0803e0    	mov	x0, x8
11671583c: 94705147    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116715840: f8786a60    	ldr	x0, [x19, x24]
116715844: 9004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116715848: f9469101    	ldr	x1, [x8, #0xd20] ; selector setTextAlignment:
11671584c: 52800022    	mov	w2, #0x1                ; =1
116715850: 94705127    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715854: b004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116715858: f942ed14    	ldr	x20, [x8, #0x5d8] ; selector badgeFontSize
11671585c: aa1303e0    	mov	x0, x19
116715860: aa1403e1    	mov	x1, x20
116715864: 94705122    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715868: d004d2e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
11671586c: f9461915    	ldr	x21, [x8, #0xc30] ; class UIFont
116715870: 1e602008    	fcmp	d0, #0.0
116715874: 9004d339    	adrp	x25, 0x120179000 <dyld_stub_binder+0x120179000>
116715878: 540002a0    	b.eq	0x1167158cc <_O266DecReleaseOutputPicture+0x3488e14>
11671587c: aa1303e0    	mov	x0, x19
116715880: aa1403e1    	mov	x1, x20
116715884: 9470511a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715888: d004cf48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
11671588c: f943b101    	ldr	x1, [x8, #0x760] ; selector boldSystemFontOfSize:
116715890: aa1503e0    	mov	x0, x21
116715894: 94705116    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715898: aa1d03fd    	mov	x29, x29
11671589c: 9470513e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167158a0: aa0003f4    	mov	x20, x0
1167158a4: f8786a60    	ldr	x0, [x19, x24]
1167158a8: f004cf88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1167158ac: f9400501    	ldr	x1, [x8, #0x8] ; selector setFont:
1167158b0: aa1403e2    	mov	x2, x20
1167158b4: 9470510e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167158b8: aa1403e0    	mov	x0, x20
1167158bc: 94705127    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167158c0: 9004b948    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1167158c4: f940f514    	ldr	x20, [x8, #0x1e8] ; selector externalIMP
1167158c8: 1400002a    	b	0x116715970 <_O266DecReleaseOutputPicture+0x3488eb8>
1167158cc: b004d4a8    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1167158d0: f9448d00    	ldr	x0, [x8, #0x918] ; class WCThemeUtil
1167158d4: 9004b948    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1167158d8: f940f514    	ldr	x20, [x8, #0x1e8] ; selector externalIMP
1167158dc: aa1403e1    	mov	x1, x20
1167158e0: 94705103    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167158e4: aa0003f6    	mov	x22, x0
1167158e8: f9424f20    	ldr	x0, [x25, #0x498] ; class WCTheme
1167158ec: aa1403e1    	mov	x1, x20
1167158f0: 947050ff    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167158f4: d004b928    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1167158f8: f947fd01    	ldr	x1, [x8, #0xff8] ; selector getValueOfProperty:inRuleSet:
1167158fc: d003fa42    	adrp	x2, 0x11e65f000 <dyld_stub_binder+0x11e65f000>
116715900: 91252042    	add	x2, x2, #0x948 ; CFString 'common_font_small_size'
116715904: d003fa43    	adrp	x3, 0x11e65f000 <dyld_stub_binder+0x11e65f000>
116715908: 9125a063    	add	x3, x3, #0x968 ; CFString '#common_default'
11671590c: 947050f8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715910: aa1d03fd    	mov	x29, x29
116715914: 94705120    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116715918: aa0003f7    	mov	x23, x0
11671591c: f004b928    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
116715920: f9400101    	ldr	x1, [x8] ; selector parseFloatFromValues:
116715924: aa1603e0    	mov	x0, x22
116715928: aa1703e2    	mov	x2, x23
11671592c: 947050f0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715930: d004b988    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
116715934: f9429501    	ldr	x1, [x8, #0x528] ; selector dynamicBoldSystemFontOfSize:
116715938: aa1503e0    	mov	x0, x21
11671593c: 947050ec    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715940: aa1d03fd    	mov	x29, x29
116715944: 94705114    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116715948: aa0003f5    	mov	x21, x0
11671594c: f8786a60    	ldr	x0, [x19, x24]
116715950: f004cf88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116715954: f9400501    	ldr	x1, [x8, #0x8] ; selector setFont:
116715958: aa1503e2    	mov	x2, x21
11671595c: 947050e4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715960: aa1503e0    	mov	x0, x21
116715964: 947050fd    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116715968: aa1703e0    	mov	x0, x23
11671596c: 947050fb    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116715970: f9424f20    	ldr	x0, [x25, #0x498] ; class WCTheme
116715974: aa1403e1    	mov	x1, x20
116715978: 947050dd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11671597c: f004b928    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
116715980: f9400901    	ldr	x1, [x8, #0x10] ; selector getColorByName:
116715984: f00422a2    	adrp	x2, 0x11eb6c000 <dyld_stub_binder+0x11eb6c000>
116715988: 9121a042    	add	x2, x2, #0x868 ; CFString 'badage_text_color'
11671598c: 947050d8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715990: aa1d03fd    	mov	x29, x29
116715994: 94705100    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116715998: aa0003f4    	mov	x20, x0
11671599c: 947050f5    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167159a0: b40000a0    	cbz	x0, 0x1167159b4 <_O266DecReleaseOutputPicture+0x3488efc>
1167159a4: aa1403e0    	mov	x0, x20
1167159a8: 947050f2    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1167159ac: aa1403f5    	mov	x21, x20
1167159b0: 14000009    	b	0x1167159d4 <_O266DecReleaseOutputPicture+0x3488f1c>
1167159b4: d004d2e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1167159b8: f9463100    	ldr	x0, [x8, #0xc60] ; class UIColor
1167159bc: d004cf48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1167159c0: f947dd01    	ldr	x1, [x8, #0xfb8] ; selector clearColor
1167159c4: 947050ca    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167159c8: aa1d03fd    	mov	x29, x29
1167159cc: 947050f2    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167159d0: aa0003f5    	mov	x21, x0
1167159d4: aa1403e0    	mov	x0, x20
1167159d8: 947050e0    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167159dc: f8786a60    	ldr	x0, [x19, x24]
1167159e0: 9004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1167159e4: f9469501    	ldr	x1, [x8, #0xd28] ; selector setTextColor:
1167159e8: aa1503e2    	mov	x2, x21
1167159ec: 947050c0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167159f0: aa1503e0    	mov	x0, x21
1167159f4: 947050d9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167159f8: aa1403e0    	mov	x0, x20
1167159fc: 947050d7    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116715a00: f8786a62    	ldr	x2, [x19, x24]
116715a04: b004cf48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
116715a08: f9476d01    	ldr	x1, [x8, #0xed8] ; selector addSubview:
116715a0c: aa1303e0    	mov	x0, x19
116715a10: 947050b7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116715a14: f8786a60    	ldr	x0, [x19, x24]
116715a18: a9447bfd    	ldp	x29, x30, [sp, #0x40]
116715a1c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
116715a20: a94257f6    	ldp	x22, x21, [sp, #0x20]
116715a24: a9415ff8    	ldp	x24, x23, [sp, #0x10]
116715a28: a8c567fa    	ldp	x26, x25, [sp], #0x50
116715a2c: 147050d7    	b	0x118329d88 <dyld_stub_binder+0x118329d88>
