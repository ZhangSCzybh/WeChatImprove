
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104abe968: d10143ff    	sub	sp, sp, #0x50
104abe96c: a9015ff8    	stp	x24, x23, [sp, #0x10]
104abe970: a90257f6    	stp	x22, x21, [sp, #0x20]
104abe974: a9034ff4    	stp	x20, x19, [sp, #0x30]
104abe978: a9047bfd    	stp	x29, x30, [sp, #0x40]
104abe97c: 910103fd    	add	x29, sp, #0x40
104abe980: 900e0c08    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104abe984: 52800029    	mov	w9, #0x1                ; =1
104abe988: 390ef109    	strb	w9, [x8, #0x3bc]
104abe98c: f00db828    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104abe990: f942e108    	ldr	x8, [x8, #0x5c0]
104abe994: a90023e0    	stp	x0, x8, [sp]
104abe998: 900db228    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104abe99c: f9466901    	ldr	x1, [x8, #0xcd0] ; selector init
104abe9a0: 910003e0    	mov	x0, sp
104abe9a4: 94c5a1e8    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104abe9a8: aa0003f3    	mov	x19, x0
104abe9ac: b4000a20    	cbz	x0, 0x104abeaf0 <_Flutter_MMFoundation_BindContext+0xf9a6d4>
104abe9b0: b00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abe9b4: b9848508    	ldrsw	x8, [x8, #0x484]
104abe9b8: b8286a7f    	str	wzr, [x19, x8]
104abe9bc: b00db248    	adrp	x8, 0x120107000 <dyld_stub_binder+0x120107000>
104abe9c0: f9451501    	ldr	x1, [x8, #0xa28] ; selector setDelegate:
104abe9c4: aa1303e0    	mov	x0, x19
104abe9c8: aa1303e2    	mov	x2, x19
104abe9cc: 94c5a1dc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abe9d0: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abe9d4: f9416901    	ldr	x1, [x8, #0x2d0] ; selector p_createTabBarItems
104abe9d8: aa1303e0    	mov	x0, x19
104abe9dc: 94c5a1d8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abe9e0: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abe9e4: f9416d01    	ldr	x1, [x8, #0x2d8] ; selector p_createSlimViewControllers
104abe9e8: aa1303e0    	mov	x0, x19
104abe9ec: 94c5a1d4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abe9f0: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abe9f4: f9414101    	ldr	x1, [x8, #0x280] ; selector p_createNewMainFrameViewController
104abe9f8: aa1303e0    	mov	x0, x19
104abe9fc: 94c5a1d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abea00: b00dbb28    	adrp	x8, 0x120223000 <dyld_stub_binder+0x120223000>
104abea04: b9848908    	ldrsw	x8, [x8, #0x488]
104abea08: f8686a62    	ldr	x2, [x19, x8]
104abea0c: d00d9d88    	adrp	x8, 0x11fe70000 <dyld_stub_binder+0x11fe70000>
104abea10: f9410101    	ldr	x1, [x8, #0x200] ; selector setViewControllers:
104abea14: aa1303e0    	mov	x0, x19
104abea18: 94c5a1c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abea1c: f00db688    	adrp	x8, 0x120191000 <dyld_stub_binder+0x120191000>
104abea20: f941a900    	ldr	x0, [x8, #0x350] ; class WCLazyInitObjectMgr
104abea24: 900db268    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
104abea28: f9437d01    	ldr	x1, [x8, #0x6f8] ; selector sharedInstance
104abea2c: 94c5a1c4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abea30: aa1d03fd    	mov	x29, x29
104abea34: 94c5a1c5    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abea38: aa0003f4    	mov	x20, x0
104abea3c: 900da5c8    	adrp	x8, 0x11ff76000 <dyld_stub_binder+0x11ff76000>
104abea40: f947b101    	ldr	x1, [x8, #0xf60] ; selector addLazyInitObject:
104abea44: aa1303e2    	mov	x2, x19
104abea48: 94c5a1bd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abea4c: aa1403e0    	mov	x0, x20
104abea50: 94c5a1c1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abea54: b00db5b8    	adrp	x24, 0x120173000 <dyld_stub_binder+0x120173000>
104abea58: f9458f00    	ldr	x0, [x24, #0xb18] ; class NSNotificationCenter
104abea5c: d00db208    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104abea60: f946b114    	ldr	x20, [x8, #0xd60] ; selector defaultCenter
104abea64: aa1403e1    	mov	x1, x20
104abea68: 94c5a1b5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abea6c: aa1d03fd    	mov	x29, x29
104abea70: 94c5a1b6    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abea74: aa0003f5    	mov	x21, x0
104abea78: f00da628    	adrp	x8, 0x11ff85000 <dyld_stub_binder+0x11ff85000>
104abea7c: f9417116    	ldr	x22, [x8, #0x2e0] ; selector onCaptureScreen:
104abea80: d00c5968    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
104abea84: f9408908    	ldr	x8, [x8, #0x110]
104abea88: f9400104    	ldr	x4, [x8]
104abea8c: 900db208    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
104abea90: f9470117    	ldr	x23, [x8, #0xe00] ; selector addObserver:selector:name:object:
104abea94: aa1703e1    	mov	x1, x23
104abea98: aa1303e2    	mov	x2, x19
104abea9c: aa1603e3    	mov	x3, x22
104abeaa0: d2800005    	mov	x5, #0x0                ; =0
104abeaa4: 94c5a1a6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeaa8: aa1503e0    	mov	x0, x21
104abeaac: 94c5a1aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abeab0: f9458f00    	ldr	x0, [x24, #0xb18] ; class NSNotificationCenter
104abeab4: aa1403e1    	mov	x1, x20
104abeab8: 94c5a1a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeabc: aa1d03fd    	mov	x29, x29
104abeac0: 94c5a1a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104abeac4: aa0003f4    	mov	x20, x0
104abeac8: d00c5968    	adrp	x8, 0x11d5ec000 <dyld_stub_binder+0x11d5ec000>
104abeacc: f9421508    	ldr	x8, [x8, #0x428]
104abead0: f9400104    	ldr	x4, [x8]
104abead4: aa1703e1    	mov	x1, x23
104abead8: aa1303e2    	mov	x2, x19
104abeadc: aa1603e3    	mov	x3, x22
104abeae0: d2800005    	mov	x5, #0x0                ; =0
104abeae4: 94c5a196    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104abeae8: aa1403e0    	mov	x0, x20
104abeaec: 94c5a19a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104abeaf0: aa1303e0    	mov	x0, x19
104abeaf4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104abeaf8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104abeafc: a94257f6    	ldp	x22, x21, [sp, #0x20]
104abeb00: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104abeb04: 910143ff    	add	sp, sp, #0x50
104abeb08: d65f03c0    	ret
