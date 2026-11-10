
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
106571ad0: d10243ff    	sub	sp, sp, #0x90
106571ad4: a9036ffc    	stp	x28, x27, [sp, #0x30]
106571ad8: a90467fa    	stp	x26, x25, [sp, #0x40]
106571adc: a9055ff8    	stp	x24, x23, [sp, #0x50]
106571ae0: a90657f6    	stp	x22, x21, [sp, #0x60]
106571ae4: a9074ff4    	stp	x20, x19, [sp, #0x70]
106571ae8: a9087bfd    	stp	x29, x30, [sp, #0x80]
106571aec: 910203fd    	add	x29, sp, #0x80
106571af0: d00c8f28    	adrp	x8, 0x11f757000 <dyld_stub_binder+0x11f757000>
106571af4: 52800029    	mov	w9, #0x1                ; =1
106571af8: 39076909    	strb	w9, [x8, #0x1da]
106571afc: f00c3fa8    	adrp	x8, 0x11ed68000 <dyld_stub_binder+0x11ed68000>
106571b00: f946fd08    	ldr	x8, [x8, #0xdf8]
106571b04: a90223e0    	stp	x0, x8, [sp, #0x20]
106571b08: d00c22e8    	adrp	x8, 0x11e9cf000 <dyld_stub_binder+0x11e9cf000>
106571b0c: f9410d01    	ldr	x1, [x8, #0x218] ; selector: initWithViewModel:
106571b10: 910083e0    	add	x0, sp, #0x20
106571b14: 945ad855    	bl	0x107c27c68 <_Flutter_MMFoundation_BindContext+0x3eae934>
106571b18: aa0003f3    	mov	x19, x0
106571b1c: b4001860    	cbz	x0, 0x106571e28 <_Flutter_MMFoundation_BindContext+0x27f8af4>
106571b20: b00c3d17    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106571b24: f943c2e0    	ldr	x0, [x23, #0x780]
106571b28: 900c22c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106571b2c: f9440114    	ldr	x20, [x8, #0x800] ; selector: currentContext
106571b30: aa1403e1    	mov	x1, x20
106571b34: 945ad84c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571b38: aa1d03fd    	mov	x29, x29
106571b3c: 945ad851    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571b40: aa0003f5    	mov	x21, x0
106571b44: f00c3ce8    	adrp	x8, 0x11ed10000 <dyld_stub_binder+0x11ed10000>
106571b48: f9400102    	ldr	x2, [x8]
106571b4c: 900c22c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106571b50: f9478516    	ldr	x22, [x8, #0xf08] ; selector: registerExtension:withTarget:
106571b54: aa1603e1    	mov	x1, x22
106571b58: aa1303e3    	mov	x3, x19
106571b5c: 945ad842    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571b60: aa1503e0    	mov	x0, x21
106571b64: 945ad843    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571b68: f943c2e0    	ldr	x0, [x23, #0x780]
106571b6c: aa1403e1    	mov	x1, x20
106571b70: 945ad83d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571b74: aa1d03fd    	mov	x29, x29
106571b78: 945ad842    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571b7c: aa0003f5    	mov	x21, x0
106571b80: d00c3ce8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
106571b84: f9443502    	ldr	x2, [x8, #0x868]
106571b88: aa1603e1    	mov	x1, x22
106571b8c: aa1303e3    	mov	x3, x19
106571b90: 945ad835    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571b94: aa1503e0    	mov	x0, x21
106571b98: 945ad836    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571b9c: f943c2e0    	ldr	x0, [x23, #0x780]
106571ba0: aa1403e1    	mov	x1, x20
106571ba4: 945ad830    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571ba8: aa1d03fd    	mov	x29, x29
106571bac: 945ad835    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571bb0: aa0003f5    	mov	x21, x0
106571bb4: b00c3d08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106571bb8: f9444900    	ldr	x0, [x8, #0x890]
106571bbc: b00c39a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106571bc0: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
106571bc4: 945ad828    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571bc8: aa0003e2    	mov	x2, x0
106571bcc: 900c22c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106571bd0: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
106571bd4: aa1503e0    	mov	x0, x21
106571bd8: 945ad823    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571bdc: aa1d03fd    	mov	x29, x29
106571be0: 945ad828    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571be4: aa0003f6    	mov	x22, x0
106571be8: b00c22c8    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
106571bec: f9411d01    	ldr	x1, [x8, #0x238] ; selector: getExpt:withDef:
106571bf0: b00b51e2    	adrp	x2, 0x11cfae000 <dyld_stub_binder+0x11cfae000>
106571bf4: 9133e042    	add	x2, x2, #0xcf8 ; CFString: clicfg_msg_voice_haidv2_cfg
106571bf8: d00b5143    	adrp	x3, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
106571bfc: 91396063    	add	x3, x3, #0xe58 ; CFString: 
106571c00: 945ad819    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571c04: aa1d03fd    	mov	x29, x29
106571c08: 945ad81e    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571c0c: aa0003f4    	mov	x20, x0
106571c10: aa1603e0    	mov	x0, x22
106571c14: 945ad817    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571c18: aa1503e0    	mov	x0, x21
106571c1c: 945ad815    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571c20: b00c3d1c    	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106571c24: f9430f80    	ldr	x0, [x28, #0x618]
106571c28: 900c22c8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
106571c2c: f9418915    	ldr	x21, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
106571c30: d00b7148    	adrp	x8, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
106571c34: 910de108    	add	x8, x8, #0x378 ; CFString: [HearingAid VoiceBubble] checkAndUpdateEnhanceVoiceBubble config: %@
106571c38: a90053e8    	stp	x8, x20, [sp]
106571c3c: f009efa5    	adrp	x5, 0x11a368000 <dyld_stub_binder+0x11a368000>
106571c40: 911c80a5    	add	x5, x5, #0x720
106571c44: f009efa7    	adrp	x7, 0x11a368000 <dyld_stub_binder+0x11a368000>
106571c48: 911ce0e7    	add	x7, x7, #0x738
106571c4c: aa1503e1    	mov	x1, x21
106571c50: 52800042    	mov	w2, #0x2                ; =2
106571c54: d2800003    	mov	x3, #0x0                ; =0
106571c58: 52800004    	mov	w4, #0x0                ; =0
106571c5c: 52801286    	mov	w6, #0x94               ; =148
106571c60: 945ad801    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571c64: f00c39a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
106571c68: f9467501    	ldr	x1, [x8, #0xce8] ; selector: length
106571c6c: aa1403e0    	mov	x0, x20
106571c70: 945ad7fd    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571c74: b4000540    	cbz	x0, 0x106571d1c <_Flutter_MMFoundation_BindContext+0x27f89e8>
106571c78: b00c39a8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
106571c7c: f945c501    	ldr	x1, [x8, #0xb88] ; selector: dataUsingEncoding:
106571c80: aa1403e0    	mov	x0, x20
106571c84: 52800082    	mov	w2, #0x4                ; =4
106571c88: 945ad7f7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571c8c: aa1d03fd    	mov	x29, x29
106571c90: 945ad7fc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571c94: aa0003f6    	mov	x22, x0
106571c98: b00c3d08    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
106571c9c: f9437100    	ldr	x0, [x8, #0x6e0]
106571ca0: f9000fff    	str	xzr, [sp, #0x18]
106571ca4: 900c39a8    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
106571ca8: f942b501    	ldr	x1, [x8, #0x568] ; selector: JSONObjectWithData:options:error:
106571cac: 910063e4    	add	x4, sp, #0x18
106571cb0: aa1603e2    	mov	x2, x22
106571cb4: d2800003    	mov	x3, #0x0                ; =0
106571cb8: 945ad7eb    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571cbc: aa1d03fd    	mov	x29, x29
106571cc0: 945ad7f0    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571cc4: aa0003f8    	mov	x24, x0
106571cc8: f9400ff7    	ldr	x23, [sp, #0x18]
106571ccc: aa1703e0    	mov	x0, x23
106571cd0: 945ad7e9    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
106571cd4: b40002f7    	cbz	x23, 0x106571d30 <_Flutter_MMFoundation_BindContext+0x27f89fc>
106571cd8: f9430f80    	ldr	x0, [x28, #0x618]
106571cdc: d00b7148    	adrp	x8, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
106571ce0: 910ee108    	add	x8, x8, #0x3b8 ; CFString: [HearingAid VoiceBubble] checkAndUpdateEnhanceVoiceBubble (video) error: %@
106571ce4: a9005fe8    	stp	x8, x23, [sp]
106571ce8: f009efa5    	adrp	x5, 0x11a368000 <dyld_stub_binder+0x11a368000>
106571cec: 911c80a5    	add	x5, x5, #0x720
106571cf0: f009efa7    	adrp	x7, 0x11a368000 <dyld_stub_binder+0x11a368000>
106571cf4: 911ce0e7    	add	x7, x7, #0x738
106571cf8: aa1503e1    	mov	x1, x21
106571cfc: 52800082    	mov	w2, #0x4                ; =4
106571d00: d2800003    	mov	x3, #0x0                ; =0
106571d04: 52800004    	mov	w4, #0x0                ; =0
106571d08: 52801486    	mov	w6, #0xa4               ; =164
106571d0c: 945ad7d6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571d10: aa1303e0    	mov	x0, x19
106571d14: 945ad7d8    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
106571d18: 1400003b    	b	0x106571e04 <_Flutter_MMFoundation_BindContext+0x27f8ad0>
106571d1c: aa1303e0    	mov	x0, x19
106571d20: 945ad7d5    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
106571d24: aa1403e0    	mov	x0, x20
106571d28: 945ad7d2    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571d2c: 14000041    	b	0x106571e30 <_Flutter_MMFoundation_BindContext+0x27f8afc>
106571d30: 900c39c8    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
106571d34: f9432919    	ldr	x25, [x8, #0x650] ; selector: objectForKeyedSubscript:
106571d38: b00b51e2    	adrp	x2, 0x11cfae000 <dyld_stub_binder+0x11cfae000>
106571d3c: 91346042    	add	x2, x2, #0xd18 ; CFString: allow_msg_haidv2
106571d40: aa1803e0    	mov	x0, x24
106571d44: aa1903e1    	mov	x1, x25
106571d48: 945ad7c7    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571d4c: aa1d03fd    	mov	x29, x29
106571d50: 945ad7cc    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571d54: aa0003fa    	mov	x26, x0
106571d58: f00c39a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
106571d5c: f9431501    	ldr	x1, [x8, #0x628] ; selector: integerValue
106571d60: 945ad7c1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571d64: aa0003fb    	mov	x27, x0
106571d68: aa1a03e0    	mov	x0, x26
106571d6c: 945ad7c1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571d70: d00b70e2    	adrp	x2, 0x11d38f000 <dyld_stub_binder+0x11d38f000>
106571d74: 913ce042    	add	x2, x2, #0xf38 ; CFString: show_count
106571d78: aa1803e0    	mov	x0, x24
106571d7c: aa1903e1    	mov	x1, x25
106571d80: 945ad7b9    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571d84: aa1d03fd    	mov	x29, x29
106571d88: 945ad7be    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
106571d8c: aa0003f9    	mov	x25, x0
106571d90: 900c39e8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
106571d94: f9456501    	ldr	x1, [x8, #0xac8] ; selector: unsignedIntValue
106571d98: 945ad7b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571d9c: aa0003fa    	mov	x26, x0
106571da0: aa1903e0    	mov	x0, x25
106571da4: 945ad7b3    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571da8: f9430f80    	ldr	x0, [x28, #0x618]
106571dac: a900ebfb    	stp	x27, x26, [sp, #0x8]
106571db0: d00b7148    	adrp	x8, 0x11d39b000 <dyld_stub_binder+0x11d39b000>
106571db4: 910e6108    	add	x8, x8, #0x398 ; CFString: [HearingAid VoiceBubble] checkAndUpdateEnhanceVoiceBubble (video) allowShow: %ld, showCount: %ld
106571db8: f90003e8    	str	x8, [sp]
106571dbc: f009efa5    	adrp	x5, 0x11a368000 <dyld_stub_binder+0x11a368000>
106571dc0: 911c80a5    	add	x5, x5, #0x720
106571dc4: f009efa7    	adrp	x7, 0x11a368000 <dyld_stub_binder+0x11a368000>
106571dc8: 911ce0e7    	add	x7, x7, #0x738
106571dcc: aa1503e1    	mov	x1, x21
106571dd0: 52800042    	mov	w2, #0x2                ; =2
106571dd4: d2800003    	mov	x3, #0x0                ; =0
106571dd8: 52800004    	mov	w4, #0x0                ; =0
106571ddc: 52801446    	mov	w6, #0xa2               ; =162
106571de0: 945ad7a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
106571de4: f100037f    	cmp	x27, #0x0
106571de8: 1a9fd7e8    	cset	w8, gt
106571dec: b00c4349    	adrp	x9, 0x11edda000 <dyld_stub_binder+0x11edda000>
106571df0: b98c7129    	ldrsw	x9, [x9, #0xc70] ; ivar: VoiceMessageCellView.isXLabEnableShow offset=392
106571df4: 38296a68    	strb	w8, [x19, x9]
106571df8: b00c4348    	adrp	x8, 0x11edda000 <dyld_stub_binder+0x11edda000>
106571dfc: b98c7508    	ldrsw	x8, [x8, #0xc74] ; ivar: VoiceMessageCellView.kVoiceEnhancementSnackBarMaxShowCount offset=388
106571e00: b8286a7a    	str	w26, [x19, x8]
106571e04: aa1803e0    	mov	x0, x24
106571e08: 945ad79a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571e0c: aa1703e0    	mov	x0, x23
106571e10: 945ad798    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571e14: aa1603e0    	mov	x0, x22
106571e18: 945ad796    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571e1c: aa1403e0    	mov	x0, x20
106571e20: 945ad794    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571e24: b5000077    	cbnz	x23, 0x106571e30 <_Flutter_MMFoundation_BindContext+0x27f8afc>
106571e28: aa1303e0    	mov	x0, x19
106571e2c: 945ad792    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
106571e30: aa1303e0    	mov	x0, x19
106571e34: 945ad78f    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
106571e38: aa1303e0    	mov	x0, x19
106571e3c: a9487bfd    	ldp	x29, x30, [sp, #0x80]
106571e40: a9474ff4    	ldp	x20, x19, [sp, #0x70]
106571e44: a94657f6    	ldp	x22, x21, [sp, #0x60]
106571e48: a9455ff8    	ldp	x24, x23, [sp, #0x50]
106571e4c: a94467fa    	ldp	x26, x25, [sp, #0x40]
106571e50: a9436ffc    	ldp	x28, x27, [sp, #0x30]
106571e54: 910243ff    	add	sp, sp, #0x90
106571e58: d65f03c0    	ret
