
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105754c50: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105754c54: a9014ff4    	stp	x20, x19, [sp, #0x10]
105754c58: a9027bfd    	stp	x29, x30, [sp, #0x20]
105754c5c: 910083fd    	add	x29, sp, #0x20
105754c60: aa0003f3    	mov	x19, x0
105754c64: f00d50e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105754c68: f9462d00    	ldr	x0, [x8, #0xc58]
105754c6c: f00d3788    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
105754c70: f9425101    	ldr	x1, [x8, #0x4a0] ; BG_0
105754c74: 94934932    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754c78: aa1d03fd    	mov	x29, x29
105754c7c: 94934933    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105754c80: aa0003f4    	mov	x20, x0
105754c84: f00d4da8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
105754c88: f946d501    	ldr	x1, [x8, #0xda8] ; view
105754c8c: aa1303e0    	mov	x0, x19
105754c90: 9493492b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754c94: aa1d03fd    	mov	x29, x29
105754c98: 9493492c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105754c9c: aa0003f5    	mov	x21, x0
105754ca0: f00d4d88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
105754ca4: f940e101    	ldr	x1, [x8, #0x1c0] ; setBackgroundColor:
105754ca8: aa1403e2    	mov	x2, x20
105754cac: 94934924    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754cb0: aa1503e0    	mov	x0, x21
105754cb4: 94934928    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105754cb8: aa1403e0    	mov	x0, x20
105754cbc: 94934926    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105754cc0: d00d3808    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105754cc4: f942f501    	ldr	x1, [x8, #0x5e8] ; initTitleArea
105754cc8: aa1303e0    	mov	x0, x19
105754ccc: 9493491c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754cd0: d00d3808    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
105754cd4: f9436901    	ldr	x1, [x8, #0x6d0] ; m_arrTagContacts
105754cd8: aa1303e0    	mov	x0, x19
105754cdc: 94934918    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754ce0: aa1d03fd    	mov	x29, x29
105754ce4: 94934919    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105754ce8: aa0003f4    	mov	x20, x0
105754cec: 900d4d68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105754cf0: f9435101    	ldr	x1, [x8, #0x6a0] ; count
105754cf4: 94934912    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754cf8: aa0003f5    	mov	x21, x0
105754cfc: aa1403e0    	mov	x0, x20
105754d00: 94934915    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105754d04: b4000115    	cbz	x21, 0x105754d24 <_Flutter_MMFoundation_BindContext+0x1c30908>
105754d08: 900d3748    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105754d0c: f9443d01    	ldr	x1, [x8, #0x878] ; initTableView
105754d10: aa1303e0    	mov	x0, x19
105754d14: 9493490a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105754d18: f00d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
105754d1c: 913ba108    	add	x8, x8, #0xee8
105754d20: 14000003    	b	0x105754d2c <_Flutter_MMFoundation_BindContext+0x1c30910>
105754d24: f00d42c8    	adrp	x8, 0x11ffaf000 <dyld_stub_binder+0x11ffaf000>
105754d28: 913b8108    	add	x8, x8, #0xee0
105754d2c: f9400101    	ldr	x1, [x8]
105754d30: aa1303e0    	mov	x0, x19
105754d34: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105754d38: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105754d3c: a8c357f6    	ldp	x22, x21, [sp], #0x30
105754d40: 149348ff    	b	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
