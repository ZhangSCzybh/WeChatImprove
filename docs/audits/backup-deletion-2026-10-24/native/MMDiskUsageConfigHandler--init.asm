
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
1029aba90: d100c3ff    	sub	sp, sp, #0x30
1029aba94: a9014ff4    	stp	x20, x19, [sp, #0x10]
1029aba98: a9027bfd    	stp	x29, x30, [sp, #0x20]
1029aba9c: 910083fd    	add	x29, sp, #0x20
1029abaa0: 900ec0a8    	adrp	x8, 0x1201bf000 <dyld_stub_binder+0x1201bf000>
1029abaa4: f9443d08    	ldr	x8, [x8, #0x878]
1029abaa8: a90023e0    	stp	x0, x8, [sp]
1029abaac: f00ebaa8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1029abab0: f9466901    	ldr	x1, [x8, #0xcd0] ; init
1029abab4: 910003e0    	mov	x0, sp
1029abab8: 9549eda3    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
1029ababc: aa0003f3    	mov	x19, x0
1029abac0: b40000a0    	cbz	x0, 0x1029abad4 <_Flutter_Image_provideRelativePathByUrl+0xdb8984>
1029abac4: b00eaa68    	adrp	x8, 0x11fef8000 <dyld_stub_binder+0x11fef8000>
1029abac8: f9423d01    	ldr	x1, [x8, #0x478] ; loadConfigFromX
1029abacc: aa1303e0    	mov	x0, x19
1029abad0: 9549ed9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1029abad4: aa1303e0    	mov	x0, x19
1029abad8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1029abadc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1029abae0: 9100c3ff    	add	sp, sp, #0x30
1029abae4: d65f03c0    	ret
