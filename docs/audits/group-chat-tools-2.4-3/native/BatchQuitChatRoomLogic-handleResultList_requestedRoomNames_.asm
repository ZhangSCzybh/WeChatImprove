
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100390020:     	stp	x28, x27, [sp, #-0x60]!
100390024:     	stp	x26, x25, [sp, #0x10]
100390028:     	stp	x24, x23, [sp, #0x20]
10039002c:     	stp	x22, x21, [sp, #0x30]
100390030:     	stp	x20, x19, [sp, #0x40]
100390034:     	stp	x29, x30, [sp, #0x50]
100390038:     	add	x29, sp, #0x50
10039003c:     	sub	sp, sp, #0x230
100390040:     	mov	x20, x3
100390044:     	mov	x19, x2
100390048:     	str	x0, [sp, #0x68]
10039004c:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
100390050:     	ldr	x8, [x8, #0xa30]
100390054:     	ldr	x8, [x8]
100390058:     	stur	x8, [x29, #-0x60]
10039005c:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100390060:     	mov	w9, #0x1                ; =1
100390064:     	strb	w9, [x8, #0xc06]
100390068:     	mov	x0, x2
10039006c:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390070:     	mov	x0, x20
100390074:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390078:     	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
10039007c:     	ldr	x0, [x8, #0x260]
100390080:     	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
100390084:     	ldr	x1, [x8, #0xeb0]
100390088:     	str	x20, [sp, #0x48]
10039008c:     	mov	x2, x20
100390090:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390094:     	mov	x29, x29
100390098:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10039009c:     	str	x0, [sp, #0x90]
1003900a0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1003900a4:     	ldr	x0, [x8, #0x630]
1003900a8:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1003900ac:     	ldr	x1, [x8, #0xf70]
1003900b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003900b4:     	mov	x29, x29
1003900b8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003900bc:     	str	x0, [sp, #0x98]
1003900c0:     	movi.16b	v0, #0x0
1003900c4:     	stp	q0, q0, [sp, #0xe0]
1003900c8:     	stp	q0, q0, [sp, #0x100]
1003900cc:     	mov	x0, x19
1003900d0:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1003900d4:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1003900d8:     	ldr	x1, [x8, #0x858]
1003900dc:     	add	x2, sp, #0xe0
1003900e0:     	sub	x3, x29, #0xe0
1003900e4:     	str	x19, [sp, #0x50]
1003900e8:     	str	x1, [sp, #0x30]
1003900ec:     	mov	w4, #0x10               ; =16
1003900f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003900f4:     	str	x0, [sp, #0x88]
1003900f8:     	cbz	x0, 0x100390328 <__text+0x388328>
1003900fc:     	ldr	x8, [sp, #0xf0]
100390100:     	ldr	x8, [x8]
100390104:     	str	x8, [sp, #0x60]
100390108:     	mov	x21, #0x0               ; =0
10039010c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390110:     	ldr	x9, [x8, #0x528]
100390114:     	adrp	x8, 0x11e9d5000 <dyld_stub_binder+0x11e9d5000>
100390118:     	ldr	x8, [x8, #0xc40]
10039011c:     	stp	x8, x9, [sp, #0x78]
100390120:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
100390124:     	ldr	x8, [x8, #0xce8]
100390128:     	str	x8, [sp, #0x70]
10039012c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100390130:     	ldr	x26, [x8, #0x738]
100390134:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100390138:     	ldr	x27, [x8, #0x650]
10039013c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390140:     	ldr	x24, [x8, #0x530]
100390144:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100390148:     	ldr	x8, [x8, #0x310]
10039014c:     	str	x8, [sp, #0x58]
100390150:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100390154:     	ldr	x9, [x8, #0x5a8]
100390158:     	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
10039015c:     	ldr	x8, [x8, #0x298]
100390160:     	stp	x8, x9, [sp, #0x38]
100390164:     	ldr	x8, [sp, #0xf0]
100390168:     	ldr	x8, [x8]
10039016c:     	ldr	x9, [sp, #0x60]
100390170:     	cmp	x8, x9
100390174:     	b.eq	0x100390180 <__text+0x388180>
100390178:     	ldr	x0, [sp, #0x50]
10039017c:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
100390180:     	ldr	x8, [sp, #0xe8]
100390184:     	ldr	x23, [x8, x21, lsl #3]
100390188:     	mov	x0, x23
10039018c:     	ldr	x1, [sp, #0x80]
100390190:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390194:     	mov	x29, x29
100390198:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10039019c:     	mov	x22, x0
1003901a0:     	mov	x0, x23
1003901a4:     	ldr	x1, [sp, #0x78]
1003901a8:     	mov	w2, #0x1                ; =1
1003901ac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003901b0:     	mov	x28, x0
1003901b4:     	mov	x0, x22
1003901b8:     	ldr	x1, [sp, #0x70]
1003901bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003901c0:     	cmp	w28, #0x0
1003901c4:     	ccmp	x0, #0x0, #0x4, ne
1003901c8:     	b.eq	0x100390204 <__text+0x388204>
1003901cc:     	ldr	x0, [sp, #0x90]
1003901d0:     	mov	x1, x26
1003901d4:     	mov	x2, x22
1003901d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003901dc:     	cbz	w0, 0x100390204 <__text+0x388204>
1003901e0:     	ldr	x0, [sp, #0x98]
1003901e4:     	mov	x1, x27
1003901e8:     	mov	x2, x22
1003901ec:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003901f0:     	mov	x29, x29
1003901f4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003901f8:     	mov	x25, x0
1003901fc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390200:     	cbz	x25, 0x1003902bc <__text+0x3882bc>
100390204:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390208:     	ldr	x25, [x8, #0x618]
10039020c:     	mov	x0, x23
100390210:     	mov	x1, x24
100390214:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390218:     	mov	x19, x0
10039021c:     	ldr	x0, [sp, #0x90]
100390220:     	mov	x1, x26
100390224:     	mov	x2, x22
100390228:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039022c:     	mov	x20, x0
100390230:     	ldr	x0, [sp, #0x98]
100390234:     	mov	x1, x27
100390238:     	mov	x2, x22
10039023c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390240:     	mov	x29, x29
100390244:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390248:     	mov	x23, x0
10039024c:     	cmp	x0, #0x0
100390250:     	cset	w8, ne
100390254:     	stp	x19, x28, [sp, #0x10]
100390258:     	adrp	x9, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10039025c:     	add	x9, x9, #0xf38
100390260:     	stp	x9, x22, [sp]
100390264:     	stp	x20, x8, [sp, #0x20]
100390268:     	mov	x0, x25
10039026c:     	ldr	x1, [sp, #0x58]
100390270:     	mov	w2, #0x3                ; =3
100390274:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
100390278:     	add	x3, x3, #0xff4
10039027c:     	mov	w4, #0x0                ; =0
100390280:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390284:     	add	x5, x5, #0xb
100390288:     	mov	w6, #0x180              ; =384
10039028c:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390290:     	add	x7, x7, #0x57a
100390294:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390298:     	mov	x0, x23
10039029c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003902a0:     	mov	x0, x22
1003902a4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003902a8:     	add	x21, x21, #0x1
1003902ac:     	ldr	x8, [sp, #0x88]
1003902b0:     	cmp	x8, x21
1003902b4:     	b.ne	0x100390164 <__text+0x388164>
1003902b8:     	b	0x100390304 <__text+0x388304>
1003902bc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1003902c0:     	ldr	x19, [x8, #0x6c0]
1003902c4:     	mov	x0, x23
1003902c8:     	mov	x1, x24
1003902cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003902d0:     	mov	x2, x0
1003902d4:     	mov	x0, x19
1003902d8:     	ldr	x1, [sp, #0x40]
1003902dc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003902e0:     	mov	x29, x29
1003902e4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003902e8:     	mov	x23, x0
1003902ec:     	ldr	x0, [sp, #0x98]
1003902f0:     	ldr	x1, [sp, #0x38]
1003902f4:     	mov	x2, x23
1003902f8:     	mov	x3, x22
1003902fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390300:     	b	0x100390298 <__text+0x388298>
100390304:     	add	x2, sp, #0xe0
100390308:     	sub	x3, x29, #0xe0
10039030c:     	ldr	x0, [sp, #0x50]
100390310:     	ldr	x1, [sp, #0x30]
100390314:     	mov	w4, #0x10               ; =16
100390318:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039031c:     	str	x0, [sp, #0x88]
100390320:     	cbnz	x0, 0x100390108 <__text+0x388108>
100390324:     	b	0x100390334 <__text+0x388334>
100390328:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10039032c:     	ldr	x8, [x8, #0x310]
100390330:     	str	x8, [sp, #0x58]
100390334:     	ldr	x0, [sp, #0x50]
100390338:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039033c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390340:     	ldr	x0, [x8, #0x618]
100390344:     	ldr	x9, [sp, #0x98]
100390348:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10039034c:     	add	x8, x8, #0xf58
100390350:     	ldr	x19, [sp, #0x48]
100390354:     	stp	x19, x9, [sp, #0x8]
100390358:     	str	x8, [sp]
10039035c:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
100390360:     	add	x3, x3, #0xff4
100390364:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390368:     	add	x5, x5, #0xb
10039036c:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390370:     	add	x7, x7, #0x57a
100390374:     	ldr	x1, [sp, #0x58]
100390378:     	mov	w2, #0x2                ; =2
10039037c:     	mov	w4, #0x0                ; =0
100390380:     	mov	w6, #0x185              ; =389
100390384:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390388:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10039038c:     	ldr	x0, [x8, #0x658]
100390390:     	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
100390394:     	ldr	x1, [x8, #0xd88]
100390398:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10039039c:     	mov	x29, x29
1003903a0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003903a4:     	mov	x21, x0
1003903a8:     	movi.16b	v0, #0x0
1003903ac:     	stp	q0, q0, [sp, #0xa0]
1003903b0:     	stp	q0, q0, [sp, #0xc0]
1003903b4:     	mov	x0, x19
1003903b8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1003903bc:     	add	x2, sp, #0xa0
1003903c0:     	add	x3, sp, #0x120
1003903c4:     	ldr	x1, [sp, #0x30]
1003903c8:     	mov	w4, #0x10               ; =16
1003903cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003903d0:     	cbz	x0, 0x10039054c <__text+0x38854c>
1003903d4:     	mov	x19, x0
1003903d8:     	mov	w24, #0x0               ; =0
1003903dc:     	ldr	x8, [sp, #0xb0]
1003903e0:     	ldr	x26, [x8]
1003903e4:     	str	x26, [sp, #0x60]
1003903e8:     	mov	x25, #0x0               ; =0
1003903ec:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1003903f0:     	ldr	x20, [x8, #0x650]
1003903f4:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1003903f8:     	ldr	x27, [x8, #0x618]
1003903fc:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390400:     	ldr	x9, [x8, #0x478]
100390404:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390408:     	ldr	x8, [x8, #0x480]
10039040c:     	stp	x8, x9, [sp, #0x70]
100390410:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390414:     	ldr	x9, [x8, #0x538]
100390418:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10039041c:     	ldr	x8, [x8, #0x518]
100390420:     	stp	x9, x8, [sp, #0x80]
100390424:     	ldr	x8, [sp, #0xb0]
100390428:     	ldr	x8, [x8]
10039042c:     	cmp	x8, x26
100390430:     	b.eq	0x10039043c <__text+0x38843c>
100390434:     	ldr	x0, [sp, #0x48]
100390438:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10039043c:     	ldr	x8, [sp, #0xa8]
100390440:     	ldr	x22, [x8, x25, lsl #3]
100390444:     	ldr	x0, [sp, #0x98]
100390448:     	mov	x1, x20
10039044c:     	mov	x2, x22
100390450:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390454:     	mov	x29, x29
100390458:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10039045c:     	mov	x28, x0
100390460:     	cbz	x0, 0x1003904e0 <__text+0x3884e0>
100390464:     	mov	x0, x28
100390468:     	mov	x1, x27
10039046c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390470:     	cbz	w0, 0x100390504 <__text+0x388504>
100390474:     	cmn	w0, #0xf0
100390478:     	cset	w23, eq
10039047c:     	cmn	w0, #0xdb4
100390480:     	ccmn	w0, #0x1, #0x4, ne
100390484:     	b.eq	0x1003904e4 <__text+0x3884e4>
100390488:     	cmn	w0, #0xf0
10039048c:     	b.eq	0x1003904e4 <__text+0x3884e4>
100390490:     	mov	x26, x27
100390494:     	mov	x27, x21
100390498:     	ldr	x21, [sp, #0x68]
10039049c:     	mov	x0, x21
1003904a0:     	ldr	x1, [sp, #0x78]
1003904a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003904a8:     	mov	x29, x29
1003904ac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003904b0:     	mov	x23, x0
1003904b4:     	mov	x0, x21
1003904b8:     	mov	x21, x27
1003904bc:     	mov	x27, x26
1003904c0:     	ldr	x26, [sp, #0x60]
1003904c4:     	ldr	x1, [sp, #0x70]
1003904c8:     	mov	x2, x22
1003904cc:     	mov	x3, x23
1003904d0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003904d4:     	mov	x0, x23
1003904d8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003904dc:     	b	0x100390514 <__text+0x388514>
1003904e0:     	mov	w23, #0x0               ; =0
1003904e4:     	ldr	x0, [sp, #0x68]
1003904e8:     	ldr	x1, [sp, #0x88]
1003904ec:     	mov	x2, x22
1003904f0:     	mov	x3, x21
1003904f4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003904f8:     	and	w8, w23, w0
1003904fc:     	orr	w24, w8, w24
100390500:     	b	0x100390514 <__text+0x388514>
100390504:     	ldr	x0, [sp, #0x68]
100390508:     	ldr	x1, [sp, #0x80]
10039050c:     	mov	x2, x22
100390510:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390514:     	mov	x0, x28
100390518:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039051c:     	add	x25, x25, #0x1
100390520:     	cmp	x19, x25
100390524:     	b.ne	0x100390424 <__text+0x388424>
100390528:     	add	x2, sp, #0xa0
10039052c:     	add	x3, sp, #0x120
100390530:     	ldr	x0, [sp, #0x48]
100390534:     	ldr	x1, [sp, #0x30]
100390538:     	mov	w4, #0x10               ; =16
10039053c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390540:     	mov	x19, x0
100390544:     	cbnz	x0, 0x1003903e8 <__text+0x3883e8>
100390548:     	b	0x100390550 <__text+0x388550>
10039054c:     	mov	w24, #0x0               ; =0
100390550:     	ldr	x19, [sp, #0x48]
100390554:     	mov	x0, x19
100390558:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039055c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390560:     	ldr	x1, [x8, #0x520]
100390564:     	and	w3, w24, #0x1
100390568:     	ldr	x0, [sp, #0x68]
10039056c:     	mov	x2, x21
100390570:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390574:     	mov	x0, x21
100390578:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039057c:     	ldr	x0, [sp, #0x98]
100390580:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390584:     	ldr	x0, [sp, #0x90]
100390588:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039058c:     	mov	x0, x19
100390590:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390594:     	ldr	x0, [sp, #0x50]
100390598:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039059c:     	ldur	x8, [x29, #-0x60]
1003905a0:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1003905a4:     	ldr	x9, [x9, #0xa30]
1003905a8:     	ldr	x9, [x9]
1003905ac:     	cmp	x9, x8
1003905b0:     	b.ne	0x1003905d4 <__text+0x3885d4>
1003905b4:     	add	sp, sp, #0x230
1003905b8:     	ldp	x29, x30, [sp, #0x50]
1003905bc:     	ldp	x20, x19, [sp, #0x40]
1003905c0:     	ldp	x22, x21, [sp, #0x30]
1003905c4:     	ldp	x24, x23, [sp, #0x20]
1003905c8:     	ldp	x26, x25, [sp, #0x10]
1003905cc:     	ldp	x28, x27, [sp], #0x60
1003905d0:     	ret
1003905d4:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
