
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c33c00: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
101c33c04: a9015ff8    	stp	x24, x23, [sp, #0x10]
101c33c08: a90257f6    	stp	x22, x21, [sp, #0x20]
101c33c0c: a9034ff4    	stp	x20, x19, [sp, #0x30]
101c33c10: a9047bfd    	stp	x29, x30, [sp, #0x40]
101c33c14: 910103fd    	add	x29, sp, #0x40
101c33c18: aa0203f3    	mov	x19, x2
101c33c1c: aa0003f4    	mov	x20, x0
101c33c20: 900f8008    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c33c24: 52800029    	mov	w9, #0x1                ; =1
101c33c28: 3925ed09    	strb	w9, [x8, #0x97b]
101c33c2c: aa0203e0    	mov	x0, x2
101c33c30: 957fcd42    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c33c34: b00f2e08    	adrp	x8, 0x1201f4000 <dyld_stub_binder+0x1201f4000>
101c33c38: b9892519    	ldrsw	x25, [x8, #0x924]
101c33c3c: 8b190280    	add	x0, x20, x25
101c33c40: 957fcd53    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c33c44: f00f269a    	adrp	x26, 0x120106000 <dyld_stub_binder+0x120106000>
101c33c48: b40003c0    	cbz	x0, 0x101c33cc0 <_Flutter_Image_provideRelativePathByUrl+0x40b70>
101c33c4c: aa0003f5    	mov	x21, x0
101c33c50: 8b190280    	add	x0, x20, x25
101c33c54: 957fcd4e    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c33c58: aa0003f6    	mov	x22, x0
101c33c5c: b00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33c60: f9472917    	ldr	x23, [x8, #0xe50] ; OnForwardMessageNeedCancelConfirm:
101c33c64: f9436341    	ldr	x1, [x26, #0x6c0] ; respondsToSelector:
101c33c68: aa1703e2    	mov	x2, x23
101c33c6c: 957fcd34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33c70: 36000200    	tbz	w0, #0x0, 0x101c33cb0 <_Flutter_Image_provideRelativePathByUrl+0x40b60>
101c33c74: 8b190280    	add	x0, x20, x25
101c33c78: 957fcd45    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c33c7c: aa0003f8    	mov	x24, x0
101c33c80: aa1703e1    	mov	x1, x23
101c33c84: aa1403e2    	mov	x2, x20
101c33c88: 957fcd2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33c8c: aa0003f7    	mov	x23, x0
101c33c90: aa1803e0    	mov	x0, x24
101c33c94: 957fcd30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33c98: aa1603e0    	mov	x0, x22
101c33c9c: 957fcd2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33ca0: aa1503e0    	mov	x0, x21
101c33ca4: 957fcd2c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33ca8: 360000d7    	tbz	w23, #0x0, 0x101c33cc0 <_Flutter_Image_provideRelativePathByUrl+0x40b70>
101c33cac: 14000057    	b	0x101c33e08 <_Flutter_Image_provideRelativePathByUrl+0x40cb8>
101c33cb0: aa1603e0    	mov	x0, x22
101c33cb4: 957fcd28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33cb8: aa1503e0    	mov	x0, x21
101c33cbc: 957fcd26    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33cc0: b00f2668    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c33cc4: f9435101    	ldr	x1, [x8, #0x6a0] ; count
101c33cc8: aa1303e0    	mov	x0, x19
101c33ccc: 957fcd1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33cd0: f100041f    	cmp	x0, #0x1
101c33cd4: 540005c1    	b.ne	0x101c33d8c <_Flutter_Image_provideRelativePathByUrl+0x40c3c>
101c33cd8: b00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33cdc: f9458501    	ldr	x1, [x8, #0xb08] ; isYuanBaoBotForwardSwitchOn
101c33ce0: aa1403e0    	mov	x0, x20
101c33ce4: 957fcd16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33ce8: 34000520    	cbz	w0, 0x101c33d8c <_Flutter_Image_provideRelativePathByUrl+0x40c3c>
101c33cec: d00f2668    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
101c33cf0: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
101c33cf4: aa1303e0    	mov	x0, x19
101c33cf8: 957fcd11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33cfc: aa1d03fd    	mov	x29, x29
101c33d00: 957fcd12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c33d04: aa0003f5    	mov	x21, x0
101c33d08: 900f2a08    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c33d0c: f9478100    	ldr	x0, [x8, #0xf00] ;  /, 
101c33d10: 900f2668    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c33d14: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101c33d18: 957fcd09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33d1c: aa0003e2    	mov	x2, x0
101c33d20: 900f2688    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
101c33d24: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
101c33d28: aa1503e0    	mov	x0, x21
101c33d2c: 957fcd04    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33d30: 340002a0    	cbz	w0, 0x101c33d84 <_Flutter_Image_provideRelativePathByUrl+0x40c34>
101c33d34: d00f1248    	adrp	x8, 0x11fe7d000 <dyld_stub_binder+0x11fe7d000>
101c33d38: f9416901    	ldr	x1, [x8, #0x2d0] ; isYuanBao
101c33d3c: aa1503e0    	mov	x0, x21
101c33d40: 957fccff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33d44: 34000200    	cbz	w0, 0x101c33d84 <_Flutter_Image_provideRelativePathByUrl+0x40c34>
101c33d48: b00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33d4c: f9458901    	ldr	x1, [x8, #0xb10] ; needShowBotForwardZipAlertForContacts:
101c33d50: aa1403e0    	mov	x0, x20
101c33d54: aa1303e2    	mov	x2, x19
101c33d58: 957fccf9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33d5c: b00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33d60: 912c6108    	add	x8, x8, #0xb18
101c33d64: b00f1449    	adrp	x9, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33d68: 912c8129    	add	x9, x9, #0xb20
101c33d6c: 7100001f    	cmp	w0, #0x0
101c33d70: 9a891108    	csel	x8, x8, x9, ne
101c33d74: f9400101    	ldr	x1, [x8]
101c33d78: aa1403e0    	mov	x0, x20
101c33d7c: aa1303e2    	mov	x2, x19
101c33d80: 1400001f    	b	0x101c33dfc <_Flutter_Image_provideRelativePathByUrl+0x40cac>
101c33d84: aa1503e0    	mov	x0, x21
101c33d88: 957fccf3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33d8c: b00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33d90: f9459501    	ldr	x1, [x8, #0xb28] ; showConfirmView:
101c33d94: aa1403e0    	mov	x0, x20
101c33d98: aa1303e2    	mov	x2, x19
101c33d9c: 957fcce8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33da0: 8b190280    	add	x0, x20, x25
101c33da4: 957fccfa    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c33da8: b4000300    	cbz	x0, 0x101c33e08 <_Flutter_Image_provideRelativePathByUrl+0x40cb8>
101c33dac: aa0003f5    	mov	x21, x0
101c33db0: 8b190280    	add	x0, x20, x25
101c33db4: 957fccf6    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c33db8: aa0003f7    	mov	x23, x0
101c33dbc: b00f1448    	adrp	x8, 0x11febc000 <dyld_stub_binder+0x11febc000>
101c33dc0: f9472d16    	ldr	x22, [x8, #0xe58] ; OnForwardMessageSelectSession:
101c33dc4: f9436341    	ldr	x1, [x26, #0x6c0] ; respondsToSelector:
101c33dc8: aa1603e2    	mov	x2, x22
101c33dcc: 957fccdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33dd0: aa0003f8    	mov	x24, x0
101c33dd4: aa1703e0    	mov	x0, x23
101c33dd8: 957fccdf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33ddc: aa1503e0    	mov	x0, x21
101c33de0: 957fccdd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33de4: 34000138    	cbz	w24, 0x101c33e08 <_Flutter_Image_provideRelativePathByUrl+0x40cb8>
101c33de8: 8b190280    	add	x0, x20, x25
101c33dec: 957fcce8    	bl	0x107c2718c <_Flutter_MMFoundation_BindContext+0x4102d70>
101c33df0: aa0003f5    	mov	x21, x0
101c33df4: aa1603e1    	mov	x1, x22
101c33df8: aa1403e2    	mov	x2, x20
101c33dfc: 957fccd0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c33e00: aa1503e0    	mov	x0, x21
101c33e04: 957fccd4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c33e08: aa1303e0    	mov	x0, x19
101c33e0c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
101c33e10: a9434ff4    	ldp	x20, x19, [sp, #0x30]
101c33e14: a94257f6    	ldp	x22, x21, [sp, #0x20]
101c33e18: a9415ff8    	ldp	x24, x23, [sp, #0x10]
101c33e1c: a8c567fa    	ldp	x26, x25, [sp], #0x50
101c33e20: 157fcccd    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>