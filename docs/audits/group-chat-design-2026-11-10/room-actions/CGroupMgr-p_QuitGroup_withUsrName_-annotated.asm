
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101d77b74 <_Flutter_Image_provideRelativePathByUrl>:
102037fa0:     	sub	sp, sp, #0x60
102037fa4:     	stp	x24, x23, [sp, #0x20]
102037fa8:     	stp	x22, x21, [sp, #0x30]
102037fac:     	stp	x20, x19, [sp, #0x40]
102037fb0:     	stp	x29, x30, [sp, #0x50]
102037fb4:     	add	x29, sp, #0x50
102037fb8:     	mov	x20, x3
102037fbc:     	mov	x21, x2
102037fc0:     	mov	x19, x0
102037fc4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102037fc8:     	ldr	x22, [x8, #0x618]
102037fcc:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
102037fd0:     	ldr	x23, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
102037fd4:     	mov	x0, x3
102037fd8:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102037fdc:     	mov	x0, x21
102037fe0:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
102037fe4:     	stp	x21, x20, [sp, #0x8]
102037fe8:     	adrp	x8, 0x11d0fa000 <dyld_stub_binder+0x11d0fa000>
102037fec:     	add	x8, x8, #0x718 ; CFString: QuitGroup: %@ %@
102037ff0:     	str	x8, [sp]
102037ff4:     	adrp	x5, 0x119e19000 <dyld_stub_binder+0x119e19000>
102037ff8:     	add	x5, x5, #0x24a
102037ffc:     	adrp	x7, 0x119e19000 <dyld_stub_binder+0x119e19000>
102038000:     	add	x7, x7, #0x426
102038004:     	mov	x0, x22
102038008:     	mov	x1, x23
10203800c:     	mov	w2, #0x2                ; =2
102038010:     	mov	x3, #0x0                ; =0
102038014:     	mov	w4, #0x0                ; =0
102038018:     	mov	w6, #0x158              ; =344
10203801c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102038020:     	adrp	x8, 0x11ed98000 <dyld_stub_binder+0x11ed98000>
102038024:     	ldrsw	x8, [x8, #0x328]
102038028:     	ldr	x0, [x19, x8]
10203802c:     	adrp	x8, 0x11ea62000 <dyld_stub_binder+0x11ea62000>
102038030:     	ldr	x1, [x8, #0x648] ; selector: start_QuitGroup:withUsrName:
102038034:     	mov	x2, x21
102038038:     	mov	x3, x20
10203803c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102038040:     	mov	x22, x0
102038044:     	mov	x0, x20
102038048:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10203804c:     	mov	x0, x21
102038050:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
102038054:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102038058:     	ldr	x0, [x8, #0x638]
10203805c:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
102038060:     	ldr	x1, [x8, #0x5c8] ; selector: stringWithFormat:
102038064:     	str	x22, [sp]
102038068:     	adrp	x2, 0x11cfa2000 <dyld_stub_binder+0x11cfa2000>
10203806c:     	add	x2, x2, #0xaf8 ; CFString: %u
102038070:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102038074:     	mov	x29, x29
102038078:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203807c:     	mov	x20, x0
102038080:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
102038084:     	ldr	x0, [x8, #0x780]
102038088:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10203808c:     	ldr	x1, [x8, #0x800] ; selector: currentContext
102038090:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
102038094:     	mov	x29, x29
102038098:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10203809c:     	mov	x21, x0
1020380a0:     	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1020380a4:     	ldr	x2, [x8, #0xc90]
1020380a8:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1020380ac:     	ldr	x1, [x8, #0x7a0] ; selector: registerExtension:withKey:withTarget:
1020380b0:     	mov	x3, x20
1020380b4:     	mov	x4, x19
1020380b8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1020380bc:     	mov	x0, x21
1020380c0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020380c4:     	cmp	w22, #0x0
1020380c8:     	cset	w19, ne
1020380cc:     	mov	x0, x20
1020380d0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1020380d4:     	mov	x0, x19
1020380d8:     	ldp	x29, x30, [sp, #0x50]
1020380dc:     	ldp	x20, x19, [sp, #0x40]
1020380e0:     	ldp	x22, x21, [sp, #0x30]
1020380e4:     	ldp	x24, x23, [sp, #0x20]
1020380e8:     	add	sp, sp, #0x60
1020380ec:     	ret
