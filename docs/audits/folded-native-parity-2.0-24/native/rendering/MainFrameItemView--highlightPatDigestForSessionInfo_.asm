
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a98070: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
104a98074: a9014ff4    	stp	x20, x19, [sp, #0x10]
104a98078: a9027bfd    	stp	x29, x30, [sp, #0x20]
104a9807c: 910083fd    	add	x29, sp, #0x20
104a98080: aa0203f3    	mov	x19, x2
104a98084: d00e0d28    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a98088: 52800029    	mov	w9, #0x1                ; =1
104a9808c: 390cb509    	strb	w9, [x8, #0x32d]
104a98090: aa0203e0    	mov	x0, x2
104a98094: 94c63c29    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104a98098: f00db708    	adrp	x8, 0x12017b000 <dyld_stub_binder+0x12017b000>
104a9809c: f941fd14    	ldr	x20, [x8, #0x3f8] ; ChatBoxUtil
104a980a0: 900d9d68    	adrp	x8, 0x11fe44000 <dyld_stub_binder+0x11fe44000>
104a980a4: f947d901    	ldr	x1, [x8, #0xfb0] ; m_nsUserName
104a980a8: aa1303e0    	mov	x0, x19
104a980ac: 94c63c24    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a980b0: aa1d03fd    	mov	x29, x29
104a980b4: 94c63c25    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a980b8: aa0003f5    	mov	x21, x0
104a980bc: 900d9f48    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
104a980c0: f9437901    	ldr	x1, [x8, #0x6f0] ; isChatBox:
104a980c4: aa1403e0    	mov	x0, x20
104a980c8: aa1503e2    	mov	x2, x21
104a980cc: 94c63c1c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a980d0: aa0003f4    	mov	x20, x0
104a980d4: aa1503e0    	mov	x0, x21
104a980d8: 94c63c1f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a980dc: 36000074    	tbz	w20, #0x0, 0x104a980e8 <_Flutter_MMFoundation_BindContext+0xf73ccc>
104a980e0: d2800016    	mov	x22, #0x0               ; =0
104a980e4: 14000038    	b	0x104a981c4 <_Flutter_MMFoundation_BindContext+0xf73da8>
104a980e8: b00d9d68    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
104a980ec: f944c501    	ldr	x1, [x8, #0x988] ; m_msgWrap
104a980f0: aa1303e0    	mov	x0, x19
104a980f4: 94c63c12    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a980f8: aa1d03fd    	mov	x29, x29
104a980fc: 94c63c13    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a98100: aa0003f4    	mov	x20, x0
104a98104: d00d9d28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104a98108: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
104a9810c: 94c63c0c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a98110: 7100c41f    	cmp	w0, #0x31
104a98114: 540004a1    	b.ne	0x104a981a8 <_Flutter_MMFoundation_BindContext+0xf73d8c>
104a98118: d00d9d28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
104a9811c: f9414115    	ldr	x21, [x8, #0x280] ; m_uiAppMsgInnerType
104a98120: aa1403e0    	mov	x0, x20
104a98124: aa1503e1    	mov	x1, x21
104a98128: 94c63c05    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9812c: 350000a0    	cbnz	w0, 0x104a98140 <_Flutter_MMFoundation_BindContext+0xf73d24>
104a98130: f00d9d28    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
104a98134: f9465501    	ldr	x1, [x8, #0xca8] ; ChangeForDisplay
104a98138: aa1403e0    	mov	x0, x20
104a9813c: 94c63c00    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a98140: aa1403e0    	mov	x0, x20
104a98144: aa1503e1    	mov	x1, x21
104a98148: 94c63bfd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a9814c: 7100f81f    	cmp	w0, #0x3e
104a98150: 540002c1    	b.ne	0x104a981a8 <_Flutter_MMFoundation_BindContext+0xf73d8c>
104a98154: 900d9d48    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a98158: f945d501    	ldr	x1, [x8, #0xba8] ; patMessageWrap
104a9815c: aa1403e0    	mov	x0, x20
104a98160: 94c63bf7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a98164: aa1d03fd    	mov	x29, x29
104a98168: 94c63bf8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a9816c: aa0003f5    	mov	x21, x0
104a98170: b4000200    	cbz	x0, 0x104a981b0 <_Flutter_MMFoundation_BindContext+0xf73d94>
104a98174: 900da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a98178: f9448101    	ldr	x1, [x8, #0x900] ; shouldHighlightDigest
104a9817c: aa1503e0    	mov	x0, x21
104a98180: 94c63bef    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a98184: 34000160    	cbz	w0, 0x104a981b0 <_Flutter_MMFoundation_BindContext+0xf73d94>
104a98188: 900da768    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a9818c: f9448501    	ldr	x1, [x8, #0x908] ; highlightDigest
104a98190: aa1503e0    	mov	x0, x21
104a98194: 94c63bea    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a98198: aa1d03fd    	mov	x29, x29
104a9819c: 94c63beb    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a981a0: aa0003f6    	mov	x22, x0
104a981a4: 14000004    	b	0x104a981b4 <_Flutter_MMFoundation_BindContext+0xf73d98>
104a981a8: d2800016    	mov	x22, #0x0               ; =0
104a981ac: 14000004    	b	0x104a981bc <_Flutter_MMFoundation_BindContext+0xf73da0>
104a981b0: d2800016    	mov	x22, #0x0               ; =0
104a981b4: aa1503e0    	mov	x0, x21
104a981b8: 94c63be7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a981bc: aa1403e0    	mov	x0, x20
104a981c0: 94c63be5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a981c4: aa1303e0    	mov	x0, x19
104a981c8: 94c63be3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a981cc: aa1603e0    	mov	x0, x22
104a981d0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
104a981d4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
104a981d8: a8c357f6    	ldp	x22, x21, [sp], #0x30
104a981dc: 14c63be5    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
