
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
115878564: d10183ff    	sub	sp, sp, #0x60
115878568: a9025ff8    	stp	x24, x23, [sp, #0x20]
11587856c: a90357f6    	stp	x22, x21, [sp, #0x30]
115878570: a9044ff4    	stp	x20, x19, [sp, #0x40]
115878574: a9057bfd    	stp	x29, x30, [sp, #0x50]
115878578: 910143fd    	add	x29, sp, #0x50
11587857c: aa0303f4    	mov	x20, x3
115878580: aa0203f3    	mov	x19, x2
115878584: aa0003f5    	mov	x21, x0
115878588: aa0203e0    	mov	x0, x2
11587858c: 94579012    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
115878590: aa1403e0    	mov	x0, x20
115878594: 94579010    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
115878598: d004a808    	adrp	x8, 0x11ed7a000 <dyld_stub_binder+0x11ed7a000>
11587859c: f941d508    	ldr	x8, [x8, #0x3a8]
1158785a0: a90123f5    	stp	x21, x8, [sp, #0x10]
1158785a4: b0048b88    	adrp	x8, 0x11e9e9000 <dyld_stub_binder+0x11e9e9000>
1158785a8: f944c501    	ldr	x1, [x8, #0x988]
1158785ac: d2800017    	mov	x23, #0x0               ; =0
1158785b0: 910043e0    	add	x0, sp, #0x10
1158785b4: aa1303e2    	mov	x2, x19
1158785b8: aa1403e3    	mov	x3, x20
1158785bc: 94578fe5    	bl	0x116e5c550 <dyld_stub_binder+0x116e5c550>
1158785c0: aa0003f5    	mov	x21, x0
1158785c4: b4001940    	cbz	x0, 0x1158788ec <_O266DecReleaseOutputPicture+0x3769380>
1158785c8: f0048a88    	adrp	x8, 0x11e9cb000 <dyld_stub_binder+0x11e9cb000>
1158785cc: f9469d01    	ldr	x1, [x8, #0xd38]
1158785d0: aa1503f7    	mov	x23, x21
1158785d4: aa1503e0    	mov	x0, x21
1158785d8: 52800022    	mov	w2, #0x1                ; =1
1158785dc: 94578fda    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158785e0: 90048aa8    	adrp	x8, 0x11e9cc000 <dyld_stub_binder+0x11e9cc000>
1158785e4: f9442901    	ldr	x1, [x8, #0x850]
1158785e8: aa1503f7    	mov	x23, x21
1158785ec: aa1503e0    	mov	x0, x21
1158785f0: 52800022    	mov	w2, #0x1                ; =1
1158785f4: 94578fd4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158785f8: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
1158785fc: b98f8d08    	ldrsw	x8, [x8, #0xf8c]
115878600: b8286abf    	str	wzr, [x21, x8]
115878604: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115878608: b98f6108    	ldrsw	x8, [x8, #0xf60]
11587860c: f8686aa0    	ldr	x0, [x21, x8]
115878610: f8286abf    	str	xzr, [x21, x8]
115878614: 94578fea    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878618: d004a4c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
11587861c: f943fd00    	ldr	x0, [x8, #0x7f8]
115878620: aa1503f7    	mov	x23, x21
115878624: 94578f71    	bl	0x116e5c3e8 <dyld_stub_binder+0x116e5c3e8>
115878628: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
11587862c: b98f9118    	ldrsw	x24, [x8, #0xf90]
115878630: f8786aa8    	ldr	x8, [x21, x24]
115878634: f8386aa0    	str	x0, [x21, x24]
115878638: aa0803e0    	mov	x0, x8
11587863c: 94578fe0    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878640: d004a4c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
115878644: f9440900    	ldr	x0, [x8, #0x810]
115878648: d004a168    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
11587864c: f942a901    	ldr	x1, [x8, #0x550]
115878650: aa1503f7    	mov	x23, x21
115878654: 94578fbc    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115878658: aa1d03fd    	mov	x29, x29
11587865c: 94578fe7    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
115878660: aa0003f6    	mov	x22, x0
115878664: f8786aa0    	ldr	x0, [x21, x24]
115878668: f004a188    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
11587866c: f9401d01    	ldr	x1, [x8, #0x38]
115878670: aa1603e2    	mov	x2, x22
115878674: 94578fb4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115878678: aa1603e0    	mov	x0, x22
11587867c: 94578fd0    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878680: f8786aa0    	ldr	x0, [x21, x24]
115878684: 9004a1a8    	adrp	x8, 0x11ecac000 <dyld_stub_binder+0x11ecac000>
115878688: f9457101    	ldr	x1, [x8, #0xae0]
11587868c: aa1503f7    	mov	x23, x21
115878690: 52800022    	mov	w2, #0x1                ; =1
115878694: 94578fac    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115878698: f8786aa0    	ldr	x0, [x21, x24]
11587869c: f004a188    	adrp	x8, 0x11ecab000 <dyld_stub_binder+0x11ecab000>
1158786a0: f9476901    	ldr	x1, [x8, #0xed0]
1158786a4: aa1503f7    	mov	x23, x21
1158786a8: 52800082    	mov	w2, #0x4                ; =4
1158786ac: 94578fa6    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158786b0: b003f688    	adrp	x8, 0x11d749000 <dyld_stub_binder+0x11d749000>
1158786b4: f9449908    	ldr	x8, [x8, #0x930]
1158786b8: f9400102    	ldr	x2, [x8]
1158786bc: f8786aa0    	ldr	x0, [x21, x24]
1158786c0: f0048ac8    	adrp	x8, 0x11e9d3000 <dyld_stub_binder+0x11e9d3000>
1158786c4: f941fd01    	ldr	x1, [x8, #0x3f8]
1158786c8: aa1503f7    	mov	x23, x21
1158786cc: 94578f9e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158786d0: d004a4c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
1158786d4: f943c100    	ldr	x0, [x8, #0x780]
1158786d8: b0048a88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1158786dc: f9440101    	ldr	x1, [x8, #0x800]
1158786e0: aa1503f7    	mov	x23, x21
1158786e4: 94578f98    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158786e8: aa1d03fd    	mov	x29, x29
1158786ec: 94578fc3    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1158786f0: aa0003f6    	mov	x22, x0
1158786f4: f004a4a8    	adrp	x8, 0x11ed0f000 <dyld_stub_binder+0x11ed0f000>
1158786f8: f944c502    	ldr	x2, [x8, #0x988]
1158786fc: b0048a88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
115878700: f9478501    	ldr	x1, [x8, #0xf08]
115878704: aa1503e3    	mov	x3, x21
115878708: 94578f8f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11587870c: aa1603e0    	mov	x0, x22
115878710: 94578fab    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878714: d004a4c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
115878718: f9442100    	ldr	x0, [x8, #0x840]
11587871c: 90048ae8    	adrp	x8, 0x11e9d4000 <dyld_stub_binder+0x11e9d4000>
115878720: f946dd03    	ldr	x3, [x8, #0xdb8]
115878724: b0049568    	adrp	x8, 0x11eb25000 <dyld_stub_binder+0x11eb25000>
115878728: f946d501    	ldr	x1, [x8, #0xda8]
11587872c: aa1503f7    	mov	x23, x21
115878730: aa1503e2    	mov	x2, x21
115878734: 94578f84    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115878738: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
11587873c: b98f9508    	ldrsw	x8, [x8, #0xf94]
115878740: 52800029    	mov	w9, #0x1                ; =1
115878744: 38286aa9    	strb	w9, [x21, x8]
115878748: b004a5c8    	adrp	x8, 0x11ed31000 <dyld_stub_binder+0x11ed31000>
11587874c: f9425500    	ldr	x0, [x8, #0x4a8]
115878750: aa1503f7    	mov	x23, x21
115878754: 94578f1f    	bl	0x116e5c3d0 <dyld_stub_binder+0x116e5c3d0>
115878758: 9004a188    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
11587875c: f9418501    	ldr	x1, [x8, #0x308]
115878760: d2e80848    	mov	x8, #0x4042000000000000 ; =4630263366890291200
115878764: 9e670103    	fmov	d3, x8
115878768: 9e6703e0    	fmov	d0, xzr
11587876c: 9e6703e1    	fmov	d1, xzr
115878770: 1e6e1002    	fmov	d2, #1.00000000
115878774: aa1503f7    	mov	x23, x21
115878778: 94578f73    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11587877c: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115878780: b98f8509    	ldrsw	x9, [x8, #0xf84]
115878784: f8696aa8    	ldr	x8, [x21, x9]
115878788: f8296aa0    	str	x0, [x21, x9]
11587878c: aa0803e0    	mov	x0, x8
115878790: 94578f8b    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878794: d004a4c8    	adrp	x8, 0x11ed12000 <dyld_stub_binder+0x11ed12000>
115878798: f9431900    	ldr	x0, [x8, #0x630]
11587879c: aa1503f7    	mov	x23, x21
1158787a0: 94578f12    	bl	0x116e5c3e8 <dyld_stub_binder+0x116e5c3e8>
1158787a4: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
1158787a8: b98f9909    	ldrsw	x9, [x8, #0xf98]
1158787ac: f8696aa8    	ldr	x8, [x21, x9]
1158787b0: f8296aa0    	str	x0, [x21, x9]
1158787b4: aa0803e0    	mov	x0, x8
1158787b8: 94578f81    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1158787bc: 9004a0e8    	adrp	x8, 0x11ec94000 <dyld_stub_binder+0x11ec94000>
1158787c0: f947f901    	ldr	x1, [x8, #0xff0]
1158787c4: aa1503f7    	mov	x23, x21
1158787c8: aa1503e0    	mov	x0, x21
1158787cc: 94578f5e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158787d0: b004a168    	adrp	x8, 0x11eca5000 <dyld_stub_binder+0x11eca5000>
1158787d4: f9452516    	ldr	x22, [x8, #0xa48]
1158787d8: b003f143    	adrp	x3, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
1158787dc: 910de063    	add	x3, x3, #0x378
1158787e0: aa1503f7    	mov	x23, x21
1158787e4: aa1503e0    	mov	x0, x21
1158787e8: aa1603e1    	mov	x1, x22
1158787ec: aa1503e2    	mov	x2, x21
1158787f0: 52800024    	mov	w4, #0x1                ; =1
1158787f4: d2800005    	mov	x5, #0x0                ; =0
1158787f8: 94578f53    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158787fc: b003f143    	adrp	x3, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
115878800: 910e6063    	add	x3, x3, #0x398
115878804: aa1503f7    	mov	x23, x21
115878808: aa1503e0    	mov	x0, x21
11587880c: aa1603e1    	mov	x1, x22
115878810: aa1503e2    	mov	x2, x21
115878814: 52800024    	mov	w4, #0x1                ; =1
115878818: d2800005    	mov	x5, #0x0                ; =0
11587881c: 94578f4a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115878820: b003f143    	adrp	x3, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
115878824: 910ee063    	add	x3, x3, #0x3b8
115878828: aa1503f7    	mov	x23, x21
11587882c: aa1503e0    	mov	x0, x21
115878830: aa1603e1    	mov	x1, x22
115878834: aa1503e2    	mov	x2, x21
115878838: 52800024    	mov	w4, #0x1                ; =1
11587883c: d2800005    	mov	x5, #0x0                ; =0
115878840: 94578f41    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
115878844: b003f143    	adrp	x3, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
115878848: 910f6063    	add	x3, x3, #0x3d8
11587884c: 52800038    	mov	w24, #0x1               ; =1
115878850: aa1503f7    	mov	x23, x21
115878854: aa1503e0    	mov	x0, x21
115878858: aa1603e1    	mov	x1, x22
11587885c: aa1503e2    	mov	x2, x21
115878860: 52800024    	mov	w4, #0x1                ; =1
115878864: d2800005    	mov	x5, #0x0                ; =0
115878868: 94578f37    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
11587886c: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115878870: b98f9d08    	ldrsw	x8, [x8, #0xf9c]
115878874: f8686aa0    	ldr	x0, [x21, x8]
115878878: f8286abf    	str	xzr, [x21, x8]
11587887c: 94578f50    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878880: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115878884: b98fa108    	ldrsw	x8, [x8, #0xfa0]
115878888: 38286abf    	strb	wzr, [x21, x8]
11587888c: d004adc8    	adrp	x8, 0x11ee32000 <dyld_stub_binder+0x11ee32000>
115878890: b98fa508    	ldrsw	x8, [x8, #0xfa4]
115878894: 38286ab8    	strb	w24, [x21, x8]
115878898: d004a688    	adrp	x8, 0x11ed4a000 <dyld_stub_binder+0x11ed4a000>
11587889c: f9440d00    	ldr	x0, [x8, #0x818]
1158788a0: b0048aa8    	adrp	x8, 0x11e9cd000 <dyld_stub_binder+0x11e9cd000>
1158788a4: f9411101    	ldr	x1, [x8, #0x220]
1158788a8: aa1503f7    	mov	x23, x21
1158788ac: 94578f26    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158788b0: b0048a88    	adrp	x8, 0x11e9c9000 <dyld_stub_binder+0x11e9c9000>
1158788b4: f9418901    	ldr	x1, [x8, #0x310]
1158788b8: b003f148    	adrp	x8, 0x11d6a1000 <dyld_stub_binder+0x11d6a1000>
1158788bc: 910fe108    	add	x8, x8, #0x3f8
1158788c0: b002c5c5    	adrp	x5, 0x11b131000 <dyld_stub_binder+0x11b131000>
1158788c4: 911d5ca5    	add	x5, x5, #0x757
1158788c8: a90057e8    	stp	x8, x21, [sp]
1158788cc: b002c5c7    	adrp	x7, 0x11b131000 <dyld_stub_binder+0x11b131000>
1158788d0: 912790e7    	add	x7, x7, #0x9e4
1158788d4: aa1503f7    	mov	x23, x21
1158788d8: 52800042    	mov	w2, #0x2                ; =2
1158788dc: d2800003    	mov	x3, #0x0                ; =0
1158788e0: 52800004    	mov	w4, #0x0                ; =0
1158788e4: 52804886    	mov	w6, #0x244              ; =580
1158788e8: 94578f17    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1158788ec: aa1403e0    	mov	x0, x20
1158788f0: 94578f33    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1158788f4: aa1303e0    	mov	x0, x19
1158788f8: 94578f31    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1158788fc: aa1503e0    	mov	x0, x21
115878900: a9457bfd    	ldp	x29, x30, [sp, #0x50]
115878904: a9444ff4    	ldp	x20, x19, [sp, #0x40]
115878908: a94357f6    	ldp	x22, x21, [sp, #0x30]
11587890c: a9425ff8    	ldp	x24, x23, [sp, #0x20]
115878910: 910183ff    	add	sp, sp, #0x60
115878914: d65f03c0    	ret
115878918: 14000001    	b	0x11587891c <_O266DecReleaseOutputPicture+0x37693b0>
11587891c: aa1603e1    	mov	x1, x22
115878920: aa0003f6    	mov	x22, x0
115878924: aa0103e0    	mov	x0, x1
115878928: 94578f25    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
11587892c: 14000003    	b	0x115878938 <_O266DecReleaseOutputPicture+0x37693cc>
115878930: aa0003f6    	mov	x22, x0
115878934: aa1703f5    	mov	x21, x23
115878938: aa1403e0    	mov	x0, x20
11587893c: 94578f20    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878940: aa1303e0    	mov	x0, x19
115878944: 94578f1e    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878948: aa1503e0    	mov	x0, x21
11587894c: 94578f1c    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
115878950: aa1603e0    	mov	x0, x22
115878954: 945768e3    	bl	0x116e52ce0 <dyld_stub_binder+0x116e52ce0>
