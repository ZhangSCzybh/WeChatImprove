
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ff9200: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
108ff9204: a90157f6    	stp	x22, x21, [sp, #0x10]
108ff9208: a9024ff4    	stp	x20, x19, [sp, #0x20]
108ff920c: a9037bfd    	stp	x29, x30, [sp, #0x30]
108ff9210: 9100c3fd    	add	x29, sp, #0x30
108ff9214: aa0303f4    	mov	x20, x3
108ff9218: aa0203f3    	mov	x19, x2
108ff921c: aa0003f5    	mov	x21, x0
108ff9220: aa0203e0    	mov	x0, x2
108ff9224: 95a18887    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ff9228: aa1403e0    	mov	x0, x20
108ff922c: 95a18885    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ff9230: 900b8c08    	adrp	x8, 0x120179000 <dyld_stub_binder+0x120179000>
108ff9234: f9455500    	ldr	x0, [x8, #0xaa8] ; `AC
108ff9238: d00b8828    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
108ff923c: f947ad16    	ldr	x22, [x8, #0xf58] ; class
108ff9240: aa1603e1    	mov	x1, x22
108ff9244: 95a18880    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9248: aa0003e2    	mov	x2, x0
108ff924c: d00b8848    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
108ff9250: f9442d17    	ldr	x23, [x8, #0x858] ; isKindOfClass:
108ff9254: aa1303e0    	mov	x0, x19
108ff9258: aa1703e1    	mov	x1, x23
108ff925c: 95a1887a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9260: 36000080    	tbz	w0, #0x0, 0x108ff9270 <_Flutter_MMFoundation_BindContext+0x54d4e54>
108ff9264: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff9268: 91036108    	add	x8, x8, #0xd8
108ff926c: 1400000c    	b	0x108ff929c <_Flutter_MMFoundation_BindContext+0x54d4e80>
108ff9270: d00b8d68    	adrp	x8, 0x1201a7000 <dyld_stub_binder+0x1201a7000>
108ff9274: f9402500    	ldr	x0, [x8, #0x48]
108ff9278: aa1603e1    	mov	x1, x22
108ff927c: 95a18872    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9280: aa0003e2    	mov	x2, x0
108ff9284: aa1303e0    	mov	x0, x19
108ff9288: aa1703e1    	mov	x1, x23
108ff928c: 95a1886e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9290: 34000140    	cbz	w0, 0x108ff92b8 <_Flutter_MMFoundation_BindContext+0x54d4e9c>
108ff9294: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff9298: 91038108    	add	x8, x8, #0xe0
108ff929c: f9400101    	ldr	x1, [x8]
108ff92a0: aa1503e0    	mov	x0, x21
108ff92a4: aa1303e2    	mov	x2, x19
108ff92a8: aa1403e3    	mov	x3, x20
108ff92ac: 95a18866    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff92b0: 52800035    	mov	w21, #0x1               ; =1
108ff92b4: 14000002    	b	0x108ff92bc <_Flutter_MMFoundation_BindContext+0x54d4ea0>
108ff92b8: 52800015    	mov	w21, #0x0               ; =0
108ff92bc: aa1403e0    	mov	x0, x20
108ff92c0: 95a18867    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ff92c4: aa1303e0    	mov	x0, x19
108ff92c8: 95a18865    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ff92cc: aa1503e0    	mov	x0, x21
108ff92d0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
108ff92d4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
108ff92d8: a94157f6    	ldp	x22, x21, [sp, #0x10]
108ff92dc: a8c45ff8    	ldp	x24, x23, [sp], #0x40
108ff92e0: d65f03c0    	ret
