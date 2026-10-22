
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106ad53e8: d10103ff    	sub	sp, sp, #0x40
106ad53ec: a90157f6    	stp	x22, x21, [sp, #0x10]
106ad53f0: a9024ff4    	stp	x20, x19, [sp, #0x20]
106ad53f4: a9037bfd    	stp	x29, x30, [sp, #0x30]
106ad53f8: 9100c3fd    	add	x29, sp, #0x30
106ad53fc: aa0003f3    	mov	x19, x0
106ad5400: 900d0b88    	adrp	x8, 0x120c45000 <dyld_stub_binder+0x120c45000>
106ad5404: 52800029    	mov	w9, #0x1                ; =1
106ad5408: 3921f909    	strb	w9, [x8, #0x87e]
106ad540c: b00cb7a8    	adrp	x8, 0x1201ca000 <dyld_stub_binder+0x1201ca000>
106ad5410: f9474908    	ldr	x8, [x8, #0xe90]
106ad5414: a90023e0    	stp	x0, x8, [sp]
106ad5418: b00c9b48    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
106ad541c: f9410d01    	ldr	x1, [x8, #0x218] ; prepareForReuse
106ad5420: 910003e0    	mov	x0, sp
106ad5424: 94454748    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
106ad5428: b00c9d48    	adrp	x8, 0x11fe7e000 <dyld_stub_binder+0x11fe7e000>
106ad542c: f947bd01    	ldr	x1, [x8, #0xf78] ; thumbImageView
106ad5430: aa1303e0    	mov	x0, x19
106ad5434: 94454742    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5438: aa1d03fd    	mov	x29, x29
106ad543c: 94454743    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5440: aa0003f4    	mov	x20, x0
106ad5444: f00cb188    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
106ad5448: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
106ad544c: 52800022    	mov	w2, #0x1                ; =1
106ad5450: 9445473b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5454: aa1403e0    	mov	x0, x20
106ad5458: 9445473f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad545c: f00c9b88    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
106ad5460: f9407d14    	ldr	x20, [x8, #0xf8] ; nameLabel
106ad5464: aa1303e0    	mov	x0, x19
106ad5468: aa1403e1    	mov	x1, x20
106ad546c: 94454734    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5470: aa1d03fd    	mov	x29, x29
106ad5474: 94454735    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad5478: aa0003f5    	mov	x21, x0
106ad547c: 94454736    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5480: 900cb1b6    	adrp	x22, 0x120109000 <dyld_stub_binder+0x120109000>
106ad5484: b4000195    	cbz	x21, 0x106ad54b4 <_Flutter_MMFoundation_BindContext+0x2fb1098>
106ad5488: aa1303e0    	mov	x0, x19
106ad548c: aa1403e1    	mov	x1, x20
106ad5490: 9445472b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5494: aa1d03fd    	mov	x29, x29
106ad5498: 9445472c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad549c: aa0003f4    	mov	x20, x0
106ad54a0: f9468ec1    	ldr	x1, [x22, #0xd18] ; setText:
106ad54a4: d2800002    	mov	x2, #0x0                ; =0
106ad54a8: 94454725    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad54ac: aa1403e0    	mov	x0, x20
106ad54b0: 94454729    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad54b4: d00c9b48    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
106ad54b8: f9442914    	ldr	x20, [x8, #0x850] ; sizeLabel
106ad54bc: aa1303e0    	mov	x0, x19
106ad54c0: aa1403e1    	mov	x1, x20
106ad54c4: 9445471e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad54c8: aa1d03fd    	mov	x29, x29
106ad54cc: 9445471f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad54d0: aa0003f5    	mov	x21, x0
106ad54d4: 94454720    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad54d8: b4000195    	cbz	x21, 0x106ad5508 <_Flutter_MMFoundation_BindContext+0x2fb10ec>
106ad54dc: aa1303e0    	mov	x0, x19
106ad54e0: aa1403e1    	mov	x1, x20
106ad54e4: 94454716    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad54e8: aa1d03fd    	mov	x29, x29
106ad54ec: 94454717    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106ad54f0: aa0003f3    	mov	x19, x0
106ad54f4: f9468ec1    	ldr	x1, [x22, #0xd18] ; setText:
106ad54f8: d2800002    	mov	x2, #0x0                ; =0
106ad54fc: 94454710    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106ad5500: aa1303e0    	mov	x0, x19
106ad5504: 94454714    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106ad5508: a9437bfd    	ldp	x29, x30, [sp, #0x30]
106ad550c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
106ad5510: a94157f6    	ldp	x22, x21, [sp, #0x10]
106ad5514: 910103ff    	add	sp, sp, #0x40
106ad5518: d65f03c0    	ret
