
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000011328cab8 <_O266DecReleaseOutputPicture>:
1167576d8: d10443ff    	sub	sp, sp, #0x110
1167576dc: 6d0833ed    	stp	d13, d12, [sp, #0x80]
1167576e0: 6d092beb    	stp	d11, d10, [sp, #0x90]
1167576e4: 6d0a23e9    	stp	d9, d8, [sp, #0xa0]
1167576e8: a90b6ffc    	stp	x28, x27, [sp, #0xb0]
1167576ec: a90c67fa    	stp	x26, x25, [sp, #0xc0]
1167576f0: a90d5ff8    	stp	x24, x23, [sp, #0xd0]
1167576f4: a90e57f6    	stp	x22, x21, [sp, #0xe0]
1167576f8: a90f4ff4    	stp	x20, x19, [sp, #0xf0]
1167576fc: a9107bfd    	stp	x29, x30, [sp, #0x100]
116757700: 910403fd    	add	x29, sp, #0x100
116757704: aa0203f3    	mov	x19, x2
116757708: aa0003f4    	mov	x20, x0
11675770c: aa0203e0    	mov	x0, x2
116757710: 946f4998    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116757714: 9004b9a8    	adrp	x8, 0x11fe8b000 <dyld_stub_binder+0x11fe8b000>
116757718: f9447d01    	ldr	x1, [x8, #0x8f8]
11675771c: aa1403e0    	mov	x0, x20
116757720: 946f4973    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757724: 34001180    	cbz	w0, 0x116757954 <_O266DecReleaseOutputPicture+0x34cae9c>
116757728: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
11675772c: b9874908    	ldrsw	x8, [x8, #0x748]
116757730: f8686a80    	ldr	x0, [x20, x8]
116757734: b004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
116757738: f9435101    	ldr	x1, [x8, #0x6a0]
11675773c: 946f496c    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757740: b40010a0    	cbz	x0, 0x116757954 <_O266DecReleaseOutputPicture+0x34cae9c>
116757744: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757748: f9477101    	ldr	x1, [x8, #0xee0]
11675774c: aa1403e0    	mov	x0, x20
116757750: 946f4967    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757754: 34000520    	cbz	w0, 0x1167577f8 <_O266DecReleaseOutputPicture+0x34cad40>
116757758: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
11675775c: b9877908    	ldrsw	x8, [x8, #0x778]
116757760: 38686a88    	ldrb	w8, [x20, x8]
116757764: d004d9d5    	adrp	x21, 0x120291000 <dyld_stub_binder+0x120291000>
116757768: 7100051f    	cmp	w8, #0x1
11675776c: 540002e1    	b.ne	0x1167577c8 <_O266DecReleaseOutputPicture+0x34cad10>
116757770: b98786a8    	ldrsw	x8, [x21, #0x784]
116757774: 38286a9f    	strb	wzr, [x20, x8]
116757778: f004d288    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
11675777c: f9448500    	ldr	x0, [x8, #0x908]
116757780: d004b728    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
116757784: f940f501    	ldr	x1, [x8, #0x1e8]
116757788: 946f4959    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675778c: d004b708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116757790: f942a901    	ldr	x1, [x8, #0x550]
116757794: d00420a8    	adrp	x8, 0x11eb6d000 <dyld_stub_binder+0x11eb6d000>
116757798: 91212108    	add	x8, x8, #0x848
11675779c: f90003e8    	str	x8, [sp]
1167577a0: f0030b85    	adrp	x5, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
1167577a4: 911b90a5    	add	x5, x5, #0x6e4
1167577a8: f0030b87    	adrp	x7, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
1167577ac: 912494e7    	add	x7, x7, #0x925
1167577b0: 52800042    	mov	w2, #0x2                ; =2
1167577b4: d2800003    	mov	x3, #0x0                ; =0
1167577b8: 52800004    	mov	w4, #0x0                ; =0
1167577bc: 528072a6    	mov	w6, #0x395              ; =917
1167577c0: 946f494b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167577c4: 14000064    	b	0x116757954 <_O266DecReleaseOutputPicture+0x34cae9c>
1167577c8: f004cd88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1167577cc: f9458101    	ldr	x1, [x8, #0xb00]
1167577d0: aa1303e0    	mov	x0, x19
1167577d4: 946f4946    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167577d8: b98786a8    	ldrsw	x8, [x21, #0x784]
1167577dc: f100041f    	cmp	x0, #0x1
1167577e0: 54000081    	b.ne	0x1167577f0 <_O266DecReleaseOutputPicture+0x34cad38>
1167577e4: 52800029    	mov	w9, #0x1                ; =1
1167577e8: 38286a89    	strb	w9, [x20, x8]
1167577ec: 14000003    	b	0x1167577f8 <_O266DecReleaseOutputPicture+0x34cad40>
1167577f0: 38686a88    	ldrb	w8, [x20, x8]
1167577f4: 36001f28    	tbz	w8, #0x0, 0x116757bd8 <_O266DecReleaseOutputPicture+0x34cb120>
1167577f8: f004d288    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
1167577fc: f9448500    	ldr	x0, [x8, #0x908]
116757800: d004b728    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
116757804: f940f501    	ldr	x1, [x8, #0x1e8]
116757808: 946f4939    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675780c: d004b708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116757810: f942a901    	ldr	x1, [x8, #0x550]
116757814: d00420a8    	adrp	x8, 0x11eb6d000 <dyld_stub_binder+0x11eb6d000>
116757818: 91222108    	add	x8, x8, #0x888
11675781c: f90003e8    	str	x8, [sp]
116757820: f0030b85    	adrp	x5, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
116757824: 911b90a5    	add	x5, x5, #0x6e4
116757828: f0030b87    	adrp	x7, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
11675782c: 912494e7    	add	x7, x7, #0x925
116757830: 52800042    	mov	w2, #0x2                ; =2
116757834: d2800003    	mov	x3, #0x0                ; =0
116757838: 52800004    	mov	w4, #0x0                ; =0
11675783c: 528073e6    	mov	w6, #0x39f              ; =927
116757840: 946f492b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757844: 9004d108    	adrp	x8, 0x120177000 <dyld_stub_binder+0x120177000>
116757848: f9457900    	ldr	x0, [x8, #0xaf0]
11675784c: 9004cd48    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
116757850: f947ad01    	ldr	x1, [x8, #0xf58]
116757854: 946f4926    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757858: aa0003e2    	mov	x2, x0
11675785c: 9004cd68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
116757860: f9442d01    	ldr	x1, [x8, #0x858]
116757864: aa1303e0    	mov	x0, x19
116757868: 946f4921    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
11675786c: 34000740    	cbz	w0, 0x116757954 <_O266DecReleaseOutputPicture+0x34cae9c>
116757870: aa1303e0    	mov	x0, x19
116757874: 946f493f    	bl	0x118329d70 <dyld_stub_binder+0x118329d70>
116757878: b004cd68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
11675787c: f9400d01    	ldr	x1, [x8, #0x18]
116757880: aa1403e2    	mov	x2, x20
116757884: 946f491a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757888: 1e604008    	fmov	d8, d0
11675788c: f004d419    	adrp	x25, 0x1201da000 <dyld_stub_binder+0x1201da000>
116757890: f9462728    	ldr	x8, [x25, #0xc48]
116757894: a906a3f4    	stp	x20, x8, [sp, #0x68]
116757898: b004cd48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
11675789c: f9427515    	ldr	x21, [x8, #0x4e8]
1167578a0: 9101a3e0    	add	x0, sp, #0x68
1167578a4: aa1503e1    	mov	x1, x21
1167578a8: 946f4914    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
1167578ac: aa1d03fd    	mov	x29, x29
1167578b0: 946f4939    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
1167578b4: aa0003f6    	mov	x22, x0
1167578b8: 9004cda8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
1167578bc: f9467901    	ldr	x1, [x8, #0xcf0]
1167578c0: aa1303e0    	mov	x0, x19
1167578c4: aa1603e2    	mov	x2, x22
1167578c8: 946f4909    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167578cc: 1e604009    	fmov	d9, d0
1167578d0: aa1603e0    	mov	x0, x22
1167578d4: 946f4921    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
1167578d8: f004cd88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
1167578dc: f9458116    	ldr	x22, [x8, #0xb00]
1167578e0: aa1303e0    	mov	x0, x19
1167578e4: aa1603e1    	mov	x1, x22
1167578e8: 946f4901    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167578ec: f100041f    	cmp	x0, #0x1
1167578f0: 540004c1    	b.ne	0x116757988 <_O266DecReleaseOutputPicture+0x34caed0>
1167578f4: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167578f8: b9878908    	ldrsw	x8, [x8, #0x788]
1167578fc: fc286a88    	str	d8, [x20, x8]
116757900: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757904: b9878d08    	ldrsw	x8, [x8, #0x78c]
116757908: fc286a88    	str	d8, [x20, x8]
11675790c: f9462728    	ldr	x8, [x25, #0xc48]
116757910: a905a3f4    	stp	x20, x8, [sp, #0x58]
116757914: 910163e0    	add	x0, sp, #0x58
116757918: aa1503e1    	mov	x1, x21
11675791c: 946f48f7    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116757920: aa1d03fd    	mov	x29, x29
116757924: 946f491c    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757928: aa0003f5    	mov	x21, x0
11675792c: b004cda8    	adrp	x8, 0x12010c000 <dyld_stub_binder+0x12010c000>
116757930: f9402101    	ldr	x1, [x8, #0x40]
116757934: 946f48ee    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757938: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
11675793c: b9879108    	ldrsw	x8, [x8, #0x790]
116757940: fc286a80    	str	d0, [x20, x8]
116757944: aa1503e0    	mov	x0, x21
116757948: 946f4904    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11675794c: aa1303e0    	mov	x0, x19
116757950: 946f4902    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757954: aa1303e0    	mov	x0, x19
116757958: 946f4900    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
11675795c: a9507bfd    	ldp	x29, x30, [sp, #0x100]
116757960: a94f4ff4    	ldp	x20, x19, [sp, #0xf0]
116757964: a94e57f6    	ldp	x22, x21, [sp, #0xe0]
116757968: a94d5ff8    	ldp	x24, x23, [sp, #0xd0]
11675796c: a94c67fa    	ldp	x26, x25, [sp, #0xc0]
116757970: a94b6ffc    	ldp	x28, x27, [sp, #0xb0]
116757974: 6d4a23e9    	ldp	d9, d8, [sp, #0xa0]
116757978: 6d492beb    	ldp	d11, d10, [sp, #0x90]
11675797c: 6d4833ed    	ldp	d13, d12, [sp, #0x80]
116757980: 910443ff    	add	sp, sp, #0x110
116757984: d65f03c0    	ret
116757988: aa1303e0    	mov	x0, x19
11675798c: aa1603e1    	mov	x1, x22
116757990: 946f48d7    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757994: f100081f    	cmp	x0, #0x2
116757998: 540007c1    	b.ne	0x116757a90 <_O266DecReleaseOutputPicture+0x34cafd8>
11675799c: 9004cd68    	adrp	x8, 0x120103000 <dyld_stub_binder+0x120103000>
1167579a0: f944fd01    	ldr	x1, [x8, #0x9f8]
1167579a4: aa1403e0    	mov	x0, x20
1167579a8: 946f48d1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167579ac: 340000e0    	cbz	w0, 0x1167579c8 <_O266DecReleaseOutputPicture+0x34caf10>
1167579b0: d004cd88    	adrp	x8, 0x120109000 <dyld_stub_binder+0x120109000>
1167579b4: f9445101    	ldr	x1, [x8, #0x8a0]
1167579b8: aa1403e0    	mov	x0, x20
1167579bc: 52800002    	mov	w2, #0x0                ; =0
1167579c0: 52800003    	mov	w3, #0x0                ; =0
1167579c4: 946f48ca    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167579c8: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
1167579cc: b9878d08    	ldrsw	x8, [x8, #0x78c]
1167579d0: fc686a80    	ldr	d0, [x20, x8]
1167579d4: 1e60390b    	fsub	d11, d8, d0
1167579d8: fc286a88    	str	d8, [x20, x8]
1167579dc: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
1167579e0: f9477501    	ldr	x1, [x8, #0xee8]
1167579e4: aa1403e0    	mov	x0, x20
1167579e8: 946f48c1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
1167579ec: 34000060    	cbz	w0, 0x1167579f8 <_O266DecReleaseOutputPicture+0x34caf40>
1167579f0: 1e602168    	fcmp	d11, #0.0
1167579f4: 54fffac4    	b.mi	0x11675794c <_O266DecReleaseOutputPicture+0x34cae94>
1167579f8: d004bea8    	adrp	x8, 0x11ff2d000 <dyld_stub_binder+0x11ff2d000>
1167579fc: f9458916    	ldr	x22, [x8, #0xb10]
116757a00: aa1403e0    	mov	x0, x20
116757a04: aa1603e1    	mov	x1, x22
116757a08: 946f48b9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757a0c: 1e61400a    	fneg	d10, d0
116757a10: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757a14: b9879108    	ldrsw	x8, [x8, #0x790]
116757a18: fc686a81    	ldr	d1, [x20, x8]
116757a1c: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757a20: b9878918    	ldrsw	x24, [x8, #0x788]
116757a24: fc786a80    	ldr	d0, [x20, x24]
116757a28: 1e602028    	fcmp	d1, #0.0
116757a2c: d004d9db    	adrp	x27, 0x120291000 <dyld_stub_binder+0x120291000>
116757a30: 9004cda8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116757a34: 54000f81    	b.ne	0x116757c24 <_O266DecReleaseOutputPicture+0x34cb16c>
116757a38: 1e68380c    	fsub	d12, d0, d8
116757a3c: b9874f7a    	ldrsw	x26, [x27, #0x74c]
116757a40: f87a6a80    	ldr	x0, [x20, x26]
116757a44: f947a517    	ldr	x23, [x8, #0xf48]
116757a48: aa1703e1    	mov	x1, x23
116757a4c: 946f48a8    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757a50: 1e602180    	fcmp	d12, d0
116757a54: 54000fcd    	b.le	0x116757c4c <_O266DecReleaseOutputPicture+0x34cb194>
116757a58: aa1403e0    	mov	x0, x20
116757a5c: aa1603e1    	mov	x1, x22
116757a60: 946f48a3    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757a64: 1e60400a    	fmov	d10, d0
116757a68: fc786a80    	ldr	d0, [x20, x24]
116757a6c: 1e683808    	fsub	d8, d0, d8
116757a70: f87a6a80    	ldr	x0, [x20, x26]
116757a74: aa1703e1    	mov	x1, x23
116757a78: 946f489d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757a7c: 1e603900    	fsub	d0, d8, d0
116757a80: 1e7a1001    	fmov	d1, #-0.25000000
116757a84: 1e610800    	fmul	d0, d0, d1
116757a88: 1e6a380a    	fsub	d10, d0, d10
116757a8c: 14000070    	b	0x116757c4c <_O266DecReleaseOutputPicture+0x34cb194>
116757a90: aa1303e0    	mov	x0, x19
116757a94: aa1603e1    	mov	x1, x22
116757a98: 946f4895    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757a9c: f1000c1f    	cmp	x0, #0x3
116757aa0: 540000c0    	b.eq	0x116757ab8 <_O266DecReleaseOutputPicture+0x34cb000>
116757aa4: aa1303e0    	mov	x0, x19
116757aa8: aa1603e1    	mov	x1, x22
116757aac: 946f4890    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757ab0: f100101f    	cmp	x0, #0x4
116757ab4: 54fff4c1    	b.ne	0x11675794c <_O266DecReleaseOutputPicture+0x34cae94>
116757ab8: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757abc: f9477501    	ldr	x1, [x8, #0xee8]
116757ac0: aa1403e0    	mov	x0, x20
116757ac4: 946f488a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757ac8: d004d9d7    	adrp	x23, 0x120291000 <dyld_stub_binder+0x120291000>
116757acc: 34000080    	cbz	w0, 0x116757adc <_O266DecReleaseOutputPicture+0x34cb024>
116757ad0: b98782e8    	ldrsw	x8, [x23, #0x780]
116757ad4: 38686a88    	ldrb	w8, [x20, x8]
116757ad8: 3707f3a8    	tbnz	w8, #0x0, 0x11675794c <_O266DecReleaseOutputPicture+0x34cae94>
116757adc: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757ae0: f9477915    	ldr	x21, [x8, #0xef0]
116757ae4: aa1403e0    	mov	x0, x20
116757ae8: aa1503e1    	mov	x1, x21
116757aec: 946f4880    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757af0: aa1d03fd    	mov	x29, x29
116757af4: 946f48a8    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757af8: aa0003f6    	mov	x22, x0
116757afc: 946f4897    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757b00: b40002b6    	cbz	x22, 0x116757b54 <_O266DecReleaseOutputPicture+0x34cb09c>
116757b04: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757b08: b9879508    	ldrsw	x8, [x8, #0x794]
116757b0c: 38686a88    	ldrb	w8, [x20, x8]
116757b10: 7100051f    	cmp	w8, #0x1
116757b14: 540001c1    	b.ne	0x116757b4c <_O266DecReleaseOutputPicture+0x34cb094>
116757b18: aa1403e0    	mov	x0, x20
116757b1c: aa1503e1    	mov	x1, x21
116757b20: 946f4873    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757b24: aa1d03fd    	mov	x29, x29
116757b28: 946f489b    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757b2c: aa0003f5    	mov	x21, x0
116757b30: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757b34: f9474501    	ldr	x1, [x8, #0xe88]
116757b38: aa1403e0    	mov	x0, x20
116757b3c: aa1503e2    	mov	x2, x21
116757b40: 946f486b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757b44: aa1503e0    	mov	x0, x21
116757b48: 946f4884    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757b4c: b98782e8    	ldrsw	x8, [x23, #0x780]
116757b50: 38286a9f    	strb	wzr, [x20, x8]
116757b54: 9100c3e0    	add	x0, sp, #0x30
116757b58: aa1403e1    	mov	x1, x20
116757b5c: 946f4852    	bl	0x118329ca4 <dyld_stub_binder+0x118329ca4>
116757b60: b98782e8    	ldrsw	x8, [x23, #0x780]
116757b64: 38686a95    	ldrb	w21, [x20, x8]
116757b68: f00374a8    	adrp	x8, 0x11d5ee000 <dyld_stub_binder+0x11d5ee000>
116757b6c: f947e108    	ldr	x8, [x8, #0xfc0]
116757b70: f90007e8    	str	x8, [sp, #0x8]
116757b74: d0013148    	adrp	x8, 0x118d81000 <dyld_stub_binder+0x118d81000>
116757b78: fd41c100    	ldr	d0, [x8, #0x380]
116757b7c: 90000008    	adrp	x8, 0x116757000 <_O266DecReleaseOutputPicture+0x34ca548>
116757b80: 913cb108    	add	x8, x8, #0xf2c
116757b84: fd000be0    	str	d0, [sp, #0x10]
116757b88: f00374e9    	adrp	x9, 0x11d5f6000 <dyld_stub_binder+0x11d5f6000>
116757b8c: 91150129    	add	x9, x9, #0x540
116757b90: a901a7e8    	stp	x8, x9, [sp, #0x18]
116757b94: 910023f6    	add	x22, sp, #0x8
116757b98: 910082c0    	add	x0, x22, #0x20
116757b9c: 9100c3e1    	add	x1, sp, #0x30
116757ba0: 946f481d    	bl	0x118329c14 <dyld_stub_binder+0x118329c14>
116757ba4: d004b808    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
116757ba8: f942c101    	ldr	x1, [x8, #0x580]
116757bac: 52800028    	mov	w8, #0x1                ; =1
116757bb0: 0a350102    	bic	w2, w8, w21
116757bb4: 910023e4    	add	x4, sp, #0x8
116757bb8: aa1403e0    	mov	x0, x20
116757bbc: 52800023    	mov	w3, #0x1                ; =1
116757bc0: 946f484b    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757bc4: 910082c0    	add	x0, x22, #0x20
116757bc8: 946f4816    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
116757bcc: 9100c3e0    	add	x0, sp, #0x30
116757bd0: 946f4814    	bl	0x118329c20 <dyld_stub_binder+0x118329c20>
116757bd4: 17ffff5e    	b	0x11675794c <_O266DecReleaseOutputPicture+0x34cae94>
116757bd8: f004d288    	adrp	x8, 0x1201aa000 <dyld_stub_binder+0x1201aa000>
116757bdc: f9448500    	ldr	x0, [x8, #0x908]
116757be0: d004b728    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
116757be4: f940f501    	ldr	x1, [x8, #0x1e8]
116757be8: 946f4841    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757bec: d004b708    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
116757bf0: f942a901    	ldr	x1, [x8, #0x550]
116757bf4: d00420a8    	adrp	x8, 0x11eb6d000 <dyld_stub_binder+0x11eb6d000>
116757bf8: 9121a108    	add	x8, x8, #0x868
116757bfc: f90003e8    	str	x8, [sp]
116757c00: f0030b85    	adrp	x5, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
116757c04: 911b90a5    	add	x5, x5, #0x6e4
116757c08: f0030b87    	adrp	x7, 0x11c8ca000 <dyld_stub_binder+0x11c8ca000>
116757c0c: 912494e7    	add	x7, x7, #0x925
116757c10: 52800042    	mov	w2, #0x2                ; =2
116757c14: d2800003    	mov	x3, #0x0                ; =0
116757c18: 52800004    	mov	w4, #0x0                ; =0
116757c1c: 52807366    	mov	w6, #0x39b              ; =923
116757c20: 17fffee8    	b	0x1167577c0 <_O266DecReleaseOutputPicture+0x34cad08>
116757c24: 1e682000    	fcmp	d0, d8
116757c28: 5400012d    	b.le	0x116757c4c <_O266DecReleaseOutputPicture+0x34cb194>
116757c2c: aa1403e0    	mov	x0, x20
116757c30: aa1603e1    	mov	x1, x22
116757c34: 946f482e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757c38: fc786a81    	ldr	d1, [x20, x24]
116757c3c: 1e683821    	fsub	d1, d1, d8
116757c40: 1e7a1002    	fmov	d2, #-0.25000000
116757c44: 1e620821    	fmul	d1, d1, d2
116757c48: 1e60382a    	fsub	d10, d1, d0
116757c4c: f9462728    	ldr	x8, [x25, #0xc48]
116757c50: a904a3f4    	stp	x20, x8, [sp, #0x48]
116757c54: 910123e0    	add	x0, sp, #0x48
116757c58: aa1503e1    	mov	x1, x21
116757c5c: 946f4827    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116757c60: aa1d03fd    	mov	x29, x29
116757c64: 946f484c    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757c68: aa0003f6    	mov	x22, x0
116757c6c: d004cd48    	adrp	x8, 0x120101000 <dyld_stub_binder+0x120101000>
116757c70: f945a101    	ldr	x1, [x8, #0xb40]
116757c74: 946f481e    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757c78: 946f25be    	bl	0x118321370 <dyld_stub_binder+0x118321370>
116757c7c: 1e602968    	fadd	d8, d11, d0
116757c80: aa1603e0    	mov	x0, x22
116757c84: 946f4835    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757c88: 1e602108    	fcmp	d8, #0.0
116757c8c: 9e6703e0    	fmov	d0, xzr
116757c90: 1e68cc00    	fcsel	d0, d0, d8, gt
116757c94: 1e602140    	fcmp	d10, d0
116757c98: 1e6a4c08    	fcsel	d8, d0, d10, mi
116757c9c: 90013168    	adrp	x8, 0x118d83000 <dyld_stub_binder+0x118d83000>
116757ca0: fd409100    	ldr	d0, [x8, #0x120]
116757ca4: 1e602100    	fcmp	d8, d0
116757ca8: 1a9f57e8    	cset	w8, mi
116757cac: 1e602128    	fcmp	d9, #0.0
116757cb0: 1a8853e8    	csel	w8, wzr, w8, pl
116757cb4: d004d9c9    	adrp	x9, 0x120291000 <dyld_stub_binder+0x120291000>
116757cb8: b9878129    	ldrsw	x9, [x9, #0x780]
116757cbc: 38296a88    	strb	w8, [x20, x9]
116757cc0: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757cc4: f9477901    	ldr	x1, [x8, #0xef0]
116757cc8: aa1403e0    	mov	x0, x20
116757ccc: 946f4808    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757cd0: aa1d03fd    	mov	x29, x29
116757cd4: 946f4830    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757cd8: aa0003f6    	mov	x22, x0
116757cdc: b4000560    	cbz	x0, 0x116757d88 <_O266DecReleaseOutputPicture+0x34cb2d0>
116757ce0: f004bd48    	adrp	x8, 0x11ff02000 <dyld_stub_binder+0x11ff02000>
116757ce4: f9400101    	ldr	x1, [x8]
116757ce8: aa1603e0    	mov	x0, x22
116757cec: 946f4800    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757cf0: 1e614000    	fneg	d0, d0
116757cf4: 1e602100    	fcmp	d8, d0
116757cf8: 1a9f57fc    	cset	w28, mi
116757cfc: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757d00: b987951a    	ldrsw	x26, [x8, #0x794]
116757d04: 387a6a88    	ldrb	w8, [x20, x26]
116757d08: 54000485    	b.pl	0x116757d98 <_O266DecReleaseOutputPicture+0x34cb2e0>
116757d0c: 37000648    	tbnz	w8, #0x0, 0x116757dd4 <_O266DecReleaseOutputPicture+0x34cb31c>
116757d10: f004d0e8    	adrp	x8, 0x120176000 <dyld_stub_binder+0x120176000>
116757d14: f9462900    	ldr	x0, [x8, #0xc50]
116757d18: 946f4798    	bl	0x118329b78 <dyld_stub_binder+0x118329b78>
116757d1c: 9004b748    	adrp	x8, 0x11fe3f000 <dyld_stub_binder+0x11fe3f000>
116757d20: f941a101    	ldr	x1, [x8, #0x340]
116757d24: d2800002    	mov	x2, #0x0                ; =0
116757d28: 946f47f1    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757d2c: aa0003f7    	mov	x23, x0
116757d30: d004cd68    	adrp	x8, 0x120105000 <dyld_stub_binder+0x120105000>
116757d34: f9451101    	ldr	x1, [x8, #0xa20]
116757d38: 946f47ed    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757d3c: 9004b7c8    	adrp	x8, 0x11fe4f000 <dyld_stub_binder+0x11fe4f000>
116757d40: f9459501    	ldr	x1, [x8, #0xb28]
116757d44: aa1703e0    	mov	x0, x23
116757d48: 946f47e9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757d4c: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757d50: f9477d01    	ldr	x1, [x8, #0xef8]
116757d54: aa1403e0    	mov	x0, x20
116757d58: aa1603e2    	mov	x2, x22
116757d5c: 946f47e4    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757d60: aa1d03fd    	mov	x29, x29
116757d64: 946f480c    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757d68: aa0003f8    	mov	x24, x0
116757d6c: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757d70: f9478101    	ldr	x1, [x8, #0xf00]
116757d74: 52800022    	mov	w2, #0x1                ; =1
116757d78: 946f47dd    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757d7c: aa1803e0    	mov	x0, x24
116757d80: 946f47f6    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757d84: 14000012    	b	0x116757dcc <_O266DecReleaseOutputPicture+0x34cb314>
116757d88: 5280001c    	mov	w28, #0x0               ; =0
116757d8c: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757d90: b987951a    	ldrsw	x26, [x8, #0x794]
116757d94: 14000010    	b	0x116757dd4 <_O266DecReleaseOutputPicture+0x34cb31c>
116757d98: 340001e8    	cbz	w8, 0x116757dd4 <_O266DecReleaseOutputPicture+0x34cb31c>
116757d9c: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757da0: f9477d01    	ldr	x1, [x8, #0xef8]
116757da4: aa1403e0    	mov	x0, x20
116757da8: aa1603e2    	mov	x2, x22
116757dac: 946f47d0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757db0: aa1d03fd    	mov	x29, x29
116757db4: 946f47f8    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757db8: aa0003f7    	mov	x23, x0
116757dbc: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757dc0: f9478101    	ldr	x1, [x8, #0xf00]
116757dc4: 52800002    	mov	w2, #0x0                ; =0
116757dc8: 946f47c9    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757dcc: aa1703e0    	mov	x0, x23
116757dd0: 946f47e2    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757dd4: 383a6a9c    	strb	w28, [x20, x26]
116757dd8: b9874f7a    	ldrsw	x26, [x27, #0x74c]
116757ddc: f87a6a80    	ldr	x0, [x20, x26]
116757de0: b004cd88    	adrp	x8, 0x120108000 <dyld_stub_binder+0x120108000>
116757de4: f9411101    	ldr	x1, [x8, #0x220]
116757de8: 52800002    	mov	w2, #0x0                ; =0
116757dec: 946f47c0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757df0: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757df4: f9475d17    	ldr	x23, [x8, #0xeb8]
116757df8: aa1403e0    	mov	x0, x20
116757dfc: aa1703e1    	mov	x1, x23
116757e00: 946f47bb    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757e04: 9004b79c    	adrp	x28, 0x11fe47000 <dyld_stub_binder+0x11fe47000>
116757e08: 340001c0    	cbz	w0, 0x116757e40 <_O266DecReleaseOutputPicture+0x34cb388>
116757e0c: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757e10: b9875518    	ldrsw	x24, [x8, #0x754]
116757e14: f8786a80    	ldr	x0, [x20, x24]
116757e18: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757e1c: b9876d1b    	ldrsw	x27, [x8, #0x76c]
116757e20: f87b6a82    	ldr	x2, [x20, x27]
116757e24: f004cd28    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
116757e28: f9476d01    	ldr	x1, [x8, #0xed8]
116757e2c: 946f47b0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757e30: f8786a80    	ldr	x0, [x20, x24]
116757e34: f87b6a82    	ldr	x2, [x20, x27]
116757e38: f946e381    	ldr	x1, [x28, #0xdc0]
116757e3c: 946f47ac    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757e40: f9462728    	ldr	x8, [x25, #0xc48]
116757e44: a903a3f4    	stp	x20, x8, [sp, #0x38]
116757e48: 9100e3e0    	add	x0, sp, #0x38
116757e4c: aa1503e1    	mov	x1, x21
116757e50: 946f47aa    	bl	0x118329cf8 <dyld_stub_binder+0x118329cf8>
116757e54: aa1d03fd    	mov	x29, x29
116757e58: 946f47cf    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757e5c: aa0003f8    	mov	x24, x0
116757e60: f004cd88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
116757e64: f941cd01    	ldr	x1, [x8, #0x398]
116757e68: 1e604100    	fmov	d0, d8
116757e6c: 946f47a0    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757e70: aa1803e0    	mov	x0, x24
116757e74: 946f47b9    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757e78: f87a6a80    	ldr	x0, [x20, x26]
116757e7c: 9004cda8    	adrp	x8, 0x12010b000 <dyld_stub_binder+0x12010b000>
116757e80: f947a501    	ldr	x1, [x8, #0xf48]
116757e84: 946f479a    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757e88: 1e604001    	fmov	d1, d0
116757e8c: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757e90: f9474101    	ldr	x1, [x8, #0xe80]
116757e94: aa1403e0    	mov	x0, x20
116757e98: 1e604100    	fmov	d0, d8
116757e9c: 946f4794    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757ea0: aa1403e0    	mov	x0, x20
116757ea4: aa1703e1    	mov	x1, x23
116757ea8: 946f4791    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757eac: 34000340    	cbz	w0, 0x116757f14 <_O266DecReleaseOutputPicture+0x34cb45c>
116757eb0: aa1403e0    	mov	x0, x20
116757eb4: aa1503e1    	mov	x1, x21
116757eb8: 946f478d    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757ebc: aa1d03fd    	mov	x29, x29
116757ec0: 946f47b5    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757ec4: aa0003f7    	mov	x23, x0
116757ec8: d004d9c8    	adrp	x8, 0x120291000 <dyld_stub_binder+0x120291000>
116757ecc: b9876d18    	ldrsw	x24, [x8, #0x76c]
116757ed0: f8786a82    	ldr	x2, [x20, x24]
116757ed4: f004cd28    	adrp	x8, 0x1200fe000 <dyld_stub_binder+0x1200fe000>
116757ed8: f9476d01    	ldr	x1, [x8, #0xed8]
116757edc: 946f4784    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757ee0: aa1703e0    	mov	x0, x23
116757ee4: 946f479d    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757ee8: aa1403e0    	mov	x0, x20
116757eec: aa1503e1    	mov	x1, x21
116757ef0: 946f477f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757ef4: aa1d03fd    	mov	x29, x29
116757ef8: 946f47a7    	bl	0x118329d94 <dyld_stub_binder+0x118329d94>
116757efc: aa0003f5    	mov	x21, x0
116757f00: f8786a82    	ldr	x2, [x20, x24]
116757f04: f946e381    	ldr	x1, [x28, #0xdc0]
116757f08: 946f4779    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757f0c: aa1503e0    	mov	x0, x21
116757f10: 946f4792    	bl	0x118329d58 <dyld_stub_binder+0x118329d58>
116757f14: 9004c528    	adrp	x8, 0x11fffb000 <dyld_stub_binder+0x11fffb000>
116757f18: f9442d01    	ldr	x1, [x8, #0x858]
116757f1c: aa1403e0    	mov	x0, x20
116757f20: 946f4773    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757f24: aa1603e0    	mov	x0, x22
116757f28: 17fffe88    	b	0x116757948 <_O266DecReleaseOutputPicture+0x34cae90>
116757f2c: a9be4ff4    	stp	x20, x19, [sp, #-0x20]!
116757f30: a9017bfd    	stp	x29, x30, [sp, #0x10]
116757f34: 910043fd    	add	x29, sp, #0x10
116757f38: 91008000    	add	x0, x0, #0x20
116757f3c: 946f4760    	bl	0x118329cbc <dyld_stub_binder+0x118329cbc>
116757f40: aa0003f3    	mov	x19, x0
116757f44: d004b808    	adrp	x8, 0x11fe59000 <dyld_stub_binder+0x11fe59000>
116757f48: f9421901    	ldr	x1, [x8, #0x430]
116757f4c: 946f4768    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757f50: 37000120    	tbnz	w0, #0x0, 0x116757f74 <_O266DecReleaseOutputPicture+0x34cb4bc>
116757f54: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757f58: f9470901    	ldr	x1, [x8, #0xe10]
116757f5c: aa1303e0    	mov	x0, x19
116757f60: 946f4763    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757f64: f004cca8    	adrp	x8, 0x1200ee000 <dyld_stub_binder+0x1200ee000>
116757f68: f9478501    	ldr	x1, [x8, #0xf08]
116757f6c: aa1303e0    	mov	x0, x19
116757f70: 946f475f    	bl	0x118329cec <dyld_stub_binder+0x118329cec>
116757f74: aa1303e0    	mov	x0, x19
116757f78: a9417bfd    	ldp	x29, x30, [sp, #0x10]
116757f7c: a8c24ff4    	ldp	x20, x19, [sp], #0x20
116757f80: 146f4776    	b	0x118329d58 <dyld_stub_binder+0x118329d58>
