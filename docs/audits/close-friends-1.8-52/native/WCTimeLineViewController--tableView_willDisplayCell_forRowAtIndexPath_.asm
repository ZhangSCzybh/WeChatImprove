
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000103b2441c <_Flutter_MMFoundation_BindContext>:
10a0c4378: d10383ff    	sub	sp, sp, #0xe0
10a0c437c: a9086ffc    	stp	x28, x27, [sp, #0x80]
10a0c4380: a90967fa    	stp	x26, x25, [sp, #0x90]
10a0c4384: a90a5ff8    	stp	x24, x23, [sp, #0xa0]
10a0c4388: a90b57f6    	stp	x22, x21, [sp, #0xb0]
10a0c438c: a90c4ff4    	stp	x20, x19, [sp, #0xc0]
10a0c4390: a90d7bfd    	stp	x29, x30, [sp, #0xd0]
10a0c4394: 910343fd    	add	x29, sp, #0xd0
10a0c4398: aa0403f8    	mov	x24, x4
10a0c439c: aa0303f7    	mov	x23, x3
10a0c43a0: aa0203f4    	mov	x20, x2
10a0c43a4: aa0003f6    	mov	x22, x0
10a0c43a8: b00b5c68    	adrp	x8, 0x120c51000 <dyld_stub_binder+0x120c51000>
10a0c43ac: 52800029    	mov	w9, #0x1                ; =1
10a0c43b0: 39126509    	strb	w9, [x8, #0x499]
10a0c43b4: aa0203e0    	mov	x0, x2
10a0c43b8: 955e5c22    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0c43bc: aa1703e0    	mov	x0, x23
10a0c43c0: 955e5c20    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0c43c4: aa1803e0    	mov	x0, x24
10a0c43c8: 955e5c1e    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0c43cc: 900b0228    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
10a0c43d0: f947a101    	ldr	x1, [x8, #0xf40] ; setNeedsLayout
10a0c43d4: aa1703e0    	mov	x0, x23
10a0c43d8: 955e5c1b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c43dc: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c43e0: f9432d01    	ldr	x1, [x8, #0x658] ; refreshScrollBouncingState
10a0c43e4: aa1603e0    	mov	x0, x22
10a0c43e8: 955e5c17    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c43ec: d00b0208    	adrp	x8, 0x120106000 <dyld_stub_binder+0x120106000>
10a0c43f0: f9440901    	ldr	x1, [x8, #0x810] ; row
10a0c43f4: aa1803e0    	mov	x0, x24
10a0c43f8: f90017e1    	str	x1, [sp, #0x28]
10a0c43fc: 955e5c12    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4400: f9002be0    	str	x0, [sp, #0x50]
10a0c4404: 900b0d88    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0c4408: b9825d08    	ldrsw	x8, [x8, #0x25c]
10a0c440c: 38686ac9    	ldrb	w9, [x22, x8]
10a0c4410: 7100053f    	cmp	w9, #0x1
10a0c4414: 54000321    	b.ne	0x10a0c4478 <_Flutter_MMFoundation_BindContext+0x65a005c>
10a0c4418: 38286adf    	strb	wzr, [x22, x8]
10a0c441c: d00aec68    	adrp	x8, 0x11fe52000 <dyld_stub_binder+0x11fe52000>
10a0c4420: f9403101    	ldr	x1, [x8, #0x60] ; footerView
10a0c4424: aa1603e0    	mov	x0, x22
10a0c4428: 955e5c07    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c442c: aa1d03fd    	mov	x29, x29
10a0c4430: 955e5c08    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4434: aa0003f3    	mov	x19, x0
10a0c4438: d00b0228    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10a0c443c: f947bd01    	ldr	x1, [x8, #0xf78] ; tableView
10a0c4440: aa1603e0    	mov	x0, x22
10a0c4444: 955e5c00    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4448: aa1d03fd    	mov	x29, x29
10a0c444c: 955e5c01    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4450: aa0003f5    	mov	x21, x0
10a0c4454: 900aecc8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a0c4458: f9473901    	ldr	x1, [x8, #0xe70] ; refreshScrollViewDataSourceDidFinishedLoading:
10a0c445c: aa1303e0    	mov	x0, x19
10a0c4460: aa1503e2    	mov	x2, x21
10a0c4464: 955e5bf8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4468: aa1503e0    	mov	x0, x21
10a0c446c: 955e5bfc    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4470: aa1303e0    	mov	x0, x19
10a0c4474: 955e5bfa    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4478: 900b0d88    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0c447c: b9820108    	ldrsw	x8, [x8, #0x200]
10a0c4480: f8686ac0    	ldr	x0, [x22, x8]
10a0c4484: 900b01e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0c4488: f9424d13    	ldr	x19, [x8, #0x498] ; containsObject:
10a0c448c: aa1303e1    	mov	x1, x19
10a0c4490: aa1803e2    	mov	x2, x24
10a0c4494: 955e5bec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4498: a90353f7    	stp	x23, x20, [sp, #0x30]
10a0c449c: 370001e0    	tbnz	w0, #0x0, 0x10a0c44d8 <_Flutter_MMFoundation_BindContext+0x65a00bc>
10a0c44a0: 900b0d88    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0c44a4: b981fd14    	ldrsw	x20, [x8, #0x1fc]
10a0c44a8: f8746ac0    	ldr	x0, [x22, x20]
10a0c44ac: aa1303e1    	mov	x1, x19
10a0c44b0: aa1803e2    	mov	x2, x24
10a0c44b4: 955e5be4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c44b8: 34000100    	cbz	w0, 0x10a0c44d8 <_Flutter_MMFoundation_BindContext+0x65a00bc>
10a0c44bc: f8746ac0    	ldr	x0, [x22, x20]
10a0c44c0: 900aebe8    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
10a0c44c4: f944c101    	ldr	x1, [x8, #0x980] ; safeRemoveObject:
10a0c44c8: aa1803e2    	mov	x2, x24
10a0c44cc: 955e5bde    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c44d0: 5280001a    	mov	w26, #0x0               ; =0
10a0c44d4: 14000002    	b	0x10a0c44dc <_Flutter_MMFoundation_BindContext+0x65a00c0>
10a0c44d8: 5280003a    	mov	w26, #0x1               ; =1
10a0c44dc: 900aebc8    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
10a0c44e0: f9427d01    	ldr	x1, [x8, #0x4f8] ; section
10a0c44e4: f90023f8    	str	x24, [sp, #0x40]
10a0c44e8: aa1803e0    	mov	x0, x24
10a0c44ec: 955e5bd6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c44f0: aa0003e2    	mov	x2, x0
10a0c44f4: d00afe88    	adrp	x8, 0x120096000 <dyld_stub_binder+0x120096000>
10a0c44f8: f944e501    	ldr	x1, [x8, #0x9c8] ; calcDataItemIndex:
10a0c44fc: aa1603e0    	mov	x0, x22
10a0c4500: 955e5bd1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4504: aa0003f3    	mov	x19, x0
10a0c4508: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c450c: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c4510: 900b01e8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0c4514: f944e919    	ldr	x25, [x8, #0x9d0] ; currentContext
10a0c4518: aa1903e1    	mov	x1, x25
10a0c451c: 955e5bca    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4520: aa1d03fd    	mov	x29, x29
10a0c4524: 955e5bcb    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4528: aa0003f5    	mov	x21, x0
10a0c452c: 900b0588    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4530: f9428500    	ldr	x0, [x8, #0x508]
10a0c4534: f00b01c8    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
10a0c4538: f947ad18    	ldr	x24, [x8, #0xf58] ; class
10a0c453c: aa1803e1    	mov	x1, x24
10a0c4540: 955e5bc1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4544: aa0003e2    	mov	x2, x0
10a0c4548: b00aeba8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0c454c: f946411b    	ldr	x27, [x8, #0xc80] ; getService:
10a0c4550: aa1503e0    	mov	x0, x21
10a0c4554: aa1b03e1    	mov	x1, x27
10a0c4558: 955e5bbb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c455c: aa1d03fd    	mov	x29, x29
10a0c4560: 955e5bbc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4564: aa0003fc    	mov	x28, x0
10a0c4568: b00afa08    	adrp	x8, 0x120005000 <dyld_stub_binder+0x120005000>
10a0c456c: f944c501    	ldr	x1, [x8, #0x988] ; getTimelineDataItemOfIndex:
10a0c4570: aa1303e2    	mov	x2, x19
10a0c4574: 955e5bb4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4578: aa1d03fd    	mov	x29, x29
10a0c457c: 955e5bb5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4580: aa0003f7    	mov	x23, x0
10a0c4584: aa1c03e0    	mov	x0, x28
10a0c4588: 955e5bb5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c458c: aa1503e0    	mov	x0, x21
10a0c4590: 955e5bb3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4594: d00aee48    	adrp	x8, 0x11fe8e000 <dyld_stub_binder+0x11fe8e000>
10a0c4598: f942ad1c    	ldr	x28, [x8, #0x558] ; isAd
10a0c459c: aa1703e0    	mov	x0, x23
10a0c45a0: aa1c03e1    	mov	x1, x28
10a0c45a4: 955e5ba8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c45a8: f9402be8    	ldr	x8, [sp, #0x50]
10a0c45ac: b5000428    	cbnz	x8, 0x10a0c4630 <_Flutter_MMFoundation_BindContext+0x65a0214>
10a0c45b0: 34000400    	cbz	w0, 0x10a0c4630 <_Flutter_MMFoundation_BindContext+0x65a0214>
10a0c45b4: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c45b8: f9453515    	ldr	x21, [x8, #0xa68]
10a0c45bc: b00aec08    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10a0c45c0: f940cd01    	ldr	x1, [x8, #0x198] ; tid
10a0c45c4: aa1703e0    	mov	x0, x23
10a0c45c8: 955e5b9f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c45cc: aa1d03fd    	mov	x29, x29
10a0c45d0: 955e5ba0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c45d4: aa0003f4    	mov	x20, x0
10a0c45d8: 900b0d88    	adrp	x8, 0x120274000 <dyld_stub_binder+0x120274000>
10a0c45dc: b981f908    	ldrsw	x8, [x8, #0x1f8]
10a0c45e0: 38686ac8    	ldrb	w8, [x22, x8]
10a0c45e4: b00aeba9    	adrp	x9, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0c45e8: f942a921    	ldr	x1, [x9, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0c45ec: a9016be8    	stp	x8, x26, [sp, #0x10]
10a0c45f0: f00a4bc8    	adrp	x8, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a0c45f4: 913f2108    	add	x8, x8, #0xfc8
10a0c45f8: a90003e8    	stp	x8, x0, [sp]
10a0c45fc: f0089ee3    	adrp	x3, 0x11b4a3000 <dyld_stub_binder+0x11b4a3000>
10a0c4600: 91338463    	add	x3, x3, #0xce1
10a0c4604: b008e205    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0c4608: 912850a5    	add	x5, x5, #0xa14
10a0c460c: d008e207    	adrp	x7, 0x11bd06000 <dyld_stub_binder+0x11bd06000>
10a0c4610: 9103ece7    	add	x7, x7, #0xfb
10a0c4614: aa1503e0    	mov	x0, x21
10a0c4618: 52800042    	mov	w2, #0x2                ; =2
10a0c461c: 52800004    	mov	w4, #0x0                ; =0
10a0c4620: 52813fe6    	mov	w6, #0x9ff              ; =2559
10a0c4624: 955e5b88    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4628: aa1403e0    	mov	x0, x20
10a0c462c: 955e5b8c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4630: aa1703e0    	mov	x0, x23
10a0c4634: aa1c03e1    	mov	x1, x28
10a0c4638: 955e5b83    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c463c: f9402be8    	ldr	x8, [sp, #0x50]
10a0c4640: f100011f    	cmp	x8, #0x0
10a0c4644: 52000008    	eor	w8, w0, #0x1
10a0c4648: 1a9f0508    	csinc	w8, w8, wzr, eq
10a0c464c: 2a080348    	orr	w8, w26, w8
10a0c4650: f90027fb    	str	x27, [sp, #0x48]
10a0c4654: 37000348    	tbnz	w8, #0x0, 0x10a0c46bc <_Flutter_MMFoundation_BindContext+0x65a02a0>
10a0c4658: d00b05a8    	adrp	x8, 0x12017a000 <dyld_stub_binder+0x12017a000>
10a0c465c: f9456100    	ldr	x0, [x8, #0xac0] ; 0h=
10a0c4660: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4664: f9433101    	ldr	x1, [x8, #0x660] ; needForceRecordAdWhenCellWillDisplay:
10a0c4668: aa1703e2    	mov	x2, x23
10a0c466c: 955e5b76    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4670: 34000260    	cbz	w0, 0x10a0c46bc <_Flutter_MMFoundation_BindContext+0x65a02a0>
10a0c4674: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4678: f9453500    	ldr	x0, [x8, #0xa68]
10a0c467c: b00aeba8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0c4680: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0c4684: f00a4008    	adrp	x8, 0x11e8c7000 <dyld_stub_binder+0x11e8c7000>
10a0c4688: 9135a108    	add	x8, x8, #0xd68
10a0c468c: f90003e8    	str	x8, [sp]
10a0c4690: 90088ac3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0c4694: 912b2863    	add	x3, x3, #0xaca
10a0c4698: b008e205    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0c469c: 912850a5    	add	x5, x5, #0xa14
10a0c46a0: d008e207    	adrp	x7, 0x11bd06000 <dyld_stub_binder+0x11bd06000>
10a0c46a4: 9103ece7    	add	x7, x7, #0xfb
10a0c46a8: 52800042    	mov	w2, #0x2                ; =2
10a0c46ac: 52800004    	mov	w4, #0x0                ; =0
10a0c46b0: 52814066    	mov	w6, #0xa03              ; =2563
10a0c46b4: 955e5b64    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c46b8: 14000002    	b	0x10a0c46c0 <_Flutter_MMFoundation_BindContext+0x65a02a4>
10a0c46bc: 36002dba    	tbz	w26, #0x0, 0x10a0c4c70 <_Flutter_MMFoundation_BindContext+0x65a0854>
10a0c46c0: d00aef88    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
10a0c46c4: f9403d1c    	ldr	x28, [x8, #0x78] ; advertiseInfo
10a0c46c8: aa1703e0    	mov	x0, x23
10a0c46cc: aa1c03e1    	mov	x1, x28
10a0c46d0: 955e5b5d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c46d4: aa1d03fd    	mov	x29, x29
10a0c46d8: 955e5b5e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c46dc: b40023e0    	cbz	x0, 0x10a0c4b58 <_Flutter_MMFoundation_BindContext+0x65a073c>
10a0c46e0: aa0003f5    	mov	x21, x0
10a0c46e4: aa1703e0    	mov	x0, x23
10a0c46e8: aa1c03e1    	mov	x1, x28
10a0c46ec: 955e5b56    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c46f0: aa1d03fd    	mov	x29, x29
10a0c46f4: 955e5b57    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c46f8: aa0003f4    	mov	x20, x0
10a0c46fc: f00af908    	adrp	x8, 0x11ffe7000 <dyld_stub_binder+0x11ffe7000>
10a0c4700: f9402d01    	ldr	x1, [x8, #0x58] ; adViewId
10a0c4704: f90013e1    	str	x1, [sp, #0x20]
10a0c4708: 955e5b4f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c470c: aa1d03fd    	mov	x29, x29
10a0c4710: 955e5b50    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4714: aa0003fa    	mov	x26, x0
10a0c4718: f00b01e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a0c471c: f946e901    	ldr	x1, [x8, #0xdd0] ; length
10a0c4720: 955e5b49    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4724: aa0003fb    	mov	x27, x0
10a0c4728: aa1a03e0    	mov	x0, x26
10a0c472c: 955e5b4c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4730: aa1403e0    	mov	x0, x20
10a0c4734: 955e5b4a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4738: aa1503e0    	mov	x0, x21
10a0c473c: 955e5b48    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4740: b40020db    	cbz	x27, 0x10a0c4b58 <_Flutter_MMFoundation_BindContext+0x65a073c>
10a0c4744: f9402be8    	ldr	x8, [sp, #0x50]
10a0c4748: b5001828    	cbnz	x8, 0x10a0c4a4c <_Flutter_MMFoundation_BindContext+0x65a0630>
10a0c474c: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4750: f9453500    	ldr	x0, [x8, #0xa68]
10a0c4754: b00aeba8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0c4758: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0c475c: f00a4bc8    	adrp	x8, 0x11ea3f000 <dyld_stub_binder+0x11ea3f000>
10a0c4760: 913fa108    	add	x8, x8, #0xfe8
10a0c4764: f90003e8    	str	x8, [sp]
10a0c4768: 90088ac3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0c476c: 912b2863    	add	x3, x3, #0xaca
10a0c4770: b008e205    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0c4774: 912850a5    	add	x5, x5, #0xa14
10a0c4778: d008e207    	adrp	x7, 0x11bd06000 <dyld_stub_binder+0x11bd06000>
10a0c477c: 9103ece7    	add	x7, x7, #0xfb
10a0c4780: 52800042    	mov	w2, #0x2                ; =2
10a0c4784: 52800004    	mov	w4, #0x0                ; =0
10a0c4788: 52814146    	mov	w6, #0xa0a              ; =2570
10a0c478c: 955e5b2e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4790: aa1703e0    	mov	x0, x23
10a0c4794: aa1c03e1    	mov	x1, x28
10a0c4798: 955e5b2b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c479c: aa1d03fd    	mov	x29, x29
10a0c47a0: 955e5b2c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c47a4: aa0003f4    	mov	x20, x0
10a0c47a8: 900af928    	adrp	x8, 0x11ffe8000 <dyld_stub_binder+0x11ffe8000>
10a0c47ac: f945ed01    	ldr	x1, [x8, #0xbd8] ; bExposured
10a0c47b0: 955e5b25    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c47b4: aa0003f5    	mov	x21, x0
10a0c47b8: aa1403e0    	mov	x0, x20
10a0c47bc: 955e5b28    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c47c0: 37000375    	tbnz	w21, #0x0, 0x10a0c482c <_Flutter_MMFoundation_BindContext+0x65a0410>
10a0c47c4: d00b0588    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
10a0c47c8: f9442514    	ldr	x20, [x8, #0x848] ; Pp=
10a0c47cc: aa1703e0    	mov	x0, x23
10a0c47d0: aa1c03e1    	mov	x1, x28
10a0c47d4: 955e5b1c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c47d8: aa1d03fd    	mov	x29, x29
10a0c47dc: 955e5b1d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c47e0: aa0003f5    	mov	x21, x0
10a0c47e4: b00aec08    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10a0c47e8: f940cd01    	ldr	x1, [x8, #0x198] ; tid
10a0c47ec: aa1703e0    	mov	x0, x23
10a0c47f0: 955e5b15    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c47f4: aa1d03fd    	mov	x29, x29
10a0c47f8: 955e5b16    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c47fc: aa0003fa    	mov	x26, x0
10a0c4800: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4804: f9433501    	ldr	x1, [x8, #0x668] ; reportAdExposeCost:snsId:position:
10a0c4808: aa1403e0    	mov	x0, x20
10a0c480c: aa1503e2    	mov	x2, x21
10a0c4810: aa1a03e3    	mov	x3, x26
10a0c4814: aa1303e4    	mov	x4, x19
10a0c4818: 955e5b0b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c481c: aa1a03e0    	mov	x0, x26
10a0c4820: 955e5b0f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4824: aa1503e0    	mov	x0, x21
10a0c4828: 955e5b0d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c482c: f00b057b    	adrp	x27, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4830: f945eb60    	ldr	x0, [x27, #0xbd0]
10a0c4834: aa1b03f5    	mov	x21, x27
10a0c4838: aa1903e1    	mov	x1, x25
10a0c483c: 955e5b02    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4840: aa1d03fd    	mov	x29, x29
10a0c4844: 955e5b03    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4848: aa0003f3    	mov	x19, x0
10a0c484c: 900b0588    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4850: f9428500    	ldr	x0, [x8, #0x508]
10a0c4854: aa1803e1    	mov	x1, x24
10a0c4858: 955e5afb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c485c: aa0003e2    	mov	x2, x0
10a0c4860: aa1303e0    	mov	x0, x19
10a0c4864: f94027fb    	ldr	x27, [sp, #0x48]
10a0c4868: aa1b03e1    	mov	x1, x27
10a0c486c: 955e5af6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4870: aa1d03fd    	mov	x29, x29
10a0c4874: 955e5af7    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4878: aa0003f4    	mov	x20, x0
10a0c487c: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4880: f9433901    	ldr	x1, [x8, #0x670] ; increaseWCAdvertiseDataExposureCnt:
10a0c4884: aa1703e2    	mov	x2, x23
10a0c4888: 955e5aef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c488c: aa1403e0    	mov	x0, x20
10a0c4890: 955e5af3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4894: aa1303e0    	mov	x0, x19
10a0c4898: 955e5af1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c489c: f945eaa0    	ldr	x0, [x21, #0xbd0]
10a0c48a0: aa1903e1    	mov	x1, x25
10a0c48a4: 955e5ae8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c48a8: aa1d03fd    	mov	x29, x29
10a0c48ac: 955e5ae9    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c48b0: aa0003f3    	mov	x19, x0
10a0c48b4: 900b05a8    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
10a0c48b8: f943f500    	ldr	x0, [x8, #0x7e8]
10a0c48bc: aa1803e1    	mov	x1, x24
10a0c48c0: 955e5ae1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c48c4: aa0003e2    	mov	x2, x0
10a0c48c8: aa1303e0    	mov	x0, x19
10a0c48cc: aa1b03e1    	mov	x1, x27
10a0c48d0: 955e5add    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c48d4: aa1d03fd    	mov	x29, x29
10a0c48d8: 955e5ade    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c48dc: aa0003f4    	mov	x20, x0
10a0c48e0: aa1703e0    	mov	x0, x23
10a0c48e4: aa1c03e1    	mov	x1, x28
10a0c48e8: 955e5ad7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c48ec: aa1d03fd    	mov	x29, x29
10a0c48f0: 955e5ad8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c48f4: aa0003f5    	mov	x21, x0
10a0c48f8: f94013e1    	ldr	x1, [sp, #0x20]
10a0c48fc: 955e5ad2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4900: aa1d03fd    	mov	x29, x29
10a0c4904: 955e5ad3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4908: aa0003fa    	mov	x26, x0
10a0c490c: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4910: f9433d01    	ldr	x1, [x8, #0x678] ; exposureADFeed:dataItem:
10a0c4914: aa1403e0    	mov	x0, x20
10a0c4918: aa1a03e2    	mov	x2, x26
10a0c491c: aa1703e3    	mov	x3, x23
10a0c4920: 955e5ac9    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4924: aa1a03e0    	mov	x0, x26
10a0c4928: 955e5acd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c492c: aa1503e0    	mov	x0, x21
10a0c4930: 955e5acb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4934: aa1403e0    	mov	x0, x20
10a0c4938: 955e5ac9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c493c: aa1303e0    	mov	x0, x19
10a0c4940: 955e5ac7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4944: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4948: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c494c: aa1903e1    	mov	x1, x25
10a0c4950: 955e5abd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4954: aa1d03fd    	mov	x29, x29
10a0c4958: 955e5abe    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c495c: aa0003f3    	mov	x19, x0
10a0c4960: 900b0588    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4964: f9428500    	ldr	x0, [x8, #0x508]
10a0c4968: aa1803e1    	mov	x1, x24
10a0c496c: 955e5ab6    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4970: aa0003e2    	mov	x2, x0
10a0c4974: aa1303e0    	mov	x0, x19
10a0c4978: aa1b03e1    	mov	x1, x27
10a0c497c: 955e5ab2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4980: aa1d03fd    	mov	x29, x29
10a0c4984: 955e5ab3    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4988: aa0003f4    	mov	x20, x0
10a0c498c: b00aec48    	adrp	x8, 0x11fe4d000 <dyld_stub_binder+0x11fe4d000>
10a0c4990: f9424d01    	ldr	x1, [x8, #0x498] ; advertiseLogicMgr
10a0c4994: 955e5aac    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4998: aa1d03fd    	mov	x29, x29
10a0c499c: 955e5aad    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c49a0: aa0003f5    	mov	x21, x0
10a0c49a4: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c49a8: f9434101    	ldr	x1, [x8, #0x680] ; updateOnTimeLineExposure:
10a0c49ac: aa1703e2    	mov	x2, x23
10a0c49b0: 955e5aa5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c49b4: aa1503e0    	mov	x0, x21
10a0c49b8: 955e5aa9    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c49bc: aa1403e0    	mov	x0, x20
10a0c49c0: 955e5aa7    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c49c4: aa1303e0    	mov	x0, x19
10a0c49c8: 955e5aa5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c49cc: f00b0728    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c49d0: f941f113    	ldr	x19, [x8, #0x3e0]
10a0c49d4: f00b0728    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c49d8: f941e500    	ldr	x0, [x8, #0x3c8]
10a0c49dc: aa1803e1    	mov	x1, x24
10a0c49e0: 955e5a99    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c49e4: aa0003f4    	mov	x20, x0
10a0c49e8: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c49ec: f940fd01    	ldr	x1, [x8, #0x1f8] ; dataControllers
10a0c49f0: aa1603e0    	mov	x0, x22
10a0c49f4: 955e5a94    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c49f8: aa1d03fd    	mov	x29, x29
10a0c49fc: 955e5a95    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4a00: aa0003f5    	mov	x21, x0
10a0c4a04: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4a08: f9411501    	ldr	x1, [x8, #0x228] ; GetImpl:InHolder:
10a0c4a0c: aa1303e0    	mov	x0, x19
10a0c4a10: aa1403e2    	mov	x2, x20
10a0c4a14: aa1503e3    	mov	x3, x21
10a0c4a18: 955e5a8b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4a1c: aa1d03fd    	mov	x29, x29
10a0c4a20: 955e5a8c    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4a24: aa0003f3    	mov	x19, x0
10a0c4a28: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4a2c: f9434501    	ldr	x1, [x8, #0x688] ; recordADBodyStartInfo:forRowAtIndexPath:
10a0c4a30: aa1703e2    	mov	x2, x23
10a0c4a34: f94023e3    	ldr	x3, [sp, #0x40]
10a0c4a38: 955e5a83    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4a3c: aa1303e0    	mov	x0, x19
10a0c4a40: 955e5a87    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4a44: aa1503e0    	mov	x0, x21
10a0c4a48: 955e5a85    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4a4c: d00aeca8    	adrp	x8, 0x11fe5a000 <dyld_stub_binder+0x11fe5a000>
10a0c4a50: f9465501    	ldr	x1, [x8, #0xca8] ; commentCount
10a0c4a54: aa1703e0    	mov	x0, x23
10a0c4a58: 955e5a7b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4a5c: 7100041f    	cmp	w0, #0x1
10a0c4a60: 540007cb    	b.lt	0x10a0c4b58 <_Flutter_MMFoundation_BindContext+0x65a073c>
10a0c4a64: d00aec88    	adrp	x8, 0x11fe56000 <dyld_stub_binder+0x11fe56000>
10a0c4a68: f9447501    	ldr	x1, [x8, #0x8e8] ; likeCount
10a0c4a6c: aa1703e0    	mov	x0, x23
10a0c4a70: 955e5a75    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4a74: 7100041f    	cmp	w0, #0x1
10a0c4a78: 52800028    	mov	w8, #0x1                ; =1
10a0c4a7c: 9a88b513    	cinc	x19, x8, ge
10a0c4a80: f94023e0    	ldr	x0, [sp, #0x40]
10a0c4a84: f94017e1    	ldr	x1, [sp, #0x28]
10a0c4a88: 955e5a6f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4a8c: eb13001f    	cmp	x0, x19
10a0c4a90: 54000641    	b.ne	0x10a0c4b58 <_Flutter_MMFoundation_BindContext+0x65a073c>
10a0c4a94: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4a98: f9453500    	ldr	x0, [x8, #0xa68]
10a0c4a9c: b00aeba8    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
10a0c4aa0: f942a901    	ldr	x1, [x8, #0x550] ; logWithLevel:module:errorCode:file:line:func:format:
10a0c4aa4: 900a4be8    	adrp	x8, 0x11ea40000 <dyld_stub_binder+0x11ea40000>
10a0c4aa8: 91002108    	add	x8, x8, #0x8
10a0c4aac: f90003e8    	str	x8, [sp]
10a0c4ab0: 90088ac3    	adrp	x3, 0x11b21c000 <dyld_stub_binder+0x11b21c000>
10a0c4ab4: 912b2863    	add	x3, x3, #0xaca
10a0c4ab8: b008e205    	adrp	x5, 0x11bd05000 <dyld_stub_binder+0x11bd05000>
10a0c4abc: 912850a5    	add	x5, x5, #0xa14
10a0c4ac0: d008e207    	adrp	x7, 0x11bd06000 <dyld_stub_binder+0x11bd06000>
10a0c4ac4: 9103ece7    	add	x7, x7, #0xfb
10a0c4ac8: 52800042    	mov	w2, #0x2                ; =2
10a0c4acc: 52800004    	mov	w4, #0x0                ; =0
10a0c4ad0: 52814366    	mov	w6, #0xa1b              ; =2587
10a0c4ad4: 955e5a5c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4ad8: f00b0728    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c4adc: f941f113    	ldr	x19, [x8, #0x3e0]
10a0c4ae0: f00b0728    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c4ae4: f941e500    	ldr	x0, [x8, #0x3c8]
10a0c4ae8: aa1803e1    	mov	x1, x24
10a0c4aec: 955e5a56    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4af0: aa0003f4    	mov	x20, x0
10a0c4af4: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4af8: f940fd01    	ldr	x1, [x8, #0x1f8] ; dataControllers
10a0c4afc: aa1603e0    	mov	x0, x22
10a0c4b00: 955e5a51    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4b04: aa1d03fd    	mov	x29, x29
10a0c4b08: 955e5a52    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4b0c: aa0003f5    	mov	x21, x0
10a0c4b10: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4b14: f9411501    	ldr	x1, [x8, #0x228] ; GetImpl:InHolder:
10a0c4b18: aa1303e0    	mov	x0, x19
10a0c4b1c: aa1403e2    	mov	x2, x20
10a0c4b20: aa1503e3    	mov	x3, x21
10a0c4b24: 955e5a48    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4b28: aa1d03fd    	mov	x29, x29
10a0c4b2c: 955e5a49    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4b30: aa0003f3    	mov	x19, x0
10a0c4b34: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4b38: f9434901    	ldr	x1, [x8, #0x690] ; recordADCommentStartInfo:forRowAtIndexPath:
10a0c4b3c: aa1703e2    	mov	x2, x23
10a0c4b40: f94023e3    	ldr	x3, [sp, #0x40]
10a0c4b44: 955e5a40    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4b48: aa1303e0    	mov	x0, x19
10a0c4b4c: 955e5a44    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4b50: aa1503e0    	mov	x0, x21
10a0c4b54: 955e5a42    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4b58: 900aecc8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a0c4b5c: f9439d13    	ldr	x19, [x8, #0x738] ; contentObj
10a0c4b60: aa1703e0    	mov	x0, x23
10a0c4b64: aa1303e1    	mov	x1, x19
10a0c4b68: 955e5a37    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4b6c: aa1d03fd    	mov	x29, x29
10a0c4b70: 955e5a38    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4b74: aa0003f4    	mov	x20, x0
10a0c4b78: f00b0228    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0c4b7c: f941c91c    	ldr	x28, [x8, #0x390] ; type
10a0c4b80: aa1c03e1    	mov	x1, x28
10a0c4b84: 955e5a30    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4b88: aa0003f5    	mov	x21, x0
10a0c4b8c: aa1403e0    	mov	x0, x20
10a0c4b90: 955e5a33    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4b94: f9402be8    	ldr	x8, [sp, #0x50]
10a0c4b98: b5000188    	cbnz	x8, 0x10a0c4bc8 <_Flutter_MMFoundation_BindContext+0x65a07ac>
10a0c4b9c: 71004abf    	cmp	w21, #0x12
10a0c4ba0: 54000141    	b.ne	0x10a0c4bc8 <_Flutter_MMFoundation_BindContext+0x65a07ac>
10a0c4ba4: 900b0588    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4ba8: f9472100    	ldr	x0, [x8, #0xe40] ; м/
10a0c4bac: d00af968    	adrp	x8, 0x11fff2000 <dyld_stub_binder+0x11fff2000>
10a0c4bb0: f9428d01    	ldr	x1, [x8, #0x518] ; adVideoExposureFromTimeLine:sourceType:isAutoPlay:fromScene:
10a0c4bb4: aa1703e2    	mov	x2, x23
10a0c4bb8: 52800043    	mov	w3, #0x2                ; =2
10a0c4bbc: 52800004    	mov	w4, #0x0                ; =0
10a0c4bc0: 52800045    	mov	w5, #0x2                ; =2
10a0c4bc4: 955e5a20    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4bc8: aa1703e0    	mov	x0, x23
10a0c4bcc: aa1303e1    	mov	x1, x19
10a0c4bd0: 955e5a1d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4bd4: aa1d03fd    	mov	x29, x29
10a0c4bd8: 955e5a1e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4bdc: aa0003f4    	mov	x20, x0
10a0c4be0: aa1c03e1    	mov	x1, x28
10a0c4be4: 955e5a18    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4be8: aa0003f5    	mov	x21, x0
10a0c4bec: aa1403e0    	mov	x0, x20
10a0c4bf0: 955e5a1b    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4bf4: a944a3fb    	ldp	x27, x8, [sp, #0x48]
10a0c4bf8: b5000448    	cbnz	x8, 0x10a0c4c80 <_Flutter_MMFoundation_BindContext+0x65a0864>
10a0c4bfc: 71000ebf    	cmp	w21, #0x3
10a0c4c00: 54000401    	b.ne	0x10a0c4c80 <_Flutter_MMFoundation_BindContext+0x65a0864>
10a0c4c04: f00b0568    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4c08: f945e900    	ldr	x0, [x8, #0xbd0]
10a0c4c0c: aa1903e1    	mov	x1, x25
10a0c4c10: 955e5a0d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4c14: aa1d03fd    	mov	x29, x29
10a0c4c18: 955e5a0e    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4c1c: aa0003f4    	mov	x20, x0
10a0c4c20: 900b05a8    	adrp	x8, 0x120178000 <dyld_stub_binder+0x120178000>
10a0c4c24: f943f500    	ldr	x0, [x8, #0x7e8]
10a0c4c28: aa1803e1    	mov	x1, x24
10a0c4c2c: 955e5a06    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4c30: aa0003e2    	mov	x2, x0
10a0c4c34: aa1403e0    	mov	x0, x20
10a0c4c38: aa1b03e1    	mov	x1, x27
10a0c4c3c: 955e5a02    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4c40: aa1d03fd    	mov	x29, x29
10a0c4c44: 955e5a03    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4c48: aa0003f5    	mov	x21, x0
10a0c4c4c: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4c50: f9434d01    	ldr	x1, [x8, #0x698] ; willDisplayADShare:
10a0c4c54: aa1703e2    	mov	x2, x23
10a0c4c58: 955e59fb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4c5c: aa1503e0    	mov	x0, x21
10a0c4c60: 955e59ff    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4c64: aa1403e0    	mov	x0, x20
10a0c4c68: 955e59fd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4c6c: 14000005    	b	0x10a0c4c80 <_Flutter_MMFoundation_BindContext+0x65a0864>
10a0c4c70: 900aecc8    	adrp	x8, 0x11fe5c000 <dyld_stub_binder+0x11fe5c000>
10a0c4c74: f9439d13    	ldr	x19, [x8, #0x738] ; contentObj
10a0c4c78: f00b0228    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0c4c7c: f941c91c    	ldr	x28, [x8, #0x390] ; type
10a0c4c80: aa1703e0    	mov	x0, x23
10a0c4c84: aa1303e1    	mov	x1, x19
10a0c4c88: 955e59ef    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4c8c: aa1d03fd    	mov	x29, x29
10a0c4c90: 955e59f0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4c94: aa0003f5    	mov	x21, x0
10a0c4c98: aa1c03e1    	mov	x1, x28
10a0c4c9c: 955e59ea    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4ca0: 7100881f    	cmp	w0, #0x22
10a0c4ca4: 540000a1    	b.ne	0x10a0c4cb8 <_Flutter_MMFoundation_BindContext+0x65a089c>
10a0c4ca8: aa1503e0    	mov	x0, x21
10a0c4cac: 955e59ec    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4cb0: 900b059a    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4cb4: 14000011    	b	0x10a0c4cf8 <_Flutter_MMFoundation_BindContext+0x65a08dc>
10a0c4cb8: aa1703e0    	mov	x0, x23
10a0c4cbc: aa1303e1    	mov	x1, x19
10a0c4cc0: 955e59e1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4cc4: aa1d03fd    	mov	x29, x29
10a0c4cc8: 955e59e2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4ccc: aa0003f4    	mov	x20, x0
10a0c4cd0: aa1c03e1    	mov	x1, x28
10a0c4cd4: 955e59dc    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4cd8: aa0003fa    	mov	x26, x0
10a0c4cdc: aa1403e0    	mov	x0, x20
10a0c4ce0: 955e59df    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4ce4: aa1503e0    	mov	x0, x21
10a0c4ce8: 955e59dd    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4cec: 7100b75f    	cmp	w26, #0x2d
10a0c4cf0: 900b059a    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4cf4: 540002a1    	b.ne	0x10a0c4d48 <_Flutter_MMFoundation_BindContext+0x65a092c>
10a0c4cf8: aa1703e0    	mov	x0, x23
10a0c4cfc: aa1303e1    	mov	x1, x19
10a0c4d00: 955e59d1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4d04: aa1d03fd    	mov	x29, x29
10a0c4d08: 955e59d2    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4d0c: aa0003f4    	mov	x20, x0
10a0c4d10: f00aec28    	adrp	x8, 0x11fe4b000 <dyld_stub_binder+0x11fe4b000>
10a0c4d14: f9432901    	ldr	x1, [x8, #0x650] ; finderLiveShareItem
10a0c4d18: 955e59cb    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4d1c: aa1d03fd    	mov	x29, x29
10a0c4d20: 955e59cc    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4d24: aa0003f5    	mov	x21, x0
10a0c4d28: d00aec48    	adrp	x8, 0x11fe4e000 <dyld_stub_binder+0x11fe4e000>
10a0c4d2c: f9429d01    	ldr	x1, [x8, #0x538] ; updateLiveStateIfNeedFromScene:
10a0c4d30: 52800042    	mov	w2, #0x2                ; =2
10a0c4d34: 955e59c4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4d38: aa1503e0    	mov	x0, x21
10a0c4d3c: 955e59c8    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4d40: aa1403e0    	mov	x0, x20
10a0c4d44: 955e59c6    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4d48: aa1703e0    	mov	x0, x23
10a0c4d4c: aa1303e1    	mov	x1, x19
10a0c4d50: 955e59bd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4d54: aa1d03fd    	mov	x29, x29
10a0c4d58: 955e59be    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4d5c: aa0003f3    	mov	x19, x0
10a0c4d60: aa1c03e1    	mov	x1, x28
10a0c4d64: 955e59b8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4d68: aa0003f4    	mov	x20, x0
10a0c4d6c: aa1303e0    	mov	x0, x19
10a0c4d70: 955e59bb    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4d74: 7101969f    	cmp	w20, #0x65
10a0c4d78: f00b057c    	adrp	x28, 0x120173000 <dyld_stub_binder+0x120173000>
10a0c4d7c: 54000341    	b.ne	0x10a0c4de4 <_Flutter_MMFoundation_BindContext+0x65a09c8>
10a0c4d80: f945eb80    	ldr	x0, [x28, #0xbd0]
10a0c4d84: aa1903e1    	mov	x1, x25
10a0c4d88: 955e59af    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4d8c: aa1d03fd    	mov	x29, x29
10a0c4d90: 955e59b0    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4d94: aa0003f3    	mov	x19, x0
10a0c4d98: 900b0588    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4d9c: f945d500    	ldr	x0, [x8, #0xba8]
10a0c4da0: aa1803e1    	mov	x1, x24
10a0c4da4: 955e59a8    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4da8: aa0003e2    	mov	x2, x0
10a0c4dac: aa1303e0    	mov	x0, x19
10a0c4db0: aa1b03e1    	mov	x1, x27
10a0c4db4: 955e59a4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4db8: aa1d03fd    	mov	x29, x29
10a0c4dbc: 955e59a5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4dc0: aa0003f4    	mov	x20, x0
10a0c4dc4: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4dc8: f9435101    	ldr	x1, [x8, #0x6a0] ; snsExposeReport:
10a0c4dcc: aa1703e2    	mov	x2, x23
10a0c4dd0: 955e599d    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4dd4: aa1403e0    	mov	x0, x20
10a0c4dd8: 955e59a1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4ddc: aa1303e0    	mov	x0, x19
10a0c4de0: 955e599f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4de4: f9402be8    	ldr	x8, [sp, #0x50]
10a0c4de8: b5000488    	cbnz	x8, 0x10a0c4e78 <_Flutter_MMFoundation_BindContext+0x65a0a5c>
10a0c4dec: f945eb80    	ldr	x0, [x28, #0xbd0]
10a0c4df0: aa1903e1    	mov	x1, x25
10a0c4df4: 955e5994    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4df8: aa1d03fd    	mov	x29, x29
10a0c4dfc: 955e5995    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4e00: aa0003f3    	mov	x19, x0
10a0c4e04: d00b0568    	adrp	x8, 0x120172000 <dyld_stub_binder+0x120172000>
10a0c4e08: f9473514    	ldr	x20, [x8, #0xe68]
10a0c4e0c: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4e10: f9435515    	ldr	x21, [x8, #0x6a8] ; onTimeLineViewWillDisplayDataItem:
10a0c4e14: d009a948    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
10a0c4e18: f947e108    	ldr	x8, [x8, #0xfc0]
10a0c4e1c: f9002fe8    	str	x8, [sp, #0x58]
10a0c4e20: b00765e8    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
10a0c4e24: fd41c100    	ldr	d0, [x8, #0x380]
10a0c4e28: fd0033e0    	str	d0, [sp, #0x60]
10a0c4e2c: b0000008    	adrp	x8, 0x10a0c5000 <_Flutter_MMFoundation_BindContext+0x65a0be4>
10a0c4e30: 910b7108    	add	x8, x8, #0x2dc
10a0c4e34: d009a989    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
10a0c4e38: 91238129    	add	x9, x9, #0x8e0
10a0c4e3c: a906a7e8    	stp	x8, x9, [sp, #0x68]
10a0c4e40: aa1703e0    	mov	x0, x23
10a0c4e44: 955e597f    	bl	0x10f85b440 <_UR_96F1_B25D+0x3a640b0>
10a0c4e48: f9003ff7    	str	x23, [sp, #0x78]
10a0c4e4c: d00aeba8    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
10a0c4e50: f9404901    	ldr	x1, [x8, #0x90] ; callExtension:selector:block:
10a0c4e54: 910163e4    	add	x4, sp, #0x58
10a0c4e58: aa1303e0    	mov	x0, x19
10a0c4e5c: aa1403e2    	mov	x2, x20
10a0c4e60: aa1503e3    	mov	x3, x21
10a0c4e64: 955e5978    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4e68: aa1303e0    	mov	x0, x19
10a0c4e6c: 955e597c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4e70: f9403fe0    	ldr	x0, [sp, #0x78]
10a0c4e74: 955e597a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4e78: f945eb80    	ldr	x0, [x28, #0xbd0]
10a0c4e7c: aa1903e1    	mov	x1, x25
10a0c4e80: 955e5971    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4e84: aa1d03fd    	mov	x29, x29
10a0c4e88: 955e5972    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4e8c: aa0003f3    	mov	x19, x0
10a0c4e90: f9428740    	ldr	x0, [x26, #0x508]
10a0c4e94: aa1803e1    	mov	x1, x24
10a0c4e98: 955e596b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4e9c: aa0003e2    	mov	x2, x0
10a0c4ea0: aa1303e0    	mov	x0, x19
10a0c4ea4: aa1b03e1    	mov	x1, x27
10a0c4ea8: 955e5967    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4eac: aa1d03fd    	mov	x29, x29
10a0c4eb0: 955e5968    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4eb4: aa0003f4    	mov	x20, x0
10a0c4eb8: b00aec08    	adrp	x8, 0x11fe45000 <dyld_stub_binder+0x11fe45000>
10a0c4ebc: f940cd01    	ldr	x1, [x8, #0x198] ; tid
10a0c4ec0: aa1703e0    	mov	x0, x23
10a0c4ec4: 955e5960    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4ec8: aa1d03fd    	mov	x29, x29
10a0c4ecc: 955e5961    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4ed0: aa0003f5    	mov	x21, x0
10a0c4ed4: d00aef88    	adrp	x8, 0x11feb6000 <dyld_stub_binder+0x11feb6000>
10a0c4ed8: f9402101    	ldr	x1, [x8, #0x40] ; appInfo
10a0c4edc: aa1703e0    	mov	x0, x23
10a0c4ee0: 955e5959    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4ee4: aa1d03fd    	mov	x29, x29
10a0c4ee8: 955e595a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4eec: aa0003fa    	mov	x26, x0
10a0c4ef0: d00aebc8    	adrp	x8, 0x11fe3e000 <dyld_stub_binder+0x11fe3e000>
10a0c4ef4: f9407101    	ldr	x1, [x8, #0xe0] ; appID
10a0c4ef8: 955e5953    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4efc: aa1d03fd    	mov	x29, x29
10a0c4f00: 955e5954    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4f04: aa0003fb    	mov	x27, x0
10a0c4f08: 900aec28    	adrp	x8, 0x11fe48000 <dyld_stub_binder+0x11fe48000>
10a0c4f0c: f942b101    	ldr	x1, [x8, #0x560] ; isFold
10a0c4f10: aa1703e0    	mov	x0, x23
10a0c4f14: 955e594c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4f18: aa0003e4    	mov	x4, x0
10a0c4f1c: b00afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c4f20: f9435901    	ldr	x1, [x8, #0x6b0] ; recordFeedExposureWithFeedId:appId:isFold:
10a0c4f24: aa1403e0    	mov	x0, x20
10a0c4f28: aa1503e2    	mov	x2, x21
10a0c4f2c: aa1b03e3    	mov	x3, x27
10a0c4f30: 955e5945    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4f34: aa1b03e0    	mov	x0, x27
10a0c4f38: f94027fb    	ldr	x27, [sp, #0x48]
10a0c4f3c: 955e5948    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4f40: aa1a03e0    	mov	x0, x26
10a0c4f44: 900b059a    	adrp	x26, 0x120174000 <dyld_stub_binder+0x120174000>
10a0c4f48: 955e5945    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4f4c: aa1503e0    	mov	x0, x21
10a0c4f50: 955e5943    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4f54: aa1403e0    	mov	x0, x20
10a0c4f58: 955e5941    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4f5c: aa1303e0    	mov	x0, x19
10a0c4f60: 955e593f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4f64: f945eb80    	ldr	x0, [x28, #0xbd0]
10a0c4f68: aa1903e1    	mov	x1, x25
10a0c4f6c: 955e5936    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4f70: aa1d03fd    	mov	x29, x29
10a0c4f74: 955e5937    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4f78: aa0003f3    	mov	x19, x0
10a0c4f7c: f9428740    	ldr	x0, [x26, #0x508]
10a0c4f80: aa1803e1    	mov	x1, x24
10a0c4f84: 955e5930    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4f88: aa0003e2    	mov	x2, x0
10a0c4f8c: aa1303e0    	mov	x0, x19
10a0c4f90: aa1b03e1    	mov	x1, x27
10a0c4f94: 955e592c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4f98: aa1d03fd    	mov	x29, x29
10a0c4f9c: 955e592d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4fa0: aa0003f4    	mov	x20, x0
10a0c4fa4: b00af9e8    	adrp	x8, 0x120001000 <dyld_stub_binder+0x120001000>
10a0c4fa8: f9400d01    	ldr	x1, [x8, #0x18] ; hitTheDelayShowExp:
10a0c4fac: aa1703e2    	mov	x2, x23
10a0c4fb0: 955e5925    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4fb4: aa0003f5    	mov	x21, x0
10a0c4fb8: aa1403e0    	mov	x0, x20
10a0c4fbc: 955e5928    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4fc0: aa1303e0    	mov	x0, x19
10a0c4fc4: 955e5926    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c4fc8: 34000335    	cbz	w21, 0x10a0c502c <_Flutter_MMFoundation_BindContext+0x65a0c10>
10a0c4fcc: f945eb80    	ldr	x0, [x28, #0xbd0]
10a0c4fd0: aa1903e1    	mov	x1, x25
10a0c4fd4: 955e591c    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4fd8: aa1d03fd    	mov	x29, x29
10a0c4fdc: 955e591d    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c4fe0: aa0003f3    	mov	x19, x0
10a0c4fe4: f9428740    	ldr	x0, [x26, #0x508]
10a0c4fe8: aa1803e1    	mov	x1, x24
10a0c4fec: 955e5916    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c4ff0: aa0003e2    	mov	x2, x0
10a0c4ff4: aa1303e0    	mov	x0, x19
10a0c4ff8: aa1b03e1    	mov	x1, x27
10a0c4ffc: 955e5912    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5000: aa1d03fd    	mov	x29, x29
10a0c5004: 955e5913    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c5008: aa0003f4    	mov	x20, x0
10a0c500c: b00afa08    	adrp	x8, 0x120006000 <dyld_stub_binder+0x120006000>
10a0c5010: f9427501    	ldr	x1, [x8, #0x4e8] ; exposureDelayShowFeed:
10a0c5014: aa1703e2    	mov	x2, x23
10a0c5018: 955e590b    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c501c: aa1403e0    	mov	x0, x20
10a0c5020: 955e590f    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5024: aa1303e0    	mov	x0, x19
10a0c5028: 955e590d    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c502c: 900afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c5030: f942bd01    	ldr	x1, [x8, #0x578] ; canEditAfterDeleted
10a0c5034: aa1703e0    	mov	x0, x23
10a0c5038: 955e5903    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c503c: f9401ffa    	ldr	x26, [sp, #0x38]
10a0c5040: 34000340    	cbz	w0, 0x10a0c50a8 <_Flutter_MMFoundation_BindContext+0x65a0c8c>
10a0c5044: f945eb80    	ldr	x0, [x28, #0xbd0]
10a0c5048: aa1903e1    	mov	x1, x25
10a0c504c: 955e58fe    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5050: aa1d03fd    	mov	x29, x29
10a0c5054: 955e58ff    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c5058: aa0003f3    	mov	x19, x0
10a0c505c: f00b06a8    	adrp	x8, 0x12019c000 <dyld_stub_binder+0x12019c000>
10a0c5060: f944e500    	ldr	x0, [x8, #0x9c8]
10a0c5064: aa1803e1    	mov	x1, x24
10a0c5068: 955e58f7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c506c: aa0003e2    	mov	x2, x0
10a0c5070: aa1303e0    	mov	x0, x19
10a0c5074: aa1b03e1    	mov	x1, x27
10a0c5078: 955e58f3    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c507c: aa1d03fd    	mov	x29, x29
10a0c5080: 955e58f4    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c5084: aa0003f4    	mov	x20, x0
10a0c5088: b00aee68    	adrp	x8, 0x11fe92000 <dyld_stub_binder+0x11fe92000>
10a0c508c: f946a501    	ldr	x1, [x8, #0xd48] ; recordExpose:
10a0c5090: aa1703e2    	mov	x2, x23
10a0c5094: 955e58ec    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5098: aa1403e0    	mov	x0, x20
10a0c509c: 955e58f0    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c50a0: aa1303e0    	mov	x0, x19
10a0c50a4: 955e58ee    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c50a8: b00af9c8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0c50ac: f943fd01    	ldr	x1, [x8, #0x7f8] ; togetherUsers
10a0c50b0: aa1703e0    	mov	x0, x23
10a0c50b4: 955e58e4    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c50b8: aa1d03fd    	mov	x29, x29
10a0c50bc: 955e58e5    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c50c0: aa0003f3    	mov	x19, x0
10a0c50c4: f00b01c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0c50c8: f9435101    	ldr	x1, [x8, #0x6a0] ; count
10a0c50cc: 955e58de    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c50d0: aa0003f4    	mov	x20, x0
10a0c50d4: aa1303e0    	mov	x0, x19
10a0c50d8: 955e58e1    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c50dc: b00af9d9    	adrp	x25, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0c50e0: b40001b4    	cbz	x20, 0x10a0c5114 <_Flutter_MMFoundation_BindContext+0x65a0cf8>
10a0c50e4: b00af9c8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0c50e8: f9440101    	ldr	x1, [x8, #0x800] ; togetherTailReporter
10a0c50ec: aa1603e0    	mov	x0, x22
10a0c50f0: 955e58d5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c50f4: aa1d03fd    	mov	x29, x29
10a0c50f8: 955e58d6    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c50fc: aa0003f3    	mov	x19, x0
10a0c5100: f9440721    	ldr	x1, [x25, #0x808] ; didDisplayDataItem:
10a0c5104: aa1703e2    	mov	x2, x23
10a0c5108: 955e58cf    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c510c: aa1303e0    	mov	x0, x19
10a0c5110: 955e58d3    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5114: 900b06c8    	adrp	x8, 0x12019d000 <dyld_stub_binder+0x12019d000>
10a0c5118: f943c100    	ldr	x0, [x8, #0x780]
10a0c511c: 900af9c8    	adrp	x8, 0x11fffd000 <dyld_stub_binder+0x11fffd000>
10a0c5120: f9478501    	ldr	x1, [x8, #0xf08] ; canDisplaySpringStyleForDataItem:
10a0c5124: aa1703e2    	mov	x2, x23
10a0c5128: 955e58c7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c512c: 34000300    	cbz	w0, 0x10a0c518c <_Flutter_MMFoundation_BindContext+0x65a0d70>
10a0c5130: f00aec28    	adrp	x8, 0x11fe4c000 <dyld_stub_binder+0x11fe4c000>
10a0c5134: f940b901    	ldr	x1, [x8, #0x170] ; isDragging
10a0c5138: aa1a03e0    	mov	x0, x26
10a0c513c: 955e58c2    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5140: 370000c0    	tbnz	w0, #0x0, 0x10a0c5158 <_Flutter_MMFoundation_BindContext+0x65a0d3c>
10a0c5144: 900aec28    	adrp	x8, 0x11fe49000 <dyld_stub_binder+0x11fe49000>
10a0c5148: f943c101    	ldr	x1, [x8, #0x780] ; isDecelerating
10a0c514c: aa1a03e0    	mov	x0, x26
10a0c5150: 955e58bd    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5154: 34000a20    	cbz	w0, 0x10a0c5298 <_Flutter_MMFoundation_BindContext+0x65a0e7c>
10a0c5158: b00af9c8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0c515c: f9440913    	ldr	x19, [x8, #0x810] ; tigerReporter
10a0c5160: aa1603e0    	mov	x0, x22
10a0c5164: aa1303e1    	mov	x1, x19
10a0c5168: 955e58b7    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c516c: aa1d03fd    	mov	x29, x29
10a0c5170: 955e58b8    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c5174: aa0003f3    	mov	x19, x0
10a0c5178: f9440721    	ldr	x1, [x25, #0x808] ; didDisplayDataItem:
10a0c517c: aa1703e2    	mov	x2, x23
10a0c5180: 955e58b1    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5184: aa1303e0    	mov	x0, x19
10a0c5188: 955e58b5    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c518c: d00b0728    	adrp	x8, 0x1201ab000 <dyld_stub_binder+0x1201ab000>
10a0c5190: f9420d00    	ldr	x0, [x8, #0x418]
10a0c5194: aa1803e1    	mov	x1, x24
10a0c5198: 955e58ab    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c519c: aa0003e2    	mov	x2, x0
10a0c51a0: d00b01e8    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
10a0c51a4: f9442d01    	ldr	x1, [x8, #0x858] ; isKindOfClass:
10a0c51a8: f9401bf5    	ldr	x21, [sp, #0x30]
10a0c51ac: aa1503e0    	mov	x0, x21
10a0c51b0: 955e58a5    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c51b4: 340000c0    	cbz	w0, 0x10a0c51cc <_Flutter_MMFoundation_BindContext+0x65a0db0>
10a0c51b8: 900afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c51bc: f9436101    	ldr	x1, [x8, #0x6c0] ; footerCellWillDisplay:
10a0c51c0: aa1603e0    	mov	x0, x22
10a0c51c4: aa1503e2    	mov	x2, x21
10a0c51c8: 955e589f    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c51cc: 900afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c51d0: f9436501    	ldr	x1, [x8, #0x6c8] ; tryClearMissReadJumpBtnWhenWillDisplay:
10a0c51d4: aa1603e0    	mov	x0, x22
10a0c51d8: aa1703e2    	mov	x2, x23
10a0c51dc: 955e589a    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c51e0: 900afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c51e4: f9430901    	ldr	x1, [x8, #0x610] ; contentItemWillDisplayForCell:
10a0c51e8: aa1603e0    	mov	x0, x22
10a0c51ec: aa1503e2    	mov	x2, x21
10a0c51f0: 955e5895    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c51f4: f00b01c8    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
10a0c51f8: f9427501    	ldr	x1, [x8, #0x4e8] ; contentView
10a0c51fc: aa1503e0    	mov	x0, x21
10a0c5200: 955e5891    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5204: aa1d03fd    	mov	x29, x29
10a0c5208: 955e5892    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c520c: aa0003f4    	mov	x20, x0
10a0c5210: d00b0228    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
10a0c5214: f9470901    	ldr	x1, [x8, #0xe10] ; viewWithTag:
10a0c5218: 52800022    	mov	w2, #0x1                ; =1
10a0c521c: 72a00202    	movk	w2, #0x10, lsl #16
10a0c5220: 955e5889    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5224: aa1d03fd    	mov	x29, x29
10a0c5228: 955e588a    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c522c: aa0003f3    	mov	x19, x0
10a0c5230: aa1403e0    	mov	x0, x20
10a0c5234: 955e588a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5238: f94023f4    	ldr	x20, [sp, #0x40]
10a0c523c: b40000b3    	cbz	x19, 0x10a0c5250 <_Flutter_MMFoundation_BindContext+0x65a0e34>
10a0c5240: d00af0e8    	adrp	x8, 0x11fee3000 <dyld_stub_binder+0x11fee3000>
10a0c5244: f9409501    	ldr	x1, [x8, #0x128] ; willDisplay
10a0c5248: aa1303e0    	mov	x0, x19
10a0c524c: 955e587e    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c5250: aa1303e0    	mov	x0, x19
10a0c5254: 955e5882    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5258: aa1703e0    	mov	x0, x23
10a0c525c: 955e5880    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5260: aa1403e0    	mov	x0, x20
10a0c5264: 955e587e    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5268: aa1503e0    	mov	x0, x21
10a0c526c: 955e587c    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5270: aa1a03e0    	mov	x0, x26
10a0c5274: 955e587a    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c5278: a94d7bfd    	ldp	x29, x30, [sp, #0xd0]
10a0c527c: a94c4ff4    	ldp	x20, x19, [sp, #0xc0]
10a0c5280: a94b57f6    	ldp	x22, x21, [sp, #0xb0]
10a0c5284: a94a5ff8    	ldp	x24, x23, [sp, #0xa0]
10a0c5288: a94967fa    	ldp	x26, x25, [sp, #0x90]
10a0c528c: a9486ffc    	ldp	x28, x27, [sp, #0x80]
10a0c5290: 910383ff    	add	sp, sp, #0xe0
10a0c5294: d65f03c0    	ret
10a0c5298: b00af9c8    	adrp	x8, 0x11fffe000 <dyld_stub_binder+0x11fffe000>
10a0c529c: f9440913    	ldr	x19, [x8, #0x810] ; tigerReporter
10a0c52a0: aa1603e0    	mov	x0, x22
10a0c52a4: aa1303e1    	mov	x1, x19
10a0c52a8: 955e5867    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c52ac: aa1d03fd    	mov	x29, x29
10a0c52b0: 955e5868    	bl	0x10f85b450 <_UR_96F1_B25D+0x3a640c0>
10a0c52b4: aa0003f4    	mov	x20, x0
10a0c52b8: 900afea8    	adrp	x8, 0x120099000 <dyld_stub_binder+0x120099000>
10a0c52bc: f9435d01    	ldr	x1, [x8, #0x6b8] ; hasDisplayedDataItem:
10a0c52c0: aa1703e2    	mov	x2, x23
10a0c52c4: 955e5860    	bl	0x10f85b444 <_UR_96F1_B25D+0x3a640b4>
10a0c52c8: aa0003f5    	mov	x21, x0
10a0c52cc: aa1403e0    	mov	x0, x20
10a0c52d0: 955e5863    	bl	0x10f85b45c <_UR_96F1_B25D+0x3a640cc>
10a0c52d4: 3607f475    	tbz	w21, #0x0, 0x10a0c5160 <_Flutter_MMFoundation_BindContext+0x65a0d44>
10a0c52d8: 17ffffad    	b	0x10a0c518c <_Flutter_MMFoundation_BindContext+0x65a0d70>
