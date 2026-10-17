
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104afa474: a9bc6ffc    	stp	x28, x27, [sp, #-0x40]!
104afa478: a90157f6    	stp	x22, x21, [sp, #0x10]
104afa47c: a9024ff4    	stp	x20, x19, [sp, #0x20]
104afa480: a9037bfd    	stp	x29, x30, [sp, #0x30]
104afa484: 9100c3fd    	add	x29, sp, #0x30
104afa488: d10c03ff    	sub	sp, sp, #0x300
104afa48c: aa0303f5    	mov	x21, x3
104afa490: aa0203f3    	mov	x19, x2
104afa494: aa0003f4    	mov	x20, x0
104afa498: b00c57a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104afa49c: f9405908    	ldr	x8, [x8, #0xb0]
104afa4a0: f9400108    	ldr	x8, [x8]
104afa4a4: f81c83a8    	stur	x8, [x29, #-0x38]
104afa4a8: 900e0a28    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104afa4ac: 52800029    	mov	w9, #0x1                ; =1
104afa4b0: 39129d09    	strb	w9, [x8, #0x4a7]
104afa4b4: aa0203e0    	mov	x0, x2
104afa4b8: 94c4b320    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104afa4bc: b4000615    	cbz	x21, 0x104afa57c <_Flutter_MMFoundation_BindContext+0xfd6160>
104afa4c0: b00db428    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
104afa4c4: f9409d00    	ldr	x0, [x8, #0x138]
104afa4c8: b00d9ac8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104afa4cc: f942c901    	ldr	x1, [x8, #0x590] ; msgServerId
104afa4d0: 94c4b31b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104afa4d4: aa0003f6    	mov	x22, x0
104afa4d8: f9001bf5    	str	x21, [sp, #0x30]
104afa4dc: 9100e3e0    	add	x0, sp, #0x38
104afa4e0: 9100c3e1    	add	x1, sp, #0x30
104afa4e4: 96e46a29    	bl	0x100414d88 <__text+0x40cd88>
104afa4e8: 910663e8    	add	x8, sp, #0x198
104afa4ec: 9102e2c0    	add	x0, x22, #0xb8
104afa4f0: 9100e3e1    	add	x1, sp, #0x38
104afa4f4: 94c449b9    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104afa4f8: 910043e8    	add	x8, sp, #0x10
104afa4fc: 91002115    	add	x21, x8, #0x8
104afa500: a9027ff5    	stp	x21, xzr, [sp, #0x20]
104afa504: b00c57e8    	adrp	x8, 0x11d5f7000 <dyld_stub_binder+0x11d5f7000>
104afa508: 9139e108    	add	x8, x8, #0xe78
104afa50c: a90157e8    	stp	x8, x21, [sp, #0x10]
104afa510: 900da468    	adrp	x8, 0x11ff86000 <dyld_stub_binder+0x11ff86000>
104afa514: f940cd01    	ldr	x1, [x8, #0x198] ; GetMsg:Where:order:Limit:
104afa518: 910663e3    	add	x3, sp, #0x198
104afa51c: 910043e4    	add	x4, sp, #0x10
104afa520: aa1403e0    	mov	x0, x20
104afa524: aa1303e2    	mov	x2, x19
104afa528: 12800005    	mov	w5, #-0x1               ; =-1
104afa52c: 94c4b304    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104afa530: aa1d03fd    	mov	x29, x29
104afa534: 94c4b305    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104afa538: aa0003f6    	mov	x22, x0
104afa53c: aa1503e0    	mov	x0, x21
104afa540: 96d66967    	bl	0x100094adc <__text+0x8cadc>
104afa544: 910663e0    	add	x0, sp, #0x198
104afa548: 94c449ce    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104afa54c: 9100e3e0    	add	x0, sp, #0x38
104afa550: 94c449cc    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104afa554: f00db028    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104afa558: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
104afa55c: aa1603e0    	mov	x0, x22
104afa560: 94c4b2f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104afa564: aa1d03fd    	mov	x29, x29
104afa568: 94c4b2f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104afa56c: aa0003f4    	mov	x20, x0
104afa570: aa1603e0    	mov	x0, x22
104afa574: 94c4b2f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104afa578: 14000012    	b	0x104afa5c0 <_Flutter_MMFoundation_BindContext+0xfd61a4>
104afa57c: b00db3c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104afa580: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
104afa584: f00d99e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104afa588: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104afa58c: 900ce548    	adrp	x8, 0x11e7a2000 <dyld_stub_binder+0x11e7a2000>
104afa590: 91152108    	add	x8, x8, #0x548
104afa594: f90003e8    	str	x8, [sp]
104afa598: d00b67e5    	adrp	x5, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104afa59c: 91027ca5    	add	x5, x5, #0x9f
104afa5a0: d00b67e7    	adrp	x7, 0x11b7f8000 <dyld_stub_binder+0x11b7f8000>
104afa5a4: 911560e7    	add	x7, x7, #0x558
104afa5a8: 52800082    	mov	w2, #0x4                ; =4
104afa5ac: d2800003    	mov	x3, #0x0                ; =0
104afa5b0: 52800004    	mov	w4, #0x0                ; =0
104afa5b4: 528064e6    	mov	w6, #0x327              ; =807
104afa5b8: 94c4b2e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104afa5bc: d2800014    	mov	x20, #0x0               ; =0
104afa5c0: aa1303e0    	mov	x0, x19
104afa5c4: 94c4b2e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104afa5c8: f85c83a8    	ldur	x8, [x29, #-0x38]
104afa5cc: b00c57a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104afa5d0: f9405929    	ldr	x9, [x9, #0xb0]
104afa5d4: f9400129    	ldr	x9, [x9]
104afa5d8: eb08013f    	cmp	x9, x8
104afa5dc: 54000101    	b.ne	0x104afa5fc <_Flutter_MMFoundation_BindContext+0xfd61e0>
104afa5e0: aa1403e0    	mov	x0, x20
104afa5e4: 910c03ff    	add	sp, sp, #0x300
104afa5e8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104afa5ec: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104afa5f0: a94157f6    	ldp	x22, x21, [sp, #0x10]
104afa5f4: a8c46ffc    	ldp	x28, x27, [sp], #0x40
104afa5f8: 14c4b2de    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104afa5fc: 94c4b2de    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>