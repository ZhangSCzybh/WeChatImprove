
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000101bf3150 <_Flutter_Image_provideRelativePathByUrl>:
10299d148: d10083ff    	sub	sp, sp, #0x20
10299d14c: a9017bfd    	stp	x29, x30, [sp, #0x10]
10299d150: 910043fd    	add	x29, sp, #0x10
10299d154: d00ec108    	adrp	x8, 0x1201bf000 <dyld_stub_binder+0x1201bf000>
10299d158: f9443508    	ldr	x8, [x8, #0x868]
10299d15c: a90023e0    	stp	x0, x8, [sp]
10299d160: b00ebb28    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10299d164: f9466901    	ldr	x1, [x8, #0xcd0] ; init
10299d168: 910003e0    	mov	x0, sp
10299d16c: 954a27f6    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
10299d170: b4000100    	cbz	x0, 0x10299d190 <_Flutter_Image_provideRelativePathByUrl+0xdaa040>
10299d174: f900141f    	str	xzr, [x0, #0x28]
10299d178: f900081f    	str	xzr, [x0, #0x10]
10299d17c: 52800128    	mov	w8, #0x9                ; =9
10299d180: f9002408    	str	x8, [x0, #0x48]
10299d184: f00b1f28    	adrp	x8, 0x118d84000 <dyld_stub_binder+0x118d84000>
10299d188: fd454900    	ldr	d0, [x8, #0xa90]
10299d18c: fd000400    	str	d0, [x0, #0x8]
10299d190: a9417bfd    	ldp	x29, x30, [sp, #0x10]
10299d194: 910083ff    	add	sp, sp, #0x20
10299d198: d65f03c0    	ret
