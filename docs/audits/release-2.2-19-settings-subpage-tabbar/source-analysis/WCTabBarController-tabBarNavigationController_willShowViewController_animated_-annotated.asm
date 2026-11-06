
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157db3fc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1157db400: a90157f6    	stp	x22, x21, [sp, #0x10]
1157db404: a9024ff4    	stp	x20, x19, [sp, #0x20]
1157db408: a9037bfd    	stp	x29, x30, [sp, #0x30]
1157db40c: 9100c3fd    	add	x29, sp, #0x30
1157db410: aa0403f6    	mov	x22, x4
1157db414: aa0303f4    	mov	x20, x3
1157db418: aa0203f3    	mov	x19, x2
1157db41c: aa0003f5    	mov	x21, x0
1157db420: aa0203e0    	mov	x0, x2
1157db424: 945a046c    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db428: aa1403e0    	mov	x0, x20
1157db42c: 945a046a    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db430: f004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157db434: f945b901    	ldr	x1, [x8, #0xb70] ; selector: selectedViewController
1157db438: aa1503e0    	mov	x0, x21
1157db43c: 945a0442    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db440: aa1d03fd    	mov	x29, x29
1157db444: 945a046d    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db448: aa0003f7    	mov	x23, x0
1157db44c: 945a045c    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db450: eb17027f    	cmp	x19, x23
1157db454: 54000661    	b.ne	0x1157db520 <_O266DecReleaseOutputPicture+0x36cbfb4>
1157db458: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db45c: f9429501    	ldr	x1, [x8, #0x528] ; selector: transitionForNavigationController:destinationViewController:animated:
1157db460: aa1503e0    	mov	x0, x21
1157db464: aa1303e2    	mov	x2, x19
1157db468: aa1403e3    	mov	x3, x20
1157db46c: aa1603e4    	mov	x4, x22
1157db470: 945a0435    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db474: aa1d03fd    	mov	x29, x29
1157db478: 945a0460    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db47c: aa0003f6    	mov	x22, x0
1157db480: b40004c0    	cbz	x0, 0x1157db518 <_O266DecReleaseOutputPicture+0x36cbfac>
1157db484: 90049528    	adrp	x8, 0x11ea7f000 <dyld_stub_binder+0x11ea7f000>
1157db488: f9452101    	ldr	x1, [x8, #0xa40] ; selector: coordinator
1157db48c: aa1603e0    	mov	x0, x22
1157db490: 945a042d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db494: aa1d03fd    	mov	x29, x29
1157db498: 945a0458    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db49c: aa0003f7    	mov	x23, x0
1157db4a0: 945a0447    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db4a4: b40002f7    	cbz	x23, 0x1157db500 <_O266DecReleaseOutputPicture+0x36cbf94>
1157db4a8: d004a668    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1157db4ac: f9470917    	ldr	x23, [x8, #0xe10] ; selector: phase
1157db4b0: aa1603e0    	mov	x0, x22
1157db4b4: aa1703e1    	mov	x1, x23
1157db4b8: 945a0423    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db4bc: b50000c0    	cbnz	x0, 0x1157db4d4 <_O266DecReleaseOutputPicture+0x36cbf68>
1157db4c0: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db4c4: f9429101    	ldr	x1, [x8, #0x520] ; selector: prepareTabBarForTransition:
1157db4c8: aa1503e0    	mov	x0, x21
1157db4cc: aa1603e2    	mov	x2, x22
1157db4d0: 945a041d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db4d4: aa1603e0    	mov	x0, x22
1157db4d8: aa1703e1    	mov	x1, x23
1157db4dc: 945a041a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db4e0: f100041f    	cmp	x0, #0x1
1157db4e4: 540001a1    	b.ne	0x1157db518 <_O266DecReleaseOutputPicture+0x36cbfac>
1157db4e8: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db4ec: f9429901    	ldr	x1, [x8, #0x530] ; selector: beginTabBarTransition:
1157db4f0: aa1503e0    	mov	x0, x21
1157db4f4: aa1603e2    	mov	x2, x22
1157db4f8: 945a0413    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db4fc: 14000007    	b	0x1157db518 <_O266DecReleaseOutputPicture+0x36cbfac>
1157db500: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db504: f9428101    	ldr	x1, [x8, #0x500] ; selector: finishTabBarTransition:cancelled:
1157db508: aa1503e0    	mov	x0, x21
1157db50c: aa1603e2    	mov	x2, x22
1157db510: 52800003    	mov	w3, #0x0                ; =0
1157db514: 945a040c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db518: aa1603e0    	mov	x0, x22
1157db51c: 945a0428    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db520: aa1403e0    	mov	x0, x20
1157db524: 945a0426    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db528: aa1303e0    	mov	x0, x19
1157db52c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1157db530: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1157db534: a94157f6    	ldp	x22, x21, [sp, #0x10]
1157db538: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1157db53c: 145a0420    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
