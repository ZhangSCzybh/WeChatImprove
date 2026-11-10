
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1002a9bb4: d10243ff    	sub	sp, sp, #0x90
1002a9bb8: a9055ff8    	stp	x24, x23, [sp, #0x50]
1002a9bbc: a90657f6    	stp	x22, x21, [sp, #0x60]
1002a9bc0: a9074ff4    	stp	x20, x19, [sp, #0x70]
1002a9bc4: a9087bfd    	stp	x29, x30, [sp, #0x80]
1002a9bc8: 910203fd    	add	x29, sp, #0x80
1002a9bcc: aa0003f3    	mov	x19, x0
1002a9bd0: f00fa4a8    	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
1002a9bd4: 52800029    	mov	w9, #0x1                ; =1
1002a9bd8: 3923cd09    	strb	w9, [x8, #0x8f3]
1002a9bdc: f9400408    	ldr	x8, [x0, #0x8]
1002a9be0: f9401d09    	ldr	x9, [x8, #0x38]
1002a9be4: b4000ce9    	cbz	x9, 0x1002a9d80 <__text+0x2a1d80>
1002a9be8: 3941b509    	ldrb	w9, [x8, #0x6d]
1002a9bec: 7100053f    	cmp	w9, #0x1
1002a9bf0: 54000c81    	b.ne	0x1002a9d80 <__text+0x2a1d80>
1002a9bf4: 3901b51f    	strb	wzr, [x8, #0x6d]
1002a9bf8: 900cc8d5    	adrp	x21, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9bfc: 91303ab5    	add	x21, x21, #0xc0e
1002a9c00: 900cc8c2    	adrp	x2, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9c04: 9130c842    	add	x2, x2, #0xc32
1002a9c08: 910083e0    	add	x0, sp, #0x20
1002a9c0c: aa1503e1    	mov	x1, x21
1002a9c10: d2800003    	mov	x3, #0x0                ; =0
1002a9c14: 95e58bf0    	bl	0x107c0cbd4 <_Flutter_MMFoundation_BindContext+0x3e938a0>
1002a9c18: 910083e0    	add	x0, sp, #0x20
1002a9c1c: 95e58bf1    	bl	0x107c0cbe0 <_Flutter_MMFoundation_BindContext+0x3e938ac>
1002a9c20: 910083e0    	add	x0, sp, #0x20
1002a9c24: 52800081    	mov	w1, #0x4                ; =4
1002a9c28: 95e58bef    	bl	0x107c0cbe4 <_Flutter_MMFoundation_BindContext+0x3e938b0>
1002a9c2c: b00f5357    	adrp	x23, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9c30: f9430ee0    	ldr	x0, [x23, #0x618]
1002a9c34: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9c38: f9418914    	ldr	x20, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1002a9c3c: 900e68a8    	adrp	x8, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a9c40: 911ee108    	add	x8, x8, #0x7b8 ; CFString: [play_test]play stop begin
1002a9c44: f90003e8    	str	x8, [sp]
1002a9c48: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9c4c: 9120a4a5    	add	x5, x5, #0x829
1002a9c50: aa1403e1    	mov	x1, x20
1002a9c54: 52800042    	mov	w2, #0x2                ; =2
1002a9c58: d2800003    	mov	x3, #0x0                ; =0
1002a9c5c: 52800004    	mov	w4, #0x0                ; =0
1002a9c60: 52804666    	mov	w6, #0x233              ; =563
1002a9c64: aa1503e7    	mov	x7, x21
1002a9c68: 95e5f7ff    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9c6c: f9400668    	ldr	x8, [x19, #0x8]
1002a9c70: f9401d00    	ldr	x0, [x8, #0x38]
1002a9c74: 52800021    	mov	w1, #0x1                ; =1
1002a9c78: 95e5f1b5    	bl	0x107c2634c <_Flutter_MMFoundation_BindContext+0x3ead018>
1002a9c7c: f00e6798    	adrp	x24, 0x11cf9c000 <dyld_stub_binder+0x11cf9c000>
1002a9c80: 910ce318    	add	x24, x24, #0x338 ; CFString: throw %s,%d: %s
1002a9c84: 34000260    	cbz	w0, 0x1002a9cd0 <__text+0x2a1cd0>
1002a9c88: aa0003f5    	mov	x21, x0
1002a9c8c: f9430ef6    	ldr	x22, [x23, #0x618]
1002a9c90: 95e58b8e    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a9c94: 900cc728    	adrp	x8, 0x119b8d000 <dyld_stub_binder+0x119b8d000>
1002a9c98: 911a0508    	add	x8, x8, #0x681
1002a9c9c: a90123f5    	stp	x21, x8, [sp, #0x10]
1002a9ca0: a90003f8    	stp	x24, x0, [sp]
1002a9ca4: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9ca8: 9120a4a5    	add	x5, x5, #0x829
1002a9cac: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9cb0: 913038e7    	add	x7, x7, #0xc0e
1002a9cb4: aa1603e0    	mov	x0, x22
1002a9cb8: aa1403e1    	mov	x1, x20
1002a9cbc: 52800082    	mov	w2, #0x4                ; =4
1002a9cc0: d2800003    	mov	x3, #0x0                ; =0
1002a9cc4: 52800004    	mov	w4, #0x0                ; =0
1002a9cc8: 52804686    	mov	w6, #0x234              ; =564
1002a9ccc: 95e5f7e6    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9cd0: f9400668    	ldr	x8, [x19, #0x8]
1002a9cd4: f9401d00    	ldr	x0, [x8, #0x38]
1002a9cd8: 52800021    	mov	w1, #0x1                ; =1
1002a9cdc: 95e5f18e    	bl	0x107c26314 <_Flutter_MMFoundation_BindContext+0x3eacfe0>
1002a9ce0: 34000260    	cbz	w0, 0x1002a9d2c <__text+0x2a1d2c>
1002a9ce4: aa0003f5    	mov	x21, x0
1002a9ce8: f9430ef6    	ldr	x22, [x23, #0x618]
1002a9cec: 95e58b77    	bl	0x107c0cac8 <_Flutter_MMFoundation_BindContext+0x3e93794>
1002a9cf0: b00cc728    	adrp	x8, 0x119b8e000 <dyld_stub_binder+0x119b8e000>
1002a9cf4: 91012d08    	add	x8, x8, #0x4b
1002a9cf8: a90123f5    	stp	x21, x8, [sp, #0x10]
1002a9cfc: a90003f8    	stp	x24, x0, [sp]
1002a9d00: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9d04: 9120a4a5    	add	x5, x5, #0x829
1002a9d08: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9d0c: 913038e7    	add	x7, x7, #0xc0e
1002a9d10: aa1603e0    	mov	x0, x22
1002a9d14: aa1403e1    	mov	x1, x20
1002a9d18: 52800082    	mov	w2, #0x4                ; =4
1002a9d1c: d2800003    	mov	x3, #0x0                ; =0
1002a9d20: 52800004    	mov	w4, #0x0                ; =0
1002a9d24: 528046a6    	mov	w6, #0x235              ; =565
1002a9d28: 95e5f7cf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9d2c: f9400668    	ldr	x8, [x19, #0x8]
1002a9d30: f9001d1f    	str	xzr, [x8, #0x38]
1002a9d34: f9430ee0    	ldr	x0, [x23, #0x618]
1002a9d38: 900e68a8    	adrp	x8, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a9d3c: 911f6108    	add	x8, x8, #0x7d8 ; CFString: [play_test]play stop end
1002a9d40: f90003e8    	str	x8, [sp]
1002a9d44: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9d48: 9120a4a5    	add	x5, x5, #0x829
1002a9d4c: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9d50: 913038e7    	add	x7, x7, #0xc0e
1002a9d54: aa1403e1    	mov	x1, x20
1002a9d58: 52800022    	mov	w2, #0x1                ; =1
1002a9d5c: d2800003    	mov	x3, #0x0                ; =0
1002a9d60: 52800004    	mov	w4, #0x0                ; =0
1002a9d64: 528046e6    	mov	w6, #0x237              ; =567
1002a9d68: 95e5f7bf    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9d6c: 910083e0    	add	x0, sp, #0x20
1002a9d70: 95e58b9a    	bl	0x107c0cbd8 <_Flutter_MMFoundation_BindContext+0x3e938a4>
1002a9d74: 910083e0    	add	x0, sp, #0x20
1002a9d78: 95e58b99    	bl	0x107c0cbdc <_Flutter_MMFoundation_BindContext+0x3e938a8>
1002a9d7c: f9400668    	ldr	x8, [x19, #0x8]
1002a9d80: 3941b108    	ldrb	w8, [x8, #0x6c]
1002a9d84: 7100051f    	cmp	w8, #0x1
1002a9d88: 54000761    	b.ne	0x1002a9e74 <__text+0x2a1e74>
1002a9d8c: b00f3988    	adrp	x8, 0x11e9da000 <dyld_stub_binder+0x11e9da000>
1002a9d90: f9452901    	ldr	x1, [x8, #0xa50] ; selector: unregisterNotification
1002a9d94: aa1303e0    	mov	x0, x19
1002a9d98: 95e5f7b3    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9d9c: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9da0: f9430d00    	ldr	x0, [x8, #0x618]
1002a9da4: f9400668    	ldr	x8, [x19, #0x8]
1002a9da8: 900f3909    	adrp	x9, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9dac: f9418921    	ldr	x1, [x9, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
1002a9db0: b9406908    	ldr	w8, [x8, #0x68]
1002a9db4: 900e68a9    	adrp	x9, 0x11cfbd000 <dyld_stub_binder+0x11cfbd000>
1002a9db8: 911fe129    	add	x9, x9, #0x7f8 ; CFString: soundControlMode:%d
1002a9dbc: a90023e9    	stp	x9, x8, [sp]
1002a9dc0: 900cc8c5    	adrp	x5, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9dc4: 9120a4a5    	add	x5, x5, #0x829
1002a9dc8: 900cc8c7    	adrp	x7, 0x119bc1000 <dyld_stub_binder+0x119bc1000>
1002a9dcc: 913038e7    	add	x7, x7, #0xc0e
1002a9dd0: 52800042    	mov	w2, #0x2                ; =2
1002a9dd4: d2800003    	mov	x3, #0x0                ; =0
1002a9dd8: 52800004    	mov	w4, #0x0                ; =0
1002a9ddc: 528047a6    	mov	w6, #0x23d              ; =573
1002a9de0: 95e5f7a1    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9de4: f9400668    	ldr	x8, [x19, #0x8]
1002a9de8: b9406909    	ldr	w9, [x8, #0x68]
1002a9dec: 321f0129    	orr	w9, w9, #0x2
1002a9df0: 71000d3f    	cmp	w9, #0x3
1002a9df4: 540003e1    	b.ne	0x1002a9e70 <__text+0x2a1e70>
1002a9df8: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9dfc: f943c100    	ldr	x0, [x8, #0x780]
1002a9e00: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9e04: f9440101    	ldr	x1, [x8, #0x800] ; selector: currentContext
1002a9e08: 95e5f797    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9e0c: aa1d03fd    	mov	x29, x29
1002a9e10: 95e5f79c    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a9e14: aa0003f4    	mov	x20, x0
1002a9e18: b00f5348    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1002a9e1c: f9446900    	ldr	x0, [x8, #0x8d0]
1002a9e20: b00f4fe8    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1002a9e24: f9428501    	ldr	x1, [x8, #0x508] ; selector: class
1002a9e28: 95e5f78f    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9e2c: aa0003e2    	mov	x2, x0
1002a9e30: 900f3908    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1002a9e34: f9452101    	ldr	x1, [x8, #0xa40] ; selector: getService:
1002a9e38: aa1403e0    	mov	x0, x20
1002a9e3c: 95e5f78a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9e40: aa1d03fd    	mov	x29, x29
1002a9e44: 95e5f78f    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a9e48: aa0003f5    	mov	x21, x0
1002a9e4c: b00f3908    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
1002a9e50: f9401101    	ldr	x1, [x8, #0x20] ; selector: StopProximityMonitorWithObject:
1002a9e54: aa1303e2    	mov	x2, x19
1002a9e58: 95e5f783    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9e5c: aa1503e0    	mov	x0, x21
1002a9e60: 95e5f784    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9e64: aa1403e0    	mov	x0, x20
1002a9e68: 95e5f782    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9e6c: f9400668    	ldr	x8, [x19, #0x8]
1002a9e70: 3901b11f    	strb	wzr, [x8, #0x6c]
1002a9e74: d00f3948    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1002a9e78: f9449914    	ldr	x20, [x8, #0x930] ; selector: meterTimer
1002a9e7c: aa1303e0    	mov	x0, x19
1002a9e80: aa1403e1    	mov	x1, x20
1002a9e84: 95e5f778    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9e88: aa1d03fd    	mov	x29, x29
1002a9e8c: 95e5f77d    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a9e90: aa0003f5    	mov	x21, x0
1002a9e94: 95e5f777    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9e98: b4000235    	cbz	x21, 0x1002a9edc <__text+0x2a1edc>
1002a9e9c: aa1303e0    	mov	x0, x19
1002a9ea0: aa1403e1    	mov	x1, x20
1002a9ea4: 95e5f770    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9ea8: aa1d03fd    	mov	x29, x29
1002a9eac: 95e5f775    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1002a9eb0: aa0003f4    	mov	x20, x0
1002a9eb4: f00f4fe8    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1002a9eb8: f9433101    	ldr	x1, [x8, #0x660] ; selector: invalidate
1002a9ebc: 95e5f76a    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9ec0: aa1403e0    	mov	x0, x20
1002a9ec4: 95e5f76b    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1002a9ec8: d00f3948    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1002a9ecc: f944b101    	ldr	x1, [x8, #0x960] ; selector: setMeterTimer:
1002a9ed0: aa1303e0    	mov	x0, x19
1002a9ed4: d2800002    	mov	x2, #0x0                ; =0
1002a9ed8: 95e5f763    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1002a9edc: a9487bfd    	ldp	x29, x30, [sp, #0x80]
1002a9ee0: a9474ff4    	ldp	x20, x19, [sp, #0x70]
1002a9ee4: a94657f6    	ldp	x22, x21, [sp, #0x60]
1002a9ee8: a9455ff8    	ldp	x24, x23, [sp, #0x50]
1002a9eec: 910243ff    	add	sp, sp, #0x90
1002a9ef0: d65f03c0    	ret
