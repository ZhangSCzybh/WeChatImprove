
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101220148:     	stp	x22, x21, [sp, #-0x30]!
10122014c:     	stp	x20, x19, [sp, #0x10]
101220150:     	stp	x29, x30, [sp, #0x20]
101220154:     	add	x29, sp, #0x20
101220158:     	mov	x19, x0
10122015c:     	adrp	x8, 0x11f744000 <dyld_stub_binder+0x11f744000>
101220160:     	mov	w9, #0x1                ; =1
101220164:     	strb	w9, [x8, #0x163]
101220168:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
10122016c:     	ldr	x20, [x8, #0x6a0]
101220170:     	mov	x1, x20
101220174:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101220178:     	mov	x29, x29
10122017c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220180:     	mov	x21, x0
101220184:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220188:     	cbz	x21, 0x1012201a8 <__text+0x12181a8>
10122018c:     	mov	x0, x19
101220190:     	mov	x1, x20
101220194:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101220198:     	mov	x29, x29
10122019c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1012201a0:     	mov	x21, x0
1012201a4:     	b	0x101220274 <__text+0x1218274>
1012201a8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1012201ac:     	ldr	x1, [x8, #0xa30]
1012201b0:     	mov	x0, x19
1012201b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1012201b8:     	mov	x29, x29
1012201bc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1012201c0:     	mov	x19, x0
1012201c4:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1012201c8:     	ldr	x1, [x8, #0xfa8]
1012201cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1012201d0:     	mov	x21, x0
1012201d4:     	mov	x0, x19
1012201d8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1012201dc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1012201e0:     	ldr	x0, [x8, #0x780]
1012201e4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1012201e8:     	ldr	x1, [x8, #0x800]
1012201ec:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1012201f0:     	mov	x29, x29
1012201f4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1012201f8:     	mov	x19, x0
1012201fc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101220200:     	ldr	x0, [x8, #0x800]
101220204:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101220208:     	ldr	x1, [x8, #0x508]
10122020c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101220210:     	mov	x2, x0
101220214:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101220218:     	ldr	x1, [x8, #0xa40]
10122021c:     	mov	x0, x19
101220220:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101220224:     	mov	x29, x29
101220228:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10122022c:     	mov	x20, x0
101220230:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101220234:     	ldr	x1, [x8, #0xa48]
101220238:     	cbz	w21, 0x101220248 <__text+0x1218248>
10122023c:     	adrp	x2, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
101220240:     	add	x2, x2, #0x378
101220244:     	b	0x101220250 <__text+0x1218250>
101220248:     	adrp	x2, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
10122024c:     	add	x2, x2, #0x398
101220250:     	mov	x0, x20
101220254:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101220258:     	mov	x29, x29
10122025c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220260:     	mov	x21, x0
101220264:     	mov	x0, x20
101220268:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10122026c:     	mov	x0, x19
101220270:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220274:     	mov	x0, x21
101220278:     	ldp	x29, x30, [sp, #0x20]
10122027c:     	ldp	x20, x19, [sp, #0x10]
101220280:     	ldp	x22, x21, [sp], #0x30
101220284:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
