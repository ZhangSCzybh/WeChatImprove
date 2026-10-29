
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
104a6e8d8: d10143ff    	sub	sp, sp, #0x50
104a6e8dc: a9015ff8    	stp	x24, x23, [sp, #0x10]
104a6e8e0: a90257f6    	stp	x22, x21, [sp, #0x20]
104a6e8e4: a9034ff4    	stp	x20, x19, [sp, #0x30]
104a6e8e8: a9047bfd    	stp	x29, x30, [sp, #0x40]
104a6e8ec: 910103fd    	add	x29, sp, #0x40
104a6e8f0: 900e0e88    	adrp	x8, 0x120c3e000 <dyld_stub_binder+0x120c3e000>
104a6e8f4: 52800029    	mov	w9, #0x1                ; =1
104a6e8f8: 390abd09    	strb	w9, [x8, #0x2af]
104a6e8fc: f00dbaa8    	adrp	x8, 0x1201c5000 <dyld_stub_binder+0x1201c5000>
104a6e900: f9429908    	ldr	x8, [x8, #0x530]
104a6e904: a90023e0    	stp	x0, x8, [sp]
104a6e908: 900db4a8    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
104a6e90c: f9466901    	ldr	x1, [x8, #0xcd0] ; selector init
104a6e910: 910003e0    	mov	x0, sp
104a6e914: 94c6e20c    	bl	0x107c27144 <_Flutter_MMFoundation_BindContext+0x4102d28>
104a6e918: aa0003f3    	mov	x19, x0
104a6e91c: b40006a0    	cbz	x0, 0x104a6e9f0 <_Flutter_MMFoundation_BindContext+0xf4a5d4>
104a6e920: d00db828    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
104a6e924: f9434100    	ldr	x0, [x8, #0x680] ; class NSMutableSet
104a6e928: 900db4c8    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
104a6e92c: f9469d01    	ldr	x1, [x8, #0xd38] ; selector set
104a6e930: 94c6e203    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e934: aa1d03fd    	mov	x29, x29
104a6e938: 94c6e204    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6e93c: f9401a68    	ldr	x8, [x19, #0x30]
104a6e940: f9001a60    	str	x0, [x19, #0x30]
104a6e944: aa0803e0    	mov	x0, x8
104a6e948: 94c6e203    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6e94c: b00db828    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
104a6e950: f9467900    	ldr	x0, [x8, #0xcf0] ; class CUtility
104a6e954: d00d9e88    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
104a6e958: f942c501    	ldr	x1, [x8, #0x588] ; selector genCurrentTimeInMsFrom1970
104a6e95c: 94c6e1f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e960: f9000a60    	str	x0, [x19, #0x10]
104a6e964: d00da8a8    	adrp	x8, 0x11ff84000 <dyld_stub_binder+0x11ff84000>
104a6e968: f9405d01    	ldr	x1, [x8, #0xb8] ; selector rebuildSessionList
104a6e96c: aa1303e0    	mov	x0, x19
104a6e970: 94c6e1f3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e974: b00db837    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
104a6e978: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
104a6e97c: d00db488    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
104a6e980: f944e914    	ldr	x20, [x8, #0x9d0] ; selector currentContext
104a6e984: aa1403e1    	mov	x1, x20
104a6e988: 94c6e1ed    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e98c: aa1d03fd    	mov	x29, x29
104a6e990: 94c6e1ee    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6e994: aa0003f5    	mov	x21, x0
104a6e998: f00db808    	adrp	x8, 0x120171000 <dyld_stub_binder+0x120171000>
104a6e99c: f9401d02    	ldr	x2, [x8, #0x38]
104a6e9a0: 900d9e68    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
104a6e9a4: f940a116    	ldr	x22, [x8, #0x140] ; selector registerExtension:withTarget:
104a6e9a8: aa1603e1    	mov	x1, x22
104a6e9ac: aa1303e3    	mov	x3, x19
104a6e9b0: 94c6e1e3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e9b4: aa1503e0    	mov	x0, x21
104a6e9b8: 94c6e1e7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6e9bc: f945eae0    	ldr	x0, [x23, #0xbd0] ; class MMContext
104a6e9c0: aa1403e1    	mov	x1, x20
104a6e9c4: 94c6e1de    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e9c8: aa1d03fd    	mov	x29, x29
104a6e9cc: 94c6e1df    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
104a6e9d0: aa0003f4    	mov	x20, x0
104a6e9d4: d00db808    	adrp	x8, 0x120170000 <dyld_stub_binder+0x120170000>
104a6e9d8: f9460502    	ldr	x2, [x8, #0xc08]
104a6e9dc: aa1603e1    	mov	x1, x22
104a6e9e0: aa1303e3    	mov	x3, x19
104a6e9e4: 94c6e1d6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
104a6e9e8: aa1403e0    	mov	x0, x20
104a6e9ec: 94c6e1da    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
104a6e9f0: aa1303e0    	mov	x0, x19
104a6e9f4: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104a6e9f8: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104a6e9fc: a94257f6    	ldp	x22, x21, [sp, #0x20]
104a6ea00: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104a6ea04: 910143ff    	add	sp, sp, #0x50
104a6ea08: d65f03c0    	ret
