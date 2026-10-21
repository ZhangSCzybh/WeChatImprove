
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104b3ea18: d10103ff    	sub	sp, sp, #0x40
104b3ea1c: a90157f6    	stp	x22, x21, [sp, #0x10]
104b3ea20: a9024ff4    	stp	x20, x19, [sp, #0x20]
104b3ea24: a9037bfd    	stp	x29, x30, [sp, #0x30]
104b3ea28: 9100c3fd    	add	x29, sp, #0x30
104b3ea2c: aa0203f3    	mov	x19, x2
104b3ea30: aa0003f4    	mov	x20, x0
104b3ea34: b00db1a8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104b3ea38: f9453515    	ldr	x21, [x8, #0xa68]
104b3ea3c: f00d97c8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
104b3ea40: f942a916    	ldr	x22, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
104b3ea44: aa0203e0    	mov	x0, x2
104b3ea48: 94c3a1bc    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
104b3ea4c: f00ce328    	adrp	x8, 0x11e7a5000 <dyld_stub_binder+0x11e7a5000>
104b3ea50: 91112108    	add	x8, x8, #0x448
104b3ea54: a9004fe8    	stp	x8, x19, [sp]
104b3ea58: f00b3723    	adrp	x3, 0x11b225000 <dyld_stub_binder+0x11b225000>
104b3ea5c: 9107f063    	add	x3, x3, #0x1fc
104b3ea60: d00b65e5    	adrp	x5, 0x11b7fc000 <dyld_stub_binder+0x11b7fc000>
104b3ea64: 910cb4a5    	add	x5, x5, #0x32d
104b3ea68: 900b6607    	adrp	x7, 0x11b7fe000 <dyld_stub_binder+0x11b7fe000>
104b3ea6c: 911e4ce7    	add	x7, x7, #0x793
104b3ea70: aa1503e0    	mov	x0, x21
104b3ea74: aa1603e1    	mov	x1, x22
104b3ea78: 52800022    	mov	w2, #0x1                ; =1
104b3ea7c: 52800004    	mov	w4, #0x0                ; =0
104b3ea80: 52820046    	mov	w6, #0x1002             ; =4098
104b3ea84: 94c3a1ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ea88: f00d97e8    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
104b3ea8c: f9479d01    	ldr	x1, [x8, #0xf38] ; GetChatName
104b3ea90: aa1303e0    	mov	x0, x19
104b3ea94: 94c3a1aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3ea98: aa1d03fd    	mov	x29, x29
104b3ea9c: 94c3a1ab    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104b3eaa0: aa0003f5    	mov	x21, x0
104b3eaa4: b00d9828    	adrp	x8, 0x11fe43000 <dyld_stub_binder+0x11fe43000>
104b3eaa8: f9464d01    	ldr	x1, [x8, #0xc98] ; AsyncOnModMsg:MsgWrap:
104b3eaac: aa1403e0    	mov	x0, x20
104b3eab0: aa1503e2    	mov	x2, x21
104b3eab4: aa1303e3    	mov	x3, x19
104b3eab8: 94c3a1a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104b3eabc: aa1303e0    	mov	x0, x19
104b3eac0: 94c3a1a5    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104b3eac4: aa1503e0    	mov	x0, x21
104b3eac8: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104b3eacc: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104b3ead0: a94157f6    	ldp	x22, x21, [sp, #0x10]
104b3ead4: 910103ff    	add	sp, sp, #0x40
104b3ead8: 14c3a19f    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
