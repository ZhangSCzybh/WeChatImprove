
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10901acb0: d10143ff    	sub	sp, sp, #0x50
10901acb4: a9015ff8    	stp	x24, x23, [sp, #0x10]
10901acb8: a90257f6    	stp	x22, x21, [sp, #0x20]
10901acbc: a9034ff4    	stp	x20, x19, [sp, #0x30]
10901acc0: a9047bfd    	stp	x29, x30, [sp, #0x40]
10901acc4: 910103fd    	add	x29, sp, #0x40
10901acc8: f00be188    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
10901accc: 52800029    	mov	w9, #0x1                ; =1
10901acd0: 393bf509    	strb	w9, [x8, #0xefd]
10901acd4: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901acd8: b9864d08    	ldrsw	x8, [x8, #0x64c]
10901acdc: 38686808    	ldrb	w8, [x0, x8]
10901ace0: 7100051f    	cmp	w8, #0x1
10901ace4: 54000261    	b.ne	0x10901ad30 <_Flutter_MMFoundation_BindContext+0x54f6914>
10901ace8: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901acec: f9453500    	ldr	x0, [x8, #0xa68]
10901acf0: f00b70e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10901acf4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10901acf8: 900acd08    	adrp	x8, 0x11e9ba000 <dyld_stub_binder+0x11e9ba000>
10901acfc: 913ea108    	add	x8, x8, #0xfa8
10901ad00: f90003e8    	str	x8, [sp]
10901ad04: d0091003    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10901ad08: 912b2863    	add	x3, x3, #0xaca
10901ad0c: d0096045    	adrp	x5, 0x11bc24000 <dyld_stub_binder+0x11bc24000>
10901ad10: 910028a5    	add	x5, x5, #0xa
10901ad14: d0096047    	adrp	x7, 0x11bc24000 <dyld_stub_binder+0x11bc24000>
10901ad18: 910798e7    	add	x7, x7, #0x1e6
10901ad1c: 52800022    	mov	w2, #0x1                ; =1
10901ad20: 52800004    	mov	w4, #0x0                ; =0
10901ad24: 52805806    	mov	w6, #0x2c0              ; =704
10901ad28: 95a101c7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901ad2c: 1400003b    	b	0x10901ae18 <_Flutter_MMFoundation_BindContext+0x54f69fc>
10901ad30: aa0003f3    	mov	x19, x0
10901ad34: b00b8ac8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10901ad38: f945e900    	ldr	x0, [x8, #0xbd0]
10901ad3c: d00b8728    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10901ad40: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
10901ad44: 95a101c0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901ad48: aa1d03fd    	mov	x29, x29
10901ad4c: 95a101c1    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901ad50: aa0003f4    	mov	x20, x0
10901ad54: d00b8ac8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10901ad58: f9428500    	ldr	x0, [x8, #0x508]
10901ad5c: b00b8728    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10901ad60: f947ad01    	ldr	x1, [x8, #0xf58] ; class
10901ad64: 95a101b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901ad68: aa0003e2    	mov	x2, x0
10901ad6c: f00b70e8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10901ad70: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
10901ad74: aa1403e0    	mov	x0, x20
10901ad78: 95a101b3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901ad7c: aa1d03fd    	mov	x29, x29
10901ad80: 95a101b4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901ad84: aa0003f5    	mov	x21, x0
10901ad88: d00b9248    	adrp	x8, 0x120264000 <dyld_stub_binder+0x120264000>
10901ad8c: b9863d08    	ldrsw	x8, [x8, #0x63c]
10901ad90: f8686a60    	ldr	x0, [x19, x8]
10901ad94: b00b7108    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10901ad98: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
10901ad9c: 95a101aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901ada0: aa1d03fd    	mov	x29, x29
10901ada4: 95a101ab    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10901ada8: aa0003f6    	mov	x22, x0
10901adac: 900b7ec8    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
10901adb0: f9440901    	ldr	x1, [x8, #0x810] ; homepageType
10901adb4: aa1303e0    	mov	x0, x19
10901adb8: 95a101a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901adbc: aa0003e3    	mov	x3, x0
10901adc0: 900b7f68    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10901adc4: f9401d01    	ldr	x1, [x8, #0x38] ; updateHomepageTail:type:
10901adc8: aa1503e0    	mov	x0, x21
10901adcc: aa1603e2    	mov	x2, x22
10901add0: 95a1019d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901add4: aa0003f7    	mov	x23, x0
10901add8: aa1603e0    	mov	x0, x22
10901addc: 95a101a0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901ade0: aa1503e0    	mov	x0, x21
10901ade4: 95a1019e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901ade8: aa1403e0    	mov	x0, x20
10901adec: 95a1019c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10901adf0: 34000157    	cbz	w23, 0x10901ae18 <_Flutter_MMFoundation_BindContext+0x54f69fc>
10901adf4: 900b8768    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10901adf8: f9404501    	ldr	x1, [x8, #0x88] ; reloadData
10901adfc: aa1303e0    	mov	x0, x19
10901ae00: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10901ae04: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10901ae08: a94257f6    	ldp	x22, x21, [sp, #0x20]
10901ae0c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10901ae10: 910143ff    	add	sp, sp, #0x50
10901ae14: 15a1018c    	b	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10901ae18: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10901ae1c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
10901ae20: a94257f6    	ldp	x22, x21, [sp, #0x20]
10901ae24: a9415ff8    	ldp	x24, x23, [sp, #0x10]
10901ae28: 910143ff    	add	sp, sp, #0x50
10901ae2c: d65f03c0    	ret
