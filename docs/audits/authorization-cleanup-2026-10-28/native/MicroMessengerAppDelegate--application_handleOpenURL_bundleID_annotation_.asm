
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104bd3530: d10203ff    	sub	sp, sp, #0x80
104bd3534: a9026ffc    	stp	x28, x27, [sp, #0x20]
104bd3538: a90367fa    	stp	x26, x25, [sp, #0x30]
104bd353c: a9045ff8    	stp	x24, x23, [sp, #0x40]
104bd3540: a90557f6    	stp	x22, x21, [sp, #0x50]
104bd3544: a9064ff4    	stp	x20, x19, [sp, #0x60]
104bd3548: a9077bfd    	stp	x29, x30, [sp, #0x70]
104bd354c: 9101c3fd    	add	x29, sp, #0x70
104bd3550: aa0503f6    	mov	x22, x5
104bd3554: aa0403f5    	mov	x21, x4
104bd3558: aa0303f4    	mov	x20, x3
104bd355c: aa0203f3    	mov	x19, x2
104bd3560: aa0003f7    	mov	x23, x0
104bd3564: f00e0348    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104bd3568: 52800029    	mov	w9, #0x1                ; =1
104bd356c: 391d0909    	strb	w9, [x8, #0x742]
104bd3570: aa0203e0    	mov	x0, x2
104bd3574: 94c14ef1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3578: aa1403e0    	mov	x0, x20
104bd357c: 94c14eef    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3580: aa1503e0    	mov	x0, x21
104bd3584: 94c14eed    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3588: aa1603e0    	mov	x0, x22
104bd358c: 94c14eeb    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd3590: f00da948    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104bd3594: f945c918    	ldr	x24, [x8, #0xb90] ; selector absoluteString
104bd3598: aa1403e0    	mov	x0, x20
104bd359c: aa1803e1    	mov	x1, x24
104bd35a0: 94c14ee7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd35a4: aa1d03fd    	mov	x29, x29
104bd35a8: 94c14ee8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd35ac: aa0003f9    	mov	x25, x0
104bd35b0: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd35b4: f9446901    	ldr	x1, [x8, #0x8d0] ; selector reportHandleOpenUrl:schemeUrl:
104bd35b8: aa1703e0    	mov	x0, x23
104bd35bc: aa1503e2    	mov	x2, x21
104bd35c0: aa1903e3    	mov	x3, x25
104bd35c4: 94c14ede    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd35c8: aa1903e0    	mov	x0, x25
104bd35cc: 94c14ee2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd35d0: aa1403e0    	mov	x0, x20
104bd35d4: aa1803e1    	mov	x1, x24
104bd35d8: 94c14ed9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd35dc: aa1d03fd    	mov	x29, x29
104bd35e0: 94c14eda    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd35e4: aa0003f9    	mov	x25, x0
104bd35e8: f00da968    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104bd35ec: f9444901    	ldr	x1, [x8, #0x890] ; selector hasPrefix:
104bd35f0: b00cdec2    	adrp	x2, 0x11e7ac000 <dyld_stub_binder+0x11e7ac000>
104bd35f4: 91262042    	add	x2, x2, #0x988 ; CFString 'weixinapp://betalogin/'
104bd35f8: 94c14ed1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd35fc: aa0003fa    	mov	x26, x0
104bd3600: aa1903e0    	mov	x0, x25
104bd3604: 94c14ed4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3608: 3400081a    	cbz	w26, 0x104bd3708 <_Flutter_MMFoundation_BindContext+0x10af2ec>
104bd360c: b00dad08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104bd3610: f9408d00    	ldr	x0, [x8, #0x118] ; class CAppViewControllerManager
104bd3614: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd3618: f9442501    	ldr	x1, [x8, #0x848] ; selector hasEnterWechatMain
104bd361c: 94c14ec8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3620: 34000860    	cbz	w0, 0x104bd372c <_Flutter_MMFoundation_BindContext+0x10af310>
104bd3624: aa1403e0    	mov	x0, x20
104bd3628: aa1803e1    	mov	x1, x24
104bd362c: 94c14ec4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3630: aa1d03fd    	mov	x29, x29
104bd3634: 94c14ec5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3638: aa0003f8    	mov	x24, x0
104bd363c: 900da988    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104bd3640: f946e919    	ldr	x25, [x8, #0xdd0] ; selector length
104bd3644: b00cdec0    	adrp	x0, 0x11e7ac000 <dyld_stub_binder+0x11e7ac000>
104bd3648: 91262000    	add	x0, x0, #0x988 ; CFString 'weixinapp://betalogin/'
104bd364c: aa1903e1    	mov	x1, x25
104bd3650: 94c14ebb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3654: aa0003e2    	mov	x2, x0
104bd3658: f00da9a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104bd365c: f9472d01    	ldr	x1, [x8, #0xe58] ; selector substringFromIndex:
104bd3660: aa1803e0    	mov	x0, x24
104bd3664: 94c14eb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3668: aa1d03fd    	mov	x29, x29
104bd366c: 94c14eb7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3670: aa0003f7    	mov	x23, x0
104bd3674: aa1803e0    	mov	x0, x24
104bd3678: 94c14eb7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd367c: aa1703e0    	mov	x0, x23
104bd3680: aa1903e1    	mov	x1, x25
104bd3684: 94c14eae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3688: f100001f    	cmp	x0, #0x0
104bd368c: 1a9f07f9    	cset	w25, ne
104bd3690: b40023e0    	cbz	x0, 0x104bd3b0c <_Flutter_MMFoundation_BindContext+0x10af6f0>
104bd3694: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd3698: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104bd369c: b00da968    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bd36a0: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104bd36a4: 94c14ea6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd36a8: aa1d03fd    	mov	x29, x29
104bd36ac: 94c14ea7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd36b0: aa0003f8    	mov	x24, x0
104bd36b4: d00dad08    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104bd36b8: f942b900    	ldr	x0, [x8, #0x570] ; class PushLoginURLMgr
104bd36bc: 900da968    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104bd36c0: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104bd36c4: 94c14e9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd36c8: aa0003e2    	mov	x2, x0
104bd36cc: d00d9328    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bd36d0: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104bd36d4: aa1803e0    	mov	x0, x24
104bd36d8: 94c14e99    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd36dc: aa1d03fd    	mov	x29, x29
104bd36e0: 94c14e9a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd36e4: aa0003fa    	mov	x26, x0
104bd36e8: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd36ec: f9446d01    	ldr	x1, [x8, #0x8d8] ; selector loginFormOtherApp:bundleID:
104bd36f0: aa1703e2    	mov	x2, x23
104bd36f4: aa1503e3    	mov	x3, x21
104bd36f8: 94c14e91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd36fc: aa1a03e0    	mov	x0, x26
104bd3700: 94c14e95    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3704: 14000100    	b	0x104bd3b04 <_Flutter_MMFoundation_BindContext+0x10af6e8>
104bd3708: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd370c: f9447101    	ldr	x1, [x8, #0x8e0] ; selector handleOpenURL:bundleID:
104bd3710: aa1703e0    	mov	x0, x23
104bd3714: aa1403e2    	mov	x2, x20
104bd3718: aa1503e3    	mov	x3, x21
104bd371c: 94c14e88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3720: 360000a0    	tbz	w0, #0x0, 0x104bd3734 <_Flutter_MMFoundation_BindContext+0x10af318>
104bd3724: 52800039    	mov	w25, #0x1               ; =1
104bd3728: 140000fb    	b	0x104bd3b14 <_Flutter_MMFoundation_BindContext+0x10af6f8>
104bd372c: 52800019    	mov	w25, #0x0               ; =0
104bd3730: 140000f9    	b	0x104bd3b14 <_Flutter_MMFoundation_BindContext+0x10af6f8>
104bd3734: b00d9828    	adrp	x8, 0x11fed8000 <dyld_stub_binder+0x11fed8000>
104bd3738: f9443501    	ldr	x1, [x8, #0x868] ; selector isFileURL
104bd373c: aa1403e0    	mov	x0, x20
104bd3740: 94c14e7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3744: 340007a0    	cbz	w0, 0x104bd3838 <_Flutter_MMFoundation_BindContext+0x10af41c>
104bd3748: d00dad08    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104bd374c: f9420900    	ldr	x0, [x8, #0x410] ; class NSFileManager
104bd3750: b00da968    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bd3754: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector defaultManager
104bd3758: 94c14e79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd375c: aa1d03fd    	mov	x29, x29
104bd3760: 94c14e7a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3764: aa0003f9    	mov	x25, x0
104bd3768: d00da988    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
104bd376c: f9438d01    	ldr	x1, [x8, #0x718] ; selector path
104bd3770: aa1403e0    	mov	x0, x20
104bd3774: 94c14e72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3778: aa1d03fd    	mov	x29, x29
104bd377c: 94c14e73    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3780: aa0003fa    	mov	x26, x0
104bd3784: f9000fff    	str	xzr, [sp, #0x18]
104bd3788: 900da968    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104bd378c: f9423d01    	ldr	x1, [x8, #0x478] ; selector attributesOfItemAtPath:error:
104bd3790: 910063e3    	add	x3, sp, #0x18
104bd3794: aa1903e0    	mov	x0, x25
104bd3798: aa1a03e2    	mov	x2, x26
104bd379c: 94c14e68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd37a0: aa1d03fd    	mov	x29, x29
104bd37a4: 94c14e69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd37a8: aa0003f8    	mov	x24, x0
104bd37ac: f9400ff7    	ldr	x23, [sp, #0x18]
104bd37b0: aa1703e0    	mov	x0, x23
104bd37b4: 94c14e61    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104bd37b8: aa1a03e0    	mov	x0, x26
104bd37bc: 94c14e66    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd37c0: aa1903e0    	mov	x0, x25
104bd37c4: 94c14e64    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd37c8: b4000c57    	cbz	x23, 0x104bd3950 <_Flutter_MMFoundation_BindContext+0x10af534>
104bd37cc: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd37d0: f9453519    	ldr	x25, [x8, #0xa68] ; class iConsole
104bd37d4: 900da988    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104bd37d8: f947f901    	ldr	x1, [x8, #0xff0] ; selector localizedDescription
104bd37dc: aa1703e0    	mov	x0, x23
104bd37e0: 94c14e57    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd37e4: aa1d03fd    	mov	x29, x29
104bd37e8: 94c14e58    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd37ec: aa0003fa    	mov	x26, x0
104bd37f0: d00d9328    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bd37f4: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104bd37f8: b00cdec8    	adrp	x8, 0x11e7ac000 <dyld_stub_binder+0x11e7ac000>
104bd37fc: 91272108    	add	x8, x8, #0x9c8 ; CFString 'handle open url error:%@'
104bd3800: a90003e8    	stp	x8, x0, [sp]
104bd3804: d00b61a5    	adrp	x5, 0x11b809000 <dyld_stub_binder+0x11b809000>
104bd3808: 9114a0a5    	add	x5, x5, #0x528 ; string 'MicroMessengerAppDelegate.mm'
104bd380c: 900b61c7    	adrp	x7, 0x11b80b000 <dyld_stub_binder+0x11b80b000>
104bd3810: 9107bce7    	add	x7, x7, #0x1ef ; string '-[MicroMessengerAppDelegate application:handleOpenURL:bundleID:annotation:]'
104bd3814: aa1903e0    	mov	x0, x25
104bd3818: 52800082    	mov	w2, #0x4                ; =4
104bd381c: d2800003    	mov	x3, #0x0                ; =0
104bd3820: 52800004    	mov	w4, #0x0                ; =0
104bd3824: 52813ec6    	mov	w6, #0x9f6              ; =2550
104bd3828: 94c14e45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd382c: aa1a03e0    	mov	x0, x26
104bd3830: 94c14e49    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3834: 140000b3    	b	0x104bd3b00 <_Flutter_MMFoundation_BindContext+0x10af6e4>
104bd3838: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd383c: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104bd3840: b00da968    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bd3844: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104bd3848: 94c14e3d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd384c: aa1d03fd    	mov	x29, x29
104bd3850: 94c14e3e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3854: aa0003f8    	mov	x24, x0
104bd3858: 900dad68    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
104bd385c: f945c900    	ldr	x0, [x8, #0xb90] ; class MMFacebookMgr
104bd3860: 900da968    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104bd3864: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104bd3868: 94c14e35    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd386c: aa0003e2    	mov	x2, x0
104bd3870: d00d9328    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bd3874: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104bd3878: aa1803e0    	mov	x0, x24
104bd387c: 94c14e30    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3880: aa1d03fd    	mov	x29, x29
104bd3884: 94c14e31    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3888: aa0003f7    	mov	x23, x0
104bd388c: aa1803e0    	mov	x0, x24
104bd3890: 94c14e31    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3894: 900d9948    	adrp	x8, 0x11fefb000 <dyld_stub_binder+0x11fefb000>
104bd3898: f944d901    	ldr	x1, [x8, #0x9b0] ; selector hasInitSDK
104bd389c: aa1703e0    	mov	x0, x23
104bd38a0: 94c14e27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd38a4: 34000520    	cbz	w0, 0x104bd3948 <_Flutter_MMFoundation_BindContext+0x10af52c>
104bd38a8: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd38ac: f9447d01    	ldr	x1, [x8, #0x8f8] ; selector needSetFacebookUsageType
104bd38b0: aa1703e0    	mov	x0, x23
104bd38b4: 94c14e22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd38b8: 34000320    	cbz	w0, 0x104bd391c <_Flutter_MMFoundation_BindContext+0x10af500>
104bd38bc: b00dad08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104bd38c0: f9408d00    	ldr	x0, [x8, #0x118] ; class CAppViewControllerManager
104bd38c4: b00d9348    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104bd38c8: f9423901    	ldr	x1, [x8, #0x470] ; selector getAppViewControllerManager
104bd38cc: 94c14e1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd38d0: aa1d03fd    	mov	x29, x29
104bd38d4: 94c14e1d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd38d8: aa0003f8    	mov	x24, x0
104bd38dc: d00d9348    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104bd38e0: f9412101    	ldr	x1, [x8, #0x240] ; selector getNewMainFrameViewController
104bd38e4: 94c14e16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd38e8: aa1d03fd    	mov	x29, x29
104bd38ec: 94c14e17    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd38f0: aa0003f9    	mov	x25, x0
104bd38f4: 94c14e18    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd38f8: f100033f    	cmp	x25, #0x0
104bd38fc: 52800028    	mov	w8, #0x1                ; =1
104bd3900: 9a881502    	cinc	x2, x8, eq
104bd3904: 900d9948    	adrp	x8, 0x11fefb000 <dyld_stub_binder+0x11fefb000>
104bd3908: f944c101    	ldr	x1, [x8, #0x980] ; selector setFacebookUsageType:
104bd390c: aa1703e0    	mov	x0, x23
104bd3910: 94c14e0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3914: aa1803e0    	mov	x0, x24
104bd3918: 94c14e0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd391c: 900d9948    	adrp	x8, 0x11fefb000 <dyld_stub_binder+0x11fefb000>
104bd3920: f944bd01    	ldr	x1, [x8, #0x978] ; selector application:openURL:sourceApplication:annotation:
104bd3924: aa1703e0    	mov	x0, x23
104bd3928: aa1303e2    	mov	x2, x19
104bd392c: aa1403e3    	mov	x3, x20
104bd3930: aa1503e4    	mov	x4, x21
104bd3934: aa1603e5    	mov	x5, x22
104bd3938: 94c14e01    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd393c: 36000060    	tbz	w0, #0x0, 0x104bd3948 <_Flutter_MMFoundation_BindContext+0x10af52c>
104bd3940: 52800039    	mov	w25, #0x1               ; =1
104bd3944: 14000072    	b	0x104bd3b0c <_Flutter_MMFoundation_BindContext+0x10af6f0>
104bd3948: 52800019    	mov	w25, #0x0               ; =0
104bd394c: 14000070    	b	0x104bd3b0c <_Flutter_MMFoundation_BindContext+0x10af6f0>
104bd3950: 900c50c8    	adrp	x8, 0x11d5eb000 <dyld_stub_binder+0x11d5eb000>
104bd3954: f9457d08    	ldr	x8, [x8, #0xaf8]
104bd3958: f9400102    	ldr	x2, [x8]
104bd395c: b00da988    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104bd3960: f947f101    	ldr	x1, [x8, #0xfe0] ; selector objectForKey:
104bd3964: aa1803e0    	mov	x0, x24
104bd3968: 94c14df5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd396c: aa1d03fd    	mov	x29, x29
104bd3970: 94c14df6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3974: aa0003fa    	mov	x26, x0
104bd3978: 900da9c8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104bd397c: f9425101    	ldr	x1, [x8, #0x4a0] ; selector unsignedLongLongValue
104bd3980: 94c14def    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3984: aa0003f9    	mov	x25, x0
104bd3988: aa1a03e0    	mov	x0, x26
104bd398c: 94c14df2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3990: 52800028    	mov	w8, #0x1                ; =1
104bd3994: 72a10008    	movk	w8, #0x800, lsl #16
104bd3998: eb08033f    	cmp	x25, x8
104bd399c: 54000882    	b.hs	0x104bd3aac <_Flutter_MMFoundation_BindContext+0x10af690>
104bd39a0: b00dad08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104bd39a4: f943a500    	ldr	x0, [x8, #0x748] ; class OpenApiMgrHelper
104bd39a8: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd39ac: f9447501    	ldr	x1, [x8, #0x8e8] ; selector makeFileAppCommunicateData:
104bd39b0: aa1403e2    	mov	x2, x20
104bd39b4: 94c14de2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd39b8: aa1d03fd    	mov	x29, x29
104bd39bc: 94c14de3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd39c0: aa0003f9    	mov	x25, x0
104bd39c4: f9000be0    	str	x0, [sp, #0x10]
104bd39c8: 900dae08    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
104bd39cc: f940e100    	ldr	x0, [x8, #0x1c0] ; class OpenApiParameter
104bd39d0: 94c14de2    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104bd39d4: aa0003fb    	mov	x27, x0
104bd39d8: f00d9348    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104bd39dc: f9407501    	ldr	x1, [x8, #0xe8] ; selector setAppID:
104bd39e0: 900ccfc2    	adrp	x2, 0x11e5cb000 <dyld_stub_binder+0x11e5cb000>
104bd39e4: 9139a042    	add	x2, x2, #0xe68 ; CFString 'wx4310bbd51be7d979'
104bd39e8: 94c14dd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd39ec: b00d97e8    	adrp	x8, 0x11fed0000 <dyld_stub_binder+0x11fed0000>
104bd39f0: f9434101    	ldr	x1, [x8, #0x680] ; selector setBundleID:
104bd39f4: aa1b03e0    	mov	x0, x27
104bd39f8: aa1503e2    	mov	x2, x21
104bd39fc: 94c14dd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3a00: d00d97a8    	adrp	x8, 0x11fec9000 <dyld_stub_binder+0x11fec9000>
104bd3a04: f9449901    	ldr	x1, [x8, #0x930] ; selector setAppData:
104bd3a08: aa1b03e0    	mov	x0, x27
104bd3a0c: aa1903e2    	mov	x2, x25
104bd3a10: 94c14dcb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3a14: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd3a18: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104bd3a1c: b00da968    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104bd3a20: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
104bd3a24: 94c14dc6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3a28: aa1d03fd    	mov	x29, x29
104bd3a2c: 94c14dc7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3a30: aa0003fc    	mov	x28, x0
104bd3a34: b00dad08    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104bd3a38: f943b500    	ldr	x0, [x8, #0x768] ; class OpenApiMgr
104bd3a3c: 900da968    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104bd3a40: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
104bd3a44: 94c14dbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3a48: aa0003e2    	mov	x2, x0
104bd3a4c: d00d9328    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bd3a50: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
104bd3a54: aa1c03e0    	mov	x0, x28
104bd3a58: 94c14db9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3a5c: aa1d03fd    	mov	x29, x29
104bd3a60: 94c14dba    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104bd3a64: aa0003fa    	mov	x26, x0
104bd3a68: b00d9da8    	adrp	x8, 0x11ff88000 <dyld_stub_binder+0x11ff88000>
104bd3a6c: f9447901    	ldr	x1, [x8, #0x8f0] ; selector doShareApi:bundleID:fromSysCopy:parameter:
104bd3a70: 52800039    	mov	w25, #0x1               ; =1
104bd3a74: 900ccfc2    	adrp	x2, 0x11e5cb000 <dyld_stub_binder+0x11e5cb000>
104bd3a78: 9139a042    	add	x2, x2, #0xe68 ; CFString 'wx4310bbd51be7d979'
104bd3a7c: aa1503e3    	mov	x3, x21
104bd3a80: 52800024    	mov	w4, #0x1                ; =1
104bd3a84: aa1b03e5    	mov	x5, x27
104bd3a88: 94c14dad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3a8c: aa1a03e0    	mov	x0, x26
104bd3a90: 94c14db1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3a94: aa1c03e0    	mov	x0, x28
104bd3a98: 94c14daf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3a9c: aa1b03e0    	mov	x0, x27
104bd3aa0: 94c14dad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3aa4: f9400be0    	ldr	x0, [sp, #0x10]
104bd3aa8: 17ffff16    	b	0x104bd3700 <_Flutter_MMFoundation_BindContext+0x10af2e4>
104bd3aac: 900dad08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104bd3ab0: 9e43db20    	ucvtf	d0, x25, #0xa
104bd3ab4: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104bd3ab8: d2e7ea08    	mov	x8, #0x3f50000000000000 ; =4562146422526312448
104bd3abc: 9e670101    	fmov	d1, x8
104bd3ac0: 1e610800    	fmul	d0, d0, d1
104bd3ac4: d00d9328    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104bd3ac8: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104bd3acc: fd0007e0    	str	d0, [sp, #0x8]
104bd3ad0: b00cdec8    	adrp	x8, 0x11e7ac000 <dyld_stub_binder+0x11e7ac000>
104bd3ad4: 9126a108    	add	x8, x8, #0x9a8 ; CFString 'file size over limit 128MB, fileSize:%0.3fMB'
104bd3ad8: f90003e8    	str	x8, [sp]
104bd3adc: d00b61a5    	adrp	x5, 0x11b809000 <dyld_stub_binder+0x11b809000>
104bd3ae0: 9114a0a5    	add	x5, x5, #0x528 ; string 'MicroMessengerAppDelegate.mm'
104bd3ae4: 900b61c7    	adrp	x7, 0x11b80b000 <dyld_stub_binder+0x11b80b000>
104bd3ae8: 9107bce7    	add	x7, x7, #0x1ef ; string '-[MicroMessengerAppDelegate application:handleOpenURL:bundleID:annotation:]'
104bd3aec: 52800082    	mov	w2, #0x4                ; =4
104bd3af0: d2800003    	mov	x3, #0x0                ; =0
104bd3af4: 52800004    	mov	w4, #0x0                ; =0
104bd3af8: 52813d66    	mov	w6, #0x9eb              ; =2539
104bd3afc: 94c14d90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104bd3b00: 52800019    	mov	w25, #0x0               ; =0
104bd3b04: aa1803e0    	mov	x0, x24
104bd3b08: 94c14d93    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3b0c: aa1703e0    	mov	x0, x23
104bd3b10: 94c14d91    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3b14: aa1603e0    	mov	x0, x22
104bd3b18: 94c14d8f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3b1c: aa1503e0    	mov	x0, x21
104bd3b20: 94c14d8d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3b24: aa1403e0    	mov	x0, x20
104bd3b28: 94c14d8b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3b2c: aa1303e0    	mov	x0, x19
104bd3b30: 94c14d89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104bd3b34: aa1903e0    	mov	x0, x25
104bd3b38: a9477bfd    	ldp	x29, x30, [sp, #0x70]
104bd3b3c: a9464ff4    	ldp	x20, x19, [sp, #0x60]
104bd3b40: a94557f6    	ldp	x22, x21, [sp, #0x50]
104bd3b44: a9445ff8    	ldp	x24, x23, [sp, #0x40]
104bd3b48: a94367fa    	ldp	x26, x25, [sp, #0x30]
104bd3b4c: a9426ffc    	ldp	x28, x27, [sp, #0x20]
104bd3b50: 910203ff    	add	sp, sp, #0x80
104bd3b54: d65f03c0    	ret
