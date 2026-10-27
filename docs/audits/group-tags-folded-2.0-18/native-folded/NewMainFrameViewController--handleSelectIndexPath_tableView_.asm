
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10511feac: d102c3ff    	sub	sp, sp, #0xb0
10511feb0: a9056ffc    	stp	x28, x27, [sp, #0x50]
10511feb4: a90667fa    	stp	x26, x25, [sp, #0x60]
10511feb8: a9075ff8    	stp	x24, x23, [sp, #0x70]
10511febc: a90857f6    	stp	x22, x21, [sp, #0x80]
10511fec0: a9094ff4    	stp	x20, x19, [sp, #0x90]
10511fec4: a90a7bfd    	stp	x29, x30, [sp, #0xa0]
10511fec8: 910283fd    	add	x29, sp, #0xa0
10511fecc: aa0303fc    	mov	x28, x3
10511fed0: aa0203f3    	mov	x19, x2
10511fed4: aa0003f6    	mov	x22, x0
10511fed8: 900dd908    	adrp	x8, 0x120c3f000 <dyld_stub_binder+0x120c3f000>
10511fedc: 52800029    	mov	w9, #0x1                ; =1
10511fee0: 392e1909    	strb	w9, [x8, #0xb86]
10511fee4: aa0203e0    	mov	x0, x2
10511fee8: 94ac1c94    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511feec: aa1c03e0    	mov	x0, x28
10511fef0: 94ac1c92    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
10511fef4: b00d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10511fef8: b9831519    	ldrsw	x25, [x8, #0x314]
10511fefc: f8796ac0    	ldr	x0, [x22, x25]
10511ff00: b00d7328    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
10511ff04: f945d101    	ldr	x1, [x8, #0xba0] ; getSessionInfoAtIndexPath:
10511ff08: aa1303e2    	mov	x2, x19
10511ff0c: 94ac1c8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ff10: aa1d03fd    	mov	x29, x29
10511ff14: 94ac1c8d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ff18: aa0003f5    	mov	x21, x0
10511ff1c: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511ff20: f9468d00    	ldr	x0, [x8, #0xd18] ; DeviceInfo
10511ff24: 900d7f28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10511ff28: f9457d01    	ldr	x1, [x8, #0xaf8] ; isiPad
10511ff2c: 94ac1c84    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ff30: b00d885a    	adrp	x26, 0x120228000 <dyld_stub_binder+0x120228000>
10511ff34: 340005c0    	cbz	w0, 0x10511ffec <_Flutter_MMFoundation_BindContext+0x15fbbd0>
10511ff38: b9836b58    	ldrsw	x24, [x26, #0x368]
10511ff3c: f8786ac8    	ldr	x8, [x22, x24]
10511ff40: b4000568    	cbz	x8, 0x10511ffec <_Flutter_MMFoundation_BindContext+0x15fbbd0>
10511ff44: b00d6928    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
10511ff48: f947d914    	ldr	x20, [x8, #0xfb0] ; m_nsUserName
10511ff4c: aa1503e0    	mov	x0, x21
10511ff50: aa1403e1    	mov	x1, x20
10511ff54: 94ac1c7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ff58: aa1d03fd    	mov	x29, x29
10511ff5c: 94ac1c7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ff60: aa0003f7    	mov	x23, x0
10511ff64: f8786ac0    	ldr	x0, [x22, x24]
10511ff68: aa1403e1    	mov	x1, x20
10511ff6c: 94ac1c74    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ff70: aa1d03fd    	mov	x29, x29
10511ff74: 94ac1c75    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10511ff78: aa0003f4    	mov	x20, x0
10511ff7c: 900d7f28    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10511ff80: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
10511ff84: aa1703e0    	mov	x0, x23
10511ff88: aa1403e2    	mov	x2, x20
10511ff8c: 94ac1c6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ff90: aa0003f8    	mov	x24, x0
10511ff94: aa1403e0    	mov	x0, x20
10511ff98: 94ac1c6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ff9c: aa1703e0    	mov	x0, x23
10511ffa0: 94ac1c6d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10511ffa4: 34000258    	cbz	w24, 0x10511ffec <_Flutter_MMFoundation_BindContext+0x15fbbd0>
10511ffa8: 900d82a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10511ffac: f9453500    	ldr	x0, [x8, #0xa68] ; iConsole
10511ffb0: d00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10511ffb4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10511ffb8: b00cb5a8    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
10511ffbc: 91292108    	add	x8, x8, #0xa48 ; CFString 'select at same session'
10511ffc0: f90003e8    	str	x8, [sp]
10511ffc4: b00b39c5    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
10511ffc8: 9122e0a5    	add	x5, x5, #0x8b8
10511ffcc: d00b39c7    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
10511ffd0: 912534e7    	add	x7, x7, #0x94d
10511ffd4: 52800042    	mov	w2, #0x2                ; =2
10511ffd8: d2800003    	mov	x3, #0x0                ; =0
10511ffdc: 52800004    	mov	w4, #0x0                ; =0
10511ffe0: 52815506    	mov	w6, #0xaa8              ; =2728
10511ffe4: 94ac1c56    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10511ffe8: 140000e1    	b	0x10512036c <_Flutter_MMFoundation_BindContext+0x15fbf50>
10511ffec: 900d68e8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10511fff0: f947d914    	ldr	x20, [x8, #0xfb0] ; m_contact
10511fff4: aa1503e0    	mov	x0, x21
10511fff8: aa1403e1    	mov	x1, x20
10511fffc: 94ac1c50    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120000: aa1d03fd    	mov	x29, x29
105120004: 94ac1c51    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105120008: aa0003f7    	mov	x23, x0
10512000c: f00d68c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
105120010: f947bd01    	ldr	x1, [x8, #0xf78] ; m_isPlugin
105120014: 94ac1c4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120018: aa0003f8    	mov	x24, x0
10512001c: aa1703e0    	mov	x0, x23
105120020: 94ac1c4d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105120024: 340004d8    	cbz	w24, 0x1051200bc <_Flutter_MMFoundation_BindContext+0x15fbca0>
105120028: aa1503e0    	mov	x0, x21
10512002c: aa1403e1    	mov	x1, x20
105120030: 94ac1c43    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120034: aa1d03fd    	mov	x29, x29
105120038: 94ac1c44    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10512003c: aa0003f7    	mov	x23, x0
105120040: f00d6c28    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
105120044: f9459901    	ldr	x1, [x8, #0xb30] ; isOpenPluginContactInfoView:
105120048: aa1603e0    	mov	x0, x22
10512004c: aa1703e2    	mov	x2, x23
105120050: 94ac1c3b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120054: aa0003f8    	mov	x24, x0
105120058: aa1703e0    	mov	x0, x23
10512005c: 94ac1c3e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105120060: 340002f8    	cbz	w24, 0x1051200bc <_Flutter_MMFoundation_BindContext+0x15fbca0>
105120064: aa1503e0    	mov	x0, x21
105120068: aa1403e1    	mov	x1, x20
10512006c: 94ac1c34    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120070: aa1d03fd    	mov	x29, x29
105120074: 94ac1c35    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105120078: aa0003f4    	mov	x20, x0
10512007c: f00d6c28    	adrp	x8, 0x11fea7000 <dyld_stub_binder+0x11fea7000>
105120080: f9459d01    	ldr	x1, [x8, #0xb38] ; openPluginContactInfoView:
105120084: aa1603e0    	mov	x0, x22
105120088: aa1403e2    	mov	x2, x20
10512008c: 94ac1c2c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120090: aa1403e0    	mov	x0, x20
105120094: 94ac1c30    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105120098: 900d8848    	adrp	x8, 0x120228000 <dyld_stub_binder+0x120228000>
10512009c: b9831908    	ldrsw	x8, [x8, #0x318]
1051200a0: f8686ac0    	ldr	x0, [x22, x8]
1051200a4: 900d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1051200a8: f947f901    	ldr	x1, [x8, #0xff0] ; deselectRowAtIndexPath:animated:
1051200ac: aa1303e2    	mov	x2, x19
1051200b0: 52800023    	mov	w3, #0x1                ; =1
1051200b4: 94ac1c22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051200b8: 140000ad    	b	0x10512036c <_Flutter_MMFoundation_BindContext+0x15fbf50>
1051200bc: aa1503e0    	mov	x0, x21
1051200c0: aa1403e1    	mov	x1, x20
1051200c4: 94ac1c1e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051200c8: aa1d03fd    	mov	x29, x29
1051200cc: 94ac1c1f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051200d0: aa0003f4    	mov	x20, x0
1051200d4: 900d6908    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
1051200d8: f941b101    	ldr	x1, [x8, #0x360] ; isTemplateMsgHolder
1051200dc: 94ac1c18    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051200e0: aa0003f7    	mov	x23, x0
1051200e4: aa1403e0    	mov	x0, x20
1051200e8: 94ac1c1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051200ec: 36000e37    	tbz	w23, #0x0, 0x1051202b0 <_Flutter_MMFoundation_BindContext+0x15fbe94>
1051200f0: f00d8288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051200f4: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
1051200f8: 900d7f08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
1051200fc: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105120100: f9001fe1    	str	x1, [sp, #0x38]
105120104: 94ac1c0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120108: aa1d03fd    	mov	x29, x29
10512010c: 94ac1c0f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105120110: aa0003f4    	mov	x20, x0
105120114: b00d82a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
105120118: f9436100    	ldr	x0, [x8, #0x6c0] ; ServiceNotifyMsgMgr
10512011c: f00d7ee8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105120120: f947ad01    	ldr	x1, [x8, #0xf58] ; class
105120124: f90017e1    	str	x1, [sp, #0x28]
105120128: 94ac1c05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10512012c: aa0003e2    	mov	x2, x0
105120130: b00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105120134: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
105120138: aa1403e0    	mov	x0, x20
10512013c: aa1b03e1    	mov	x1, x27
105120140: 94ac1bff    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120144: aa1d03fd    	mov	x29, x29
105120148: 94ac1c00    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10512014c: aa0003f8    	mov	x24, x0
105120150: b00d6928    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
105120154: f90027fc    	str	x28, [sp, #0x48]
105120158: f944c51c    	ldr	x28, [x8, #0x988] ; m_msgWrap
10512015c: aa1503e0    	mov	x0, x21
105120160: aa1c03e1    	mov	x1, x28
105120164: 94ac1bf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120168: aa1d03fd    	mov	x29, x29
10512016c: 94ac1bf7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105120170: f90023f9    	str	x25, [sp, #0x40]
105120174: aa0003f9    	mov	x25, x0
105120178: d00d7f28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10512017c: f9440917    	ldr	x23, [x8, #0x810] ; row
105120180: aa1303e0    	mov	x0, x19
105120184: aa1703e1    	mov	x1, x23
105120188: 94ac1bed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10512018c: aa0003fa    	mov	x26, x0
105120190: b00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105120194: f942e501    	ldr	x1, [x8, #0x5c8] ; m_uUnReadCount
105120198: f9001be1    	str	x1, [sp, #0x30]
10512019c: aa1503e0    	mov	x0, x21
1051201a0: 94ac1be7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051201a4: aa0003e4    	mov	x4, x0
1051201a8: f00d73c8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
1051201ac: f9404901    	ldr	x1, [x8, #0x90] ; onMainFrameMsgClick:rowIndex:unreadCount:
1051201b0: aa1803e0    	mov	x0, x24
1051201b4: aa1903e2    	mov	x2, x25
1051201b8: aa1a03e3    	mov	x3, x26
1051201bc: 94ac1be0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051201c0: aa1903e0    	mov	x0, x25
1051201c4: 94ac1be4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051201c8: aa1803e0    	mov	x0, x24
1051201cc: 94ac1be2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051201d0: aa1403e0    	mov	x0, x20
1051201d4: 94ac1be0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051201d8: f00d8288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051201dc: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
1051201e0: f9401fe1    	ldr	x1, [sp, #0x38]
1051201e4: 94ac1bd6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051201e8: aa1d03fd    	mov	x29, x29
1051201ec: 94ac1bd7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1051201f0: aa0003f8    	mov	x24, x0
1051201f4: b00d82a8    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
1051201f8: f9436100    	ldr	x0, [x8, #0x6c0] ; ServiceNotifyMsgMgr
1051201fc: f94017e1    	ldr	x1, [sp, #0x28]
105120200: 94ac1bcf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120204: aa0003e2    	mov	x2, x0
105120208: aa1803e0    	mov	x0, x24
10512020c: aa1b03e1    	mov	x1, x27
105120210: 94ac1bcb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120214: aa1d03fd    	mov	x29, x29
105120218: 94ac1bcc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10512021c: aa0003f4    	mov	x20, x0
105120220: aa1503e0    	mov	x0, x21
105120224: aa1c03e1    	mov	x1, x28
105120228: f94027fc    	ldr	x28, [sp, #0x48]
10512022c: 94ac1bc4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120230: aa1d03fd    	mov	x29, x29
105120234: 94ac1bc5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105120238: aa0003f9    	mov	x25, x0
10512023c: aa1303e0    	mov	x0, x19
105120240: aa1703e1    	mov	x1, x23
105120244: 94ac1bbe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120248: aa0003fa    	mov	x26, x0
10512024c: b00d68e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105120250: f9404101    	ldr	x1, [x8, #0x80] ; numberOfRowsInSection:
105120254: aa1c03e0    	mov	x0, x28
105120258: 52800022    	mov	w2, #0x1                ; =1
10512025c: 94ac1bb8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120260: aa0003fb    	mov	x27, x0
105120264: aa1503e0    	mov	x0, x21
105120268: f9401be1    	ldr	x1, [sp, #0x30]
10512026c: 94ac1bb4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120270: aa0003e4    	mov	x4, x0
105120274: f00d73c8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
105120278: f9404d01    	ldr	x1, [x8, #0x98] ; onMainFrameMsgClickForNewRowIndex:rowIndex:unreadCount:
10512027c: 8b1a0363    	add	x3, x27, x26
105120280: 900d885a    	adrp	x26, 0x120228000 <dyld_stub_binder+0x120228000>
105120284: aa1403e0    	mov	x0, x20
105120288: aa1903e2    	mov	x2, x25
10512028c: 94ac1bac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120290: aa1903e0    	mov	x0, x25
105120294: f94023f9    	ldr	x25, [sp, #0x40]
105120298: 94ac1baf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10512029c: aa1403e0    	mov	x0, x20
1051202a0: 94ac1bad    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051202a4: aa1803e0    	mov	x0, x24
1051202a8: 94ac1bab    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1051202ac: 14000003    	b	0x1051202b8 <_Flutter_MMFoundation_BindContext+0x15fbe9c>
1051202b0: d00d7f28    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
1051202b4: f9440917    	ldr	x23, [x8, #0x810] ; row
1051202b8: f00d8288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1051202bc: f9453514    	ldr	x20, [x8, #0xa68] ; iConsole
1051202c0: 900d68e8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
1051202c4: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
1051202c8: aa1303e0    	mov	x0, x19
1051202cc: 94ac1b9c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051202d0: aa0003f8    	mov	x24, x0
1051202d4: aa1303e0    	mov	x0, x19
1051202d8: aa1703e1    	mov	x1, x23
1051202dc: 94ac1b98    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1051202e0: b00d68c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
1051202e4: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
1051202e8: a90173e0    	stp	x0, x28, [sp, #0x10]
1051202ec: 900cb5a8    	adrp	x8, 0x11e7d4000 <dyld_stub_binder+0x11e7d4000>
1051202f0: 9129a108    	add	x8, x8, #0xa68 ; CFString 'MainFrameVC select at indexPath = (%ld, %ld), tableView = %@'
1051202f4: a90063e8    	stp	x8, x24, [sp]
1051202f8: 900b39c5    	adrp	x5, 0x11b858000 <dyld_stub_binder+0x11b858000>
1051202fc: 9122e0a5    	add	x5, x5, #0x8b8
105120300: b00b39c7    	adrp	x7, 0x11b859000 <dyld_stub_binder+0x11b859000>
105120304: 912534e7    	add	x7, x7, #0x94d
105120308: aa1403e0    	mov	x0, x20
10512030c: 52800042    	mov	w2, #0x2                ; =2
105120310: d2800003    	mov	x3, #0x0                ; =0
105120314: 52800004    	mov	w4, #0x0                ; =0
105120318: 52815766    	mov	w6, #0xabb              ; =2747
10512031c: 94ac1b88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120320: b9836b48    	ldrsw	x8, [x26, #0x368]
105120324: 8b0802c0    	add	x0, x22, x8
105120328: aa1503e1    	mov	x1, x21
10512032c: 94ac1b85    	bl	0x107c27140 <_Flutter_MMFoundation_BindContext+0x4102d24>
105120330: f8796ac0    	ldr	x0, [x22, x25]
105120334: f00d73c8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
105120338: f9405101    	ldr	x1, [x8, #0xa0] ; onDidSelectCellAt:
10512033c: aa1303e2    	mov	x2, x19
105120340: 94ac1b7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105120344: f00d73c8    	adrp	x8, 0x11ff9b000 <dyld_stub_binder+0x11ff9b000>
105120348: f9405501    	ldr	x1, [x8, #0xa8] ; openMessageContentView:startSendMessage:msgWrapToAdd:animated:jumpToFirstUnreadNode:indexPath:
10512034c: aa1603e0    	mov	x0, x22
105120350: aa1503e2    	mov	x2, x21
105120354: 52800003    	mov	w3, #0x0                ; =0
105120358: d2800004    	mov	x4, #0x0                ; =0
10512035c: 52800025    	mov	w5, #0x1                ; =1
105120360: 52800006    	mov	w6, #0x0                ; =0
105120364: aa1303e7    	mov	x7, x19
105120368: 94ac1b75    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10512036c: aa1503e0    	mov	x0, x21
105120370: 94ac1b79    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105120374: aa1c03e0    	mov	x0, x28
105120378: 94ac1b77    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10512037c: aa1303e0    	mov	x0, x19
105120380: a94a7bfd    	ldp	x29, x30, [sp, #0xa0]
105120384: a9494ff4    	ldp	x20, x19, [sp, #0x90]
105120388: a94857f6    	ldp	x22, x21, [sp, #0x80]
10512038c: a9475ff8    	ldp	x24, x23, [sp, #0x70]
105120390: a94667fa    	ldp	x26, x25, [sp, #0x60]
105120394: a9456ffc    	ldp	x28, x27, [sp, #0x50]
105120398: 9102c3ff    	add	sp, sp, #0xb0
10512039c: 14ac1b6e    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
