
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
116714cd0: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
116714cd4: a9014ff4    	stp	x20, x19, [sp, #0x10]
116714cd8: a9027bfd    	stp	x29, x30, [sp, #0x20]
116714cdc: 910083fd    	add	x29, sp, #0x20
116714ce0: aa0203f3    	mov	x19, x2
116714ce4: aa0003f4    	mov	x20, x0
116714ce8: aa0203e0    	mov	x0, x2
116714cec: 94705421    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116714cf0: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714cf4: f942e101    	ldr	x1, [x8, #0x5c0] ; selector isPureInteger:
116714cf8: aa1403e0    	mov	x0, x20
116714cfc: aa1303e2    	mov	x2, x19
116714d00: 947053fb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d04: 34000160    	cbz	w0, 0x116714d30 <_O266DecReleaseOutputPicture+0x3488278>
116714d08: f004cf68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
116714d0c: f9425101    	ldr	x1, [x8, #0x4a0] ; selector integerValue
116714d10: aa1303e0    	mov	x0, x19
116714d14: 947053f6    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d18: aa0003e2    	mov	x2, x0
116714d1c: d004cfa8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
116714d20: f940bd01    	ldr	x1, [x8, #0x178] ; selector setValue:
116714d24: aa1403e0    	mov	x0, x20
116714d28: 947053f1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d2c: 1400002a    	b	0x116714dd4 <_O266DecReleaseOutputPicture+0x348831c>
116714d30: 9004c208    	adrp	x8, 0x11ff54000 <dyld_stub_binder+0x11ff54000>
116714d34: f940fd15    	ldr	x21, [x8, #0x1f8] ; selector badgeLabel
116714d38: aa1403e0    	mov	x0, x20
116714d3c: aa1503e1    	mov	x1, x21
116714d40: 947053eb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d44: aa1d03fd    	mov	x29, x29
116714d48: 94705413    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714d4c: aa0003f6    	mov	x22, x0
116714d50: 9004cfa8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116714d54: f9411101    	ldr	x1, [x8, #0x220] ; selector setHidden:
116714d58: 52800002    	mov	w2, #0x0                ; =0
116714d5c: 947053e4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d60: aa1603e0    	mov	x0, x22
116714d64: 947053fd    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714d68: aa1403e0    	mov	x0, x20
116714d6c: aa1503e1    	mov	x1, x21
116714d70: 947053df    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d74: aa1d03fd    	mov	x29, x29
116714d78: 94705407    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714d7c: aa0003f6    	mov	x22, x0
116714d80: b004cfa8    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
116714d84: f9468d01    	ldr	x1, [x8, #0xd18] ; selector setText:
116714d88: aa1303e2    	mov	x2, x19
116714d8c: 947053d8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714d90: aa1603e0    	mov	x0, x22
116714d94: 947053f1    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714d98: aa1403e0    	mov	x0, x20
116714d9c: aa1503e1    	mov	x1, x21
116714da0: 947053d3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714da4: aa1d03fd    	mov	x29, x29
116714da8: 947053fb    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116714dac: aa0003f5    	mov	x21, x0
116714db0: b004b928    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116714db4: f9465101    	ldr	x1, [x8, #0xca0] ; selector sizeToFit
116714db8: 947053cd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714dbc: aa1503e0    	mov	x0, x21
116714dc0: 947053e6    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116714dc4: d004cec8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116714dc8: f942cd01    	ldr	x1, [x8, #0x598] ; selector innerSetBadgeShape
116714dcc: aa1403e0    	mov	x0, x20
116714dd0: 947053c7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116714dd4: aa1303e0    	mov	x0, x19
116714dd8: a9427bfd    	ldp	x29, x30, [sp, #0x20]
116714ddc: a9414ff4    	ldp	x20, x19, [sp, #0x10]
116714de0: a8c357f6    	ldp	x22, x21, [sp], #0x30
116714de4: 147053dd    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
