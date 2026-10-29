
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104728f50: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104728f54: a90157f6    	stp	x22, x21, [sp, #0x10]
104728f58: a9024ff4    	stp	x20, x19, [sp, #0x20]
104728f5c: a9037bfd    	stp	x29, x30, [sp, #0x30]
104728f60: 9100c3fd    	add	x29, sp, #0x30
104728f64: aa0003f3    	mov	x19, x0
104728f68: b00e28a8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
104728f6c: 52800029    	mov	w9, #0x1                ; =1
104728f70: 391a3d09    	strb	w9, [x8, #0x68f]
104728f74: f00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104728f78: b98a2108    	ldrsw	x8, [x8, #0xa20]
104728f7c: 38686816    	ldrb	w22, [x0, x8]
104728f80: f00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104728f84: b98a0917    	ldrsw	x23, [x8, #0xa08]
104728f88: f8776800    	ldr	x0, [x0, x23]
104728f8c: d00dc208    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
104728f90: f947e114    	ldr	x20, [x8, #0xfc0] ; selector highlightImage
104728f94: aa1403e1    	mov	x1, x20
104728f98: 94d3f869    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728f9c: aa1d03fd    	mov	x29, x29
104728fa0: 94d3f86a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728fa4: aa0003f5    	mov	x21, x0
104728fa8: 94d3f86b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104728fac: 710006df    	cmp	w22, #0x1
104728fb0: 54000201    	b.ne	0x104728ff0 <_Flutter_MMFoundation_BindContext+0xc04bd4>
104728fb4: b40003f5    	cbz	x21, 0x104729030 <_Flutter_MMFoundation_BindContext+0xc04c14>
104728fb8: f8776a60    	ldr	x0, [x19, x23]
104728fbc: aa1403e1    	mov	x1, x20
104728fc0: 94d3f85f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728fc4: aa1d03fd    	mov	x29, x29
104728fc8: 94d3f860    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104728fcc: aa0003f4    	mov	x20, x0
104728fd0: f00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104728fd4: b98a2508    	ldrsw	x8, [x8, #0xa24]
104728fd8: f8686a60    	ldr	x0, [x19, x8]
104728fdc: 900dcf08    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104728fe0: f9417901    	ldr	x1, [x8, #0x2f0] ; selector setImage:
104728fe4: aa1403e2    	mov	x2, x20
104728fe8: 94d3f855    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104728fec: 1400002a    	b	0x104729094 <_Flutter_MMFoundation_BindContext+0xc04c78>
104728ff0: b4000735    	cbz	x21, 0x1047290d4 <_Flutter_MMFoundation_BindContext+0xc04cb8>
104728ff4: f8776a60    	ldr	x0, [x19, x23]
104728ff8: f00db9a8    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
104728ffc: f942d501    	ldr	x1, [x8, #0x5a8] ; selector normalImage
104729000: 94d3f84f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104729004: aa1d03fd    	mov	x29, x29
104729008: 94d3f850    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472900c: aa0003f4    	mov	x20, x0
104729010: d00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104729014: b98a2508    	ldrsw	x8, [x8, #0xa24]
104729018: f8686a60    	ldr	x0, [x19, x8]
10472901c: f00dcee8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
104729020: f9417901    	ldr	x1, [x8, #0x2f0] ; selector setImage:
104729024: aa1403e2    	mov	x2, x20
104729028: 94d3f845    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472902c: 14000043    	b	0x104729138 <_Flutter_MMFoundation_BindContext+0xc04d1c>
104729030: d00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104729034: b98a2508    	ldrsw	x8, [x8, #0xa24]
104729038: f8686a75    	ldr	x21, [x19, x8]
10472903c: f8776a60    	ldr	x0, [x19, x23]
104729040: 900dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104729044: f946a101    	ldr	x1, [x8, #0xd40] ; selector highlightImageUrl
104729048: 94d3f83d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472904c: aa1d03fd    	mov	x29, x29
104729050: 94d3f83e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104729054: aa0003f4    	mov	x20, x0
104729058: f8776a60    	ldr	x0, [x19, x23]
10472905c: 900dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104729060: f946a501    	ldr	x1, [x8, #0xd48] ; selector highlightImageDarkUrl
104729064: 94d3f836    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104729068: aa1d03fd    	mov	x29, x29
10472906c: 94d3f837    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104729070: aa0003f6    	mov	x22, x0
104729074: d00db8e8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
104729078: f9423501    	ldr	x1, [x8, #0x468] ; selector setLightImageURL:darkImageURL:
10472907c: aa1503e0    	mov	x0, x21
104729080: aa1403e2    	mov	x2, x20
104729084: aa1603e3    	mov	x3, x22
104729088: 94d3f82d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472908c: aa1603e0    	mov	x0, x22
104729090: 94d3f831    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104729094: aa1403e0    	mov	x0, x20
104729098: 94d3f82f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10472909c: f8776a60    	ldr	x0, [x19, x23]
1047290a0: d00dbce8    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
1047290a4: f9445515    	ldr	x21, [x8, #0x8a8] ; selector selectedTitleColor
1047290a8: aa1503e1    	mov	x1, x21
1047290ac: 94d3f824    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047290b0: aa1d03fd    	mov	x29, x29
1047290b4: 94d3f825    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047290b8: aa0003f4    	mov	x20, x0
1047290bc: b5000540    	cbnz	x0, 0x104729164 <_Flutter_MMFoundation_BindContext+0xc04d48>
1047290c0: d00dd248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047290c4: f9462d00    	ldr	x0, [x8, #0xc58] ; class WCColor
1047290c8: f00db888    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1047290cc: f9405901    	ldr	x1, [x8, #0xb0] ; selector Brand_100
1047290d0: 1400002c    	b	0x104729180 <_Flutter_MMFoundation_BindContext+0xc04d64>
1047290d4: d00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
1047290d8: b98a2508    	ldrsw	x8, [x8, #0xa24]
1047290dc: f8686a75    	ldr	x21, [x19, x8]
1047290e0: f8776a60    	ldr	x0, [x19, x23]
1047290e4: 900dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
1047290e8: f946a901    	ldr	x1, [x8, #0xd50] ; selector normalImageUrl
1047290ec: 94d3f814    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047290f0: aa1d03fd    	mov	x29, x29
1047290f4: 94d3f815    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047290f8: aa0003f4    	mov	x20, x0
1047290fc: f8776a60    	ldr	x0, [x19, x23]
104729100: 900dc268    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
104729104: f946ad01    	ldr	x1, [x8, #0xd58] ; selector normalImageDarkUrl
104729108: 94d3f80d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10472910c: aa1d03fd    	mov	x29, x29
104729110: 94d3f80e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104729114: aa0003f6    	mov	x22, x0
104729118: d00db8e8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
10472911c: f9423501    	ldr	x1, [x8, #0x468] ; selector setLightImageURL:darkImageURL:
104729120: aa1503e0    	mov	x0, x21
104729124: aa1403e2    	mov	x2, x20
104729128: aa1603e3    	mov	x3, x22
10472912c: 94d3f804    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104729130: aa1603e0    	mov	x0, x22
104729134: 94d3f808    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104729138: aa1403e0    	mov	x0, x20
10472913c: 94d3f806    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104729140: f8776a60    	ldr	x0, [x19, x23]
104729144: b00dc208    	adrp	x8, 0x11ff6a000 <dyld_stub_binder+0x11ff6a000>
104729148: f947ed15    	ldr	x21, [x8, #0xfd8] ; selector normalTitleColor
10472914c: aa1503e1    	mov	x1, x21
104729150: 94d3f7fb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104729154: aa1d03fd    	mov	x29, x29
104729158: 94d3f7fc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472915c: aa0003f4    	mov	x20, x0
104729160: b4000080    	cbz	x0, 0x104729170 <_Flutter_MMFoundation_BindContext+0xc04d54>
104729164: f8776a60    	ldr	x0, [x19, x23]
104729168: aa1503e1    	mov	x1, x21
10472916c: 14000005    	b	0x104729180 <_Flutter_MMFoundation_BindContext+0xc04d64>
104729170: d00dd248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104729174: f9462d00    	ldr	x0, [x8, #0xc58] ; class WCColor
104729178: d00dcec8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10472917c: f9462901    	ldr	x1, [x8, #0xc50] ; selector labelColor
104729180: 94d3f7ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104729184: aa1d03fd    	mov	x29, x29
104729188: 94d3f7f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10472918c: aa0003f5    	mov	x21, x0
104729190: d00dd7a8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104729194: b98a0d08    	ldrsw	x8, [x8, #0xa0c]
104729198: f8686a60    	ldr	x0, [x19, x8]
10472919c: 900dcf08    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1047291a0: f9469501    	ldr	x1, [x8, #0xd28] ; selector setTextColor:
1047291a4: aa1503e2    	mov	x2, x21
1047291a8: 94d3f7e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047291ac: aa1503e0    	mov	x0, x21
1047291b0: 94d3f7e9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047291b4: aa1403e0    	mov	x0, x20
1047291b8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1047291bc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1047291c0: a94157f6    	ldp	x22, x21, [sp, #0x10]
1047291c4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1047291c8: 14d3f7e3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
