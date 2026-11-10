
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105593c34: d10383ff    	sub	sp, sp, #0xe0
105593c38: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
105593c3c: a90b57f6    	stp	x22, x21, [sp, #0xb0]
105593c40: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
105593c44: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
105593c48: 910343fd    	add	x29, sp, #0xd0
105593c4c: aa0203f3    	mov	x19, x2
105593c50: 900d0e08    	adrp	x8, 0x11f753000 <dyld_stub_binder+0x11f753000>
105593c54: 52800029    	mov	w9, #0x1                ; =1
105593c58: 3923dd09    	strb	w9, [x8, #0x8f7]
105593c5c: aa0203e0    	mov	x0, x2
105593c60: 949a5005    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105593c64: b00cb8a8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
105593c68: f9467514    	ldr	x20, [x8, #0xce8] ; selector: length
105593c6c: aa1303e0    	mov	x0, x19
105593c70: aa1403e1    	mov	x1, x20
105593c74: 949a4ffc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593c78: b4000620    	cbz	x0, 0x105593d3c <_Flutter_MMFoundation_BindContext+0x181aa08>
105593c7c: f81c83bf    	stur	xzr, [x29, #-0x38]
105593c80: aa1303e0    	mov	x0, x19
105593c84: 949a4ffd    	bl	0x107c27c78 <_Flutter_MMFoundation_BindContext+0x3eae944>
105593c88: f00cb888    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105593c8c: f940f115    	ldr	x21, [x8, #0x1e0] ; selector: bytes
105593c90: aa1503e1    	mov	x1, x21
105593c94: 949a4ff4    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593c98: aa0003f6    	mov	x22, x0
105593c9c: aa1303e0    	mov	x0, x19
105593ca0: aa1403e1    	mov	x1, x20
105593ca4: 949a4ff0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593ca8: aa0003e1    	mov	x1, x0
105593cac: d100d3a2    	sub	x2, x29, #0x34
105593cb0: d100e3a3    	sub	x3, x29, #0x38
105593cb4: aa1603e0    	mov	x0, x22
105593cb8: 9499e09d    	bl	0x107c0bf2c <_Flutter_MMFoundation_BindContext+0x3e92bf8>
105593cbc: 36000600    	tbz	w0, #0x0, 0x105593d7c <_Flutter_MMFoundation_BindContext+0x181aa48>
105593cc0: b85cc3a8    	ldur	w8, [x29, #-0x34]
105593cc4: 35000068    	cbnz	w8, 0x105593cd0 <_Flutter_MMFoundation_BindContext+0x181a99c>
105593cc8: 5287d008    	mov	w8, #0x3e80             ; =16000
105593ccc: b81cc3a8    	stur	w8, [x29, #-0x34]
105593cd0: 9100c3e0    	add	x0, sp, #0x30
105593cd4: 9499e093    	bl	0x107c0bf20 <_Flutter_MMFoundation_BindContext+0x3e92bec>
105593cd8: 297907a8    	ldp	w8, w1, [x29, #-0x38]
105593cdc: 7100051f    	cmp	w8, #0x1
105593ce0: 1a9fc502    	csinc	w2, w8, wzr, gt
105593ce4: 9100c3e0    	add	x0, sp, #0x30
105593ce8: 529f4003    	mov	w3, #0xfa00             ; =64000
105593cec: 52800024    	mov	w4, #0x1                ; =1
105593cf0: 9499e090    	bl	0x107c0bf30 <_Flutter_MMFoundation_BindContext+0x3e92bfc>
105593cf4: 34000680    	cbz	w0, 0x105593dc4 <_Flutter_MMFoundation_BindContext+0x181aa90>
105593cf8: f00cbbe8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105593cfc: f9430d08    	ldr	x8, [x8, #0x618]
105593d00: d00ca1a9    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105593d04: f9418921    	ldr	x1, [x9, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
105593d08: b00beb89    	adrp	x9, 0x11d304000 <dyld_stub_binder+0x11d304000>
105593d0c: 9124e129    	add	x9, x9, #0x938 ; CFString: [OpusPlayer] calculateVoiceTime: decoder init failed, ret=%d
105593d10: a90003e9    	stp	x9, x0, [sp]
105593d14: b00a6525    	adrp	x5, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593d18: 910f50a5    	add	x5, x5, #0x3d4
105593d1c: b00a6527    	adrp	x7, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593d20: 91240ce7    	add	x7, x7, #0x903
105593d24: aa0803e0    	mov	x0, x8
105593d28: 52800082    	mov	w2, #0x4                ; =4
105593d2c: d2800003    	mov	x3, #0x0                ; =0
105593d30: 52800004    	mov	w4, #0x0                ; =0
105593d34: 52804fa6    	mov	w6, #0x27d              ; =637
105593d38: 14000071    	b	0x105593efc <_Flutter_MMFoundation_BindContext+0x181abc8>
105593d3c: f00cbbe8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105593d40: f9430d00    	ldr	x0, [x8, #0x618]
105593d44: d00ca1a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105593d48: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
105593d4c: b00beb88    	adrp	x8, 0x11d304000 <dyld_stub_binder+0x11d304000>
105593d50: 9123e108    	add	x8, x8, #0x8f8 ; CFString: [OpusPlayer] calculateVoiceTime: empty data
105593d54: f90003e8    	str	x8, [sp]
105593d58: b00a6525    	adrp	x5, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593d5c: 910f50a5    	add	x5, x5, #0x3d4
105593d60: b00a6527    	adrp	x7, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593d64: 91240ce7    	add	x7, x7, #0x903
105593d68: 52800082    	mov	w2, #0x4                ; =4
105593d6c: d2800003    	mov	x3, #0x0                ; =0
105593d70: 52800004    	mov	w4, #0x0                ; =0
105593d74: 52804d26    	mov	w6, #0x269              ; =617
105593d78: 14000010    	b	0x105593db8 <_Flutter_MMFoundation_BindContext+0x181aa84>
105593d7c: f00cbbe8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105593d80: f9430d00    	ldr	x0, [x8, #0x618]
105593d84: d00ca1a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105593d88: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
105593d8c: b00beb88    	adrp	x8, 0x11d304000 <dyld_stub_binder+0x11d304000>
105593d90: 91246108    	add	x8, x8, #0x918 ; CFString: [OpusPlayer] calculateVoiceTime: invalid header
105593d94: f90003e8    	str	x8, [sp]
105593d98: b00a6525    	adrp	x5, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593d9c: 910f50a5    	add	x5, x5, #0x3d4
105593da0: b00a6527    	adrp	x7, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593da4: 91240ce7    	add	x7, x7, #0x903
105593da8: 52800082    	mov	w2, #0x4                ; =4
105593dac: d2800003    	mov	x3, #0x0                ; =0
105593db0: 52800004    	mov	w4, #0x0                ; =0
105593db4: 52804e26    	mov	w6, #0x271              ; =625
105593db8: 949a4fab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593dbc: 52800014    	mov	w20, #0x0               ; =0
105593dc0: 14000053    	b	0x105593f0c <_Flutter_MMFoundation_BindContext+0x181abd8>
105593dc4: aa1303e0    	mov	x0, x19
105593dc8: aa1403e1    	mov	x1, x20
105593dcc: 949a4fa6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593dd0: 52800648    	mov	w8, #0x32               ; =50
105593dd4: 1b087c16    	mul	w22, w0, w8
105593dd8: 93407ec0    	sxtw	x0, w22
105593ddc: 949a4e46    	bl	0x107c276f4 <_Flutter_MMFoundation_BindContext+0x3eae3c0>
105593de0: aa0003f7    	mov	x23, x0
105593de4: b9002fff    	str	wzr, [sp, #0x2c]
105593de8: aa1303e0    	mov	x0, x19
105593dec: 949a4fa3    	bl	0x107c27c78 <_Flutter_MMFoundation_BindContext+0x3eae944>
105593df0: aa1503e1    	mov	x1, x21
105593df4: 949a4f9c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593df8: aa0003f5    	mov	x21, x0
105593dfc: aa1303e0    	mov	x0, x19
105593e00: aa1403e1    	mov	x1, x20
105593e04: 949a4f98    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593e08: aa0003e2    	mov	x2, x0
105593e0c: 9100c3e0    	add	x0, sp, #0x30
105593e10: 9100b3e5    	add	x5, sp, #0x2c
105593e14: aa1503e1    	mov	x1, x21
105593e18: aa1703e3    	mov	x3, x23
105593e1c: aa1603e4    	mov	x4, x22
105593e20: 9499e047    	bl	0x107c0bf3c <_Flutter_MMFoundation_BindContext+0x3e92c08>
105593e24: aa0003f4    	mov	x20, x0
105593e28: aa1703e0    	mov	x0, x23
105593e2c: 949a4e2e    	bl	0x107c276e4 <_Flutter_MMFoundation_BindContext+0x3eae3b0>
105593e30: 9100c3e0    	add	x0, sp, #0x30
105593e34: 9499e03c    	bl	0x107c0bf24 <_Flutter_MMFoundation_BindContext+0x3e92bf0>
105593e38: 35000454    	cbnz	w20, 0x105593ec0 <_Flutter_MMFoundation_BindContext+0x181ab8c>
105593e3c: b9402fe8    	ldr	w8, [sp, #0x2c]
105593e40: 34000408    	cbz	w8, 0x105593ec0 <_Flutter_MMFoundation_BindContext+0x181ab8c>
105593e44: 29792ba9    	ldp	w9, w10, [x29, #-0x38]
105593e48: 7100053f    	cmp	w9, #0x1
105593e4c: 1a9fc529    	csinc	w9, w9, wzr, gt
105593e50: 1e220100    	scvtf	s0, w8
105593e54: 1b0a7d2b    	mul	w11, w9, w10
105593e58: 531f796b    	lsl	w11, w11, #1
105593e5c: 1e220161    	scvtf	s1, w11
105593e60: 1e211800    	fdiv	s0, s0, s1
105593e64: 52a88f4b    	mov	w11, #0x447a0000        ; =1148846080
105593e68: 1e270161    	fmov	s1, w11
105593e6c: 1e210800    	fmul	s0, s0, s1
105593e70: 1e390014    	fcvtzu	w20, s0
105593e74: f00cbbeb    	adrp	x11, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105593e78: f9430d60    	ldr	x0, [x11, #0x618]
105593e7c: d00ca1ab    	adrp	x11, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105593e80: f9418961    	ldr	x1, [x11, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
105593e84: a90127ea    	stp	x10, x9, [sp, #0x10]
105593e88: b00beb89    	adrp	x9, 0x11d304000 <dyld_stub_binder+0x11d304000>
105593e8c: 9125e129    	add	x9, x9, #0x978 ; CFString: [OpusPlayer] calculateVoiceTime: pcmBytes=%d sampleRate=%d channels=%d voiceTime=%u ms
105593e90: a90023e9    	stp	x9, x8, [sp]
105593e94: f90013f4    	str	x20, [sp, #0x20]
105593e98: b00a6525    	adrp	x5, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593e9c: 910f50a5    	add	x5, x5, #0x3d4
105593ea0: b00a6527    	adrp	x7, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593ea4: 91240ce7    	add	x7, x7, #0x903
105593ea8: 52800042    	mov	w2, #0x2                ; =2
105593eac: d2800003    	mov	x3, #0x0                ; =0
105593eb0: 52800004    	mov	w4, #0x0                ; =0
105593eb4: 52805306    	mov	w6, #0x298              ; =664
105593eb8: 949a4f6b    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593ebc: 14000012    	b	0x105593f04 <_Flutter_MMFoundation_BindContext+0x181abd0>
105593ec0: f00cbbe8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
105593ec4: f9430d00    	ldr	x0, [x8, #0x618]
105593ec8: d00ca1a8    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
105593ecc: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
105593ed0: b00beb88    	adrp	x8, 0x11d304000 <dyld_stub_binder+0x11d304000>
105593ed4: 91256108    	add	x8, x8, #0x958 ; CFString: [OpusPlayer] calculateVoiceTime: decode failed, ret=%d
105593ed8: a90053e8    	stp	x8, x20, [sp]
105593edc: b00a6525    	adrp	x5, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593ee0: 910f50a5    	add	x5, x5, #0x3d4
105593ee4: b00a6527    	adrp	x7, 0x11a238000 <dyld_stub_binder+0x11a238000>
105593ee8: 91240ce7    	add	x7, x7, #0x903
105593eec: 52800082    	mov	w2, #0x4                ; =4
105593ef0: d2800003    	mov	x3, #0x0                ; =0
105593ef4: 52800004    	mov	w4, #0x0                ; =0
105593ef8: 52805166    	mov	w6, #0x28b              ; =651
105593efc: 949a4f5a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105593f00: 52800014    	mov	w20, #0x0               ; =0
105593f04: 9100c3e0    	add	x0, sp, #0x30
105593f08: 9499e008    	bl	0x107c0bf28 <_Flutter_MMFoundation_BindContext+0x3e92bf4>
105593f0c: aa1303e0    	mov	x0, x19
105593f10: 949a4f58    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105593f14: aa1403e0    	mov	x0, x20
105593f18: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
105593f1c: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
105593f20: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
105593f24: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
105593f28: 910383ff    	add	sp, sp, #0xe0
105593f2c: d65f03c0    	ret
