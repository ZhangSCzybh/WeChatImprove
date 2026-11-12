
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
10546123c: d100c3ff    	sub	sp, sp, #0x30
105461240: a9027bfd    	stp	x29, x30, [sp, #0x20]
105461244: 910083fd    	add	x29, sp, #0x20
105461248: b00cc588    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10546124c: f9430d00    	ldr	x0, [x8, #0x618] ; class iConsole
105461250: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461254: f9418901    	ldr	x1, [x8, #0x310] ; selector logWithLevel:module:errorCode:file:line:func:format:
105461258: 2a020068    	orr	w8, w3, w2
10546125c: 340001e8    	cbz	w8, 0x105461298 <_Flutter_MMFoundation_BindContext+0x16e7f64>
105461260: a9008fe2    	stp	x2, x3, [sp, #0x8]
105461264: b00bf4a8    	adrp	x8, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
105461268: 912fe108    	add	x8, x8, #0xbf8 ; cfstring 'BgFgResponse failed, errType=%d, errCode=%d'
10546126c: f90003e8    	str	x8, [sp]
105461270: 900a44a3    	adrp	x3, 0x119cf5000 <dyld_stub_binder+0x119cf5000>
105461274: 913ebc63    	add	x3, x3, #0xfaf ; 'Sync'
105461278: d00a6de5    	adrp	x5, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
10546127c: 912b44a5    	add	x5, x5, #0xad1 ; 'NewSyncService.mm'
105461280: d00a6de7    	adrp	x7, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
105461284: 912b8ce7    	add	x7, x7, #0xae3 ; '+[NewSyncService logBgFgResponseWithErrType:errCode:]'
105461288: 52800062    	mov	w2, #0x3                ; =3
10546128c: 52800004    	mov	w4, #0x0                ; =0
105461290: 52800b06    	mov	w6, #0x58               ; =88
105461294: 1400000d    	b	0x1054612c8 <_Flutter_MMFoundation_BindContext+0x16e7f94>
105461298: b00bf4a8    	adrp	x8, 0x11d2f6000 <dyld_stub_binder+0x11d2f6000>
10546129c: 91306108    	add	x8, x8, #0xc18 ; cfstring 'BgFgResponse success'
1054612a0: f90003e8    	str	x8, [sp]
1054612a4: 900a44a3    	adrp	x3, 0x119cf5000 <dyld_stub_binder+0x119cf5000>
1054612a8: 913ebc63    	add	x3, x3, #0xfaf ; 'Sync'
1054612ac: d00a6de5    	adrp	x5, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
1054612b0: 912b44a5    	add	x5, x5, #0xad1 ; 'NewSyncService.mm'
1054612b4: d00a6de7    	adrp	x7, 0x11a21f000 <dyld_stub_binder+0x11a21f000>
1054612b8: 912b8ce7    	add	x7, x7, #0xae3 ; '+[NewSyncService logBgFgResponseWithErrType:errCode:]'
1054612bc: 52800042    	mov	w2, #0x2                ; =2
1054612c0: 52800004    	mov	w4, #0x0                ; =0
1054612c4: 52800b66    	mov	w6, #0x5b               ; =91
1054612c8: 949f1a67    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1054612cc: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1054612d0: 9100c3ff    	add	sp, sp, #0x30
1054612d4: d65f03c0    	ret
