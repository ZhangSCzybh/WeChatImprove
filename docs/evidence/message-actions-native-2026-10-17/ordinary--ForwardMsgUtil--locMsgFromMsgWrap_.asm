
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c4df18: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101c4df1c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101c4df20: a9027bfd    	stp	x29, x30, [sp, #0x20]
101c4df24: 910083fd    	add	x29, sp, #0x20
101c4df28: d00f7f28    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c4df2c: 52800029    	mov	w9, #0x1                ; =1
101c4df30: 39273509    	strb	w9, [x8, #0x9cd]
101c4df34: b00f2948    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
101c4df38: f9422d00    	ldr	x0, [x8, #0x458]
101c4df3c: 900f1388    	adrp	x8, 0x11febd000 <dyld_stub_binder+0x11febd000>
101c4df40: f9438d01    	ldr	x1, [x8, #0x718] ; locationMsgWrapFromMsgWrap:
101c4df44: 957f647e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4df48: aa1d03fd    	mov	x29, x29
101c4df4c: 957f647f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4df50: aa0003f3    	mov	x19, x0
101c4df54: d00f2928    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c4df58: f9471100    	ldr	x0, [x8, #0xe20]
101c4df5c: 900f0f88    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
101c4df60: f947e901    	ldr	x1, [x8, #0xfd0] ; getLocalUsrName:
101c4df64: 52800002    	mov	w2, #0x0                ; =0
101c4df68: 957f6475    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4df6c: aa1d03fd    	mov	x29, x29
101c4df70: 957f6476    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4df74: aa0003f4    	mov	x20, x0
101c4df78: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4df7c: f9453101    	ldr	x1, [x8, #0xa60] ; setM_nsFromUsr:
101c4df80: aa1303e0    	mov	x0, x19
101c4df84: aa1403e2    	mov	x2, x20
101c4df88: 957f646d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4df8c: aa1403e0    	mov	x0, x20
101c4df90: 957f6471    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4df94: d00f2928    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c4df98: f945e900    	ldr	x0, [x8, #0xbd0]
101c4df9c: f00f2588    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c4dfa0: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101c4dfa4: 957f6466    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dfa8: aa1d03fd    	mov	x29, x29
101c4dfac: 957f6467    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4dfb0: aa0003f4    	mov	x20, x0
101c4dfb4: f00f2928    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101c4dfb8: f9401d00    	ldr	x0, [x8, #0x38]
101c4dfbc: d00f2588    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c4dfc0: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101c4dfc4: 957f645e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dfc8: aa0003e2    	mov	x2, x0
101c4dfcc: 900f0f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c4dfd0: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101c4dfd4: aa1403e0    	mov	x0, x20
101c4dfd8: 957f6459    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dfdc: aa1d03fd    	mov	x29, x29
101c4dfe0: 957f645a    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4dfe4: aa0003f5    	mov	x21, x0
101c4dfe8: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4dfec: f9454501    	ldr	x1, [x8, #0xa88] ; GenSendMsgTime
101c4dff0: 957f6453    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dff4: aa0003e2    	mov	x2, x0
101c4dff8: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4dffc: f9454901    	ldr	x1, [x8, #0xa90] ; setM_uiCreateTime:
101c4e000: aa1303e0    	mov	x0, x19
101c4e004: 957f644e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4e008: aa1503e0    	mov	x0, x21
101c4e00c: 957f6452    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4e010: aa1403e0    	mov	x0, x20
101c4e014: 957f6450    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4e018: d00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4e01c: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
101c4e020: aa1303e0    	mov	x0, x19
101c4e024: 52800022    	mov	w2, #0x1                ; =1
101c4e028: 957f6445    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4e02c: b00f0fe8    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
101c4e030: f9438901    	ldr	x1, [x8, #0x710] ; setM_uiImgStatus:
101c4e034: aa1303e0    	mov	x0, x19
101c4e038: 52800022    	mov	w2, #0x1                ; =1
101c4e03c: 957f6440    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4e040: b00f0f88    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
101c4e044: f9467101    	ldr	x1, [x8, #0xce0] ; UpdateContent:
101c4e048: aa1303e0    	mov	x0, x19
101c4e04c: d2800002    	mov	x2, #0x0                ; =0
101c4e050: 957f643b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4e054: aa1303e0    	mov	x0, x19
101c4e058: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101c4e05c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101c4e060: a8c357f6    	ldp	x22, x21, [sp], #0x30
101c4e064: 157f6443    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>