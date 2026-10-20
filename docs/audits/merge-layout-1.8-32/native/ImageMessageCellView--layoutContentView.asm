
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101f773dc: d102c3ff    	sub	sp, sp, #0xb0
101f773e0: 6d0423e9    	stp	d9, d8, [sp, #0x40]
101f773e4: a9056ffc    	stp	x28, x27, [sp, #0x50]
101f773e8: a90667fa    	stp	x26, x25, [sp, #0x60]
101f773ec: a9075ff8    	stp	x24, x23, [sp, #0x70]
101f773f0: a90857f6    	stp	x22, x21, [sp, #0x80]
101f773f4: a9094ff4    	stp	x20, x19, [sp, #0x90]
101f773f8: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
101f773fc: 910283fd    	add	x29, sp, #0xa0
101f77400: aa0003f3    	mov	x19, x0
101f77404: b00f65e8    	adrp	x8, 0x120c34000 <dyld_stub_binder+0x120c34000>
101f77408: 52800029    	mov	w9, #0x1                ; =1
101f7740c: 3918ad09    	strb	w9, [x8, #0x62b]
101f77410: b00ef868    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
101f77414: f945a101    	ldr	x1, [x8, #0xb40] ; initImageView
101f77418: 9572bf49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7741c: 900f1348    	adrp	x8, 0x1201df000 <dyld_stub_binder+0x1201df000>
101f77420: 910a8108    	add	x8, x8, #0x2a0
101f77424: b980011c    	ldrsw	x28, [x8]
101f77428: f87c6a60    	ldr	x0, [x19, x28]
101f7742c: b00f1408    	adrp	x8, 0x1201f8000 <dyld_stub_binder+0x1201f8000>
101f77430: b982f114    	ldrsw	x20, [x8, #0x2f0]
101f77434: f8746a62    	ldr	x2, [x19, x20]
101f77438: f00f0c28    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
101f7743c: f9476d17    	ldr	x23, [x8, #0xed8] ; addSubview:
101f77440: aa1703e1    	mov	x1, x23
101f77444: 9572bf3e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77448: f8746a60    	ldr	x0, [x19, x20]
101f7744c: f00f0c88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
101f77450: f9406901    	ldr	x1, [x8, #0xd0] ; setUserInteractionEnabled:
101f77454: 52800022    	mov	w2, #0x1                ; =1
101f77458: 9572bf39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7745c: b00f1408    	adrp	x8, 0x1201f8000 <dyld_stub_binder+0x1201f8000>
101f77460: b982f518    	ldrsw	x24, [x8, #0x2f4]
101f77464: 38386a7f    	strb	wzr, [x19, x24]
101f77468: f00ef628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101f7746c: f941091b    	ldr	x27, [x8, #0x210] ; viewModel
101f77470: aa1303e0    	mov	x0, x19
101f77474: aa1b03e1    	mov	x1, x27
101f77478: 9572bf31    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7747c: aa1d03fd    	mov	x29, x29
101f77480: 9572bf32    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77484: aa0003f5    	mov	x21, x0
101f77488: 900ef648    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
101f7748c: f940d501    	ldr	x1, [x8, #0x1a8] ; isSender
101f77490: 9572bf2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77494: aa0003f6    	mov	x22, x0
101f77498: aa1503e0    	mov	x0, x21
101f7749c: 9572bf2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f774a0: 900f0ffa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
101f774a4: f9000bfb    	str	x27, [sp, #0x10]
101f774a8: 34000116    	cbz	w22, 0x101f774c8 <_Flutter_Image_provideRelativePathByUrl+0x384378>
101f774ac: b00f0c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101f774b0: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
101f774b4: 900f0c48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101f774b8: f947ad16    	ldr	x22, [x8, #0xf58] ; class
101f774bc: d00ef608    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101f774c0: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
101f774c4: 14000061    	b	0x101f77648 <_Flutter_Image_provideRelativePathByUrl+0x3844f8>
101f774c8: f90007fc    	str	x28, [sp, #0x8]
101f774cc: aa1303e0    	mov	x0, x19
101f774d0: aa1b03e1    	mov	x1, x27
101f774d4: 9572bf1a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f774d8: aa1d03fd    	mov	x29, x29
101f774dc: 9572bf1b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f774e0: aa0003f5    	mov	x21, x0
101f774e4: f00ef688    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
101f774e8: f9438101    	ldr	x1, [x8, #0x700] ; thumbDownloadStatus
101f774ec: 9572bf14    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f774f0: aa0003f6    	mov	x22, x0
101f774f4: aa1503e0    	mov	x0, x21
101f774f8: 9572bf17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f774fc: 71000adf    	cmp	w22, #0x2
101f77500: 54000061    	b.ne	0x101f7750c <_Flutter_Image_provideRelativePathByUrl+0x3843bc>
101f77504: 52800028    	mov	w8, #0x1                ; =1
101f77508: 38386a68    	strb	w8, [x19, x24]
101f7750c: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
101f77510: b00f0c48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101f77514: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
101f77518: aa1503e1    	mov	x1, x21
101f7751c: 9572bf08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77520: aa1d03fd    	mov	x29, x29
101f77524: 9572bf09    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77528: aa0003f9    	mov	x25, x0
101f7752c: f00f0fe8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
101f77530: f942a500    	ldr	x0, [x8, #0x548] ; �A/ 
101f77534: 900f0c48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101f77538: f947ad16    	ldr	x22, [x8, #0xf58] ; class
101f7753c: aa1603e1    	mov	x1, x22
101f77540: 9572beff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77544: aa0003e2    	mov	x2, x0
101f77548: d00ef608    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101f7754c: f9464118    	ldr	x24, [x8, #0xc80] ; getService:
101f77550: aa1903e0    	mov	x0, x25
101f77554: aa1803e1    	mov	x1, x24
101f77558: 9572bef9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7755c: aa1d03fd    	mov	x29, x29
101f77560: 9572befa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77564: aa0003fa    	mov	x26, x0
101f77568: aa1303e0    	mov	x0, x19
101f7756c: aa1b03e1    	mov	x1, x27
101f77570: 9572bef3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77574: aa1d03fd    	mov	x29, x29
101f77578: 9572bef4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f7757c: aa0003fb    	mov	x27, x0
101f77580: f00ef628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101f77584: f9410501    	ldr	x1, [x8, #0x208] ; messageWrap
101f77588: 9572beed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7758c: aa1d03fd    	mov	x29, x29
101f77590: 9572beee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77594: aa0003fc    	mov	x28, x0
101f77598: d00efaa8    	adrp	x8, 0x11fecd000 <dyld_stub_binder+0x11fecd000>
101f7759c: f943dd01    	ldr	x1, [x8, #0x7b8] ; StartAutoDownloadFromChat:
101f775a0: aa1a03e0    	mov	x0, x26
101f775a4: aa1c03e2    	mov	x2, x28
101f775a8: 9572bee5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f775ac: aa1c03e0    	mov	x0, x28
101f775b0: 9572bee9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f775b4: aa1b03e0    	mov	x0, x27
101f775b8: f9400bfb    	ldr	x27, [sp, #0x10]
101f775bc: 9572bee6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f775c0: aa1a03e0    	mov	x0, x26
101f775c4: 900f0ffa    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
101f775c8: 9572bee3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f775cc: aa1903e0    	mov	x0, x25
101f775d0: 9572bee1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f775d4: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
101f775d8: aa1503e1    	mov	x1, x21
101f775dc: 9572bed8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f775e0: aa1d03fd    	mov	x29, x29
101f775e4: 9572bed9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f775e8: aa0003f9    	mov	x25, x0
101f775ec: b00f0fc8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
101f775f0: f9458502    	ldr	x2, [x8, #0xb08]
101f775f4: d00efaa8    	adrp	x8, 0x11fecd000 <dyld_stub_binder+0x11fecd000>
101f775f8: f943e103    	ldr	x3, [x8, #0x7c0] ; onUserDidSeeImage:
101f775fc: f00db3a8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
101f77600: f947e108    	ldr	x8, [x8, #0xfc0]
101f77604: f9000fe8    	str	x8, [sp, #0x18]
101f77608: d00b7048    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101f7760c: fd41c100    	ldr	d0, [x8, #0x380]
101f77610: 90000008    	adrp	x8, 0x101f77000 <_Flutter_Image_provideRelativePathByUrl+0x383eb0>
101f77614: 91263108    	add	x8, x8, #0x98c
101f77618: f00db3e9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
101f7761c: 91238129    	add	x9, x9, #0x8e0
101f77620: fd0013e0    	str	d0, [sp, #0x20]
101f77624: a902a7e8    	stp	x8, x9, [sp, #0x28]
101f77628: f9001ff3    	str	x19, [sp, #0x38]
101f7762c: f00ef608    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
101f77630: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
101f77634: 910063e4    	add	x4, sp, #0x18
101f77638: 9572bec1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7763c: aa1903e0    	mov	x0, x25
101f77640: 9572bec5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77644: f94007fc    	ldr	x28, [sp, #0x8]
101f77648: aa1303e0    	mov	x0, x19
101f7764c: aa1b03e1    	mov	x1, x27
101f77650: 9572bebb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77654: aa1d03fd    	mov	x29, x29
101f77658: 9572bebc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f7765c: aa0003f9    	mov	x25, x0
101f77660: 900ef648    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
101f77664: f9405501    	ldr	x1, [x8, #0xa8] ; downloadThumbImageIfNeed
101f77668: 9572beb5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7766c: aa1903e0    	mov	x0, x25
101f77670: 9572beb9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77674: f00ef628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101f77678: f9412901    	ldr	x1, [x8, #0x250] ; initMaskImageView
101f7767c: aa1303e0    	mov	x0, x19
101f77680: 9572beaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77684: f87c6a60    	ldr	x0, [x19, x28]
101f77688: d00f1388    	adrp	x8, 0x1201e9000 <dyld_stub_binder+0x1201e9000>
101f7768c: 9112a108    	add	x8, x8, #0x4a8
101f77690: b9800108    	ldrsw	x8, [x8]
101f77694: f8686a62    	ldr	x2, [x19, x8]
101f77698: aa1703e1    	mov	x1, x23
101f7769c: 9572bea8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f776a0: f8746a60    	ldr	x0, [x19, x20]
101f776a4: 900f0ca8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
101f776a8: f947a501    	ldr	x1, [x8, #0xf48] ; width
101f776ac: 9572bea4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f776b0: 1e604008    	fmov	d8, d0
101f776b4: f8746a60    	ldr	x0, [x19, x20]
101f776b8: f00f0c48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
101f776bc: f9449d01    	ldr	x1, [x8, #0x938] ; height
101f776c0: 9572be9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f776c4: 1e604001    	fmov	d1, d0
101f776c8: f87c6a60    	ldr	x0, [x19, x28]
101f776cc: d00f0c88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
101f776d0: f9453d01    	ldr	x1, [x8, #0xa78] ; setSize:
101f776d4: 1e604100    	fmov	d0, d8
101f776d8: 9572be99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f776dc: f8746a60    	ldr	x0, [x19, x20]
101f776e0: d00f0c48    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
101f776e4: f945a101    	ldr	x1, [x8, #0xb40] ; frame
101f776e8: 9572be95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f776ec: f00ef628    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101f776f0: f9412501    	ldr	x1, [x8, #0x248] ; setFrameForBgImageView:
101f776f4: aa1303e0    	mov	x0, x19
101f776f8: 9572be91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f776fc: f87c6a60    	ldr	x0, [x19, x28]
101f77700: 900f0c68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101f77704: f9469514    	ldr	x20, [x8, #0xd28] ; layer
101f77708: aa1403e1    	mov	x1, x20
101f7770c: 9572be8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77710: aa1d03fd    	mov	x29, x29
101f77714: 9572be8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77718: aa0003f9    	mov	x25, x0
101f7771c: 900f0c88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101f77720: f943e901    	ldr	x1, [x8, #0x7d0] ; setCornerRadius:
101f77724: 1e621000    	fmov	d0, #4.00000000
101f77728: 9572be85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7772c: aa1903e0    	mov	x0, x25
101f77730: 9572be89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77734: f945eb40    	ldr	x0, [x26, #0xbd0] ; ��d 
101f77738: aa1503e1    	mov	x1, x21
101f7773c: 9572be80    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77740: aa1d03fd    	mov	x29, x29
101f77744: 9572be81    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77748: aa0003f5    	mov	x21, x0
101f7774c: b00f0fe8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101f77750: f9404100    	ldr	x0, [x8, #0x80]
101f77754: aa1603e1    	mov	x1, x22
101f77758: 9572be79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7775c: aa0003e2    	mov	x2, x0
101f77760: aa1503e0    	mov	x0, x21
101f77764: aa1803e1    	mov	x1, x24
101f77768: 9572be75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7776c: aa1d03fd    	mov	x29, x29
101f77770: 9572be76    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77774: aa0003f6    	mov	x22, x0
101f77778: b00ef628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101f7777c: f9400501    	ldr	x1, [x8, #0x8] ; colorList
101f77780: 9572be6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77784: aa1d03fd    	mov	x29, x29
101f77788: 9572be70    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f7778c: aa0003f8    	mov	x24, x0
101f77790: b00ef628    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101f77794: f9416901    	ldr	x1, [x8, #0x2d0] ; getColorByName:withAlpha:
101f77798: b00e2942    	adrp	x2, 0x11e4a0000 <dyld_stub_binder+0x11e4a0000>
101f7779c: 9126a042    	add	x2, x2, #0x9a8
101f777a0: d00b7048    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
101f777a4: fd42d100    	ldr	d0, [x8, #0x5a0]
101f777a8: 9572be65    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f777ac: aa1d03fd    	mov	x29, x29
101f777b0: 9572be66    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f777b4: aa0003f9    	mov	x25, x0
101f777b8: 9572be60    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101f777bc: b40000a0    	cbz	x0, 0x101f777d0 <_Flutter_Image_provideRelativePathByUrl+0x384680>
101f777c0: aa1903e0    	mov	x0, x25
101f777c4: 9572be5d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101f777c8: aa1903fa    	mov	x26, x25
101f777cc: 14000009    	b	0x101f777f0 <_Flutter_Image_provideRelativePathByUrl+0x3846a0>
101f777d0: 900f0fe8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101f777d4: f9463100    	ldr	x0, [x8, #0xc60]
101f777d8: 900f0c48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101f777dc: f947dd01    	ldr	x1, [x8, #0xfb8] ; clearColor
101f777e0: 9572be57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f777e4: aa1d03fd    	mov	x29, x29
101f777e8: 9572be58    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f777ec: aa0003fa    	mov	x26, x0
101f777f0: aa1903e0    	mov	x0, x25
101f777f4: 9572be58    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f777f8: aa1a03e0    	mov	x0, x26
101f777fc: 9572be6b    	bl	0x107c271a8 <_Flutter_MMFoundation_BindContext+0x4102d8c>
101f77800: f00f0c28    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
101f77804: f942f501    	ldr	x1, [x8, #0x5e8] ; CGColor
101f77808: 9572be4d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7780c: aa0003fb    	mov	x27, x0
101f77810: f87c6a60    	ldr	x0, [x19, x28]
101f77814: aa1403e1    	mov	x1, x20
101f77818: 9572be49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7781c: aa1d03fd    	mov	x29, x29
101f77820: 9572be4a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77824: aa1c03f7    	mov	x23, x28
101f77828: aa0003fc    	mov	x28, x0
101f7782c: 900f0c88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101f77830: f9416501    	ldr	x1, [x8, #0x2c8] ; setBorderColor:
101f77834: aa1b03e2    	mov	x2, x27
101f77838: 9572be41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7783c: aa1c03e0    	mov	x0, x28
101f77840: 9572be45    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77844: aa1a03e0    	mov	x0, x26
101f77848: 9572be43    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f7784c: aa1903e0    	mov	x0, x25
101f77850: 9572be41    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77854: aa1803e0    	mov	x0, x24
101f77858: 9572be3f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f7785c: aa1603e0    	mov	x0, x22
101f77860: 9572be3d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77864: aa1503e0    	mov	x0, x21
101f77868: 9572be3b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f7786c: b00f0fe8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101f77870: f9406100    	ldr	x0, [x8, #0xc0]
101f77874: b00f0c68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101f77878: f9413101    	ldr	x1, [x8, #0x260] ; mainScreen
101f7787c: 9572be30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77880: aa1d03fd    	mov	x29, x29
101f77884: 9572be31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77888: aa0003f5    	mov	x21, x0
101f7788c: f00f0c68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
101f77890: f944d901    	ldr	x1, [x8, #0x9b0] ; scale
101f77894: 9572be2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77898: 1e6e1001    	fmov	d1, #1.00000000
101f7789c: f8776a60    	ldr	x0, [x19, x23]
101f778a0: 1e601828    	fdiv	d8, d1, d0
101f778a4: aa1403e1    	mov	x1, x20
101f778a8: 9572be25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f778ac: aa1d03fd    	mov	x29, x29
101f778b0: 9572be26    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f778b4: aa0003f6    	mov	x22, x0
101f778b8: 900f0c88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101f778bc: f9416d01    	ldr	x1, [x8, #0x2d8] ; setBorderWidth:
101f778c0: 1e604100    	fmov	d0, d8
101f778c4: 9572be1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f778c8: aa1603e0    	mov	x0, x22
101f778cc: 9572be22    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f778d0: aa1503e0    	mov	x0, x21
101f778d4: 9572be20    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f778d8: f8776a60    	ldr	x0, [x19, x23]
101f778dc: 900f0c88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101f778e0: f942e101    	ldr	x1, [x8, #0x5c0] ; setClipsToBounds:
101f778e4: 52800022    	mov	w2, #0x1                ; =1
101f778e8: 9572be15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f778ec: 900f1028    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
101f778f0: f9449100    	ldr	x0, [x8, #0x920] ; h�9 
101f778f4: b00ef868    	adrp	x8, 0x11fe84000 <dyld_stub_binder+0x11fe84000>
101f778f8: f9427901    	ldr	x1, [x8, #0x4f0] ; GetAlphaImageBackgroundColor
101f778fc: 9572be10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77900: aa1d03fd    	mov	x29, x29
101f77904: 9572be11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f77908: aa0003f5    	mov	x21, x0
101f7790c: f8776a60    	ldr	x0, [x19, x23]
101f77910: 900f0c88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
101f77914: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
101f77918: aa1503e2    	mov	x2, x21
101f7791c: 9572be08    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77920: aa1503e0    	mov	x0, x21
101f77924: 9572be0c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77928: aa1303e0    	mov	x0, x19
101f7792c: f9400be1    	ldr	x1, [sp, #0x10]
101f77930: 9572be03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77934: aa1d03fd    	mov	x29, x29
101f77938: 9572be04    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101f7793c: aa0003f4    	mov	x20, x0
101f77940: d00efaa8    	adrp	x8, 0x11fecd000 <dyld_stub_binder+0x11fecd000>
101f77944: f943e501    	ldr	x1, [x8, #0x7c8] ; isComponentHidden
101f77948: 9572bdfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f7794c: aa0003e2    	mov	x2, x0
101f77950: f8776a60    	ldr	x0, [x19, x23]
101f77954: b00f0c88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
101f77958: f9411101    	ldr	x1, [x8, #0x220] ; setHidden:
101f7795c: 9572bdf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101f77960: aa1403e0    	mov	x0, x20
101f77964: 9572bdfc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101f77968: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
101f7796c: a9494ff4    	ldp	x20, x19, [sp, #0x90]
101f77970: a94857f6    	ldp	x22, x21, [sp, #0x80]
101f77974: a9475ff8    	ldp	x24, x23, [sp, #0x70]
101f77978: a94667fa    	ldp	x26, x25, [sp, #0x60]
101f7797c: a9456ffc    	ldp	x28, x27, [sp, #0x50]
101f77980: 6d4423e9    	ldp	d9, d8, [sp, #0x40]
101f77984: 9102c3ff    	add	sp, sp, #0xb0
101f77988: d65f03c0    	ret