
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105c0d124: d101c3ff    	sub	sp, sp, #0x70
105c0d128: a9016ffc    	stp	x28, x27, [sp, #0x10]
105c0d12c: a90267fa    	stp	x26, x25, [sp, #0x20]
105c0d130: a9035ff8    	stp	x24, x23, [sp, #0x30]
105c0d134: a90457f6    	stp	x22, x21, [sp, #0x40]
105c0d138: a9054ff4    	stp	x20, x19, [sp, #0x50]
105c0d13c: a9067bfd    	stp	x29, x30, [sp, #0x60]
105c0d140: 910183fd    	add	x29, sp, #0x60
105c0d144: aa0003f3    	mov	x19, x0
105c0d148: b00d81a8    	adrp	x8, 0x120c42000 <dyld_stub_binder+0x120c42000>
105c0d14c: 52800029    	mov	w9, #0x1                ; =1
105c0d150: 390fe109    	strb	w9, [x8, #0x3f8]
105c0d154: b00d1188    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
105c0d158: f9410517    	ldr	x23, [x8, #0x208] ; messageWrap
105c0d15c: aa1703e1    	mov	x1, x23
105c0d160: 948067f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d164: aa1d03fd    	mov	x29, x29
105c0d168: 948067f8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d16c: aa0003f4    	mov	x20, x0
105c0d170: 900d13a8    	adrp	x8, 0x11fe81000 <dyld_stub_binder+0x11fe81000>
105c0d174: f942ed01    	ldr	x1, [x8, #0x5d8] ; IsRoomAnnouncement
105c0d178: 948067f1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d17c: aa0003f5    	mov	x21, x0
105c0d180: aa1403e0    	mov	x0, x20
105c0d184: 948067f4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d188: 34000d35    	cbz	w21, 0x105c0d32c <_Flutter_MMFoundation_BindContext+0x20e8f10>
105c0d18c: d00d1188    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
105c0d190: f9437914    	ldr	x20, [x8, #0x6f0] ; chatContact
105c0d194: aa1303e0    	mov	x0, x19
105c0d198: aa1403e1    	mov	x1, x20
105c0d19c: 948067e8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d1a0: aa1d03fd    	mov	x29, x29
105c0d1a4: 948067e9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d1a8: aa0003f5    	mov	x21, x0
105c0d1ac: d00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0d1b0: f9478100    	ldr	x0, [x8, #0xf00] ;  /, 
105c0d1b4: d00d2788    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105c0d1b8: f947ad18    	ldr	x24, [x8, #0xf58] ; class
105c0d1bc: aa1803e1    	mov	x1, x24
105c0d1c0: 948067df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d1c4: aa0003e2    	mov	x2, x0
105c0d1c8: d00d27a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105c0d1cc: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
105c0d1d0: aa1503e0    	mov	x0, x21
105c0d1d4: 948067da    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d1d8: aa0003f6    	mov	x22, x0
105c0d1dc: aa1503e0    	mov	x0, x21
105c0d1e0: 948067dd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d1e4: 34000a56    	cbz	w22, 0x105c0d32c <_Flutter_MMFoundation_BindContext+0x20e8f10>
105c0d1e8: aa1303e0    	mov	x0, x19
105c0d1ec: aa1403e1    	mov	x1, x20
105c0d1f0: 948067d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d1f4: aa1d03fd    	mov	x29, x29
105c0d1f8: 948067d4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d1fc: aa0003f4    	mov	x20, x0
105c0d200: aa1303e0    	mov	x0, x19
105c0d204: aa1703e1    	mov	x1, x23
105c0d208: 948067cd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d20c: aa1d03fd    	mov	x29, x29
105c0d210: 948067ce    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d214: aa0003f5    	mov	x21, x0
105c0d218: f00d1168    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
105c0d21c: f947d501    	ldr	x1, [x8, #0xfa8] ; m_n64MesSvrID
105c0d220: 948067c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d224: aa0003fa    	mov	x26, x0
105c0d228: d00d2b28    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105c0d22c: f945e900    	ldr	x0, [x8, #0xbd0] ; ��d 
105c0d230: f00d2788    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105c0d234: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
105c0d238: 948067c1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d23c: aa1d03fd    	mov	x29, x29
105c0d240: 948067c2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d244: aa0003f6    	mov	x22, x0
105c0d248: b00d2b48    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
105c0d24c: f9417500    	ldr	x0, [x8, #0x2e8]
105c0d250: aa1803e1    	mov	x1, x24
105c0d254: 948067ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d258: aa0003e2    	mov	x2, x0
105c0d25c: 900d1168    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105c0d260: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
105c0d264: aa1603e0    	mov	x0, x22
105c0d268: 948067b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d26c: aa1d03fd    	mov	x29, x29
105c0d270: 948067b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d274: aa0003f8    	mov	x24, x0
105c0d278: aa1303e0    	mov	x0, x19
105c0d27c: aa1703e1    	mov	x1, x23
105c0d280: 948067af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d284: aa1d03fd    	mov	x29, x29
105c0d288: 948067b0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d28c: aa0003f7    	mov	x23, x0
105c0d290: 900d1188    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
105c0d294: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
105c0d298: 948067a9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d29c: aa1d03fd    	mov	x29, x29
105c0d2a0: 948067aa    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d2a4: aa0003f9    	mov	x25, x0
105c0d2a8: b00d1d88    	adrp	x8, 0x11ffbe000 <dyld_stub_binder+0x11ffbe000>
105c0d2ac: f9418101    	ldr	x1, [x8, #0x300] ; getLatestRoomDescSvrIdForRoom:
105c0d2b0: aa1803e0    	mov	x0, x24
105c0d2b4: aa1903e2    	mov	x2, x25
105c0d2b8: 948067a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d2bc: eb00035f    	cmp	x26, x0
105c0d2c0: 540003a1    	b.ne	0x105c0d334 <_Flutter_MMFoundation_BindContext+0x20e8f18>
105c0d2c4: d00d1208    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
105c0d2c8: f9418d01    	ldr	x1, [x8, #0x318] ; m_ChatRoomDetail
105c0d2cc: aa1403e0    	mov	x0, x20
105c0d2d0: 9480679b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d2d4: aa1d03fd    	mov	x29, x29
105c0d2d8: 9480679c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d2dc: aa0003fa    	mov	x26, x0
105c0d2e0: d00d1208    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
105c0d2e4: f9419101    	ldr	x1, [x8, #0x320] ; m_nsChatRoomDesc
105c0d2e8: 94806795    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d2ec: aa1d03fd    	mov	x29, x29
105c0d2f0: 94806796    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105c0d2f4: aa0003fb    	mov	x27, x0
105c0d2f8: d00d27a8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
105c0d2fc: f946e901    	ldr	x1, [x8, #0xdd0] ; length
105c0d300: 9480678f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105c0d304: b40001c0    	cbz	x0, 0x105c0d33c <_Flutter_MMFoundation_BindContext+0x20e8f20>
105c0d308: d00d2dc8    	adrp	x8, 0x1201c7000 <dyld_stub_binder+0x1201c7000>
105c0d30c: f947d108    	ldr	x8, [x8, #0xfa0]
105c0d310: a90023f3    	stp	x19, x8, [sp]
105c0d314: b00d1208    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
105c0d318: f9471901    	ldr	x1, [x8, #0xe30] ; shouldShowRoomTodoView
105c0d31c: 910003e0    	mov	x0, sp
105c0d320: 94806789    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
105c0d324: aa0003f3    	mov	x19, x0
105c0d328: 14000006    	b	0x105c0d340 <_Flutter_MMFoundation_BindContext+0x20e8f24>
105c0d32c: 52800013    	mov	w19, #0x0               ; =0
105c0d330: 14000014    	b	0x105c0d380 <_Flutter_MMFoundation_BindContext+0x20e8f64>
105c0d334: 52800013    	mov	w19, #0x0               ; =0
105c0d338: 14000006    	b	0x105c0d350 <_Flutter_MMFoundation_BindContext+0x20e8f34>
105c0d33c: 52800013    	mov	w19, #0x0               ; =0
105c0d340: aa1b03e0    	mov	x0, x27
105c0d344: 94806784    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d348: aa1a03e0    	mov	x0, x26
105c0d34c: 94806782    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d350: aa1903e0    	mov	x0, x25
105c0d354: 94806780    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d358: aa1703e0    	mov	x0, x23
105c0d35c: 9480677e    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d360: aa1803e0    	mov	x0, x24
105c0d364: 9480677c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d368: aa1603e0    	mov	x0, x22
105c0d36c: 9480677a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d370: aa1503e0    	mov	x0, x21
105c0d374: 94806778    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d378: aa1403e0    	mov	x0, x20
105c0d37c: 94806776    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105c0d380: aa1303e0    	mov	x0, x19
105c0d384: a9467bfd    	ldp	x29, x30, [sp, #0x60]
105c0d388: a9454ff4    	ldp	x20, x19, [sp, #0x50]
105c0d38c: a94457f6    	ldp	x22, x21, [sp, #0x40]
105c0d390: a9435ff8    	ldp	x24, x23, [sp, #0x30]
105c0d394: a94267fa    	ldp	x26, x25, [sp, #0x20]
105c0d398: a9416ffc    	ldp	x28, x27, [sp, #0x10]
105c0d39c: 9101c3ff    	add	sp, sp, #0x70
105c0d3a0: d65f03c0    	ret