
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100391130:     	sub	sp, sp, #0x70
100391134:     	stp	x26, x25, [sp, #0x20]
100391138:     	stp	x24, x23, [sp, #0x30]
10039113c:     	stp	x22, x21, [sp, #0x40]
100391140:     	stp	x20, x19, [sp, #0x50]
100391144:     	stp	x29, x30, [sp, #0x60]
100391148:     	add	x29, sp, #0x60
10039114c:     	mov	x19, x0
100391150:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100391154:     	mov	w9, #0x1                ; =1
100391158:     	strb	w9, [x8, #0xc0b]
10039115c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100391160:     	ldr	x20, [x8, #0x400]
100391164:     	mov	x1, x20
100391168:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039116c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100391170:     	ldr	x22, [x8, #0x618]
100391174:     	tbz	w0, #0x0, 0x1003913d4 <__text+0x3893d4>
100391178:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039117c:     	ldr	x21, [x8, #0x450]
100391180:     	mov	x0, x19
100391184:     	mov	x1, x21
100391188:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039118c:     	mov	x29, x29
100391190:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100391194:     	mov	x23, x0
100391198:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039119c:     	ldr	x20, [x8, #0x458]
1003911a0:     	mov	x0, x19
1003911a4:     	mov	x1, x20
1003911a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003911ac:     	mov	x29, x29
1003911b0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003911b4:     	mov	x24, x0
1003911b8:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1003911bc:     	ldr	x1, [x8, #0xba0]
1003911c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003911c4:     	mov	x29, x29
1003911c8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003911cc:     	mov	x25, x0
1003911d0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1003911d4:     	ldr	x1, [x8, #0x310]
1003911d8:     	stp	x23, x0, [sp, #0x8]
1003911dc:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
1003911e0:     	add	x8, x8, #0xff8
1003911e4:     	str	x8, [sp]
1003911e8:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
1003911ec:     	add	x3, x3, #0xff4
1003911f0:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
1003911f4:     	add	x5, x5, #0xb
1003911f8:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
1003911fc:     	add	x7, x7, #0x7eb
100391200:     	mov	x0, x22
100391204:     	mov	w2, #0x2                ; =2
100391208:     	mov	w4, #0x0                ; =0
10039120c:     	mov	w6, #0x200              ; =512
100391210:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391214:     	mov	x0, x25
100391218:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039121c:     	mov	x0, x24
100391220:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100391224:     	mov	x0, x23
100391228:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039122c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100391230:     	ldr	x1, [x8, #0x408]
100391234:     	mov	x0, x19
100391238:     	mov	w2, #0x0                ; =0
10039123c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391240:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100391244:     	ldr	x1, [x8, #0x420]
100391248:     	mov	x0, x19
10039124c:     	mov	x2, #0x0                ; =0
100391250:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391254:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100391258:     	ldr	x1, [x8, #0x418]
10039125c:     	mov	x0, x19
100391260:     	mov	x2, #0x0                ; =0
100391264:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391268:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039126c:     	ldr	x1, [x8, #0x428]
100391270:     	mov	x0, x19
100391274:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391278:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039127c:     	ldr	x1, [x8, #0x430]
100391280:     	add	x2, x0, #0x1
100391284:     	mov	x0, x19
100391288:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039128c:     	adrp	x8, 0x11d74e000 <dyld_stub_binder+0x11d74e000>
100391290:     	ldr	x8, [x8, #0xa10]
100391294:     	ldr	x2, [x8]
100391298:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039129c:     	ldr	x1, [x8, #0x470]
1003912a0:     	mov	x0, x19
1003912a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003912a8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
1003912ac:     	ldr	x1, [x8, #0x4b8]
1003912b0:     	mov	x0, x19
1003912b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003912b8:     	mov	x0, x19
1003912bc:     	mov	x1, x21
1003912c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003912c4:     	mov	x29, x29
1003912c8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003912cc:     	mov	x22, x0
1003912d0:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1003912d4:     	ldr	x23, [x8, #0x818]
1003912d8:     	mov	x1, x23
1003912dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003912e0:     	mov	x21, x0
1003912e4:     	mov	x0, x22
1003912e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003912ec:     	mov	x0, x19
1003912f0:     	mov	x1, x20
1003912f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003912f8:     	mov	x29, x29
1003912fc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100391300:     	mov	x20, x0
100391304:     	mov	x1, x23
100391308:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039130c:     	mov	x22, x0
100391310:     	mov	x0, x20
100391314:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100391318:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039131c:     	ldr	x1, [x8, #0x568]
100391320:     	mov	x0, x19
100391324:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391328:     	mov	x29, x29
10039132c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100391330:     	mov	x20, x0
100391334:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100391338:     	ldr	x1, [x8, #0x570]
10039133c:     	mov	x0, x19
100391340:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391344:     	mov	x23, x0
100391348:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10039134c:     	ldr	x1, [x8, #0xd38]
100391350:     	mov	x0, x19
100391354:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391358:     	mov	x29, x29
10039135c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100391360:     	mov	x24, x0
100391364:     	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
100391368:     	ldr	x1, [x8, #0x618]
10039136c:     	mov	x0, x19
100391370:     	mov	x2, #0x0                ; =0
100391374:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391378:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039137c:     	ldr	x1, [x8, #0x578]
100391380:     	mov	x0, x24
100391384:     	mov	x2, x19
100391388:     	mov	x3, x21
10039138c:     	mov	x4, x22
100391390:     	mov	x5, x20
100391394:     	mov	x6, x23
100391398:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039139c:     	mov	x0, x24
1003913a0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003913a4:     	mov	x0, x20
1003913a8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003913ac:     	mov	x0, x22
1003913b0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003913b4:     	mov	x0, x21
1003913b8:     	ldp	x29, x30, [sp, #0x60]
1003913bc:     	ldp	x20, x19, [sp, #0x50]
1003913c0:     	ldp	x22, x21, [sp, #0x40]
1003913c4:     	ldp	x24, x23, [sp, #0x30]
1003913c8:     	ldp	x26, x25, [sp, #0x20]
1003913cc:     	add	sp, sp, #0x70
1003913d0:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003913d4:     	mov	x0, x19
1003913d8:     	mov	x1, x20
1003913dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003913e0:     	mov	x20, x0
1003913e4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
1003913e8:     	ldr	x1, [x8, #0x4a0]
1003913ec:     	mov	x0, x19
1003913f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003913f4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1003913f8:     	ldr	x1, [x8, #0x310]
1003913fc:     	stp	x20, x0, [sp, #0x8]
100391400:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
100391404:     	add	x8, x8, #0xfd8
100391408:     	str	x8, [sp]
10039140c:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
100391410:     	add	x3, x3, #0xff4
100391414:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100391418:     	add	x5, x5, #0xb
10039141c:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100391420:     	add	x7, x7, #0x7eb
100391424:     	mov	x0, x22
100391428:     	mov	w2, #0x3                ; =3
10039142c:     	mov	w4, #0x0                ; =0
100391430:     	mov	w6, #0x1fd              ; =509
100391434:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391438:     	ldp	x29, x30, [sp, #0x60]
10039143c:     	ldp	x20, x19, [sp, #0x50]
100391440:     	ldp	x22, x21, [sp, #0x40]
100391444:     	ldp	x24, x23, [sp, #0x30]
100391448:     	ldp	x26, x25, [sp, #0x20]
10039144c:     	add	sp, sp, #0x70
100391450:     	ret
