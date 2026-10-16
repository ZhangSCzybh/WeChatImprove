
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116728b28: d102c3ff    	sub	sp, sp, #0xb0
116728b2c: 6d0533ed    	stp	d13, d12, [sp, #0x50]
116728b30: 6d062beb    	stp	d11, d10, [sp, #0x60]
116728b34: 6d0723e9    	stp	d9, d8, [sp, #0x70]
116728b38: a90857f6    	stp	x22, x21, [sp, #0x80]
116728b3c: a9094ff4    	stp	x20, x19, [sp, #0x90]
116728b40: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
116728b44: 910283fd    	add	x29, sp, #0xa0
116728b48: 1e604068    	fmov	d8, d3
116728b4c: 1e604049    	fmov	d9, d2
116728b50: 1e60402a    	fmov	d10, d1
116728b54: 1e60400b    	fmov	d11, d0
116728b58: aa0003f3    	mov	x19, x0
116728b5c: b004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116728b60: b983a108    	ldrsw	x8, [x8, #0x3a0]
116728b64: 38686808    	ldrb	w8, [x0, x8]
116728b68: 36000788    	tbz	w8, #0x0, 0x116728c58 <_O266DecReleaseOutputPicture+0x349c1a0>
116728b6c: d004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116728b70: f9443914    	ldr	x20, [x8, #0x870]
116728b74: aa1303e0    	mov	x0, x19
116728b78: aa1403e1    	mov	x1, x20
116728b7c: 9470045c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728b80: aa1d03fd    	mov	x29, x29
116728b84: 94700484    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116728b88: aa0003f5    	mov	x21, x0
116728b8c: 94700473    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116728b90: b40003b5    	cbz	x21, 0x116728c04 <_O266DecReleaseOutputPicture+0x349c14c>
116728b94: f004d248    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
116728b98: f9458900    	ldr	x0, [x8, #0xb10]
116728b9c: 9004cee8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
116728ba0: f947a501    	ldr	x1, [x8, #0xf48]
116728ba4: 52800062    	mov	w2, #0x3                ; =3
116728ba8: 94700451    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728bac: aa1d03fd    	mov	x29, x29
116728bb0: 94700479    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116728bb4: aa0003f5    	mov	x21, x0
116728bb8: d004b968    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
116728bbc: f9438501    	ldr	x1, [x8, #0x708]
116728bc0: 9470044b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728bc4: 1e60400c    	fmov	d12, d0
116728bc8: aa1303e0    	mov	x0, x19
116728bcc: aa1403e1    	mov	x1, x20
116728bd0: 94700447    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728bd4: aa1d03fd    	mov	x29, x29
116728bd8: 9470046f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116728bdc: aa0003f4    	mov	x20, x0
116728be0: b004bb08    	adrp	x8, 0x11fe89000 <dyld_stub_binder+0x11fe89000>
116728be4: f9438101    	ldr	x1, [x8, #0x700]
116728be8: 94700441    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728bec: 1e602980    	fadd	d0, d12, d0
116728bf0: 1e602929    	fadd	d9, d9, d0
116728bf4: aa1403e0    	mov	x0, x20
116728bf8: 94700458    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116728bfc: aa1503e0    	mov	x0, x21
116728c00: 94700456    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116728c04: d004d594    	adrp	x20, 0x1201da000 <dyld_stub_binder+0x1201da000>
116728c08: f945c688    	ldr	x8, [x20, #0xb88]
116728c0c: a90123f3    	stp	x19, x8, [sp, #0x10]
116728c10: f004cee8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
116728c14: f9439501    	ldr	x1, [x8, #0x728]
116728c18: 910043e0    	add	x0, sp, #0x10
116728c1c: 1e604160    	fmov	d0, d11
116728c20: 1e604141    	fmov	d1, d10
116728c24: 1e604122    	fmov	d2, d9
116728c28: 1e604103    	fmov	d3, d8
116728c2c: 94700433    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116728c30: f945c688    	ldr	x8, [x20, #0xb88]
116728c34: a90023f3    	stp	x19, x8, [sp]
116728c38: 9004b928    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
116728c3c: f943c501    	ldr	x1, [x8, #0x788]
116728c40: 910003e0    	mov	x0, sp
116728c44: 1e604160    	fmov	d0, d11
116728c48: 1e604141    	fmov	d1, d10
116728c4c: 1e604122    	fmov	d2, d9
116728c50: 1e604103    	fmov	d3, d8
116728c54: 1400002b    	b	0x116728d00 <_O266DecReleaseOutputPicture+0x349c248>
116728c58: b004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116728c5c: b983a508    	ldrsw	x8, [x8, #0x3a4]
116728c60: 38686a68    	ldrb	w8, [x19, x8]
116728c64: 370000c8    	tbnz	w8, #0x0, 0x116728c7c <_O266DecReleaseOutputPicture+0x349c1c4>
116728c68: d004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116728c6c: f9443501    	ldr	x1, [x8, #0x868]
116728c70: aa1303e0    	mov	x0, x19
116728c74: 9470041e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728c78: 34fff7a0    	cbz	w0, 0x116728b6c <_O266DecReleaseOutputPicture+0x349c0b4>
116728c7c: d004d594    	adrp	x20, 0x1201da000 <dyld_stub_binder+0x1201da000>
116728c80: f945c688    	ldr	x8, [x20, #0xb88]
116728c84: a90423f3    	stp	x19, x8, [sp, #0x40]
116728c88: f004b888    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
116728c8c: f945b901    	ldr	x1, [x8, #0xb70]
116728c90: 910103e0    	add	x0, sp, #0x40
116728c94: 94700419    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116728c98: 1e604004    	fmov	d4, d0
116728c9c: 1e604025    	fmov	d5, d1
116728ca0: 1e604046    	fmov	d6, d2
116728ca4: 1e604067    	fmov	d7, d3
116728ca8: 90037635    	adrp	x21, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
116728cac: f940feb5    	ldr	x21, [x21, #0x1f8]
116728cb0: 6d4006a0    	ldp	d0, d1, [x21]
116728cb4: 6d410ea2    	ldp	d2, d3, [x21, #0x10]
116728cb8: 1e6120a0    	fcmp	d5, d1
116728cbc: 1e600480    	fccmp	d4, d0, #0x0, eq
116728cc0: 1e6304e0    	fccmp	d7, d3, #0x0, eq
116728cc4: 1e6204c0    	fccmp	d6, d2, #0x0, eq
116728cc8: 540001e0    	b.eq	0x116728d04 <_O266DecReleaseOutputPicture+0x349c24c>
116728ccc: f945c688    	ldr	x8, [x20, #0xb88]
116728cd0: a90323f3    	stp	x19, x8, [sp, #0x30]
116728cd4: f004cee8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
116728cd8: f9439501    	ldr	x1, [x8, #0x728]
116728cdc: 9100c3e0    	add	x0, sp, #0x30
116728ce0: 94700406    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116728ce4: 6d4006a0    	ldp	d0, d1, [x21]
116728ce8: 6d410ea2    	ldp	d2, d3, [x21, #0x10]
116728cec: f945c688    	ldr	x8, [x20, #0xb88]
116728cf0: a90223f3    	stp	x19, x8, [sp, #0x20]
116728cf4: 9004b928    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
116728cf8: f943c501    	ldr	x1, [x8, #0x788]
116728cfc: 910083e0    	add	x0, sp, #0x20
116728d00: 947003fe    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116728d04: f004b888    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
116728d08: f945a901    	ldr	x1, [x8, #0xb50]
116728d0c: aa1303e0    	mov	x0, x19
116728d10: 947003f7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728d14: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
116728d18: a9494ff4    	ldp	x20, x19, [sp, #0x90]
116728d1c: a94857f6    	ldp	x22, x21, [sp, #0x80]
116728d20: 6d4723e9    	ldp	d9, d8, [sp, #0x70]
116728d24: 6d462beb    	ldp	d11, d10, [sp, #0x60]
116728d28: 6d4533ed    	ldp	d13, d12, [sp, #0x50]
116728d2c: 9102c3ff    	add	sp, sp, #0xb0
116728d30: d65f03c0    	ret
116728d34: d10103ff    	sub	sp, sp, #0x40
116728d38: a9024ff4    	stp	x20, x19, [sp, #0x20]
116728d3c: a9037bfd    	stp	x29, x30, [sp, #0x30]
116728d40: 9100c3fd    	add	x29, sp, #0x30
116728d44: aa0003f3    	mov	x19, x0
116728d48: b004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116728d4c: b983a108    	ldrsw	x8, [x8, #0x3a0]
116728d50: 38686808    	ldrb	w8, [x0, x8]
116728d54: 360000c8    	tbz	w8, #0x0, 0x116728d6c <_O266DecReleaseOutputPicture+0x349c2b4>
116728d58: f90003f3    	str	x19, [sp]
116728d5c: f004b888    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
116728d60: 912dc108    	add	x8, x8, #0xb70
116728d64: 910003e0    	mov	x0, sp
116728d68: 1400000e    	b	0x116728da0 <_O266DecReleaseOutputPicture+0x349c2e8>
116728d6c: b004db48    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116728d70: b983a508    	ldrsw	x8, [x8, #0x3a4]
116728d74: 38686a68    	ldrb	w8, [x19, x8]
116728d78: 370000c8    	tbnz	w8, #0x0, 0x116728d90 <_O266DecReleaseOutputPicture+0x349c2d8>
116728d7c: d004ce28    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116728d80: f9443501    	ldr	x1, [x8, #0x868]
116728d84: aa1303e0    	mov	x0, x19
116728d88: 947003d9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116728d8c: 34fffe60    	cbz	w0, 0x116728d58 <_O266DecReleaseOutputPicture+0x349c2a0>
116728d90: f9000bf3    	str	x19, [sp, #0x10]
116728d94: d004cea8    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
116728d98: 913e0108    	add	x8, x8, #0xf80
116728d9c: 910043e0    	add	x0, sp, #0x10
116728da0: d004d589    	adrp	x9, 0x1201da000 <dyld_stub_binder+0x1201da000>
116728da4: f945c529    	ldr	x9, [x9, #0xb88]
116728da8: f9000409    	str	x9, [x0, #0x8]
116728dac: f9400101    	ldr	x1, [x8]
116728db0: 947003d2    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116728db4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
116728db8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
116728dbc: 910103ff    	add	sp, sp, #0x40
116728dc0: d65f03c0    	ret
