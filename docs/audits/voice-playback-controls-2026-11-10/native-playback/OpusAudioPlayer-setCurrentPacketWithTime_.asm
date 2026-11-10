
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105592cb8: 1e630040    	ucvtf	d0, w2
105592cbc: d2e80b28    	mov	x8, #0x4059000000000000 ; =4636737291354636288
105592cc0: 9e670101    	fmov	d1, x8
105592cc4: 1e611800    	fdiv	d0, d0, d1
105592cc8: 1e790008    	fcvtzu	w8, d0
105592ccc: 900cbf69    	adrp	x9, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105592cd0: 912ab129    	add	x9, x9, #0xaac
105592cd4: b9800129    	ldrsw	x9, [x9]
105592cd8: f8696809    	ldr	x9, [x0, x9]
105592cdc: b9000928    	str	w8, [x9, #0x8]
105592ce0: fd400920    	ldr	d0, [x9, #0x10]
105592ce4: b00919aa    	adrp	x10, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
105592ce8: fd445d41    	ldr	d1, [x10, #0x8b8]
105592cec: 1e610800    	fmul	d0, d0, d1
105592cf0: 1e78000a    	fcvtzs	w10, d0
105592cf4: 1b087d48    	mul	w8, w10, w8
105592cf8: f9003128    	str	x8, [x9, #0x60]
105592cfc: 52800028    	mov	w8, #0x1                ; =1
105592d00: 7806d128    	sturh	w8, [x9, #0x6d]
105592d04: 900cbf68    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105592d08: 912ac108    	add	x8, x8, #0xab0
105592d0c: b9800108    	ldrsw	x8, [x8]
105592d10: 12800009    	mov	w9, #-0x1               ; =-1
105592d14: b8286809    	str	w9, [x0, x8]
105592d18: d65f03c0    	ret
