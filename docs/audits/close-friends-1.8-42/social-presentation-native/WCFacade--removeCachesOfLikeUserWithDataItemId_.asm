
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1071231c8: d10143ff    	sub	sp, sp, #0x50
1071231cc: a9015ff8    	stp	x24, x23, [sp, #0x10]
1071231d0: a90257f6    	stp	x22, x21, [sp, #0x20]
1071231d4: a9034ff4    	stp	x20, x19, [sp, #0x30]
1071231d8: a9047bfd    	stp	x29, x30, [sp, #0x40]
1071231dc: 910103fd    	add	x29, sp, #0x40
1071231e0: aa0203f3    	mov	x19, x2
1071231e4: aa0003f4    	mov	x20, x0
1071231e8: f00cd908    	adrp	x8, 0x120c46000 <dyld_stub_binder+0x120c46000>
1071231ec: 52800029    	mov	w9, #0x1                ; =1
1071231f0: 393ffd09    	strb	w9, [x8, #0xfff]
1071231f4: aa0203e0    	mov	x0, x2
1071231f8: 942c0fd0    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1071231fc: b4000b53    	cbz	x19, 0x107123364 <_Flutter_MMFoundation_BindContext+0x35fef48>
107123200: 900c8928    	adrp	x8, 0x120247000 <dyld_stub_binder+0x120247000>
107123204: 9124e108    	add	x8, x8, #0x938
107123208: b9800117    	ldrsw	x23, [x8]
10712320c: f8776a80    	ldr	x0, [x20, x23]
107123210: b00c7f08    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
107123214: f947f101    	ldr	x1, [x8, #0xfe0] ; objectForKey:
107123218: aa1303e2    	mov	x2, x19
10712321c: 942c0fc8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123220: aa1d03fd    	mov	x29, x29
107123224: 942c0fc9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
107123228: aa0003f5    	mov	x21, x0
10712322c: b4000980    	cbz	x0, 0x10712335c <_Flutter_MMFoundation_BindContext+0x35fef40>
107123230: d00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
107123234: f946c101    	ldr	x1, [x8, #0xd80] ; likeUserHeight
107123238: aa1503e0    	mov	x0, x21
10712323c: 942c0fc0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123240: 940009ce    	bl	0x107125978 <_Flutter_MMFoundation_BindContext+0x360155c>
107123244: d00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
107123248: f946cd16    	ldr	x22, [x8, #0xd98] ; likeUserLayoutStyles
10712324c: aa1503e0    	mov	x0, x21
107123250: aa1603e1    	mov	x1, x22
107123254: 942c0fba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123258: f9400818    	ldr	x24, [x0, #0x10]
10712325c: aa1503e0    	mov	x0, x21
107123260: aa1603e1    	mov	x1, x22
107123264: 942c0fb6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123268: b40000d8    	cbz	x24, 0x107123280 <_Flutter_MMFoundation_BindContext+0x35fee64>
10712326c: f9400f00    	ldr	x0, [x24, #0x18]
107123270: f9000f1f    	str	xzr, [x24, #0x18]
107123274: 942c0fb8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107123278: f9400318    	ldr	x24, [x24]
10712327c: 17fffff8    	b	0x10712325c <_Flutter_MMFoundation_BindContext+0x35fee40>
107123280: aa1503e0    	mov	x0, x21
107123284: aa1603e1    	mov	x1, x22
107123288: 942c0fad    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10712328c: 96de5c23    	bl	0x1028ba318 <_Flutter_Image_provideRelativePathByUrl+0xcc71c8>
107123290: d00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
107123294: f946bd01    	ldr	x1, [x8, #0xd78] ; springLikeUserHeight
107123298: aa1503e0    	mov	x0, x21
10712329c: 942c0fa8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071232a0: 940009b6    	bl	0x107125978 <_Flutter_MMFoundation_BindContext+0x360155c>
1071232a4: d00c7708    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
1071232a8: f946c916    	ldr	x22, [x8, #0xd90] ; springLikeUserLayoutStyles
1071232ac: aa1503e0    	mov	x0, x21
1071232b0: aa1603e1    	mov	x1, x22
1071232b4: 942c0fa2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071232b8: f9400818    	ldr	x24, [x0, #0x10]
1071232bc: aa1503e0    	mov	x0, x21
1071232c0: aa1603e1    	mov	x1, x22
1071232c4: 942c0f9e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071232c8: b40000d8    	cbz	x24, 0x1071232e0 <_Flutter_MMFoundation_BindContext+0x35feec4>
1071232cc: f9400f00    	ldr	x0, [x24, #0x18]
1071232d0: f9000f1f    	str	xzr, [x24, #0x18]
1071232d4: 942c0fa0    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1071232d8: f9400318    	ldr	x24, [x24]
1071232dc: 17fffff8    	b	0x1071232bc <_Flutter_MMFoundation_BindContext+0x35feea0>
1071232e0: aa1503e0    	mov	x0, x21
1071232e4: aa1603e1    	mov	x1, x22
1071232e8: 942c0f95    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1071232ec: 96de5c0b    	bl	0x1028ba318 <_Flutter_Image_provideRelativePathByUrl+0xcc71c8>
1071232f0: 900c7f08    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1071232f4: f943bd01    	ldr	x1, [x8, #0x778] ; isEmpty
1071232f8: aa1503e0    	mov	x0, x21
1071232fc: 942c0f90    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123300: 360002e0    	tbz	w0, #0x0, 0x10712335c <_Flutter_MMFoundation_BindContext+0x35fef40>
107123304: 900c8288    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
107123308: f9453500    	ldr	x0, [x8, #0xa68]
10712330c: d00c68a8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
107123310: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
107123314: f00bbee8    	adrp	x8, 0x11e902000 <dyld_stub_binder+0x11e902000>
107123318: 91112108    	add	x8, x8, #0x448
10712331c: a9004fe8    	stp	x8, x19, [sp]
107123320: b00a07c3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
107123324: 912b2863    	add	x3, x3, #0xaca
107123328: b00a4b25    	adrp	x5, 0x11ba88000 <dyld_stub_binder+0x11ba88000>
10712332c: 913c50a5    	add	x5, x5, #0xf14
107123330: d00a4b27    	adrp	x7, 0x11ba89000 <dyld_stub_binder+0x11ba89000>
107123334: 91006ce7    	add	x7, x7, #0x1b
107123338: 52800042    	mov	w2, #0x2                ; =2
10712333c: 52800004    	mov	w4, #0x0                ; =0
107123340: 52805806    	mov	w6, #0x2c0              ; =704
107123344: 942c0f7e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
107123348: f8776a80    	ldr	x0, [x20, x23]
10712334c: 900c68c8    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
107123350: f9462101    	ldr	x1, [x8, #0xc40] ; safeRemoveObjectForKey:
107123354: aa1303e2    	mov	x2, x19
107123358: 942c0f79    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10712335c: aa1503e0    	mov	x0, x21
107123360: 942c0f7d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
107123364: aa1303e0    	mov	x0, x19
107123368: a9447bfd    	ldp	x29, x30, [sp, #0x40]
10712336c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
107123370: a94257f6    	ldp	x22, x21, [sp, #0x20]
107123374: a9415ff8    	ldp	x24, x23, [sp, #0x10]
107123378: 910143ff    	add	sp, sp, #0x50
10712337c: 142c0f76    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
