
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116756564: d10203ff    	sub	sp, sp, #0x80
116756568: 6d0423e9    	stp	d9, d8, [sp, #0x40]
11675656c: a90557f6    	stp	x22, x21, [sp, #0x50]
116756570: a9064ff4    	stp	x20, x19, [sp, #0x60]
116756574: a9077bfd    	stp	x29, x30, [sp, #0x70]
116756578: 9101c3fd    	add	x29, sp, #0x70
11675657c: aa0003f3    	mov	x19, x0
116756580: 9004d435    	adrp	x21, 0x1201da000 <dyld_stub_binder+0x1201da000>
116756584: f94626a8    	ldr	x8, [x21, #0xc48]
116756588: a90323e0    	stp	x0, x8, [sp, #0x30]
11675658c: 9004b748    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
116756590: f940a901    	ldr	x1, [x8, #0x150] ; selector layoutSubviews
116756594: 9100c3e0    	add	x0, sp, #0x30
116756598: 946f4dd8    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
11675659c: f94626a8    	ldr	x8, [x21, #0xc48]
1167565a0: a90223f3    	stp	x19, x8, [sp, #0x20]
1167565a4: b004cd48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1167565a8: f943d501    	ldr	x1, [x8, #0x7a8] ; selector bounds
1167565ac: 910083e0    	add	x0, sp, #0x20
1167565b0: 946f4dd2    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1167565b4: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167565b8: b9875516    	ldrsw	x22, [x8, #0x754] ; ivar-offset MMBaseMultiMenuTableViewCell._actualContentView
1167565bc: f8766a60    	ldr	x0, [x19, x22]
1167565c0: d004cd88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
1167565c4: f9403501    	ldr	x1, [x8, #0x68] ; selector setFrame:
1167565c8: 946f4dc9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167565cc: f94626a8    	ldr	x8, [x21, #0xc48]
1167565d0: a90123f3    	stp	x19, x8, [sp, #0x10]
1167565d4: d004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1167565d8: f9427501    	ldr	x1, [x8, #0x4e8] ; selector contentView
1167565dc: 910043e0    	add	x0, sp, #0x10
1167565e0: 946f4dc6    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1167565e4: aa1d03fd    	mov	x29, x29
1167565e8: 946f4deb    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167565ec: aa0003f4    	mov	x20, x0
1167565f0: f8766a62    	ldr	x2, [x19, x22]
1167565f4: 9004cd48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
1167565f8: f9476d01    	ldr	x1, [x8, #0xed8] ; selector addSubview:
1167565fc: 946f4dbc    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756600: aa1403e0    	mov	x0, x20
116756604: 946f4dd5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756608: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
11675660c: f9470d01    	ldr	x1, [x8, #0xe18] ; selector updateCopyedBackgroundView
116756610: aa1303e0    	mov	x0, x19
116756614: 946f4db6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756618: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
11675661c: b9874908    	ldrsw	x8, [x8, #0x748] ; ivar-offset MMBaseMultiMenuTableViewCell._arrMenuItems
116756620: f8686a68    	ldr	x8, [x19, x8]
116756624: b4000408    	cbz	x8, 0x1167566a4 <_O266DecReleaseOutputPicture+0x34c9bec>
116756628: b004b9a8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
11675662c: f9447d01    	ldr	x1, [x8, #0x8f8] ; selector contextMenuEnabled
116756630: aa1303e0    	mov	x0, x19
116756634: 946f4dae    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756638: 34000360    	cbz	w0, 0x1167566a4 <_O266DecReleaseOutputPicture+0x34c9bec>
11675663c: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116756640: f9470101    	ldr	x1, [x8, #0xe00] ; selector checkAndAddDeleteItem
116756644: aa1303e0    	mov	x0, x19
116756648: 946f4da9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675664c: f94626a8    	ldr	x8, [x21, #0xc48]
116756650: a90023f3    	stp	x19, x8, [sp]
116756654: b004cda8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116756658: f947a514    	ldr	x20, [x8, #0xf48] ; selector width
11675665c: 910003e0    	mov	x0, sp
116756660: aa1403e1    	mov	x1, x20
116756664: 946f4da5    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116756668: 1e604008    	fmov	d8, d0
11675666c: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756670: b9874d15    	ldrsw	x21, [x8, #0x74c] ; ivar-offset MMBaseMultiMenuTableViewCell._menuContentView
116756674: f8756a60    	ldr	x0, [x19, x21]
116756678: aa1403e1    	mov	x1, x20
11675667c: 946f4d9c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756680: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756684: b9876908    	ldrsw	x8, [x8, #0x768] ; ivar-offset MMBaseMultiMenuTableViewCell._menuContentLeftMargin
116756688: fc686a61    	ldr	d1, [x19, x8]
11675668c: 1e603900    	fsub	d0, d8, d0
116756690: 1e613800    	fsub	d0, d0, d1
116756694: f8756a60    	ldr	x0, [x19, x21]
116756698: 9004cda8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
11675669c: f941cd01    	ldr	x1, [x8, #0x398] ; selector setX:
1167566a0: 946f4d93    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167566a4: a9477bfd    	ldp	x29, x30, [sp, #0x70]
1167566a8: a9464ff4    	ldp	x20, x19, [sp, #0x60]
1167566ac: a94557f6    	ldp	x22, x21, [sp, #0x50]
1167566b0: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
1167566b4: 910203ff    	add	sp, sp, #0x80
1167566b8: d65f03c0    	ret
