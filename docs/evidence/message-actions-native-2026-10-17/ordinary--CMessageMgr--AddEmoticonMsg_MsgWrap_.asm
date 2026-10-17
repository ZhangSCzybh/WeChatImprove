
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b39674: d10183ff    	sub	sp, sp, #0x60
104b39678: a90167fa    	stp	x26, x25, [sp, #0x10]
104b3967c: a9025ff8    	stp	x24, x23, [sp, #0x20]
104b39680: a90357f6    	stp	x22, x21, [sp, #0x30]
104b39684: a9044ff4    	stp	x20, x19, [sp, #0x40]
104b39688: a9057bfd    	stp	x29, x30, [sp, #0x50]
104b3968c: 910143fd    	add	x29, sp, #0x50
104b39690: aa0303f4    	mov	x20, x3
104b39694: aa0203f3    	mov	x19, x2
104b39698: aa0003f5    	mov	x21, x0
104b3969c: b00e0828    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b396a0: 52800029    	mov	w9, #0x1                ; =1
104b396a4: 3915bd09    	strb	w9, [x8, #0x56f]
104b396a8: aa0203e0    	mov	x0, x2
104b396ac: 94c3b6a3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b396b0: aa1403e0    	mov	x0, x20
104b396b4: 94c3b6a1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b396b8: b00d9839    	adrp	x25, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104b396bc: b4001074    	cbz	x20, 0x104b398c8 <_Flutter_MMFoundation_BindContext+0x10154ac>
104b396c0: d00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b396c4: f940b101    	ldr	x1, [x8, #0x160] ; m_nsEmoticonMD5
104b396c8: aa1403e0    	mov	x0, x20
104b396cc: 94c3b69c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b396d0: aa1d03fd    	mov	x29, x29
104b396d4: 94c3b69d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b396d8: aa0003f7    	mov	x23, x0
104b396dc: d00dae48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104b396e0: f946e916    	ldr	x22, [x8, #0xdd0] ; length
104b396e4: aa1603e1    	mov	x1, x22
104b396e8: 94c3b695    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b396ec: b4000ea0    	cbz	x0, 0x104b398c0 <_Flutter_MMFoundation_BindContext+0x10154a4>
104b396f0: f9413f21    	ldr	x1, [x25, #0x278] ; m_uiMessageType
104b396f4: aa1403e0    	mov	x0, x20
104b396f8: 94c3b691    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b396fc: aa0003f8    	mov	x24, x0
104b39700: aa1703e0    	mov	x0, x23
104b39704: 94c3b694    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b39708: 7100bf1f    	cmp	w24, #0x2f
104b3970c: 54000de1    	b.ne	0x104b398c8 <_Flutter_MMFoundation_BindContext+0x10154ac>
104b39710: d00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b39714: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
104b39718: aa1403e0    	mov	x0, x20
104b3971c: d2800002    	mov	x2, #0x0                ; =0
104b39720: 94c3b687    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39724: d00db748    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b39728: b9895508    	ldrsw	x8, [x8, #0x954]
104b3972c: f8686aa0    	ldr	x0, [x21, x8]
104b39730: d00d9848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b39734: f945a501    	ldr	x1, [x8, #0xb48] ; AddMsg:MsgWrap:
104b39738: aa1303e2    	mov	x2, x19
104b3973c: aa1403e3    	mov	x3, x20
104b39740: 94c3b67f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39744: f00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b39748: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b3974c: aa1403e0    	mov	x0, x20
104b39750: 94c3b67b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39754: 34000f80    	cbz	w0, 0x104b39944 <_Flutter_MMFoundation_BindContext+0x1015528>
104b39758: d00d9888    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104b3975c: f9406917    	ldr	x23, [x8, #0xd0] ; revokeBatchId
104b39760: aa1403e0    	mov	x0, x20
104b39764: aa1703e1    	mov	x1, x23
104b39768: 94c3b675    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3976c: aa1d03fd    	mov	x29, x29
104b39770: 94c3b676    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b39774: aa0003f8    	mov	x24, x0
104b39778: aa1603e1    	mov	x1, x22
104b3977c: 94c3b670    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39780: aa0003f6    	mov	x22, x0
104b39784: aa1803e0    	mov	x0, x24
104b39788: 94c3b673    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3978c: b4000536    	cbz	x22, 0x104b39830 <_Flutter_MMFoundation_BindContext+0x1015414>
104b39790: d00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b39794: f945e900    	ldr	x0, [x8, #0xbd0]
104b39798: f00dae28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b3979c: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104b397a0: 94c3b667    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b397a4: aa1d03fd    	mov	x29, x29
104b397a8: 94c3b668    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b397ac: aa0003f6    	mov	x22, x0
104b397b0: b00db1e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
104b397b4: f940f500    	ldr	x0, [x8, #0x1e8] ; ا7 
104b397b8: d00dae28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104b397bc: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104b397c0: 94c3b65f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b397c4: aa0003e2    	mov	x2, x0
104b397c8: 900d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b397cc: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104b397d0: aa1603e0    	mov	x0, x22
104b397d4: 94c3b65a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b397d8: aa1d03fd    	mov	x29, x29
104b397dc: 94c3b65b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b397e0: aa0003f8    	mov	x24, x0
104b397e4: aa1403e0    	mov	x0, x20
104b397e8: aa1703e1    	mov	x1, x23
104b397ec: 94c3b654    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b397f0: aa1d03fd    	mov	x29, x29
104b397f4: 94c3b655    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b397f8: aa0003f7    	mov	x23, x0
104b397fc: b00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b39800: f943dd01    	ldr	x1, [x8, #0x7b8] ; addBatchSendForUser:record:identifier:
104b39804: aa1803e0    	mov	x0, x24
104b39808: aa1303e2    	mov	x2, x19
104b3980c: aa1403e3    	mov	x3, x20
104b39810: aa1703e4    	mov	x4, x23
104b39814: 94c3b64a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39818: aa1703e0    	mov	x0, x23
104b3981c: 94c3b64e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b39820: aa1803e0    	mov	x0, x24
104b39824: 94c3b64c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b39828: aa1603e0    	mov	x0, x22
104b3982c: 94c3b64a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b39830: d00db1d6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b39834: f9467ac0    	ldr	x0, [x22, #0xcf0]
104b39838: f00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b3983c: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
104b39840: 94c3b63f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39844: aa0003e2    	mov	x2, x0
104b39848: 900d9948    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b3984c: f943a501    	ldr	x1, [x8, #0x748] ; setM_uiSendTime:
104b39850: aa1403e0    	mov	x0, x20
104b39854: 94c3b63a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39858: b00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b3985c: f9440101    	ldr	x1, [x8, #0x800] ; AsyncOnPreAddMsg:MsgWrap:
104b39860: aa1503e0    	mov	x0, x21
104b39864: aa1303e2    	mov	x2, x19
104b39868: aa1403e3    	mov	x3, x20
104b3986c: 94c3b634    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39870: b00da268    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104b39874: f9440501    	ldr	x1, [x8, #0x808] ; AsyncOnAddMsg:MsgWrap:
104b39878: aa1503e0    	mov	x0, x21
104b3987c: aa1303e2    	mov	x2, x19
104b39880: aa1403e3    	mov	x3, x20
104b39884: 94c3b62e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39888: d00d9928    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
104b3988c: f944ed01    	ldr	x1, [x8, #0x9d8] ; AsyncOnAddMsgForSession:MsgWrap:
104b39890: aa1503e0    	mov	x0, x21
104b39894: aa1303e2    	mov	x2, x19
104b39898: aa1403e3    	mov	x3, x20
104b3989c: 94c3b628    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b398a0: 900d9948    	adrp	x8, 0x11fe61000 <dyld_stub_binder+0x11fe61000>
104b398a4: f9452d01    	ldr	x1, [x8, #0xa58] ; IsBypassMessage
104b398a8: aa1403e0    	mov	x0, x20
104b398ac: 94c3b624    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b398b0: 340009a0    	cbz	w0, 0x104b399e4 <_Flutter_MMFoundation_BindContext+0x10155c8>
104b398b4: d00db748    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b398b8: b9897908    	ldrsw	x8, [x8, #0x978]
104b398bc: 1400005a    	b	0x104b39a24 <_Flutter_MMFoundation_BindContext+0x1015608>
104b398c0: aa1703e0    	mov	x0, x23
104b398c4: 94c3b624    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b398c8: d00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b398cc: f9453515    	ldr	x21, [x8, #0xa68]
104b398d0: f9413f21    	ldr	x1, [x25, #0x278] ; m_uiMessageType
104b398d4: aa1403e0    	mov	x0, x20
104b398d8: 94c3b619    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b398dc: 900d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b398e0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b398e4: f00ce348    	adrp	x8, 0x11e7a4000 <dyld_stub_binder+0x11e7a4000>
104b398e8: 9139a108    	add	x8, x8, #0xe68
104b398ec: a90003e8    	stp	x8, x0, [sp]
104b398f0: 900b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b398f4: 9107f063    	add	x3, x3, #0x1fc
104b398f8: f00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b398fc: 910cb4a5    	add	x5, x5, #0x32d
104b39900: 900b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b39904: 913c30e7    	add	x7, x7, #0xf0c
104b39908: aa1503e0    	mov	x0, x21
104b3990c: 52800082    	mov	w2, #0x4                ; =4
104b39910: 52800004    	mov	w4, #0x0                ; =0
104b39914: 52819786    	mov	w6, #0xcbc              ; =3260
104b39918: 94c3b609    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3991c: aa1403e0    	mov	x0, x20
104b39920: 94c3b60d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b39924: aa1303e0    	mov	x0, x19
104b39928: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104b3992c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104b39930: a94357f6    	ldp	x22, x21, [sp, #0x30]
104b39934: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104b39938: a94167fa    	ldp	x26, x25, [sp, #0x10]
104b3993c: 910183ff    	add	sp, sp, #0x60
104b39940: 14c3b605    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b39944: d00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b39948: f9453515    	ldr	x21, [x8, #0xa68]
104b3994c: d00db1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b39950: f9454516    	ldr	x22, [x8, #0xa88]
104b39954: d00d9828    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b39958: f940d901    	ldr	x1, [x8, #0x1b0] ; m_nsToUsr
104b3995c: aa1403e0    	mov	x0, x20
104b39960: 94c3b5f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39964: aa1d03fd    	mov	x29, x29
104b39968: 94c3b5f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3996c: aa0003f7    	mov	x23, x0
104b39970: f00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b39974: f947c901    	ldr	x1, [x8, #0xf90] ; generatePrivacyString:
104b39978: aa1603e0    	mov	x0, x22
104b3997c: aa1703e2    	mov	x2, x23
104b39980: 94c3b5ef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39984: aa1d03fd    	mov	x29, x29
104b39988: 94c3b5f0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3998c: aa0003f6    	mov	x22, x0
104b39990: 900d9808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b39994: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b39998: f00cd228    	adrp	x8, 0x11e580000 <dyld_stub_binder+0x11e580000>
104b3999c: 9109a108    	add	x8, x8, #0x268
104b399a0: a90003e8    	stp	x8, x0, [sp]
104b399a4: 900b3763    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b399a8: 9107f063    	add	x3, x3, #0x1fc
104b399ac: f00b6605    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b399b0: 910cb4a5    	add	x5, x5, #0x32d
104b399b4: 900b6627    	adrp	x7, 0x11b7fd000 <dyld_stub_binder+0x11b7fd000>
104b399b8: 913c30e7    	add	x7, x7, #0xf0c
104b399bc: aa1503e0    	mov	x0, x21
104b399c0: 52800082    	mov	w2, #0x4                ; =4
104b399c4: 52800004    	mov	w4, #0x0                ; =0
104b399c8: 528198e6    	mov	w6, #0xcc7              ; =3271
104b399cc: 94c3b5dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b399d0: aa1603e0    	mov	x0, x22
104b399d4: 94c3b5e0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b399d8: aa1703e0    	mov	x0, x23
104b399dc: 94c3b5de    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b399e0: 17ffffcf    	b	0x104b3991c <_Flutter_MMFoundation_BindContext+0x1015500>
104b399e4: 900db1e8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104b399e8: f940d500    	ldr	x0, [x8, #0x1a8]
104b399ec: b00d9848    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
104b399f0: f9434501    	ldr	x1, [x8, #0x688] ; getPluginUserNameType:
104b399f4: aa1303e2    	mov	x2, x19
104b399f8: 94c3b5d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b399fc: f100141f    	cmp	x0, #0x5
104b39a00: 540000e1    	b.ne	0x104b39a1c <_Flutter_MMFoundation_BindContext+0x1015600>
104b39a04: f9467ac0    	ldr	x0, [x22, #0xcf0]
104b39a08: d00d9848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b39a0c: f9465901    	ldr	x1, [x8, #0xcb0] ; CheckSyncMediaNote:
104b39a10: aa1303e2    	mov	x2, x19
104b39a14: 94c3b5ca    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39a18: 34000120    	cbz	w0, 0x104b39a3c <_Flutter_MMFoundation_BindContext+0x1015620>
104b39a1c: d00db748    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104b39a20: b9897108    	ldrsw	x8, [x8, #0x970]
104b39a24: f8686aa0    	ldr	x0, [x21, x8]
104b39a28: b00d9c88    	adrp	x8, 0x11feca000 <dyld_stub_binder+0x11feca000>
104b39a2c: f946ad01    	ldr	x1, [x8, #0xd58] ; StartUpload:
104b39a30: aa1403e2    	mov	x2, x20
104b39a34: 94c3b5c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39a38: 17ffffb9    	b	0x104b3991c <_Flutter_MMFoundation_BindContext+0x1015500>
104b39a3c: f00d9808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b39a40: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
104b39a44: aa1403e0    	mov	x0, x20
104b39a48: 52800042    	mov	w2, #0x2                ; =2
104b39a4c: 94c3b5bc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39a50: b00d9888    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104b39a54: f9464901    	ldr	x1, [x8, #0xc90] ; ModMsg:MsgWrap:
104b39a58: aa1503e0    	mov	x0, x21
104b39a5c: aa1303e2    	mov	x2, x19
104b39a60: aa1403e3    	mov	x3, x20
104b39a64: 94c3b5b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b39a68: 17ffffad    	b	0x104b3991c <_Flutter_MMFoundation_BindContext+0x1015500>