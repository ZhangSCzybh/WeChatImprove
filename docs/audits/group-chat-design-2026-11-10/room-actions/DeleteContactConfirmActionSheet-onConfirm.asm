
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1012211e0:     	stp	x22, x21, [sp, #-0x30]!
1012211e4:     	stp	x20, x19, [sp, #0x10]
1012211e8:     	stp	x29, x30, [sp, #0x20]
1012211ec:     	add	x29, sp, #0x20
1012211f0:     	mov	x19, x0
1012211f4:     	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
1012211f8:     	ldr	x1, [x8, #0x448]
1012211fc:     	mov	w2, #0x1                ; =1
101221200:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101221204:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
101221208:     	ldr	x20, [x8, #0x650]
10122120c:     	mov	x0, x19
101221210:     	mov	x1, x20
101221214:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101221218:     	mov	x29, x29
10122121c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101221220:     	mov	x21, x0
101221224:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101221228:     	cbz	x21, 0x10122128c <__text+0x121928c>
10122122c:     	adrp	x8, 0x11ea22000 <dyld_stub_binder+0x11ea22000>
101221230:     	ldr	x1, [x8, #0x638]
101221234:     	mov	x0, x19
101221238:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10122123c:     	mov	x29, x29
101221240:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101221244:     	mov	x21, x0
101221248:     	adrp	x8, 0x11e9d7000 <dyld_stub_binder+0x11e9d7000>
10122124c:     	ldr	x1, [x8, #0xe18]
101221250:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101221254:     	mov	x22, x0
101221258:     	mov	x0, x21
10122125c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101221260:     	mov	x0, x19
101221264:     	mov	x1, x20
101221268:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10122126c:     	mov	x29, x29
101221270:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101221274:     	mov	x20, x0
101221278:     	ldr	x8, [x0, #0x10]
10122127c:     	mov	x1, x22
101221280:     	blr	x8
101221284:     	mov	x0, x20
101221288:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10122128c:     	adrp	x8, 0x11ea13000 <dyld_stub_binder+0x11ea13000>
101221290:     	ldr	x1, [x8, #0x4d0]
101221294:     	mov	x0, x19
101221298:     	mov	x2, #0x0                ; =0
10122129c:     	ldp	x29, x30, [sp, #0x20]
1012212a0:     	ldp	x20, x19, [sp, #0x10]
1012212a4:     	ldp	x22, x21, [sp], #0x30
1012212a8:     	b	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
