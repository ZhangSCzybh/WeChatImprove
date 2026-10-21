
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101816adc: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
101816ae0: a90157f6    	stp	x22, x21, [sp, #0x10]
101816ae4: a9024ff4    	stp	x20, x19, [sp, #0x20]
101816ae8: a9037bfd    	stp	x29, x30, [sp, #0x30]
101816aec: 9100c3fd    	add	x29, sp, #0x30
101816af0: aa0003f5    	mov	x21, x0
101816af4: 900fa0e8    	adrp	x8, 0x120c32000 <dyld_stub_binder+0x120c32000>
101816af8: 52800029    	mov	w9, #0x1                ; =1
101816afc: 392c8509    	strb	w9, [x8, #0xb21]
101816b00: b00f4b08    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
101816b04: f946b900    	ldr	x0, [x8, #0xd70]
101816b08: 95904194    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
101816b0c: aa0003f3    	mov	x19, x0
101816b10: b00f4ae8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101816b14: f9455500    	ldr	x0, [x8, #0xaa8]
101816b18: d00f4768    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
101816b1c: f9461d01    	ldr	x1, [x8, #0xc38] ; new
101816b20: 95904187    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816b24: aa0003f4    	mov	x20, x0
101816b28: b00f4b48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101816b2c: f9426900    	ldr	x0, [x8, #0x4d0]
101816b30: b00f34a8    	adrp	x8, 0x11feab000 <dyld_stub_binder+0x11feab000>
101816b34: f9440501    	ldr	x1, [x8, #0x808] ; uiEnabled
101816b38: 95904181    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816b3c: 34000500    	cbz	w0, 0x101816bdc <__text+0x180ebdc>
101816b40: b00f4b08    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
101816b44: f946bd00    	ldr	x0, [x8, #0xd78]
101816b48: 95904184    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
101816b4c: aa0003f6    	mov	x22, x0
101816b50: 900f3488    	adrp	x8, 0x11fea6000 <dyld_stub_binder+0x11fea6000>
101816b54: f9436917    	ldr	x23, [x8, #0x6d0] ; searchBarText
101816b58: aa1503e0    	mov	x0, x21
101816b5c: aa1703e1    	mov	x1, x23
101816b60: 95904177    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816b64: aa1d03fd    	mov	x29, x29
101816b68: 95904178    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101816b6c: aa0003f8    	mov	x24, x0
101816b70: d00f3148    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
101816b74: f9418101    	ldr	x1, [x8, #0x300] ; setWord:
101816b78: aa1603e0    	mov	x0, x22
101816b7c: aa1803e2    	mov	x2, x24
101816b80: 9590416f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816b84: aa1803e0    	mov	x0, x24
101816b88: 95904173    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101816b8c: aa1503e0    	mov	x0, x21
101816b90: aa1703e1    	mov	x1, x23
101816b94: 9590416a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816b98: aa1d03fd    	mov	x29, x29
101816b9c: 9590416b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101816ba0: aa0003f5    	mov	x21, x0
101816ba4: b00f3248    	adrp	x8, 0x11fe5f000 <dyld_stub_binder+0x11fe5f000>
101816ba8: f9451101    	ldr	x1, [x8, #0xa20] ; setDocId:
101816bac: aa1603e0    	mov	x0, x22
101816bb0: aa1503e2    	mov	x2, x21
101816bb4: 95904162    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816bb8: aa1503e0    	mov	x0, x21
101816bbc: 95904166    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101816bc0: 900f4748    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
101816bc4: f946f501    	ldr	x1, [x8, #0xde8] ; addObject:
101816bc8: aa1403e0    	mov	x0, x20
101816bcc: aa1603e2    	mov	x2, x22
101816bd0: 9590415b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816bd4: aa1603e0    	mov	x0, x22
101816bd8: 9590415f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101816bdc: d00f4788    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
101816be0: f9439d01    	ldr	x1, [x8, #0x738] ; setItems:
101816be4: aa1303e0    	mov	x0, x19
101816be8: aa1403e2    	mov	x2, x20
101816bec: 95904154    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816bf0: b00f4b48    	adrp	x8, 0x12017f000 <dyld_stub_binder+0x12017f000>
101816bf4: f943e100    	ldr	x0, [x8, #0x7c0]
101816bf8: 9590415a    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
101816bfc: aa0003f5    	mov	x21, x0
101816c00: b00f4768    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101816c04: f9459901    	ldr	x1, [x8, #0xb30] ; items
101816c08: aa1303e0    	mov	x0, x19
101816c0c: 9590414c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816c10: aa1d03fd    	mov	x29, x29
101816c14: 9590414d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101816c18: aa0003f6    	mov	x22, x0
101816c1c: d00f4748    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101816c20: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101816c24: 95904146    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816c28: aa0003e4    	mov	x4, x0
101816c2c: 900f34a8    	adrp	x8, 0x11feaa000 <dyld_stub_binder+0x11feaa000>
101816c30: f940b101    	ldr	x1, [x8, #0x160] ; initWithType:data:searchItemCount:
101816c34: aa1503e0    	mov	x0, x21
101816c38: 52800122    	mov	w2, #0x9                ; =9
101816c3c: aa1303e3    	mov	x3, x19
101816c40: 9590413f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101816c44: aa0003f5    	mov	x21, x0
101816c48: aa1603e0    	mov	x0, x22
101816c4c: 95904142    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101816c50: aa1403e0    	mov	x0, x20
101816c54: 95904140    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101816c58: aa1303e0    	mov	x0, x19
101816c5c: 9590413e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101816c60: aa1503e0    	mov	x0, x21
101816c64: a9437bfd    	ldp	x29, x30, [sp, #0x30]
101816c68: a9424ff4    	ldp	x20, x19, [sp, #0x20]
101816c6c: a94157f6    	ldp	x22, x21, [sp, #0x10]
101816c70: a8c45ff8    	ldp	x24, x23, [sp], #0x40
101816c74: 1590413f    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
