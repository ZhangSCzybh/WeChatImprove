
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101074910:     	stp	x20, x19, [sp, #-0x20]!
101074914:     	stp	x29, x30, [sp, #0x10]
101074918:     	add	x29, sp, #0x10
10107491c:     	mov	x19, x2
101074920:     	mov	x0, x2
101074924:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
101074928:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10107492c:     	ldr	x1, [x8, #0xfa8] ; selector: isChatroom
101074930:     	mov	x0, x19
101074934:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074938:     	tbz	w0, #0x0, 0x101074944 <__text+0x106c944>
10107493c:     	mov	w20, #0x1               ; =1
101074940:     	b	0x10107498c <__text+0x106c98c>
101074944:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
101074948:     	ldr	x0, [x8, #0xac0]
10107494c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
101074950:     	ldr	x1, [x8, #0x508] ; selector: class
101074954:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074958:     	mov	x2, x0
10107495c:     	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
101074960:     	ldr	x1, [x8, #0x890] ; selector: isKindOfClass:
101074964:     	mov	x0, x19
101074968:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10107496c:     	cbz	w0, 0x101074988 <__text+0x106c988>
101074970:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
101074974:     	ldr	x1, [x8, #0x980] ; selector: isOpenImChatroomAndUpgradeOpenIMChatroom
101074978:     	mov	x0, x19
10107497c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074980:     	mov	x20, x0
101074984:     	b	0x10107498c <__text+0x106c98c>
101074988:     	mov	w20, #0x0               ; =0
10107498c:     	mov	x0, x19
101074990:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101074994:     	mov	x0, x20
101074998:     	ldp	x29, x30, [sp, #0x10]
10107499c:     	ldp	x20, x19, [sp], #0x20
1010749a0:     	ret
