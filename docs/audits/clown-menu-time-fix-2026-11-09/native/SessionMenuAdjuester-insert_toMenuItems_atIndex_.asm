
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105ae1808: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
105ae180c: a9014ff4    	stp	x20, x19, [sp, #0x10]
105ae1810: a9027bfd    	stp	x29, x30, [sp, #0x20]
105ae1814: 910083fd    	add	x29, sp, #0x20
105ae1818: aa0403f5    	mov	x21, x4
105ae181c: aa0303f4    	mov	x20, x3
105ae1820: aa0203f3    	mov	x19, x2
105ae1824: aa0203e0    	mov	x0, x2
105ae1828: 94851913    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae182c: aa1403e0    	mov	x0, x20
105ae1830: 94851911    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
105ae1834: b4000273    	cbz	x19, 0x105ae1880 <_Flutter_MMFoundation_BindContext+0x1d6854c>
105ae1838: b00c8e28    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
105ae183c: f9442901    	ldr	x1, [x8, #0x850]
105ae1840: aa1403e0    	mov	x0, x20
105ae1844: 94851908    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1848: eb0002bf    	cmp	x21, x0
105ae184c: 540000e9    	b.ls	0x105ae1868 <_Flutter_MMFoundation_BindContext+0x1d68534>
105ae1850: b00c7748    	adrp	x8, 0x11e9ca000 <dyld_stub_binder+0x11e9ca000>
105ae1854: f942c101    	ldr	x1, [x8, #0x580]
105ae1858: aa1403e0    	mov	x0, x20
105ae185c: aa1303e2    	mov	x2, x19
105ae1860: 94851901    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1864: 14000007    	b	0x105ae1880 <_Flutter_MMFoundation_BindContext+0x1d6854c>
105ae1868: d00c7748    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
105ae186c: f9456d01    	ldr	x1, [x8, #0xad8]
105ae1870: aa1403e0    	mov	x0, x20
105ae1874: aa1303e2    	mov	x2, x19
105ae1878: aa1503e3    	mov	x3, x21
105ae187c: 948518fa    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
105ae1880: aa1403e0    	mov	x0, x20
105ae1884: 948518fb    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
105ae1888: aa1303e0    	mov	x0, x19
105ae188c: a9427bfd    	ldp	x29, x30, [sp, #0x20]
105ae1890: a9414ff4    	ldp	x20, x19, [sp, #0x10]
105ae1894: a8c357f6    	ldp	x22, x21, [sp], #0x30
105ae1898: 148518f6    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
