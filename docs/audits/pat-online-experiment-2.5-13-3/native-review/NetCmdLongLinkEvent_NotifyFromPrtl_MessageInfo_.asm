
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
1053224d4: d10283ff    	sub	sp, sp, #0xa0
1053224d8: a90567fa    	stp	x26, x25, [sp, #0x50]
1053224dc: a9065ff8    	stp	x24, x23, [sp, #0x60]
1053224e0: a90757f6    	stp	x22, x21, [sp, #0x70]
1053224e4: a9084ff4    	stp	x20, x19, [sp, #0x80]
1053224e8: a9097bfd    	stp	x29, x30, [sp, #0x90]
1053224ec: 910243fd    	add	x29, sp, #0x90
1053224f0: aa0303f6    	mov	x22, x3
1053224f4: aa0203f8    	mov	x24, x2
1053224f8: aa0003f9    	mov	x25, x0
1053224fc: 900d2188    	adrp	x8, 0x11f752000 <dyld_stub_binder+0x11f752000>
105322500: 52800029    	mov	w9, #0x1                ; =1
105322504: 393ed509    	strb	w9, [x8, #0xfb5]
105322508: 900cc0a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
10532250c: f9406913    	ldr	x19, [x8, #0xd0] ; selector responseHandler
105322510: aa0303e0    	mov	x0, x3
105322514: 94a415d8    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105322518: aa1903e0    	mov	x0, x25
10532251c: aa1303e1    	mov	x1, x19
105322520: 94a415d1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105322524: aa1d03fd    	mov	x29, x29
105322528: 94a415d6    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10532252c: aa0003f3    	mov	x19, x0
105322530: b00cb8c8    	adrp	x8, 0x11ea3b000 <dyld_stub_binder+0x11ea3b000>
105322534: f9436501    	ldr	x1, [x8, #0x6c8] ; selector responseData
105322538: aa1903e0    	mov	x0, x25
10532253c: 94a415ca    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105322540: aa1d03fd    	mov	x29, x29
105322544: 94a415cf    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
105322548: aa0003f4    	mov	x20, x0
10532254c: 900cc0a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
105322550: f9406d01    	ldr	x1, [x8, #0xd8] ; selector responseErrType
105322554: aa1903e0    	mov	x0, x25
105322558: 94a415c3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10532255c: aa0003f5    	mov	x21, x0
105322560: 900cc0a8    	adrp	x8, 0x11eb36000 <dyld_stub_binder+0x11eb36000>
105322564: f9407101    	ldr	x1, [x8, #0xe0] ; selector responseErrCode
105322568: aa1903e0    	mov	x0, x25
10532256c: 94a415be    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105322570: aa0003f7    	mov	x23, x0
105322574: f00cd208    	adrp	x8, 0x11ed65000 <dyld_stub_binder+0x11ed65000>
105322578: f946c108    	ldr	x8, [x8, #0xd80] ; 0x11ed65d80 __objc_superrefs
10532257c: a90423f9    	stp	x25, x8, [sp, #0x40]
105322580: b00cb8c8    	adrp	x8, 0x11ea3b000 <dyld_stub_binder+0x11ea3b000>
105322584: f9435101    	ldr	x1, [x8, #0x6a0] ; selector NotifyFromPrtl:MessageInfo:
105322588: 910103e0    	add	x0, sp, #0x40
10532258c: aa1803e2    	mov	x2, x24
105322590: aa1603e3    	mov	x3, x22
105322594: 94a415b5    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
105322598: aa1603e0    	mov	x0, x22
10532259c: 94a415b5    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1053225a0: b4000453    	cbz	x19, 0x105322628 <_Flutter_MMFoundation_BindContext+0x15a92f4>
1053225a4: d2800000    	mov	x0, #0x0                ; =0
1053225a8: d2800001    	mov	x1, #0x0                ; =0
1053225ac: 94a414b4    	bl	0x107c2787c <_Flutter_MMFoundation_BindContext+0x3eae548>
1053225b0: aa1d03fd    	mov	x29, x29
1053225b4: 94a415b3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1053225b8: aa0003f6    	mov	x22, x0
1053225bc: d00c2148    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1053225c0: f9449908    	ldr	x8, [x8, #0x930] ; 0x11d74c930 __got
1053225c4: f90007e8    	str	x8, [sp, #0x8]
1053225c8: b0092d28    	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
1053225cc: fd434100    	ldr	d0, [x8, #0x680]
1053225d0: fd000be0    	str	d0, [sp, #0x10]
1053225d4: 90000008    	adrp	x8, 0x105322000 <_Flutter_MMFoundation_BindContext+0x15a8ccc>
1053225d8: 91195108    	add	x8, x8, #0x654 ; 0x105322654 __text
1053225dc: f00b7ae9    	adrp	x9, 0x11c281000 <dyld_stub_binder+0x11c281000>
1053225e0: 910fe129    	add	x9, x9, #0x3f8 ; 0x11c2813f8 __const
1053225e4: a901a7e8    	stp	x8, x9, [sp, #0x18]
1053225e8: aa1303e0    	mov	x0, x19
1053225ec: 94a415a2    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1053225f0: f9001bf3    	str	x19, [sp, #0x30]
1053225f4: aa1403e0    	mov	x0, x20
1053225f8: 94a4159f    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1053225fc: f90017f4    	str	x20, [sp, #0x28]
105322600: 29075ff5    	stp	w21, w23, [sp, #0x38]
105322604: 910023e1    	add	x1, sp, #0x8
105322608: aa1603e0    	mov	x0, x22
10532260c: 94a3a964    	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
105322610: aa1603e0    	mov	x0, x22
105322614: 94a41597    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105322618: f94017e0    	ldr	x0, [sp, #0x28]
10532261c: 94a41595    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105322620: f9401be0    	ldr	x0, [sp, #0x30]
105322624: 94a41593    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105322628: aa1403e0    	mov	x0, x20
10532262c: 94a41591    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105322630: aa1303e0    	mov	x0, x19
105322634: 94a4158f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105322638: a9497bfd    	ldp	x29, x30, [sp, #0x90]
10532263c: a9484ff4    	ldp	x20, x19, [sp, #0x80]
105322640: a94757f6    	ldp	x22, x21, [sp, #0x70]
105322644: a9465ff8    	ldp	x24, x23, [sp, #0x60]
105322648: a94567fa    	ldp	x26, x25, [sp, #0x50]
10532264c: 910283ff    	add	sp, sp, #0xa0
105322650: d65f03c0    	ret
