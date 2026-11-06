
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157dbe30: d101c3ff    	sub	sp, sp, #0x70
1157dbe34: a90457f6    	stp	x22, x21, [sp, #0x40]
1157dbe38: a9054ff4    	stp	x20, x19, [sp, #0x50]
1157dbe3c: a9067bfd    	stp	x29, x30, [sp, #0x60]
1157dbe40: 910183fd    	add	x29, sp, #0x60
1157dbe44: aa0203f3    	mov	x19, x2
1157dbe48: aa0003f5    	mov	x21, x0
1157dbe4c: aa0203e0    	mov	x0, x2
1157dbe50: 945a01e1    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbe54: 90049528    	adrp	x8, 0x11ea7f000 <dyld_stub_binder+0x11ea7f000>
1157dbe58: f9452101    	ldr	x1, [x8, #0xa40]
1157dbe5c: aa1303e0    	mov	x0, x19
1157dbe60: 945a01b9    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbe64: aa1d03fd    	mov	x29, x29
1157dbe68: 945a01e4    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbe6c: aa0003f4    	mov	x20, x0
1157dbe70: b00494c8    	adrp	x8, 0x11ea74000 <dyld_stub_binder+0x11ea74000>
1157dbe74: f9409d01    	ldr	x1, [x8, #0x138]
1157dbe78: aa1303e0    	mov	x0, x19
1157dbe7c: 52800042    	mov	w2, #0x2                ; =2
1157dbe80: 945a01b1    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbe84: d100a3a0    	sub	x0, x29, #0x28
1157dbe88: aa1503e1    	mov	x1, x21
1157dbe8c: 945a019c    	bl	0x116e5c4fc <dyld_stub_binder+0x116e5c4fc>
1157dbe90: b003fb88    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1157dbe94: f9449908    	ldr	x8, [x8, #0x930]
1157dbe98: f90007e8    	str	x8, [sp, #0x8]
1157dbe9c: 90010768    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1157dbea0: fd434100    	ldr	d0, [x8, #0x680]
1157dbea4: 90000008    	adrp	x8, 0x1157db000 <_O266DecReleaseOutputPicture+0x36cba94>
1157dbea8: 913d2108    	add	x8, x8, #0xf48
1157dbeac: fd000be0    	str	d0, [sp, #0x10]
1157dbeb0: 90035ba9    	adrp	x9, 0x11c34f000 <dyld_stub_binder+0x11c34f000>
1157dbeb4: 91008129    	add	x9, x9, #0x20
1157dbeb8: a901a7e8    	stp	x8, x9, [sp, #0x18]
1157dbebc: 910023f6    	add	x22, sp, #0x8
1157dbec0: 9100a2c0    	add	x0, x22, #0x28
1157dbec4: d100a3a1    	sub	x1, x29, #0x28
1157dbec8: 945a0169    	bl	0x116e5c46c <dyld_stub_binder+0x116e5c46c>
1157dbecc: aa1303e0    	mov	x0, x19
1157dbed0: 945a01c1    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbed4: f90017f3    	str	x19, [sp, #0x28]
1157dbed8: 90049088    	adrp	x8, 0x11e9eb000 <dyld_stub_binder+0x11e9eb000>
1157dbedc: f940e901    	ldr	x1, [x8, #0x1d0]
1157dbee0: 910023e3    	add	x3, sp, #0x8
1157dbee4: aa1403e0    	mov	x0, x20
1157dbee8: d2800002    	mov	x2, #0x0                ; =0
1157dbeec: 945a0196    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbef0: 370000e0    	tbnz	w0, #0x0, 0x1157dbf0c <_O266DecReleaseOutputPicture+0x36cc9a0>
1157dbef4: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbef8: f9428101    	ldr	x1, [x8, #0x500]
1157dbefc: aa1503e0    	mov	x0, x21
1157dbf00: aa1303e2    	mov	x2, x19
1157dbf04: 52800003    	mov	w3, #0x0                ; =0
1157dbf08: 945a018f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbf0c: f94017e0    	ldr	x0, [sp, #0x28]
1157dbf10: 945a01ab    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbf14: 9100a2c0    	add	x0, x22, #0x28
1157dbf18: 945a0158    	bl	0x116e5c478 <dyld_stub_binder+0x116e5c478>
1157dbf1c: d100a3a0    	sub	x0, x29, #0x28
1157dbf20: 945a0156    	bl	0x116e5c478 <dyld_stub_binder+0x116e5c478>
1157dbf24: aa1403e0    	mov	x0, x20
1157dbf28: 945a01a5    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbf2c: aa1303e0    	mov	x0, x19
1157dbf30: 945a01a3    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbf34: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1157dbf38: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1157dbf3c: a94457f6    	ldp	x22, x21, [sp, #0x40]
1157dbf40: 9101c3ff    	add	sp, sp, #0x70
1157dbf44: d65f03c0    	ret
1157dbf48: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
1157dbf4c: a90157f6    	stp	x22, x21, [sp, #0x10]
1157dbf50: a9024ff4    	stp	x20, x19, [sp, #0x20]
1157dbf54: a9037bfd    	stp	x29, x30, [sp, #0x30]
1157dbf58: 9100c3fd    	add	x29, sp, #0x30
1157dbf5c: aa0103f3    	mov	x19, x1
1157dbf60: aa0003f5    	mov	x21, x0
1157dbf64: aa0103e0    	mov	x0, x1
1157dbf68: 945a019b    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157dbf6c: 9100a2a0    	add	x0, x21, #0x28
1157dbf70: 945a0169    	bl	0x116e5c514 <dyld_stub_binder+0x116e5c514>
1157dbf74: aa0003f4    	mov	x20, x0
1157dbf78: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbf7c: f9423101    	ldr	x1, [x8, #0x460]
1157dbf80: 945a0171    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbf84: aa1d03fd    	mov	x29, x29
1157dbf88: 945a019c    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dbf8c: aa0003f6    	mov	x22, x0
1157dbf90: f94012b7    	ldr	x23, [x21, #0x20]
1157dbf94: 945a018a    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbf98: eb1702df    	cmp	x22, x23
1157dbf9c: 54000181    	b.ne	0x1157dbfcc <_O266DecReleaseOutputPicture+0x36cca60>
1157dbfa0: f94012b5    	ldr	x21, [x21, #0x20]
1157dbfa4: b004a668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1157dbfa8: f9439101    	ldr	x1, [x8, #0x720]
1157dbfac: aa1303e0    	mov	x0, x19
1157dbfb0: 945a0165    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbfb4: aa0003e3    	mov	x3, x0
1157dbfb8: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dbfbc: f9428101    	ldr	x1, [x8, #0x500]
1157dbfc0: aa1403e0    	mov	x0, x20
1157dbfc4: aa1503e2    	mov	x2, x21
1157dbfc8: 945a015f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dbfcc: aa1403e0    	mov	x0, x20
1157dbfd0: 945a017b    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dbfd4: aa1303e0    	mov	x0, x19
1157dbfd8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1157dbfdc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1157dbfe0: a94157f6    	ldp	x22, x21, [sp, #0x10]
1157dbfe4: a8c45ff8    	ldp	x24, x23, [sp], #0x40
1157dbfe8: 145a0175    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
