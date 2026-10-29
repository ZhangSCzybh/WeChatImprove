
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10700ce7c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
10700ce80: a9015ff8    	stp	x24, x23, [sp, #0x10]
10700ce84: a90257f6    	stp	x22, x21, [sp, #0x20]
10700ce88: a9034ff4    	stp	x20, x19, [sp, #0x30]
10700ce8c: a9047bfd    	stp	x29, x30, [sp, #0x40]
10700ce90: 910103fd    	add	x29, sp, #0x40
10700ce94: d00ce1c8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
10700ce98: 52800029    	mov	w9, #0x1                ; =1
10700ce9c: 392fdd09    	strb	w9, [x8, #0xbf7]
10700cea0: b00c8b59    	adrp	x25, 0x120175000 <dyld_stub_binder+0x120175000>
10700cea4: f9418320    	ldr	x0, [x25, #0x300] ; class WCDeepLinkHandler
10700cea8: d00c7fa8    	adrp	x8, 0x120002000 <dyld_stub_binder+0x120002000>
10700ceac: f9442901    	ldr	x1, [x8, #0x850] ; selector getDeepLinkNameFromUrl:
10700ceb0: 943068a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700ceb4: aa1d03fd    	mov	x29, x29
10700ceb8: 943068a4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700cebc: aa0003f3    	mov	x19, x0
10700cec0: b4000ac0    	cbz	x0, 0x10700d018 <_Flutter_MMFoundation_BindContext+0x34e8bfc>
10700cec4: f00c87a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10700cec8: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
10700cecc: aa1303e0    	mov	x0, x19
10700ced0: 9430689b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700ced4: b4000a20    	cbz	x0, 0x10700d018 <_Flutter_MMFoundation_BindContext+0x34e8bfc>
10700ced8: 900c87a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10700cedc: f940f516    	ldr	x22, [x8, #0x1e8] ; selector componentsSeparatedByString:
10700cee0: b00ba4c2    	adrp	x2, 0x11e4a5000 <dyld_stub_binder+0x11e4a5000>
10700cee4: 91182042    	add	x2, x2, #0x608 ; CFString '?'
10700cee8: aa1303e0    	mov	x0, x19
10700ceec: aa1603e1    	mov	x1, x22
10700cef0: 94306893    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cef4: aa1d03fd    	mov	x29, x29
10700cef8: 94306894    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700cefc: aa0003f4    	mov	x20, x0
10700cf00: 900c87a8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10700cf04: f9435117    	ldr	x23, [x8, #0x6a0] ; selector count
10700cf08: aa1703e1    	mov	x1, x23
10700cf0c: 9430688c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cf10: aa0003f5    	mov	x21, x0
10700cf14: b00c87ba    	adrp	x26, 0x120101000 <dyld_stub_binder+0x120101000>
10700cf18: f100081f    	cmp	x0, #0x2
10700cf1c: 54000143    	b.lo	0x10700cf44 <_Flutter_MMFoundation_BindContext+0x34e8b28>
10700cf20: f9452341    	ldr	x1, [x26, #0xa40] ; selector firstObject
10700cf24: aa1403e0    	mov	x0, x20
10700cf28: 94306885    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cf2c: aa1d03fd    	mov	x29, x29
10700cf30: 94306886    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700cf34: aa0003f8    	mov	x24, x0
10700cf38: aa1303e0    	mov	x0, x19
10700cf3c: 94306886    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700cf40: aa1803f3    	mov	x19, x24
10700cf44: d00ba462    	adrp	x2, 0x11e49a000 <dyld_stub_binder+0x11e49a000>
10700cf48: 9127a042    	add	x2, x2, #0x9e8 ; CFString '/'
10700cf4c: aa1303e0    	mov	x0, x19
10700cf50: aa1603e1    	mov	x1, x22
10700cf54: 9430687a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cf58: aa1d03fd    	mov	x29, x29
10700cf5c: 9430687b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700cf60: aa0003f6    	mov	x22, x0
10700cf64: aa1703e1    	mov	x1, x23
10700cf68: 94306875    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cf6c: aa0003f8    	mov	x24, x0
10700cf70: f100081f    	cmp	x0, #0x2
10700cf74: 54000143    	b.lo	0x10700cf9c <_Flutter_MMFoundation_BindContext+0x34e8b80>
10700cf78: f9452341    	ldr	x1, [x26, #0xa40] ; selector firstObject
10700cf7c: aa1603e0    	mov	x0, x22
10700cf80: 9430686f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cf84: aa1d03fd    	mov	x29, x29
10700cf88: 94306870    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700cf8c: aa0003f7    	mov	x23, x0
10700cf90: aa1303e0    	mov	x0, x19
10700cf94: 94306870    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700cf98: aa1703f3    	mov	x19, x23
10700cf9c: f9418320    	ldr	x0, [x25, #0x300] ; class WCDeepLinkHandler
10700cfa0: d00c7fa8    	adrp	x8, 0x120002000 <dyld_stub_binder+0x120002000>
10700cfa4: f9442d01    	ldr	x1, [x8, #0x858] ; selector deepLinkByName:
10700cfa8: aa1303e2    	mov	x2, x19
10700cfac: 94306864    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cfb0: aa1d03fd    	mov	x29, x29
10700cfb4: 94306865    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10700cfb8: aa0003f7    	mov	x23, x0
10700cfbc: b40001e0    	cbz	x0, 0x10700cff8 <_Flutter_MMFoundation_BindContext+0x34e8bdc>
10700cfc0: 900c71e8    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
10700cfc4: f9414519    	ldr	x25, [x8, #0x288] ; selector flag
10700cfc8: aa1703e0    	mov	x0, x23
10700cfcc: aa1903e1    	mov	x1, x25
10700cfd0: 9430685b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cfd4: f1000b1f    	cmp	x24, #0x2
10700cfd8: 54000043    	b.lo	0x10700cfe0 <_Flutter_MMFoundation_BindContext+0x34e8bc4>
10700cfdc: 360800e0    	tbz	w0, #0x1, 0x10700cff8 <_Flutter_MMFoundation_BindContext+0x34e8bdc>
10700cfe0: aa1703e0    	mov	x0, x23
10700cfe4: aa1903e1    	mov	x1, x25
10700cfe8: 94306855    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10700cfec: f1000abf    	cmp	x21, #0x2
10700cff0: 54000283    	b.lo	0x10700d040 <_Flutter_MMFoundation_BindContext+0x34e8c24>
10700cff4: 37000260    	tbnz	w0, #0x0, 0x10700d040 <_Flutter_MMFoundation_BindContext+0x34e8c24>
10700cff8: d2800015    	mov	x21, #0x0               ; =0
10700cffc: aa1603e0    	mov	x0, x22
10700d000: 94306855    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700d004: aa1403e0    	mov	x0, x20
10700d008: 94306853    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700d00c: aa1703e0    	mov	x0, x23
10700d010: 94306851    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700d014: 14000002    	b	0x10700d01c <_Flutter_MMFoundation_BindContext+0x34e8c00>
10700d018: d2800015    	mov	x21, #0x0               ; =0
10700d01c: aa1303e0    	mov	x0, x19
10700d020: 9430684d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10700d024: aa1503e0    	mov	x0, x21
10700d028: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10700d02c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10700d030: a94257f6    	ldp	x22, x21, [sp, #0x20]
10700d034: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10700d038: a8c567fa    	ldp	x26, x25, [sp], #0x50
10700d03c: 1430684d    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
10700d040: aa1703e0    	mov	x0, x23
10700d044: 9430683d    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10700d048: aa1703f5    	mov	x21, x23
10700d04c: 17ffffec    	b	0x10700cffc <_Flutter_MMFoundation_BindContext+0x34e8be0>
