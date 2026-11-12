
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105463690: d10183ff    	sub	sp, sp, #0x60
105463694: a9025ff8    	stp	x24, x23, [sp, #0x20]
105463698: a90357f6    	stp	x22, x21, [sp, #0x30]
10546369c: a9044ff4    	stp	x20, x19, [sp, #0x40]
1054636a0: a9057bfd    	stp	x29, x30, [sp, #0x50]
1054636a4: 910143fd    	add	x29, sp, #0x50
1054636a8: aa0303f5    	mov	x21, x3
1054636ac: aa0203f3    	mov	x19, x2
1054636b0: aa0003f4    	mov	x20, x0
1054636b4: 900d1788    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
1054636b8: 52800029    	mov	w9, #0x1                ; =1
1054636bc: 3911f909    	strb	w9, [x8, #0x47e]
1054636c0: aa0203e0    	mov	x0, x2
1054636c4: 949f116c    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1054636c8: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1054636cc: f9461516    	ldr	x22, [x8, #0xc28] ; selector m_uiCgi
1054636d0: aa1303e0    	mov	x0, x19
1054636d4: aa1603e1    	mov	x1, x22
1054636d8: 949f1163    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054636dc: 710aa41f    	cmp	w0, #0x2a9
1054636e0: 54000101    	b.ne	0x105463700 <_Flutter_MMFoundation_BindContext+0x16ea3cc>
1054636e4: f00cb6a8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
1054636e8: f9461101    	ldr	x1, [x8, #0xc20] ; selector HandleOplog:Event:
1054636ec: aa1403e0    	mov	x0, x20
1054636f0: aa1303e2    	mov	x2, x19
1054636f4: aa1503e3    	mov	x3, x21
1054636f8: 949f115b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054636fc: 140000c4    	b	0x105463a0c <_Flutter_MMFoundation_BindContext+0x16ea6d8>
105463700: aa1303e0    	mov	x0, x19
105463704: aa1603e1    	mov	x1, x22
105463708: 949f1157    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546370c: 7102281f    	cmp	w0, #0x8a
105463710: 54000d81    	b.ne	0x1054638c0 <_Flutter_MMFoundation_BindContext+0x16ea58c>
105463714: f00ccb28    	adrp	x8, 0x11edca000 <dyld_stub_binder+0x11edca000>
105463718: b988e908    	ldrsw	x8, [x8, #0x8e8]
10546371c: b8286a9f    	str	wzr, [x20, x8]
105463720: f00cc568    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105463724: f9430d17    	ldr	x23, [x8, #0x618] ; class iConsole
105463728: 900cab48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10546372c: f9467116    	ldr	x22, [x8, #0xce0] ; selector m_uiMessage
105463730: aa1303e0    	mov	x0, x19
105463734: aa1603e1    	mov	x1, x22
105463738: 949f114b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546373c: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105463740: f9418901    	ldr	x1, [x8, #0x310] ; selector logWithLevel:module:errorCode:file:line:func:format:
105463744: a90083f5    	stp	x21, x0, [sp, #0x8]
105463748: f00bf488    	adrp	x8, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
10546374c: 913be108    	add	x8, x8, #0xef8 ; cfstring 'EventID: %u, message:%u'
105463750: f90003e8    	str	x8, [sp]
105463754: d00a4483    	adrp	x3, 0x119cf5000 <dyld_stub_binder+0x119cf5000>
105463758: 913ebc63    	add	x3, x3, #0xfaf ; 'Sync'
10546375c: 900a6de5    	adrp	x5, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
105463760: 912b44a5    	add	x5, x5, #0xad1 ; 'NewSyncService.mm'
105463764: 900a6de7    	adrp	x7, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
105463768: 913e7ce7    	add	x7, x7, #0xf9f ; '-[NewSyncService MessageReturn:Event:]'
10546376c: aa1703e0    	mov	x0, x23
105463770: 52800042    	mov	w2, #0x2                ; =2
105463774: 52800004    	mov	w4, #0x0                ; =0
105463778: 528045a6    	mov	w6, #0x22d              ; =557
10546377c: 949f113a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463780: f00cc568    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105463784: f9442100    	ldr	x0, [x8, #0x840] ; class CAppUtil
105463788: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10546378c: f9461901    	ldr	x1, [x8, #0xc30] ; selector removePBEventObserverListItem:andValue:
105463790: aa1503e2    	mov	x2, x21
105463794: aa1403e3    	mov	x3, x20
105463798: 949f1133    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546379c: 900cab48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1054637a0: f9443501    	ldr	x1, [x8, #0x868] ; selector m_pbRequest
1054637a4: aa1303e0    	mov	x0, x19
1054637a8: 949f112f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054637ac: aa1d03fd    	mov	x29, x29
1054637b0: 949f1134    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1054637b4: aa0003f5    	mov	x21, x0
1054637b8: f00cc228    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1054637bc: f9453101    	ldr	x1, [x8, #0xa60] ; selector scene
1054637c0: 949f1129    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054637c4: 7100301f    	cmp	w0, #0xc
1054637c8: 54000221    	b.ne	0x10546380c <_Flutter_MMFoundation_BindContext+0x16ea4d8>
1054637cc: f00cc568    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1054637d0: f9436500    	ldr	x0, [x8, #0x6c8] ; 0x11ed126c8 (?) bind pointer 0x801000000000280d
1054637d4: f00cc208    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1054637d8: f9466901    	ldr	x1, [x8, #0xcd0] ; selector defaultCenter
1054637dc: 949f1122    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054637e0: aa1d03fd    	mov	x29, x29
1054637e4: 949f1127    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1054637e8: aa0003f7    	mov	x23, x0
1054637ec: d00cc228    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1054637f0: f9478101    	ldr	x1, [x8, #0xf00] ; selector postNotificationName:object:
1054637f4: f00bf322    	adrp	x2, 0x11d2ca000 <dyld_stub_binder+0x11d2ca000>
1054637f8: 9101e042    	add	x2, x2, #0x78 ; cfstring 'fetchsyncdone'
1054637fc: d2800003    	mov	x3, #0x0                ; =0
105463800: 949f1119    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463804: aa1703e0    	mov	x0, x23
105463808: 949f111a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10546380c: aa1303e0    	mov	x0, x19
105463810: aa1603e1    	mov	x1, x22
105463814: 949f1114    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463818: 7100041f    	cmp	w0, #0x1
10546381c: 54000bc1    	b.ne	0x105463994 <_Flutter_MMFoundation_BindContext+0x16ea660>
105463820: f00cb6a8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105463824: f9455101    	ldr	x1, [x8, #0xaa0] ; selector resetGettingData
105463828: aa1403e0    	mov	x0, x20
10546382c: 949f110e    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463830: f00ccb28    	adrp	x8, 0x11edca000 <dyld_stub_binder+0x11edca000>
105463834: b988f108    	ldrsw	x8, [x8, #0x8f0]
105463838: 52800029    	mov	w9, #0x1                ; =1
10546383c: 38286a89    	strb	w9, [x20, x8]
105463840: f00cc568    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105463844: f943c100    	ldr	x0, [x8, #0x780] ; class MMContext
105463848: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10546384c: f9440101    	ldr	x1, [x8, #0x800] ; selector currentContext
105463850: 949f1105    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463854: aa1d03fd    	mov	x29, x29
105463858: 949f110a    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10546385c: aa0003f4    	mov	x20, x0
105463860: 900cc568    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
105463864: f943b102    	ldr	x2, [x8, #0x760] ; 0x11ed0f760 __objc_protorefs
105463868: f00cb6a8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
10546386c: f9461503    	ldr	x3, [x8, #0xc28] ; selector onNewSyncOplogConnectFail
105463870: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105463874: f9472d01    	ldr	x1, [x8, #0xe58] ; selector callExtension:selector:block:
105463878: d00b74c4    	adrp	x4, 0x11c2fd000 <dyld_stub_binder+0x11c2fd000>
10546387c: 913b2084    	add	x4, x4, #0xec8 ; 0x11c2fdec8 __const
105463880: 949f10f9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463884: aa1403e0    	mov	x0, x20
105463888: 949f10fa    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10546388c: 52801200    	mov	w0, #0x90               ; =144
105463890: 52800081    	mov	w1, #0x4                ; =4
105463894: 52800022    	mov	w2, #0x1                ; =1
105463898: 52800003    	mov	w3, #0x0                ; =0
10546389c: 52800004    	mov	w4, #0x0                ; =0
1054638a0: 97321a5b    	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
1054638a4: f00bf481    	adrp	x1, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
1054638a8: 913c6021    	add	x1, x1, #0xf18 ; cfstring '4,0'
1054638ac: 52915720    	mov	w0, #0x8ab9             ; =35513
1054638b0: 52800002    	mov	w2, #0x0                ; =0
1054638b4: 52800003    	mov	w3, #0x0                ; =0
1054638b8: 973eda05    	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
1054638bc: 14000052    	b	0x105463a04 <_Flutter_MMFoundation_BindContext+0x16ea6d0>
1054638c0: aa1303e0    	mov	x0, x19
1054638c4: aa1603e1    	mov	x1, x22
1054638c8: 949f10e7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054638cc: 71022c1f    	cmp	w0, #0x8b
1054638d0: 540009e1    	b.ne	0x105463a0c <_Flutter_MMFoundation_BindContext+0x16ea6d8>
1054638d4: f00cc568    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1054638d8: f9430d14    	ldr	x20, [x8, #0x618] ; class iConsole
1054638dc: 900cab48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1054638e0: f9467116    	ldr	x22, [x8, #0xce0] ; selector m_uiMessage
1054638e4: aa1303e0    	mov	x0, x19
1054638e8: aa1603e1    	mov	x1, x22
1054638ec: 949f10de    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054638f0: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1054638f4: f9418901    	ldr	x1, [x8, #0x310] ; selector logWithLevel:module:errorCode:file:line:func:format:
1054638f8: f00bf488    	adrp	x8, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
1054638fc: 913be108    	add	x8, x8, #0xef8 ; cfstring 'EventID: %u, message:%u'
105463900: a90083f5    	stp	x21, x0, [sp, #0x8]
105463904: f90003e8    	str	x8, [sp]
105463908: d00a4483    	adrp	x3, 0x119cf5000 <dyld_stub_binder+0x119cf5000>
10546390c: 913ebc63    	add	x3, x3, #0xfaf ; 'Sync'
105463910: 900a6de5    	adrp	x5, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
105463914: 912b44a5    	add	x5, x5, #0xad1 ; 'NewSyncService.mm'
105463918: 900a6de7    	adrp	x7, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
10546391c: 913e7ce7    	add	x7, x7, #0xf9f ; '-[NewSyncService MessageReturn:Event:]'
105463920: aa1403e0    	mov	x0, x20
105463924: 52800042    	mov	w2, #0x2                ; =2
105463928: 52800004    	mov	w4, #0x0                ; =0
10546392c: 528048a6    	mov	w6, #0x245              ; =581
105463930: 949f10cd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463934: aa1303e0    	mov	x0, x19
105463938: aa1603e1    	mov	x1, x22
10546393c: 949f10ca    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105463940: 7100041f    	cmp	w0, #0x1
105463944: 54000641    	b.ne	0x105463a0c <_Flutter_MMFoundation_BindContext+0x16ea6d8>
105463948: f00cc568    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10546394c: f943c100    	ldr	x0, [x8, #0x780] ; class MMContext
105463950: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105463954: f9440101    	ldr	x1, [x8, #0x800] ; selector currentContext
105463958: 949f10c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546395c: aa1d03fd    	mov	x29, x29
105463960: 949f10c8    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105463964: aa0003f4    	mov	x20, x0
105463968: b00cc568    	adrp	x8, 0x11ed10000 <dyld_stub_binder+0x11ed10000>
10546396c: f9413502    	ldr	x2, [x8, #0x268] ; 0x11ed10268 __objc_protorefs
105463970: f00cb6a8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
105463974: f9461d03    	ldr	x3, [x8, #0xc38] ; selector onNewInitConnectFail
105463978: d00cab28    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10546397c: f9472d01    	ldr	x1, [x8, #0xe58] ; selector callExtension:selector:block:
105463980: d00b74c4    	adrp	x4, 0x11c2fd000 <dyld_stub_binder+0x11c2fd000>
105463984: 913ba084    	add	x4, x4, #0xee8 ; 0x11c2fdee8 __const
105463988: 949f10b7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10546398c: aa1403e0    	mov	x0, x20
105463990: 1400001e    	b	0x105463a08 <_Flutter_MMFoundation_BindContext+0x16ea6d4>
105463994: 900cab68    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
105463998: f9405101    	ldr	x1, [x8, #0xa0] ; selector m_oUserData
10546399c: aa1303e0    	mov	x0, x19
1054639a0: 949f10b1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054639a4: aa1d03fd    	mov	x29, x29
1054639a8: 949f10b6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1054639ac: aa0003f6    	mov	x22, x0
1054639b0: 900cab48    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1054639b4: f9443901    	ldr	x1, [x8, #0x870] ; selector m_pbResponse
1054639b8: aa1303e0    	mov	x0, x19
1054639bc: 949f10aa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054639c0: aa1d03fd    	mov	x29, x29
1054639c4: 949f10af    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1054639c8: aa0003f7    	mov	x23, x0
1054639cc: f00cc208    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1054639d0: f9408501    	ldr	x1, [x8, #0x108] ; selector boolValue
1054639d4: aa1603e0    	mov	x0, x22
1054639d8: 949f10a3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054639dc: aa0003e3    	mov	x3, x0
1054639e0: f00cb6a8    	adrp	x8, 0x11eb3a000 <dyld_stub_binder+0x11eb3a000>
1054639e4: f9461901    	ldr	x1, [x8, #0xc30] ; selector HandleSyncResp:handleResult:
1054639e8: aa1403e0    	mov	x0, x20
1054639ec: aa1703e2    	mov	x2, x23
1054639f0: 949f109d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054639f4: aa1703e0    	mov	x0, x23
1054639f8: 949f109e    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1054639fc: aa1603e0    	mov	x0, x22
105463a00: 949f109c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105463a04: aa1503e0    	mov	x0, x21
105463a08: 949f109a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105463a0c: aa1303e0    	mov	x0, x19
105463a10: a9457bfd    	ldp	x29, x30, [sp, #0x50]
105463a14: a9444ff4    	ldp	x20, x19, [sp, #0x40]
105463a18: a94357f6    	ldp	x22, x21, [sp, #0x30]
105463a1c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
105463a20: 910183ff    	add	sp, sp, #0x60
105463a24: 149f1093    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
