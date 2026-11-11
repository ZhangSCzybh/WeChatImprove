
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f78f58: d10643ff    	sub	sp, sp, #0x190
100f78f5c: a9136ffc    	stp	x28, x27, [sp, #0x130]
100f78f60: a91467fa    	stp	x26, x25, [sp, #0x140]
100f78f64: a9155ff8    	stp	x24, x23, [sp, #0x150]
100f78f68: a91657f6    	stp	x22, x21, [sp, #0x160]
100f78f6c: a9174ff4    	stp	x20, x19, [sp, #0x170]
100f78f70: a9187bfd    	stp	x29, x30, [sp, #0x180]
100f78f74: 910603fd    	add	x29, sp, #0x180
100f78f78: aa0203fb    	mov	x27, x2
100f78f7c: aa0003f4    	mov	x20, x0
100f78f80: 900e3ea8    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f78f84: f9451908    	ldr	x8, [x8, #0xa30]
100f78f88: f9400108    	ldr	x8, [x8]
100f78f8c: f81a03a8    	stur	x8, [x29, #-0x60]
100f78f90: f00f3e48    	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100f78f94: 52800029    	mov	w9, #0x1                ; =1
100f78f98: 391ba909    	strb	w9, [x8, #0x6ea]
100f78f9c: aa0203e0    	mov	x0, x2
100f78fa0: 95b2bb35    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100f78fa4: f9401281    	ldr	x1, [x20, #0x20]
100f78fa8: 910243e0    	add	x0, sp, #0x90
100f78fac: 95b24f41    	bl	0x107c0ccb0 <_Flutter_MMFoundation_BindContext+0x3e9397c>
100f78fb0: f9000bf4    	str	x20, [sp, #0x10]
100f78fb4: f9400688    	ldr	x8, [x20, #0x8]
100f78fb8: b5000128    	cbnz	x8, 0x100f78fdc <__text+0xf70fdc>
100f78fbc: d00eecc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f78fc0: f9431900    	ldr	x0, [x8, #0x630]
100f78fc4: 95b2bb12    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
100f78fc8: f9400be9    	ldr	x9, [sp, #0x10]
100f78fcc: f9400528    	ldr	x8, [x9, #0x8]
100f78fd0: f9000520    	str	x0, [x9, #0x8]
100f78fd4: aa0803e0    	mov	x0, x8
100f78fd8: 95b2bb26    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f78fdc: 4f00e400    	movi.16b	v0, #0x0
100f78fe0: ad0383e0    	stp	q0, q0, [sp, #0x70]
100f78fe4: ad0283e0    	stp	q0, q0, [sp, #0x50]
100f78fe8: d00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f78fec: f9475d01    	ldr	x1, [x8, #0xeb8] ; selector: chatRoomMember
100f78ff0: aa1b03e0    	mov	x0, x27
100f78ff4: 95b2bb1c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f78ff8: aa1d03fd    	mov	x29, x29
100f78ffc: 95b2bb21    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f79000: b00ee968    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f79004: f9442d01    	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
100f79008: 910143e2    	add	x2, sp, #0x50
100f7900c: 910283e3    	add	x3, sp, #0xa0
100f79010: f90027e0    	str	x0, [sp, #0x48]
100f79014: f90007e1    	str	x1, [sp, #0x8]
100f79018: 52800204    	mov	w4, #0x10               ; =16
100f7901c: 95b2bb12    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f79020: b4000ca0    	cbz	x0, 0x100f791b4 <__text+0xf711b4>
100f79024: aa0003f6    	mov	x22, x0
100f79028: f94033e8    	ldr	x8, [sp, #0x60]
100f7902c: f9400114    	ldr	x20, [x8]
100f79030: d2800019    	mov	x25, #0x0               ; =0
100f79034: b00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f79038: f947611a    	ldr	x26, [x8, #0xec0] ; selector: infoMask
100f7903c: f00ed288    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f79040: f9453909    	ldr	x9, [x8, #0xa70] ; selector: userName
100f79044: f00ed2a8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100f79048: f941e508    	ldr	x8, [x8, #0x3c8] ; selector: displayName
100f7904c: a903a7e8    	stp	x8, x9, [sp, #0x38]
100f79050: b00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f79054: f9476508    	ldr	x8, [x8, #0xec8] ; selector: setDataForUserName:key:value:
100f79058: a902a3f6    	stp	x22, x8, [sp, #0x28]
100f7905c: b00ed4e8    	adrp	x8, 0x11ea16000 <dyld_stub_binder+0x11ea16000>
100f79060: f9476909    	ldr	x9, [x8, #0xed0] ; selector: chatroomMemberFlag
100f79064: 900ee988    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100f79068: f942d508    	ldr	x8, [x8, #0x5a8] ; selector: numberWithInt:
100f7906c: a901a7e8    	stp	x8, x9, [sp, #0x18]
100f79070: f94033e8    	ldr	x8, [sp, #0x60]
100f79074: f9400108    	ldr	x8, [x8]
100f79078: eb14011f    	cmp	x8, x20
100f7907c: 54000060    	b.eq	0x100f79088 <__text+0xf71088>
100f79080: f94027e0    	ldr	x0, [sp, #0x48]
100f79084: 95b2baee    	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
100f79088: f9402fe8    	ldr	x8, [sp, #0x58]
100f7908c: f8797915    	ldr	x21, [x8, x25, lsl #3]
100f79090: aa1b03e0    	mov	x0, x27
100f79094: aa1a03e1    	mov	x1, x26
100f79098: 95b2baf3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f7909c: 35000760    	cbnz	w0, 0x100f79188 <__text+0xf71188>
100f790a0: aa1503e0    	mov	x0, x21
100f790a4: f94023f8    	ldr	x24, [sp, #0x40]
100f790a8: aa1803e1    	mov	x1, x24
100f790ac: 95b2baee    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f790b0: aa1d03fd    	mov	x29, x29
100f790b4: 95b2baf3    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f790b8: aa0003fc    	mov	x28, x0
100f790bc: aa1503e0    	mov	x0, x21
100f790c0: f9401fe1    	ldr	x1, [sp, #0x38]
100f790c4: 95b2bae8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f790c8: aa1d03fd    	mov	x29, x29
100f790cc: 95b2baed    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f790d0: aa1403f6    	mov	x22, x20
100f790d4: aa0003f4    	mov	x20, x0
100f790d8: f9400bf3    	ldr	x19, [sp, #0x10]
100f790dc: aa1303e0    	mov	x0, x19
100f790e0: f9401bf7    	ldr	x23, [sp, #0x30]
100f790e4: aa1703e1    	mov	x1, x23
100f790e8: aa1c03e2    	mov	x2, x28
100f790ec: b00e0643    	adrp	x3, 0x11d042000 <dyld_stub_binder+0x11d042000>
100f790f0: 912e6063    	add	x3, x3, #0xb98 ; CFString: DisplayName
100f790f4: aa1403e4    	mov	x4, x20
100f790f8: 95b2badb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f790fc: aa1403e0    	mov	x0, x20
100f79100: 95b2badc    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f79104: aa1c03e0    	mov	x0, x28
100f79108: 95b2bada    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f7910c: aa1503e0    	mov	x0, x21
100f79110: aa1803e1    	mov	x1, x24
100f79114: 95b2bad4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f79118: aa1d03fd    	mov	x29, x29
100f7911c: 95b2bad9    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f79120: aa0003f4    	mov	x20, x0
100f79124: b00eecc8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f79128: f943611c    	ldr	x28, [x8, #0x6c0]
100f7912c: aa1503e0    	mov	x0, x21
100f79130: f94013e1    	ldr	x1, [sp, #0x20]
100f79134: 95b2bacc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f79138: aa0003e2    	mov	x2, x0
100f7913c: aa1c03e0    	mov	x0, x28
100f79140: f9400fe1    	ldr	x1, [sp, #0x18]
100f79144: 95b2bac8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f79148: aa1d03fd    	mov	x29, x29
100f7914c: 95b2bacd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f79150: aa0003f5    	mov	x21, x0
100f79154: aa1303e0    	mov	x0, x19
100f79158: aa1703e1    	mov	x1, x23
100f7915c: aa1403e2    	mov	x2, x20
100f79160: b00e0643    	adrp	x3, 0x11d042000 <dyld_stub_binder+0x11d042000>
100f79164: 912ee063    	add	x3, x3, #0xbb8 ; CFString: Flag
100f79168: aa1503e4    	mov	x4, x21
100f7916c: 95b2babe    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f79170: aa1503e0    	mov	x0, x21
100f79174: 95b2babf    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f79178: aa1403e0    	mov	x0, x20
100f7917c: aa1603f4    	mov	x20, x22
100f79180: f94017f6    	ldr	x22, [sp, #0x28]
100f79184: 95b2babb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f79188: 91000739    	add	x25, x25, #0x1
100f7918c: eb1902df    	cmp	x22, x25
100f79190: 54fff701    	b.ne	0x100f79070 <__text+0xf71070>
100f79194: 910143e2    	add	x2, sp, #0x50
100f79198: 910283e3    	add	x3, sp, #0xa0
100f7919c: f94027e0    	ldr	x0, [sp, #0x48]
100f791a0: f94007e1    	ldr	x1, [sp, #0x8]
100f791a4: 52800204    	mov	w4, #0x10               ; =16
100f791a8: 95b2baaf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f791ac: aa0003f6    	mov	x22, x0
100f791b0: b5fff400    	cbnz	x0, 0x100f79030 <__text+0xf71030>
100f791b4: f94027e0    	ldr	x0, [sp, #0x48]
100f791b8: 95b2baae    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f791bc: 910243e0    	add	x0, sp, #0x90
100f791c0: 95b24ebd    	bl	0x107c0ccb4 <_Flutter_MMFoundation_BindContext+0x3e93980>
100f791c4: aa1b03e0    	mov	x0, x27
100f791c8: 95b2baaa    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f791cc: f85a03a8    	ldur	x8, [x29, #-0x60]
100f791d0: f00e3e89    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f791d4: f9451929    	ldr	x9, [x9, #0xa30]
100f791d8: f9400129    	ldr	x9, [x9]
100f791dc: eb08013f    	cmp	x9, x8
100f791e0: 54000121    	b.ne	0x100f79204 <__text+0xf71204>
100f791e4: a9587bfd    	ldp	x29, x30, [sp, #0x180]
100f791e8: a9574ff4    	ldp	x20, x19, [sp, #0x170]
100f791ec: a95657f6    	ldp	x22, x21, [sp, #0x160]
100f791f0: a9555ff8    	ldp	x24, x23, [sp, #0x150]
100f791f4: a95467fa    	ldp	x26, x25, [sp, #0x140]
100f791f8: a9536ffc    	ldp	x28, x27, [sp, #0x130]
100f791fc: 910643ff    	add	sp, sp, #0x190
100f79200: d65f03c0    	ret
100f79204: 95b2b94b    	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
