
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a781fc: d101c3ff    	sub	sp, sp, #0x70
104a78200: a9016ffc    	stp	x28, x27, [sp, #0x10]
104a78204: a90267fa    	stp	x26, x25, [sp, #0x20]
104a78208: a9035ff8    	stp	x24, x23, [sp, #0x30]
104a7820c: a90457f6    	stp	x22, x21, [sp, #0x40]
104a78210: a9054ff4    	stp	x20, x19, [sp, #0x50]
104a78214: a9067bfd    	stp	x29, x30, [sp, #0x60]
104a78218: 910183fd    	add	x29, sp, #0x60
104a7821c: aa0003f3    	mov	x19, x0
104a78220: d00e0e28    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a78224: 5280003c    	mov	w28, #0x1               ; =1
104a78228: 390b511c    	strb	w28, [x8, #0x2d4]
104a7822c: f9400400    	ldr	x0, [x0, #0x8]
104a78230: f00d9e08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a78234: f947d914    	ldr	x20, [x8, #0xfb0] ; m_contact
104a78238: aa1403e1    	mov	x1, x20
104a7823c: 94c6bbc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78240: aa1d03fd    	mov	x29, x29
104a78244: 94c6bbc1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a78248: aa0003f7    	mov	x23, x0
104a7824c: f00d9e08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a78250: f9434d01    	ldr	x1, [x8, #0x698] ; m_nsUsrName
104a78254: 94c6bbba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78258: aa1d03fd    	mov	x29, x29
104a7825c: 94c6bbbb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a78260: aa0003f8    	mov	x24, x0
104a78264: f9400660    	ldr	x0, [x19, #0x8]
104a78268: b00d9e68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a7826c: f944c515    	ldr	x21, [x8, #0x988] ; m_msgWrap
104a78270: aa1503e1    	mov	x1, x21
104a78274: 94c6bbb2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78278: aa1d03fd    	mov	x29, x29
104a7827c: 94c6bbb3    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a78280: aa0003f9    	mov	x25, x0
104a78284: f00d9e28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a78288: f941e916    	ldr	x22, [x8, #0x3d0] ; m_nsRealChatUsr
104a7828c: aa1603e1    	mov	x1, x22
104a78290: 94c6bbab    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78294: aa1d03fd    	mov	x29, x29
104a78298: 94c6bbac    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7829c: aa0003fa    	mov	x26, x0
104a782a0: 900db448    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a782a4: f940b901    	ldr	x1, [x8, #0x170] ; compare:
104a782a8: aa1803e0    	mov	x0, x24
104a782ac: aa1a03e2    	mov	x2, x26
104a782b0: 94c6bba3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a782b4: aa0003fb    	mov	x27, x0
104a782b8: aa1a03e0    	mov	x0, x26
104a782bc: 94c6bba6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a782c0: aa1903e0    	mov	x0, x25
104a782c4: 94c6bba4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a782c8: aa1803e0    	mov	x0, x24
104a782cc: 94c6bba2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a782d0: aa1703e0    	mov	x0, x23
104a782d4: 94c6bba0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a782d8: b4000adb    	cbz	x27, 0x104a78430 <_Flutter_MMFoundation_BindContext+0xf54014>
104a782dc: f00db7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a782e0: f945e900    	ldr	x0, [x8, #0xbd0] ; MMContext
104a782e4: 900db448    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a782e8: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
104a782ec: 94c6bb94    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a782f0: aa1d03fd    	mov	x29, x29
104a782f4: 94c6bb95    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a782f8: aa0003f7    	mov	x23, x0
104a782fc: 900db7e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a78300: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
104a78304: f00db428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
104a78308: f947ad01    	ldr	x1, [x8, #0xf58] ; class
104a7830c: 94c6bb8c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78310: aa0003e2    	mov	x2, x0
104a78314: b00d9e08    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104a78318: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
104a7831c: aa1703e0    	mov	x0, x23
104a78320: 94c6bb87    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78324: aa1d03fd    	mov	x29, x29
104a78328: 94c6bb88    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7832c: aa0003f8    	mov	x24, x0
104a78330: aa1703e0    	mov	x0, x23
104a78334: 94c6bb88    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a78338: f9400660    	ldr	x0, [x19, #0x8]
104a7833c: aa1503e1    	mov	x1, x21
104a78340: 94c6bb7f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78344: aa1d03fd    	mov	x29, x29
104a78348: 94c6bb80    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a7834c: aa0003f7    	mov	x23, x0
104a78350: aa1603e1    	mov	x1, x22
104a78354: 94c6bb7a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78358: aa1d03fd    	mov	x29, x29
104a7835c: 94c6bb7b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a78360: aa0003f6    	mov	x22, x0
104a78364: 900d9e28    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
104a78368: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
104a7836c: aa1803e0    	mov	x0, x24
104a78370: aa1603e2    	mov	x2, x22
104a78374: 94c6bb72    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78378: aa1d03fd    	mov	x29, x29
104a7837c: 94c6bb73    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a78380: aa0003f5    	mov	x21, x0
104a78384: aa1603e0    	mov	x0, x22
104a78388: 94c6bb73    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7838c: aa1703e0    	mov	x0, x23
104a78390: 94c6bb71    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a78394: aa1803e0    	mov	x0, x24
104a78398: 94c6bb6f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7839c: b40004b5    	cbz	x21, 0x104a78430 <_Flutter_MMFoundation_BindContext+0xf54014>
104a783a0: 3900da7f    	strb	wzr, [x19, #0x36]
104a783a4: f00d9e08    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
104a783a8: f9470901    	ldr	x1, [x8, #0xe10] ; isSelf
104a783ac: aa1503e0    	mov	x0, x21
104a783b0: 94c6bb63    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a783b4: 37000420    	tbnz	w0, #0x0, 0x104a78438 <_Flutter_MMFoundation_BindContext+0xf5401c>
104a783b8: f9400660    	ldr	x0, [x19, #0x8]
104a783bc: aa1403e1    	mov	x1, x20
104a783c0: 94c6bb5f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a783c4: aa1d03fd    	mov	x29, x29
104a783c8: 94c6bb60    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a783cc: aa0003f3    	mov	x19, x0
104a783d0: 900d9e48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a783d4: f9413d01    	ldr	x1, [x8, #0x278] ; getChatRoomMemberDisplayName:
104a783d8: aa1503e2    	mov	x2, x21
104a783dc: 94c6bb58    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a783e0: aa1d03fd    	mov	x29, x29
104a783e4: 94c6bb59    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a783e8: aa0003f4    	mov	x20, x0
104a783ec: aa1303e0    	mov	x0, x19
104a783f0: 94c6bb59    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a783f4: b40003d4    	cbz	x20, 0x104a7846c <_Flutter_MMFoundation_BindContext+0xf54050>
104a783f8: f00db7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a783fc: f9454500    	ldr	x0, [x8, #0xa88]
104a78400: d00db488    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104a78404: f946a501    	ldr	x1, [x8, #0xd48] ; stringWithFormat:
104a78408: f90003f4    	str	x20, [sp]
104a7840c: 900cd842    	adrp	x2, 0x11e580000 <dyld_stub_binder+0x11e580000>
104a78410: 91202042    	add	x2, x2, #0x808 ; CFString '%@: '
104a78414: 94c6bb4a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a78418: aa1d03fd    	mov	x29, x29
104a7841c: 94c6bb4b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a78420: aa0003f3    	mov	x19, x0
104a78424: aa1403e0    	mov	x0, x20
104a78428: 94c6bb4b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a7842c: 14000005    	b	0x104a78440 <_Flutter_MMFoundation_BindContext+0xf54024>
104a78430: d2800015    	mov	x21, #0x0               ; =0
104a78434: 3900da7c    	strb	w28, [x19, #0x36]
104a78438: f00cd113    	adrp	x19, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
104a7843c: 91032273    	add	x19, x19, #0xc8 ; CFString ''
104a78440: aa1503e0    	mov	x0, x21
104a78444: 94c6bb44    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a78448: aa1303e0    	mov	x0, x19
104a7844c: a9467bfd    	ldp	x29, x30, [sp, #0x60]
104a78450: a9454ff4    	ldp	x20, x19, [sp, #0x50]
104a78454: a94457f6    	ldp	x22, x21, [sp, #0x40]
104a78458: a9435ff8    	ldp	x24, x23, [sp, #0x30]
104a7845c: a94267fa    	ldp	x26, x25, [sp, #0x20]
104a78460: a9416ffc    	ldp	x28, x27, [sp, #0x10]
104a78464: 9101c3ff    	add	sp, sp, #0x70
104a78468: 14c6bb42    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
104a7846c: d2800013    	mov	x19, #0x0               ; =0
104a78470: 17fffff4    	b	0x104a78440 <_Flutter_MMFoundation_BindContext+0xf54024>
