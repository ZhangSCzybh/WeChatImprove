
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
11610d4e4: d100c3ff    	sub	sp, sp, #0x30
11610d4e8: a9014ff4    	stp	x20, x19, [sp, #0x10]
11610d4ec: a9027bfd    	stp	x29, x30, [sp, #0x20]
11610d4f0: 910083fd    	add	x29, sp, #0x20
11610d4f4: d0046368    	adrp	x8, 0x11ed7b000 <dyld_stub_binder+0x11ed7b000>
11610d4f8: f9441908    	ldr	x8, [x8, #0x830]
11610d4fc: a90023e0    	stp	x0, x8, [sp]
11610d500: f0045cc8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
11610d504: f9404d01    	ldr	x1, [x8, #0x98] ; selector: init
11610d508: 910003e0    	mov	x0, sp
11610d50c: 94353c11    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
11610d510: aa0003f3    	mov	x19, x0
11610d514: b40000c0    	cbz	x0, 0x11610d52c <_O266DecReleaseOutputPicture+0x3ffdfc0>
11610d518: f0045c88    	adrp	x8, 0x11eca0000 <dyld_stub_binder+0x11eca0000>
11610d51c: f9453101    	ldr	x1, [x8, #0xa60] ; selector: setupWithCapacity:
11610d520: aa1303e0    	mov	x0, x19
11610d524: d2800002    	mov	x2, #0x0                ; =0
11610d528: 94353c07    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11610d52c: aa1303e0    	mov	x0, x19
11610d530: a9427bfd    	ldp	x29, x30, [sp, #0x20]
11610d534: a9414ff4    	ldp	x20, x19, [sp, #0x10]
11610d538: 9100c3ff    	add	sp, sp, #0x30
11610d53c: d65f03c0    	ret
