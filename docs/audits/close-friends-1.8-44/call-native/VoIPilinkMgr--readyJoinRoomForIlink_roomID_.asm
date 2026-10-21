
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106262e84: d10183ff    	sub	sp, sp, #0x60
106262e88: a90167fa    	stp	x26, x25, [sp, #0x10]
106262e8c: a9025ff8    	stp	x24, x23, [sp, #0x20]
106262e90: a90357f6    	stp	x22, x21, [sp, #0x30]
106262e94: a9044ff4    	stp	x20, x19, [sp, #0x40]
106262e98: a9057bfd    	stp	x29, x30, [sp, #0x50]
106262e9c: 910143fd    	add	x29, sp, #0x50
106262ea0: aa0303f5    	mov	x21, x3
106262ea4: aa0203f4    	mov	x20, x2
106262ea8: aa0003f3    	mov	x19, x0
106262eac: b00d4f08    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106262eb0: 52800039    	mov	w25, #0x1               ; =1
106262eb4: 39269919    	strb	w25, [x8, #0x9a6]
106262eb8: 52800040    	mov	w0, #0x2                ; =2
106262ebc: 9466a8e1    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106262ec0: 34000560    	cbz	w0, 0x106262f6c <_Flutter_MMFoundation_BindContext+0x273eb50>
106262ec4: 946710b7    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106262ec8: aa0003f6    	mov	x22, x0
106262ecc: b00cf898    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106262ed0: f9454700    	ldr	x0, [x24, #0xa88]
106262ed4: 946710a3    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106262ed8: aa0003f7    	mov	x23, x0
106262edc: f9454700    	ldr	x0, [x24, #0xa88]
106262ee0: 900cf548    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106262ee4: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
106262ee8: a9007ff5    	stp	x21, xzr, [sp]
106262eec: f00c30a2    	adrp	x2, 0x11e879000 <dyld_stub_binder+0x11e879000>
106262ef0: 9125a042    	add	x2, x2, #0x968
106262ef4: 94671092    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262ef8: aa1d03fd    	mov	x29, x29
106262efc: 94671093    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106262f00: aa0003f8    	mov	x24, x0
106262f04: 900cf508    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106262f08: f947d101    	ldr	x1, [x8, #0xfa0] ; initWithFormat:
106262f0c: b00c11c8    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106262f10: 91352108    	add	x8, x8, #0xd48
106262f14: a90003e8    	stp	x8, x0, [sp]
106262f18: b00c11c2    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106262f1c: 9134a042    	add	x2, x2, #0xd28
106262f20: aa1703e0    	mov	x0, x23
106262f24: 94671086    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262f28: aa0003f7    	mov	x23, x0
106262f2c: aa1803e0    	mov	x0, x24
106262f30: 94671089    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262f34: f00a7d81    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
106262f38: 9124e421    	add	x1, x1, #0x939
106262f3c: 900ab9e2    	adrp	x2, 0x11b99e000 <dyld_stub_binder+0x11b99e000>
106262f40: 91112042    	add	x2, x2, #0x448
106262f44: d00ab9e4    	adrp	x4, 0x11b9a0000 <dyld_stub_binder+0x11b9a0000>
106262f48: 9134a484    	add	x4, x4, #0xd29
106262f4c: 52800040    	mov	w0, #0x2                ; =2
106262f50: 528190a3    	mov	w3, #0xc85              ; =3205
106262f54: aa1703e5    	mov	x5, x23
106262f58: 9466a8bb    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106262f5c: aa1703e0    	mov	x0, x23
106262f60: 9467107d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106262f64: aa1603e0    	mov	x0, x22
106262f68: 94671091    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106262f6c: b00ceb88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106262f70: f9430d01    	ldr	x1, [x8, #0x618] ; setJoinToRoom:
106262f74: aa1303e0    	mov	x0, x19
106262f78: 52800022    	mov	w2, #0x1                ; =1
106262f7c: 94671070    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262f80: b00ceb88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106262f84: f942d501    	ldr	x1, [x8, #0x5a8] ; setChangeToMultiTalk:
106262f88: aa1303e0    	mov	x0, x19
106262f8c: 52800022    	mov	w2, #0x1                ; =1
106262f90: 9467106b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262f94: 900cdec8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106262f98: f947c101    	ldr	x1, [x8, #0xf80] ; setIsThisTalkIlink:
106262f9c: aa1303e0    	mov	x0, x19
106262fa0: 52800022    	mov	w2, #0x1                ; =1
106262fa4: 94671066    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262fa8: b00ceb88    	adrp	x8, 0x11ffd3000 <dyld_stub_binder+0x11ffd3000>
106262fac: f942b101    	ldr	x1, [x8, #0x560] ; setMRoomId:
106262fb0: aa1303e0    	mov	x0, x19
106262fb4: aa1503e2    	mov	x2, x21
106262fb8: 94671061    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262fbc: 71000a9f    	cmp	w20, #0x2
106262fc0: 1a9f17e2    	cset	w2, eq
106262fc4: 900ceb88    	adrp	x8, 0x11ffd2000 <dyld_stub_binder+0x11ffd2000>
106262fc8: f9418501    	ldr	x1, [x8, #0x308] ; setIsAudio:
106262fcc: aa1303e0    	mov	x0, x19
106262fd0: 9467105b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106262fd4: d00cfea8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
106262fd8: b98b3d08    	ldrsw	x8, [x8, #0xb3c]
106262fdc: 38286a79    	strb	w25, [x19, x8]
106262fe0: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106262fe4: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106262fe8: a94357f6    	ldp	x22, x21, [sp, #0x30]
106262fec: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106262ff0: a94167fa    	ldp	x26, x25, [sp, #0x10]
106262ff4: 910183ff    	add	sp, sp, #0x60
106262ff8: d65f03c0    	ret
