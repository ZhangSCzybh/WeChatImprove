
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116756b14: d10483ff    	sub	sp, sp, #0x120
116756b18: 6d0a2beb    	stp	d11, d10, [sp, #0xa0]
116756b1c: 6d0b23e9    	stp	d9, d8, [sp, #0xb0]
116756b20: a90c6ffc    	stp	x28, x27, [sp, #0xc0]
116756b24: a90d67fa    	stp	x26, x25, [sp, #0xd0]
116756b28: a90e5ff8    	stp	x24, x23, [sp, #0xe0]
116756b2c: a90f57f6    	stp	x22, x21, [sp, #0xf0]
116756b30: a9104ff4    	stp	x20, x19, [sp, #0x100]
116756b34: a9117bfd    	stp	x29, x30, [sp, #0x110]
116756b38: 910443fd    	add	x29, sp, #0x110
116756b3c: aa0403f3    	mov	x19, x4
116756b40: aa0303f8    	mov	x24, x3
116756b44: aa0203f4    	mov	x20, x2
116756b48: aa0003f5    	mov	x21, x0
116756b4c: aa0403e0    	mov	x0, x4
116756b50: 946f4c88    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116756b54: b004b9a8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
116756b58: f9447d01    	ldr	x1, [x8, #0x8f8]
116756b5c: aa1503e0    	mov	x0, x21
116756b60: 946f4c63    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756b64: 34002960    	cbz	w0, 0x116757090 <_O266DecReleaseOutputPicture+0x34ca5d8>
116756b68: b004cd68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
116756b6c: f944fd01    	ldr	x1, [x8, #0x9f8]
116756b70: aa1503e0    	mov	x0, x21
116756b74: 946f4c5e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756b78: 340000e0    	cbz	w0, 0x116756b94 <_O266DecReleaseOutputPicture+0x34ca0dc>
116756b7c: f004cd88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116756b80: f9445101    	ldr	x1, [x8, #0x8a0]
116756b84: aa1503e0    	mov	x0, x21
116756b88: 52800002    	mov	w2, #0x0                ; =0
116756b8c: 52800003    	mov	w3, #0x0                ; =0
116756b90: 946f4c57    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756b94: f004d9d6    	adrp	x22, 0x120291000 <dyld_stub_binder+0x120291000>
116756b98: 360000f4    	tbz	w20, #0x0, 0x116756bb4 <_O266DecReleaseOutputPicture+0x34ca0fc>
116756b9c: 340003f8    	cbz	w24, 0x116756c18 <_O266DecReleaseOutputPicture+0x34ca160>
116756ba0: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756ba4: b9877908    	ldrsw	x8, [x8, #0x778]
116756ba8: 52800029    	mov	w9, #0x1                ; =1
116756bac: 38286aa9    	strb	w9, [x21, x8]
116756bb0: 1400001a    	b	0x116756c18 <_O266DecReleaseOutputPicture+0x34ca160>
116756bb4: b9874ec8    	ldrsw	x8, [x22, #0x74c]
116756bb8: f8686aa0    	ldr	x0, [x21, x8]
116756bbc: d004cd88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116756bc0: f9411101    	ldr	x1, [x8, #0x220]
116756bc4: 52800002    	mov	w2, #0x0                ; =0
116756bc8: 946f4c49    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756bcc: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116756bd0: f9475d01    	ldr	x1, [x8, #0xeb8]
116756bd4: aa1503e0    	mov	x0, x21
116756bd8: 946f4c45    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756bdc: 340001e0    	cbz	w0, 0x116756c18 <_O266DecReleaseOutputPicture+0x34ca160>
116756be0: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756be4: b9875517    	ldrsw	x23, [x8, #0x754]
116756be8: f8776aa0    	ldr	x0, [x21, x23]
116756bec: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756bf0: b9876d19    	ldrsw	x25, [x8, #0x76c]
116756bf4: f8796aa2    	ldr	x2, [x21, x25]
116756bf8: 9004cd48    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
116756bfc: f9476d01    	ldr	x1, [x8, #0xed8]
116756c00: 946f4c3b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756c04: f8776aa0    	ldr	x0, [x21, x23]
116756c08: f8796aa2    	ldr	x2, [x21, x25]
116756c0c: b004b788    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
116756c10: f946e101    	ldr	x1, [x8, #0xdc0]
116756c14: 946f4c36    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756c18: b9874ed9    	ldrsw	x25, [x22, #0x74c]
116756c1c: f8796aa0    	ldr	x0, [x21, x25]
116756c20: 9004cda8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
116756c24: f9474901    	ldr	x1, [x8, #0xe90]
116756c28: 946f4c31    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756c2c: aa1d03fd    	mov	x29, x29
116756c30: 946f4c59    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756c34: aa0003f6    	mov	x22, x0
116756c38: d004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116756c3c: f9435101    	ldr	x1, [x8, #0x6a0]
116756c40: 946f4c2b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756c44: aa0003f7    	mov	x23, x0
116756c48: aa1603e0    	mov	x0, x22
116756c4c: 946f4c43    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756c50: b50000d7    	cbnz	x23, 0x116756c68 <_O266DecReleaseOutputPicture+0x34ca1b0>
116756c54: 370000b4    	tbnz	w20, #0x0, 0x116756c68 <_O266DecReleaseOutputPicture+0x34ca1b0>
116756c58: b004c528    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
116756c5c: f9442d01    	ldr	x1, [x8, #0x858]
116756c60: aa1503e0    	mov	x0, x21
116756c64: 946f4c22    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756c68: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756c6c: b9875108    	ldrsw	x8, [x8, #0x750]
116756c70: 38286ab4    	strb	w20, [x21, x8]
116756c74: f004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116756c78: b9877d08    	ldrsw	x8, [x8, #0x77c]
116756c7c: b8686aa9    	ldr	w9, [x21, x8]
116756c80: 11000537    	add	w23, w9, #0x1
116756c84: b8286ab7    	str	w23, [x21, x8]
116756c88: 9e6703ea    	fmov	d10, xzr
116756c8c: 370000d4    	tbnz	w20, #0x0, 0x116756ca4 <_O266DecReleaseOutputPicture+0x34ca1ec>
116756c90: f004bea8    	adrp	x8, 0x11ff2d000 <dyld_stub_binder+0x11ff2d000>
116756c94: f9458901    	ldr	x1, [x8, #0xb10]
116756c98: aa1503e0    	mov	x0, x21
116756c9c: 946f4c14    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756ca0: 1e61400a    	fneg	d10, d0
116756ca4: b004cd48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
116756ca8: f943d516    	ldr	x22, [x8, #0x7a8]
116756cac: aa1503e0    	mov	x0, x21
116756cb0: aa1603e1    	mov	x1, x22
116756cb4: 946f4c0e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756cb8: 946f29b4    	bl	0x118321388 <dyld_stub_binder+0x118321388>
116756cbc: 1e604008    	fmov	d8, d0
116756cc0: aa1503e0    	mov	x0, x21
116756cc4: aa1603e1    	mov	x1, x22
116756cc8: 946f4c09    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756ccc: 946f299a    	bl	0x118321334 <dyld_stub_binder+0x118321334>
116756cd0: 900374da    	adrp	x26, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
116756cd4: f947e35a    	ldr	x26, [x26, #0xfc0]
116756cd8: f90027fa    	str	x26, [sp, #0x48]
116756cdc: f0013148    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
116756ce0: fd41c109    	ldr	d9, [x8, #0x380]
116756ce4: fd002be9    	str	d9, [sp, #0x50]
116756ce8: b0000008    	adrp	x8, 0x116757000 <_O266DecReleaseOutputPicture+0x34ca548>
116756cec: 91030108    	add	x8, x8, #0xc0
116756cf0: f00377e9    	adrp	x9, 0x11d655000 <dyld_stub_binder+0x11d655000>
116756cf4: 913be129    	add	x9, x9, #0xef8
116756cf8: a905a7e8    	stp	x8, x9, [sp, #0x58]
116756cfc: f90037f5    	str	x21, [sp, #0x68]
116756d00: fd003bea    	str	d10, [sp, #0x70]
116756d04: f9003fff    	str	xzr, [sp, #0x78]
116756d08: 6d0803e8    	stp	d8, d0, [sp, #0x80]
116756d0c: 390243f4    	strb	w20, [sp, #0x90]
116756d10: 910123e0    	add	x0, sp, #0x48
116756d14: 946f4c23    	bl	0x118329da0 <dyld_stub_binder+0x118329da0>
116756d18: aa0003f6    	mov	x22, x0
116756d1c: f9000bfa    	str	x26, [sp, #0x10]
116756d20: b0000008    	adrp	x8, 0x116757000 <_O266DecReleaseOutputPicture+0x34ca548>
116756d24: 91079108    	add	x8, x8, #0x1e4
116756d28: f003e169    	adrp	x9, 0x11e385000 <dyld_stub_binder+0x11e385000>
116756d2c: 91100129    	add	x9, x9, #0x400
116756d30: fd000fe9    	str	d9, [sp, #0x18]
116756d34: a90227e8    	stp	x8, x9, [sp, #0x20]
116756d38: 390113f4    	strb	w20, [sp, #0x44]
116756d3c: f9001bf5    	str	x21, [sp, #0x30]
116756d40: b90043f7    	str	w23, [sp, #0x40]
116756d44: aa1303e0    	mov	x0, x19
116756d48: 946f4c0a    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116756d4c: f9001ff3    	str	x19, [sp, #0x38]
116756d50: 910043e0    	add	x0, sp, #0x10
116756d54: 946f4c13    	bl	0x118329da0 <dyld_stub_binder+0x118329da0>
116756d58: aa0003f7    	mov	x23, x0
116756d5c: 340005f8    	cbz	w24, 0x116756e18 <_O266DecReleaseOutputPicture+0x34ca360>
116756d60: 7100029f    	cmp	w20, #0x0
116756d64: 90013168    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
116756d68: fd40b900    	ldr	d0, [x8, #0x170]
116756d6c: f0013148    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
116756d70: fd43c101    	ldr	d1, [x8, #0x780]
116756d74: 1e601c28    	fcsel	d8, d1, d0, ne
116756d78: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116756d7c: f9476118    	ldr	x24, [x8, #0xec0]
116756d80: aa1503e0    	mov	x0, x21
116756d84: aa1803e1    	mov	x1, x24
116756d88: 946f4bd9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756d8c: 1e602008    	fcmp	d0, #0.0
116756d90: 540000ad    	b.le	0x116756da4 <_O266DecReleaseOutputPicture+0x34ca2ec>
116756d94: aa1503e0    	mov	x0, x21
116756d98: aa1803e1    	mov	x1, x24
116756d9c: 946f4bd4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756da0: 1e604008    	fmov	d8, d0
116756da4: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116756da8: f9476518    	ldr	x24, [x8, #0xec8]
116756dac: aa1503e0    	mov	x0, x21
116756db0: aa1803e1    	mov	x1, x24
116756db4: 946f4bce    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756db8: aa1d03fd    	mov	x29, x29
116756dbc: 946f4bf6    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756dc0: aa0003f9    	mov	x25, x0
116756dc4: 946f4be5    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756dc8: b40004b9    	cbz	x25, 0x116756e5c <_O266DecReleaseOutputPicture+0x34ca3a4>
116756dcc: b004d0e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
116756dd0: f9474d19    	ldr	x25, [x8, #0xe98]
116756dd4: aa1503e0    	mov	x0, x21
116756dd8: aa1803e1    	mov	x1, x24
116756ddc: 946f4bc4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756de0: aa1d03fd    	mov	x29, x29
116756de4: 946f4bec    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756de8: aa0003f8    	mov	x24, x0
116756dec: b004b808    	adrp	x8, 0x11fe57000 <dyld_stub_binder+0x11fe57000>
116756df0: f9462901    	ldr	x1, [x8, #0xc50]
116756df4: aa1903e0    	mov	x0, x25
116756df8: 1e604100    	fmov	d0, d8
116756dfc: aa1803e2    	mov	x2, x24
116756e00: aa1603e3    	mov	x3, x22
116756e04: aa1703e4    	mov	x4, x23
116756e08: 946f4bb9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756e0c: aa1803e0    	mov	x0, x24
116756e10: 946f4bd2    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756e14: 14000035    	b	0x116756ee8 <_O266DecReleaseOutputPicture+0x34ca430>
116756e18: f9400ac8    	ldr	x8, [x22, #0x10]
116756e1c: aa1603e0    	mov	x0, x22
116756e20: d63f0100    	blr	x8
116756e24: f9400ae8    	ldr	x8, [x23, #0x10]
116756e28: aa1703e0    	mov	x0, x23
116756e2c: 52800021    	mov	w1, #0x1                ; =1
116756e30: d63f0100    	blr	x8
116756e34: 340005b4    	cbz	w20, 0x116756ee8 <_O266DecReleaseOutputPicture+0x34ca430>
116756e38: b004c528    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
116756e3c: f9442901    	ldr	x1, [x8, #0x850]
116756e40: aa1503e0    	mov	x0, x21
116756e44: 946f4baa    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756e48: f8796aa0    	ldr	x0, [x21, x25]
116756e4c: 9004cd88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
116756e50: f940f901    	ldr	x1, [x8, #0x1f0]
116756e54: 946f4ba6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756e58: 14000024    	b	0x116756ee8 <_O266DecReleaseOutputPicture+0x34ca430>
116756e5c: 9004d428    	adrp	x8, 0x1201da000 <dyld_stub_binder+0x1201da000>
116756e60: f9462508    	ldr	x8, [x8, #0xc48]
116756e64: a90023f5    	stp	x21, x8, [sp]
116756e68: d004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116756e6c: f9427501    	ldr	x1, [x8, #0x4e8]
116756e70: 910003e0    	mov	x0, sp
116756e74: 946f4ba1    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116756e78: aa1d03fd    	mov	x29, x29
116756e7c: 946f4bc6    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756e80: aa0003f8    	mov	x24, x0
116756e84: d004cda8    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
116756e88: f9402101    	ldr	x1, [x8, #0x40]
116756e8c: 946f4b98    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756e90: 1e604009    	fmov	d9, d0
116756e94: aa1803e0    	mov	x0, x24
116756e98: 946f4bb0    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756e9c: 1e6a2120    	fcmp	d9, d10
116756ea0: 1a9f5688    	csinc	w8, w20, wzr, pl
116756ea4: 7100011f    	cmp	w8, #0x0
116756ea8: 90013168    	adrp	x8, 0x118d82000 <dyld_stub_binder+0x118d82000>
116756eac: fd40f100    	ldr	d0, [x8, #0x1e0]
116756eb0: 1e6e1001    	fmov	d1, #1.00000000
116756eb4: 1e601c22    	fcsel	d2, d1, d0, ne
116756eb8: b004d0e8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
116756ebc: f9474d00    	ldr	x0, [x8, #0xe98]
116756ec0: 9004b8a8    	adrp	x8, 0x11fe6a000 <dyld_stub_binder+0x11fe6a000>
116756ec4: f9435d01    	ldr	x1, [x8, #0x6b8]
116756ec8: 9e6703e1    	fmov	d1, xzr
116756ecc: 9e6703e3    	fmov	d3, xzr
116756ed0: 1e604100    	fmov	d0, d8
116756ed4: 528000c2    	mov	w2, #0x6                ; =6
116756ed8: 72a00042    	movk	w2, #0x2, lsl #16
116756edc: aa1603e3    	mov	x3, x22
116756ee0: aa1703e4    	mov	x4, x23
116756ee4: 946f4b82    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756ee8: d004b988    	adrp	x8, 0x11fe88000 <dyld_stub_binder+0x11fe88000>
116756eec: f947e901    	ldr	x1, [x8, #0xfd0]
116756ef0: aa1503e0    	mov	x0, x21
116756ef4: aa1503e2    	mov	x2, x21
116756ef8: 946f4b7d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756efc: aa1d03fd    	mov	x29, x29
116756f00: 946f4ba5    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756f04: aa0003f8    	mov	x24, x0
116756f08: f004b788    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
116756f0c: f9431101    	ldr	x1, [x8, #0x620]
116756f10: aa1503e2    	mov	x2, x21
116756f14: 946f4b76    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756f18: aa1d03fd    	mov	x29, x29
116756f1c: 946f4b9e    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756f20: aa0003f9    	mov	x25, x0
116756f24: b5000220    	cbnz	x0, 0x116756f68 <_O266DecReleaseOutputPicture+0x34ca4b0>
116756f28: 9004ba28    	adrp	x8, 0x11fe9a000 <dyld_stub_binder+0x11fe9a000>
116756f2c: f9426519    	ldr	x25, [x8, #0x4c8]
116756f30: aa1503e0    	mov	x0, x21
116756f34: aa1903e1    	mov	x1, x25
116756f38: 946f4b6d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756f3c: aa1d03fd    	mov	x29, x29
116756f40: 946f4b95    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756f44: aa0003fa    	mov	x26, x0
116756f48: 946f4b84    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756f4c: b40008ba    	cbz	x26, 0x116757060 <_O266DecReleaseOutputPicture+0x34ca5a8>
116756f50: aa1503e0    	mov	x0, x21
116756f54: aa1903e1    	mov	x1, x25
116756f58: 946f4b65    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756f5c: aa1d03fd    	mov	x29, x29
116756f60: 946f4b8d    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756f64: aa0003f9    	mov	x25, x0
116756f68: b4000818    	cbz	x24, 0x116757068 <_O266DecReleaseOutputPicture+0x34ca5b0>
116756f6c: d004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116756f70: f946f115    	ldr	x21, [x8, #0xde0]
116756f74: aa1803e0    	mov	x0, x24
116756f78: aa1503e1    	mov	x1, x21
116756f7c: 946f4b5c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756f80: aa1d03fd    	mov	x29, x29
116756f84: 946f4b84    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756f88: aa0003fa    	mov	x26, x0
116756f8c: 340002b4    	cbz	w20, 0x116756fe0 <_O266DecReleaseOutputPicture+0x34ca528>
116756f90: b40006da    	cbz	x26, 0x116757068 <_O266DecReleaseOutputPicture+0x34ca5b0>
116756f94: aa1803e0    	mov	x0, x24
116756f98: aa1503e1    	mov	x1, x21
116756f9c: 946f4b54    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756fa0: aa1d03fd    	mov	x29, x29
116756fa4: 946f4b7c    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756fa8: aa0003fb    	mov	x27, x0
116756fac: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116756fb0: f9476914    	ldr	x20, [x8, #0xed0]
116756fb4: 9004cd88    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
116756fb8: f9436101    	ldr	x1, [x8, #0x6c0]
116756fbc: aa1403e2    	mov	x2, x20
116756fc0: 946f4b4b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756fc4: aa0003fc    	mov	x28, x0
116756fc8: aa1b03e0    	mov	x0, x27
116756fcc: 946f4b63    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756fd0: aa1a03e0    	mov	x0, x26
116756fd4: 946f4b61    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116756fd8: 370002bc    	tbnz	w28, #0x0, 0x11675702c <_O266DecReleaseOutputPicture+0x34ca574>
116756fdc: 14000023    	b	0x116757068 <_O266DecReleaseOutputPicture+0x34ca5b0>
116756fe0: b400045a    	cbz	x26, 0x116757068 <_O266DecReleaseOutputPicture+0x34ca5b0>
116756fe4: aa1803e0    	mov	x0, x24
116756fe8: aa1503e1    	mov	x1, x21
116756fec: 946f4b40    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116756ff0: aa1d03fd    	mov	x29, x29
116756ff4: 946f4b68    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116756ff8: aa0003fb    	mov	x27, x0
116756ffc: 9004ccc8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757000: f9476d14    	ldr	x20, [x8, #0xed8]
116757004: f004cd68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
116757008: f9436101    	ldr	x1, [x8, #0x6c0]
11675700c: aa1403e2    	mov	x2, x20
116757010: 946f4b37    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757014: aa0003fc    	mov	x28, x0
116757018: aa1b03e0    	mov	x0, x27
11675701c: 946f4b4f    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757020: aa1a03e0    	mov	x0, x26
116757024: 946f4b4d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757028: 3400021c    	cbz	w28, 0x116757068 <_O266DecReleaseOutputPicture+0x34ca5b0>
11675702c: aa1803e0    	mov	x0, x24
116757030: aa1503e1    	mov	x1, x21
116757034: 946f4b2e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757038: aa1d03fd    	mov	x29, x29
11675703c: 946f4b56    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757040: aa0003f5    	mov	x21, x0
116757044: aa1403e1    	mov	x1, x20
116757048: aa1803e2    	mov	x2, x24
11675704c: aa1903e3    	mov	x3, x25
116757050: 946f4b27    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757054: aa1503e0    	mov	x0, x21
116757058: 946f4b40    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11675705c: 14000003    	b	0x116757068 <_O266DecReleaseOutputPicture+0x34ca5b0>
116757060: d2800019    	mov	x25, #0x0               ; =0
116757064: b5fff858    	cbnz	x24, 0x116756f6c <_O266DecReleaseOutputPicture+0x34ca4b4>
116757068: aa1903e0    	mov	x0, x25
11675706c: 946f4b3b    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757070: aa1803e0    	mov	x0, x24
116757074: 946f4b39    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757078: aa1703e0    	mov	x0, x23
11675707c: 946f4b37    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757080: f9401fe0    	ldr	x0, [sp, #0x38]
116757084: 946f4b35    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757088: aa1603e0    	mov	x0, x22
11675708c: 946f4b33    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757090: aa1303e0    	mov	x0, x19
116757094: 946f4b31    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757098: a9517bfd    	ldp	x29, x30, [sp, #0x110]
11675709c: a9504ff4    	ldp	x20, x19, [sp, #0x100]
1167570a0: a94f57f6    	ldp	x22, x21, [sp, #0xf0]
1167570a4: a94e5ff8    	ldp	x24, x23, [sp, #0xe0]
1167570a8: a94d67fa    	ldp	x26, x25, [sp, #0xd0]
1167570ac: a94c6ffc    	ldp	x28, x27, [sp, #0xc0]
1167570b0: 6d4b23e9    	ldp	d9, d8, [sp, #0xb0]
1167570b4: 6d4a2beb    	ldp	d11, d10, [sp, #0xa0]
1167570b8: 910483ff    	add	sp, sp, #0x120
1167570bc: d65f03c0    	ret
1167570c0: d101c3ff    	sub	sp, sp, #0x70
1167570c4: 6d022beb    	stp	d11, d10, [sp, #0x20]
1167570c8: 6d0323e9    	stp	d9, d8, [sp, #0x30]
1167570cc: a90457f6    	stp	x22, x21, [sp, #0x40]
1167570d0: a9054ff4    	stp	x20, x19, [sp, #0x50]
1167570d4: a9067bfd    	stp	x29, x30, [sp, #0x60]
1167570d8: 910183fd    	add	x29, sp, #0x60
1167570dc: aa0003f3    	mov	x19, x0
1167570e0: 6d42a408    	ldp	d8, d9, [x0, #0x28]
1167570e4: 6d43ac0a    	ldp	d10, d11, [x0, #0x38]
1167570e8: f9401008    	ldr	x8, [x0, #0x20]
1167570ec: f004d416    	adrp	x22, 0x1201da000 <dyld_stub_binder+0x1201da000>
1167570f0: f94626c9    	ldr	x9, [x22, #0xc48]
1167570f4: a90127e8    	stp	x8, x9, [sp, #0x10]
1167570f8: b004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1167570fc: f9427514    	ldr	x20, [x8, #0x4e8]
116757100: 910043e0    	add	x0, sp, #0x10
116757104: aa1403e1    	mov	x1, x20
116757108: 946f4afc    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
11675710c: aa1d03fd    	mov	x29, x29
116757110: 946f4b21    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757114: aa0003f5    	mov	x21, x0
116757118: b004cd88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
11675711c: f9403501    	ldr	x1, [x8, #0x68]
116757120: 1e604100    	fmov	d0, d8
116757124: 1e604121    	fmov	d1, d9
116757128: 1e604142    	fmov	d2, d10
11675712c: 1e604163    	fmov	d3, d11
116757130: 946f4aef    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757134: aa1503e0    	mov	x0, x21
116757138: 946f4b08    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11675713c: f9401275    	ldr	x21, [x19, #0x20]
116757140: f94626c8    	ldr	x8, [x22, #0xc48]
116757144: a90023f5    	stp	x21, x8, [sp]
116757148: 910003e0    	mov	x0, sp
11675714c: aa1403e1    	mov	x1, x20
116757150: 946f4aea    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116757154: aa1d03fd    	mov	x29, x29
116757158: 946f4b0f    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
11675715c: aa0003f4    	mov	x20, x0
116757160: b004cda8    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
116757164: f9402101    	ldr	x1, [x8, #0x40]
116757168: 946f4ae1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675716c: 1e604008    	fmov	d8, d0
116757170: f9401268    	ldr	x8, [x19, #0x20]
116757174: d004d9c9    	adrp	x9, 0x120291000 <dyld_stub_binder+0x120291000>
116757178: b9874d29    	ldrsw	x9, [x9, #0x74c]
11675717c: f8696900    	ldr	x0, [x8, x9]
116757180: 9004cda8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116757184: f947a501    	ldr	x1, [x8, #0xf48]
116757188: 946f4ad9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675718c: 1e604001    	fmov	d1, d0
116757190: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757194: f9474101    	ldr	x1, [x8, #0xe80]
116757198: aa1503e0    	mov	x0, x21
11675719c: 1e604100    	fmov	d0, d8
1167571a0: 946f4ad3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167571a4: aa1403e0    	mov	x0, x20
1167571a8: 946f4aec    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167571ac: f9401260    	ldr	x0, [x19, #0x20]
1167571b0: 39412268    	ldrb	w8, [x19, #0x48]
1167571b4: b004cc89    	adrp	x9, 0x1200e8000 <dyld_stub_binder+0x1200e8000>
1167571b8: f9410121    	ldr	x1, [x9, #0x200]
1167571bc: 52800029    	mov	w9, #0x1                ; =1
1167571c0: 0a280122    	bic	w2, w9, w8
1167571c4: 946f4aca    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167571c8: a9467bfd    	ldp	x29, x30, [sp, #0x60]
1167571cc: a9454ff4    	ldp	x20, x19, [sp, #0x50]
1167571d0: a94457f6    	ldp	x22, x21, [sp, #0x40]
1167571d4: 6d4323e9    	ldp	d9, d8, [sp, #0x30]
1167571d8: 6d422beb    	ldp	d11, d10, [sp, #0x20]
1167571dc: 9101c3ff    	add	sp, sp, #0x70
1167571e0: d65f03c0    	ret
1167571e4: d100c3ff    	sub	sp, sp, #0x30
1167571e8: a9014ff4    	stp	x20, x19, [sp, #0x10]
1167571ec: a9027bfd    	stp	x29, x30, [sp, #0x20]
1167571f0: 910083fd    	add	x29, sp, #0x20
1167571f4: aa0103f4    	mov	x20, x1
1167571f8: aa0003f3    	mov	x19, x0
1167571fc: 3940d008    	ldrb	w8, [x0, #0x34]
116757200: 7100051f    	cmp	w8, #0x1
116757204: 540001c1    	b.ne	0x11675723c <_O266DecReleaseOutputPicture+0x34ca784>
116757208: f9401268    	ldr	x8, [x19, #0x20]
11675720c: d004d9c9    	adrp	x9, 0x120291000 <dyld_stub_binder+0x120291000>
116757210: b9877529    	ldrsw	x9, [x9, #0x774]
116757214: f8696909    	ldr	x9, [x8, x9]
116757218: d004d9ca    	adrp	x10, 0x120291000 <dyld_stub_binder+0x120291000>
11675721c: b987494a    	ldrsw	x10, [x10, #0x748]
116757220: f86a690a    	ldr	x10, [x8, x10]
116757224: eb0a013f    	cmp	x9, x10
116757228: 540000a0    	b.eq	0x11675723c <_O266DecReleaseOutputPicture+0x34ca784>
11675722c: d004d9c9    	adrp	x9, 0x120291000 <dyld_stub_binder+0x120291000>
116757230: b9876129    	ldrsw	x9, [x9, #0x760]
116757234: 5280002a    	mov	w10, #0x1               ; =1
116757238: 3829690a    	strb	w10, [x8, x9]
11675723c: b9403269    	ldr	w9, [x19, #0x30]
116757240: f9401268    	ldr	x8, [x19, #0x20]
116757244: d004d9ca    	adrp	x10, 0x120291000 <dyld_stub_binder+0x120291000>
116757248: b9877d4a    	ldrsw	x10, [x10, #0x77c]
11675724c: b86a690a    	ldr	w10, [x8, x10]
116757250: 6b0a013f    	cmp	w9, w10
116757254: 54000661    	b.ne	0x116757320 <_O266DecReleaseOutputPicture+0x34ca868>
116757258: 3940d269    	ldrb	w9, [x19, #0x34]
11675725c: 52000129    	eor	w9, w9, #0x1
116757260: d004d9ca    	adrp	x10, 0x120291000 <dyld_stub_binder+0x120291000>
116757264: b987814a    	ldrsw	x10, [x10, #0x780]
116757268: 382a6909    	strb	w9, [x8, x10]
11675726c: f9401660    	ldr	x0, [x19, #0x28]
116757270: b40002c0    	cbz	x0, 0x1167572c8 <_O266DecReleaseOutputPicture+0x34ca810>
116757274: f9400808    	ldr	x8, [x0, #0x10]
116757278: d63f0100    	blr	x8
11675727c: f004d288    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
116757280: f9448500    	ldr	x0, [x8, #0x908]
116757284: d004b728    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
116757288: f940f501    	ldr	x1, [x8, #0x1e8]
11675728c: 946f4a98    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757290: d004b708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116757294: f942a901    	ldr	x1, [x8, #0x550]
116757298: d00420a8    	adrp	x8, 0x11eb6d000 <dyld_stub_binder+0x11eb6d000>
11675729c: 9120a108    	add	x8, x8, #0x828
1167572a0: f90003e8    	str	x8, [sp]
1167572a4: f0030b85    	adrp	x5, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
1167572a8: 911b90a5    	add	x5, x5, #0x6e4
1167572ac: f0030b87    	adrp	x7, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
1167572b0: 912228e7    	add	x7, x7, #0x88a
1167572b4: 52800042    	mov	w2, #0x2                ; =2
1167572b8: d2800003    	mov	x3, #0x0                ; =0
1167572bc: 52800004    	mov	w4, #0x0                ; =0
1167572c0: 52806526    	mov	w6, #0x329              ; =809
1167572c4: 946f4a8a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167572c8: f9401268    	ldr	x8, [x19, #0x20]
1167572cc: d004d9c9    	adrp	x9, 0x120291000 <dyld_stub_binder+0x120291000>
1167572d0: b9877929    	ldrsw	x9, [x9, #0x778]
1167572d4: 3829691f    	strb	wzr, [x8, x9]
1167572d8: 340004b4    	cbz	w20, 0x11675736c <_O266DecReleaseOutputPicture+0x34ca8b4>
1167572dc: 3940d268    	ldrb	w8, [x19, #0x34]
1167572e0: 7100051f    	cmp	w8, #0x1
1167572e4: 54000441    	b.ne	0x11675736c <_O266DecReleaseOutputPicture+0x34ca8b4>
1167572e8: f9401260    	ldr	x0, [x19, #0x20]
1167572ec: 9004c528    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
1167572f0: f9442901    	ldr	x1, [x8, #0x850]
1167572f4: 946f4a7e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167572f8: f9401268    	ldr	x8, [x19, #0x20]
1167572fc: d004d9c9    	adrp	x9, 0x120291000 <dyld_stub_binder+0x120291000>
116757300: b9874d29    	ldrsw	x9, [x9, #0x74c]
116757304: f8696900    	ldr	x0, [x8, x9]
116757308: f004cd68    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
11675730c: f940f901    	ldr	x1, [x8, #0x1f0]
116757310: a9427bfd    	ldp	x29, x30, [sp, #0x20]
116757314: a9414ff4    	ldp	x20, x19, [sp, #0x10]
116757318: 9100c3ff    	add	sp, sp, #0x30
11675731c: 146f4a74    	b	0x118329cec <dyld_stub_binder+0x118329cec>
116757320: f004d288    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
116757324: f9448500    	ldr	x0, [x8, #0x908]
116757328: d004b728    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
11675732c: f940f501    	ldr	x1, [x8, #0x1e8]
116757330: 946f4a6f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757334: d004b708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116757338: f942a901    	ldr	x1, [x8, #0x550]
11675733c: d00420a8    	adrp	x8, 0x11eb6d000 <dyld_stub_binder+0x11eb6d000>
116757340: 91202108    	add	x8, x8, #0x808
116757344: f90003e8    	str	x8, [sp]
116757348: f0030b85    	adrp	x5, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
11675734c: 911b90a5    	add	x5, x5, #0x6e4
116757350: f0030b87    	adrp	x7, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
116757354: 912228e7    	add	x7, x7, #0x88a
116757358: 52800042    	mov	w2, #0x2                ; =2
11675735c: d2800003    	mov	x3, #0x0                ; =0
116757360: 52800004    	mov	w4, #0x0                ; =0
116757364: 52806446    	mov	w6, #0x322              ; =802
116757368: 946f4a61    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675736c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
116757370: a9414ff4    	ldp	x20, x19, [sp, #0x10]
116757374: 9100c3ff    	add	sp, sp, #0x30
116757378: d65f03c0    	ret
