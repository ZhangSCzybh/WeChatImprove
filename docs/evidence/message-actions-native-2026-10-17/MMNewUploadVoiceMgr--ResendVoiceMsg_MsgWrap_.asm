
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10453be60: d10443ff    	sub	sp, sp, #0x110
10453be64: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
10453be68: a90c67fa    	stp	x26, x25, [sp, #0xc0]
10453be6c: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
10453be70: a90e57f6    	stp	x22, x21, [sp, #0xe0]
10453be74: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
10453be78: a9107bfd    	stp	x29, x30, [sp, #0x100]
10453be7c: 910403fd    	add	x29, sp, #0x100
10453be80: aa0303f4    	mov	x20, x3
10453be84: aa0003f3    	mov	x19, x0
10453be88: b00e3808    	adrp	x8, 0x120c3c000 <dyld_stub_binder+0x120c3c000>
10453be8c: 52800029    	mov	w9, #0x1                ; =1
10453be90: 393c8d09    	strb	w9, [x8, #0xf23]
10453be94: f9003fe2    	str	x2, [sp, #0x78]
10453be98: aa0203e0    	mov	x0, x2
10453be9c: 94dbaca7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10453bea0: aa1403e0    	mov	x0, x20
10453bea4: 94dbaca5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10453bea8: d00de708    	adrp	x8, 0x12021d000 <dyld_stub_binder+0x12021d000>
10453beac: b9878908    	ldrsw	x8, [x8, #0x788]
10453beb0: f9003bf3    	str	x19, [sp, #0x70]
10453beb4: f8686a61    	ldr	x1, [x19, x8]
10453beb8: d101a3a0    	sub	x0, x29, #0x68
10453bebc: 94db451d    	bl	0x107c0d330 <_Flutter_MMFoundation_BindContext+0x40e8f14>
10453bec0: 900dc848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10453bec4: f9456501    	ldr	x1, [x8, #0xac8] ; m_dtVoice
10453bec8: aa1403e0    	mov	x0, x20
10453becc: 94dbac9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453bed0: aa1d03fd    	mov	x29, x29
10453bed4: 94dbac9d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10453bed8: aa0003f5    	mov	x21, x0
10453bedc: 900dde48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10453bee0: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10453bee4: 94dbac96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453bee8: aa0003f8    	mov	x24, x0
10453beec: aa1503e0    	mov	x0, x21
10453bef0: 94dbac99    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10453bef4: 34000ed8    	cbz	w24, 0x10453c0cc <_Flutter_MMFoundation_BindContext+0xa17cb0>
10453bef8: 5280001a    	mov	w26, #0x0               ; =0
10453befc: 900dc848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10453bf00: f9457d16    	ldr	x22, [x8, #0xaf8] ; m_uiVoiceFormat
10453bf04: 900dc848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10453bf08: f943ed08    	ldr	x8, [x8, #0x7d8] ; m_uiVoiceTime
10453bf0c: f9001be8    	str	x8, [sp, #0x30]
10453bf10: d00dc7e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10453bf14: f942a909    	ldr	x9, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10453bf18: b00dc808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10453bf1c: f947d108    	ldr	x8, [x8, #0xfa0] ; m_uiMesLocalID
10453bf20: a90627e8    	stp	x8, x9, [sp, #0x60]
10453bf24: b00dc808    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10453bf28: b00dc809    	adrp	x9, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10453bf2c: 900dc84a    	adrp	x10, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10453bf30: 900dc82b    	adrp	x11, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
10453bf34: f947d508    	ldr	x8, [x8, #0xfa8] ; m_n64MesSvrID
10453bf38: f9002fe8    	str	x8, [sp, #0x58]
10453bf3c: 900dc848    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10453bf40: f947d929    	ldr	x9, [x9, #0xfb0] ; m_uiCreateTime
10453bf44: f9002be9    	str	x9, [sp, #0x50]
10453bf48: f9468949    	ldr	x9, [x10, #0xd10] ; m_uiVoiceForwardFlag
10453bf4c: f90027e9    	str	x9, [sp, #0x48]
10453bf50: f944f169    	ldr	x9, [x11, #0x9e0] ; m_nsMsgSource
10453bf54: f9466108    	ldr	x8, [x8, #0xcc0] ; AddNewPart:LocalID:n64SvrID:Offset:Len:VoiceTime:CreateTime:EndFlag:CancelFlag:VoiceFormat:ForwardFlag:msgSource:chatName:
10453bf58: a903a7e8    	stp	x8, x9, [sp, #0x38]
10453bf5c: 4b1a0308    	sub	w8, w24, w26
10453bf60: 7140091f    	cmp	w8, #0x2, lsl #12       ; =0x2000
10453bf64: 52840009    	mov	w9, #0x2000             ; =8192
10453bf68: 1a893108    	csel	w8, w8, w9, lo
10453bf6c: b81943a8    	stur	w8, [x29, #-0x6c]
10453bf70: 0b1a011c    	add	w28, w8, w26
10453bf74: aa1403e0    	mov	x0, x20
10453bf78: aa1603e1    	mov	x1, x22
10453bf7c: 94dbac70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453bf80: 7100101f    	cmp	w0, #0x4
10453bf84: 540000c1    	b.ne	0x10453bf9c <_Flutter_MMFoundation_BindContext+0xa17b80>
10453bf88: aa1403e0    	mov	x0, x20
10453bf8c: f9401be1    	ldr	x1, [sp, #0x30]
10453bf90: 94dbac6b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453bf94: aa0003e9    	mov	x9, x0
10453bf98: 14000008    	b	0x10453bfb8 <_Flutter_MMFoundation_BindContext+0xa17b9c>
10453bf9c: 53017f88    	lsr	w8, w28, #1
10453bfa0: 52849269    	mov	w9, #0x2493             ; =9363
10453bfa4: 72b24929    	movk	w9, #0x9249, lsl #16
10453bfa8: 9ba97d08    	umull	x8, w8, w9
10453bfac: d362fd08    	lsr	x8, x8, #34
10453bfb0: 0b080908    	add	w8, w8, w8, lsl #2
10453bfb4: 531e7509    	lsl	w9, w8, #2
10453bfb8: f81883a9    	stur	x9, [x29, #-0x78]
10453bfbc: 900de1c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10453bfc0: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
10453bfc4: d00d10c8    	adrp	x8, 0x11e755000 <dyld_stub_binder+0x11e755000>
10453bfc8: 911ea108    	add	x8, x8, #0x7a8
10453bfcc: a90027e8    	stp	x8, x9, [sp]
10453bfd0: f94037e1    	ldr	x1, [sp, #0x68]
10453bfd4: 52800022    	mov	w2, #0x1                ; =1
10453bfd8: d2800003    	mov	x3, #0x0                ; =0
10453bfdc: 52800004    	mov	w4, #0x0                ; =0
10453bfe0: f00b91a5    	adrp	x5, 0x11b772000 <dyld_stub_binder+0x11b772000>
10453bfe4: 910dd4a5    	add	x5, x5, #0x375
10453bfe8: 52802a86    	mov	w6, #0x154              ; =340
10453bfec: f00b91a7    	adrp	x7, 0x11b772000 <dyld_stub_binder+0x11b772000>
10453bff0: 91195ce7    	add	x7, x7, #0x657
10453bff4: 94dbac52    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453bff8: 6b18039f    	cmp	w28, w24
10453bffc: 1a9f37e8    	cset	w8, hs
10453c000: b81843a8    	stur	w8, [x29, #-0x7c]
10453c004: aa1403e0    	mov	x0, x20
10453c008: f94033e1    	ldr	x1, [sp, #0x60]
10453c00c: 94dbac4c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c010: b90083e0    	str	w0, [sp, #0x80]
10453c014: aa1403e0    	mov	x0, x20
10453c018: f9402fe1    	ldr	x1, [sp, #0x58]
10453c01c: 94dbac48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c020: aa0003f9    	mov	x25, x0
10453c024: aa1403e0    	mov	x0, x20
10453c028: f9402be1    	ldr	x1, [sp, #0x50]
10453c02c: 94dbac44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c030: aa0003fb    	mov	x27, x0
10453c034: aa1403e0    	mov	x0, x20
10453c038: aa1603e1    	mov	x1, x22
10453c03c: 94dbac40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c040: aa0003f3    	mov	x19, x0
10453c044: aa1403e0    	mov	x0, x20
10453c048: f94027e1    	ldr	x1, [sp, #0x48]
10453c04c: 94dbac3c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c050: aa0003f7    	mov	x23, x0
10453c054: aa1403e0    	mov	x0, x20
10453c058: f94023e1    	ldr	x1, [sp, #0x40]
10453c05c: 94dbac38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c060: aa1d03fd    	mov	x29, x29
10453c064: 94dbac39    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10453c068: aa1403f5    	mov	x21, x20
10453c06c: aa1603f4    	mov	x20, x22
10453c070: aa0003f6    	mov	x22, x0
10453c074: f9403fe2    	ldr	x2, [sp, #0x78]
10453c078: a9018be0    	stp	x0, x2, [sp, #0x18]
10453c07c: 2901dff3    	stp	w19, w23, [sp, #0xc]
10453c080: b9000bff    	str	wzr, [sp, #0x8]
10453c084: b85843a8    	ldur	w8, [x29, #-0x7c]
10453c088: 290023fb    	stp	w27, w8, [sp]
10453c08c: f9403be0    	ldr	x0, [sp, #0x70]
10453c090: f9401fe1    	ldr	x1, [sp, #0x38]
10453c094: b94083e3    	ldr	w3, [sp, #0x80]
10453c098: aa1903e4    	mov	x4, x25
10453c09c: aa1a03e5    	mov	x5, x26
10453c0a0: b85943a6    	ldur	w6, [x29, #-0x6c]
10453c0a4: f85883a7    	ldur	x7, [x29, #-0x78]
10453c0a8: 94dbac25    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c0ac: aa1603e0    	mov	x0, x22
10453c0b0: aa1403f6    	mov	x22, x20
10453c0b4: aa1503f4    	mov	x20, x21
10453c0b8: 94dbac27    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10453c0bc: aa1c03fa    	mov	x26, x28
10453c0c0: 6b18039f    	cmp	w28, w24
10453c0c4: 54fff4c3    	b.lo	0x10453bf5c <_Flutter_MMFoundation_BindContext+0xa17b40>
10453c0c8: 14000012    	b	0x10453c110 <_Flutter_MMFoundation_BindContext+0xa17cf4>
10453c0cc: f00de1a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10453c0d0: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
10453c0d4: b00dc7e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10453c0d8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10453c0dc: b00d10c8    	adrp	x8, 0x11e755000 <dyld_stub_binder+0x11e755000>
10453c0e0: 911e2108    	add	x8, x8, #0x788
10453c0e4: f90003e8    	str	x8, [sp]
10453c0e8: b00b6743    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
10453c0ec: 9107f063    	add	x3, x3, #0x1fc
10453c0f0: d00b91a5    	adrp	x5, 0x11b772000 <dyld_stub_binder+0x11b772000>
10453c0f4: 910dd4a5    	add	x5, x5, #0x375
10453c0f8: d00b91a7    	adrp	x7, 0x11b772000 <dyld_stub_binder+0x11b772000>
10453c0fc: 91195ce7    	add	x7, x7, #0x657
10453c100: 52800082    	mov	w2, #0x4                ; =4
10453c104: 52800004    	mov	w4, #0x0                ; =0
10453c108: 528028a6    	mov	w6, #0x145              ; =325
10453c10c: 94dbac0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10453c110: d101a3a0    	sub	x0, x29, #0x68
10453c114: 94db4488    	bl	0x107c0d334 <_Flutter_MMFoundation_BindContext+0x40e8f18>
10453c118: aa1403e0    	mov	x0, x20
10453c11c: 94dbac0e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10453c120: f9403fe0    	ldr	x0, [sp, #0x78]
10453c124: 94dbac0c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10453c128: a9507bfd    	ldp	x29, x30, [sp, #0x100]
10453c12c: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
10453c130: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
10453c134: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
10453c138: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
10453c13c: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
10453c140: 910443ff    	add	sp, sp, #0x110
10453c144: d65f03c0    	ret