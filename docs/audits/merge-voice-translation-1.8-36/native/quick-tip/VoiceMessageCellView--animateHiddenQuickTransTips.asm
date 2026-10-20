
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
1062795c8: d10183ff    	sub	sp, sp, #0x60
1062795cc: a90357f6    	stp	x22, x21, [sp, #0x30]
1062795d0: a9044ff4    	stp	x20, x19, [sp, #0x40]
1062795d4: a9057bfd    	stp	x29, x30, [sp, #0x50]
1062795d8: 910143fd    	add	x29, sp, #0x50
1062795dc: aa0003f3    	mov	x19, x0
1062795e0: d00d4e48    	adrp	x8, 0x120c43000 <dyld_stub_binder+0x120c43000>
1062795e4: 52800029    	mov	w9, #0x1                ; =1
1062795e8: 3927cd09    	strb	w9, [x8, #0x9f3]
1062795ec: f00cfde8    	adrp	x8, 0x120238000 <dyld_stub_binder+0x120238000>
1062795f0: b98d5516    	ldrsw	x22, [x8, #0xd54]
1062795f4: f8766800    	ldr	x0, [x0, x22]
1062795f8: b40007a0    	cbz	x0, 0x1062796ec <_Flutter_MMFoundation_BindContext+0x27552d0>
1062795fc: b00cf488    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
106279600: f9475d01    	ldr	x1, [x8, #0xeb8] ; superview
106279604: 9466b6ce    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279608: aa1d03fd    	mov	x29, x29
10627960c: 9466b6cf    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
106279610: aa0003f4    	mov	x20, x0
106279614: b40000e0    	cbz	x0, 0x106279630 <_Flutter_MMFoundation_BindContext+0x2755214>
106279618: f8766a60    	ldr	x0, [x19, x22]
10627961c: d00cf428    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
106279620: f9403501    	ldr	x1, [x8, #0x68] ; alpha
106279624: 9466b6c6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279628: 1e602008    	fcmp	d0, #0.0
10627962c: 540000e1    	b.ne	0x106279648 <_Flutter_MMFoundation_BindContext+0x275522c>
106279630: aa1403e0    	mov	x0, x20
106279634: a9457bfd    	ldp	x29, x30, [sp, #0x50]
106279638: a9444ff4    	ldp	x20, x19, [sp, #0x40]
10627963c: a94357f6    	ldp	x22, x21, [sp, #0x30]
106279640: 910183ff    	add	sp, sp, #0x60
106279644: 1466b6c4    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279648: f8766a60    	ldr	x0, [x19, x22]
10627964c: d00cf448    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
106279650: f943f901    	ldr	x1, [x8, #0x7f0] ; isHidden
106279654: 9466b6ba    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
106279658: aa0003f5    	mov	x21, x0
10627965c: aa1403e0    	mov	x0, x20
106279660: 9466b6bd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
106279664: 37000455    	tbnz	w21, #0x0, 0x1062796ec <_Flutter_MMFoundation_BindContext+0x27552d0>
106279668: f8766a61    	ldr	x1, [x19, x22]
10627966c: 9100a3e0    	add	x0, sp, #0x28
106279670: 9466b6bf    	bl	0x107c2716c <_Flutter_MMFoundation_BindContext+0x4102d50>
106279674: d00cf7c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
106279678: b00b9ba9    	adrp	x9, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10627967c: f947e129    	ldr	x9, [x9, #0xfc0]
106279680: f9474d13    	ldr	x19, [x8, #0xe98]
106279684: f90003e9    	str	x9, [sp]
106279688: 90095848    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10627968c: fd41c100    	ldr	d0, [x8, #0x380]
106279690: 90000008    	adrp	x8, 0x106279000 <_Flutter_MMFoundation_BindContext+0x2754be4>
106279694: 911c0108    	add	x8, x8, #0x700
106279698: fd0007e0    	str	d0, [sp, #0x8]
10627969c: b00b9be9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
1062796a0: 91150129    	add	x9, x9, #0x540
1062796a4: a90127e8    	stp	x8, x9, [sp, #0x10]
1062796a8: 910003f4    	mov	x20, sp
1062796ac: 91008280    	add	x0, x20, #0x20
1062796b0: 9100a3e1    	add	x1, sp, #0x28
1062796b4: 9466b6b1    	bl	0x107c27178 <_Flutter_MMFoundation_BindContext+0x4102d5c>
1062796b8: b00cde28    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
1062796bc: f9402d01    	ldr	x1, [x8, #0x58] ; animateWithDuration:animations:completion:
1062796c0: f00ba043    	adrp	x3, 0x11d684000 <dyld_stub_binder+0x11d684000>
1062796c4: 910b4063    	add	x3, x3, #0x2d0
1062796c8: 90095848    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
1062796cc: fd437100    	ldr	d0, [x8, #0x6e0]
1062796d0: 910003e2    	mov	x2, sp
1062796d4: aa1303e0    	mov	x0, x19
1062796d8: 9466b699    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1062796dc: 91008280    	add	x0, x20, #0x20
1062796e0: 9466b6ac    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1062796e4: 9100a3e0    	add	x0, sp, #0x28
1062796e8: 9466b6aa    	bl	0x107c27190 <_Flutter_MMFoundation_BindContext+0x4102d74>
1062796ec: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1062796f0: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1062796f4: a94357f6    	ldp	x22, x21, [sp, #0x30]
1062796f8: 910183ff    	add	sp, sp, #0x60
1062796fc: d65f03c0    	ret