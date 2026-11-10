
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
109e78a08: a9bb67fa    	stp	x26, x25, [sp, #-0x50]!
109e78a0c: a9015ff8    	stp	x24, x23, [sp, #0x10]
109e78a10: a90257f6    	stp	x22, x21, [sp, #0x20]
109e78a14: a9034ff4    	stp	x20, x19, [sp, #0x30]
109e78a18: a9047bfd    	stp	x29, x30, [sp, #0x40]
109e78a1c: 910103fd    	add	x29, sp, #0x40
109e78a20: aa0003f3    	mov	x19, x0
109e78a24: f00ac748    	adrp	x8, 0x11f763000 <dyld_stub_binder+0x11f763000>
109e78a28: 52800029    	mov	w9, #0x1                ; =1
109e78a2c: d00a782a    	adrp	x10, 0x11ed7e000 <dyld_stub_binder+0x11ed7e000>
109e78a30: 912e314a    	add	x10, x10, #0xb8c
109e78a34: 392f8d09    	strb	w9, [x8, #0xbe3]
109e78a38: b9800159    	ldrsw	x25, [x10]
109e78a3c: f8796800    	ldr	x0, [x0, x25]
109e78a40: b00a5b28    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
109e78a44: f946bd14    	ldr	x20, [x8, #0xd78]
109e78a48: aa1403e1    	mov	x1, x20
109e78a4c: 95679c67    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78a50: aa1d03fd    	mov	x29, x29
109e78a54: 95679c6e    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78a58: aa0003f6    	mov	x22, x0
109e78a5c: b00a5b28    	adrp	x8, 0x11e9dd000 <dyld_stub_binder+0x11e9dd000>
109e78a60: f946e915    	ldr	x21, [x8, #0xdd0]
109e78a64: aa1503e1    	mov	x1, x21
109e78a68: 95679c60    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78a6c: aa1d03fd    	mov	x29, x29
109e78a70: 95679c67    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78a74: aa0003f7    	mov	x23, x0
109e78a78: 900a7188    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
109e78a7c: f9467501    	ldr	x1, [x8, #0xce8]
109e78a80: 95679c5a    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78a84: aa0003f8    	mov	x24, x0
109e78a88: aa1703e0    	mov	x0, x23
109e78a8c: 95679c5b    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e78a90: aa1603e0    	mov	x0, x22
109e78a94: 95679c59    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e78a98: b4000158    	cbz	x24, 0x109e78ac0 <_Flutter_MMFoundation_BindContext+0x60ff78c>
109e78a9c: b00a6da8    	adrp	x8, 0x11ec2d000 <dyld_stub_binder+0x11ec2d000>
109e78aa0: f943bd01    	ldr	x1, [x8, #0x778]
109e78aa4: aa1303e0    	mov	x0, x19
109e78aa8: 95679c50    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78aac: 340001a0    	cbz	w0, 0x109e78ae0 <_Flutter_MMFoundation_BindContext+0x60ff7ac>
109e78ab0: b00a6da8    	adrp	x8, 0x11ec2d000 <dyld_stub_binder+0x11ec2d000>
109e78ab4: f943e501    	ldr	x1, [x8, #0x7c8]
109e78ab8: aa1303e0    	mov	x0, x19
109e78abc: 14000004    	b	0x109e78acc <_Flutter_MMFoundation_BindContext+0x60ff798>
109e78ac0: f8796a60    	ldr	x0, [x19, x25]
109e78ac4: d00a5aa8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
109e78ac8: f9421d01    	ldr	x1, [x8, #0x438]
109e78acc: 95679c47    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78ad0: aa1d03fd    	mov	x29, x29
109e78ad4: 95679c4e    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78ad8: aa0003f3    	mov	x19, x0
109e78adc: 1400000e    	b	0x109e78b14 <_Flutter_MMFoundation_BindContext+0x60ff7e0>
109e78ae0: f8796a60    	ldr	x0, [x19, x25]
109e78ae4: aa1403e1    	mov	x1, x20
109e78ae8: 95679c40    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78aec: aa1d03fd    	mov	x29, x29
109e78af0: 95679c47    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78af4: aa0003f4    	mov	x20, x0
109e78af8: aa1503e1    	mov	x1, x21
109e78afc: 95679c3b    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e78b00: aa1d03fd    	mov	x29, x29
109e78b04: 95679c42    	bl	0x10f85fc0c <_GetBoxIamBizTLRecFeedsDataUtil+0xdecf0>
109e78b08: aa0003f3    	mov	x19, x0
109e78b0c: aa1403e0    	mov	x0, x20
109e78b10: 95679c3a    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e78b14: aa1303e0    	mov	x0, x19
109e78b18: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109e78b1c: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109e78b20: a94257f6    	ldp	x22, x21, [sp, #0x20]
109e78b24: a9415ff8    	ldp	x24, x23, [sp, #0x10]
109e78b28: a8c567fa    	ldp	x26, x25, [sp], #0x50
109e78b2c: 15679c1c    	b	0x10f85fb9c <_GetBoxIamBizTLRecFeedsDataUtil+0xdec80>
