
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100390b88:     	sub	sp, sp, #0xb0
100390b8c:     	stp	x28, x27, [sp, #0x50]
100390b90:     	stp	x26, x25, [sp, #0x60]
100390b94:     	stp	x24, x23, [sp, #0x70]
100390b98:     	stp	x22, x21, [sp, #0x80]
100390b9c:     	stp	x20, x19, [sp, #0x90]
100390ba0:     	stp	x29, x30, [sp, #0xa0]
100390ba4:     	add	x29, sp, #0xa0
100390ba8:     	mov	x19, x2
100390bac:     	mov	x22, x0
100390bb0:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
100390bb4:     	mov	w9, #0x1                ; =1
100390bb8:     	strb	w9, [x8, #0xc09]
100390bbc:     	mov	x0, x2
100390bc0:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100390bc4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390bc8:     	ldr	x0, [x8, #0x9d0]
100390bcc:     	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
100390bd0:     	ldr	x1, [x8, #0x120] ; selector: getLocalUsrName:
100390bd4:     	mov	w2, #0x0                ; =0
100390bd8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390bdc:     	mov	x29, x29
100390be0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390be4:     	str	x0, [sp, #0x30]
100390be8:     	adrp	x20, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390bec:     	ldr	x0, [x20, #0x780]
100390bf0:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100390bf4:     	ldr	x21, [x8, #0x800] ; selector: currentContext
100390bf8:     	mov	x1, x21
100390bfc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390c00:     	mov	x29, x29
100390c04:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390c08:     	mov	x23, x0
100390c0c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390c10:     	ldr	x0, [x8, #0xb78]
100390c14:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
100390c18:     	ldr	x24, [x8, #0x508] ; selector: class
100390c1c:     	mov	x1, x24
100390c20:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390c24:     	mov	x2, x0
100390c28:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100390c2c:     	ldr	x25, [x8, #0xa40] ; selector: getService:
100390c30:     	mov	x0, x23
100390c34:     	mov	x1, x25
100390c38:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390c3c:     	mov	x29, x29
100390c40:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390c44:     	mov	x27, x0
100390c48:     	mov	x0, x23
100390c4c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390c50:     	ldr	x0, [x20, #0x780]
100390c54:     	mov	x1, x21
100390c58:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390c5c:     	mov	x29, x29
100390c60:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390c64:     	mov	x21, x0
100390c68:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390c6c:     	ldr	x0, [x8, #0xbe8]
100390c70:     	mov	x1, x24
100390c74:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390c78:     	mov	x2, x0
100390c7c:     	mov	x0, x21
100390c80:     	mov	x1, x25
100390c84:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390c88:     	mov	x29, x29
100390c8c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390c90:     	mov	x23, x0
100390c94:     	mov	x0, x21
100390c98:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390c9c:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100390ca0:     	ldr	x25, [x8, #0x150] ; selector: getContactByName:
100390ca4:     	mov	x0, x23
100390ca8:     	mov	x1, x25
100390cac:     	mov	x2, x19
100390cb0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390cb4:     	mov	x29, x29
100390cb8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390cbc:     	str	x0, [sp, #0x48]
100390cc0:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390cc4:     	ldr	x1, [x8, #0x468] ; selector: oldUITypeByRoomName
100390cc8:     	mov	x0, x22
100390ccc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390cd0:     	mov	x29, x29
100390cd4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390cd8:     	mov	x21, x0
100390cdc:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100390ce0:     	ldr	x1, [x8, #0x650] ; selector: objectForKeyedSubscript:
100390ce4:     	mov	x2, x19
100390ce8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390cec:     	mov	x29, x29
100390cf0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390cf4:     	mov	x26, x0
100390cf8:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
100390cfc:     	ldr	x1, [x8, #0xac8] ; selector: unsignedIntValue
100390d00:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390d04:     	mov	x24, x0
100390d08:     	mov	x0, x26
100390d0c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390d10:     	mov	x0, x21
100390d14:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390d18:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390d1c:     	ldr	x28, [x8, #0x488] ; selector: clearHistory
100390d20:     	str	x22, [sp, #0x40]
100390d24:     	mov	x0, x22
100390d28:     	ldr	x22, [sp, #0x30]
100390d2c:     	mov	x1, x28
100390d30:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390d34:     	mov	x4, x0
100390d38:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390d3c:     	ldr	x1, [x8, #0x540] ; selector: reconcileBatchQuitGroupLocally:withUsrName:deleteAllMsg:
100390d40:     	mov	x0, x27
100390d44:     	mov	x2, x19
100390d48:     	mov	x3, x22
100390d4c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390d50:     	mov	x26, x0
100390d54:     	adrp	x8, 0x11e9db000 <dyld_stub_binder+0x11e9db000>
100390d58:     	ldr	x1, [x8, #0xb98] ; selector: IsUsrInChatRoom:Usr:
100390d5c:     	str	x27, [sp, #0x38]
100390d60:     	mov	x0, x27
100390d64:     	mov	x2, x19
100390d68:     	mov	x3, x22
100390d6c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390d70:     	tbnz	w26, #0x0, 0x100390dd4 <__text+0x388dd4>
100390d74:     	mov	x21, x0
100390d78:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390d7c:     	ldr	x20, [x8, #0x618]
100390d80:     	ldr	x0, [sp, #0x40]
100390d84:     	mov	x1, x28
100390d88:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390d8c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
100390d90:     	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
100390d94:     	stp	x0, x24, [sp, #0x18]
100390d98:     	stp	x19, x21, [sp, #0x8]
100390d9c:     	adrp	x8, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
100390da0:     	add	x8, x8, #0xfb8 ; CFString: local reconciliation failed, room:%@ remainsInRoom:%d clearHistory:%d oldUIType:%u
100390da4:     	str	x8, [sp]
100390da8:     	adrp	x3, 0x119bcf000 <dyld_stub_binder+0x119bcf000>
100390dac:     	add	x3, x3, #0xff4
100390db0:     	adrp	x5, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390db4:     	add	x5, x5, #0xb
100390db8:     	adrp	x7, 0x119bd0000 <dyld_stub_binder+0x119bd0000>
100390dbc:     	add	x7, x7, #0x765
100390dc0:     	mov	x0, x20
100390dc4:     	mov	w2, #0x3                ; =3
100390dc8:     	mov	w4, #0x0                ; =0
100390dcc:     	mov	w6, #0x1d8              ; =472
100390dd0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390dd4:     	ldr	x21, [sp, #0x48]
100390dd8:     	cbz	x21, 0x100390ea0 <__text+0x388ea0>
100390ddc:     	adrp	x28, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
100390de0:     	ldr	x0, [x28, #0x638]
100390de4:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
100390de8:     	ldr	x20, [x8, #0x5c8] ; selector: stringWithFormat:
100390dec:     	mov	x27, x24
100390df0:     	str	x27, [sp]
100390df4:     	adrp	x21, 0x11cfa2000 <dyld_stub_binder+0x11cfa2000>
100390df8:     	add	x21, x21, #0xaf8 ; CFString: %u
100390dfc:     	mov	x1, x20
100390e00:     	mov	x2, x21
100390e04:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390e08:     	mov	x29, x29
100390e0c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390e10:     	mov	x27, x0
100390e14:     	ldr	x28, [x28, #0x638]
100390e18:     	mov	x0, x23
100390e1c:     	mov	x1, x25
100390e20:     	mov	x2, x19
100390e24:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390e28:     	mov	x29, x29
100390e2c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390e30:     	mov	x25, x0
100390e34:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
100390e38:     	ldr	x1, [x8, #0xed0] ; selector: m_uiType
100390e3c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390e40:     	str	x0, [sp]
100390e44:     	mov	x0, x28
100390e48:     	mov	x1, x20
100390e4c:     	mov	x2, x21
100390e50:     	ldr	x21, [sp, #0x48]
100390e54:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390e58:     	mov	x29, x29
100390e5c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100390e60:     	mov	x20, x0
100390e64:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390e68:     	ldr	x1, [x8, #0x548] ; selector: reportContactImportantChangeData:actionCode:actionScene:oldValue:newValue:
100390e6c:     	mov	x0, x23
100390e70:     	mov	x2, x21
100390e74:     	mov	w3, #0x6                ; =6
100390e78:     	mov	w4, #0x3                ; =3
100390e7c:     	mov	x5, x27
100390e80:     	mov	x6, x20
100390e84:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390e88:     	mov	x0, x20
100390e8c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390e90:     	mov	x0, x25
100390e94:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390e98:     	mov	x0, x27
100390e9c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390ea0:     	tbnz	w26, #0x0, 0x100390ebc <__text+0x388ebc>
100390ea4:     	mov	w0, #0x14f              ; =335
100390ea8:     	mov	w1, #0x7e               ; =126
100390eac:     	mov	w2, #0x1                ; =1
100390eb0:     	mov	w3, #0x0                ; =0
100390eb4:     	mov	w4, #0x0                ; =0
100390eb8:     	bl	0x1020ea20c <_Flutter_Image_provideRelativePathByUrl+0x372698>
100390ebc:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100390ec0:     	ldr	x1, [x8, #0x550] ; selector: recordSuccessForRoom:
100390ec4:     	ldr	x0, [sp, #0x40]
100390ec8:     	mov	x2, x19
100390ecc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100390ed0:     	mov	x0, x21
100390ed4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390ed8:     	mov	x0, x23
100390edc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390ee0:     	ldr	x0, [sp, #0x38]
100390ee4:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390ee8:     	mov	x0, x22
100390eec:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100390ef0:     	mov	x0, x19
100390ef4:     	ldp	x29, x30, [sp, #0xa0]
100390ef8:     	ldp	x20, x19, [sp, #0x90]
100390efc:     	ldp	x22, x21, [sp, #0x80]
100390f00:     	ldp	x24, x23, [sp, #0x70]
100390f04:     	ldp	x26, x25, [sp, #0x60]
100390f08:     	ldp	x28, x27, [sp, #0x50]
100390f0c:     	add	sp, sp, #0xb0
100390f10:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
