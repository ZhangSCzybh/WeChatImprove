
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101763fa8: d10183ff    	sub	sp, sp, #0x60
101763fac: a90167fa    	stp	x26, x25, [sp, #0x10]
101763fb0: a9025ff8    	stp	x24, x23, [sp, #0x20]
101763fb4: a90357f6    	stp	x22, x21, [sp, #0x30]
101763fb8: a9044ff4    	stp	x20, x19, [sp, #0x40]
101763fbc: a9057bfd    	stp	x29, x30, [sp, #0x50]
101763fc0: 910143fd    	add	x29, sp, #0x50
101763fc4: aa0303f4    	mov	x20, x3
101763fc8: aa0203f3    	mov	x19, x2
101763fcc: aa0003f5    	mov	x21, x0
101763fd0: f00fa668    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101763fd4: 52800029    	mov	w9, #0x1                ; =1
101763fd8: 3922b109    	strb	w9, [x8, #0x8ac]
101763fdc: aa0203e0    	mov	x0, x2
101763fe0: 95930c56    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101763fe4: aa1403e0    	mov	x0, x20
101763fe8: 95930c54    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101763fec: 900f36c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
101763ff0: f9478d01    	ldr	x1, [x8, #0xf18] ; searchBar
101763ff4: aa1503e0    	mov	x0, x21
101763ff8: 95930c51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101763ffc: aa1d03fd    	mov	x29, x29
101764000: 95930c52    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101764004: aa0003f6    	mov	x22, x0
101764008: f00f3a08    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
10176400c: f9453d01    	ldr	x1, [x8, #0xa78] ; setIsReplaceText:
101764010: 52800002    	mov	w2, #0x0                ; =0
101764014: 95930c4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764018: aa1603e0    	mov	x0, x22
10176401c: 95930c4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101764020: b40000d3    	cbz	x19, 0x101764038 <__text+0x175c038>
101764024: f00f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101764028: f943bd01    	ldr	x1, [x8, #0x778] ; isEmpty
10176402c: aa1303e0    	mov	x0, x19
101764030: 95930c43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764034: 36000e40    	tbz	w0, #0x0, 0x1017641fc <__text+0x175c1fc>
101764038: 900f3828    	adrp	x8, 0x11fe68000 <dyld_stub_binder+0x11fe68000>
10176403c: f946f117    	ldr	x23, [x8, #0xde0] ; presenter
101764040: aa1503e0    	mov	x0, x21
101764044: aa1703e1    	mov	x1, x23
101764048: 95930c3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176404c: aa1d03fd    	mov	x29, x29
101764050: 95930c3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101764054: aa0003f6    	mov	x22, x0
101764058: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10176405c: f9412d01    	ldr	x1, [x8, #0x258] ; isDuringVoiceSearch
101764060: 95930c37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764064: aa0003f8    	mov	x24, x0
101764068: aa1603e0    	mov	x0, x22
10176406c: 95930c3a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101764070: 34000258    	cbz	w24, 0x1017640b8 <__text+0x175c0b8>
101764074: f00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101764078: f9453500    	ldr	x0, [x8, #0xa68]
10176407c: b00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101764080: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
101764084: d00e7168    	adrp	x8, 0x11e592000 <dyld_stub_binder+0x11e592000>
101764088: 913fa108    	add	x8, x8, #0xfe8
10176408c: f90003e8    	str	x8, [sp]
101764090: 900cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
101764094: 91388063    	add	x3, x3, #0xe20
101764098: f00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
10176409c: 911b74a5    	add	x5, x5, #0x6dd
1017640a0: f00ce3e7    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
1017640a4: 9132f0e7    	add	x7, x7, #0xcbc
1017640a8: 52800042    	mov	w2, #0x2                ; =2
1017640ac: 52800004    	mov	w4, #0x0                ; =0
1017640b0: 52806086    	mov	w6, #0x304              ; =772
1017640b4: 14000062    	b	0x10176423c <__text+0x175c23c>
1017640b8: f00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1017640bc: f9467900    	ldr	x0, [x8, #0xcf0]
1017640c0: b00f37a8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1017640c4: f9436501    	ldr	x1, [x8, #0x6c8] ; trimString:
1017640c8: aa1403e2    	mov	x2, x20
1017640cc: 95930c1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017640d0: aa1d03fd    	mov	x29, x29
1017640d4: 95930c1d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017640d8: aa0003f6    	mov	x22, x0
1017640dc: f00f4ce8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1017640e0: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1017640e4: 95930c16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017640e8: aa0003f8    	mov	x24, x0
1017640ec: f100001f    	cmp	x0, #0x0
1017640f0: 1a9f17e2    	cset	w2, eq
1017640f4: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017640f8: f9413101    	ldr	x1, [x8, #0x260] ; updateViewHideStates:
1017640fc: aa1503e0    	mov	x0, x21
101764100: 95930c0f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764104: b5000158    	cbnz	x24, 0x10176412c <__text+0x175c12c>
101764108: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
10176410c: f9413501    	ldr	x1, [x8, #0x268] ; tryHideCheckBox:
101764110: aa1503e0    	mov	x0, x21
101764114: 52800002    	mov	w2, #0x0                ; =0
101764118: 95930c09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176411c: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101764120: f9413901    	ldr	x1, [x8, #0x270] ; trySwitchToLargeInputBox
101764124: aa1503e0    	mov	x0, x21
101764128: 95930c05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10176412c: f100031f    	cmp	x24, #0x0
101764130: 1a9f07e2    	cset	w2, ne
101764134: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101764138: f9413d01    	ldr	x1, [x8, #0x278] ; setActionButtonHiddenImmediately:
10176413c: aa1503e0    	mov	x0, x21
101764140: 95930bff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764144: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101764148: f9414101    	ldr	x1, [x8, #0x280] ; isFromVoice
10176414c: aa1503e0    	mov	x0, x21
101764150: 95930bfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764154: aa0003f8    	mov	x24, x0
101764158: aa1503e0    	mov	x0, x21
10176415c: aa1703e1    	mov	x1, x23
101764160: 95930bf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764164: aa1d03fd    	mov	x29, x29
101764168: 95930bf8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10176416c: aa0003f9    	mov	x25, x0
101764170: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
101764174: f9414501    	ldr	x1, [x8, #0x288] ; setIsFromVoice:
101764178: aa1803e2    	mov	x2, x24
10176417c: 95930bf0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764180: aa1903e0    	mov	x0, x25
101764184: 95930bf4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101764188: aa1503e0    	mov	x0, x21
10176418c: aa1703e1    	mov	x1, x23
101764190: 95930beb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764194: aa1d03fd    	mov	x29, x29
101764198: 95930bec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10176419c: aa0003f7    	mov	x23, x0
1017641a0: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017641a4: f9414901    	ldr	x1, [x8, #0x290] ; handleTextDidChange:
1017641a8: aa1603e2    	mov	x2, x22
1017641ac: 95930be4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017641b0: aa1703e0    	mov	x0, x23
1017641b4: 95930be8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017641b8: 900f5468    	adrp	x8, 0x1201f0000 <dyld_stub_binder+0x1201f0000>
1017641bc: b98db108    	ldrsw	x8, [x8, #0xdb0]
1017641c0: f8686aa0    	ldr	x0, [x21, x8]
1017641c4: b00f3a28    	adrp	x8, 0x11fea9000 <dyld_stub_binder+0x11fea9000>
1017641c8: f9414d01    	ldr	x1, [x8, #0x298] ; reportHandler
1017641cc: 95930bdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017641d0: aa1d03fd    	mov	x29, x29
1017641d4: 95930bdd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1017641d8: aa0003f5    	mov	x21, x0
1017641dc: f00f4cc8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1017641e0: f947d901    	ldr	x1, [x8, #0xfb0] ; clearCache
1017641e4: 95930bd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1017641e8: aa1503e0    	mov	x0, x21
1017641ec: 95930bda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017641f0: aa1603e0    	mov	x0, x22
1017641f4: 95930bd8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1017641f8: 14000012    	b	0x101764240 <__text+0x175c240>
1017641fc: f00f5068    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101764200: f9453500    	ldr	x0, [x8, #0xa68]
101764204: b00f36a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101764208: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10176420c: f00e7148    	adrp	x8, 0x11e58f000 <dyld_stub_binder+0x11e58f000>
101764210: 9115a108    	add	x8, x8, #0x568
101764214: a90053e8    	stp	x8, x20, [sp]
101764218: 900cd883    	adrp	x3, 0x11b274000 <dyld_stub_binder+0x11b274000>
10176421c: 91388063    	add	x3, x3, #0xe20
101764220: f00ce3e5    	adrp	x5, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
101764224: 911b74a5    	add	x5, x5, #0x6dd
101764228: f00ce3e7    	adrp	x7, 0x11b3e3000 <dyld_stub_binder+0x11b3e3000>
10176422c: 9132f0e7    	add	x7, x7, #0xcbc
101764230: 52800042    	mov	w2, #0x2                ; =2
101764234: 52800004    	mov	w4, #0x0                ; =0
101764238: 52805fe6    	mov	w6, #0x2ff              ; =767
10176423c: 95930bc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101764240: aa1403e0    	mov	x0, x20
101764244: 95930bc4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101764248: aa1303e0    	mov	x0, x19
10176424c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
101764250: a9444ff4    	ldp	x20, x19, [sp, #0x40]
101764254: a94357f6    	ldp	x22, x21, [sp, #0x30]
101764258: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10176425c: a94167fa    	ldp	x26, x25, [sp, #0x10]
101764260: 910183ff    	add	sp, sp, #0x60
101764264: 15930bbc    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
