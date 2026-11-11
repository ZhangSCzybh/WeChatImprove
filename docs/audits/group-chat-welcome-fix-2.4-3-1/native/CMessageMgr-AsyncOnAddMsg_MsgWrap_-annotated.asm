
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104dd9d54: d10143ff    	sub	sp, sp, #0x50
104dd9d58: a9015ff8    	stp	x24, x23, [sp, #0x10]
104dd9d5c: a90257f6    	stp	x22, x21, [sp, #0x20]
104dd9d60: a9034ff4    	stp	x20, x19, [sp, #0x30]
104dd9d64: a9047bfd    	stp	x29, x30, [sp, #0x40]
104dd9d68: 910103fd    	add	x29, sp, #0x40
104dd9d6c: aa0303f4    	mov	x20, x3
104dd9d70: aa0203f3    	mov	x19, x2
104dd9d74: aa0003f5    	mov	x21, x0
104dd9d78: aa0203e0    	mov	x0, x2
104dd9d7c: 94b937be    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104dd9d80: aa1403e0    	mov	x0, x20
104dd9d84: 94b937bc    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104dd9d88: b4000653    	cbz	x19, 0x104dd9e50 <_Flutter_MMFoundation_BindContext+0x1060b1c>
104dd9d8c: b4000634    	cbz	x20, 0x104dd9e50 <_Flutter_MMFoundation_BindContext+0x1060b1c>
104dd9d90: b00cf9c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104dd9d94: f9431900    	ldr	x0, [x8, #0x630]
104dd9d98: 94b9379d    	bl	0x107c27c0c <_Flutter_MMFoundation_BindContext+0x3eae8d8>
104dd9d9c: aa0003f6    	mov	x22, x0
104dd9da0: 900cdf88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104dd9da4: f941a917    	ldr	x23, [x8, #0x350] ; selector: safeSetObject:forKey:
104dd9da8: d00c0e83    	adrp	x3, 0x11cfab000 <dyld_stub_binder+0x11cfab000>
104dd9dac: 911f6063    	add	x3, x3, #0x7d8 ; CFString: 2
104dd9db0: aa1703e1    	mov	x1, x23
104dd9db4: aa1303e2    	mov	x2, x19
104dd9db8: 94b937ab    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dd9dbc: 900c0f43    	adrp	x3, 0x11cfc1000 <dyld_stub_binder+0x11cfc1000>
104dd9dc0: 9106e063    	add	x3, x3, #0x1b8 ; CFString: 3
104dd9dc4: aa1603e0    	mov	x0, x22
104dd9dc8: aa1703e1    	mov	x1, x23
104dd9dcc: aa1403e2    	mov	x2, x20
104dd9dd0: 94b937a5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dd9dd4: b00cf9c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104dd9dd8: f9431d00    	ldr	x0, [x8, #0x638]
104dd9ddc: 900cf6a8    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
104dd9de0: f942e501    	ldr	x1, [x8, #0x5c8] ; selector: stringWithFormat:
104dd9de4: 52800048    	mov	w8, #0x2                ; =2
104dd9de8: f90003e8    	str	x8, [sp]
104dd9dec: b00c0e42    	adrp	x2, 0x11cfa2000 <dyld_stub_binder+0x11cfa2000>
104dd9df0: 912be042    	add	x2, x2, #0xaf8 ; CFString: %u
104dd9df4: 94b9379c    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dd9df8: aa1d03fd    	mov	x29, x29
104dd9dfc: 94b937a1    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104dd9e00: aa0003f8    	mov	x24, x0
104dd9e04: d00c0e03    	adrp	x3, 0x11cf9b000 <dyld_stub_binder+0x11cf9b000>
104dd9e08: 911e6063    	add	x3, x3, #0x798 ; CFString: 1
104dd9e0c: aa1603e0    	mov	x0, x22
104dd9e10: aa1703e1    	mov	x1, x23
104dd9e14: aa1803e2    	mov	x2, x24
104dd9e18: 94b93793    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dd9e1c: aa1803e0    	mov	x0, x24
104dd9e20: 94b93794    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104dd9e24: d00cea48    	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104dd9e28: f9474902    	ldr	x2, [x8, #0xe90] ; selector: MainThreadNotifyToExt:
104dd9e2c: 900cf688    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
104dd9e30: f946f901    	ldr	x1, [x8, #0xdf0] ; selector: performSelectorOnMainThread:withObject:waitUntilDone:
104dd9e34: aa1503e0    	mov	x0, x21
104dd9e38: aa1603e3    	mov	x3, x22
104dd9e3c: 52800004    	mov	w4, #0x0                ; =0
104dd9e40: 94b93789    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dd9e44: aa1603e0    	mov	x0, x22
104dd9e48: 94b9378a    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104dd9e4c: 14000012    	b	0x104dd9e94 <_Flutter_MMFoundation_BindContext+0x1060b60>
104dd9e50: b00cf9c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104dd9e54: f9430d00    	ldr	x0, [x8, #0x618]
104dd9e58: 900cdf88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104dd9e5c: f9418901    	ldr	x1, [x8, #0x310] ; selector: logWithLevel:module:errorCode:file:line:func:format:
104dd9e60: 900c2748    	adrp	x8, 0x11d2c1000 <dyld_stub_binder+0x11d2c1000>
104dd9e64: 91356108    	add	x8, x8, #0xd58 ; CFString: object nil
104dd9e68: f90003e8    	str	x8, [sp]
104dd9e6c: d00a6e43    	adrp	x3, 0x119ba3000 <dyld_stub_binder+0x119ba3000>
104dd9e70: 91076463    	add	x3, x3, #0x1d9
104dd9e74: 900a9f05    	adrp	x5, 0x11a1b9000 <dyld_stub_binder+0x11a1b9000>
104dd9e78: 913f88a5    	add	x5, x5, #0xfe2
104dd9e7c: b00a9f07    	adrp	x7, 0x11a1ba000 <dyld_stub_binder+0x11a1ba000>
104dd9e80: 910348e7    	add	x7, x7, #0xd2
104dd9e84: 52800082    	mov	w2, #0x4                ; =4
104dd9e88: 52800004    	mov	w4, #0x0                ; =0
104dd9e8c: 52801e86    	mov	w6, #0xf4               ; =244
104dd9e90: 94b93775    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dd9e94: aa1403e0    	mov	x0, x20
104dd9e98: 94b93776    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104dd9e9c: aa1303e0    	mov	x0, x19
104dd9ea0: a9447bfd    	ldp	x29, x30, [sp, #0x40]
104dd9ea4: a9434ff4    	ldp	x20, x19, [sp, #0x30]
104dd9ea8: a94257f6    	ldp	x22, x21, [sp, #0x20]
104dd9eac: a9415ff8    	ldp	x24, x23, [sp, #0x10]
104dd9eb0: 910143ff    	add	sp, sp, #0x50
104dd9eb4: 14b9376f    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
