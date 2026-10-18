
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10971190c: d101c3ff    	sub	sp, sp, #0x70
109711910: a9016ffc    	stp	x28, x27, [sp, #0x10]
109711914: a90267fa    	stp	x26, x25, [sp, #0x20]
109711918: a9035ff8    	stp	x24, x23, [sp, #0x30]
10971191c: a90457f6    	stp	x22, x21, [sp, #0x40]
109711920: a9054ff4    	stp	x20, x19, [sp, #0x50]
109711924: a9067bfd    	stp	x29, x30, [sp, #0x60]
109711928: 910183fd    	add	x29, sp, #0x60
10971192c: aa0203f3    	mov	x19, x2
109711930: aa0003f6    	mov	x22, x0
109711934: d00ba9e8    	adrp	x8, 0x120c4f000 <dyld_stub_binder+0x120c4f000>
109711938: 52800039    	mov	w25, #0x1               ; =1
10971193c: 39182919    	strb	w25, [x8, #0x60a]
109711940: aa0203e0    	mov	x0, x2
109711944: 958526bf    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
109711948: d00b5315    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
10971194c: f94542a0    	ldr	x0, [x21, #0xa80]
109711950: 958526c4    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109711954: aa0003f4    	mov	x20, x0
109711958: f94542a0    	ldr	x0, [x21, #0xa80]
10971195c: 958526c1    	bl	0x10f85b460 <_UR_96F1_B25D+0x3a640d0>
109711960: aa0003f5    	mov	x21, x0
109711964: 900b39e8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109711968: f9409901    	ldr	x1, [x8, #0x130] ; m_nsTransferID
10971196c: aa1303e0    	mov	x0, x19
109711970: 958526b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711974: aa1d03fd    	mov	x29, x29
109711978: 958526b6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10971197c: aa0003f8    	mov	x24, x0
109711980: 900b3948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109711984: f942c917    	ldr	x23, [x8, #0x590] ; safeSetObject:forKey:
109711988: f00a9663    	adrp	x3, 0x11e9e0000 <dyld_stub_binder+0x11e9e0000>
10971198c: 91242063    	add	x3, x3, #0x908 ; CFSTR trans_id
109711990: aa1403e0    	mov	x0, x20
109711994: aa1703e1    	mov	x1, x23
109711998: aa1803e2    	mov	x2, x24
10971199c: 958526aa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097119a0: aa1803e0    	mov	x0, x24
1097119a4: 958526ae    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
1097119a8: d00a6f42    	adrp	x2, 0x11e4fb000 <dyld_stub_binder+0x11e4fb000>
1097119ac: 9101a042    	add	x2, x2, #0x68 ; CFSTR confirm
1097119b0: 900a7223    	adrp	x3, 0x11e555000 <dyld_stub_binder+0x11e555000>
1097119b4: 9112a063    	add	x3, x3, #0x4a8 ; CFSTR op
1097119b8: aa1403e0    	mov	x0, x20
1097119bc: aa1703e1    	mov	x1, x23
1097119c0: 958526a1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097119c4: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
1097119c8: f9454d01    	ldr	x1, [x8, #0xa98] ; m_nsFromUserName
1097119cc: aa1303e0    	mov	x0, x19
1097119d0: 9585269d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097119d4: aa1d03fd    	mov	x29, x29
1097119d8: 9585269e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
1097119dc: aa0003f8    	mov	x24, x0
1097119e0: b00a6cc3    	adrp	x3, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
1097119e4: 910b2063    	add	x3, x3, #0x2c8 ; CFSTR username
1097119e8: aa1403e0    	mov	x0, x20
1097119ec: aa1703e1    	mov	x1, x23
1097119f0: aa1803e2    	mov	x2, x24
1097119f4: 95852694    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
1097119f8: aa1803e0    	mov	x0, x24
1097119fc: 95852698    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711a00: d00b531c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
109711a04: f945479a    	ldr	x26, [x28, #0xa88]
109711a08: 900b39e8    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
109711a0c: f940b101    	ldr	x1, [x8, #0x160] ; m_uiInvalidTime
109711a10: aa1303e0    	mov	x0, x19
109711a14: 9585268c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711a18: b00b4fc8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
109711a1c: f946a518    	ldr	x24, [x8, #0xd48] ; stringWithFormat:
109711a20: f90003e0    	str	x0, [sp]
109711a24: b00a6ca2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
109711a28: 91232042    	add	x2, x2, #0x8c8 ; CFSTR %llu
109711a2c: aa1a03e0    	mov	x0, x26
109711a30: aa1803e1    	mov	x1, x24
109711a34: 95852684    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711a38: aa1d03fd    	mov	x29, x29
109711a3c: 95852685    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711a40: aa0003fa    	mov	x26, x0
109711a44: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711a48: 91292063    	add	x3, x3, #0xa48 ; CFSTR invalid_time
109711a4c: aa1403e0    	mov	x0, x20
109711a50: aa1703e1    	mov	x1, x23
109711a54: aa1a03e2    	mov	x2, x26
109711a58: 9585267b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711a5c: aa1a03e0    	mov	x0, x26
109711a60: 9585267f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711a64: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109711a68: f9455101    	ldr	x1, [x8, #0xaa0] ; left_button_continue
109711a6c: aa1303e0    	mov	x0, x19
109711a70: 95852675    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711a74: aa1d03fd    	mov	x29, x29
109711a78: 95852676    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711a7c: aa0003fa    	mov	x26, x0
109711a80: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711a84: 9118a063    	add	x3, x3, #0x628 ; CFSTR left_button_continue
109711a88: aa1403e0    	mov	x0, x20
109711a8c: aa1703e1    	mov	x1, x23
109711a90: aa1a03e2    	mov	x2, x26
109711a94: 9585266c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711a98: aa1a03e0    	mov	x0, x26
109711a9c: 95852670    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711aa0: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109711aa4: f9454501    	ldr	x1, [x8, #0xa88] ; group_username
109711aa8: aa1303e0    	mov	x0, x19
109711aac: 95852666    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711ab0: aa1d03fd    	mov	x29, x29
109711ab4: 95852667    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711ab8: aa0003fa    	mov	x26, x0
109711abc: 900a9763    	adrp	x3, 0x11e9fd000 <dyld_stub_binder+0x11e9fd000>
109711ac0: 9111a063    	add	x3, x3, #0x468 ; CFSTR group_username
109711ac4: aa1403e0    	mov	x0, x20
109711ac8: aa1703e1    	mov	x1, x23
109711acc: aa1a03e2    	mov	x2, x26
109711ad0: 9585265d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711ad4: aa1a03e0    	mov	x0, x26
109711ad8: 95852661    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711adc: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109711ae0: f9454901    	ldr	x1, [x8, #0xa90] ; m_nsTransferAttach
109711ae4: aa1303e0    	mov	x0, x19
109711ae8: 95852657    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711aec: aa1d03fd    	mov	x29, x29
109711af0: 95852658    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711af4: aa0003fa    	mov	x26, x0
109711af8: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711afc: 9128a063    	add	x3, x3, #0xa28 ; CFSTR transfer_attach
109711b00: aa1403e0    	mov	x0, x20
109711b04: aa1703e1    	mov	x1, x23
109711b08: aa1a03e2    	mov	x2, x26
109711b0c: 9585264e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711b10: aa1a03e0    	mov	x0, x26
109711b14: 95852652    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711b18: 900b4b08    	adrp	x8, 0x120071000 <dyld_stub_binder+0x120071000>
109711b1c: f9472d01    	ldr	x1, [x8, #0xe58] ; bind_serial
109711b20: aa1303e0    	mov	x0, x19
109711b24: 95852648    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711b28: aa1d03fd    	mov	x29, x29
109711b2c: 95852649    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711b30: aa0003fa    	mov	x26, x0
109711b34: 900a76e3    	adrp	x3, 0x11e5ed000 <dyld_stub_binder+0x11e5ed000>
109711b38: 911fa063    	add	x3, x3, #0x7e8 ; CFSTR bind_serial
109711b3c: aa1403e0    	mov	x0, x20
109711b40: aa1703e1    	mov	x1, x23
109711b44: aa1a03e2    	mov	x2, x26
109711b48: 9585263f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711b4c: aa1a03e0    	mov	x0, x26
109711b50: 95852643    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711b54: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109711b58: f945551b    	ldr	x27, [x8, #0xaa8] ; recv_channel_type
109711b5c: aa1303e0    	mov	x0, x19
109711b60: aa1b03e1    	mov	x1, x27
109711b64: 95852638    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711b68: f945479a    	ldr	x26, [x28, #0xa88]
109711b6c: 340000a0    	cbz	w0, 0x109711b80 <_Flutter_MMFoundation_BindContext+0x5bed764>
109711b70: aa1303e0    	mov	x0, x19
109711b74: aa1b03e1    	mov	x1, x27
109711b78: 95852633    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711b7c: aa0003f9    	mov	x25, x0
109711b80: f90003f9    	str	x25, [sp]
109711b84: 900a6c82    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
109711b88: 912a2042    	add	x2, x2, #0xa88 ; CFSTR %u
109711b8c: aa1a03e0    	mov	x0, x26
109711b90: aa1803e1    	mov	x1, x24
109711b94: 9585262c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711b98: aa1d03fd    	mov	x29, x29
109711b9c: 9585262d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711ba0: aa0003f9    	mov	x25, x0
109711ba4: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711ba8: 912a2063    	add	x3, x3, #0xa88 ; CFSTR recv_account_type
109711bac: aa1403e0    	mov	x0, x20
109711bb0: aa1703e1    	mov	x1, x23
109711bb4: aa1903e2    	mov	x2, x25
109711bb8: 95852623    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711bbc: aa1903e0    	mov	x0, x25
109711bc0: 95852627    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711bc4: 900b4028    	adrp	x8, 0x11ff15000 <dyld_stub_binder+0x11ff15000>
109711bc8: f9416119    	ldr	x25, [x8, #0x2c0] ; groupType
109711bcc: aa1303e0    	mov	x0, x19
109711bd0: aa1903e1    	mov	x1, x25
109711bd4: 9585261c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711bd8: 340002c0    	cbz	w0, 0x109711c30 <_Flutter_MMFoundation_BindContext+0x5bed814>
109711bdc: f945479a    	ldr	x26, [x28, #0xa88]
109711be0: aa1303e0    	mov	x0, x19
109711be4: aa1903e1    	mov	x1, x25
109711be8: 95852617    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711bec: f90003e0    	str	x0, [sp]
109711bf0: 900a6c82    	adrp	x2, 0x11e4a1000 <dyld_stub_binder+0x11e4a1000>
109711bf4: 912a2042    	add	x2, x2, #0xa88 ; CFSTR %u
109711bf8: aa1a03e0    	mov	x0, x26
109711bfc: aa1803e1    	mov	x1, x24
109711c00: 95852611    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711c04: aa1d03fd    	mov	x29, x29
109711c08: 95852612    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711c0c: aa0003f9    	mov	x25, x0
109711c10: 900a9763    	adrp	x3, 0x11e9fd000 <dyld_stub_binder+0x11e9fd000>
109711c14: 9119a063    	add	x3, x3, #0x668 ; CFSTR group_type
109711c18: aa1403e0    	mov	x0, x20
109711c1c: aa1703e1    	mov	x1, x23
109711c20: aa1903e2    	mov	x2, x25
109711c24: 95852608    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711c28: aa1903e0    	mov	x0, x25
109711c2c: 9585260c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711c30: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109711c34: f9455919    	ldr	x25, [x8, #0xab0] ; sub_title_clicked
109711c38: aa1303e0    	mov	x0, x19
109711c3c: aa1903e1    	mov	x1, x25
109711c40: 95852601    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711c44: aa1d03fd    	mov	x29, x29
109711c48: 95852602    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711c4c: aa0003fa    	mov	x26, x0
109711c50: d00b4f88    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
109711c54: f946e901    	ldr	x1, [x8, #0xdd0] ; length
109711c58: 958525fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711c5c: aa0003fb    	mov	x27, x0
109711c60: aa1a03e0    	mov	x0, x26
109711c64: 958525fe    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711c68: b40001fb    	cbz	x27, 0x109711ca4 <_Flutter_MMFoundation_BindContext+0x5bed888>
109711c6c: aa1303e0    	mov	x0, x19
109711c70: aa1903e1    	mov	x1, x25
109711c74: 958525f4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711c78: aa1d03fd    	mov	x29, x29
109711c7c: 958525f5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711c80: aa0003f9    	mov	x25, x0
109711c84: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711c88: 912aa063    	add	x3, x3, #0xaa8 ; CFSTR sub_title_clicked
109711c8c: aa1403e0    	mov	x0, x20
109711c90: aa1703e1    	mov	x1, x23
109711c94: aa1903e2    	mov	x2, x25
109711c98: 958525eb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711c9c: aa1903e0    	mov	x0, x25
109711ca0: 958525ef    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711ca4: d00b4b68    	adrp	x8, 0x12007f000 <dyld_stub_binder+0x12007f000>
109711ca8: f9455d19    	ldr	x25, [x8, #0xab8] ; sub_recv_channel_id
109711cac: aa1303e0    	mov	x0, x19
109711cb0: aa1903e1    	mov	x1, x25
109711cb4: 958525e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711cb8: b40002c0    	cbz	x0, 0x109711d10 <_Flutter_MMFoundation_BindContext+0x5bed8f4>
109711cbc: f945479a    	ldr	x26, [x28, #0xa88]
109711cc0: aa1303e0    	mov	x0, x19
109711cc4: aa1903e1    	mov	x1, x25
109711cc8: 958525df    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711ccc: f90003e0    	str	x0, [sp]
109711cd0: b00a6ca2    	adrp	x2, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
109711cd4: 91232042    	add	x2, x2, #0x8c8 ; CFSTR %llu
109711cd8: aa1a03e0    	mov	x0, x26
109711cdc: aa1803e1    	mov	x1, x24
109711ce0: 958525d9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711ce4: aa1d03fd    	mov	x29, x29
109711ce8: 958525da    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
109711cec: aa0003f8    	mov	x24, x0
109711cf0: b00a9763    	adrp	x3, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711cf4: 912b2063    	add	x3, x3, #0xac8 ; CFSTR sub_recv_channel_id
109711cf8: aa1403e0    	mov	x0, x20
109711cfc: aa1703e1    	mov	x1, x23
109711d00: aa1803e2    	mov	x2, x24
109711d04: 958525d0    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711d08: aa1803e0    	mov	x0, x24
109711d0c: 958525d4    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711d10: 900b4b68    	adrp	x8, 0x12007d000 <dyld_stub_binder+0x12007d000>
109711d14: f9477d01    	ldr	x1, [x8, #0xef8] ; GetWCPayBusinessRequest:WXInnerUseDic:CMDID:OutputType:
109711d18: aa1603e0    	mov	x0, x22
109711d1c: aa1403e2    	mov	x2, x20
109711d20: aa1503e3    	mov	x3, x21
109711d24: 52800aa4    	mov	w4, #0x55               ; =85
109711d28: 52800025    	mov	w5, #0x1                ; =1
109711d2c: 958525c6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711d30: d00b5308    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
109711d34: f9453500    	ldr	x0, [x8, #0xa68] ; �gH 
109711d38: 900b3948    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
109711d3c: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
109711d40: b00a9768    	adrp	x8, 0x11e9fe000 <dyld_stub_binder+0x11e9fe000>
109711d44: 912ba108    	add	x8, x8, #0xae8 ; CFSTR MMTENPAY_CGICMD_TRANSFER_CONFIRM start !!
109711d48: f90003e8    	str	x8, [sp]
109711d4c: f008d9c3    	adrp	x3, 0x11b24c000 <dyld_stub_binder+0x11b24c000>
109711d50: 910fac63    	add	x3, x3, #0x3eb
109711d54: f0092bc5    	adrp	x5, 0x11bc8c000 <dyld_stub_binder+0x11bc8c000>
109711d58: 9133aca5    	add	x5, x5, #0xceb
109711d5c: 90092be7    	adrp	x7, 0x11bc8d000 <dyld_stub_binder+0x11bc8d000>
109711d60: 910340e7    	add	x7, x7, #0xd0
109711d64: 52800022    	mov	w2, #0x1                ; =1
109711d68: 52800004    	mov	w4, #0x0                ; =0
109711d6c: 52804606    	mov	w6, #0x230              ; =560
109711d70: 958525b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
109711d74: aa1503e0    	mov	x0, x21
109711d78: 958525b9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711d7c: aa1403e0    	mov	x0, x20
109711d80: 958525b7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
109711d84: aa1303e0    	mov	x0, x19
109711d88: a9467bfd    	ldp	x29, x30, [sp, #0x60]
109711d8c: a9454ff4    	ldp	x20, x19, [sp, #0x50]
109711d90: a94457f6    	ldp	x22, x21, [sp, #0x40]
109711d94: a9435ff8    	ldp	x24, x23, [sp, #0x30]
109711d98: a94267fa    	ldp	x26, x25, [sp, #0x20]
109711d9c: a9416ffc    	ldp	x28, x27, [sp, #0x10]
109711da0: 9101c3ff    	add	sp, sp, #0x70
109711da4: 158525ae    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>