
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
108fe54d4: 6dbc23e9    	stp	d9, d8, [sp, #-0x40]!
108fe54d8: a90157f6    	stp	x22, x21, [sp, #0x10]
108fe54dc: a9024ff4    	stp	x20, x19, [sp, #0x20]
108fe54e0: a9037bfd    	stp	x29, x30, [sp, #0x30]
108fe54e4: 9100c3fd    	add	x29, sp, #0x30
108fe54e8: aa0303f5    	mov	x21, x3
108fe54ec: aa0203f6    	mov	x22, x2
108fe54f0: 900be348    	adrp	x8, 0x120c4d000 <dyld_stub_binder+0x120c4d000>
108fe54f4: 52800029    	mov	w9, #0x1                ; =1
108fe54f8: 39386d09    	strb	w9, [x8, #0xe1b]
108fe54fc: b00b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe5500: f946e913    	ldr	x19, [x8, #0xdd0] ; m_arrPhotoDatas
108fe5504: aa0303e0    	mov	x0, x3
108fe5508: 95a1d7ce    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108fe550c: aa1603e0    	mov	x0, x22
108fe5510: 95a1d7cc    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
108fe5514: aa1503e0    	mov	x0, x21
108fe5518: aa1303e1    	mov	x1, x19
108fe551c: 95a1d7ca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe5520: aa1d03fd    	mov	x29, x29
108fe5524: 95a1d7cb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe5528: aa0003f4    	mov	x20, x0
108fe552c: 900b88e8    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
108fe5530: f9452101    	ldr	x1, [x8, #0xa40] ; firstObject
108fe5534: 95a1d7c4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe5538: aa1d03fd    	mov	x29, x29
108fe553c: 95a1d7c5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe5540: aa0003f3    	mov	x19, x0
108fe5544: aa1403e0    	mov	x0, x20
108fe5548: 95a1d7c5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe554c: d00b8e08    	adrp	x8, 0x1201a7000 <dyld_stub_binder+0x1201a7000>
108fe5550: f9401500    	ldr	x0, [x8, #0x28]
108fe5554: b00b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe5558: f946ed01    	ldr	x1, [x8, #0xdd8] ; statusInfoWithDataItem:inGroup:groupItem:
108fe555c: aa1303e2    	mov	x2, x19
108fe5560: aa1603e3    	mov	x3, x22
108fe5564: aa1503e4    	mov	x4, x21
108fe5568: 95a1d7b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe556c: aa1d03fd    	mov	x29, x29
108fe5570: 95a1d7b8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
108fe5574: aa0003f4    	mov	x20, x0
108fe5578: aa1503e0    	mov	x0, x21
108fe557c: 95a1d7b8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe5580: aa1603e0    	mov	x0, x22
108fe5584: 95a1d7b6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe5588: b00b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe558c: f946f101    	ldr	x1, [x8, #0xde0] ; showsStarredStatus
108fe5590: aa1403e0    	mov	x0, x20
108fe5594: 95a1d7ac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe5598: 7100001f    	cmp	w0, #0x0
108fe559c: 1e721000    	fmov	d0, #-4.00000000
108fe55a0: 1e661001    	fmov	d1, #16.00000000
108fe55a4: 1e601c28    	fcsel	d8, d1, d0, ne
108fe55a8: b00b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe55ac: f946f501    	ldr	x1, [x8, #0xde8] ; showsPrivateStatus
108fe55b0: aa1403e0    	mov	x0, x20
108fe55b4: 95a1d7a4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe55b8: 1e669009    	fmov	d9, #20.00000000
108fe55bc: 1e692900    	fadd	d0, d8, d9
108fe55c0: 7100001f    	cmp	w0, #0x0
108fe55c4: 1e681c08    	fcsel	d8, d0, d8, ne
108fe55c8: b00b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe55cc: f946f901    	ldr	x1, [x8, #0xdf0] ; showsGroupedStatus
108fe55d0: aa1403e0    	mov	x0, x20
108fe55d4: 95a1d79c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe55d8: 1e692900    	fadd	d0, d8, d9
108fe55dc: 7100001f    	cmp	w0, #0x0
108fe55e0: 1e681c08    	fcsel	d8, d0, d8, ne
108fe55e4: b00b8408    	adrp	x8, 0x120066000 <dyld_stub_binder+0x120066000>
108fe55e8: f946fd01    	ldr	x1, [x8, #0xdf8] ; showsFailureStatus
108fe55ec: aa1403e0    	mov	x0, x20
108fe55f0: 95a1d795    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
108fe55f4: 1e692900    	fadd	d0, d8, d9
108fe55f8: 7100001f    	cmp	w0, #0x0
108fe55fc: 1e681c00    	fcsel	d0, d0, d8, ne
108fe5600: 1e602008    	fcmp	d0, #0.0
108fe5604: 9e6703e1    	fmov	d1, xzr
108fe5608: 1e604c28    	fcsel	d8, d1, d0, mi
108fe560c: aa1403e0    	mov	x0, x20
108fe5610: 95a1d793    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe5614: aa1303e0    	mov	x0, x19
108fe5618: 95a1d791    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
108fe561c: 1e604100    	fmov	d0, d8
108fe5620: a9437bfd    	ldp	x29, x30, [sp, #0x30]
108fe5624: a9424ff4    	ldp	x20, x19, [sp, #0x20]
108fe5628: a94157f6    	ldp	x22, x21, [sp, #0x10]
108fe562c: 6cc423e9    	ldp	d9, d8, [sp], #0x40
108fe5630: d65f03c0    	ret
