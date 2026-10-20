
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101062100: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101062104: a9015ff8    	stp	x24, x23, [sp, #0x10]
101062108: a90257f6    	stp	x22, x21, [sp, #0x20]
10106210c: a9034ff4    	stp	x20, x19, [sp, #0x30]
101062110: a9047bfd    	stp	x29, x30, [sp, #0x40]
101062114: 910103fd    	add	x29, sp, #0x40
101062118: aa0303f4    	mov	x20, x3
10106211c: aa0203f3    	mov	x19, x2
101062120: aa0003f5    	mov	x21, x0
101062124: d00fde68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
101062128: 52800029    	mov	w9, #0x1                ; =1
10106212c: 39389109    	strb	w9, [x8, #0xe24]
101062130: aa0203e0    	mov	x0, x2
101062134: 95af1401    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101062138: aa1403e0    	mov	x0, x20
10106213c: 95af13ff    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101062140: 900f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
101062144: b9838508    	ldrsw	x8, [x8, #0x384] ; ivar ContactTagNewDetailViewController._contactsKeyArray
101062148: f8686ab6    	ldr	x22, [x21, x8]
10106214c: d00f6ec8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101062150: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
101062154: 95af13fa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062158: aa0003e2    	mov	x2, x0
10106215c: 900f6ec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101062160: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
101062164: aa1603e0    	mov	x0, x22
101062168: 95af13f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10106216c: aa1d03fd    	mov	x29, x29
101062170: 95af13f6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101062174: aa0003f6    	mov	x22, x0
101062178: 900f8c48    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
10106217c: b9838908    	ldrsw	x8, [x8, #0x388] ; ivar ContactTagNewDetailViewController._contactsDict
101062180: f8686aa0    	ldr	x0, [x21, x8]
101062184: d00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101062188: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
10106218c: aa1603e2    	mov	x2, x22
101062190: 95af13eb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101062194: aa1d03fd    	mov	x29, x29
101062198: 95af13ec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10106219c: aa0003f7    	mov	x23, x0
1010621a0: 900f8528    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1010621a4: f9440918    	ldr	x24, [x8, #0x810] ; row
1010621a8: aa1403e0    	mov	x0, x20
1010621ac: aa1803e1    	mov	x1, x24
1010621b0: 95af13e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010621b4: aa0003f9    	mov	x25, x0
1010621b8: d00f84e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1010621bc: f9435101    	ldr	x1, [x8, #0x6a0] ; count
1010621c0: aa1703e0    	mov	x0, x23
1010621c4: 95af13de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010621c8: eb00033f    	cmp	x25, x0
1010621cc: 540001a2    	b.hs	0x101062200 <__text+0x105a200>
1010621d0: aa1403e0    	mov	x0, x20
1010621d4: aa1803e1    	mov	x1, x24
1010621d8: 95af13d9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010621dc: aa0003e2    	mov	x2, x0
1010621e0: d00f8508    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1010621e4: f947e101    	ldr	x1, [x8, #0xfc0] ; objectAtIndexedSubscript:
1010621e8: aa1703e0    	mov	x0, x23
1010621ec: 95af13d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010621f0: aa1d03fd    	mov	x29, x29
1010621f4: 95af13d5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1010621f8: aa0003f8    	mov	x24, x0
1010621fc: 14000002    	b	0x101062204 <__text+0x105a204>
101062200: d2800018    	mov	x24, #0x0               ; =0
101062204: f00f7128    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
101062208: f9433901    	ldr	x1, [x8, #0x670] ; makeMemberContactCellContent:contact:
10106220c: aa1503e0    	mov	x0, x21
101062210: aa1303e2    	mov	x2, x19
101062214: aa1803e3    	mov	x3, x24
101062218: 95af13c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10106221c: aa1803e0    	mov	x0, x24
101062220: 95af13cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062224: aa1703e0    	mov	x0, x23
101062228: 95af13cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10106222c: aa1603e0    	mov	x0, x22
101062230: 95af13c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101062234: aa1403e0    	mov	x0, x20
101062238: 95af13c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10106223c: aa1303e0    	mov	x0, x19
101062240: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101062244: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101062248: a94257f6    	ldp	x22, x21, [sp, #0x20]
10106224c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101062250: a8c567fa    	ldp	x26, x25, [sp], #0x50
101062254: 15af13c0    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
