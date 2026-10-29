
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1045329d0: d10183ff    	sub	sp, sp, #0x60
1045329d4: a90167fa    	stp	x26, x25, [sp, #0x10]
1045329d8: a9025ff8    	stp	x24, x23, [sp, #0x20]
1045329dc: a90357f6    	stp	x22, x21, [sp, #0x30]
1045329e0: a9044ff4    	stp	x20, x19, [sp, #0x40]
1045329e4: a9057bfd    	stp	x29, x30, [sp, #0x50]
1045329e8: 910143fd    	add	x29, sp, #0x50
1045329ec: aa0203f3    	mov	x19, x2
1045329f0: aa0003f4    	mov	x20, x0
1045329f4: aa0203e0    	mov	x0, x2
1045329f8: 94dbd1d0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1045329fc: b00de219    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
104532a00: f9453737    	ldr	x23, [x25, #0xa68] ; class iConsole
104532a04: b00de21a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104532a08: f9454740    	ldr	x0, [x26, #0xa88] ; class NSString
104532a0c: d00dc848    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104532a10: f947c916    	ldr	x22, [x8, #0xf90] ; selector generatePrivacyString:
104532a14: aa1603e1    	mov	x1, x22
104532a18: aa1303e2    	mov	x2, x19
104532a1c: 94dbd1c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532a20: aa1d03fd    	mov	x29, x29
104532a24: 94dbd1c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104532a28: aa0003f8    	mov	x24, x0
104532a2c: f00dc828    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104532a30: f942a915    	ldr	x21, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104532a34: d00cfb48    	adrp	x8, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
104532a38: 9122a108    	add	x8, x8, #0x8a8 ; CFString '%@'
104532a3c: a90003e8    	stp	x8, x0, [sp]
104532a40: f00b6943    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
104532a44: 911f2c63    	add	x3, x3, #0x7cb ; string 'Session'
104532a48: b00b91e5    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
104532a4c: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
104532a50: f00b91e7    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
104532a54: 912d2ce7    	add	x7, x7, #0xb4b ; string '-[MMNewSessionMgr OnUnReadCountChange:]'
104532a58: aa1703e0    	mov	x0, x23
104532a5c: aa1503e1    	mov	x1, x21
104532a60: 52800022    	mov	w2, #0x1                ; =1
104532a64: 52800004    	mov	w4, #0x0                ; =0
104532a68: 52817546    	mov	w6, #0xbaa              ; =2986
104532a6c: 94dbd1b4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532a70: aa1803e0    	mov	x0, x24
104532a74: 94dbd1b8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104532a78: b00dcca8    	adrp	x8, 0x11fec7000 <dyld_stub_binder+0x11fec7000>
104532a7c: f9415901    	ldr	x1, [x8, #0x2b0] ; selector isUserNeedProcess:
104532a80: aa1403e0    	mov	x0, x20
104532a84: aa1303e2    	mov	x2, x19
104532a88: 94dbd1ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532a8c: 360001a0    	tbz	w0, #0x0, 0x104532ac0 <_Flutter_MMFoundation_BindContext+0xa0e6a4>
104532a90: 900dd1e8    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
104532a94: f9420101    	ldr	x1, [x8, #0x400] ; selector GetUnReadCountExcludingActiveUser:
104532a98: aa1403e0    	mov	x0, x20
104532a9c: aa1303e2    	mov	x2, x19
104532aa0: 94dbd1a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532aa4: aa0003e3    	mov	x3, x0
104532aa8: b00dc8c8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104532aac: f9458d01    	ldr	x1, [x8, #0xb18] ; selector ChangeSessionUnReadCount:to:
104532ab0: aa1403e0    	mov	x0, x20
104532ab4: aa1303e2    	mov	x2, x19
104532ab8: 94dbd1a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532abc: 1400001a    	b	0x104532b24 <_Flutter_MMFoundation_BindContext+0xa0e708>
104532ac0: f9453734    	ldr	x20, [x25, #0xa68] ; class iConsole
104532ac4: f9454740    	ldr	x0, [x26, #0xa88] ; class NSString
104532ac8: aa1603e1    	mov	x1, x22
104532acc: aa1303e2    	mov	x2, x19
104532ad0: 94dbd19b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532ad4: aa1d03fd    	mov	x29, x29
104532ad8: 94dbd19c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104532adc: aa0003f6    	mov	x22, x0
104532ae0: f00d1108    	adrp	x8, 0x11e755000 <dyld_stub_binder+0x11e755000>
104532ae4: 9103a108    	add	x8, x8, #0xe8 ; CFString "[%@] don't need process by me"
104532ae8: a90003e8    	stp	x8, x0, [sp]
104532aec: f00b6943    	adrp	x3, 0x11b25d000 <dyld_stub_binder+0x11b25d000>
104532af0: 911f2c63    	add	x3, x3, #0x7cb ; string 'Session'
104532af4: b00b91e5    	adrp	x5, 0x11b76f000 <dyld_stub_binder+0x11b76f000>
104532af8: 913ffca5    	add	x5, x5, #0xfff ; string 'MMNewSessionMgr.mm'
104532afc: f00b91e7    	adrp	x7, 0x11b771000 <dyld_stub_binder+0x11b771000>
104532b00: 912d2ce7    	add	x7, x7, #0xb4b ; string '-[MMNewSessionMgr OnUnReadCountChange:]'
104532b04: aa1403e0    	mov	x0, x20
104532b08: aa1503e1    	mov	x1, x21
104532b0c: 52800042    	mov	w2, #0x2                ; =2
104532b10: 52800004    	mov	w4, #0x0                ; =0
104532b14: 52817586    	mov	w6, #0xbac              ; =2988
104532b18: 94dbd189    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104532b1c: aa1603e0    	mov	x0, x22
104532b20: 94dbd18d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104532b24: aa1303e0    	mov	x0, x19
104532b28: a9457bfd    	ldp	x29, x30, [sp, #0x50]
104532b2c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
104532b30: a94357f6    	ldp	x22, x21, [sp, #0x30]
104532b34: a9425ff8    	ldp	x24, x23, [sp, #0x20]
104532b38: a94167fa    	ldp	x26, x25, [sp, #0x10]
104532b3c: 910183ff    	add	sp, sp, #0x60
104532b40: 14dbd185    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
