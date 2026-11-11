
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100f9b118:     	sub	sp, sp, #0x90
100f9b11c:     	stp	x24, x23, [sp, #0x50]
100f9b120:     	stp	x22, x21, [sp, #0x60]
100f9b124:     	stp	x20, x19, [sp, #0x70]
100f9b128:     	stp	x29, x30, [sp, #0x80]
100f9b12c:     	add	x29, sp, #0x80
100f9b130:     	mov	x19, x0
100f9b134:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100f9b138:     	mov	w9, #0x1                ; =1
100f9b13c:     	strb	w9, [x8, #0x778]
100f9b140:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b144:     	ldr	x20, [x8, #0x618]
100f9b148:     	adrp	x8, 0x11ed88000 <dyld_stub_binder+0x11ed88000>
100f9b14c:     	ldrsw	x23, [x8, #0xfb8]
100f9b150:     	ldr	x0, [x0, x23]
100f9b154:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f9b158:     	ldr	x21, [x8, #0x620]
100f9b15c:     	mov	x1, x21
100f9b160:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b164:     	mov	x29, x29
100f9b168:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b16c:     	mov	x22, x0
100f9b170:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b174:     	ldr	x1, [x8, #0x310]
100f9b178:     	adrp	x8, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9b17c:     	add	x8, x8, #0x118
100f9b180:     	stp	x8, x0, [sp]
100f9b184:     	adrp	x5, 0x119ce6000 <dyld_stub_binder+0x119ce6000>
100f9b188:     	add	x5, x5, #0x900
100f9b18c:     	adrp	x7, 0x119ce7000 <dyld_stub_binder+0x119ce7000>
100f9b190:     	add	x7, x7, #0x160
100f9b194:     	mov	x0, x20
100f9b198:     	mov	w2, #0x2                ; =2
100f9b19c:     	mov	x3, #0x0                ; =0
100f9b1a0:     	mov	w4, #0x0                ; =0
100f9b1a4:     	mov	w6, #0x843              ; =2115
100f9b1a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b1ac:     	mov	x0, x22
100f9b1b0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b1b4:     	adrp	x8, 0x11ed1a000 <dyld_stub_binder+0x11ed1a000>
100f9b1b8:     	ldr	x0, [x8, #0x888]
100f9b1bc:     	bl	0x107c27c08 <_Flutter_MMFoundation_BindContext+0x3eae8d4>
100f9b1c0:     	ldr	x2, [x19, x23]
100f9b1c4:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f9b1c8:     	ldr	x1, [x8, #0x528]
100f9b1cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b1d0:     	mov	x20, x0
100f9b1d4:     	sub	x0, x29, #0x38
100f9b1d8:     	mov	x1, x19
100f9b1dc:     	bl	0x107c27c58 <_Flutter_MMFoundation_BindContext+0x3eae924>
100f9b1e0:     	ldr	x0, [x19, x23]
100f9b1e4:     	mov	x1, x21
100f9b1e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b1ec:     	mov	x29, x29
100f9b1f0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b1f4:     	mov	x21, x0
100f9b1f8:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f9b1fc:     	ldr	x8, [x8, #0x930]
100f9b200:     	str	x8, [sp, #0x18]
100f9b204:     	adrp	x8, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
100f9b208:     	ldr	d0, [x8, #0x680]
100f9b20c:     	adrp	x8, 0x100f9b000 <__text+0xf93000>
100f9b210:     	add	x8, x8, #0x29c
100f9b214:     	str	d0, [sp, #0x20]
100f9b218:     	adrp	x9, 0x11c283000 <dyld_stub_binder+0x11c283000>
100f9b21c:     	add	x9, x9, #0x590
100f9b220:     	stp	x8, x9, [sp, #0x28]
100f9b224:     	add	x22, sp, #0x18
100f9b228:     	add	x0, x22, #0x28
100f9b22c:     	sub	x1, x29, #0x38
100f9b230:     	bl	0x107c27c30 <_Flutter_MMFoundation_BindContext+0x3eae8fc>
100f9b234:     	str	x21, [sp, #0x38]
100f9b238:     	adrp	x8, 0x11ea13000 <dyld_stub_binder+0x11ea13000>
100f9b23c:     	ldr	x1, [x8, #0x4d0]
100f9b240:     	add	x2, sp, #0x18
100f9b244:     	mov	x0, x20
100f9b248:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b24c:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100f9b250:     	ldr	x1, [x8, #0xac8]
100f9b254:     	mov	x0, x20
100f9b258:     	mov	x2, x19
100f9b25c:     	mov	w3, #0x1                ; =1
100f9b260:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b264:     	add	x0, x22, #0x28
100f9b268:     	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
100f9b26c:     	mov	x0, x21
100f9b270:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b274:     	sub	x0, x29, #0x38
100f9b278:     	bl	0x107c27c34 <_Flutter_MMFoundation_BindContext+0x3eae900>
100f9b27c:     	mov	x0, x20
100f9b280:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b284:     	ldp	x29, x30, [sp, #0x80]
100f9b288:     	ldp	x20, x19, [sp, #0x70]
100f9b28c:     	ldp	x22, x21, [sp, #0x60]
100f9b290:     	ldp	x24, x23, [sp, #0x50]
100f9b294:     	add	sp, sp, #0x90
100f9b298:     	ret
100f9b29c:     	sub	sp, sp, #0x70
100f9b2a0:     	stp	x24, x23, [sp, #0x30]
100f9b2a4:     	stp	x22, x21, [sp, #0x40]
100f9b2a8:     	stp	x20, x19, [sp, #0x50]
100f9b2ac:     	stp	x29, x30, [sp, #0x60]
100f9b2b0:     	add	x29, sp, #0x60
100f9b2b4:     	mov	x20, x1
100f9b2b8:     	mov	x21, x0
100f9b2bc:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f9b2c0:     	ldr	x8, [x8, #0xa30]
100f9b2c4:     	ldr	x8, [x8]
100f9b2c8:     	str	x8, [sp, #0x28]
100f9b2cc:     	add	x0, x0, #0x28
100f9b2d0:     	bl	0x107c27c5c <_Flutter_MMFoundation_BindContext+0x3eae928>
100f9b2d4:     	mov	x19, x0
100f9b2d8:     	cbz	w20, 0x100f9b2fc <__text+0xf932fc>
100f9b2dc:     	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
100f9b2e0:     	ldr	x0, [x8, #0x680]
100f9b2e4:     	ldr	x2, [x21, #0x20]
100f9b2e8:     	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
100f9b2ec:     	ldr	x1, [x8, #0x910]
100f9b2f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b2f4:     	mov	w22, #0x1               ; =1
100f9b2f8:     	b	0x100f9b300 <__text+0xf93300>
100f9b2fc:     	mov	w22, #0x2               ; =2
100f9b300:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
100f9b304:     	ldr	x1, [x8, #0x7a0]
100f9b308:     	mov	x0, x19
100f9b30c:     	mov	x2, x20
100f9b310:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b314:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b318:     	ldr	x0, [x8, #0x780]
100f9b31c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b320:     	ldr	x1, [x8, #0x800]
100f9b324:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b328:     	mov	x29, x29
100f9b32c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b330:     	mov	x20, x0
100f9b334:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b338:     	ldr	x0, [x8, #0xc10]
100f9b33c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f9b340:     	ldr	x1, [x8, #0x508]
100f9b344:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b348:     	mov	x2, x0
100f9b34c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100f9b350:     	ldr	x1, [x8, #0xa40]
100f9b354:     	mov	x0, x20
100f9b358:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b35c:     	mov	x29, x29
100f9b360:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b364:     	mov	x21, x0
100f9b368:     	adrp	x8, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
100f9b36c:     	add	x8, x8, #0x4b8
100f9b370:     	adrp	x9, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9b374:     	add	x10, x9, #0x138
100f9b378:     	adrp	x9, 0x11d044000 <dyld_stub_binder+0x11d044000>
100f9b37c:     	add	x9, x9, #0x158
100f9b380:     	str	x8, [sp, #0x8]
100f9b384:     	stp	x9, x10, [sp, #0x10]
100f9b388:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b38c:     	ldr	x0, [x8, #0x6c0]
100f9b390:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100f9b394:     	ldr	x1, [x8, #0x5a8]
100f9b398:     	mov	x2, x22
100f9b39c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b3a0:     	mov	x29, x29
100f9b3a4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b3a8:     	mov	x22, x0
100f9b3ac:     	str	x0, [sp, #0x20]
100f9b3b0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100f9b3b4:     	ldr	x0, [x8, #0x698]
100f9b3b8:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100f9b3bc:     	ldr	x1, [x8, #0xfc0]
100f9b3c0:     	add	x2, sp, #0x18
100f9b3c4:     	add	x3, sp, #0x8
100f9b3c8:     	mov	w4, #0x2                ; =2
100f9b3cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b3d0:     	mov	x29, x29
100f9b3d4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100f9b3d8:     	mov	x23, x0
100f9b3dc:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100f9b3e0:     	ldr	x1, [x8, #0xe38]
100f9b3e4:     	adrp	x2, 0x11cfa1000 <dyld_stub_binder+0x11cfa1000>
100f9b3e8:     	add	x2, x2, #0x498
100f9b3ec:     	mov	x0, x21
100f9b3f0:     	mov	x3, #0x0                ; =0
100f9b3f4:     	mov	x4, x23
100f9b3f8:     	mov	w5, #0x6785             ; =26501
100f9b3fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100f9b400:     	mov	x0, x23
100f9b404:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b408:     	mov	x0, x22
100f9b40c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b410:     	mov	x0, x21
100f9b414:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b418:     	mov	x0, x20
100f9b41c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b420:     	mov	x0, x19
100f9b424:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100f9b428:     	ldr	x8, [sp, #0x28]
100f9b42c:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100f9b430:     	ldr	x9, [x9, #0xa30]
100f9b434:     	ldr	x9, [x9]
100f9b438:     	cmp	x9, x8
100f9b43c:     	b.ne	0x100f9b458 <__text+0xf93458>
100f9b440:     	ldp	x29, x30, [sp, #0x60]
100f9b444:     	ldp	x20, x19, [sp, #0x50]
100f9b448:     	ldp	x22, x21, [sp, #0x40]
100f9b44c:     	ldp	x24, x23, [sp, #0x30]
100f9b450:     	add	sp, sp, #0x70
100f9b454:     	ret
100f9b458:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
