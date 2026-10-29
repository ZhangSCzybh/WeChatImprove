
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10700d050: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
10700d054: a9014ff4    	stp	x20, x19, [sp, #0x10]
10700d058: a9027bfd    	stp	x29, x30, [sp, #0x20]
10700d05c: 910083fd    	add	x29, sp, #0x20
10700d060: 900c8b48    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10700d064: f9418100    	ldr	x0, [x8, #0x300] ; class WCDeepLinkHandler
10700d068: d00c7b48    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
10700d06c: f9477501    	ldr	x1, [x8, #0xee8] ; selector deepLinkByUrl:
10700d070: 94306833    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700d074: aa1d03fd    	mov	x29, x29
10700d078: 94306834    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700d07c: aa0003f3    	mov	x19, x0
10700d080: b40001a0    	cbz	x0, 0x10700d0b4 <_Flutter_MMFoundation_BindContext+0x34e8c98>
10700d084: b00c7b68    	adrp	x8, 0x11ff7a000 <dyld_stub_binder+0x11ff7a000>
10700d088: f946dd01    	ldr	x1, [x8, #0xdb8] ; selector isCallDelegate
10700d08c: aa1303e0    	mov	x0, x19
10700d090: 9430682b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700d094: 370000c0    	tbnz	w0, #0x0, 0x10700d0ac <_Flutter_MMFoundation_BindContext+0x34e8c90>
10700d098: b00c7b68    	adrp	x8, 0x11ff7a000 <dyld_stub_binder+0x11ff7a000>
10700d09c: f946e501    	ldr	x1, [x8, #0xdc8] ; selector isCallExtension
10700d0a0: aa1303e0    	mov	x0, x19
10700d0a4: 94306826    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700d0a8: 360000a0    	tbz	w0, #0x0, 0x10700d0bc <_Flutter_MMFoundation_BindContext+0x34e8ca0>
10700d0ac: 52800034    	mov	w20, #0x1               ; =1
10700d0b0: 14000011    	b	0x10700d0f4 <_Flutter_MMFoundation_BindContext+0x34e8cd8>
10700d0b4: 52800014    	mov	w20, #0x0               ; =0
10700d0b8: 1400000f    	b	0x10700d0f4 <_Flutter_MMFoundation_BindContext+0x34e8cd8>
10700d0bc: d00c7b48    	adrp	x8, 0x11ff77000 <dyld_stub_binder+0x11ff77000>
10700d0c0: f9477901    	ldr	x1, [x8, #0xef0] ; selector getLink
10700d0c4: aa1303e0    	mov	x0, x19
10700d0c8: 9430681d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700d0cc: aa1d03fd    	mov	x29, x29
10700d0d0: 9430681e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700d0d4: aa0003f5    	mov	x21, x0
10700d0d8: d00c87a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10700d0dc: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
10700d0e0: 94306817    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700d0e4: f100001f    	cmp	x0, #0x0
10700d0e8: 1a9f07f4    	cset	w20, ne
10700d0ec: aa1503e0    	mov	x0, x21
10700d0f0: 94306819    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700d0f4: aa1303e0    	mov	x0, x19
10700d0f8: 94306817    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700d0fc: aa1403e0    	mov	x0, x20
10700d100: a9427bfd    	ldp	x29, x30, [sp, #0x20]
10700d104: a9414ff4    	ldp	x20, x19, [sp, #0x10]
10700d108: a8c357f6    	ldp	x22, x21, [sp], #0x30
10700d10c: d65f03c0    	ret
