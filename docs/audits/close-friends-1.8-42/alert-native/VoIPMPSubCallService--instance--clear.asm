
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106168488: d10103ff    	sub	sp, sp, #0x40
10616848c: a90157f6    	stp	x22, x21, [sp, #0x10]
106168490: a9024ff4    	stp	x20, x19, [sp, #0x20]
106168494: a9037bfd    	stp	x29, x30, [sp, #0x30]
106168498: 9100c3fd    	add	x29, sp, #0x30
10616849c: aa0003f3    	mov	x19, x0
1061684a0: 52800040    	mov	w0, #0x2                ; =2
1061684a4: 946a9367    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1061684a8: 34000560    	cbz	w0, 0x106168554 <_Flutter_MMFoundation_BindContext+0x2644138>
1061684ac: 946afb3d    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1061684b0: aa0003f4    	mov	x20, x0
1061684b4: f00d0056    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
1061684b8: f94546c0    	ldr	x0, [x22, #0xa88]
1061684bc: 946afb29    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1061684c0: aa0003f5    	mov	x21, x0
1061684c4: f94546c0    	ldr	x0, [x22, #0xa88]
1061684c8: d00cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1061684cc: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
1061684d0: f90003ff    	str	xzr, [sp]
1061684d4: f00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
1061684d8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='Prepare to clear all status ...'
1061684dc: 946afb18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1061684e0: aa1d03fd    	mov	x29, x29
1061684e4: 946afb19    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1061684e8: aa0003f6    	mov	x22, x0
1061684ec: d00cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1061684f0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
1061684f4: f00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1061684f8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
1061684fc: a90003e8    	stp	x8, x0, [sp]
106168500: f00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106168504: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106168508: aa1503e0    	mov	x0, x21
10616850c: 946afb0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106168510: aa0003f5    	mov	x21, x0
106168514: aa1603e0    	mov	x0, x22
106168518: 946afb0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616851c: f00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106168520: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
106168524: f00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106168528: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616852c: f00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
106168530: 9130b884    	add	x4, x4, #0xc2e ; cstring='-[VoIPMPSubCallService clear]'
106168534: 52800040    	mov	w0, #0x2                ; =2
106168538: 52801a03    	mov	w3, #0xd0               ; =208
10616853c: aa1503e5    	mov	x5, x21
106168540: 946a9341    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106168544: aa1503e0    	mov	x0, x21
106168548: 946afb03    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616854c: aa1403e0    	mov	x0, x20
106168550: 946afb17    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106168554: d00cf2a8    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
106168558: f9433d01    	ldr	x1, [x8, #0x678] ; selector=setCache:
10616855c: aa1303e0    	mov	x0, x19
106168560: d2800002    	mov	x2, #0x0                ; =0
106168564: 946afaf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106168568: b00cf348    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10616856c: f940a501    	ldr	x1, [x8, #0x148] ; selector=setIsWaitingForAccept:
106168570: aa1303e0    	mov	x0, x19
106168574: 52800002    	mov	w2, #0x0                ; =0
106168578: a9437bfd    	ldp	x29, x30, [sp, #0x30]
10616857c: a9424ff4    	ldp	x20, x19, [sp, #0x20]
106168580: a94157f6    	ldp	x22, x21, [sp, #0x10]
106168584: 910103ff    	add	sp, sp, #0x40
106168588: 146afaed    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
