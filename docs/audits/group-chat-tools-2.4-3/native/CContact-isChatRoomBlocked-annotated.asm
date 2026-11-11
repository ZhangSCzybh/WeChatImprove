
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
101074b68:     	stp	x20, x19, [sp, #-0x20]!
101074b6c:     	stp	x29, x30, [sp, #0x10]
101074b70:     	add	x29, sp, #0x10
101074b74:     	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
101074b78:     	ldr	x1, [x8, #0xfd8] ; selector: m_ChatRoomDetail
101074b7c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074b80:     	mov	x29, x29
101074b84:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101074b88:     	mov	x19, x0
101074b8c:     	adrp	x8, 0x11ea1a000 <dyld_stub_binder+0x11ea1a000>
101074b90:     	ldr	x1, [x8, #0xf08] ; selector: m_uiChatRoomSpamStatus
101074b94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101074b98:     	mov	x20, x0
101074b9c:     	mov	x0, x19
101074ba0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101074ba4:     	and	w0, w20, #0x1
101074ba8:     	ldp	x29, x30, [sp, #0x10]
101074bac:     	ldp	x20, x19, [sp], #0x20
101074bb0:     	ret
