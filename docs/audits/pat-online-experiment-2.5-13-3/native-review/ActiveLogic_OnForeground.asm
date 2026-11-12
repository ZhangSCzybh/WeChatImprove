
/private/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/wechat-crash-141902-g68h12mb/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1130e3fe4: f0065189    	adrp	x9, 0x11fb16000 <dyld_stub_binder+0x11fb16000>
1130e3fe8: f9443529    	ldr	x9, [x9, #0x868] ; 0x11fb16868 __bss
1130e3fec: b4000049    	cbz	x9, 0x1130e3ff4 <_O266DecReleaseOutputPicture+0xfd4a88>
1130e3ff0: d61f0120    	br	x9
1130e3ff4: a9bc6ffc    	stp	x28, x27, [sp, #-0x40]!
1130e3ff8: a90157f6    	stp	x22, x21, [sp, #0x10]
1130e3ffc: a9024ff4    	stp	x20, x19, [sp, #0x20]
1130e4000: a9037bfd    	stp	x29, x30, [sp, #0x30]
1130e4004: 9100c3fd    	add	x29, sp, #0x30
1130e4008: d10a83ff    	sub	sp, sp, #0x2a0
1130e400c: aa0103f4    	mov	x20, x1
1130e4010: aa0003f3    	mov	x19, x0
1130e4014: 90053348    	adrp	x8, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1130e4018: f9451908    	ldr	x8, [x8, #0xa30] ; 0x11d74ca30 __got
1130e401c: f9400108    	ldr	x8, [x8]
1130e4020: f81c83a8    	stur	x8, [x29, #-0x38]
1130e4024: 940441e1    	bl	0x1131f47a8 <_O266DecReleaseOutputPicture+0x10e523c>
1130e4028: aa0003f5    	mov	x21, x0
1130e402c: 940434ea    	bl	0x1131f13d4 <_O266DecReleaseOutputPicture+0x10e1e68>
1130e4030: eb0002bf    	cmp	x21, x0
1130e4034: 54001121    	b.ne	0x1130e4258 <_O266DecReleaseOutputPicture+0xfd4cec>
1130e4038: d102e3b5    	sub	x21, x29, #0xb8
1130e403c: d003f3c2    	adrp	x2, 0x11af5e000 <dyld_stub_binder+0x11af5e000>
1130e4040: 91340442    	add	x2, x2, #0xd01 ; 'mars::baseevent'
1130e4044: d003bcc3    	adrp	x3, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e4048: 9137d063    	add	x3, x3, #0xdf4 ; 'active_logic.cc'
1130e404c: f003bb64    	adrp	x4, 0x11a853000 <dyld_stub_binder+0x11a853000>
1130e4050: 91284884    	add	x4, x4, #0xa12 ; 'OnForeground'
1130e4054: 910263e0    	add	x0, sp, #0x98
1130e4058: 52800001    	mov	w1, #0x0                ; =0
1130e405c: 52800de5    	mov	w5, #0x6f               ; =111
1130e4060: 52800006    	mov	w6, #0x0                ; =0
1130e4064: d2800007    	mov	x7, #0x0                ; =0
1130e4068: 9404d3dc    	bl	0x113218fd8 <_O266DecReleaseOutputPicture+0x1109a6c>
1130e406c: 52800040    	mov	w0, #0x2                ; =2
1130e4070: 9404d775    	bl	0x113219e44 <_O266DecReleaseOutputPicture+0x110a8d8>
1130e4074: 340006a0    	cbz	w0, 0x1130e4148 <_O266DecReleaseOutputPicture+0xfd4bdc>
1130e4078: d003f3c2    	adrp	x2, 0x11af5e000 <dyld_stub_binder+0x11af5e000>
1130e407c: 91340442    	add	x2, x2, #0xd01 ; 'mars::baseevent'
1130e4080: d003bcc3    	adrp	x3, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e4084: 9137d063    	add	x3, x3, #0xdf4 ; 'active_logic.cc'
1130e4088: f003bb64    	adrp	x4, 0x11a853000 <dyld_stub_binder+0x11a853000>
1130e408c: 91284884    	add	x4, x4, #0xa12 ; 'OnForeground'
1130e4090: 910023e0    	add	x0, sp, #0x8
1130e4094: 52800041    	mov	w1, #0x2                ; =2
1130e4098: 52800e05    	mov	w5, #0x70               ; =112
1130e409c: 52800006    	mov	w6, #0x0                ; =0
1130e40a0: d2800007    	mov	x7, #0x0                ; =0
1130e40a4: 9404d3cd    	bl	0x113218fd8 <_O266DecReleaseOutputPicture+0x1109a6c>
1130e40a8: f003f4c8    	adrp	x8, 0x11af7f000 <dyld_stub_binder+0x11af7f000>
1130e40ac: 912d6908    	add	x8, x8, #0xb5a ; 'false'
1130e40b0: 390743ff    	strb	wzr, [sp, #0x1d0]
1130e40b4: f00406e9    	adrp	x9, 0x11b1c3000 <dyld_stub_binder+0x11b1c3000>
1130e40b8: 9125e129    	add	x9, x9, #0x978 ; 'true'
1130e40bc: 7100029f    	cmp	w20, #0x0
1130e40c0: 9a88112a    	csel	x10, x9, x8, ne
1130e40c4: f900e7ea    	str	x10, [sp, #0x1c8]
1130e40c8: 3940e26a    	ldrb	w10, [x19, #0x38]
1130e40cc: 390603ff    	strb	wzr, [sp, #0x180]
1130e40d0: 6b14015f    	cmp	w10, w20
1130e40d4: 9a890108    	csel	x8, x8, x9, eq
1130e40d8: f900bfe8    	str	x8, [sp, #0x178]
1130e40dc: f90003f3    	str	x19, [sp]
1130e40e0: 9104a3f6    	add	x22, sp, #0x128
1130e40e4: 9104a3e0    	add	x0, sp, #0x128
1130e40e8: 910003e1    	mov	x1, sp
1130e40ec: 97f2da75    	bl	0x112d9aac0 <_O266DecReleaseOutputPicture+0xc8b554>
1130e40f0: 910723e8    	add	x8, sp, #0x1c8
1130e40f4: 9105e3e9    	add	x9, sp, #0x178
1130e40f8: a934a7a8    	stp	x8, x9, [x29, #-0xb8]
1130e40fc: 4f00e400    	movi.16b	v0, #0x0
1130e4100: 3c8182a0    	stur	q0, [x21, #0x18]
1130e4104: 3c8282a0    	stur	q0, [x21, #0x28]
1130e4108: 3c8382a0    	stur	q0, [x21, #0x38]
1130e410c: 3c8482a0    	stur	q0, [x21, #0x48]
1130e4110: 3c8582a0    	stur	q0, [x21, #0x58]
1130e4114: 3c8682a0    	stur	q0, [x21, #0x68]
1130e4118: f81583b6    	stur	x22, [x29, #-0xa8]
1130e411c: f81c03bf    	stur	xzr, [x29, #-0x40]
1130e4120: d003bcc1    	adrp	x1, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e4124: 9138e821    	add	x1, x1, #0xe3a ; 'OnForeground:%0, change:%1, this:%2'
1130e4128: 910023e0    	add	x0, sp, #0x8
1130e412c: d102e3a2    	sub	x2, x29, #0xb8
1130e4130: 9404d478    	bl	0x113219310 <_O266DecReleaseOutputPicture+0x1109da4>
1130e4134: 910023e0    	add	x0, sp, #0x8
1130e4138: 910263e1    	add	x1, sp, #0x98
1130e413c: 9404d3f4    	bl	0x11321910c <_O266DecReleaseOutputPicture+0x1109ba0>
1130e4140: 910023e0    	add	x0, sp, #0x8
1130e4144: 9404d3ed    	bl	0x1132190f8 <_O266DecReleaseOutputPicture+0x1109b8c>
1130e4148: 3940e268    	ldrb	w8, [x19, #0x38]
1130e414c: 6b14011f    	cmp	w8, w20
1130e4150: 540007e0    	b.eq	0x1130e424c <_O266DecReleaseOutputPicture+0xfd4ce0>
1130e4154: 3940e676    	ldrb	w22, [x19, #0x39]
1130e4158: 52800028    	mov	w8, #0x1                ; =1
1130e415c: 3900e668    	strb	w8, [x19, #0x39]
1130e4160: 3900e274    	strb	w20, [x19, #0x38]
1130e4164: 9404cbf8    	bl	0x113217144 <_O266DecReleaseOutputPicture+0x1107bd8>
1130e4168: f9008260    	str	x0, [x19, #0x100]
1130e416c: 91010260    	add	x0, x19, #0x40
1130e4170: 97ffea85    	bl	0x1130deb84 <_O266DecReleaseOutputPicture+0xfcf618>
1130e4174: 3940e261    	ldrb	w1, [x19, #0x38]
1130e4178: 3940e674    	ldrb	w20, [x19, #0x39]
1130e417c: f9400a60    	ldr	x0, [x19, #0x10]
1130e4180: 96197ca0    	bl	0x10b743400 <_mmkv_importFrom+0x88065c>
1130e4184: 6b1402df    	cmp	w22, w20
1130e4188: 54000620    	b.eq	0x1130e424c <_O266DecReleaseOutputPicture+0xfd4ce0>
1130e418c: 52800040    	mov	w0, #0x2                ; =2
1130e4190: 9404d72d    	bl	0x113219e44 <_O266DecReleaseOutputPicture+0x110a8d8>
1130e4194: 34000560    	cbz	w0, 0x1130e4240 <_O266DecReleaseOutputPicture+0xfd4cd4>
1130e4198: d003f3c2    	adrp	x2, 0x11af5e000 <dyld_stub_binder+0x11af5e000>
1130e419c: 91340442    	add	x2, x2, #0xd01 ; 'mars::baseevent'
1130e41a0: d003bcc3    	adrp	x3, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e41a4: 9137d063    	add	x3, x3, #0xdf4 ; 'active_logic.cc'
1130e41a8: f003bb64    	adrp	x4, 0x11a853000 <dyld_stub_binder+0x11a853000>
1130e41ac: 91284884    	add	x4, x4, #0xa12 ; 'OnForeground'
1130e41b0: 910023e0    	add	x0, sp, #0x8
1130e41b4: 52800041    	mov	w1, #0x2                ; =2
1130e41b8: 528010e5    	mov	w5, #0x87               ; =135
1130e41bc: 52800006    	mov	w6, #0x0                ; =0
1130e41c0: d2800007    	mov	x7, #0x0                ; =0
1130e41c4: 9404d385    	bl	0x113218fd8 <_O266DecReleaseOutputPicture+0x1109a6c>
1130e41c8: 390743ff    	strb	wzr, [sp, #0x1d0]
1130e41cc: 3940e668    	ldrb	w8, [x19, #0x39]
1130e41d0: f003f4c9    	adrp	x9, 0x11af7f000 <dyld_stub_binder+0x11af7f000>
1130e41d4: 912d6929    	add	x9, x9, #0xb5a ; 'false'
1130e41d8: f00406ea    	adrp	x10, 0x11b1c3000 <dyld_stub_binder+0x11b1c3000>
1130e41dc: 9125e14a    	add	x10, x10, #0x978 ; 'true'
1130e41e0: 7100011f    	cmp	w8, #0x0
1130e41e4: 9a891148    	csel	x8, x10, x9, ne
1130e41e8: f900e7e8    	str	x8, [sp, #0x1c8]
1130e41ec: 4f00e400    	movi.16b	v0, #0x0
1130e41f0: 3c8082a0    	stur	q0, [x21, #0x8]
1130e41f4: 910723e8    	add	x8, sp, #0x1c8
1130e41f8: 3c8182a0    	stur	q0, [x21, #0x18]
1130e41fc: 3c8282a0    	stur	q0, [x21, #0x28]
1130e4200: 3c8382a0    	stur	q0, [x21, #0x38]
1130e4204: 3c8482a0    	stur	q0, [x21, #0x48]
1130e4208: 3c8582a0    	stur	q0, [x21, #0x58]
1130e420c: 3c8682a0    	stur	q0, [x21, #0x68]
1130e4210: f81483a8    	stur	x8, [x29, #-0xb8]
1130e4214: f81c03bf    	stur	xzr, [x29, #-0x40]
1130e4218: d003bcc1    	adrp	x1, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e421c: 91397821    	add	x1, x1, #0xe5e ; 'active change:%0'
1130e4220: 910023e0    	add	x0, sp, #0x8
1130e4224: d102e3a2    	sub	x2, x29, #0xb8
1130e4228: 9404d43a    	bl	0x113219310 <_O266DecReleaseOutputPicture+0x1109da4>
1130e422c: 910023e0    	add	x0, sp, #0x8
1130e4230: 910263e1    	add	x1, sp, #0x98
1130e4234: 9404d3b6    	bl	0x11321910c <_O266DecReleaseOutputPicture+0x1109ba0>
1130e4238: 910023e0    	add	x0, sp, #0x8
1130e423c: 9404d3af    	bl	0x1132190f8 <_O266DecReleaseOutputPicture+0x1109b8c>
1130e4240: 3940e661    	ldrb	w1, [x19, #0x39]
1130e4244: f9401660    	ldr	x0, [x19, #0x28]
1130e4248: 96197c6e    	bl	0x10b743400 <_mmkv_importFrom+0x88065c>
1130e424c: 910263e0    	add	x0, sp, #0x98
1130e4250: 9404d3aa    	bl	0x1132190f8 <_O266DecReleaseOutputPicture+0x1109b8c>
1130e4254: 1400001d    	b	0x1130e42c8 <_O266DecReleaseOutputPicture+0xfd4d5c>
1130e4258: f0ffffe8    	adrp	x8, 0x1130e3000 <_O266DecReleaseOutputPicture+0xfd3a94>
1130e425c: 913f9108    	add	x8, x8, #0xfe4 ; 0x1130e3fe4 __text
1130e4260: a909ffe8    	stp	x8, xzr, [sp, #0x98]
1130e4264: f90057f3    	str	x19, [sp, #0xa8]
1130e4268: 3902c3f4    	strb	w20, [sp, #0xb0]
1130e426c: f900bff3    	str	x19, [sp, #0x178]
1130e4270: 9404414e    	bl	0x1131f47a8 <_O266DecReleaseOutputPicture+0x10e523c>
1130e4274: f90097e0    	str	x0, [sp, #0x128]
1130e4278: 9104a3e0    	add	x0, sp, #0x128
1130e427c: 9404416a    	bl	0x1131f4824 <_O266DecReleaseOutputPicture+0x10e52b8>
1130e4280: f900e7e0    	str	x0, [sp, #0x1c8]
1130e4284: b901d3e1    	str	w1, [sp, #0x1d0]
1130e4288: d003bcc1    	adrp	x1, 0x11a87e000 <dyld_stub_binder+0x11a87e000>
1130e428c: 91388021    	add	x1, x1, #0xe20 ; 'ActiveLogic::OnForeground'
1130e4290: 910023e0    	add	x0, sp, #0x8
1130e4294: 97b1cb56    	bl	0x111d56fec <_OnAccessibilityFeaturesChanged+0xbecf78>
1130e4298: d102e3a8    	sub	x8, x29, #0xb8
1130e429c: 910263e0    	add	x0, sp, #0x98
1130e42a0: 9105e3e1    	add	x1, sp, #0x178
1130e42a4: 910723e2    	add	x2, sp, #0x1c8
1130e42a8: 910023e3    	add	x3, sp, #0x8
1130e42ac: 94000014    	bl	0x1130e42fc <_O266DecReleaseOutputPicture+0xfd4d90>
1130e42b0: 39c07fe8    	ldrsb	w8, [sp, #0x1f]
1130e42b4: 36f800a8    	tbz	w8, #0x1f, 0x1130e42c8 <_O266DecReleaseOutputPicture+0xfd4d5c>
1130e42b8: f94007e0    	ldr	x0, [sp, #0x8]
1130e42bc: f9400fe8    	ldr	x8, [sp, #0x18]
1130e42c0: 9240f901    	and	x1, x8, #0x7fffffffffffffff
1130e42c4: 94f5d20f    	bl	0x116e58b00 <dyld_stub_binder+0x116e58b00>
1130e42c8: f85c83a8    	ldur	x8, [x29, #-0x38]
1130e42cc: 90053349    	adrp	x9, 0x11d74c000 <dyld_stub_binder+0x11d74c000>
1130e42d0: f9451929    	ldr	x9, [x9, #0xa30] ; 0x11d74ca30 __got
1130e42d4: f9400129    	ldr	x9, [x9]
1130e42d8: eb08013f    	cmp	x9, x8
1130e42dc: 540000e1    	b.ne	0x1130e42f8 <_O266DecReleaseOutputPicture+0xfd4d8c>
1130e42e0: 910a83ff    	add	sp, sp, #0x2a0
1130e42e4: a9437bfd    	ldp	x29, x30, [sp, #0x30]
1130e42e8: a9424ff4    	ldp	x20, x19, [sp, #0x20]
1130e42ec: a94157f6    	ldp	x22, x21, [sp, #0x10]
1130e42f0: a8c46ffc    	ldp	x28, x27, [sp], #0x40
1130e42f4: d65f03c0    	ret
1130e42f8: 94f5d280    	bl	0x116e58cf8 <dyld_stub_binder+0x116e58cf8>
