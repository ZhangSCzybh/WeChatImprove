
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104aa79e8: d10303ff    	sub	sp, sp, #0xc0
104aa79ec: a9066ffc    	stp	x28, x27, [sp, #0x60]
104aa79f0: a90767fa    	stp	x26, x25, [sp, #0x70]
104aa79f4: a9085ff8    	stp	x24, x23, [sp, #0x80]
104aa79f8: a90957f6    	stp	x22, x21, [sp, #0x90]
104aa79fc: a90a4ff4    	stp	x20, x19, [sp, #0xa0]
104aa7a00: a90b7bfd    	stp	x29, x30, [sp, #0xb0]
104aa7a04: 9102c3fd    	add	x29, sp, #0xb0
104aa7a08: aa0203f3    	mov	x19, x2
104aa7a0c: aa0003f4    	mov	x20, x0
104aa7a10: 900c5a48    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104aa7a14: f9405908    	ldr	x8, [x8, #0xb0]
104aa7a18: f9400108    	ldr	x8, [x8]
104aa7a1c: f9002fe8    	str	x8, [sp, #0x58]
104aa7a20: f00e0ca8    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104aa7a24: 52800029    	mov	w9, #0x1                ; =1
104aa7a28: 390d8509    	strb	w9, [x8, #0x361]
104aa7a2c: aa0203e0    	mov	x0, x2
104aa7a30: 94c5fdc2    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104aa7a34: b00da6e8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104aa7a38: f9458d01    	ldr	x1, [x8, #0xb18] ; selector callUpdateSession:
104aa7a3c: aa1403e0    	mov	x0, x20
104aa7a40: aa1303e2    	mov	x2, x19
104aa7a44: 94c5fdbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7a48: b00db668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aa7a4c: f9400114    	ldr	x20, [x8] ; class MMKernelUtil
104aa7a50: b00d9ce8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104aa7a54: f947d918    	ldr	x24, [x8, #0xfb0] ; selector m_nsUserName
104aa7a58: aa1303e0    	mov	x0, x19
104aa7a5c: aa1803e1    	mov	x1, x24
104aa7a60: 94c5fdb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7a64: aa1d03fd    	mov	x29, x29
104aa7a68: 94c5fdb8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7a6c: aa0003f5    	mov	x21, x0
104aa7a70: b00d9cc8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104aa7a74: f946c901    	ldr	x1, [x8, #0xd90] ; selector IsChatRoom:
104aa7a78: aa1403e0    	mov	x0, x20
104aa7a7c: aa1503e2    	mov	x2, x21
104aa7a80: 94c5fdaf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7a84: aa0003f4    	mov	x20, x0
104aa7a88: aa1503e0    	mov	x0, x21
104aa7a8c: 94c5fdb2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7a90: 34003574    	cbz	w20, 0x104aa813c <_Flutter_MMFoundation_BindContext+0xf83d20>
104aa7a94: 900db676    	adrp	x22, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7a98: f945eac0    	ldr	x0, [x22, #0xbd0] ; class MMContext
104aa7a9c: b00db2c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104aa7aa0: f944e91c    	ldr	x28, [x8, #0x9d0] ; selector currentContext
104aa7aa4: aa1c03e1    	mov	x1, x28
104aa7aa8: 94c5fda5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7aac: aa1d03fd    	mov	x29, x29
104aa7ab0: 94c5fda6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7ab4: aa0003f5    	mov	x21, x0
104aa7ab8: b00db668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aa7abc: f9401500    	ldr	x0, [x8, #0x28] ; class CContactMgr
104aa7ac0: 900db2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aa7ac4: f947ad1b    	ldr	x27, [x8, #0xf58] ; selector class
104aa7ac8: aa1b03e1    	mov	x1, x27
104aa7acc: 94c5fd9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ad0: aa0003e2    	mov	x2, x0
104aa7ad4: d00d9c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aa7ad8: f9464117    	ldr	x23, [x8, #0xc80] ; selector getService:
104aa7adc: aa1503e0    	mov	x0, x21
104aa7ae0: aa1703e1    	mov	x1, x23
104aa7ae4: 94c5fd96    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ae8: aa1d03fd    	mov	x29, x29
104aa7aec: 94c5fd97    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7af0: aa0003f9    	mov	x25, x0
104aa7af4: aa1303e0    	mov	x0, x19
104aa7af8: aa1803e1    	mov	x1, x24
104aa7afc: 94c5fd90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7b00: aa1d03fd    	mov	x29, x29
104aa7b04: 94c5fd91    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7b08: aa0003fa    	mov	x26, x0
104aa7b0c: b00d9ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aa7b10: f940c901    	ldr	x1, [x8, #0x190] ; selector getContactByName:
104aa7b14: aa1903e0    	mov	x0, x25
104aa7b18: aa1a03e2    	mov	x2, x26
104aa7b1c: 94c5fd88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7b20: aa1d03fd    	mov	x29, x29
104aa7b24: 94c5fd89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7b28: aa0003f4    	mov	x20, x0
104aa7b2c: aa1a03e0    	mov	x0, x26
104aa7b30: 94c5fd89    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7b34: aa1903e0    	mov	x0, x25
104aa7b38: 94c5fd87    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7b3c: aa1503e0    	mov	x0, x21
104aa7b40: 94c5fd85    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7b44: b4000814    	cbz	x20, 0x104aa7c44 <_Flutter_MMFoundation_BindContext+0xf83828>
104aa7b48: a9036ffc    	stp	x28, x27, [sp, #0x30]
104aa7b4c: a90453f7    	stp	x23, x20, [sp, #0x40]
104aa7b50: 900d9ca8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104aa7b54: f947d918    	ldr	x24, [x8, #0xfb0] ; selector m_contact
104aa7b58: aa1303e0    	mov	x0, x19
104aa7b5c: aa1803e1    	mov	x1, x24
104aa7b60: 94c5fd77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7b64: aa1d03fd    	mov	x29, x29
104aa7b68: 94c5fd78    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7b6c: aa0003fb    	mov	x27, x0
104aa7b70: b00d9ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aa7b74: f944d919    	ldr	x25, [x8, #0x9b0] ; selector m_ChatRoomData
104aa7b78: aa1903e1    	mov	x1, x25
104aa7b7c: 94c5fd70    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7b80: aa1d03fd    	mov	x29, x29
104aa7b84: 94c5fd71    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7b88: 900db674    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7b8c: b4001020    	cbz	x0, 0x104aa7d90 <_Flutter_MMFoundation_BindContext+0xf83974>
104aa7b90: aa0003f5    	mov	x21, x0
104aa7b94: aa1303e0    	mov	x0, x19
104aa7b98: aa1803e1    	mov	x1, x24
104aa7b9c: 94c5fd68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ba0: aa1d03fd    	mov	x29, x29
104aa7ba4: 94c5fd69    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7ba8: aa0003f6    	mov	x22, x0
104aa7bac: aa1903e1    	mov	x1, x25
104aa7bb0: 94c5fd63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7bb4: aa1d03fd    	mov	x29, x29
104aa7bb8: 94c5fd64    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7bbc: aa0003f7    	mov	x23, x0
104aa7bc0: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7bc4: f940a101    	ldr	x1, [x8, #0x140] ; selector chatRoomVersion
104aa7bc8: f90013e1    	str	x1, [sp, #0x20]
104aa7bcc: 94c5fd5c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7bd0: b9002fe0    	str	w0, [sp, #0x2c]
104aa7bd4: aa1303e0    	mov	x0, x19
104aa7bd8: aa1803e1    	mov	x1, x24
104aa7bdc: 94c5fd58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7be0: aa1d03fd    	mov	x29, x29
104aa7be4: 94c5fd59    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7be8: aa0003f4    	mov	x20, x0
104aa7bec: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7bf0: f944951c    	ldr	x28, [x8, #0x928] ; selector m_uiChatRoomVersion
104aa7bf4: aa1c03e1    	mov	x1, x28
104aa7bf8: 94c5fd51    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7bfc: aa0003fa    	mov	x26, x0
104aa7c00: aa1403e0    	mov	x0, x20
104aa7c04: 94c5fd54    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7c08: aa1703e0    	mov	x0, x23
104aa7c0c: 94c5fd52    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7c10: aa1603e0    	mov	x0, x22
104aa7c14: 94c5fd50    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7c18: aa1503e0    	mov	x0, x21
104aa7c1c: 94c5fd4e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7c20: aa1b03e0    	mov	x0, x27
104aa7c24: 94c5fd4c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7c28: b9402fe8    	ldr	w8, [sp, #0x2c]
104aa7c2c: 6b1a011f    	cmp	w8, w26
104aa7c30: 900db67a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7c34: 540015c2    	b.hs	0x104aa7eec <_Flutter_MMFoundation_BindContext+0xf83ad0>
104aa7c38: 900db674    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7c3c: f94013fb    	ldr	x27, [sp, #0x20]
104aa7c40: 1400005b    	b	0x104aa7dac <_Flutter_MMFoundation_BindContext+0xf83990>
104aa7c44: 900db668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7c48: f9453514    	ldr	x20, [x8, #0xa68] ; class iConsole
104aa7c4c: aa1303e0    	mov	x0, x19
104aa7c50: aa1803e1    	mov	x1, x24
104aa7c54: 94c5fd3a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7c58: aa1d03fd    	mov	x29, x29
104aa7c5c: 94c5fd3b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7c60: aa0003f5    	mov	x21, x0
104aa7c64: d00d9c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aa7c68: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104aa7c6c: f00ce7a8    	adrp	x8, 0x11e79e000 <dyld_stub_binder+0x11e79e000>
104aa7c70: 91112108    	add	x8, x8, #0x448 ; CFString 'local contact not exist: %@'
104aa7c74: a90003e8    	stp	x8, x0, [sp]
104aa7c78: 900b42e3    	adrp	x3, 0x11b303000 <dyld_stub_binder+0x11b303000>
104aa7c7c: 913e9463    	add	x3, x3, #0xfa5 ; string 'ChatRoom'
104aa7c80: d00b6a45    	adrp	x5, 0x11b7f1000 <dyld_stub_binder+0x11b7f1000>
104aa7c84: 91154ca5    	add	x5, x5, #0x553 ; string 'MainFrameLogicController.mm'
104aa7c88: d00b6a47    	adrp	x7, 0x11b7f1000 <dyld_stub_binder+0x11b7f1000>
104aa7c8c: 9129b4e7    	add	x7, x7, #0xa6d ; string '-[MainFrameLogicController onSessionChanged:]'
104aa7c90: aa1403e0    	mov	x0, x20
104aa7c94: 52800042    	mov	w2, #0x2                ; =2
104aa7c98: 52800004    	mov	w4, #0x0                ; =0
104aa7c9c: 52809246    	mov	w6, #0x492              ; =1170
104aa7ca0: 94c5fd27    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ca4: aa1503e0    	mov	x0, x21
104aa7ca8: 94c5fd2b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7cac: 900db668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7cb0: f9478100    	ldr	x0, [x8, #0xf00] ; class CContact
104aa7cb4: 94c5fd29    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
104aa7cb8: aa0003f9    	mov	x25, x0
104aa7cbc: aa1303e0    	mov	x0, x19
104aa7cc0: aa1803e1    	mov	x1, x24
104aa7cc4: 94c5fd1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7cc8: aa1d03fd    	mov	x29, x29
104aa7ccc: 94c5fd1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7cd0: aa0003f5    	mov	x21, x0
104aa7cd4: b00d9ca8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104aa7cd8: f945fd01    	ldr	x1, [x8, #0xbf8] ; selector setM_nsUsrName:
104aa7cdc: aa1903e0    	mov	x0, x25
104aa7ce0: aa1503e2    	mov	x2, x21
104aa7ce4: 94c5fd16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ce8: aa1503e0    	mov	x0, x21
104aa7cec: 94c5fd1a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7cf0: f945eac0    	ldr	x0, [x22, #0xbd0]
104aa7cf4: aa1c03e1    	mov	x1, x28
104aa7cf8: 94c5fd11    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7cfc: aa1d03fd    	mov	x29, x29
104aa7d00: 94c5fd12    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7d04: aa0003f5    	mov	x21, x0
104aa7d08: b00db668    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104aa7d0c: f9401500    	ldr	x0, [x8, #0x28] ; class CContactMgr
104aa7d10: aa1b03e1    	mov	x1, x27
104aa7d14: 94c5fd0a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7d18: aa0003e2    	mov	x2, x0
104aa7d1c: aa1503e0    	mov	x0, x21
104aa7d20: aa1703e1    	mov	x1, x23
104aa7d24: 94c5fd06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7d28: aa1d03fd    	mov	x29, x29
104aa7d2c: 94c5fd07    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7d30: aa0003f6    	mov	x22, x0
104aa7d34: f9002bf9    	str	x25, [sp, #0x50]
104aa7d38: 900db668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7d3c: f9456d00    	ldr	x0, [x8, #0xad8] ; class NSArray
104aa7d40: 900db2c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104aa7d44: f941c501    	ldr	x1, [x8, #0x388] ; selector arrayWithObjects:count:
104aa7d48: 910143e2    	add	x2, sp, #0x50
104aa7d4c: 52800023    	mov	w3, #0x1                ; =1
104aa7d50: 94c5fcfb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7d54: aa1d03fd    	mov	x29, x29
104aa7d58: 94c5fcfc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7d5c: aa0003f7    	mov	x23, x0
104aa7d60: 900d9d68    	adrp	x8, 0x11fe53000 <dyld_stub_binder+0x11fe53000>
104aa7d64: f9409901    	ldr	x1, [x8, #0x130] ; selector getContactsFromServer:withScene:
104aa7d68: aa1603e0    	mov	x0, x22
104aa7d6c: aa1703e2    	mov	x2, x23
104aa7d70: 52800423    	mov	w3, #0x21               ; =33
104aa7d74: 94c5fcf2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7d78: aa1703e0    	mov	x0, x23
104aa7d7c: 94c5fcf6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7d80: aa1603e0    	mov	x0, x22
104aa7d84: 94c5fcf4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7d88: aa1503e0    	mov	x0, x21
104aa7d8c: 140000e5    	b	0x104aa8120 <_Flutter_MMFoundation_BindContext+0xf83d04>
104aa7d90: aa1b03e0    	mov	x0, x27
104aa7d94: 94c5fcf0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7d98: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7d9c: f944951c    	ldr	x28, [x8, #0x928] ; selector m_uiChatRoomVersion
104aa7da0: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7da4: f940a11b    	ldr	x27, [x8, #0x140] ; selector chatRoomVersion
104aa7da8: 900db67a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7dac: f9453694    	ldr	x20, [x20, #0xa68]
104aa7db0: aa1303e0    	mov	x0, x19
104aa7db4: aa1803e1    	mov	x1, x24
104aa7db8: 94c5fce1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7dbc: aa1d03fd    	mov	x29, x29
104aa7dc0: 94c5fce2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7dc4: aa0003f5    	mov	x21, x0
104aa7dc8: aa1c03e1    	mov	x1, x28
104aa7dcc: 94c5fcdc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7dd0: aa0003f6    	mov	x22, x0
104aa7dd4: aa1303e0    	mov	x0, x19
104aa7dd8: aa1803e1    	mov	x1, x24
104aa7ddc: 94c5fcd8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7de0: aa1d03fd    	mov	x29, x29
104aa7de4: 94c5fcd9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7de8: aa0003f7    	mov	x23, x0
104aa7dec: aa1903e1    	mov	x1, x25
104aa7df0: 94c5fcd3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7df4: aa1d03fd    	mov	x29, x29
104aa7df8: 94c5fcd4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7dfc: aa0003f9    	mov	x25, x0
104aa7e00: aa1b03e1    	mov	x1, x27
104aa7e04: 94c5fcce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7e08: d00d9c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aa7e0c: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104aa7e10: a90083f6    	stp	x22, x0, [sp, #0x8]
104aa7e14: 900cd488    	adrp	x8, 0x11e537000 <dyld_stub_binder+0x11e537000>
104aa7e18: 9137a108    	add	x8, x8, #0xde8 ; CFString 'Data Version: new = %u, curr = %u'
104aa7e1c: f90003e8    	str	x8, [sp]
104aa7e20: 900b42e3    	adrp	x3, 0x11b303000 <dyld_stub_binder+0x11b303000>
104aa7e24: 913e9463    	add	x3, x3, #0xfa5 ; string 'ChatRoom'
104aa7e28: d00b6a45    	adrp	x5, 0x11b7f1000 <dyld_stub_binder+0x11b7f1000>
104aa7e2c: 91154ca5    	add	x5, x5, #0x553 ; string 'MainFrameLogicController.mm'
104aa7e30: d00b6a47    	adrp	x7, 0x11b7f1000 <dyld_stub_binder+0x11b7f1000>
104aa7e34: 9129b4e7    	add	x7, x7, #0xa6d ; string '-[MainFrameLogicController onSessionChanged:]'
104aa7e38: aa1403e0    	mov	x0, x20
104aa7e3c: 52800042    	mov	w2, #0x2                ; =2
104aa7e40: 52800004    	mov	w4, #0x0                ; =0
104aa7e44: 52809366    	mov	w6, #0x49b              ; =1179
104aa7e48: 94c5fcbd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7e4c: aa1903e0    	mov	x0, x25
104aa7e50: 94c5fcc1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7e54: aa1703e0    	mov	x0, x23
104aa7e58: 94c5fcbf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7e5c: aa1503e0    	mov	x0, x21
104aa7e60: 94c5fcbd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7e64: f945eb40    	ldr	x0, [x26, #0xbd0] ; class MMContext
104aa7e68: f9401be1    	ldr	x1, [sp, #0x30]
104aa7e6c: 94c5fcb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7e70: aa1d03fd    	mov	x29, x29
104aa7e74: 94c5fcb5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7e78: aa0003f4    	mov	x20, x0
104aa7e7c: 900db668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7e80: f947dd00    	ldr	x0, [x8, #0xfb8] ; class CGroupMgr
104aa7e84: f9401fe1    	ldr	x1, [sp, #0x38]
104aa7e88: 94c5fcad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7e8c: aa0003e2    	mov	x2, x0
104aa7e90: aa1403e0    	mov	x0, x20
104aa7e94: f94023e1    	ldr	x1, [sp, #0x40]
104aa7e98: 94c5fca9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7e9c: aa1d03fd    	mov	x29, x29
104aa7ea0: 94c5fcaa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7ea4: aa0003f5    	mov	x21, x0
104aa7ea8: aa1303e0    	mov	x0, x19
104aa7eac: aa1803e1    	mov	x1, x24
104aa7eb0: 94c5fca3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7eb4: aa1d03fd    	mov	x29, x29
104aa7eb8: 94c5fca4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7ebc: aa0003f6    	mov	x22, x0
104aa7ec0: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7ec4: f9449901    	ldr	x1, [x8, #0x930] ; selector GetChatRoomMemberDetail:
104aa7ec8: aa1503e0    	mov	x0, x21
104aa7ecc: aa1603e2    	mov	x2, x22
104aa7ed0: 94c5fc9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ed4: aa1603e0    	mov	x0, x22
104aa7ed8: 94c5fc9f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7edc: aa1503e0    	mov	x0, x21
104aa7ee0: 94c5fc9d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7ee4: aa1403e0    	mov	x0, x20
104aa7ee8: 94c5fc9b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7eec: aa1303e0    	mov	x0, x19
104aa7ef0: aa1803e1    	mov	x1, x24
104aa7ef4: 94c5fc92    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ef8: aa1d03fd    	mov	x29, x29
104aa7efc: 94c5fc93    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7f00: aa0003fa    	mov	x26, x0
104aa7f04: 900d9d48    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
104aa7f08: f9418d19    	ldr	x25, [x8, #0x318] ; selector m_ChatRoomDetail
104aa7f0c: aa1903e1    	mov	x1, x25
104aa7f10: 94c5fc8b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7f14: aa1d03fd    	mov	x29, x29
104aa7f18: 94c5fc8c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7f1c: b4001060    	cbz	x0, 0x104aa8128 <_Flutter_MMFoundation_BindContext+0xf83d0c>
104aa7f20: aa0003f5    	mov	x21, x0
104aa7f24: aa1303e0    	mov	x0, x19
104aa7f28: aa1803e1    	mov	x1, x24
104aa7f2c: 94c5fc84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7f30: aa1d03fd    	mov	x29, x29
104aa7f34: 94c5fc85    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7f38: aa0003f4    	mov	x20, x0
104aa7f3c: aa1903e1    	mov	x1, x25
104aa7f40: 94c5fc7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7f44: aa1d03fd    	mov	x29, x29
104aa7f48: 94c5fc80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7f4c: aa0003f6    	mov	x22, x0
104aa7f50: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7f54: f944a101    	ldr	x1, [x8, #0x940] ; selector m_uiChatRoomInfoVersion
104aa7f58: f90013e1    	str	x1, [sp, #0x20]
104aa7f5c: 94c5fc78    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7f60: b9002fe0    	str	w0, [sp, #0x2c]
104aa7f64: aa1303e0    	mov	x0, x19
104aa7f68: aa1803e1    	mov	x1, x24
104aa7f6c: 94c5fc74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7f70: aa1d03fd    	mov	x29, x29
104aa7f74: 94c5fc75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7f78: aa0003fb    	mov	x27, x0
104aa7f7c: aa1903e1    	mov	x1, x25
104aa7f80: 94c5fc6f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7f84: aa1d03fd    	mov	x29, x29
104aa7f88: 94c5fc70    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7f8c: aa0003fc    	mov	x28, x0
104aa7f90: f00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa7f94: f944a501    	ldr	x1, [x8, #0x948] ; selector m_uiChatRoomInfoSvrVersion
104aa7f98: f9000fe1    	str	x1, [sp, #0x18]
104aa7f9c: 94c5fc68    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7fa0: aa0003f7    	mov	x23, x0
104aa7fa4: aa1c03e0    	mov	x0, x28
104aa7fa8: 94c5fc6b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7fac: aa1b03e0    	mov	x0, x27
104aa7fb0: 94c5fc69    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7fb4: aa1603e0    	mov	x0, x22
104aa7fb8: 94c5fc67    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7fbc: aa1403e0    	mov	x0, x20
104aa7fc0: 94c5fc65    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7fc4: aa1503e0    	mov	x0, x21
104aa7fc8: 94c5fc63    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7fcc: aa1a03e0    	mov	x0, x26
104aa7fd0: 94c5fc61    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa7fd4: b9402fe8    	ldr	w8, [sp, #0x2c]
104aa7fd8: 6b17011f    	cmp	w8, w23
104aa7fdc: 54000aa2    	b.hs	0x104aa8130 <_Flutter_MMFoundation_BindContext+0xf83d14>
104aa7fe0: 900db668    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa7fe4: f9453514    	ldr	x20, [x8, #0xa68] ; class iConsole
104aa7fe8: aa1303e0    	mov	x0, x19
104aa7fec: aa1803e1    	mov	x1, x24
104aa7ff0: 94c5fc53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa7ff4: aa1d03fd    	mov	x29, x29
104aa7ff8: 94c5fc54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa7ffc: aa0003fa    	mov	x26, x0
104aa8000: aa1903e1    	mov	x1, x25
104aa8004: 94c5fc4e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8008: aa1d03fd    	mov	x29, x29
104aa800c: 94c5fc4f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa8010: aa0003f5    	mov	x21, x0
104aa8014: f94013e1    	ldr	x1, [sp, #0x20]
104aa8018: 94c5fc49    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa801c: aa0003f6    	mov	x22, x0
104aa8020: aa1303e0    	mov	x0, x19
104aa8024: aa1803e1    	mov	x1, x24
104aa8028: 94c5fc45    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa802c: aa1d03fd    	mov	x29, x29
104aa8030: 94c5fc46    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa8034: aa0003f7    	mov	x23, x0
104aa8038: aa1903e1    	mov	x1, x25
104aa803c: 94c5fc40    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8040: aa1d03fd    	mov	x29, x29
104aa8044: 94c5fc41    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa8048: aa0003f8    	mov	x24, x0
104aa804c: f9400fe1    	ldr	x1, [sp, #0x18]
104aa8050: 94c5fc3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8054: b00d9c88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104aa8058: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104aa805c: a90083f6    	stp	x22, x0, [sp, #0x8]
104aa8060: d00ce7a8    	adrp	x8, 0x11e79e000 <dyld_stub_binder+0x11e79e000>
104aa8064: 9111a108    	add	x8, x8, #0x468 ; CFString 'ChatRoomInfo Data Version: new = %u, curr = %u'
104aa8068: f90003e8    	str	x8, [sp]
104aa806c: f00b42c3    	adrp	x3, 0x11b303000 <dyld_stub_binder+0x11b303000>
104aa8070: 913e9463    	add	x3, x3, #0xfa5 ; string 'ChatRoom'
104aa8074: b00b6a45    	adrp	x5, 0x11b7f1000 <dyld_stub_binder+0x11b7f1000>
104aa8078: 91154ca5    	add	x5, x5, #0x553 ; string 'MainFrameLogicController.mm'
104aa807c: b00b6a47    	adrp	x7, 0x11b7f1000 <dyld_stub_binder+0x11b7f1000>
104aa8080: 9129b4e7    	add	x7, x7, #0xa6d ; string '-[MainFrameLogicController onSessionChanged:]'
104aa8084: aa1403e0    	mov	x0, x20
104aa8088: 52800042    	mov	w2, #0x2                ; =2
104aa808c: 52800004    	mov	w4, #0x0                ; =0
104aa8090: 52809486    	mov	w6, #0x4a4              ; =1188
104aa8094: 94c5fc2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8098: aa1803e0    	mov	x0, x24
104aa809c: 94c5fc2e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa80a0: aa1703e0    	mov	x0, x23
104aa80a4: 94c5fc2c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa80a8: aa1503e0    	mov	x0, x21
104aa80ac: 94c5fc2a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa80b0: aa1a03e0    	mov	x0, x26
104aa80b4: 94c5fc28    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa80b8: f00db648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa80bc: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104aa80c0: f9401be1    	ldr	x1, [sp, #0x30]
104aa80c4: 94c5fc1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa80c8: aa1d03fd    	mov	x29, x29
104aa80cc: 94c5fc1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa80d0: aa0003f4    	mov	x20, x0
104aa80d4: f00db648    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104aa80d8: f947dd00    	ldr	x0, [x8, #0xfb8] ; class CGroupMgr
104aa80dc: f9401fe1    	ldr	x1, [sp, #0x38]
104aa80e0: 94c5fc17    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa80e4: aa0003e2    	mov	x2, x0
104aa80e8: aa1403e0    	mov	x0, x20
104aa80ec: f94023e1    	ldr	x1, [sp, #0x40]
104aa80f0: 94c5fc13    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa80f4: aa1d03fd    	mov	x29, x29
104aa80f8: 94c5fc14    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104aa80fc: aa0003f5    	mov	x21, x0
104aa8100: d00d9ec8    	adrp	x8, 0x11fe82000 <dyld_stub_binder+0x11fe82000>
104aa8104: f944a901    	ldr	x1, [x8, #0x950] ; selector GetChatRoomInfo:
104aa8108: f94027f9    	ldr	x25, [sp, #0x48]
104aa810c: aa1903e2    	mov	x2, x25
104aa8110: 94c5fc0b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104aa8114: aa1503e0    	mov	x0, x21
104aa8118: 94c5fc0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa811c: aa1403e0    	mov	x0, x20
104aa8120: 94c5fc0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8124: 14000004    	b	0x104aa8134 <_Flutter_MMFoundation_BindContext+0xf83d18>
104aa8128: aa1a03e0    	mov	x0, x26
104aa812c: 94c5fc0a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8130: f94027f9    	ldr	x25, [sp, #0x48]
104aa8134: aa1903e0    	mov	x0, x25
104aa8138: 94c5fc07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa813c: aa1303e0    	mov	x0, x19
104aa8140: 94c5fc05    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104aa8144: f9402fe8    	ldr	x8, [sp, #0x58]
104aa8148: f00c5a29    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104aa814c: f9405929    	ldr	x9, [x9, #0xb0]
104aa8150: f9400129    	ldr	x9, [x9]
104aa8154: eb08013f    	cmp	x9, x8
104aa8158: 54000121    	b.ne	0x104aa817c <_Flutter_MMFoundation_BindContext+0xf83d60>
104aa815c: a94b7bfd    	ldp	x29, x30, [sp, #0xb0]
104aa8160: a94a4ff4    	ldp	x20, x19, [sp, #0xa0]
104aa8164: a94957f6    	ldp	x22, x21, [sp, #0x90]
104aa8168: a9485ff8    	ldp	x24, x23, [sp, #0x80]
104aa816c: a94767fa    	ldp	x26, x25, [sp, #0x70]
104aa8170: a9466ffc    	ldp	x28, x27, [sp, #0x60]
104aa8174: 910303ff    	add	sp, sp, #0xc0
104aa8178: d65f03c0    	ret
104aa817c: 94c5fbfe    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
