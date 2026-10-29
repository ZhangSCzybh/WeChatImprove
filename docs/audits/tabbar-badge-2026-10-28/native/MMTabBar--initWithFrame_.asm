
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10471e0c8: d10143ff    	sub	sp, sp, #0x50
10471e0cc: a9015ff8    	stp	x24, x23, [sp, #0x10]
10471e0d0: a90257f6    	stp	x22, x21, [sp, #0x20]
10471e0d4: a9034ff4    	stp	x20, x19, [sp, #0x30]
10471e0d8: a9047bfd    	stp	x29, x30, [sp, #0x40]
10471e0dc: 910103fd    	add	x29, sp, #0x40
10471e0e0: f00e28e8    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
10471e0e4: 52800029    	mov	w9, #0x1                ; =1
10471e0e8: 39194d09    	strb	w9, [x8, #0x653]
10471e0ec: d00dd528    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
10471e0f0: f945fd08    	ldr	x8, [x8, #0xbf8]
10471e0f4: a90023e0    	stp	x0, x8, [sp]
10471e0f8: 900dcf28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10471e0fc: f947d901    	ldr	x1, [x8, #0xfb0] ; selector initWithFrame:
10471e100: 910003e0    	mov	x0, sp
10471e104: 94d42410    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10471e108: aa0003f3    	mov	x19, x0
10471e10c: b40009c0    	cbz	x0, 0x10471e244 <_Flutter_MMFoundation_BindContext+0xbf9e28>
10471e110: b00dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471e114: f946d500    	ldr	x0, [x8, #0xda8] ; class UIImage
10471e118: 94d42410    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
10471e11c: aa0003f4    	mov	x20, x0
10471e120: 900dbaa8    	adrp	x8, 0x11fe72000 <dyld_stub_binder+0x11fe72000>
10471e124: f943a101    	ldr	x1, [x8, #0x740] ; selector setBackgroundImage:
10471e128: aa1303e0    	mov	x0, x19
10471e12c: aa1403e2    	mov	x2, x20
10471e130: 94d42403    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e134: aa1403e0    	mov	x0, x20
10471e138: 94d42407    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471e13c: f00dc2a8    	adrp	x8, 0x11ff75000 <dyld_stub_binder+0x11ff75000>
10471e140: f9457501    	ldr	x1, [x8, #0xae8] ; selector addCustomBackground
10471e144: aa1303e0    	mov	x0, x19
10471e148: 94d423fd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e14c: b00dd2a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10471e150: f9468d00    	ldr	x0, [x8, #0xd18] ; class DeviceInfo
10471e154: b00dcf28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10471e158: f9457d01    	ldr	x1, [x8, #0xaf8] ; selector isiPad
10471e15c: 94d423f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e160: 34000720    	cbz	w0, 0x10471e244 <_Flutter_MMFoundation_BindContext+0xbf9e28>
10471e164: b00dd2b7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
10471e168: f9458ee0    	ldr	x0, [x23, #0xb18] ; class NSNotificationCenter
10471e16c: d00dcf08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10471e170: f946b114    	ldr	x20, [x8, #0xd60] ; selector defaultCenter
10471e174: aa1403e1    	mov	x1, x20
10471e178: 94d423f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e17c: aa1d03fd    	mov	x29, x29
10471e180: 94d423f2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471e184: aa0003f5    	mov	x21, x0
10471e188: 900dc1e8    	adrp	x8, 0x11ff5a000 <dyld_stub_binder+0x11ff5a000>
10471e18c: f9400d03    	ldr	x3, [x8, #0x18] ; selector onKeyboradWillShow:
10471e190: d00c7668    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
10471e194: f941b508    	ldr	x8, [x8, #0x368]
10471e198: f9400104    	ldr	x4, [x8]
10471e19c: 900dcf08    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
10471e1a0: f9470116    	ldr	x22, [x8, #0xe00] ; selector addObserver:selector:name:object:
10471e1a4: aa1603e1    	mov	x1, x22
10471e1a8: aa1303e2    	mov	x2, x19
10471e1ac: d2800005    	mov	x5, #0x0                ; =0
10471e1b0: 94d423e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e1b4: aa1503e0    	mov	x0, x21
10471e1b8: 94d423e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471e1bc: f9458ee0    	ldr	x0, [x23, #0xb18] ; class NSNotificationCenter
10471e1c0: aa1403e1    	mov	x1, x20
10471e1c4: 94d423de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e1c8: aa1d03fd    	mov	x29, x29
10471e1cc: 94d423df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471e1d0: aa0003f5    	mov	x21, x0
10471e1d4: b00db9c8    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
10471e1d8: f947c503    	ldr	x3, [x8, #0xf88] ; selector onKeyboardWillHide:
10471e1dc: d00c7668    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
10471e1e0: f941b108    	ldr	x8, [x8, #0x360]
10471e1e4: f9400104    	ldr	x4, [x8]
10471e1e8: aa1603e1    	mov	x1, x22
10471e1ec: aa1303e2    	mov	x2, x19
10471e1f0: d2800005    	mov	x5, #0x0                ; =0
10471e1f4: 94d423d2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e1f8: aa1503e0    	mov	x0, x21
10471e1fc: 94d423d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471e200: f9458ee0    	ldr	x0, [x23, #0xb18] ; class NSNotificationCenter
10471e204: aa1403e1    	mov	x1, x20
10471e208: 94d423cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e20c: aa1d03fd    	mov	x29, x29
10471e210: 94d423ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10471e214: aa0003f4    	mov	x20, x0
10471e218: b00dbb68    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
10471e21c: f9423103    	ldr	x3, [x8, #0x460] ; selector onKeyboardWillChangeFrame:
10471e220: d00c7668    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
10471e224: f941ad08    	ldr	x8, [x8, #0x358]
10471e228: f9400104    	ldr	x4, [x8]
10471e22c: aa1603e1    	mov	x1, x22
10471e230: aa1303e2    	mov	x2, x19
10471e234: d2800005    	mov	x5, #0x0                ; =0
10471e238: 94d423c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10471e23c: aa1403e0    	mov	x0, x20
10471e240: 94d423c5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10471e244: aa1303e0    	mov	x0, x19
10471e248: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10471e24c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10471e250: a94257f6    	ldp	x22, x21, [sp, #0x20]
10471e254: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10471e258: 910143ff    	add	sp, sp, #0x50
10471e25c: d65f03c0    	ret
