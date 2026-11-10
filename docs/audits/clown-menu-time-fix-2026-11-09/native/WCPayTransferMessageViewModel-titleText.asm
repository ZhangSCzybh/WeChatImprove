
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
109e78918: a9bc5ff8    	stp	x24, x23, [sp, #-0x40]!
109e7891c: a90157f6    	stp	x22, x21, [sp, #0x10]
109e78920: a9024ff4    	stp	x20, x19, [sp, #0x20]
109e78924: a9037bfd    	stp	x29, x30, [sp, #0x30]
109e78928: 9100c3fd    	add	x29, sp, #0x30
109e7892c: aa0003f3    	mov	x19, x0
109e78930: d00a7828    	adrp	x8, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
109e78934: 912e3108    	add	x8, x8, #0xb8c
109e78938: b9800118    	ldrsw	x24, [x8]
109e7893c: f8786800    	ldr	x0, [x0, x24]
109e78940: b00a5b28    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
109e78944: f946bd14    	ldr	x20, [x8, #0xd78]
109e78948: aa1403e1    	mov	x1, x20
109e7894c: 95679ca7    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78950: aa1d03fd    	mov	x29, x29
109e78954: 95679cae    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78958: aa0003f6    	mov	x22, x0
109e7895c: b00a5b28    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
109e78960: f946c115    	ldr	x21, [x8, #0xd80]
109e78964: aa1503e1    	mov	x1, x21
109e78968: 95679ca0    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e7896c: aa0003f7    	mov	x23, x0
109e78970: aa1603e0    	mov	x0, x22
109e78974: 95679ca1    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e78978: 710052ff    	cmp	w23, #0x14
109e7897c: 54000263    	b.lo	0x109e789c8 <_Flutter_MMFoundation_BindContext+0x60ff694>
109e78980: f8786a60    	ldr	x0, [x19, x24]
109e78984: aa1403e1    	mov	x1, x20
109e78988: 95679c98    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e7898c: aa1d03fd    	mov	x29, x29
109e78990: 95679c9f    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78994: aa0003f4    	mov	x20, x0
109e78998: aa1503e1    	mov	x1, x21
109e7899c: 95679c93    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e789a0: aa0003f5    	mov	x21, x0
109e789a4: aa1403e0    	mov	x0, x20
109e789a8: 95679c94    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e789ac: 71006ebf    	cmp	w21, #0x1b
109e789b0: 52800028    	mov	w8, #0x1                ; =1
109e789b4: 1ad52108    	lsl	w8, w8, w21
109e789b8: 121f6908    	and	w8, w8, #0xffffffe
109e789bc: 120b5908    	and	w8, w8, #0xffe00fff
109e789c0: 7a409904    	ccmp	w8, #0x0, #0x4, ls
109e789c4: 540001a0    	b.eq	0x109e789f8 <_Flutter_MMFoundation_BindContext+0x60ff6c4>
109e789c8: b00a6da8    	adrp	x8, 0x11ec2d000 <dyld_stub_binder+0x11ec2d000>
109e789cc: 911f0108    	add	x8, x8, #0x7c0
109e789d0: f9400101    	ldr	x1, [x8]
109e789d4: aa1303e0    	mov	x0, x19
109e789d8: 95679c84    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e789dc: aa1d03fd    	mov	x29, x29
109e789e0: 95679c8b    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e789e4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
109e789e8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
109e789ec: a94157f6    	ldp	x22, x21, [sp, #0x10]
109e789f0: a8c45ff8    	ldp	x24, x23, [sp], #0x40
109e789f4: 15679c6a    	b	0x10f85fb9c <_GetBoxIamBizTLRecFeedsDataUtil+0xdec80>
109e789f8: f8786a73    	ldr	x19, [x19, x24]
109e789fc: d00a5aa8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
109e78a00: 9110e108    	add	x8, x8, #0x438
109e78a04: 17fffff3    	b	0x109e789d0 <_Flutter_MMFoundation_BindContext+0x60ff69c>
