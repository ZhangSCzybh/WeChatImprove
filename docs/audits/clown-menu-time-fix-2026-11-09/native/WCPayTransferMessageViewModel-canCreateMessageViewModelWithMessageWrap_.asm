
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103d79334 <_Flutter_MMFoundation_BindContext>:
109e76f8c: d10143ff    	sub	sp, sp, #0x50
109e76f90: a90257f6    	stp	x22, x21, [sp, #0x20]
109e76f94: a9034ff4    	stp	x20, x19, [sp, #0x30]
109e76f98: a9047bfd    	stp	x29, x30, [sp, #0x40]
109e76f9c: 910103fd    	add	x29, sp, #0x40
109e76fa0: aa0203f3    	mov	x19, x2
109e76fa4: aa0203e0    	mov	x0, x2
109e76fa8: 9567a316    	bl	0x10f85fc00 <_GetBoxIamBizTLRecFeedsDataUtil+0xdece4>
109e76fac: 900a5ac8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
109e76fb0: f941f914    	ldr	x20, [x8, #0x3f0]
109e76fb4: aa1303e0    	mov	x0, x19
109e76fb8: aa1403e1    	mov	x1, x20
109e76fbc: 9567a30b    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e76fc0: 7100c41f    	cmp	w0, #0x31
109e76fc4: 540001e1    	b.ne	0x109e77000 <_Flutter_MMFoundation_BindContext+0x60fdccc>
109e76fc8: 900a5ac8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
109e76fcc: f941fd15    	ldr	x21, [x8, #0x3f8]
109e76fd0: aa1303e0    	mov	x0, x19
109e76fd4: aa1503e1    	mov	x1, x21
109e76fd8: 9567a304    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e76fdc: 711f401f    	cmp	w0, #0x7d0
109e76fe0: 540000c0    	b.eq	0x109e76ff8 <_Flutter_MMFoundation_BindContext+0x60fdcc4>
109e76fe4: aa1303e0    	mov	x0, x19
109e76fe8: aa1503e1    	mov	x1, x21
109e76fec: 9567a2ff    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e76ff0: 711f6c1f    	cmp	w0, #0x7db
109e76ff4: 54000061    	b.ne	0x109e77000 <_Flutter_MMFoundation_BindContext+0x60fdccc>
109e76ff8: 52800034    	mov	w20, #0x1               ; =1
109e76ffc: 14000022    	b	0x109e77084 <_Flutter_MMFoundation_BindContext+0x60fdd50>
109e77000: aa1303e0    	mov	x0, x19
109e77004: aa1403e1    	mov	x1, x20
109e77008: 9567a2f8    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e7700c: 7100c41f    	cmp	w0, #0x31
109e77010: 54000381    	b.ne	0x109e77080 <_Flutter_MMFoundation_BindContext+0x60fdd4c>
109e77014: f00a74c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
109e77018: f9430d15    	ldr	x21, [x8, #0x618]
109e7701c: aa1303e0    	mov	x0, x19
109e77020: aa1403e1    	mov	x1, x20
109e77024: 9567a2f1    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e77028: aa0003f4    	mov	x20, x0
109e7702c: f00a5aa8    	adrp	x8, 0x11e9ce000 <dyld_stub_binder+0x11e9ce000>
109e77030: f941fd01    	ldr	x1, [x8, #0x3f8]
109e77034: aa1303e0    	mov	x0, x19
109e77038: 9567a2ec    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e7703c: d00a5a88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
109e77040: f9418901    	ldr	x1, [x8, #0x310]
109e77044: a90083f4    	stp	x20, x0, [sp, #0x8]
109e77048: d009b668    	adrp	x8, 0x11d545000 <dyld_stub_binder+0x11d545000>
109e7704c: 9114e108    	add	x8, x8, #0x538
109e77050: f90003e8    	str	x8, [sp]
109e77054: 90083e43    	adrp	x3, 0x11a63f000 <dyld_stub_binder+0x11a63f000>
109e77058: 91346c63    	add	x3, x3, #0xd1b
109e7705c: b0084125    	adrp	x5, 0x11a69c000 <dyld_stub_binder+0x11a69c000>
109e77060: 910af8a5    	add	x5, x5, #0x2be
109e77064: b0084127    	adrp	x7, 0x11a69c000 <dyld_stub_binder+0x11a69c000>
109e77068: 910b7ce7    	add	x7, x7, #0x2df
109e7706c: aa1503e0    	mov	x0, x21
109e77070: 52800042    	mov	w2, #0x2                ; =2
109e77074: 52800004    	mov	w4, #0x0                ; =0
109e77078: 528004e6    	mov	w6, #0x27               ; =39
109e7707c: 9567a2db    	bl	0x10f85fbe8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdeccc>
109e77080: 52800014    	mov	w20, #0x0               ; =0
109e77084: aa1303e0    	mov	x0, x19
109e77088: 9567a2dc    	bl	0x10f85fbf8 <_GetBoxIamBizTLRecFeedsDataUtil+0xdecdc>
109e7708c: aa1403e0    	mov	x0, x20
109e77090: a9447bfd    	ldp	x29, x30, [sp, #0x40]
109e77094: a9434ff4    	ldp	x20, x19, [sp, #0x30]
109e77098: a94257f6    	ldp	x22, x21, [sp, #0x20]
109e7709c: 910143ff    	add	sp, sp, #0x50
109e770a0: d65f03c0    	ret
