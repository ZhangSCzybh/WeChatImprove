
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038ec48:     	sub	sp, sp, #0x90
10038ec4c:     	stp	x24, x23, [sp, #0x50]
10038ec50:     	stp	x22, x21, [sp, #0x60]
10038ec54:     	stp	x20, x19, [sp, #0x70]
10038ec58:     	stp	x29, x30, [sp, #0x80]
10038ec5c:     	add	x29, sp, #0x80
10038ec60:     	mov	x19, x2
10038ec64:     	mov	x20, x0
10038ec68:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10038ec6c:     	mov	w9, #0x1                ; =1
10038ec70:     	strb	w9, [x8, #0xc02]
10038ec74:     	mov	x0, x2
10038ec78:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038ec7c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ec80:     	ldr	x21, [x8, #0x400] ; selector: running
10038ec84:     	mov	x0, x20
10038ec88:     	mov	x1, x21
10038ec8c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ec90:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ec94:     	ldr	x22, [x8, #0x4a8] ; selector: currentRoomName
10038ec98:     	cbz	w0, 0x10038ed74 <__text+0x386d74>
10038ec9c:     	mov	x0, x20
10038eca0:     	mov	x1, x22
10038eca4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eca8:     	mov	x29, x29
10038ecac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ecb0:     	mov	x23, x0
10038ecb4:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
10038ecb8:     	ldr	x1, [x8, #0x7b8] ; selector: isEqualToString:
10038ecbc:     	mov	x2, x19
10038ecc0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ecc4:     	mov	x24, x0
10038ecc8:     	mov	x0, x23
10038eccc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ecd0:     	tbz	w24, #0x0, 0x10038ed74 <__text+0x386d74>
10038ecd4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ecd8:     	ldr	x1, [x8, #0x448] ; selector: approvedRoomNames
10038ecdc:     	mov	x0, x20
10038ece0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ece4:     	mov	x29, x29
10038ece8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ecec:     	mov	x21, x0
10038ecf0:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
10038ecf4:     	ldr	x1, [x8, #0xa38] ; selector: addObject:
10038ecf8:     	mov	x2, x19
10038ecfc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ed00:     	mov	x0, x21
10038ed04:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ed08:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ed0c:     	ldr	x1, [x8, #0x420] ; selector: setCurrentRoomName:
10038ed10:     	mov	x0, x20
10038ed14:     	mov	x2, #0x0                ; =0
10038ed18:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ed1c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ed20:     	ldr	x1, [x8, #0x418] ; selector: setStage:
10038ed24:     	mov	x0, x20
10038ed28:     	mov	w2, #0x1                ; =1
10038ed2c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ed30:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038ed34:     	ldr	x8, [x8, #0x930]
10038ed38:     	str	x8, [sp, #0x28]
10038ed3c:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
10038ed40:     	ldr	d0, [x8, #0x680] ; constant double=1.6080749353e-314
10038ed44:     	adrp	x8, 0x10038e000 <__text+0x386000>
10038ed48:     	add	x8, x8, #0xe0c
10038ed4c:     	str	d0, [sp, #0x30]
10038ed50:     	adrp	x9, 0x11c280000 <dyld_stub_binder+0x11c280000>
10038ed54:     	add	x9, x9, #0x470
10038ed58:     	stp	x8, x9, [sp, #0x38]
10038ed5c:     	str	x20, [sp, #0x48]
10038ed60:     	adrp	x0, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038ed64:     	ldr	x0, [x0, #0xa98]
10038ed68:     	add	x1, sp, #0x28
10038ed6c:     	bl	0x107c0cb9c <_Flutter_MMFoundation_BindContext+0x3e93868>
10038ed70:     	b	0x10038edec <__text+0x386dec>
10038ed74:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038ed78:     	ldr	x23, [x8, #0x618]
10038ed7c:     	mov	x0, x20
10038ed80:     	mov	x1, x22
10038ed84:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ed88:     	mov	x29, x29
10038ed8c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ed90:     	mov	x22, x0
10038ed94:     	mov	x0, x20
10038ed98:     	mov	x1, x21
10038ed9c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eda0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038eda4:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10038eda8:     	stp	x22, x0, [sp, #0x10]
10038edac:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038edb0:     	add	x8, x8, #0xe18 ; CFString: ignore room approval, room:%@ currentRoom:%@ running:%d
10038edb4:     	stp	x8, x19, [sp]
10038edb8:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
10038edbc:     	add	x3, x3, #0xff4
10038edc0:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038edc4:     	add	x5, x5, #0xb
10038edc8:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
10038edcc:     	add	x7, x7, #0x292
10038edd0:     	mov	x0, x23
10038edd4:     	mov	w2, #0x3                ; =3
10038edd8:     	mov	w4, #0x0                ; =0
10038eddc:     	mov	w6, #0xd8               ; =216
10038ede0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ede4:     	mov	x0, x22
10038ede8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038edec:     	mov	x0, x19
10038edf0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038edf4:     	ldp	x29, x30, [sp, #0x80]
10038edf8:     	ldp	x20, x19, [sp, #0x70]
10038edfc:     	ldp	x22, x21, [sp, #0x60]
10038ee00:     	ldp	x24, x23, [sp, #0x50]
10038ee04:     	add	sp, sp, #0x90
10038ee08:     	ret
10038ee0c:     	ldr	x0, [x0, #0x20]
10038ee10:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ee14:     	ldr	x1, [x8, #0x498] ; selector: processNextRoom
10038ee18:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
