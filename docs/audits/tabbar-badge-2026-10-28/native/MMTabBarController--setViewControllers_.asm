
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1047244d8: d10143ff    	sub	sp, sp, #0x50
1047244dc: a90257f6    	stp	x22, x21, [sp, #0x20]
1047244e0: a9034ff4    	stp	x20, x19, [sp, #0x30]
1047244e4: a9047bfd    	stp	x29, x30, [sp, #0x40]
1047244e8: 910103fd    	add	x29, sp, #0x40
1047244ec: aa0203f3    	mov	x19, x2
1047244f0: aa0003f4    	mov	x20, x0
1047244f4: 900dd508    	adrp	x8, 0x1201c4000 <dyld_stub_binder+0x1201c4000>
1047244f8: f9460908    	ldr	x8, [x8, #0xc10]
1047244fc: a90123e0    	stp	x0, x8, [sp, #0x10]
104724500: 900dba68    	adrp	x8, 0x11fe70000 <dyld_stub_binder+0x11fe70000>
104724504: f9410115    	ldr	x21, [x8, #0x200] ; selector setViewControllers:
104724508: aa0203e0    	mov	x0, x2
10472450c: 94d40b0b    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104724510: 910043e0    	add	x0, sp, #0x10
104724514: aa1503e1    	mov	x1, x21
104724518: aa1303e2    	mov	x2, x19
10472451c: 94d40b0a    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104724520: f00dd268    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104724524: f9453500    	ldr	x0, [x8, #0xa68] ; class iConsole
104724528: b00db8a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10472452c: f942a901    	ldr	x1, [x8, #0x550] ; selector logWithLevel:module:errorCode:file:line:func:format:
104724530: f00d0228    	adrp	x8, 0x11e76b000 <dyld_stub_binder+0x11e76b000>
104724534: 91072108    	add	x8, x8, #0x1c8 ; CFString 'quick launch: setViewControllers'
104724538: f90003e8    	str	x8, [sp]
10472453c: d00b5823    	adrp	x3, 0x11b22a000 <dyld_stub_binder+0x11b22a000>
104724540: 9114a863    	add	x3, x3, #0x52a ; string 'TabBar'
104724544: 900b83a5    	adrp	x5, 0x11b798000 <dyld_stub_binder+0x11b798000>
104724548: 912d64a5    	add	x5, x5, #0xb59 ; string 'MMTabBarController.mm'
10472454c: 900b83a7    	adrp	x7, 0x11b798000 <dyld_stub_binder+0x11b798000>
104724550: 91310ce7    	add	x7, x7, #0xc43 ; string '-[MMTabBarController setViewControllers:]'
104724554: 52800042    	mov	w2, #0x2                ; =2
104724558: 52800004    	mov	w4, #0x0                ; =0
10472455c: 528014c6    	mov	w6, #0xa6               ; =166
104724560: 94d40af7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724564: 900dcee8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104724568: f9435101    	ldr	x1, [x8, #0x6a0] ; selector count
10472456c: aa1303e0    	mov	x0, x19
104724570: 94d40af3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104724574: aa0003f5    	mov	x21, x0
104724578: aa1303e0    	mov	x0, x19
10472457c: 94d40af6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104724580: f00dd7c8    	adrp	x8, 0x12021f000 <dyld_stub_binder+0x12021f000>
104724584: b989ed08    	ldrsw	x8, [x8, #0x9ec]
104724588: f8286a95    	str	x21, [x20, x8]
10472458c: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104724590: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104724594: a94257f6    	ldp	x22, x21, [sp, #0x20]
104724598: 910143ff    	add	sp, sp, #0x50
10472459c: d65f03c0    	ret
