
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116714ae4: 6db933ed    	stp	d13, d12, [sp, #-0x70]!
116714ae8: 6d012beb    	stp	d11, d10, [sp, #0x10]
116714aec: 6d0223e9    	stp	d9, d8, [sp, #0x20]
116714af0: a9035ff8    	stp	x24, x23, [sp, #0x30]
116714af4: a90457f6    	stp	x22, x21, [sp, #0x40]
116714af8: a9054ff4    	stp	x20, x19, [sp, #0x50]
116714afc: a9067bfd    	stp	x29, x30, [sp, #0x60]
116714b00: 910183fd    	add	x29, sp, #0x60
116714b04: aa0003f3    	mov	x19, x0
116714b08: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714b0c: f942d501    	ldr	x1, [x8, #0x5a8] ; selector updateShape:
116714b10: 52800042    	mov	w2, #0x2                ; =2
116714b14: 94705476    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714b18: 9004c208    	adrp	x8, 0x11ff54000 <dyld_stub_binder+0x11ff54000>
116714b1c: f940fd14    	ldr	x20, [x8, #0x1f8] ; selector badgeLabel
116714b20: aa1303e0    	mov	x0, x19
116714b24: aa1403e1    	mov	x1, x20
116714b28: 94705471    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714b2c: aa1d03fd    	mov	x29, x29
116714b30: 94705499    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714b34: aa0003f7    	mov	x23, x0
116714b38: d004cf68    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
116714b3c: f9449d15    	ldr	x21, [x8, #0x938] ; selector height
116714b40: aa1503e1    	mov	x1, x21
116714b44: 9470546a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714b48: 1e604008    	fmov	d8, d0
116714b4c: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714b50: f942dd16    	ldr	x22, [x8, #0x5b8] ; selector badgeInset
116714b54: aa1303e0    	mov	x0, x19
116714b58: aa1603e1    	mov	x1, x22
116714b5c: 94705464    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714b60: b00376d8    	adrp	x24, 0x11d5ed000 <dyld_stub_binder+0x11d5ed000>
116714b64: f9417b18    	ldr	x24, [x24, #0x2f0]
116714b68: 6d401303    	ldp	d3, d4, [x24]
116714b6c: 1e611002    	fmov	d2, #3.00000000
116714b70: 1e632000    	fcmp	d0, d3
116714b74: 1e640420    	fccmp	d1, d4, #0x0, eq
116714b78: 540000a0    	b.eq	0x116714b8c <_O266DecReleaseOutputPicture+0x34880d4>
116714b7c: aa1303e0    	mov	x0, x19
116714b80: aa1603e1    	mov	x1, x22
116714b84: 9470545a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714b88: 1e612822    	fadd	d2, d1, d1
116714b8c: 1e622908    	fadd	d8, d8, d2
116714b90: aa1703e0    	mov	x0, x23
116714b94: 94705471    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714b98: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714b9c: f942d901    	ldr	x1, [x8, #0x5b0] ; selector setRedDotImageWithDiameter:shouldStretch:
116714ba0: aa1303e0    	mov	x0, x19
116714ba4: 1e604100    	fmov	d0, d8
116714ba8: 52800022    	mov	w2, #0x1                ; =1
116714bac: 94705450    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714bb0: 9004cfa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116714bb4: f9410901    	ldr	x1, [x8, #0x210] ; selector setHeight:
116714bb8: aa1303e0    	mov	x0, x19
116714bbc: 1e604100    	fmov	d0, d8
116714bc0: 9470544b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714bc4: aa1303e0    	mov	x0, x19
116714bc8: aa1603e1    	mov	x1, x22
116714bcc: 94705448    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714bd0: 1e604009    	fmov	d9, d0
116714bd4: 1e60402a    	fmov	d10, d1
116714bd8: 6d40330b    	ldp	d11, d12, [x24]
116714bdc: aa1303e0    	mov	x0, x19
116714be0: aa1403e1    	mov	x1, x20
116714be4: 94705442    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714be8: aa1d03fd    	mov	x29, x29
116714bec: 9470546a    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714bf0: aa0003f8    	mov	x24, x0
116714bf4: f004cfa8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116714bf8: f947a517    	ldr	x23, [x8, #0xf48] ; selector width
116714bfc: aa1703e1    	mov	x1, x23
116714c00: 9470543b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c04: 1e604008    	fmov	d8, d0
116714c08: 1e6b2120    	fcmp	d9, d11
116714c0c: 1e6c0540    	fccmp	d10, d12, #0x0, eq
116714c10: 540000e0    	b.eq	0x116714c2c <_O266DecReleaseOutputPicture+0x3488174>
116714c14: aa1303e0    	mov	x0, x19
116714c18: aa1603e1    	mov	x1, x22
116714c1c: 94705434    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c20: 1e601001    	fmov	d1, #2.00000000
116714c24: 1f412000    	fmadd	d0, d0, d1, d8
116714c28: 14000007    	b	0x116714c44 <_O266DecReleaseOutputPicture+0x348818c>
116714c2c: aa1303e0    	mov	x0, x19
116714c30: aa1503e1    	mov	x1, x21
116714c34: 9470542e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c38: 1e602900    	fadd	d0, d8, d0
116714c3c: 1e729001    	fmov	d1, #-5.00000000
116714c40: 1e612800    	fadd	d0, d0, d1
116714c44: d004cfa8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
116714c48: f9418d01    	ldr	x1, [x8, #0x318] ; selector setWidth:
116714c4c: aa1303e0    	mov	x0, x19
116714c50: 94705427    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c54: aa1803e0    	mov	x0, x24
116714c58: 94705440    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714c5c: aa1303e0    	mov	x0, x19
116714c60: aa1703e1    	mov	x1, x23
116714c64: 94705422    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c68: 1e6c1009    	fmov	d9, #0.50000000
116714c6c: 1e690808    	fmul	d8, d0, d9
116714c70: aa1303e0    	mov	x0, x19
116714c74: aa1503e1    	mov	x1, x21
116714c78: 9470541d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c7c: 1e690809    	fmul	d9, d0, d9
116714c80: aa1303e0    	mov	x0, x19
116714c84: aa1403e1    	mov	x1, x20
116714c88: 94705419    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714c8c: aa1d03fd    	mov	x29, x29
116714c90: 94705441    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714c94: aa0003f3    	mov	x19, x0
116714c98: f004cf88    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
116714c9c: f9425101    	ldr	x1, [x8, #0x4a0] ; selector setCenter:
116714ca0: 1e604100    	fmov	d0, d8
116714ca4: 1e604121    	fmov	d1, d9
116714ca8: 94705411    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714cac: aa1303e0    	mov	x0, x19
116714cb0: a9467bfd    	ldp	x29, x30, [sp, #0x60]
116714cb4: a9454ff4    	ldp	x20, x19, [sp, #0x50]
116714cb8: a94457f6    	ldp	x22, x21, [sp, #0x40]
116714cbc: a9435ff8    	ldp	x24, x23, [sp, #0x30]
116714cc0: 6d4223e9    	ldp	d9, d8, [sp, #0x20]
116714cc4: 6d412beb    	ldp	d11, d10, [sp, #0x10]
116714cc8: 6cc733ed    	ldp	d13, d12, [sp], #0x70
116714ccc: 14705423    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
