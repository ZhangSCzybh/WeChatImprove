
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10038ee1c:     	sub	sp, sp, #0x1b0
10038ee20:     	stp	x28, x27, [sp, #0x150]
10038ee24:     	stp	x26, x25, [sp, #0x160]
10038ee28:     	stp	x24, x23, [sp, #0x170]
10038ee2c:     	stp	x22, x21, [sp, #0x180]
10038ee30:     	stp	x20, x19, [sp, #0x190]
10038ee34:     	stp	x29, x30, [sp, #0x1a0]
10038ee38:     	add	x29, sp, #0x1a0
10038ee3c:     	mov	x19, x0
10038ee40:     	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038ee44:     	ldr	x8, [x8, #0xa30]
10038ee48:     	ldr	x8, [x8]
10038ee4c:     	stur	x8, [x29, #-0x60]
10038ee50:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10038ee54:     	mov	w9, #0x1                ; =1
10038ee58:     	strb	w9, [x8, #0xc03]
10038ee5c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ee60:     	ldr	x1, [x8, #0x400] ; selector: running
10038ee64:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ee68:     	cbz	w0, 0x10038f260 <__text+0x387260>
10038ee6c:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038ee70:     	ldr	x20, [x8, #0x448] ; selector: approvedRoomNames
10038ee74:     	mov	x0, x19
10038ee78:     	mov	x1, x20
10038ee7c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ee80:     	mov	x29, x29
10038ee84:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ee88:     	mov	x21, x0
10038ee8c:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038ee90:     	ldr	x1, [x8, #0x818] ; selector: copy
10038ee94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ee98:     	mov	x22, x0
10038ee9c:     	mov	x0, x21
10038eea0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038eea4:     	mov	x0, x19
10038eea8:     	mov	x1, x20
10038eeac:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eeb0:     	mov	x29, x29
10038eeb4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038eeb8:     	mov	x20, x0
10038eebc:     	adrp	x8, 0x11ecaa000 <dyld_stub_binder+0x11ecaa000>
10038eec0:     	ldr	x1, [x8, #0x420] ; selector: removeAllObjects
10038eec4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eec8:     	mov	x0, x20
10038eecc:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038eed0:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038eed4:     	ldr	x1, [x8, #0x850] ; selector: count
10038eed8:     	mov	x0, x22
10038eedc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eee0:     	cbz	x0, 0x10038f248 <__text+0x387248>
10038eee4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038eee8:     	ldr	x1, [x8, #0x418] ; selector: setStage:
10038eeec:     	mov	x0, x19
10038eef0:     	mov	w2, #0x1                ; =1
10038eef4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038eef8:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038eefc:     	ldr	x0, [x8, #0x780]
10038ef00:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038ef04:     	ldr	x1, [x8, #0x800] ; selector: currentContext
10038ef08:     	str	x1, [sp, #0x78]
10038ef0c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ef10:     	mov	x29, x29
10038ef14:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ef18:     	mov	x20, x0
10038ef1c:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038ef20:     	ldr	x0, [x8, #0xbe8]
10038ef24:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038ef28:     	ldr	x1, [x8, #0x508] ; selector: class
10038ef2c:     	str	x1, [sp, #0x70]
10038ef30:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ef34:     	mov	x2, x0
10038ef38:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10038ef3c:     	ldr	x24, [x8, #0xa40] ; selector: getService:
10038ef40:     	mov	x0, x20
10038ef44:     	mov	x1, x24
10038ef48:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ef4c:     	mov	x29, x29
10038ef50:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038ef54:     	str	x0, [sp, #0x40]
10038ef58:     	mov	x0, x20
10038ef5c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038ef60:     	movi.16b	v0, #0x0
10038ef64:     	stp	q0, q0, [sp, #0xa0]
10038ef68:     	stp	q0, q0, [sp, #0x80]
10038ef6c:     	mov	x0, x22
10038ef70:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10038ef74:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10038ef78:     	ldr	x1, [x8, #0x858] ; selector: countByEnumeratingWithState:objects:count:
10038ef7c:     	add	x2, sp, #0x80
10038ef80:     	add	x3, sp, #0xc0
10038ef84:     	str	x1, [sp, #0x10]
10038ef88:     	mov	w4, #0x10               ; =16
10038ef8c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038ef90:     	str	x0, [sp, #0x68]
10038ef94:     	cbz	x0, 0x10038f220 <__text+0x387220>
10038ef98:     	ldr	x8, [sp, #0x90]
10038ef9c:     	ldr	x8, [x8]
10038efa0:     	stp	x22, x8, [sp, #0x30]
10038efa4:     	mov	x20, #0x0               ; =0
10038efa8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10038efac:     	ldr	x9, [x8, #0x150] ; selector: getContactByName:
10038efb0:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
10038efb4:     	ldr	x8, [x8, #0xed0] ; selector: m_uiType
10038efb8:     	stp	x8, x9, [sp, #0x58]
10038efbc:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
10038efc0:     	ldr	x9, [x8, #0x5d8] ; selector: numberWithUnsignedInt:
10038efc4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038efc8:     	ldr	x8, [x8, #0x468] ; selector: oldUITypeByRoomName
10038efcc:     	stp	x8, x9, [sp, #0x48]
10038efd0:     	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
10038efd4:     	ldr	x23, [x8, #0x298] ; selector: setObject:forKeyedSubscript:
10038efd8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038efdc:     	ldr	x26, [x8, #0x488] ; selector: clearHistory
10038efe0:     	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
10038efe4:     	ldr	x9, [x8, #0x910] ; selector: cleanSessionMigrationRecord:
10038efe8:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10038efec:     	ldr	x8, [x8, #0x5c8] ; selector: stringWithFormat:
10038eff0:     	stp	x8, x9, [sp, #0x20]
10038eff4:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038eff8:     	ldr	x21, [x8, #0x4d0] ; selector: IsOpenWXTalkMode:
10038effc:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f000:     	ldr	x8, [x8, #0x4d8] ; selector: CloseWXTalkModeAndNotifyUI:
10038f004:     	str	x8, [sp, #0x18]
10038f008:     	ldr	x8, [sp, #0x90]
10038f00c:     	ldr	x8, [x8]
10038f010:     	ldr	x9, [sp, #0x38]
10038f014:     	cmp	x8, x9
10038f018:     	b.eq	0x10038f024 <__text+0x387024>
10038f01c:     	ldr	x0, [sp, #0x30]
10038f020:     	bl	0x107c27c3c <_Flutter_MMFoundation_BindContext+0x3eae908>
10038f024:     	ldr	x8, [sp, #0x88]
10038f028:     	ldr	x25, [x8, x20, lsl #3]
10038f02c:     	ldr	x0, [sp, #0x40]
10038f030:     	ldr	x1, [sp, #0x60]
10038f034:     	mov	x2, x25
10038f038:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f03c:     	mov	x29, x29
10038f040:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f044:     	mov	x28, x0
10038f048:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f04c:     	ldr	x27, [x8, #0x6c0]
10038f050:     	ldr	x1, [sp, #0x58]
10038f054:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f058:     	mov	x2, x0
10038f05c:     	mov	x0, x27
10038f060:     	ldr	x1, [sp, #0x50]
10038f064:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f068:     	mov	x29, x29
10038f06c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f070:     	mov	x27, x0
10038f074:     	mov	x0, x19
10038f078:     	ldr	x1, [sp, #0x48]
10038f07c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f080:     	mov	x29, x29
10038f084:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f088:     	mov	x22, x0
10038f08c:     	mov	x1, x23
10038f090:     	mov	x2, x27
10038f094:     	mov	x3, x25
10038f098:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f09c:     	mov	x0, x22
10038f0a0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f0a4:     	mov	x0, x27
10038f0a8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f0ac:     	mov	x0, x19
10038f0b0:     	mov	x1, x26
10038f0b4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f0b8:     	cbz	w0, 0x10038f114 <__text+0x387114>
10038f0bc:     	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10038f0c0:     	ldr	x0, [x8, #0x680]
10038f0c4:     	ldr	x1, [sp, #0x28]
10038f0c8:     	mov	x2, x25
10038f0cc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f0d0:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f0d4:     	ldr	x0, [x8, #0x638]
10038f0d8:     	str	x25, [sp]
10038f0dc:     	ldr	x1, [sp, #0x20]
10038f0e0:     	adrp	x2, 0x11cfc6000 <dyld_stub_binder+0x11cfc6000>
10038f0e4:     	add	x2, x2, #0xe38 ; CFString: 4,2,%@
10038f0e8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f0ec:     	mov	x29, x29
10038f0f0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f0f4:     	mov	x22, x0
10038f0f8:     	mov	w0, #0x38d9             ; =14553
10038f0fc:     	mov	x1, x22
10038f100:     	mov	w2, #0x0                ; =0
10038f104:     	mov	w3, #0x0                ; =0
10038f108:     	bl	0x10241a0cc <_Flutter_Image_provideRelativePathByUrl+0x6a2558>
10038f10c:     	mov	x0, x22
10038f110:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f114:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f118:     	ldr	x0, [x8, #0x780]
10038f11c:     	ldr	x1, [sp, #0x78]
10038f120:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f124:     	mov	x29, x29
10038f128:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f12c:     	mov	x22, x0
10038f130:     	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10038f134:     	ldr	x0, [x8, #0x9f0]
10038f138:     	ldr	x1, [sp, #0x70]
10038f13c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f140:     	mov	x2, x0
10038f144:     	mov	x0, x22
10038f148:     	mov	x1, x24
10038f14c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f150:     	mov	x29, x29
10038f154:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f158:     	mov	x27, x0
10038f15c:     	mov	x1, x21
10038f160:     	mov	x2, x25
10038f164:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f168:     	mov	x25, x0
10038f16c:     	mov	x0, x27
10038f170:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f174:     	mov	x0, x22
10038f178:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f17c:     	cbz	w25, 0x10038f1e4 <__text+0x3871e4>
10038f180:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10038f184:     	ldr	x0, [x8, #0x780]
10038f188:     	ldr	x1, [sp, #0x78]
10038f18c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f190:     	mov	x29, x29
10038f194:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f198:     	mov	x22, x0
10038f19c:     	adrp	x8, 0x11ed15000 <dyld_stub_binder+0x11ed15000>
10038f1a0:     	ldr	x0, [x8, #0x9f0]
10038f1a4:     	ldr	x1, [sp, #0x70]
10038f1a8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f1ac:     	mov	x2, x0
10038f1b0:     	mov	x0, x22
10038f1b4:     	mov	x1, x24
10038f1b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f1bc:     	mov	x29, x29
10038f1c0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10038f1c4:     	mov	x25, x0
10038f1c8:     	ldr	x1, [sp, #0x18]
10038f1cc:     	mov	w2, #0x1                ; =1
10038f1d0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f1d4:     	mov	x0, x25
10038f1d8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f1dc:     	mov	x0, x22
10038f1e0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f1e4:     	mov	x0, x28
10038f1e8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f1ec:     	add	x20, x20, #0x1
10038f1f0:     	ldr	x8, [sp, #0x68]
10038f1f4:     	cmp	x8, x20
10038f1f8:     	b.ne	0x10038f008 <__text+0x387008>
10038f1fc:     	add	x2, sp, #0x80
10038f200:     	add	x3, sp, #0xc0
10038f204:     	ldr	x22, [sp, #0x30]
10038f208:     	mov	x0, x22
10038f20c:     	ldr	x1, [sp, #0x10]
10038f210:     	mov	w4, #0x10               ; =16
10038f214:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f218:     	str	x0, [sp, #0x68]
10038f21c:     	cbnz	x0, 0x10038efa4 <__text+0x386fa4>
10038f220:     	mov	x0, x22
10038f224:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f228:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f22c:     	ldr	x1, [x8, #0x4e0] ; selector: sendBatchWithRoomNames:
10038f230:     	mov	x0, x19
10038f234:     	mov	x2, x22
10038f238:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f23c:     	ldr	x0, [sp, #0x40]
10038f240:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f244:     	b	0x10038f258 <__text+0x387258>
10038f248:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
10038f24c:     	ldr	x1, [x8, #0x490] ; selector: complete
10038f250:     	mov	x0, x19
10038f254:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10038f258:     	mov	x0, x22
10038f25c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10038f260:     	ldur	x8, [x29, #-0x60]
10038f264:     	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
10038f268:     	ldr	x9, [x9, #0xa30]
10038f26c:     	ldr	x9, [x9]
10038f270:     	cmp	x9, x8
10038f274:     	b.ne	0x10038f298 <__text+0x387298>
10038f278:     	ldp	x29, x30, [sp, #0x1a0]
10038f27c:     	ldp	x20, x19, [sp, #0x190]
10038f280:     	ldp	x22, x21, [sp, #0x180]
10038f284:     	ldp	x24, x23, [sp, #0x170]
10038f288:     	ldp	x26, x25, [sp, #0x160]
10038f28c:     	ldp	x28, x27, [sp, #0x150]
10038f290:     	add	sp, sp, #0x1b0
10038f294:     	ret
10038f298:     	bl	0x107c27730 <_Flutter_MMFoundation_BindContext+0x3eae3fc>
