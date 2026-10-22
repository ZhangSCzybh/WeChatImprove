
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108ff9000: a9bd57f6    	stp	x22, x21, [sp, #-0x30]!
108ff9004: a9014ff4    	stp	x20, x19, [sp, #0x10]
108ff9008: a9027bfd    	stp	x29, x30, [sp, #0x20]
108ff900c: 910083fd    	add	x29, sp, #0x20
108ff9010: aa0303f4    	mov	x20, x3
108ff9014: aa0203f3    	mov	x19, x2
108ff9018: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff901c: f946f515    	ldr	x21, [x8, #0xde8] ; showsPrivateStatus
108ff9020: aa0303e0    	mov	x0, x3
108ff9024: 95a18907    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ff9028: aa1303e0    	mov	x0, x19
108ff902c: 95a18905    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108ff9030: aa1403e0    	mov	x0, x20
108ff9034: aa1503e1    	mov	x1, x21
108ff9038: 95a18903    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff903c: aa0003e2    	mov	x2, x0
108ff9040: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff9044: f9405901    	ldr	x1, [x8, #0xb0] ; showLockStatus:
108ff9048: aa1303e0    	mov	x0, x19
108ff904c: 95a188fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9050: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff9054: f946f901    	ldr	x1, [x8, #0xdf0] ; showsGroupedStatus
108ff9058: aa1403e0    	mov	x0, x20
108ff905c: 95a188fa    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9060: aa0003e2    	mov	x2, x0
108ff9064: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff9068: f9405d01    	ldr	x1, [x8, #0xb8] ; showSharedStatus:
108ff906c: aa1303e0    	mov	x0, x19
108ff9070: 95a188f5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9074: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff9078: f946f101    	ldr	x1, [x8, #0xde0] ; showsStarredStatus
108ff907c: aa1403e0    	mov	x0, x20
108ff9080: 95a188f1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9084: aa0003e2    	mov	x2, x0
108ff9088: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff908c: f9406101    	ldr	x1, [x8, #0xc0] ; showStarredStatus:
108ff9090: aa1303e0    	mov	x0, x19
108ff9094: 95a188ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff9098: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff909c: f9406501    	ldr	x1, [x8, #0xc8] ; showsLivePhotoStatus
108ff90a0: aa1403e0    	mov	x0, x20
108ff90a4: 95a188e8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff90a8: aa0003e2    	mov	x2, x0
108ff90ac: b00b73a8    	adrp	x8, 0x11fe6e000 <dyld_stub_binder+0x11fe6e000>
108ff90b0: f946f101    	ldr	x1, [x8, #0xde0] ; updateLivePhotoStatus:
108ff90b4: aa1303e0    	mov	x0, x19
108ff90b8: 95a188e3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff90bc: b00b8368    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108ff90c0: f946fd01    	ldr	x1, [x8, #0xdf8] ; showsFailureStatus
108ff90c4: aa1403e0    	mov	x0, x20
108ff90c8: 95a188df    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff90cc: aa0003f5    	mov	x21, x0
108ff90d0: aa1403e0    	mov	x0, x20
108ff90d4: 95a188e2    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108ff90d8: d00b8368    	adrp	x8, 0x120067000 <dyld_stub_binder+0x120067000>
108ff90dc: f9406901    	ldr	x1, [x8, #0xd0] ; showFailedStatus:
108ff90e0: aa1303e0    	mov	x0, x19
108ff90e4: aa1503e2    	mov	x2, x21
108ff90e8: 95a188d7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108ff90ec: aa1303e0    	mov	x0, x19
108ff90f0: a9427bfd    	ldp	x29, x30, [sp, #0x20]
108ff90f4: a9414ff4    	ldp	x20, x19, [sp, #0x10]
108ff90f8: a8c357f6    	ldp	x22, x21, [sp], #0x30
108ff90fc: 15a188d8    	b	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
