
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
106e90044: d10183ff    	sub	sp, sp, #0x60
106e90048: a90167fa    	stp	x26, x25, [sp, #0x10]
106e9004c: a9025ff8    	stp	x24, x23, [sp, #0x20]
106e90050: a90357f6    	stp	x22, x21, [sp, #0x30]
106e90054: a9044ff4    	stp	x20, x19, [sp, #0x40]
106e90058: a9057bfd    	stp	x29, x30, [sp, #0x50]
106e9005c: 910143fd    	add	x29, sp, #0x50
106e90060: aa0303f5    	mov	x21, x3
106e90064: aa0203f3    	mov	x19, x2
106e90068: aa0003f4    	mov	x20, x0
106e9006c: d00ceda8    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
106e90070: 52800029    	mov	w9, #0x1                ; =1
106e90074: 391ae509    	strb	w9, [x8, #0x6b9]
106e90078: aa0203e0    	mov	x0, x2
106e9007c: 94365c2f    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
106e90080: b4000853    	cbz	x19, 0x106e90188 <_Flutter_MMFoundation_BindContext+0x336bd6c>
106e90084: d00c93c8    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106e90088: f947c101    	ldr	x1, [x8, #0xf80] ; tag
106e9008c: aa1303e0    	mov	x0, x19
106e90090: 94365c2b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90094: b7f80cc0    	tbnz	x0, #0x3f, 0x106e9022c <_Flutter_MMFoundation_BindContext+0x336be10>
106e90098: aa0003f6    	mov	x22, x0
106e9009c: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e900a0: b984c117    	ldrsw	x23, [x8, #0x4c0]
106e900a4: f8776a80    	ldr	x0, [x20, x23]
106e900a8: 900c9388    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
106e900ac: f9435101    	ldr	x1, [x8, #0x6a0] ; count
106e900b0: 94365c23    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e900b4: eb0002df    	cmp	x22, x0
106e900b8: 54000ba2    	b.hs	0x106e9022c <_Flutter_MMFoundation_BindContext+0x336be10>
106e900bc: f8776a80    	ldr	x0, [x20, x23]
106e900c0: d00c7d48    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
106e900c4: f942c101    	ldr	x1, [x8, #0x580] ; safeObjectAtIndex:
106e900c8: aa1603e2    	mov	x2, x22
106e900cc: 94365c1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e900d0: aa1d03fd    	mov	x29, x29
106e900d4: 94365c1d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e900d8: aa0003f7    	mov	x23, x0
106e900dc: 900c7d68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
106e900e0: f9471101    	ldr	x1, [x8, #0xe20] ; username
106e900e4: 94365c16    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e900e8: aa1d03fd    	mov	x29, x29
106e900ec: 94365c17    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e900f0: aa0003f9    	mov	x25, x0
106e900f4: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e900f8: f9471100    	ldr	x0, [x8, #0xe20]
106e900fc: b00c7d68    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
106e90100: f9459901    	ldr	x1, [x8, #0xb30] ; getCurUsrName
106e90104: 94365c0e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90108: aa1d03fd    	mov	x29, x29
106e9010c: 94365c0f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106e90110: aa0003fa    	mov	x26, x0
106e90114: f00c9388    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106e90118: f943c901    	ldr	x1, [x8, #0x790] ; isEqualToString:
106e9011c: aa1903e0    	mov	x0, x25
106e90120: aa1a03e2    	mov	x2, x26
106e90124: 94365c06    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90128: aa0003f8    	mov	x24, x0
106e9012c: aa1a03e0    	mov	x0, x26
106e90130: 94365c09    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e90134: aa1903e0    	mov	x0, x25
106e90138: 94365c07    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9013c: b00c8b68    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
106e90140: f9475901    	ldr	x1, [x8, #0xeb0] ; bForbideComment
106e90144: aa1403e0    	mov	x0, x20
106e90148: 94365bfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e9014c: 37000078    	tbnz	w24, #0x0, 0x106e90158 <_Flutter_MMFoundation_BindContext+0x336bd3c>
106e90150: b5000055    	cbnz	x21, 0x106e90158 <_Flutter_MMFoundation_BindContext+0x336bd3c>
106e90154: 35000680    	cbnz	w0, 0x106e90224 <_Flutter_MMFoundation_BindContext+0x336be08>
106e90158: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e9015c: b984e908    	ldrsw	x8, [x8, #0x4e8]
106e90160: f8686a80    	ldr	x0, [x20, x8]
106e90164: 900c81a8    	adrp	x8, 0x11fec4000 <dyld_stub_binder+0x11fec4000>
106e90168: f945c101    	ldr	x1, [x8, #0xb80] ; eInputMode
106e9016c: 94365bf4    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90170: b4000300    	cbz	x0, 0x106e901d0 <_Flutter_MMFoundation_BindContext+0x336bdb4>
106e90174: f00c83a8    	adrp	x8, 0x11ff07000 <dyld_stub_binder+0x11ff07000>
106e90178: f9463d01    	ldr	x1, [x8, #0xc78] ; resignInput
106e9017c: aa1403e0    	mov	x0, x20
106e90180: 94365bef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90184: 14000028    	b	0x106e90224 <_Flutter_MMFoundation_BindContext+0x336be08>
106e90188: f00c9708    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106e9018c: f9453500    	ldr	x0, [x8, #0xa68]
106e90190: b00c7d48    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
106e90194: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
106e90198: 900bd2e8    	adrp	x8, 0x11e8ec000 <dyld_stub_binder+0x11e8ec000>
106e9019c: 9134a108    	add	x8, x8, #0xd28
106e901a0: f90003e8    	str	x8, [sp]
106e901a4: 900a1c63    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
106e901a8: 912b2863    	add	x3, x3, #0xaca
106e901ac: 900a5ea5    	adrp	x5, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e901b0: 910820a5    	add	x5, x5, #0x208
106e901b4: 900a5ea7    	adrp	x7, 0x11ba64000 <dyld_stub_binder+0x11ba64000>
106e901b8: 913f40e7    	add	x7, x7, #0xfd0
106e901bc: 52800082    	mov	w2, #0x4                ; =4
106e901c0: 52800004    	mov	w4, #0x0                ; =0
106e901c4: 52823246    	mov	w6, #0x1192             ; =4498
106e901c8: 94365bdd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e901cc: 14000018    	b	0x106e9022c <_Flutter_MMFoundation_BindContext+0x336be10>
106e901d0: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e901d4: b9846508    	ldrsw	x8, [x8, #0x464]
106e901d8: 38286a9f    	strb	wzr, [x20, x8]
106e901dc: b00c9da8    	adrp	x8, 0x120245000 <dyld_stub_binder+0x120245000>
106e901e0: b984fd08    	ldrsw	x8, [x8, #0x4fc]
106e901e4: f8686a80    	ldr	x0, [x20, x8]
106e901e8: f8286a9f    	str	xzr, [x20, x8]
106e901ec: 94365bda    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e901f0: f10002bf    	cmp	x21, #0x0
106e901f4: 1a9f17e5    	cset	w5, eq
106e901f8: 34000098    	cbz	w24, 0x106e90208 <_Flutter_MMFoundation_BindContext+0x336bdec>
106e901fc: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e90200: f9447901    	ldr	x1, [x8, #0x8f0] ; onClickSelfComment:comment:index:confirmDelete:
106e90204: 14000003    	b	0x106e90210 <_Flutter_MMFoundation_BindContext+0x336bdf4>
106e90208: d00c8b68    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
106e9020c: f9447d01    	ldr	x1, [x8, #0x8f8] ; onClickFriendsComment:comment:index:replay:
106e90210: aa1403e0    	mov	x0, x20
106e90214: aa1303e2    	mov	x2, x19
106e90218: aa1703e3    	mov	x3, x23
106e9021c: aa1603e4    	mov	x4, x22
106e90220: 94365bc7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106e90224: aa1703e0    	mov	x0, x23
106e90228: 94365bcb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106e9022c: aa1303e0    	mov	x0, x19
106e90230: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106e90234: a9444ff4    	ldp	x20, x19, [sp, #0x40]
106e90238: a94357f6    	ldp	x22, x21, [sp, #0x30]
106e9023c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
106e90240: a94167fa    	ldp	x26, x25, [sp, #0x10]
106e90244: 910183ff    	add	sp, sp, #0x60
106e90248: 14365bc3    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
