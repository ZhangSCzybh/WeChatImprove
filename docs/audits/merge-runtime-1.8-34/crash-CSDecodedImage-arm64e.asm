
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-merge-native-caps-1.8-33-kpv2li7j/theos/obj/arm64e/WeChatImprove.dylib:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000000004da7c <_CSBubbleStyleStart>:
   4dbb0: aa0003f3     	mov	x19, x0
   4dbb4: f0000980     	adrp	x0, 0x180000 <_uname+0x180000>
   4dbb8: 9134e000     	add	x0, x0, #0xd38
   4dbbc: 94031aca     	bl	0x1146e4 <_uname+0x1146e4>
   4dbc0: aa0003f4     	mov	x20, x0
   4dbc4: b4000220     	cbz	x0, 0x4dc08 <_CSBubbleStyleStart+0x18c>
   4dbc8: aa1303e0     	mov	x0, x19
   4dbcc: aa1403e1     	mov	x1, x20
   4dbd0: 94031bf5     	bl	0x114ba4 <_uname+0x114ba4>
   4dbd4: 360001a0     	tbz	w0, #0x0, 0x4dc08 <_CSBubbleStyleStart+0x18c>
   4dbd8: 90000b81     	adrp	x1, 0x1bd000 <_uname+0x1bd000>
   4dbdc: 910f2021     	add	x1, x1, #0x3c8
   4dbe0: aa1303e0     	mov	x0, x19
   4dbe4: 94031bc8     	bl	0x114b04 <_uname+0x114b04>
   4dbe8: aa1d03fd     	mov	x29, x29
   4dbec: 94031c0e     	bl	0x114c24 <_uname+0x114c24>
   4dbf0: aa0003f5     	mov	x21, x0
   4dbf4: b4000180     	cbz	x0, 0x4dc24 <_CSBubbleStyleStart+0x1a8>
   4dbf8: aa1503e0     	mov	x0, x21
   4dbfc: 94031bfe     	bl	0x114bf4 <_uname+0x114bf4>
   4dc00: aa0003f6     	mov	x22, x0
   4dc04: 14000033     	b	0x4dcd0 <_CSBubbleStyleStart+0x254>
   4dc08: aa1303e0     	mov	x0, x19
   4dc0c: aa1403e1     	mov	x1, x20
   4dc10: 94000223     	bl	0x4e49c <_CSBubbleStyleModelInsets+0x4f0>
   4dc14: aa1d03fd     	mov	x29, x29
   4dc18: 94031c03     	bl	0x114c24 <_uname+0x114c24>
   4dc1c: aa0003f6     	mov	x22, x0
   4dc20: 1400002e     	b	0x4dcd8 <_CSBubbleStyleStart+0x25c>
   4dc24: d2800018     	mov	x24, #0x0               ; =0
   4dc28: f00007a8     	adrp	x8, 0x144000 <_uname+0x144000>
   4dc2c: 913f4d08     	add	x8, x8, #0xfd3
   4dc30: f00007a9     	adrp	x9, 0x144000 <_uname+0x144000>
   4dc34: 913f1129     	add	x9, x9, #0xfc4
   4dc38: 710002df     	cmp	w22, #0x0
   4dc3c: 9a88112a     	csel	x10, x9, x8, ne
   4dc40: f00007ab     	adrp	x11, 0x144000 <_uname+0x144000>
   4dc44: 913f896b     	add	x11, x11, #0xfe2
   4dc48: a9002fea     	stp	x10, x11, [sp]
   4dc4c: 9a891108     	csel	x8, x8, x9, ne
   4dc50: f9000be8     	str	x8, [sp, #0x10]
   4dc54: 52800079     	mov	w25, #0x3               ; =3
   4dc58: 910003fa     	mov	x26, sp
   4dc5c: aa1303e0     	mov	x0, x19
   4dc60: 94031c1d     	bl	0x114cd4 <_uname+0x114cd4>
   4dc64: f8787b41     	ldr	x1, [x26, x24, lsl #3]
   4dc68: 94031b0b     	bl	0x114894 <_uname+0x114894>
   4dc6c: b40002a0     	cbz	x0, 0x4dcc0 <_CSBubbleStyleStart+0x244>
   4dc70: aa0003f6     	mov	x22, x0
   4dc74: 94031b4c     	bl	0x1149a4 <_uname+0x1149a4>
   4dc78: b4000240     	cbz	x0, 0x4dcc0 <_CSBubbleStyleStart+0x244>
   4dc7c: 39400008     	ldrb	w8, [x0]
   4dc80: 7101011f     	cmp	w8, #0x40
   4dc84: 540001e1     	b.ne	0x4dcc0 <_CSBubbleStyleStart+0x244>
   4dc88: aa1303e0     	mov	x0, x19
   4dc8c: aa1603e1     	mov	x1, x22
   4dc90: 94031c15     	bl	0x114ce4 <_uname+0x114ce4>
   4dc94: aa1d03fd     	mov	x29, x29
   4dc98: 94031be3     	bl	0x114c24 <_uname+0x114c24>
   4dc9c: aa0003f7     	mov	x23, x0
   4dca0: aa1403e1     	mov	x1, x20
   4dca4: 940001fe     	bl	0x4e49c <_CSBubbleStyleModelInsets+0x4f0>
   4dca8: aa1d03fd     	mov	x29, x29
   4dcac: 94031bde     	bl	0x114c24 <_uname+0x114c24>
   4dcb0: aa0003f6     	mov	x22, x0
   4dcb4: aa1703e0     	mov	x0, x23
   4dcb8: 94031bcb     	bl	0x114be4 <_uname+0x114be4>
   4dcbc: b50000b6     	cbnz	x22, 0x4dcd0 <_CSBubbleStyleStart+0x254>
   4dcc0: 91000718     	add	x24, x24, #0x1
   4dcc4: f1000739     	subs	x25, x25, #0x1
   4dcc8: 54fffca1     	b.ne	0x4dc5c <_CSBubbleStyleStart+0x1e0>
   4dccc: d2800016     	mov	x22, #0x0               ; =0
   4dcd0: aa1503e0     	mov	x0, x21
   4dcd4: 94031bc4     	bl	0x114be4 <_uname+0x114be4>
   4dcd8: aa1303e0     	mov	x0, x19
   4dcdc: 94031bc2     	bl	0x114be4 <_uname+0x114be4>
   4dce0: f9400fe8     	ldr	x8, [sp, #0x18]
   4dce4: d0000a49     	adrp	x9, 0x197000 <_uname+0x197000>
   4dce8: f9431929     	ldr	x9, [x9, #0x630]
   4dcec: f9400129     	ldr	x9, [x9]
   4dcf0: eb08013f     	cmp	x9, x8
   4dcf4: 540001a1     	b.ne	0x4dd28 <_CSBubbleStyleStart+0x2ac>
   4dcf8: aa1603e0     	mov	x0, x22
   4dcfc: a9467bfd     	ldp	x29, x30, [sp, #0x60]
   4dd00: a9454ff4     	ldp	x20, x19, [sp, #0x50]
   4dd04: a94457f6     	ldp	x22, x21, [sp, #0x40]
   4dd08: a9435ff8     	ldp	x24, x23, [sp, #0x30]
   4dd0c: a94267fa     	ldp	x26, x25, [sp, #0x20]
   4dd10: 9101c3ff     	add	sp, sp, #0x70
   4dd14: d50323ff     	autibsp
   4dd18: ca1e07d0     	eor	x16, x30, x30, lsl #1
   4dd1c: b6f00050     	tbz	x16, #0x3e, 0x4dd24 <_CSBubbleStyleStart+0x2a8>
   4dd20: d4388e20     	brk	#0xc471
   4dd24: 14031b54     	b	0x114a74 <_uname+0x114a74>
   4dd28: 94031ab7     	bl	0x114804 <_uname+0x114804>
