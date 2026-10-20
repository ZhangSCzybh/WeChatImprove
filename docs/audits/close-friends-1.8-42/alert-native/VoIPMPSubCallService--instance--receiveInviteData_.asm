
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106169af4: d10203ff    	sub	sp, sp, #0x80
106169af8: a9026ffc    	stp	x28, x27, [sp, #0x20]
106169afc: a90367fa    	stp	x26, x25, [sp, #0x30]
106169b00: a9045ff8    	stp	x24, x23, [sp, #0x40]
106169b04: a90557f6    	stp	x22, x21, [sp, #0x50]
106169b08: a9064ff4    	stp	x20, x19, [sp, #0x60]
106169b0c: a9077bfd    	stp	x29, x30, [sp, #0x70]
106169b10: 9101c3fd    	add	x29, sp, #0x70
106169b14: aa0203f3    	mov	x19, x2
106169b18: aa0003f5    	mov	x21, x0
106169b1c: d00d56c8    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
106169b20: 52800029    	mov	w9, #0x1                ; =1
106169b24: 391bb909    	strb	w9, [x8, #0x6ee]
106169b28: aa0203e0    	mov	x0, x2
106169b2c: 946af583    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106169b30: 52800040    	mov	w0, #0x2                ; =2
106169b34: 946a8dc3    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106169b38: 34000560    	cbz	w0, 0x106169be4 <_Flutter_MMFoundation_BindContext+0x26457c8>
106169b3c: 946af599    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106169b40: aa0003f4    	mov	x20, x0
106169b44: d00d0057    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
106169b48: f94546e0    	ldr	x0, [x23, #0xa88]
106169b4c: 946af585    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106169b50: aa0003f6    	mov	x22, x0
106169b54: f94546e0    	ldr	x0, [x23, #0xa88]
106169b58: b00cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106169b5c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106169b60: f90003ff    	str	xzr, [sp]
106169b64: d00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
106169b68: 9139a042    	add	x2, x2, #0xe68 ; cfstring='Prepare to receive invite data ...'
106169b6c: 946af574    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169b70: aa1d03fd    	mov	x29, x29
106169b74: 946af575    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169b78: aa0003f7    	mov	x23, x0
106169b7c: b00cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106169b80: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106169b84: d00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169b88: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106169b8c: a90003e8    	stp	x8, x0, [sp]
106169b90: d00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169b94: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106169b98: aa1603e0    	mov	x0, x22
106169b9c: 946af568    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169ba0: aa0003f6    	mov	x22, x0
106169ba4: aa1703e0    	mov	x0, x23
106169ba8: 946af56b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169bac: d00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106169bb0: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
106169bb4: d00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169bb8: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
106169bbc: d00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169bc0: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
106169bc4: 52800040    	mov	w0, #0x2                ; =2
106169bc8: 52802a43    	mov	w3, #0x152              ; =338
106169bcc: aa1603e5    	mov	x5, x22
106169bd0: 946a8d9d    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106169bd4: aa1603e0    	mov	x0, x22
106169bd8: 946af55f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169bdc: aa1403e0    	mov	x0, x20
106169be0: 946af573    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106169be4: 900ce6a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106169be8: f9474d16    	ldr	x22, [x8, #0xe98] ; selector=cache
106169bec: aa1503e0    	mov	x0, x21
106169bf0: aa1603e1    	mov	x1, x22
106169bf4: 946af552    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169bf8: aa1d03fd    	mov	x29, x29
106169bfc: 946af553    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169c00: aa0003f4    	mov	x20, x0
106169c04: 946af554    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169c08: b4001934    	cbz	x20, 0x106169f2c <_Flutter_MMFoundation_BindContext+0x2645b10>
106169c0c: aa1503e0    	mov	x0, x21
106169c10: aa1603e1    	mov	x1, x22
106169c14: 946af54a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169c18: aa1d03fd    	mov	x29, x29
106169c1c: 946af54b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169c20: aa0003f4    	mov	x20, x0
106169c24: d00cfce8    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
106169c28: f944a901    	ldr	x1, [x8, #0x950] ; selector=setData:
106169c2c: aa1303e2    	mov	x2, x19
106169c30: 946af543    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169c34: aa1403e0    	mov	x0, x20
106169c38: 946af547    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169c3c: d00d00e8    	adrp	x8, 0x120187000 <dyld_stub_binder+0x120187000>
106169c40: f9442900    	ldr	x0, [x8, #0x850] ; class=ConfRecvInviteInfo
106169c44: 900ce6a8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106169c48: f9435101    	ldr	x1, [x8, #0x6a0] ; selector=parseFromData:
106169c4c: aa1303e2    	mov	x2, x19
106169c50: 946af53b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169c54: aa1d03fd    	mov	x29, x29
106169c58: 946af53c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169c5c: aa0003f4    	mov	x20, x0
106169c60: 52800040    	mov	w0, #0x2                ; =2
106169c64: 946a8d77    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106169c68: 34000560    	cbz	w0, 0x106169d14 <_Flutter_MMFoundation_BindContext+0x26458f8>
106169c6c: 946af54d    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106169c70: aa0003f7    	mov	x23, x0
106169c74: d00d0059    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
106169c78: f9454720    	ldr	x0, [x25, #0xa88]
106169c7c: 946af539    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106169c80: aa0003f8    	mov	x24, x0
106169c84: f9454720    	ldr	x0, [x25, #0xa88]
106169c88: b00cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106169c8c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106169c90: a9007ff4    	stp	x20, xzr, [sp]
106169c94: d00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
106169c98: 913aa042    	add	x2, x2, #0xea8 ; cfstring='Finish to parse invite info! (%@)'
106169c9c: 946af528    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169ca0: aa1d03fd    	mov	x29, x29
106169ca4: 946af529    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169ca8: aa0003f9    	mov	x25, x0
106169cac: b00cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106169cb0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106169cb4: d00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169cb8: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106169cbc: a90003e8    	stp	x8, x0, [sp]
106169cc0: d00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169cc4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106169cc8: aa1803e0    	mov	x0, x24
106169ccc: 946af51c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169cd0: aa0003f8    	mov	x24, x0
106169cd4: aa1903e0    	mov	x0, x25
106169cd8: 946af51f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169cdc: d00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106169ce0: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
106169ce4: d00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169ce8: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
106169cec: d00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169cf0: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
106169cf4: 52800040    	mov	w0, #0x2                ; =2
106169cf8: 52802b83    	mov	w3, #0x15c              ; =348
106169cfc: aa1803e5    	mov	x5, x24
106169d00: 946a8d51    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106169d04: aa1803e0    	mov	x0, x24
106169d08: 946af513    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169d0c: aa1703e0    	mov	x0, x23
106169d10: 946af527    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106169d14: b00ce728    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
106169d18: f9450518    	ldr	x24, [x8, #0xa08] ; selector=roomid
106169d1c: aa1403e0    	mov	x0, x20
106169d20: aa1803e1    	mov	x1, x24
106169d24: 946af506    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169d28: aa0003f7    	mov	x23, x0
106169d2c: aa1503e0    	mov	x0, x21
106169d30: aa1603e1    	mov	x1, x22
106169d34: 946af502    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169d38: aa1d03fd    	mov	x29, x29
106169d3c: 946af503    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169d40: aa0003f9    	mov	x25, x0
106169d44: d00cf328    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106169d48: f9459101    	ldr	x1, [x8, #0xb20] ; selector=inviteMsg
106169d4c: 946af4fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169d50: aa1d03fd    	mov	x29, x29
106169d54: 946af4fd    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169d58: aa0003fa    	mov	x26, x0
106169d5c: aa1803e1    	mov	x1, x24
106169d60: 946af4f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169d64: aa0003fb    	mov	x27, x0
106169d68: aa1a03e0    	mov	x0, x26
106169d6c: 946af4fa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169d70: aa1903e0    	mov	x0, x25
106169d74: 946af4f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169d78: eb1b02ff    	cmp	x23, x27
106169d7c: 54001461    	b.ne	0x10616a008 <_Flutter_MMFoundation_BindContext+0x2645bec>
106169d80: b00cec68    	adrp	x8, 0x11fef6000 <dyld_stub_binder+0x11fef6000>
106169d84: f942a101    	ldr	x1, [x8, #0x540] ; selector=subCall
106169d88: aa1403e0    	mov	x0, x20
106169d8c: 946af4ec    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169d90: 36001d80    	tbz	w0, #0x0, 0x10616a140 <_Flutter_MMFoundation_BindContext+0x2645d24>
106169d94: aa1503e0    	mov	x0, x21
106169d98: aa1603e1    	mov	x1, x22
106169d9c: 946af4e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169da0: aa1d03fd    	mov	x29, x29
106169da4: 946af4e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169da8: aa0003f7    	mov	x23, x0
106169dac: d00cf328    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
106169db0: f9458901    	ldr	x1, [x8, #0xb10] ; selector=setInviteInfo:
106169db4: aa1403e2    	mov	x2, x20
106169db8: 946af4e1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169dbc: aa1703e0    	mov	x0, x23
106169dc0: 946af4e5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169dc4: 900cf348    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
106169dc8: f940b917    	ldr	x23, [x8, #0x170] ; selector=subAppid
106169dcc: aa1403e0    	mov	x0, x20
106169dd0: aa1703e1    	mov	x1, x23
106169dd4: 946af4da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169dd8: aa1d03fd    	mov	x29, x29
106169ddc: 946af4db    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169de0: aa0003f9    	mov	x25, x0
106169de4: d00cfcc8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106169de8: f943c918    	ldr	x24, [x8, #0x790] ; selector=isEqualToString:
106169dec: b00c27e2    	adrp	x2, 0x11e666000 <dyld_stub_binder+0x11e666000>
106169df0: 9104a042    	add	x2, x2, #0x128 ; cfstring='voip-2p'
106169df4: aa1803e1    	mov	x1, x24
106169df8: 946af4d1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169dfc: aa0003fa    	mov	x26, x0
106169e00: aa1903e0    	mov	x0, x25
106169e04: 946af4d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169e08: 34001eda    	cbz	w26, 0x10616a1e0 <_Flutter_MMFoundation_BindContext+0x2645dc4>
106169e0c: d00ce7e8    	adrp	x8, 0x11fe67000 <dyld_stub_binder+0x11fe67000>
106169e10: f9438501    	ldr	x1, [x8, #0x708] ; selector=usernameList
106169e14: aa1403e0    	mov	x0, x20
106169e18: 946af4c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169e1c: aa1d03fd    	mov	x29, x29
106169e20: 946af4ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169e24: aa0003f7    	mov	x23, x0
106169e28: f00cfca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106169e2c: f9435101    	ldr	x1, [x8, #0x6a0] ; selector=count
106169e30: 946af4c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169e34: aa0003f8    	mov	x24, x0
106169e38: aa1703e0    	mov	x0, x23
106169e3c: 946af4c6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169e40: b40032d8    	cbz	x24, 0x10616a498 <_Flutter_MMFoundation_BindContext+0x264607c>
106169e44: 52800040    	mov	w0, #0x2                ; =2
106169e48: 946a8cfe    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106169e4c: 34000560    	cbz	w0, 0x106169ef8 <_Flutter_MMFoundation_BindContext+0x2645adc>
106169e50: 946af4d4    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106169e54: aa0003f7    	mov	x23, x0
106169e58: d00d0059    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
106169e5c: f9454720    	ldr	x0, [x25, #0xa88]
106169e60: 946af4c0    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106169e64: aa0003f8    	mov	x24, x0
106169e68: f9454720    	ldr	x0, [x25, #0xa88]
106169e6c: b00cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106169e70: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106169e74: f90003ff    	str	xzr, [sp]
106169e78: d00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
106169e7c: 913ba042    	add	x2, x2, #0xee8 ; cfstring='It is 2p to multitalk'
106169e80: 946af4af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169e84: aa1d03fd    	mov	x29, x29
106169e88: 946af4b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169e8c: aa0003f9    	mov	x25, x0
106169e90: b00cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106169e94: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106169e98: d00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169e9c: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106169ea0: a90003e8    	stp	x8, x0, [sp]
106169ea4: d00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169ea8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106169eac: aa1803e0    	mov	x0, x24
106169eb0: 946af4a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169eb4: aa0003f8    	mov	x24, x0
106169eb8: aa1903e0    	mov	x0, x25
106169ebc: 946af4a6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169ec0: d00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106169ec4: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
106169ec8: d00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169ecc: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
106169ed0: d00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169ed4: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
106169ed8: 52800040    	mov	w0, #0x2                ; =2
106169edc: 52802dc3    	mov	w3, #0x16e              ; =366
106169ee0: aa1803e5    	mov	x5, x24
106169ee4: 946a8cd8    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106169ee8: aa1803e0    	mov	x0, x24
106169eec: 946af49a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169ef0: aa1703e0    	mov	x0, x23
106169ef4: 946af4ae    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
106169ef8: aa1503e0    	mov	x0, x21
106169efc: aa1603e1    	mov	x1, x22
106169f00: 946af48f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169f04: aa1d03fd    	mov	x29, x29
106169f08: 946af490    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169f0c: aa0003f7    	mov	x23, x0
106169f10: 900cf348    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
106169f14: f940bd01    	ldr	x1, [x8, #0x178] ; selector=setIsChangeToMultitalk:
106169f18: 52800022    	mov	w2, #0x1                ; =1
106169f1c: 946af488    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169f20: aa1703e0    	mov	x0, x23
106169f24: 946af48c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169f28: 140000e9    	b	0x10616a2cc <_Flutter_MMFoundation_BindContext+0x2645eb0>
106169f2c: 52800040    	mov	w0, #0x2                ; =2
106169f30: 946a8cc4    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
106169f34: 34003ec0    	cbz	w0, 0x10616a70c <_Flutter_MMFoundation_BindContext+0x26462f0>
106169f38: 946af49a    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
106169f3c: aa0003f4    	mov	x20, x0
106169f40: d00d0058    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
106169f44: f9454700    	ldr	x0, [x24, #0xa88]
106169f48: 946af486    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
106169f4c: aa0003f7    	mov	x23, x0
106169f50: f9454718    	ldr	x24, [x24, #0xa88]
106169f54: aa1503e0    	mov	x0, x21
106169f58: aa1603e1    	mov	x1, x22
106169f5c: 946af478    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169f60: aa1d03fd    	mov	x29, x29
106169f64: 946af479    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169f68: aa0003f5    	mov	x21, x0
106169f6c: b00cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106169f70: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
106169f74: a9007fe0    	stp	x0, xzr, [sp]
106169f78: d00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
106169f7c: 913a2042    	add	x2, x2, #0xe88 ; cfstring="It should't handle call! (%@)"
106169f80: aa1803e0    	mov	x0, x24
106169f84: 946af46e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169f88: aa1d03fd    	mov	x29, x29
106169f8c: 946af46f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106169f90: aa0003f6    	mov	x22, x0
106169f94: b00cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
106169f98: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
106169f9c: d00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169fa0: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
106169fa4: a90003e8    	stp	x8, x0, [sp]
106169fa8: d00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
106169fac: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
106169fb0: aa1703e0    	mov	x0, x23
106169fb4: 946af462    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106169fb8: aa0003f7    	mov	x23, x0
106169fbc: aa1603e0    	mov	x0, x22
106169fc0: 946af465    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169fc4: aa1503e0    	mov	x0, x21
106169fc8: 946af463    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169fcc: d00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
106169fd0: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
106169fd4: d00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169fd8: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
106169fdc: d00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
106169fe0: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
106169fe4: 52800040    	mov	w0, #0x2                ; =2
106169fe8: 52802aa3    	mov	w3, #0x155              ; =341
106169fec: aa1703e5    	mov	x5, x23
106169ff0: 946a8c95    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
106169ff4: aa1703e0    	mov	x0, x23
106169ff8: 946af457    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106169ffc: aa1403e0    	mov	x0, x20
10616a000: 946af46b    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a004: 140001c2    	b	0x10616a70c <_Flutter_MMFoundation_BindContext+0x26462f0>
10616a008: 52800080    	mov	w0, #0x4                ; =4
10616a00c: 946a8c8d    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a010: 340037a0    	cbz	w0, 0x10616a704 <_Flutter_MMFoundation_BindContext+0x26462e8>
10616a014: 946af463    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a018: aa0003f7    	mov	x23, x0
10616a01c: b00d005a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
10616a020: f9454740    	ldr	x0, [x26, #0xa88]
10616a024: 946af44f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a028: aa0003f9    	mov	x25, x0
10616a02c: f945475a    	ldr	x26, [x26, #0xa88]
10616a030: b00d0048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616a034: f945891b    	ldr	x27, [x8, #0xb10]
10616a038: aa1503e0    	mov	x0, x21
10616a03c: aa1603e1    	mov	x1, x22
10616a040: 946af43f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a044: aa1d03fd    	mov	x29, x29
10616a048: 946af440    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a04c: aa0003f5    	mov	x21, x0
10616a050: b00cf328    	adrp	x8, 0x11ffcf000 <dyld_stub_binder+0x11ffcf000>
10616a054: f9459501    	ldr	x1, [x8, #0xb28] ; selector=inviteInfo
10616a058: 946af439    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a05c: aa1d03fd    	mov	x29, x29
10616a060: 946af43a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a064: aa0003f6    	mov	x22, x0
10616a068: aa1803e1    	mov	x1, x24
10616a06c: 946af434    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a070: aa0003e2    	mov	x2, x0
10616a074: d00cfcc8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10616a078: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
10616a07c: aa1b03e0    	mov	x0, x27
10616a080: 946af42f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a084: aa1d03fd    	mov	x29, x29
10616a088: 946af430    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a08c: aa0003f8    	mov	x24, x0
10616a090: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a094: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a098: a900ffe0    	stp	x0, xzr, [sp, #0x8]
10616a09c: f90003f4    	str	x20, [sp]
10616a0a0: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a0a4: 91342042    	add	x2, x2, #0xd08 ; cfstring='It is not the same call! (%@, %@)'
10616a0a8: aa1a03e0    	mov	x0, x26
10616a0ac: 946af424    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a0b0: aa1d03fd    	mov	x29, x29
10616a0b4: 946af425    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a0b8: aa0003fa    	mov	x26, x0
10616a0bc: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a0c0: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a0c4: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a0c8: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616a0cc: a90003e8    	stp	x8, x0, [sp]
10616a0d0: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a0d4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a0d8: aa1903e0    	mov	x0, x25
10616a0dc: 946af418    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a0e0: aa0003f9    	mov	x25, x0
10616a0e4: aa1a03e0    	mov	x0, x26
10616a0e8: 946af41b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a0ec: aa1803e0    	mov	x0, x24
10616a0f0: 946af419    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a0f4: aa1603e0    	mov	x0, x22
10616a0f8: 946af417    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a0fc: aa1503e0    	mov	x0, x21
10616a100: 946af415    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a104: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a108: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a10c: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a110: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a114: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a118: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a11c: 52800080    	mov	w0, #0x4                ; =4
10616a120: 52802bc3    	mov	w3, #0x15e              ; =350
10616a124: aa1903e5    	mov	x5, x25
10616a128: 946a8c47    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a12c: aa1903e0    	mov	x0, x25
10616a130: 946af409    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a134: aa1703e0    	mov	x0, x23
10616a138: 946af41d    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a13c: 14000172    	b	0x10616a704 <_Flutter_MMFoundation_BindContext+0x26462e8>
10616a140: 52800080    	mov	w0, #0x4                ; =4
10616a144: 946a8c3f    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a148: 34002d60    	cbz	w0, 0x10616a6f4 <_Flutter_MMFoundation_BindContext+0x26462d8>
10616a14c: 946af415    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a150: aa0003f6    	mov	x22, x0
10616a154: b00d0058    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10616a158: f9454700    	ldr	x0, [x24, #0xa88]
10616a15c: 946af401    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a160: aa0003f7    	mov	x23, x0
10616a164: f9454700    	ldr	x0, [x24, #0xa88]
10616a168: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a16c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a170: a9007ff4    	stp	x20, xzr, [sp]
10616a174: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a178: 913b2042    	add	x2, x2, #0xec8 ; cfstring='It is not sub call! (%@)'
10616a17c: 946af3f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a180: aa1d03fd    	mov	x29, x29
10616a184: 946af3f1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a188: aa0003f8    	mov	x24, x0
10616a18c: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a190: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a194: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a198: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616a19c: a90003e8    	stp	x8, x0, [sp]
10616a1a0: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a1a4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a1a8: aa1703e0    	mov	x0, x23
10616a1ac: 946af3e4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a1b0: aa0003f7    	mov	x23, x0
10616a1b4: aa1803e0    	mov	x0, x24
10616a1b8: 946af3e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a1bc: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a1c0: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a1c4: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a1c8: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a1cc: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a1d0: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a1d4: 52800080    	mov	w0, #0x4                ; =4
10616a1d8: 52802c83    	mov	w3, #0x164              ; =356
10616a1dc: 14000140    	b	0x10616a6dc <_Flutter_MMFoundation_BindContext+0x26462c0>
10616a1e0: aa1403e0    	mov	x0, x20
10616a1e4: aa1703e1    	mov	x1, x23
10616a1e8: 946af3d5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a1ec: aa1d03fd    	mov	x29, x29
10616a1f0: 946af3d6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a1f4: aa0003f7    	mov	x23, x0
10616a1f8: 900c27e2    	adrp	x2, 0x11e666000 <dyld_stub_binder+0x11e666000>
10616a1fc: 9109a042    	add	x2, x2, #0x268 ; cfstring='voip-mt'
10616a200: aa1803e1    	mov	x1, x24
10616a204: 946af3ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a208: aa0003f8    	mov	x24, x0
10616a20c: aa1703e0    	mov	x0, x23
10616a210: 946af3d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a214: 34002178    	cbz	w24, 0x10616a640 <_Flutter_MMFoundation_BindContext+0x2646224>
10616a218: 52800040    	mov	w0, #0x2                ; =2
10616a21c: 946a8c09    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a220: 34000560    	cbz	w0, 0x10616a2cc <_Flutter_MMFoundation_BindContext+0x2645eb0>
10616a224: 946af3df    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a228: aa0003f7    	mov	x23, x0
10616a22c: b00d0059    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10616a230: f9454720    	ldr	x0, [x25, #0xa88]
10616a234: 946af3cb    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a238: aa0003f8    	mov	x24, x0
10616a23c: f9454720    	ldr	x0, [x25, #0xa88]
10616a240: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a244: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a248: f90003ff    	str	xzr, [sp]
10616a24c: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a250: 913d2042    	add	x2, x2, #0xf48 ; cfstring='It is multitalk'
10616a254: 946af3ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a258: aa1d03fd    	mov	x29, x29
10616a25c: 946af3bb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a260: aa0003f9    	mov	x25, x0
10616a264: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a268: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a26c: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a270: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616a274: a90003e8    	stp	x8, x0, [sp]
10616a278: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a27c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a280: aa1803e0    	mov	x0, x24
10616a284: 946af3ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a288: aa0003f8    	mov	x24, x0
10616a28c: aa1903e0    	mov	x0, x25
10616a290: 946af3b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a294: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a298: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a29c: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a2a0: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a2a4: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a2a8: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a2ac: 52800040    	mov	w0, #0x2                ; =2
10616a2b0: 52802f63    	mov	w3, #0x17b              ; =379
10616a2b4: aa1803e5    	mov	x5, x24
10616a2b8: 946a8be3    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a2bc: aa1803e0    	mov	x0, x24
10616a2c0: 946af3a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a2c4: aa1703e0    	mov	x0, x23
10616a2c8: 946af3b9    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a2cc: 52800077    	mov	w23, #0x3               ; =3
10616a2d0: aa1503e0    	mov	x0, x21
10616a2d4: aa1603e1    	mov	x1, x22
10616a2d8: 946af399    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a2dc: aa1d03fd    	mov	x29, x29
10616a2e0: 946af39a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a2e4: aa0003f8    	mov	x24, x0
10616a2e8: 900cf308    	adrp	x8, 0x11ffca000 <dyld_stub_binder+0x11ffca000>
10616a2ec: f9450901    	ldr	x1, [x8, #0xa10] ; selector=setInviteType:
10616a2f0: aa1703e2    	mov	x2, x23
10616a2f4: 946af392    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a2f8: aa1803e0    	mov	x0, x24
10616a2fc: 946af396    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a300: aa1503e0    	mov	x0, x21
10616a304: aa1603e1    	mov	x1, x22
10616a308: 946af38d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a30c: aa1d03fd    	mov	x29, x29
10616a310: 946af38e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a314: aa0003f7    	mov	x23, x0
10616a318: f00cf328    	adrp	x8, 0x11ffd1000 <dyld_stub_binder+0x11ffd1000>
10616a31c: f940c101    	ldr	x1, [x8, #0x180] ; selector=inviteMonoMsg
10616a320: 946af387    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a324: aa1d03fd    	mov	x29, x29
10616a328: 946af388    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a32c: aa0003f6    	mov	x22, x0
10616a330: aa1703e0    	mov	x0, x23
10616a334: 946af388    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a338: b4000496    	cbz	x22, 0x10616a3c8 <_Flutter_MMFoundation_BindContext+0x2645fac>
10616a33c: f00ce668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10616a340: f946d101    	ldr	x1, [x8, #0xda0] ; selector=setM_delegate:
10616a344: aa1603e0    	mov	x0, x22
10616a348: aa1503e2    	mov	x2, x21
10616a34c: 946af37c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a350: b00d0048    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10616a354: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
10616a358: d00cfca8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10616a35c: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
10616a360: 946af377    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a364: aa1d03fd    	mov	x29, x29
10616a368: 946af378    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a36c: aa0003f5    	mov	x21, x0
10616a370: b00d0128    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
10616a374: f9473900    	ldr	x0, [x8, #0xe70] ; class=MonoServiceMsgMgr
10616a378: b00cfca8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10616a37c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector=class
10616a380: 946af36f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a384: aa0003e2    	mov	x2, x0
10616a388: f00ce668    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10616a38c: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
10616a390: aa1503e0    	mov	x0, x21
10616a394: 946af36a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a398: aa1d03fd    	mov	x29, x29
10616a39c: 946af36b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a3a0: aa0003f7    	mov	x23, x0
10616a3a4: d00cf148    	adrp	x8, 0x11ff94000 <dyld_stub_binder+0x11ff94000>
10616a3a8: f945e501    	ldr	x1, [x8, #0xbc8] ; selector=inQueueMsg:
10616a3ac: aa1603e2    	mov	x2, x22
10616a3b0: 946af363    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a3b4: aa1703e0    	mov	x0, x23
10616a3b8: 946af367    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a3bc: aa1503e0    	mov	x0, x21
10616a3c0: 946af365    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a3c4: 14000032    	b	0x10616a48c <_Flutter_MMFoundation_BindContext+0x2646070>
10616a3c8: 52800080    	mov	w0, #0x4                ; =4
10616a3cc: 946a8b9d    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a3d0: 34000560    	cbz	w0, 0x10616a47c <_Flutter_MMFoundation_BindContext+0x2646060>
10616a3d4: 946af373    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a3d8: aa0003f7    	mov	x23, x0
10616a3dc: b00d0059    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10616a3e0: f9454720    	ldr	x0, [x25, #0xa88]
10616a3e4: 946af35f    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a3e8: aa0003f8    	mov	x24, x0
10616a3ec: f9454720    	ldr	x0, [x25, #0xa88]
10616a3f0: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a3f4: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a3f8: f90003ff    	str	xzr, [sp]
10616a3fc: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a400: 913e2042    	add	x2, x2, #0xf88 ; cfstring='None monoMsg!'
10616a404: 946af34e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a408: aa1d03fd    	mov	x29, x29
10616a40c: 946af34f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a410: aa0003f9    	mov	x25, x0
10616a414: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a418: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a41c: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a420: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616a424: a90003e8    	stp	x8, x0, [sp]
10616a428: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a42c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a430: aa1803e0    	mov	x0, x24
10616a434: 946af342    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a438: aa0003f8    	mov	x24, x0
10616a43c: aa1903e0    	mov	x0, x25
10616a440: 946af345    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a444: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a448: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a44c: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a450: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a454: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a458: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a45c: 52800080    	mov	w0, #0x4                ; =4
10616a460: 52803103    	mov	w3, #0x188              ; =392
10616a464: aa1803e5    	mov	x5, x24
10616a468: 946a8b77    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a46c: aa1803e0    	mov	x0, x24
10616a470: 946af339    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a474: aa1703e0    	mov	x0, x23
10616a478: 946af34d    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a47c: b00ce688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10616a480: f940e101    	ldr	x1, [x8, #0x1c0] ; selector=clear
10616a484: aa1503e0    	mov	x0, x21
10616a488: 946af32d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a48c: aa1603e0    	mov	x0, x22
10616a490: 946af331    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a494: 1400009c    	b	0x10616a704 <_Flutter_MMFoundation_BindContext+0x26462e8>
10616a498: f00ce848    	adrp	x8, 0x11fe75000 <dyld_stub_binder+0x11fe75000>
10616a49c: f9429117    	ldr	x23, [x8, #0x520] ; selector=roomType
10616a4a0: aa1403e0    	mov	x0, x20
10616a4a4: aa1703e1    	mov	x1, x23
10616a4a8: 946af325    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a4ac: 7100041f    	cmp	w0, #0x1
10616a4b0: 54000621    	b.ne	0x10616a574 <_Flutter_MMFoundation_BindContext+0x2646158>
10616a4b4: 52800057    	mov	w23, #0x2               ; =2
10616a4b8: 52800040    	mov	w0, #0x2                ; =2
10616a4bc: 946a8b61    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a4c0: 34fff080    	cbz	w0, 0x10616a2d0 <_Flutter_MMFoundation_BindContext+0x2645eb4>
10616a4c4: 946af337    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a4c8: aa0003f8    	mov	x24, x0
10616a4cc: b00d0059    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10616a4d0: f9454720    	ldr	x0, [x25, #0xa88]
10616a4d4: 946af323    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a4d8: aa0003f7    	mov	x23, x0
10616a4dc: f9454720    	ldr	x0, [x25, #0xa88]
10616a4e0: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a4e4: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a4e8: f90003ff    	str	xzr, [sp]
10616a4ec: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a4f0: 913c2042    	add	x2, x2, #0xf08 ; cfstring='It is 2p video'
10616a4f4: 946af312    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a4f8: aa1d03fd    	mov	x29, x29
10616a4fc: 946af313    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a500: aa0003f9    	mov	x25, x0
10616a504: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a508: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a50c: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a510: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616a514: a90003e8    	stp	x8, x0, [sp]
10616a518: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a51c: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a520: aa1703e0    	mov	x0, x23
10616a524: 946af306    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a528: aa0003fa    	mov	x26, x0
10616a52c: aa1903e0    	mov	x0, x25
10616a530: 946af309    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a534: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a538: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a53c: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a540: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a544: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a548: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a54c: 52800057    	mov	w23, #0x2               ; =2
10616a550: 52800040    	mov	w0, #0x2                ; =2
10616a554: 52802e63    	mov	w3, #0x173              ; =371
10616a558: aa1a03e5    	mov	x5, x26
10616a55c: 946a8b3a    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a560: aa1a03e0    	mov	x0, x26
10616a564: 946af2fc    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a568: aa1803e0    	mov	x0, x24
10616a56c: 946af310    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a570: 17ffff58    	b	0x10616a2d0 <_Flutter_MMFoundation_BindContext+0x2645eb4>
10616a574: aa1403e0    	mov	x0, x20
10616a578: aa1703e1    	mov	x1, x23
10616a57c: 946af2f0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a580: 7100081f    	cmp	w0, #0x2
10616a584: 540005e1    	b.ne	0x10616a640 <_Flutter_MMFoundation_BindContext+0x2646224>
10616a588: 946a8b2e    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a58c: 34000560    	cbz	w0, 0x10616a638 <_Flutter_MMFoundation_BindContext+0x264621c>
10616a590: 946af304    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a594: aa0003f7    	mov	x23, x0
10616a598: b00d0059    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
10616a59c: f9454720    	ldr	x0, [x25, #0xa88]
10616a5a0: 946af2f0    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a5a4: aa0003f8    	mov	x24, x0
10616a5a8: f9454720    	ldr	x0, [x25, #0xa88]
10616a5ac: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a5b0: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a5b4: f90003ff    	str	xzr, [sp]
10616a5b8: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a5bc: 913ca042    	add	x2, x2, #0xf28 ; cfstring='It is 2p audio'
10616a5c0: 946af2df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a5c4: aa1d03fd    	mov	x29, x29
10616a5c8: 946af2e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a5cc: aa0003f9    	mov	x25, x0
10616a5d0: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a5d4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a5d8: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a5dc: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
10616a5e0: a90003e8    	stp	x8, x0, [sp]
10616a5e4: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a5e8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a5ec: aa1803e0    	mov	x0, x24
10616a5f0: 946af2d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a5f4: aa0003f8    	mov	x24, x0
10616a5f8: aa1903e0    	mov	x0, x25
10616a5fc: 946af2d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a600: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a604: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a608: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a60c: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a610: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a614: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a618: 52800040    	mov	w0, #0x2                ; =2
10616a61c: 52802ec3    	mov	w3, #0x176              ; =374
10616a620: aa1803e5    	mov	x5, x24
10616a624: 946a8b08    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a628: aa1803e0    	mov	x0, x24
10616a62c: 946af2ca    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a630: aa1703e0    	mov	x0, x23
10616a634: 946af2de    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a638: 52800037    	mov	w23, #0x1               ; =1
10616a63c: 17ffff25    	b	0x10616a2d0 <_Flutter_MMFoundation_BindContext+0x2645eb4>
10616a640: 52800080    	mov	w0, #0x4                ; =4
10616a644: 946a8aff    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
10616a648: 34000560    	cbz	w0, 0x10616a6f4 <_Flutter_MMFoundation_BindContext+0x26462d8>
10616a64c: 946af2d5    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10616a650: aa0003f6    	mov	x22, x0
10616a654: b00d0058    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
10616a658: f9454700    	ldr	x0, [x24, #0xa88]
10616a65c: 946af2c1    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10616a660: aa0003f7    	mov	x23, x0
10616a664: f9454700    	ldr	x0, [x24, #0xa88]
10616a668: 900cfd08    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10616a66c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10616a670: f90003ff    	str	xzr, [sp]
10616a674: b00c3842    	adrp	x2, 0x11e873000 <dyld_stub_binder+0x11e873000>
10616a678: 913da042    	add	x2, x2, #0xf68 ; cfstring='None inviteType!'
10616a67c: 946af2b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a680: aa1d03fd    	mov	x29, x29
10616a684: 946af2b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10616a688: aa0003f8    	mov	x24, x0
10616a68c: 900cfcc8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10616a690: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
10616a694: b00c1988    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a698: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10616a69c: a90003e8    	stp	x8, x0, [sp]
10616a6a0: b00c1982    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10616a6a4: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10616a6a8: aa1703e0    	mov	x0, x23
10616a6ac: 946af2a4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a6b0: aa0003f7    	mov	x23, x0
10616a6b4: aa1803e0    	mov	x0, x24
10616a6b8: 946af2a7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a6bc: b00ac101    	adrp	x1, 0x11b98b000 <dyld_stub_binder+0x11b98b000>
10616a6c0: 911d5021    	add	x1, x1, #0x754 ; cstring='voipmp.sub_call'
10616a6c4: b00ac142    	adrp	x2, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a6c8: 912efc42    	add	x2, x2, #0xbbf ; cstring='VoIPMPSubCallService.mm'
10616a6cc: b00ac144    	adrp	x4, 0x11b993000 <dyld_stub_binder+0x11b993000>
10616a6d0: 9138b084    	add	x4, x4, #0xe2c ; cstring='-[VoIPMPSubCallService receiveInviteData:]'
10616a6d4: 52800080    	mov	w0, #0x4                ; =4
10616a6d8: 52802fe3    	mov	w3, #0x17f              ; =383
10616a6dc: aa1703e5    	mov	x5, x23
10616a6e0: 946a8ad9    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10616a6e4: aa1703e0    	mov	x0, x23
10616a6e8: 946af29b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a6ec: aa1603e0    	mov	x0, x22
10616a6f0: 946af2af    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
10616a6f4: b00ce688    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10616a6f8: f940e101    	ldr	x1, [x8, #0x1c0] ; selector=clear
10616a6fc: aa1503e0    	mov	x0, x21
10616a700: 946af28f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10616a704: aa1403e0    	mov	x0, x20
10616a708: 946af293    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10616a70c: aa1303e0    	mov	x0, x19
10616a710: a9477bfd    	ldp	x29, x30, [sp, #0x70]
10616a714: a9464ff4    	ldp	x20, x19, [sp, #0x60]
10616a718: a94557f6    	ldp	x22, x21, [sp, #0x50]
10616a71c: a9445ff8    	ldp	x24, x23, [sp, #0x40]
10616a720: a94367fa    	ldp	x26, x25, [sp, #0x30]
10616a724: a9426ffc    	ldp	x28, x27, [sp, #0x20]
10616a728: 910203ff    	add	sp, sp, #0x80
10616a72c: 146af28a    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
