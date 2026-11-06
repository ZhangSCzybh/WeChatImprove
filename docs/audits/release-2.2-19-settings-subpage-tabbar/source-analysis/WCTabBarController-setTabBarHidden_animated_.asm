
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157dcd70: d10283ff    	sub	sp, sp, #0xa0
1157dcd74: a9065ff8    	stp	x24, x23, [sp, #0x60]
1157dcd78: a90757f6    	stp	x22, x21, [sp, #0x70]
1157dcd7c: a9084ff4    	stp	x20, x19, [sp, #0x80]
1157dcd80: a9097bfd    	stp	x29, x30, [sp, #0x90]
1157dcd84: 910243fd    	add	x29, sp, #0x90
1157dcd88: aa0303f5    	mov	x21, x3
1157dcd8c: aa0203f3    	mov	x19, x2
1157dcd90: aa0003f4    	mov	x20, x0
1157dcd94: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dcd98: f942dd01    	ldr	x1, [x8, #0x5b8]
1157dcd9c: 9459fdea    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcda0: 6b00027f    	cmp	w19, w0
1157dcda4: 54000a60    	b.eq	0x1157dcef0 <_O266DecReleaseOutputPicture+0x36cd984>
1157dcda8: f004a5a8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157dcdac: f942e101    	ldr	x1, [x8, #0x5c0]
1157dcdb0: aa1403e0    	mov	x0, x20
1157dcdb4: aa1303e2    	mov	x2, x19
1157dcdb8: 9459fde3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcdbc: d00499a8    	adrp	x8, 0x11eb12000 <dyld_stub_binder+0x11eb12000>
1157dcdc0: f9462901    	ldr	x1, [x8, #0xc50]
1157dcdc4: aa1403e0    	mov	x0, x20
1157dcdc8: aa1303e2    	mov	x2, x19
1157dcdcc: 9459fdde    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcdd0: b004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157dcdd4: f9472916    	ldr	x22, [x8, #0xe50]
1157dcdd8: aa1403e0    	mov	x0, x20
1157dcddc: aa1603e1    	mov	x1, x22
1157dcde0: 9459fdd9    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcde4: aa1d03fd    	mov	x29, x29
1157dcde8: 9459fe04    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dcdec: aa0003f7    	mov	x23, x0
1157dcdf0: 9004a688    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1157dcdf4: f9411101    	ldr	x1, [x8, #0x220]
1157dcdf8: 9459fdd3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcdfc: aa1703e0    	mov	x0, x23
1157dce00: 9459fdef    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dce04: 36000c55    	tbz	w21, #0x0, 0x1157dcf8c <_O266DecReleaseOutputPicture+0x36cda20>
1157dce08: 37000373    	tbnz	w19, #0x0, 0x1157dce74 <_O266DecReleaseOutputPicture+0x36cd908>
1157dce0c: b0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dce10: f9443915    	ldr	x21, [x8, #0x870]
1157dce14: aa1403e0    	mov	x0, x20
1157dce18: aa1503e1    	mov	x1, x21
1157dce1c: 9459fdca    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dce20: aa1d03fd    	mov	x29, x29
1157dce24: 9459fdf5    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dce28: aa0003f6    	mov	x22, x0
1157dce2c: f004a668    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1157dce30: f9458d01    	ldr	x1, [x8, #0xb18]
1157dce34: 52800002    	mov	w2, #0x0                ; =0
1157dce38: 9459fdc3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dce3c: aa1603e0    	mov	x0, x22
1157dce40: 9459fddf    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dce44: aa1403e0    	mov	x0, x20
1157dce48: aa1503e1    	mov	x1, x21
1157dce4c: 9459fdbe    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dce50: aa1d03fd    	mov	x29, x29
1157dce54: 9459fde9    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dce58: aa0003f5    	mov	x21, x0
1157dce5c: d004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dce60: f946f501    	ldr	x1, [x8, #0xde8]
1157dce64: 9e6703e0    	fmov	d0, xzr
1157dce68: 9459fdb7    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dce6c: aa1503e0    	mov	x0, x21
1157dce70: 9459fdd3    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dce74: d004a9a8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1157dce78: f9452d00    	ldr	x0, [x8, #0xa58]
1157dce7c: 9003fb88    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1157dce80: f9449908    	ldr	x8, [x8, #0x930]
1157dce84: f9001be8    	str	x8, [sp, #0x30]
1157dce88: f0010749    	adrp	x9, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1157dce8c: fd434120    	ldr	d0, [x9, #0x680]
1157dce90: fd001fe0    	str	d0, [sp, #0x38]
1157dce94: 90000009    	adrp	x9, 0x1157dc000 <_O266DecReleaseOutputPicture+0x36cca94>
1157dce98: 913f3129    	add	x9, x9, #0xfcc
1157dce9c: 9003552a    	adrp	x10, 0x11c280000 <dyld_stub_binder+0x11c280000>
1157dcea0: 9120414a    	add	x10, x10, #0x810
1157dcea4: a9042be9    	stp	x9, x10, [sp, #0x40]
1157dcea8: f9002bf4    	str	x20, [sp, #0x50]
1157dceac: 390163f3    	strb	w19, [sp, #0x58]
1157dceb0: f90003e8    	str	x8, [sp]
1157dceb4: fd0007e0    	str	d0, [sp, #0x8]
1157dceb8: b0000008    	adrp	x8, 0x1157dd000 <_O266DecReleaseOutputPicture+0x36cda94>
1157dcebc: 9100a108    	add	x8, x8, #0x28
1157dcec0: 90035569    	adrp	x9, 0x11c288000 <dyld_stub_binder+0x11c288000>
1157dcec4: 91148129    	add	x9, x9, #0x520
1157dcec8: a90127e8    	stp	x8, x9, [sp, #0x10]
1157dcecc: f90013f4    	str	x20, [sp, #0x20]
1157dced0: 3900a3f3    	strb	w19, [sp, #0x28]
1157dced4: d0048f88    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
1157dced8: f940dd01    	ldr	x1, [x8, #0x1b8]
1157dcedc: 1e6a1000    	fmov	d0, #0.25000000
1157dcee0: 9100c3e2    	add	x2, sp, #0x30
1157dcee4: 910003e3    	mov	x3, sp
1157dcee8: 9459fd97    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dceec: 14000022    	b	0x1157dcf74 <_O266DecReleaseOutputPicture+0x36cda08>
1157dcef0: d0048fc8    	adrp	x8, 0x11e9d6000 <dyld_stub_binder+0x11e9d6000>
1157dcef4: f940f901    	ldr	x1, [x8, #0x1f0]
1157dcef8: aa1403e0    	mov	x0, x20
1157dcefc: 9459fd92    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcf00: 340003a0    	cbz	w0, 0x1157dcf74 <_O266DecReleaseOutputPicture+0x36cda08>
1157dcf04: b0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dcf08: f9443915    	ldr	x21, [x8, #0x870]
1157dcf0c: aa1403e0    	mov	x0, x20
1157dcf10: aa1503e1    	mov	x1, x21
1157dcf14: 9459fd8c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcf18: aa1d03fd    	mov	x29, x29
1157dcf1c: 9459fdb7    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dcf20: aa0003f6    	mov	x22, x0
1157dcf24: 9004a668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1157dcf28: f9441501    	ldr	x1, [x8, #0x828]
1157dcf2c: 9459fd86    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcf30: aa0003f7    	mov	x23, x0
1157dcf34: aa1603e0    	mov	x0, x22
1157dcf38: 9459fda1    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dcf3c: 6b17027f    	cmp	w19, w23
1157dcf40: 540001a0    	b.eq	0x1157dcf74 <_O266DecReleaseOutputPicture+0x36cda08>
1157dcf44: aa1403e0    	mov	x0, x20
1157dcf48: aa1503e1    	mov	x1, x21
1157dcf4c: 9459fd7e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcf50: aa1d03fd    	mov	x29, x29
1157dcf54: 9459fda9    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dcf58: aa0003f4    	mov	x20, x0
1157dcf5c: f004a668    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1157dcf60: f9458d01    	ldr	x1, [x8, #0xb18]
1157dcf64: aa1303e2    	mov	x2, x19
1157dcf68: 9459fd77    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcf6c: aa1403e0    	mov	x0, x20
1157dcf70: 14000011    	b	0x1157dcfb4 <_O266DecReleaseOutputPicture+0x36cda48>
1157dcf74: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1157dcf78: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1157dcf7c: a94757f6    	ldp	x22, x21, [sp, #0x70]
1157dcf80: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1157dcf84: 910283ff    	add	sp, sp, #0xa0
1157dcf88: d65f03c0    	ret
1157dcf8c: aa1403e0    	mov	x0, x20
1157dcf90: aa1603e1    	mov	x1, x22
1157dcf94: 9459fd6c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcf98: aa1d03fd    	mov	x29, x29
1157dcf9c: 9459fd97    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dcfa0: aa0003f3    	mov	x19, x0
1157dcfa4: 9004a668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1157dcfa8: f9465d01    	ldr	x1, [x8, #0xcb8]
1157dcfac: 9459fd66    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcfb0: aa1303e0    	mov	x0, x19
1157dcfb4: a9497bfd    	ldp	x29, x30, [sp, #0x90]
1157dcfb8: a9484ff4    	ldp	x20, x19, [sp, #0x80]
1157dcfbc: a94757f6    	ldp	x22, x21, [sp, #0x70]
1157dcfc0: a9465ff8    	ldp	x24, x23, [sp, #0x60]
1157dcfc4: 910283ff    	add	sp, sp, #0xa0
1157dcfc8: 1459fd7d    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dcfcc: 6dbd23e9    	stp	d9, d8, [sp, #-0x30]!
1157dcfd0: a9014ff4    	stp	x20, x19, [sp, #0x10]
1157dcfd4: a9027bfd    	stp	x29, x30, [sp, #0x20]
1157dcfd8: 910083fd    	add	x29, sp, #0x20
1157dcfdc: 3940a008    	ldrb	w8, [x0, #0x28]
1157dcfe0: 52000108    	eor	w8, w8, #0x1
1157dcfe4: 1e630108    	ucvtf	d8, w8
1157dcfe8: f9401000    	ldr	x0, [x0, #0x20]
1157dcfec: b0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dcff0: f9443901    	ldr	x1, [x8, #0x870]
1157dcff4: 9459fd54    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dcff8: aa1d03fd    	mov	x29, x29
1157dcffc: 9459fd7f    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dd000: aa0003f3    	mov	x19, x0
1157dd004: b004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dd008: f946f501    	ldr	x1, [x8, #0xde8]
1157dd00c: 4ea81d00    	mov.16b	v0, v8
1157dd010: 9459fd4d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dd014: aa1303e0    	mov	x0, x19
1157dd018: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1157dd01c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1157dd020: 6cc323e9    	ldp	d9, d8, [sp], #0x30
1157dd024: 1459fd66    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dd028: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
1157dd02c: a9014ff4    	stp	x20, x19, [sp, #0x10]
1157dd030: a9027bfd    	stp	x29, x30, [sp, #0x20]
1157dd034: 910083fd    	add	x29, sp, #0x20
1157dd038: aa0003f3    	mov	x19, x0
1157dd03c: 3940a014    	ldrb	w20, [x0, #0x28]
1157dd040: f9401000    	ldr	x0, [x0, #0x20]
1157dd044: 90049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157dd048: f9443915    	ldr	x21, [x8, #0x870]
1157dd04c: aa1503e1    	mov	x1, x21
1157dd050: 9459fd3d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dd054: aa1d03fd    	mov	x29, x29
1157dd058: 9459fd68    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dd05c: aa0003f6    	mov	x22, x0
1157dd060: d004a668    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1157dd064: f9458d01    	ldr	x1, [x8, #0xb18]
1157dd068: aa1403e2    	mov	x2, x20
1157dd06c: 9459fd36    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dd070: aa1603e0    	mov	x0, x22
1157dd074: 9459fd52    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157dd078: f9401260    	ldr	x0, [x19, #0x20]
1157dd07c: aa1503e1    	mov	x1, x21
1157dd080: 9459fd31    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dd084: aa1d03fd    	mov	x29, x29
1157dd088: 9459fd5c    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157dd08c: aa0003f3    	mov	x19, x0
1157dd090: b004a668    	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
1157dd094: f946f501    	ldr	x1, [x8, #0xde8]
1157dd098: 1e6e1000    	fmov	d0, #1.00000000
1157dd09c: 9459fd2a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157dd0a0: aa1303e0    	mov	x0, x19
1157dd0a4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
1157dd0a8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
1157dd0ac: a8c357f6    	ldp	x22, x21, [sp], #0x30
1157dd0b0: 1459fd43    	b	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
