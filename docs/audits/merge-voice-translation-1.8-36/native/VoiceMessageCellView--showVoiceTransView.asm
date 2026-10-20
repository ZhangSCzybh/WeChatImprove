
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106283038: d10243ff    	sub	sp, sp, #0x90
10628303c: a9036ffc    	stp	x28, x27, [sp, #0x30]
106283040: a90467fa    	stp	x26, x25, [sp, #0x40]
106283044: a9055ff8    	stp	x24, x23, [sp, #0x50]
106283048: a90657f6    	stp	x22, x21, [sp, #0x60]
10628304c: a9074ff4    	stp	x20, x19, [sp, #0x70]
106283050: a9087bfd    	stp	x29, x30, [sp, #0x80]
106283054: 910203fd    	add	x29, sp, #0x80
106283058: aa0003f3    	mov	x19, x0
10628305c: 900d4e08    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106283060: 52800029    	mov	w9, #0x1                ; =1
106283064: 39285109    	strb	w9, [x8, #0xa14]
106283068: f00cddc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10628306c: f9410917    	ldr	x23, [x8, #0x210] ; viewModel
106283070: aa1703e1    	mov	x1, x23
106283074: 94669032    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283078: aa1d03fd    	mov	x29, x29
10628307c: 94669033    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106283080: aa0003f4    	mov	x20, x0
106283084: 900cea88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106283088: f946d901    	ldr	x1, [x8, #0xdb0] ; hasLocalTranslateResult
10628308c: 9466902c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283090: aa0003f5    	mov	x21, x0
106283094: aa1403e0    	mov	x0, x20
106283098: 9466902f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10628309c: b00cf3e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1062830a0: f944e914    	ldr	x20, [x8, #0x9d0] ; currentContext
1062830a4: 900cf79b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
1062830a8: 37000df5    	tbnz	w21, #0x0, 0x106283264 <_Flutter_MMFoundation_BindContext+0x275ee48>
1062830ac: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
1062830b0: aa1403e1    	mov	x1, x20
1062830b4: 94669022    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062830b8: aa1d03fd    	mov	x29, x29
1062830bc: 94669023    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062830c0: aa0003f8    	mov	x24, x0
1062830c4: 900cf7a8    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
1062830c8: f9479100    	ldr	x0, [x8, #0xf20] ; �=8 
1062830cc: 900cf3e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1062830d0: f947ad15    	ldr	x21, [x8, #0xf58] ; class
1062830d4: aa1503e1    	mov	x1, x21
1062830d8: 94669019    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062830dc: aa0003e2    	mov	x2, x0
1062830e0: d00cdda8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1062830e4: f9464116    	ldr	x22, [x8, #0xc80] ; getService:
1062830e8: aa1803e0    	mov	x0, x24
1062830ec: aa1603e1    	mov	x1, x22
1062830f0: 94669013    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062830f4: aa1d03fd    	mov	x29, x29
1062830f8: 94669014    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062830fc: aa0003f9    	mov	x25, x0
106283100: f00cdea8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
106283104: f943e901    	ldr	x1, [x8, #0x7d0] ; getNetworkStatusType
106283108: 9466900d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628310c: aa0003fa    	mov	x26, x0
106283110: aa1903e0    	mov	x0, x25
106283114: 94669010    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283118: aa1803e0    	mov	x0, x24
10628311c: 9466900e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283120: 7100075f    	cmp	w26, #0x1
106283124: 54000a01    	b.ne	0x106283264 <_Flutter_MMFoundation_BindContext+0x275ee48>
106283128: 900cf788    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10628312c: f9469518    	ldr	x24, [x8, #0xd28] ; x<c 
106283130: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
106283134: aa1403e1    	mov	x1, x20
106283138: 94669001    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628313c: aa1d03fd    	mov	x29, x29
106283140: 94669002    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106283144: aa0003f3    	mov	x19, x0
106283148: 900cf79c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10628314c: f9462b80    	ldr	x0, [x28, #0xc50]
106283150: aa1503e1    	mov	x1, x21
106283154: 94668ffa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283158: aa0003e2    	mov	x2, x0
10628315c: aa1303e0    	mov	x0, x19
106283160: aa1603e1    	mov	x1, x22
106283164: 94668ff6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283168: aa1d03fd    	mov	x29, x29
10628316c: 94668ff7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106283170: aa0003f7    	mov	x23, x0
106283174: d00cdda8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106283178: f9464519    	ldr	x25, [x8, #0xc88] ; getStringForCurLanguage:
10628317c: f00c2fa2    	adrp	x2, 0x11e87a000 <dyld_stub_binder+0x11e87a000>
106283180: 9124a042    	add	x2, x2, #0x928
106283184: aa1903e1    	mov	x1, x25
106283188: 94668fed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628318c: aa1d03fd    	mov	x29, x29
106283190: 94668fee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106283194: aa0003fa    	mov	x26, x0
106283198: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
10628319c: aa1403e1    	mov	x1, x20
1062831a0: 94668fe7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062831a4: aa1d03fd    	mov	x29, x29
1062831a8: 94668fe8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062831ac: aa0003f4    	mov	x20, x0
1062831b0: f9462b80    	ldr	x0, [x28, #0xc50]
1062831b4: aa1503e1    	mov	x1, x21
1062831b8: 94668fe1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062831bc: aa0003e2    	mov	x2, x0
1062831c0: aa1403e0    	mov	x0, x20
1062831c4: aa1603e1    	mov	x1, x22
1062831c8: 94668fdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062831cc: aa1d03fd    	mov	x29, x29
1062831d0: 94668fde    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062831d4: aa0003f5    	mov	x21, x0
1062831d8: b00c10e2    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
1062831dc: 9106a042    	add	x2, x2, #0x1a8
1062831e0: aa1903e1    	mov	x1, x25
1062831e4: 94668fd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062831e8: aa1d03fd    	mov	x29, x29
1062831ec: 94668fd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062831f0: aa0003f6    	mov	x22, x0
1062831f4: f00cdda8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1062831f8: f941cd01    	ldr	x1, [x8, #0x398] ; showAlertWithTitle:message:btnTitle:
1062831fc: aa1803e0    	mov	x0, x24
106283200: d2800002    	mov	x2, #0x0                ; =0
106283204: aa1a03e3    	mov	x3, x26
106283208: aa1603e4    	mov	x4, x22
10628320c: 94668fcc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283210: aa1d03fd    	mov	x29, x29
106283214: 94668fd4    	bl	0x107c27164 <_Flutter_MMFoundation_BindContext+0x4102d48>
106283218: aa1603e0    	mov	x0, x22
10628321c: 94668fce    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283220: aa1503e0    	mov	x0, x21
106283224: 94668fcc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283228: aa1403e0    	mov	x0, x20
10628322c: 94668fca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283230: aa1a03e0    	mov	x0, x26
106283234: 94668fc8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283238: aa1703e0    	mov	x0, x23
10628323c: 94668fc6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283240: aa1303e0    	mov	x0, x19
106283244: a9487bfd    	ldp	x29, x30, [sp, #0x80]
106283248: a9474ff4    	ldp	x20, x19, [sp, #0x70]
10628324c: a94657f6    	ldp	x22, x21, [sp, #0x60]
106283250: a9455ff8    	ldp	x24, x23, [sp, #0x50]
106283254: a94467fa    	ldp	x26, x25, [sp, #0x40]
106283258: a9436ffc    	ldp	x28, x27, [sp, #0x30]
10628325c: 910243ff    	add	sp, sp, #0x90
106283260: 14668fbd    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283264: aa1303e0    	mov	x0, x19
106283268: aa1703e1    	mov	x1, x23
10628326c: 94668fb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283270: aa1d03fd    	mov	x29, x29
106283274: 94668fb5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106283278: aa0003f5    	mov	x21, x0
10628327c: 900cea88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106283280: f9472901    	ldr	x1, [x8, #0xe50] ; translateVoice
106283284: 94668fae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106283288: aa1503e0    	mov	x0, x21
10628328c: 94668fb2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283290: f945eb60    	ldr	x0, [x27, #0xbd0] ; ��d 
106283294: aa1403e1    	mov	x1, x20
106283298: 94668fa9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10628329c: aa1d03fd    	mov	x29, x29
1062832a0: 94668faa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1062832a4: aa0003f4    	mov	x20, x0
1062832a8: b00cf768    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
1062832ac: f9468102    	ldr	x2, [x8, #0xd00]
1062832b0: 900cea88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
1062832b4: f9472d03    	ldr	x3, [x8, #0xe58] ; OnVoiceTranslateStart:
1062832b8: f00b9b48    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
1062832bc: f947e108    	ldr	x8, [x8, #0xfc0]
1062832c0: f90007e8    	str	x8, [sp, #0x8]
1062832c4: d00957e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1062832c8: fd41c100    	ldr	d0, [x8, #0x380]
1062832cc: 90000008    	adrp	x8, 0x106283000 <_Flutter_MMFoundation_BindContext+0x275ebe4>
1062832d0: 910c8108    	add	x8, x8, #0x320
1062832d4: f00b9b89    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1062832d8: 91238129    	add	x9, x9, #0x8e0
1062832dc: fd000be0    	str	d0, [sp, #0x10]
1062832e0: a901a7e8    	stp	x8, x9, [sp, #0x18]
1062832e4: f90017f3    	str	x19, [sp, #0x28]
1062832e8: f00cdda8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1062832ec: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
1062832f0: 910023e4    	add	x4, sp, #0x8
1062832f4: 94668f92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062832f8: aa1403e0    	mov	x0, x20
1062832fc: 94668f96    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106283300: a9487bfd    	ldp	x29, x30, [sp, #0x80]
106283304: a9474ff4    	ldp	x20, x19, [sp, #0x70]
106283308: a94657f6    	ldp	x22, x21, [sp, #0x60]
10628330c: a9455ff8    	ldp	x24, x23, [sp, #0x50]
106283310: a94467fa    	ldp	x26, x25, [sp, #0x40]
106283314: a9436ffc    	ldp	x28, x27, [sp, #0x30]
106283318: 910243ff    	add	sp, sp, #0x90
10628331c: d65f03c0    	ret