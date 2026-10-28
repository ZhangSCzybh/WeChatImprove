
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167275b8: 6dba23e9    	stp	d9, d8, [sp, #-0x60]!
1167275bc: a90167fa    	stp	x26, x25, [sp, #0x10]
1167275c0: a9025ff8    	stp	x24, x23, [sp, #0x20]
1167275c4: a90357f6    	stp	x22, x21, [sp, #0x30]
1167275c8: a9044ff4    	stp	x20, x19, [sp, #0x40]
1167275cc: a9057bfd    	stp	x29, x30, [sp, #0x50]
1167275d0: 910143fd    	add	x29, sp, #0x50
1167275d4: aa0003f3    	mov	x19, x0
1167275d8: d004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167275dc: b9837519    	ldrsw	x25, [x8, #0x374]
1167275e0: f8796808    	ldr	x8, [x0, x25]
1167275e4: b4000c88    	cbz	x8, 0x116727774 <_O266DecReleaseOutputPicture+0x349acbc>
1167275e8: b004b948    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
1167275ec: f9452114    	ldr	x20, [x8, #0xa40] ; tableFooterView
1167275f0: aa1303e0    	mov	x0, x19
1167275f4: aa1403e1    	mov	x1, x20
1167275f8: 947009bd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167275fc: aa1d03fd    	mov	x29, x29
116727600: 947009e5    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116727604: b4000d00    	cbz	x0, 0x1167277a4 <_O266DecReleaseOutputPicture+0x349acec>
116727608: aa0003f5    	mov	x21, x0
11672760c: aa1303e0    	mov	x0, x19
116727610: aa1403e1    	mov	x1, x20
116727614: 947009b6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727618: aa1d03fd    	mov	x29, x29
11672761c: 947009de    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116727620: aa0003f6    	mov	x22, x0
116727624: d004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116727628: b9837918    	ldrsw	x24, [x8, #0x378]
11672762c: f8786a77    	ldr	x23, [x19, x24]
116727630: 947009ca    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116727634: aa1503e0    	mov	x0, x21
116727638: 947009c8    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11672763c: eb1702df    	cmp	x22, x23
116727640: 54000b60    	b.eq	0x1167277ac <_O266DecReleaseOutputPicture+0x349acf4>
116727644: f8786a60    	ldr	x0, [x19, x24]
116727648: f004cee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
11672764c: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
116727650: 947009a7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727654: 9004d268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
116727658: f9474d00    	ldr	x0, [x8, #0xe98]
11672765c: 94700947    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
116727660: aa0003f5    	mov	x21, x0
116727664: 9004cf28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116727668: f947a501    	ldr	x1, [x8, #0xf48] ; width
11672766c: aa1303e0    	mov	x0, x19
116727670: 9470099f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727674: 1e604008    	fmov	d8, d0
116727678: 9004d276    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
11672767c: f94702c0    	ldr	x0, [x22, #0xe00] ; UiUtil
116727680: d004b8e8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
116727684: f9456501    	ldr	x1, [x8, #0xac8] ; pageScopeHeightWithWarningFor:
116727688: aa1303e2    	mov	x2, x19
11672768c: 94700998    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727690: 1e604009    	fmov	d9, d0
116727694: f94702c0    	ldr	x0, [x22, #0xe00] ; UiUtil
116727698: b004b8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
11672769c: f940f501    	ldr	x1, [x8, #0x1e8] ; statusBarHeight
1167276a0: 94700993    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167276a4: 1e603923    	fsub	d3, d9, d0
1167276a8: f004cec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1167276ac: f947d901    	ldr	x1, [x8, #0xfb0] ; initWithFrame:
1167276b0: 9e6703e0    	fmov	d0, xzr
1167276b4: 9e6703e1    	fmov	d1, xzr
1167276b8: aa1503e0    	mov	x0, x21
1167276bc: 1e604102    	fmov	d2, d8
1167276c0: 9470098b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167276c4: f8786a68    	ldr	x8, [x19, x24]
1167276c8: f8386a60    	str	x0, [x19, x24]
1167276cc: aa0803e0    	mov	x0, x8
1167276d0: 947009a2    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167276d4: f8786a60    	ldr	x0, [x19, x24]
1167276d8: 9004cf08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1167276dc: f9406501    	ldr	x1, [x8, #0xc8] ; setAutoresizingMask:
1167276e0: 52800242    	mov	w2, #0x12               ; =18
1167276e4: 94700982    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167276e8: f8796a62    	ldr	x2, [x19, x25]
1167276ec: f8786a60    	ldr	x0, [x19, x24]
1167276f0: 9004cf08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1167276f4: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
1167276f8: 9470097d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167276fc: aa1303e0    	mov	x0, x19
116727700: aa1403e1    	mov	x1, x20
116727704: 9470097a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727708: aa1d03fd    	mov	x29, x29
11672770c: 947009a2    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116727710: aa0003f5    	mov	x21, x0
116727714: f004cec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
116727718: f9449d01    	ldr	x1, [x8, #0x938] ; height
11672771c: 94700974    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727720: 1e604001    	fmov	d1, d0
116727724: f8786a60    	ldr	x0, [x19, x24]
116727728: d004b888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
11672772c: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
116727730: 9e6703e0    	fmov	d0, xzr
116727734: 9470096e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727738: aa1503e0    	mov	x0, x21
11672773c: 94700987    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116727740: aa1303e0    	mov	x0, x19
116727744: aa1403e1    	mov	x1, x20
116727748: 94700969    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672774c: aa1d03fd    	mov	x29, x29
116727750: 94700991    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116727754: aa0003f4    	mov	x20, x0
116727758: f8786a62    	ldr	x2, [x19, x24]
11672775c: f004cea8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
116727760: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
116727764: 94700962    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727768: aa1403e0    	mov	x0, x20
11672776c: 9470097b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116727770: 14000073    	b	0x11672793c <_O266DecReleaseOutputPicture+0x349ae84>
116727774: d004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116727778: b9837908    	ldrsw	x8, [x8, #0x378]
11672777c: f8686a60    	ldr	x0, [x19, x8]
116727780: f004cee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
116727784: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
116727788: a9457bfd    	ldp	x29, x30, [sp, #0x50]
11672778c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
116727790: a94357f6    	ldp	x22, x21, [sp, #0x30]
116727794: a9425ff8    	ldp	x24, x23, [sp, #0x20]
116727798: a94167fa    	ldp	x26, x25, [sp, #0x10]
11672779c: 6cc623e9    	ldp	d9, d8, [sp], #0x60
1167277a0: 14700953    	b	0x118329cec <dyld_stub_binder+0x118329cec>
1167277a4: d004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167277a8: b9837918    	ldrsw	x24, [x8, #0x378]
1167277ac: f8786a60    	ldr	x0, [x19, x24]
1167277b0: f004cee8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1167277b4: f940f901    	ldr	x1, [x8, #0x1f0] ; removeFromSuperview
1167277b8: 9470094d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167277bc: 9004d27a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1167277c0: f9474f40    	ldr	x0, [x26, #0xe98]
1167277c4: 947008ed    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
1167277c8: aa0003f6    	mov	x22, x0
1167277cc: aa1303e0    	mov	x0, x19
1167277d0: aa1403e1    	mov	x1, x20
1167277d4: 94700946    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167277d8: aa1d03fd    	mov	x29, x29
1167277dc: 9470096e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167277e0: aa0003f4    	mov	x20, x0
1167277e4: 9004cf28    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1167277e8: f947a517    	ldr	x23, [x8, #0xf48] ; width
1167277ec: aa1703e1    	mov	x1, x23
1167277f0: 9470093f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167277f4: 1e604002    	fmov	d2, d0
1167277f8: f004cec8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1167277fc: f947d915    	ldr	x21, [x8, #0xfb0] ; initWithFrame:
116727800: 9e6703e0    	fmov	d0, xzr
116727804: 9e6703e1    	fmov	d1, xzr
116727808: 9e6703e3    	fmov	d3, xzr
11672780c: aa1603e0    	mov	x0, x22
116727810: aa1503e1    	mov	x1, x21
116727814: 94700936    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727818: f8786a68    	ldr	x8, [x19, x24]
11672781c: f8386a60    	str	x0, [x19, x24]
116727820: aa0803e0    	mov	x0, x8
116727824: 9470094d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116727828: aa1403e0    	mov	x0, x20
11672782c: 9470094b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116727830: f8786a60    	ldr	x0, [x19, x24]
116727834: 9004cf08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
116727838: f9406514    	ldr	x20, [x8, #0xc8] ; setAutoresizingMask:
11672783c: aa1403e1    	mov	x1, x20
116727840: 52800242    	mov	w2, #0x12               ; =18
116727844: 9470092a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727848: f9474f40    	ldr	x0, [x26, #0xe98]
11672784c: 947008cb    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
116727850: aa0003f6    	mov	x22, x0
116727854: f8786a60    	ldr	x0, [x19, x24]
116727858: aa1703e1    	mov	x1, x23
11672785c: 94700924    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727860: 1e604008    	fmov	d8, d0
116727864: 9004d277    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
116727868: f94702e0    	ldr	x0, [x23, #0xe00] ; UiUtil
11672786c: d004b8e8    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
116727870: f9456501    	ldr	x1, [x8, #0xac8] ; pageScopeHeightWithWarningFor:
116727874: aa1303e2    	mov	x2, x19
116727878: 9470091d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672787c: 1e604009    	fmov	d9, d0
116727880: f94702e0    	ldr	x0, [x23, #0xe00] ; UiUtil
116727884: b004b8e8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
116727888: f940f501    	ldr	x1, [x8, #0x1e8] ; statusBarHeight
11672788c: 94700918    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727890: 1e603923    	fsub	d3, d9, d0
116727894: 9e6703e0    	fmov	d0, xzr
116727898: 9e6703e1    	fmov	d1, xzr
11672789c: aa1603e0    	mov	x0, x22
1167278a0: aa1503e1    	mov	x1, x21
1167278a4: 1e604102    	fmov	d2, d8
1167278a8: 94700911    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167278ac: d004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167278b0: b9837d15    	ldrsw	x21, [x8, #0x37c]
1167278b4: f8756a68    	ldr	x8, [x19, x21]
1167278b8: f8356a60    	str	x0, [x19, x21]
1167278bc: aa0803e0    	mov	x0, x8
1167278c0: 94700926    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167278c4: f8796a62    	ldr	x2, [x19, x25]
1167278c8: f8756a60    	ldr	x0, [x19, x21]
1167278cc: 9004cf08    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1167278d0: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
1167278d4: 94700906    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167278d8: f8756a60    	ldr	x0, [x19, x21]
1167278dc: d004b888    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1167278e0: f9465501    	ldr	x1, [x8, #0xca8] ; setWcOrigin:
1167278e4: 9e6703e0    	fmov	d0, xzr
1167278e8: 9e6703e1    	fmov	d1, xzr
1167278ec: 94700900    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167278f0: f8756a60    	ldr	x0, [x19, x21]
1167278f4: aa1403e1    	mov	x1, x20
1167278f8: 52800242    	mov	w2, #0x12               ; =18
1167278fc: 947008fc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727900: f8786a60    	ldr	x0, [x19, x24]
116727904: f8756a62    	ldr	x2, [x19, x21]
116727908: f004cea8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
11672790c: f9476d01    	ldr	x1, [x8, #0xed8] ; addSubview:
116727910: 947008f7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727914: f8786a62    	ldr	x2, [x19, x24]
116727918: f004b928    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
11672791c: f9406d01    	ldr	x1, [x8, #0xd8] ; setTableFooterView:
116727920: aa1303e0    	mov	x0, x19
116727924: 947008f2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116727928: f8786a60    	ldr	x0, [x19, x24]
11672792c: b004cf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116727930: f9410901    	ldr	x1, [x8, #0x210] ; setHeight:
116727934: 9e6703e0    	fmov	d0, xzr
116727938: 947008ed    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11672793c: f004b968    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
116727940: f9431901    	ldr	x1, [x8, #0x630] ; setSeparatorInset:
116727944: 9e6703e0    	fmov	d0, xzr
116727948: 1e649001    	fmov	d1, #10.00000000
11672794c: 9e6703e2    	fmov	d2, xzr
116727950: 9e6703e3    	fmov	d3, xzr
116727954: aa1303e0    	mov	x0, x19
116727958: a9457bfd    	ldp	x29, x30, [sp, #0x50]
11672795c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
116727960: a94357f6    	ldp	x22, x21, [sp, #0x30]
116727964: a9425ff8    	ldp	x24, x23, [sp, #0x20]
116727968: a94167fa    	ldp	x26, x25, [sp, #0x10]
11672796c: 6cc623e9    	ldp	d9, d8, [sp], #0x60
116727970: 147008df    	b	0x118329cec <dyld_stub_binder+0x118329cec>
