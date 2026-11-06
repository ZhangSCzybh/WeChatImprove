
/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011210f56c <_O266DecReleaseOutputPicture>:
1157db5d4: a9ba6ffc    	stp	x28, x27, [sp, #-0x60]!
1157db5d8: a90167fa    	stp	x26, x25, [sp, #0x10]
1157db5dc: a9025ff8    	stp	x24, x23, [sp, #0x20]
1157db5e0: a90357f6    	stp	x22, x21, [sp, #0x30]
1157db5e4: a9044ff4    	stp	x20, x19, [sp, #0x40]
1157db5e8: a9057bfd    	stp	x29, x30, [sp, #0x50]
1157db5ec: 910143fd    	add	x29, sp, #0x50
1157db5f0: aa0403f6    	mov	x22, x4
1157db5f4: aa0303f4    	mov	x20, x3
1157db5f8: aa0203f3    	mov	x19, x2
1157db5fc: aa0003f5    	mov	x21, x0
1157db600: aa0203e0    	mov	x0, x2
1157db604: 945a03f4    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db608: aa1403e0    	mov	x0, x20
1157db60c: 945a03f2    	bl	0x116e5c5d4 <dyld_stub_binder+0x116e5c5d4>
1157db610: d004a688    	adrp	x8, 0x11ecad000 <dyld_stub_binder+0x11ecad000>
1157db614: f9473519    	ldr	x25, [x8, #0xe68]
1157db618: aa1303e0    	mov	x0, x19
1157db61c: aa1903e1    	mov	x1, x25
1157db620: 945a03c9    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db624: aa1d03fd    	mov	x29, x29
1157db628: 945a03f4    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db62c: aa0003f7    	mov	x23, x0
1157db630: f004a648    	adrp	x8, 0x11eca6000 <dyld_stub_binder+0x11eca6000>
1157db634: f9442901    	ldr	x1, [x8, #0x850]
1157db638: 945a03c3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db63c: f100081f    	cmp	x0, #0x2
1157db640: 540000e3    	b.lo	0x1157db65c <_O266DecReleaseOutputPicture+0x36cc0f0>
1157db644: d004a4e8    	adrp	x8, 0x11ec79000 <dyld_stub_binder+0x11ec79000>
1157db648: f940d501    	ldr	x1, [x8, #0x1a8]
1157db64c: aa1403e0    	mov	x0, x20
1157db650: 945a03bd    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db654: aa0003f8    	mov	x24, x0
1157db658: 14000002    	b	0x1157db660 <_O266DecReleaseOutputPicture+0x36cc0f4>
1157db65c: 52800018    	mov	w24, #0x0               ; =0
1157db660: aa1703e0    	mov	x0, x23
1157db664: 945a03d6    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db668: 34000136    	cbz	w22, 0x1157db68c <_O266DecReleaseOutputPicture+0x36cc120>
1157db66c: 90049028    	adrp	x8, 0x11e9df000 <dyld_stub_binder+0x11e9df000>
1157db670: f942c501    	ldr	x1, [x8, #0x588]
1157db674: aa1303e0    	mov	x0, x19
1157db678: 945a03b3    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db67c: aa1d03fd    	mov	x29, x29
1157db680: 945a03de    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db684: aa0003f6    	mov	x22, x0
1157db688: 14000002    	b	0x1157db690 <_O266DecReleaseOutputPicture+0x36cc124>
1157db68c: d2800016    	mov	x22, #0x0               ; =0
1157db690: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db694: f9423101    	ldr	x1, [x8, #0x460]
1157db698: aa1503e0    	mov	x0, x21
1157db69c: 945a03aa    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db6a0: aa1d03fd    	mov	x29, x29
1157db6a4: 945a03d5    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db6a8: aa0003f7    	mov	x23, x0
1157db6ac: d004a668    	adrp	x8, 0x11eca9000 <dyld_stub_binder+0x11eca9000>
1157db6b0: f941b101    	ldr	x1, [x8, #0x360]
1157db6b4: 945a03a4    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db6b8: aa1d03fd    	mov	x29, x29
1157db6bc: 945a03cf    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db6c0: aa0003fa    	mov	x26, x0
1157db6c4: eb13001f    	cmp	x0, x19
1157db6c8: 54000060    	b.eq	0x1157db6d4 <_O266DecReleaseOutputPicture+0x36cc168>
1157db6cc: 5280001b    	mov	w27, #0x0               ; =0
1157db6d0: 1400000a    	b	0x1157db6f8 <_O266DecReleaseOutputPicture+0x36cc18c>
1157db6d4: f0049588    	adrp	x8, 0x11ea8e000 <dyld_stub_binder+0x11ea8e000>
1157db6d8: f943fd01    	ldr	x1, [x8, #0x7f8]
1157db6dc: aa1703e0    	mov	x0, x23
1157db6e0: 945a0399    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db6e4: aa1d03fd    	mov	x29, x29
1157db6e8: 945a03c4    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db6ec: eb14001f    	cmp	x0, x20
1157db6f0: 1a9f17fb    	cset	w27, eq
1157db6f4: 945a03b2    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db6f8: aa1a03e0    	mov	x0, x26
1157db6fc: 945a03b0    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db700: b4000177    	cbz	x23, 0x1157db72c <_O266DecReleaseOutputPicture+0x36cc1c0>
1157db704: 3700015b    	tbnz	w27, #0x0, 0x1157db72c <_O266DecReleaseOutputPicture+0x36cc1c0>
1157db708: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db70c: f9428101    	ldr	x1, [x8, #0x500]
1157db710: aa1503e0    	mov	x0, x21
1157db714: aa1703e2    	mov	x2, x23
1157db718: 52800023    	mov	w3, #0x1                ; =1
1157db71c: 945a038a    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db720: aa1703e0    	mov	x0, x23
1157db724: 945a03a6    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db728: d2800017    	mov	x23, #0x0               ; =0
1157db72c: 340000fb    	cbz	w27, 0x1157db748 <_O266DecReleaseOutputPicture+0x36cc1dc>
1157db730: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db734: f9429d01    	ldr	x1, [x8, #0x538]
1157db738: aa1703e0    	mov	x0, x23
1157db73c: 945a0382    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db740: aa0003fb    	mov	x27, x0
1157db744: 14000015    	b	0x1157db798 <_O266DecReleaseOutputPicture+0x36cc22c>
1157db748: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db74c: f9422501    	ldr	x1, [x8, #0x448]
1157db750: aa1503e0    	mov	x0, x21
1157db754: 945a037c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db758: 36000060    	tbz	w0, #0x0, 0x1157db764 <_O266DecReleaseOutputPicture+0x36cc1f8>
1157db75c: 5280003b    	mov	w27, #0x1               ; =1
1157db760: 1400000e    	b	0x1157db798 <_O266DecReleaseOutputPicture+0x36cc22c>
1157db764: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157db768: f9443901    	ldr	x1, [x8, #0x870]
1157db76c: aa1503e0    	mov	x0, x21
1157db770: 945a0375    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db774: aa1d03fd    	mov	x29, x29
1157db778: 945a03a0    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db77c: aa0003fa    	mov	x26, x0
1157db780: b004a668    	adrp	x8, 0x11eca8000 <dyld_stub_binder+0x11eca8000>
1157db784: f9441501    	ldr	x1, [x8, #0x828]
1157db788: 945a036f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db78c: aa0003fb    	mov	x27, x0
1157db790: aa1a03e0    	mov	x0, x26
1157db794: 945a038a    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db798: d003fb68    	adrp	x8, 0x11d749000 <dyld_stub_binder+0x11d749000>
1157db79c: f947a108    	ldr	x8, [x8, #0xf40]
1157db7a0: f9400102    	ldr	x2, [x8]
1157db7a4: d0049068    	adrp	x8, 0x11e9e9000 <dyld_stub_binder+0x11e9e9000>
1157db7a8: f946a901    	ldr	x1, [x8, #0xd50]
1157db7ac: aa1603e0    	mov	x0, x22
1157db7b0: 945a0365    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db7b4: aa1d03fd    	mov	x29, x29
1157db7b8: 945a0390    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db7bc: aa0003fa    	mov	x26, x0
1157db7c0: b40002e0    	cbz	x0, 0x1157db81c <_O266DecReleaseOutputPicture+0x36cc2b0>
1157db7c4: aa1303e0    	mov	x0, x19
1157db7c8: aa1903e1    	mov	x1, x25
1157db7cc: 945a035e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db7d0: aa1d03fd    	mov	x29, x29
1157db7d4: 945a0389    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db7d8: aa0003f9    	mov	x25, x0
1157db7dc: 9004a668    	adrp	x8, 0x11eca7000 <dyld_stub_binder+0x11eca7000>
1157db7e0: f942cd01    	ldr	x1, [x8, #0x598]
1157db7e4: 945a0358    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db7e8: aa1d03fd    	mov	x29, x29
1157db7ec: 945a0383    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db7f0: aa0003fb    	mov	x27, x0
1157db7f4: 945a0372    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db7f8: aa1903e0    	mov	x0, x25
1157db7fc: 945a0370    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db800: eb1b035f    	cmp	x26, x27
1157db804: 54000280    	b.eq	0x1157db854 <_O266DecReleaseOutputPicture+0x36cc2e8>
1157db808: d004a4e8    	adrp	x8, 0x11ec79000 <dyld_stub_binder+0x11ec79000>
1157db80c: f940d501    	ldr	x1, [x8, #0x1a8]
1157db810: aa1a03e0    	mov	x0, x26
1157db814: 945a034c    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db818: aa0003fb    	mov	x27, x0
1157db81c: 6b1b031f    	cmp	w24, w27
1157db820: 54000860    	b.eq	0x1157db92c <_O266DecReleaseOutputPicture+0x36cc3c0>
1157db824: b40001f7    	cbz	x23, 0x1157db860 <_O266DecReleaseOutputPicture+0x36cc2f4>
1157db828: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db82c: f9428501    	ldr	x1, [x8, #0x508]
1157db830: aa1703e0    	mov	x0, x23
1157db834: aa1b03e2    	mov	x2, x27
1157db838: 945a0343    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db83c: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db840: f9428901    	ldr	x1, [x8, #0x510]
1157db844: aa1703e0    	mov	x0, x23
1157db848: aa1803e2    	mov	x2, x24
1157db84c: 945a033e    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db850: 14000031    	b	0x1157db914 <_O266DecReleaseOutputPicture+0x36cc3a8>
1157db854: 360006d8    	tbz	w24, #0x0, 0x1157db92c <_O266DecReleaseOutputPicture+0x36cc3c0>
1157db858: 5280001b    	mov	w27, #0x0               ; =0
1157db85c: b5fffe77    	cbnz	x23, 0x1157db828 <_O266DecReleaseOutputPicture+0x36cc2bc>
1157db860: b004abc8    	adrp	x8, 0x11ed54000 <dyld_stub_binder+0x11ed54000>
1157db864: f944c900    	ldr	x0, [x8, #0x990]
1157db868: 945a02e0    	bl	0x116e5c3e8 <dyld_stub_binder+0x116e5c3e8>
1157db86c: aa0003f7    	mov	x23, x0
1157db870: d0048fa8    	adrp	x8, 0x11e9d1000 <dyld_stub_binder+0x11e9d1000>
1157db874: f9405501    	ldr	x1, [x8, #0xa8]
1157db878: aa1303e2    	mov	x2, x19
1157db87c: 945a0332    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db880: f0049588    	adrp	x8, 0x11ea8e000 <dyld_stub_binder+0x11ea8e000>
1157db884: f9442d01    	ldr	x1, [x8, #0x858]
1157db888: aa1703e0    	mov	x0, x23
1157db88c: aa1403e2    	mov	x2, x20
1157db890: 945a032d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db894: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db898: f9428501    	ldr	x1, [x8, #0x508]
1157db89c: aa1703e0    	mov	x0, x23
1157db8a0: aa1b03e2    	mov	x2, x27
1157db8a4: 945a0328    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db8a8: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db8ac: f9428901    	ldr	x1, [x8, #0x510]
1157db8b0: aa1703e0    	mov	x0, x23
1157db8b4: aa1803e2    	mov	x2, x24
1157db8b8: 945a0323    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db8bc: d0049ae8    	adrp	x8, 0x11eb39000 <dyld_stub_binder+0x11eb39000>
1157db8c0: f9443901    	ldr	x1, [x8, #0x870]
1157db8c4: aa1503e0    	mov	x0, x21
1157db8c8: 945a031f    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db8cc: aa1d03fd    	mov	x29, x29
1157db8d0: 945a034a    	bl	0x116e5c5f8 <dyld_stub_binder+0x116e5c5f8>
1157db8d4: aa0003f8    	mov	x24, x0
1157db8d8: f0048fa8    	adrp	x8, 0x11e9d2000 <dyld_stub_binder+0x11e9d2000>
1157db8dc: f942cd01    	ldr	x1, [x8, #0x598]
1157db8e0: 945a0319    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db8e4: aa0003e2    	mov	x2, x0
1157db8e8: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db8ec: f942a101    	ldr	x1, [x8, #0x540]
1157db8f0: aa1703e0    	mov	x0, x23
1157db8f4: 945a0314    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db8f8: aa1803e0    	mov	x0, x24
1157db8fc: 945a0330    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db900: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db904: f9428d01    	ldr	x1, [x8, #0x518]
1157db908: aa1503e0    	mov	x0, x21
1157db90c: aa1703e2    	mov	x2, x23
1157db910: 945a030d    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db914: d0049548    	adrp	x8, 0x11ea85000 <dyld_stub_binder+0x11ea85000>
1157db918: f945a101    	ldr	x1, [x8, #0xb40]
1157db91c: aa1703e0    	mov	x0, x23
1157db920: aa1603e2    	mov	x2, x22
1157db924: 945a0308    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db928: 1400000b    	b	0x1157db954 <_O266DecReleaseOutputPicture+0x36cc3e8>
1157db92c: b4000157    	cbz	x23, 0x1157db954 <_O266DecReleaseOutputPicture+0x36cc3e8>
1157db930: 9004a5c8    	adrp	x8, 0x11ec93000 <dyld_stub_binder+0x11ec93000>
1157db934: f9428101    	ldr	x1, [x8, #0x500]
1157db938: aa1503e0    	mov	x0, x21
1157db93c: aa1703e2    	mov	x2, x23
1157db940: 52800003    	mov	w3, #0x0                ; =0
1157db944: 945a0300    	bl	0x116e5c544 <dyld_stub_binder+0x116e5c544>
1157db948: aa1703e0    	mov	x0, x23
1157db94c: 945a031c    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db950: d2800017    	mov	x23, #0x0               ; =0
1157db954: aa1a03e0    	mov	x0, x26
1157db958: 945a0319    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db95c: aa1603e0    	mov	x0, x22
1157db960: 945a0317    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db964: aa1403e0    	mov	x0, x20
1157db968: 945a0315    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db96c: aa1303e0    	mov	x0, x19
1157db970: 945a0313    	bl	0x116e5c5bc <dyld_stub_binder+0x116e5c5bc>
1157db974: aa1703e0    	mov	x0, x23
1157db978: a9457bfd    	ldp	x29, x30, [sp, #0x50]
1157db97c: a9444ff4    	ldp	x20, x19, [sp, #0x40]
1157db980: a94357f6    	ldp	x22, x21, [sp, #0x30]
1157db984: a9425ff8    	ldp	x24, x23, [sp, #0x20]
1157db988: a94167fa    	ldp	x26, x25, [sp, #0x10]
1157db98c: a8c66ffc    	ldp	x28, x27, [sp], #0x60
1157db990: 145a02a8    	b	0x116e5c430 <dyld_stub_binder+0x116e5c430>
