
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047a4dfc: d10243ff    	sub	sp, sp, #0x90
1047a4e00: a9036ffc    	stp	x28, x27, [sp, #0x30]
1047a4e04: a90467fa    	stp	x26, x25, [sp, #0x40]
1047a4e08: a9055ff8    	stp	x24, x23, [sp, #0x50]
1047a4e0c: a90657f6    	stp	x22, x21, [sp, #0x60]
1047a4e10: a9074ff4    	stp	x20, x19, [sp, #0x70]
1047a4e14: a9087bfd    	stp	x29, x30, [sp, #0x80]
1047a4e18: 910203fd    	add	x29, sp, #0x80
1047a4e1c: aa0303f6    	mov	x22, x3
1047a4e20: aa0203f3    	mov	x19, x2
1047a4e24: aa0003fc    	mov	x28, x0
1047a4e28: b00e24c8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1047a4e2c: 52800029    	mov	w9, #0x1                ; =1
1047a4e30: 39203509    	strb	w9, [x8, #0x80d]
1047a4e34: aa0203e0    	mov	x0, x2
1047a4e38: 94d208c0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047a4e3c: aa1603e0    	mov	x0, x22
1047a4e40: 94d208be    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1047a4e44: 900dce94    	adrp	x20, 0x120174000 <dyld_stub_binder+0x120174000>
1047a4e48: f9427280    	ldr	x0, [x20, #0x4e0] ; class NSURL
1047a4e4c: b00db4c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1047a4e50: f9441d18    	ldr	x24, [x8, #0x838] ; selector safeUrlWithString:
1047a4e54: aa1803e1    	mov	x1, x24
1047a4e58: aa1303e2    	mov	x2, x19
1047a4e5c: 94d208b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4e60: aa1d03fd    	mov	x29, x29
1047a4e64: 94d208b9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4e68: aa0003f5    	mov	x21, x0
1047a4e6c: b5000460    	cbnz	x0, 0x1047a4ef8 <_Flutter_MMFoundation_BindContext+0xc80adc>
1047a4e70: f00db868    	adrp	x8, 0x11feb3000 <dyld_stub_binder+0x11feb3000>
1047a4e74: f9432501    	ldr	x1, [x8, #0x648] ; selector gtm_stringByEscapingForURLArgumentOnly
1047a4e78: aa1303e0    	mov	x0, x19
1047a4e7c: 94d208b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4e80: aa1d03fd    	mov	x29, x29
1047a4e84: 94d208b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4e88: aa0003f7    	mov	x23, x0
1047a4e8c: f9427280    	ldr	x0, [x20, #0x4e0] ; class NSURL
1047a4e90: aa1803e1    	mov	x1, x24
1047a4e94: aa1703e2    	mov	x2, x23
1047a4e98: 94d208a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4e9c: aa1d03fd    	mov	x29, x29
1047a4ea0: 94d208aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4ea4: aa0003f5    	mov	x21, x0
1047a4ea8: b5000240    	cbnz	x0, 0x1047a4ef0 <_Flutter_MMFoundation_BindContext+0xc80ad4>
1047a4eac: f00dce68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047a4eb0: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
1047a4eb4: b00db4a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1047a4eb8: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
1047a4ebc: a900fff7    	stp	x23, xzr, [sp, #0x8]
1047a4ec0: 900cf368    	adrp	x8, 0x11e610000 <dyld_stub_binder+0x11e610000>
1047a4ec4: 912c2108    	add	x8, x8, #0xb08 ; CFString "still can't help safeUrlWithString [%@] targetUrl [%@]"
1047a4ec8: f90003e8    	str	x8, [sp]
1047a4ecc: d00b7fe5    	adrp	x5, 0x11b7a2000 <dyld_stub_binder+0x11b7a2000>
1047a4ed0: 913cc8a5    	add	x5, x5, #0xf32 ; string 'MMURLHandler.mm'
1047a4ed4: d00b7fe7    	adrp	x7, 0x11b7a2000 <dyld_stub_binder+0x11b7a2000>
1047a4ed8: 913dbce7    	add	x7, x7, #0xf6f ; string '-[MMURLHandler handleDeepLinkURL:withExtraInfo:]'
1047a4edc: 52800082    	mov	w2, #0x4                ; =4
1047a4ee0: d2800003    	mov	x3, #0x0                ; =0
1047a4ee4: 52800004    	mov	w4, #0x0                ; =0
1047a4ee8: 52802b66    	mov	w6, #0x15b              ; =347
1047a4eec: 94d20894    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4ef0: aa1703e0    	mov	x0, x23
1047a4ef4: 94d20898    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a4ef8: b00dce88    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1047a4efc: f9418100    	ldr	x0, [x8, #0x300] ; class WCDeepLinkHandler
1047a4f00: f00dbe88    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
1047a4f04: f9477501    	ldr	x1, [x8, #0xee8] ; selector deepLinkByUrl:
1047a4f08: aa1303e2    	mov	x2, x19
1047a4f0c: 94d2088c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4f10: aa1d03fd    	mov	x29, x29
1047a4f14: 94d2088d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4f18: aa0003f7    	mov	x23, x0
1047a4f1c: b00dcf68    	adrp	x8, 0x120191000 <dyld_stub_binder+0x120191000>
1047a4f20: f9431d18    	ldr	x24, [x8, #0x638] ; class DeepLinkParam
1047a4f24: f00dbe88    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
1047a4f28: f9477901    	ldr	x1, [x8, #0xef0] ; selector getLink
1047a4f2c: 94d20884    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4f30: aa1d03fd    	mov	x29, x29
1047a4f34: 94d20885    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4f38: aa0003f9    	mov	x25, x0
1047a4f3c: 900dcae8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1047a4f40: f940f501    	ldr	x1, [x8, #0x1e8] ; selector componentsSeparatedByString:
1047a4f44: d00ce7a2    	adrp	x2, 0x11e49a000 <dyld_stub_binder+0x11e49a000>
1047a4f48: 9127a042    	add	x2, x2, #0x9e8 ; CFString '/'
1047a4f4c: 94d2087c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4f50: aa1d03fd    	mov	x29, x29
1047a4f54: 94d2087d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4f58: aa0003fa    	mov	x26, x0
1047a4f5c: f00dbe88    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
1047a4f60: f9477d01    	ldr	x1, [x8, #0xef8] ; selector DeepLinkParamWithLink:
1047a4f64: aa1803e0    	mov	x0, x24
1047a4f68: aa1a03e2    	mov	x2, x26
1047a4f6c: 94d20874    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4f70: aa1d03fd    	mov	x29, x29
1047a4f74: 94d20875    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4f78: aa0003f8    	mov	x24, x0
1047a4f7c: aa1a03e0    	mov	x0, x26
1047a4f80: 94d20875    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a4f84: aa1903e0    	mov	x0, x25
1047a4f88: 94d20873    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a4f8c: d00db548    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
1047a4f90: f9408d01    	ldr	x1, [x8, #0x118] ; selector linkArray
1047a4f94: aa1803e0    	mov	x0, x24
1047a4f98: 94d20869    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4f9c: aa1d03fd    	mov	x29, x29
1047a4fa0: 94d2086a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4fa4: aa0003f9    	mov	x25, x0
1047a4fa8: 900dcae8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1047a4fac: f9435101    	ldr	x1, [x8, #0x6a0] ; selector count
1047a4fb0: 94d20863    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4fb4: aa0003fa    	mov	x26, x0
1047a4fb8: aa1903e0    	mov	x0, x25
1047a4fbc: 94d20866    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a4fc0: b4000e5a    	cbz	x26, 0x1047a5188 <_Flutter_MMFoundation_BindContext+0xc80d6c>
1047a4fc4: f00dce68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047a4fc8: f9454100    	ldr	x0, [x8, #0xa80] ; class NSMutableDictionary
1047a4fcc: b00dcae8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
1047a4fd0: f9401d01    	ldr	x1, [x8, #0x38] ; selector dictionaryWithDictionary:
1047a4fd4: f90017f6    	str	x22, [sp, #0x28]
1047a4fd8: aa1603e2    	mov	x2, x22
1047a4fdc: 94d20858    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a4fe0: aa1d03fd    	mov	x29, x29
1047a4fe4: 94d20859    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a4fe8: aa0003f6    	mov	x22, x0
1047a4fec: 900dce88    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
1047a4ff0: f9426d00    	ldr	x0, [x8, #0x4d8] ; class MMWebViewController
1047a4ff4: 94d2085b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1047a4ff8: 900dd3e8    	adrp	x8, 0x120220000 <dyld_stub_binder+0x120220000>
1047a4ffc: b9809d14    	ldrsw	x20, [x8, #0x9c]
1047a5000: 38746b83    	ldrb	w3, [x28, x20]
1047a5004: f00db4c8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1047a5008: f9411901    	ldr	x1, [x8, #0x230] ; selector initWithURL:presentModal:extraInfo:
1047a500c: aa1503e2    	mov	x2, x21
1047a5010: f90013f6    	str	x22, [sp, #0x20]
1047a5014: aa1603e4    	mov	x4, x22
1047a5018: 94d20849    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a501c: aa0003fa    	mov	x26, x0
1047a5020: 900db4c8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
1047a5024: f9442501    	ldr	x1, [x8, #0x848] ; selector setDisableShareMenu:
1047a5028: 52800022    	mov	w2, #0x1                ; =1
1047a502c: 94d20844    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a5030: d00dce68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047a5034: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
1047a5038: f00dcac8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1047a503c: f944e901    	ldr	x1, [x8, #0x9d0] ; selector currentContext
1047a5040: 94d2083f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a5044: aa1d03fd    	mov	x29, x29
1047a5048: 94d20840    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a504c: aa0003fb    	mov	x27, x0
1047a5050: d00dce68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047a5054: f9462900    	ldr	x0, [x8, #0xc50] ; class MMLanguageMgr
1047a5058: d00dcac8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1047a505c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector class
1047a5060: 94d20837    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a5064: aa0003e2    	mov	x2, x0
1047a5068: 900db4a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1047a506c: f9464101    	ldr	x1, [x8, #0xc80] ; selector getService:
1047a5070: aa1b03e0    	mov	x0, x27
1047a5074: 94d20832    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a5078: aa1d03fd    	mov	x29, x29
1047a507c: 94d20833    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a5080: aa1c03f9    	mov	x25, x28
1047a5084: aa0003fc    	mov	x28, x0
1047a5088: 900db4a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1047a508c: f9464501    	ldr	x1, [x8, #0xc88] ; selector getStringForCurLanguage:
1047a5090: 900cfe62    	adrp	x2, 0x11e771000 <dyld_stub_binder+0x11e771000>
1047a5094: 9135a042    	add	x2, x2, #0xd68 ; CFString 'Webview_Deeplink_Redirecting_Title'
1047a5098: 94d20829    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a509c: aa1d03fd    	mov	x29, x29
1047a50a0: 94d2082a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a50a4: aa0003f6    	mov	x22, x0
1047a50a8: 900dcb28    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1047a50ac: f9472101    	ldr	x1, [x8, #0xe40] ; selector setTitle:
1047a50b0: aa1a03e0    	mov	x0, x26
1047a50b4: aa1603e2    	mov	x2, x22
1047a50b8: 94d20821    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a50bc: aa1603e0    	mov	x0, x22
1047a50c0: 94d20825    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a50c4: aa1c03e0    	mov	x0, x28
1047a50c8: 94d20823    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a50cc: aa1b03e0    	mov	x0, x27
1047a50d0: 94d20821    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a50d4: 38746b28    	ldrb	w8, [x25, x20]
1047a50d8: 7100051f    	cmp	w8, #0x1
1047a50dc: 54000301    	b.ne	0x1047a513c <_Flutter_MMFoundation_BindContext+0xc80d20>
1047a50e0: d00dce68    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1047a50e4: f947d500    	ldr	x0, [x8, #0xfa8] ; class MMUINavigationController
1047a50e8: 94d2081e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1047a50ec: d00dcae8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1047a50f0: f940d901    	ldr	x1, [x8, #0x1b0] ; selector initWithRootViewController:
1047a50f4: aa1a03e2    	mov	x2, x26
1047a50f8: 94d20811    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a50fc: aa0003fb    	mov	x27, x0
1047a5100: d00db4a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1047a5104: f945d501    	ldr	x1, [x8, #0xba8] ; selector getViewController
1047a5108: aa1903e0    	mov	x0, x25
1047a510c: 94d2080c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a5110: aa1d03fd    	mov	x29, x29
1047a5114: 94d2080d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a5118: aa0003f6    	mov	x22, x0
1047a511c: d00db4a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1047a5120: f945d901    	ldr	x1, [x8, #0xbb0] ; selector PresentModalViewController:animated:
1047a5124: aa1b03e2    	mov	x2, x27
1047a5128: 52800003    	mov	w3, #0x0                ; =0
1047a512c: 94d20804    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a5130: aa1603e0    	mov	x0, x22
1047a5134: 94d20808    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a5138: 1400000d    	b	0x1047a516c <_Flutter_MMFoundation_BindContext+0xc80d50>
1047a513c: d00db528    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
1047a5140: f946f101    	ldr	x1, [x8, #0xde0] ; selector getNavigationController
1047a5144: aa1903e0    	mov	x0, x25
1047a5148: 94d207fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a514c: aa1d03fd    	mov	x29, x29
1047a5150: 94d207fe    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1047a5154: aa0003fb    	mov	x27, x0
1047a5158: d00db4a8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1047a515c: f944e101    	ldr	x1, [x8, #0x9c0] ; selector PushViewController:animated:
1047a5160: aa1a03e2    	mov	x2, x26
1047a5164: 52800003    	mov	w3, #0x0                ; =0
1047a5168: 94d207f5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1047a516c: aa1b03e0    	mov	x0, x27
1047a5170: 94d207f9    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a5174: aa1a03e0    	mov	x0, x26
1047a5178: 94d207f7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a517c: f94013e0    	ldr	x0, [sp, #0x20]
1047a5180: 94d207f5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a5184: f94017f6    	ldr	x22, [sp, #0x28]
1047a5188: aa1803e0    	mov	x0, x24
1047a518c: 94d207f2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a5190: aa1703e0    	mov	x0, x23
1047a5194: 94d207f0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a5198: aa1503e0    	mov	x0, x21
1047a519c: 94d207ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a51a0: aa1603e0    	mov	x0, x22
1047a51a4: 94d207ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1047a51a8: aa1303e0    	mov	x0, x19
1047a51ac: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1047a51b0: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1047a51b4: a94657f6    	ldp	x22, x21, [sp, #0x60]
1047a51b8: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1047a51bc: a94467fa    	ldp	x26, x25, [sp, #0x40]
1047a51c0: a9436ffc    	ldp	x28, x27, [sp, #0x30]
1047a51c4: 910243ff    	add	sp, sp, #0x90
1047a51c8: 14d207e3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
