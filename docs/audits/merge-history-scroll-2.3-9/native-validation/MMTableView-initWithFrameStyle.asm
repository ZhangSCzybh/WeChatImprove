
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
11593dde8: d10103ff    	sub	sp, sp, #0x40
11593ddec: a90157f6    	stp	x22, x21, [sp, #0x10]
11593ddf0: a9024ff4    	stp	x20, x19, [sp, #0x20]
11593ddf4: a9037bfd    	stp	x29, x30, [sp, #0x30]
11593ddf8: 9100c3fd    	add	x29, sp, #0x30
11593ddfc: aa0203f4    	mov	x20, x2
11593de00: b004a1e8    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
11593de04: f9438108    	ldr	x8, [x8, #0x700]
11593de08: a90023e0    	stp	x0, x8, [sp]
11593de0c: f0048468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
11593de10: f9418901    	ldr	x1, [x8, #0x310]
11593de14: 910003e0    	mov	x0, sp
11593de18: 945479ce    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
11593de1c: aa0003f3    	mov	x19, x0
11593de20: b40016a0    	cbz	x0, 0x11593e0f4 <_O266DecReleaseOutputPicture+0x382eb88>
11593de24: d004a7a8    	adrp	x8, 0x11ee33000 <dyld_stub_binder+0x11ee33000>
11593de28: b98f9508    	ldrsw	x8, [x8, #0xf94]
11593de2c: 52800029    	mov	w9, #0x1                ; =1
11593de30: 38286a69    	strb	w9, [x19, x8]
11593de34: f100069f    	cmp	x20, #0x1
11593de38: 54000681    	b.ne	0x11593df08 <_O266DecReleaseOutputPicture+0x382e99c>
11593de3c: b0048608    	adrp	x8, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
11593de40: f942b101    	ldr	x1, [x8, #0x560]
11593de44: aa1303e0    	mov	x0, x19
11593de48: d2800002    	mov	x2, #0x0                ; =0
11593de4c: 945479be    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593de50: f0048468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
11593de54: f947b501    	ldr	x1, [x8, #0xf68]
11593de58: aa1303e0    	mov	x0, x19
11593de5c: 52800022    	mov	w2, #0x1                ; =1
11593de60: 945479b9    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593de64: b0048588    	adrp	x8, 0x11e9ee000 <dyld_stub_binder+0x11e9ee000>
11593de68: f9404d01    	ldr	x1, [x8, #0x98]
11593de6c: 9e6703e0    	fmov	d0, xzr
11593de70: aa1303e0    	mov	x0, x19
11593de74: 945479b4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593de78: b0049ea8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
11593de7c: f943f100    	ldr	x0, [x8, #0x7e0]
11593de80: 90048468    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
11593de84: f9451101    	ldr	x1, [x8, #0xa20]
11593de88: 1e641000    	fmov	d0, #8.00000000
11593de8c: 945479ae    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593de90: b0048588    	adrp	x8, 0x11e9ee000 <dyld_stub_binder+0x11e9ee000>
11593de94: f9404901    	ldr	x1, [x8, #0x90]
11593de98: aa1303e0    	mov	x0, x19
11593de9c: 945479aa    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593dea0: b0049ea8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
11593dea4: f9452d00    	ldr	x0, [x8, #0xa58]
11593dea8: 9454794a    	bl	0x116e5c3d0 <dyld_stub_binder+0x116e5c3d0>
11593deac: aa0003f4    	mov	x20, x0
11593deb0: b0049ea8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
11593deb4: f944d900    	ldr	x0, [x8, #0x9b0]
11593deb8: 90048488    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
11593debc: f946f501    	ldr	x1, [x8, #0xde8]
11593dec0: aa1303e2    	mov	x2, x19
11593dec4: 945479a0    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593dec8: 4ea01c02    	mov.16b	v2, v0
11593decc: f0049b48    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
11593ded0: f9418501    	ldr	x1, [x8, #0x308]
11593ded4: 9e6703e0    	fmov	d0, xzr
11593ded8: 9e6703e1    	fmov	d1, xzr
11593dedc: 1e6e1003    	fmov	d3, #1.00000000
11593dee0: aa1403e0    	mov	x0, x20
11593dee4: 94547998    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593dee8: aa0003f4    	mov	x20, x0
11593deec: f0048468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
11593def0: f940b901    	ldr	x1, [x8, #0x170]
11593def4: aa1303e0    	mov	x0, x19
11593def8: aa1403e2    	mov	x2, x20
11593defc: 94547992    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593df00: aa1403e0    	mov	x0, x20
11593df04: 945479ae    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593df08: b0049eb6    	adrp	x22, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
11593df0c: f9440ac0    	ldr	x0, [x22, #0x810]
11593df10: b0049b48    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
11593df14: f945a501    	ldr	x1, [x8, #0xb48]
11593df18: 9454798b    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593df1c: aa1d03fd    	mov	x29, x29
11593df20: 945479b6    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593df24: aa0003f4    	mov	x20, x0
11593df28: 900496c8    	adrp	x8, 0x11ec15000 <dyld_stub_binder+0x11ec15000>
11593df2c: f946c101    	ldr	x1, [x8, #0xd80]
11593df30: aa1303e0    	mov	x0, x19
11593df34: aa1403e2    	mov	x2, x20
11593df38: 94547983    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593df3c: aa1403e0    	mov	x0, x20
11593df40: 9454799f    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593df44: f9440ac0    	ldr	x0, [x22, #0x810]
11593df48: b0049b48    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
11593df4c: f942a914    	ldr	x20, [x8, #0x550]
11593df50: aa1403e1    	mov	x1, x20
11593df54: 9454797c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593df58: aa1d03fd    	mov	x29, x29
11593df5c: 945479a7    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593df60: aa0003f5    	mov	x21, x0
11593df64: b0049ac8    	adrp	x8, 0x11ec96000 <dyld_stub_binder+0x11ec96000>
11593df68: f9461d01    	ldr	x1, [x8, #0xc38]
11593df6c: aa1303e0    	mov	x0, x19
11593df70: aa1503e2    	mov	x2, x21
11593df74: 94547974    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593df78: aa1503e0    	mov	x0, x21
11593df7c: 94547990    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593df80: f9440ac0    	ldr	x0, [x22, #0x810]
11593df84: aa1403e1    	mov	x1, x20
11593df88: 9454796f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593df8c: aa1d03fd    	mov	x29, x29
11593df90: 9454799a    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593df94: aa0003f4    	mov	x20, x0
11593df98: b0049ac8    	adrp	x8, 0x11ec96000 <dyld_stub_binder+0x11ec96000>
11593df9c: f946d501    	ldr	x1, [x8, #0xda8]
11593dfa0: aa1303e0    	mov	x0, x19
11593dfa4: aa1403e2    	mov	x2, x20
11593dfa8: 94547967    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593dfac: aa1403e0    	mov	x0, x20
11593dfb0: 94547983    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593dfb4: b0049eb5    	adrp	x21, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
11593dfb8: f94406a0    	ldr	x0, [x21, #0x808]
11593dfbc: f0048468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
11593dfc0: f9408501    	ldr	x1, [x8, #0x108]
11593dfc4: 94547960    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593dfc8: aa1d03fd    	mov	x29, x29
11593dfcc: 9454798b    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593dfd0: aa0003f4    	mov	x20, x0
11593dfd4: f0048548    	adrp	x8, 0x11e9e8000 <dyld_stub_binder+0x11e9e8000>
11593dfd8: f9405501    	ldr	x1, [x8, #0xa8]
11593dfdc: aa1303e0    	mov	x0, x19
11593dfe0: aa1403e2    	mov	x2, x20
11593dfe4: 94547958    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593dfe8: aa1403e0    	mov	x0, x20
11593dfec: 94547974    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593dff0: d0049b68    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
11593dff4: f9421d01    	ldr	x1, [x8, #0x438]
11593dff8: aa1303e0    	mov	x0, x19
11593dffc: 52800042    	mov	w2, #0x2                ; =2
11593e000: 94547951    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e004: b0049eb4    	adrp	x20, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
11593e008: f9465a80    	ldr	x0, [x20, #0xcb0]
11593e00c: 90048508    	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
11593e010: f947d901    	ldr	x1, [x8, #0xfb0]
11593e014: 9454794c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e018: 37000160    	tbnz	w0, #0x0, 0x11593e044 <_O266DecReleaseOutputPicture+0x382ead8>
11593e01c: f9465a80    	ldr	x0, [x20, #0xcb0]
11593e020: 90048ea8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
11593e024: f9466101    	ldr	x1, [x8, #0xcc0]
11593e028: 94547947    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e02c: 340000c0    	cbz	w0, 0x11593e044 <_O266DecReleaseOutputPicture+0x382ead8>
11593e030: 90048668    	adrp	x8, 0x11ea0a000 <dyld_stub_binder+0x11ea0a000>
11593e034: f943d501    	ldr	x1, [x8, #0x7a8]
11593e038: aa1303e0    	mov	x0, x19
11593e03c: 52800002    	mov	w2, #0x0                ; =0
11593e040: 94547941    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e044: b0048548    	adrp	x8, 0x11e9e7000 <dyld_stub_binder+0x11e9e7000>
11593e048: f945bd01    	ldr	x1, [x8, #0xb78]
11593e04c: 9e6703e0    	fmov	d0, xzr
11593e050: aa1303e0    	mov	x0, x19
11593e054: 9454793c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e058: f0048568    	adrp	x8, 0x11e9ed000 <dyld_stub_binder+0x11e9ed000>
11593e05c: f9407901    	ldr	x1, [x8, #0xf0]
11593e060: 9e6703e0    	fmov	d0, xzr
11593e064: aa1303e0    	mov	x0, x19
11593e068: 94547937    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e06c: f0048568    	adrp	x8, 0x11e9ed000 <dyld_stub_binder+0x11e9ed000>
11593e070: f9407d01    	ldr	x1, [x8, #0xf8]
11593e074: 9e6703e0    	fmov	d0, xzr
11593e078: aa1303e0    	mov	x0, x19
11593e07c: 94547932    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e080: 90049b68    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
11593e084: f9479d01    	ldr	x1, [x8, #0xf38]
11593e088: aa1303e0    	mov	x0, x19
11593e08c: 52800002    	mov	w2, #0x0                ; =0
11593e090: 9454792d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e094: d0048468    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
11593e098: f947bd01    	ldr	x1, [x8, #0xf78]
11593e09c: 9e6703e0    	fmov	d0, xzr
11593e0a0: aa1303e0    	mov	x0, x19
11593e0a4: 94547928    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e0a8: 900485e8    	adrp	x8, 0x11e9fa000 <dyld_stub_binder+0x11e9fa000>
11593e0ac: f947bd01    	ldr	x1, [x8, #0xf78]
11593e0b0: aa1303e0    	mov	x0, x19
11593e0b4: 52800002    	mov	w2, #0x0                ; =0
11593e0b8: 94547923    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e0bc: f94406a0    	ldr	x0, [x21, #0x808]
11593e0c0: f0049b28    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
11593e0c4: f947d101    	ldr	x1, [x8, #0xfa0]
11593e0c8: 9454791f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e0cc: aa1d03fd    	mov	x29, x29
11593e0d0: 9454794a    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
11593e0d4: aa0003f4    	mov	x20, x0
11593e0d8: b0049b68    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
11593e0dc: f9401d01    	ldr	x1, [x8, #0x38]
11593e0e0: aa1303e0    	mov	x0, x19
11593e0e4: aa1403e2    	mov	x2, x20
11593e0e8: 94547917    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11593e0ec: aa1403e0    	mov	x0, x20
11593e0f0: 94547933    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11593e0f4: aa1303e0    	mov	x0, x19
11593e0f8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
11593e0fc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
11593e100: a94157f6    	ldp	x22, x21, [sp, #0x10]
11593e104: 910103ff    	add	sp, sp, #0x40
11593e108: d65f03c0    	ret
