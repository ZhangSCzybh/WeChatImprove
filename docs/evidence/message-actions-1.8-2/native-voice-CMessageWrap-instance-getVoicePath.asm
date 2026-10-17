
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b9ae04: d104c3ff    	sub	sp, sp, #0x130
104b9ae08: a90e67fa    	stp	x26, x25, [sp, #0xe0]
104b9ae0c: a90f5ff8    	stp	x24, x23, [sp, #0xf0]
104b9ae10: a91057f6    	stp	x22, x21, [sp, #0x100]
104b9ae14: a9114ff4    	stp	x20, x19, [sp, #0x110]
104b9ae18: a9127bfd    	stp	x29, x30, [sp, #0x120]
104b9ae1c: 910483fd    	add	x29, sp, #0x120
104b9ae20: aa0003f3    	mov	x19, x0
104b9ae24: b00c52a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b9ae28: f9405908    	ldr	x8, [x8, #0xb0]
104b9ae2c: f9400108    	ldr	x8, [x8]
104b9ae30: f81b83a8    	stur	x8, [x29, #-0x48]
104b9ae34: 900e0528    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104b9ae38: 52800029    	mov	w9, #0x1                ; =1
104b9ae3c: 391a0909    	strb	w9, [x8, #0x682]
104b9ae40: d00daec8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104b9ae44: f9451500    	ldr	x0, [x8, #0xa28]
104b9ae48: 900dab88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104b9ae4c: f9437d01    	ldr	x1, [x8, #0x6f8] ; sharedInstance
104b9ae50: 94c230bb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ae54: aa1d03fd    	mov	x29, x29
104b9ae58: 94c230bc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9ae5c: aa0003f6    	mov	x22, x0
104b9ae60: d00daea8    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104b9ae64: f9456902    	ldr	x2, [x8, #0xad0]
104b9ae68: d00d9848    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b9ae6c: f9424d14    	ldr	x20, [x8, #0x498] ; GetPathOfAppRemindAttach:retStrPath:
104b9ae70: b00d9528    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104b9ae74: f9403101    	ldr	x1, [x8, #0x60] ; getClsMethodObservers:selector:
104b9ae78: aa1403e3    	mov	x3, x20
104b9ae7c: 94c230b0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9ae80: aa1d03fd    	mov	x29, x29
104b9ae84: 94c230b1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9ae88: aa0003f5    	mov	x21, x0
104b9ae8c: aa1603e0    	mov	x0, x22
104b9ae90: 94c230b1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9ae94: 4f00e400    	movi.16b	v0, #0x0
104b9ae98: ad0183e0    	stp	q0, q0, [sp, #0x30]
104b9ae9c: ad0083e0    	stp	q0, q0, [sp, #0x10]
104b9aea0: d00dab28    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104b9aea4: f9435501    	ldr	x1, [x8, #0x6a8] ; countByEnumeratingWithState:objects:count:
104b9aea8: 910043e2    	add	x2, sp, #0x10
104b9aeac: 910163e3    	add	x3, sp, #0x58
104b9aeb0: aa1503e0    	mov	x0, x21
104b9aeb4: 52800204    	mov	w4, #0x10               ; =16
104b9aeb8: 94c230a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9aebc: b4000180    	cbz	x0, 0x104b9aeec <_Flutter_MMFoundation_BindContext+0x1076ad0>
104b9aec0: f9400fe8    	ldr	x8, [sp, #0x18]
104b9aec4: f9400100    	ldr	x0, [x8]
104b9aec8: f90007ff    	str	xzr, [sp, #0x8]
104b9aecc: 910023e3    	add	x3, sp, #0x8
104b9aed0: aa1403e1    	mov	x1, x20
104b9aed4: aa1303e2    	mov	x2, x19
104b9aed8: 94c23099    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9aedc: f94007f4    	ldr	x20, [sp, #0x8]
104b9aee0: aa1403e0    	mov	x0, x20
104b9aee4: 94c23095    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b9aee8: 14000002    	b	0x104b9aef0 <_Flutter_MMFoundation_BindContext+0x1076ad4>
104b9aeec: d2800014    	mov	x20, #0x0               ; =0
104b9aef0: aa1503e0    	mov	x0, x21
104b9aef4: 94c23098    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9aef8: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9aefc: f9459d01    	ldr	x1, [x8, #0xb38] ; m_isEnterpriseMsg
104b9af00: aa1303e0    	mov	x0, x19
104b9af04: 94c2308e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9af08: 34000660    	cbz	w0, 0x104b9afd4 <_Flutter_MMFoundation_BindContext+0x1076bb8>
104b9af0c: f00daed8    	adrp	x24, 0x120175000 <dyld_stub_binder+0x120175000>
104b9af10: f942a715    	ldr	x21, [x24, #0x548]
104b9af14: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9af18: f945d101    	ldr	x1, [x8, #0xba0] ; m_nsBizChatId
104b9af1c: aa1303e0    	mov	x0, x19
104b9af20: 94c23087    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9af24: aa1d03fd    	mov	x29, x29
104b9af28: 94c23088    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9af2c: aa0003f6    	mov	x22, x0
104b9af30: d00d9508    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b9af34: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b9af38: aa1303e0    	mov	x0, x19
104b9af3c: 94c23080    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9af40: aa0003f7    	mov	x23, x0
104b9af44: f942a700    	ldr	x0, [x24, #0x548]
104b9af48: d00d9848    	adrp	x8, 0x11fea4000 <dyld_stub_binder+0x11fea4000>
104b9af4c: f9416501    	ldr	x1, [x8, #0x2c8] ; getEnterpriseChatBrandUserName:
104b9af50: aa1303e2    	mov	x2, x19
104b9af54: 94c2307a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9af58: aa1d03fd    	mov	x29, x29
104b9af5c: 94c2307b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9af60: aa0003f8    	mov	x24, x0
104b9af64: b00daec8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b9af68: f9467900    	ldr	x0, [x8, #0xcf0]
104b9af6c: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9af70: f943a501    	ldr	x1, [x8, #0x748] ; GetDocPath
104b9af74: 94c23072    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9af78: aa1d03fd    	mov	x29, x29
104b9af7c: 94c23073    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9af80: aa0003f9    	mov	x25, x0
104b9af84: b00d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9af88: f945d501    	ldr	x1, [x8, #0xba8] ; GetPathOfMesAudio:LocalID:Brand:DocPath:
104b9af8c: aa1503e0    	mov	x0, x21
104b9af90: aa1603e2    	mov	x2, x22
104b9af94: aa1703e3    	mov	x3, x23
104b9af98: aa1803e4    	mov	x4, x24
104b9af9c: aa1903e5    	mov	x5, x25
104b9afa0: 94c23067    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9afa4: aa1d03fd    	mov	x29, x29
104b9afa8: 94c23068    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9afac: aa0003f5    	mov	x21, x0
104b9afb0: aa1403e0    	mov	x0, x20
104b9afb4: 94c23068    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9afb8: aa1903e0    	mov	x0, x25
104b9afbc: 94c23066    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9afc0: aa1803e0    	mov	x0, x24
104b9afc4: 94c23064    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9afc8: aa1603e0    	mov	x0, x22
104b9afcc: 94c23062    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9afd0: aa1503f4    	mov	x20, x21
104b9afd4: b5000494    	cbnz	x20, 0x104b9b064 <_Flutter_MMFoundation_BindContext+0x1076c48>
104b9afd8: b00daed6    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104b9afdc: f9467ad4    	ldr	x20, [x22, #0xcf0]
104b9afe0: f00d9508    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b9afe4: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104b9afe8: aa1303e0    	mov	x0, x19
104b9afec: 94c23054    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9aff0: aa1d03fd    	mov	x29, x29
104b9aff4: 94c23055    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9aff8: aa0003f5    	mov	x21, x0
104b9affc: d00d9508    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104b9b000: f947d101    	ldr	x1, [x8, #0xfa0] ; m_uiMesLocalID
104b9b004: aa1303e0    	mov	x0, x19
104b9b008: 94c2304d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9b00c: aa0003f3    	mov	x19, x0
104b9b010: f9467ac0    	ldr	x0, [x22, #0xcf0]
104b9b014: 900d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9b018: f943a501    	ldr	x1, [x8, #0x748] ; GetDocPath
104b9b01c: 94c23048    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9b020: aa1d03fd    	mov	x29, x29
104b9b024: 94c23049    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9b028: aa0003f6    	mov	x22, x0
104b9b02c: 900d9548    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b9b030: f943a901    	ldr	x1, [x8, #0x750] ; GetPathOfMesAudio:LocalID:DocPath:
104b9b034: aa1403e0    	mov	x0, x20
104b9b038: aa1503e2    	mov	x2, x21
104b9b03c: aa1303e3    	mov	x3, x19
104b9b040: aa1603e4    	mov	x4, x22
104b9b044: 94c2303e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b9b048: aa1d03fd    	mov	x29, x29
104b9b04c: 94c2303f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b9b050: aa0003f4    	mov	x20, x0
104b9b054: aa1603e0    	mov	x0, x22
104b9b058: 94c2303f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9b05c: aa1503e0    	mov	x0, x21
104b9b060: 94c2303d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b9b064: f85b83a8    	ldur	x8, [x29, #-0x48]
104b9b068: 900c52a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104b9b06c: f9405929    	ldr	x9, [x9, #0xb0]
104b9b070: f9400129    	ldr	x9, [x9]
104b9b074: eb08013f    	cmp	x9, x8
104b9b078: 54000121    	b.ne	0x104b9b09c <_Flutter_MMFoundation_BindContext+0x1076c80>
104b9b07c: aa1403e0    	mov	x0, x20
104b9b080: a9527bfd    	ldp	x29, x30, [sp, #0x120]
104b9b084: a9514ff4    	ldp	x20, x19, [sp, #0x110]
104b9b088: a95057f6    	ldp	x22, x21, [sp, #0x100]
104b9b08c: a94f5ff8    	ldp	x24, x23, [sp, #0xf0]
104b9b090: a94e67fa    	ldp	x26, x25, [sp, #0xe0]
104b9b094: 9104c3ff    	add	sp, sp, #0x130
104b9b098: 14c23036    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104b9b09c: 94c23036    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
