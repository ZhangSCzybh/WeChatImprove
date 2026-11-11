
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100390ff8:     	stp	x24, x23, [sp, #-0x40]!
100390ffc:     	stp	x22, x21, [sp, #0x10]
100391000:     	stp	x20, x19, [sp, #0x20]
100391004:     	stp	x29, x30, [sp, #0x30]
100391008:     	add	x29, sp, #0x30
10039100c:     	mov	x20, x3
100391010:     	mov	x19, x2
100391014:     	mov	x21, x0
100391018:     	adrp	x8, 0x11f740000 <dyld_stub_binder+0x11f740000>
10039101c:     	mov	w9, #0x1                ; =1
100391020:     	strb	w9, [x8, #0xc0a]
100391024:     	mov	x0, x2
100391028:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
10039102c:     	mov	x0, x20
100391030:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100391034:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
100391038:     	ldr	x22, [x8, #0x458] ; selector: failures
10039103c:     	mov	x0, x21
100391040:     	mov	x1, x22
100391044:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391048:     	mov	x29, x29
10039104c:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100391050:     	mov	x23, x0
100391054:     	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
100391058:     	ldr	x1, [x8, #0x650] ; selector: objectForKeyedSubscript:
10039105c:     	mov	x2, x19
100391060:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391064:     	mov	x29, x29
100391068:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10039106c:     	mov	x24, x0
100391070:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100391074:     	mov	x0, x23
100391078:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10039107c:     	cbnz	x24, 0x100391110 <__text+0x389110>
100391080:     	adrp	x8, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
100391084:     	add	x8, x8, #0xe58 ; CFString: 
100391088:     	cmp	x20, #0x0
10039108c:     	csel	x23, x8, x20, eq
100391090:     	mov	x0, x23
100391094:     	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
100391098:     	mov	x0, x21
10039109c:     	mov	x1, x22
1003910a0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003910a4:     	mov	x29, x29
1003910a8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003910ac:     	mov	x22, x0
1003910b0:     	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
1003910b4:     	ldr	x1, [x8, #0x298] ; selector: setObject:forKeyedSubscript:
1003910b8:     	mov	x2, x23
1003910bc:     	mov	x3, x19
1003910c0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003910c4:     	mov	x0, x22
1003910c8:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
1003910cc:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1003910d0:     	ldr	x1, [x8, #0xd38] ; selector: delegate
1003910d4:     	mov	x0, x21
1003910d8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1003910dc:     	mov	x29, x29
1003910e0:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1003910e4:     	mov	x22, x0
1003910e8:     	adrp	x8, 0x11e9e1000 <dyld_stub_binder+0x11e9e1000>
1003910ec:     	ldr	x1, [x8, #0x560] ; selector: batchQuitChatRoomLogic:didFailRoom:errorMessage:
1003910f0:     	mov	x2, x21
1003910f4:     	mov	x3, x19
1003910f8:     	mov	x4, x23
1003910fc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100391100:     	mov	x0, x23
100391104:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100391108:     	mov	x0, x22
10039110c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100391110:     	mov	x0, x20
100391114:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100391118:     	mov	x0, x19
10039111c:     	ldp	x29, x30, [sp, #0x30]
100391120:     	ldp	x20, x19, [sp, #0x20]
100391124:     	ldp	x22, x21, [sp, #0x10]
100391128:     	ldp	x24, x23, [sp], #0x40
10039112c:     	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
