
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
1010a4030: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
1010a4034: a9017bfd    	stp	x29, x30, [sp, #0x10]
1010a4038: 910043fd    	add	x29, sp, #0x10
1010a403c: aa0203f3    	mov	x19, x2
1010a4040: aa0003f4    	mov	x20, x0
1010a4044: 900fdc68    	adrp	x8, 0x120c30000 <dyld_stub_binder+0x120c30000>
1010a4048: 52800029    	mov	w9, #0x1                ; =1
1010a404c: 393cdd09    	strb	w9, [x8, #0xf37]
1010a4050: aa0203e0    	mov	x0, x2
1010a4054: 95ae0c39    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
1010a4058: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a405c: b9863108    	ldrsw	x8, [x8, #0x630]
1010a4060: 38286a9f    	strb	wzr, [x20, x8]
1010a4064: d00f8a28    	adrp	x8, 0x1201ea000 <dyld_stub_binder+0x1201ea000>
1010a4068: b9863508    	ldrsw	x8, [x8, #0x634]
1010a406c: b8686a88    	ldr	w8, [x20, x8]
1010a4070: 7100b51f    	cmp	w8, #0x2d
1010a4074: 54000e08    	b.hi	0x1010a4234 <__text+0x109c234>
1010a4078: 900be709    	adrp	x9, 0x118d84000 <dyld_stub_binder+0x118d84000>
1010a407c: 9124c129    	add	x9, x9, #0x930
1010a4080: 1000008a    	adr	x10, 0x1010a4090 <__text+0x109c090>
1010a4084: 3868692b    	ldrb	w11, [x9, x8]
1010a4088: 8b0b094a    	add	x10, x10, x11, lsl #2
1010a408c: d61f0140    	br	x10
1010a4090: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4094: f941c101    	ldr	x1, [x8, #0x380] ; filterHistoryGroupContacts:IgnoreOpenim:
1010a4098: aa1403e0    	mov	x0, x20
1010a409c: aa1303e2    	mov	x2, x19
1010a40a0: 52800023    	mov	w3, #0x1                ; =1
1010a40a4: 14000038    	b	0x1010a4184 <__text+0x109c184>
1010a40a8: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a40ac: f941c101    	ldr	x1, [x8, #0x380] ; filterHistoryGroupContacts:IgnoreOpenim:
1010a40b0: 14000032    	b	0x1010a4178 <__text+0x109c178>
1010a40b4: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a40b8: f941b901    	ldr	x1, [x8, #0x370] ; filterMultiSelectContacts:IgnoreOpenim:
1010a40bc: 17fffff7    	b	0x1010a4098 <__text+0x109c098>
1010a40c0: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a40c4: f941b501    	ldr	x1, [x8, #0x368] ; filterSelectContacts:
1010a40c8: 14000058    	b	0x1010a4228 <__text+0x109c228>
1010a40cc: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a40d0: f941bd01    	ldr	x1, [x8, #0x378] ; filterGroupContacts:IgnoreOpenim:
1010a40d4: 14000029    	b	0x1010a4178 <__text+0x109c178>
1010a40d8: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a40dc: f941f901    	ldr	x1, [x8, #0x3f0] ; filterCustomizationSelectContacts:
1010a40e0: 14000052    	b	0x1010a4228 <__text+0x109c228>
1010a40e4: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a40e8: f941d501    	ldr	x1, [x8, #0x3a8] ; filterOnlyWeixinContact:IgnoreOpenim:ignoreSelf:ignoreFileHelpr:
1010a40ec: aa1403e0    	mov	x0, x20
1010a40f0: aa1303e2    	mov	x2, x19
1010a40f4: 52800023    	mov	w3, #0x1                ; =1
1010a40f8: 52800024    	mov	w4, #0x1                ; =1
1010a40fc: 52800025    	mov	w5, #0x1                ; =1
1010a4100: 1400002d    	b	0x1010a41b4 <__text+0x109c1b4>
1010a4104: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4108: f941c501    	ldr	x1, [x8, #0x388] ; filterCanUpgradeOpenIMGroupContacts:
1010a410c: 14000047    	b	0x1010a4228 <__text+0x109c228>
1010a4110: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4114: f941e901    	ldr	x1, [x8, #0x3d0] ; filterOnlyBrandContactContact:brandType:
1010a4118: aa1403e0    	mov	x0, x20
1010a411c: aa1303e2    	mov	x2, x19
1010a4120: d2800003    	mov	x3, #0x0                ; =0
1010a4124: 14000031    	b	0x1010a41e8 <__text+0x109c1e8>
1010a4128: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a412c: f941d501    	ldr	x1, [x8, #0x3a8] ; filterOnlyWeixinContact:IgnoreOpenim:ignoreSelf:ignoreFileHelpr:
1010a4130: aa1403e0    	mov	x0, x20
1010a4134: aa1303e2    	mov	x2, x19
1010a4138: 52800023    	mov	w3, #0x1                ; =1
1010a413c: 1400001c    	b	0x1010a41ac <__text+0x109c1ac>
1010a4140: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4144: f941dd01    	ldr	x1, [x8, #0x3b8] ; filterVoiceContact:
1010a4148: 14000038    	b	0x1010a4228 <__text+0x109c228>
1010a414c: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4150: f941e501    	ldr	x1, [x8, #0x3c8] ; filterTransferMoneySimpleSessionContacts:
1010a4154: 14000035    	b	0x1010a4228 <__text+0x109c228>
1010a4158: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a415c: f941ed01    	ldr	x1, [x8, #0x3d8] ; filterForSearchContact:
1010a4160: 14000032    	b	0x1010a4228 <__text+0x109c228>
1010a4164: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4168: f941bd01    	ldr	x1, [x8, #0x378] ; filterGroupContacts:IgnoreOpenim:
1010a416c: 17ffffcb    	b	0x1010a4098 <__text+0x109c098>
1010a4170: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4174: f941b901    	ldr	x1, [x8, #0x370] ; filterMultiSelectContacts:IgnoreOpenim:
1010a4178: aa1403e0    	mov	x0, x20
1010a417c: aa1303e2    	mov	x2, x19
1010a4180: 52800003    	mov	w3, #0x0                ; =0
1010a4184: 95ae0bee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4188: 1400002b    	b	0x1010a4234 <__text+0x109c234>
1010a418c: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4190: f941b101    	ldr	x1, [x8, #0x360] ; filterContactsViewContacts:
1010a4194: 14000025    	b	0x1010a4228 <__text+0x109c228>
1010a4198: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a419c: f941d501    	ldr	x1, [x8, #0x3a8] ; filterOnlyWeixinContact:IgnoreOpenim:ignoreSelf:ignoreFileHelpr:
1010a41a0: aa1403e0    	mov	x0, x20
1010a41a4: aa1303e2    	mov	x2, x19
1010a41a8: 52800003    	mov	w3, #0x0                ; =0
1010a41ac: 52800004    	mov	w4, #0x0                ; =0
1010a41b0: 52800005    	mov	w5, #0x0                ; =0
1010a41b4: 95ae0be2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a41b8: 1400001f    	b	0x1010a4234 <__text+0x109c234>
1010a41bc: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a41c0: f941f101    	ldr	x1, [x8, #0x3e0] ; filterSingleSelectSession:
1010a41c4: 14000019    	b	0x1010a4228 <__text+0x109c228>
1010a41c8: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a41cc: f941c901    	ldr	x1, [x8, #0x390] ; filterSelectWithBrandContacts:IgnoreOpenim:
1010a41d0: 17ffffb2    	b	0x1010a4098 <__text+0x109c098>
1010a41d4: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a41d8: f941e901    	ldr	x1, [x8, #0x3d0] ; filterOnlyBrandContactContact:brandType:
1010a41dc: aa1403e0    	mov	x0, x20
1010a41e0: aa1303e2    	mov	x2, x19
1010a41e4: 52800023    	mov	w3, #0x1                ; =1
1010a41e8: 95ae0bd5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a41ec: 14000012    	b	0x1010a4234 <__text+0x109c234>
1010a41f0: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a41f4: f941f501    	ldr	x1, [x8, #0x3e8] ; filterSelectOpenIMContacts:
1010a41f8: 1400000c    	b	0x1010a4228 <__text+0x109c228>
1010a41fc: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4200: f941d101    	ldr	x1, [x8, #0x3a0] ; filterMutilSelectWithBakChatFilter:
1010a4204: 14000009    	b	0x1010a4228 <__text+0x109c228>
1010a4208: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a420c: f941cd01    	ldr	x1, [x8, #0x398] ; filterSelectWithVerifyedContacts:
1010a4210: 14000006    	b	0x1010a4228 <__text+0x109c228>
1010a4214: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4218: f941d901    	ldr	x1, [x8, #0x3b0] ; filterVideoContact:
1010a421c: 14000003    	b	0x1010a4228 <__text+0x109c228>
1010a4220: d00f6f28    	adrp	x8, 0x11fe8a000 <dyld_stub_binder+0x11fe8a000>
1010a4224: f941e101    	ldr	x1, [x8, #0x3c0] ; filterTransferMoneyContacts:
1010a4228: aa1403e0    	mov	x0, x20
1010a422c: aa1303e2    	mov	x2, x19
1010a4230: 95ae0bc3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1010a4234: aa1303e0    	mov	x0, x19
1010a4238: a9417bfd    	ldp	x29, x30, [sp, #0x10]
1010a423c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
1010a4240: 15ae0bc5    	b	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
