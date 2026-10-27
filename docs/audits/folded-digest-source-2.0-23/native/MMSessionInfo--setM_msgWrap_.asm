
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1046ae114: d10103ff    	sub	sp, sp, #0x40
1046ae118: a90157f6    	stp	x22, x21, [sp, #0x10]
1046ae11c: a9024ff4    	stp	x20, x19, [sp, #0x20]
1046ae120: a9037bfd    	stp	x29, x30, [sp, #0x30]
1046ae124: 9100c3fd    	add	x29, sp, #0x30
1046ae128: aa0203f3    	mov	x19, x2
1046ae12c: aa0003f4    	mov	x20, x0
1046ae130: f00e2c68    	adrp	x8, 0x120c3d000 <dyld_stub_binder+0x120c3d000>
1046ae134: 52800029    	mov	w9, #0x1                ; =1
1046ae138: 39128109    	strb	w9, [x8, #0x4a0]
1046ae13c: aa0203e0    	mov	x0, x2
1046ae140: 94d5e3fe    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1046ae144: aa1403e0    	mov	x0, x20
1046ae148: f8428c08    	ldr	x8, [x0, #0x28]!
1046ae14c: eb13011f    	cmp	x8, x19
1046ae150: 54000a40    	b.eq	0x1046ae298 <_Flutter_MMFoundation_BindContext+0xb89e7c>
1046ae154: aa1303e1    	mov	x1, x19
1046ae158: 94d5e3fa    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
1046ae15c: b5000233    	cbnz	x19, 0x1046ae1a0 <_Flutter_MMFoundation_BindContext+0xb89d84>
1046ae160: b00dd628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1046ae164: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
1046ae168: f00dbc48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1046ae16c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1046ae170: f00cf0e8    	adrp	x8, 0x11e4cd000 <dyld_stub_binder+0x11e4cd000>
1046ae174: 91132108    	add	x8, x8, #0x4c8 ; CFString 'msg is nil'
1046ae178: f90003e8    	str	x8, [sp]
1046ae17c: f00b8705    	adrp	x5, 0x11b791000 <dyld_stub_binder+0x11b791000>
1046ae180: 912584a5    	add	x5, x5, #0x961
1046ae184: f00b8707    	adrp	x7, 0x11b791000 <dyld_stub_binder+0x11b791000>
1046ae188: 9126ece7    	add	x7, x7, #0x9bb
1046ae18c: 52800082    	mov	w2, #0x4                ; =4
1046ae190: d2800003    	mov	x3, #0x0                ; =0
1046ae194: 52800004    	mov	w4, #0x0                ; =0
1046ae198: 52801d86    	mov	w6, #0xec               ; =236
1046ae19c: 94d5e3e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae1a0: 900dc608    	adrp	x8, 0x11ff6e000 <dyld_stub_binder+0x11ff6e000>
1046ae1a4: f941f901    	ldr	x1, [x8, #0x3f0] ; forbidDisplayInSession
1046ae1a8: aa1303e0    	mov	x0, x19
1046ae1ac: 94d5e3e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae1b0: 34000380    	cbz	w0, 0x1046ae220 <_Flutter_MMFoundation_BindContext+0xb89e04>
1046ae1b4: b00dd628    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1046ae1b8: f9453515    	ldr	x21, [x8, #0xa68] ; iConsole
1046ae1bc: d00dbc68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1046ae1c0: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
1046ae1c4: aa1303e0    	mov	x0, x19
1046ae1c8: 94d5e3dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae1cc: f00dbc48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1046ae1d0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1046ae1d4: b00d05c8    	adrp	x8, 0x11e767000 <dyld_stub_binder+0x11e767000>
1046ae1d8: 9118a108    	add	x8, x8, #0x628 ; CFString 'msg:%lld is forbidDisplayInSession'
1046ae1dc: a90003e8    	stp	x8, x0, [sp]
1046ae1e0: f00b8705    	adrp	x5, 0x11b791000 <dyld_stub_binder+0x11b791000>
1046ae1e4: 912584a5    	add	x5, x5, #0x961
1046ae1e8: f00b8707    	adrp	x7, 0x11b791000 <dyld_stub_binder+0x11b791000>
1046ae1ec: 9126ece7    	add	x7, x7, #0x9bb
1046ae1f0: aa1503e0    	mov	x0, x21
1046ae1f4: 52800082    	mov	w2, #0x4                ; =4
1046ae1f8: d2800003    	mov	x3, #0x0                ; =0
1046ae1fc: 52800004    	mov	w4, #0x0                ; =0
1046ae200: 52801e06    	mov	w6, #0xf0               ; =240
1046ae204: 94d5e3ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae208: 52800520    	mov	w0, #0x29               ; =41
1046ae20c: 528001e1    	mov	w1, #0xf                ; =15
1046ae210: 52800022    	mov	w2, #0x1                ; =1
1046ae214: 52800003    	mov	w3, #0x0                ; =0
1046ae218: 52800004    	mov	w4, #0x0                ; =0
1046ae21c: 976287d8    	bl	0x101f5017c <_Flutter_Image_provideRelativePathByUrl+0x35d02c>
1046ae220: b00dd668    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
1046ae224: f941fd00    	ldr	x0, [x8, #0x3f8] ; ChatBoxUtil
1046ae228: f9400682    	ldr	x2, [x20, #0x8]
1046ae22c: d00dbe88    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
1046ae230: f9437901    	ldr	x1, [x8, #0x6f0] ; isChatBox:
1046ae234: 94d5e3c2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae238: 37000300    	tbnz	w0, #0x0, 0x1046ae298 <_Flutter_MMFoundation_BindContext+0xb89e7c>
1046ae23c: 900dbc88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1046ae240: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
1046ae244: aa1303e0    	mov	x0, x19
1046ae248: 94d5e3bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae24c: aa1d03fd    	mov	x29, x29
1046ae250: 94d5e3be    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1046ae254: aa0003f5    	mov	x21, x0
1046ae258: b00dd2a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1046ae25c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
1046ae260: 94d5e3b7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae264: aa0003f6    	mov	x22, x0
1046ae268: aa1503e0    	mov	x0, x21
1046ae26c: 94d5e3ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1046ae270: b4000156    	cbz	x22, 0x1046ae298 <_Flutter_MMFoundation_BindContext+0xb89e7c>
1046ae274: f9401680    	ldr	x0, [x20, #0x28]
1046ae278: b00dc628    	adrp	x8, 0x11ff73000 <dyld_stub_binder+0x11ff73000>
1046ae27c: f947f901    	ldr	x1, [x8, #0xff0] ; getSessionTime
1046ae280: 94d5e3af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae284: aa0003e2    	mov	x2, x0
1046ae288: 900dbcc8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
1046ae28c: f9430d01    	ldr	x1, [x8, #0x618] ; setM_uLastTime:
1046ae290: aa1403e0    	mov	x0, x20
1046ae294: 94d5e3aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1046ae298: aa1303e0    	mov	x0, x19
1046ae29c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1046ae2a0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1046ae2a4: a94157f6    	ldp	x22, x21, [sp, #0x10]
1046ae2a8: 910103ff    	add	sp, sp, #0x40
1046ae2ac: 14d5e3aa    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
