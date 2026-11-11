
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
10121ff00:     	sub	sp, sp, #0x60
10121ff04:     	stp	x26, x25, [sp, #0x10]
10121ff08:     	stp	x24, x23, [sp, #0x20]
10121ff0c:     	stp	x22, x21, [sp, #0x30]
10121ff10:     	stp	x20, x19, [sp, #0x40]
10121ff14:     	stp	x29, x30, [sp, #0x50]
10121ff18:     	add	x29, sp, #0x50
10121ff1c:     	mov	x20, x0
10121ff20:     	adrp	x8, 0x11f744000 <dyld_stub_binder+0x11f744000>
10121ff24:     	mov	w9, #0x1                ; =1
10121ff28:     	strb	w9, [x8, #0x162]
10121ff2c:     	adrp	x8, 0x11ea1c000 <dyld_stub_binder+0x11ea1c000>
10121ff30:     	ldr	x19, [x8, #0xd18]
10121ff34:     	mov	x1, x19
10121ff38:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ff3c:     	mov	x29, x29
10121ff40:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ff44:     	mov	x21, x0
10121ff48:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121ff4c:     	cbz	x21, 0x10121ff6c <__text+0x1217f6c>
10121ff50:     	mov	x0, x20
10121ff54:     	mov	x1, x19
10121ff58:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ff5c:     	mov	x29, x29
10121ff60:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ff64:     	mov	x20, x0
10121ff68:     	b	0x101220128 <__text+0x1218128>
10121ff6c:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121ff70:     	ldr	x23, [x8, #0xa30]
10121ff74:     	mov	x0, x20
10121ff78:     	mov	x1, x23
10121ff7c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ff80:     	mov	x29, x29
10121ff84:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ff88:     	mov	x19, x0
10121ff8c:     	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
10121ff90:     	ldr	x1, [x8, #0xfa8]
10121ff94:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ff98:     	mov	x24, x0
10121ff9c:     	mov	x0, x19
10121ffa0:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10121ffa4:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121ffa8:     	ldr	x22, [x8, #0x638]
10121ffac:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121ffb0:     	ldr	x0, [x8, #0x780]
10121ffb4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121ffb8:     	ldr	x1, [x8, #0x800]
10121ffbc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ffc0:     	mov	x29, x29
10121ffc4:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121ffc8:     	mov	x19, x0
10121ffcc:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10121ffd0:     	ldr	x0, [x8, #0x800]
10121ffd4:     	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
10121ffd8:     	ldr	x1, [x8, #0x508]
10121ffdc:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121ffe0:     	mov	x2, x0
10121ffe4:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
10121ffe8:     	ldr	x1, [x8, #0xa40]
10121ffec:     	mov	x0, x19
10121fff0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10121fff4:     	mov	x29, x29
10121fff8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
10121fffc:     	mov	x21, x0
101220000:     	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
101220004:     	ldr	x1, [x8, #0xa48]
101220008:     	cbz	w24, 0x1012200a4 <__text+0x12180a4>
10122000c:     	adrp	x2, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
101220010:     	add	x2, x2, #0x338
101220014:     	mov	x0, x21
101220018:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10122001c:     	mov	x29, x29
101220020:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220024:     	mov	x24, x0
101220028:     	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
10122002c:     	ldr	x25, [x8, #0xac0]
101220030:     	mov	x0, x20
101220034:     	mov	x1, x23
101220038:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10122003c:     	mov	x29, x29
101220040:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220044:     	mov	x23, x0
101220048:     	adrp	x8, 0x11e9f3000 <dyld_stub_binder+0x11e9f3000>
10122004c:     	ldr	x1, [x8, #0xe78]
101220050:     	mov	x0, x25
101220054:     	mov	x2, x23
101220058:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
10122005c:     	mov	x29, x29
101220060:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220064:     	mov	x25, x0
101220068:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
10122006c:     	ldr	x1, [x8, #0x5c8]
101220070:     	str	x0, [sp]
101220074:     	mov	x0, x22
101220078:     	mov	x2, x24
10122007c:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
101220080:     	mov	x29, x29
101220084:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220088:     	mov	x20, x0
10122008c:     	mov	x0, x25
101220090:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220094:     	mov	x0, x23
101220098:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
10122009c:     	mov	x0, x24
1012200a0:     	b	0x101220114 <__text+0x1218114>
1012200a4:     	adrp	x2, 0x11d05c000 <dyld_stub_binder+0x11d05c000>
1012200a8:     	add	x2, x2, #0x358
1012200ac:     	mov	x0, x21
1012200b0:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1012200b4:     	mov	x29, x29
1012200b8:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1012200bc:     	mov	x23, x0
1012200c0:     	adrp	x8, 0x11ed8b000 <dyld_stub_binder+0x11ed8b000>
1012200c4:     	ldrsw	x8, [x8, #0x2f4]
1012200c8:     	ldr	x0, [x20, x8]
1012200cc:     	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1012200d0:     	ldr	x1, [x8, #0x990]
1012200d4:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1012200d8:     	mov	x29, x29
1012200dc:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
1012200e0:     	mov	x24, x0
1012200e4:     	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1012200e8:     	ldr	x1, [x8, #0x5c8]
1012200ec:     	str	x0, [sp]
1012200f0:     	mov	x0, x22
1012200f4:     	mov	x2, x23
1012200f8:     	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
1012200fc:     	mov	x29, x29
101220100:     	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
101220104:     	mov	x20, x0
101220108:     	mov	x0, x24
10122010c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220110:     	mov	x0, x23
101220114:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220118:     	mov	x0, x21
10122011c:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220120:     	mov	x0, x19
101220124:     	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
101220128:     	mov	x0, x20
10122012c:     	ldp	x29, x30, [sp, #0x50]
101220130:     	ldp	x20, x19, [sp, #0x40]
101220134:     	ldp	x22, x21, [sp, #0x30]
101220138:     	ldp	x24, x23, [sp, #0x20]
10122013c:     	ldp	x26, x25, [sp, #0x10]
101220140:     	add	sp, sp, #0x60
101220144:     	b	0x107c27c20 <_Flutter_MMFoundation_BindContext+0x3eae8ec>
