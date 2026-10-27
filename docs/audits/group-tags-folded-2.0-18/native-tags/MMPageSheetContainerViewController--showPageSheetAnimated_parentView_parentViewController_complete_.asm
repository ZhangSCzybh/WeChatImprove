
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116800128: d10243ff    	sub	sp, sp, #0x90
11680012c: a9036ffc    	stp	x28, x27, [sp, #0x30]
116800130: a90467fa    	stp	x26, x25, [sp, #0x40]
116800134: a9055ff8    	stp	x24, x23, [sp, #0x50]
116800138: a90657f6    	stp	x22, x21, [sp, #0x60]
11680013c: a9074ff4    	stp	x20, x19, [sp, #0x70]
116800140: a9087bfd    	stp	x29, x30, [sp, #0x80]
116800144: 910203fd    	add	x29, sp, #0x80
116800148: aa0503f8    	mov	x24, x5
11680014c: aa0403f3    	mov	x19, x4
116800150: aa0203f9    	mov	x25, x2
116800154: aa0003f7    	mov	x23, x0
116800158: f0036f68    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
11680015c: f9405908    	ldr	x8, [x8, #0xb0]
116800160: f9400108    	ldr	x8, [x8]
116800164: f90017e8    	str	x8, [sp, #0x28]
116800168: aa0403e0    	mov	x0, x4
11680016c: 946ca701    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116800170: 9004cbc8    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
116800174: f9420d14    	ldr	x20, [x8, #0x418] ; Ўc
116800178: b004b1e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
11680017c: f940f515    	ldr	x21, [x8, #0x1e8] ; externalIMP
116800180: aa1803e0    	mov	x0, x24
116800184: 946ca6fb    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116800188: aa1403e0    	mov	x0, x20
11680018c: f9000ff5    	str	x21, [sp, #0x18]
116800190: aa1503e1    	mov	x1, x21
116800194: 946ca6d6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800198: aa1d03fd    	mov	x29, x29
11680019c: 946ca6fe    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1168001a0: aa0003f6    	mov	x22, x0
1168001a4: d004cba8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
1168001a8: f940a500    	ldr	x0, [x8, #0x148]
1168001ac: 9004b288    	adrp	x8, 0x11fe50000 <dyld_stub_binder+0x11fe50000>
1168001b0: f941b101    	ldr	x1, [x8, #0x360] ; lastActiveSceneRootWindow
1168001b4: 946ca6ce    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168001b8: aa1d03fd    	mov	x29, x29
1168001bc: 946ca6f6    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1168001c0: aa0003fa    	mov	x26, x0
1168001c4: b004b208    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1168001c8: f943a501    	ldr	x1, [x8, #0x748] ; topViewControllerOfWindow:
1168001cc: aa1603e0    	mov	x0, x22
1168001d0: aa1a03e2    	mov	x2, x26
1168001d4: 946ca6c6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168001d8: aa1d03fd    	mov	x29, x29
1168001dc: 946ca6ee    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1168001e0: aa0003f4    	mov	x20, x0
1168001e4: aa1a03e0    	mov	x0, x26
1168001e8: 946ca6dc    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1168001ec: aa1603e0    	mov	x0, x22
1168001f0: 946ca6da    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1168001f4: d004b208    	adrp	x8, 0x11fe42000 <dyld_stub_binder+0x11fe42000>
1168001f8: f9440501    	ldr	x1, [x8, #0x808] ; supportedInterfaceOrientations
1168001fc: aa1403e0    	mov	x0, x20
116800200: 946ca6bb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800204: d004d488    	adrp	x8, 0x120292000 <dyld_stub_binder+0x120292000>
116800208: b9865d15    	ldrsw	x21, [x8, #0x65c]
11680020c: f8356ae0    	str	x0, [x23, x21]
116800210: d004d488    	adrp	x8, 0x120292000 <dyld_stub_binder+0x120292000>
116800214: b9865908    	ldrsw	x8, [x8, #0x658]
116800218: 38286aff    	strb	wzr, [x23, x8]
11680021c: d004d488    	adrp	x8, 0x120292000 <dyld_stub_binder+0x120292000>
116800220: b9865508    	ldrsw	x8, [x8, #0x654]
116800224: 38286aff    	strb	wzr, [x23, x8]
116800228: b004c768    	adrp	x8, 0x1200ed000 <dyld_stub_binder+0x1200ed000>
11680022c: f944f901    	ldr	x1, [x8, #0x9f0] ; providerView
116800230: aa1703e0    	mov	x0, x23
116800234: 946ca6ae    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800238: aa1d03fd    	mov	x29, x29
11680023c: 946ca6d6    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116800240: aa0003fa    	mov	x26, x0
116800244: 9004c768    	adrp	x8, 0x1200ec000 <dyld_stub_binder+0x1200ec000>
116800248: f9413501    	ldr	x1, [x8, #0x268] ; topPageProvider
11680024c: 946ca6a8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800250: aa1d03fd    	mov	x29, x29
116800254: 946ca6d0    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116800258: aa0003fb    	mov	x27, x0
11680025c: 9004b268    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
116800260: f943f901    	ldr	x1, [x8, #0x7f0] ; pageSheetConfig
116800264: 946ca6a2    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800268: aa1d03fd    	mov	x29, x29
11680026c: 946ca6ca    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116800270: aa0003f6    	mov	x22, x0
116800274: aa1b03e0    	mov	x0, x27
116800278: 946ca6b8    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11680027c: aa1a03e0    	mov	x0, x26
116800280: 946ca6b6    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116800284: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
116800288: f9475501    	ldr	x1, [x8, #0xea8] ; externalNavigationController
11680028c: aa1603e0    	mov	x0, x22
116800290: 946ca697    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800294: aa1d03fd    	mov	x29, x29
116800298: 946ca6bf    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11680029c: b40002c0    	cbz	x0, 0x1168002f4 <_O266DecReleaseOutputPicture+0x357383c>
1168002a0: aa0003fa    	mov	x26, x0
1168002a4: f90013f7    	str	x23, [sp, #0x20]
1168002a8: f004cb88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1168002ac: f9456d00    	ldr	x0, [x8, #0xad8]
1168002b0: f004c7e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
1168002b4: f941c501    	ldr	x1, [x8, #0x388] ; arrayWithObjects:count:
1168002b8: 910083e2    	add	x2, sp, #0x20
1168002bc: 52800023    	mov	w3, #0x1                ; =1
1168002c0: 946ca68b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168002c4: aa1d03fd    	mov	x29, x29
1168002c8: 946ca6b3    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1168002cc: aa0003fb    	mov	x27, x0
1168002d0: b004b2c8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
1168002d4: f940f501    	ldr	x1, [x8, #0x1e8] ; setViewControllers:animated:
1168002d8: aa1a03e0    	mov	x0, x26
1168002dc: aa1b03e2    	mov	x2, x27
1168002e0: 52800003    	mov	w3, #0x0                ; =0
1168002e4: 946ca682    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168002e8: aa1b03e0    	mov	x0, x27
1168002ec: 946ca69b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1168002f0: 14000009    	b	0x116800314 <_O266DecReleaseOutputPicture+0x357385c>
1168002f4: f004cb88    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1168002f8: f947d500    	ldr	x0, [x8, #0xfa8] ; (#c
1168002fc: 946ca61f    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
116800300: f004c808    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
116800304: f940d901    	ldr	x1, [x8, #0x1b0] ; initWithRootViewController:
116800308: aa1703e2    	mov	x2, x23
11680030c: 946ca678    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800310: aa0003fa    	mov	x26, x0
116800314: 9004c848    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116800318: f9471101    	ldr	x1, [x8, #0xe20] ; setModalPresentationStyle:
11680031c: aa1a03e0    	mov	x0, x26
116800320: 52800082    	mov	w2, #0x4                ; =4
116800324: 946ca672    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800328: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
11680032c: f947591b    	ldr	x27, [x8, #0xeb0] ; presentTransitionDelegate
116800330: aa1603e0    	mov	x0, x22
116800334: aa1b03e1    	mov	x1, x27
116800338: 946ca66d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11680033c: aa1d03fd    	mov	x29, x29
116800340: 946ca695    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116800344: aa0003fc    	mov	x28, x0
116800348: b5000260    	cbnz	x0, 0x116800394 <_O266DecReleaseOutputPicture+0x35738dc>
11680034c: d004bbc8    	adrp	x8, 0x11ff7a000 <dyld_stub_binder+0x11ff7a000>
116800350: f9434901    	ldr	x1, [x8, #0x690] ; transferTouchEventInBgMask
116800354: aa1603e0    	mov	x0, x22
116800358: 946ca665    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11680035c: 34000200    	cbz	w0, 0x11680039c <_O266DecReleaseOutputPicture+0x35738e4>
116800360: b004cda8    	adrp	x8, 0x1201b5000 <dyld_stub_binder+0x1201b5000>
116800364: f9422100    	ldr	x0, [x8, #0x440]
116800368: 946ca60a    	bl	0x118329b90 <dyld_stub_binder+0x118329b90>
11680036c: aa0003fc    	mov	x28, x0
116800370: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
116800374: f9475d01    	ldr	x1, [x8, #0xeb8] ; setPageSheetConfig:
116800378: aa1603e2    	mov	x2, x22
11680037c: 946ca65c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800380: d004bc28    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
116800384: f9472d01    	ldr	x1, [x8, #0xe58] ; setPresentTransitionDelegate:
116800388: aa1603e0    	mov	x0, x22
11680038c: aa1c03e2    	mov	x2, x28
116800390: 946ca657    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800394: aa1c03e0    	mov	x0, x28
116800398: 946ca670    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11680039c: aa1603e0    	mov	x0, x22
1168003a0: aa1b03e1    	mov	x1, x27
1168003a4: 946ca652    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168003a8: aa1d03fd    	mov	x29, x29
1168003ac: 946ca67a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1168003b0: aa0003fc    	mov	x28, x0
1168003b4: 946ca669    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1168003b8: b40001dc    	cbz	x28, 0x1168003f0 <_O266DecReleaseOutputPicture+0x3573938>
1168003bc: aa1603e0    	mov	x0, x22
1168003c0: aa1b03e1    	mov	x1, x27
1168003c4: 946ca64a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168003c8: aa1d03fd    	mov	x29, x29
1168003cc: 946ca672    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1168003d0: aa0003fb    	mov	x27, x0
1168003d4: 9004b1e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1168003d8: f9447d01    	ldr	x1, [x8, #0x8f8] ; setTransitioningDelegate:
1168003dc: aa1a03e0    	mov	x0, x26
1168003e0: aa1b03e2    	mov	x2, x27
1168003e4: 946ca642    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168003e8: aa1b03e0    	mov	x0, x27
1168003ec: 946ca65b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1168003f0: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
1168003f4: f947611b    	ldr	x27, [x8, #0xec0] ; overrideSupportOrientation
1168003f8: aa1603e0    	mov	x0, x22
1168003fc: aa1b03e1    	mov	x1, x27
116800400: 946ca63b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800404: b40000a0    	cbz	x0, 0x116800418 <_O266DecReleaseOutputPicture+0x3573960>
116800408: aa1603e0    	mov	x0, x22
11680040c: aa1b03e1    	mov	x1, x27
116800410: 946ca637    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800414: f8356ae0    	str	x0, [x23, x21]
116800418: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
11680041c: f9476501    	ldr	x1, [x8, #0xec8] ; setShowPageSheetAnimated:
116800420: aa1703e0    	mov	x0, x23
116800424: aa1903e2    	mov	x2, x25
116800428: 946ca631    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11680042c: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
116800430: f9474d01    	ldr	x1, [x8, #0xe98] ; setShowPageSheetComplete:
116800434: aa1703e0    	mov	x0, x23
116800438: aa1803e2    	mov	x2, x24
11680043c: 946ca62c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800440: aa1803e0    	mov	x0, x24
116800444: 946ca645    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116800448: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
11680044c: f9473901    	ldr	x1, [x8, #0xe70] ; setHasCallShowPageSheet:
116800450: aa1703e0    	mov	x0, x23
116800454: 52800002    	mov	w2, #0x0                ; =0
116800458: 946ca625    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11680045c: b004cba8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
116800460: f9408500    	ldr	x0, [x8, #0x108]
116800464: f004c7e8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
116800468: f947ad01    	ldr	x1, [x8, #0xf58] ; class
11680046c: 946ca620    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800470: aa0003e2    	mov	x2, x0
116800474: f004c808    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
116800478: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
11680047c: aa1303e0    	mov	x0, x19
116800480: 946ca61b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800484: 34000320    	cbz	w0, 0x1168004e8 <_O266DecReleaseOutputPicture+0x3573a30>
116800488: d004b228    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
11680048c: f941c101    	ldr	x1, [x8, #0x380] ; m_bAnimating
116800490: aa1303e0    	mov	x0, x19
116800494: 946ca616    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800498: 34000280    	cbz	w0, 0x1168004e8 <_O266DecReleaseOutputPicture+0x3573a30>
11680049c: d004cd48    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1168004a0: f9448500    	ldr	x0, [x8, #0x908]
1168004a4: f9400fe1    	ldr	x1, [sp, #0x18]
1168004a8: 946ca611    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168004ac: b004b1c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1168004b0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1168004b4: b0041b88    	adrp	x8, 0x11eb71000 <dyld_stub_binder+0x11eb71000>
1168004b8: 9100a108    	add	x8, x8, #0x28
1168004bc: a9004fe8    	stp	x8, x19, [sp]
1168004c0: 90030685    	adrp	x5, 0x11c8d0000 <dyld_stub_binder+0x11c8d0000>
1168004c4: 911804a5    	add	x5, x5, #0x601
1168004c8: 90030687    	adrp	x7, 0x11c8d0000 <dyld_stub_binder+0x11c8d0000>
1168004cc: 911a3ce7    	add	x7, x7, #0x68f
1168004d0: 52800082    	mov	w2, #0x4                ; =4
1168004d4: d2800003    	mov	x3, #0x0                ; =0
1168004d8: 52800004    	mov	w4, #0x0                ; =0
1168004dc: 52802326    	mov	w6, #0x119              ; =281
1168004e0: 946ca603    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168004e4: 1400000f    	b	0x116800520 <_O266DecReleaseOutputPicture+0x3573a68>
1168004e8: 9004c788    	adrp	x8, 0x1200f0000 <dyld_stub_binder+0x1200f0000>
1168004ec: f9476901    	ldr	x1, [x8, #0xed0] ; autoRotatePortraitAtPresent
1168004f0: aa1603e0    	mov	x0, x22
1168004f4: 946ca5fe    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1168004f8: aa0003e5    	mov	x5, x0
1168004fc: b004b2c8    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
116800500: f940fd01    	ldr	x1, [x8, #0x1f8] ; PresentModalViewController:animated:forceFullScreen:isAutoRotatePortrait:completion:
116800504: d003dc26    	adrp	x6, 0x11e386000 <dyld_stub_binder+0x11e386000>
116800508: 912460c6    	add	x6, x6, #0x918
11680050c: aa1303e0    	mov	x0, x19
116800510: aa1a03e2    	mov	x2, x26
116800514: 52800003    	mov	w3, #0x0                ; =0
116800518: 52800004    	mov	w4, #0x0                ; =0
11680051c: 946ca5f4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116800520: aa1a03e0    	mov	x0, x26
116800524: 946ca60d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116800528: aa1603e0    	mov	x0, x22
11680052c: 946ca60b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116800530: aa1403e0    	mov	x0, x20
116800534: 946ca609    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116800538: aa1303e0    	mov	x0, x19
11680053c: 946ca607    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116800540: f94017e8    	ldr	x8, [sp, #0x28]
116800544: f0036f69    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
116800548: f9405929    	ldr	x9, [x9, #0xb0]
11680054c: f9400129    	ldr	x9, [x9]
116800550: eb08013f    	cmp	x9, x8
116800554: 54000121    	b.ne	0x116800578 <_O266DecReleaseOutputPicture+0x3573ac0>
116800558: a9487bfd    	ldp	x29, x30, [sp, #0x80]
11680055c: a9474ff4    	ldp	x20, x19, [sp, #0x70]
116800560: a94657f6    	ldp	x22, x21, [sp, #0x60]
116800564: a9455ff8    	ldp	x24, x23, [sp, #0x50]
116800568: a94467fa    	ldp	x26, x25, [sp, #0x40]
11680056c: a9436ffc    	ldp	x28, x27, [sp, #0x30]
116800570: 910243ff    	add	sp, sp, #0x90
116800574: d65f03c0    	ret
116800578: 946c98e1    	bl	0x1183268fc <dyld_stub_binder+0x1183268fc>
