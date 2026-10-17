
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10017be18: d10203ff    	sub	sp, sp, #0x80
10017be1c: a9026ffc    	stp	x28, x27, [sp, #0x20]
10017be20: a90367fa    	stp	x26, x25, [sp, #0x30]
10017be24: a9045ff8    	stp	x24, x23, [sp, #0x40]
10017be28: a90557f6    	stp	x22, x21, [sp, #0x50]
10017be2c: a9064ff4    	stp	x20, x19, [sp, #0x60]
10017be30: a9077bfd    	stp	x29, x30, [sp, #0x70]
10017be34: 9101c3fd    	add	x29, sp, #0x70
10017be38: aa0203f3    	mov	x19, x2
10017be3c: aa0003f4    	mov	x20, x0
10017be40: d0105588    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
10017be44: 52800029    	mov	w9, #0x1                ; =1
10017be48: 391f2909    	strb	w9, [x8, #0x7ca]
10017be4c: aa0203e0    	mov	x0, x2
10017be50: 95eaacba    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10017be54: d00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017be58: f9469d15    	ldr	x21, [x8, #0xd38] ; audioid
10017be5c: aa1303e0    	mov	x0, x19
10017be60: aa1503e1    	mov	x1, x21
10017be64: 95eaacb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017be68: aa0003e2    	mov	x2, x0
10017be6c: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017be70: f9460d01    	ldr	x1, [x8, #0xc18] ; notifyOnEndRecording:
10017be74: aa1403e0    	mov	x0, x20
10017be78: 95eaacb1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017be7c: d00fffc8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
10017be80: f9429d00    	ldr	x0, [x8, #0x538]
10017be84: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017be88: f9461101    	ldr	x1, [x8, #0xc20] ; reportStartRecordCost:
10017be8c: aa1303e2    	mov	x2, x19
10017be90: 95eaacab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017be94: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017be98: f944c116    	ldr	x22, [x8, #0x980] ; transcacheLogic
10017be9c: aa1403e0    	mov	x0, x20
10017bea0: aa1603e1    	mov	x1, x22
10017bea4: 95eaaca6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bea8: aa1d03fd    	mov	x29, x29
10017beac: 95eaaca7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017beb0: aa0003f7    	mov	x23, x0
10017beb4: 95eaaca8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017beb8: b4000c57    	cbz	x23, 0x10017c040 <__text+0x174040>
10017bebc: d00fe628    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
10017bec0: f944b101    	ldr	x1, [x8, #0x960] ; chatname
10017bec4: aa1303e0    	mov	x0, x19
10017bec8: 95eaac9d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017becc: aa1d03fd    	mov	x29, x29
10017bed0: 95eaac9e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017bed4: aa0003f7    	mov	x23, x0
10017bed8: aa1403e0    	mov	x0, x20
10017bedc: aa1603e1    	mov	x1, x22
10017bee0: 95eaac97    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bee4: aa1d03fd    	mov	x29, x29
10017bee8: 95eaac98    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017beec: aa0003f8    	mov	x24, x0
10017bef0: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017bef4: f9461501    	ldr	x1, [x8, #0xc28] ; nsChatName
10017bef8: 95eaac91    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017befc: aa1d03fd    	mov	x29, x29
10017bf00: 95eaac92    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017bf04: aa0003fa    	mov	x26, x0
10017bf08: 900ffc48    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10017bf0c: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10017bf10: aa1703e0    	mov	x0, x23
10017bf14: aa1a03e2    	mov	x2, x26
10017bf18: 95eaac89    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bf1c: 36000400    	tbz	w0, #0x0, 0x10017bf9c <__text+0x173f9c>
10017bf20: aa1303e0    	mov	x0, x19
10017bf24: aa1503e1    	mov	x1, x21
10017bf28: 95eaac85    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bf2c: b9001fe0    	str	w0, [sp, #0x1c]
10017bf30: aa1403e0    	mov	x0, x20
10017bf34: aa1603e1    	mov	x1, x22
10017bf38: 95eaac81    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bf3c: aa1d03fd    	mov	x29, x29
10017bf40: 95eaac82    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017bf44: aa0003fc    	mov	x28, x0
10017bf48: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017bf4c: f9461919    	ldr	x25, [x8, #0xc30] ; audioId
10017bf50: aa1903e1    	mov	x1, x25
10017bf54: 95eaac7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bf58: aa0003fb    	mov	x27, x0
10017bf5c: aa1c03e0    	mov	x0, x28
10017bf60: 95eaac7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bf64: aa1a03e0    	mov	x0, x26
10017bf68: 95eaac7b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bf6c: aa1803e0    	mov	x0, x24
10017bf70: 95eaac79    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bf74: aa1703e0    	mov	x0, x23
10017bf78: 95eaac77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bf7c: b9401fe8    	ldr	w8, [sp, #0x1c]
10017bf80: 6b1b011f    	cmp	w8, w27
10017bf84: 540001c1    	b.ne	0x10017bfbc <__text+0x173fbc>
10017bf88: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017bf8c: f945fd01    	ldr	x1, [x8, #0xbf8] ; cleanTranscacheLogic
10017bf90: aa1403e0    	mov	x0, x20
10017bf94: 95eaac6a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bf98: 1400002a    	b	0x10017c040 <__text+0x174040>
10017bf9c: aa1a03e0    	mov	x0, x26
10017bfa0: 95eaac6d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bfa4: aa1803e0    	mov	x0, x24
10017bfa8: 95eaac6b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bfac: aa1703e0    	mov	x0, x23
10017bfb0: 95eaac69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017bfb4: 900fe648    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
10017bfb8: f9461919    	ldr	x25, [x8, #0xc30] ; audioId
10017bfbc: 900fffc8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10017bfc0: f9453517    	ldr	x23, [x8, #0xa68]
10017bfc4: aa1303e0    	mov	x0, x19
10017bfc8: aa1503e1    	mov	x1, x21
10017bfcc: 95eaac5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bfd0: aa0003f5    	mov	x21, x0
10017bfd4: aa1403e0    	mov	x0, x20
10017bfd8: aa1603e1    	mov	x1, x22
10017bfdc: 95eaac58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bfe0: aa1d03fd    	mov	x29, x29
10017bfe4: 95eaac59    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10017bfe8: aa0003f4    	mov	x20, x0
10017bfec: aa1903e1    	mov	x1, x25
10017bff0: 95eaac53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017bff4: d00fe5e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10017bff8: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10017bffc: a90083f5    	stp	x21, x0, [sp, #0x8]
10017c000: d00f1988    	adrp	x8, 0x11e4ae000 <dyld_stub_binder+0x11e4ae000>
10017c004: 910d2108    	add	x8, x8, #0x348
10017c008: f90003e8    	str	x8, [sp]
10017c00c: d00d8583    	adrp	x3, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017c010: 911fe463    	add	x3, x3, #0x7f9
10017c014: d00d8585    	adrp	x5, 0x11b22e000 <dyld_stub_binder+0x11b22e000>
10017c018: 912014a5    	add	x5, x5, #0x805
10017c01c: f00d8587    	adrp	x7, 0x11b22f000 <dyld_stub_binder+0x11b22f000>
10017c020: 910854e7    	add	x7, x7, #0x215
10017c024: aa1703e0    	mov	x0, x23
10017c028: 52800082    	mov	w2, #0x4                ; =4
10017c02c: 52800004    	mov	w4, #0x0                ; =0
10017c030: 528088c6    	mov	w6, #0x446              ; =1094
10017c034: 95eaac42    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10017c038: aa1403e0    	mov	x0, x20
10017c03c: 95eaac46    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10017c040: aa1303e0    	mov	x0, x19
10017c044: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10017c048: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10017c04c: a94557f6    	ldp	x22, x21, [sp, #0x50]
10017c050: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10017c054: a94367fa    	ldp	x26, x25, [sp, #0x30]
10017c058: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10017c05c: 910203ff    	add	sp, sp, #0x80
10017c060: 15eaac3d    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
