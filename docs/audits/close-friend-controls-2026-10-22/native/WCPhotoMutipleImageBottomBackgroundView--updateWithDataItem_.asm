
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
109b31ce8: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
109b31cec: a90157f6    	stp	x22, x21, [sp, #0x10]
109b31cf0: a9024ff4    	stp	x20, x19, [sp, #0x20]
109b31cf4: a9037bfd    	stp	x29, x30, [sp, #0x30]
109b31cf8: 9100c3fd    	add	x29, sp, #0x30
109b31cfc: aa0203f4    	mov	x20, x2
109b31d00: aa0003f3    	mov	x19, x0
109b31d04: f00b88e8    	adrp	x8, 0x120c50000 <dyld_stub_binder+0x120c50000>
109b31d08: 52800029    	mov	w9, #0x1                ; =1
109b31d0c: 3908a109    	strb	w9, [x8, #0x228]
109b31d10: d00b18a8    	adrp	x8, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
109b31d14: f9449d15    	ldr	x21, [x8, #0x938] ; setDataItem:
109b31d18: aa0203e0    	mov	x0, x2
109b31d1c: 9574a5c9    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109b31d20: aa1303e0    	mov	x0, x19
109b31d24: aa1503e1    	mov	x1, x21
109b31d28: aa1403e2    	mov	x2, x20
109b31d2c: 9574a5c6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31d30: f00b2e68    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
109b31d34: f9427515    	ldr	x21, [x8, #0x4e8] ; contentView
109b31d38: aa1303e0    	mov	x0, x19
109b31d3c: aa1503e1    	mov	x1, x21
109b31d40: 9574a5c1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31d44: aa1d03fd    	mov	x29, x29
109b31d48: 9574a5c2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31d4c: aa0003f6    	mov	x22, x0
109b31d50: f00b1868    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
109b31d54: f9417517    	ldr	x23, [x8, #0x2e8] ; contentDesc
109b31d58: aa1403e0    	mov	x0, x20
109b31d5c: aa1703e1    	mov	x1, x23
109b31d60: 9574a5b9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31d64: aa1d03fd    	mov	x29, x29
109b31d68: 9574a5ba    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31d6c: aa0003f8    	mov	x24, x0
109b31d70: f00b1868    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
109b31d74: f9417101    	ldr	x1, [x8, #0x2e0] ; setContent:
109b31d78: aa1603e0    	mov	x0, x22
109b31d7c: aa1803e2    	mov	x2, x24
109b31d80: 9574a5b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31d84: aa1803e0    	mov	x0, x24
109b31d88: 9574a5b5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31d8c: aa1603e0    	mov	x0, x22
109b31d90: 9574a5b3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31d94: aa1403e0    	mov	x0, x20
109b31d98: aa1703e1    	mov	x1, x23
109b31d9c: 9574a5aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31da0: aa1d03fd    	mov	x29, x29
109b31da4: 9574a5ab    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31da8: aa0003f6    	mov	x22, x0
109b31dac: d00b2e88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109b31db0: f946e901    	ldr	x1, [x8, #0xdd0] ; length
109b31db4: 9574a5a4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31db8: f100001f    	cmp	x0, #0x0
109b31dbc: 1a9f17f7    	cset	w23, eq
109b31dc0: aa1303e0    	mov	x0, x19
109b31dc4: aa1503e1    	mov	x1, x21
109b31dc8: 9574a59f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31dcc: aa1d03fd    	mov	x29, x29
109b31dd0: 9574a5a0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31dd4: aa0003f5    	mov	x21, x0
109b31dd8: f00b2ea8    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
109b31ddc: f9411118    	ldr	x24, [x8, #0x220] ; setHidden:
109b31de0: aa1803e1    	mov	x1, x24
109b31de4: aa1703e2    	mov	x2, x23
109b31de8: 9574a597    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31dec: aa1503e0    	mov	x0, x21
109b31df0: 9574a59b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31df4: aa1603e0    	mov	x0, x22
109b31df8: 9574a599    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31dfc: d00b1c48    	adrp	x8, 0x11febb000 <dyld_stub_binder+0x11febb000>
109b31e00: f9467101    	ldr	x1, [x8, #0xce0] ; isPrivate
109b31e04: aa1403e0    	mov	x0, x20
109b31e08: 9574a58f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31e0c: aa0003f5    	mov	x21, x0
109b31e10: aa1403e0    	mov	x0, x20
109b31e14: 9574a592    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31e18: b00b2608    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
109b31e1c: f9450d01    	ldr	x1, [x8, #0xa18] ; privateImageView
109b31e20: aa1303e0    	mov	x0, x19
109b31e24: 9574a588    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31e28: aa1d03fd    	mov	x29, x29
109b31e2c: 9574a589    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109b31e30: aa0003f4    	mov	x20, x0
109b31e34: 520002a2    	eor	w2, w21, #0x1
109b31e38: aa1803e1    	mov	x1, x24
109b31e3c: 9574a582    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109b31e40: aa1403e0    	mov	x0, x20
109b31e44: 9574a586    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109b31e48: 900b1848    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109b31e4c: f9465101    	ldr	x1, [x8, #0xca0] ; sizeToFit
109b31e50: aa1303e0    	mov	x0, x19
109b31e54: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109b31e58: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109b31e5c: a94157f6    	ldp	x22, x21, [sp, #0x10]
109b31e60: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109b31e64: 1574a578    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
