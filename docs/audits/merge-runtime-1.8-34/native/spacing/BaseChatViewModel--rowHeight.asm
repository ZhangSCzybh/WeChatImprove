
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10029d2ec: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
10029d2f0: a9017bfd    	stp	x29, x30, [sp, #0x10]
10029d2f4: 910043fd    	add	x29, sp, #0x10
10029d2f8: aa0003f3    	mov	x19, x0
10029d2fc: 900fdd28    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
10029d300: f9402101    	ldr	x1, [x8, #0x40] ; shouldLayoutIfNeeded
10029d304: 95e6278e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029d308: 34000300    	cbz	w0, 0x10029d368 <__text+0x295368>
10029d30c: fd400a60    	ldr	d0, [x19, #0x10]
10029d310: 1e602008    	fcmp	d0, #0.0
10029d314: 540000a0    	b.eq	0x10029d328 <__text+0x295328>
10029d318: b00fdd68    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10029d31c: f9409d01    	ldr	x1, [x8, #0x138] ; resetLayoutCache
10029d320: aa1303e0    	mov	x0, x19
10029d324: 95e62786    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029d328: 900e9a88    	adrp	x8, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
10029d32c: f9417908    	ldr	x8, [x8, #0x2f0]
10029d330: 6d400500    	ldp	d0, d1, [x8]
10029d334: b00fdd68    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
10029d338: f940a101    	ldr	x1, [x8, #0x140] ; measure:
10029d33c: aa1303e0    	mov	x0, x19
10029d340: 95e6277f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029d344: 1e64c020    	frintp	d0, d1
10029d348: fd000e60    	str	d0, [x19, #0x18]
10029d34c: d00ff6a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10029d350: f9470100    	ldr	x0, [x8, #0xe00] ; �*c 
10029d354: f00fdce8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10029d358: f9419101    	ldr	x1, [x8, #0x320] ; pageScopeWidthFor:
10029d35c: aa1303e2    	mov	x2, x19
10029d360: 95e62777    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10029d364: fd000a60    	str	d0, [x19, #0x10]
10029d368: fd400e60    	ldr	d0, [x19, #0x18]
10029d36c: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10029d370: a8c24ff4    	ldp	x20, x19, [sp], #0x20
10029d374: d65f03c0    	ret