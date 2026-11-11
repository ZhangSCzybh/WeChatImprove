
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100fd803c:     	stp	x24, x23, [sp, #-0x40]!
100fd8040:     	stp	x22, x21, [sp, #0x10]
100fd8044:     	stp	x20, x19, [sp, #0x20]
100fd8048:     	stp	x29, x30, [sp, #0x30]
100fd804c:     	add	x29, sp, #0x30
100fd8050:     	mov	x23, x6
100fd8054:     	mov	x22, x5
100fd8058:     	mov	x21, x4
100fd805c:     	mov	x20, x3
100fd8060:     	mov	x19, x2
100fd8064:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fd8068:     	mov	w9, #0x1                ; =1
100fd806c:     	strb	w9, [x8, #0x892]
100fd8070:     	mov	x0, x2
100fd8074:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8078:     	mov	x0, x20
100fd807c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8080:     	mov	x0, x21
100fd8084:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8088:     	mov	x0, x22
100fd808c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100fd8090:     	cbz	x19, 0x100fd81c0 <__text+0xfd01c0>
100fd8094:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd8098:     	ldr	x0, [x8, #0xac0]
100fd809c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fd80a0:     	ldr	x1, [x8, #0x508]
100fd80a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80a8:     	mov	x2, x0
100fd80ac:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100fd80b0:     	ldr	x1, [x8, #0x890]
100fd80b4:     	mov	x0, x19
100fd80b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80bc:     	cbz	w0, 0x100fd81c0 <__text+0xfd01c0>
100fd80c0:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100fd80c4:     	ldr	x1, [x8, #0xa60]
100fd80c8:     	mov	x0, x19
100fd80cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80d0:     	cbz	w0, 0x100fd81c0 <__text+0xfd01c0>
100fd80d4:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100fd80d8:     	ldr	x1, [x8, #0x158]
100fd80dc:     	mov	x0, x19
100fd80e0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80e4:     	tbnz	w0, #0x0, 0x100fd80fc <__text+0xfd00fc>
100fd80e8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100fd80ec:     	ldr	x1, [x8, #0xda0]
100fd80f0:     	mov	x0, x19
100fd80f4:     	mov	w2, #0xe                ; =14
100fd80f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd80fc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd8100:     	ldr	x0, [x8, #0xbd0]
100fd8104:     	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
100fd8108:     	mov	x24, x0
100fd810c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd8110:     	ldr	x1, [x8, #0xd30]
100fd8114:     	mov	x2, x19
100fd8118:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd811c:     	adrp	x8, 0x11e9de000 <dyld_stub_binder+0x11e9de000>
100fd8120:     	ldr	x1, [x8, #0xb60]
100fd8124:     	mov	x0, x24
100fd8128:     	mov	x2, x20
100fd812c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8130:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd8134:     	ldr	x1, [x8, #0xd48]
100fd8138:     	mov	x0, x24
100fd813c:     	mov	w2, #0xc                ; =12
100fd8140:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8144:     	adrp	x8, 0x11e9dc000 <dyld_stub_binder+0x11e9dc000>
100fd8148:     	ldr	x1, [x8, #0x500]
100fd814c:     	mov	x0, x24
100fd8150:     	mov	x2, x23
100fd8154:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8158:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd815c:     	ldr	x1, [x8, #0xb68]
100fd8160:     	mov	x0, x24
100fd8164:     	mov	x2, x22
100fd8168:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd816c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd8170:     	ldr	x1, [x8, #0xd38]
100fd8174:     	mov	x0, x24
100fd8178:     	mov	w2, #0x1                ; =1
100fd817c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8180:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100fd8184:     	ldr	x1, [x8, #0x360]
100fd8188:     	mov	x0, x21
100fd818c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8190:     	mov	x29, x29
100fd8194:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8198:     	mov	x23, x0
100fd819c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
100fd81a0:     	ldr	x1, [x8, #0x930]
100fd81a4:     	mov	x2, x24
100fd81a8:     	mov	w3, #0x1                ; =1
100fd81ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd81b0:     	mov	x0, x23
100fd81b4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81b8:     	mov	x0, x24
100fd81bc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81c0:     	mov	x0, x22
100fd81c4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81c8:     	mov	x0, x21
100fd81cc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81d0:     	mov	x0, x20
100fd81d4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81d8:     	mov	x0, x19
100fd81dc:     	ldp	x29, x30, [sp, #0x30]
100fd81e0:     	ldp	x20, x19, [sp, #0x20]
100fd81e4:     	ldp	x22, x21, [sp, #0x10]
100fd81e8:     	ldp	x24, x23, [sp], #0x40
100fd81ec:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd81f0:     	stp	x28, x27, [sp, #-0x60]!
100fd81f4:     	stp	x26, x25, [sp, #0x10]
100fd81f8:     	stp	x24, x23, [sp, #0x20]
100fd81fc:     	stp	x22, x21, [sp, #0x30]
100fd8200:     	stp	x20, x19, [sp, #0x40]
100fd8204:     	stp	x29, x30, [sp, #0x50]
100fd8208:     	add	x29, sp, #0x50
100fd820c:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fd8210:     	mov	w9, #0x1                ; =1
100fd8214:     	strb	w9, [x8, #0x893]
100fd8218:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd821c:     	ldr	x0, [x27, #0x780]
100fd8220:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd8224:     	ldr	x20, [x8, #0x800]
100fd8228:     	mov	x1, x20
100fd822c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8230:     	mov	x29, x29
100fd8234:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8238:     	mov	x24, x0
100fd823c:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd8240:     	ldr	x0, [x28, #0x800]
100fd8244:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fd8248:     	ldr	x21, [x8, #0x508]
100fd824c:     	mov	x1, x21
100fd8250:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8254:     	mov	x2, x0
100fd8258:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd825c:     	ldr	x22, [x8, #0xa40]
100fd8260:     	mov	x0, x24
100fd8264:     	mov	x1, x22
100fd8268:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd826c:     	mov	x29, x29
100fd8270:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8274:     	mov	x25, x0
100fd8278:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd827c:     	ldr	x23, [x8, #0xa48]
100fd8280:     	adrp	x2, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
100fd8284:     	add	x2, x2, #0x5f8
100fd8288:     	mov	x1, x23
100fd828c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8290:     	mov	x29, x29
100fd8294:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8298:     	mov	x19, x0
100fd829c:     	mov	x0, x25
100fd82a0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd82a4:     	mov	x0, x24
100fd82a8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd82ac:     	ldr	x0, [x27, #0x780]
100fd82b0:     	mov	x1, x20
100fd82b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd82b8:     	mov	x29, x29
100fd82bc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd82c0:     	mov	x25, x0
100fd82c4:     	ldr	x0, [x28, #0x800]
100fd82c8:     	mov	x1, x21
100fd82cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd82d0:     	mov	x2, x0
100fd82d4:     	mov	x0, x25
100fd82d8:     	mov	x1, x22
100fd82dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd82e0:     	mov	x29, x29
100fd82e4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd82e8:     	mov	x26, x0
100fd82ec:     	adrp	x2, 0x11cfc0000 <dyld_stub_binder+0x11cfc0000>
100fd82f0:     	add	x2, x2, #0xb38
100fd82f4:     	mov	x1, x23
100fd82f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd82fc:     	mov	x29, x29
100fd8300:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8304:     	mov	x24, x0
100fd8308:     	mov	x0, x26
100fd830c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8310:     	mov	x0, x25
100fd8314:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8318:     	ldr	x0, [x27, #0x780]
100fd831c:     	mov	x1, x20
100fd8320:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8324:     	mov	x29, x29
100fd8328:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd832c:     	mov	x26, x0
100fd8330:     	ldr	x0, [x28, #0x800]
100fd8334:     	mov	x1, x21
100fd8338:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd833c:     	mov	x2, x0
100fd8340:     	mov	x0, x26
100fd8344:     	mov	x1, x22
100fd8348:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd834c:     	mov	x29, x29
100fd8350:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8354:     	mov	x27, x0
100fd8358:     	adrp	x2, 0x11d045000 <dyld_stub_binder+0x11d045000>
100fd835c:     	add	x2, x2, #0xbb8
100fd8360:     	mov	x1, x23
100fd8364:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8368:     	mov	x29, x29
100fd836c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8370:     	mov	x25, x0
100fd8374:     	mov	x0, x27
100fd8378:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd837c:     	mov	x0, x26
100fd8380:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8384:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd8388:     	ldr	x0, [x8, #0x780]
100fd838c:     	mov	x1, x20
100fd8390:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8394:     	mov	x29, x29
100fd8398:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd839c:     	mov	x20, x0
100fd83a0:     	ldr	x0, [x28, #0x800]
100fd83a4:     	mov	x1, x21
100fd83a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd83ac:     	mov	x2, x0
100fd83b0:     	mov	x0, x20
100fd83b4:     	mov	x1, x22
100fd83b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd83bc:     	mov	x29, x29
100fd83c0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd83c4:     	mov	x21, x0
100fd83c8:     	adrp	x2, 0x11d045000 <dyld_stub_binder+0x11d045000>
100fd83cc:     	add	x2, x2, #0xbd8
100fd83d0:     	mov	x1, x23
100fd83d4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd83d8:     	mov	x29, x29
100fd83dc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd83e0:     	mov	x22, x0
100fd83e4:     	mov	x0, x21
100fd83e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd83ec:     	mov	x0, x20
100fd83f0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd83f4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd83f8:     	ldr	x0, [x8, #0x8d8]
100fd83fc:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100fd8400:     	ldr	x1, [x8, #0x4a0]
100fd8404:     	mov	x2, x25
100fd8408:     	mov	x3, x22
100fd840c:     	mov	x4, x19
100fd8410:     	mov	x5, #0x0                ; =0
100fd8414:     	mov	x6, x24
100fd8418:     	mov	x7, #0x0                ; =0
100fd841c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8420:     	mov	x29, x29
100fd8424:     	bl	0x107c27cac <_Flutter_MMFoundation_BindContext+0x3eae978>
100fd8428:     	mov	x0, x22
100fd842c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8430:     	mov	x0, x25
100fd8434:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8438:     	mov	x0, x24
100fd843c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8440:     	mov	x0, x19
100fd8444:     	ldp	x29, x30, [sp, #0x50]
100fd8448:     	ldp	x20, x19, [sp, #0x40]
100fd844c:     	ldp	x22, x21, [sp, #0x30]
100fd8450:     	ldp	x24, x23, [sp, #0x20]
100fd8454:     	ldp	x26, x25, [sp, #0x10]
100fd8458:     	ldp	x28, x27, [sp], #0x60
100fd845c:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8460:     	stp	x28, x27, [sp, #-0x60]!
100fd8464:     	stp	x26, x25, [sp, #0x10]
100fd8468:     	stp	x24, x23, [sp, #0x20]
100fd846c:     	stp	x22, x21, [sp, #0x30]
100fd8470:     	stp	x20, x19, [sp, #0x40]
100fd8474:     	stp	x29, x30, [sp, #0x50]
100fd8478:     	add	x29, sp, #0x50
100fd847c:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
100fd8480:     	mov	w9, #0x1                ; =1
100fd8484:     	strb	w9, [x8, #0x894]
100fd8488:     	adrp	x26, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd848c:     	ldr	x0, [x26, #0x780]
100fd8490:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd8494:     	ldr	x20, [x8, #0x800]
100fd8498:     	mov	x1, x20
100fd849c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd84a0:     	mov	x29, x29
100fd84a4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd84a8:     	mov	x21, x0
100fd84ac:     	adrp	x27, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100fd84b0:     	ldr	x0, [x27, #0x800]
100fd84b4:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100fd84b8:     	ldr	x22, [x8, #0x508]
100fd84bc:     	mov	x1, x22
100fd84c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd84c4:     	mov	x2, x0
100fd84c8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd84cc:     	ldr	x23, [x8, #0xa40]
100fd84d0:     	mov	x0, x21
100fd84d4:     	mov	x1, x23
100fd84d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd84dc:     	mov	x29, x29
100fd84e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd84e4:     	mov	x24, x0
100fd84e8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100fd84ec:     	ldr	x25, [x8, #0xa48]
100fd84f0:     	adrp	x2, 0x11d045000 <dyld_stub_binder+0x11d045000>
100fd84f4:     	add	x2, x2, #0xbf8
100fd84f8:     	mov	x1, x25
100fd84fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8500:     	mov	x29, x29
100fd8504:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8508:     	mov	x19, x0
100fd850c:     	mov	x0, x24
100fd8510:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8514:     	mov	x0, x21
100fd8518:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd851c:     	ldr	x0, [x26, #0x780]
100fd8520:     	mov	x1, x20
100fd8524:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8528:     	mov	x29, x29
100fd852c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8530:     	mov	x20, x0
100fd8534:     	ldr	x0, [x27, #0x800]
100fd8538:     	mov	x1, x22
100fd853c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8540:     	mov	x2, x0
100fd8544:     	mov	x0, x20
100fd8548:     	mov	x1, x23
100fd854c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd8550:     	mov	x29, x29
100fd8554:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8558:     	mov	x21, x0
100fd855c:     	adrp	x2, 0x11d045000 <dyld_stub_binder+0x11d045000>
100fd8560:     	add	x2, x2, #0xbd8
100fd8564:     	mov	x1, x25
100fd8568:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100fd856c:     	mov	x29, x29
100fd8570:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100fd8574:     	mov	x22, x0
100fd8578:     	mov	x0, x21
100fd857c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8580:     	mov	x0, x20
100fd8584:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100fd8588:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
