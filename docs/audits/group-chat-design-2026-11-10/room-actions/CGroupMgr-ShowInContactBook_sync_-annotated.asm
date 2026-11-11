
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
10203a6e8:     	sub	sp, sp, #0x40
10203a6ec:     	stp	x22, x21, [sp, #0x10]
10203a6f0:     	stp	x20, x19, [sp, #0x20]
10203a6f4:     	stp	x29, x30, [sp, #0x30]
10203a6f8:     	add	x29, sp, #0x30
10203a6fc:     	mov	x19, x2
10203a700:     	mov	x0, x2
10203a704:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10203a708:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a70c:     	ldr	x0, [x8, #0x780]
10203a710:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a714:     	ldr	x1, [x8, #0x800] ; selector: currentContext
10203a718:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a71c:     	mov	x29, x29
10203a720:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a724:     	mov	x21, x0
10203a728:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a72c:     	ldr	x0, [x8, #0xbe8]
10203a730:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10203a734:     	ldr	x1, [x8, #0x508] ; selector: class
10203a738:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a73c:     	mov	x2, x0
10203a740:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a744:     	ldr	x1, [x8, #0xa40] ; selector: getService:
10203a748:     	mov	x0, x21
10203a74c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a750:     	mov	x29, x29
10203a754:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a758:     	mov	x20, x0
10203a75c:     	mov	x0, x21
10203a760:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a764:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10203a768:     	ldr	x1, [x8, #0x150] ; selector: getContactByName:
10203a76c:     	mov	x0, x20
10203a770:     	mov	x2, x19
10203a774:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a778:     	mov	x29, x29
10203a77c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203a780:     	mov	x21, x0
10203a784:     	cbz	x0, 0x10203a7b0 <_Flutter_Image_provideRelativePathByUrl+0x2c2c3c>
10203a788:     	adrp	x8, 0x11ea08000 <dyld_stub_binder+0x11ea08000>
10203a78c:     	ldr	x1, [x8, #0xd08] ; selector: addContact:listType:opLog:callExt:
10203a790:     	mov	x0, x20
10203a794:     	mov	x2, x21
10203a798:     	mov	w3, #0x1                ; =1
10203a79c:     	mov	w4, #0x1                ; =1
10203a7a0:     	mov	w5, #0x1                ; =1
10203a7a4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a7a8:     	mov	x22, x0
10203a7ac:     	b	0x10203a7f8 <_Flutter_Image_provideRelativePathByUrl+0x2c2c84>
10203a7b0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10203a7b4:     	ldr	x0, [x8, #0x618]
10203a7b8:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203a7bc:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
10203a7c0:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
10203a7c4:     	add	x8, x8, #0x918 ; CFString: return NO because oContact == nil, groupName: %@
10203a7c8:     	stp	x8, x19, [sp]
10203a7cc:     	adrp	x3, 0x119c93000 <dyld_stub_binder+0x119c93000>
10203a7d0:     	add	x3, x3, #0x582
10203a7d4:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a7d8:     	add	x5, x5, #0x24a
10203a7dc:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
10203a7e0:     	add	x7, x7, #0x760
10203a7e4:     	mov	w2, #0x2                ; =2
10203a7e8:     	mov	w4, #0x0                ; =0
10203a7ec:     	mov	w6, #0x2a8              ; =680
10203a7f0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10203a7f4:     	mov	w22, #0x0               ; =0
10203a7f8:     	mov	x0, x21
10203a7fc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a800:     	mov	x0, x20
10203a804:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a808:     	mov	x0, x19
10203a80c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203a810:     	mov	x0, x22
10203a814:     	ldp	x29, x30, [sp, #0x30]
10203a818:     	ldp	x20, x19, [sp, #0x20]
10203a81c:     	ldp	x22, x21, [sp, #0x10]
10203a820:     	add	sp, sp, #0x40
10203a824:     	ret
