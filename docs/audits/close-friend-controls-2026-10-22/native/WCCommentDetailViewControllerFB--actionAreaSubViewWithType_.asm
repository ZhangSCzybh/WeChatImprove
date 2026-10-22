
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e8817c: a9bf7bfd    	stp	x29, x30, [sp, #-0x10]!
106e88180: 910003fd    	mov	x29, sp
106e88184: aa0003e8    	mov	x8, x0
106e88188: d2800000    	mov	x0, #0x0                ; =0
106e8818c: d00cede9    	adrp	x9, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e88190: 5280002a    	mov	w10, #0x1               ; =1
106e88194: 391a6d2a    	strb	w10, [x9, #0x69b]
106e88198: f1000c5f    	cmp	x2, #0x3
106e8819c: 5400014d    	b.le	0x106e881c4 <_Flutter_MMFoundation_BindContext+0x3363da8>
106e881a0: f100145f    	cmp	x2, #0x5
106e881a4: 5400022c    	b.gt	0x106e881e8 <_Flutter_MMFoundation_BindContext+0x3363dcc>
106e881a8: f100105f    	cmp	x2, #0x4
106e881ac: 54000320    	b.eq	0x106e88210 <_Flutter_MMFoundation_BindContext+0x3363df4>
106e881b0: f100145f    	cmp	x2, #0x5
106e881b4: 540004a1    	b.ne	0x106e88248 <_Flutter_MMFoundation_BindContext+0x3363e2c>
106e881b8: b00c9de9    	adrp	x9, 0x120245000 <dyld_stub_binder+0x120245000>
106e881bc: b9857129    	ldrsw	x9, [x9, #0x570]
106e881c0: 14000019    	b	0x106e88224 <_Flutter_MMFoundation_BindContext+0x3363e08>
106e881c4: f100045f    	cmp	x2, #0x1
106e881c8: 540001e0    	b.eq	0x106e88204 <_Flutter_MMFoundation_BindContext+0x3363de8>
106e881cc: f100085f    	cmp	x2, #0x2
106e881d0: 54000300    	b.eq	0x106e88230 <_Flutter_MMFoundation_BindContext+0x3363e14>
106e881d4: f1000c5f    	cmp	x2, #0x3
106e881d8: 54000381    	b.ne	0x106e88248 <_Flutter_MMFoundation_BindContext+0x3363e2c>
106e881dc: d00c8aa9    	adrp	x9, 0x11ffde000 <dyld_stub_binder+0x11ffde000>
106e881e0: f9445121    	ldr	x1, [x9, #0x8a0] ; weAppView
106e881e4: 14000015    	b	0x106e88238 <_Flutter_MMFoundation_BindContext+0x3363e1c>
106e881e8: f100185f    	cmp	x2, #0x6
106e881ec: 54000180    	b.eq	0x106e8821c <_Flutter_MMFoundation_BindContext+0x3363e00>
106e881f0: f1001c5f    	cmp	x2, #0x7
106e881f4: 540002a1    	b.ne	0x106e88248 <_Flutter_MMFoundation_BindContext+0x3363e2c>
106e881f8: f00c7f29    	adrp	x9, 0x11fe6f000 <dyld_stub_binder+0x11fe6f000>
106e881fc: f9415521    	ldr	x1, [x9, #0x2a8] ; locationLabel
106e88200: 1400000e    	b	0x106e88238 <_Flutter_MMFoundation_BindContext+0x3363e1c>
106e88204: b00c9de9    	adrp	x9, 0x120245000 <dyld_stub_binder+0x120245000>
106e88208: b9851129    	ldrsw	x9, [x9, #0x510]
106e8820c: 14000006    	b	0x106e88224 <_Flutter_MMFoundation_BindContext+0x3363e08>
106e88210: d00c8ba9    	adrp	x9, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e88214: f9434521    	ldr	x1, [x9, #0x688] ; starIconButton
106e88218: 14000008    	b	0x106e88238 <_Flutter_MMFoundation_BindContext+0x3363e1c>
106e8821c: b00c9de9    	adrp	x9, 0x120245000 <dyld_stub_binder+0x120245000>
106e88220: b9852529    	ldrsw	x9, [x9, #0x524]
106e88224: f8696900    	ldr	x0, [x8, x9]
106e88228: 94367bc4    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e8822c: 14000007    	b	0x106e88248 <_Flutter_MMFoundation_BindContext+0x3363e2c>
106e88230: b00c7dc9    	adrp	x9, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
106e88234: f9414d21    	ldr	x1, [x9, #0x298] ; sourceLabel
106e88238: aa0803e0    	mov	x0, x8
106e8823c: 94367bc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e88240: aa1d03fd    	mov	x29, x29
106e88244: 94367bc1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e88248: a8c17bfd    	ldp	x29, x30, [sp], #0x10
106e8824c: 14367bc9    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
