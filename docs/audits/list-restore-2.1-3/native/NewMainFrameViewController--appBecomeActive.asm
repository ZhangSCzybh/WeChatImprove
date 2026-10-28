
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105110df8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
105110dfc: a90157f6    	stp	x22, x21, [sp, #0x10]
105110e00: a9024ff4    	stp	x20, x19, [sp, #0x20]
105110e04: a9037bfd    	stp	x29, x30, [sp, #0x30]
105110e08: 9100c3fd    	add	x29, sp, #0x30
105110e0c: aa0003f3    	mov	x19, x0
105110e10: f00d8317    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
105110e14: f9458ee0    	ldr	x0, [x23, #0xb18]
105110e18: 900d7f88    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105110e1c: f946b114    	ldr	x20, [x8, #0xd60] ; defaultCenter
105110e20: aa1403e1    	mov	x1, x20
105110e24: 94ac58c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110e28: aa1d03fd    	mov	x29, x29
105110e2c: 94ac58c7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105110e30: aa0003f5    	mov	x21, x0
105110e34: 900c2a68    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
105110e38: 91388108    	add	x8, x8, #0xe20
105110e3c: f9400103    	ldr	x3, [x8]
105110e40: d00d7fa8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
105110e44: f9416516    	ldr	x22, [x8, #0x2c8] ; removeObserver:name:object:
105110e48: aa1603e1    	mov	x1, x22
105110e4c: aa1303e2    	mov	x2, x19
105110e50: d2800004    	mov	x4, #0x0                ; =0
105110e54: 94ac58ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110e58: aa1503e0    	mov	x0, x21
105110e5c: 94ac58be    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105110e60: f9458ee0    	ldr	x0, [x23, #0xb18]
105110e64: aa1403e1    	mov	x1, x20
105110e68: 94ac58b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110e6c: aa1d03fd    	mov	x29, x29
105110e70: 94ac58b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105110e74: aa0003f4    	mov	x20, x0
105110e78: 900c2a68    	adrp	x8, 0x11d65c000 <dyld_stub_binder+0x11d65c000>
105110e7c: 9138a108    	add	x8, x8, #0xe28
105110e80: f9400103    	ldr	x3, [x8]
105110e84: aa1603e1    	mov	x1, x22
105110e88: aa1303e2    	mov	x2, x19
105110e8c: d2800004    	mov	x4, #0x0                ; =0
105110e90: 94ac58ab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110e94: aa1403e0    	mov	x0, x20
105110e98: 94ac58af    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105110e9c: b00d8408    	adrp	x8, 0x120191000 <dyld_stub_binder+0x120191000>
105110ea0: f941a900    	ldr	x0, [x8, #0x350] ; WCLazyInitObjectMgr
105110ea4: d00d7fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
105110ea8: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
105110eac: 94ac58a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110eb0: aa1d03fd    	mov	x29, x29
105110eb4: 94ac58a5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105110eb8: aa0003f4    	mov	x20, x0
105110ebc: d00d7328    	adrp	x8, 0x11ff76000 <dyld_stub_binder+0x11ff76000>
105110ec0: f947b101    	ldr	x1, [x8, #0xf60] ; addLazyInitObject:
105110ec4: aa1303e2    	mov	x2, x19
105110ec8: 94ac589d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105110ecc: aa1403e0    	mov	x0, x20
105110ed0: 94ac58a1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105110ed4: d00d7448    	adrp	x8, 0x11ff9a000 <dyld_stub_binder+0x11ff9a000>
105110ed8: f945a101    	ldr	x1, [x8, #0xb40] ; delayToLoadMainTableViewData
105110edc: aa1303e0    	mov	x0, x19
105110ee0: a9437bfd    	ldp	x29, x30, [sp, #0x30]
105110ee4: a9424ff4    	ldp	x20, x19, [sp, #0x20]
105110ee8: a94157f6    	ldp	x22, x21, [sp, #0x10]
105110eec: a8c45ff8    	ldp	x24, x23, [sp], #0x40
105110ef0: 14ac5893    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
