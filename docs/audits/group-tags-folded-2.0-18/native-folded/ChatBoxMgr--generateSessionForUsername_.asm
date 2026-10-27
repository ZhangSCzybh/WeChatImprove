
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100e48f5c: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
100e48f60: a9015ff8    	stp	x24, x23, [sp, #0x10]
100e48f64: a90257f6    	stp	x22, x21, [sp, #0x20]
100e48f68: a9034ff4    	stp	x20, x19, [sp, #0x30]
100e48f6c: a9047bfd    	stp	x29, x30, [sp, #0x40]
100e48f70: 910103fd    	add	x29, sp, #0x40
100e48f74: aa0203f3    	mov	x19, x2
100e48f78: 900fef48    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
100e48f7c: 52800029    	mov	w9, #0x1                ; =1
100e48f80: 39187909    	strb	w9, [x8, #0x61e]
100e48f84: aa0203e0    	mov	x0, x2
100e48f88: 95b7786c    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100e48f8c: f00f995a    	adrp	x26, 0x120173000 <dyld_stub_binder+0x120173000>
100e48f90: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
100e48f94: 900f95c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100e48f98: f944e915    	ldr	x21, [x8, #0x9d0] ; currentContext
100e48f9c: aa1503e1    	mov	x1, x21
100e48fa0: 95b77867    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48fa4: aa1d03fd    	mov	x29, x29
100e48fa8: 95b77868    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48fac: aa0003f8    	mov	x24, x0
100e48fb0: 900f9968    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e48fb4: f9401d00    	ldr	x0, [x8, #0x38] ; MMNewSessionMgr
100e48fb8: f00f95a8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100e48fbc: f947ad16    	ldr	x22, [x8, #0xf58] ; class
100e48fc0: aa1603e1    	mov	x1, x22
100e48fc4: 95b7785e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48fc8: aa0003e2    	mov	x2, x0
100e48fcc: b00f7f88    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100e48fd0: f9464117    	ldr	x23, [x8, #0xc80] ; getService:
100e48fd4: aa1803e0    	mov	x0, x24
100e48fd8: aa1703e1    	mov	x1, x23
100e48fdc: 95b77858    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48fe0: aa1d03fd    	mov	x29, x29
100e48fe4: 95b77859    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e48fe8: aa0003f9    	mov	x25, x0
100e48fec: 900f81c8    	adrp	x8, 0x11fe80000 <dyld_stub_binder+0x11fe80000>
100e48ff0: f943a501    	ldr	x1, [x8, #0x748] ; genSessionInfoByUserName:
100e48ff4: aa1303e2    	mov	x2, x19
100e48ff8: 95b77851    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e48ffc: aa1d03fd    	mov	x29, x29
100e49000: 95b77852    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49004: aa0003f4    	mov	x20, x0
100e49008: aa1903e0    	mov	x0, x25
100e4900c: 95b77852    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49010: aa1803e0    	mov	x0, x24
100e49014: 95b77850    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49018: b50008f4    	cbnz	x20, 0x100e49134 <__text+0xe41134>
100e4901c: 900f9968    	adrp	x8, 0x120175000 <dyld_stub_binder+0x120175000>
100e49020: f9458100    	ldr	x0, [x8, #0xb00] ; MMSessionInfo
100e49024: 95b7784d    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100e49028: aa0003f4    	mov	x20, x0
100e4902c: f945eb40    	ldr	x0, [x26, #0xbd0] ; MMContext
100e49030: aa1503e1    	mov	x1, x21
100e49034: 95b77842    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49038: aa1d03fd    	mov	x29, x29
100e4903c: 95b77843    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49040: aa0003f5    	mov	x21, x0
100e49044: f00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e49048: f9401500    	ldr	x0, [x8, #0x28] ; CContactMgr
100e4904c: aa1603e1    	mov	x1, x22
100e49050: 95b7783b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49054: aa0003e2    	mov	x2, x0
100e49058: aa1503e0    	mov	x0, x21
100e4905c: aa1703e1    	mov	x1, x23
100e49060: 95b77837    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49064: aa1d03fd    	mov	x29, x29
100e49068: 95b77838    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e4906c: aa0003f6    	mov	x22, x0
100e49070: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e49074: f940c901    	ldr	x1, [x8, #0x190] ; getContactByName:
100e49078: aa1303e2    	mov	x2, x19
100e4907c: 95b77830    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49080: aa1d03fd    	mov	x29, x29
100e49084: 95b77831    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100e49088: aa0003f7    	mov	x23, x0
100e4908c: d00f7f88    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100e49090: f946dd01    	ldr	x1, [x8, #0xdb8] ; setM_contact:
100e49094: aa1403e0    	mov	x0, x20
100e49098: aa1703e2    	mov	x2, x23
100e4909c: 95b77828    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e490a0: aa1703e0    	mov	x0, x23
100e490a4: 95b7782c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e490a8: aa1603e0    	mov	x0, x22
100e490ac: 95b7782a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e490b0: aa1503e0    	mov	x0, x21
100e490b4: 95b77828    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e490b8: f00f9948    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100e490bc: f9411d00    	ldr	x0, [x8, #0x238] ; CMessageWrap
100e490c0: 95b77828    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100e490c4: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e490c8: f9452d01    	ldr	x1, [x8, #0xa58] ; initWithMsgType:
100e490cc: 52800022    	mov	w2, #0x1                ; =1
100e490d0: 95b7781b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e490d4: aa0003f5    	mov	x21, x0
100e490d8: d00f9948    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100e490dc: f9467900    	ldr	x0, [x8, #0xcf0] ; CUtility
100e490e0: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e490e4: f9403501    	ldr	x1, [x8, #0x68] ; genServerCurrentTime
100e490e8: 95b77815    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e490ec: aa0003e2    	mov	x2, x0
100e490f0: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e490f4: f9454901    	ldr	x1, [x8, #0xa90] ; setM_uiCreateTime:
100e490f8: aa1503e0    	mov	x0, x21
100e490fc: 95b77810    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49100: f00f7f88    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100e49104: f9453d01    	ldr	x1, [x8, #0xa78] ; setM_nsContent:
100e49108: d00eb282    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100e4910c: 91032042    	add	x2, x2, #0xc8 ; CFString ''
100e49110: aa1503e0    	mov	x0, x21
100e49114: 95b7780a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e49118: b00f7fe8    	adrp	x8, 0x11fe46000 <dyld_stub_binder+0x11fe46000>
100e4911c: f942f901    	ldr	x1, [x8, #0x5f0] ; setM_msgWrap:
100e49120: aa1403e0    	mov	x0, x20
100e49124: aa1503e2    	mov	x2, x21
100e49128: 95b77805    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100e4912c: aa1503e0    	mov	x0, x21
100e49130: 95b77809    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e49134: aa1303e0    	mov	x0, x19
100e49138: 95b77807    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100e4913c: aa1403e0    	mov	x0, x20
100e49140: a9447bfd    	ldp	x29, x30, [sp, #0x40]
100e49144: a9434ff4    	ldp	x20, x19, [sp, #0x30]
100e49148: a94257f6    	ldp	x22, x21, [sp, #0x20]
100e4914c: a9415ff8    	ldp	x24, x23, [sp, #0x10]
100e49150: a8c567fa    	ldp	x26, x25, [sp], #0x50
100e49154: 15b77807    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>
