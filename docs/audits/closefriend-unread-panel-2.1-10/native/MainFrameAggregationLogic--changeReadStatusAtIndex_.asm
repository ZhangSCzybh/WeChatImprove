
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6f7a8: d106c3ff    	sub	sp, sp, #0x1b0
104a6f7ac: a9156ffc    	stp	x28, x27, [sp, #0x150]
104a6f7b0: a91667fa    	stp	x26, x25, [sp, #0x160]
104a6f7b4: a9175ff8    	stp	x24, x23, [sp, #0x170]
104a6f7b8: a91857f6    	stp	x22, x21, [sp, #0x180]
104a6f7bc: a9194ff4    	stp	x20, x19, [sp, #0x190]
104a6f7c0: a91a7bfd    	stp	x29, x30, [sp, #0x1a0]
104a6f7c4: 910683fd    	add	x29, sp, #0x1a0
104a6f7c8: aa0003fa    	mov	x26, x0
104a6f7cc: 900c5c08    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104a6f7d0: f9405908    	ldr	x8, [x8, #0xb0]
104a6f7d4: f9400108    	ldr	x8, [x8]
104a6f7d8: f81a03a8    	stur	x8, [x29, #-0x60]
104a6f7dc: f00e0e68    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a6f7e0: 52800029    	mov	w9, #0x1                ; =1
104a6f7e4: 390ad509    	strb	w9, [x8, #0x2b5]
104a6f7e8: 900d9f68    	adrp	x8, 0x11fe5b000 <dyld_stub_binder+0x11fe5b000>
104a6f7ec: f9427d01    	ldr	x1, [x8, #0x4f8] ; selector sessionAtIndex:
104a6f7f0: 94c6de53    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f7f4: aa1d03fd    	mov	x29, x29
104a6f7f8: 94c6de54    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f7fc: aa0003fb    	mov	x27, x0
104a6f800: a9077fff    	stp	xzr, xzr, [sp, #0x70]
104a6f804: 900db868    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104a6f808: f9420900    	ldr	x0, [x8, #0x410] ; class MainFrameFoldReporter
104a6f80c: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6f810: f9406d01    	ldr	x1, [x8, #0xd8] ; selector getUnreadCountFrom:in24hUnreadMsgCnt:out24hUnreadMsgCnt:
104a6f814: 9101e3e3    	add	x3, sp, #0x78
104a6f818: 9101c3e4    	add	x4, sp, #0x70
104a6f81c: aa1b03e2    	mov	x2, x27
104a6f820: 94c6de47    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f824: 900db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6f828: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104a6f82c: b00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6f830: f944e919    	ldr	x25, [x8, #0x9d0] ; selector currentContext
104a6f834: aa1903e1    	mov	x1, x25
104a6f838: 94c6de41    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f83c: aa1d03fd    	mov	x29, x29
104a6f840: 94c6de42    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f844: aa0003f4    	mov	x20, x0
104a6f848: b00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6f84c: f941bd00    	ldr	x0, [x8, #0x378] ; class MainSessionMgr
104a6f850: 900db488    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a6f854: f947ad13    	ldr	x19, [x8, #0xf58] ; selector class
104a6f858: aa1303e1    	mov	x1, x19
104a6f85c: 94c6de38    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f860: aa0003e2    	mov	x2, x0
104a6f864: d00d9e48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a6f868: f9464118    	ldr	x24, [x8, #0xc80] ; selector getService:
104a6f86c: aa1403e0    	mov	x0, x20
104a6f870: aa1803e1    	mov	x1, x24
104a6f874: 94c6de32    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f878: aa1d03fd    	mov	x29, x29
104a6f87c: 94c6de33    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f880: aa0003f5    	mov	x21, x0
104a6f884: b00d9ea8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a6f888: f947d91c    	ldr	x28, [x8, #0xfb0] ; selector m_nsUserName
104a6f88c: aa1b03e0    	mov	x0, x27
104a6f890: aa1c03e1    	mov	x1, x28
104a6f894: 94c6de2a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f898: aa1d03fd    	mov	x29, x29
104a6f89c: 94c6de2b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f8a0: aa0003f6    	mov	x22, x0
104a6f8a4: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6f8a8: f9407101    	ldr	x1, [x8, #0xe0] ; selector visibleSessionIndexForUsername:
104a6f8ac: aa1503e0    	mov	x0, x21
104a6f8b0: aa1603e2    	mov	x2, x22
104a6f8b4: 94c6de22    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f8b8: aa0003f7    	mov	x23, x0
104a6f8bc: aa1603e0    	mov	x0, x22
104a6f8c0: 94c6de25    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f8c4: aa1503e0    	mov	x0, x21
104a6f8c8: 94c6de23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f8cc: aa1403e0    	mov	x0, x20
104a6f8d0: 94c6de21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6f8d4: 92f00008    	mov	x8, #0x7fffffffffffffff ; =9223372036854775807
104a6f8d8: eb0802ff    	cmp	x23, x8
104a6f8dc: 9a9707e8    	csinc	x8, xzr, x23, eq
104a6f8e0: f90013e8    	str	x8, [sp, #0x20]
104a6f8e4: 900db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6f8e8: f945e900    	ldr	x0, [x8, #0xbd0] ; class MMContext
104a6f8ec: f90037f9    	str	x25, [sp, #0x68]
104a6f8f0: aa1903e1    	mov	x1, x25
104a6f8f4: aa1303f9    	mov	x25, x19
104a6f8f8: aa1b03f3    	mov	x19, x27
104a6f8fc: 94c6de10    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f900: aa1d03fd    	mov	x29, x29
104a6f904: 94c6de11    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f908: aa0003f4    	mov	x20, x0
104a6f90c: b00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6f910: f9402900    	ldr	x0, [x8, #0x50] ; class DataReportService
104a6f914: aa1903e1    	mov	x1, x25
104a6f918: 94c6de09    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f91c: aa0003e2    	mov	x2, x0
104a6f920: f90027f4    	str	x20, [sp, #0x48]
104a6f924: aa1403e0    	mov	x0, x20
104a6f928: f9002ff8    	str	x24, [sp, #0x58]
104a6f92c: aa1803e1    	mov	x1, x24
104a6f930: 94c6de03    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f934: aa1d03fd    	mov	x29, x29
104a6f938: 94c6de04    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f93c: f9001fe0    	str	x0, [sp, #0x38]
104a6f940: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6f944: 911fa108    	add	x8, x8, #0x7e8 ; CFString 'unread_num'
104a6f948: f90043e8    	str	x8, [sp, #0x80]
104a6f94c: 900db835    	adrp	x21, 0x120173000 <dyld_stub_binder+0x120173000>
104a6f950: f9458ab4    	ldr	x20, [x21, #0xb10] ; class NSNumber
104a6f954: d00d9e68    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a6f958: f942e518    	ldr	x24, [x8, #0x5c8] ; selector m_uUnReadCount
104a6f95c: aa1b03e0    	mov	x0, x27
104a6f960: aa1803e1    	mov	x1, x24
104a6f964: 94c6ddf6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f968: aa0003e2    	mov	x2, x0
104a6f96c: b00db4a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a6f970: f947bd17    	ldr	x23, [x8, #0xf78] ; selector numberWithUnsignedInt:
104a6f974: aa1403e0    	mov	x0, x20
104a6f978: aa1703e1    	mov	x1, x23
104a6f97c: 94c6ddf0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f980: aa1d03fd    	mov	x29, x29
104a6f984: 94c6ddf1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f988: f9001be0    	str	x0, [sp, #0x30]
104a6f98c: f81403a0    	stur	x0, [x29, #-0xc0]
104a6f990: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6f994: 91222108    	add	x8, x8, #0x888 ; CFString 'unread_group_event_ms'
104a6f998: f90047e8    	str	x8, [sp, #0x88]
104a6f99c: f9458ab4    	ldr	x20, [x21, #0xb10] ; class NSNumber
104a6f9a0: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6f9a4: f9407501    	ldr	x1, [x8, #0xe8] ; selector enterPageTime
104a6f9a8: aa1a03e0    	mov	x0, x26
104a6f9ac: 94c6dde4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f9b0: aa0003e2    	mov	x2, x0
104a6f9b4: b00db4a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a6f9b8: f947c901    	ldr	x1, [x8, #0xf90] ; selector numberWithUnsignedLongLong:
104a6f9bc: aa1403e0    	mov	x0, x20
104a6f9c0: 94c6dddf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f9c4: aa1d03fd    	mov	x29, x29
104a6f9c8: 94c6dde0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6f9cc: f90017e0    	str	x0, [sp, #0x28]
104a6f9d0: f81483a0    	stur	x0, [x29, #-0xb8]
104a6f9d4: 900cd1a8    	adrp	x8, 0x11e4a3000 <dyld_stub_binder+0x11e4a3000>
104a6f9d8: 913b2108    	add	x8, x8, #0xec8 ; CFString 'chat_type'
104a6f9dc: f9004be8    	str	x8, [sp, #0x90]
104a6f9e0: f9458ab4    	ldr	x20, [x21, #0xb10] ; class NSNumber
104a6f9e4: d00db828    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
104a6f9e8: f9457100    	ldr	x0, [x8, #0xae0] ; class MainSessionReporter
104a6f9ec: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6f9f0: f9407901    	ldr	x1, [x8, #0xf0] ; selector chatTypeForSession:
104a6f9f4: aa1b03e2    	mov	x2, x27
104a6f9f8: 94c6ddd1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6f9fc: aa0003e2    	mov	x2, x0
104a6fa00: b00db4a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a6fa04: f947a916    	ldr	x22, [x8, #0xf50] ; selector numberWithInteger:
104a6fa08: aa1403e0    	mov	x0, x20
104a6fa0c: aa1603e1    	mov	x1, x22
104a6fa10: 94c6ddcb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fa14: aa1d03fd    	mov	x29, x29
104a6fa18: 94c6ddcc    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fa1c: f9000fe0    	str	x0, [sp, #0x18]
104a6fa20: f81503a0    	stur	x0, [x29, #-0xb0]
104a6fa24: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fa28: 9122a108    	add	x8, x8, #0x8a8 ; CFString 'slide_action'
104a6fa2c: f9004fe8    	str	x8, [sp, #0x98]
104a6fa30: f9458ab4    	ldr	x20, [x21, #0xb10] ; class NSNumber
104a6fa34: aa1b03e0    	mov	x0, x27
104a6fa38: f90023f8    	str	x24, [sp, #0x40]
104a6fa3c: aa1803e1    	mov	x1, x24
104a6fa40: 94c6ddbf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fa44: 7100001f    	cmp	w0, #0x0
104a6fa48: 52800028    	mov	w8, #0x1                ; =1
104a6fa4c: 1a881502    	cinc	w2, w8, eq
104a6fa50: b00db4a8    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
104a6fa54: f947a518    	ldr	x24, [x8, #0xf48] ; selector numberWithInt:
104a6fa58: aa1403e0    	mov	x0, x20
104a6fa5c: aa1803e1    	mov	x1, x24
104a6fa60: 94c6ddb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fa64: aa1d03fd    	mov	x29, x29
104a6fa68: 94c6ddb8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fa6c: f9000be0    	str	x0, [sp, #0x10]
104a6fa70: f81583a0    	stur	x0, [x29, #-0xa8]
104a6fa74: f00cd1a8    	adrp	x8, 0x11e4a6000 <dyld_stub_binder+0x11e4a6000>
104a6fa78: 9136a108    	add	x8, x8, #0xda8 ; CFString 'chat_username'
104a6fa7c: f90053e8    	str	x8, [sp, #0xa0]
104a6fa80: aa1b03e0    	mov	x0, x27
104a6fa84: f9002bfc    	str	x28, [sp, #0x50]
104a6fa88: aa1c03e1    	mov	x1, x28
104a6fa8c: 94c6ddac    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fa90: aa1d03fd    	mov	x29, x29
104a6fa94: 94c6ddad    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fa98: aa0003f4    	mov	x20, x0
104a6fa9c: 900db4a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
104a6faa0: f946e901    	ldr	x1, [x8, #0xdd0] ; selector length
104a6faa4: 94c6dda6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6faa8: f90033f9    	str	x25, [sp, #0x60]
104a6faac: f90007f4    	str	x20, [sp, #0x8]
104a6fab0: b4000180    	cbz	x0, 0x104a6fae0 <_Flutter_MMFoundation_BindContext+0xf4b6c4>
104a6fab4: f00db4c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a6fab8: f9466d01    	ldr	x1, [x8, #0xcd8] ; selector stringByReplacingOccurrencesOfString:withString:
104a6fabc: b00cd162    	adrp	x2, 0x11e49c000 <dyld_stub_binder+0x11e49c000>
104a6fac0: 9126a042    	add	x2, x2, #0x9a8 ; CFString ','
104a6fac4: 900cd163    	adrp	x3, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a6fac8: 9102a063    	add	x3, x3, #0xa8 ; CFString ' '
104a6facc: aa1403e0    	mov	x0, x20
104a6fad0: 94c6dd9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fad4: aa1d03fd    	mov	x29, x29
104a6fad8: 94c6dd9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fadc: 14000003    	b	0x104a6fae8 <_Flutter_MMFoundation_BindContext+0xf4b6cc>
104a6fae0: 900cd160    	adrp	x0, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a6fae4: 91032000    	add	x0, x0, #0xc8 ; CFString ''
104a6fae8: f90003e0    	str	x0, [sp]
104a6faec: f81603a0    	stur	x0, [x29, #-0xa0]
104a6faf0: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6faf4: 91232108    	add	x8, x8, #0x8c8 ; CFString 'latest_msg_ts'
104a6faf8: f90057e8    	str	x8, [sp, #0xa8]
104a6fafc: f9458ab9    	ldr	x25, [x21, #0xb10] ; class NSNumber
104a6fb00: d00d9e68    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104a6fb04: f9413501    	ldr	x1, [x8, #0x268] ; selector m_uLastTime
104a6fb08: aa1303e0    	mov	x0, x19
104a6fb0c: 94c6dd8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fb10: aa0003e2    	mov	x2, x0
104a6fb14: aa1903e0    	mov	x0, x25
104a6fb18: aa1703e1    	mov	x1, x23
104a6fb1c: 94c6dd88    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fb20: aa1d03fd    	mov	x29, x29
104a6fb24: 94c6dd89    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fb28: aa0003f7    	mov	x23, x0
104a6fb2c: f81683a0    	stur	x0, [x29, #-0x98]
104a6fb30: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fb34: 9123a108    	add	x8, x8, #0x8e8 ; CFString 'in_unread_group'
104a6fb38: f9005be8    	str	x8, [sp, #0xb0]
104a6fb3c: f9458ab9    	ldr	x25, [x21, #0xb10] ; class NSNumber
104a6fb40: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6fb44: f9407d01    	ldr	x1, [x8, #0xf8] ; selector isSessionInInitalList:
104a6fb48: aa1a03e0    	mov	x0, x26
104a6fb4c: aa1303e2    	mov	x2, x19
104a6fb50: 94c6dd7b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fb54: aa0003e2    	mov	x2, x0
104a6fb58: aa1903e0    	mov	x0, x25
104a6fb5c: aa1803e1    	mov	x1, x24
104a6fb60: 94c6dd77    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fb64: aa1d03fd    	mov	x29, x29
104a6fb68: 94c6dd78    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fb6c: aa0003fc    	mov	x28, x0
104a6fb70: f81703a0    	stur	x0, [x29, #-0x90]
104a6fb74: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fb78: 91242108    	add	x8, x8, #0x908 ; CFString 'in24h_unread_msg_cnt'
104a6fb7c: f9005fe8    	str	x8, [sp, #0xb8]
104a6fb80: f9458aa0    	ldr	x0, [x21, #0xb10] ; class NSNumber
104a6fb84: f9403fe2    	ldr	x2, [sp, #0x78]
104a6fb88: aa1603e1    	mov	x1, x22
104a6fb8c: 94c6dd6c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fb90: aa1d03fd    	mov	x29, x29
104a6fb94: 94c6dd6d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fb98: aa0003fa    	mov	x26, x0
104a6fb9c: f81783a0    	stur	x0, [x29, #-0x88]
104a6fba0: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fba4: 9124a108    	add	x8, x8, #0x928 ; CFString 'out24h_unread_msg_cnt'
104a6fba8: f90063e8    	str	x8, [sp, #0xc0]
104a6fbac: f9458aa0    	ldr	x0, [x21, #0xb10] ; class NSNumber
104a6fbb0: f9403be2    	ldr	x2, [sp, #0x70]
104a6fbb4: aa1603e1    	mov	x1, x22
104a6fbb8: 94c6dd61    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fbbc: aa1d03fd    	mov	x29, x29
104a6fbc0: 94c6dd62    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fbc4: aa0003f9    	mov	x25, x0
104a6fbc8: f81803a0    	stur	x0, [x29, #-0x80]
104a6fbcc: d00cd1c8    	adrp	x8, 0x11e4a9000 <dyld_stub_binder+0x11e4a9000>
104a6fbd0: 910ba108    	add	x8, x8, #0x2e8 ; CFString 'log_version'
104a6fbd4: f90067e8    	str	x8, [sp, #0xc8]
104a6fbd8: f9458aa0    	ldr	x0, [x21, #0xb10] ; class NSNumber
104a6fbdc: aa1803e1    	mov	x1, x24
104a6fbe0: 528e2082    	mov	w2, #0x7104             ; =28932
104a6fbe4: 72a18262    	movk	w2, #0xc13, lsl #16
104a6fbe8: 94c6dd55    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fbec: aa1d03fd    	mov	x29, x29
104a6fbf0: 94c6dd56    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fbf4: aa0003f8    	mov	x24, x0
104a6fbf8: f81883a0    	stur	x0, [x29, #-0x78]
104a6fbfc: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fc00: 91252108    	add	x8, x8, #0x948 ; CFString 'user_grey_type'
104a6fc04: f9006be8    	str	x8, [sp, #0xd0]
104a6fc08: f9458abb    	ldr	x27, [x21, #0xb10] ; class NSNumber
104a6fc0c: f00db908    	adrp	x8, 0x120192000 <dyld_stub_binder+0x120192000>
104a6fc10: f944b900    	ldr	x0, [x8, #0x970] ; class MainFrameUnreadReporter
104a6fc14: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6fc18: f9408101    	ldr	x1, [x8, #0x100] ; selector getXlabType
104a6fc1c: 94c6dd48    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fc20: aa0003e2    	mov	x2, x0
104a6fc24: aa1b03e0    	mov	x0, x27
104a6fc28: aa1603e1    	mov	x1, x22
104a6fc2c: 94c6dd44    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fc30: aa1d03fd    	mov	x29, x29
104a6fc34: 94c6dd45    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fc38: aa0003fb    	mov	x27, x0
104a6fc3c: f81903a0    	stur	x0, [x29, #-0x70]
104a6fc40: b00ce968    	adrp	x8, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fc44: 9120a108    	add	x8, x8, #0x828 ; CFString 'rownumAbsolute'
104a6fc48: f9006fe8    	str	x8, [sp, #0xd8]
104a6fc4c: f9458aa0    	ldr	x0, [x21, #0xb10] ; class NSNumber
104a6fc50: aa1603e1    	mov	x1, x22
104a6fc54: f94013e2    	ldr	x2, [sp, #0x20]
104a6fc58: 94c6dd39    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fc5c: aa1d03fd    	mov	x29, x29
104a6fc60: 94c6dd3a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fc64: aa0003f6    	mov	x22, x0
104a6fc68: f81983a0    	stur	x0, [x29, #-0x68]
104a6fc6c: 900db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6fc70: f9457500    	ldr	x0, [x8, #0xae8] ; class NSDictionary
104a6fc74: d00db488    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
104a6fc78: f9402901    	ldr	x1, [x8, #0x50] ; selector dictionaryWithObjects:forKeys:count:
104a6fc7c: d10303a2    	sub	x2, x29, #0xc0
104a6fc80: 910203e3    	add	x3, sp, #0x80
104a6fc84: 52800184    	mov	w4, #0xc                ; =12
104a6fc88: 94c6dd2d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fc8c: aa1d03fd    	mov	x29, x29
104a6fc90: 94c6dd2e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fc94: aa0003f5    	mov	x21, x0
104a6fc98: b00d9e68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a6fc9c: f9429501    	ldr	x1, [x8, #0x528] ; selector reportCustomEvent:params:routeRule:
104a6fca0: b00ce962    	adrp	x2, 0x11e79c000 <dyld_stub_binder+0x11e79c000>
104a6fca4: 9121a042    	add	x2, x2, #0x868 ; CFString 'view_unread_chat_slide'
104a6fca8: f9401ff4    	ldr	x20, [sp, #0x38]
104a6fcac: aa1403e0    	mov	x0, x20
104a6fcb0: aa1503e3    	mov	x3, x21
104a6fcb4: 52912e44    	mov	w4, #0x8972             ; =35186
104a6fcb8: 94c6dd21    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fcbc: aa1503e0    	mov	x0, x21
104a6fcc0: 94c6dd25    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fcc4: aa1603e0    	mov	x0, x22
104a6fcc8: 94c6dd23    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fccc: aa1b03e0    	mov	x0, x27
104a6fcd0: 94c6dd21    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fcd4: aa1803e0    	mov	x0, x24
104a6fcd8: 94c6dd1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fcdc: aa1903e0    	mov	x0, x25
104a6fce0: 94c6dd1d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fce4: aa1a03e0    	mov	x0, x26
104a6fce8: 94c6dd1b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fcec: aa1c03e0    	mov	x0, x28
104a6fcf0: 94c6dd19    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fcf4: aa1703e0    	mov	x0, x23
104a6fcf8: 94c6dd17    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fcfc: f94003e0    	ldr	x0, [sp]
104a6fd00: 94c6dd15    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd04: f94007e0    	ldr	x0, [sp, #0x8]
104a6fd08: 94c6dd13    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd0c: f9400be0    	ldr	x0, [sp, #0x10]
104a6fd10: 94c6dd11    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd14: f9400fe0    	ldr	x0, [sp, #0x18]
104a6fd18: 94c6dd0f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd1c: f94017e0    	ldr	x0, [sp, #0x28]
104a6fd20: 94c6dd0d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd24: f9401be0    	ldr	x0, [sp, #0x30]
104a6fd28: 94c6dd0b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd2c: aa1403e0    	mov	x0, x20
104a6fd30: 94c6dd09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd34: f94027e0    	ldr	x0, [sp, #0x48]
104a6fd38: 94c6dd07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fd3c: aa1303e0    	mov	x0, x19
104a6fd40: f94023e1    	ldr	x1, [sp, #0x40]
104a6fd44: 94c6dcfe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fd48: aa0003f6    	mov	x22, x0
104a6fd4c: 900db839    	adrp	x25, 0x120173000 <dyld_stub_binder+0x120173000>
104a6fd50: f945eb20    	ldr	x0, [x25, #0xbd0] ; class MMContext
104a6fd54: f94037f8    	ldr	x24, [sp, #0x68]
104a6fd58: aa1803e1    	mov	x1, x24
104a6fd5c: 94c6dcf8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fd60: aa1d03fd    	mov	x29, x29
104a6fd64: 94c6dcf9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fd68: aa0003f4    	mov	x20, x0
104a6fd6c: b00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6fd70: f9427900    	ldr	x0, [x8, #0x4f0] ; class OnlineClientMgr
104a6fd74: f94033fa    	ldr	x26, [sp, #0x60]
104a6fd78: aa1a03e1    	mov	x1, x26
104a6fd7c: 94c6dcf0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fd80: aa0003e2    	mov	x2, x0
104a6fd84: aa1403e0    	mov	x0, x20
104a6fd88: f9402ffb    	ldr	x27, [sp, #0x58]
104a6fd8c: aa1b03e1    	mov	x1, x27
104a6fd90: 94c6dceb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fd94: aa1d03fd    	mov	x29, x29
104a6fd98: 94c6dcec    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fd9c: aa0003f5    	mov	x21, x0
104a6fda0: aa1303e0    	mov	x0, x19
104a6fda4: f9402bfc    	ldr	x28, [sp, #0x50]
104a6fda8: aa1c03e1    	mov	x1, x28
104a6fdac: 94c6dce4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fdb0: aa1d03fd    	mov	x29, x29
104a6fdb4: 94c6dce5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fdb8: aa0003f7    	mov	x23, x0
104a6fdbc: 34000596    	cbz	w22, 0x104a6fe6c <_Flutter_MMFoundation_BindContext+0xf4ba50>
104a6fdc0: f00d9ec8    	adrp	x8, 0x11fe4a000 <dyld_stub_binder+0x11fe4a000>
104a6fdc4: f946ad01    	ldr	x1, [x8, #0xd58] ; selector MarkChatRead:
104a6fdc8: aa1503e0    	mov	x0, x21
104a6fdcc: aa1703e2    	mov	x2, x23
104a6fdd0: 94c6dcdb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fdd4: aa1703e0    	mov	x0, x23
104a6fdd8: 94c6dcdf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fddc: aa1503e0    	mov	x0, x21
104a6fde0: 94c6dcdd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fde4: aa1403e0    	mov	x0, x20
104a6fde8: 94c6dcdb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fdec: f945eb20    	ldr	x0, [x25, #0xbd0] ; class MMContext
104a6fdf0: aa1803e1    	mov	x1, x24
104a6fdf4: 94c6dcd2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fdf8: aa1d03fd    	mov	x29, x29
104a6fdfc: 94c6dcd3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fe00: aa0003f4    	mov	x20, x0
104a6fe04: b00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6fe08: f9403100    	ldr	x0, [x8, #0x60] ; class CMessageMgr
104a6fe0c: aa1a03e1    	mov	x1, x26
104a6fe10: 94c6dccb    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fe14: aa0003e2    	mov	x2, x0
104a6fe18: aa1403e0    	mov	x0, x20
104a6fe1c: aa1b03e1    	mov	x1, x27
104a6fe20: 94c6dcc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fe24: aa1d03fd    	mov	x29, x29
104a6fe28: 94c6dcc8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fe2c: aa0003f5    	mov	x21, x0
104a6fe30: aa1303e0    	mov	x0, x19
104a6fe34: aa1c03e1    	mov	x1, x28
104a6fe38: 94c6dcc1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fe3c: aa1d03fd    	mov	x29, x29
104a6fe40: 94c6dcc2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fe44: aa0003f7    	mov	x23, x0
104a6fe48: b00d9ea8    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a6fe4c: f9443501    	ldr	x1, [x8, #0x868] ; selector ClearUnRead:FromID:ToID:
104a6fe50: aa1503e0    	mov	x0, x21
104a6fe54: aa1703e2    	mov	x2, x23
104a6fe58: 52800003    	mov	w3, #0x0                ; =0
104a6fe5c: 52800004    	mov	w4, #0x0                ; =0
104a6fe60: 94c6dcb7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fe64: 52800016    	mov	w22, #0x0               ; =0
104a6fe68: 14000007    	b	0x104a6fe84 <_Flutter_MMFoundation_BindContext+0xf4ba68>
104a6fe6c: b00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6fe70: f9408501    	ldr	x1, [x8, #0x108] ; selector MarkChatUnread:
104a6fe74: aa1503e0    	mov	x0, x21
104a6fe78: aa1703e2    	mov	x2, x23
104a6fe7c: 94c6dcb0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fe80: 52800036    	mov	w22, #0x1               ; =1
104a6fe84: aa1703e0    	mov	x0, x23
104a6fe88: 94c6dcb3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fe8c: aa1503e0    	mov	x0, x21
104a6fe90: 94c6dcb1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fe94: aa1403e0    	mov	x0, x20
104a6fe98: 94c6dcaf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6fe9c: f945eb20    	ldr	x0, [x25, #0xbd0] ; class MMContext
104a6fea0: aa1803e1    	mov	x1, x24
104a6fea4: 94c6dca6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fea8: aa1d03fd    	mov	x29, x29
104a6feac: 94c6dca7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6feb0: aa0003f4    	mov	x20, x0
104a6feb4: b00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6feb8: f9401d00    	ldr	x0, [x8, #0x38] ; class MMNewSessionMgr
104a6febc: aa1a03e1    	mov	x1, x26
104a6fec0: 94c6dc9f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fec4: aa0003e2    	mov	x2, x0
104a6fec8: aa1403e0    	mov	x0, x20
104a6fecc: aa1b03e1    	mov	x1, x27
104a6fed0: 94c6dc9b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6fed4: aa1d03fd    	mov	x29, x29
104a6fed8: 94c6dc9c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fedc: aa0003f5    	mov	x21, x0
104a6fee0: aa1303e0    	mov	x0, x19
104a6fee4: aa1c03e1    	mov	x1, x28
104a6fee8: 94c6dc95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6feec: aa1d03fd    	mov	x29, x29
104a6fef0: 94c6dc96    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6fef4: aa0003f7    	mov	x23, x0
104a6fef8: 900d9ee8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
104a6fefc: f9458d01    	ldr	x1, [x8, #0xb18] ; selector ChangeSessionUnReadCount:to:
104a6ff00: aa1503e0    	mov	x0, x21
104a6ff04: aa1703e2    	mov	x2, x23
104a6ff08: aa1603e3    	mov	x3, x22
104a6ff0c: 94c6dc8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6ff10: aa1703e0    	mov	x0, x23
104a6ff14: 94c6dc90    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ff18: aa1503e0    	mov	x0, x21
104a6ff1c: 94c6dc8e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ff20: aa1403e0    	mov	x0, x20
104a6ff24: 94c6dc8c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ff28: aa1303e0    	mov	x0, x19
104a6ff2c: 94c6dc8a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6ff30: f85a03a8    	ldur	x8, [x29, #-0x60]
104a6ff34: 900c5c09    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
104a6ff38: f9405929    	ldr	x9, [x9, #0xb0]
104a6ff3c: f9400129    	ldr	x9, [x9]
104a6ff40: eb08013f    	cmp	x9, x8
104a6ff44: 54000121    	b.ne	0x104a6ff68 <_Flutter_MMFoundation_BindContext+0xf4bb4c>
104a6ff48: a95a7bfd    	ldp	x29, x30, [sp, #0x1a0]
104a6ff4c: a9594ff4    	ldp	x20, x19, [sp, #0x190]
104a6ff50: a95857f6    	ldp	x22, x21, [sp, #0x180]
104a6ff54: a9575ff8    	ldp	x24, x23, [sp, #0x170]
104a6ff58: a95667fa    	ldp	x26, x25, [sp, #0x160]
104a6ff5c: a9556ffc    	ldp	x28, x27, [sp, #0x150]
104a6ff60: 9106c3ff    	add	sp, sp, #0x1b0
104a6ff64: d65f03c0    	ret
104a6ff68: 94c6dc83    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
