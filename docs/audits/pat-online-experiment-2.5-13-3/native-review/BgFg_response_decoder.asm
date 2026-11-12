
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105461ab0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105461ab4: a9014ff4    	stp	x20, x19, [sp, #0x10]
105461ab8: a9027bfd    	stp	x29, x30, [sp, #0x20]
105461abc: 910083fd    	add	x29, sp, #0x20
105461ac0: aa0203f4    	mov	x20, x2
105461ac4: aa0103f3    	mov	x19, x1
105461ac8: aa0103e0    	mov	x0, x1
105461acc: 949f186a    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105461ad0: f00cc228    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105461ad4: f9467501    	ldr	x1, [x8, #0xce8] ; selector length
105461ad8: aa1303e0    	mov	x0, x19
105461adc: 949f1862    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461ae0: b4000240    	cbz	x0, 0x105461b28 <_Flutter_MMFoundation_BindContext+0x16e87f4>
105461ae4: f00cc688    	adrp	x8, 0x11ed34000 <dyld_stub_binder+0x11ed34000>
105461ae8: f9416d00    	ldr	x0, [x8, #0x2d8] ; class BgFgResponse
105461aec: 900cab68    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
105461af0: f9439d01    	ldr	x1, [x8, #0x738] ; selector parseFromData:
105461af4: aa1303e2    	mov	x2, x19
105461af8: 949f185b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461afc: aa1d03fd    	mov	x29, x29
105461b00: 949f1860    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105461b04: b4000120    	cbz	x0, 0x105461b28 <_Flutter_MMFoundation_BindContext+0x16e87f4>
105461b08: aa0003f5    	mov	x21, x0
105461b0c: b40002b4    	cbz	x20, 0x105461b60 <_Flutter_MMFoundation_BindContext+0x16e882c>
105461b10: 900cab48    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105461b14: f946c501    	ldr	x1, [x8, #0xd88] ; selector retcode
105461b18: aa1503e0    	mov	x0, x21
105461b1c: 949f1852    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105461b20: 52800016    	mov	w22, #0x0               ; =0
105461b24: 14000005    	b	0x105461b38 <_Flutter_MMFoundation_BindContext+0x16e8804>
105461b28: d2800015    	mov	x21, #0x0               ; =0
105461b2c: 128001b6    	mov	w22, #-0xe              ; =-14
105461b30: b4000074    	cbz	x20, 0x105461b3c <_Flutter_MMFoundation_BindContext+0x16e8808>
105461b34: 12800000    	mov	w0, #-0x1               ; =-1
105461b38: b9000280    	str	w0, [x20]
105461b3c: aa1503e0    	mov	x0, x21
105461b40: 949f184c    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461b44: aa1303e0    	mov	x0, x19
105461b48: 949f184a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105461b4c: aa1603e0    	mov	x0, x22
105461b50: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105461b54: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105461b58: a8c357f6    	ldp	x22, x21, [sp], #0x30
105461b5c: d65f03c0    	ret
105461b60: 52800016    	mov	w22, #0x0               ; =0
105461b64: 17fffff6    	b	0x105461b3c <_Flutter_MMFoundation_BindContext+0x16e8808>
