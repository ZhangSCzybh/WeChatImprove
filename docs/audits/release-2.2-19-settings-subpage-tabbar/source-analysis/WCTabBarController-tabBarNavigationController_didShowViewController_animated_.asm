
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157db540: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1157db544: a9014ff4    	stp	x20, x19, [sp, #0x10]
1157db548: a9027bfd    	stp	x29, x30, [sp, #0x20]
1157db54c: 910083fd    	add	x29, sp, #0x20
1157db550: aa0203f3    	mov	x19, x2
1157db554: aa0003f4    	mov	x20, x0
1157db558: aa0203e0    	mov	x0, x2
1157db55c: 945a041e    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db560: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db564: f9423101    	ldr	x1, [x8, #0x460]
1157db568: aa1403e0    	mov	x0, x20
1157db56c: 945a03f6    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db570: aa1d03fd    	mov	x29, x29
1157db574: 945a0421    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db578: b4000060    	cbz	x0, 0x1157db584 <_O266DecReleaseOutputPicture+0x36cc018>
1157db57c: 945a0410    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db580: 14000010    	b	0x1157db5c0 <_O266DecReleaseOutputPicture+0x36cc054>
1157db584: f004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157db588: f945b901    	ldr	x1, [x8, #0xb70]
1157db58c: aa1403e0    	mov	x0, x20
1157db590: 945a03ed    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db594: aa1d03fd    	mov	x29, x29
1157db598: 945a0418    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db59c: aa0003f5    	mov	x21, x0
1157db5a0: 945a0407    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db5a4: eb15027f    	cmp	x19, x21
1157db5a8: 540000c1    	b.ne	0x1157db5c0 <_O266DecReleaseOutputPicture+0x36cc054>
1157db5ac: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db5b0: f9426d01    	ldr	x1, [x8, #0x4d8]
1157db5b4: aa1403e0    	mov	x0, x20
1157db5b8: aa1303e2    	mov	x2, x19
1157db5bc: 945a03e2    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db5c0: aa1303e0    	mov	x0, x19
1157db5c4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1157db5c8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1157db5cc: a8c357f6    	ldp	x22, x21, [sp], #0x30
1157db5d0: 145a03fb    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
