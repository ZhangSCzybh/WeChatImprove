
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100792418: d101c3ff    	sub	sp, sp, #0x70
10079241c: a9035ff8    	stp	x24, x23, [sp, #0x30]
100792420: a90457f6    	stp	x22, x21, [sp, #0x40]
100792424: a9054ff4    	stp	x20, x19, [sp, #0x50]
100792428: a9067bfd    	stp	x29, x30, [sp, #0x60]
10079242c: 910183fd    	add	x29, sp, #0x60
100792430: aa0203f3    	mov	x19, x2
100792434: aa0003f4    	mov	x20, x0
100792438: 901024e8    	adrp	x8, 0x120c2e000 <dyld_stub_binder+0x120c2e000>
10079243c: 52800029    	mov	w9, #0x1                ; =1
100792440: 393bf909    	strb	w9, [x8, #0xefe]
100792444: aa0203e0    	mov	x0, x2
100792448: 95d2533c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10079244c: d00fcb68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100792450: f9435101    	ldr	x1, [x8, #0x6a0] ; count
100792454: aa1303e0    	mov	x0, x19
100792458: 95d25339    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079245c: b4000a40    	cbz	x0, 0x1007925a4 <__text+0x78a5a4>
100792460: 900fb688    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
100792464: f9412d01    	ldr	x1, [x8, #0x258] ; containsAskXiaoWei:
100792468: aa1403e0    	mov	x0, x20
10079246c: aa1303e2    	mov	x2, x19
100792470: 95d25333    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792474: 34000980    	cbz	w0, 0x1007925a4 <__text+0x78a5a4>
100792478: b00fcf08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10079247c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d
100792480: d00fcb68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100792484: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
100792488: 95d2532d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079248c: aa1d03fd    	mov	x29, x29
100792490: 95d2532e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792494: aa0003f5    	mov	x21, x0
100792498: b00fcf08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10079249c: f9467100    	ldr	x0, [x8, #0xce0] ; @�-
1007924a0: b00fcb68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1007924a4: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1007924a8: 95d25325    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1007924ac: aa0003e2    	mov	x2, x0
1007924b0: f00fb528    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1007924b4: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
1007924b8: aa1503e0    	mov	x0, x21
1007924bc: 95d25320    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1007924c0: aa1d03fd    	mov	x29, x29
1007924c4: 95d25321    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1007924c8: aa0003f6    	mov	x22, x0
1007924cc: 900fb548    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
1007924d0: f9404101    	ldr	x1, [x8, #0x80] ; getExpt:withBoolDef:
1007924d4: 900eeac2    	adrp	x2, 0x11e4ea000 <dyld_stub_binder+0x11e4ea000>
1007924d8: 91042042    	add	x2, x2, #0x108
1007924dc: 52800003    	mov	w3, #0x0                ; =0
1007924e0: 95d25317    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1007924e4: aa0003f7    	mov	x23, x0
1007924e8: aa1603e0    	mov	x0, x22
1007924ec: 95d2531a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007924f0: aa1503e0    	mov	x0, x21
1007924f4: 95d25318    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007924f8: 34000577    	cbz	w23, 0x1007925a4 <__text+0x78a5a4>
1007924fc: 900fb688    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
100792500: f9413101    	ldr	x1, [x8, #0x260] ; mutexMenuTypes
100792504: aa1403e0    	mov	x0, x20
100792508: 95d2530d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079250c: aa1d03fd    	mov	x29, x29
100792510: 95d2530e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792514: aa0003f4    	mov	x20, x0
100792518: d00fcf08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10079251c: f9419115    	ldr	x21, [x8, #0x320]
100792520: 900e72e8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
100792524: f947e108    	ldr	x8, [x8, #0xfc0]
100792528: f90007e8    	str	x8, [sp, #0x8]
10079252c: f00c2f68    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
100792530: fd41c100    	ldr	d0, [x8, #0x380]
100792534: 90000008    	adrp	x8, 0x100792000 <__text+0x78a000>
100792538: 91171108    	add	x8, x8, #0x5c4
10079253c: 900e7389    	adrp	x9, 0x11d602000 <dyld_stub_binder+0x11d602000>
100792540: 9136a129    	add	x9, x9, #0xda8
100792544: fd000be0    	str	d0, [sp, #0x10]
100792548: a901a7e8    	stp	x8, x9, [sp, #0x18]
10079254c: f90017e0    	str	x0, [sp, #0x28]
100792550: 900fb688    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
100792554: f9413516    	ldr	x22, [x8, #0x268] ; predicateWithBlock:
100792558: 95d252f8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10079255c: 910023e2    	add	x2, sp, #0x8
100792560: aa1503e0    	mov	x0, x21
100792564: aa1603e1    	mov	x1, x22
100792568: 95d252f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079256c: aa1d03fd    	mov	x29, x29
100792570: 95d252f6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792574: aa0003f5    	mov	x21, x0
100792578: 900fb688    	adrp	x8, 0x11fe62000 <dyld_stub_binder+0x11fe62000>
10079257c: f9413901    	ldr	x1, [x8, #0x270] ; filterUsingPredicate:
100792580: aa1303e0    	mov	x0, x19
100792584: aa1503e2    	mov	x2, x21
100792588: 95d252ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079258c: aa1503e0    	mov	x0, x21
100792590: 95d252f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100792594: f94017e0    	ldr	x0, [sp, #0x28]
100792598: 95d252ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10079259c: aa1403e0    	mov	x0, x20
1007925a0: 95d252ed    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007925a4: aa1303e0    	mov	x0, x19
1007925a8: 95d252eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1007925ac: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1007925b0: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1007925b4: a94457f6    	ldp	x22, x21, [sp, #0x40]
1007925b8: a9435ff8    	ldp	x24, x23, [sp, #0x30]
1007925bc: 9101c3ff    	add	sp, sp, #0x70
1007925c0: d65f03c0    	ret
1007925c4: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1007925c8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1007925cc: a9027bfd    	stp	x29, x30, [sp, #0x20]
1007925d0: 910083fd    	add	x29, sp, #0x20
1007925d4: aa0103f3    	mov	x19, x1
1007925d8: aa0003f4    	mov	x20, x0
1007925dc: aa0103e0    	mov	x0, x1
1007925e0: 95d252d6    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1007925e4: d00fcf08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1007925e8: f9452900    	ldr	x0, [x8, #0xa50]
1007925ec: b00fcb68    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1007925f0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
1007925f4: 95d252d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1007925f8: aa0003e2    	mov	x2, x0
1007925fc: b00fcb88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
100792600: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
100792604: aa1303e0    	mov	x0, x19
100792608: 95d252cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079260c: 34000320    	cbz	w0, 0x100792670 <__text+0x78a670>
100792610: f9401294    	ldr	x20, [x20, #0x20]
100792614: b00fcf08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100792618: f9458915    	ldr	x21, [x8, #0xb10]
10079261c: b00fb568    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
100792620: f9436501    	ldr	x1, [x8, #0x6c8] ; menuType
100792624: aa1303e0    	mov	x0, x19
100792628: 95d252c5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10079262c: aa0003e2    	mov	x2, x0
100792630: d00fcb88    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100792634: f947a901    	ldr	x1, [x8, #0xf50] ; numberWithInteger:
100792638: aa1503e0    	mov	x0, x21
10079263c: 95d252c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792640: aa1d03fd    	mov	x29, x29
100792644: 95d252c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100792648: aa0003f5    	mov	x21, x0
10079264c: d00fcb68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100792650: f9424d01    	ldr	x1, [x8, #0x498] ; containsObject:
100792654: aa1403e0    	mov	x0, x20
100792658: aa1503e2    	mov	x2, x21
10079265c: 95d252b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100792660: 52000014    	eor	w20, w0, #0x1
100792664: aa1503e0    	mov	x0, x21
100792668: 95d252bb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10079266c: 14000002    	b	0x100792674 <__text+0x78a674>
100792670: 52800034    	mov	w20, #0x1               ; =1
100792674: aa1303e0    	mov	x0, x19
100792678: 95d252b7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10079267c: aa1403e0    	mov	x0, x20
100792680: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100792684: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100792688: a8c357f6    	ldp	x22, x21, [sp], #0x30
10079268c: d65f03c0    	ret