
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105180ff8: d10183ff    	sub	sp, sp, #0x60
105180ffc: a90167fa    	stp	x26, x25, [sp, #0x10]
105181000: a9025ff8    	stp	x24, x23, [sp, #0x20]
105181004: a90357f6    	stp	x22, x21, [sp, #0x30]
105181008: a9044ff4    	stp	x20, x19, [sp, #0x40]
10518100c: a9057bfd    	stp	x29, x30, [sp, #0x50]
105181010: 910143fd    	add	x29, sp, #0x50
105181014: d00dd5e8    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
105181018: 52800029    	mov	w9, #0x1                ; =1
10518101c: 39336109    	strb	w9, [x8, #0xcd8]
105181020: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181024: f9464900    	ldr	x0, [x8, #0xc90]
105181028: b00d65e8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10518102c: f9405101    	ldr	x1, [x8, #0xa0]
105181030: 94aa9843    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181034: 34001220    	cbz	w0, 0x105181278 <_Flutter_MMFoundation_BindContext+0x165ce5c>
105181038: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10518103c: f9453500    	ldr	x0, [x8, #0xa68]
105181040: 900d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105181044: f942a901    	ldr	x1, [x8, #0x550]
105181048: d00cb2a8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10518104c: 9134a108    	add	x8, x8, #0xd28
105181050: f90003e8    	str	x8, [sp]
105181054: f00b0ee3    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
105181058: 91270063    	add	x3, x3, #0x9c0
10518105c: b00b36e5    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181060: 912b00a5    	add	x5, x5, #0xac0
105181064: b00b36e7    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
105181068: 912d88e7    	add	x7, x7, #0xb62
10518106c: 52800042    	mov	w2, #0x2                ; =2
105181070: 52800004    	mov	w4, #0x0                ; =0
105181074: 52801a86    	mov	w6, #0xd4               ; =212
105181078: 94aa9831    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518107c: f00d8088    	adrp	x8, 0x120194000 <dyld_stub_binder+0x120194000>
105181080: f9440500    	ldr	x0, [x8, #0x808]
105181084: 94aa9835    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105181088: aa0003f3    	mov	x19, x0
10518108c: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105181090: f9467900    	ldr	x0, [x8, #0xcf0]
105181094: b00d7be8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
105181098: f9439901    	ldr	x1, [x8, #0x730]
10518109c: 94aa9828    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051810a0: aa0003e2    	mov	x2, x0
1051810a4: d00d7c28    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
1051810a8: f942dd01    	ldr	x1, [x8, #0x5b8]
1051810ac: aa1303e0    	mov	x0, x19
1051810b0: 94aa9823    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051810b4: f00d8068    	adrp	x8, 0x120190000 <dyld_stub_binder+0x120190000>
1051810b8: f9477100    	ldr	x0, [x8, #0xee0]
1051810bc: f00d6f88    	adrp	x8, 0x11ff74000 <dyld_stub_binder+0x11ff74000>
1051810c0: f9408101    	ldr	x1, [x8, #0x100]
1051810c4: 94aa981e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051810c8: aa0003e2    	mov	x2, x0
1051810cc: b00d6608    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1051810d0: f9473501    	ldr	x1, [x8, #0xe68]
1051810d4: aa1303e0    	mov	x0, x19
1051810d8: 94aa9819    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051810dc: d00d7f9a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
1051810e0: f945eb40    	ldr	x0, [x26, #0xbd0]
1051810e4: f00d7be8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1051810e8: f944e914    	ldr	x20, [x8, #0x9d0]
1051810ec: aa1403e1    	mov	x1, x20
1051810f0: 94aa9813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051810f4: aa1d03fd    	mov	x29, x29
1051810f8: 94aa9814    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051810fc: aa0003f7    	mov	x23, x0
105181100: f00d7f88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
105181104: f9420900    	ldr	x0, [x8, #0x410]
105181108: d00d7be8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10518110c: f947ad15    	ldr	x21, [x8, #0xf58]
105181110: aa1503e1    	mov	x1, x21
105181114: 94aa980a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181118: aa0003e2    	mov	x2, x0
10518111c: 900d65c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105181120: f9464116    	ldr	x22, [x8, #0xc80]
105181124: aa1703e0    	mov	x0, x23
105181128: aa1603e1    	mov	x1, x22
10518112c: 94aa9804    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181130: aa1d03fd    	mov	x29, x29
105181134: 94aa9805    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181138: aa0003f8    	mov	x24, x0
10518113c: d00d6608    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
105181140: f9400d01    	ldr	x1, [x8, #0x18]
105181144: 94aa97fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181148: aa0003e2    	mov	x2, x0
10518114c: f00d7c28    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
105181150: f947a901    	ldr	x1, [x8, #0xf50]
105181154: aa1303e0    	mov	x0, x19
105181158: 94aa97f9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10518115c: aa1803e0    	mov	x0, x24
105181160: 94aa97fd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181164: aa1703e0    	mov	x0, x23
105181168: 94aa97fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10518116c: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
105181170: f942a501    	ldr	x1, [x8, #0x548]
105181174: aa1303e0    	mov	x0, x19
105181178: 52800062    	mov	w2, #0x3                ; =3
10518117c: 94aa97f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181180: b00d65c8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
105181184: f9439d01    	ldr	x1, [x8, #0x738]
105181188: aa1303e0    	mov	x0, x19
10518118c: 94aa97ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181190: aa1d03fd    	mov	x29, x29
105181194: 94aa97ed    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181198: aa0003f7    	mov	x23, x0
10518119c: b00d7fe8    	adrp	x8, 0x12017e000 <dyld_stub_binder+0x12017e000>
1051811a0: f9469100    	ldr	x0, [x8, #0xd20]
1051811a4: 94aa97ed    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
1051811a8: aa0003f8    	mov	x24, x0
1051811ac: 52800300    	mov	w0, #0x18               ; =24
1051811b0: 94aa97f3    	bl	0x107c2717c <_Flutter_MMFoundation_BindContext+0x4102d60>
1051811b4: aa0003f9    	mov	x25, x0
1051811b8: aa1703e1    	mov	x1, x23
1051811bc: 52802702    	mov	w2, #0x138              ; =312
1051811c0: 97fb2631    	bl	0x10504aa84 <_Flutter_MMFoundation_BindContext+0x1526668>
1051811c4: f00d70c8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
1051811c8: f942a901    	ldr	x1, [x8, #0x550]
1051811cc: aa1803e0    	mov	x0, x24
1051811d0: aa1903e2    	mov	x2, x25
1051811d4: 94aa97da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051811d8: f945eb40    	ldr	x0, [x26, #0xbd0]
1051811dc: aa1403e1    	mov	x1, x20
1051811e0: 94aa97d7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051811e4: aa1d03fd    	mov	x29, x29
1051811e8: 94aa97d8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051811ec: aa0003f4    	mov	x20, x0
1051811f0: d00d7f88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051811f4: f9479d00    	ldr	x0, [x8, #0xf38]
1051811f8: aa1503e1    	mov	x1, x21
1051811fc: 94aa97d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181200: aa0003e2    	mov	x2, x0
105181204: aa1403e0    	mov	x0, x20
105181208: aa1603e1    	mov	x1, x22
10518120c: 94aa97cc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181210: aa1d03fd    	mov	x29, x29
105181214: 94aa97cd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105181218: aa0003f5    	mov	x21, x0
10518121c: f00d6908    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
105181220: f946d502    	ldr	x2, [x8, #0xda8]
105181224: 900d7c28    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
105181228: f943e901    	ldr	x1, [x8, #0x7d0]
10518122c: aa1803e3    	mov	x3, x24
105181230: 52800004    	mov	w4, #0x0                ; =0
105181234: 94aa97c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105181238: aa1503e0    	mov	x0, x21
10518123c: 94aa97c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181240: aa1403e0    	mov	x0, x20
105181244: 94aa97c4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181248: aa1803e0    	mov	x0, x24
10518124c: 94aa97c2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181250: aa1303e0    	mov	x0, x19
105181254: 94aa97c0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181258: aa1703e0    	mov	x0, x23
10518125c: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105181260: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105181264: a94357f6    	ldp	x22, x21, [sp, #0x30]
105181268: a9425ff8    	ldp	x24, x23, [sp, #0x20]
10518126c: a94167fa    	ldp	x26, x25, [sp, #0x10]
105181270: 910183ff    	add	sp, sp, #0x60
105181274: 14aa97b8    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105181278: a9457bfd    	ldp	x29, x30, [sp, #0x50]
10518127c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105181280: a94357f6    	ldp	x22, x21, [sp, #0x30]
105181284: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105181288: a94167fa    	ldp	x26, x25, [sp, #0x10]
10518128c: 910183ff    	add	sp, sp, #0x60
105181290: d65f03c0    	ret
