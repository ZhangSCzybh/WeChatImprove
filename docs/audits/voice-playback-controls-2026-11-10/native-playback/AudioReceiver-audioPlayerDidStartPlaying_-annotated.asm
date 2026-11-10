
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100177b18: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
100177b1c: a9014ff4    	stp	x20, x19, [sp, #0x10]
100177b20: a9027bfd    	stp	x29, x30, [sp, #0x20]
100177b24: 910083fd    	add	x29, sp, #0x20
100177b28: aa0003f3    	mov	x19, x0
100177b2c: d00f6028    	adrp	x8, 0x11ed7d000 <dyld_stub_binder+0x11ed7d000>
100177b30: b98b0108    	ldrsw	x8, [x8, #0xb00] ; ivar: AudioReceiver.m_audioPlayer offset=8
100177b34: f8686800    	ldr	x0, [x0, x8]
100177b38: eb02001f    	cmp	x0, x2
100177b3c: 540000a0    	b.eq	0x100177b50 <__text+0x16fb50>
100177b40: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177b44: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177b48: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177b4c: d65f03c0    	ret
100177b50: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177b54: f9455d01    	ldr	x1, [x8, #0xab8] ; selector: getUserData
100177b58: 95eac043    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177b5c: aa1d03fd    	mov	x29, x29
100177b60: 95eac048    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177b64: aa0003f4    	mov	x20, x0
100177b68: b00f42c8    	adrp	x8, 0x11e9d0000 <dyld_stub_binder+0x11e9d0000>
100177b6c: f9433101    	ldr	x1, [x8, #0x660] ; selector: msgWrap
100177b70: 95eac03d    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177b74: aa1d03fd    	mov	x29, x29
100177b78: 95eac042    	bl	0x107c27c80 <_Flutter_MMFoundation_BindContext+0x3eae94c>
100177b7c: aa0003f5    	mov	x21, x0
100177b80: 900f42e8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
100177b84: f944e501    	ldr	x1, [x8, #0x9c8] ; selector: notifyOnPlaying:success:
100177b88: aa1303e0    	mov	x0, x19
100177b8c: aa1503e2    	mov	x2, x21
100177b90: 52800023    	mov	w3, #0x1                ; =1
100177b94: 95eac034    	bl	0x107c27c64 <_Flutter_MMFoundation_BindContext+0x3eae930>
100177b98: aa1503e0    	mov	x0, x21
100177b9c: 95eac035    	bl	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
100177ba0: aa1403e0    	mov	x0, x20
100177ba4: a9427bfd    	ldp	x29, x30, [sp, #0x20]
100177ba8: a9414ff4    	ldp	x20, x19, [sp, #0x10]
100177bac: a8c357f6    	ldp	x22, x21, [sp], #0x30
100177bb0: 15eac030    	b	0x107c27c70 <_Flutter_MMFoundation_BindContext+0x3eae93c>
