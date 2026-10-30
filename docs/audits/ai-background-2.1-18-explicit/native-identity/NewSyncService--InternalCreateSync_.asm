
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1051818bc: d10103ff    	sub	sp, sp, #0x40
1051818c0: a90157f6    	stp	x22, x21, [sp, #0x10]
1051818c4: a9024ff4    	stp	x20, x19, [sp, #0x20]
1051818c8: a9037bfd    	stp	x29, x30, [sp, #0x30]
1051818cc: 9100c3fd    	add	x29, sp, #0x30
1051818d0: aa0203f4    	mov	x20, x2
1051818d4: aa0003f3    	mov	x19, x0
1051818d8: d00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
1051818dc: 52800029    	mov	w9, #0x1                ; =1
1051818e0: 39336909    	strb	w9, [x8, #0xcda]
1051818e4: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
1051818e8: b9891908    	ldrsw	x8, [x8, #0x918]
1051818ec: 38686808    	ldrb	w8, [x0, x8]
1051818f0: 7100051f    	cmp	w8, #0x1
1051818f4: 540000e1    	b.ne	0x105181910 <_Flutter_MMFoundation_BindContext+0x165d4f4>
1051818f8: d00d7008    	adrp	x8, 0x11ff83000 <dyld_stub_binder+0x11ff83000>
1051818fc: f947b501    	ldr	x1, [x8, #0xf68]
105181900: aa1303e0    	mov	x0, x19
105181904: aa1403e2    	mov	x2, x20
105181908: 94aa960d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518190c: 14000065    	b	0x105181aa0 <_Flutter_MMFoundation_BindContext+0x165d684>
105181910: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181914: f9471100    	ldr	x0, [x8, #0xe20]
105181918: b00d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10518191c: f946f101    	ldr	x1, [x8, #0xde0]
105181920: 94aa9607    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181924: aa1d03fd    	mov	x29, x29
105181928: 94aa9608    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10518192c: aa0003f5    	mov	x21, x0
105181930: b00d6868    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
105181934: f944d101    	ldr	x1, [x8, #0x9a0]
105181938: 94aa9601    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518193c: aa0003f6    	mov	x22, x0
105181940: aa1503e0    	mov	x0, x21
105181944: 94aa9604    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181948: 34000576    	cbz	w22, 0x1051819f4 <_Flutter_MMFoundation_BindContext+0x165d5d8>
10518194c: aa1303e0    	mov	x0, x19
105181950: 94aa95fa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
105181954: 94aa961a    	bl	0x107c271bc <_Flutter_MMFoundation_BindContext+0x4102da0>
105181958: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10518195c: b9890d08    	ldrsw	x8, [x8, #0x90c]
105181960: 38686a68    	ldrb	w8, [x19, x8]
105181964: 360006c8    	tbz	w8, #0x0, 0x105181a3c <_Flutter_MMFoundation_BindContext+0x165d620>
105181968: aa1303e0    	mov	x0, x19
10518196c: 94aa9622    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
105181970: aa1303e0    	mov	x0, x19
105181974: 94aa95f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181978: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10518197c: b9891d08    	ldrsw	x8, [x8, #0x91c]
105181980: b8686a68    	ldr	w8, [x19, x8]
105181984: 340009c8    	cbz	w8, 0x105181abc <_Flutter_MMFoundation_BindContext+0x165d6a0>
105181988: 7100329f    	cmp	w20, #0xc
10518198c: 540008a0    	b.eq	0x105181aa0 <_Flutter_MMFoundation_BindContext+0x165d684>
105181990: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105181994: b9890914    	ldrsw	x20, [x8, #0x908]
105181998: 38746a68    	ldrb	w8, [x19, x20]
10518199c: 37000248    	tbnz	w8, #0x0, 0x1051819e4 <_Flutter_MMFoundation_BindContext+0x165d5c8>
1051819a0: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051819a4: f9453500    	ldr	x0, [x8, #0xa68]
1051819a8: 900d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051819ac: f942a901    	ldr	x1, [x8, #0x550]
1051819b0: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
1051819b4: 9137a108    	add	x8, x8, #0xde8
1051819b8: f90003e8    	str	x8, [sp]
1051819bc: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
1051819c0: 91270063    	add	x3, x3, #0x9c0
1051819c4: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051819c8: 912b00a5    	add	x5, x5, #0xac0
1051819cc: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
1051819d0: 913028e7    	add	x7, x7, #0xc0a
1051819d4: 52800042    	mov	w2, #0x2                ; =2
1051819d8: 52800004    	mov	w4, #0x0                ; =0
1051819dc: 52802666    	mov	w6, #0x133              ; =307
1051819e0: 94aa95d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051819e4: 52800008    	mov	w8, #0x0                ; =0
1051819e8: 52800029    	mov	w9, #0x1                ; =1
1051819ec: 38346a69    	strb	w9, [x19, x20]
1051819f0: 1400002d    	b	0x105181aa4 <_Flutter_MMFoundation_BindContext+0x165d688>
1051819f4: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051819f8: f9453500    	ldr	x0, [x8, #0xa68]
1051819fc: 900d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105181a00: f942a901    	ldr	x1, [x8, #0x550]
105181a04: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105181a08: 9136a108    	add	x8, x8, #0xda8
105181a0c: f90003e8    	str	x8, [sp]
105181a10: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105181a14: 91270063    	add	x3, x3, #0x9c0
105181a18: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181a1c: 912b00a5    	add	x5, x5, #0xac0
105181a20: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181a24: 913028e7    	add	x7, x7, #0xc0a
105181a28: 52800062    	mov	w2, #0x3                ; =3
105181a2c: 52800004    	mov	w4, #0x0                ; =0
105181a30: 52802346    	mov	w6, #0x11a              ; =282
105181a34: 94aa95c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181a38: 1400001a    	b	0x105181aa0 <_Flutter_MMFoundation_BindContext+0x165d684>
105181a3c: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181a40: f9453500    	ldr	x0, [x8, #0xa68]
105181a44: 900d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105181a48: f942a901    	ldr	x1, [x8, #0x550]
105181a4c: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
105181a50: 91372108    	add	x8, x8, #0xdc8
105181a54: f90003e8    	str	x8, [sp]
105181a58: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105181a5c: 91270063    	add	x3, x3, #0x9c0
105181a60: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181a64: 912b00a5    	add	x5, x5, #0xac0
105181a68: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181a6c: 913028e7    	add	x7, x7, #0xc0a
105181a70: 52800062    	mov	w2, #0x3                ; =3
105181a74: 52800004    	mov	w4, #0x0                ; =0
105181a78: 52802406    	mov	w6, #0x120              ; =288
105181a7c: 94aa95b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181a80: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105181a84: b9890908    	ldrsw	x8, [x8, #0x908]
105181a88: 52800029    	mov	w9, #0x1                ; =1
105181a8c: 38286a69    	strb	w9, [x19, x8]
105181a90: aa1303e0    	mov	x0, x19
105181a94: 94aa95d8    	bl	0x107c271f4 <_Flutter_MMFoundation_BindContext+0x4102dd8>
105181a98: aa1303e0    	mov	x0, x19
105181a9c: 94aa95ae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181aa0: 52800008    	mov	w8, #0x0                ; =0
105181aa4: 12000100    	and	w0, w8, #0x1
105181aa8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105181aac: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105181ab0: a94157f6    	ldp	x22, x21, [sp, #0x10]
105181ab4: 910103ff    	add	sp, sp, #0x40
105181ab8: d65f03c0    	ret
105181abc: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105181ac0: b9890908    	ldrsw	x8, [x8, #0x908]
105181ac4: 38286a7f    	strb	wzr, [x19, x8]
105181ac8: d00d6608    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105181acc: f9474901    	ldr	x1, [x8, #0xe90]
105181ad0: 52800035    	mov	w21, #0x1               ; =1
105181ad4: aa1303e0    	mov	x0, x19
105181ad8: 52800022    	mov	w2, #0x1                ; =1
105181adc: 94aa9598    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181ae0: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181ae4: f942bd01    	ldr	x1, [x8, #0x578]
105181ae8: aa1303e0    	mov	x0, x19
105181aec: aa1403e2    	mov	x2, x20
105181af0: 94aa9593    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181af4: 340000a0    	cbz	w0, 0x105181b08 <_Flutter_MMFoundation_BindContext+0x165d6ec>
105181af8: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105181afc: b9894d08    	ldrsw	x8, [x8, #0x94c]
105181b00: 38286a75    	strb	w21, [x19, x8]
105181b04: 14000007    	b	0x105181b20 <_Flutter_MMFoundation_BindContext+0x165d704>
105181b08: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181b0c: f9423101    	ldr	x1, [x8, #0x460]
105181b10: aa1303e0    	mov	x0, x19
105181b14: 94aa958a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181b18: f00d8528    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
105181b1c: b9894d08    	ldrsw	x8, [x8, #0x94c]
105181b20: f00d8529    	adrp	x9, 0x120228000 <dyld_stub_binder+0x120228000>
105181b24: b9892129    	ldrsw	x9, [x9, #0x920]
105181b28: 38296a7f    	strb	wzr, [x19, x9]
105181b2c: 38686a68    	ldrb	w8, [x19, x8]
105181b30: 17ffffdd    	b	0x105181aa4 <_Flutter_MMFoundation_BindContext+0x165d688>
