
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ff9100: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
108ff9104: a9014ff4    	stp	x20, x19, [sp, #0x10]
108ff9108: a9027bfd    	stp	x29, x30, [sp, #0x20]
108ff910c: 910083fd    	add	x29, sp, #0x20
108ff9110: aa0303f4    	mov	x20, x3
108ff9114: aa0203f3    	mov	x19, x2
108ff9118: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff911c: f946f515    	ldr	x21, [x8, #0xde8] ; showsPrivateStatus
108ff9120: aa0303e0    	mov	x0, x3
108ff9124: 95a188c7    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ff9128: aa1303e0    	mov	x0, x19
108ff912c: 95a188c5    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ff9130: aa1403e0    	mov	x0, x20
108ff9134: aa1503e1    	mov	x1, x21
108ff9138: 95a188c3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff913c: aa0003e2    	mov	x2, x0
108ff9140: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff9144: f9405901    	ldr	x1, [x8, #0xb0] ; showLockStatus:
108ff9148: aa1303e0    	mov	x0, x19
108ff914c: 95a188be    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9150: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff9154: f946f901    	ldr	x1, [x8, #0xdf0] ; showsGroupedStatus
108ff9158: aa1403e0    	mov	x0, x20
108ff915c: 95a188ba    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9160: aa0003e2    	mov	x2, x0
108ff9164: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff9168: f9405d01    	ldr	x1, [x8, #0xb8] ; showSharedStatus:
108ff916c: aa1303e0    	mov	x0, x19
108ff9170: 95a188b5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9174: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff9178: f946f101    	ldr	x1, [x8, #0xde0] ; showsStarredStatus
108ff917c: aa1403e0    	mov	x0, x20
108ff9180: 95a188b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9184: aa0003e2    	mov	x2, x0
108ff9188: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff918c: f9406101    	ldr	x1, [x8, #0xc0] ; showStarredStatus:
108ff9190: aa1303e0    	mov	x0, x19
108ff9194: 95a188ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9198: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff919c: f9406501    	ldr	x1, [x8, #0xc8] ; showsLivePhotoStatus
108ff91a0: aa1403e0    	mov	x0, x20
108ff91a4: 95a188a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff91a8: aa0003e2    	mov	x2, x0
108ff91ac: b00b73a8    	adrp	x8, 0x11fe6e000 <dyld_stub_binder+0x11fe6e000>
108ff91b0: f946f101    	ldr	x1, [x8, #0xde0] ; updateLivePhotoStatus:
108ff91b4: aa1303e0    	mov	x0, x19
108ff91b8: 95a188a3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff91bc: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff91c0: f946fd01    	ldr	x1, [x8, #0xdf8] ; showsFailureStatus
108ff91c4: aa1403e0    	mov	x0, x20
108ff91c8: 95a1889f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff91cc: aa0003f5    	mov	x21, x0
108ff91d0: aa1403e0    	mov	x0, x20
108ff91d4: 95a188a2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ff91d8: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff91dc: f9406901    	ldr	x1, [x8, #0xd0] ; showFailedStatus:
108ff91e0: aa1303e0    	mov	x0, x19
108ff91e4: aa1503e2    	mov	x2, x21
108ff91e8: 95a18897    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff91ec: aa1303e0    	mov	x0, x19
108ff91f0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
108ff91f4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
108ff91f8: a8c357f6    	ldp	x22, x21, [sp], #0x30
108ff91fc: 15a18898    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
