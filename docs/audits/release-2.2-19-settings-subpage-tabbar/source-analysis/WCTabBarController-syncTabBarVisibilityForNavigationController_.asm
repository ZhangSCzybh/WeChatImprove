
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157dbfec: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1157dbff0: a90157f6    	stp	x22, x21, [sp, #0x10]
1157dbff4: a9024ff4    	stp	x20, x19, [sp, #0x20]
1157dbff8: a9037bfd    	stp	x29, x30, [sp, #0x30]
1157dbffc: 9100c3fd    	add	x29, sp, #0x30
1157dc000: aa0203f3    	mov	x19, x2
1157dc004: aa0003f4    	mov	x20, x0
1157dc008: aa0203e0    	mov	x0, x2
1157dc00c: 945a0172    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dc010: d004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dc014: f945b901    	ldr	x1, [x8, #0xb70]
1157dc018: aa1403e0    	mov	x0, x20
1157dc01c: 945a014a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc020: aa1d03fd    	mov	x29, x29
1157dc024: 945a0175    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc028: aa0003f5    	mov	x21, x0
1157dc02c: 945a0164    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc030: eb15027f    	cmp	x19, x21
1157dc034: 540004a1    	b.ne	0x1157dc0c8 <_O266DecReleaseOutputPicture+0x36ccb5c>
1157dc038: b004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157dc03c: f9448901    	ldr	x1, [x8, #0x910]
1157dc040: aa1303e0    	mov	x0, x19
1157dc044: 945a0140    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc048: aa1d03fd    	mov	x29, x29
1157dc04c: 945a016b    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc050: aa0003f5    	mov	x21, x0
1157dc054: b004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157dc058: f9473501    	ldr	x1, [x8, #0xe68]
1157dc05c: aa1303e0    	mov	x0, x19
1157dc060: 945a0139    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc064: aa1d03fd    	mov	x29, x29
1157dc068: 945a0164    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dc06c: aa0003f6    	mov	x22, x0
1157dc070: d004a648    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1157dc074: f9442901    	ldr	x1, [x8, #0x850]
1157dc078: 945a0133    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc07c: f100081f    	cmp	x0, #0x2
1157dc080: 540000e3    	b.lo	0x1157dc09c <_O266DecReleaseOutputPicture+0x36ccb30>
1157dc084: b004a4e8    	adrp	x8, 0x11ec79000 <dyld_stub_binder+0x11ec79000>
1157dc088: f940d501    	ldr	x1, [x8, #0x1a8]
1157dc08c: aa1503e0    	mov	x0, x21
1157dc090: 945a012d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc094: aa0003f7    	mov	x23, x0
1157dc098: 14000002    	b	0x1157dc0a0 <_O266DecReleaseOutputPicture+0x36ccb34>
1157dc09c: 52800017    	mov	w23, #0x0               ; =0
1157dc0a0: aa1603e0    	mov	x0, x22
1157dc0a4: 945a0146    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc0a8: b0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dc0ac: f9443d01    	ldr	x1, [x8, #0x878]
1157dc0b0: aa1403e0    	mov	x0, x20
1157dc0b4: aa1703e2    	mov	x2, x23
1157dc0b8: 52800003    	mov	w3, #0x0                ; =0
1157dc0bc: 945a0122    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dc0c0: aa1503e0    	mov	x0, x21
1157dc0c4: 945a013e    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dc0c8: aa1303e0    	mov	x0, x19
1157dc0cc: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1157dc0d0: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1157dc0d4: a94157f6    	ldp	x22, x21, [sp, #0x10]
1157dc0d8: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1157dc0dc: 145a0138    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
