
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1175e0228: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1175e022c: a90157f6    	stp	x22, x21, [sp, #0x10]
1175e0230: a9024ff4    	stp	x20, x19, [sp, #0x20]
1175e0234: a9037bfd    	stp	x29, x30, [sp, #0x30]
1175e0238: 9100c3fd    	add	x29, sp, #0x30
1175e023c: aa0203f3    	mov	x19, x2
1175e0240: aa0003f4    	mov	x20, x0
1175e0244: d00465b7    	adrp	x23, 0x120296000 <dyld_stub_binder+0x120296000>
1175e0248: 911c02f7    	add	x23, x23, #0x700
1175e024c: b98002e8    	ldrsw	x8, [x23]
1175e0250: f8686855    	ldr	x21, [x2, x8]
1175e0254: 90044328    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
1175e0258: f946b916    	ldr	x22, [x8, #0xd70] ; removeAllServices
1175e025c: aa0203e0    	mov	x0, x2
1175e0260: 943526c4    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
1175e0264: aa1503e0    	mov	x0, x21
1175e0268: aa1603e1    	mov	x1, x22
1175e026c: 943526a0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e0270: f9400a80    	ldr	x0, [x20, #0x10]
1175e0274: 90045928    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1175e0278: f9402d01    	ldr	x1, [x8, #0x58] ; lock
1175e027c: 9435269c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e0280: b98002e8    	ldrsw	x8, [x23]
1175e0284: f8686a60    	ldr	x0, [x19, x8]
1175e0288: b00458c8    	adrp	x8, 0x1200f9000 <dyld_stub_binder+0x1200f9000>
1175e028c: f9469501    	ldr	x1, [x8, #0xd28] ; userDidLogout
1175e0290: 94352697    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1175e0294: d00465a8    	adrp	x8, 0x120296000 <dyld_stub_binder+0x120296000>
1175e0298: 911b8108    	add	x8, x8, #0x6e0
1175e029c: b9800108    	ldrsw	x8, [x8]
1175e02a0: 52800069    	mov	w9, #0x3                ; =3
1175e02a4: f8286a69    	str	x9, [x19, x8]
1175e02a8: aa1303e0    	mov	x0, x19
1175e02ac: 943526ab    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1175e02b0: f9400a80    	ldr	x0, [x20, #0x10]
1175e02b4: f0045948    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1175e02b8: f9422101    	ldr	x1, [x8, #0x440] ; unlock
1175e02bc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1175e02c0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1175e02c4: a94157f6    	ldp	x22, x21, [sp, #0x10]
1175e02c8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1175e02cc: 14352688    	b	0x118329cec <dyld_stub_binder+0x118329cec>