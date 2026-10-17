
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3850c: d101c3ff    	sub	sp, sp, #0x70
104b38510: a90267fa    	stp	x26, x25, [sp, #0x20]
104b38514: a9035ff8    	stp	x24, x23, [sp, #0x30]
104b38518: a90457f6    	stp	x22, x21, [sp, #0x40]
104b3851c: a9054ff4    	stp	x20, x19, [sp, #0x50]
104b38520: a9067bfd    	stp	x29, x30, [sp, #0x60]
104b38524: 910183fd    	add	x29, sp, #0x60
104b38528: aa0603f8    	mov	x24, x6
104b3852c: aa0503f5    	mov	x21, x5
104b38530: aa0403f7    	mov	x23, x4
104b38534: aa0303f4    	mov	x20, x3
104b38538: aa0203f3    	mov	x19, x2
104b3853c: aa0003f6    	mov	x22, x0
104b38540: d00e0828    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b38544: 52800029    	mov	w9, #0x1                ; =1
104b38548: 3915a109    	strb	w9, [x8, #0x568]
104b3854c: aa0203e0    	mov	x0, x2
104b38550: 94c3bafa    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b38554: aa1403e0    	mov	x0, x20
104b38558: 94c3baf8    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3855c: b4000334    	cbz	x20, 0x104b385c0 <_Flutter_MMFoundation_BindContext+0x10141a4>
104b38560: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b38564: f9467900    	ldr	x0, [x8, #0xcf0] ; ��b 
104b38568: f00d9848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3856c: f9462101    	ldr	x1, [x8, #0xc40] ; isEnterpriseUsrName:
104b38570: aa1303e2    	mov	x2, x19
104b38574: 94c3baf2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38578: 340005a0    	cbz	w0, 0x104b3862c <_Flutter_MMFoundation_BindContext+0x1014210>
104b3857c: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b38580: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
104b38584: b00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b38588: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3858c: 900ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b38590: 91392108    	add	x8, x8, #0xe48
104b38594: f90003e8    	str	x8, [sp]
104b38598: b00b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3859c: 9107f063    	add	x3, x3, #0x1fc
104b385a0: 900b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b385a4: 910cb4a5    	add	x5, x5, #0x32d
104b385a8: b00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b385ac: 9139f0e7    	add	x7, x7, #0xe7c
104b385b0: 52800082    	mov	w2, #0x4                ; =4
104b385b4: 52800004    	mov	w4, #0x0                ; =0
104b385b8: 52818126    	mov	w6, #0xc09              ; =3081
104b385bc: 14000011    	b	0x104b38600 <_Flutter_MMFoundation_BindContext+0x10141e4>
104b385c0: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b385c4: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
104b385c8: b00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b385cc: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b385d0: 900ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b385d4: 911c2108    	add	x8, x8, #0x708
104b385d8: f90003e8    	str	x8, [sp]
104b385dc: b00b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b385e0: 9107f063    	add	x3, x3, #0x1fc
104b385e4: 900b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b385e8: 910cb4a5    	add	x5, x5, #0x32d
104b385ec: b00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b385f0: 9139f0e7    	add	x7, x7, #0xe7c
104b385f4: 52800082    	mov	w2, #0x4                ; =4
104b385f8: 52800004    	mov	w4, #0x0                ; =0
104b385fc: 528180a6    	mov	w6, #0xc05              ; =3077
104b38600: 94c3bacf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38604: aa1403e0    	mov	x0, x20
104b38608: 94c3bad3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3860c: aa1303e0    	mov	x0, x19
104b38610: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104b38614: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104b38618: a94457f6    	ldp	x22, x21, [sp, #0x40]
104b3861c: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104b38620: a94267fa    	ldp	x26, x25, [sp, #0x20]
104b38624: 9101c3ff    	add	sp, sp, #0x70
104b38628: 14c3bacb    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3862c: f00db75a    	adrp	x26, 0x120223000 <dyld_stub_binder+0x120223000>
104b38630: 340007b8    	cbz	w24, 0x104b38724 <_Flutter_MMFoundation_BindContext+0x1014308>
104b38634: 900d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b38638: f947d518    	ldr	x24, [x8, #0xfa8] ; m_n64MesSvrID
104b3863c: aa1403e0    	mov	x0, x20
104b38640: aa1803e1    	mov	x1, x24
104b38644: 94c3babe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38648: f100041f    	cmp	x0, #0x1
104b3864c: 540006cb    	b.lt	0x104b38724 <_Flutter_MMFoundation_BindContext+0x1014308>
104b38650: f00dae48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b38654: f946e901    	ldr	x1, [x8, #0xdd0] ; length
104b38658: aa1303e0    	mov	x0, x19
104b3865c: 94c3bab8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38660: b4000620    	cbz	x0, 0x104b38724 <_Flutter_MMFoundation_BindContext+0x1014308>
104b38664: b9895748    	ldrsw	x8, [x26, #0x954]
104b38668: f8686ad9    	ldr	x25, [x22, x8]
104b3866c: aa1403e0    	mov	x0, x20
104b38670: aa1803e1    	mov	x1, x24
104b38674: 94c3bab2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38678: aa0003e3    	mov	x3, x0
104b3867c: 900d9848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104b38680: f941c101    	ldr	x1, [x8, #0x380] ; GetMsg:n64SvrID:
104b38684: aa1903e0    	mov	x0, x25
104b38688: aa1303e2    	mov	x2, x19
104b3868c: 94c3baac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38690: aa1d03fd    	mov	x29, x29
104b38694: 94c3baad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b38698: aa0003f9    	mov	x25, x0
104b3869c: 94c3baae    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b386a0: b4000439    	cbz	x25, 0x104b38724 <_Flutter_MMFoundation_BindContext+0x1014308>
104b386a4: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b386a8: f9453515    	ldr	x21, [x8, #0xa68] ; �gH 
104b386ac: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b386b0: f9454500    	ldr	x0, [x8, #0xa88]
104b386b4: 900d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b386b8: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b386bc: aa1303e2    	mov	x2, x19
104b386c0: 94c3ba9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b386c4: aa1d03fd    	mov	x29, x29
104b386c8: 94c3baa0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b386cc: aa0003f6    	mov	x22, x0
104b386d0: aa1403e0    	mov	x0, x20
104b386d4: aa1803e1    	mov	x1, x24
104b386d8: 94c3ba99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b386dc: b00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b386e0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b386e4: a90083f6    	stp	x22, x0, [sp, #0x8]
104b386e8: 900ce368    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b386ec: 9114a108    	add	x8, x8, #0x528
104b386f0: f90003e8    	str	x8, [sp]
104b386f4: 900b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b386f8: 910cb4a5    	add	x5, x5, #0x32d
104b386fc: b00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b38700: 9139f0e7    	add	x7, x7, #0xe7c
104b38704: aa1503e0    	mov	x0, x21
104b38708: 52800042    	mov	w2, #0x2                ; =2
104b3870c: d2800003    	mov	x3, #0x0                ; =0
104b38710: 52800004    	mov	w4, #0x0                ; =0
104b38714: 528181e6    	mov	w6, #0xc0f              ; =3087
104b38718: 94c3ba89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3871c: aa1603e0    	mov	x0, x22
104b38720: 14000054    	b	0x104b38870 <_Flutter_MMFoundation_BindContext+0x1014454>
104b38724: d00d9828    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b38728: f9413d18    	ldr	x24, [x8, #0x278] ; m_uiMessageType
104b3872c: aa1403e0    	mov	x0, x20
104b38730: aa1803e1    	mov	x1, x24
104b38734: 94c3ba82    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38738: 7100c41f    	cmp	w0, #0x31
104b3873c: 540000c1    	b.ne	0x104b38754 <_Flutter_MMFoundation_BindContext+0x1014338>
104b38740: f00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b38744: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b38748: aa1403e0    	mov	x0, x20
104b3874c: d2800002    	mov	x2, #0x0                ; =0
104b38750: 94c3ba7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38754: aa1403e0    	mov	x0, x20
104b38758: aa1803e1    	mov	x1, x24
104b3875c: 94c3ba78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38760: f00d9839    	adrp	x25, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b38764: 7100bc1f    	cmp	w0, #0x2f
104b38768: 54000081    	b.ne	0x104b38778 <_Flutter_MMFoundation_BindContext+0x101435c>
104b3876c: f9465721    	ldr	x1, [x25, #0xca8] ; ChangeForDisplay
104b38770: aa1403e0    	mov	x0, x20
104b38774: 94c3ba72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38778: b9895748    	ldrsw	x8, [x26, #0x954]
104b3877c: f8686ac0    	ldr	x0, [x22, x8]
104b38780: d00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b38784: f9407901    	ldr	x1, [x8, #0xf0] ; AddMsg:MsgWrap:withTimeFixed:
104b38788: aa1303e2    	mov	x2, x19
104b3878c: aa1403e3    	mov	x3, x20
104b38790: aa1703e4    	mov	x4, x23
104b38794: 94c3ba6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38798: 900d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3879c: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b387a0: aa1403e0    	mov	x0, x20
104b387a4: 94c3ba66    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b387a8: 34000180    	cbz	w0, 0x104b387d8 <_Flutter_MMFoundation_BindContext+0x10143bc>
104b387ac: aa1403e0    	mov	x0, x20
104b387b0: aa1803e1    	mov	x1, x24
104b387b4: 94c3ba62    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b387b8: 7100f81f    	cmp	w0, #0x3e
104b387bc: 540005e0    	b.eq	0x104b38878 <_Flutter_MMFoundation_BindContext+0x101445c>
104b387c0: 7100881f    	cmp	w0, #0x22
104b387c4: 54000681    	b.ne	0x104b38894 <_Flutter_MMFoundation_BindContext+0x1014478>
104b387c8: d00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b387cc: f9452101    	ldr	x1, [x8, #0xa40] ; SaveMesVoice:MsgWrap:
104b387d0: aa1603e0    	mov	x0, x22
104b387d4: 1400002d    	b	0x104b38888 <_Flutter_MMFoundation_BindContext+0x101446c>
104b387d8: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b387dc: f9453515    	ldr	x21, [x8, #0xa68] ; �gH 
104b387e0: f00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b387e4: f9454516    	ldr	x22, [x8, #0xa88]
104b387e8: f00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b387ec: f940d901    	ldr	x1, [x8, #0x1b0] ; m_nsToUsr
104b387f0: aa1403e0    	mov	x0, x20
104b387f4: 94c3ba52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b387f8: aa1d03fd    	mov	x29, x29
104b387fc: 94c3ba53    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b38800: aa0003f7    	mov	x23, x0
104b38804: 900d9828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b38808: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b3880c: aa1603e0    	mov	x0, x22
104b38810: aa1703e2    	mov	x2, x23
104b38814: 94c3ba4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38818: aa1d03fd    	mov	x29, x29
104b3881c: 94c3ba4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b38820: aa0003f6    	mov	x22, x0
104b38824: b00d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b38828: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3882c: 900cd248    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b38830: 9109a108    	add	x8, x8, #0x268
104b38834: a90003e8    	stp	x8, x0, [sp]
104b38838: b00b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3883c: 9107f063    	add	x3, x3, #0x1fc
104b38840: 900b6625    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b38844: 910cb4a5    	add	x5, x5, #0x32d
104b38848: b00b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b3884c: 9139f0e7    	add	x7, x7, #0xe7c
104b38850: aa1503e0    	mov	x0, x21
104b38854: 52800082    	mov	w2, #0x4                ; =4
104b38858: 52800004    	mov	w4, #0x0                ; =0
104b3885c: 52818406    	mov	w6, #0xc20              ; =3104
104b38860: 94c3ba37    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38864: aa1603e0    	mov	x0, x22
104b38868: 94c3ba3b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3886c: aa1703e0    	mov	x0, x23
104b38870: 94c3ba39    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b38874: 17ffff64    	b	0x104b38604 <_Flutter_MMFoundation_BindContext+0x10141e8>
104b38878: 900db208    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
104b3887c: f9479100    	ldr	x0, [x8, #0xf20] ; �D/ 
104b38880: b00d9968    	adrp	x8, 0x11fe65000 <dyld_stub_binder+0x11fe65000>
104b38884: f9413501    	ldr	x1, [x8, #0x268] ; SaveMsgThumb:MsgWrap:
104b38888: aa1303e2    	mov	x2, x19
104b3888c: aa1403e3    	mov	x3, x20
104b38890: 94c3ba2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b38894: f9465721    	ldr	x1, [x25, #0xca8] ; ChangeForDisplay
104b38898: aa1403e0    	mov	x0, x20
104b3889c: 94c3ba28    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b388a0: d00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b388a4: f9440101    	ldr	x1, [x8, #0x800] ; AsyncOnPreAddMsg:MsgWrap:
104b388a8: aa1603e0    	mov	x0, x22
104b388ac: aa1303e2    	mov	x2, x19
104b388b0: aa1403e3    	mov	x3, x20
104b388b4: 94c3ba22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b388b8: d00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b388bc: f9440501    	ldr	x1, [x8, #0x808] ; AsyncOnAddMsg:MsgWrap:
104b388c0: aa1603e0    	mov	x0, x22
104b388c4: aa1303e2    	mov	x2, x19
104b388c8: aa1403e3    	mov	x3, x20
104b388cc: 94c3ba1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b388d0: d00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b388d4: f9435d01    	ldr	x1, [x8, #0x6b8] ; AsyncOnAddMsgForSession:MsgWrap:NewMsgArriveNotify:
104b388d8: aa1603e0    	mov	x0, x22
104b388dc: aa1303e2    	mov	x2, x19
104b388e0: aa1403e3    	mov	x3, x20
104b388e4: aa1503e4    	mov	x4, x21
104b388e8: 94c3ba15    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b388ec: 17ffff46    	b	0x104b38604 <_Flutter_MMFoundation_BindContext+0x10141e8>