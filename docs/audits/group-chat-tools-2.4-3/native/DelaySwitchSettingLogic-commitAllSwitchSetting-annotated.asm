
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10121b1cc:     	adrp	x8, 0x11f744000 <dyld_stub_binder+0x11f744000>
10121b1d0:     	mov	w9, #0x1                ; =1
10121b1d4:     	strb	w9, [x8, #0x14c]
10121b1d8:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
10121b1dc:     	ldrsw	x8, [x8, #0x2d4]
10121b1e0:     	ldrb	w9, [x0, x8]
10121b1e4:     	cmp	w9, #0x1
10121b1e8:     	b.ne	0x10121b318 <__text+0x1213318>
10121b1ec:     	stp	x26, x25, [sp, #-0x50]!
10121b1f0:     	stp	x24, x23, [sp, #0x10]
10121b1f4:     	stp	x22, x21, [sp, #0x20]
10121b1f8:     	stp	x20, x19, [sp, #0x30]
10121b1fc:     	stp	x29, x30, [sp, #0x40]
10121b200:     	add	x29, sp, #0x40
10121b204:     	mov	x19, x0
10121b208:     	strb	wzr, [x0, x8]
10121b20c:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121b210:     	ldr	x1, [x8, #0x428] ; selector: commitQuickReplySettingChange
10121b214:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b218:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10121b21c:     	ldr	x1, [x8, #0x430] ; selector: commitApnsContentSettingChange
10121b220:     	mov	x0, x19
10121b224:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b228:     	adrp	x25, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121b22c:     	ldr	x0, [x25, #0x780]
10121b230:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b234:     	ldr	x19, [x8, #0x800] ; selector: currentContext
10121b238:     	mov	x1, x19
10121b23c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b240:     	mov	x29, x29
10121b244:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b248:     	mov	x20, x0
10121b24c:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10121b250:     	ldr	x0, [x8, #0xc30]
10121b254:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121b258:     	ldr	x21, [x8, #0x508] ; selector: class
10121b25c:     	mov	x1, x21
10121b260:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b264:     	mov	x2, x0
10121b268:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121b26c:     	ldr	x22, [x8, #0xa40] ; selector: getService:
10121b270:     	mov	x0, x20
10121b274:     	mov	x1, x22
10121b278:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b27c:     	mov	x29, x29
10121b280:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b284:     	mov	x23, x0
10121b288:     	adrp	x8, 0x11e9e4000 <dyld_stub_binder+0x11e9e4000>
10121b28c:     	ldr	x24, [x8, #0x250] ; selector: NeedToSyncOplog
10121b290:     	mov	x1, x24
10121b294:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b298:     	mov	x0, x23
10121b29c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121b2a0:     	mov	x0, x20
10121b2a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121b2a8:     	ldr	x0, [x25, #0x780]
10121b2ac:     	mov	x1, x19
10121b2b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b2b4:     	mov	x29, x29
10121b2b8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b2bc:     	mov	x19, x0
10121b2c0:     	adrp	x8, 0x11ed1b000 <dyld_stub_binder+0x11ed1b000>
10121b2c4:     	ldr	x0, [x8, #0x6a0]
10121b2c8:     	mov	x1, x21
10121b2cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b2d0:     	mov	x2, x0
10121b2d4:     	mov	x0, x19
10121b2d8:     	mov	x1, x22
10121b2dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b2e0:     	mov	x29, x29
10121b2e4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121b2e8:     	mov	x20, x0
10121b2ec:     	mov	x1, x24
10121b2f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121b2f4:     	mov	x0, x20
10121b2f8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121b2fc:     	mov	x0, x19
10121b300:     	ldp	x29, x30, [sp, #0x40]
10121b304:     	ldp	x20, x19, [sp, #0x30]
10121b308:     	ldp	x22, x21, [sp, #0x20]
10121b30c:     	ldp	x24, x23, [sp, #0x10]
10121b310:     	ldp	x26, x25, [sp], #0x50
10121b314:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121b318:     	ret
