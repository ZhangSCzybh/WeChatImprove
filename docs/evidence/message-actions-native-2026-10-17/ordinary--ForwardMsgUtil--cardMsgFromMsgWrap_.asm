
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
101c4dd88: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
101c4dd8c: a9014ff4    	stp	x20, x19, [sp, #0x10]
101c4dd90: a9027bfd    	stp	x29, x30, [sp, #0x20]
101c4dd94: 910083fd    	add	x29, sp, #0x20
101c4dd98: aa0203f3    	mov	x19, x2
101c4dd9c: d00f7f28    	adrp	x8, 0x120c33000 <dyld_stub_binder+0x120c33000>
101c4dda0: 52800029    	mov	w9, #0x1                ; =1
101c4dda4: 39273109    	strb	w9, [x8, #0x9cc]
101c4dda8: f00f2928    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101c4ddac: f9411d14    	ldr	x20, [x8, #0x238]
101c4ddb0: aa0203e0    	mov	x0, x2
101c4ddb4: 957f64e1    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
101c4ddb8: aa1403e0    	mov	x0, x20
101c4ddbc: 957f64e9    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
101c4ddc0: aa0003f4    	mov	x20, x0
101c4ddc4: b00f0f88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101c4ddc8: f9413d01    	ldr	x1, [x8, #0x278] ; m_uiMessageType
101c4ddcc: aa1303e0    	mov	x0, x19
101c4ddd0: 957f64db    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4ddd4: 2a0003e2    	mov	w2, w0
101c4ddd8: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4dddc: f9452d01    	ldr	x1, [x8, #0xa58] ; initWithMsgType:
101c4dde0: aa1403e0    	mov	x0, x20
101c4dde4: 957f64d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dde8: aa0003f4    	mov	x20, x0
101c4ddec: d00f2928    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c4ddf0: f9471100    	ldr	x0, [x8, #0xe20]
101c4ddf4: 900f0f88    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
101c4ddf8: f947e901    	ldr	x1, [x8, #0xfd0] ; getLocalUsrName:
101c4ddfc: 52800002    	mov	w2, #0x0                ; =0
101c4de00: 957f64cf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4de04: aa1d03fd    	mov	x29, x29
101c4de08: 957f64d0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4de0c: aa0003f5    	mov	x21, x0
101c4de10: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4de14: f9453101    	ldr	x1, [x8, #0xa60] ; setM_nsFromUsr:
101c4de18: aa1403e0    	mov	x0, x20
101c4de1c: aa1503e2    	mov	x2, x21
101c4de20: 957f64c7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4de24: aa1503e0    	mov	x0, x21
101c4de28: 957f64cb    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4de2c: d00f2928    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
101c4de30: f945e900    	ldr	x0, [x8, #0xbd0]
101c4de34: f00f2588    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
101c4de38: f944e901    	ldr	x1, [x8, #0x9d0] ; currentContext
101c4de3c: 957f64c0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4de40: aa1d03fd    	mov	x29, x29
101c4de44: 957f64c1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4de48: aa0003f5    	mov	x21, x0
101c4de4c: f00f2928    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
101c4de50: f9401d00    	ldr	x0, [x8, #0x38]
101c4de54: d00f2588    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
101c4de58: f947ad01    	ldr	x1, [x8, #0xf58] ; class
101c4de5c: 957f64b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4de60: aa0003e2    	mov	x2, x0
101c4de64: 900f0f68    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
101c4de68: f9464101    	ldr	x1, [x8, #0xc80] ; getService:
101c4de6c: aa1503e0    	mov	x0, x21
101c4de70: 957f64b3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4de74: aa1d03fd    	mov	x29, x29
101c4de78: 957f64b4    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4de7c: aa0003f6    	mov	x22, x0
101c4de80: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4de84: f9454501    	ldr	x1, [x8, #0xa88] ; GenSendMsgTime
101c4de88: 957f64ad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4de8c: aa0003e2    	mov	x2, x0
101c4de90: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4de94: f9454901    	ldr	x1, [x8, #0xa90] ; setM_uiCreateTime:
101c4de98: aa1403e0    	mov	x0, x20
101c4de9c: 957f64a8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dea0: aa1603e0    	mov	x0, x22
101c4dea4: 957f64ac    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4dea8: aa1503e0    	mov	x0, x21
101c4deac: 957f64aa    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4deb0: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4deb4: f9454101    	ldr	x1, [x8, #0xa80] ; setM_uiStatus:
101c4deb8: aa1403e0    	mov	x0, x20
101c4debc: 52800022    	mov	w2, #0x1                ; =1
101c4dec0: 957f649f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4dec4: b00f0f88    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
101c4dec8: f9417101    	ldr	x1, [x8, #0x2e0] ; m_nsContent
101c4decc: aa1303e0    	mov	x0, x19
101c4ded0: 957f649b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4ded4: aa1d03fd    	mov	x29, x29
101c4ded8: 957f649c    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
101c4dedc: aa0003f5    	mov	x21, x0
101c4dee0: aa1303e0    	mov	x0, x19
101c4dee4: 957f649c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4dee8: f00f0f68    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
101c4deec: f9453d01    	ldr	x1, [x8, #0xa78] ; setM_nsContent:
101c4def0: aa1403e0    	mov	x0, x20
101c4def4: aa1503e2    	mov	x2, x21
101c4def8: 957f6491    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
101c4defc: aa1503e0    	mov	x0, x21
101c4df00: 957f6495    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
101c4df04: aa1403e0    	mov	x0, x20
101c4df08: a9427bfd    	ldp	x29, x30, [sp, #0x20]
101c4df0c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
101c4df10: a8c357f6    	ldp	x22, x21, [sp], #0x30
101c4df14: 157f6497    	b	0x107c27170 <_Flutter_MMFoundation_BindContext+0x4102d54>