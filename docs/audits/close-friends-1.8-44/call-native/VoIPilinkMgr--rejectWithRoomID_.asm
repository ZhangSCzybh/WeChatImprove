
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106255454: d10103ff    	sub	sp, sp, #0x40
106255458: a90157f6    	stp	x22, x21, [sp, #0x10]
10625545c: a9024ff4    	stp	x20, x19, [sp, #0x20]
106255460: a9037bfd    	stp	x29, x30, [sp, #0x30]
106255464: 9100c3fd    	add	x29, sp, #0x30
106255468: aa0203f3    	mov	x19, x2
10625546c: aa0003f4    	mov	x20, x0
106255470: d00d4f68    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106255474: 52800029    	mov	w9, #0x1                ; =1
106255478: 3925c109    	strb	w9, [x8, #0x970]
10625547c: d00cf8e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106255480: f9453500    	ldr	x0, [x8, #0xa68]
106255484: 900cdf28    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106255488: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10625548c: f00c3108    	adrp	x8, 0x11e878000 <dyld_stub_binder+0x11e878000>
106255490: 913a2108    	add	x8, x8, #0xe88
106255494: a9000be8    	stp	x8, x2, [sp]
106255498: 900a9163    	adrp	x3, 0x11b481000 <dyld_stub_binder+0x11b481000>
10625549c: 91056463    	add	x3, x3, #0x159
1062554a0: b00aba45    	adrp	x5, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
1062554a4: 911120a5    	add	x5, x5, #0x448
1062554a8: d00aba47    	adrp	x7, 0x11b99f000 <dyld_stub_binder+0x11b99f000>
1062554ac: 910f28e7    	add	x7, x7, #0x3ca
1062554b0: 52800042    	mov	w2, #0x2                ; =2
1062554b4: 52800004    	mov	w4, #0x0                ; =0
1062554b8: 5280a306    	mov	w6, #0x518              ; =1304
1062554bc: 94674720    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062554c0: d00cf568    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1062554c4: f9437501    	ldr	x1, [x8, #0x6e8] ; isConnected
1062554c8: aa1403e0    	mov	x0, x20
1062554cc: 9467471c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062554d0: 340000e0    	cbz	w0, 0x1062554ec <_Flutter_MMFoundation_BindContext+0x27310d0>
1062554d4: b00ce508    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
1062554d8: f9402901    	ldr	x1, [x8, #0x50] ; mRoomId
1062554dc: aa1403e0    	mov	x0, x20
1062554e0: 94674717    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062554e4: eb13001f    	cmp	x0, x19
1062554e8: 54000141    	b.ne	0x106255510 <_Flutter_MMFoundation_BindContext+0x27310f4>
1062554ec: 900cea08    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
1062554f0: f9419d01    	ldr	x1, [x8, #0x338] ; hangupWithRoomID:
1062554f4: aa1403e0    	mov	x0, x20
1062554f8: aa1303e2    	mov	x2, x19
1062554fc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
106255500: a9424ff4    	ldp	x20, x19, [sp, #0x20]
106255504: a94157f6    	ldp	x22, x21, [sp, #0x10]
106255508: 910103ff    	add	sp, sp, #0x40
10625550c: 1467470c    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255510: d00cf9f6    	adrp	x22, 0x120193000 <dyld_stub_binder+0x120193000>
106255514: f9471ac0    	ldr	x0, [x22, #0xe30]
106255518: 900cea08    	adrp	x8, 0x11ff95000 <dyld_stub_binder+0x11ff95000>
10625551c: f941a914    	ldr	x20, [x8, #0x350] ; defaultService
106255520: aa1403e1    	mov	x1, x20
106255524: 94674706    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255528: aa1d03fd    	mov	x29, x29
10625552c: 94674707    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106255530: aa0003f5    	mov	x21, x0
106255534: 94674708    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106255538: b40001b5    	cbz	x21, 0x10625556c <_Flutter_MMFoundation_BindContext+0x2731150>
10625553c: f9471ac0    	ldr	x0, [x22, #0xe30]
106255540: aa1403e1    	mov	x1, x20
106255544: 946746fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255548: aa1d03fd    	mov	x29, x29
10625554c: 946746ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106255550: aa0003f4    	mov	x20, x0
106255554: d00cebe8    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106255558: f943b501    	ldr	x1, [x8, #0x768] ; rejectWithRoomID:
10625555c: aa1303e2    	mov	x2, x19
106255560: 946746f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255564: aa1403e0    	mov	x0, x20
106255568: 946746fb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10625556c: d00cf9e8    	adrp	x8, 0x120193000 <dyld_stub_binder+0x120193000>
106255570: f946d900    	ldr	x0, [x8, #0xdb0] ; p*;
106255574: b00cf5a8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106255578: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
10625557c: 946746f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255580: aa1d03fd    	mov	x29, x29
106255584: 946746f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106255588: aa0003f3    	mov	x19, x0
10625558c: 900cebe8    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
106255590: f940f101    	ldr	x1, [x8, #0x1e0] ; reject
106255594: 946746ea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106255598: aa1303e0    	mov	x0, x19
10625559c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1062555a0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1062555a4: a94157f6    	ldp	x22, x21, [sp, #0x10]
1062555a8: 910103ff    	add	sp, sp, #0x40
1062555ac: 146746ea    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
