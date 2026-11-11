
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101071164:     	stp	x24, x23, [sp, #-0x40]!
101071168:     	stp	x22, x21, [sp, #0x10]
10107116c:     	stp	x20, x19, [sp, #0x20]
101071170:     	stp	x29, x30, [sp, #0x30]
101071174:     	add	x29, sp, #0x30
101071178:     	mov	x19, x2
10107117c:     	mov	x21, x0
101071180:     	adrp	x8, 0x11f743000 <dyld_stub_binder+0x11f743000>
101071184:     	mov	w9, #0x1                ; =1
101071188:     	strb	w9, [x8, #0xac2]
10107118c:     	mov	x0, x2
101071190:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101071194:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101071198:     	ldr	x22, [x8, #0x9b8]
10107119c:     	mov	x0, x21
1010711a0:     	mov	x1, x22
1010711a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010711a8:     	mov	x29, x29
1010711ac:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010711b0:     	mov	x20, x0
1010711b4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010711b8:     	cbz	x20, 0x101071290 <__text+0x1069290>
1010711bc:     	adrp	x8, 0x11ea05000 <dyld_stub_binder+0x11ea05000>
1010711c0:     	ldr	x1, [x8, #0xca8]
1010711c4:     	mov	x0, x19
1010711c8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010711cc:     	mov	x29, x29
1010711d0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010711d4:     	mov	x20, x0
1010711d8:     	adrp	x24, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1010711dc:     	cbz	x0, 0x101071200 <__text+0x1069200>
1010711e0:     	ldr	x1, [x24, #0xce8]
1010711e4:     	mov	x0, x20
1010711e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010711ec:     	cbz	x0, 0x101071200 <__text+0x1069200>
1010711f0:     	mov	x0, x20
1010711f4:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
1010711f8:     	mov	x21, x20
1010711fc:     	b	0x1010712cc <__text+0x10692cc>
101071200:     	mov	x0, x21
101071204:     	mov	x1, x22
101071208:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10107120c:     	mov	x29, x29
101071210:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101071214:     	mov	x22, x0
101071218:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10107121c:     	ldr	x1, [x8, #0x620]
101071220:     	mov	x0, x19
101071224:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101071228:     	mov	x29, x29
10107122c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101071230:     	mov	x23, x0
101071234:     	adrp	x8, 0x11ea17000 <dyld_stub_binder+0x11ea17000>
101071238:     	ldr	x1, [x8, #0x790]
10107123c:     	mov	x0, x22
101071240:     	mov	x2, x23
101071244:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101071248:     	mov	x29, x29
10107124c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101071250:     	mov	x21, x0
101071254:     	mov	x0, x20
101071258:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10107125c:     	mov	x0, x23
101071260:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101071264:     	mov	x0, x22
101071268:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10107126c:     	cbz	x21, 0x1010712b0 <__text+0x10692b0>
101071270:     	ldr	x1, [x24, #0xce8]
101071274:     	mov	x0, x21
101071278:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10107127c:     	cbz	x0, 0x1010712b0 <__text+0x10692b0>
101071280:     	mov	x0, x21
101071284:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101071288:     	mov	x20, x21
10107128c:     	b	0x1010712cc <__text+0x10692cc>
101071290:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101071294:     	ldr	x1, [x8, #0x990]
101071298:     	mov	x0, x19
10107129c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010712a0:     	mov	x29, x29
1010712a4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010712a8:     	mov	x20, x0
1010712ac:     	b	0x1010712d4 <__text+0x10692d4>
1010712b0:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1010712b4:     	ldr	x1, [x8, #0x990]
1010712b8:     	mov	x0, x19
1010712bc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1010712c0:     	mov	x29, x29
1010712c4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1010712c8:     	mov	x20, x0
1010712cc:     	mov	x0, x21
1010712d0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010712d4:     	mov	x0, x19
1010712d8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1010712dc:     	mov	x0, x20
1010712e0:     	ldp	x29, x30, [sp, #0x30]
1010712e4:     	ldp	x20, x19, [sp, #0x20]
1010712e8:     	ldp	x22, x21, [sp, #0x10]
1010712ec:     	ldp	x24, x23, [sp], #0x40
1010712f0:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
