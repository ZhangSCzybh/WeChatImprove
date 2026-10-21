
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104ff8520: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104ff8524: a90157f6    	stp	x22, x21, [sp, #0x10]
104ff8528: a9024ff4    	stp	x20, x19, [sp, #0x20]
104ff852c: a9037bfd    	stp	x29, x30, [sp, #0x30]
104ff8530: 9100c3fd    	add	x29, sp, #0x30
104ff8534: d12683ff    	sub	sp, sp, #0x9a0
104ff8538: f00c2fa8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff853c: f9405908    	ldr	x8, [x8, #0xb0]
104ff8540: f9400108    	ldr	x8, [x8]
104ff8544: f81c83a8    	stur	x8, [x29, #-0x38]
104ff8548: f00de228    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
104ff854c: 52800035    	mov	w21, #0x1               ; =1
104ff8550: 391ad515    	strb	w21, [x8, #0x6b5]
104ff8554: f9401013    	ldr	x19, [x0, #0x20]
104ff8558: f00d8cd6    	adrp	x22, 0x120193000 <dyld_stub_binder+0x120193000>
104ff855c: f947f6c0    	ldr	x0, [x22, #0xfe8]
104ff8560: b00d7208    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104ff8564: f947d501    	ldr	x1, [x8, #0xfa8] ; allProperties
104ff8568: 94b0baf5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff856c: 911bc3e8    	add	x8, sp, #0x6f0
104ff8570: 94b05270    	bl	0x107c0cf30 <_Flutter_MMFoundation_BindContext+0x40e8b14>
104ff8574: 912143e0    	add	x0, sp, #0x850
104ff8578: 911bc3e1    	add	x1, sp, #0x6f0
104ff857c: 94b051b2    	bl	0x107c0cc44 <_Flutter_MMFoundation_BindContext+0x40e8828>
104ff8580: f947f6c0    	ldr	x0, [x22, #0xfe8]
104ff8584: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff8588: f946d501    	ldr	x1, [x8, #0xda8] ; m_flag
104ff858c: 94b0baec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8590: aa0003f4    	mov	x20, x0
104ff8594: b9000fff    	str	wzr, [sp, #0xc]
104ff8598: 910b43e0    	add	x0, sp, #0x2d0
104ff859c: 910033e1    	add	x1, sp, #0xc
104ff85a0: 96c25db6    	bl	0x10008fc78 <__text+0x87c78>
104ff85a4: 9110c3f7    	add	x23, sp, #0x430
104ff85a8: 9110c3e8    	add	x8, sp, #0x430
104ff85ac: 9102e280    	add	x0, x20, #0xb8
104ff85b0: 910b43e1    	add	x1, sp, #0x2d0
104ff85b4: 94b05189    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104ff85b8: f947f6c0    	ldr	x0, [x22, #0xfe8]
104ff85bc: d00d7ce8    	adrp	x8, 0x11ff96000 <dyld_stub_binder+0x11ff96000>
104ff85c0: f9470d01    	ldr	x1, [x8, #0xe18] ; m_messgaeRelevanceType
104ff85c4: 94b0bade    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff85c8: aa0003f4    	mov	x20, x0
104ff85cc: f90003f5    	str	x21, [sp]
104ff85d0: 910043e0    	add	x0, sp, #0x10
104ff85d4: 910003e1    	mov	x1, sp
104ff85d8: 97ffff70    	bl	0x104ff8398 <_Flutter_MMFoundation_BindContext+0x14d3f7c>
104ff85dc: 9105c3e8    	add	x8, sp, #0x170
104ff85e0: 9102e280    	add	x0, x20, #0xb8
104ff85e4: 910043e1    	add	x1, sp, #0x10
104ff85e8: 94b0517c    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x40e87bc>
104ff85ec: 911643e8    	add	x8, sp, #0x590
104ff85f0: 9104a2e0    	add	x0, x23, #0x128
104ff85f4: 9105c3e1    	add	x1, sp, #0x170
104ff85f8: 94b0517a    	bl	0x107c0cbe0 <_Flutter_MMFoundation_BindContext+0x40e87c4>
104ff85fc: f00d72c8    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104ff8600: f9428901    	ldr	x1, [x8, #0x510] ; getValueOnResultColumn:where:
104ff8604: 912143e2    	add	x2, sp, #0x850
104ff8608: 911643e3    	add	x3, sp, #0x590
104ff860c: aa1303e0    	mov	x0, x19
104ff8610: 94b0bacb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8614: aa1d03fd    	mov	x29, x29
104ff8618: 94b0bacc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff861c: aa0003f4    	mov	x20, x0
104ff8620: b00d7228    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104ff8624: f9465d01    	ldr	x1, [x8, #0xcb8] ; numberValue
104ff8628: 94b0bac5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff862c: aa1d03fd    	mov	x29, x29
104ff8630: 94b0bac6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104ff8634: aa0003f5    	mov	x21, x0
104ff8638: f00d8888    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
104ff863c: f9424901    	ldr	x1, [x8, #0x490] ; unsignedIntValue
104ff8640: 94b0babf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104ff8644: aa0003f3    	mov	x19, x0
104ff8648: aa1503e0    	mov	x0, x21
104ff864c: 94b0bac2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8650: aa1403e0    	mov	x0, x20
104ff8654: 94b0bac0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104ff8658: 911643e0    	add	x0, sp, #0x590
104ff865c: 94b05189    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8660: 9105c3e0    	add	x0, sp, #0x170
104ff8664: 94b05187    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8668: 910043e0    	add	x0, sp, #0x10
104ff866c: 94b05185    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8670: 9110c3e0    	add	x0, sp, #0x430
104ff8674: 94b05183    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8678: 910b43e0    	add	x0, sp, #0x2d0
104ff867c: 94b05181    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8680: 912143e0    	add	x0, sp, #0x850
104ff8684: 94b0516f    	bl	0x107c0cc40 <_Flutter_MMFoundation_BindContext+0x40e8824>
104ff8688: 911bc3e0    	add	x0, sp, #0x6f0
104ff868c: 94b0517d    	bl	0x107c0cc80 <_Flutter_MMFoundation_BindContext+0x40e8864>
104ff8690: f85c83a8    	ldur	x8, [x29, #-0x38]
104ff8694: f00c2fa9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104ff8698: f9405929    	ldr	x9, [x9, #0xb0]
104ff869c: f9400129    	ldr	x9, [x9]
104ff86a0: eb08013f    	cmp	x9, x8
104ff86a4: 54000101    	b.ne	0x104ff86c4 <_Flutter_MMFoundation_BindContext+0x14d42a8>
104ff86a8: aa1303e0    	mov	x0, x19
104ff86ac: 912683ff    	add	sp, sp, #0x9a0
104ff86b0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104ff86b4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104ff86b8: a94157f6    	ldp	x22, x21, [sp, #0x10]
104ff86bc: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104ff86c0: d65f03c0    	ret
104ff86c4: 94b0baac    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
