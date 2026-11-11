
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-4b6441f8-4e09-4a13-9071-759ca0cc225f/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
104dda038: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
104dda03c: a90157f6    	stp	x22, x21, [sp, #0x10]
104dda040: a9024ff4    	stp	x20, x19, [sp, #0x20]
104dda044: a9037bfd    	stp	x29, x30, [sp, #0x30]
104dda048: 9100c3fd    	add	x29, sp, #0x30
104dda04c: aa0403f6    	mov	x22, x4
104dda050: aa0303f7    	mov	x23, x3
104dda054: aa0203f3    	mov	x19, x2
104dda058: aa0003f4    	mov	x20, x0
104dda05c: aa0203e0    	mov	x0, x2
104dda060: 94b93705    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104dda064: 900cf9c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
104dda068: f9431915    	ldr	x21, [x8, #0x630]
104dda06c: 900cf668    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
104dda070: f947b918    	ldr	x24, [x8, #0xf70]
104dda074: aa1703e0    	mov	x0, x23
104dda078: 94b936ff    	bl	0x107c27c74 <_Flutter_MMFoundation_BindContext+0x3eae940>
104dda07c: aa1503e0    	mov	x0, x21
104dda080: aa1803e1    	mov	x1, x24
104dda084: 94b936f8    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dda088: aa1d03fd    	mov	x29, x29
104dda08c: 94b936fd    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104dda090: aa0003f5    	mov	x21, x0
104dda094: f00cdf68    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
104dda098: f941a901    	ldr	x1, [x8, #0x350]
104dda09c: aa1703e2    	mov	x2, x23
104dda0a0: aa1303e3    	mov	x3, x19
104dda0a4: 94b936f0    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dda0a8: aa1703e0    	mov	x0, x23
104dda0ac: 94b936f1    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104dda0b0: d2800017    	mov	x23, #0x0               ; =0
104dda0b4: b4000173    	cbz	x19, 0x104dda0e0 <_Flutter_MMFoundation_BindContext+0x1060dac>
104dda0b8: 34000156    	cbz	w22, 0x104dda0e0 <_Flutter_MMFoundation_BindContext+0x1060dac>
104dda0bc: b00cf9c8    	adrp	x8, 0x11ed13000 <dyld_stub_binder+0x11ed13000>
104dda0c0: f9413100    	ldr	x0, [x8, #0x260]
104dda0c4: 900cdfc8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
104dda0c8: f942a901    	ldr	x1, [x8, #0x550]
104dda0cc: aa1303e2    	mov	x2, x19
104dda0d0: 94b936e5    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dda0d4: aa1d03fd    	mov	x29, x29
104dda0d8: 94b936ea    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
104dda0dc: aa0003f7    	mov	x23, x0
104dda0e0: b00cea48    	adrp	x8, 0x11eb23000 <dyld_stub_binder+0x11eb23000>
104dda0e4: f9475101    	ldr	x1, [x8, #0xea0]
104dda0e8: aa1403e0    	mov	x0, x20
104dda0ec: aa1503e2    	mov	x2, x21
104dda0f0: aa1703e3    	mov	x3, x23
104dda0f4: 94b936dc    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
104dda0f8: aa1703e0    	mov	x0, x23
104dda0fc: 94b936dd    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104dda100: aa1503e0    	mov	x0, x21
104dda104: 94b936db    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
104dda108: aa1303e0    	mov	x0, x19
104dda10c: a9437bfd    	ldp	x29, x30, [sp, #0x30]
104dda110: a9424ff4    	ldp	x20, x19, [sp, #0x20]
104dda114: a94157f6    	ldp	x22, x21, [sp, #0x10]
104dda118: a8c45ff8    	ldp	x24, x23, [sp], #0x40
104dda11c: 14b936d5    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
