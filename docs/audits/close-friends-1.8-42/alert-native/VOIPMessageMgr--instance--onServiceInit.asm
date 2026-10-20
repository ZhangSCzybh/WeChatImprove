
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
105f7dfdc: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105f7dfe0: a9014ff4    	stp	x20, x19, [sp, #0x10]
105f7dfe4: a9027bfd    	stp	x29, x30, [sp, #0x20]
105f7dfe8: 910083fd    	add	x29, sp, #0x20
105f7dfec: aa0003f3    	mov	x19, x0
105f7dff0: d00d1088    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
105f7dff4: f9473500    	ldr	x0, [x8, #0xe68] ; class=MonoServiceMsgLogic
105f7dff8: 9472a458    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
105f7dffc: aa0003f4    	mov	x20, x0
105f7e000: f00cf5c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f7e004: f946d101    	ldr	x1, [x8, #0xda0] ; selector=setM_delegate:
105f7e008: aa1303e2    	mov	x2, x19
105f7e00c: 9472a44c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7e010: b00d0fa8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
105f7e014: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
105f7e018: d00d0c08    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
105f7e01c: f944e901    	ldr	x1, [x8, #0x9d0] ; selector=currentContext
105f7e020: 9472a447    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7e024: aa1d03fd    	mov	x29, x29
105f7e028: 9472a448    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f7e02c: aa0003f3    	mov	x19, x0
105f7e030: b00d1088    	adrp	x8, 0x12018f000 <dyld_stub_binder+0x12018f000>
105f7e034: f9473900    	ldr	x0, [x8, #0xe70] ; class=MonoServiceMsgMgr
105f7e038: b00d0c08    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
105f7e03c: f947ad01    	ldr	x1, [x8, #0xf58] ; selector=class
105f7e040: 9472a43f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7e044: aa0003e2    	mov	x2, x0
105f7e048: f00cf5c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
105f7e04c: f9464101    	ldr	x1, [x8, #0xc80] ; selector=getService:
105f7e050: aa1303e0    	mov	x0, x19
105f7e054: 9472a43a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7e058: aa1d03fd    	mov	x29, x29
105f7e05c: 9472a43b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
105f7e060: aa0003f5    	mov	x21, x0
105f7e064: b00cff48    	adrp	x8, 0x11ff67000 <dyld_stub_binder+0x11ff67000>
105f7e068: f945d101    	ldr	x1, [x8, #0xba0] ; selector=addMsgLogic:
105f7e06c: aa1403e2    	mov	x2, x20
105f7e070: 9472a433    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
105f7e074: aa1503e0    	mov	x0, x21
105f7e078: 9472a437    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f7e07c: aa1303e0    	mov	x0, x19
105f7e080: 9472a435    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
105f7e084: aa1403e0    	mov	x0, x20
105f7e088: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105f7e08c: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105f7e090: a8c357f6    	ldp	x22, x21, [sp], #0x30
105f7e094: 1472a430    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
