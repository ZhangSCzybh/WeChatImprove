
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10517cc7c: d103c3ff    	sub	sp, sp, #0xf0
10517cc80: 6d0823e9    	stp	d9, d8, [sp, #0x80]
10517cc84: a9096ffc    	stp	x28, x27, [sp, #0x90]
10517cc88: a90a67fa    	stp	x26, x25, [sp, #0xa0]
10517cc8c: a90b5ff8    	stp	x24, x23, [sp, #0xb0]
10517cc90: a90c57f6    	stp	x22, x21, [sp, #0xc0]
10517cc94: a90d4ff4    	stp	x20, x19, [sp, #0xd0]
10517cc98: a90e7bfd    	stp	x29, x30, [sp, #0xe0]
10517cc9c: 910383fd    	add	x29, sp, #0xe0
10517cca0: aa0303f4    	mov	x20, x3
10517cca4: aa0203f3    	mov	x19, x2
10517cca8: aa0003f8    	mov	x24, x0
10517ccac: f00dd608    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10517ccb0: 52800029    	mov	w9, #0x1                ; =1
10517ccb4: 39331109    	strb	w9, [x8, #0xcc4]
10517ccb8: aa0203e0    	mov	x0, x2
10517ccbc: 94aaa91f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10517ccc0: 3900029f    	strb	wzr, [x20]
10517ccc4: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517ccc8: f9457100    	ldr	x0, [x8, #0xae0] ; bind _OBJC_CLASS_$_NSDate
10517cccc: 900d7c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517ccd0: f9460d01    	ldr	x1, [x8, #0xc18] ; selector/string date
10517ccd4: 94aaa91a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ccd8: aa1d03fd    	mov	x29, x29
10517ccdc: 94aaa91b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cce0: aa0003f4    	mov	x20, x0
10517cce4: f00d7c68    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10517cce8: f940a901    	ldr	x1, [x8, #0x150] ; selector/string timeIntervalSince1970
10517ccec: 94aaa914    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ccf0: 1e604008    	fmov	d8, d0
10517ccf4: aa1403e0    	mov	x0, x20
10517ccf8: 94aaa917    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517ccfc: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cd00: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
10517cd04: d00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517cd08: f940ad15    	ldr	x21, [x8, #0x158] ; selector/string genCurrentTimeInMs
10517cd0c: aa1503e1    	mov	x1, x21
10517cd10: 94aaa90b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cd14: aa0003fc    	mov	x28, x0
10517cd18: f00d7fba    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10517cd1c: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext
10517cd20: 900d7c28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517cd24: f944e917    	ldr	x23, [x8, #0x9d0] ; selector/string currentContext
10517cd28: aa1703e1    	mov	x1, x23
10517cd2c: 94aaa904    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cd30: aa1d03fd    	mov	x29, x29
10517cd34: 94aaa905    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cd38: aa0003f4    	mov	x20, x0
10517cd3c: 900d6608    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10517cd40: f9453501    	ldr	x1, [x8, #0xa68] ; selector/string userName
10517cd44: 94aaa8fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cd48: aa1d03fd    	mov	x29, x29
10517cd4c: 94aaa8ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cd50: aa0003f6    	mov	x22, x0
10517cd54: f00d7c28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10517cd58: f946e901    	ldr	x1, [x8, #0xdd0] ; selector/string length
10517cd5c: 94aaa8f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cd60: aa0003f9    	mov	x25, x0
10517cd64: aa1603e0    	mov	x0, x22
10517cd68: 94aaa8fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cd6c: aa1403e0    	mov	x0, x20
10517cd70: 94aaa8f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cd74: b4001039    	cbz	x25, 0x10517cf78 <_Flutter_MMFoundation_BindContext+0x1658b5c>
10517cd78: f00d65e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10517cd7c: f9447d01    	ldr	x1, [x8, #0x8f8] ; selector/string m_pbResponse
10517cd80: aa1303e0    	mov	x0, x19
10517cd84: 94aaa8ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cd88: aa1d03fd    	mov	x29, x29
10517cd8c: 94aaa8ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cd90: aa0003f4    	mov	x20, x0
10517cd94: b40012e0    	cbz	x0, 0x10517cff0 <_Flutter_MMFoundation_BindContext+0x1658bd4>
10517cd98: f00d65e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10517cd9c: f9428116    	ldr	x22, [x8, #0x500] ; selector/string ret
10517cda0: aa1403e0    	mov	x0, x20
10517cda4: aa1603e1    	mov	x1, x22
10517cda8: 94aaa8e5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cdac: 340000c0    	cbz	w0, 0x10517cdc4 <_Flutter_MMFoundation_BindContext+0x16589a8>
10517cdb0: aa1403e0    	mov	x0, x20
10517cdb4: aa1603e1    	mov	x1, x22
10517cdb8: 94aaa8e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cdbc: 311f581f    	cmn	w0, #0x7d6
10517cdc0: 54001541    	b.ne	0x10517d068 <_Flutter_MMFoundation_BindContext+0x1658c4c>
10517cdc4: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext
10517cdc8: aa1703e1    	mov	x1, x23
10517cdcc: 94aaa8dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cdd0: aa1d03fd    	mov	x29, x29
10517cdd4: 94aaa8dd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cdd8: aa0003f6    	mov	x22, x0
10517cddc: b00d7fc8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10517cde0: f9401d00    	ldr	x0, [x8, #0x38] ; class NewSyncService
10517cde4: f00d7c08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10517cde8: f947ad01    	ldr	x1, [x8, #0xf58] ; selector/string class
10517cdec: f9002be1    	str	x1, [sp, #0x50]
10517cdf0: 94aaa8d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cdf4: aa0003e2    	mov	x2, x0
10517cdf8: b00d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517cdfc: f9464101    	ldr	x1, [x8, #0xc80] ; selector/string getService:
10517ce00: aa1603e0    	mov	x0, x22
10517ce04: f90027e1    	str	x1, [sp, #0x48]
10517ce08: 94aaa8cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ce0c: aa1d03fd    	mov	x29, x29
10517ce10: 94aaa8ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517ce14: aa0003fb    	mov	x27, x0
10517ce18: 900d7108    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517ce1c: f9421101    	ldr	x1, [x8, #0x420] ; selector/string markSyncOperating
10517ce20: 94aaa8c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ce24: aa1b03e0    	mov	x0, x27
10517ce28: 94aaa8cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517ce2c: aa1603e0    	mov	x0, x22
10517ce30: 94aaa8c9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517ce34: 900d7108    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517ce38: f942151b    	ldr	x27, [x8, #0x428] ; selector/string svrTime
10517ce3c: aa1403e0    	mov	x0, x20
10517ce40: aa1b03e1    	mov	x1, x27
10517ce44: 94aaa8be    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ce48: 34001e80    	cbz	w0, 0x10517d218 <_Flutter_MMFoundation_BindContext+0x1658dfc>
10517ce4c: 1e790119    	fcvtzu	w25, d8
10517ce50: 900d8568    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10517ce54: b988e11a    	ldrsw	x26, [x8, #0x8e0] ; ivar NewSyncEventHandler.ct1 offset=8 type=I
10517ce58: b87a6b16    	ldr	w22, [x24, x26]
10517ce5c: 4b160328    	sub	w8, w25, w22
10517ce60: 7101dd1f    	cmp	w8, #0x77
10517ce64: 54001da8    	b.hi	0x10517d218 <_Flutter_MMFoundation_BindContext+0x1658dfc>
10517ce68: f90023fc    	str	x28, [sp, #0x40]
10517ce6c: aa1403e0    	mov	x0, x20
10517ce70: aa1b03e1    	mov	x1, x27
10517ce74: 94aaa8b2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517ce78: a90367fa    	stp	x26, x25, [sp, #0x30]
10517ce7c: b87a6b08    	ldr	w8, [x24, x26]
10517ce80: 4b080328    	sub	w8, w25, w8
10517ce84: 0b487d08    	add	w8, w8, w8, lsr #31
10517ce88: 4b0002c9    	sub	w9, w22, w0
10517ce8c: 0b880539    	add	w25, w9, w8, asr #1
10517ce90: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517ce94: f9471100    	ldr	x0, [x8, #0xe20] ; class SettingUtil
10517ce98: d00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517ce9c: f946f11a    	ldr	x26, [x8, #0xde0] ; selector/string getMainSetting
10517cea0: aa1a03e1    	mov	x1, x26
10517cea4: 94aaa8a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cea8: aa1d03fd    	mov	x29, x29
10517ceac: 94aaa8a7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517ceb0: aa0003f6    	mov	x22, x0
10517ceb4: f00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517ceb8: f9478501    	ldr	x1, [x8, #0xf08] ; selector/string m_iDiffTime
10517cebc: 94aaa8a0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cec0: aa0003fc    	mov	x28, x0
10517cec4: aa1603e0    	mov	x0, x22
10517cec8: 94aaa8a3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cecc: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517ced0: f9471100    	ldr	x0, [x8, #0xe20] ; class SettingUtil
10517ced4: aa1a03e1    	mov	x1, x26
10517ced8: 94aaa899    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cedc: aa1d03fd    	mov	x29, x29
10517cee0: 94aaa89a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cee4: aa0003f6    	mov	x22, x0
10517cee8: 6b19039f    	cmp	w28, w25
10517ceec: 54001221    	b.ne	0x10517d130 <_Flutter_MMFoundation_BindContext+0x1658d14>
10517cef0: 900d7108    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517cef4: f9421901    	ldr	x1, [x8, #0x430] ; selector/string m_uStartTime
10517cef8: aa1603e0    	mov	x0, x22
10517cefc: 94aaa890    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cf00: aa0003f8    	mov	x24, x0
10517cf04: aa1603e0    	mov	x0, x22
10517cf08: 94aaa893    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cf0c: f94023fc    	ldr	x28, [sp, #0x40]
10517cf10: 35001858    	cbnz	w24, 0x10517d218 <_Flutter_MMFoundation_BindContext+0x1658dfc>
10517cf14: f00d7fb8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10517cf18: f9467b00    	ldr	x0, [x24, #0xcf0] ; class CUtility
10517cf1c: f00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517cf20: f9478901    	ldr	x1, [x8, #0xf10] ; selector/string genServerCurrentTimeNotABTest
10517cf24: 94aaa886    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cf28: aa0003f6    	mov	x22, x0
10517cf2c: f9467b00    	ldr	x0, [x24, #0xcf0] ; class CUtility
10517cf30: f00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517cf34: f9478d01    	ldr	x1, [x8, #0xf18] ; selector/string getRealUptime
10517cf38: 94aaa881    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cf3c: 4b0002d6    	sub	w22, w22, w0
10517cf40: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cf44: f9471100    	ldr	x0, [x8, #0xe20] ; class SettingUtil
10517cf48: aa1a03e1    	mov	x1, x26
10517cf4c: 94aaa87c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cf50: aa1d03fd    	mov	x29, x29
10517cf54: 94aaa87d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517cf58: aa0003f8    	mov	x24, x0
10517cf5c: f00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517cf60: f9479101    	ldr	x1, [x8, #0xf20] ; selector/string setM_uStartTime:
10517cf64: aa1603e2    	mov	x2, x22
10517cf68: 94aaa875    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cf6c: aa1803e0    	mov	x0, x24
10517cf70: 94aaa879    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517cf74: 140000a9    	b	0x10517d218 <_Flutter_MMFoundation_BindContext+0x1658dfc>
10517cf78: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cf7c: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10517cf80: b00d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517cf84: f942a901    	ldr	x1, [x8, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
10517cf88: f00cb2c8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517cf8c: 912a2108    	add	x8, x8, #0xa88 ; CFString 'invalid setting info, username is nil'
10517cf90: f90003e8    	str	x8, [sp]
10517cf94: 900b0f23    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
10517cf98: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
10517cf9c: d00b3705    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517cfa0: 911d1ca5    	add	x5, x5, #0x747 ; string 'NewSyncEventHandler.mm'
10517cfa4: d00b3707    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517cfa8: 911d78e7    	add	x7, x7, #0x75e ; string '-[NewSyncEventHandler OnProtocolResponse:shouldContinue:]'
10517cfac: 52800062    	mov	w2, #0x3                ; =3
10517cfb0: 52800004    	mov	w4, #0x0                ; =0
10517cfb4: 528006a6    	mov	w6, #0x35               ; =53
10517cfb8: 94aaa861    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517cfbc: 52801200    	mov	w0, #0x90               ; =144
10517cfc0: 528000a1    	mov	w1, #0x5                ; =5
10517cfc4: 52800022    	mov	w2, #0x1                ; =1
10517cfc8: 52800003    	mov	w3, #0x0                ; =0
10517cfcc: 52800004    	mov	w4, #0x0                ; =0
10517cfd0: 97374c6b    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10517cfd4: f00cb2c1    	adrp	x1, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517cfd8: 912aa021    	add	x1, x1, #0xaa8 ; CFString '5,0'
10517cfdc: 52915720    	mov	w0, #0x8ab9             ; =35513
10517cfe0: 52800002    	mov	w2, #0x0                ; =0
10517cfe4: 52800003    	mov	w3, #0x0                ; =0
10517cfe8: 9743bf3e    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
10517cfec: 14000140    	b	0x10517d4ec <_Flutter_MMFoundation_BindContext+0x16590d0>
10517cff0: f00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517cff4: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
10517cff8: b00d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517cffc: f942a901    	ldr	x1, [x8, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
10517d000: d00cb2c8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517d004: 912b2108    	add	x8, x8, #0xac8 ; CFString 'get buffer fail!'
10517d008: f90003e8    	str	x8, [sp]
10517d00c: f00b0f03    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
10517d010: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
10517d014: b00b3705    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517d018: 911d1ca5    	add	x5, x5, #0x747 ; string 'NewSyncEventHandler.mm'
10517d01c: b00b3707    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517d020: 911d78e7    	add	x7, x7, #0x75e ; string '-[NewSyncEventHandler OnProtocolResponse:shouldContinue:]'
10517d024: 52800082    	mov	w2, #0x4                ; =4
10517d028: 52800004    	mov	w4, #0x0                ; =0
10517d02c: 528007a6    	mov	w6, #0x3d               ; =61
10517d030: 94aaa843    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d034: 52801200    	mov	w0, #0x90               ; =144
10517d038: 52800021    	mov	w1, #0x1                ; =1
10517d03c: 52800022    	mov	w2, #0x1                ; =1
10517d040: 52800003    	mov	w3, #0x0                ; =0
10517d044: 52800004    	mov	w4, #0x0                ; =0
10517d048: 97374c4d    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10517d04c: f00c9e41    	adrp	x1, 0x11e548000 <dyld_stub_binder+0x11e548000>
10517d050: 912e2021    	add	x1, x1, #0xb88 ; CFString '1,0'
10517d054: 52915720    	mov	w0, #0x8ab9             ; =35513
10517d058: 52800002    	mov	w2, #0x0                ; =0
10517d05c: 52800003    	mov	w3, #0x0                ; =0
10517d060: 9743bf20    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
10517d064: 14000120    	b	0x10517d4e4 <_Flutter_MMFoundation_BindContext+0x16590c8>
10517d068: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d06c: f9453515    	ldr	x21, [x8, #0xa68] ; class iConsole
10517d070: aa1403e0    	mov	x0, x20
10517d074: aa1603e1    	mov	x1, x22
10517d078: 94aaa831    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d07c: 900d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517d080: f942a901    	ldr	x1, [x8, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
10517d084: d00cb2c8    	adrp	x8, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517d088: 912ba108    	add	x8, x8, #0xae8 ; CFString 'onNewSyncOplogFail ret=%d'
10517d08c: a90003e8    	stp	x8, x0, [sp]
10517d090: f00b0f03    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
10517d094: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
10517d098: b00b3705    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517d09c: 911d1ca5    	add	x5, x5, #0x747 ; string 'NewSyncEventHandler.mm'
10517d0a0: b00b3707    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517d0a4: 911d78e7    	add	x7, x7, #0x75e ; string '-[NewSyncEventHandler OnProtocolResponse:shouldContinue:]'
10517d0a8: aa1503e0    	mov	x0, x21
10517d0ac: 52800082    	mov	w2, #0x4                ; =4
10517d0b0: 52800004    	mov	w4, #0x0                ; =0
10517d0b4: 52800866    	mov	w6, #0x43               ; =67
10517d0b8: 94aaa821    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d0bc: 52801200    	mov	w0, #0x90               ; =144
10517d0c0: 52800041    	mov	w1, #0x2                ; =2
10517d0c4: 52800022    	mov	w2, #0x1                ; =1
10517d0c8: 52800003    	mov	w3, #0x0                ; =0
10517d0cc: 52800004    	mov	w4, #0x0                ; =0
10517d0d0: 97374c2b    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
10517d0d4: d00cb2c1    	adrp	x1, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517d0d8: 912c2021    	add	x1, x1, #0xb08 ; CFString '2,0'
10517d0dc: 52915720    	mov	w0, #0x8ab9             ; =35513
10517d0e0: 52800002    	mov	w2, #0x0                ; =0
10517d0e4: 52800003    	mov	w3, #0x0                ; =0
10517d0e8: 9743befe    	bl	0x10226cce0 <_Flutter_Image_provideRelativePathByUrl+0x679b90>
10517d0ec: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext
10517d0f0: aa1703e1    	mov	x1, x23
10517d0f4: 94aaa812    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d0f8: aa1d03fd    	mov	x29, x29
10517d0fc: 94aaa813    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d100: aa0003f5    	mov	x21, x0
10517d104: f00d7f88    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
10517d108: f9462502    	ldr	x2, [x8, #0xc48]
10517d10c: f00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517d110: f9420d03    	ldr	x3, [x8, #0x418] ; selector/string onNewSyncOplogFail
10517d114: b00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517d118: f940d501    	ldr	x1, [x8, #0x1a8] ; selector/string callExtensionOnMainThread:selector:sync:block:
10517d11c: b00c2785    	adrp	x5, 0x11d66e000 <dyld_stub_binder+0x11d66e000>
10517d120: 911580a5    	add	x5, x5, #0x560
10517d124: 52800004    	mov	w4, #0x0                ; =0
10517d128: 94aaa805    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d12c: 140000ec    	b	0x10517d4dc <_Flutter_MMFoundation_BindContext+0x16590c0>
10517d130: d00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517d134: f9478101    	ldr	x1, [x8, #0xf00] ; selector/string setM_iDiffTime:
10517d138: aa1603e0    	mov	x0, x22
10517d13c: aa1903e2    	mov	x2, x25
10517d140: 94aaa7ff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d144: aa1603e0    	mov	x0, x22
10517d148: 94aaa803    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d14c: d00d7fbc    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10517d150: f9467b80    	ldr	x0, [x28, #0xcf0] ; class CUtility
10517d154: d00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517d158: f9478901    	ldr	x1, [x8, #0xf10] ; selector/string genServerCurrentTimeNotABTest
10517d15c: 94aaa7f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d160: aa0003f6    	mov	x22, x0
10517d164: f9467b80    	ldr	x0, [x28, #0xcf0] ; class CUtility
10517d168: d00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517d16c: f9478d01    	ldr	x1, [x8, #0xf18] ; selector/string getRealUptime
10517d170: 94aaa7f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d174: 4b0002d6    	sub	w22, w22, w0
10517d178: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d17c: f9471100    	ldr	x0, [x8, #0xe20] ; class SettingUtil
10517d180: aa1a03e1    	mov	x1, x26
10517d184: 94aaa7ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d188: aa1d03fd    	mov	x29, x29
10517d18c: 94aaa7ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d190: aa0003fc    	mov	x28, x0
10517d194: d00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517d198: f9479101    	ldr	x1, [x8, #0xf20] ; selector/string setM_uStartTime:
10517d19c: aa1603e2    	mov	x2, x22
10517d1a0: 94aaa7e7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d1a4: aa1c03e0    	mov	x0, x28
10517d1a8: 94aaa7eb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d1ac: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d1b0: f9453516    	ldr	x22, [x8, #0xa68] ; class iConsole
10517d1b4: aa1403e0    	mov	x0, x20
10517d1b8: aa1b03e1    	mov	x1, x27
10517d1bc: 94aaa7e0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d1c0: 900d65e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10517d1c4: f942a901    	ldr	x1, [x8, #0x550] ; selector/string logWithLevel:module:errorCode:file:line:func:format:
10517d1c8: f9401be8    	ldr	x8, [sp, #0x30]
10517d1cc: b8686b08    	ldr	w8, [x24, x8]
10517d1d0: f90013e8    	str	x8, [sp, #0x20]
10517d1d4: f9401fe8    	ldr	x8, [sp, #0x38]
10517d1d8: a90123e0    	stp	x0, x8, [sp, #0x10]
10517d1dc: b00c9988    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10517d1e0: 911e2108    	add	x8, x8, #0x788 ; CFString 'iDiffTime:%d  iSvrTime:%u  ct2:%u  ct1:%u'
10517d1e4: a90067e8    	stp	x8, x25, [sp]
10517d1e8: f00b0f03    	adrp	x3, 0x11b360000 <dyld_stub_binder+0x11b360000>
10517d1ec: 91270063    	add	x3, x3, #0x9c0 ; string 'Sync'
10517d1f0: b00b3705    	adrp	x5, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517d1f4: 911d1ca5    	add	x5, x5, #0x747 ; string 'NewSyncEventHandler.mm'
10517d1f8: b00b3707    	adrp	x7, 0x11b85e000 <dyld_stub_binder+0x11b85e000>
10517d1fc: 911d78e7    	add	x7, x7, #0x75e ; string '-[NewSyncEventHandler OnProtocolResponse:shouldContinue:]'
10517d200: aa1603e0    	mov	x0, x22
10517d204: 52800042    	mov	w2, #0x2                ; =2
10517d208: 52800004    	mov	w4, #0x0                ; =0
10517d20c: 52800a06    	mov	w6, #0x50               ; =80
10517d210: 94aaa7cb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d214: f94023fc    	ldr	x28, [sp, #0x40]
10517d218: aa1403e0    	mov	x0, x20
10517d21c: aa1b03e1    	mov	x1, x27
10517d220: 94aaa7c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d224: 2a0003f6    	mov	w22, w0
10517d228: d00d7fb9    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10517d22c: f9471320    	ldr	x0, [x25, #0xe20] ; class SettingUtil
10517d230: b00d65e8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10517d234: f946f118    	ldr	x24, [x8, #0xde0] ; selector/string getMainSetting
10517d238: aa1803e1    	mov	x1, x24
10517d23c: 94aaa7c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d240: aa1d03fd    	mov	x29, x29
10517d244: 94aaa7c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d248: aa0003fb    	mov	x27, x0
10517d24c: d00d6628    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10517d250: f9479501    	ldr	x1, [x8, #0xf28] ; selector/string setLastSvrTime:
10517d254: aa1603e2    	mov	x2, x22
10517d258: 94aaa7b9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d25c: aa1b03e0    	mov	x0, x27
10517d260: 94aaa7bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d264: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d268: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
10517d26c: aa1703e1    	mov	x1, x23
10517d270: 94aaa7b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d274: aa1d03fd    	mov	x29, x29
10517d278: 94aaa7b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d27c: aa0003f6    	mov	x22, x0
10517d280: 900d7fc8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10517d284: f9414d00    	ldr	x0, [x8, #0x298] ; class AccountStorageMgr
10517d288: f9402be1    	ldr	x1, [sp, #0x50]
10517d28c: 94aaa7ac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d290: aa0003e2    	mov	x2, x0
10517d294: aa1603e0    	mov	x0, x22
10517d298: f94027e1    	ldr	x1, [sp, #0x48]
10517d29c: 94aaa7a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d2a0: aa1d03fd    	mov	x29, x29
10517d2a4: 94aaa7a9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d2a8: aa0003f7    	mov	x23, x0
10517d2ac: b00d6628    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
10517d2b0: f9458101    	ldr	x1, [x8, #0xb00] ; selector/string MainThreadSaveSetting
10517d2b4: 94aaa7a2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d2b8: aa1703e0    	mov	x0, x23
10517d2bc: 94aaa7a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d2c0: aa1603e0    	mov	x0, x22
10517d2c4: 94aaa7a4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d2c8: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d2cc: f9468d00    	ldr	x0, [x8, #0xd18] ; class DeviceInfo
10517d2d0: d00d7c28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10517d2d4: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector/string isiPad
10517d2d8: 94aaa799    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d2dc: aa0003f6    	mov	x22, x0
10517d2e0: f9471320    	ldr	x0, [x25, #0xe20] ; class SettingUtil
10517d2e4: aa1803e1    	mov	x1, x24
10517d2e8: 94aaa795    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d2ec: aa1d03fd    	mov	x29, x29
10517d2f0: 94aaa796    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d2f4: aa0003f7    	mov	x23, x0
10517d2f8: f00d65e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10517d2fc: f942d501    	ldr	x1, [x8, #0x5a8] ; selector/string m_uiExtStatus
10517d300: 94aaa78f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d304: aa0003f8    	mov	x24, x0
10517d308: aa1703e0    	mov	x0, x23
10517d30c: 94aaa792    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d310: 710002df    	cmp	w22, #0x0
10517d314: 52800808    	mov	w8, #0x40               ; =64
10517d318: 52801009    	mov	w9, #0x80               ; =128
10517d31c: 9a881128    	csel	x8, x9, x8, ne
10517d320: ea08031f    	tst	x24, x8
10517d324: 1a9f17e2    	cset	w2, eq
10517d328: aa1403e0    	mov	x0, x20
10517d32c: 52800001    	mov	w1, #0x0                ; =0
10517d330: 9400007e    	bl	0x10517d528 <_Flutter_MMFoundation_BindContext+0x165910c>
10517d334: aa0003f7    	mov	x23, x0
10517d338: 900d67a8    	adrp	x8, 0x11fe71000 <dyld_stub_binder+0x11fe71000>
10517d33c: f942a518    	ldr	x24, [x8, #0x548] ; selector/string cmdList
10517d340: aa1403e0    	mov	x0, x20
10517d344: aa1803e1    	mov	x1, x24
10517d348: 94aaa77d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d34c: aa1d03fd    	mov	x29, x29
10517d350: 94aaa77e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d354: aa0003f6    	mov	x22, x0
10517d358: f00d7c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10517d35c: f9435119    	ldr	x25, [x8, #0x6a0] ; selector/string count
10517d360: aa1903e1    	mov	x1, x25
10517d364: 94aaa776    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d368: aa0003fa    	mov	x26, x0
10517d36c: aa1603e0    	mov	x0, x22
10517d370: 94aaa779    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d374: 3400099a    	cbz	w26, 0x10517d4a4 <_Flutter_MMFoundation_BindContext+0x1659088>
10517d378: d00d7fb6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
10517d37c: f9467ac0    	ldr	x0, [x22, #0xcf0] ; class CUtility
10517d380: aa1503e1    	mov	x1, x21
10517d384: 94aaa76e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d388: cb1c001b    	sub	x27, x0, x28
10517d38c: d00d65e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10517d390: f9447901    	ldr	x1, [x8, #0x8f0] ; selector/string m_pbRequest
10517d394: aa1303e0    	mov	x0, x19
10517d398: 94aaa769    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d39c: aa1d03fd    	mov	x29, x29
10517d3a0: 94aaa76a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d3a4: aa0003f5    	mov	x21, x0
10517d3a8: f9467ad6    	ldr	x22, [x22, #0xcf0] ; class CUtility
10517d3ac: 900d6668    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
10517d3b0: f9466501    	ldr	x1, [x8, #0xcc8] ; selector/string continueFlag
10517d3b4: aa1403e0    	mov	x0, x20
10517d3b8: 94aaa761    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d3bc: aa0003e2    	mov	x2, x0
10517d3c0: f00d70e8    	adrp	x8, 0x11ff9c000 <dyld_stub_binder+0x11ff9c000>
10517d3c4: f9421d01    	ldr	x1, [x8, #0x438] ; selector/string NeedNewSync:
10517d3c8: aa1603e0    	mov	x0, x22
10517d3cc: 94aaa75c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d3d0: aa0003f6    	mov	x22, x0
10517d3d4: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d3d8: f945451a    	ldr	x26, [x8, #0xa88] ; bind _OBJC_CLASS_$_NSString
10517d3dc: aa1403e0    	mov	x0, x20
10517d3e0: aa1803e1    	mov	x1, x24
10517d3e4: 94aaa756    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d3e8: aa1d03fd    	mov	x29, x29
10517d3ec: 94aaa757    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d3f0: aa0003f8    	mov	x24, x0
10517d3f4: aa1903e1    	mov	x1, x25
10517d3f8: 94aaa751    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d3fc: aa0003f9    	mov	x25, x0
10517d400: b00d7c48    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10517d404: f9450901    	ldr	x1, [x8, #0xa10] ; selector/string scene
10517d408: aa1503e0    	mov	x0, x21
10517d40c: 94aaa74c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d410: b00d7c68    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10517d414: f946a501    	ldr	x1, [x8, #0xd48] ; selector/string stringWithFormat:
10517d418: a9015be0    	stp	x0, x22, [sp, #0x10]
10517d41c: a9006ff9    	stp	x25, x27, [sp]
10517d420: d00cb2c2    	adrp	x2, 0x11e7d7000 <dyld_stub_binder+0x11e7d7000>
10517d424: 912ca042    	add	x2, x2, #0xb28 ; CFString '%u,%llu,%u,%u'
10517d428: aa1a03e0    	mov	x0, x26
10517d42c: 94aaa744    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d430: aa1d03fd    	mov	x29, x29
10517d434: 94aaa745    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d438: aa0003f6    	mov	x22, x0
10517d43c: aa1803e0    	mov	x0, x24
10517d440: 94aaa745    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d444: b00c2388    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10517d448: f947e108    	ldr	x8, [x8, #0xfc0] ; bind __NSConcreteStackBlock
10517d44c: f9002fe8    	str	x8, [sp, #0x58]
10517d450: 9009e028    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10517d454: fd41c100    	ldr	d0, [x8, #0x380]
10517d458: 90000008    	adrp	x8, 0x10517d000 <_Flutter_MMFoundation_BindContext+0x1658be4>
10517d45c: 912d4108    	add	x8, x8, #0xb50
10517d460: fd0033e0    	str	d0, [sp, #0x60]
10517d464: b00c23c9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
10517d468: 9115c129    	add	x9, x9, #0x570
10517d46c: a906a7e8    	stp	x8, x9, [sp, #0x68]
10517d470: f9003ff6    	str	x22, [sp, #0x78]
10517d474: aa1603e0    	mov	x0, x22
10517d478: 94aaa730    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10517d47c: d00c2380    	adrp	x0, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
10517d480: f9408c00    	ldr	x0, [x0, #0x118] ; bind __dispatch_main_q
10517d484: 910163e1    	add	x1, sp, #0x58
10517d488: 94aa3f66    	bl	0x107c0d220 <_Flutter_MMFoundation_BindContext+0x40e8e04>
10517d48c: f9403fe0    	ldr	x0, [sp, #0x78]
10517d490: 94aaa731    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d494: aa1603e0    	mov	x0, x22
10517d498: 94aaa72f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d49c: aa1503e0    	mov	x0, x21
10517d4a0: 94aaa72d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d4a4: d00d7fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10517d4a8: f9458900    	ldr	x0, [x8, #0xb10] ; bind _OBJC_CLASS_$_NSNumber
10517d4ac: f00d7c28    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10517d4b0: f9479501    	ldr	x1, [x8, #0xf28] ; selector/string numberWithBool:
10517d4b4: aa1703e2    	mov	x2, x23
10517d4b8: 94aaa721    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d4bc: aa1d03fd    	mov	x29, x29
10517d4c0: 94aaa722    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10517d4c4: aa0003f5    	mov	x21, x0
10517d4c8: b00d6608    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10517d4cc: f947a101    	ldr	x1, [x8, #0xf40] ; selector/string setM_oUserData:
10517d4d0: aa1303e0    	mov	x0, x19
10517d4d4: aa1503e2    	mov	x2, x21
10517d4d8: 94aaa719    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10517d4dc: aa1503e0    	mov	x0, x21
10517d4e0: 94aaa71d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d4e4: aa1403e0    	mov	x0, x20
10517d4e8: 94aaa71b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d4ec: aa1303e0    	mov	x0, x19
10517d4f0: 94aaa719    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10517d4f4: a94e7bfd    	ldp	x29, x30, [sp, #0xe0]
10517d4f8: a94d4ff4    	ldp	x20, x19, [sp, #0xd0]
10517d4fc: a94c57f6    	ldp	x22, x21, [sp, #0xc0]
10517d500: a94b5ff8    	ldp	x24, x23, [sp, #0xb0]
10517d504: a94a67fa    	ldp	x26, x25, [sp, #0xa0]
10517d508: a9496ffc    	ldp	x28, x27, [sp, #0x90]
10517d50c: 6d4823e9    	ldp	d9, d8, [sp, #0x80]
10517d510: 9103c3ff    	add	sp, sp, #0xf0
10517d514: d65f03c0    	ret
