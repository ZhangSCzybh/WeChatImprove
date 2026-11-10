
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-fav-8080-20261110-g5qs3obm/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
105cf4b08: 1e630040    	ucvtf	d0, w2
105cf4b0c: d2e80b28    	mov	x8, #0x4059000000000000 ; =4636737291354636288
105cf4b10: 9e670101    	fmov	d1, x8
105cf4b14: 1e611800    	fdiv	d0, d0, d1
105cf4b18: 1e790008    	fcvtzu	w8, d0
105cf4b1c: d00c8449    	adrp	x9, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105cf4b20: 912ab129    	add	x9, x9, #0xaac
105cf4b24: b9800129    	ldrsw	x9, [x9]
105cf4b28: f8696809    	ldr	x9, [x0, x9]
105cf4b2c: b9000928    	str	w8, [x9, #0x8]
105cf4b30: fd400920    	ldr	d0, [x9, #0x10]
105cf4b34: f008de8a    	adrp	x10, 0x1178c7000 <dyld_stub_binder+0x1178c7000>
105cf4b38: fd445d41    	ldr	d1, [x10, #0x8b8]
105cf4b3c: 1e610800    	fmul	d0, d0, d1
105cf4b40: 1e78000a    	fcvtzs	w10, d0
105cf4b44: 1b087d48    	mul	w8, w10, w8
105cf4b48: f9003128    	str	x8, [x9, #0x60]
105cf4b4c: 52800028    	mov	w8, #0x1                ; =1
105cf4b50: 7806d128    	sturh	w8, [x9, #0x6d]
105cf4b54: d00c8448    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
105cf4b58: 912ac108    	add	x8, x8, #0xab0
105cf4b5c: b9800108    	ldrsw	x8, [x8]
105cf4b60: 12800009    	mov	w9, #-0x1               ; =-1
105cf4b64: b8286809    	str	w9, [x0, x8]
105cf4b68: d65f03c0    	ret
